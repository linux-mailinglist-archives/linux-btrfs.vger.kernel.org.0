Return-Path: <linux-btrfs+bounces-21160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDkdKebGeWl0zAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21160-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:20:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBC9E283
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B02D3021EB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32F26A1CF;
	Wed, 28 Jan 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NxiCym0e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A91EAE7
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588435; cv=none; b=QBV4cUzkA6dP8AgEG+7PaZloy5HkJoY1PLHgROuihlQl2a9CQO1EBHxxK075LuVrZBynyH10ma1MeSqCb13W88ya1ZamhYU1bgeD3qnsB7mg/pbT4aylXHg6lCll679LvDm1HpCwBdW+v1ENpmN2dQmNCCnXvjIFzw0QGI5VVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588435; c=relaxed/simple;
	bh=nGFMUwVWznZdItOVYfC1OzXOIL0c62vfKBU8fGFRQFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy8isPtHY3OmI9Skny949WxswhEi/QWPGDNyhtmoPQJDhJTzhF6UY7gQN3D9Acv0nbUmRpjzdbqlnluRWjlmgBLkUNo33EQXhYoafeukW7ZkV+qzbUuJ8KqIK4hfwcvUR8xfOw+NoFr/HBfb1N3GimdfPosHshthDwfqZN8+nWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NxiCym0e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee0291921so56382245e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769588430; x=1770193230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kSrnvj0AA2YQfz+buIKyFAivtbZyzQNq9hTO8zPitEc=;
        b=NxiCym0eyBrogQ5S5OhiuOUpxBEPYgX+GPED54AvuWTSpHnw4qVqqmOf9vyJmfgMe0
         5b/ig2aIv9PdzCPHBDSD/l9e2NqmfLiZdujSojV9OMcHj3NTUI75AAkw27oB9Ufo3+ag
         tafOBZz6ZvLH5TwFJapeZNebyNgae3RErg33iR/cxiBmjMu30a6RW1rGZGt5Ki46Xr13
         pm/jAVysKgFRxRcih9FKaA6ibCO1Q3fbRyfmaO4l7aA5yJaKebWVkAi7kklwHqvo1dB0
         Jjxbj0B+bPTCa22iyj+y6mYLqKEy/MrYLFPmOld2Yo1OsEq4e3FQ1aQVqmzNuC9mVL1h
         Dkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769588430; x=1770193230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSrnvj0AA2YQfz+buIKyFAivtbZyzQNq9hTO8zPitEc=;
        b=TzlMUnbV3fVvewmD7taj1hq5JRKssv9grepuApumugBdACDd6Xp8RULKKFK5l7R5NI
         rn6q1cNoKg0BOpraLCQhXoikobYeDCs6rRm9XT+LzeQ+kqqgYr+23gTO9v+Dbsqkt1jE
         4/GyV54ZC+fk9RB5kU5EZDzZPpiJqYflp/eJTD0wwxTbDhc0YG1W5nqPOBnugdm/8lIc
         m6Rf6EB+Z9eXliu6dQ86d6C0Ml0Ro24NbDha6Qns8kgdbbCPkqRKZIM9LPRIChG0q/CO
         DqY66i0QKBCZp45DS4FsPlSYSG+AmvR7A6Y7ZwHFSWnD25sU3OreW+yi1tTsbqtw02xa
         K7NA==
X-Forwarded-Encrypted: i=1; AJvYcCViSep+RD+cm0PNxK7GQmA3d/VzFUwLXMHoo/VvzIs11G9Xxq+5RvnKImab6RtvHa7mITzVv8nHfph6wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynlhsqeLGqcPjQ7FnFcFnOlDDIKmpbdm0r9E08A0LGRjgnz1F/
	gBdhqPK0fdIZoqt2cR5RpWOMjt1Ct41KSCLtCfAWKQZdxS0LveVWNGrG+z3INgpPpIM=
X-Gm-Gg: AZuq6aKiblSgS7/SlL/qtxVTc9ASmvPSBhFPxQ9/36dhQS9OfxSRCWKjc6WXkf8oUy3
	pLwxnKeo3Jxj7DdgJ7PVuSulid9Lsemdb+pPuyzpMg3GtuNwpVd0c3ZAi/1wwYPUD8LnhJgwU6f
	k3FcHXpdtJOphsKilK6j7b9n9KD2KI0Fb1GkPVZzuGh1wYIN+83Zmj5xGnQMeTo8KfomgH+yw/c
	17q0p7m+Q7txX+YsXOg2nzepqTcGxLpLqaCzgIMp383nXnCrORYP+aHWpPNvUVskjeHDz+NPNeV
	8TuLeJtHqPrzkXBvFyWlmmrM7xXXhSWD4eQ+o9zDZxZ5yBMQTA5SmttP8VUqnq/sodvnh+Chp1E
	ISmFxtwUmT7jQ40QLiLOjNZtFM2inqcTIL5d7aSFve6Mk/pu/SPi0XbyBSB0wKCyroFSNqEr4hu
	goy5sCNWDRsxw4NUoPor9y9jzSC6u5cOl7HrxMBLE=
X-Received: by 2002:a05:600c:4e94:b0:480:4b5d:9ec with SMTP id 5b1f17b1804b1-48069cafa29mr56486855e9.33.1769588430518;
        Wed, 28 Jan 2026 00:20:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642afbeaf3sm1495796a12.33.2026.01.28.00.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:20:29 -0800 (PST)
Message-ID: <eec6b47d-2b0a-4196-807a-b05f4a983e47@suse.com>
Date: Wed, 28 Jan 2026 18:50:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] btrfs: handle user interrupt properly in
 btrfs_trim_fs
To: jinbaohong <jinbaohong@synology.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org, dsterba@suse.com, Robbie Ko <robbieko@synology.com>
References: <20260128070641.826722-1-jinbaohong@synology.com>
 <20260128070641.826722-4-jinbaohong@synology.com>
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
In-Reply-To: <20260128070641.826722-4-jinbaohong@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21160-lists,linux-btrfs=lfdr.de];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 51FBC9E283
X-Rspamd-Action: no action



在 2026/1/28 17:36, jinbaohong 写道:
> When a fatal signal is pending or the process is freezing,
> btrfs_trim_block_group and btrfs_trim_free_extents return -ERESTARTSYS.
> Currently this is treated as a regular error: the loops continue to the
> next iteration and count it as a block group or device failure.
> 
> Instead, break out of the loops immediately and return -ERESTARTSYS to
> userspace without counting it as a failure. Also skip the device loop
> entirely if the block group loop was interrupted.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>
> ---
>   fs/btrfs/extent-tree.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 6c49465c0632..633c7c0f9d92 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6665,6 +6665,10 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   						     range->minlen);
>   
>   			trimmed += group_trimmed;
> +			if (ret == -ERESTARTSYS || ret == -EINTR) {
> +				btrfs_put_block_group(cache);
> +				break;
> +			}
>   			if (ret) {
>   				bg_failed++;
>   				if (!bg_ret)
> @@ -6679,6 +6683,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   			"failed to trim %llu block group(s), first error %d",
>   			bg_failed, bg_ret);
>   
> +	if (ret == -ERESTARTSYS || ret == -EINTR)
> +		return ret;
> +

If your idea is to exit without counting it as an error, it's better to 
put the early return before the error message, or it will still acts 
like an error.

>   	mutex_lock(&fs_devices->device_list_mutex);
>   	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>   		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> @@ -6687,6 +6694,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   		ret = btrfs_trim_free_extents(device, &group_trimmed);
>   
>   		trimmed += group_trimmed;
> +		if (ret == -ERESTARTSYS || ret == -EINTR)
> +			break;

Here you're only to break and then catching the same error code just to 
return.

Why not just unlock the mutex and return? That also skips the error message.

Thanks,
Qu

>   		if (ret) {
>   			dev_failed++;
>   			if (!dev_ret)
> @@ -6701,6 +6710,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   			"failed to trim %llu device(s), first error %d",
>   			dev_failed, dev_ret);
>   	range->len = trimmed;
> +	if (ret == -ERESTARTSYS || ret == -EINTR)
> +		return ret;
>   	if (bg_ret)
>   		return bg_ret;
>   	return dev_ret;


