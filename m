Return-Path: <linux-btrfs+bounces-5336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70408D2DB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F441C22AF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE24161307;
	Wed, 29 May 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdaFL/tM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7691DDC3
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965876; cv=none; b=kIrvp4vKjqM0e3TGMqkdOeevpWPLZpJGzGy4wQIKTj2BvN+ul/jBphTvRnsP+dCbgW979XHpewp/wayqhOASvTU416+yCnmisvNVW/UkjrjPg77WAcuwFzlPwjvE5TRy2pttpz6VHHnEU6RxkhRxLUVA95g0CBeYQaN1/WbyFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965876; c=relaxed/simple;
	bh=l/V05A/Kr9pMR3eklw9K8MKRqnjCwDmp2OTE5UqpVjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SymLWDacP95Z3tkPC2UUFEXfxyOcZswwc/OP4b34mOrDeK+Aq9RDgUQCvmeC2smVIqG4du1SppKCgu0Brwp4slJEavZZs1mmFx4aYVMhsBvKCvjFnVCLSLGu6pKYiH19dlC/EtC1RHy7RJjkeQSVNwutooyMIA2QEpfi7U0ZBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdaFL/tM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716965873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X1jNL5AKCTqKVJJWMUcLi/+HsxHmghC2E1+CScAu2FQ=;
	b=MdaFL/tMe3OnpC8azQuftqv0/BBVMx4UOvkjcnwIgLH31T3SaIeJVSBPsbMOZe4nL4x0Kg
	IU5gGTRs2OUkNF6VSKSu0opQGymnnTclt2ACXz2BxOCXOV27Yka3Urz/Y6kKITAwjRjYsD
	Zc21FLpjpNL7cfNBSWN2cLV7U8BdnFw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-k_WfJDtvNJWdGxj5HPIKIw-1; Wed, 29 May 2024 02:57:52 -0400
X-MC-Unique: k_WfJDtvNJWdGxj5HPIKIw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4210d151c5bso12956965e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 23:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716965871; x=1717570671;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1jNL5AKCTqKVJJWMUcLi/+HsxHmghC2E1+CScAu2FQ=;
        b=KZprNmn1Q3zTqALituGBAENWvvhZNQ/LMeaHrzsQi4DoVOgxDWkKaWFyaGG4/xaGHe
         MN//eBkgdjaOsnpuqJXNx4P4lOCFRCrGBwN92Wm3cEloHWPfbUa1zWDtaSEqtQgoyIC5
         yixv5tkRXfaWvVnAstjJ792z9Ix7zReZJxbduvXnvBmbSKMbsnUtsneRJDnAGpkG0jb3
         bjgflOS0l8gLV9rHzqqCKkd//LbWvhd6uMXuZODinMMfDsnQhdMTuTLYO1BwWV6YYtsV
         DibvD7U4Chq1LzF7p8oGXczsuqVdZBXPrkf/mvgt1XsWKeNqrpPWFiq+xLYZ0Caz1JYu
         NRvg==
X-Forwarded-Encrypted: i=1; AJvYcCV6518s4EEkwci3sCiB5+Zgf4BnS2Cm33eM1Lbpkzj7RzpcqlkU6h8R1p7AIhgKVo4aiTcM4dgu8y0f+n9AbIxrGM8PxqBjd6FAqgQ=
X-Gm-Message-State: AOJu0YxX3VXWmuznQ3v/ySmJVwtKxbtSsW3s3q59iIx6k1n1sm7YXPXC
	AxKiOfvvLXTsNHWbNUHAPNj4XcMKFxTHwf7HDr0YzhJr7/CwwndxybFY7ABB0JvydipH3OgCFet
	K1VUleofET2WerDIT3N0nr61NxD52ePfNQzZnqUavm8FV/uLXu/JH183m3wyP
X-Received: by 2002:a05:600c:198e:b0:420:fe60:c387 with SMTP id 5b1f17b1804b1-42108a12ab4mr117555445e9.38.1716965870815;
        Tue, 28 May 2024 23:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CejlWqPuXFqZN2EXRjw1Ccc4Nzq8rTsvDWbC57PrZ0GsEmBQvVcERgWRL1Bwkx7iEvBtug==
X-Received: by 2002:a05:600c:198e:b0:420:fe60:c387 with SMTP id 5b1f17b1804b1-42108a12ab4mr117555135e9.38.1716965870249;
        Tue, 28 May 2024 23:57:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:3c00:686e:317c:3ed4:d7b8? (p200300cbc70c3c00686e317c3ed4d7b8.dip0.t-ipconnect.de. [2003:cb:c70c:3c00:686e:317c:3ed4:d7b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee7f1dsm201788225e9.7.2024.05.28.23.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 23:57:49 -0700 (PDT)
Message-ID: <ff29f723-32de-421b-a65e-7b7d2e03162d@redhat.com>
Date: Wed, 29 May 2024 08:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
From: David Hildenbrand <david@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
 <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
 <CABXGCsP46xvu3C3Ntd=k5ARrYScAea1gj+YmKYqO+Yj7u3xu1Q@mail.gmail.com>
 <CABXGCsP3Yf2g6e7pSi71pbKpm+r1LdGyF5V7KaXbQjNyR9C_Rw@mail.gmail.com>
 <162cb2a8-1b53-4e86-8d49-f4e09b3255a4@redhat.com>
 <209ff705-fe6e-4d6d-9d08-201afba7d74b@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <209ff705-fe6e-4d6d-9d08-201afba7d74b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.05.24 16:24, David Hildenbrand wrote:
> Am 28.05.24 um 15:57 schrieb David Hildenbrand:
>> Am 28.05.24 um 08:05 schrieb Mikhail Gavrilov:
>>> On Thu, May 23, 2024 at 12:05 PM Mikhail Gavrilov
>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>
>>>> On Thu, May 9, 2024 at 10:50 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> The only known workload that causes this is updating a large
>>>> container. Unfortunately, not every container update reproduces the
>>>> problem.
>>>
>>> Is it possible to add more debugging information to make it clearer
>>> what's going on?
>>
>> If we knew who originally allocated that problematic page, that might help.
>> Maybe page_owner could give some hints?
>>
>>>
>>> BUG: Bad page state in process kcompactd0  pfn:605811
>>> page: refcount:0 mapcount:0 mapping:0000000082d91e3e index:0x1045efc4f
>>> pfn:0x605811
>>> aops:btree_aops ino:1
>>> flags:
>>> 0x17ffffc600020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x1fffff)
>>> raw: 0017ffffc600020c dead000000000100 dead000000000122 ffff888159075220
>>> raw: 00000001045efc4f 0000000000000000 00000000ffffffff 0000000000000000
>>> page dumped because: non-NULL mapping
>>
>> Seems to be an order-0 page, otherwise we would have another "head: ..." report.
>>
>> It's not an anon/ksm/non-lru migration folio, because we clear the page->mapping
>> field for them manually on the page freeing path. Likely it's a pagecache folio.
>>
>> So one option is that something seems to not properly set folio->mapping to
>> NULL. But that problem would then also show up without page migration? Hmm.
>>
>>> Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
>>> BIOS 2611 04/07/2024
>>> Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x84/0xd0
>>>    bad_page.cold+0xbe/0xe0
>>>    ? __pfx_bad_page+0x10/0x10
>>>    ? page_bad_reason+0x9d/0x1f0
>>>    free_unref_page+0x838/0x10e0
>>>    __folio_put+0x1ba/0x2b0
>>>    ? __pfx___folio_put+0x10/0x10
>>>    ? __pfx___might_resched+0x10/0x10
>>
>> I suspect we come via
>>       migrate_pages_batch()->migrate_folio_unmap()->migrate_folio_done().
>>
>> Maybe this is the "Folio was freed from under us. So we are done." path
>> when "folio_ref_count(src) == 1".
>>
>> Alternatively, we might come via
>>       migrate_pages_batch()->migrate_folio_move()->migrate_folio_done().
>>
>> For ordinary migration, move_to_new_folio() will clear src->mapping if
>> the folio was migrated successfully. That's the very first thing that
>> migrate_folio_move() does, so I doubt that is the problem.
>>
>> So I suspect we are in the migrate_folio_unmap() path. But for
>> a !anon folio, who should be freeing the folio concurrently (and not clearing
>> folio->mapping?)? After all, we have to hold the folio lock while migrating.
>>
>> In khugepaged:collapse_file() we manually set folio->mapping = NULL, before
>> dropping the reference.
>>
>> Something to try might be (to see if the problem goes away).
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index dd04f578c19c..45e92e14c904 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1124,6 +1124,13 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>                   /* Folio was freed from under us. So we are done. */
>>                   folio_clear_active(src);
>>                   folio_clear_unevictable(src);
>> +               /*
>> +                * Anonymous and movable src->mapping will be cleared by
>> +                * free_pages_prepare so don't reset it here for keeping
>> +                * the type to work PageAnon, for example.
>> +                */
>> +               if (!folio_mapping_flags(src))
>> +                       src->mapping = NULL;
>>                   /* free_pages_prepare() will clear PG_isolated. */
>>                   list_del(&src->lru);
>>                   migrate_folio_done(src, reason);
>>
>> But it does feel weird: who freed the page concurrently and didn't clear
>> folio->mapping ...
>>
>> We don't hold the folio lock of src, though, but have the only reference. So
>> another possible thing might be folio refcount mis-counting: folio_ref_count()
>> == 1 but there are other references (e.g., from the pagecache).
> 
> Hmm, your original report mentions kswapd, so I'm getting the feeling someone
> does one folio_put() too much and we are freeing a pageache folio that is still
> in the pageache and, therefore, has folio->mapping set ... bisecting would
> really help.
> 

A little bird just told me that I missed an important piece in the dmesg 
output: "aops:btree_aops ino:1" from dump_mapping():

This is btrfs, i_ino is 1, and we don't have a dentry. Is that 
BTRFS_BTREE_INODE_OBJECTID?

Summarizing what we know so far:
(1) Freeing an order-0 btrfs folio where folio->mapping
     is still set
(2) Triggered by kswapd and kcompactd; not triggered by other means of
     page freeing so far

Possible theories:
(A) folio->mapping not cleared when freeing the folio. But shouldn't
     this also happen on other freeing paths? Or are we simply lucky to
     never trigger that for that folio?
(B) Messed-up refcounting: freeing a folio that is still in use (and
     therefore has folio-> mapping still set)

I was briefly wondering if large folio splitting could be involved.

CCing btrfs maintainers.

-- 
Cheers,

David / dhildenb


