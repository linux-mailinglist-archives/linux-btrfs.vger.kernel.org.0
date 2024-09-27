Return-Path: <linux-btrfs+bounces-8277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED3987C10
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 02:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF281C22B2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5C8467;
	Fri, 27 Sep 2024 00:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iniSzVb9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE764C8C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727395965; cv=none; b=gGmQ+dFOUXB/spDOdFiiApFBYJOhQoyO5NBWw5rV53R5hMOT3L53E929A9ydY7RdVm3FMT0/gy1KQxeD69OEicbtZsCKwPIjyuLTwe4kogxTVt/l8vacnbzyTBb55rvr3yHOJg3DIO+/1VM8PDUJCekXHOdF01roiANyGo7zGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727395965; c=relaxed/simple;
	bh=TVNXSlpYLC07Sseqsa1ky1U8cbnfYhC++xQSiWHzEfE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KVW00+/T954LIrTI/fdllcDXO6m9NZMAB3RgSpom5YFE1UvTCCFzqkHXGvLo0zsLebG8RXAvMnwQEoGX6qMTlCkdCvhRHdByQLhAZ2zt8UHZitHfzjtTD6E8BNpiQNCVTWT9kdfqYt0tMQUYz2hsjsKylg1b0PqUN8J/ZKop2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iniSzVb9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727395954; x=1728000754; i=quwenruo.btrfs@gmx.com;
	bh=BVxkxPTljopIzmHsq9dO66Tpe4hR5AHSL+DkJKqttCQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iniSzVb9yE0ebqES2z4eB3KCJaW+9cW55k69YzrzuH6foY4oQwGrDs+VOz5GluXI
	 LkUDp7qZw5NYXyCk3mtgaRrL3RnZfVFeRnTQhWzrxmYovjwejVWUltKB7O79o3sdX
	 1KiiJo2IfN4juaBQ8XHTo3x27nB9433u/+wytVZKVktqQKbSb9/FE7Bw6ASaGkPQl
	 7u1IBkW7LKFewSfbZ/22WYNxezz6cIY8ELO4lAOTJCEPYOtTLGm5wlr/eQmwj5409
	 X2RjH/UiK5yeNGtFxs/igORI99cMJG7Um/fpaJtk2muoqbV/pAhS8pflVUbEndoHX
	 mC+FKhSFvQkPl3L//Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1sSNYT22QW-00WwBV; Fri, 27
 Sep 2024 02:12:33 +0200
Message-ID: <82386baf-1cff-4590-8c94-7a0ffb76aa07@gmx.com>
Date: Fri, 27 Sep 2024 09:42:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Ben Millwood <thebenmachine@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
 <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com>
 <f9062d51-946c-4142-9be1-ea8a2701592a@gmx.com>
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
In-Reply-To: <f9062d51-946c-4142-9be1-ea8a2701592a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1msD+EeLCeplV/Zh+ZqHkDJNkAmupVuO3M9lXwSxA4eLXCsTxtQ
 caPhtdy7oXfm243AimNzHJn6AydJ0zBEcJWh5MY0JfN4OpgKQcMPHeqFh2oBTyp1RV8Ly5l
 qRZNl6HDnzMYvoWhJIrbuREoNj2hlShKZNfG8w5UgSRSP66qUlj4vKntbkLzZguGQBTFsMO
 kyyREfE8zjhvF2hDtR1cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BVS13T1byM8=;E2KH6Clfk5wDIOgE+oTULbvuf7D
 0e1/z1SQiYd9rCzjER3lgBTZahXITP7kidQEJDeOg1NH1A3oiN1sB3I8xaN8NPFvyBQ3Wzu08
 Gca99geSAWr7Ehwu82zJJugFuNAsJHcaT1RfmSm+v7LHmZHLRDIlxx2Ol+W0Gjzidkj7/+J86
 zU20+OK93xBzqZSrtlLoNuBCWkmSaARR3cJktxQ4Mhk/z9vDQRUlj/1aJ+ts2EszWQr3/uLC9
 skIOhGJOeS4qiOf17xRBEz3BbgmLTO1URuf4P3pQQShJS1SDhPqhaSm2v6JMH2gVtIMnM5lUc
 16LAYkWypR6ema769891V7MhgzzSVvD8s/0sfeDNtsXUHtw7F2CMuX9dLfwSPotO58xcaem24
 jZ4cgl5ES6Kq73e5+jLii97ewfKZliRcaffO6qcfr1g1HbLEXhPeSMSA578fgR4tSY0/3mRm+
 Jd+Kfay2feHCFzBeaXKPkD4iezktc50zrfMPo267JKfQDQtUveBQLjYluY5pmp9AK7vywNKEu
 x2d0p89DChUAvFC5/18ipo38vFmZsgnEGgPqLUvqaJm1uZ6DJJy4HyACaMQ07p7hYR4u3ubri
 6tDDZpccWOLlx5aY/Gg0fd6xMi0MpEyigqY94s9W7pf2RE6C2ecKwQboAUdmSFWxPjjAeEa3I
 OWxMjVTjYNZqLPQJhKSFUR9i+GF6rAYDub5y4rCWUslVzbfW/en+Mm7VIgOsAx3iXoklq7qsz
 /P3a6iaVRdz2D/tEK813rr3rXA5Q81tzdUlgS11Fz+rsPuOAWLfn0oFEqLuDr1KG4y6pNmxd5
 2EqEfn2TMBC1GlLUTzM1anrg==



=E5=9C=A8 2024/9/27 08:43, Qu Wenruo =E5=86=99=E9=81=93:
>
>
[...]
> And send the full dump.log?

Thanks a lot for the dump.

It indeed shows something I missed before.

Firstly since it's using a parent subvolume, we do a snapshot in the
very beginning:

  snapshot        ./2024-09-12T17:04:17+00:00
uuid=3Df4190efb-ee53-0341-9613-93be3d2afbcb transid=3D63121
parent_uuid=3D1640ca1d-94ca-f448-a89c-a3d83023744a parent_transid=3D63051

Then create the file system-packages.nix:

  write
./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix offset=3D0 len=
=3D4985
  truncate
./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix size=3D4985

Which has 4985 sized, so far so good.

Now we do the clone, notice that there is no "mkfile" command, meaning
there should be an existing file at "system-packages.nix":

  clone
./2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/etc-nixos/system-pac=
kages.nix
offset=3D0 len=3D4985
from=3D./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix
clone_offset=3D0

This clone can only happen if the existing file has the same size 4985,
or the clone ioctl will fail.

Then according to your original mail, the original file in source
subvolume indeed has a different size.
The source subvolume is "2024-09-12T16:29:16+00:00", but the file has a
different size:

# stat
/snap/root/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether/etc-nixo=
s/system-packages.nix
   File:
/snap/root/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/etc-nixos/s=
ystem-packages.nix
   Size: 5026          Blocks: 16         IO Block: 4096   regular file

This is the direct cause.

The root cause is, the source subvolume has been modified:

     Name:             2024-09-12T16:29:16+00:00
     UUID:             cfa79865-0272-3845-b447-4d650c2f6d5a
     Parent UUID:         3d45fbdc-7e4e-f044-83c3-32ad05b70441
     Received UUID:         1640ca1d-94ca-f448-a89c-a3d83023744a
     Creation time:         2024-09-26 14:00:31 +0100
     Subvolume ID:         5842
     Generation:         14268      <<<<
     Gen at creation:     14255     <<<<
     Parent ID:         5
     Top level ID:         5
     Flags:             readonly
     Send transid:         63051
     Send time:         2024-09-26 14:00:31 +0100
     Receive transid:     14261
     Receive time:         2024-09-26 14:09:52 +0100
     Snapshot(s):
     Quota group:        n/a

And I believe the source subvolume has been changed to RW, then
modified, causing above contents mismatch, failing the receive.

I guess the recevied subvolume is modified in some older kernels, as
since v5.14.2 kernel will reset the received uuid upon changing it from
RO to RW.

Thanks,
Qu

>
> Thanks,
> Qu
>


