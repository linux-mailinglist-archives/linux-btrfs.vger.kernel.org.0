Return-Path: <linux-btrfs+bounces-15133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD3AEE96D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E625D7ACA4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987B22DFA3;
	Mon, 30 Jun 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsR30e1a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020774C6C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318573; cv=none; b=CEsQfScS+jnOIRPkjCc+J6TmfHUVnQVp3jgHCN3rw5nPR98Mvv1wMfjnH0Rt0t5x3PSY0Am0lxhAdCQgVqvF00HkKtULUsFAj8/jD4rG9bQW96u70JekUWMT8Pwv2FZTVI8ZCZ3uhjctqsbfulPsJikBXorO/x8nj65S7KVSfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318573; c=relaxed/simple;
	bh=QXm8EjkjAwNpADziLWsCQ5giQij59/ZXQ+HjrMH3urw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BRifp2AS+8sVltKsfpnn/FMLtlCLAkwhjp+pCONLsPeng92O1ryCe0i8ePrhz4/puUm6BhaQXD65JvGdhzQbGK+kVwbhRkfwPldh9ImMG8IHEzhPim3gmmzsWL2+P+KDI2VtEDRyLBe30TU8blNWqB7VSZ72UBvnyt3XuLoiMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsR30e1a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so3145888f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751318569; x=1751923369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5h7jUbtKc6zaru93Z9lgBqen+siZs5NUZA3AA4hguJY=;
        b=VsR30e1aOOdDlTlkXtiicQCmUe0GfVNfdg53M6i7eD0zDXI53wrC8ONqNnAjZWBoeV
         Y18/cCiHfPOHDgc6Ht4aZTM3SHqeD6/xUz4gF66fgKBn3eW+7lrtou9Ar5/Oqop5EOjM
         jgAPlfy+bbh9ZHWyK7UO+67LqD5y7zRfv4SXZKmvWBBLx87jmWL4epIVCH2vHlGJdVbQ
         dv1+GAOZOHs+okm3t1KkSHTMibeWZuHYjPpKy6Chh1R8tzoW4HkNpxUE1QeWX4QEOdfl
         Hbt0fH41PacduVhjipmTgE0+4z9V6oUGgBvcM0naIsauqofeTlt0MT1RKqb3Vyac963N
         KI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751318569; x=1751923369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5h7jUbtKc6zaru93Z9lgBqen+siZs5NUZA3AA4hguJY=;
        b=a9yv0/H67uUbOrV4FflbOEm50Cldkz3pcbF8M1AzbeuYc4+DfQEo1GzgrVg8Rcrss8
         5rWePxNhL8qER1t0VuGZzP3h+D7xnOLRmMRqzyy5/0osmcXpPflDcDxsvPsAIo806oIt
         Ok0rV0lUjcKt5O31JRfStdwfPaaB9BUfvSvg54za/1IH22RNWgZu6utPSiQ04Wd9Pg7f
         JLSYAIRD/PnLdWmx+gEArooRS0IqFxqRJruvR2Kr2LkQVxTA7OOwlIRUFc2BnvX6rRbK
         Y7wUvPpxPrtg7yf74VR51LUH53AC3WZa3npY1NctvN8NU3nbmcP47zSak7vvMeDfwapx
         Ebmw==
X-Forwarded-Encrypted: i=1; AJvYcCWbPRod+/Ex18JX/AakX/HIlcxf3kELmBapHJ+W7c4GsyFuVv0cQDmKmXZecRexYGpZKYHTWjSV/C/ZGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKyr4cVLdvpwQt0RMhBnEMw5RKZ1oxjAztM1trVJwKhFKeWfY
	DubRuhtC0P0wwM9w2x7K8O8kQl0Q713E3Gpf99GLBa87s0QsW9cutP8Z7gH3x3CwOsTED662pKW
	lESLp
X-Gm-Gg: ASbGncvO4N+kPKHL6qQ6wbxpgN2uRMUkzKG/1ebrz80Ny/iXFsvy7bUsq9ZeAJDuxIB
	FrTOOlRh1RzLRVY3yIvAUsoaG5rOotAqUavePH1Ji8FwxeAzFjhUdkbG/Syyut1xblxvAOH16jT
	ksmIM+wKa2IvIJIKhKXk2RzDGQuAzEhDlhXykFb7HDGZS7cW6rmU33xUH+BcKk1tABZkdVQzePA
	UiJ4BM6QEiZINWyXXIPLyx9fsal5HqG4zQwHFtI1XDNAg3/CvnMgAQ+vWY/MFghVJYN7irbuwUc
	6l42DVjNL3vOZsS5EEwARQxtS0jCJ2GiAGOwQnOh73RraMng0M5NIOqBlUqxi/zErK7s1VrqeUp
	bn9o+UxUvmdzSzKKlLymGYLq4
X-Google-Smtp-Source: AGHT+IHPqUvSLD+9QB6Cs94XPgmx0BBjO2YejR9hfbQRU0x+Syr/C2n3zDlMyDJherCtOJda7UsBSQ==
X-Received: by 2002:a05:6000:14b:b0:3a5:8d0b:d0b8 with SMTP id ffacd0b85a97d-3a90b6dfba7mr10914446f8f.54.1751318568999;
        Mon, 30 Jun 2025 14:22:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5571b7asm10130516b3a.85.2025.06.30.14.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 14:22:48 -0700 (PDT)
Message-ID: <3cfa190e-fa9b-45b7-a6a3-8d067f2cc197@suse.com>
Date: Tue, 1 Jul 2025 06:52:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: fix race between quota disable and
 quota rescan ioctl
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1751288689.git.fdmanana@suse.com>
 <19f775a9f256c4a5146cc97b7f521464429c81bc.1751288689.git.fdmanana@suse.com>
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
In-Reply-To: <19f775a9f256c4a5146cc97b7f521464429c81bc.1751288689.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/30 22:37, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a race between a task disabling quotas and another running the
> rescan ioctl that can result in a use-after-free of qgroup records from
> the fs_info->qgroup_tree rbtree.
> 
> This happens as follows:
> 
> 1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();
> 
> 2) Task B enters btrfs_quota_disable() and calls
>     btrfs_qgroup_wait_for_completion(), which does nothing because at that
>     point fs_info->qgroup_rescan_running is false (it wasn't set yet by
>     task A);
> 
> 3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
>     from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lock;
> 
> 4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
>     the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
>     but task B is freeing qgroup records from that tree without holding
>     the lock, resulting in a use-after-free.
> 
> Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
> Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
> were already disabled.
> 
> Reported-by: cen zhang <zzzccc427@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/qgroup.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index b83d9534adae..8fa874ef80b3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -636,22 +636,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
>   
>   /*
>    * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
> - * first two are in single-threaded paths.And for the third one, we have set
> - * quota_root to be null with qgroup_lock held before, so it is safe to clean
> - * up the in-memory structures without qgroup_lock held.
> + * first two are in single-threaded paths.
>    */
>   void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
>   {
>   	struct rb_node *n;
>   	struct btrfs_qgroup *qgroup;
>   
> +	/*
> +	 * btrfs_quota_disable() can be called concurrently with
> +	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
> +	 * lock.
> +	 */
> +	spin_lock(&fs_info->qgroup_lock);
>   	while ((n = rb_first(&fs_info->qgroup_tree))) {
>   		qgroup = rb_entry(n, struct btrfs_qgroup, node);
>   		rb_erase(n, &fs_info->qgroup_tree);
>   		__del_qgroup_rb(qgroup);
> +		spin_unlock(&fs_info->qgroup_lock);
>   		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
>   		kfree(qgroup);
> +		spin_lock(&fs_info->qgroup_lock);
>   	}
> +	spin_unlock(&fs_info->qgroup_lock);
> +
>   	/*
>   	 * We call btrfs_free_qgroup_config() when unmounting
>   	 * filesystem and disabling quota, so we set qgroup_ulist
> @@ -4036,12 +4044,16 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
>   	qgroup_rescan_zero_tracking(fs_info);
>   
>   	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	fs_info->qgroup_rescan_running = true;
> -	btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -			 &fs_info->qgroup_rescan_work);
> +	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
> +		fs_info->qgroup_rescan_running = true;
> +		btrfs_queue_work(fs_info->qgroup_rescan_workers,
> +				 &fs_info->qgroup_rescan_work);
> +	} else {
> +		ret = -ENOTCONN;
> +	}
>   	mutex_unlock(&fs_info->qgroup_rescan_lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,


