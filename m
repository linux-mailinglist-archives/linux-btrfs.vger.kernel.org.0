Return-Path: <linux-btrfs+bounces-9997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256E9DFA96
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 07:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89170B21A45
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD091E25FA;
	Mon,  2 Dec 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHh3Ib38"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96917E
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733119421; cv=none; b=BF7wXzjCpod14Ch2BxnfPxn907+K51CtPgRySIvDMCSeY54D67MJEUf1JuoPxnYgZnDjCpLlc+az7OVCBuCqTP9PBvijsd6h29/SNBehruHOKK3/Qh7Nwf8vOIrtU8CcfaB9NzBqT+6jVdqwl7C0A9ouTF9P5px8w+n7l/hjX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733119421; c=relaxed/simple;
	bh=j5r48Hgw9Bu0R1Y7leKpgqfARmZ+q1DteeRooGXEu4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPYaxZoa+37DtAbcn4xwRKAJ39EK70sitFz0EYHQ1VhPKRmATLLS+MR1m7e5JXaqEeZj8yfwVufFUF2mwgjukTjSqpYm8gNHM+9CGJw61zcupBvHxOh11s24+v+RTthB/5+NdS+p5HTYDvHNmV3sEnZsdpXoOxJnU8k1WhtZjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHh3Ib38; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df1e0641fso4189616e87.1
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Dec 2024 22:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733119415; x=1733724215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3N+HAFyGQlCcuVWJ+o5HxrQpV6AxxjgUXNvAtdiBeBc=;
        b=WHh3Ib38VmdhPUaGuvbDL8zGcdX1/Fev5a23kc+YRZgSouClrkC5WrR0Y99EuYWbbu
         cGawogP0c6Aeq7ULa5xStuLoJWtC6jSgOjKqlnHxs+Q7ehQCtw334lBBRHXrGE/EIlhg
         cY8Wlzok7pcpCShWgMM4rtEmvhC9AOchP0UBDzytqYcOMb8Svisf+34B5ZRK6giuqPCW
         cPxGqmt4e8IXq7NcmwIGHstiFZUXOz2qtONGVImf60jTo1Wq37XVNym2K0q8KM9BK+k9
         ElhaM9SjSdskd5PnZgOGxsdj5IRp0/omuruu04Vfx3gVRjnRVR7T91BUV+9ckSbFZf4+
         5Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733119415; x=1733724215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N+HAFyGQlCcuVWJ+o5HxrQpV6AxxjgUXNvAtdiBeBc=;
        b=PgtsDeC1NRpR/ZWlRbjOi5tT9DZz2napgdgh9UJYDTesZFpWdQxmZdYi086uQNvisC
         36GqKf8IGg4qSr1yE8JRuEwiSDhvgWH+1CMa9g4z3TxfJ9g5jNEtCrcOkN5adW9IkIGH
         6Pv7VhbHUbxJDHuOxoMUIYhPPguYoy3AtVqYl5PmD23JujJ44MeyqIkxAWK/Q1gQKyIQ
         CMDC6wvkSJj6CfGk5XkNFjqqepHzRacQoVDpcavhPndBTmn2sUBIqAb5GVgSAND6VMRq
         8pexIDoKsgp4IEAGHX/zq1vxTjLRodVYZk6whopZIrPqkyDe4wOZ8w0v/L9c1OGj0Gv/
         JsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBSJT1qAx75fzb9rShKZwYi0JXIEmPTRuH9mpHixSpq977qWDUKHHre0avdXm48eOp+AAQOb/RDr6xxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCa8/EgS1MDgas/D2B2U45/8E3PsNXYBUhI36bS5EQAl0mPAI
	IFeixD2iH6OVuoOAmbOy9uZD4Uhn6iz8DakcpLglKwlFKNElBDKCg888/7omxws=
X-Gm-Gg: ASbGncu9u/uReCVBsKV280iQgnwLZO09EAnLsO9TgPx+XIMiW3gG+KCsrGLDIo5w6V4
	xk+cs1QQdGghF0qzuk5JyKgraKFJG1RgrZNfqL57pLrJ4JI69M5O9QqnX+T5z5M34PYqOzA44XR
	/mT5JGs7J0MawtpNJiQZz1ZI/Es7/6O/mrUQSW0qkQmuF/4DMnXCfFRuxttRaW1kETO2NxUyUUz
	gxsmabmcMYa5meAaIhZxHRBbzGSRoh5K75e0M9u1LEL1g/jDKVhWrkO5HOaJcMnvLgdLsK46aea
	+A==
X-Google-Smtp-Source: AGHT+IE7Bd+jODqZEH1hAv8rqGL4yogMOj9kofXr0Dpy/1f4zB3w0MT+eahbjI+YSzbzdEdZ192e3w==
X-Received: by 2002:a05:6512:3b06:b0:53d:ab04:54ee with SMTP id 2adb3069b0e04-53df0107235mr11572391e87.41.1733119414858;
        Sun, 01 Dec 2024 22:03:34 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215714b4f77sm23312485ad.202.2024.12.01.22.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 22:03:34 -0800 (PST)
Message-ID: <65822232-67b7-47fd-9fda-e7e8a1539633@suse.com>
Date: Mon, 2 Dec 2024 16:33:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: don't BUG_ON() in btrfs_drop_extents()
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <970a8c4f8a0593de2a8498ceaddc2b00ee2d352f.1733118459.git.johannes.thumshirn@wdc.com>
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
In-Reply-To: <970a8c4f8a0593de2a8498ceaddc2b00ee2d352f.1733118459.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/2 16:18, Johannes Thumshirn 写道:
> btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
> extents is greater than 0. But all of these code paths can handle errors,
> so there's no need to crash the kernel. Instead WARN() that the condition
> has been met and gracefully bail out.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Although I really prefer one extra line explaining the reason, but it 
should be good enough for now, until we hit one in the real world.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Changes to v2:
> - Dump leaf when hitting the WARN (Qu)
> 
> Link to v2:
> - https://lore.kernel.org/linux-btrfs/be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org
> 
> Changes to v1:
> - Fix spelling error in commit message
> - Change ASSERT() to WARN_ON()
> - Take care of the other BUG_ON() cases as well
> 
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/20241128093428.21485-1-jth@kernel.org
> ---
>   fs/btrfs/file.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..b3bfd7425efc 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -36,6 +36,7 @@
>   #include "ioctl.h"
>   #include "file.h"
>   #include "super.h"
> +#include "print-tree.h"
>   
>   /*
>    * Helper to fault in page and copy.  This should go away and be replaced with
> @@ -245,7 +246,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
>   next_slot:
>   		leaf = path->nodes[0];
>   		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				btrfs_print_leaf(leaf);
> +				ret = -EINVAL;
> +				break;
> +			}
>   			ret = btrfs_next_leaf(root, path);
>   			if (ret < 0)
>   				break;
> @@ -321,7 +326,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
>   		 *  | -------- extent -------- |
>   		 */
>   		if (args->start > key.offset && args->end < extent_end) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				btrfs_print_leaf(leaf);
> +				ret = -EINVAL;
> +				break;
> +			}
>   			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>   				ret = -EOPNOTSUPP;
>   				break;
> @@ -409,7 +418,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
>   		 *  | -------- extent -------- |
>   		 */
>   		if (args->start > key.offset && args->end >= extent_end) {
> -			BUG_ON(del_nr > 0);
> +			if (WARN_ON(del_nr > 0)) {
> +				btrfs_print_leaf(leaf);
> +				ret = -EINVAL;
> +				break;
> +			}
>   			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>   				ret = -EOPNOTSUPP;
>   				break;
> @@ -437,7 +450,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
>   				del_slot = path->slots[0];
>   				del_nr = 1;
>   			} else {
> -				BUG_ON(del_slot + del_nr != path->slots[0]);
> +				if (WARN_ON(del_slot + del_nr != path->slots[0])) {
> +					btrfs_print_leaf(leaf);
> +					ret = -EINVAL;
> +					break;
> +				}
>   				del_nr++;
>   			}
>   


