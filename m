Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC5535B50
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiE0ITV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiE0ITU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:19:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA83ED8F5;
        Fri, 27 May 2022 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kkRStRGtLvu5r997h610I3mv4VJpeYPszAMW/dhqqdE=; b=C8vuMZre/bvJRJdNYsbmtSMhwR
        IQgFIuvE7gbDWPFAHUMG2NNrNwPxAsjYo7/eJja/XugV5iiS0jzkbR5YWO2UYWoCvYOJnvqvkgaSh
        G2KlRgmAzZvfZWgwAw99gNESSkJ/KiQFzzbX2gp67dI9lzsIkX6OtterAFFa7+B2wec4wzXFI1VLV
        guhYiehN02YzXE2BVsLbOr1FTD8l+S0+iQlf1UI/spgxu/WA+rgPzhgkzmyT6m4xb9lWYi+Z9uNt3
        BMcCthEm/juYf2+8PBgjanIGg5hwz/3yq45UF0pkNeyw6k1Nj/tgjwia0aATnxxfteAC9AkKXRKRJ
        mtL7KDYg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVBl-00GztD-EO; Fri, 27 May 2022 08:19:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: btrfs read repair: new tests and cleanups
Date:   Fri, 27 May 2022 10:19:05 +0200
Message-Id: <20220527081915.2024853-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

this series adds more tests for the btrfs read-repair code that exercise
the raid1c3 profile and adds helpers to avoid duplicating too much code
for read repair testing

Changes since v2:
 - use the -b option to btrfs-map-logical-blocks for the $seqres.full
   output
 - don't use _btrfs_no_v1_cache_opt for the new tests
 - add a new test to test interleaved sector corruption repair for
   direct I/O.

Changes since v1:
 - add common helpers for read repair
 - increase the offsets so thay they should be fine with 64k block size
   (although I don't have a system to actually verify that)
