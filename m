Return-Path: <linux-btrfs+bounces-8098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7297B51E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58A4284C27
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCCF18BC12;
	Tue, 17 Sep 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iaeh4g9v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB41862B9
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608220; cv=none; b=fctQopAJxmUOfJ7eRuf9rzqwF6o01OSVU3U1N1y0QhuTTM+AVSW2AL8YsWY0uOiKb2hWNizhZOoa0OH9FbB0NIXnNce1xG/iLjWZO2i3lyUt8pwjkE8Le/yTZcyHWQwXLw5MvY27hl17gqhdN01v8PoIzRgalpRUiPgOHs8QVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608220; c=relaxed/simple;
	bh=+arKzJ8oiy9UNhpmGeJsVqEfdQhzfDCBxHsExE39bPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5v3cZKg6RSxwxXuU1w8V1y3LECHYS4EO70mxy+cbugjrG2C2FHdeZ06JhXHP+uFjrrrLPJK4b5lJUXFI1ZOYKnkGTY+A0TIXdQA3a1rw5H1ZZgVCFNZUA+5xFYPMtBS7B24Ii+0SrUvzZTy7yfaG9MpUt9ypIld/Ayoxa5KDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iaeh4g9v; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726608215; x=1727213015; i=quwenruo.btrfs@gmx.com;
	bh=JvHfGTLe0eeKj6zkIk3BiUCiLqrkmw2tGFAxsO2pDSc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iaeh4g9voqNUzRXRUGjDQGEbcBI4kVuWS1OjUGmtI3idA/VKuagLTHFR+7aNIHKD
	 SBbY8DZgoRFswe0v//ibvXAvzgVr91k8K8vgJZbIN7rsBLt9t8s1dtM5RA70xYE8Q
	 dD6Xxr3ffp2nZ/KbWDpbPgFKTupGzMEex67sbaHXITh8NnpOZg4Nd5dvCOjCTxJx7
	 CLuEIYq8hUNom06OLFiG8MfsQANWX1LPkV5fDtVvKn59CH1TAkC5FW0vQCgvbm7oe
	 +MTBr0CoV8+oj44RBcjJuxZwtVR/tkb+FzdqIyKY9JJdQuLWgsHkQ80Lhp3JgdhUB
	 CbuNRFRwyOaEdDdjQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTN9-1seDJr1Zmn-00Y6ZT; Tue, 17
 Sep 2024 23:23:34 +0200
Message-ID: <8cbc9893-5612-482e-ae4b-95545f9e100d@gmx.com>
Date: Wed, 18 Sep 2024 06:53:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not assume the full page range is not dirty in
 extent_writepage_io()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <6239c8bb8ce319c2940d6469ffcb7f5f6641db79.1726011300.git.wqu@suse.com>
 <20240917165941.GH2920@twin.jikos.cz>
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
In-Reply-To: <20240917165941.GH2920@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0k5Kulc2ajV/lpsq21MynnXZzEdwuR1mE9yyZ0mbQ5peDo5p9mg
 t8s2+d4DAbUX5UWuyOCCVLCWJtJx8oF/bslvB04mdMoKOsOpvlWRJcZWZuTxk6DPo2zyJ4k
 rmA/sg9HMpKzj+7M8mav4zzHl4rCnFQfM1GfAWNGlfM1LsOqOBK/8m3Hrkc7NxBiZn//Phv
 GBD0qM8tELRENkoWYPEUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fVxC9dVRcUo=;zdF/7tIsX/F/WR53qrIKsVENwdj
 fVrLK6O5kJYcncNtMwVpeaVFbRIcizghmvJemk6hbZjdybTk4ijPudkQcDKKEZThrYhFfMQfh
 Ykmt8cv2nGmLvItA2GtiepuWFjyShR0JhZdC87FEsVT5bhOM8o7lUrvWDyxPwAJu1HI+zTgv7
 j12Wi+6NRgGesFx77+c0TpltQU/+SccGhkJP1dDI6XTnz/kgX3vyFaZJrM7Xv4hmhnIW4xXfo
 FjHEoFO0XvSLzBpdENoEFcgiC4+JLEAObnZ7A/wMO5QD+MK0xZ82nf3MkBGKenZDj81BcPxcI
 NDTc9g+ZONFd4jJhUSDiVVK2+42X1utcCuXlHLQ3KzlV6z8Gm+TII461U4610Pw7NnrX7yXCq
 8umMyRHGY/amgAdXUwKznSbJgGAJXiT6wAZ4DnEG8mlLrnTXZ1hGKDpgl/89i4xCSAIc4GZMS
 97LcjogdDy/hb76KkLPVYXFvT2ycyPwee3Zs5j2CJ/xvYwROXGF78V+u2fPLaSgvsWjivsZrI
 Gmrfx1Lla5aDYz4E/WreHcUvNM5/5Aw2K9vUsMwKURXMNKsZMPQyhbWy79qwVxgx2CHxzmY8V
 h9vB9GYqK5MVs2mRjr0Rk8jhSvM6YSUrnOl4dg70CRB7Fd1SP0ImOveUn0c0vj/7tJawpUtbO
 72gX4Meh8CSzLhdG8JXqLEWDc9waUB/xOhOoWBhMpQ5VCXzv46xGfAx612jzbOjTVmW8RMJpu
 7C3Iti39s6LX/StwW9B9hlasjYCZinZl3sVEUNkW4RWdEwi+p8T4e3hbx+uRF9f47LeFF3UT+
 mAKKN5LlB89P1+1It1yibjyq3NYyjvwQxezBoHo7trIz8=



=E5=9C=A8 2024/9/18 02:29, David Sterba =E5=86=99=E9=81=93:
> On Wed, Sep 11, 2024 at 09:51:02AM +0930, Qu Wenruo wrote:
>> The function extent_writepage_io() will submit the dirty sectors inside
>> the page for the write.
>>
>> But recently to co-operate with the incoming subpage compression
>> enhancement, a new bitmap is introduced to
>> btrfs_bio_ctrl::submit_bitmap, to only avoid a subset of the dirty
>> range.
>>
>> This is because we can have the following cases with 64K page size:
>>
>>      0      16K       32K       48K       64K
>>      |      |/////////|         |/|
>>                                   52K
>>
>> For range [16K, 32K), we queue the dirty range for compression, which i=
s
>> ran in a delayed workqueue.
>> Then for range [48K, 52K), we go through the regular submission path.
>>
>> In that case, our btrfs_bio_ctrl::submit_bitmap will exclude the range
>> [16K, 32K).
>>
>> The dirty flags for the range [16K, 32K) is only cleared when the
>> compression is done, by the extent_clear_unlock_delalloc() call inside
>> submit_one_async_extent().
>>
>> This patch fix the false alert by removing the
>> btrfs_folio_assert_not_dirty() check, since it's no longer correct for
>> subpage compression cases.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> This should be the last patch before the enablement of sector perfect
>> compression support for subpage.
>>
>> Locally I have already been testing the sector perfect compression, and
>> that's the last fix.
>>
>> All the subpage related fixes can be applied out of order as long as th=
e
>> final enablement patch is at the end of the queue, but for now
>> my local branch has the following patch order (git log sequence):
>>
>>   btrfs: allow compression even if the range is not page aligned
>>   btrfs: do not assume the full page range is not dirty in extent_write=
page_io()
>>   btrfs: make extent_range_clear_diryt_for_io() to handle sector size <=
 page size cases
>>   btrfs: wait for writeback if sector size is smaller than page size
>>   btrfs: compression: add an ASSERT() to ensure the read-in length is s=
ane
>>   btrfs: zstd: make the compression path to handle sector size < page s=
ize
>>   btrfs: zlib: make the compression path to handle sector size < page s=
ize
>
> That's great news. I don't think there's anything else of comparable
> size missing from the subpage support.

Well, one more submitted series, which slightly reworks the delalloc
locking inside a page, to fix a possible double folio unlock which leads
to some hang:

https://lore.kernel.org/linux-btrfs/cover.1726441226.git.wqu@suse.com/

Then we're able to enable the feature:

https://lore.kernel.org/linux-btrfs/05299dac9e4379aff3f24986b4ca3fafb04d5d=
6a.1726527472.git.wqu@suse.com/


>
> We're now in the middle of merge window but as the pull request has been
> merged there's nothing blocking for-next so you can post the patches and
> then add them.

Sure, but IIRC none of the small fixes gets reviewed, I'm still waiting
for feedback.

Appreciate any review on those fixes, especially for those compression
path ones (the first 3), as they are really small fixes and will still
be needed even if we later change how we submit compressed writes.

Thanks,
Qu

