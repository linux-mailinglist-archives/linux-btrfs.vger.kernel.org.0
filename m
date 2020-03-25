Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB731931B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 21:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYUPB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 16:15:01 -0400
Received: from magic.merlins.org ([209.81.13.136]:33222 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYUPB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 16:15:01 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:42174 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1jHCQS-0005q1-62; Wed, 25 Mar 2020 13:14:57 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1jHCQR-00060X-MC; Wed, 25 Mar 2020 13:14:55 -0700
Date:   Wed, 25 Mar 2020 13:14:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <20200325201455.GO29461@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
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
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the suggestion Nikolay

Dear Anand, David,

I see that 
https://gitlab.freedesktop.org/seanpaul/dpu-staging/commit/228a73abde5c04428678e917b271f8526cfd90ed
may have helped, but is this really something a user should know/do?

Why does a device that disappeared from the bus, need to be manually
unregistered?
Are users really supposed to know this?
Why does btrfs device scan not invalidate the cache of devices and keep
remembering a device that's gone (not visible in new scan)?

Thanks,
Marc


On Sat, Mar 21, 2020 at 11:25:04PM +0200, Nikolay Borisov wrote:
> 
> 
> On 21.03.20 г. 22:23 ч., Marc MERLIN wrote:
> > /dev/sde blipped off the bus (hardware issue?) and came
> > back as /dev/sdq.
> > Except btrfs won't let me scan or mount it.
> > 
> > I was able to btrfs check it though and that came back clean.
> > 
> > gargamel:~# ls -l /dev/sde
> > ls: cannot access '/dev/sde': No such file or directory
> > 
> > 
> > gargamel:~# mount /dev/sdq1 /mnt/mnt
> > mount: /mnt/mnt: mount(2) system call failed: File exists.
> > gargamel:~# dmesg |tail -1
> > [2560371.195249] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1
> > 
> > gargamel:~# btrfs device scan
> > Scanning for Btrfs filesystems
> > ERROR: device scan failed on '/dev/sdq1': File exists
> > ERROR: there are 1 errors while registering devices
> > gargamel:~# dmesg |tail -1
> > [2560416.434529] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdq1
> > 
> > gargamel:~# grep sde /proc/mounts 
> > cgroup2 /sys/fs/cgroup/unified cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
> > gargamel:~# 
> > 
> > gargamel:~# lsblk -f |grep 727c7ba3-f6f9-462a-8472-453dd7d46d8a
> > └─sdq1                            btrfs             btrfs_space                 727c7ba3-f6f9-462a-8472-453dd7d46d8a   
> > gargamel:~# 
> > 
> > So, that FS isn't a duplicate anymore and I see to have no way out except reboot
> > which I'll do now.
> > 
> > Was there another way around it? Obviously this is not desirable
> > behaviour, in the past, I was able to remount the device when it came
> > back.
> > 
> 
> Presumably you could have used the device forget functionality that got
> introduced in 5.1, i.e the BTRFS_IOC_FORGET_DEV ioctl. For more info
> check out: 228a73abde5c04428678e917b271f8526cfd90ed
> 
> > Thanks,
> > Marc
> > 
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
