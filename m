Return-Path: <linux-btrfs+bounces-21619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH1BL4uji2ktXgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21619-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 22:30:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1511F6B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 22:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C930C30465F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6633893D;
	Tue, 10 Feb 2026 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fe83tUrJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016928F50F
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758987; cv=none; b=Sl/WWZSukAWKYFlQSIowbh3Ln+rMkqNlB4YHOvC6qNa9aVFo6jHEEW/6msfX9Lc7F9SMNe8g2qMy1KMDHdCzTwiS5wUhNNmks/1kFbv1sE/pgT83bnOIvrRNm5jpF17JNCa1RZZTTIh0C72YvpQvuza7bf1A/wCWf4AMsx4SHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758987; c=relaxed/simple;
	bh=b+WwzXYSpBgw6MEWQ2bh8QSWroP1riwOD/L/0OU7GW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X0BnZSX6NXYK0A1spijZJKBPCz7CpKC/nQ+mYKqaxsmFU5qw5EdQGpelSZtwWxgnkOBcqS2fftD8yTem8uqsc0gBGz2t8dAiC+gl6erK6+ZDGd2TYNLE9rrEnPZWxLz+lpIDk+qaMwuuLe7YDOEri5WoWZy4Ze6hrWq/BHnYFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fe83tUrJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4807068eacbso11676375e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770758985; x=1771363785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SJII5UF1bAiFbHw1zIGy7g5FHm0hGuO9fY2xniW6BIc=;
        b=fe83tUrJXaVYako5rx7k3D/Mu0+hedAY5kgbZVZgAfnQ8l8ujedfU/iGfGeNUnKCzC
         qU23xxnK5I0Bf3EpzMyNPEwnQ5Yzv0jPI053rI2rajTt/tiC7woZA3hFSHjO5YwxXTcv
         BweA+f8FYp4my9qv14ULWdyLpMtEZT50j8UVv3U2a31W3V07w+k4ga2tHOxRj34zJvcu
         +vdOrTnkD3JJvnZ9rKv1hrOmVi6aFuBDvl6VdGZRqSdn82aOFxkjqYN3Bz0XZ0kg5EIT
         oXuPh2mgOFNwXoINpPSW8wBB0K+JPczQS/BMfvCmAqYHTd7yxURa9rUEnbGY7khEsxvW
         LVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770758985; x=1771363785;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJII5UF1bAiFbHw1zIGy7g5FHm0hGuO9fY2xniW6BIc=;
        b=k7Hb+bHVuueZL0Rg4n4LzqE4IgSUty0BtjoALUJy5mz0fLUHHrnHNPgzIhAFn9pCQ9
         5KvPRzwqAbv4RKD4lI3wBi+LwZ1EV08D6hUCYU4ZlzBcgXdXiBfRLjqUQKj4ior6je2n
         MvRZJjAZu8YC0kdZN7yRLpCz1KSFE9xU0gtyC5E01iW3XBtZPluxJdcZOpceCHCXRtlz
         +NLjUSdGEF+lW/Oi0R9bjakCeyZMLLjBPyn2PhuvgQ3mxoj3CoqbR0zvACHHFZFHsGho
         c7WBDNWxT1btCE5K0xyci10FF2ImvZ/Kt+9rr3F39z/DxKu1lw1CxBFPR9aW+9ohGuIb
         luxg==
X-Forwarded-Encrypted: i=1; AJvYcCWsArZAzgOeDOTUYuNU4dtXRTk34bfxzIKNbFmY6RRtfrK7VdyUp4vP6HnGZKOb+qUHI7E/Qw8qeaxzlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0PS7BQ5t1xZU16EwS9+8XlGF3EUAkeIMrTgs9lU+UeonwT/h
	Zuk7Vq2Ub+D/aL3jlqavs9v/Kd80SehoVIB2JgB1N2TInAcLRJyBMMDyccN0bbAns9M3S78fsqW
	LCYueFiQ=
X-Gm-Gg: AZuq6aIUsTrUwguRat88N7h+eYr9x77tzn+19aEQdCT530uPOc51cv5qGtkZmd6te1r
	6ZahnweRG0ijaAKnjD0cuO8kxJCseEbOoghA3YSOc3LVkvz4CAFt2SdeBNY1H+RQ0/M4yUwsr4y
	wkqRcM0k/sbHIfYCIgY8juZbjmahDqnb+ZQk4htQooSyerANnsv/0SxS5pN1njGS3gHWdd9/dLA
	p1id59cZ+JpGS28zqHxSXRLYnbAZDGp8HFtdwxiQVyFmo7ELnfkjcV8CPBVlXeN0/HBjBopiUYt
	GW2tko9ZH//9ofNQXFqMwdWgO1jDwMSycQ3VnFMa0So2lsyGVwZPmgdNUPb9JuZUzU+QWFRZvYh
	X2+IlA6AHkMSfE2FRfw3M/nOR8+BEwtlnTSTCjoL7Qx4N5/+GcuYYw88110HzZg1E7+1/NAlrEG
	tvdLw61k8/lC8ILHoFCiJ7kaTkQ6RMJUuQkJcCNDnSlg32PB8ZR1c=
X-Received: by 2002:a05:600c:348a:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-48337ae7016mr139374025e9.3.1770758984739;
        Tue, 10 Feb 2026 13:29:44 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6b10csm3798915a91.8.2026.02.10.13.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 13:29:43 -0800 (PST)
Message-ID: <23937ff8-ba99-4a39-b97c-3f396f43eadf@suse.com>
Date: Wed, 11 Feb 2026 07:59:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove pointless out label in
 qgroup_account_snapshot()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b9fdf03c58efd3a7f53472de443054e6c2d9ba69.1770725404.git.fdmanana@suse.com>
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
In-Reply-To: <b9fdf03c58efd3a7f53472de443054e6c2d9ba69.1770725404.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21619-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BB1511F6B6
X-Rspamd-Action: no action



在 2026/2/10 22:40, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The 'out' label is pointless as there are no cleanups to perform there,
> we can replace every goto with a direct return.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/transaction.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 746678044fed..98fb8c515a13 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1602,16 +1602,16 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>   
>   	ret = commit_fs_roots(trans);
>   	if (ret)
> -		goto out;
> +		return ret;
>   	ret = btrfs_qgroup_account_extents(trans);
>   	if (ret < 0)
> -		goto out;
> +		return ret;
>   
>   	/* Now qgroup are all updated, we can inherit it to new qgroups */
>   	ret = btrfs_qgroup_inherit(trans, btrfs_root_id(src), dst_objectid,
>   				   btrfs_root_id(parent), inherit);
>   	if (ret < 0)
> -		goto out;
> +		return ret;
>   
>   	/*
>   	 * Now we do a simplified commit transaction, which will:
> @@ -1627,23 +1627,22 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
>   	 */
>   	ret = commit_cowonly_roots(trans);
>   	if (ret)
> -		goto out;
> +		return ret;
>   	switch_commit_roots(trans);
>   	ret = btrfs_write_and_wait_transaction(trans);
> -	if (unlikely(ret))
> +	if (unlikely(ret)) {
>   		btrfs_err(fs_info,
>   "error while writing out transaction during qgroup snapshot accounting: %d", ret);
> +		return ret;
> +	}
>   
> -out:
>   	/*
>   	 * Force parent root to be updated, as we recorded it before so its
>   	 * last_trans == cur_transid.
>   	 * Or it won't be committed again onto disk after later
>   	 * insert_dir_item()
>   	 */
> -	if (!ret)
> -		ret = record_root_in_trans(trans, parent, 1);
> -	return ret;
> +	return record_root_in_trans(trans, parent, 1);
>   }
>   
>   /*


