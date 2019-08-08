Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6986BB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbfHHUk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 16:40:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37551 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHUk6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 16:40:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id b3so3806631wro.4
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13jQWTVffZ5yhYIDEGnbHiu50uG7FbNALo45S86/kkA=;
        b=NfMJ/jVks/t9aZEfKcG4FTqISIvUH1lmMXPERMSZlVOIAvYbR13RcgNkz2b534O+I6
         p2biSNcKX1U9gymBEd0+7WlE7Mn9MSchL2xgHlQC1LvxP3kO4yNCApexaDgARUjCfH7M
         JepTG9gMx8uvUy1i8qea7qbYrnecSjb5odK+jJ6Ye2ChP5s1NvpkwMLz4VnM/zWhEYlf
         CG98ug44NaSCzBUYIMe7gknspTtcnZ1B4nrdIywkORZYmtEaDiqdzLcITZ9YGXojar6u
         GOW8Qn9C8eSOjHabRoOchcaYFbfu9ldgi/nhZon+Nk2t3SRFif6Zjs/oaqoMsH07DRVa
         yhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=13jQWTVffZ5yhYIDEGnbHiu50uG7FbNALo45S86/kkA=;
        b=R8g/0NMOvrRSUBIkE1ncEQhK/2fS7ScUapSjBPnJuzyt8ylfLMySWU4OJiuSkVwLrb
         IHm17dbGiiI0rUOHaryr7pEdcUVFrTwr5Om9AniMgb7Uca/OcBA1ey0mYcI3EorkM6QI
         lD9Bm6x6ZMe1sWqW1F2QSqMGNb+cCCHMvVy3CIA1JrIHbEkHIuWwEAuo9vgGhFbkUlND
         d+wh2X+xAc/h5pZAVLugRzlQjgL6um9msJel9lijT6+KU0mXgaKME4RgjYsxBxAujHB+
         XSoKmR047w5sPAjzofpJ4B7DfUuBsWnU/g00mnTw4ApzEegb+PAmrvOjFkwGKDCVfJnC
         l2jg==
X-Gm-Message-State: APjAAAXcgkLb4gcGUfb+3MidcDHleQgFV4oqcWXoIJxyC4R5gHFsmQB5
        LmdcACNQakX3LrrpnpGymK73AKfoE/Q=
X-Google-Smtp-Source: APXvYqw00APg67s2gIFclR+9OV4n2nzCNy09X/ihZtKeMzalI80VigiaHDlsiXttLXEXkUXqpB+EEA==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr17755463wrq.137.1565296855892;
        Thu, 08 Aug 2019 13:40:55 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id s25sm2339985wmc.21.2019.08.08.13.40.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 13:40:55 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
From:   Vladimir Panteleev <thecybershadow@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
 <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
 <811c2c41-e795-9562-0e8b-033b404bf43d@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thecybershadow@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFar2yQBCADWo1C5Ir1smytf7+vWGCEoZgb/4XKkxrp+GUO7eJO8iYCWHTmCPZpi6p/z
 y6eh+NYcDQSRzKA99ffgdN+aT8/L6d63pYdsgtDmX/yrFWyLOVgW62LQpC/To4MTJAIgY/Rg
 /VjdifOJtYFvr+BKJwFCTfcviy4EQjsfHLnyJjvL9BiCXfSBXASc/Gn9WOTL5ZNpk4TStGXO
 +/2PIKeg228LtJ5vc/vemBo4hcjJv9ttX7dCebpSAbNo7GgOs8XNgJU2mEcra3IMT15dGk0/
 KpGMx7bMinTIlxx/BAGt5M5w8OnNi4p2AcKzvH18OTE7Lssn5ub8Ains32hbUFf18hJbABEB
 AAG0K1ZsYWRpbWlyIFBhbnRlbGVldiA8Z3BnQHRoZWN5YmVyc2hhZG93Lm5ldD6JAVEEEwEI
 ADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS77RsIjO1/lYkX++hQBPD60FFXbQUC
 WJ9eKQIZAQAKCRBQBPD60FFXbX0yB/9PEcY3H9mEZtU1UVqxLzPMVXUX5Khk6RD3Jt8/V7aA
 vu8VO4qwmnhadRPHXxVwnnVotao9d5U1zHw0gDhvJWelGRm52mKAPtyPwtBy4y3oXzymLfOM
 RIZxwxMY5RkbqdgWNEY7tCplABnWmaUMm5qDIjzkbEabpiqGySMy2gy6lQHUdRHcgFqO+ceZ
 R7IOPEh2fnVuQc5t1V56OHHRQZMQLgGupInST+svryv2sfr5+ZJqtwWL3nn8aFER6eIWzDDu
 m9y2RZnykbfwd56c81bpY6qqZtHkyt0hImkOwOiBj3UWtJvgZ95WnJ8NBPHPcttgL3vQTsXu
 BRYEjQZln81tuQENBFar2yQBCADFGh8NqHMtBT8F4m/UzQx0QAMDyPQN3CjKn67gW//8gd5v
 TmZCws2TwjaGlrJmwhGseUkZ368dth5vZLPu95MVSo2TBGf+XIVPsGzX6cuIRNtvQOT5YSUz
 uOghU0wh5gjw7evg7d0qfZRTZ2/JAuWmeTvPl66dasUoqKxVrq5o2MXdYkI6KoSxTsal3/36
 ii5cl2GfzE+bVAj3MB8B0ktdIZCHAJT8n+8h10/5TD5oEkWjhWdATeWMrC2bZwFykgSKjY/3
 jUvmfeyJp56sw5w3evZLQdQCo+NWoFGHdHBm0onyZbgbWS+2DEQI+ee0t6q6/iR1tf8VPX2U
 LY0jjiZ7ABEBAAGJAR8EGAEIAAkFAlar2yQCGwwACgkQUATw+tBRV200GQf8CaQxTy7OhWQ5
 O47G3+yKuBxDnYoP9h+T/sKcWsOUgy7i/vbqfkJvrqME8rRiO9YB/1/no1KqXm+gq0rSeZjy
 DA3mk9pNKvreHX9VO1md4r/vZF6jTwxNI7K97T34hZJGUQqsGzd8kMAvrgP199tXGG2+NOXv
 ih44I0of/VFFklNmO87y/Vn5F8OfNzwiHLNleBXZ1bMp/QBMd3HtahZVk7xRMNAKYqkyvI/C
 z0kgoHYP9wKpSmbPXJ5Qq0ndAJ7KIRcIwwDcbh3/F9Icj/N3v0SpxuJO7l0KlXQIWQ7TSpaO
 liYT2ARnGHHYcE2OhA0ixGV3Y3suUhk+GQaRQoiytw==
Message-ID: <9f0f001c-54a6-9db4-3f1d-668d90fde023@gmail.com>
Date:   Thu, 8 Aug 2019 20:40:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <811c2c41-e795-9562-0e8b-033b404bf43d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Did more digging today. Here is where the -ENOSPC is coming from:

btrfs_run_delayed_refs ->          // WARN here
__btrfs_run_delayed_refs ->
btrfs_run_delayed_refs_for_head ->
run_one_delayed_ref ->
run_delayed_data_ref ->
__btrfs_inc_extent_ref ->
insert_extent_backref ->
insert_extent_data_ref ->
btrfs_insert_empty_item ->
btrfs_insert_empty_items ->
btrfs_search_slot ->
split_leaf ->
alloc_tree_block_no_bg_flush ->
btrfs_alloc_tree_block ->
use_block_rsv ->
block_rsv_use_bytes / reserve_metadata_bytes

In use_block_rsv, first block_rsv_use_bytes (with the 
BTRFS_BLOCK_RSV_DELREFS one) fails, then reserve_metadata_bytes fails, 
then block_rsv_use_bytes with global_rsv fails again.

My understanding of this in plain English is as follows: btrfs attempted 
to finalize a transaction and add the queued backreferences. When doing 
so, it ran out of space in a B-tree, and attempted to allocate a new 
tree block; however, in doing so, it hit the limit it reserved for 
itself for how much space it was going to use during that operation, so 
it gave up on the whole thing, which led everything to go downhill from 
there. Is this anywhere close to being accurate?

BTW, the DELREFS rsv is 0 / 7GB reserved/free. So, it looks like it 
didn't expect to allocate the new tree node at all? Perhaps it should be 
using some other rsv for those?

Am I on the right track, or should I be discussing this elsewhere / with 
someone else?

On 20/07/2019 10.59, Vladimir Panteleev wrote:
> Hi,
> 
> I've done a few experiments and here are my findings.
> 
> First I probably should describe the filesystem: it is a snapshot 
> archive, containing a lot of snapshots for 4 subvolumes, totaling 2487 
> subvolumes/snapshots. There are also a few files (inside the snapshots) 
> that are probably very fragmented. This is probably what causes the bug.
> 
> Observations:
> 
> - If I delete all snapshots, the bug disappears (device delete succeeds).
> - If I delete all but any single subvolume's snapshots, the bug disappears.
> - If I delete one of two subvolumes' snapshots, the bug disappears, but 
> stays if I delete one of the other two subvolumes' snapshots.
> 
> It looks like two subvolumes' snapshots' data participates in causing 
> the bug.
> 
> In theory, I guess it would be possible to reduce the filesystem to the 
> minimal one causing the bug by iteratively deleting snapshots / files 
> and checking if the bug manifests, but it would be extremely 
> time-consuming, probably requiring weeks.
> 
> Anything else I can do to help diagnose / fix it? Or should I just order 
> more HDDs and clone the RAID10 the right way?
> 
> On 06/07/2019 05.51, Qu Wenruo wrote:
>>
>>
>> On 2019/7/6 下午1:13, Vladimir Panteleev wrote:
>> [...]
>>>> I'm not sure if it's the degraded mount cause the problem, as the
>>>> enospc_debug output looks like reserved/pinned/over-reserved space has
>>>> taken up all space, while no new chunk get allocated.
>>>
>>> The problem happens after replace-ing the missing device (which succeeds
>>> in full) and then attempting to remove it, i.e. without a degraded 
>>> mount.
>>>
>>>> Would you please try to balance metadata to see if the ENOSPC still
>>>> happens?
>>>
>>> The problem also manifests when attempting to rebalance the metadata.
>>
>> Have you tried to balance just one or two metadata block groups?
>> E.g using -mdevid or -mvrange?
>>
>> And did the problem always happen at the same block group?
>>
>> Thanks,
>> Qu
>>>
>>> Thanks!
>>>
>>
> 

-- 
Best regards,
  Vladimir
