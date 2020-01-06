Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F31315F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFQVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:21:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39599 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:21:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so39889063qko.6
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3TBndYW71mpg6cZLWvwNaPkzAd9sbyB9ZbtfouFhmfM=;
        b=bDR4kdS95TG63SP2eKRSfsBtj/LH9d3jBNAp4VUBJ9xfAIsA1ZC9of2Nr4knZChGHy
         DC15JHq6y+arY6MQDRyuNDn8LTSwZH4pUMJL6R4T+8CVnYT/B4119JTTaw75NSY1GRjK
         VutiMEO/uFQQdcHfuJhUnFF9Vh1fbl6Vo+qvsMiTsqT0DAFGKb04161ZpJ9GDetE1eTP
         /GGzWWZUNDE/UMOFjlfz/1AL1ZrntW39GvHaa5IROAprHVS8Pgnb7L/LMSDgoHYiSvEj
         Ejy6SYzjjp9s9fIx+DE9MGNxF+maRxhAKDZ1d9nio4iF3iYk2JudPeKBnnV/4YDvvp+i
         EtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3TBndYW71mpg6cZLWvwNaPkzAd9sbyB9ZbtfouFhmfM=;
        b=LKR4d44N95KLWwA2xw9p+tYfZHAEXpZYrfKP61YUuj2Xefh9Wwf6AvchMTveXzVeWs
         qGzOQAy9U0bKVg4cA+lBm3lDvsl0JTzGnXh51Q7jBCtgEggNsuHiNv/s+vFnF3EoP90n
         QqmgOiGIL3lBNzlwM/uNxOTdnhr7/gq2QPDesaZ+sjtQ1+KgDj14qJW3ojqZ4MNwDRKw
         HgA281Oo8/XTpHpVXuI5+RPEslCu63OvDSfbbmX5RD/n2doE1xPDz6ppL2FxyFsJTJxf
         +///lC24b0BsqCK6cIDPGHNYCbR51E0DaBFTUrDfYgpSdMdxwASbNV84DG/0wjJPgcdY
         aYlg==
X-Gm-Message-State: APjAAAUWaE1mTN6CR3ruHPhKaVunzq9h2JNZrR0PfnOCWAj4tX2IJB+5
        30IHxOisdkt5HjQ8B3XEzSKueQfh6nzMvw==
X-Google-Smtp-Source: APXvYqxqScCQDfFjK7yixRvyGDxIRLRLdMTHeCfdYUw9jLmj0ztkJPMA43uxDf1fP8N36o1VP10vQg==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr80834367qkh.3.1578327712469;
        Mon, 06 Jan 2020 08:21:52 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id d1sm23492976qto.97.2020.01.06.08.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:21:51 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: sysfs, add read_policy attribute
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     btrfs-list@steev.me.uk
References: <20200105151402.1440-1-anand.jain@oracle.com>
 <20200105151402.1440-3-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a3e99d85-80c5-5ad3-cda3-75834e1f7441@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:21:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200105151402.1440-3-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/20 10:14 AM, Anand Jain wrote:
> Add
> 
>   /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1 and raid10 chunks can be
> tuned.
> 
> When this attribute is read, it shall show all available policies, and
> the active policy is with in [ ], read_policy attribute can be written
> using one of the items showed in the read.
> 
> For example:
> cat /sys/fs/btrfs/UUID/read_policy
> [by_pid]
> echo by_pid > /sys/fs/btrfs/UUID/read_policy
> echo -n by_pid > /sys/fs/btrfs/UUID/read_policy
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  1 +
>   2 files changed, 68 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index d414b98fb27f..ae2935184d75 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -642,6 +642,72 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
>   
>   BTRFS_ATTR(, checksum, btrfs_checksum_show);
>   
> +static const inline char *btrfs_read_policy_name(enum btrfs_read_policy_type type)
> +{
> +	switch (type) {
> +	case BTRFS_READ_BY_PID:
> +		return "by_pid";
> +	default:
> +		return "null";
> +	}
> +}
> +
> +static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> +				      struct kobj_attribute *a, char *buf)
> +{
> +	int i;
> +	ssize_t len = 0;
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
> +		if (len)
> +			len += snprintf(buf + len, PAGE_SIZE, " ");
> +		if (fs_devices->read_policy == i)
> +			len += snprintf(buf + len, PAGE_SIZE, "[%s]",
> +					btrfs_read_policy_name(i));
> +		else
> +			len += snprintf(buf + len, PAGE_SIZE, "%s",
> +					btrfs_read_policy_name(i));
> +	}
> +
> +	len += snprintf(buf + len, PAGE_SIZE, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
> +				       struct kobj_attribute *a,
> +				       const char *buf, size_t len)
> +{
> +	int i;
> +	char *stripped;
> +	char *policy_name;
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> +
> +	policy_name = kstrdup(buf, GFP_KERNEL);
> +	if (!policy_name)
> +		return -ENOMEM;
> +
> +	stripped = strstrip(policy_name);
> +	if (strlen(stripped) > BTRFS_READ_POLICY_NAME_MAX) {
> +		kfree(policy_name);
> +		return -EINVAL;
> +	}

We have the len passed to us, let's do the length check _before_ we arbitrarily 
kstrdup().  Thanks,

Josef
