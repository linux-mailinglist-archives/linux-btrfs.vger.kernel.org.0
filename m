Return-Path: <linux-btrfs+bounces-7092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B894DFC6
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DCB1F215E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD215DF58;
	Sun, 11 Aug 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sezK33TB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C188F70
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723344965; cv=none; b=RAzcRlTDWQ/xUuRaPxJNHmEU/CuASkvkEVC0GOIivA8lIaplDgKQI/OR76fhPcLqb2dMi53y2PX7Z3sE/SdDsWvYYgIiLLXK0va+9txQPfJDcZ+Td6L2PjZSOgcw6/Ox0jV4oQpk55J2AjDEfmwbYEYBUsYx9FitJY2Q5/xzwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723344965; c=relaxed/simple;
	bh=+4K6XhcIDPuVC94PJotybTjZ3q5KKz3e1R8f67HD5bw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ak9SQitl9pFitz6IUX11k8u3uvBD4HVo7D2fKaYsDHsF4dQZ+smC6364P5DC/UX3kICH4xW3p9LvrcbvC3CUye80+MQuC6mii07lwiy2hzqhdVKgRtLECLHRAx4ehYKfbslaZbgXInthJ4HtJ/9Wglszr+uEza3rFofR3U+C8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sezK33TB; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723344958; x=1723949758; i=quwenruo.btrfs@gmx.com;
	bh=5r349Tq9m3SAWW1U0ZsqG9eiGEz29IhPtc2uPZw4gFo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sezK33TBKigIJ2HbX6wB8wZ6jSclKCWYQRd42V4QrOEY8Ryrumbc9DLt3+F0poys
	 IcSMXts7GWt6LBvVikfH3uM8xb0iLzuH9bVezWipAgXMVh0tK5Q+G28IMWSVP7CCr
	 Jf05CkEXI35VVo8P03WmUKtZE4xJcWqgCTZxuQPGNJ34qqoz7hsKi6b+3pEI7z/xq
	 VL0N1DYOq4USpGEPq/Xmh/FWM+mTcGyS7me0vc6QdhHA5LqFKdNoT7Alhq48J3CyB
	 IBsDufQL/79Iea8e/tfGSg7RudpQS/U1hngDv/FW1XdhU2qGbRViPJ+j5ziu0Xw/0
	 LiorXFdmwOm5qaRMwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5wPb-1sXDRm3Fvf-004X6s; Sun, 11
 Aug 2024 04:55:58 +0200
Message-ID: <564893c0-01b0-4a91-b920-a28874c1632f@gmx.com>
Date: Sun, 11 Aug 2024 12:25:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add recursive subvol delete
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
References: <20240627152156.1349692-1-maharmstone@fb.com>
 <82ab8aa0-d4c7-4dbb-99f7-a63df5ab9c81@gmx.com>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <82ab8aa0-d4c7-4dbb-99f7-a63df5ab9c81@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S0pnec8CjMITi9QArWESbDZXcu4aWEnoWodPtMf74Du4PU24HLs
 sI7827zI67ZPma+N3e+NJf0m6CG2RyxujsGACLNWAF4+P33c8ejV/ZERhcycztzseZUaAUC
 ZaZ3Xlq0thA6YUMOLoLAsywQLuLsW+dfQaH+STVkPWKNgUuh3bImC3uqnk8VIWW5wVdqg/M
 sAB+TB/txx/LE2viMMB9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0H9BbDxzNtI=;I0dn8E16Y9mfToY3PcAGPy3Dr1N
 I/QgrTbnJ+0H/d2GPJGKrgznrNt56I3u+fPz+lr+yxwAUa9XkmgunOyT0PhfEskPSBg3n5Wrp
 O+AqHhXYLrAp+o7OSZClGtMER+RbmXyrVM2e2vKVS1B0otzwS8INGFCqxEJaFsF1+Rm34e3AA
 O2H/IDSGdEmeu2carTxPjoHFlpRMzJAGfnPFKEqBoGzDP8IxLIypJsi7RltkAA4E3dHeAq9dd
 AAkS99GL3tAhOVm9I2zq+eF5S8K5y6HOaUTCmI2QQsZF76rutZk5gfUH8ybIHo5kG3oD19KIq
 HUG5CSxmuySfWbQxYHsreTL+PuF+Ixrx1boxRe4OGbSjKQdOTN1N9GnnS/y5mHWBCUCAilpAs
 KJ8fdzGTZRwMzQb9+X7tXr7jFQ0l8DUhfntxkgOttyUt/MZUARXz+xjCu7Ti9qN83v05F/hUg
 8Pf9gQsbsAqNUW3GnYle/xGrW241azC/BMSzciHG4KeRmbgkvvd5Pgjzr66LEgF2fejZaH2MP
 4XiftPRw/5kj7sQxCUezAHUPOtL9A8H8hS8fm50GN/VOtYAch9KI+rIwfb28b+tsWWxZx5Ti6
 oWnfNfKCIaJeMsoc0tOmf3NLjkvuhFwHJYfdlH+alDsj1uRQ1yBVtvnBQEexakkQH4Srz4NM/
 WxKPE4LxV8cEkkgLIpxnjGVS3ZWSQ5V6UWsv+CCuKR8q9Q8XhHFBgNmGezuMmKRf85XaNKT2g
 1oeJ3ais+eBE0tjwfDENQMRND9HbZeP5bw4GD4sUMj+BL+rO0EudiB7SIWkJcAmOi17nnBgUD
 0Dwwz80mP04NGN28O0Hp3P6Q==



=E5=9C=A8 2024/8/2 07:36, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/6/28 00:51, Mark Harmstone =E5=86=99=E9=81=93:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> Adds a --recursive option to btrfs subvol delete, causing it to pass th=
e
>> BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE flag through to libbtrfsutil.
>>
>> This is a resubmission of part of a patch that Omar Sandoval sent in
>> 2018, which appears to have been overlooked:
>> https://lore.kernel.org/linux-btrfs/e42cdc5d5287269faf4d09e8c9786d0b3ad=
eb658.1516991902.git.osandov@fb.com/
>>
>> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
>> Co-authored-by: Mark Harmstone <maharmstone@meta.com>
>
> Looks very reasonable to me, especially the flag is already there.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Sorry to bother you, although this patch already has two reviewed-by
tags, I thought it would be an easy push thus created the PR for you:

   https://github.com/kdave/btrfs-progs/pull/861

But I got some resistance from David, focusing on certain technical
details on the help string (which I strongly disagree).

I think you may want to contribute your opinions to that.
(The thread on cmds/subvolumes.c)

And if possible, you may want to send an updated version, and create
your PR to the repo (and I will close my PR).

Furthermore, you may want to submit your PR to btrfs-progs repo, to get
some more direct feedback.

Thanks,
Qu

>
> Thanks,
> Qu
>> ---
>> =C2=A0 Documentation/btrfs-subvolume.rst |=C2=A0 4 ++++
>> =C2=A0 cmds/subvolume.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++-=
-
>> =C2=A0 2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/btrfs-subvolume.rst
>> b/Documentation/btrfs-subvolume.rst
>> index d1e89f15..b1f22344 100644
>> --- a/Documentation/btrfs-subvolume.rst
>> +++ b/Documentation/btrfs-subvolume.rst
>> @@ -112,6 +112,10 @@ delete [options] [<subvolume> [<subvolume>...]],
>> delete -i|--subvolid <subvolid>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -i|--subvolid <s=
ubvolid>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subvolume id to be removed instead of th=
e <path>
>> that should point to the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filesystem with the subvolume
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -R|--recursive
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 delete subvolumes beneath each subvolume recursively
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -v|--verbose
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (deprecated) alias for global *-v* optio=
n
>>
>> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
>> index 52bc8850..b4151af2 100644
>> --- a/cmds/subvolume.c
>> +++ b/cmds/subvolume.c
>> @@ -347,6 +347,7 @@ static const char * const
>> cmd_subvolume_delete_usage[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPTLINE("-c|--commit-after", "wait for t=
ransaction commit at the
>> end of the operation"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPTLINE("-C|--commit-each", "wait for tr=
ansaction commit after
>> deleting each subvolume"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPTLINE("-i|--subvolid", "subvolume id o=
f the to be removed
>> subvolume"),
>> +=C2=A0=C2=A0=C2=A0 OPTLINE("-R|--recursive", "delete subvolumes beneat=
h each
>> subvolume recursively"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPTLINE("-v|--verbose", "deprecated, ali=
as for global -v option"),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HELPINFO_INSERT_GLOBALS,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HELPINFO_INSERT_VERBOSE,
>> @@ -367,6 +368,7 @@ static int cmd_subvolume_delete(const struct
>> cmd_struct *cmd, int argc, char **a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0 *path =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int commit_mode =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool subvol_path_not_found =3D false;
>> +=C2=A0=C2=A0=C2=A0 int flags =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 fsid[BTRFS_FSID_SIZE];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 subvolid =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>> @@ -383,11 +385,12 @@ static int cmd_subvolume_delete(const struct
>> cmd_struct *cmd, int argc, char **a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 {"commit-after", no_argument, NULL, 'c'},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 {"commit-each", no_argument, NULL, 'C'},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 {"subvolid", required_argument, NULL, 'i'},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {"r=
ecursive", no_argument, NULL, 'R'},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 {"verbose", no_argument, NULL, 'v'},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 {NULL, 0, NULL, 0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D getopt_long(argc, arg=
v, "cCi:v", long_options, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D getopt_long(argc, arg=
v, "cCi:Rv", long_options, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>
>> @@ -401,6 +404,9 @@ static int cmd_subvolume_delete(const struct
>> cmd_struct *cmd, int argc, char **a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'i':
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 subvolid =3D arg_strtou64(optarg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'R':
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fla=
gs |=3D BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'v':
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bconf_be_verbose();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> @@ -416,6 +422,11 @@ static int cmd_subvolume_delete(const struct
>> cmd_struct *cmd, int argc, char **a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (subvolid > 0 && check_argc_exact(arg=
c - optind, 1))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>
>> +=C2=A0=C2=A0=C2=A0 if (subvolid > 0 && flags & BTRFS_UTIL_DELETE_SUBVO=
LUME_RECURSIVE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("option --recursive n=
ot supported with --subvolid");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_verbose(LOG_INFO, "Transaction commit=
: %s\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 !commit_mode ? "none (default)" :
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 commit_mode =3D=3D COMMIT_AFTER ? "at the end" : "after each");
>> @@ -528,7 +539,7 @@ again:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Start deleting. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (subvolid =3D=3D 0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D btrfs_util_delete_s=
ubvolume_fd(fd, vname, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D btrfs_util_delete_s=
ubvolume_fd(fd, vname, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D btrfs_ut=
il_delete_subvolume_by_id_fd(fd, subvolid);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>

