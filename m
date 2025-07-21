Return-Path: <linux-btrfs+bounces-15616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31EB0CD68
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 01:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2855F546033
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 23:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01539245000;
	Mon, 21 Jul 2025 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C24SWwzp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75049224227
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753138791; cv=none; b=HJn0UJJAMbfh2MEWk4VWdNcqtCyOOdW+e/elannBK/g6lHPadkqEMgRFBUT6DlzU0Hgko+uN6c3CqB8/s2aM6fNRofhcKVc89wjBcf1DsU4/HoWcXT9rGaNOwD4ujlW5Og+Xo04xnmIbjuhLNiplI9RutvrwZ620nCRE1++I1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753138791; c=relaxed/simple;
	bh=pgHUWwCgjePkVQA7L9yLFM1ny2ZRidr7RBqRw1q5D1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HARpqfNtOXiGPEEKFkpGEM1Gnm8Xa2DE6OTtf6KZ6AFOKEPL9Ir0r1zoyTIU8iJxt8r9sDqQ+IExVUFvuI3OZwytUOrhQb/kyAg/wcO3oZUksOdI8tAebf1hdWOJqxMsiZvQvjDiaPkU183ETQK1zd+vPLesGZbxW0nhnSs1DXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C24SWwzp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2788158f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753138787; x=1753743587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=urVoydnbmtQnbBKfPBE7JxXo+3/UEj8DRykdiSmX/Mc=;
        b=C24SWwzpXXy8qhyIyhMz02gOtE7xSDP5vMIkpBUL7F3SMUzWVnt06Jvq5Oi6zRSnoF
         VzIQVlPVD09pGCZKTcMFiETeIdSrWRcdjwOLrOI328VjqKogkRgbUCUklOK49Z95db/w
         JBJdju2GVNIgdaVImfZDkPLLDSuIZMMf48lZpOm0oRLKlPbkSaJGsBRI8+0M6Jg0aGre
         3mDNxyCPV0IWaDvGIG5sh8J3neAjUi5xOKX7Z57cCcwaQMdNPWkZdGEYuiqQIxQ92bMN
         IjdeAMDPUufn9E/m+dEy1q4d3ZRC7WBum12kAjOrLijkNz++g4Jx3V6BYsNxlcLL5yip
         037g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138787; x=1753743587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urVoydnbmtQnbBKfPBE7JxXo+3/UEj8DRykdiSmX/Mc=;
        b=r//F6SfOCSg0ts1BDD40p55fnSLsq7khqw+RKpgos793lCmP3Il7qPNt2wznxl7Opz
         df85enQhs/aQN5VIPdfQrwqyx3ff6ilzS3foPfgj8VBG4nSubJIkF9Uz5xcTIT+dsstu
         HGS9wVthqQYtsBDudmqpXEaSCi7ukntYayexZPmQbYTeymFikNkegn3qqGx8ZN8vluTV
         4CVyXf5TtrVIYnWfcS9kPreFDZejERBemM980/bGsUXDUjxhHWDk5AUmO05jhah+waTO
         +3b6BLfJbZHaVUR0sT3vvtqf/aZXzoJ6k4qRYRNL26DWFytVxAHylbzwCTMCDq4dm4ag
         zmmw==
X-Gm-Message-State: AOJu0Yyeh60He5v+zH9Uo5GfBBt6Ogxets1OluIQjqt8Ex6yH3CLm8Tm
	hzPQ4Iad91ljAsBLvxM462/FUAegB+LnREiruOzHrlKAY3PTEEIHoRg1ZpEjP9tYwky1rprMD2D
	9Xndw
X-Gm-Gg: ASbGncuwy9+oAzlpyYRZgnwD+ic2qbipalW+2FSfVGeFvedVisf7U/cdZyOOcxG++vd
	0PtBGXnyL+6O4y7AErsw0rWB7+PpVrbpy5E1cIGZSiorrtWMQmFJXshDYjGLOUCmu63ucKCQqSx
	LTDRh7bBbozWP3cLiCbP3jvG4tsa0XWnarxaeJYaMP5hTwewOfpEl0npIG5IwK4QPgJTAJ/bS9D
	IJCmgweO47GP8qvJt2fxKFWY8Qsaz83HGldwr3W5b1wSTjkx+cSc3Jg7Z9B8Xr18aK3Ey2hJjMq
	rHq9QsB+8qe6N+QuTPhVOyhboFB8/VGObxuKvYqw1oHMs4RU7twTuvYhGM9HtPqIHAYaj3UE9Id
	tfyapX3yWgr9O16mQr3MBHncDtXn1gx7e1lHekfDdrWBij2lMeg==
X-Google-Smtp-Source: AGHT+IF1Oiby6ZO+fBaUvLyHt9yd3SgVwKfnlKZEcY4Ov26Wlp8fOYn+AviqZ9i9ElCQ3luhxiOSEw==
X-Received: by 2002:a05:6000:2f81:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3b61b217fe2mr10903269f8f.31.1753138786444;
        Mon, 21 Jul 2025 15:59:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef8e6sm63431725ad.212.2025.07.21.15.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:59:45 -0700 (PDT)
Message-ID: <8bb945f3-4c7f-4ea1-bde7-a0722e6f820f@suse.com>
Date: Tue, 22 Jul 2025 08:29:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: replace double boolean parameters of
 cow_file_range()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1752992367.git.wqu@suse.com>
 <3480a38763369c46ca8bbe79a8e4a5b87d20197a.1752992367.git.wqu@suse.com>
 <20250721202928.GB2071341@zen.localdomain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250721202928.GB2071341@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/22 05:59, Boris Burkov 写道:
> On Sun, Jul 20, 2025 at 03:59:09PM +0930, Qu Wenruo wrote:
>> The function cow_file_range() has two boolean parameters, which is never
>> a good thing for eyes.
>>
>> Replace it with a single @flags parameter, with two flags:
>>
>> - COW_FILE_RANGE_NO_INLINE
>> - COW_FILE_RANGE_KEEP_LOCKED
>>
>> And since we're here, also update the comments of cow_file_range() to
>> replace the old "page" usage with "folio".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Had a nit, but looks good overall. I think the flag approach is nice.
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>> ---
>>   fs/btrfs/inode.c | 32 +++++++++++++++++---------------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index b77dd22b8cdb..fc47e234b729 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -72,6 +72,9 @@
>>   #include "raid-stripe-tree.h"
>>   #include "fiemap.h"
>>   
>> +#define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
>> +#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
>> +
>>   struct btrfs_iget_args {
>>   	u64 ino;
>>   	struct btrfs_root *root;
>> @@ -1243,18 +1246,18 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>>    * locked_folio is the folio that writepage had locked already.  We use
>>    * it to make sure we don't do extra locks or unlocks.
>>    *
>> - * When this function fails, it unlocks all pages except @locked_folio.
>> + * When this function fails, it unlocks all folios except @locked_folio.
>>    *
>>    * When this function successfully creates an inline extent, it returns 1 and
>> - * unlocks all pages including locked_folio and starts I/O on them.
>> - * (In reality inline extents are limited to a single page, so locked_folio is
>> - * the only page handled anyway).
>> + * unlocks all folios including locked_folio and starts I/O on them.
>> + * (In reality inline extents are limited to a single block, so locked_folio is
>> + * the only folio handled anyway).
>>    *
>> - * When this function succeed and creates a normal extent, the page locking
>> + * When this function succeed and creates a normal extent, the folio locking
>>    * status depends on the passed in flags:
>>    *
>> - * - If @keep_locked is set, all pages are kept locked.
>> - * - Else all pages except for @locked_folio are unlocked.
>> + * - If COW_FILE_RANGE_KEEP_LOCKED flag is set, all folios are kept locked.
>> + * - Else all folios except for @locked_folio are unlocked.
>>    *
>>    * When a failure happens in the second or later iteration of the
>>    * while-loop, the ordered extents created in previous iterations are cleaned up.
>> @@ -1262,7 +1265,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>>   static noinline int cow_file_range(struct btrfs_inode *inode,
>>   				   struct folio *locked_folio, u64 start,
>>   				   u64 end, u64 *done_offset,
>> -				   bool keep_locked, bool no_inline)
>> +				   unsigned long flags)
>>   {
>>   	struct btrfs_root *root = inode->root;
>>   	struct btrfs_fs_info *fs_info = root->fs_info;
>> @@ -1290,7 +1293,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>>   
>>   	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>>   
>> -	if (!no_inline) {
>> +	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {
> 
> I get that you are keeping the existing semantics, but if you are
> bothering to refactor it, I think it would be nice to also get rid of
> the double negative here. COW_FILE_RANGE_ALLOW_INLINE or TRY_INLINE
> maybe?

I have considered this, but for the current 3 call sites, one doesn't 
want inline, two want inline, thus INLINE is the more common pattern.

Thus I kept the existing scheme, to keep the minority call sites to use 
extra flags.

Thanks,
Qu


