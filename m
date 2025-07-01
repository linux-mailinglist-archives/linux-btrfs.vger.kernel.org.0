Return-Path: <linux-btrfs+bounces-15184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE55AF067E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2680D16017A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D0288C17;
	Tue,  1 Jul 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U9vA0ayq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A363266560
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408575; cv=none; b=j+BBnFT7dHJQ4GBncEIP+XwIVixm02qHD/4RkYrF6pyT6IKkrXxfa6d3fbkA8vvwk3BLzFGLVh9noge8uYKq8/mTPNNNJv50NXhGLnt/dDkzU5pkKz3++inru4NY++uqQjnEKaVpY0nDwxynLjDHe1lhwuxlLOAOiS2L3xnHI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408575; c=relaxed/simple;
	bh=TYpsgls0RnGK9Yb2qoNNfV022/u0nfk8kbnWeHObHe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UnO3PZ4gh3yA5sIgIFBMiegNajm3/vhZeuEQmQqHKuqBLnuPJ4oxYGtEwTNxSJnNL8OJ0O/08aOLkosIr3scMsuXJH6O1gJ8LnmnF1D/beeueCW0EfbojOZd8JKIpjvwuzf8DfViG1Avk+iMssA4u9y/OzA1hKQ2CEnNfAzBy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U9vA0ayq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf214200so31382765e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751408571; x=1752013371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMoxcANHDUr0a7TS3wDHgIA4pnVyJpi+grveeYobTZc=;
        b=U9vA0ayqf/jX6UCM4pLL9fYoPgRoOzmeA3kH5hs4Ocg1jpn5fr80PepZpxOP4v3htK
         b9CIstDCY4VWpbHblrmgbtJq/2z4k8cZ9J303hhMjtASYmdoYjPdlmPYT5USDBo9XBWG
         hv05EkoXzL5QW1QJ7bQ4N1d6oTeNKTtNRda9NIb3YLQxiDL1/70Jzn0C6JblPYphxbRp
         zUKBHdapd08CcckDGbqUnXABlpI+2MHDvX3LsJLA4Fg295O1JGq3GsNw9xvnUQZttFiP
         phBXO8VoQBQ8uHFROWHUQ/UG/OwQJEcxfIW3zvNzxOEUtJc9t4OgMGmL4Vb5EI+Eby1X
         kNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751408571; x=1752013371;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMoxcANHDUr0a7TS3wDHgIA4pnVyJpi+grveeYobTZc=;
        b=by6DmjYl8pftV5TNRTuHDMIm5iXAiF7akBZOlgQ+M055+xP/CSr/jxo2jHXrp54cnD
         ma7PxVj/gYgWDFuoth6AAzd7ENGP1pzzY0/jLQYcPUQ561FjMsCcqznJdGLzMPdjCtlE
         JMRS7qew/lbTH5FGdo0dr4OdMFGdqGCetATlZHToXOFYj8qxUBLmI0/xpILFLGXa9RRH
         caGCh763xr8RABO/4tJRXx90w+5Rrh16vKUz26mhfXHIDz+mWjlTLdf3PnIAWT2wd5N6
         C2lfrlcMLzafrnbNtePiQ8+zT8exEBC7TO5QhI5mz5Z9deeYYVKDGVcqyah7a5dOxbWy
         B9zA==
X-Forwarded-Encrypted: i=1; AJvYcCW3gnvbQVtBo0pfYafGWPhjd8XrAGoQ/+5bvK8AwI3yDzX23o9/RiM6NC6cQ+lCCCbrVcq8gHimRcZ2+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6D7b1THVIgPAXvtqVyRdtWa/OrYS3OL+jaLl2UgNAyYljgkI
	ozhnYIvuA9JaBekwRypIZRzI41FoTuNZFnoh4Fs45XiXJ3xEl/Occ0vjONoa56frNDYUKYCEevC
	Z4qbv
X-Gm-Gg: ASbGncsDa7OT47vkEC9056bgaffSUF0f3Z5OXOvKWiugk2412oFVN5E6+5QvvkTb5Tb
	lnkHDkWKFZTayupncrxwF1i4gR1JhdbrEEc0IJ/qyJOySbYc913rFOgg+zjyATWlf7iqHyT/h+X
	36Kk5eaV2iEb1ncGATLm5ptO2ajXA21JbYSs0A9h1HXQPSRJ3UWHQVDuZheGaUcS4LWQg65u7OA
	WpxT/yfpAiD4nWDmMJQ74TBR5Xu5nhkCPMpogb3lVuokz0Jh0Y4WQGNYmVD4ak8tzSL35qPFY6n
	TiQlXzzne+VdzyRhIpxV1KTK0t87ovs2eWVcEts7UlBKplHW/th4BJy/gk9s2c6aoSH+K+CpEPJ
	CG/YwJL4EJH6+Uw==
X-Google-Smtp-Source: AGHT+IEmH0uY+amudehgcKy0UMY53KIfZOTPigex67lbDYTIM+WA0IauwNkOEJoTWpABAn7bVogiFg==
X-Received: by 2002:a05:6000:64b:b0:3a4:ef33:e60 with SMTP id ffacd0b85a97d-3b20067c810mr118585f8f.40.1751408571036;
        Tue, 01 Jul 2025 15:22:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c5a8csm115510585ad.223.2025.07.01.15.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:22:50 -0700 (PDT)
Message-ID: <25210267-fc5c-4b67-a59c-66c2616931bc@suse.com>
Date: Wed, 2 Jul 2025 07:52:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: qgroup: fix qgroup create ioctl returning
 success after quotas disabled
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1751383079.git.fdmanana@suse.com>
 <9a550560f176ad2ad5a2f3a0b1900175e574dd7b.1751383079.git.fdmanana@suse.com>
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
In-Reply-To: <9a550560f176ad2ad5a2f3a0b1900175e574dd7b.1751383079.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/2 01:12, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When quotas are disabled qgroup ioctls are supposed to return -ENOTCONN,
> but the qgroup create ioctl stopped doing that when it races with a quota
> disable operation, returning 0 instead. This change of behaviour happened
> in commit 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot
> creation").
> 
> The issue happens as follows:
> 
> 1) Task A enters btrfs_ioctl_qgroup_create(), qgroups are enabled and so
>     qgroup_enabled() returns true since fs_info->quota_root is not NULL;
> 
> 2) Task B enters btrfs_ioctl_quota_ctl() -> btrfs_quota_disable() and
>     disables qgroups, so now fs_info->quota_root is NULL;
> 
> 3) Task A enters btrfs_create_qgroup() and calls btrfs_qgroup_mode(),
>     which returns BTRFS_QGROUP_MODE_DISABLED since quotas are disabled,
>     and then btrfs_create_qgroup() returns 0 to the caller, which makes
>     the ioctl return 0 instead of -ENOTCONN.
> 
>     The check for fs_info->quota_root and returning -ENOTCONN if it's NULL
>     is made only after the call btrfs_qgroup_mode().
> 
> Fix this by moving the check for disabled quotas with btrfs_qgroup_mode()
> into transaction.c:create_pending_snapshot(), so that we don't abort the
> transaction if btrfs_create_qgroup() returns -ENOTCONN and quotas are
> disabled.
> 
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Since create_pending_snapshot() is called during 
btrfs_commit_transaction(), we're safe from a btrfs_quota_enable() call 
as it requires a trans handle.

So there will not be a race between create_pending_snapshot() and 
btrfs_quota_enable().

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/qgroup.c      | 3 ---
>   fs/btrfs/transaction.c | 6 ++++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index eb1bb57dee7d..ae9bc7c71a34 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1662,9 +1662,6 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	struct btrfs_qgroup *prealloc = NULL;
>   	int ret = 0;
>   
> -	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> -		return 0;
> -
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
>   	if (!fs_info->quota_root) {
>   		ret = -ENOTCONN;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 2e07c90be5cd..c5c0d9cf1a80 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1735,8 +1735,10 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   
>   	ret = btrfs_create_qgroup(trans, objectid);
>   	if (ret && ret != -EEXIST) {
> -		btrfs_abort_transaction(trans, ret);
> -		goto fail;
> +		if (ret != -ENOTCONN || btrfs_qgroup_enabled(fs_info)) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto fail;
> +		}
>   	}
>   
>   	/*


