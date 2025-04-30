Return-Path: <linux-btrfs+bounces-13568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51BAA567B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3DD9E2C94
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A6296D2E;
	Wed, 30 Apr 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Git5eqQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB311CAA62
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047311; cv=none; b=cja6ZGcIFY3rBZdu5zCMEhoWm+CMIbPaJa3K4FtXeT/pQhRbxnUsttYvp6T6bQ9PamdCNyACKkQggyt+0BeeTX2ntjsozscyNzVCksf/C1P761vJWAy2IQh7+E50WtAJ/ZIN0lGkRptTJvSP4uToEW00w4hnH2pYAS/MtUNioaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047311; c=relaxed/simple;
	bh=/n6J6p/kYlfXs9g3AL90pF00gHuw03vUedzRYFzCSMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVHOEZAthmIowOR1Wr2ZT2f4quD4is8pAlAUWpkohWSc3NW+nXGgIYahnAeit+gDBRn9I1gJGqAOBjxMqzT9/OJmN+kesAfGMGp/46QMUlBSK/qMgQA5Nrhk5RknU4WdLw17nzIRTr0qj0OOKxgrr3d+8+uId068VpXGms5F4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Git5eqQi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746047308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zf75Wi3ZWE/mWR/ajf5F8uvVnkwMZAW0yZvw06r6h3g=;
	b=Git5eqQi/z2cVb7YuyCqPCYjxN1Mg5tk1PHP6KnjjrFdcyaPGpk23j417SNxHgR2yfJ8Vz
	Et9OuUnWlIUOAAnlBpXZz1jEGFQ9CuhRdVA/ZsCdSzI7WcKGiQAKoMuiy2BNaiQwEP93wO
	rtjbAJxgIniVNSo7C6ChNEPUQ6VC8W8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Rus9JUNsNR-meQ50zlu4ng-1; Wed, 30 Apr 2025 17:08:27 -0400
X-MC-Unique: Rus9JUNsNR-meQ50zlu4ng-1
X-Mimecast-MFC-AGG-ID: Rus9JUNsNR-meQ50zlu4ng_1746047306
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39979ad285bso92149f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746047306; x=1746652106;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zf75Wi3ZWE/mWR/ajf5F8uvVnkwMZAW0yZvw06r6h3g=;
        b=aAS+LFh6cBGwOg8yZsxoFoqvh8KX6r5gngWHMbpGLS+syC6dnQxR2eAcvLJtL5DUwD
         dVGVWFnrkPUUbBI1i32hCrnc3FUW+TdZmpb1IUs+foi9RKOf8/SCgIO8Fnii4pAlgdnn
         q4n86rglXdJH6g/852n/UPGJrHU8yKna36S4VW6A6sYWHbQYryNc7BSWgWEUIYqORvaT
         uJeNisYeJnFa4IRSHsjwbxJEBtDP4m2JARHJOUnFjORc0fiRoSgxq/Xfl8fSl7FcEbhV
         46ChxPkF3tDj+/npYhbxFzjs2YBf6wWvZz0dfhipv4R+z5WfvmlBhl7Y7+m4Tr3OjSwu
         kYCA==
X-Forwarded-Encrypted: i=1; AJvYcCXtNVZCiNlx7t9GfQ+7gz/2Uf2V/XKr2hEp/Maa40Ww09dyvSAT4XCOYd4tH/vDj7fkmOjwGNwmTfR7qA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzha5KdmQWxWdw5b7LThrVANadAS22Pm5zp/5tU+1ZOfdmLrVwe
	OdXs4vWfOXQ8y7WPU0lHB0tVKq1miTzPy0wTZdZ989HAfsdohwp02gwEWql+cWmGwzeypVK/ptg
	4DMm82pA0+b5itVnd20VM8z35hEBaFLjpm4S2zOfM+l4AhLxtURDJYAEB8diI
X-Gm-Gg: ASbGncujioSZNTe99+XRCOPOFh6sOU/wS2fuO793e+jVr4Ih8O+bkSIYtXMgAarZUqI
	8zszNWZWwdYJdpumfCn1n13Ub1RK10dbbwYU/jnkKNo/SIsHFd/V3EYkvNjVjVHXjcmIOS8fotP
	4oNNaGqPRLE+avAHnq9RpNUFh12WWGqoZhVAUoCAbhpkFlMecgVVCBh50gQlu71YoxPRoGbIEeP
	t8IXTztQzw/ewmmUJZPDrIP2TFdSygSa27wJcDc9qDGwhKfs/UCbn6QGByoTtNRIGSU0thT3lLF
	gydMbEnKtOJcG9AVHdi8p3g9GpDkhoNfAat29NrkZTKIPtzpBXA7v/5wf3L5/4jCngW58CfOaSu
	iZGZASMSL1vicEgOzCukewyv5Eg+fYSypprDoPmk=
X-Received: by 2002:a05:6000:2af:b0:3a0:8af9:f379 with SMTP id ffacd0b85a97d-3a094003b02mr12351f8f.0.1746047305832;
        Wed, 30 Apr 2025 14:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEh2kIvvrmMWEfDRj9ATD8PLw6GQnjab2hqVipDv6tY3UvlIRVoqYxbhRVvgkhSMRGShw2KQ==
X-Received: by 2002:a05:6000:2af:b0:3a0:8af9:f379 with SMTP id ffacd0b85a97d-3a094003b02mr12334f8f.0.1746047305525;
        Wed, 30 Apr 2025 14:08:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9? (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de. [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a07a5ed2e0sm15523808f8f.39.2025.04.30.14.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:08:25 -0700 (PDT)
Message-ID: <97e55ba8-2627-47ec-9707-71b039b07d26@redhat.com>
Date: Wed, 30 Apr 2025 23:08:23 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] btrfs: drop usage of folio_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <20250430181052.55698-1-ryncsn@gmail.com>
 <20250430181052.55698-3-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250430181052.55698-3-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 20:10, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` but btrfs does not use that method for swap.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197f5e51c474..e08b50504d13 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3509,7 +3509,7 @@ static void btree_clear_folio_dirty_tag(struct folio *folio)
>   	xa_lock_irq(&folio->mapping->i_pages);
>   	if (!folio_test_dirty(folio))
>   		__xa_clear_mark(&folio->mapping->i_pages,
> -				folio_index(folio), PAGECACHE_TAG_DIRTY);
> +				folio->index, PAGECACHE_TAG_DIRTY);
>   	xa_unlock_irq(&folio->mapping->i_pages);
>   }
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


