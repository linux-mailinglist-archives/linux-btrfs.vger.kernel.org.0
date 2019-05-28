Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AB2CEF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfE1SyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 14:54:06 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:59099 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfE1SyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 14:54:06 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hVhEZ-000817-K9; Tue, 28 May 2019 18:54:03 +0000
Date:   Tue, 28 May 2019 18:54:03 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Cesar Strauss <cesar.strauss@inpe.br>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unable to mount, corrupt leaf
Message-ID: <20190528185403.GE21741@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Cesar Strauss <cesar.strauss@inpe.br>, linux-btrfs@vger.kernel.org
References: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 03:39:36PM -0300, Cesar Strauss wrote:
> Hello,
> 
> After a BTRFS partition becoming read-only under use, it cannot be
> mounted anymore.
> 
> The output is:
> 
> # mount /dev/sdb5 /mnt/disk1
> mount: /mnt/disk1: wrong fs type, bad option, bad superblock on
> /dev/sdb5, missing codepage or helper program, or other error.
> 
> Kernel output:
> [ 2042.106654] BTRFS info (device sdb5): disk space caching is enabled
> [ 2042.799537] BTRFS critical (device sdb5): corrupt leaf: root=2
> block=199940210688 slot=31, unexpected item end, have 268450090
> expect 14634

   You have bad RAM.

The item end it's got on the disk:
>>> hex(268450090)
'0x1000392a'

The item end it should have (based on the other items and their
lengths and positions):
>>> hex(14634)
'0x392a'

   The good checksum on the block (it hasn't complained about the
csum, so it's good) indicates that the corruption happened in memory
at some point. The bit-flip in the data would strongly suggest that
it's caused by a stuck memory cell -- i.e. bad hardware.

   Run memtest86 for a minimum of 8 hours (preferably 24) and see what
shows up. Then fix the hardware.

   Hugo.

> [ 2042.807879] BTRFS critical (device sdb5): corrupt leaf: root=2
> block=199940210688 slot=31, unexpected item end, have 268450090
> expect 14634
> [ 2042.807947] BTRFS error (device sdb5): failed to read block groups: -5
> [ 2042.832362] BTRFS error (device sdb5): open_ctree failed
> 
> # btrfs check /dev/sdb5
> Opening filesystem to check...
> incorrect offsets 14634 268450090
> incorrect offsets 14634 268450090
> incorrect offsets 14634 268450090
> incorrect offsets 14634 268450090
> ERROR: cannot open file system
> 
> Giving -s and -b options to "btrfs check" made no difference.
> 
> The usebackuproot mount option made no difference.
> 
> "btrfs restore" was successful in recovering most of the files,
> except for a couple instances of "Error copying data".
> 
> System information:
> 
> OS: Arch Linux
> 
> $ uname -a
> Linux rescue 5.1.4-arch1-1-ARCH #1 SMP PREEMPT Wed May 22 08:06:56
> UTC 2019 x86_64 GNU/Linux
> 
> $ btrfs --version
> btrfs-progs v5.1
> 
> I have since updated the kernel, with no difference:
> 
> $ uname -a
> Linux rescue 5.1.5-arch1-2-ARCH #1 SMP PREEMPT Mon May 27 03:37:39
> UTC 2019 x86_64 GNU/Linux
> 
> Before making any recovery attempts, or even restoring from backup,
> I would like to ask for the best option to proceed.
> 
> Thanks,
> 
> Cesar

-- 
Hugo Mills             | You've read the project plan. Forget that. We're
hugo@... carfax.org.uk | going to Do Stuff and Have Fun doing it.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                           Jeremy Frey

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc7YPLAAoJEFheFHXiqx3kelYP/ihm3kc6andZGV1dueTgJIMj
+2Hvzky+oY1/2awIg7pL+G6PjMPeXqwGpRdNIoJfer9aPjO4/dPo6bBYEORKESVF
A+MdK87rm/9c7nZzPdJqfh5+e/42GJrz8okFSD8O49b4uZpUsK/wwAGfYTGjI8R1
SmvzlZO7XqClWpjmWLi6M2Dr7XIN6FNb+O0Gx13vCFST9+otImANWMYhMKz1cjsN
JSyea1EbVwxTJYoapWaSCG2Im59NiOSzv3BVl6R+Y3HQowGeTzIxID78COKVE/39
9A3pT7rHn7M6fbHiepOlHMoqm0shSmtDl4c93DdHjqN9kDMgBAJJiXikbIGUhcEa
UAAwXwJWke6jm7Kg0zbkYooTDq8PTbpHQRKwNzE7VkWlpcfseXlx1E9tPekWRyI9
u51wLn4OfNVgNyN1VpUPd/WWJFHzTRGZamklOOwI24+QvleouA1JBf1tEPd+LcUp
2UvxfEBr0a/YTiALon4FPDMXZMOWzOEcUs2tv8qemcFjnyCVgyCL7tb7Vl97wo7g
KEpKmKC08MBmIYgr+Gk+gxSn5CUVqyNhb64l/rsHAigEF1CCsb+7hHVtBXact1ob
kizNpopNn4/MhQ4vh4PWFWweDoqVXy4O9ZpKXDZgJbL16Wf6Pe3eatz3+IIbyzaT
L9YwP/biBRUm0cXV2sRf
=bffI
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
