Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B0193EAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCZMM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 08:12:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:54439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgCZMM1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 08:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585224733;
        bh=DLwDhYjB1LY66546G4WoMYPhTcwrWaATHv4lsguG/tk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jQqErsqCCz+aAqtvTxSp+SMElateJctE0HF6VzfUjePxFbJbqBzftS0zDH1qw9PbU
         7AIRApNEBkarXsE2n1R2lmODYIgaGHHmIQODL52ihYnemAKwbiQZ2mIy9aQTL/TzH8
         PHn0GX4UoXPGFa6KQUDDSjf8cHyxxWcwOWzHgNH0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1j23AC11HU-00FRch; Thu, 26
 Mar 2020 13:12:13 +0100
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
To:     halfdog <me@halfdog.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u>
 <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com>
 <1560-1582396254.825041@rTOD.AYhR.XHry>
 <13266-1585038442.846261@8932.E3YE.qSfc>
 <20200325035357.GU13306@hungrycats.org>
 <3552-1585216388.633914@1bS6.I8MI.I0Ki>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <42c0f4cb-bf38-5a65-8702-7f4e4b75a473@gmx.com>
Date:   Thu, 26 Mar 2020 20:12:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3552-1585216388.633914@1bS6.I8MI.I0Ki>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="05AERg0Z0qNv4d8Ly8SBkGTO4fpQYtO4D"
X-Provags-ID: V03:K1:t7RIz2bbOmMB654uWxug7xV3ag3DfeCIleNuXpmsUW/MplXjktg
 e3tppFKB+9KBvZr7NmGUKEHSefGRZa5qaI4CNzbpFazIO5/ey8TFLzHR27lwgNVnirAr8az
 r/RWVgcyJ7le9+5S32sx2yjCjt8y0miYgv7JaVBy6qC6cuDDdrtYB4fQnXM/A5GlnFy8gGG
 sqwQH0QtshNQiYe9hv00g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vt7wonkbDWI=:NtI3LinZRH1wzlMaQLTiUF
 BeQywoJLJMSHiIYIKoBtJoMFbsV9aAJqZAn6FbRwNo+Sg6M0/oGkEHzYBC1ARhtEgeIkRrPIr
 LDCutCSDAwSxghnLpEoX43enm99HILU4iuLfHQg1jLOMeZCz6Q9iBqeauo9Zd1UStjoerD6UC
 0k66eIBs7m10h4S2cazsTHZUhqOm3yhAUxu1lUHApJ9c4HW/2HvdcYD6Xsv+85yWOa/Yydtsx
 od+bRDnNVlPPreBiaLkkmrDJAKujJnQUP7vB8qSxkfzSI7DtYq9EYg8BRtQtJqmjiPYffT25v
 8bIdifSYxaHCzAo9/lSYJmNN21bT8reC1/LrIEXGxn87w7LPjJ0Q6Kw3y8vrnubSuALNxNaa6
 B2DVX8u6iV8OqkrLFUjpsPk2Ts/ydms4JFy092BWHLHd6GzqRZSaF7LsI30KLkaY8SpH3BF0n
 K+F9h5dbz7+XCesg/jAIBR0vC2ldC/LYJFIBHhpj/2Zep8BHse87yxCQY/rrwFrttsJL/H5wz
 Twbh72M6htlKy5KiEi2pkFO//IKiPQJGp+4l8/dgAAf/+vrmefnWZUvKxHMdJxOHi3bwErCFP
 BQ6/nI1X9GRmjV96b7TuGMIMJ62mROapdEEM+X/W04migFrApGzOH1dxuWsvpe6rLt4ogbxts
 tPL6TnScyYqJCTG/ryg12JL3Kdiukf4x5MCYKAEPhfJTVhBQt0T4PqTjxugnc11csiVAomWfP
 VIwtwKST5UFX5xfJ92gwFjVWz84bnMW21BODzADcBTqMSX8fX0OSzYmdek6BWeWqO7nn1SB8X
 dTZjvelUxZ8rvNOoLC/MS9iN9wQ1dr6bU76j+2aK/1aFSxF/4H4R/3omAgHL7czfcG2l8zAqN
 YDMP5MxXig5tM94rFk+iG4JGNXOOPmpKP2Dt1YEjD/0hfjMkCyweg+afWFlBFK7BU2ziimND1
 LbpAcCh0BnYMe9XHhlaT761Q+NvKXSxrOAO67Q7DRYD1/HiusWRlfaklm9bXGOq0pkK5v7BJg
 nFzUtklzyQ2tgv+loP/Ynl7aIRR3E8domg2/FmyR4o6kFzU8pQfazqi0BG1W7nZxq8L2IEbBm
 aEkZOUi0muYboPowwG1aQEBWD7GA/wBNV1+QOEne51uyTqgfSujp+2VBqU7YaCmbswJkoiCOc
 cgT9dfHpburt9L8VF8l9cl7K5K+BMjSlW3i8frJPzwucsxtQDw1tkgfhFnScXLO8QgOtSq6FS
 b189g13IFH0bO16Ey
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--05AERg0Z0qNv4d8Ly8SBkGTO4fpQYtO4D
Content-Type: multipart/mixed; boundary="SgO6x3xf1CfGBNPNFgl8CUw9QSFbzRg62"

--SgO6x3xf1CfGBNPNFgl8CUw9QSFbzRg62
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/26 =E4=B8=8B=E5=8D=885:53, halfdog wrote:
> Thanks for your lengthy reply!
>=20
> Zygo Blaxell writes:
>> On Tue, Mar 24, 2020 at 08:27:22AM +0000, halfdog wrote:
>>> Hello list,
>>>
>>> It seems the woes really continued ... After trashing the
>>> old, corrupted filesystem (see old message below) I started
>>> rebuilding the storage. Synchronization from another (still
>>> working) storage roughly should have performed the same actions
>>> as during initial build (minus count and time of mounts/unmounts,
>>> transfer interrupts, ...).
>>>
>>> It does not seem to be a mere coincidence, that the corruption
>>> occured when deduplicating the exact same file as last time.
>>> While corruption last time made disk completely inaccessible,
>>> this time it just was mounted readonly with a different error
>>> message:
>>>
>>> [156603.177699] BTRFS error (device dm-1): parent transid
>>> verify failed on 6680428544 wanted 12947 found 12945
>>> [156603.177707] BTRFS: error (device dm-1) in
>>> __btrfs_free_extent:3080: errno=3D-5 IO failure [156603.177708]
>>> BTRFS info (device dm-1): forced readonly [156603.177711]
>>> BTRFS: error (device dm-1) in btrfs_run_delayed_refs:2188:
>>> errno=3D-5 IO failure
>>
>> Normally those messages mean your hardware is dropping writes
>> somewhere; however, you previously reported running kernels
>> 5.3.0 and 5.3.9, so there may be another explanation.
>>
>> Try kernel 4.19.x, 5.4.19, 5.5.3, or later.  Definitely do
>> not use kernels from 5.1-rc1 to 5.4.13 inclusive unless backported
>> fixes are included.
>=20
> Sorry, I forgot to update on that: I used the old kernel but also
> managed t reproduce on
> ii  linux-image-5.4.0-4-amd64            5.4.19-1                      =
      amd64        Linux 5.4 for 64-bit PCs (signed)
> Linux version 5.4.0-4-amd64 (debian-kernel@lists.debian.org) (gcc versi=
on 9.2.1 20200203 (Debian 9.2.1-28)) #1 SMP Debian 5.4.19-1 (2020-02-13)
>=20
>> I mention 5.5.3 and 5.4.19 instead of 5.5.0 and 5.4.14 because
>> the later ones include the EOF dedupe fix.  4.19 avoids the
>> regressions of later kernels.
>=20
> 5.4.19-1 matches your spec, but as latest Debian experimental
> is "linux-signed-amd64 (5.5~rc5+1~exp1)", which is also above
> your  5.5.3 recommendation, should I try again with that kernel
> or even use the "5.5~rc5+1~exp1" config to apply it to yesterays
> 5.5.13 LTS and build an own kernel?

Despite the kernel version, would you like to mention any other history
of the fs?

Especially about even clean shutdown/reboot of the system?

And further more, what's the storage stack below btrfs?
(Things like bcache, lvm, dmraid)

Furthermore, the specific storage hardware (e.g. SATA/SAS HDD with its
model name, the raid card if involved)

Have you experienced the same problem on other systems?

Thanks,
Qu

>=20
>>> As it seems that the bug here is somehow reproducible, I would
>>> like to try to develop a reproducer exploit and fix for that
>>> bug as an excercise. Unfortunately the fault occurs only after
>>> transfering and deduplicating ~20TB of data.
>>>
>>> Are there any recommendations e.g. how to "bisect" that problem?
>>
>> Find someone who has already done it and ask.  ;)
>=20
> Seems I found someone with good recommendations already :)
>=20
> Thank you!
>=20
>> Upgrade straight from 5.0.21 to 5.4.14 (or 5.4.19 if you want
>> the dedupe fix too).  Don't run any kernel in between for btrfs.
>>
>> There was a bug introduced in 5.1-rc1, fixed in 5.4.14, which
>> corrupts metadata.  It's a UAF bug, so its behavior can be
>> unpredictable, but quite often the symptom is corrupted metadata
>> or write-time tree-checker errors. Sometimes you just get a
>> harmless NULL dereference crash, or some noise warnings.
>>
>> There are at least two other filesystem corrupting bugs with
>> lifetimes overlapping that range of kernel versions; however
>> both of those were fixed by 5.3.
>=20
> So maybe leaving my 5.4.19-1 to the 5.5+ series sounds like recommended=

> anyway?
>=20
>>> Is there a way (switch or source code modification) to log
>>> all internal btrfs state transitions for later analysis?
>>
>> There are (e.g. the dm write logger), but most bugs that would
>> be found in unit tests by such tools have been fixed by the
>> time a kernel is released, and they'll only tell you that btrfs
>> did something wrong, not why.
>=20
> As IO seems sane, the error reported "verify failed on 6680428544
> wanted 12947 found 12945" seems not to point to a data structure
> problem at a sector/page/block boundary (12947=3D=3D0x3293), I would
> also guess, that basic IO/paging is not involved in it, but that
> the data structure is corrupted in memory and used directly or
> written/reread ... therefore I would deem write logs also as
> not the first way to go ..
>=20
>> Also, there can be tens of thousands of btrfs state transitions
>> per second during dedupe, so the volume of logs themselves
>> can present data wrangling challenges.
>=20
> Yes, that's why me asking. Maybe someone has already taken up
> that challenge as such a tool-chain (generic transaction logging
> with userspace stream compression, analysis) might be quite
> handy for such task, but hell effort to build ...
>=20
>> The more invasively you try to track internal btrfs state,
>> the more the tools become _part_ of that state, and introduce
>> additional problems. e.g. there is the ref verifier, and the
>> _bug fix history_ of the ref verifier...
>=20
> That is right. Therefore I hoped, that some minimal invasive
> toolsets might be available already for kernel or maybe could
> be written, e.g.
>=20
> * Install an alternative kernel page fault handler
> * Set breakpoints on btrfs functions
>   * When entering the function, record return address, stack
>     and register arguments, send to userspace
>   * Strip write bits kernel from page table for most pages
>     exept those needed by page fault handler
>   * Continue execution
> * For each pagefault, the pagefault flips back to original
>   page table, sends information about write fault (what, where)
>   to userspace, performs the faulted instruction before switching
>   back to read-only page table and continuing btrfs function
> * When returning from the last btrfs function, also switch back
>   to standard page table.
>=20
> By being completely btrfs-agnostic, such tool should not introduce
> any btrfs-specific issues due to the analysis process. Does someone
> know about such a tool or a simplified version of it?
>=20
> Doing similar over qemu/kernel debugging tools might be easier
> to implement but too slow to handle that huge amount of data.
>=20
>>> Other ideas for debugging that?
>>
>> Run dedupe on a test machine with a few TB test corpus (or
>> whatever your workload is) on a debug-enabled kernel, report
>> every bug that kills the box or hurts the data, update the
>> kernel to get fixes for the bugs that were reported.  Repeat
>> until the box stops crapping itself, then use the kernel it
>> stopped on (5.4.14 in this case).  Do that for every kernel
>> upgrade because regressions are a thing.
>=20
> Well, that seems like overkill. My btrfs is not haunted by a
> load of bugs, just one that corrupted the filesystem two times
> when trying to deduplicate the same set of files.
>=20
> As desccribed, just creating a btrfs with only that file did
> not trigger the corruption. If this is not a super-rare coincidence,
> then something in the other 20TB of transferred files has to
> have corrupted the file system or at least brought it to a state,
> where then deduplication of exact that problematic set of files
> triggered the final fault.
>=20
>>> Just creating the same number of snapshots and putting just
>>> that single file into each of them did not trigger the bug
>>> during deduplication.
>>
>> Dedupe itself is fine, but some of the supporting ioctls a
>> deduper has to use to get information about the filesystem
>> structure triggered a lot of bugs.
>=20
> To get rid of that, I already ripped out quite some of the userspace
> deduping part. I now do the extent queries in a Python tool
> using ctypes, split the dedup request into smaller chunks (to
> improve logging granularity) and just use the deduper to do
> that single FIDEDUPERANGE call (I was to lazy to ctype that
> in Python too).
>=20
> Still deduplicating the same files caused corruption again.
>=20
> hd
>=20
>> ...
>=20


--SgO6x3xf1CfGBNPNFgl8CUw9QSFbzRg62--

--05AERg0Z0qNv4d8Ly8SBkGTO4fpQYtO4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl58nBgACgkQwj2R86El
/qi3EggAlc8t4xznvQgrIG3SeOfHSRYHfOUTt9JiTyeModcKY3PrN4lz7MmG8JC1
RUL693kpo+e1rEMHlr8YFe06I9idE70vPoIY9htVL827oiX89DCXZgm/rguBw3G/
nq5Qf5TPKOrHjSACJEekolceFSDBkr+lJEsLAUw1L3Ag3NsNDOZ4TaQQc+Uls9Rg
HjaE3kvWBuk+S48oQ3jhg4Iyw3+dr6/ACd+3UptQBOH2Yis4pJGYJqpqiC0gApcZ
1xo1GAyjl0DSDmsZzBDMFIzK+svLCJnDlk0jfRZ/BycKPxZIcx4I1RwDZnqWVBHb
Y1+nJur/GIPRBdXvOLvlNCOwciJ7CQ==
=DW9z
-----END PGP SIGNATURE-----

--05AERg0Z0qNv4d8Ly8SBkGTO4fpQYtO4D--
