Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6094A21C79F
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGLFMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 01:12:44 -0400
Received: from mail.nethype.de ([5.9.56.24]:45187 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgGLFMo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 01:12:44 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1juUI5-000oQn-EL; Sun, 12 Jul 2020 05:12:41 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1juUI5-0007x9-9h; Sun, 12 Jul 2020 05:12:41 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1juUI5-0000w0-9L; Sun, 12 Jul 2020 07:12:41 +0200
Date:   Sun, 12 Jul 2020 07:12:41 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail, second attempt
Message-ID: <20200712051241.GC491@schmorp.de>
References: <20200702021815.GB6648@schmorp.de>
 <96009f54f7548080513ab2100d420d82f50d4e90.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96009f54f7548080513ab2100d420d82f50d4e90.camel@kepstin.ca>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 01:35:08PM -0400, Calvin Walton <calvin.walton@kepstin.ca> wrote:
> You shared kernel logs, but it would be helpful to see the systemd
> journal. One thing to note is that by default systemd has a timeout on
> mounts! It's entirely possible that as soon as the mount kernel thread
> becomes unblocked, it notices that systemd has sent a SIGTERM/SIGKILL
> and aborts the mount.
> 
> See the documentation (man systemd.mount) and consider increasing or
> disabling the timeout on the affected mount units.

Good idea, systemd indeed KILLed the mount:

   Jul 01 02:02:26 cerebro systemd[1]: cryptlocalvol.mount: Mount process still around after SIGKILL. Ignoring.
   Jul 01 02:02:26 cerebro systemd[1]: cryptlocalvol.mount: Failed with result 'timeout'.
   Jul 01 02:02:26 cerebro systemd[1]: Failed to mount /cryptlocalvol.

However, are btrfs mounts really interruptible? In any case, the
problem happens both for systemd-triggered mounts as well as for mount
commands entered interactively (and also for volumes where there is no
fstab/mount unit at all). For example, here is a case where the initial
systemd-controlled mount fails, and the interactively-entered "mount
/localvol" then fails once more and it only succeeds on the third attempt:

   May 30 03:17:53 cerebro kernel: BTRFS info (device dm-7): disk space caching is enabled
   May 30 03:17:53 cerebro kernel: BTRFS info (device dm-7): has skinny extents
   May 30 03:19:23 cerebro systemd[1]: localvol.mount: Mounting timed out. Terminating.
   May 30 03:20:53 cerebro systemd[1]: localvol.mount: Mount process timed out. Killing.
   May 30 03:20:53 cerebro systemd[1]: localvol.mount: Killing process 1116 (mount) with signal SIGKILL.
   May 30 03:22:23 cerebro systemd[1]: localvol.mount: Mount process still around after SIGKILL. Ignoring.
   May 30 03:22:23 cerebro systemd[1]: localvol.mount: Failed with result 'timeout'.
   May 30 03:22:23 cerebro systemd[1]: Failed to mount /localvol.
   May 30 03:27:53 cerebro kernel: BTRFS error (device dm-7): open_ctree failed
[systemd-initiated mount failed here]
   May 30 03:27:54 cerebro kernel: BTRFS info (device dm-7): turning on discard
   May 30 03:27:54 cerebro kernel: BTRFS info (device dm-7): disk space caching is enabled
   May 30 03:27:54 cerebro kernel: BTRFS info (device dm-7): has skinny extents
   May 30 03:27:54 cerebro kernel: BTRFS error (device dm-7): open_ctree failed
[emergency-shell interactive mount failed here]
   May 30 03:28:14 cerebro kernel: BTRFS info (device dm-7): turning on discard
   May 30 03:28:14 cerebro kernel: BTRFS info (device dm-7): disk space caching is enabled
   May 30 03:28:14 cerebro kernel: BTRFS info (device dm-7): has skinny extents
[third attempt succeeded]
   May 30 03:40:04 cerebro systemd[1]: localvol.mount: Succeeded.

While looking at the case above, I notice that the second mount fails
practically instantly, and it was initiated practically the moment the
previous mount failed.

I think the reason is that systemd dropped me into the emergency
shell long before the (kernel) mount failed, and I likely entered the
interactive mount command long before the previous mount finished, which
could explain why the interactive mount appears to happen within one
second of the previous mount failure - it was probably running for minutes
already, waiting for some lock.

I have disabled the systemd mount timeout for the time being, to exclude
this case.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
