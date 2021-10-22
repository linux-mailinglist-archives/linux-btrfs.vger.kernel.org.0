Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1945343710D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 06:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhJVEvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 00:51:24 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:36957 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhJVEvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 00:51:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0557336|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0278873-0.000299257-0.971813;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LftKqRF_1634878137;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LftKqRF_1634878137)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 22 Oct 2021 12:48:57 +0800
Date:   Fri, 22 Oct 2021 12:49:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Su Yue <l@damenly.su>
Subject: Re: fstest/btrfs/220 tigger a check-integrity warning
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <pmryhp99.fsf@damenly.su>
References: <20211014152939.5E10.409509F4@e16-tech.com> <pmryhp99.fsf@damenly.su>
Message-Id: <20211022124902.B018.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > xfstest/btrfs/220 tigger check-integrity warning.
> >
> > btrfs source:  5.15.0-0.rc5 with btrfs pull for rc6
> >
> > btrfs kernel config:
> > CONFIG_BTRFS_FS=m
> > CONFIG_BTRFS_FS_POSIX_ACL=y
> > CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > # CONFIG_BTRFS_DEBUG is not set
> > CONFIG_BTRFS_ASSERT=y
> > CONFIG_BTRFS_FS_REF_VERIFY=y
> >
> > reproduce frequency: 100%
> >
> > [ 1917.552758] btrfs: attempt to write superblock which
> > references block M
> > @5242880 (sdb2/5242880/0) which is not flushed out of disk's
> > write cache (block
> > flush_gen=1, dev->flush_gen=0)!
> >
> Anything special about /dev/sdb? I can reproduce if test device is zram
> since zram seems to handle FUA in its way.
> For normal device backing by file/disk, the test always passed on my side.

Thanks for this info.  

I checked it on some disks.
passed:
	SSD/SAS	PX05SMQ040
failed:
	SSD/SAS		HUSMH842
	SSD/NVMe	SM963/SM1715

I noticed that PX05SMQ040 is 'WCE:1/write back', but HUSMH842 is'WCE:0/write
through', both SM963 and SM1715 are 
' [0:0] : 0     Volatile Write Cache Not Present/write through'

I failed to test it on zram.
#mkfs.btrfs /dev/zram0
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
ERROR: '/dev/zram0' is too small to make a usable filesystem
ERROR: minimum size for each btrfs device is 47185920

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/22


