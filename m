Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEB72216B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFEIvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:51:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98CDA
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aokqzP92/LPOEG1hq0AoO9qc5OP2fiIemj9laMc5Plc=; b=VpknpraqQrYS8utbvL4Ggou9ke
        vr6c8Js18QxVhZTqaWxkvTJIKHI2ephdQJHAVHFXHsjxElVT76j4xc6sPWXzUFli9GmZKa4npotAK
        9xTsspfd/BVAnmrtF6a+EW5oLVwvoFGFJoDuDA70lezy38+SIG7Qm189GTociY64j9ScD6tPkxpb8
        bop7ubR848wqAeVMVBiTjTu7jZwWY0g5DSc1bMeUW8DcHNOpzJOp9g9qe2ADnI/sOUYaKkGZ9eLTY
        12At+w9VWzM09mY7CzWRXJe/Fq7X2C7Zj8VZ8KZ05Uf18fVSVUpdpDDz0mJ3R8tXNm4G7yyJY4H0C
        igaG2jdg==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65vi-00ElFg-1B;
        Mon, 05 Jun 2023 08:51:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: split btrfs_load_block_group_zone_info
Date:   Mon,  5 Jun 2023 10:51:04 +0200
Message-Id: <20230605085108.580976-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series splits btrfs_load_block_group_zone_info into more
maintainable chunks.  It already is pretty big, and with the
raid-stipe-tree it would grow even more.
