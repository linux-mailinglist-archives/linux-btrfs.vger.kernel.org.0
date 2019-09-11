Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D8AFA3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfIKKVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 06:21:25 -0400
Received: from hawking.davidnewall.com ([203.20.69.83]:41549 "EHLO
        hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKKVZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 06:21:25 -0400
Received: from [172.30.0.109] (ppp14-2-96-129.adl-apt-pir-bras32.tpg.internode.on.net [::ffff:14.2.96.129])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by hawking.rebel.net.au with ESMTPSA; Wed, 11 Sep 2019 19:51:23 +0930
  id 0000000000064FBC.5D78CAA3.00003E4A
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <c00dfaf7-81a4-5e79-6279-b4af53f7f928@davidnewall.com>
 <1a651f17-ba40-2f17-403e-69999e927b2d@suse.com>
From:   David Newall <btrfs@davidnewall.com>
Message-ID: <cfc872b2-ea1e-57b4-f548-48679daad069@davidnewall.com>
Date:   Wed, 11 Sep 2019 19:51:22 +0930
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1a651f17-ba40-2f17-403e-69999e927b2d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> echo w > /proc/sysrq-trigger

Interesting.

One material point which I failed to mention is that the btrfs volume is 
on an encrypted volume (cryptsetup luksOpen /dev/vdc backups).

The first step, "mount -r /dev/vg/ext2fs-snapshot 
/btrfs-backup-volume/local-snapshot", seemed to trigger the problem.  
When I did the echo to sysrq-trigger, it seemed to stop blocking, but 
that might have been a coincidence.  After the echo, kernel output 
exceeded 100KB, so I saved it to https://davidnewall.com/kern.1

During rsync (--archive --one-file-system --hard-links --inplace 
--numeric-ids --delete /btrfs-backup-volume/local-snapshot/ 
/btrfs-backup-volume/data/), initially there was no problem, but, then 
it (df) seemed to hang again.  The rsync took a long time to complete, 
and before it did finish, I did the echo to sysrq-trigger again; kernel 
output is saved to https://davidnewall.com/kern.2

The rsync finished not long after the echo to sysrq-trigger, but that's 
probably also a coincidence.  After rsync completed, df still hung.  I 
did another echo to sysrq-trigger, and saved kernel output to 
https://davidnewall.com/kern.3

I tried a minor change in procedure to see if it would bring the system 
back to normal response.  Normally I'd do "btrfs subvolume snapshot", 
but I tried unmounting the lvm2 snapshot first (umount 
/btrfs-backup-volume/local-snapshot).  It did not complete within the 
expected time, and another echo to sysrq-trigger resulted in 
https://davidnewall.com/kern.4

Eventually the umount completed and system came back to normal response.

I did the btrfs subvolume snapshot, and it completed faster than I could 
notice without causing any issues.

After unmounting the btrfs volume, I tried each step again, and 
everything completed within expected times without causing any hang.

Something which I did previously mention, but I'll repeat because it 
might well be important, is that the base ext2 filesystem is on a 
drbd-replicated volume.  I don't know if it's part of the problem, and I 
observe that the hang condition was not triggered at the point of 
creating the lvm2 snapshot.

I greatly appreciate your advice and help.

Thanks,

David

