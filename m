Return-Path: <linux-btrfs+bounces-15188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C84AF09B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 06:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1ED1C03DB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 04:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76881DEFDB;
	Wed,  2 Jul 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ct8i7XSz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837F1531C1;
	Wed,  2 Jul 2025 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751430072; cv=none; b=BjGC/N0PSVL4ivcnW1+fag5UP8dKTQ6zy1oq8QEK+IuGUhyjcUm9Ibi3otcyNYbm0l63chiob+2MmoynHjvGQoz4QzBPbpPt94I8J1A+DDpNbZ52RRbEkZjQ2jZI+2KJgJ2Sy0e37HVkeuJGLC3Ue++AtQQ4E+rMqW90V4w7D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751430072; c=relaxed/simple;
	bh=Zd7ViOPdLYQ/xCKX3FG8i9HuC9++ssNPbnlkmyXqde4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/VDlfIJgaziSZG7Ho7V21PfNVB4h4iOZT0TV1fo090+hvwFY4xIwfn7QTg06Z/l74kI+ZfEMkT5ICzdLitnGHMRRa6Qrh4Jh9IFabG/ZFbptCo260/kVEi3bY4tMBlmH0HN6Sy21dK/1+RzNTgGx64+dIgDDql6Uk8rg8N03ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ct8i7XSz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751430063; x=1752034863; i=quwenruo.btrfs@gmx.com;
	bh=lpgfCkjFN47SizZtLhoXB0PAE/eFCsqiHrjuZgPB4Zg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ct8i7XSzyZo7UdIzT2wqV5vqBKL0jrsB+UY8JHeFk91ONxUxj2oI8A25Y9YFi9L0
	 T++GGq+lLuloLMBv6CkgOWLO//erROz5hB4C5mQ5Ta3eMr6CYD2iAWjqbG1C3weX8
	 YA75Qw1QvqfYv1+9Qxx5AAqsRpnmgp6QzyPjgWM/+J/fjdZORCw4wiPnYXXF0E0gs
	 aEXlRZfoh9Q2G+/p8LeUOurLtfhnfrFHsFkaAx9LyAwVbCaqHlA+ofHoChrOgWu8R
	 E+gv7FjMvHfeFl3AvHg87bd1zzZQNJTrzxoOjdXs00nyolw1NFni8216eVpAjrEza
	 5Qtca4xT/w5n+XsKiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1um6kw1kPw-00vtd3; Wed, 02
 Jul 2025 06:21:02 +0200
Message-ID: <c9d298da-c7f6-4c1d-8870-78b6c7145282@gmx.com>
Date: Wed, 2 Jul 2025 13:50:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: add proper btrfs log tree detection to
 _has_metadata_journaling
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250630010253.30075-1-wqu@suse.com>
 <20250701145606.2mxdnldtcp7hcur2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250701145606.2mxdnldtcp7hcur2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8sWi6hZ1Vnrixix+4RRyh5Cg7PTQjQEhID/suRfDcDEfQfmHvCA
 v0/ZqnaYL5q/3YbU/AHmTkxbsTsJjTj8jUVOHLa1z67RIE5wQ+eyIGhjhjSXs4fP8L6u4SY
 6BVMkbTkddIED1OLhWg6yVBTLymcXo+O2S2lkaf25tqLnm9+/jGhEeGGIqksP/CpWj45BUO
 +617Wib6ZoO/z6pA8IaRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CD4q+4m9P0I=;bK++KnQRcKmaj8Dzrer/q6IGhpu
 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



=E5=9C=A8 2025/7/2 00:26, Zorro Lang =E5=86=99=E9=81=93:
> On Mon, Jun 30, 2025 at 10:32:53AM +0930, Qu Wenruo wrote:
>> [BUG]
>> With the incoming btrfs shutdown ioctl/remove_bdev callback support,
>> btrfs can be tested with the shutdown group.
>>
>> But test case generic/050 still fails on btrfs with shutdown support:
>>
>> generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//=
generic/050.out.bad)
>>      --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
>>      +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10=
:22:21.752068622 +0930
>>      @@ -13,9 +13,7 @@
>>       setting device read-only
>>       mounting filesystem that needs recovery on a read-only device:
>>       mount: device write-protected, mounting read-only
>>      -mount: cannot mount device read-only
>>       unmounting read-only filesystem
>>      -umount: SCRATCH_DEV: not mounted
>>       mounting filesystem with -o norecovery on a read-only device:
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam=
/xfstests/results//generic/050.out.bad'  to see the entire diff)
>> Ran: generic/050
>>
>> [CAUSE]
>> The test case generic/050 has several different golden output depending
>> on the fs features.
>>
>> For fses which requires data write (e.g. replay the journal) during
>> mount, mounting a read-only block device should fail.
>> And that is the default golden output.
>>
>> However there are cases that the fs doesn't need to write anything, e.g=
.
>> the fs has no metadata journal support at all, or the fs has no dirty
>> journal to replay.
>>
>> In that case, there is the generic/050.nojournal golden output.
>>
>> The test case is using the helper _has_metadata_journaling() to
>> determine the feature.
>>
>> Unfortunately that helper doesn't support btrfs, thus the default
>> behavior is to assume the fs has journal to replay, thus for btrfs it
>> always assume there is a journal to replay and results the wrong golden
>> output to be used.
>>
>> [FIX]
>> Add btrfs specific log tree check into _has_metadata_journaling(), so
>> that if there is no log tree to replay, expose the "nojournal" feature
>> correctly to pass generic/050.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/rc | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 2d8e7167..a78b779a 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4283,6 +4283,14 @@ _has_metadata_journaling()
>>   			return 1
>>   		fi
>>   		;;
>> +	btrfs)
>> +		_require_btrfs_command inspect-internal dump-super
>> +		if "$BTRFS_UTIL_PROG" inspect-internal dump-super $dev | \
>> +		   grep -q "log_root\s\+0" ; then
>> +			echo "$FSTYPE on $dev has empty log tree"
>                                 ^^^^^^
>                                 FSTYP

Despite the typo, this change is causing other test cases to be skipped.

As _require_metadata_journaling() relies on _has_metadata_journaling()=20
to check if the fs has metadata journal support.

I'll need to find a way to tell the test case that even a fs support=20
metadata journaling, the fs can still be mounted RO when there is no=20
dirty journal.

This will be more complex than just modifying _has_metadata_journaling().

Thanks,
Qu

>=20
>=20
>=20
>=20
>> +			return 1
>> +		fi
>> +		;;
>>   	*)
>>   		# by default we pass; if you need to, add your fs above!
>>   		;;
>> --=20
>> 2.50.0
>>
>>
>=20
>=20


