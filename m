Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C3768EB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGaH3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaH1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 03:27:17 -0400
Received: from out28-225.mail.aliyun.com (out28-225.mail.aliyun.com [115.124.28.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA951BDC
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 00:23:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6218966|-1;BR=01201311R201b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_news_journal|0.585828-1.57954e-05-0.414156;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.U4dYX0i_1690788143;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U4dYX0i_1690788143)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 15:22:27 +0800
Date:   Mon, 31 Jul 2023 15:22:28 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-Id: <20230731152223.4EFB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I noticed a btrfs write-bandwidth performance regression of 6.5-rc4/rc3
with the compare to btrfs 6.4.0

test case:
  disk: NVMe PCIe3 SSD *4 
  btrfs: -m raid -d raid0
  fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30
   -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4
   -directory=/mnt/test

6.5-rc4/rc3
	fio(-numjobs=4) WRITE: bw=1512MiB/s (1586MB/s)
	but ¡®dd conv=fsync¡¯ works well, 2.1 GiB/s.

6.4.0
	fio(-numjobs=4) WRITE: bw=4147MiB/s (4349MB/s)

'git bisect' between 6.4 and 6.5 is yet not done.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/07/31


