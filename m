Return-Path: <linux-btrfs+bounces-15134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9941AEE96F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 23:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2113189B8E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085E224240;
	Mon, 30 Jun 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A+8uBCST"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968861A0BE0
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318657; cv=none; b=CQ3nHKu/V9/xm54QV2g+Yn+CBgXfnNv8tASmXGtkckxhrLlwOdf2baRoI+XI7izgiPIbzEtW/roXUYosmZ+G05VdIIzBALOM7REF0DZHNyUYMIp9/tG07jiuOCJYB9WIU1ja/kZZfrrzWwjOlNekQSX+6AvPHNQOxDS64VbTrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318657; c=relaxed/simple;
	bh=6GwBx70sN2JBI7hpyC2gpTEu3DB/7q4qEsdOYlo9Gp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h017EnULdWMG4kJvN4do3DZMOCPWCtxQiIb9ONxYsr84BG4NXIX158N0SNvOJwhABzLJ/CfchGgs2SAp2x5NbLzjoiGl+Ef1Tz2vbY4jUTGVS6ihqk3v2A6f34aMQIsT2cVfK5zX3+aRu+9jpV0cqxSWr6plar6mxxLftsEKow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A+8uBCST; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb79177so29051465e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751318654; x=1751923454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9q3gCJ3fangaDb5c1I3OsLQwr4sawDCcfdZiz3Z3iv8=;
        b=A+8uBCSTxb8BvDROYGSXRzgZBeyfCEvGTTGSyDVqNPvDNM1FEVxTcqsRWRH/CEzzf2
         uDchSezWRKzpcpXEho1e6DgAUtkv/wqv03dP9UrreyOFITb/k7/IbSiNySIywStoKv5O
         J9cQ8EExs6JpYZoLxq/CK43bW1Y9pAm82qhR+mOMxP1Q3I+KVeFktxp6d2uaNn8uQwJE
         1wVcjteGRpIa4i2f3mM6AI66x9Yx++1YJX76S/OyBeMGl49K5OUmhm1klhGqMufHm7Rn
         m7FZRaw8sJFnwL6MRYNA5ipVfXBXdI+hvsN3aKfhF70kmgOcW3gmVWmdhAcP7PF6S5CQ
         6Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751318654; x=1751923454;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q3gCJ3fangaDb5c1I3OsLQwr4sawDCcfdZiz3Z3iv8=;
        b=D+ultoUmEqNxSqsWdy/NF8kaG33pOc17ZOR2PBJptJozglFR741RUyb6hsxXoDClie
         f+qofTSwecYkqxUiZFZEF46uO78Vh95l+82cdFx2FQHf0GAD30wEYhWPzeaEf+sHFyLQ
         okA4OPUJEaOTGRgTpGtvHy36MHiYPq4dkn+rRe6iuLCv/3C4bnb1Iu8frE3jW7x+NjpA
         q0OptD8bzskNaDRUlxTJT5bx371qdZL7SX1/gBF4KhKNOeOVYNquI73T0FQqtwr7itix
         2KphOrNfZ9hKngYOWQYvZeAH9i0ZxyFpvr24gsMOtC5XYaLg0XQZAsxxxYZAnUE2ikHk
         81VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zrd3Olv5EzC51Loub3lvjrf5al+gtgZkwHOe+UQbEVrfxabbNaOYL8d0Yxvy2Ke2k2oQ5bi0e086Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpoHuna2yfF5Uf5FdF+eQXep8m0cPLPEfMKYLU9x7P8M72B3KQ
	qmZVWaIRGeFUF9laBz26DbAE3x10yqgPCwHHkPH3i06Y0Ncoo63kJANgXm5Jn8yBQwLNW2lmmMS
	B3X4+
X-Gm-Gg: ASbGncvDZx7gC1HRn9CDhk9QSn0JQgkH8Z+6yYs4plMObuVwm4iyd/lvUnjMsf6ovct
	Tur9mqATLMDVz5l5ZX+gLqhOH+2pW0iYwjiJ9hHvmPwVE2z+MVwFjwZLR/vLGtbwVPdTV5NsGVi
	ivGYrLbu4Pit45/q6Ojszrlaoadmqw4ETnSuLvRu4Oit6eyBQQIM0Zauevcmrbg4AKYJud0HXfh
	RvSH56UXvFJ/lnY81A6XIKoTVJVSdudzKH8MhPl4ItA+cNANzrRv+xXVSS8chCws3vfiuqEevyR
	b+Y7jm+V2sP+12xfJdLvoj4onLZV6Vu8kZtNykvyGR1MOSsLUSzIhIFo2Nx/LXtSIPtARoWOD9D
	bD6+zs/rGRI9DfA==
X-Google-Smtp-Source: AGHT+IFatFzSqjE3IV2Nb/G0jrp2GHNZtNKIhleS/5XtzwilWtdB5fboa/SPJnO3a7Xzm148jHT2ag==
X-Received: by 2002:adf:9c92:0:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3a8ffcca333mr9569260f8f.36.1751318653611;
        Mon, 30 Jun 2025 14:24:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ba55asm88389725ad.198.2025.06.30.14.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 14:24:13 -0700 (PDT)
Message-ID: <5ac95d1f-ae5e-4251-b1b1-7c42aeb77f24@suse.com>
Date: Tue, 1 Jul 2025 06:54:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: qgroup: remove no longer used
 fs_info->qgroup_ulist
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1751288689.git.fdmanana@suse.com>
 <6051db0c1a943d7f896fbb5b9cd548908e161ed0.1751288689.git.fdmanana@suse.com>
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
In-Reply-To: <6051db0c1a943d7f896fbb5b9cd548908e161ed0.1751288689.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/30 22:37, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's not used anymore after commit 091344508249 ("btrfs: qgroup: use
> qgroup_iterator in qgroup_convert_meta()"), so remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks a lot for catching this.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c |  1 -
>   fs/btrfs/fs.h      |  6 ------
>   fs/btrfs/qgroup.c  | 31 +------------------------------
>   3 files changed, 1 insertion(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f6fa951c6be9..ee4911452cfd 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1947,7 +1947,6 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
>   	fs_info->qgroup_tree = RB_ROOT;
>   	INIT_LIST_HEAD(&fs_info->dirty_qgroups);
>   	fs_info->qgroup_seq = 1;
> -	fs_info->qgroup_ulist = NULL;
>   	fs_info->qgroup_rescan_running = false;
>   	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
>   	mutex_init(&fs_info->qgroup_rescan_lock);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b239e4b8421c..a731c883687d 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -740,12 +740,6 @@ struct btrfs_fs_info {
>   	struct rb_root qgroup_tree;
>   	spinlock_t qgroup_lock;
>   
> -	/*
> -	 * Used to avoid frequently calling ulist_alloc()/ulist_free()
> -	 * when doing qgroup accounting, it must be protected by qgroup_lock.
> -	 */
> -	struct ulist *qgroup_ulist;
> -
>   	/*
>   	 * Protect user change for quota operations. If a transaction is needed,
>   	 * it must be started before locking this lock.
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8fa874ef80b3..98a53e6edb2c 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -397,12 +397,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>   	if (!fs_info->quota_root)
>   		return 0;
>   
> -	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
> -	if (!fs_info->qgroup_ulist) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
>   	path = btrfs_alloc_path();
>   	if (!path) {
>   		ret = -ENOMEM;
> @@ -587,8 +581,6 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>   		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
>   			ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
>   	} else {
> -		ulist_free(fs_info->qgroup_ulist);
> -		fs_info->qgroup_ulist = NULL;
>   		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
>   		btrfs_sysfs_del_qgroups(fs_info);
>   	}
> @@ -660,13 +652,6 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
>   	}
>   	spin_unlock(&fs_info->qgroup_lock);
>   
> -	/*
> -	 * We call btrfs_free_qgroup_config() when unmounting
> -	 * filesystem and disabling quota, so we set qgroup_ulist
> -	 * to be null here to avoid double free.
> -	 */
> -	ulist_free(fs_info->qgroup_ulist);
> -	fs_info->qgroup_ulist = NULL;
>   	btrfs_sysfs_del_qgroups(fs_info);
>   }
>   
> @@ -1012,7 +997,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   	struct btrfs_qgroup *qgroup = NULL;
>   	struct btrfs_qgroup *prealloc = NULL;
>   	struct btrfs_trans_handle *trans = NULL;
> -	struct ulist *ulist = NULL;
>   	const bool simple = (quota_ctl_args->cmd == BTRFS_QUOTA_CTL_ENABLE_SIMPLE_QUOTA);
>   	int ret = 0;
>   	int slot;
> @@ -1035,12 +1019,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   	if (fs_info->quota_root)
>   		goto out;
>   
> -	ulist = ulist_alloc(GFP_KERNEL);
> -	if (!ulist) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
>   	ret = btrfs_sysfs_add_qgroups(fs_info);
>   	if (ret < 0)
>   		goto out;
> @@ -1080,9 +1058,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   	if (fs_info->quota_root)
>   		goto out;
>   
> -	fs_info->qgroup_ulist = ulist;
> -	ulist = NULL;
> -
>   	/*
>   	 * initially create the quota tree
>   	 */
> @@ -1281,17 +1256,13 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   	if (ret)
>   		btrfs_put_root(quota_root);
>   out:
> -	if (ret) {
> -		ulist_free(fs_info->qgroup_ulist);
> -		fs_info->qgroup_ulist = NULL;
> +	if (ret)
>   		btrfs_sysfs_del_qgroups(fs_info);
> -	}
>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>   	if (ret && trans)
>   		btrfs_end_transaction(trans);
>   	else if (trans)
>   		ret = btrfs_end_transaction(trans);
> -	ulist_free(ulist);
>   	kfree(prealloc);
>   	return ret;
>   }


