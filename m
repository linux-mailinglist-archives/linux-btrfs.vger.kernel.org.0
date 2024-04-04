Return-Path: <linux-btrfs+bounces-3941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C58990F1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A8B24E19
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972113C3E0;
	Thu,  4 Apr 2024 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dsCO0m2/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65FC13C3C7;
	Thu,  4 Apr 2024 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268141; cv=none; b=ekzhzS13h/gcJ+4sH7VpQSpOF37MH1pcZwxBpSgABoHxWV9AefpdOyd2HwftNIVKw8I/Cp4J/lQ/EGnLFFt8AALNAkgwKuI83HHPN6lr0l//86sqUo4nU2VTaWEairZQs3H/rN9iyvvETmMmNHsdZKlsxdZQaqnypRfdQdcOBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268141; c=relaxed/simple;
	bh=4OQKT5bLncOufta+fmUh7ry0byprSvQIr1WUD3MNDRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmfV71YfLCezUP+vtW4RoWbPIyAup7A1jILKX7Vdd+TwYd/bMhDtYwtfoxn7KxCFTFIyA5djHvxuK7Mbwn8GtCU+WdPtuDxK0OwhFR7WDlk8lhGlVMYix00GF4OwGYhSN6j3/pWGOpoCj2I0XlX4t2gz5ldtcM3/f09EUQYnq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dsCO0m2/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712268135; x=1712872935; i=quwenruo.btrfs@gmx.com;
	bh=vRdH59DgBS8BAe2/3WUKH9sKyGYNWR3kIvL5/gwgd6g=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dsCO0m2/XY0tdcYeKDIgNhEkl3Yj3wUz++C1C9A+h1vm6vH6saJv6YvRNmr0Hoov
	 p6SU9mQWmM8pLag/Js5WXLoUVpQvbe25ah6xv9nBWXGDnFBNo88+fYJYU+yGGKS2M
	 /Xn49PMZ46O/W1z6K4adrbWRd9HJMrf6SA2Vf3serYckYkqun3QOSp66r//mpdT5I
	 bW0aDCV5fCP/zRaCekMOuj+YlNEXjAqJgMHblj++KY4mNGAmSeeDTqI+PjNblBoPB
	 HmXv5Xj08J7OKCS1z5XX++S4Z79gUVYzf5srG7hCIqZy8mFlBjDG8t7TllSM3oqy6
	 KUcD15NwRSog4y4Wfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fMY-1ruAvN0W6c-007FD5; Fri, 05
 Apr 2024 00:02:15 +0200
Message-ID: <d51b8a18-0b61-4f8b-ac41-01f5f7ddfa1f@gmx.com>
Date: Fri, 5 Apr 2024 08:32:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] btrfs: reduce the log level for
 btrfs_dev_stat_inc_and_print()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <cover.1710906371.git.wqu@suse.com>
 <8f3e7a57b40973e62c0d758922971566ca96fb2e.1710906371.git.wqu@suse.com>
 <20240404202644.GN14596@twin.jikos.cz>
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
In-Reply-To: <20240404202644.GN14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1TWV5WHAgslgOh5BI3MF7vSrEcJ9EpGX+3h+05We0LxURvguzU8
 Qq3yKBIKKvtIbp8OJlMt9FmfbtFD10Efp46zvTGjcogCeyJ/WyBwudZXXBMxtZ07lu0YDpc
 JmZcXRweN3GcAy6Cl9cEhDoSdeHx/5nO2nvraF1vJcm6yYjYKIC+wr+OWhndGEpiJjyaQT9
 UD7OD+V+DXxXi3LRIXFRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zuhvLjdg8v8=;ql4od9hr7Ruyfms+fHRtzAp23Tj
 4KxUfHrUXNbeNpF0xbmM9/ty4luj2mNUzMRe+LbC6tPgLj3Hmgn9jYZ1Rjpr6kRKPalZ1yhtx
 4qFYET9WOFHjpkMuaJMEr3tjqnUiEX1Ywp0yM3Ps4nXEx2Kj/EqwINcTv+oPzdwIkbCx5/eEI
 bNkzVFMSj1Jjg95p1Til8TvW5Rlnxdrp4zIaKhc7KsMrGrcDBoh1pCKvIHfRKm2+vLFFct4+m
 uuUZsQkyod1GY1GgRlVx8DXU5qSzMhoAwEYewI5bVL1wrqxZKq8zM6MeSR4OG4G5OECUGI9by
 o0xpYUWXX/3eJ7dewuOMjDMuTe8ZHvhF5Vm3oSwV0vu+KHsadymBMuvGKEOQEfTpCi7Cx5kcJ
 MI7Uaj/8LNr4F4oaJKtWaAb9wTRhFaalNkjun+Q+OC+c5p6+GaRhCqHPzZzd+rZvbagLxsF9w
 H6zLtg8BrG6NeuPHVHoWaRuYIV93QWf7Y8D9O7LBZDheISiDeDQC3rR0K7lRyiICHA8fSVWsR
 i2q7HQXHRUd7ZP8j02d+8uUMRb4hKu+3tk2Ky7N+pIQ7HOd6yRw/OcBrN6Ebvl0Ph2iIYDJzL
 2RbFF8XCNy+Yy7Sk2TYTIzvgJY3Ke9kScoXNC7n8jG54phhYM9aUiUjBySXKJfV2ovrC5tMtA
 rCQ0DUb9PxifMOTIRTO997rxLmrOiUEYzg9RcxLeN8gGvFpDUDqsnW9kZkoh1iZk+Ql+dnec4
 OKaokXHtf1D0maqLK55D9MT+LiDKaQqrA20ARIQnhubP4X2t8CXNCm8phzp1PZJkmYKsB3nFU
 8zLXlWMnyfFznhTXLLedGimxKHn4gq66d+FUfQdhwSaLw=



=E5=9C=A8 2024/4/5 06:56, David Sterba =E5=86=99=E9=81=93:
> On Wed, Mar 20, 2024 at 02:24:52PM +1030, Qu Wenruo wrote:
>> Currently when we increase the device statistics, it would always lead
>> to an error message in the kernel log.
>>
>> However this output is mostly duplicated with the existing ones:
>>
>> - For scrub operations
>>    We always have the following messages:
>>    * "fixed up error at logical %llu"
>>    * "unable to fixup (regular) error at logical %llu"
>>
>>    So no matter if the corruption is repaired or not, it scrub would
>>    output an error message to indicate the problem.
>>
>> - For non-scrub read operations
>>    We also have the following messages:
>>    * "csum failed root %lld inode %llu off %llu" for data csum mismatch
>>    * "bad (tree block start|fsid|tree block level)" for metadata
>>    * "read error corrected: ino %llu off %llu" for repaired data/metada=
ta
>>
>> So the error message from btrfs_dev_stat_inc_and_print() is duplicated.
>>
>> The real usage for the btrfs device statistics is for some user space
>> daemon to check if there is any new errors, acting like some checks on
>> SMART, thus we don't really need/want those messages in dmesg.
>>
>> This patch would reduce the log level to debug (disabled by default) fo=
r
>> btrfs_dev_stat_inc_and_print().
>> For users really want to utilize btrfs devices statistics, they should
>> go check "btrfs device stats" periodically, and we should focus the
>> kernel error messages to more important things.
>
> I kind if disagree with each point.
>
> The message is meant to be logged as it will happen in production and
> outside of development, so the debug level does not make sense.
>
> The stats message is not duplicated for the individual causes, it
> additionally tracks the whole state.

I'd disagree with this.

We already have mount time output, and detailed causes are way more
useful and just a duplicated message repeating itself.

>
> Logging important messages to system log is a common thing and we do tha=
t
> a lot, this makes debugging and anlyzing things easier. We can't
> expect that there would always be a daemon collecting the stats, there's
> not standardized or recommended tool for that. A quick look to dmesg can
> show that something is wrong.

Then try supporting cases with all these duplicated and useless
messages, you'll hardly agree that they provide any usefulness.

>
> What we can do: reduce the number messages so the whole stats are
> printed once per transaction if there is a change.
>
> We can also tune which events also print the stats, for example flush
> errors are more interesting than read/write, comparing the number of
> events that can happen in a batch.

My another point is, if it's an important error, we should output it
with detailed reason/cause/extra info immediately.

And that's already the case for regular/scrub read errors.

For critical operations like flush, we should output extra error
messages, other than relying on that generic and vague error.

Thanks,
Qu

