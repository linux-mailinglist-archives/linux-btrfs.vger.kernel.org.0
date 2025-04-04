Return-Path: <linux-btrfs+bounces-12809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619A3A7C5C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCE188F3A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68E1A4E98;
	Fri,  4 Apr 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nn6ke+Wp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EF2E62A3
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803485; cv=none; b=Lrm4miS8hfRn1rCMhHTVXtjjIB7ouvuSZcn/baEWIh8lxOgT+yLdRfvnS4gIF1Qrttr07KB0DHFHL3o+ikq32IcGIjO4XCI3Kqs/JKgd36zQmfluM0rgcX/4t7IMWUKf8liWk4k6szbTeEBMTBa4Hh+Vtk7Dl7+dnRUn9caTuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803485; c=relaxed/simple;
	bh=HTI6LTib7AFiPV2d9kz5edwmk8rkY7W/4Eonqr3dup8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMsOX8SB4S9MC3EazvsLKr+0QNmjvv8o4U9sc8qX9IehR3mguEoJIIs9BJ3NqdXYPPdKtpt+M7rvoDH/7Zs8Gjgd8RXDLE9PGOkDIB/jaAAFybKZxPFGIURbkmV7cpUK5a8Le6WFgL5xF5QqMS5/LpqeNzJKfDPlryrRs2TA3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nn6ke+Wp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf848528aso19629695e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743803481; x=1744408281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OUoTYp5OKRMGChdKlkKcOWhf0w7hdOWIEyoFff+cBsk=;
        b=Nn6ke+WpF+ae+YO8shhliGxaIuYQ0Pe7xYZFT7SsnVqnwNpBYfKL8lIkNDtbxo8Syt
         8POupqJdInLV9P3mu6F9PXYN6p/q1tnX5mioWt+LCzSSialyaRC/IOUUlroZbX/SEB6Z
         R6AggNjO/iZ1mxVPszRB5jel5LTTCX30B7PB4u1Pu8kPjSyeMME4wTwi17rGnTUBtVoo
         0T5E4LiU0B41hRjC3YHBEROcAIlY1JDeF8OkfNBGw1JqLa35e5CGbO4IBIDno9AKK8eh
         iGBUWdcT3bH3/z8vOXZg9fVfF0t8sdtdbapwc1U+nH3hQCt3NUAWyCHELz4eX0wYUXyU
         bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743803481; x=1744408281;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUoTYp5OKRMGChdKlkKcOWhf0w7hdOWIEyoFff+cBsk=;
        b=CIpfDrDMVUeJiiXcg/pvePYfV0ZLTnSdf7lTn7izb6I/BjLDTZj2V7HBI+daeGYf+3
         uYaECg+2rFdZXmorWLlrRluQKIidMV/nrOCDFZVkW0GWNVdNwwYNsIhivp2/dLAIDGXz
         TF1SpBIrRaEJ6rQ7voAaNtczkKVikfc+0UkFmA5eFQLYiZhKC9eKqLliuw0QvMVsat/z
         mbb/DCn74m6AaDltWlNb26kuFwYNB8bpsMYcaSL2zUtC9GJG0KEJMDszgURq5flzCZfv
         nc56FF2f0sPpnSSDmfEufoZeYazkVFF1gPLxVH6o9JBIg7UJ9N5SkRECLKJqMdfzeGBA
         IEZQ==
X-Gm-Message-State: AOJu0YyPFrjj8NfTuMKTt2OlvOluTiw8kA2+4hOs/cV0IdLscXCfmEvb
	GE/utdWiYl5+FpGilaLGnQ/FR6I8uFxcFT47fQlbcpRfM6FywZrMlUe8zlWrynD8ixa43wySlgB
	d
X-Gm-Gg: ASbGncsBnPIXGrq89feddnOrDptrIXa31Dwyo4j5YqWUFw+x/iKcxCvN6T9HqfZpC3s
	bO/mWqEkL+04OI0C8NTN1z8IbzeiAnmqUYcT7Mh1e/i3KAu8Kq4vb9ioQVgEyGtF07V014ACm7k
	VTrSqIkrR3l2/irJqQkMwKRO076t6rXmd8DIhaUBy4SjnPZhFDuvQirC0XoouyojRSEtV4xjZu/
	xXPFMSWYQpSdMAD22K+ll3wdPvEt08x+r/b2+kyfBlisy21d94095paEP5DFVfBVQ5Pv2/2OgYI
	3q3PCqj0RCKyaXCnSNLpq7zR0GVaQUi+RRYoHv2Dq8jdmGqJbO02xY69NMnASNbPp/MjY5vy
X-Google-Smtp-Source: AGHT+IGmOhYyasOI5O1+J/XrQSeYghjnzcDWZv+1Of6+UnQw4eBHo3cPSjl4PnxKEwZFSVF1gsommA==
X-Received: by 2002:a05:6000:2909:b0:39a:c80b:8283 with SMTP id ffacd0b85a97d-39d6fc7c97emr587161f8f.31.1743803480558;
        Fri, 04 Apr 2025 14:51:20 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee5bdsm3931444b3a.49.2025.04.04.14.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:51:20 -0700 (PDT)
Message-ID: <caa57242-1971-46f9-a2f9-dceb19ab7b4f@suse.com>
Date: Sat, 5 Apr 2025 08:21:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: get rid of filemap_get_folios_contig() calls
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
 <CAL3q7H4AZZtCe6FXwAwaoKL7JNtnoLfu3BimKQ1KRZUNuezkwQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4AZZtCe6FXwAwaoKL7JNtnoLfu3BimKQ1KRZUNuezkwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/5 03:08, Filipe Manana 写道:
> On Fri, Apr 4, 2025 at 2:48 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> With large folios, filemap_get_folios_contig() can return duplicated
>> folios, for example:
>>
>>          704K                     768K                             1M
>>          |<-- 64K sized folio --->|<------- 256K sized folio ----->|
>>                                |          |
>>                                764K       800K
>>
>> If we call lock_delalloc_folios() with range [762K, 800K) on above
>> layout with locked folio at 704K, we will hit the following sequence:
>>
>> 1. filemap_get_folios_contig() returned 1 for range [764K, 768K)
>>     As this is a folio boundary.
>>
>>     The returned folio will be folio at 704K.
>>
>>     Since the folio is already locked, we will not lock the folio.
>>
>> 2. filemap_get_folios_contig() returned 8 for range [768K, 800K)
>>     All the entries are the same folio at 768K.
>>
>> 3. We lock folio 768K for the slot 0 of the fbatch
>>
>> 4. We lock folio 768K for the slot 1 of the fbatch
>>     We deadlock, as we have already locked the same folio at step 3.
>>
>> The filemap_get_folios_contig() behavior is definitely not ideal, but on
>> the other hand, we do not really need the filemap_get_folios_contig()
>> call either.
>>
>> The current filemap_get_folios() is already good enough, and we require
>> no strong contiguous requirement either, we only need the returned folios
>> contiguous at file map level (aka, their folio file offsets are contiguous).
> 
> This paragraph is confusing.
> This says filemap_get_folios() provides contiguous results in the
> sense that the file offset of each folio is greater than the previous
> ones (the folios in the batch are ordered by file offsets).
> But then what is the kind of contiguous results that
> filemap_get_folios_contig() provides? How different is it? Is it that
> the batch doesn't get "holes" - i.e. a folio's start always matches
> the end of the previous one +1?

 From my understanding, filemap_get_folios_contig() returns physically 
contiguous pages/folios.

And the hole handling is always the caller's responsibility, no matter 
if it's the _contig() version or not.

Thus for filemap_get_folios_contig(), and the above two large folios 
cases, as long as the two large folios are not physically contiguous, 
the call returns the first folio, then the next call it returns the next 
folio.

Not returning both in one go, and this behavior is not that useful to us 
either.


And talking about holes, due to the _contig() behavior itself, if we hit 
a hole the function will definitely return, but between different calls 
caller should check the folio's position between calls, to make sure no 
holes is between two filemap_get_folios_contig() calls.

Of course, no caller is really doing that, thus another reason why we do 
not need the filemap_get_folios_contig() call.

Thanks,
Qu>
>>
>> So get rid of the cursed filemap_get_folios_contig() and use regular
>> filemap_get_folios() instead, this will fix the above deadlock for large
>> folios.
> 
> I think it's worth adding in this changelog that it is known that
> filemap_get_folios_contig() has a bug and there's a pending fix for
> it, adding links to the thread you started and the respective fix:
> 
> https://lore.kernel.org/linux-btrfs/b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com/
> https://lore.kernel.org/linux-btrfs/Z-8s1-kiIDkzgRbc@fedora/
> 
> Anyway, it seems good, so with those small changes:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c             | 6 ++----
>>   fs/btrfs/tests/extent-io-tests.c | 3 +--
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index f0d51f6ed951..986bda2eff1c 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -207,8 +207,7 @@ static void __process_folios_contig(struct address_space *mapping,
>>          while (index <= end_index) {
>>                  int found_folios;
>>
>> -               found_folios = filemap_get_folios_contig(mapping, &index,
>> -                               end_index, &fbatch);
>> +               found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
>>                  for (i = 0; i < found_folios; i++) {
>>                          struct folio *folio = fbatch.folios[i];
>>
>> @@ -245,8 +244,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
>>          while (index <= end_index) {
>>                  unsigned int found_folios, i;
>>
>> -               found_folios = filemap_get_folios_contig(mapping, &index,
>> -                               end_index, &fbatch);
>> +               found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
>>                  if (found_folios == 0)
>>                          goto out;
>>
>> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
>> index 74aca7180a5a..e762eca8a99f 100644
>> --- a/fs/btrfs/tests/extent-io-tests.c
>> +++ b/fs/btrfs/tests/extent-io-tests.c
>> @@ -32,8 +32,7 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
>>          folio_batch_init(&fbatch);
>>
>>          while (index <= end_index) {
>> -               ret = filemap_get_folios_contig(inode->i_mapping, &index,
>> -                               end_index, &fbatch);
>> +               ret = filemap_get_folios(inode->i_mapping, &index, end_index, &fbatch);
>>                  for (i = 0; i < ret; i++) {
>>                          struct folio *folio = fbatch.folios[i];
>>
>> --
>> 2.49.0
>>
>>


