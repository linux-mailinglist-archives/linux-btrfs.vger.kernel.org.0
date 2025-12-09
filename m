Return-Path: <linux-btrfs+bounces-19603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59885CB01EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F55F3007E5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83E2820A0;
	Tue,  9 Dec 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq934qZG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC622A7E4
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288687; cv=none; b=XJo0raUFCU/S8Zx+f/4ZI4A/+jM7HK+f4GV10Tf6OwJgnB9QU3br5oIr51VwDpb9WRZB8hEDF4Re3isjugzAX9sh1Uy56idIpueQMARSW4hClPg201Xj0fc+Mszu10Ya2cLHnsy8LrtCLkpsde1IW2R39Y6mh8OINRfp7x/RVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288687; c=relaxed/simple;
	bh=y6R1RWUnC/TzKizWUJpgMbxhve0zaEBP8xrO1R2iUkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/z/nemtwORfaqwJV6g6B96gSCFzINw5wmhThua63Wv2KISElEJ53tVGNYioVE4RR5LBL7fpMzsds/Oslx4beO2Ny8Ti3XQ3SrpsHj9e1Pjq847c92M9BTdGTzVMDlihWQWiDO98TLgdYHDB0+TCbF78A4EY1lCDfyc5FIvk5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq934qZG; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-297f6ccc890so8853455ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Dec 2025 05:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765288685; x=1765893485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnVSqjpUkXuryAmGGdJWSvjkMW9l37ntqmfW0dZowtw=;
        b=Iq934qZGYumqUm6jTpVAfBI5rDLCOsHQTNiR8KBc3L+g+LPY8b17yxNF2ZDsMyQGYu
         dsnre9WMLWHkyJzGsx4zh55Eug4giAWuCTg/hIpzjI5Pu4Cr0j56Op6Zp4IAUjgRNa9g
         Dqc0061b5bZk4S/ZdFtWQ6pliJygGIC2Fn9k9c3WxZ1nDyr4KqI44YVQzAsBFrNdD4wC
         X5MIrsIUqaiJLbzrHm6lTKM6W9XmKPCyvF1vUVczOOGt22B2nrOqku5Yrx7PWsedFyYt
         tVvJliQbZKPfI/3KQuwmTxUvMU3BQg91qLr4m0ZYqYfUmYCKZ4Z5NgEFXa5uagN4u3dE
         X9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765288685; x=1765893485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnVSqjpUkXuryAmGGdJWSvjkMW9l37ntqmfW0dZowtw=;
        b=q+mEZPmKmJ88Nb88WHcF8rJ2bxjbmfwugKOuGNEgMjXjH/57AggkHzpTSPpQeIO+F+
         flv8iz1PGgh7IP1sRNMt2DlHUw5eKZICnaxtRF+OziaWEzieH4ZqG03nk76IEx1H47dH
         wTrY4hEXdyOMoan8rfrv43Pc76L0OhSTIvH+2o3nKTNh/DrA9vG51b+R2tMiNozZwIx2
         r/YW0i94UjmxfL9wz2H2Wek6K+twBnVBMJwJR8hhZ2Ppz1g1RxBVGd2tBTuLc1SFJlzt
         /GUOSggV3gceiyAc06HQMMQISue4neix6ucDKtEWqPH/MjLWF+mTsKjR/015kPNpfTK9
         LO9w==
X-Gm-Message-State: AOJu0YzEvCy8kwPl9tNURtJ0c5NlTL1uf8BI63o7wvt4TDgx9OwAOn8o
	3zt8A8abPDAR87N5VyPddeeONm9IPxpDWYLN+Bd787uk10xPflNdQKpasLMlG73Q6Bh1+Q==
X-Gm-Gg: AY/fxX6laNlmQOq9p06+hgafsj2bWhfYhzT2MMdtZfPn8JORTrZMIxkwceAzFSXdHtd
	kWr0ajitHcLwO6kyG9w6PDcpLvFnDE/ct2EoEmtYAskR64aA+M45w9JAiKghU562jxD0klieqds
	T9iNCbzIjBQtB/gBtJynTRXFV7zBlVopcJQUbAopP598ZyozeEVfHgOMV9JzLGPIYbAmflMdq8b
	3RbRdNjqZBZGf0apVysHOV0Iv4pE/4FVZShMAyFA4goPyTfS8tR9Rhg6rk7FVS9O2if+Psc+4k6
	tfkydtfRJlBmr7zyCllM7IdYgL3wvQes2KvMDHwbArWpIl8+fnElmQD9RJT5XG8+IUPosezEv6a
	zcfYuqAJZqeY9meO6lMx2CeSNDANagSnQ7+W068GYXsWKDPfLFQ+Fs/B8AFJvMEy+q8o26w+L62
	Fs2jKfWWUH/VsLgnFIm56EpGmW
X-Google-Smtp-Source: AGHT+IFWttDd5n6b13wFWaNn16fpVcf6lKayajHxZcIEY+MCdJsbafkfg5fbUmMX8W2wyVXoepT//g==
X-Received: by 2002:a17:903:1786:b0:295:a1a5:baf6 with SMTP id d9443c01a7336-29df5dae0b2mr73254635ad.6.1765288684617;
        Tue, 09 Dec 2025 05:58:04 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4d3a2dsm159401895ad.31.2025.12.09.05.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 05:58:04 -0800 (PST)
Message-ID: <ab342845-48b0-40d5-a26f-a49f81a6cf77@gmail.com>
Date: Tue, 9 Dec 2025 21:57:59 +0800
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
> 
> I left all such cases commented in detail in btrfs_prev_leaf() for a reason...
> 
> Removing that logic is just wrong and there's no explanation here for it.
> 
> Thanks.
> 

Oh, after go deeper into git history, I think I got your point.

I guess you mean:

1) check the key at p->slots[0] is lower than original key(or <= calculated
previous key) to make sure we're in a previous leaf;
2) before 1), we should check that if p is pointing to the original key, we
should `p->slots[0]--;` so we'll not return the original item.

I think now I totally get your point. And I still think my way is more simple
and clear because we don't bother comparing keys and only need to deal with two
different cases when we got ret==1 from btrfs_search_slot():

1) when p->slots[0] == 0, we're searching the lowest key in the whole tree. So
there's no prev leaf. Just return 1;
2) when p->slots[0] != 0, p is pointing to the original item, or other item if
the original one was removed. But this doesn't matter because after
p->slots[0]--, we'll get what we want: an item with a key lower than the
original one(of course also lower than the computed previous key). We get what
we want, return 0.

I hope I've make myself clear.

Thanks.
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


