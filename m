Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6362437117
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhJVFJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 01:09:56 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:47015 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJVFJz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 01:09:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05408988|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.094841-0.00125974-0.903899;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LftL.kV_1634879256;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LftL.kV_1634879256)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 22 Oct 2021 13:07:36 +0800
Date:   Fri, 22 Oct 2021 13:07:42 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
Subject: Re: fstest/btrfs/220 tigger a check-integrity warning
In-Reply-To: <20211022124902.B018.409509F4@e16-tech.com>
References: <pmryhp99.fsf@damenly.su> <20211022124902.B018.409509F4@e16-tech.com>
Message-Id: <20211022130742.7119.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> > > xfstest/btrfs/220 tigger check-integrity warning.
> > >
> > > btrfs source:  5.15.0-0.rc5 with btrfs pull for rc6
> > >
> > > btrfs kernel config:
> > > CONFIG_BTRFS_FS=m
> > > CONFIG_BTRFS_FS_POSIX_ACL=y
> > > CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> > > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > > # CONFIG_BTRFS_DEBUG is not set
> > > CONFIG_BTRFS_ASSERT=y
> > > CONFIG_BTRFS_FS_REF_VERIFY=y
> > >
> > > reproduce frequency: 100%
> > >
> > > [ 1917.552758] btrfs: attempt to write superblock which
> > > references block M
> > > @5242880 (sdb2/5242880/0) which is not flushed out of disk's
> > > write cache (block
> > > flush_gen=1, dev->flush_gen=0)!
> > >
> > Anything special about /dev/sdb? I can reproduce if test device is zram
> > since zram seems to handle FUA in its way.
> > For normal device backing by file/disk, the test always passed on my side.
> 
> Thanks for this info.  
> 
> I checked it on some disks.
> passed:
> 	SSD/SAS	PX05SMQ040
> failed:
> 	SSD/SAS		HUSMH842
> 	SSD/NVMe	SM963/SM1715
> I noticed that PX05SMQ040 is 'WCE:1/write back', but HUSMH842 is'WCE:0/write
> through', both SM963 and SM1715 are 
> ' [0:0] : 0     Volatile Write Cache Not Present/write through'

When I changed the SSD/SAS from write through to write back,
The result of fstest/btrfs/220 on HUSMH842 is changed from failed to
passed.
# sdparm --set=WCE --save /dev/sda

so there is some process in btrfs wrongly depends on block disk write
back?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/22

