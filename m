Return-Path: <linux-btrfs+bounces-4423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C58AAA38
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 10:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A532283824
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002751004;
	Fri, 19 Apr 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BuQ5FfZp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604534C8A
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515576; cv=none; b=c25M0xpe5SHv1ohFrUIRZcSp3QJ9LbID5p97kVS+ypslV9EvW7iuHPo4GjyGqDX+zX0iXeB0fv+k9Q6ptao96BqedpjiTyJdCqHKbozBFcp4kL17HeQPRaEoFsvoDj6qON2S+UgkpmpmOcf4aagUFjaXJioCvQ0GzY8RbPc0ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515576; c=relaxed/simple;
	bh=jmX+mm4lsiEogbVMULBEA+8QPZ4ejLszCFuiSk2v3AY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sAjUkPRZEd5bV0kKPBCr01svg+kiJ9M8u9fASN8ghLczT/qS4IqPIx0e5QcANGozMPn0qDKxTiQeSSDkUHG07KLxRhoVdGUNCT6Ga3M+5u953+tNwvP4l3HZn0zJMtXyTMuYAEovT8QJnXRGbSayuFWzKF9ThptBTILuB8wQrio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BuQ5FfZp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d094bc2244so23107901fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713515572; x=1714120372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/92wZKMdWeqmUIeQ98qu23M4tXJ4I3ECkZbIsS5twcQ=;
        b=BuQ5FfZpkM/iBDJFW6NCH1pCrBfz925nzI6vvamphIptVdxG3cqX72JFrcMu2ziScP
         CwsXND1P8WLLx+wBcQCSFbGq3p58KS9JtWd8a6kh8rXXBd5rwkDU14XfaDrJMeEynNSK
         NPbBtmO2p7c3gcvfg+ahxg7cAGHGKJbXq7eIvHbE600E1eeVTfx1bNeYbFokhIOrKHYt
         RYllZ/1ltC1oltF/8BKz7973k9Zo9vFUOWA4MOxiCk+a3bS0fHcJkTNe5+8iyeq5c8s2
         g5eczjYwqm5vZUXSQiMSnTUoqUpxbwU9SRwOEBzrh8fCNApDKBghwUpwCHX7vP/2OkNF
         3EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713515572; x=1714120372;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/92wZKMdWeqmUIeQ98qu23M4tXJ4I3ECkZbIsS5twcQ=;
        b=NuPOhalSe9PEJV7TZvNdBjBBYAz7Q6B9FT1z7TMRDqL5Hp4DCm3kpZpJOrEDdBDkOt
         w9eOD5tS/fXiM90QAysk+78ft/InybQ/1Xn0Xzw0Fp8HiKKPecQ9K3tAMR3UX7/GYKwF
         BEUEMbW/VyjeQw/30pP87lsNcG1MjtDpCSOjKQB58Ul/J/yKmsW59r0kLDDoLRXQ/jJH
         14jz7mO2a/XI/wc9C1SXFB1j6rO2cJXRSas/y5lKq3lJQZJQg+Smc2HEHlgzJmmpeQUZ
         jvu8KFkkzQ1eVIx9aJXx61qCf/Mf+RzHwvoDbEmFGQlKKjyxAUxJ4cm7jzhJO9H6BJp7
         XhMA==
X-Gm-Message-State: AOJu0YxNdY/Z0Hvzs37BeDREiXpsQyPcFdSLBrnXqdc6SObD05VzQ7jG
	ckEEaYRv0NBk9TJtOrJmI0auRG75x7vGBhVpquigjkJWly4i5PdItEcJEW7k4a6lpz2/TB+eIPr
	5
X-Google-Smtp-Source: AGHT+IGtbHlz/w3myI1VbfbcoowYqwihaWE/T98IgqSJoPc2U367VVDNFcH/nC8Mmtvwr64FyEM/Qg==
X-Received: by 2002:a2e:911a:0:b0:2d9:fe84:a485 with SMTP id m26-20020a2e911a000000b002d9fe84a485mr787149ljg.29.1713515572404;
        Fri, 19 Apr 2024 01:32:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y7-20020a634947000000b005dc491ccdcesm2562519pgk.14.2024.04.19.01.32.50
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 01:32:51 -0700 (PDT)
Message-ID: <58795dd2-44bb-44b5-bae6-17fc03ed4740@suse.com>
Date: Fri, 19 Apr 2024 18:02:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: slightly loose the requirement for qgroup
 removal
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1713508989.git.wqu@suse.com>
 <acdae2db72282b45ff6d2e11df788a9b146ffe92.1713508989.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <acdae2db72282b45ff6d2e11df788a9b146ffe92.1713508989.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/19 16:20, Qu Wenruo 写道:
> [BUG]
> Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
> and a snapshot with level higher than that value is dropped, btrfs will
> not be able to delete the qgroup until next qgroup rescan:
> 
>    uuid=ffffffff-eeee-dddd-cccc-000000000000
> 
>    wipefs -fa $dev
>    mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
>    mount $dev $mnt
> 
>    btrfs subvolume create $mnt/subv1/
>    for (( i = 0; i < 1024; i++ )); do
>    	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
>    done
>    sync
>    btrfs subv snapshot $mnt/subv1 $mnt/snapshot
>    btrfs quota enable $mnt
>    btrfs quota rescan -w $mnt
>    sync
>    echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
>    btrfs subvolume delete $mnt/snapshot
>    btrfs subv sync $mnt
>    btrfs qgroup show -prce --sync $mnt
>    btrfs qgroup destroy 0/256 $mnt

My bad, the target qgroup show be 0/257.

Would update the commit message.

Thanks,
Qu
>    umount $mnt
> 
> The final qgroup removal would fail with the following error:
> 
>    ERROR: unable to destroy quota group: Device or resource busy
> 
> [CAUSE]
> The above script would generate a subvolume of level 2, then snapshot
> it, enable qgroup, set the drop_subtree_threshold, then drop the
> snapshot.
> 
> Since the subvolume drop would meet the threshold, qgroup would be
> marked inconsistent and skip accounting to avoid hanging the system at
> transaction commit.
> 
> But currently we do not allow a qgroup with any rfer/excl numbers to be
> dropped, and this is not really compatible with the new
> drop_subtree_threshold behavior.
> 
> [FIX]
> Instead of a strong requirement for zero rfer/excl numbers, just check
> if there is any child for higher level qgroup, and for subvolume qgroups
> check if there is a corresponding subvolume for it.
> 
> For rsv values, just do a WARN_ON() in case.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/qgroup.c | 48 ++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9a9f84c4d3b8..e6fcce4372a4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1736,13 +1736,38 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   	return ret;
>   }
>   
> -static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
> +static bool can_delete_qgroup(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_qgroup *qgroup)
>   {
> -	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
> -		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
> -		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
> +	struct btrfs_key key;
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	/* For higher level qgroup, we can only delete it if it has no child. */
> +	if (btrfs_qgroup_level(qgroup->qgroupid)) {
> +		if (!list_empty(&qgroup->members))
> +			return false;
> +		return true;
> +	}
> +
> +	/*
> +	 * For level-0 qgroups, we can only delete it if it has no subvolume
> +	 * for it.
> +	 * This means even a subvolume is unlinked but not yet fully dropped,
> +	 * we can not delete the qgroup.
> +	 */
> +	key.objectid = qgroup->qgroupid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = -1ULL;
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return false;
> +
> +	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
> +	btrfs_free_path(path);
> +	if (ret > 0)
> +		return true;
> +	return false;
>   }
>   
>   int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> @@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   		goto out;
>   	}
>   
> -	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
> +	if (!can_delete_qgroup(fs_info, qgroup)) {
>   		ret = -EBUSY;
>   		goto out;
>   	}
> @@ -1775,6 +1800,15 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Warn on reserved space. The subvolume should has no child nor
> +	 * corresponding subvolume.
> +	 * Thus its reserved space should all be zero.
> +	 */
> +	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
> +		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
> +
>   	ret = del_qgroup_item(trans, qgroupid);
>   	if (ret && ret != -ENOENT)
>   		goto out;

