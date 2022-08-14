Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AB591DB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 05:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiHNDKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNDKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 23:10:32 -0400
Received: from out20-159.mail.aliyun.com (out20-159.mail.aliyun.com [115.124.20.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EE765F
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 20:10:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05100216|-1;BR=01201311R501S38rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00801485-0.000219503-0.991766;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.OswPL9b_1660446626;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OswPL9b_1660446626)
          by smtp.aliyun-inc.com;
          Sun, 14 Aug 2022 11:10:26 +0800
Date:   Sun, 14 Aug 2022 11:10:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Uncorrectable error during multiple scrub (raid5 recovery).
Message-Id: <20220814111026.25EF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Uncorrectable error during multiple scrub (raid5 recovery).

This reproducer is based on some reproducer [1],
but it seems a new problem, so I open a new thread.

reproducer:

mkfs.btrfs -f -draid5 -mraid1 ${SCRATCH_DEV_POOL}
SCRATCH_DEV_ARRAY=($SCRATCH_DEV_POOL)
mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=zstd,noatime

/bin/cp -a /usr/bin $SCRATCH_MNT/
#(OK)dd if=/dev/urandom bs=1M count=1K of=$SCRATCH_MNT/1G.img
du -sh $SCRATCH_MNT

for((i=1;i<=15;++i)); do

	#(OK)umount $SCRATCH_MNT; mount ${SCRATCH_DEV_ARRAY[0]} $SCRATCH_MNT # -o compress=zstd,noatime
	sync; sleep 5; sync; sleep 5; sync; sleep 25;

	# change the device to discard in every loop
	j=$(( i % ${#SCRATCH_DEV_ARRAY[@]} ))
	/usr/sbin/blkdiscard -f ${SCRATCH_DEV_ARRAY[$j]} # --offset 2M

	btrfs scrub start -Bd $SCRATCH_MNT | grep 'summary\|Uncorrectable'

done

This problem will not happen if we change the test data to simpler one.
# about 220M data of '/usr/bin' to single 1G file

This problem will not happen if we clear cache with 'umount; mount'
between multiple loop.
# 'sync; sleep 5; ...' to  'umount; mount'

so it seems that some info in memory is wrong after RAID5 recovery?

[1]
Subject: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
during raid5 recovery
https://lore.kernel.org/linux-btrfs/9dfb0b60-9178-7bbe-6ba1-10d056a7e84c@gmx.com/T/#t

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/14


