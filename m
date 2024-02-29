Return-Path: <linux-btrfs+bounces-2899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB786BF40
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 04:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89D3B25F8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 03:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED336B16;
	Thu, 29 Feb 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XWByx8Gr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5194364D2
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175741; cv=none; b=Idigzf2uIhxu0SBnSb+PF61pIG/oHQpvsuDvBNt4WyLT+hASp3F8KxX/OMXrriGdrrpiGyc0ehw8PMWhP4m/9zMB61a0EJ+GLdi4P34/n5Y5ls0VQgdsbHjI1bawJsUv8sLwdrgPjOIXjxsTOT9HKjF4R0SyMW4S3GLeDwl/1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175741; c=relaxed/simple;
	bh=BZ56r9ua1P8zqxeU9reO8yCYDOguK2n9S+SyXgaA+F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dqOG5XLrrEKn03tuX0WuEOTxfb/bWg4KDYR7g1INToIdSeYdZ6mMQjXLaQbOvEK6icqH0bn2Wf9l8oAesRoZ5Qr9abgfXy/WkD+9Hn9txhbAIuVRLlhEB1eNyuAqZ1tAwkWXdOc1izaGYQjxi3M4MbMGJQ1bChbqosnuBJLPPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XWByx8Gr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709175736; x=1709780536; i=quwenruo.btrfs@gmx.com;
	bh=BZ56r9ua1P8zqxeU9reO8yCYDOguK2n9S+SyXgaA+F8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=XWByx8Grs7mvGP0KECvIMBFsvfUAacqJUh+aO3l3l3g1WYYUIxHgdy+kL9K5cm4s
	 cyDKaC2mw2zXI5DMByveGl20CDp+T3YiwoW85h2/O8bkgrT/UiLvojMGhg4c9eA/r
	 NCfXOun6Ipv85CGhdHgznauhdBR1OcjXwyH78adq4hLiIW0WxsJsksc1YscmZ//XI
	 KPZT/lq99WZ3+LpyHFsxY2T72+5wYmJQLuYwg09aOd0jqidJrOoEiypNYSOPaQBmW
	 RDebyiJFugJpnHa2gdCY0K6hXeqp7smtQSv0f/a/YXpWk/r/hESfdu+v1UGyolJAN
	 d2yq4pxDkpDjFKOn/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1qykoF0LcJ-00gpl1; Thu, 29
 Feb 2024 04:02:16 +0100
Message-ID: <103dacd5-d97c-42e2-8a13-39d1800a85bf@gmx.com>
Date: Thu, 29 Feb 2024 13:32:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zero sized file that should have 512KB size with 6.6
Content-Language: en-US
To: Martin Raiber <martin@urbackup.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102018df1b2a3a2-9359bfe7-9155-4af6-a0d1-7cee1faf77e4-000000@eu-west-1.amazonses.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <0102018df1b2a3a2-9359bfe7-9155-4af6-a0d1-7cee1faf77e4-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLDJ4veLRq6JNNxOufUoJDJX/yEuPj3wSz4Z4nBO6fdTwKdjlBb
 VQgKlJdDc1vYjBTXn0FumFpujVA/O01UBbteoqKjDEx79T0f6Aj73gmHXmi15jh4NOH1ovz
 0ccF3wB7VmXuD9ic6HIeOesmKwxjDUgsoTuVvy6UD2fRUGdbs9FACd9C4hvaYVIrVobNrZr
 NJ2VnV0Nj6nZN/tlxGeww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yn7zl9dY7BU=;3oYaMqOKscZ/HinQ1Fzgrh0MbwB
 WyHPuYTUNKneVoaRJskSCWL43T/rDMb9Vyu7u7yp1ENoXmyO4mEGqpf+3pUCOZcTE1Nbv6n4C
 1rhLKJxw/okEtqZLHwClqTNcc0esTYBlle2hdPruqBBCA0IJMpvNTRWQlJ2/6tf16HxROfvmJ
 TE0ehCnW0i16nvftP4R6FPMeTJJGdgB6HBDjJdCck3uUdwoHWRayqcSpiSuH1NeVtfD5fhXE0
 wqUcxCm7loN2yCljwWRL7qd6DsFc83QaJ7dHEqFXPAaAZyQcgfZKdjrZpMRWJrX2Hb63jhl4j
 Cr4jZiI/6CJI+tElABAeMxxG5de14KyC6f+Rgxgcjf2EfBXVzkxCH3VgqfhYZxO/FyBOjTqfN
 JzGaFn6EtKWnqk1V+YH4yXumGHRJT/8qlYeMQD2XVx1trZ7Tlm2EPs/6glXsXz+bd2V+yFG8a
 4D8kovexDRxfgdYD5k3SpBpegTK9izvxlX6VoB9D1Hvvx5wSqEf/UpM+MYje5g1YY13OqH9Be
 uvqJ0rJ2nVMQepOEmRTFQFTheljGQO/ZlsVkci30yjHqbW3QSN8N9W3elRaX2Q76+XjhA+wBu
 DJsaXpSCPklA/npva3L3qPIcGCl2Tfs5FH4nNrR7vtmg2CBwGIqEvIgrE04O81fz0I30IPmQt
 fNYezgA4k0oyu9t0R+yDEQbsfIWisM3M7BtjgWXEQTL7VdMVHfTxi11VNfIxodVSOVanRZmUn
 nZDtIksv2gZWd/bqtpcsWaRIVNmmTYBkdpFwMrMwFb9CMGRycjWqTzqnDXbPHnQ2tFtIVW7cS
 gB8WjWx7v0bBikSRl8DchknQ/oH6EYWx8D1P8zZDPxgi4=



=E5=9C=A8 2024/2/29 08:20, Martin Raiber =E5=86=99=E9=81=93:
> Hi,
>
> when upgrading to kernel 6.6 I have a zero sized file after a few days
> of running. I'm pretty sure the app has written 512KB into this file
> (using normal write()). Yet stat etc. return zero. But fiemap has some
> extents!

Have you found a reliable way to reproduce such files manually?
Or that application is required to create such files?

If you have a reproducer that would be a perfect case for us to fix (and
add a test case for it).

>
> The machine is not power cycled or restarted between the writing and the
> zero size issue.
>
> Kernel 6.6.17 mounted with
> rw,noatime,compress=3Dlzo,ssd,discard=3Dasync,nospace_cache,skip_balance=
,metadata_ratio=3D8,subvolid=3D5,subvol=3D/
> Running with ECC RAM (but data=3Dsingle on one device).
>
> $ filefrag -v ./73c0138c00
> Filesystem type is: 9123683e
> File size of ./73c0138c00 is 0 (0 blocks of 4096 bytes)
>  =C2=A0ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 physical_offset: length: expected: flags:
>  =C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32..=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 63:=C2=A0 229943374.. 229943405:=C2=A0=C2=A0=C2=A0=C2=A0 3=
2: 32: encoded,eof
>  =C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64..=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 95:=C2=A0 231710261.. 231710292:=C2=A0=C2=A0=C2=A0=C2=A0 3=
2: 229943406:
> encoded,eof
>  =C2=A0=C2=A0 2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 96..=C2=A0=C2=A0=C2=
=A0=C2=A0 127:=C2=A0 231741406.. 231741437:=C2=A0=C2=A0=C2=A0=C2=A0 32: 23=
1710293:
> last,encoded,eof
> ./73c0138c00: 3 extents found
>
> $ stat ./73c0138c00
>  =C2=A0 File: ./73c0138c00
>  =C2=A0 Size: 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Blocks: 768=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 IO Block: 4096 regular empty
> file
> Device: 34h/52d Inode: 424931256=C2=A0=C2=A0 Links: 1
> Access: (0750/-rwxr-x---)=C2=A0 Uid: (=C2=A0=C2=A0=C2=A0 0/=C2=A0=C2=A0=
=C2=A0 root)=C2=A0=C2=A0 Gid: (=C2=A0=C2=A0=C2=A0 0/ root)
> Access: 2024-02-28 10:52:08.421899782 +0100
> Modify: 2024-02-28 10:52:10.809908158 +0100
> Change: 2024-02-28 10:52:10.809908158 +0100
>  =C2=A0Birth: 2024-02-28 10:52:08.421899782 +0100

Could you please dump the contents of the inode?

# btrfs ins dump-tree -t 5 <device> | grep -A7 'item .* key (424931256 '

Thanks,
Qu
>
> * Nothing in dmesg
> * Btrfs scrub has no errors
> * Rebooting does not fix size
> * Btrfs check has no errors
>
> Let me know if there is anything else I can provide. Will leave this
> as-is till the end of this week.
>
> Regards,
> Martin Raiber
>
>

