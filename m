Return-Path: <linux-btrfs+bounces-2898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D886BEAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD182839F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14C364C0;
	Thu, 29 Feb 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UBRTHWha"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85002E64F
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172088; cv=none; b=LdDRV5lGvg/RHB5FX6ghp3NK2rYGDJBlq+nALonXIhkKaEX8HBI4wC04mq0fx/DcHCleaiWKFcswprihIXrlnXwx3K5WccqOT03K+B559CYJZl5ySOlft3+q9fCBuGdjRDq35rs63juzqLXh6kvUswYhbaR4muLbe6PkkyY42D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172088; c=relaxed/simple;
	bh=qKhHZmhnQlNkxetMwAJpVF2HbVRRHDJ+/RlC4kTXR8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMYWB+RBC+RJDLrTmoT0mBb9+NaxseryN7guvuJJo0f7gNSCgCYvVrzow1Ie+XdM5w+D8fLiFk3CxKGqrhqqRpWK9EIxjr2RnFYsEFZKQPoFxS5pQcKUfs2p5r3wOf0G1ZkX8XZj1OcIgnGa9WW0XmO8+gATE/YvNPcXN7IAyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UBRTHWha; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709172083; x=1709776883; i=quwenruo.btrfs@gmx.com;
	bh=qKhHZmhnQlNkxetMwAJpVF2HbVRRHDJ+/RlC4kTXR8c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UBRTHWhab54Q0QgFTKM+x00QO551jlAw9STdKfgl62Jp2SR6qG/+iTEKEvCPT+2L
	 vS0uCUzMJKcqiCXpClRaTIv7J2JcYeEx669QciVqToE3LQ44/zbeZ1MLy4eSQOpXA
	 RoM2Rs5xQ7Qs5lUROu5QspUGCeIw/f6wUEBocpiJ5Od+deXsXazgsQA++ugFkGjWn
	 SMEkf5p5eRub2QxvyKh4oaJJAUReder0K9JN6iP0p/ISSR/hYp0czx74I51qJwhZP
	 mkIyjZv9kxltFRey+WfTcfswc5m6qGH3DB3IviP4w2OTwgbzXsZJdOwq2DjtzrDfj
	 bwLl7t2FiTodkY5O/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mxm3Q-1qgHZU3vGo-00zFpM; Thu, 29
 Feb 2024 03:01:23 +0100
Message-ID: <34db6285-deb1-4b4a-b4d9-106646c0f894@gmx.com>
Date: Thu, 29 Feb 2024 12:31:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue lockup,
 is it an IO bug/hang though?
Content-Language: en-US
To: Marc MERLIN <marc@merlins.org>
Cc: linux-btrfs@vger.kernel.org
References: <ZdL0BJjuyhtS8vn1@merlins.org> <Zd5s1k8bFguE2NVl@merlins.org>
 <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
 <671192d3-1331-480b-b00a-af3eaf794089@gmx.com> <Zd_gvRXHIjtvN06N@merlins.org>
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
In-Reply-To: <Zd_gvRXHIjtvN06N@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/1BiZayzHnJrnjbqQ5iZUBS0Sg+Fhe9vSTy2cviiTWUFG3GfPB+
 mdB7x9xqXeSEJPykdCRKtSh+mhC6Ogz31Lrh6T24fX6oemx72U3R+UDwKiUY7LF52MAtEnf
 hg7YI5GMGv9HohDusGVon5GIpKczpJa36Q382bXqw79Q3qw2OjEGdW9mB3RH3PU7G4s4oP+
 9mZ+DmUxwVw22w7VYTTZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0LXeng3OzMA=;WKIFNK19blMdfVW1u7mJj0Y2vIx
 TqGanHRhyz0SYIXUs298JxAca03hnhVKFemUS3QMaDf/1OIVtXfwkrIelD5I0vOVipFQvBapw
 oNdikjNGcJlKUnc+DeAwsYxhN+pNRUMgiQecMgujsiba8F9rfENVcripl1dkKWZ7ov5cuml6B
 asA3iXxrJUPRyq1FjRRjbVztM14mrBOHl8weDnDkhMRBg7m1BJ428dBuq5K8UiiZJt/yTGUCZ
 srilHyxRJzdLvWy6z/I6S4HaK+6SGv4+Il+3rt19bVF6cU50jrLmyS6p5CxB/guglp9o8KMQD
 ZO69h9skcz/Czg7QDt5y2Joh6im4gaSW/ypMZrCtzUtxcAw9XMJq66rWa5oELHnj3J/pfucU8
 Z+fi+IQARfabvzjJxOCYCLkAbjChvsTyXcwAbC2gEm2fRJGTouNFbZJNHhT1KiBpAH7jlifzV
 X6NuJuxP5N34A/9RLDx3vrJPBi/wz4zynWQqWVUpDXZy7x3GQEEXfJXEsn8ZfEIefQFb9H2SH
 miVIs1ugJlvD5gm3CY12ZKvv/Oky1czLXoX1TiD+XHCi7utqVis/f2da1gA1lWJavbfdd2fz3
 J1E1KgvolcjMwjmFCFxcT9KEpyAKPMEqG+vja+M1yuqRylr244sGvYu76iS/QwREoQBkz+ljp
 wlMpiSmfdQH7cjpeo5FfqBej/XEQWrhDrQGAnsfsR6T7HeNO4FeZ2ox5u5Esi/ym7A7MlFTQ4
 bzNmfAfdMdkrMkRWiOj3rt9lZg3+LuYGZN0JL8bKmmwCYrH8oXfFQxOPGOncL7AR5Ya3RffxD
 t2Neh7G5B2i0MM/QE2Ee6vvnWge1wszsiR0pIRpd/UEOg=



=E5=9C=A8 2024/2/29 12:11, Marc MERLIN =E5=86=99=E9=81=93:
> On Wed, Feb 28, 2024 at 06:54:48PM +1030, Qu Wenruo wrote:
>> It looks like there are something wrong with the aacraid driver, withou=
t
>> several hanging IOs.
>>
>> That may be the cause.
>
> This was what I thought, but was hoping for a confirmation, so thanks
> for looking it over, and I guess aacraid hangs turn into btrfs hangs,
> making it look like it's at fault, but really it's not.

Not an expert on the block drivers, but a lot of btrfs works relies on
the endio function (either a successful end, or an error) to unlock
various structures.

If the driver didn't properly end the bio when something went wrong, it
would definitely cause a hang.


Another question is, are both kernels running on the same machine?

In that case, is the same aacraid driver used on v6.9? As the newer
kernel shows hangs on mdraid too, which is now shown in the older kernel.

Thanks,
Qu

>
> Thanks,
> Marc

