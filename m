Return-Path: <linux-btrfs+bounces-7787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E89699AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EAD2870A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B319F427;
	Tue,  3 Sep 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HNhN33XV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BA1A0BF7;
	Tue,  3 Sep 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357735; cv=none; b=NG3bOhjwbpYo2VK5RFgYUYuRsW47jnjrjFLL03M38Lyizp474vL1L+cpt+GSmUiJoX39PSNHOH65s5FPQzTIcq+/xtVvQgr608LuQpMMLRE7+bl3woInV/bneWTdZIpzdr3jrriqqZOooEeI7xI/NQvKTHVFGgJVk7VfY37U6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357735; c=relaxed/simple;
	bh=0EsLlew7p4ixQUH1iqCKCxGIJ0MwBss9nsjMczTCMhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eam/tWW7RfSSkCuLlJGcvz9u2tc6Bpx4eEO1zEKe36oShx6oeovmKXS1qkQuNU6gzraeaNKUFYsaXQGqQ8zNgBJ9MYI0yAZvnvhmElByOkqZn8krkmj/0bk1AEnPFjD2GSlRqqXo5Ro5zqQ5KINb7hENRpZijkBt8xKNTooLcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HNhN33XV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725357725; x=1725962525; i=quwenruo.btrfs@gmx.com;
	bh=0EsLlew7p4ixQUH1iqCKCxGIJ0MwBss9nsjMczTCMhQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HNhN33XVe21tHRMYq/iW1VAJUqiqPa65wYdB/pZQ+OH9zucGzyik6IAu1MXC6hMY
	 ifHld6ZcQUXM1WMkmKRjbBGaGrMZmmaStHwhI6NINmFyIgMh6uoJ3XsjxY7ShfLFK
	 Uf176fbu8xTu59BhV9gUw+m8IBIS3tQ38qp5xBFJ+P7FLNRp3hQ3k57VWFDO78LCh
	 zUyk4lQUZ4Yc46NgDL6kJWJx52PDOc5hDtp2XC0wpH2LMT1xp0CqdoHYTCNLzLzHB
	 3i2WvkUycyq2RF4HmvbyjfLAiEO9sqAsOcUqOk7SBHHXkMNWzXTsb6Whb9PmNOZTm
	 UZUSAKbKUpyt2Sjz+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1sGVOW3Woi-00pPHF; Tue, 03
 Sep 2024 12:02:05 +0200
Message-ID: <4201d17f-beff-448d-a8fa-5fcab46c6325@gmx.com>
Date: Tue, 3 Sep 2024 19:32:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync using
 same fd
To: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
 <20240902202856.e5mqgsbwmiwxs4qe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7vDpoG=k55yh9rJQWw=sit5fMkjPZMpVfwf7629b_hsA@mail.gmail.com>
 <20240903040907.gqfprq4ul6x7s2kt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4WSd7woy_cDmQ-1Z45zgMDdyfSS-2uzhOqkHisQewWXw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4WSd7woy_cDmQ-1Z45zgMDdyfSS-2uzhOqkHisQewWXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L/5s3FBzFnP6DEk18qZGkxHMzSft5XxkQyqxafm1WMwtFuGMn27
 4wNrQ0fdwACokEmEEc+hP9Yej0oNxr6gtpv5YPk9LiUPRyDDddc8VUswLsP1uwS9NRUbtTA
 +eUaAKStEEucyV+JXwANW6F9V/W6Vyux9MNlNsVyOrtYlVVHs21tdSl/yjP9etYqFZpXJ8e
 6fZKpxccrRjjur/Cfg6KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:msU6GcQf/A4=;D2PktTWMgpwISgPiZdspdtE5WjM
 /SIz2fzsoNQUNTJIfxoVinr8r8YEcjV4/F/83JfTxfFi8JNZZIOjiCIgvmdZV4c7XWFN+0thn
 wY55wW8r4wC/qAXNcFJd7uZ6jo0gcO6ZMD2nfhgcPJao11iDdgVRlsmzpnT8LlxDjJtbbsdiP
 5o88MwEroEeprlI8ohK27Jh4+hGPnxG0VKRK/YHX6S5nN8MZMHVh63DDBv1suCb7uEwVExtWI
 ZlrHkH3tRgsu5A4q8uUWX9bubww/IokSewcyd/mVzcaFC0paH2YSvnS68oqK4rIsjz54AtJUG
 ZlVcT7+Xl+t0ulGL2cEotUmBhLR0hyhAyJyKZfofoPa1gW/bFDetvhpBvbb8EoHnBYitJWXkm
 4lAlrm2Dix2Ta+tM2JEUKIyXYqA5bfeH8VJhZQd/oyFbK5y+JQINCd7ZrTwRGKDC9cOBqXjFp
 H6eUGPSgMlkXDEkqHFki9XwoZW+7EfRUHUp50cj8AVikhrpTw9bo+/2BKd3NKukKoXvb38sOC
 hteJcOnIfSJvDfCtDphnvGDKP78t3abcLH4deo3ssZdoeNAksuf/32cvxXjAXfSC4sDEVV/aQ
 gYPTGrvexJt7Cn7osBcsV2OYr1DadqDqA7LD7tO4LVEaOk1S+UVCwP6YA94oA4EHDFR26E5Z/
 nCcJOJXqNnd0mnIHr5ip/cg3k6UaTuP7H+kfLH329l8GH8itPpaUm3Y9ulFLDbuYi6Y9JYX7N
 qLkXDhDgVeJ8PHVzJ2ATkq3YH5gqtF91XuUowvo6K5ogzhL2f2Eer7ZvkdFmcpXdv/GNU4X9n
 kaqwGxhDP+8K0UqlDH6EO/RA==



=E5=9C=A8 2024/9/3 19:11, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Sep 3, 2024 at 5:09=E2=80=AFAM Zorro Lang <zlang@redhat.com> wro=
te:
[...]
>>
>> Oh, so this test depends on CONFIG_BTRFS_ASSERT=3Dy, or it always test =
passed? I tested
>> on general kernel of fedora 42, which doesn't enable this config.
>>
>> There's a _require_xfs_debug helper in common/xfs (and _require_no_xfs_=
debug
>> too), does btrfs have similar method to check that?
>
> No, we don't.
>
> I don't think we should make the test run only if the kernel config
> has CONFIG_BTRFS_ASSERT=3Dy.
>
> This particular regression is easily detected with
> CONFIG_BTRFS_ASSERT=3Dy, and btrfs developers and the CI we use have
> that setting enabled.
>
> The fact that this regression happened shows that fstests didn't have
> this type of scenario covered, which happens in practice with qemu's
> workload (from two user reports).
>
> I'm adding the test not just to prove the assertion can be triggered
> for this particular regression, but also to make sure no other types
> of regressions happen in the future which may be unrelated to the
> reason for the current regression.

I agree with Filipe, yes I know it's frustrating if one can not
reproduce the bug.

But considering filesystems can have different configs to expose
different behavior, limiting the test case for certain configs doesn't
really improve coverage.

And I believe for most fs development teams, we all have different
kernel configs for prod and develop coverage.

For this particular case, I believe just mentioning what is needed to
trigger the original failure (and what the original symptom) is good enoug=
h.
Although I guess that's what is missing and caused the initial confusion.

So mind to slightly update the commit message to mention the needed
config to trigger the original bug?

With such a small update, it should help us to communicate with other
people who mostly works out of our realm.

Thanks,
Qu
>
> Hope that makes sense.
>
>>
>> Thanks,
>> Zorro
>>

>

