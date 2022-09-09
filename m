Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85FE5B41AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIIVs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiIIVsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:48:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C7F6523
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0lGWBEJ5IzxirygEv5SqYsSDdddAhF5F5zmkvcRvNmQ=; b=XTrfPvETYE8R+HgnQrR4SPoPMU
        e82JLDMuqO2Csig+41s4CBXH9lQdVR77rPNo1ZZL+WyCa8YfEiEIQrLhYSNYIUPUsvaP+wVf6UxPf
        2AwUyNQ7YvCEb2YOMumDyfnmWR1V7hSZjOwZ5njDv76Ci1MQjnA6KeedEzAqv4vc2n0zSk/a+C/i2
        YPKpmEFKLAh0nCfD0ObmEhoJNfhU18W3QQHiXr432P5Cyg1Iify5VWXhIaZqlhhdiYlnMtkYA7rPT
        fq2zODqD3tiH9SVUlxX7ylOZ8GrUKxbw5U0ywP02InxmtiVqM3f5i3HRRVFrmcwhg1pEv8S7IOoJO
        8bT3zDcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWlrD-003CE3-7u; Fri, 09 Sep 2022 21:48:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dsterba@suse.com, johannes.thumshirn@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org, damien.lemoal@wdc.com
Cc:     pankydev8@gmail.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: [PATCH 0/2] btrfs-progs: minor mkfs fs size error message enhancements
Date:   Fri,  9 Sep 2022 14:48:08 -0700
Message-Id: <20220909214810.761928-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are just a couple of minor enhancements to the error printed when
we get an error to create a filesystem on ZNS which simply makes no
sense at all at first glance.

Luis Chamberlain (2):
  btrfs-progs: mkfs: fix error message for minimum zoned filesystem size
  btrfs-progs: mkfs: use pretty_size_mode() on min size error

 mkfs/main.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.35.1

