Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF63324C03
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 09:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhBYI0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 03:26:07 -0500
Received: from out20-15.mail.aliyun.com ([115.124.20.15]:47167 "EHLO
        out20-15.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhBYIZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 03:25:53 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.047104|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.101896-0.000707346-0.897396;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Jd4SWhk_1614241510;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jd4SWhk_1614241510)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 25 Feb 2021 16:25:10 +0800
Date:   Thu, 25 Feb 2021 16:25:13 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: xfstest btrfs/154 failed at kernel 5.4.100
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <b5b5c384-af04-d05f-f3d0-5d6372d2c52a@suse.com>
References: <20210225155350.BB3A.409509F4@e16-tech.com> <b5b5c384-af04-d05f-f3d0-5d6372d2c52a@suse.com>
Message-Id: <20210225162512.D437.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs/154 passed with with the backport of this patch.
btrfs: correctly calculate item size used when item key collision
happens

Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/25

> 
> 
> On 25.02.21 §Ô. 9:53 §é., Wang Yugui wrote:
> > Hi,
> > 
> > xfstest btrfs/154 failed at kernel 5.4.100
> > 
> > frequency: always
> > kernel version: 5.4.100, other kernel version yet not tested.
> > xfstest: https://github.com/kdave/xfstests.git
> > btrfs-progs: 5.10.1
> > 	but mkfs.btrfs default enable no-holes and free-space-tree.
> > 
> > # ./check btrfs/154
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 T7610 5.4.100-3.el7.x86_64 #1 SMP Thu Feb 25 13:19:45 CST 2021
> > MKFS_OPTIONS  -- /dev/sdb
> > MOUNT_OPTIONS -- /dev/sdb /mnt/scratch
> > 
> > btrfs/154       _check_dmesg: something found in dmesg (see /ssd/git/os/xfstests/results//btrfs/154.dmesg)
> > - output mismatch (see /ssd/git/os/xfstests/results//btrfs/154.out.bad)
> >     --- tests/btrfs/154.out     2021-02-25 13:41:27.906590386 +0800
> >     +++ /ssd/git/os/xfstests/results//btrfs/154.out.bad 2021-02-25 15:45:52.182865707 +0800
> >     @@ -1,2 +1,6 @@
> >      QA output created by 154
> >     +Traceback (most recent call last):
> >     +  File "/ssd/git/os/xfstests/src/btrfs_crc32c_forged_name.py", line 89, in <module>
> >     +    os.rename(srcpath, dstpath)
> >     +OSError: [Errno 75] Value too large for defined data type
> >      Silence is golden
> > 
> 
> That's expected to fail, the commit for it landed in 5.11-rc2 actually
> if you've taken the time to look into the test itself it even states the
> name of the commit. Furthermore, the commit is tagged for stable 4.4 so
> it will eventually land in all stable kernels.

