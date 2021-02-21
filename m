Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486503207D2
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBUA16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 19:27:58 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:46282 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBUA1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 19:27:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08492363|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.51539-5.7105e-05-0.484553;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Jb8zZCM_1613867209;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jb8zZCM_1613867209)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 21 Feb 2021 08:26:49 +0800
Date:   Sun, 21 Feb 2021 08:26:50 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Chris Murphy <lists@colorremedies.com>
Subject: Re: 5.11 free space tree remount warning
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Boris Burkov <boris@bur.io>
In-Reply-To: <CAJCQCtTT7djC+FPEeQg3mJuO75JTJUaoKuibBF+KOq0SWKt+zA@mail.gmail.com>
References: <CAJCQCtTT7djC+FPEeQg3mJuO75JTJUaoKuibBF+KOq0SWKt+zA@mail.gmail.com>
Message-Id: <20210221082648.365F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Boris Burkov, Chris Murphy

This happened is my server too.

1, this warning [*1] is not loged in /var/log/messages
    because it happened after the ro remount of /
   my server is a dell PowerEdge T640, this log can be confirmed by
iDRAC console.

[*1]  BTRFS warning (device vda3): remount supports changing free space
tree only from ro to rw

2, no space_cache=v2 in /etc/fstab
   but space_cache=v2 is reported in /proc/mounts
   systemd-shutdown ro remount / with the param based on /proc/mount

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/21

> Hi,
> 
> systemd does remount ro at reboot/shutdown time, and if free space
> tree exists, this is always logged:
> 
> [   27.476941] systemd-shutdown[1]: Unmounting file systems.
> [   27.479756] [1601]: Remounting '/' read-only in with options
> 'seclabel,compress=zstd:1,space_cache=v2,subvolid=258,subvol=/root'.
> [   27.489196] BTRFS info (device vda3): using free space tree
> [   27.492009] BTRFS warning (device vda3): remount supports changing
> free space tree only from ro to rw
> 
> Is there a way to better detect that this isn't an attempt to change
> to v2? If there's no v1 present, it's not a change.
> 
> -- 
> Chris Murphy


