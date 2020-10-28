Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889429DA7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 00:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgJ1XM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 19:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgJ1XL1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 19:11:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFC7C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 16:11:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r7so630574qkf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0WZMxCnzKvBjHtZp6eQihEfzgwm3X3erjjPZAu9r97w=;
        b=qbhiQ9+OCxOrOJkaRXqwVJGYuhjz89NwZrAHCAEqV5dkXXwyODqa4nBIIWKs3UXSSr
         2KOqK/sA9WMgCeWjFtntleiz/GRsAllUIxOX/6zwlJ5ZwXO8p0E3097Ri/XuN8E3/t+X
         xxhM4THRv12ndpsJVdEqSkGweBHP8mHFnPWjXeV2uO0IWOEja7s2iSktVNvXMtunsdqm
         l/peSFvAW8/qfhqzkH3/fomwLsIU2g0i1ljPNgHE9Y6uq7ojDG9ZBFaI85lhcOMcCSc6
         6NrWnPGuQV70RhqBDLsE05SGpXYfu/LnXRetgNMujrUwiGK6a9AbEe+tlFx8iWVeSmoI
         COsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WZMxCnzKvBjHtZp6eQihEfzgwm3X3erjjPZAu9r97w=;
        b=Ma39udYYgOyfd5sTdgw3rBKaCUP5jAQ+yUtI64sknvstMDN/94IOccr+OfWtfeiDQM
         AFOdbbbqSyZ0PTScxLzuJcDM4QBXn0f7p2enjy58FySar0AwihLYi+/xA5s70tmJ9Mcu
         XukkKQ1w2BC/hK0dLyVWZ3djeU7SLHyK0RaaRNmFeysQH/+XQpi8EnbCOAKNFUFPYf8Y
         zh8SO2EX01LbG13nAXo6YyttEFWMDrCxr5M5W2qf24fOccaRnGy253chWjOJa4JqXl3u
         f1Nq7t4ZNsKBpvea2kS84vFXO6gtowy5LvFJ5l77m8y5WyO2UGuhhNJ1J9WtCMHKfAyM
         Bd6w==
X-Gm-Message-State: AOAM530rlKzNQFwnq/oF51Dq9gbYFllaZfa6QluJ3uYGB0xVmmnoqsjF
        BROK8eHYJVd3Rn3HTl/10CCkzVTaycuFyBQC
X-Google-Smtp-Source: ABdhPJxQrdetQQziIaD7AF8/NvxSL5ntUEPQfc5VI4VgSufxaSWcnfyryxR4ufJfFefIsVmXincMNQ==
X-Received: by 2002:a05:622a:188:: with SMTP id s8mr1576336qtw.369.1603896278979;
        Wed, 28 Oct 2020 07:44:38 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u2sm2800788qtw.40.2020.10.28.07.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:44:38 -0700 (PDT)
Subject: Re: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <3ef863dea2d61ab41e5767ee935d5411c3117fa0.1603884539.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1c3a5069-45ce-fd91-1abd-4104095d2b12@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:44:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3ef863dea2d61ab41e5767ee935d5411c3117fa0.1603884539.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 9:26 AM, Anand Jain wrote:
> Add round-robin read policy to route the read IO to the next device in the
> round-robin order. The chunk allocation and thus the stripe-index follows
> the order of free space available on devices. So to make the round-robin
> effective it shall follow the devid order instead of the stripe-index
> order.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC: because I am not too sure if any workload or block layer
> configurations shall suit round-robin read_policy.
> 
>   fs/btrfs/sysfs.c   |  2 +-
>   fs/btrfs/volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  2 ++
>   3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index d2a974e1a1c4..293311c79321 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -908,7 +908,7 @@ static bool btrfs_strmatch(const char *given, const char *golden)
>   
>   /* Must follow the order as in enum btrfs_read_policy */
>   static const char * const btrfs_read_policy_name[] = { "pid", "latency",
> -						       "device" };
> +						       "device", "roundrobin" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7ac675504051..fa1b1a3ebc87 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5469,6 +5469,52 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>   	return ret;
>   }
>   
> +struct stripe_mirror {
> +	u64 devid;
> +	int map;
> +};
> +
> +static int btrfs_cmp_devid(const void *a, const void *b)
> +{
> +	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
> +	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
> +
> +	if (s1->devid < s2->devid)
> +		return -1;
> +	if (s1->devid > s2->devid)
> +		return 1;
> +	return 0;
> +}
> +
> +static int btrfs_find_read_round_robin(struct map_lookup *map, int first,
> +				       int num_stripe)
> +{
> +	struct stripe_mirror stripes[4] = {0}; //4: for testing, works for now.
> +	struct btrfs_fs_devices *fs_devices;
> +	u64 devid;
> +	int index, j, cnt;
> +	int next_stripe;
> +
> +	index = 0;
> +	for (j = first; j < first + num_stripe; j++) {
> +		devid = map->stripes[j].dev->devid;
> +
> +		stripes[index].devid = devid;
> +		stripes[index].map = j;
> +
> +		index++;
> +	}
> +
> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
> +	     btrfs_cmp_devid, NULL);
> +
> +	fs_devices = map->stripes[first].dev->fs_devices;
> +	cnt = atomic_inc_return(&fs_devices->total_reads);
> +	next_stripe = stripes[cnt % num_stripe].map;

This is heavy handed for policy decisions, just do something like

stripe_nr = atomic_inc_return(&fs_devices->total_reds) % num_stripes;
return stripes[stripe_nr].map;

There's no reason to sort the stripes by devid every time we call this.  Thanks,

Josef
