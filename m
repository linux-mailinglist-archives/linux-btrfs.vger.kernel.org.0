Return-Path: <linux-btrfs+bounces-21628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCgoCkqNjGn5qwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21628-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 15:08:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9412511A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2D43019163
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C993161BD;
	Wed, 11 Feb 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="l8vN01zJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="kueumZAK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from e234-51.smtp-out.ap-northeast-1.amazonses.com (e234-51.smtp-out.ap-northeast-1.amazonses.com [23.251.234.51])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4328003A;
	Wed, 11 Feb 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818877; cv=none; b=CIarlvAan9gysc+ZV/1r1bL3y0TBYO2koEqM4qSM5LEKcxwbn+K3YSFNdNKDq4Dx8dsb5mVHTC20Y2dJCZyhh5Z1qtpX0kiEiWqt/kDowTkqKvW/E72m/R/QLoPUXHVNpw1gqNh0b2gfCYeIjQselIDgrIAYdd+5zIz0PnX6ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818877; c=relaxed/simple;
	bh=JBRt7Ezl/LBKAeRqxr0PRydbrRNyibAjsQeSlY40a48=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=QjSi1mvfVAC28u+gUTECJFnKN/vav+1HTHi28/AqfPL1wN5RJl9E9O2g+frDKLusAzMLMkLURoEcrXGfGznzP6ko7z/YXGPszXr4q4QlyIan97jk+DATYZkFBNE3lN2jKWcXfXiTbxjvHJiDLIY89eYdrtJcf4OhUGSO/mVbiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=l8vN01zJ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=kueumZAK; arc=none smtp.client-ip=23.251.234.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1770818874;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=JBRt7Ezl/LBKAeRqxr0PRydbrRNyibAjsQeSlY40a48=;
	b=l8vN01zJezh58AXATuIgsxCgcLgsXjj5WwUOFZPQMlJVn9nYjyuyKbfpnonax0Oc
	mrVDupViHz3Qu+Z1U+s94OkcaWQHQysm+dMZm1mF9f8M4YVyLMd79V39uzF5wIt8qW/
	AD8pwjLDMvjOCdlkysOcCeQpVukpUgN4GNVMZ6rk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1770818874;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=JBRt7Ezl/LBKAeRqxr0PRydbrRNyibAjsQeSlY40a48=;
	b=kueumZAKMGYQn8Rb4qzNRYAIGTN+CwHeT16lcJhtQDWt3QBU0zNFjwBMis8SHsKP
	FpwFKF+r5gjlatrLYK8TXb/w0MrrhuA3VdjvAU2moRRutyt0dqE+7Vib4U1/rLSSwAM
	lBrGmWklfeCfTZUTY0FIMBOxsoVI8kaUOTqnHvh4=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <aWU5VnDW8cHnnauK@mozart.vkv.me>
From: Kenta Akagi <k@mgml.me>
To: Calvin Owens <calvin@wbinvd.org>
Cc: quwenruo.btrfs@gmx.com, linux-block@vger.kernel.org, 
	linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, k@mgml.me
Subject: Re: [QUESTION] Debugging some file data corruption
Message-ID: <0106019c4d07ac84-21cd2ccf-edb9-4caa-b8ae-5706b56b4717-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Feb 2026 14:07:54 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.SskAFE1oaJ7KCjyyJFCV37nkSRmUZttpeGoevLE2CszduPSq19CK0OWqrkMmPMemkYWmFvQfvS6+lCR9ETv8vDWvEFaQZtUQ69n4DuGGNbGH4U7i+CnKWCHWm/HpilUFxPcCpCRFiQTHPHnKlfimqanQj7AjyJ2y8XQuaQGs83Sl+MS5tJ/lS6+Uh2zwyhRo:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.02.11-23.251.234.51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mgml.me,none];
	R_DKIM_ALLOW(-0.20)[mgml.me:s=resend,amazonses.com:s=suwteswkahkjx5z3rgaujjw4zqymtlt2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21628-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_MUA_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mgml.me:+,amazonses.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@mgml.me,linux-btrfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org,mgml.me];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazonses.com:dkim,ap-northeast-1.amazonses.com:mid]
X-Rspamd-Queue-Id: 9DC9412511A
X-Rspamd-Action: no action



On 2026/01/13 3:11, Calvin Owens wrote:
> On Wednesday 11/12 at 07:32 =
+1030, Qu Wenruo wrote:
>> =E5=9C=A8 2025/11/12 03:31, Calvin Owens =
=E5=86=99=E9=81=93:
>>> Hello all,
>>>
>>> I'm looking for help debugging =
some corruption I recently encountered.
>>> It happened on 6.17.0, and I'm =
trying to reproduce it on 6.18-rc. This
>>> is not really actionable yet, =
I'm just looking for advice.
>>>
>>> After copying about 10TB of data to a =
btrfs+luks+mdraid1 across two 18TB
>>> drives,
>>
>> With LUKS in the =
middle, it makes any corruption pattern very human
>> unreadable.
>>
>> I guess it's not really feasible to try to reproduce the problem again =
since
>> it has 10TiB data involved?
>>
>> But if you can spend a lot of =
time waiting for data copy, mind to try
>> the following combination(s)?
>>
>> - btrfs on mdraid1
>> - btrfs RAID1 on raw two HDDs
>=20
> I re-ran the copies several times and never reproduced it. But I finally
> hit it again after I gave up, while making a backup on 6.18.0 with
> btrfs-raid1+luks:
>=20
>     Opening filesystem to check...
>     Checking filesystem on /dev/mapper/sdc_crypt
>     UUID: =
f8223856-32cc-4dcf-8cee-9312e032c005
>     [1/8] checking log skipped (none=
 written)
>     [1/7] checking root items                      (0:00:59 =
elapsed, 4875792 items checked)
>     [2/7] checking extents               =
          (0:28:03 elapsed, 4583919 items checked)
>     [3/7] checking =
free space tree                 (0:01:01 elapsed, 8253 items checked)
>     [4/7] checking fs roots                        (0:20:30 elapsed, =
10978 items checked)
>     mirror 2 bytenr 870744010752 csum =
0xdb1b27f0ca1a0139f7c65a0c0698a9a3f9e6ca6d624da7f70eecb3fc0f14ffc7 expected=
 csum 0x2bce1cca32d98c3f83087f09980770a101b0560b1ddde7919fbbcd58a75f7d6b
>     mirror 1 bytenr 2004063948800 csum 0xe3f0a16cc8f03705a89f81178d4617c2=
847d660b7171abe29b65b5b394a9aace expected csum 0xc85b7f37fb620e1a68754692fd=
7ca43846ca316de6485fc8a4b447bfeab78d78
>     mirror 2 bytenr 3575828525056 =
csum 0xb9d9ee193d29b59b2015efed6151029c340a051c0338ec7ebca200363d304be8 =
expected csum 0xd645b7e5add1aa540a3440b78b7d31daa9545c925d32d2650d6bc61b7fd=
f4813
>     mirror 1 bytenr 3714124914688 csum 0xcb2ff575e84a8e965b94bc8faf=
9e76d8f645742ee9cd503609efd78ac22623e4 expected csum =
0x966b1d021450ffb6c47759161533e185f06a14a50c30ff881097a43b7ad6d6cc
>     mirror 2 bytenr 4211891310592 csum 0xd1c11dabfa4bf3acea463479ab444bbc=
4c66dc9ba3257f09f4e1815bb46afac2 expected csum 0x17fff4d14269c69d84d267466c=
577ced3787fd9a9a445e36642067c47f129601
>     mirror 2 bytenr 4328552914944 =
csum 0x02f75c04f1d921ce34f5b6b9bf40c3b0056971fc89989dad227fc45723938472 =
expected csum 0xdd6416d001ac47f16e68a24d1438244152355a0774142d4885e5a031c69=
38d93
>     mirror 2 bytenr 4681011163136 csum 0x44c0b9d90fb258659e7377e93a=
96039afcadb501559a0cd831bf8c36f8fa1b2b expected csum =
0x36c59223538807fc604537be5d686900031866626f3a1dc788755e92a74869cb
>     mirror 1 bytenr 4808263344128 csum 0xfd6278ce98b1f15c8aefea981e5ba7a5=
21fa1a08d0f642185abf72e215288618 expected csum 0x1108b8b604c5b21f7d7d80d32a=
1fd9c0c0e753cad8fb97967dfa3525105bf808
>     mirror 1 bytenr 4993017057280 =
csum 0x033440e421102ec0c7b3057eae89dd80f300aecba70d3f1fcf5fe81c2cd6faba =
expected csum 0xb0e94e343b7291df9aae42a079bd0bba307a1c2ab81315361a49b0d8b6d=
53f49
>     mirror 2 bytenr 5037246173184 csum 0x00b807ff8d0a31a79bb947e774=
c077916b0bd162dbf24fe43e4fca179e364214 expected csum =
0x984635996e4c3fed6c701519e9f654b1b0adb06f3921522f6b687bbccd730271
>     mirror 1 bytenr 5316786614272 csum 0x2805b36b130667ffaf187f1cc6bdab08=
02e5eb26332f3bae572202c9c34585dd expected csum 0xd7a2bab5bfddacddb610c60445=
04474c88962ed22d837a881faba8e4e60bee40
>     mirror 2 bytenr 7293991006208 =
csum 0x68f917b93233bb6c7e49775c0c0deed66c47fe0027f3d4287a3b2c736fb25a1b =
expected csum 0x3662cf0b4a35cd0a0b71a475f35a92a6fefdcf21b7ee59a97b261bb6fbd=
a1c8a
>     [5/7] checking csums against data              (33:30:05 =
elapsed, 6082759 items checked)
>     ERROR: errors found in csum tree
>     [6/7] checking root refs                       (0:00:00 elapsed, 3 =
items checked)
>     [8/8] checking quota groups skipped (not enabled on =
this FS)
>     found 8848080683008 bytes used, error(s) found
>     total csum bytes: 68538889856
>     total tree bytes: 75102781440
>     total fs tree bytes: 180338688
>     total extent tree bytes: =
340852736
>     btree space waste bytes: 5344101189
>     file data blocks allocated: 8776199127040
>      referenced =
8772977901568
>=20
> The corruptions looked similar to the first time, =
couldn't get any new
> clues out of them. Unfortunately it was on LUKS =
again because I'd given
> up on reproducing this, I'll try without LUKS =
going forward.
>=20
> I realized the common factor betwen the original =
repro and this one was
> that I was additionally running an sftp copy of =
the same files over the
> network while the files were being copied between=
 the two local volumes.
>=20
>     mkfs.btrfs -m raid1 -d raid1 --csum =
blake2 /dev/sda /dev/sdb
>     mount /dev/sda -o compress=3Dzstd:1 /mnt
>     rsync -Pav /data/ /mnt
>=20
> ...and then, concurrently from another =
machine:
>=20
>     sftp -ar nas:/data .
>=20
> Can anybody else reproduce =
this corruption with that combo?
>=20
> Otherwise, I'll keep working on =
narrowing this down: the tests take ages
> to run but require very little =
actual human time from me, so I'm happy
> to keep trying. Any other =
suggestions are welcome!

Hi Calvin,

How about replacing one of your hard =
drives with a product from a completely=20
different manufacturer for =
isolate the issue?
I've seen this type of problem occur twice due to =
hardware,=20
and neither of them were using btrfs, md or luks.

The first case was about 12 years ago. I had a RAID-Z2 (RAID6) =
configured=20
with ZFS on Linux. There was a problem only with the HDDs =
connected to the=20
Marvell 88SE9128, and the problem was resolved when I =
changed to a different=20
SATA controller.
My memory is a bit hazy, but I =
believe ZFS detected a checksum inconsistency=20
during scrubbing only on =
the disk connected with the Marvell.
- However, since you say your USB =
enclosure has been in use for a long time,=20
it seems the controller is =
not the issue.

The other case was relatively recent, and I can't go into =
details for some reasons,=20
but there was a problem with the disk's =
firmware which resulted in data corruption.

Thanks,
Akagi

>=20
> Thanks,
> Calvin
>=20


