Return-Path: <linux-btrfs+bounces-21466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HSMMzrGh2lldAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21466-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 00:09:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5610764C
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 00:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1D63016ED0
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45A318EC6;
	Sat,  7 Feb 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XFFIgj+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38E20010C
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505778; cv=none; b=JHTp9JpezEwipuDtojRJYK4ub1U+e0Dj91ZmAxvZMxGVSX0/jFqq844wgzhSbPlxQQ4i6EweIELnt1uRB7+tLgF5eFhjXWYvMQKXne4+qvtIs3LIgyKC51Ihqr8irDKFDk3jnqZ6k9HZA0lPwcbA3PvJqYbM9PpDATgPmlUCQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505778; c=relaxed/simple;
	bh=C3Q7wNNI8TKx3YHyg1bQGI5pmhndABogR2Rgvo+5jag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2awvV2vV61T0iRyabSaAW7JeB1u1d1morzChTE3rdCJA6iVEsg4cnHO/faDhsd/LHZFlmM2Kif/nc9BehNYYYb4IMU87Y4wlsmwJ1OBwSbdPekLapv4D42aDMDKodQzWdP5my663BXOFVfVFUfvCeG9hXW+xBmIjMmWRWOgrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XFFIgj+n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso19842915e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 15:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770505776; x=1771110576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iC1jrmeiZAbSCDpd51lzvnkKT0kz8BqD/+/Q4mcoGDE=;
        b=XFFIgj+nyJg0DBqpx2EOHaGzuMhGJY05AaDvhaIAMrm6lMngve0dBykuGm2lsGprcz
         Et0httpnksVfFLibEv9W+JYxDYDjjE9kM77PpudCeoC/ItXY3+mXzfZiL1lK8OLbaoX+
         7ruxzp2J8It+A2T91Aofrzbr+WzgyIAbLJd/2YrVc98ufuDVpAGLFM2eKhdAvqRjHkCW
         X/I8dzOgAijVpcqRBzw86+UpWeWj9SVulbv3QI2hRAZn/7rquuOntnAV8qPQRN7A1tB9
         +p29AwHNI1RZP4FiV/DC13qlf4dKKNy3Yev4f//v/J1QwftszRbn7I6nU4OhWCL/71Hh
         cbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505776; x=1771110576;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC1jrmeiZAbSCDpd51lzvnkKT0kz8BqD/+/Q4mcoGDE=;
        b=q+GnAjnIbcl9dj3czWY7sorZkNQFNLvM6U6k/Lp27vJOD0N9QoK3xyNzbHEeCMrv9I
         BR+RxAtehLWSeMVr8Q9c2gyXa522Z0G7EX/e6ZNihs9hLLQowoaA8/cgx5bt3frnShbw
         YyC+6rO5PtM5/3+JV8SUWy5Bn7/BVULAXH3mY1DYT+cMC5qL0fxi6CJmfDlIxYiMed38
         rEX13J1cvYluRGSSuevsfuOyekYrBf+jMAZXe1efKJy5OksH3svQkwli6V9EPMZKG+eP
         g99KNfObPTfihy9M1UQvcX0i56PCslT0eZ/t4diuhjvLKBVC54iyqjir9wi4qci9DZCj
         sahQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7D5rcWQ3vb865h50VDeUf6p1qESL1LSkKisIwNXifvwdWtpB+6PImcvl5IQZOUxiP50fsfHRK9QHGEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7pIK5EU/bZ2+re1AgWW0n5tUsm7UMaqdIF8Mvd+Daf8Dg0iT
	EREMkxdhwULsTPMrsxHQ5bZoE4Y0r2XTdMDMazC7pKNdc7Dw5dCS3pla9HUPhx7/AIA=
X-Gm-Gg: AZuq6aIndp7Hay4CQGJrL2Fbza4MoNwbfFTGu+Dk7XCTAYVaiqxkIC7cIWyExdI2ptg
	b2McwDFHFFdPtj+tLqBudzEyo4fpt+/8idP/vlbssV/pVqAECfy01pOrcSxd2GQ/asPccWTk8tW
	GbgUBK7sVfP9gw+19yEcN7JMyk/3Z05IU4BLHbO3RiV4VEpmqpbNldbxHdt0ZZuR9Vxm6eD4k/Y
	uNUMO4REokSRykwyGs69LC4YTv5RUcdUAhB1W0W1vZU1HYR+RmJse54+ifp+JmpP/tQLkeIqGOr
	DNg2M7Krq1hzQHeNpncX6diwExcS8lMbsffkB2q5AbpSGV7VDmC5etdBylXcy7k+Vw9rTGJLrST
	NH7tzY/CHqQM3E06a46T4Nb2otIci9k9WZDEA0EjSdFIjEzWTFv5xOs6ZLQFW7jdb4YVeBM7+BH
	x2a8I0m1Z+xEyBe6LHl2xXDhwPMJGH+cXzg8GHI88=
X-Received: by 2002:a05:600c:628d:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-483202160admr99043685e9.23.1770505775904;
        Sat, 07 Feb 2026 15:09:35 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb64a103sm5436147a12.30.2026.02.07.15.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 15:09:35 -0800 (PST)
Message-ID: <bf7c477d-ce4c-4d6e-9538-1baa33e39a02@suse.com>
Date: Sun, 8 Feb 2026 09:39:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
References: <20251211072442.15920-2-sunk67188@gmail.com>
 <20251211072442.15920-6-sunk67188@gmail.com>
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
In-Reply-To: <20251211072442.15920-6-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21466-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FB5610764C
X-Rspamd-Action: no action



在 2025/12/11 17:52, Sun YangKai 写道:
> There's a common parttern in callers of btrfs_prev_leaf:
> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
> 
> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
> valid slot and cleanup its over complex logic.
> 
> And then remove the related logic and cleanup the callers.
> 
> This will make things much simpler.
> 
> No functional changes.
> 
> A. Details about changes in callers:
> 
> ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0])) in callers
> is enough to make sure that nritems != 0 and slots[0] points to a valid
> btrfs_item.

I don't think the change is safe.

There are callers doing proper checks for empty trees, e.g. 
btrfs_previous_extent_item() and btrfs_previous_item(), now you will 
just ignore that for kernels without CONFIG_BTRFS_ASSERT, or crash the 
kernel if CONFIG_BTRFS_ASSERT is selected.

If you're just cleaning up btrfs_prev_leaf(), then you should keep the 
callers the same without changing their behaviors.

I think there may be some corner case races when tree deleting and some 
other work are happening at the same time.

> 
> And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
> error because btrfs_pref_leaf() should always
> 
> 1. either find a non-empty leaf

Nope, there is no such guarantee in the first place.
btrfs_prev_leaf() will unlock the path, thus all kinds of modification 
can happen between btrfs_release_path() and btrfs_search_slot().

This assumption is just wrong.

> 2. or return 1
> 
> So we can use ASSERT safely here.
> 
> B. Details about cleanup of btrfs_prev_leaf().
> 
> The previous implementation works like this:
> 
> 0) Get a previous key by "dec by 1" of the original key. Let's call it
>     search key. It's obvious that search key is less than original key
>     and there's no key between them.
> 
> 1) Call btrfs_search_slot() with search key.
> 
> 2) If we got an error or an exact match, early return.
> 
> 3) If p->slots[0] points to the original item, p->slots[0]-- to make sure
>     that we will not return the same item again. This may happen because
>     there might be some tree balancing happened so the original item is no
>     longer at slot 0.
> 
> 4) Check if the key of the item at slot 0 is (less than the original key
>     / less than or equal to search key) to verify if we got a previous leaf.
> 
> However, 3) and 4) are over complex. We only need to check if
> p->slots[0] == 0 because:
> 
> 3a) If p->slots[0] == 0, there's no key less than or equal to search key
>      in the tree, which means the original key is lowest in the tree. In
>      this case, there's no previous leaf, we should return 1.
> 
> 3b) If p->slots[0] != 0, using p->slots[0]-- is enough to get a valid
>      previous item neither missing anything nor return the original item
>      again because:
> 
>      i) p->slots[0] == nritems, which means all keys in the leaf are less
>         than search key so the leaf is a previous leaf. We only need to
>         p->slots[0]-- to get a valid previous item.
> 
>      ii) p->slots[0] < nritems, p->slots[0] points to an item whose key
>          is greater than search key(probably the original item if it was
>          not deleted), and p->slots[0] - 1 points to an item whose key is
>          less than search key. So use p->slots[0]-- to get the previous
>          item and we will neigher miss anything nor return the original
>          item again. This handles the case 3) in original implementation.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>   fs/btrfs/ctree.c | 99 ++++++++++--------------------------------------
>   1 file changed, 19 insertions(+), 80 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0a0157db0b0c..3026d956c7fb 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2376,12 +2376,9 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
>   static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>   {
>   	struct btrfs_key key;
> -	struct btrfs_key orig_key;
> -	struct btrfs_disk_key found_key;
>   	int ret;
>   
>   	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
> -	orig_key = key;
>   
>   	if (key.offset > 0) {
>   		key.offset--;
> @@ -2401,48 +2398,12 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
>   	if (ret <= 0)
>   		return ret;
>   
> -	/*
> -	 * Previous key not found. Even if we were at slot 0 of the leaf we had
> -	 * before releasing the path and calling btrfs_search_slot(), we now may
> -	 * be in a slot pointing to the same original key - this can happen if
> -	 * after we released the path, one of more items were moved from a
> -	 * sibling leaf into the front of the leaf we had due to an insertion
> -	 * (see push_leaf_right()).
> -	 * If we hit this case and our slot is > 0 and just decrement the slot
> -	 * so that the caller does not process the same key again, which may or
> -	 * may not break the caller, depending on its logic.
> -	 */

Although the change is mostly fine, if you want to keep the existing 
behavior, you should return 0 for empty tree to keep the old behavior.

Furthermore, you have to explain why it's safe not only in the commit 
message, but also comments.

This not a small change, and very low-level. Just doing black magic is 
not acceptable.

And you need something better than your commit message as comments.

In short, you should:

- Not change the callers

- Better comments

> -	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
> -		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
> -		ret = btrfs_comp_keys(&found_key, &orig_key);
> -		if (ret == 0) {
> -			if (path->slots[0] > 0) {
> -				path->slots[0]--;
> -				return 0;
> -			}
> -			/*
> -			 * At slot 0, same key as before, it means orig_key is
> -			 * the lowest, leftmost, key in the tree. We're done.
> -			 */
> -			return 1;
> -		}
> -	}
> +	/* There's no smaller keys in the whole tree. */
> +	if (path->slots[0] == 0)
> +		return 1;
>   
> -	btrfs_item_key(path->nodes[0], &found_key, 0);
> -	ret = btrfs_comp_keys(&found_key, &key);
> -	/*
> -	 * We might have had an item with the previous key in the tree right
> -	 * before we released our path. And after we released our path, that
> -	 * item might have been pushed to the first slot (0) of the leaf we
> -	 * were holding due to a tree balance. Alternatively, an item with the
> -	 * previous key can exist as the only element of a leaf (big fat item).
> -	 * Therefore account for these 2 cases, so that our callers (like
> -	 * btrfs_previous_item) don't miss an existing item with a key matching
> -	 * the previous key we computed above.
> -	 */
> -	if (ret <= 0)
> -		return 0;
> -	return 1;
> +	path->slots[0]--;
> +	return 0;
>   }
>   
>   /*
> @@ -2473,19 +2434,11 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
>   		if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
>   			return btrfs_next_leaf(root, p);
>   	} else {
> -		if (p->slots[0] == 0) {
> -			ret = btrfs_prev_leaf(root, p);
> -			if (ret < 0)
> -				return ret;
> -			if (!ret) {
> -				if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
> -					p->slots[0]--;
> -				return 0;
> -			}
> +		/* We have no lower key in the tree. */
> +		if (p->slots[0] == 0)
>   			return 1;
> -		} else {
> -			p->slots[0]--;
> -		}
> +
> +		p->slots[0]--;
>   	}
>   	return 0;
>   }
> @@ -4969,26 +4922,19 @@ int btrfs_previous_item(struct btrfs_root *root,
>   			int type)
>   {
>   	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
> -	u32 nritems;
>   	int ret;
>   
>   	while (1) {
>   		if (path->slots[0] == 0) {
>   			ret = btrfs_prev_leaf(root, path);
> -			if (ret != 0)
> +			if (ret)
>   				return ret;
> -		} else {
> -			path->slots[0]--;
> -		}
> -		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> +		} else
>   			path->slots[0]--;
>   
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>   		if (found_key.objectid < min_objectid)
>   			break;
>   		if (found_key.type == type)
> @@ -5010,26 +4956,19 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
>   			struct btrfs_path *path, u64 min_objectid)
>   {
>   	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
> -	u32 nritems;
>   	int ret;
>   
>   	while (1) {
>   		if (path->slots[0] == 0) {
>   			ret = btrfs_prev_leaf(root, path);
> -			if (ret != 0)
> +			if (ret)
>   				return ret;
> -		} else {
> -			path->slots[0]--;
> -		}
> -		leaf = path->nodes[0];
> -		nritems = btrfs_header_nritems(leaf);
> -		if (nritems == 0)
> -			return 1;
> -		if (path->slots[0] == nritems)
> +		} else
>   			path->slots[0]--;
>   
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +		ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>   		if (found_key.objectid < min_objectid)
>   			break;
>   		if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||


