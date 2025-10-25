Return-Path: <linux-btrfs+bounces-18331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC2C08EFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 12:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EBAC4E20C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F792ED164;
	Sat, 25 Oct 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cSV+qqna"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592D2EA14D
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387538; cv=none; b=cBPKRxZMYK7gLvze+tXdlTjWEf7chFgKCZQWcI4IzlRQ/yAdWWd2Wbj+imQQT4v1EYwbHo1HLTK5uBnDUXDoEQ3wHGi9uIe6F/xRNOhHJV4epYL1lg/JUwXof8Q+LP0u1MfCARRNctBuy1SD/SOYnZA1kQsOjm82vF6eGM7/e7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387538; c=relaxed/simple;
	bh=ajAMYFZrYJezb0D2gTF3n3P0mWPwltlHSpRx5qDl0+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jjQu0QK6o2WO6TAd+fHTU0/ISGBXAy8Lq+8IcHt14p0HA7uYWa9SbPiU9RlskNDRg5wJv/BgyDQCwzej/sbRhlB+3bs3tsBBCPXNDFoi4ahCuVi+sJwoEsekUkuQO5SVnbf0L08J/E/cIYqhSYfKKldN9wYZym1S7eZhSJKe5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cSV+qqna; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so24418195e9.3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761387534; x=1761992334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XOX2IqknAaArjqQGx6GKDIJgGGPjjoxcTt/z68yUDPw=;
        b=cSV+qqnafAaK0MSkIAx+J7f+EzTXfKYC0tMLpB5VkLwuMi5fb7GC8JKO7J6w3dPhZD
         dAirrNAgThK9IwQShZS/yDlzUnmLvxa9Wo0vB36YdftHUsPW8vqvE9A03riGUWrREwmr
         IsST1Jr9GXCaYb+XNOQEKcv/C2osdjSWU6rGvnaSpgkCKxRORMwzoCu9oJc0I3vUU4lz
         gQ5leGGpuRE/wgAapDNOpLnIGF7qGwapzB+ASL1JQeTrskPStNqpViJ0orRgAYDYJaXL
         s3EwHCdkZblwzZ+uAdxsXx8QVQ88OkJrApukaRLEJbNt1UrYrTqYmvqZvoDMOgdK3JGf
         qKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387534; x=1761992334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOX2IqknAaArjqQGx6GKDIJgGGPjjoxcTt/z68yUDPw=;
        b=q4P3NYmUMi1PWLr9QCa9tA7OEN2/259kS9r4Kn3wSwXCwJn0bfLtLvmi9/KHjCKMBz
         hGkRfuiUB9VGolBvchJHw39ZS+ypWvn7dKnJIDUukoG/HtLkY5XTBxX+We0WeMLb042f
         efV1/DYv8avjmF0fprFk2TKSZhXQL+wIFsGV45rbc8RIxY/TO+y5gkh5F4aRmu+sQ7H3
         JAjOrXThfYogMAbCEdy8TEVOWA8b+CeE3hXAUWKT8fF933TOFTjYqsCptszuxLe5hZ08
         JGViViudqPbT1O4lKP2q7P4luLJOBFqPG/EH+nUbYKxjt8hSugAtaJzUDVxoYd8PWh4K
         iLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDXaFkaNxW76j/esCtwhubxDOdzJWe90c++igXULLvg36OG4exB7YDjMSLwJGe9JtAlF8Mj+nxogsoiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoObRchVIWa6vILT0D7vCNph/wgUHzr+/zbUa+aH3OADAPcJ5j
	ZoqPeJ0ntzg3K8IRA/E6kNtpdjp3Bxbqyd5WPBGkCTDXnDf3ly4IPF5rR1VkOcA/ZPHjpa/ep1p
	KeThP
X-Gm-Gg: ASbGncuzHlomFfSbtgxjbzQGrFMh1THZL84Sa64K0ypI3AweArnr7aHs/SmZvg2rcg/
	YiSiEFJ94FbqGLbnEZCKsoV/CfAtlz0Z2hM6Y//cP53BwZwjWVs2oosVTClggcxfIs8QdwqGSIb
	HplUIawHSYUS6n9bZ2DfQM4FDjn+2D5iQ4VcNw0XuY1zDcmav6Kwmd9MKRmcA3tonMwyCVrBHl+
	Zh+QrHGt0dOyA7Npmb8Z85hDsIk+a0o8UT1sw4ylPt36TNR7zGSdJ1KFgVI4h+uFnz2lhw7EEn5
	QUNgRK8EflJ4jAtdnFM52pitAPeqC7t3OEFoJRgoJEdTo34SoXHeX6aiyVjf0yTkH/az4Alc+3s
	0tUP8gXk7oBr63UOL2WCIDHGJDQiA4S4hEwwMAKw4KFiWxl8YwUQUvoxpQ4dskn8em38uQwel1Z
	S7MNT/jQcZFul2qBAlKLd5MXde2Dq0zvdCmMUcvk81PevfX6wZ9A==
X-Google-Smtp-Source: AGHT+IEETx4TGaug7rYlzE4I9daVbUimK2DPddVar2i0/lX80E/LbLSAjKxJiW8BPKZ46AEoCN99GQ==
X-Received: by 2002:a05:600c:3553:b0:471:a73:a9d2 with SMTP id 5b1f17b1804b1-471178a6484mr233038665e9.11.1761387534457;
        Sat, 25 Oct 2025 03:18:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a329sm18834215ad.36.2025.10.25.03.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 03:18:53 -0700 (PDT)
Message-ID: <5f6ba77e-6550-4bf0-97a3-65471de27b4c@suse.com>
Date: Sat, 25 Oct 2025 20:48:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when
 logging new name
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cf3df42390ff83be421dcdc375d072716a67d561.1761306236.git.fdmanana@suse.com>
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
In-Reply-To: <cf3df42390ff83be421dcdc375d072716a67d561.1761306236.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 22:22, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we are logging a new name make sure our inode has the runtime flag
> BTRFS_INODE_COPY_EVERYTHING set so that at btrfs_log_inode() we will find
> new inode refs/extrefs in the subvolume tree and copy them into the log
> tree.
> 
> We are currently doing it when adding a new link but we are missing it
> when renaming.
> 
> An example where this makes a new name not persisted:
> 
>    1) create symlink with name foo in directory A
>    2) fsync directory A, which persists the symlink
>    3) rename the symlink from foo to bar
>    4) fsync directory A to persist the new symlink name
> 
> Step 4 isn't working correctly as it's not logging the new name and also
> leaving the old inode ref in the log tree, so after a power failure the
> symlink still has the old name of "foo". This is because when we first
> fsync directoy A we log the symlink's inode (as it's a new entry) and at
> btrfs_log_inode() we set the log mode to LOG_INODE_ALL and then because
> we are using that mode and the inode has the runtime flag
> BTRFS_INODE_NEEDS_FULL_SYNC set, we clear that flag as well as the flag
> BTRFS_INODE_COPY_EVERYTHING. That means the next time we log the inode,
> during the rename through the call to btrfs_log_new_name() (calling
> btrfs_log_inode_parent() and then btrfs_log_inode()), we will not search
> the subvolume tree for new refs/extrefs and jump directory to the
> 'log_extents' label.
> 
> Fix this by making sure we set BTRFS_INODE_COPY_EVERYTHING on an inode
> when we are about to log a new name. A test case for fstests will follow
> soon.
> 
> Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c    | 1 -
>   fs/btrfs/tree-log.c | 3 +++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 79732756b87f..03e9c3ac20ed 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6885,7 +6885,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>   	BTRFS_I(inode)->dir_index = 0ULL;
>   	inode_inc_iversion(inode);
>   	inode_set_ctime_current(inode);
> -	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
>   
>   	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
>   			     &fname.disk_name, 1, index);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 65079eb651da..8dfd504b37ae 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -7905,6 +7905,9 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
>   	bool log_pinned = false;
>   	int ret;
>   
> +	/* The inode has a new name (ref/extref), so make sure we log it. */
> +	set_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
> +
>   	btrfs_init_log_ctx(&ctx, inode);
>   	ctx.logging_new_name = true;
>   


