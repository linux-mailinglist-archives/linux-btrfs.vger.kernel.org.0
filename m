Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755EB76ADF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHAJes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 05:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHAJeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 05:34:24 -0400
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E45257
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 02:32:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09385116|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0260082-0.000822041-0.97317;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U5re6TG_1690882328;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U5re6TG_1690882328)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:32:12 +0800
Date:   Tue, 01 Aug 2023 17:32:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230801090316.GA25781@lst.de>
References: <20230801165652.760D.409509F4@e16-tech.com> <20230801090316.GA25781@lst.de>
Message-Id: <20230801173208.4F08.409509F4@e16-tech.com>
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

> On Tue, Aug 01, 2023 at 04:56:58PM +0800, Wang Yugui wrote:
> > > Odd.  What CPU are you using to test?  It seems like it doesn't set
> > > BTRFS_FS_CSUM_IMPL_FAST as that is the only way to even hit a potential
> > > difference.  Or are you using a non-standard checksum type?
> > 
> > The CPU is E5 2680 v2.
> 
> Is this in a VM and not passing through cpu flags?  What does dmesg
> say when mounting?  Norally it should say something like:
> 
> [   23.461448] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum algorithm

This is NOT VM.

dmesg output:
[  250.596544] raid6: skipped pq benchmark and selected sse2x4
[  250.602836] raid6: using ssse3x2 recovery algorithm
[  250.612812] xor: automatically using best checksumming function   avx       
[  250.895573] Btrfs loaded, assert=on, zoned=yes, fsverity=no
[  250.905249] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 3 transid 6 /dev/nvme3n1 scanned by systemd-udevd (1726)
[  250.922155] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 4 transid 6 /dev/nvme0n1 scanned by systemd-udevd (1729)
[  250.935965] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 1 transid 6 /dev/nvme1n1 scanned by systemd-udevd (1724)
[  250.968268] BTRFS: device fsid f5ebfdd6-6bf6-4c2b-b47b-79517bc00c8f devid 2 transid 6 /dev/nvme2n1 scanned by systemd-udevd (1723)
[  251.070139] BTRFS info (device nvme1n1): using crc32c (crc32c-intel) checksum algorithm
[  251.079164] BTRFS info (device nvme1n1): using free space tree
[  251.089871] BTRFS info (device nvme1n1): enabling ssd optimizations
[  251.096921] BTRFS info (device nvme1n1): auto enabling async discard
[  251.104417] BTRFS info (device nvme1n1): checking UUID tree

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01

