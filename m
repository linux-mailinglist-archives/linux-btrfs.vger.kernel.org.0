Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC54B76B914
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjHAPvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 11:51:36 -0400
Received: from out28-42.mail.aliyun.com (out28-42.mail.aliyun.com [115.124.28.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD931B2
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 08:51:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1138481|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.11902-0.00284345-0.878137;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U63Bi5S_1690905083;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U63Bi5S_1690905083)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 23:51:27 +0800
Date:   Tue, 01 Aug 2023 23:51:28 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230801145946.GA11625@lst.de>
References: <20230801210400.F0DE.409509F4@e16-tech.com> <20230801145946.GA11625@lst.de>
Message-Id: <20230801235123.B665.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Tue, Aug 01, 2023 at 09:04:05PM +0800, Wang Yugui wrote:
> > good performance
> > 	drop 'btrfs: submit IO synchronously for fast checksum implementations' too
> > 	6.4.0 + patches until ' btrfs: use SECTOR_SHIFT to convert LBA to physical offset'
> > 
> > but I have tested 6.1.y with  a patch almost same as 
> > 'btrfs: submit IO synchronously for fast checksum implementations'
> > for over 20+ times, no performance regression found.
> 
> Can you try a git-revert of 140fb1f734736a on the latest tree (which
> should work cleanly) for an additional data point?

GOOD performance  when btrfs 6.5-rc4 with
	Revert "btrfs: determine synchronous writers from bio or writeback control"
	Revert "btrfs: submit IO synchronously for fast checksum implementations"

GOOD performance  when btrfs 6.5-rc4 with this fix too.
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f3e06ec6924..1b7344e673db 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *work)
 static bool should_async_write(struct btrfs_bio *bbio)
 {
        /* Submit synchronously if the checksum implementation is fast. */
-       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
                return false;

        /*

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01


