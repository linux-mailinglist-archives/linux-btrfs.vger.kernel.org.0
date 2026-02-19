Return-Path: <linux-btrfs+bounces-21777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMRdG4fdlmlJpgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21777-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 10:53:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CD15D8C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA703015A5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A73093C7;
	Thu, 19 Feb 2026 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XNufQCt3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839E1E8320
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494787; cv=none; b=cNRDNx7sX7HQ1yDF/BGTb3bvQdLg9F9ZLLOSg2hAK7sGN2LT0O2K1ErFRl2+w419s/6DV2gRFGW1u6KWfoXRAU1tB6aHmRDKcjVLYj+ghKyRa+x3NWDVnpdEt2hWjMqxwL4noaGwOHjM16okdd9IR2R+/mWcFiggHDquKGo4Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494787; c=relaxed/simple;
	bh=3HhSIwn4VBXD985+3dhTZeOVFBjE8aqWlNXmDHuOMwc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FRM+0AcQKxKlNz0MBnYCfSgXfrnWNLCJwyj2VvXLx/O/v3vZvdu6Q05rd+0KrdrxezHbVl75u3ZUeHHMgUHA+AiVCsI8Do98/tJLbcBTXL02W19+04YshjA8gAW2RH/mAqi7nK24WWH2NEkK14hGfqgK0CtLEk1Wz8Vcc3RjVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XNufQCt3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso8717445e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771494784; x=1772099584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnjPc6mWI9DTqy+hPC6IS8s6pf3Jrq2df++Mue0JOwM=;
        b=XNufQCt3DASAJ8uokgijOcMxQX+e+uQxpYtbEzcjzUs2ZU16YVAW8dJxFo7MJErHFr
         Ur/FJQ7jFzngTcLq3PTmxiNJxPD1mI6eXMaZw0CZXrFAv9OJNaliufJ+FbpnY45om9Ju
         CqZpUEYMICeX/1nSAaGj+8Kkb+KvEnhYqcP8CGHqgjYkaNXAIEVM0kLWwPpq5NXeGSsQ
         JaijdgF8NFptcVcBLJFzD/8I5p9xahCUwCSjfX7usjaFdFQzMVT8XjN21T8ThkLh0wC6
         ij2qisHz5qxTZF46sy/l22Eottep+tCPgQzynXS409WIbtkwNclngraq7DWQfEA5CT+x
         Lnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771494784; x=1772099584;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnjPc6mWI9DTqy+hPC6IS8s6pf3Jrq2df++Mue0JOwM=;
        b=P0u9BYRr6wI6cihDtjdCQBeymi7wd6mVHui9e64Sq5r3uvqJKXazrjh7pyESM/DzE8
         VSLdbEdSqiqbolciRFZdrrQSkylcdhPURAbxwBvj0+SbZXE9GVYAIzjca9/LstbQBT2Z
         kW8bH2CqIInyULIuGlfFQOwUSIhwOmJKJOUwvwNCg3Sl2cguRzpVZRwB1xDSLnZj41BO
         WamRg7+nrK6T/713WPHGyMGXmKxQYJpjeum/0BbLK7SMpYKoYaEbechMJ3uIweEuDOzb
         675FE+ZOXhgdLN9jQJlcWnuBW6szAbKK2zNDt/vUR1N+2+pWnN+N3gTDV5vBI8Ok0gm6
         zCfw==
X-Gm-Message-State: AOJu0Ywf4vSG1T/vq8XaDx95Thr4hPaKtmGKLrSbUX5wNniJKcRs97N0
	LrS1T82+I+nD6r39OYRZppYOUtBqNowCdeyUdHes1IFNBulgWlHQNqBsmNjgtrUXMCNhXy2swcn
	cWYRVDmE=
X-Gm-Gg: AZuq6aLjy7btwwkQ/zXMWWIwJcI7zDLoblzXmqP1GlboTh+sZuEZIxdy7fkWlX18+kD
	bRRgA9FhCkvbWPExIC4FK99PSfnpgRr3luwVHJLDlRpLJEbAGMYPRuFY/ABvXa4AU0QqQlAJ+pA
	btz/QaRCAsjXW1ghoW4Grdq3P7oTnDehsL9Qz99qeZMU50m+RYxjHJ9rexf+dk2uGwtQsDUwJu5
	iZXJsQpHwPYaNUcf0umGt9z4pWINFKIR9eIf1Mx9id4ITK/L6syzwAcH8+uaoRZfS5pNZ9LW4Nl
	aJxwbFIIlRKy1ju8IEEE1xPv16a0gPjxS37h25bdXVl9eh+H0p9i5sBmKPzkN/smjc5LadWsnEO
	2LMndiPT41/RmAOg1aKhGK3lOucDQaESTRssb3wMvlgVnKpAO0RSxV+AW4cQ4Qc5Jk9eCAp+xe7
	r0DJ4YIVQ/lZwmibZYGbLmmvBe4TpZi4I7V0uHuvRRGRYiwzNQqGg=
X-Received: by 2002:a05:600c:698c:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-48379b932b7mr315091195e9.3.1771494783828;
        Thu, 19 Feb 2026 01:53:03 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb5596sm18713041b3a.58.2026.02.19.01.53.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:53:03 -0800 (PST)
Message-ID: <6a71fffc-d858-453c-bb75-88f92a08791c@suse.com>
Date: Thu, 19 Feb 2026 20:22:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: mark qgroup inconsistent if dropping a large
 subvolume
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21777-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7CD15D8C6
X-Rspamd-Action: no action

Gentle ping?

This should handle large subvolume without no snapshot better, with less 
hangs in qgroup accounting.

Thanks,
Qu

在 2025/12/19 16:23, Qu Wenruo 写道:
> Commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to avoid
> low stall in btrfs_commit_transaction()") tries to solves the problem of
> long transaction hang caused by large qgroup workload triggered by
> dropping a large subtree.
> 
> But there is another situation where dropping a subvolume without any
> snapshot can lead to the same problem.
> 
> The only difference is that non-shared subvolume dropping triggers a lot
> of leaf rescan in one transaction. In theory btrfs_end_transaction()
> should be able to commit a transaction due to various limits, but qgroup
> workload is never part of the threshold.
> 
> So for now just follow the same drop_subtree_threshold for any subvolume
> drop, so that we can avoid long transaction hang.
> 
> Unfortunately this means any slightly large subvolume deletion will mark
> qgroup inconsistent and needs a rescan.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent-tree.c | 10 ++++++++++
>   fs/btrfs/qgroup.c      | 14 ++++++++++++++
>   fs/btrfs/qgroup.h      |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1dcd69fe97ed..59fe3d89e910 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6151,6 +6151,16 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
>   		}
>   	}
>   
> +	/*
> +	 * Not only high subtree can cause long qgroup workload,
> +	 * a lot of level 0 drop in a single transaction can also lead
> +	 * to a lot of qgroup load and freeze a transaction.
> +	 *
> +	 * So check the level and if it's too high just mark qgroup
> +	 * inconsistent instead of a possible long transaction freeze.
> +	 */
> +	btrfs_qgroup_check_subvol_drop(fs_info, level);
> +
>   	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>   	wc->level = level;
>   	wc->shared_level = -1;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 14d393a5853d..4dfeed998c54 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4953,3 +4953,17 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>   	spin_unlock(&fs_info->qgroup_lock);
>   	return ret;
>   }
> +
> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 level)
> +{
> +	u8 drop_subtree_thres;
> +
> +	if (!btrfs_qgroup_full_accounting(fs_info))
> +		return;
> +	spin_lock(&fs_info->qgroup_lock);
> +	drop_subtree_thres = fs_info->qgroup_drop_subtree_thres;
> +	spin_unlock(&fs_info->qgroup_lock);
> +
> +	if (level >= drop_subtree_thres)
> +		qgroup_mark_inconsistent(fs_info, "subvolume level reached threshold");
> +}
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index a979fd59a4da..785ed16f5cc4 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -453,5 +453,6 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
>   bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
>   int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>   			      const struct btrfs_squota_delta *delta);
> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 level);
>   
>   #endif


