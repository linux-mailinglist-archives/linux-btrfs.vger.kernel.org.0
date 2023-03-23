Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712696C697B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 14:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCWN1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjCWN1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 09:27:49 -0400
Received: from out28-44.mail.aliyun.com (out28-44.mail.aliyun.com [115.124.28.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBC623C74
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 06:27:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04447077|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0277868-0.0478687-0.924345;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.RyJ1DxG_1679578063;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RyJ1DxG_1679578063)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 21:27:44 +0800
Date:   Thu, 23 Mar 2023 21:27:46 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: fix mkfs/mount/check failures due to race with systemd-udevd scan
Cc:     linux-btrfs@vger.kernel.org, Sherry Yang <sherry.yang@oracle.com>,
        kernel test robot <oliver.sang@intel.com>
In-Reply-To: <cbac9a8b-7db4-dc54-1f1d-4dc48e5dfcc9@oracle.com>
References: <20230323195710.433E.409509F4@e16-tech.com> <cbac9a8b-7db4-dc54-1f1d-4dc48e5dfcc9@oracle.com>
Message-Id: <20230323212745.4342.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> 
> 
> On 23/03/2023 19:57, Wang Yugui wrote:
> > Hi,
> >
> >> During the device scan initiated by systemd-udevd, other user space
> >> EXCL operations such as mkfs, mount, or check may get blocked and result
> >> in a "Device or resource busy" error. This is because the device
> >> scan process opens the device with the EXCL flag in the kernel.
> >>
> >> Two reports were received:
> >>
> >>   . One with the btrfs/179 testcase, where the fsck command failed with
> >>     the -EBUSY error; and
> >>
> >>   . Another with the LTP pwritev03 testcase, where mkfs.vfs failed with
> >>     the -EBUSY error, when mkfs.vfs tried to overwrite old btrfs filesystem
> >>     on the device.
> >>
> >> In both cases, fsck and mkfs (respectively) were racing with a
> >> systemd-udevd device scan, and systemd-udevd won, resulting in the
> >> -EBUSY error for fsck and mkfs.
> >>
> >> Reproducing the problem has been difficult because there is a very
> >> small timeframe during which these userspace threads can race to
> >> acquire the exclusive device open. Even on the system where the problem
> >> was observed, the problem occurances were anywhere between 10 to 400
> >> iterations and chances of reproducing lessen with debug printk()s.
> >>
> >> However, an exclusive device open is unnecessary for the scan process,
> >> as there are no write operations on the device during scan. Furthermore,
> >> during the mount process, the superblock is re-read in the below
> >> function stack.
> >>
> >>    btrfs_mount_root
> >>     btrfs_open_devices
> >>      open_fs_devices
> >>       btrfs_open_one_device
> >>         btrfs_get_bdev_and_sb
> >>
> >> So, to fix this issue, this patch removes the FMODE_EXCL flag from the scan
> >> operation, and adds a comment.
> >>
> >> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Link: https://lore.kernel.org/oe-lkp/202303170839.fdf23068-oliver.sang@intel.com
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>
> >>   This patch should be cc-ed to stable-5.15.y and stable-6.1.y. As for
> >>   stable-5.10.y and stable-5.4.y, a conflict fix is necessary, which I
> >>   will send separately.
> >>
> >>   fs/btrfs/volumes.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 93bc45001e68..cc1871767c8c 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -1366,8 +1366,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
> >>   	 * So, we need to add a special mount option to scan for
> >>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
> >>   	 */
> >> -	flags |= FMODE_EXCL;
> >>  >> +	/*
> >> +	 * Avoid using flag |= FMODE_EXCL here, as the systemd-udev may
> >> +	 * initiate the device scan which may race with the user's mount
> >> +	 * or mkfs command, resulting in failure.
> > 
> > for  FMODE_READ | FMODE_EXCL, we need some sleep/retry,
> > for  FMODE_WRITE | FMODE_EXCL, we should fail immediately?
> 
>   Sorry I don't understand the context here what represents the we here?
> 
>   In the LTP testcase the two sides are
>    mkfs.<vfs|btrfs> side (FMODE_WRITE|FMODE_EXCL) and
>    device-scan side (now: FMODE_READ, before: FMODE_READ|FMODE_EXCL)
> 
> > scan race with with mkfs may result worse?
> 
>   In the above example, the mkfs.<vfs|btrfs> failed immediately without
>   the patch and with the patch it is successful.

With the patch, when mkfs.<vfs|btrfs> is still running, 
device-scan can read, but the read data is meaningless, so it is worse?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/03/23

