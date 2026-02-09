Return-Path: <linux-btrfs+bounces-21520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOkhOqpciWlY7gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21520-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:03:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C95610B7E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A963006B46
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964E1E0B86;
	Mon,  9 Feb 2026 04:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LkOaKMQh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C71862A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609827; cv=none; b=HoS2ZcjbAmuM6cpxZV9QwlId38B9mqUUsGxXMXXer6A1pDcamKx5Eg7OdChvxivMfirHeGUGKLGmLMae1VxSfeV7Kd+tlVCAuekEN4pd7aZi5qkfbxVUsUrgaf43LxBJpTnwfhL0mB9/bAeTN2r7bkfV5Q+NGSuJ0BljC0+rHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609827; c=relaxed/simple;
	bh=cPR/1DlLNGU+dpCVxoza4XgcAEwbjs2LHrah9Tu3Sp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cm0qDYlsB4sqOD8sKDdQrjzZd5ir7arJshMN0UaGZ1xx3lwUw0xtHBUlKnrZQH3aXWL3boFTLBkqJeN8jEJ9KwO06ea2idD2U6RmERf2kHrtma2cp3e7eOVB+rahkVH2roc3wlyOIyq38LTXFtzbygHTCGEjJ0B3O9YppmKQsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LkOaKMQh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee0291921so23055945e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 20:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770609825; x=1771214625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G45ws+QTWpXKYKIvRsrym9kpRp34TrD5TjxhGRG9Fcs=;
        b=LkOaKMQhkLt/rCjq7QsUgpnuoZcIQMKcosgApzcRbSWbs9t7ECFjMIF/1YwygholpS
         Wi7QRtu1x/RQSx/fVCVlyfY287XNQo+UkDTgM7a8fd+D5Zl4iChb9QMZ17/vYHp5Z4M1
         BSZLTEQ7hH8mp9QO2kJBORoEvCmWrJCAo4T+za0hNkQdeGXQ07QL9foR1/lE/DDSl17E
         MZ6pbixjrkj6PVK1R470/UcKViebusCCoQnQyceOpG27akLd+QxxmyuXvOu1EGZaIWXg
         diFJHkUtF63UxH6K3J3WN/W3DQulrfB7l1cdjRLWI+y+Ov35xs/Vauwy2zzPIoLWcUJM
         DFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770609825; x=1771214625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G45ws+QTWpXKYKIvRsrym9kpRp34TrD5TjxhGRG9Fcs=;
        b=rnw7PILKggHBB5GGHlKaYvRPy1kknVY7uTy9YM9v7NmtowSFpTugIiJcXfbe0THkyt
         U8BsRHHn5O1DME7G8mtm9Vqbu7C1x/0A6DLf0sVcHyvmoGpWsdaTvYnvsgo+tBOaIvfL
         J50WpgkhRellaIfdiBCXzYx34BZ/CsiAB30xC+EhhL/VH02KWthrVdt+fgzaHNH3NSiE
         ieypOO4pG9d2gSEND0Rjnmc7SklxUvkROGbSUuhjQKwDKXCD50IhlqZhEfsGUEiLb54Z
         vMgiTZKAua6Q13PNZE6sIh3ObLOoq8IrO9P+VxqQfHi3U9c9P1KW9Io13wU9BPJ3Mkz0
         k9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8Fgt+O2KMIPlxR8nwGkgFv1Oe7z2R1jwHmNF93T4TZlNzm+Oj7i0gWMC/bwuPdj46Ri4cYep4lyVZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCjbw7SgBNTe90kP5hBcUlSteqrodwubJCQeeg0F7q8rjSCY2
	o6KE3HOQW/rU8OzzRsc1hAIokq8BotSHTkFZNZQ4q9I+EP93UkaaTWkmSiCD7AY/uETwqSMcyvo
	tD2l/GLk=
X-Gm-Gg: AZuq6aLiO7N4NZN1j+ZDbuCcpmfHt2Vjk6MaPf96lhQ+J9leNtZVZizRFEmAVQjsne4
	SlI4iiM+1RmtUgLna7+Aj+8IDt+yJCXB+3rAMOlcgUKC1ANp2zNFhUgaoRW1lk4fQSEXbsM1JIj
	SywKdLgHjvaJWhCdyRi6voBaPXCheottTCf1LPjpNdMbOkUfm2o4jYWBeONItylm0zF4k36Yh/8
	W9dK/kULYpDiSiCnu0Jbsoo/c274pwvtzdtB/V6QRSzD6+rcIz+Ijab8ZODIAS+mjYdm1CJKmrR
	iQiFxhttWFCru0ceoJ7ku9m46QVj1Z3gyzFZuNKGY5zd1SOKa+JfkpX3PRZHcmb0XkL6R96R3q9
	5jO8JY5QpMONi6C5iitxvKuUYHHYR+30MXjJJEfLz2A5pk2ZMgkb4zjPpYWQ+ENP0HbZNL4HpVY
	SgOjNVJgnwPDCqoCqYpswi5PLzLafA+lmY0a68NsNFhWtElbSQ5w==
X-Received: by 2002:a05:600c:19c7:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-483201e160dmr134696095e9.10.1770609825439;
        Sun, 08 Feb 2026 20:03:45 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b465df51sm4338749a91.9.2026.02.08.20.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 20:03:44 -0800 (PST)
Message-ID: <0da2097d-58c1-414e-95cb-972ea9345544@suse.com>
Date: Mon, 9 Feb 2026 14:33:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix lost error return in btrfs_find_orphan_roots()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <6400dc5103b5ddbe543961b4e865e311ab396790.1770580302.git.fdmanana@suse.com>
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
In-Reply-To: <6400dc5103b5ddbe543961b4e865e311ab396790.1770580302.git.fdmanana@suse.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21520-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 8C95610B7E8
X-Rspamd-Action: no action



在 2026/2/9 06:22, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the call to btrfs_get_fs_root() returns an error different from -ENOENT
> we break out of the loop and then return 0, losing the error. Fix this
> by returning the error instead of breaking from the loop.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208185321.1128472-1-clm@meta.com/
> Fixes: 8670a25ecb2f ("btrfs: use single return variable in btrfs_find_orphan_roots()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/root-tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 37a4173c0a0b..d85a09ae1733 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -257,7 +257,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>   		root = btrfs_get_fs_root(fs_info, root_objectid, false);
>   		ret = PTR_ERR_OR_ZERO(root);
>   		if (ret && ret != -ENOENT) {
> -			break;
> +			return ret;
>   		} else if (ret == -ENOENT) {
>   			struct btrfs_trans_handle *trans;
>   


