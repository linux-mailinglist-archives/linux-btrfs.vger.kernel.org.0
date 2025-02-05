Return-Path: <linux-btrfs+bounces-11302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655FA29B90
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE99166E90
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7EA214A6B;
	Wed,  5 Feb 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PK/2Ov6T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B221DAC81
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789233; cv=none; b=Sn83Cn6RRL5zlXiIk0nDQukm6YH591uHutzghWWH1/WzZoLmHQ0az4GWL+l7OvC+kCocittqxHr0mp/4TKn18HGkDo3OKZH/LhJ3A9ADqgjlC59NxpNATSCp9oizARKK+rvO42kclV+Fq+Op315hjtHZMNlmfW9TKYw8sh9Am8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789233; c=relaxed/simple;
	bh=67kjp5zSNi03bREpIPKe0zbdnrzsT4hBDkE9OVJ+cc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5NtSDVUKIms9J8703Vx+E8tdM8I3LZgFtwTrb8rvetBrx8XeJ3JainRA5veRETE4sqQEGvXxxWXvK9VbbDplUTEojHNiEuSKTl5arZ2zg3KhzFYnBVZ78a19nlscpMG1+4oydXh4CDIkTF1zR3W0NrRmsH9RQpjISoDhrRih7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PK/2Ov6T; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38db0c06e96so119335f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738789229; x=1739394029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6RBXrEsC+iy5cf/12KrPllBO78Rv6/nCva0fGi12Vt8=;
        b=PK/2Ov6TpSXsaLZuJ5uj6aegSOt8Dv9xUsno/TjIGxAh93Ss5paLxTJyzjjeNoFYyN
         MXdXDv5fuCvYavpBHOHt4LwQNbbfCJJg+Ulr0Qq973DpbT9umUMOBneSGp9pZg3eClLS
         XPzwNJKUU9jAQVQrXv6EICIT8EKfzqSqbwsBmcty5R9jRIkEe679bjkweBhqgHoy9+uw
         pKNLCF0yKb3naF1f29lvLe5IK033bQDdJoFPaBDuVilUbpl0U50Lz1au0zZHON1r9+a8
         vrG/Wt5z9vWkhM49prd/0vYOVikMA8tFlcfa1qAOV8qVltjJVKGFfQI33hazzshUa6qs
         Mt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789229; x=1739394029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RBXrEsC+iy5cf/12KrPllBO78Rv6/nCva0fGi12Vt8=;
        b=CUoSwZ7fT8lbLoPvKd0+UOUfHVYeggpDqOkeWzLiipF0EZrfjZmet+jt+sudrZ1o6y
         AhIkKXHqy00x6Q5LMXvAcE4qYQspd42WJDPljUrskMPhaasKatVKEGn3UOAXfhtuzwZG
         LZL8ipNEGXKm4EIjwo2YbE0WvgD5u9SgRNprEU30XDUCJlP7LlfaKxnVWNs519f7ZZ2h
         4KPsg+Bxldh7izWKz6VFJXZwShsGsF18spmpWMXIUcFdt+VXIZR2EiOp+/R5NRVc3y9u
         hmdewMxmvO6jmfGzJPWbzpw8HAnzAtYHoKMqAy/b61w0eJvumEEVAKb2ef+aM0zyxErd
         p4JA==
X-Gm-Message-State: AOJu0YzhBdc3knDhuOkdbQfLS0WFnomVjUxJ1Vg1kmf5TgJ9qMcZRidS
	NZUzYHkzfmaDWNec5EeeSshYOt20tqkvcLMj5J/f1R0I5eZtLCTpdh3C2OSZJhA=
X-Gm-Gg: ASbGncvkUzBDoNqAqtKoyJja5S0m+GbeUo7LsbVMTsGX9SctLipjrSOqqGem55U4ksx
	OBExxWdJoeE1NkKLYVwuvXrF3f7RWvR/+JKx8mPFr0Kfr2Yyokqj2y/iCV+3ndf3fZDbClhNKQL
	0sMZdQz1jMIJn/zFX6Xybl4XIWr2DpJCw/2Ztiyar1uSSfEYcWvtf0ffEXxJ4HcdtzoFEFHs7e7
	hZ7l8/Oa7I1P4VNKrBv6MjeV/mikLqNFdfGIOtyzpgv+42D9dxGhCu2FQvyIz8lh49F+DjBftDV
	LigG9F8nWth6aiVQI9M1EBX8Wdeb3F6S0rT2doG6+zU=
X-Google-Smtp-Source: AGHT+IF2hAcDfiUHKy+mOdHenNsbiB/dvttWOu9dcmsSEEyVeH/rS5pPWUVjJPGqtsXoXnkao6OOQw==
X-Received: by 2002:a05:6000:186e:b0:38d:b113:e9b with SMTP id ffacd0b85a97d-38db4869560mr2941692f8f.17.1738789228550;
        Wed, 05 Feb 2025 13:00:28 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32edd7esm118695575ad.144.2025.02.05.13.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 13:00:27 -0800 (PST)
Message-ID: <59798af3-1567-4cf0-b881-d8983477548b@suse.com>
Date: Thu, 6 Feb 2025 07:30:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
 <CAL3q7H7eJG2pRDQnvsfob7ifOiHSU_W0QNfzXyO=V99c5ugXQQ@mail.gmail.com>
 <CAL3q7H6oAtVcNpMkHKY3+4kH3GjHyxz9UxqWFHcwEoXMmzOajQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6oAtVcNpMkHKY3+4kH3GjHyxz9UxqWFHcwEoXMmzOajQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/6 05:42, Filipe Manana 写道:
> On Tue, Feb 4, 2025 at 11:19 AM Filipe Manana <fdmanana@kernel.org> wrote:
>>
>> On Tue, Feb 4, 2025 at 3:31 AM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> [BUG]
>>> It is a long known bug that VM image on btrfs can lead to data csum
>>> mismatch, if the qemu is using direct-io for the image (this is commonly
>>> known as cache mode none).
>>>
>>> [CAUSE]
>>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>>> fs is allowed to dirty/modify the folio even the folio is under
>>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>>> flag inherited from the block device).
>>>
>>> This is a valid optimization to improve the concurrency, and since these
>>> filesystems have no extra checksum on data, the content change is not a
>>> problem at all.
>>>
>>> But the final write into the image file is handled by btrfs, which need
>>> the content not to be modified during writeback, or the checksum will
>>> not match the data (checksum is calculated before submitting the bio).
>>>
>>> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
>>> but btrfs requires no modification, this leads to the false csum
>>> mismatch.
>>>
>>> This is only a controlled example, there are even cases where
>>> multi-thread programs can submit a direct IO write, then another thread
>>> modifies the direct IO buffer for whatever reason.
>>>
>>> For such cases, btrfs has no sane way to detect such cases and leads to
>>> false data csum mismatch.
>>>
>>> [FIX]
>>> I have considered the following ideas to solve the problem:
>>>
>>> - Make direct IO to always skip data checksum
>>>    This not only requires a new incompatible flag, as it breaks the
>>>    current per-inode NODATASUM flag.
>>>    But also requires extra handling for no csum found cases.
>>>
>>>    And this also reduces our checksum protection.
>>>
>>> - Let hardware to handle all the checksum
>>>    AKA, just nodatasum mount option.
>>>    That requires trust for hardware (which is not that trustful in a lot
>>>    of cases), and it's not generic at all.
>>>
>>> - Always fallback to buffered write if the inode requires checksum
>>>    This is suggested by Christoph, and is the solution utilized by this
>>>    patch.
>>>
>>>    The cost is obvious, the extra buffer copying into page cache, thus it
>>>    reduce the performance.
>>>    But at least it's still user configurable, if the end user still wants
>>>    the zero-copy performance, just set NODATASUM flag for the inode
>>>    (which is a common practice for VM images on btrfs).
>>>
>>>    Since we can not trust user space programs to keep the buffer
>>>    consistent during direct IO, we have no choice but always falling
>>>    back to buffered IO.
>>>    At least by this, we avoid the more deadly false data checksum
>>>    mismatch error.
>>>
>>> Suggested-by: hch@infradead.org <hch@infradead.org>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Move the checksum check just after check_direct_IO()
>>>    So that we don't need the extra ENOTBLK error code trick to fallback
>>>    to buffered IO.
>>>
>>> - Slightly improve the comment
>>>    Adds that only direct write is affected, and why buffered write is
>>>    fine.
>>> ---
>>>   fs/btrfs/direct-io.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>>> index c99ceabcd792..0de4397130be 100644
>>> --- a/fs/btrfs/direct-io.c
>>> +++ b/fs/btrfs/direct-io.c
>>> @@ -855,6 +855,21 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>>>                  btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
>>>                  goto buffered;
>>>          }
>>> +       /*
>>> +        * For direct IO write, we have no control on the folios passed in,
>>> +        * thus the content can change halfway after we calculated the data
>>> +        * checksum, and result data checksum mismatch and unable to read
>>> +        * the data out anymore.
>>
>> I would phrase this differently to be more clear:
>>
>> We can't control the folios being passed in, applications can write to
>> them while a
>> direct IO write is in progress. This means the content might change
>> after we calculate the data
>> checksum. Therefore we can end up storing a checksum that doesn't
>> match the persisted data.
>>
>> Otherwise it looks fine to me:
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Btw, did you actually run fstests with this?
> 
> At least one test is failing after this change:
> 
> btrfs/226 2s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad)
>      --- tests/btrfs/226.out 2024-05-20 11:27:55.933394605 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad
> 2025-02-05 19:09:33.990188790 +0000
>      @@ -39,14 +39,11 @@
>       Testing write against prealloc extent at eof
>       wrote 65536/65536 bytes at offset 0
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      -wrote 65536/65536 bytes at offset 65536
>      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      +pwrite: Resource temporarily unavailable

That's caused by NOWAIT flag, we rejects NOWAIT direct-io if it falls 
back to buffered one.

This should be fixed through the test case.

Or do you mean that NOWAIT direct-IO is pretty common and this change is 
going to break a lot of user space tools?

Thanks,
Qu

>       File after write:
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/226.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/226.out.bad'  to see
> the entire diff)
> 
> 
> 
>>
>> Thanks.
>>
>>> +        *
>>> +        * To be extra safe and avoid false data checksum mismatch, if the
>>> +        * inode requires data checksum, just fallback to buffered IO.
>>> +        * For buffered IO we have full control of page cache and can ensure
>>> +        * no one is modifying the content during writeback.
>>> +        */
>>> +       if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>>> +               btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
>>> +               goto buffered;
>>> +       }
>>>
>>>          /*
>>>           * The iov_iter can be mapped to the same file range we are writing to.
>>> --
>>> 2.48.1
>>>
>>>


