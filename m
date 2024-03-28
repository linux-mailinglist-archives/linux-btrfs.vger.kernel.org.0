Return-Path: <linux-btrfs+bounces-3740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7E890B41
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5315D1F27F1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F113AD07;
	Thu, 28 Mar 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sXpLabkp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E613AA22
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657441; cv=none; b=Mt491Lvc3QsM3nNd6H4ObjLIxssqmGpRdUB0qhfcYsyU9VypBGMZDj1QbyGKA/I4eCymlCwbZykb1wJeSplj5RZnWeynEqknn6x6c+JqpgHpa14cKp8dDr+IAlzl+63a2Xyr3BrkcqjHygvPewZYZ9n/MsT/gtjBkeuHBrYFfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657441; c=relaxed/simple;
	bh=OGixinJxAUZspwvtFXdqMxL77SnIGI7R+YN8YsdQmyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ex9XE1HNQ9w0OBHSFcxj0dypI2ixmxjZetOQ/OrkDvjA0vv91LpX0Dcv9UuHLDHTushpPeNXe3kuPofAizAaLjtJS6x4DkjtatikO8oRtfEDiSK9ws5pXlRA8D60oQfa1Mf7pQ0OPBk2Z49zxdgbOoqvgisfv2M2bIqoI2E2Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sXpLabkp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711657436; x=1712262236; i=quwenruo.btrfs@gmx.com;
	bh=xLjX/8hjbdR/HgjSonT+sXXh7Rsdcm6ZFEmSqcXMvNE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=sXpLabkp7xk5kQRWdtudi96sw8rObyHRWzVe2VgD7EUQzYENlzO5k8oqOb/kuhQm
	 flSYl/1IiSZrwQOeGl9lS1Vq+klj5rAJU4QtdjjVQkXvD9GwkQrHiSxwG868N4bMX
	 X1WhSf/bjDSBn1mNVvwUgYLBNsB9Nz2/UMOowfQvd9uydCp0nRHhiS3yHBgL21frM
	 IUGU1V+sKg+Hl4r1Y6OXI+BFNTMf1+R+yVGn6wCaiJGCD4ykWVUTds9u15r8o6zDl
	 XaM7YlmNZ+wUHr+T2S3ZJziqUxw5+mWLKSxSEha/AjRx/67p1aOhRXYqiu1icStOS
	 cUFomplLx388po1Avg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFvp-1rxOww3PvB-00AHYw; Thu, 28
 Mar 2024 21:23:56 +0100
Message-ID: <874a2dc5-191f-4e20-9f18-998a107b09a5@gmx.com>
Date: Fri, 29 Mar 2024 06:53:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I/O blocked after booting
To: "Massimo B." <massimo.b@gmx.net>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <238dc2b36f27838baf02425b364705c58fcc5de5.camel@gmx.net>
 <22650868-6777-41ae-a068-37821929be7c@gmx.com>
 <47440995279bdba442678e807499fff05ee49302.camel@gmx.net>
 <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
Content-Language: en-US
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
In-Reply-To: <94addf02f0eac5e5f402f48f41d16cb80d17470b.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9RLlIHOAED1b1p0a7MJnwjSfB7wFKw54pDosiL8UymGTs59sv9H
 ZsKvoajG2d5w1v319MVw/DOr0wCvrE20RdwMmRWerRflQP9sZD26ytXKkJYBYiFX2KJCMiJ
 xywhejcPPRLXlsqDDfFJIyxMFzbCizyayE7vqsIt3obiuq0Fhnvw5ERDktjd278zgTnaQUz
 RjxbOstLxxCikV9db9U7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kcwasbH0NO4=;ZMVhqJSWxye7+WUfn05LqW8a+sH
 SeJpMeBdOn8I6HNywfbTKWUM3/sglivm+cAAdWRr/swluIoCvKwY12D/pF2PYz9GFnH9FlzQA
 wcXMzTlC3ctuH3MqsB18UbBnHPSV+O8v4gDVPsw1PbAA9RcYYhk+79pCa/+Wuhj+4YCpb11yq
 10VfHN2OwB3legKxKlZP6K6HXnfs+GL4YqDz6iwcD+8CL42B1ztYPdkNyKEIsM33WWpEAMSCo
 Rsm+MECz0oB1Hl33T3ChjFRxc2cIeKMoIhPTp2sqNuF+CCtGCrSQB2k28g6XISir5JSOuUcc7
 lfGcCQdpy2l57gchg0sGQSSO+puawyiW2MQFtPoRKbfcuKbCs+B+jlVHFzaexc+5PaTKH49ck
 WStoix+7hCtiOy7xvV4ChYluwBQ4cGljO9r9RdmmhrKBs9DnYq0D7jsxdT9IbrDhcXYV0C7u0
 OjnR0hG7Y+u5zrXx9q86F4mXkg8YrVdp9ux9ozODXvlk5X9w9qjJiXXynUmgT3MQYBHpVMKf1
 rHPG40FRuFBskmEoZ74PNoA/XgJgNJGhoMpOKOkym6ifP5uro3QnXnCMZmeG8T5L9aXBP1RjA
 EVPMVkfUVJEFz8oKzZHHpWDVSgexzSYBM7NUugAMND1hs4S0/SSHuBhmIl4f7gXU6W05a81ry
 nh6diX7TNm0s6j/6ERG9bSnveeUWMPQBNtyqWmVTerAuy7Nu0ry2TMBoMmMOa4gVQYcZLzHB3
 jHo9txKYJ+MlqtjLaBv3/TZvOmgc9ZlTvhf4w8XFQb1s5Oiu79TpjX072KpGI8QNCOYlWTT00
 1/6J4vVRx4olZX9gBCGH6VHj/Es+4SHLF4VLRy2T+HKy8=



=E5=9C=A8 2024/3/29 01:25, Massimo B. =E5=86=99=E9=81=93:
> On Thu, 2024-03-28 at 11:39 +0100, Massimo B. wrote:
>
>> Mar 28 11:38:26 [kernel] [14826.740669] BTRFS warning (device dm-0): fa=
iled to
>> trim 698 block group(s), last error -512
>> Mar 28 11:38:26 [kernel] [14826.741731] BTRFS warning (device dm-0): fa=
iled to
>> trim 1 device(s), last error -512
>
>
> I have set nodiscard now on all my btrfs on SSDs...
> For not rebooting I did  mount -o remount,nodiscard /
> and I see in the syslog: turning off async discard

I mean you should not do any fstrim/discard to see if everything works
fine first.

This is to make sure the problem is really from the trim/discard part.

Thanks,
Qu
>
>   Eventhough fstrim was finishing one time with
> /: 157,3 GiB (168907370496 bytes) trimmed on /dev/mapper/luks-6745....
>
> ... now running again, it does not return, and in the syslog I see:
> [kernel] BTRFS warning (device dm-0): failed to trim 143 block group(s),=
 last
> error -512
>
> dmsetup table
> shows allow_discards on that device.
>
>
> Again I did  mount -o remount,nodiscard /
>
> But this time I don't see in the syslog  "turning off async discard"   s=
o it
> seems to be still disabled.
>
> grep " / " /proc/mounts
> shows nothing about discard or nodiscard in the options.
>
> What can I do about that failed to trim?
> I have tried this on different disks like
>
> Samsung SSD 970 EVO Plus 1TB NVMe
> and
> Samsung SSD 860 EVO 1TB SATA
>
> Trying again after the failed to trim, I got it finished again with
> 156,8 GiB (168413265920 bytes) trimmed
>
> Should fstrim be fast if it was just finished some minutes before? Why t=
here are
> again more than 100GiB to be trimmed shortly after the last run?
>
> Is there anything broken with the trim on these devices?
>
> Best regards,
> Massimo

