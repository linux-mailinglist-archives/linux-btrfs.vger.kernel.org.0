Return-Path: <linux-btrfs+bounces-8662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DA9958DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830C2B22BFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E12139C7;
	Tue,  8 Oct 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b8DnRtWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2058222
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421100; cv=none; b=sA6MN1jmzasrI5HzAo2YbsljrFfQn9I96VwpdX7O7gS9AtDJorftHw5AKGbebA8L0Ddq18OKIPMltFr4U35wMSQfL8P2zIdks9fhTFPfk9EQkq3G1B30p75pwhXWKgVZ2FvGDa2a2Bwz/s4sNgwB2S+8WkHztL1ppRCkH5oV8AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421100; c=relaxed/simple;
	bh=yoGH8/Y43y6s/pnbcZEKyp19LKeUJ02Jke9b+lqHF5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/vLeu0A4lIKdQNju0PFzk68SvUpM5Nbr4Gj4M91cMOX2CVAp0cGGb3vbcHLEhvwHk2I5ClT6WLIZW6dT12EShQioWQDlMYrVhBr7h8ZNJ0Glmjw+4qQX0wfFZUOWSOysKCoU7spY/RJFiSr4LZgF2JPLzlCyRRk18ksnzFSlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b8DnRtWd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728421093; x=1729025893; i=quwenruo.btrfs@gmx.com;
	bh=Oy5tNiyhGNWweZ2qLR+Mlu9Ha6wnsac18/7l6gY/w7s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b8DnRtWdQ5Q5fxXLjac+e48KpmWLm3YUZMIQxNeDmo0OL9LOzoa+MVjejsk7CMWp
	 E09NNprFie+P4nyTKPqlBXHchRo1goKINSKTn51h5bVemDyBpdVTKHcbDhPGZCWiG
	 y/hBqMoKQviGf/T6TcTjXeFZCS6DNiePuXMXtlEOTKgXz4jtPMH9ZtYJ9rMI9Rp3u
	 w+PqTsXnZQaGDk46+aGA2T3OckSgZKfrkXxnzazW1PezY24iLBieqc4UCd2dhubfS
	 VEB+MSndMysgGNWgLTosTDxZZUIuzuPESGA8u4eLFgbt54FHJsdmgeodGp6nq1425
	 7rQdVr6w5dGcru57Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1t4Zsj1rDd-003wTM; Tue, 08
 Oct 2024 22:58:13 +0200
Message-ID: <3a5b435b-7790-4499-8501-9ae3646f3377@gmx.com>
Date: Wed, 9 Oct 2024 07:28:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix the delalloc range locking if sector size <
 page size
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <305e53f3931e164c8ab3b09c059ea68bd792a4b2.1728256845.git.wqu@suse.com>
 <20241008165833.GD1609@twin.jikos.cz>
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
In-Reply-To: <20241008165833.GD1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wndrmv0RPMQjA+EqOxmVPKMkyNy4U/D7ZiCn7Ztx8TwEIyaEka7
 4v8kbE+UXWTZsItTaBU2q7lMkDXKuC+xwfV2nHI1JNt8aqjfV9KfVRtF4xy18KzxOTY5May
 keDheQL83ugkqYsmcmIo2EO0jHSW10iu8eGKQdIUjvYgSmq5Mo9Kk4ucbjnNLlnBayJgASZ
 A7sovpbXcxxyo6v5RsZbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Dkak0H3VFw=;3l9lSpPUrGUAC1QxWJbMXJpgpS5
 Wh21IWBJvVcufkMLAAcigoDFLg31GW7/hnxM5bVa0T6i0THwJHykJk+vURWjnInsgyh4JYpsV
 kN9Fy1DbCFU4Q6d9dzIh35ezYvf6XnRgl5z/8jzwlLtSZGOcGJVmwiEekNWveTVFc9bnMSXOL
 gJCEjMXZ5+u7NoJFtOT9hkJfmKnIhMTvqyD25yHmtpRFAwz7Y7+gIZdRBTTiMiccNZ15KuK8B
 dh4ll7drDhKZOmKZgKnzzNk2pyP3t7y8b6oROH+B0vrkjI3IUij7Pp3IuH3hsKBxSO+xlAeHq
 LiQI6nseegipDCiBCwA6mnjRk8r2jCUv9Xg75ZVTcV/xn6n2cjHvSSBk2U2QnqgsojddJ3+I4
 qd7xggXjmw+OKOewjf059Buxw7UmfUkInTMuPELvDT7OsD2RIz1je0rDkeQOmQFixAdDzDP7D
 tGhs1HWEyeVYs+KnTFmb+4uuri+Tz4rH+Wk/TfH4hqAIooWzIffAVh7wlxdEW3zsKvJYo2mC0
 uVAWDX8GqgbqJyJNF8yI1VcSeVrkHDpp85pHu5ke6/+fC7fYTFmvLC9AVQoFeuToKICOi+KLG
 42JnukoT0N3uYt2jGUtlHVR8fR+Fcmtk5zblpcYiJC8iGhCns9KU/3RdovAmFKAoDQTvvM5Xj
 3b6+XtoXiHIwBsK18U//jL1uRzj8wrFny/7SbCyZ26gsxdJYYAu35pQNRZc3On1FAWdxIlrAf
 FD0gOnuuhWt6LiBMst/eQXqJIPNvWU8ksKlwyeE+vUCtvT2XKsr4jeqQf0xkJAVs4Dk5OUMo9
 7OyAK1f+rRdEHZzHf28/xebQ==



=E5=9C=A8 2024/10/9 03:28, David Sterba =E5=86=99=E9=81=93:
> On Mon, Oct 07, 2024 at 09:51:40AM +1030, Qu Wenruo wrote:
>> Inside lock_delalloc_folios(), there are several problems related to
>> sector size < page size handling:
>>
>> - Set the writer locks without checking if the folio is still valid
>>    We call btrfs_folio_start_writer_lock() just like it's folio_lock().
>>    But since the folio may not even be the folio of the current mapping=
,
>>    we can easily screw up the folio->private.
>>
>> - The range is not clampped inside the page
>>    This means we can over write other bitmaps if the start/len is not
>>    properly handled, and trigger the btrfs_subpage_assert().
>>
>> - @processed_end is always rounded up to page end
>>    If the delalloc range is not page aligned, and we need to retry
>>    (returning -EAGAIN), then we will unlock to the page end.
>>
>>    Thankfully this is not a huge problem, as now
>>    btrfs_folio_end_writer_lock() can handle range larger than the locke=
d
>>    range, and only unlock what is already locked.
>>
>> Fix all these problems by:
>>
>> - Lock and check the folio first, then call
>>    btrfs_folio_set_writer_lock()
>>    So that if we got a folio not belonging to the inode, we won't
>>    touch folio->private.
>>
>> - Properly truncate the range inside the page
>>
>> - Update @processed_end to the locked range end
>>
>> - Remove btrfs_folio_start_writer_lock()
>>    Since all callsites only utilize btrfs_folio_set_writer_lock() now,
>>    remove the unnecessary btrfs_folio_start_writer_lock().
>>
>> Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage =
locking")
>
> This commit is in 5.14, so we'd need backport to 5.15+. The v1 would be
> more suitable as it does not remove the unused
> btrfs_folio_start_writer_lock(). As it's exported function there should
> be no warning.
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Remove the unused btrfs_folio_start_writer_lock() function
>> ---
>>   fs/btrfs/extent_io.c | 15 +++++++-------
>>   fs/btrfs/subpage.c   | 47 -------------------------------------------=
-
>>   fs/btrfs/subpage.h   |  2 --
>>   3 files changed, 7 insertions(+), 57 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index e0b43640849e..0448cee2b983 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -262,22 +262,21 @@ static noinline int lock_delalloc_folios(struct i=
node *inode,
>>
>>   		for (i =3D 0; i < found_folios; i++) {
>>   			struct folio *folio =3D fbatch.folios[i];
>> -			u32 len =3D end + 1 - start;
>> +			u64 range_start =3D max_t(u64, folio_pos(folio), start);
>> +			u32 range_len =3D min_t(u64, folio_pos(folio) + folio_size(folio),
>> +					      end + 1) - range_start;
>>
>>   			if (folio =3D=3D locked_folio)
>>   				continue;
>>
>> -			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
>> -							  len))
>> -				goto out;
>> -
>> +			folio_lock(folio);
>>   			if (!folio_test_dirty(folio) || folio->mapping !=3D mapping) {
>
> Should the range_start and range_end be set after folio_lock? One of the
> prolblems you're fixing is the folio and mapping mismatch, if I read it
> correctly.
>
Nice catch, indeed that's the problem.

Will fix it and split out the cleanup in the next version.

Thanks,
Qu

