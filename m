Return-Path: <linux-btrfs+bounces-4547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921018B2B59
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 23:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B461C2212B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C53155A4D;
	Thu, 25 Apr 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G+/GOY7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85E15534E
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081882; cv=none; b=Pzo8JLYizWLBNBLicU+XXrQcsHuv7i0yThzpgYOEhBsofTfevWY2vlr6LllFwT7uZu79iuQOPWo6fYeJuTOcon2kKgYJw1Z/QEYWC28LMwv4IR4kz56YBNwIPpJKOtEOt04x/nCAluoPaSz60wzzsSUJya/McSGIdaJq106gBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081882; c=relaxed/simple;
	bh=kq3OFym26sgTaW0h06UBZXkEMy00OkncZ8eTp//EsJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVQTn86900bc+Sgk0eBDhfJlFO6zciY1vvTwKLbJuvV844/8QkumaNu+CwX/g7PIzCBMmx9zVo6aIaNfwpS6lTRvWnj/+UBptXqj2g/ftd7+bHKMomFR2lyooak9IG0eTGnCEgkd2jiTuhU7ZmlxaeNvxxqdwKiBB8Dwt07N11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G+/GOY7C; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714081874; x=1714686674; i=quwenruo.btrfs@gmx.com;
	bh=rFMmHdgbhLvuMoLslwlqFTpD7L1lazjf8iqu63bVICI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G+/GOY7Cf0fwFKkn8bz81PWYgWLxN8SonboIxaLjz85l+CMM+J8vumAH73mtKuzh
	 vBDbJDmDpoOzz8ilxPqc0cGZYVreobODhZmnu3QCq/Ss8mCRKCaGs1jUUlbM9TTbD
	 awaABT+M7xBfvCIAX0ZB+RqIgbuiTVYbK9OAfUlsFH8hIPPriHBspgVsJt5UFrhO2
	 TlBIEuSa8e1WQkCu+fspmUJB4fNjtodvy+pqWTLED8CsURlQOPMR1Nq9DcLG2BxRZ
	 VeJ4BsLQrX9kjC1bvKaAFQzK7ovc8bnKFJrp4yHs9PPLVzonI//jeiFUqqzFAJhDp
	 cKtfXoc3mYp1jE6Nzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuDXp-1sptL23G6n-00uWPa; Thu, 25
 Apr 2024 23:51:14 +0200
Message-ID: <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
Date: Fri, 26 Apr 2024 07:21:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, boris@bur.io
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
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
In-Reply-To: <20240425123450.GP3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GTcxKYc5KwDD0zFHGl6oqd0fJe2DhpMPgpKdGLxt/ILFs19eoew
 bzI7Ygi50N41PzvRFMeT0+hKqh2cCrwfxF0VcETiGv1IAL21+Jwgn5knXeTBrhvYciI+p6o
 Fqpcchc5hA0ExUEzhb7PUzadBhovtZHwPqaUCyqQWZ7cC182OxhbmtxrXVE28tL3kI5Of/B
 qY1NM01TaMRI1OkdLcTjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4A76DF2aMd8=;2SAhNXamQFVSmtlcDpsk2GQcJk8
 aP9MxrPJSFBFLW9DtdQyd9sh1qoCMm+GLpjzJ6X6UzuQZiCGizNd16nRsjA2OD28E1kWWLvUp
 smzbGalqFNWL6nvo+AoAoEnX3odvEDJUJThLoNaAxH5B0mKOKUgzwn1XaRrp7T0kLbTfr5dJi
 3G2122uGFAHtEZ5cgyVKhoeHzr0bPsJhxZtxpoKJfSpcMk/IsIVEuR+rmwq2xsqQXcnRABaeT
 b4oy8ebQWG3Xl+KrGmm3HsDaNt8CHYZa87jgRy9mAqE0gFRrgdRjxzH/o+d3olxREqJ2hoqOb
 RvM/KgYT3o8VDvVvjYVSqUV6MOYVoZxPGTpYOQ+XjRWCjo611VXLKdFexwoZjSserdYY09IyU
 EPTUMYQfEHiTD3fUviBsN3ZN5GurzPWBgi1XRl8Qp5HcgMThcrPmMFSpsxgS6Z1dUa095GxvK
 EvS4lBXmbMItNOMRq5crsMig4DGYuj6SlBmo4kqAR9kIl7AOef/eXUmzxAIPwjG8mgQzvk2Dm
 p2AHE+MryTwzBLZjIcRdCbalsChorwKB33swOxh7zfLCRMowB19ZuzrC5xVJA24FFTCsWvx1u
 9nmHMH5jloIKrLSo8OH3mgEKKzmE/xtN4DOMPmpiYTo7tcjdoT7gMcSBQsc7p4RGS/5TzPTP9
 8eMQVhI5IpbT4xkNkaF+HDOXPBrHQgOWGTQReI9a/Lc/4llIf8HqId0mDSzkZo9QJbDMXHsnQ
 2HOR2Wn2yaw8xIa7+4SuXhcmgSbmTCfz56o04inRMEVnXgIyTDhrJpx/7Pc/Gv1yFEhx7fFpn
 dzxvJFpUwIbD4UvOKQRRuxRhY8dx8ZTaLcMGylyDdVbPQ=



=E5=9C=A8 2024/4/25 22:04, David Sterba =E5=86=99=E9=81=93:
> On Thu, Apr 25, 2024 at 07:49:12AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/24 22:11, David Sterba =E5=86=99=E9=81=93:
>>> On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
>>>> Currently if we fully removed a subvolume (not only unlinked, but ful=
ly
>>>> dropped its root item), its qgroup would not be removed.
>>>>
>>>> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroup=
s.
>>>
>>> There's also an option 'btrfs subvolume delete --delete-qgroup' that
>>> does that and is going to be default in 6.9. With this kernel change i=
t
>>> would break the behaviour of the --no-delete-qgroup, which is there fo=
r
>>> the case something depends on that.  For now I'd rather postpone
>>> changing the kernel behaviour.
>>>
>>
>> A quick glance of the --delete-qgroup shows it won't work as expected a=
t
>> all.
>>
>> Firstly, the qgroup delete requires the qgroup numbers to be 0.
>> Meanwhile qgroup numbers can only be 0 after 1) the full subvolume has
>> been dropped 2) a transaction is committed to reflect the qgroup number=
s.
>
> The deletion option calls ioctl, so this means that 'btrfs qgroup remove=
'
> will not delete it either?

Nope, at least if the subvolume is not cleaned up immediately.
>
>> Both situation is only handled in my patchset, thus this means for a lo=
t
>> of cases it won't work at all.
>>
>> Furthermore, there is the drop_subtree_threshold thing, which can mark
>> qgroup inconsistent and skip accounting, making the target subvolume's
>> qgroup numbers never fall back to 0 (until next rescan).
>>
>> So I'm afraid the --delete-qgroup won't work until the 1/2 patch get
>> merged (allowing deleting qgroups as long as the target subvolume is go=
ne).
>
> Ok, so for emulation of the complete removal in userspace it's
>
> btrfs subvolume delete 123
> btrfs subvolume sync 123
> btrfs qgroup remove 0/123
>
> but this needs to wait until the sync is finished and that is not
> expected for the subvolume delete command.

That's the problem, and why doing it in user space has it limits.

Furthermore, with drop_subtree_threshold or other qgroup operations
marking the qgroup inconsistent, you can not delete that qgroup at all,
until the next rescan.

> It needs to be fixed but now
> I'm not sure this can be default in 6.9 as planned.

I'd say, you should not implement this feature without really
understanding the challenges in the first place.

And that's why I really prefer you send out non-trivial btrfs-progs for
review, other than pushing them directly into github repo.

Thanks,
Qu

