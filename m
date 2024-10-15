Return-Path: <linux-btrfs+bounces-8925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7399DD39
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 06:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5148B22217
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 04:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652941741C3;
	Tue, 15 Oct 2024 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pY2WJWsA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F943ACB
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967304; cv=none; b=sUuxl1wfnYwNGeEmTQQ+D2tc+xIV9KT3UXbGAjn6mSktv2GC59O6i4jkkioHEFPi0PDOwQuWio1BezOODTHOKOy2iquBLkFBTlO1tH2jOgA1Y8xEFqBEApPMOnm620J76UyHtXIFIYdIQNNF3sAVCgzNzROyTKa2hOf3fhguSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967304; c=relaxed/simple;
	bh=ysae/AkPoAgUVamXs5rWwqamYq85HA4DnjiLcWEaXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5o+Em10OBlRRa1HxM6EZUGFK4Gz/H0UEzf+1PTVDUgmDDNmjQoZAb61k+RMnSHYvzE91NvGyyJaMkS7KEQBlq2LwswPZHXPelXgwGQftuUrLi6+dhXV2F36VaEecxQfiE4Y2ofS/7rJoUcgLR/aQ1uo5zmzpxGEIT1Cu/WMY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pY2WJWsA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728967294; x=1729572094; i=quwenruo.btrfs@gmx.com;
	bh=j6973GxZJxMBD5R2WmvRN5+ZuxvE1cKUbcw42BA2MJQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pY2WJWsAU6IiJODdTSjYXvY8TN3hokdHO2za3MTurv4+jBYi6pQmRQUYf/h3oPjh
	 CU59O0mFQslwv6dIASVFAW/tCRrEtkTOrId8oxEVp0k/ZZZJ/Ap402WjZm4PdZYff
	 dxq34jyg91enzhdqjiaJG2Q+67OnMZAjHGobqPascMUhCGofgX04ceV6jHnu7b80Q
	 KA8+OrzVKJEWz1PkXV6GnGw2tHgqI1WtvinFPmjAYscrgUtNw1nENgTLT47l8DfV+
	 oGV9G+FqTxE2IVXQ93YDTJzZuVtAXvnG9+2MglbTRvj4teRJxICiW3arTHzfXlKdS
	 2lPGq71SRDGGGg3izA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ygY-1t4P7Y0FSI-001Zs4; Tue, 15
 Oct 2024 06:41:34 +0200
Message-ID: <bd7dd2ac-71f8-440d-90c4-5acebba61a92@gmx.com>
Date: Tue, 15 Oct 2024 15:11:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
 <20241014141622.GB1609@twin.jikos.cz>
 <8ef15f84-6523-4e47-beda-fa440128df0e@gmx.com>
 <20241015003148.GG1609@suse.cz>
 <3c6ce709-472a-4fbc-ad54-b7257c18c62d@suse.com>
 <10f0899c-15d5-42fc-9d8a-ccbb573673b4@oracle.com>
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
In-Reply-To: <10f0899c-15d5-42fc-9d8a-ccbb573673b4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvUyRHuv89y45vCHEzILZfX0wn5B3pVaGMVSgvLEKjZpovSgY84
 I0ufzcfrI4wmI9QvKJQltL+0iAVVpzJ0BGmQiXBkZ7kaxV5zrN3OXXzGneC4oUXJ07EIoiJ
 tRopwciR8nI5VX+dW+w3nhzALsrtjeyEWJcX+u9JN74n3AhJCkb3iYZLU/iKJI0hszeW2rz
 8YPHWxkvozPQOmMBiGRDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zDRmdO65t54=;y84rXXvi8bTutEtVXTdB1sS09zI
 U4WmL/E7Z7RL5KbDpFFGkiZyznPUjsOzli5z/5tg8P6eI5TsJSpqbGjRkY4pmlevGpZIIhHFd
 yYWjTGDEREQk6wAaR55kJYbcP/qcQdu8aTvadmNSpYBgciSt0DbumuiOjUZGlNQnW52Vb1BWn
 Nzz589PyvsqrAjvFbqiOvIO6EeJZQ7osvRG4N0jHdr69d+Eo3mOILQukM0CiVCJCXUHLpFKej
 DTmlgc24Ju9kMYhrrBXRdQggX40fAfKN9Zazv8TwjQZCOyO0Co1smK1V1cJZokfH4NjawK+N0
 SbuqglnH2K98JvsVuah72ZWNZsGjr/+B5T34BKgQJBvVyFopiHMR46AHNWO+sHZbzu6hzqBif
 DTChMSOWFnUMMdkEqcCIV1nW/cypTHUmTFOkJEMWRxPeF9pD8iBLpU/KDAY1eipaGhwcSUe8o
 YOF7kMN1P7YOpUh0yBsDUqUcL1Kqwt7jq7/m+jO+d+j8rsS4TZsgs3xKXoum36LKBUOyeZ1eO
 kEBdA7XA5pIkJlM6Ole0yFeIn5JK/3kEraqAIUYz7Vt+ZM+sQXV/In8a+8lGNNRivvyKZrQVR
 xmRxuDx3dT7x4tJpygBcD82VF9OYbm7vdvjScickmm7zxD25gyRigMyEXd6eSwqYFxXwdFJRO
 9K93NNM9i3gtGL/tYXEmMOPzz9zHRiVrJGaID3X8jO07PdKGT/VcX2R6QDkd/6BKKZtJ3UP5o
 bdCQ/Q+NqpZw3Oeyouj7zaS3FBORJxyaSkXHS9qOhDg8GN5fRllfF24vrae52UMtLhWqK5Q/T
 5OCGUt1ooWVZcHBMricv7Xfg==



=E5=9C=A8 2024/10/15 14:34, Anand Jain =E5=86=99=E9=81=93:
> On 15/10/24 09:26, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/10/15 11:01, David Sterba =E5=86=99=E9=81=93:
>>> On Tue, Oct 15, 2024 at 07:25:20AM +1030, Qu Wenruo wrote:
>>>> =E5=9C=A8 2024/10/15 00:46, David Sterba =E5=86=99=E9=81=93:
>>>>> On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
>>>>>> __filemap_get_folio() provides the flag FGP_STABLE to wait for
>>>>>> writeback.
>>>>>>
>>>>>> There are two call sites doing __filemap_get_folio() then
>>>>>> folio_wait_writeback():
>>>>>>
>>>>>> - btrfs_truncate_block()
>>>>>> - defrag_prepare_one_folio()
>>>>>>
>>>>>> We can directly utilize that flag instead of manually calling
>>>>>> folio_wait_writeback().
>>>>>
>>>>> We can do that but I'm missing a justification for that. The explici=
t
>>>>> writeback calls are done at a different points than what FGP_STABLE
>>>>> does. So what's the difference?
>>>>>
>>>>
>>>> TL;DR, it's not safe to read folio before waiting for writeback in
>>>> theory.
>>>>
>>>> There is a possible race, mostly related to my previous attempt of
>>>> subpage partial uptodate support:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Thread A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Threa=
d B
>>>> -------------------------------+-----------------------------
>>>> extent_writepage_io()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
>>>> |- submit_one_sector()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
>>>> =C2=A0=C2=A0=C2=A0 |- folio_set_writeback()=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The folio is partial dirty|
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and uninvolved sectors are|
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not uptodate=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | btrfs_truncate_block=
()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- btrfs_do_readpage=
()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |- submi=
t_one_folio
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 This will read all sectors
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 from disk, but that writeback
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sector is not yet finished
>>>>
>>>> In this case, we can read out garbage from disk, since the write is n=
ot
>>>> yet finished.
>>>>
>>>> This is not yet possible, because we always read out the whole page s=
o
>>>> in that case thread B won't trigger a read.
>>>>
>>>> But this already shows the way we wait for writeback is not safe.
>>>> And that's why no other filesystems manually wait for writeback after
>>>> reading the folio.
>>>>
>>>> Thus I think doing FGP_STABLE is way more safer, and that's why all
>>>> other fses are doing this way instead.
>>>
>>> I'm not disputing we need it and I may be missing something, what I
>>> noticed in the patch is maybe a generic pattern, structure read at som=
e
>>> time and then synced/written, but there could be some change in
>>> bettween.=C2=A0 One example is one you show (theoretically or not).
>>>
>>> The writeback is a kind of synchronization point, but also in parallel
>>> with the data/metadata in page cache. If the state, regarding writebac=
k,
>>> is not safe and we can either get old data or could get partially sync=
ed
>>> data (ie. ok in page cache but not regarding writeback) it is a
>>> problematic pattern.
>>
>> The writeback is a sync point, but it's more like an optimization to
>> reduce page lock contention.
>>
>
> The commit/ref below avoids using %FGP_STABLE (and possibly
> %FGP_WRITEBEGIN) in f2fs due to a potential deadlock in the
> write-back code, but I'm unsure how. The reasoning isn't clear.
> The two changes in our case aren't in the write-back path,
> though. On the 2nd thought, any idea if a similar deadlock would
> apply to our case in your pov?

Not an expert on f2fs, but from the function
f2fs_wait_one_page_writeback() it will do extra bio submission and merge.

So my current guess is, there may be some page marked writeback, but not
  yet submitted related to F2FS specific behaviors.

If that's the case, f2fs will cause deadlock where it didn't submit but
wait for those writeback, causing the deadlock.

Thankfully for btrfs we do not have such cases thus it doesn't apply to us=
.

Thanks,
Qu
>
>
> Ref:
> ----
>  =C2=A0 commit dfd2e81d37e1 ("f2fs: Convert f2fs_write_begin() to use a =
folio")
>
>  =C2=A0 %FGP_STABLE - Wait for the folio to be stable (finished writebac=
k)
>
>  =C2=A0=C2=A0 #define FGP_WRITEBEGIN (FGP_LOCK | FGP_WRITE | FGP_CREAT |=
 FGP_STABLE)
> ----
>
> Thanks, Anand
>
>
>> E.g. when a page contains several blocks, and some blocks are dirty
>> and being written back, but also some sectors needs to be read.
>> If implemented properly, the not uptodate blocks can be properly read
>> meanwhile without waiting for the writeback to finish.
>>
>> But from the safety point of view, I strongly prefer to wait for the
>> folio writeback in such case.
>>
>> Especially considering all the existing get folio + read + wait for
>> writeback is from the time where we only consider sectorsize =3D=3D pag=
e
>> size.
>>
>> We have enabled sectorsize < page size since 5.15, and we should have
>> dropped the wrong assumption for years.
>>
>>>
>>> You found two cases, truncate and defrag. Both are different I think,
>>> truncate comes from normal MM operations, while defrag is triggered by
>>> an ioctl (still trying to be in sync with MM).
>>>
>>> I'm not sure we can copy what other filesystems do, even if it's just =
on
>>> the basic principle of COW vs update in place + journaling.
>>
>> I do not think COW is making any difference. All the COW handling is
>> at delalloc time, meanwhile the folio get/lock/read/wait sequence is
>> more common for page dirtying (regular buffered write, defrag,
>> truncate are all in a similar situation).
>>
>> Page cache is here just to provide file content cache, it doesn't care
>> about if it's COW or NOT.
>>
>> Furthermore, COW is no longer our exclusive feature, XFS has supported
>> it for quite some time, and there is no special handling just for the
>> page cache.
>> (Meanwhile XFS and ext4 has much better blocksize < page size handling
>> than us for years)
>>
>>
>> And I have already explained in that case, waiting for the writeback
>> at folio get time is much safer (although reduces concurrency).
>>
>> Just for the data safety, I believe you need to provide a much
>> stronger argument than COW vs overwrite (which is completely unrelated)=
.
>>
>>> We copy the
>>> and do the next update and don't have to care about previous state, so
>>> even a split between read and writeback does no harm.
>>
>> Although I love the csum/datacow, I do not see any strong reason not
>> to follow the more common (and IMHO safer) way to wait for the writebac=
k.
>>
>> I have explained the possible race, and I do not think I need to
>> repeat that example again.
>>
>> If you didn't fully understand why my example, please let me know
>> where it's unclear that I can explain it better.
>>
>> Thanks,
>> Qu
>


