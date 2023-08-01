Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D176A6E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHACXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHACXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 22:23:06 -0400
Received: from out28-64.mail.aliyun.com (out28-64.mail.aliyun.com [115.124.28.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515C10DD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 19:23:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4799461|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.778991-8.83197e-05-0.220921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U5FC74-_1690856573;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U5FC74-_1690856573)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:22:57 +0800
Date:   Tue, 01 Aug 2023 10:22:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
In-Reply-To: <20230731152223.4EFB.409509F4@e16-tech.com>
References: <20230731152223.4EFB.409509F4@e16-tech.com>
Message-Id: <20230801102253.1AF4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
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

> I noticed a btrfs write-bandwidth performance regression of 6.5-rc4/rc3
> with the compare to btrfs 6.4.0
> 
> test case:
>   disk: NVMe PCIe3 SSD *4 
>   btrfs: -m raid -d raid0
>   fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30
>    -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=4
>    -directory=/mnt/test
> 
> 6.5-rc4/rc3
> 	fio(-numjobs=4) WRITE: bw=1512MiB/s (1586MB/s)
> 	but ¡®dd conv=fsync¡¯ works well, 2.1 GiB/s.
> 
> 6.4.0
> 	fio(-numjobs=4) WRITE: bw=4147MiB/s (4349MB/s)
> 
> 'git bisect' between 6.4 and 6.5 is yet not done.

'git bisect' show that this patch is the root cause of performance
regression.

e917ff56c8e7 :Christoph Hellwig: btrfs: determine synchronous writers from bio
or writeback control

The performance is still good when
da023618076a :Christoph Hellwig: btrfs: submit IO synchronously for fast checksum implementations

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01

