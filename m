Return-Path: <linux-btrfs+bounces-4861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0B8C0CC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC32B22537
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50B149C65;
	Thu,  9 May 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VlWR18W7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC113C8E2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244171; cv=none; b=bmR/pyQ9KtKzKY4xCeokSh6Z+abBGwBm3DbsAudtFeqdC9dpmsDJH6g4teg5bUfQAfup7ZHu+HcxgyCfk+4NVn5Y9lwmtA5BForaGBVatuA5S4UtdFVaNCvsuhvtD5nvl9nIiUqy42ozvS6YjAFaFMnIK/lmXqljQ3LJkYSNZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244171; c=relaxed/simple;
	bh=DJi7X3cNdtC++SwT+BiIabbRvw1PrfZMAkFOa84BOD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RooZsvQWqkiK5L6OttB7ECh7ad1ocjYo4JslM0KDIAnkzQ1mGAHsUuwXBAaz+N9ub6yBj2fLE0hwrKJkJSzWmcTlzHW4EiCYC2LPOerIv50alBQKEGH8w6DyH0yfh5AH+Em4PY5Onx3itaSZL2mw/arBcP9o6rNvafQg1iKLOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VlWR18W7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so932773f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715244167; x=1715848967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xC0yd8mIzwdpy8hVP1DRoeQ57YKdb2Lc1kPVbuui+mQ=;
        b=VlWR18W7v08QFUcs8XtLQdeBX4NH4MMTQuUQcTiFvCG4ENvy4jY/tbAr8q9ykLh24N
         5KhI7AhUx0wzxuIhstJd3FV5WTMKgQj7KgXFHmeVXkPb8ZBG6XQ3LuQfHTjl3/y4rj4c
         IddjsKhVrQDHoWjzdcbYX+Pbaf51LdYPf94rBrxS5P8+WkHV7R9Pf1UgQtMRZslxmnqM
         VxyMKzpNiXqAmQLt4FkYsy8lWPtllX3qdKJeI7M6evt20keYVE/RG2Ie13ReLl2HUBHu
         gmH8k1tAUsAdwCpPWso08/zuAKXIlfbi1aetKrWY2mK5pyG7esZDo/gDZ6jxeJnCoEnV
         5/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715244167; x=1715848967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC0yd8mIzwdpy8hVP1DRoeQ57YKdb2Lc1kPVbuui+mQ=;
        b=Id5g8qUXHCcL2eILZTmrWAqEbI4A/gsH8mU+rKvpBL/vvvhNepAWnehkYbo9ANT5KO
         uPwHsSVnGs5xUNmoIAeXCN2albIAJijAN1c4IQIJS6xEb/033huzZbTw8yv9gcCbOW2K
         HaxmjvYpnk3kAPi+rGCSOQEAq22tRFXX0dhTFnv0qyuHBYjn1kzcvR0++qPR0mAIoWcl
         2OxFw2O+YYcXqg57etfQ3k88X1TI072ZDmkzE2VJ+hZTyuls7+GOfxXI7gAi9FKUbDvT
         PUcF4+gouTGUTs0SAp4e9OGRch96ObbX+N6upK0uCSMuPPfMP+4Pw2lfUsTmo+wQ2eh8
         yVAA==
X-Gm-Message-State: AOJu0YwyBbbYrtObz5wg03giPXO0dNQQc2/WaJnZvwxUGz+q8hDb4A0w
	2yFs2yLmASdXwsODwWPW4R8Dtg9TjMxPkJOOS0e4iOByw3GVUokw0AOQwgr3U/0=
X-Google-Smtp-Source: AGHT+IH6+j8vQOpi+y1O7Em2pQHWQLxRq9FKsOYd5bJMQhy1ZXDIi/Zqdhbx65EUhQd3ASxCT2Jv9g==
X-Received: by 2002:adf:a589:0:b0:34f:8f7c:8fe2 with SMTP id ffacd0b85a97d-350181144edmr1840136f8f.10.1715244167597;
        Thu, 09 May 2024 01:42:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2e69sm845833b3a.177.2024.05.09.01.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:42:47 -0700 (PDT)
Message-ID: <078144d9-775e-4125-9469-27ffb47fed1c@suse.com>
Date: Thu, 9 May 2024 18:12:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] btrfs: remove inode_lock from struct btrfs_root and
 use xarray locks
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <51066985ea4e9ea16388854a1d48ee197f07219f.1715169723.git.fdmanana@suse.com>
 <23310a98-c2dc-4a99-ac83-593da5e7d42f@gmx.com>
 <CAL3q7H7xFxOYZ_rQnb9_qOXuGXGMHOCso2m1p23xe4dGFfd74Q@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAL3q7H7xFxOYZ_rQnb9_qOXuGXGMHOCso2m1p23xe4dGFfd74Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/9 18:08, Filipe Manana 写道:
> On Thu, May 9, 2024 at 1:25 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/5/8 21:47, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Currently we use the spinlock inode_lock from struct btrfs_root to
>>> serialize access to two different data structures:
>>>
>>> 1) The delayed inodes xarray (struct btrfs_root::delayed_nodes);
>>> 2) The inodes xarray (struct btrfs_root::inodes).
>>>
>>> Instead of using our own lock, we can use the spinlock that is part of the
>>> xarray implementation, by using the xa_lock() and xa_unlock() APIs and
>>> using the xarray APIs with the double underscore prefix that don't take
>>> the xarray locks and assume the caller is using xa_lock() and xa_unlock().
>>>
>>> So remove the spinlock inode_lock from struct btrfs_root and use the
>>> corresponding xarray locks. This brings 2 benefits:
>>>
>>> 1) We reduce the size of struct btrfs_root, from 1336 bytes down to
>>>      1328 bytes on a 64 bits release kernel config;
>>>
>>> 2) We reduce lock contention by not using anymore  the same lock for
>>>      changing two different and unrelated xarrays.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/ctree.h         |  1 -
>>>    fs/btrfs/delayed-inode.c | 24 +++++++++++-------------
>>>    fs/btrfs/disk-io.c       |  1 -
>>>    fs/btrfs/inode.c         | 18 ++++++++----------
>>>    4 files changed, 19 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index aa2568f86dc9..1004cb934b4a 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -221,7 +221,6 @@ struct btrfs_root {
>>>
>>>        struct list_head root_list;
>>>
>>> -     spinlock_t inode_lock;
>>>        /*
>>>         * Xarray that keeps track of in-memory inodes, protected by the lock
>>>         * @inode_lock.
>>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>>> index 95a0497fa866..1373f474c9b6 100644
>>> --- a/fs/btrfs/delayed-inode.c
>>> +++ b/fs/btrfs/delayed-inode.c
>>> @@ -77,14 +77,14 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>>>                return node;
>>>        }
>>>
>>> -     spin_lock(&root->inode_lock);
>>> +     xa_lock(&root->delayed_nodes);
>>>        node = xa_load(&root->delayed_nodes, ino);
>>
>> Do we need xa_lock() here?
>>
>> The doc shows xa_load() use RCU read lock already.
>> Only xa_store()/xa_find() would take xa_lock internally, thus they need
>> to be converted.
>>
>> Or did I miss something else?
> 
> The RCU is only for protection against concurrent xarray operations
> that modify the xarray.
> After xa_load() returns, the "node" might have been removed from the
> xarray and freed by another task.
> 
> That's why this change is a straightforward switch from one lock to another.
> 
> It may be that our code is structured in a way that we can get away
> with the lock.
> But that needs to be properly analysed and given that it's a
> non-trivial behavioural change, should have its own separate patch and
> change log with the analysis.

OK, got it.

Then it looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Thanks.
> 
> 
>>
>> Thanks,
>> Qu
>>>
>>>        if (node) {
>>>                if (btrfs_inode->delayed_node) {
>>>                        refcount_inc(&node->refs);      /* can be accessed */
>>>                        BUG_ON(btrfs_inode->delayed_node != node);
>>> -                     spin_unlock(&root->inode_lock);
>>> +                     xa_unlock(&root->delayed_nodes);
>>>                        return node;
>>>                }
>>>
>>> @@ -111,10 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delayed_node(
>>>                        node = NULL;
>>>                }
>>>
>>> -             spin_unlock(&root->inode_lock);
>>> +             xa_unlock(&root->delayed_nodes);
>>>                return node;
>>>        }
>>> -     spin_unlock(&root->inode_lock);
>>> +     xa_unlock(&root->delayed_nodes);
>>>
>>>        return NULL;
>>>    }
>>> @@ -148,21 +148,21 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
>>>                kmem_cache_free(delayed_node_cache, node);
>>>                return ERR_PTR(-ENOMEM);
>>>        }
>>> -     spin_lock(&root->inode_lock);
>>> +     xa_lock(&root->delayed_nodes);
>>>        ptr = xa_load(&root->delayed_nodes, ino);
>>>        if (ptr) {
>>>                /* Somebody inserted it, go back and read it. */
>>> -             spin_unlock(&root->inode_lock);
>>> +             xa_unlock(&root->delayed_nodes);
>>>                kmem_cache_free(delayed_node_cache, node);
>>>                node = NULL;
>>>                goto again;
>>>        }
>>> -     ptr = xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
>>> +     ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
>>>        ASSERT(xa_err(ptr) != -EINVAL);
>>>        ASSERT(xa_err(ptr) != -ENOMEM);
>>>        ASSERT(ptr == NULL);
>>>        btrfs_inode->delayed_node = node;
>>> -     spin_unlock(&root->inode_lock);
>>> +     xa_unlock(&root->delayed_nodes);
>>>
>>>        return node;
>>>    }
>>> @@ -275,14 +275,12 @@ static void __btrfs_release_delayed_node(
>>>        if (refcount_dec_and_test(&delayed_node->refs)) {
>>>                struct btrfs_root *root = delayed_node->root;
>>>
>>> -             spin_lock(&root->inode_lock);
>>>                /*
>>>                 * Once our refcount goes to zero, nobody is allowed to bump it
>>>                 * back up.  We can delete it now.
>>>                 */
>>>                ASSERT(refcount_read(&delayed_node->refs) == 0);
>>>                xa_erase(&root->delayed_nodes, delayed_node->inode_id);
>>> -             spin_unlock(&root->inode_lock);
>>>                kmem_cache_free(delayed_node_cache, delayed_node);
>>>        }
>>>    }
>>> @@ -2057,9 +2055,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>>>                struct btrfs_delayed_node *node;
>>>                int count;
>>>
>>> -             spin_lock(&root->inode_lock);
>>> +             xa_lock(&root->delayed_nodes);
>>>                if (xa_empty(&root->delayed_nodes)) {
>>> -                     spin_unlock(&root->inode_lock);
>>> +                     xa_unlock(&root->delayed_nodes);
>>>                        return;
>>>                }
>>>
>>> @@ -2076,7 +2074,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>>>                        if (count >= ARRAY_SIZE(delayed_nodes))
>>>                                break;
>>>                }
>>> -             spin_unlock(&root->inode_lock);
>>> +             xa_unlock(&root->delayed_nodes);
>>>                index++;
>>>
>>>                for (int i = 0; i < count; i++) {
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index ed40fe1db53e..d20e400a9ce3 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -674,7 +674,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
>>>        INIT_LIST_HEAD(&root->ordered_extents);
>>>        INIT_LIST_HEAD(&root->ordered_root);
>>>        INIT_LIST_HEAD(&root->reloc_dirty_list);
>>> -     spin_lock_init(&root->inode_lock);
>>>        spin_lock_init(&root->delalloc_lock);
>>>        spin_lock_init(&root->ordered_extent_lock);
>>>        spin_lock_init(&root->accounting_lock);
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 8ea9fd4c2b66..4fd41d6b377f 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -5509,9 +5509,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
>>>                        return ret;
>>>        }
>>>
>>> -     spin_lock(&root->inode_lock);
>>>        existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
>>> -     spin_unlock(&root->inode_lock);
>>>
>>>        if (xa_is_err(existing)) {
>>>                ret = xa_err(existing);
>>> @@ -5531,16 +5529,16 @@ static void btrfs_del_inode_from_root(struct btrfs_inode *inode)
>>>        struct btrfs_inode *entry;
>>>        bool empty = false;
>>>
>>> -     spin_lock(&root->inode_lock);
>>> -     entry = xa_erase(&root->inodes, btrfs_ino(inode));
>>> +     xa_lock(&root->inodes);
>>> +     entry = __xa_erase(&root->inodes, btrfs_ino(inode));
>>>        if (entry == inode)
>>>                empty = xa_empty(&root->inodes);
>>> -     spin_unlock(&root->inode_lock);
>>> +     xa_unlock(&root->inodes);
>>>
>>>        if (empty && btrfs_root_refs(&root->root_item) == 0) {
>>> -             spin_lock(&root->inode_lock);
>>> +             xa_lock(&root->inodes);
>>>                empty = xa_empty(&root->inodes);
>>> -             spin_unlock(&root->inode_lock);
>>> +             xa_unlock(&root->inodes);
>>>                if (empty)
>>>                        btrfs_add_dead_root(root);
>>>        }
>>> @@ -10871,7 +10869,7 @@ struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
>>>        struct btrfs_inode *inode;
>>>        unsigned long from = min_ino;
>>>
>>> -     spin_lock(&root->inode_lock);
>>> +     xa_lock(&root->inodes);
>>>        while (true) {
>>>                inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
>>>                if (!inode)
>>> @@ -10880,9 +10878,9 @@ struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
>>>                        break;
>>>
>>>                from = btrfs_ino(inode) + 1;
>>> -             cond_resched_lock(&root->inode_lock);
>>> +             cond_resched_lock(&root->inodes.xa_lock);
>>>        }
>>> -     spin_unlock(&root->inode_lock);
>>> +     xa_unlock(&root->inodes);
>>>
>>>        return inode;
>>>    }
> 

