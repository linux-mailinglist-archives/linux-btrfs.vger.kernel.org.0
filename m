Return-Path: <linux-btrfs+bounces-12760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC5A796FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7409116F794
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DE1EF0A5;
	Wed,  2 Apr 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UGqYesX1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7511C863D
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627660; cv=none; b=QFWiD9DXR3jkyirCtS2umyTOMzVAviPcNi/a7j8C+IKihRFiNptq7FyaL/tMCAFL41+c80o6SVUx5sLFSE+g3mdAHM5dsOJAMp97Lr3YPA1j5lZ1upbIy+CiXi5pvF4cQ4F84OB2Lf5WCPUYI+JMtl7M++qB6Uywy1ouXlfCKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627660; c=relaxed/simple;
	bh=K+0XDFMmoOJOpSIv97exPIsVpeLprVYA4GDUlPY3TiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/K9bpb/i47SfcupXvs0oLI1rm5dmtBWOvGJY3Opv+y5okdcF1HXU7yKShKZavAtgT+JZ7LOuRzWiIu+4si8vGKirR6lr6iZCPf6gEcpbPJg2DxFumYwOe0juwtx2Xkgadz+pHUviT4AIg7lbUBKb+vEIA0yRwaT3epOE/Zw7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UGqYesX1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743627655; x=1744232455; i=quwenruo.btrfs@gmx.com;
	bh=i9r+O5/809XAhY9yT4SCDiIRY5OQ5dIOh+BohblTJ58=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UGqYesX11FuhTO65Je7i/T9tCo+akBU+uYIIvVrP3beS1PX8eS19QPy14zpEmr63
	 MfZv7qtbEekGvGVO6ml8iMDyC7H4d3dTjhyMtO9Me1eDqOoE+7zCvENrPr+O65gKv
	 dPxPwJF8cYrDbIVEpJIKqcnEeS8XTIEsg9eycmxYl6nBz9VIDlWFROyiQDFWycMms
	 x8FwwdGk/SaarCX1BIYZIFnCAgSykcsroVljgMmCSrUL3e3nL2JDoqZISYSmr/tGS
	 GLyFCOW6gbmeAgZqTONhU7ACpp3Sl5ZpmAx1tesC5vpqjl3bD7LBQYQoTmgh3CHze
	 F+RyKnm/xwvnA/0UFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bjy-1t23bs2E7a-015rYT; Wed, 02
 Apr 2025 23:00:55 +0200
Message-ID: <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com>
Date: Thu, 3 Apr 2025 07:30:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
 <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
 <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
 <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
 <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
 <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cMn7AW8hkEG/yUU/SHPQVz78TcyINquvxcaJ3LPI9cBJ8tbWUaa
 G1w1WFP2Qm5YL0qDV5HcPGW79PSCyNCiSXAV+96WmItVw1HMsquJZfRPPB/1E6cCHTBbplN
 2Sxe+loAbYVz8z9y04OpNfRH2HjhKOd3T2gruRIQDFCkGYeY8Rf0zs/lnjmnBdcCIjbmUd+
 V5tCIZtpQ5TsUSX8EWC/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kD9gmmZNCto=;vExTfeyKTWQghP3xie/KTfUnJ5F
 wJhfQexZqL4mMUXFys9TcTLuXdgG/5McXieGRHVuBLC08SB0leOiLIkfSOlkHg1sSvkp1eRJ/
 BMwHrxFP1BO0IvNvIiKuDy/niT/v9QjlmwQdSYDkdn83bm134NeQWtVnhi0QYys6BX/AWOQ+a
 0QWLrqu5cQguV1C0lV+BgIqeZ6+pecd3VLfHNyz3zTw8EFWVo7G4bJDT6lEhagmaHe2N2OEB6
 9NAXzV1L3RZ7nU9STHKIviKaHIxh3EAK/CcdB7zST4UpmunnySsId1XcPPQYNKC3xQh3LamEl
 a0mzku3P5zDZh+KvYdebwgpJ9FKpTrFlP3C0Ksttx4ZBC4khyAGH/1nBsolgW0kFSh3v0ymFM
 ggjQhvt2Dg/9xMesgsjnow9GnFtLu3/8/wOeRyxchOVLx3U//iqCtDFUgRwUmEG82W8Vl63tC
 /9Rq/ve7wz3XaMEeXn0vMDNOAAMwOt6kcpQA9em541u6c0t/7g4GD2NWF2OXiHMiqCzrGK18K
 dMXwI6g5UXBoiszPnPl8um9YIbQ5vvWSDOcHX8IMbVLh6z9SZam+WKdjpqsB3GiPXauX1bsoP
 3vrbMZupwDdYEkWUbyC8zz27hU/05b5NrJIxWo21AFk5cSKHCoB8NPVoKydEoWDUoSsOT75Jo
 y0+dgwBw/GvRm4h3mb9CHHmLbU3AfM/ILHNDRfQN7MlOS1fvfB775jNnideg9S7LBSfzuRFUs
 9V06XI+4o3HuBniytQHeSZ0kFw0eKJaf5++fxHreTWgseEOkwVnkEjGcub0tVOANZEvrW7od4
 sJyyaaf9Za94YXrpDuBchmVaIQJ+Cn3G90G90QCYcwn1PU5OubSDInFJLW7n5sbdvPIqqJHer
 dggpA5qVLeF6E6XXvR4KD/3AtR68SNBgUqinEjVNqQb/9WSofkKKufNejHA0WZmG48ppj39kd
 92dq4Oy1Ju/OyTIukybnKys/IchbCYF3BLpaQ9tGljI5ZPDaSuYGIBc8F4ahNa0ixFyFyn5li
 HUJePp1QJJoS34rPplRmZABaAkdCmrbX1PDDMbo7lPIj+1Cw1LU5FbLVs7aqkHp9TfZxovWww
 zfAPylA5eL0GA19SS25uBt5+DlQiL6M5BCuuS7VAT6G8H7Ile8cCKOzDuscqI+mUjDlyDupGD
 9nlD+xdg/I87KKtFqfhdBctoez6PevPsZMb08+2jbNkGrvKGAVlRpcSXwTCo11RQdVIDnWZlM
 eoXPlO+sBJJBTEghno7H1J28dSDI5+RrQsXwWPVw7y0EkZcGKLuZ3HS/gGWSFaScpW+LQ6pxn
 6rHVF7g2oUgRLvgS3SLWf5Xv2ZQjmYzuciqCec/RjK5Rmn+69Rpk8EoIi7LhotmpN7x4t1YTc
 Ud9yX1Bklm4cgrAMAG/cSE0JD2L8m3P0Ki3vGV+irvYxL/7IopzOFBtnItniD59km6BPrdzPt
 qsSasCJj4/fmhuBMmP7TAUTzwJGk=



=E5=9C=A8 2025/3/29 00:11, Dimitrios Apostolou =E5=86=99=E9=81=93:
> On Fri, 28 Mar 2025, Qu Wenruo wrote:
>>
>> =E5=9C=A8 2025/3/28 00:10, Dimitrios Apostolou =E5=86=99=E9=81=93:
>>>
>>> =C2=A0Do you know of other cases besides fallocate?
>>
>> /dev/urandom or something similar, those kind of data will result the
>> compressed data to be larger than the original, and btrfs will abort
>> compression no matter the mount option.
>
> The docs imply that the compression remains enabled for incompressible
> data with compress-force:
>
>  =C2=A0 If the first portion of data being compressed is not smaller tha=
n the
>  =C2=A0 original, the compression of the file is disabled -- unless the
>  =C2=A0 filesystem is mounted with compress-force.

But the code shows otherwise, from fs/btrfs/zlib.c:

                 /* we're making it bigger, give up */
                 if (workspace->strm.total_in > 8192 &&
                     workspace->strm.total_in <
                     workspace->strm.total_out) {
                         ret =3D -E2BIG;
                         goto out;
                 }

The same thing is done for zstd too.

Nor during my local tests:

$ mkfs.btrfs  -f test.img
$ sudo mount test.img -o compress-force=3Dzlib /mnt/btrfs/
$ sudo dd if=3D/dev/urandom bs=3D1M count=3D1 of=3D/mnt/btrfs/file
$ sudo sync
$ btrfs ins dump-tree -t 5 test.img
	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
		index 2 namelen 4 name: file
	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13631488 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)
	item 7 key (257 EXTENT_DATA 524288) itemoff 15763 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 14155776 nr 524288
		extent data offset 0 nr 524288 ram 524288
		extent compression 0 (none)

Showing the resulted file extents are still uncompressed.

>
>>
>> E.g. Ext2 doesn't support fallocate.
>>
>> But suddenly dropping one feature which we originally support, is a
>> little concerning.
>>
>>>
>>> =C2=A0Maybe the best tradeoff is to add a mount option fallocate=3Doff=
.
>>
>> That will be feasible.
>>
>> I can try push that direction after you have updated the docs.
>
>
> How about this patch:
>
>
> diff --git a/Documentation/ch-compression.rst
> b/Documentation/ch-compression.rst
> index 30b8849c..2553a60c 100644
> --- a/Documentation/ch-compression.rst
> +++ b/Documentation/ch-compression.rst
> @@ -92,18 +92,34 @@ The ZSTD support includes levels -15..15, a subset
> of full range of what ZSTD
>  =C2=A0provides. Levels -15..-1 are real-time with worse compression rat=
io,
> levels
>  =C2=A01..3 are near real-time with good compression, 4..8 are slower wi=
th
> improved
>  =C2=A0compression and 9..15 try even harder though the resulting size m=
ay
> not be
>  =C2=A0significantly improved. Higher levels also require more memory an=
d as
> they need
>  =C2=A0more CPU the system performance is affected.
>
>  =C2=A0Level 0 always maps to the default. The compression level does no=
t affect
>  =C2=A0compatibility.
>
> +Exceptions
> +----------
> +
> +Any file that has been extended with the *fallocate* system call (which=
 is

Not a native speaker, and in fact I'm pretty sure I'm the biggest causer
of typos and grammar errors inside btrfs code.

But to me, the word "extended" may be a little too specific.
E.g. fallocate can be called inside a hole, not extending the file size.

Thus I'd recommend to use "touched" instead.

> +invoked by *posix_fallocate*)

And I won't mention the function name, as there are a lot of different
ways to trigger fallocate, and the posix one may not be the most common on=
e.

IMHO fallocate() is more common than the posix wrapper.


> will always be excepted from compression,
> even
> +if future file growth is without *fallocate*, even if *force-compress*
> mount

And since we mentioned that any file touched by fallocate will not be
compressed, we can skip the "future file growth" part.

> +option is used.
> +
> +The reason for this is that a successful *fallocate* call must
> guarantee that
> +writing to the allocated range wil not fail because of lack of space. T=
o
> +achieve this, btrfs disables COW (thus compression too) for the file.

Technically not correct. Btrfs doesn't disable COW for fallocated files.

The fallocated inode has a flag called PREALLOC:

	item 10 key (258 INODE_ITEM 0) itemoff 15531 itemsize 160
		generation 10 transid 10 size 1048576 nbytes 1048576
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x10(PREALLOC)

That flag makes all btrfs write paths to try NOCOW first, and if NOCOW
can not be done, it falls back to regular COW.
And such fallback will not go through compression path.

I do not have a short and easy way to explain this to end users.
May be you can extract this part into a better expression?

Thanks,
Qu

> +
> +As a workaround, one can trigger a compressed rewrite for such a file
> using
> +the *btrfs defrag* command.
> +
> +
>  =C2=A0Incompressible data
>  =C2=A0-------------------
>
>  =C2=A0Files with already compressed data or with data that won't compre=
ss
> well with
>  =C2=A0the CPU and memory constraints of the kernel implementations are =
using
> a simple
>  =C2=A0decision logic. If the first portion of data being compressed is =
not
> smaller
>  =C2=A0than the original, the compression of the file is disabled -- unl=
ess the
>  =C2=A0filesystem is mounted with *compress-force*. In that case compres=
sion
> will
>  =C2=A0always be attempted on the file only to be later discarded. This =
is
> not optimal
>
>
>
>
> Thank you for your detailed responses!
> Dimitris
>
> PS. I would like to add a command that detects if a file is marked as
>  =C2=A0=C2=A0=C2=A0 fallocate'd. Is there such a thing?
>

