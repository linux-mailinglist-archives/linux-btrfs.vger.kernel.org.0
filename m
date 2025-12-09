Return-Path: <linux-btrfs+bounces-19601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B953CAFEB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 928883018317
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F450321445;
	Tue,  9 Dec 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ6ucpj4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379C2FD7BE
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283233; cv=none; b=AkUwqWSPv3Luf8qr5atuTaFygSbRbL7AqyUf0t6wHie7DjcYXkTVfzMtcl2k6lws8/2wb7rUbKQzLYR4tyfDoD2htKAsSk5oY8T4NicdtCw2o9YwLGc0SKRET/7hONwxIAJT8lGpFCcRDyiG+OdTN/uvKJMYPQ/uik3knGxe/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283233; c=relaxed/simple;
	bh=dRH8ZVX3pu75gzVo1+CIDeUQodnh7DrDZp1dE/tY7TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzUGFn/K82S1m5WZPuc188V7hXEXdEAt7nCztPqeJyJKuQXkIJwNtaL4DLT1oF15w3+ljfJrerEjVWcwqvsBY3Cw2rKzwlxag8J2ATOz06rELWuHnyBxe40CnsULusoLFPt2OlRlAZBNi0gtyvlijHpescg8udo7Jjo5izyz1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ6ucpj4; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-bd5cf88d165so111862a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Dec 2025 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765283231; x=1765888031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98X8ApwLwiRgXv3fOOGd6MHdsir4ZUIVYN03JOnCxLM=;
        b=YZ6ucpj4gC6XSDReEYmV1oMCXv5UJjXt9uZgIC1mK3lXbCFy8CyI1WoGaE/M1zfWHk
         C7OkiWlU+/P0Ksai/vnZ+PxUeb7dMmrzUVPOFxSRPvIteGdu/gnljs4D0ljCpw7eVQT0
         sYK2UYVvok5w4faHJQtBX4ZcDUQtPBbpdJQSPEuUF0WZUvioSieT4CmjG5yIkWc4Ws+9
         lsmWIFoHqjDg5h/O0aMppdOPMCUIHQQmjbsoP89KXUUH0bljh2r83wRya8dDE+xSpSOj
         ceCdmoHEttIvWieL+9U8zb8MCQwA9hDq8ghBMHXfmGcJLY7b2Z/8k9xGDFsX6EPWVrm1
         hBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765283231; x=1765888031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98X8ApwLwiRgXv3fOOGd6MHdsir4ZUIVYN03JOnCxLM=;
        b=uqXMxpiE4FSR7TEVadngxlHu7zSf85eflhdyB0/4rBsq6Gr3LuKy6hi0xCXBDoKq6h
         JaO9eWA5x6tNELPULYzH9tCrLtfdXoM0t56WfJIJ/JhYEu4qIlCDZw0fa5XPo5wK01TW
         0PslLoxOiY2JKdrIWEBi/nn+P7/hOO/MdKCFItcSnMwh8iJ708qPX8meCcOC7vw520cD
         9ykU0gu6m9cUc+qwLZeB4hjhKA1oVWPME1AC9o0nPEKq7xXQqcWUTcxVDvZ+WRyy94wC
         dBCUFRJQ5BqnRQcCNYMMLLXaTtZQUXY8P0RmUgFvKPX/1g+iLddNWAg5U3JaOQK0MIpQ
         831Q==
X-Gm-Message-State: AOJu0Yw+QZBZ7Zmtf/w+Ir7seaZ84QlzsBUTaWcY/IplZ1CBcfQTFD0O
	yPAGgufUPm+9n9l6+uMVU2JbS03N5kqVV6FbZK59InvT2HdP2D8R6x0a
X-Gm-Gg: ASbGncvkwa0fTPNYWXkxwNV6svyTVOaa+U8s1tCdcXbU0zeFUAtMhxj5CioNVJc8HjJ
	9x4Hs15c54tiqGsgleUqbJd6LZYh5hc2rxOu3kWvNXcCbaOvrbDh7qaNvtmOEcK9A0i+SBn+exZ
	0VyTsGc2wPDFIN/5sSXgqxxVUeN6sNN0I9WjEsfoeMFFtqoUFf6K9I3WZup1gDntK3thFIySGyu
	2ytRpW5kDfYeAtP9hwoMfXDMWmdoXrHksyj70PxjHSCcBRFUakRbnBgzRCX4ADVRImEeEgdOUJ4
	BaOCmhwOBAMbF9wbYuuSkcDPg+72MGLqFMkJWtclM4be0etxoBRc0xrftcLcALFQ+y17CAqGIso
	DgEs/H1wH/AuZR8YVjryhjDA7gXOAcJZ4gNwL7I7BeJ5vJJgn0Yqs5SuiUHyl6N9IZyuUCxy3X2
	j6nEHRdi/WpUZeHH8+HV1SapkXE5VvlpOqVVADXCBJuv0qkZGc/Hg5kxs=
X-Google-Smtp-Source: AGHT+IGWKFxgcR1pU5nI0t0Ji8jDe7Rr96Yhpr+v80oOLp4OgIGGBc4ws0yPMYYsTwodM2icKMI21A==
X-Received: by 2002:a05:6a00:3c84:b0:7a2:861d:bfb with SMTP id d2e1a72fcca58-7e8c7096ba9mr7414757b3a.7.1765283231301;
        Tue, 09 Dec 2025 04:27:11 -0800 (PST)
Received: from [192.168.1.13] (tk2-102-53910.vs.sakura.ne.jp. [59.106.191.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e42d6e7a4csm15600304b3a.18.2025.12.09.04.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 04:27:10 -0800 (PST)
Message-ID: <e058b458-0c8a-47ae-9e45-88f2eaa8b821@gmail.com>
Date: Tue, 9 Dec 2025 20:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
 <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/12/9 20:05, Filipe Manana 写道:
> On Tue, Dec 9, 2025 at 3:38 AM Sun YangKai <sunk67188@gmail.com> wrote:
>>
>> There's a common parttern in callers of btrfs_prev_leaf:
>> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
>>
>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>> valid slot and cleanup its over complex logic.
>>
>> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
>> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
>> should insert the key.
> 
> Hell no! path->slots[0] can end up pointing to the original key, which is what
> should be the location for the computed previous key, and the
> comments there explain how that can happen.
> 
>> So just slots[0]-- is enough to get the previous
>> item.
> 
> All that logic in btrfs_prev_leaf() is necessary.
> 
> We release the path and then do a btrfs_search_slot() for the computed
> previous key, but after the release and before the search, the
> structure of the tree may have changed, keys moved between leaves, new
> keys added, previous keys removed, and so on.

Thanks for your reply. Here's my thoughts about this:

My assumption is that there's not a key between the computed previous key and
the original key. So...

1) When searching for the computed previous key, we may get ret==1 and
p->slots[0] points to the original key. In this case,

if (p->slots[0] == 0) // we're the lowest key in the tree.
	return 1;

p->slots[0]--; // move to the previous item.
return 0;

is exactly what we want if I understand it correctly. I don't understand why
it's a special case.

2) And if there's an item matches the computed previous key, we will get ret==0
from btrfs_search_slot() and we will early return after calling
btrfs_search_slot(). If there's no such an item, then we'll never get an item
whose key is lower than the key we give to btrfs_search_slot().
So the second comment block is also not a special case.

These two cases are not related with how the items moved, added or deleted
before we call btrfs_search_slot().

Please correct me if I got anything wrong.

Thanks.
> 
> I left all such cases commented in detail in btrfs_prev_leaf() for a reason...
> 
> Removing that logic is just wrong and there's no explanation here for it.
> 
> Thanks.
> 
> 
> 
>>
>> And then remove the related logic and cleanup the callers.
>>
>> ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]))
>> is enough to make sure that nritems != 0 and slots[0] points to a valid
>> btrfs_item.
>>
>> And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
>> error because btrfs_pref_leaf() should always
>>
>> 1. either find a non-empty leaf
>> 2. or return 1
>>
>> So we can use ASSERT here.
>>
>> No functional changes.
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>> ---
>>  fs/btrfs/ctree.c | 100 +++++++++--------------------------------------
>>  1 file changed, 19 insertions(+), 81 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index bb886f9508e2..07e6433cde61 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -2365,12 +2365,9 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
>>  static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>>  {
>>         struct btrfs_key key;
>> -       struct btrfs_key orig_key;
>> -       struct btrfs_disk_key found_key;
>>         int ret;
>>
>>         btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
>> -       orig_key = key;
>>
>>         if (key.offset > 0) {
>>                 key.offset--;
>> @@ -2390,48 +2387,12 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>>         if (ret <= 0)
>>                 return ret;
>>
>> -       /*
>> -        * Previous key not found. Even if we were at slot 0 of the leaf we had
>> -        * before releasing the path and calling btrfs_search_slot(), we now may
>> -        * be in a slot pointing to the same original key - this can happen if
>> -        * after we released the path, one of more items were moved from a
>> -        * sibling leaf into the front of the leaf we had due to an insertion
>> -        * (see push_leaf_right()).
>> -        * If we hit this case and our slot is > 0 and just decrement the slot
>> -        * so that the caller does not process the same key again, which may or
>> -        * may not break the caller, depending on its logic.
>> -        */
>> -       if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
>> -               btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
>> -               ret = btrfs_comp_keys(&found_key, &orig_key);
>> -               if (ret == 0) {
>> -                       if (path->slots[0] > 0) {
>> -                               path->slots[0]--;
>> -                               return 0;
>> -                       }
>> -                       /*
>> -                        * At slot 0, same key as before, it means orig_key is
>> -                        * the lowest, leftmost, key in the tree. We're done.
>> -                        */
>> -                       return 1;
>> -               }
>> -       }
>> +       /* There's no smaller keys in the whole tree. */
>> +       if (path->slots[0] == 0)
>> +               return 1;
>>
>> -       btrfs_item_key(path->nodes[0], &found_key, 0);
>> -       ret = btrfs_comp_keys(&found_key, &key);
>> -       /*
>> -        * We might have had an item with the previous key in the tree right
>> -        * before we released our path. And after we released our path, that
>> -        * item might have been pushed to the first slot (0) of the leaf we
>> -        * were holding due to a tree balance. Alternatively, an item with the
>> -        * previous key can exist as the only element of a leaf (big fat item).
>> -        * Therefore account for these 2 cases, so that our callers (like
>> -        * btrfs_previous_item) don't miss an existing item with a key matching
>> -        * the previous key we computed above.
>> -        */
>> -       if (ret <= 0)
>> -               return 0;
>> -       return 1;
>> +       path->slots[0]--;
>> +       return 0;
>>  }
>>
>>  /*
>> @@ -2461,19 +2422,10 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>>                 if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
>>                         return btrfs_next_leaf(root, p);
>>         } else {
>> -               if (p->slots[0] == 0) {
>> -                       ret = btrfs_prev_leaf(root, p);
>> -                       if (ret < 0)
>> -                               return ret;
>> -                       if (!ret) {
>> -                               if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
>> -                                       p->slots[0]--;
>> -                               return 0;
>> -                       }
>> -                       return 1;
>> -               } else {
>> -                       p->slots[0]--;
>> -               }
>> +               if (p->slots[0] == 0)
>> +                       return btrfs_prev_leaf(root, p);
>> +
>> +               p->slots[0]--;
>>         }
>>         return 0;
>>  }
>> @@ -4957,26 +4909,19 @@ int btrfs_previous_item(struct btrfs_root *root,
>>                         int type)
>>  {
>>         struct btrfs_key found_key;
>> -       struct extent_buffer *leaf;
>> -       u32 nritems;
>>         int ret;
>>
>>         while (1) {
>>                 if (path->slots[0] == 0) {
>>                         ret = btrfs_prev_leaf(root, path);
>> -                       if (ret != 0)
>> +                       if (ret)
>>                                 return ret;
>> -               } else {
>> -                       path->slots[0]--;
>> -               }
>> -               leaf = path->nodes[0];
>> -               nritems = btrfs_header_nritems(leaf);
>> -               if (nritems == 0)
>> -                       return 1;
>> -               if (path->slots[0] == nritems)
>> +               } else
>>                         path->slots[0]--;
>>
>> -               btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +               ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
>> +
>> +               btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>>                 if (found_key.objectid < min_objectid)
>>                         break;
>>                 if (found_key.type == type)
>> @@ -4998,26 +4943,19 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
>>                         struct btrfs_path *path, u64 min_objectid)
>>  {
>>         struct btrfs_key found_key;
>> -       struct extent_buffer *leaf;
>> -       u32 nritems;
>>         int ret;
>>
>>         while (1) {
>>                 if (path->slots[0] == 0) {
>>                         ret = btrfs_prev_leaf(root, path);
>> -                       if (ret != 0)
>> +                       if (ret)
>>                                 return ret;
>> -               } else {
>> -                       path->slots[0]--;
>> -               }
>> -               leaf = path->nodes[0];
>> -               nritems = btrfs_header_nritems(leaf);
>> -               if (nritems == 0)
>> -                       return 1;
>> -               if (path->slots[0] == nritems)
>> +               } else
>>                         path->slots[0]--;
>>
>> -               btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +               ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
>> +
>> +               btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>>                 if (found_key.objectid < min_objectid)
>>                         break;
>>                 if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
>> --
>> 2.51.2
>>
>>


