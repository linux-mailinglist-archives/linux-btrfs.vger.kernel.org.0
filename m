Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD84307494
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhA1LSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhA1LSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:18:41 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522EC061573
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 03:18:01 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l55H6-0005eI-IF; Thu, 28 Jan 2021 11:15:44 +0000
Date:   Thu, 28 Jan 2021 11:15:44 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Andrew Vaughan <andrewjvaughan@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: super_total_bytes mismatch with fs_devices total_rw_bytes
Message-ID: <20210128111544.GI4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Andrew Vaughan <andrewjvaughan@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CALxwgb59wUpyC1dinzYjG05781JesjrEf2WaXcP5bpm85-n52A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALxwgb59wUpyC1dinzYjG05781JesjrEf2WaXcP5bpm85-n52A@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

   I'm not sure I'm confident enough to recommend a course of action
on this one, but one note from something you said:

On Thu, Jan 28, 2021 at 10:03:08PM +1100, Andrew Vaughan wrote:
[...]
> Today I did '# btrfs fi resize 4:max /srv/shared' as preparation for a
> balance to make the extra drive space available.  (The old drives are
> all fairly full.  About 130 GB free space on each.  I initially tried
> btrfs fi resize max /srv/shared as the syntax on the manpage implies
> that devid is optional.  Since that command errored, I assume it
> didn't change the filesystem).

   The devid is indeed optional, but it then assumes that you mean
device 1 (which is what it is on a single-device FS). It looks like
your FS, for historical reasons, no longer has a device 1, hence the
error. That should be completely harmless.

[...]
> # uname -a
> Linux nl40 5.10.0-2-amd64 #1 SMP Debian 5.10.9-1 (2021-01-20) x86_64 GNU/Linux
> 
> # mount -t btrfs /dev/sdd1 /mnt/sdd-tmp
> mount: /mnt/sdd-tmp: wrong fs type, bad option, bad superblock on
> /dev/sdd1, missing codepage or helper program, or other error.
> 
> # dmesg | grep -i btrfs
> [    5.799637] Btrfs loaded, crc32c=crc32c-generic
> [    6.428245] BTRFS: device label samba.btrfs devid 8 transid 1281994
> /dev/sdb1 scanned by btrfs (172)
> [    6.428804] BTRFS: device label samba.btrfs devid 5 transid 1281994
> /dev/sdd1 scanned by btrfs (172)
> [    6.429473] BTRFS: device label samba.btrfs devid 4 transid 1281994
> /dev/sde1 scanned by btrfs (172)
> [ 2004.140494] BTRFS info (device sde1): disk space caching is enabled
> [ 2004.790843] BTRFS error (device sde1): super_total_bytes
> 22004298366976 mismatch with fs_devices total_rw_bytes 22004298370048
> [ 2004.790854] BTRFS error (device sde1): failed to read chunk tree: -22
> [ 2004.805043] BTRFS error (device sde1): open_ctree failed
> 
> Note that drive identifiers have changed between reboots.  I haven't
> seen that on this system before.

   It happens sometimes. Sometimes between kernels, sometimes changed
hardware responds slightly faster than the previous device. Sometimes
devices get bumped along by having something new attached to an
earlier controller in the enumeration sequence. I've seen machines
that have had totally stable hardware for years suddenly decide to
flip enumeration order on one reboot. I wouldn't worry about it. :)

   The good news is I don't see any of the usual horribly fatal error
messages here, so it's probably fixable.

> Questions
> =========
> 
> Is btrfs rescue fix-device-size <device> considered the best way to
> recover?  Should I run that once for each device in the filesystem?

   I'm not confident enough to answer anything more than "probably" to
both of those.

> Do you want me to run any other commands to help diagnose the cause
> before attempting recovery?

   Looks like a fairly complete report to me (but see above).

   Hugo.

-- 
Hugo Mills             | Be pure.
hugo@... carfax.org.uk | Be vigilant.
http://carfax.org.uk/  | Behave.
PGP: E2AB1DE4          |                                   Torquemada, Nemesis
