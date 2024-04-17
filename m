Return-Path: <linux-btrfs+bounces-4350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334138A838C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA5B21727
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2A13D60D;
	Wed, 17 Apr 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.big.or.jp header.i=@mail.big.or.jp header.b="xliy8O4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.big.or.jp (mail.big.or.jp [210.197.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB812D60C;
	Wed, 17 Apr 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.197.72.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358689; cv=none; b=FILSIej0JIesEcQaZnYZfluetsmIfYJDkL6KttI59LrebDn5z8SqG5YUBS9V79OZPYG4l98lYNWL/Vc54G/cb+ESTZ5KQTryexftqX15QizvB5RNwra+ovRgHvpycNLUVAyTWM/mS1ezOPb5I2IiJ3WToK78waegca8uIfkG/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358689; c=relaxed/simple;
	bh=MquDlLoR4inyVaQlfpG/3XlB8PgwuIOPpDrgijXngzk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GQf+Qgm8tzHBvNRgvsgY8A49RDN12Io6RKWEaBUpapobSWr7ufZT8WhCO7gIqa1389oQSbgPs7RamAkxa9wXiANolPnIyWPmai6olH7U5eUKLuAi+JyMOXofH9hEQmsvk0/oZ5hyhVZH2kOM5QuRRZGC7uZfZ3u8yAuOf6uNKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=big.or.jp; spf=pass smtp.mailfrom=big.or.jp; dkim=pass (1024-bit key) header.d=mail.big.or.jp header.i=@mail.big.or.jp header.b=xliy8O4m; arc=none smtp.client-ip=210.197.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=big.or.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=big.or.jp
Received: from localhost (unknown [IPv6:2409:250:40:1a00:d65d:64ff:fef1:3a80])
	by mail.big.or.jp (Postfix) with ESMTPA id 7916E15FAEF;
	Wed, 17 Apr 2024 21:57:55 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.big.or.jp;
	s=_dkimselector; t=1713358675;
	bh=lJ2zFCwXJhAWv+hCBMbTgI0iTMS74MJsdKoj+VbWoIE=;
	h=Date:To:Cc:Subject:From:In-Reply-To:References;
	b=xliy8O4mGTpxJ2tLUBJ2DBe+6f8PMZu3TFcAcARRA8Xz67fZBqlbDibs/DNu9+3CY
	 PRBev9Et0r9mL3Suun+Yedi1v/hrIRSPp97W2d2LMwF9zDwrMoGWkTiadRrtCE1ysf
	 NM1G2TwTID5TLSkrJg1JzvDmeQ+s9CEGDgFYPKck=
Date: Wed, 17 Apr 2024 21:57:50 +0900 (JST)
Message-Id: <20240417.215750.795520800087390305.sian@big.or.jp>
To: greg@kroah.com
Cc: holger@applied-asynchrony.com, Naohiro.Aota@wdc.com,
 regressions@lists.linux.dev, dsterba@suse.com, wqu@suse.com,
 linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: btrfs: sanity tests fails on 6.8.3
From: sian@big.or.jp
In-Reply-To: <20240415.214704.2195618259755902678.sian@big.or.jp>
References: <3b2d9a1c-37d2-47f4-b0b4-a9d6c34d2c7d@applied-asynchrony.com>
	<2024041508-refocus-cycling-09e8@gregkh>
	<20240415.214704.2195618259755902678.sian@big.or.jp>
X-Mailer: Mew version 6.8 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hi,

6.8.7 works.
Thank you!.

> Hi,
> =

> Thank you for all your replies.
> I cherry-picked b2136cc288fc and the ssanity tests work well.
> =

> =

> From: Greg KH <greg@kroah.com>
> Subject: Re: btrfs: sanity tests fails on 6.8.3
> Date: Mon, 15 Apr 2024 09:33:27 +0200
> =

>> On Mon, Apr 15, 2024 at 09:25:58AM +0200, Holger Hoffst=E4tte wrote:=

>>> On 2024-04-15 07:24, Naohiro Aota wrote:
>>> > On Mon, Apr 15, 2024 at 07:11:15AM +0200, Linux regression tracki=
ng (Thorsten Leemhuis) wrote:
>>> > > [adding the authors of the two commits mentioned as well as the=
 Btrfs
>>> > > maintainers and the regressions & stable list to the list of re=
cipients]
>>> > > =

>>> > > On 15.04.24 05:56, Hiroshi Takekawa wrote:
>>> > > > =

>>> > > > Module loading fails with CONFIG_BTRFS_FS_RUN_SANITY_TESTS en=
abled on
>>> > > > 6.8.3-6.8.6.
>>> > > > =

>>> > > > Bisected:
>>> > > > Reverting these commits, then module loading succeeds.
>>> > > > 70f49f7b9aa3dfa70e7a2e3163ab4cae7c9a457a
>>> > > =

>>> > > FWIW, that is a linux-stable commit-id for 41044b41ad2c8c ("btr=
fs: add
>>> > > helper to get fs_info from struct inode pointer") [v6.9-rc1, v6=
.8.3
>>> > > (70f49f7b9aa3df)]
>>> > > =

>>> > > > 86211eea8ae1676cc819d2b4fdc8d995394be07d
>>> > =

>>> > It looks like the stable tree lacks this commit, which is necessa=
ry for the
>>> > commit above.
>>> > =

>>> > b2136cc288fc ("btrfs: tests: allocate dummy fs_info and root in t=
est_find_delalloc()")
>>> > =

>>> =

>>> This was previously reported during the last stable cycle, and the =
missing
>>> patch is already queued up. You can see the queue here:
>>> =

>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue=
.git/tree/queue-6.8
>> =

>> Thanks for confirming this, the next 6.8 release should resolve this=

>> issue.
>> =

>> greg k-h
>> =

>>
> =

> cherry-picked on top of 6.8.6
> =

> $ git log -2
> commit 12d79cec1083658f23f4566fcea40463549c5a54 (HEAD -> refs/heads/l=
inux-6.8.6-btrfs-selftest-fix)
> Author: David Sterba <dsterba@suse.com>
> Date:   Mon Jan 29 19:04:33 2024 +0100
> =

>     btrfs: tests: allocate dummy fs_info and root in test_find_delall=
oc()
>     =

>     Allocate fs_info and root to have a valid fs_info pointer in case=
 it's
>     dereferenced by a helper outside of tests, like find_lock_delallo=
c_range().
>     =

>     Signed-off-by: David Sterba <dsterba@suse.com>
> =

> commit 1f7d392571dfec1c47b306a32bbe60be05a51160 (tag: refs/tags/v6.8.=
6, refs/remotes/origin/linux-6.8.y, refs/heads/linux-6.8.y)
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Sat Apr 13 13:10:12 2024 +0200
> =

>     Linux 6.8.6
>     =

>     Link: https://lore.kernel.org/r/20240411095420.903937140@linuxfou=
ndation.org
>     Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
>     Tested-by: SeongJae Park <sj@kernel.org>
>     Tested-by: Ronald Warsow <rwarsow@gmx.de>
>     Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
>     Tested-by: Shuah Khan <skhan@linuxfoundation.org>
>     Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>     Tested-by: Ron Economos <re@w6rz.net>
>     Tested-by: Jon Hunter <jonathanh@nvidia.com>
>     Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> =

> $ cat /proc/version =

> Linux version 6.8.6+ (user@host) (clang version 18.1.3, LLD 18.1.3) #=
1 SMP PREEMPT Mon Apr 15 21:31:32 JST 2024
> =

> sanity tests are enabled:
> $ zgrep BTRFS_FS_RUN /proc/config.gz =

> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy
> =

> dmesg, which indicates the success.
> [  105.926765] xor: automatically using best checksumming function   =
avx       =

> [  105.928174] raid6: skipped pq benchmark and selected avx2x4
> [  105.928175] raid6: using avx2x2 recovery algorithm
> [  106.017111] Btrfs loaded, zoned=3Dno, fsverity=3Dno
> [  106.017125] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
> [  106.017126] BTRFS: selftest: running btrfs free space cache tests
> [  106.017131] BTRFS: selftest: running extent only tests
> [  106.017133] BTRFS: selftest: running bitmap only tests
> [  106.017136] BTRFS: selftest: running bitmap and extent tests
> [  106.017139] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> [  106.017278] BTRFS: selftest: running bytes index tests
> [  106.017283] BTRFS: selftest: running extent buffer operation tests=

> [  106.017283] BTRFS: selftest: running btrfs_split_item tests
> [  106.017287] BTRFS: selftest: running extent I/O tests
> [  106.017288] BTRFS: selftest: running find delalloc tests
> [  106.051988] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> [  106.051991] BTRFS: selftest: running extent buffer bitmap tests
> [  106.058653] BTRFS: selftest: running extent buffer memory operatio=
n tests
> [  106.058664] BTRFS: selftest: running inode tests
> [  106.058665] BTRFS: selftest: running btrfs_get_extent tests
> [  106.058680] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> [  106.058685] BTRFS: selftest: running outstanding_extents tests
> [  106.058693] BTRFS: selftest: running qgroup tests
> [  106.058694] BTRFS: selftest: running qgroup add/remove tests
> [  106.058701] BTRFS: selftest: running qgroup multiple refs test
> [  106.058709] BTRFS: selftest: running free space tree tests
> [  106.065024] BTRFS: selftest: sectorsize: 4096  nodesize: 8192
> [  106.065025] BTRFS: selftest: running btrfs free space cache tests
> [  106.065027] BTRFS: selftest: running extent only tests
> [  106.065029] BTRFS: selftest: running bitmap only tests
> [  106.065032] BTRFS: selftest: running bitmap and extent tests
> [  106.065035] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> [  106.065174] BTRFS: selftest: running bytes index tests
> [  106.065179] BTRFS: selftest: running extent buffer operation tests=

> [  106.065180] BTRFS: selftest: running btrfs_split_item tests
> [  106.065183] BTRFS: selftest: running extent I/O tests
> [  106.065183] BTRFS: selftest: running find delalloc tests
> [  106.099325] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> [  106.099327] BTRFS: selftest: running extent buffer bitmap tests
> [  106.116359] BTRFS: selftest: running extent buffer memory operatio=
n tests
> [  106.116380] BTRFS: selftest: running inode tests
> [  106.116381] BTRFS: selftest: running btrfs_get_extent tests
> [  106.116395] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> [  106.116398] BTRFS: selftest: running outstanding_extents tests
> [  106.116405] BTRFS: selftest: running qgroup tests
> [  106.116406] BTRFS: selftest: running qgroup add/remove tests
> [  106.116413] BTRFS: selftest: running qgroup multiple refs test
> [  106.116420] BTRFS: selftest: running free space tree tests
> [  106.122685] BTRFS: selftest: sectorsize: 4096  nodesize: 16384
> [  106.122686] BTRFS: selftest: running btrfs free space cache tests
> [  106.122688] BTRFS: selftest: running extent only tests
> [  106.122690] BTRFS: selftest: running bitmap only tests
> [  106.122693] BTRFS: selftest: running bitmap and extent tests
> [  106.122697] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> [  106.122837] BTRFS: selftest: running bytes index tests
> [  106.122842] BTRFS: selftest: running extent buffer operation tests=

> [  106.122843] BTRFS: selftest: running btrfs_split_item tests
> [  106.122847] BTRFS: selftest: running extent I/O tests
> [  106.122847] BTRFS: selftest: running find delalloc tests
> [  106.156175] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> [  106.156177] BTRFS: selftest: running extent buffer bitmap tests
> [  106.190038] BTRFS: selftest: running extent buffer memory operatio=
n tests
> [  106.190076] BTRFS: selftest: running inode tests
> [  106.190076] BTRFS: selftest: running btrfs_get_extent tests
> [  106.190091] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> [  106.190095] BTRFS: selftest: running outstanding_extents tests
> [  106.190102] BTRFS: selftest: running qgroup tests
> [  106.190102] BTRFS: selftest: running qgroup add/remove tests
> [  106.190110] BTRFS: selftest: running qgroup multiple refs test
> [  106.190117] BTRFS: selftest: running free space tree tests
> [  106.196389] BTRFS: selftest: sectorsize: 4096  nodesize: 32768
> [  106.196390] BTRFS: selftest: running btrfs free space cache tests
> [  106.196391] BTRFS: selftest: running extent only tests
> [  106.196394] BTRFS: selftest: running bitmap only tests
> [  106.196397] BTRFS: selftest: running bitmap and extent tests
> [  106.196400] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> [  106.196539] BTRFS: selftest: running bytes index tests
> [  106.196544] BTRFS: selftest: running extent buffer operation tests=

> [  106.196544] BTRFS: selftest: running btrfs_split_item tests
> [  106.196549] BTRFS: selftest: running extent I/O tests
> [  106.196549] BTRFS: selftest: running find delalloc tests
> [  106.230530] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> [  106.230534] BTRFS: selftest: running extent buffer bitmap tests
> [  106.297904] BTRFS: selftest: running extent buffer memory operatio=
n tests
> [  106.297981] BTRFS: selftest: running inode tests
> [  106.297982] BTRFS: selftest: running btrfs_get_extent tests
> [  106.297997] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> [  106.298001] BTRFS: selftest: running outstanding_extents tests
> [  106.298008] BTRFS: selftest: running qgroup tests
> [  106.298009] BTRFS: selftest: running qgroup add/remove tests
> [  106.298016] BTRFS: selftest: running qgroup multiple refs test
> [  106.298023] BTRFS: selftest: running free space tree tests
> [  106.304312] BTRFS: selftest: sectorsize: 4096  nodesize: 65536
> [  106.304313] BTRFS: selftest: running btrfs free space cache tests
> [  106.304315] BTRFS: selftest: running extent only tests
> [  106.304317] BTRFS: selftest: running bitmap only tests
> [  106.304320] BTRFS: selftest: running bitmap and extent tests
> [  106.304324] BTRFS: selftest: running space stealing from bitmap to=
 extent tests
> [  106.304462] BTRFS: selftest: running bytes index tests
> [  106.304468] BTRFS: selftest: running extent buffer operation tests=

> [  106.304468] BTRFS: selftest: running btrfs_split_item tests
> [  106.304473] BTRFS: selftest: running extent I/O tests
> [  106.304473] BTRFS: selftest: running find delalloc tests
> [  106.338587] BTRFS: selftest: running find_first_clear_extent_bit t=
est
> [  106.338589] BTRFS: selftest: running extent buffer bitmap tests
> [  106.472975] BTRFS: selftest: running extent buffer memory operatio=
n tests
> [  106.473127] BTRFS: selftest: running inode tests
> [  106.473127] BTRFS: selftest: running btrfs_get_extent tests
> [  106.473143] BTRFS: selftest: running hole first btrfs_get_extent t=
est
> [  106.473148] BTRFS: selftest: running outstanding_extents tests
> [  106.473155] BTRFS: selftest: running qgroup tests
> [  106.473156] BTRFS: selftest: running qgroup add/remove tests
> [  106.473164] BTRFS: selftest: running qgroup multiple refs test
> [  106.473172] BTRFS: selftest: running free space tree tests
> [  106.479514] BTRFS: selftest: running extent_map tests
> [  106.479517] BTRFS: selftest: Running btrfs_drop_extent_map_range t=
ests
> [  106.479520] BTRFS: selftest: Running btrfs_drop_extent_cache with =
pinned
> [  106.479521] BTRFS: selftest: running rmap tests
> [  126.436989] modprobe: FATAL: Module ikconfig not found in director=
y /lib/modules/6.8.6+
> [  170.100869] udevd[9881]: conflicting device node '/dev/mapper/data=
-encrypted' found, link to '/dev/dm-0' will not be created
> [  170.861020] EXT4-fs (dm-0): mounted filesystem 22071832-a730-492a-=
a11f-2bc502437c08 r/w with ordered data mode. Quota mode: disabled.
> [  176.037983] udevd[9902]: conflicting device node '/dev/mapper/pool=
-encrypted' found, link to '/dev/dm-1' will not be created
> [  177.780518] BTRFS: device label pool devid 1 transid 16145 /dev/ma=
pper/pool-encrypted scanned by mount (9904)
> [  177.780955] BTRFS info (device dm-1): first mount of filesystem 25=
48bfee-1ac9-4894-bd68-47e128d7af9b
> [  177.780963] BTRFS info (device dm-1): using crc32c (crc32c-intel) =
checksum algorithm
> [  177.780965] BTRFS info (device dm-1): disk space caching is enable=
d
> [  177.865416] BTRFS warning (device dm-1): devid 1 physical 0 len 41=
94304 inside the reserved space
> [  183.347633] udevd[10073]: conflicting device node '/dev/mapper/bac=
kup-encrypted' found, link to '/dev/dm-2' will not be created
> =

> Best regards,
> =

> --
> Hiroshi Takekawa <sian@big.or.jp>

Best regards,

--
Hiroshi Takekawa <sian@big.or.jp>

