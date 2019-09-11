Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD45AF61F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfIKGuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 02:50:10 -0400
Received: from hawking.davidnewall.com ([203.20.69.83]:60832 "EHLO
        hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfIKGuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 02:50:10 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 02:50:09 EDT
Received: from [172.30.0.109] (ppp14-2-96-129.adl-apt-pir-bras32.tpg.internode.on.net [::ffff:14.2.96.129])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by hawking.rebel.net.au with ESMTPSA; Wed, 11 Sep 2019 16:15:07 +0930
  id 0000000000064FBC.5D7897F3.00001D5F
To:     linux-btrfs@vger.kernel.org
From:   David Newall <btrfs@davidnewall.com>
Subject: Mount/df/PAM login hangs during rsync to btrfs subvolume, or maybe
 doing btrfs subvolume snapshot
Message-ID: <c00dfaf7-81a4-5e79-6279-b4af53f7f928@davidnewall.com>
Date:   Wed, 11 Sep 2019 16:15:06 +0930
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

I might have misunderstood how to report a problem.  I registered for 
bugzilla and reported a bug 
(https://bugzilla.kernel.org/show_bug.cgi?id=204757), but, perhaps I 
should have sent this message to this mailing list, first.  My apologies 
if I bungled it.

I've been trying to track down a problem, intermittently, for a long 
time, and now need to reach out for advice.  I apologise in advance for 
the quality of this report, which I feel includes more detail than 
needed, yet may be missing what's important.  I'm trying my best.

The brief summary is that my system hangs during SSH login while a 
backup is in progress.  Sshd uses PAM authentication.  The problem seems 
to be related to mounts as df and mount also hang.

The longer details are:  I'm running Ubuntu 16.04.5 on a 64-bit VM under 
kvm.  I backup data using the following steps:

1. Take an LVM2 snapshot of the (non-root) ext2 file-system mounted as 
/data;
2. Mount a btrfs file system as /backup;
2. Mount the snapshot over an empty directory (may be subvolume; does it 
make a difference?) on /backup/snapshot;
3. Rsync the snapshot (with --archive --one-file-system --hard-links 
--inplace --numeric-ids --delete) to a subvolume /backup/data (thus it 
always contains /data as at last backup);
4. Take btrfs subvolume snapshot of /backup/data;
5. Unmount /backup/snapshot and /backup.

By the time I get called, SSH logins via PAM hang (but complete 
"immediately" if I re-configure sshd for UsePAM no).  Sessions which are 
still logged in seem unaffected, except df and mount both hang.  I don't 
know what else hangs.

During all of these steps, the /data is almost static, maybe even be 
completely static.

I've queried my user, carefully, to determine the exact step where it 
starts to hang, and am 90% confident in her answer, which indicates that 
the hang-condition starts during rsync.

Processes that were hanging complete normally when subvolume snapshot 
finishes.

There's a chance that processes complete when the snapshot or btrfs 
file-system is unmounted, but I think it's before then because I've 
tried running each step by hand, was unable to reproduce the problem, 
probably because the amount of data to rsync in real-use is much larger 
than I tried writing during that test.  At any rate, during that test I 
could log in between and during each step of the procedure.

The only messages in dmesg are "mounting ext2 file system using the ext4 
subsystem" and "mounted filesystem without journal. Opts: (null)", which 
sounds right as I use "mount" instead of "mount -text2".

When I tried running df under strace, strace's output was:

   open("/proc/self/mountinfo", O_RDONLY)  = 3
   fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
   read(3, "18 24 0:17 / /sys rw,nosuid,node"..., 1024) = 1024
   read(3, "ystemd/systemd-cgroups-agent,nam"..., 1024) = 1024
   read(3, "t rw,nosuid,nodev,noexec,relatim"..., 1024) = 1024
   read(3,

After the subvolume snapshot completed, strace continued producing output:

   "fs lxcfs rw,user_id=0,group_id=0"..., 1024) = 624
   --- SIGCONT {si_signo=SIGCONT, si_code=SI_USER, si_pid=28055, 
si_uid=1000} ---
   read(3, "", 1024)                       = 0
   lseek(3, 0, SEEK_CUR)                   = 3696
   close(3)                                = 0

I think the SIGCONT was because I suspended the parent, strace, using 
Ctrl-Z.

I could just leave sshd doing non-PAM authentication but I think that's 
the wrong approach.  How do I zero in on this problem?

Thanks,

David

