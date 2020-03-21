Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF718E433
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 21:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCUUXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Mar 2020 16:23:12 -0400
Received: from magic.merlins.org ([209.81.13.136]:52102 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUUXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 16:23:12 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:42366 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1jFkeC-0002yc-1C; Sat, 21 Mar 2020 13:23:10 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1jFkeB-0004pz-NT; Sat, 21 Mar 2020 13:23:07 -0700
Date:   Sat, 21 Mar 2020 13:23:07 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <20200321202307.GA15906@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.4-rc1-mmrules_20121111 (2020-01-18)
        on magic.merlins.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=7.0 tests=GREYLIST_ISWHITE,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.4-rc1-mmrules_20121111
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this receipient and sender
Subject: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

/dev/sde blipped off the bus (hardware issue?) and came
back as /dev/sdq.
Except btrfs won't let me scan or mount it.

I was able to btrfs check it though and that came back clean.

gargamel:~# ls -l /dev/sde
ls: cannot access '/dev/sde': No such file or directory


gargamel:~# mount /dev/sdq1 /mnt/mnt
mount: /mnt/mnt: mount(2) system call failed: File exists.
gargamel:~# dmesg |tail -1
[2560371.195249] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1

gargamel:~# btrfs device scan
Scanning for Btrfs filesystems
ERROR: device scan failed on '/dev/sdq1': File exists
ERROR: there are 1 errors while registering devices
gargamel:~# dmesg |tail -1
[2560416.434529] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1

gargamel:~# grep sde /proc/mounts 
cgroup2 /sys/fs/cgroup/unified cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
gargamel:~# 

gargamel:~# lsblk -f |grep 727c7ba3-f6f9-462a-8472-453dd7d46d8a
└─sdq1                            btrfs             btrfs_space                 727c7ba3-f6f9-462a-8472-453dd7d46d8a   
gargamel:~# 

So, that FS isn't a duplicate anymore and I see to have no way out except reboot
which I'll do now.

Was there another way around it? Obviously this is not desirable
behaviour, in the past, I was able to remount the device when it came
back.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
