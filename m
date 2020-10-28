Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD0329E067
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 02:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgJ1WE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgJ1WBe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BCAC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:01:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o9so289647plx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VNBscBROqyGL0f4jid9YWJItxWCHSstm95+t7n1tat0=;
        b=z20uBiUIlqUK+0INnVwk08250N/wIHsu5AbNOTA3NamCfaOo4klCtuKYenC7dTCBHP
         CJfoM036xdjcqvvfLlSxH8EHSu03yYEoaP5TwtQgU8C27wzGlKvbha4RMf4EmVIrOUUQ
         uZQJAWh+yQJM9X9bMxUK2k9iXCnbIrCNpYHbtgoo+GHwl7L4T1F/S5RcPceovX6L7kia
         ygjtSZI4wItJSU0/H+/4MynrEjZZGlU8z+zo+ZZtinyYLdP5OlyRmG9tM8I23zn6bJLl
         urBT9Ujv/THuVPhTR7uBH2B4nyy6Pfr1HRIJZEwGxV5kRBLp4RYA5t/UuqAL+lb0xxcI
         GeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VNBscBROqyGL0f4jid9YWJItxWCHSstm95+t7n1tat0=;
        b=M7jimTI1xQUYr/FBSTqrhI+YdHKcdEtF3i6AMEtq2Sk6ewjIeqjdldLh9jrh2BccNj
         QyWu9GDMxFEJef2DpGWwH/bRL9BPKRPttBGN3r9yOqiHg4pKzz+vdqBep9apqs3Gr6cP
         YYcHpZ7JaNIcXxF/OblZah4Bc7KC4OWN9hPYnNV0Pt8xu+0ePrzlIrg4Ao8Fxypfvkyo
         CkVWiEOzm0x3IhNXjgeG43pqkOgVXfXu4kKwTWtOqWU57/+oYkvhd5aAI+NwLZEVkpNE
         BtbSHJLE4AMiQAX1CLbsezEzSj4HxP4iL0Y/OoxFNI6DLhMwuM4B2tqjbZY+foV405kH
         C2OA==
X-Gm-Message-State: AOAM531kUOBduu4laHNPuJH0sbgO3BG/QYclKP4fnH9gVCRidgBY6id5
        z5NWRgqdCic826Mso7ip2tDdbEVbvkMEIVHa
X-Google-Smtp-Source: ABdhPJz8oMW3thxsxsUJ2b2Um2TqGoFetLlMapjqSqj0yeAxI7xjtrIIvHk/RQQHIt9fnV98ANEqLg==
X-Received: by 2002:a0c:b65b:: with SMTP id q27mr7654679qvf.8.1603893152640;
        Wed, 28 Oct 2020 06:52:32 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k15sm2888175qtq.11.2020.10.28.06.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:52:31 -0700 (PDT)
Subject: Re: [PATCH v5 02/10] btrfs: cleanup all orphan inodes on ro->rw
 remount
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1603828718.git.boris@bur.io>
 <56e0a8c18483c395d20fc6c69a42740d19742eb1.1603828718.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c59bbda1-4767-05f7-b71a-b988b3feae1a@toxicpanda.com>
Date:   Wed, 28 Oct 2020 09:52:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56e0a8c18483c395d20fc6c69a42740d19742eb1.1603828718.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/27/20 5:07 PM, Boris Burkov wrote:
> When we mount a rw file system, we clean the orphan inodes in the
> filesystem trees, and also on the tree_root and fs_root. However, when
> we remount a ro file system rw, we only clean the former. Move the calls
> to btrfs_orphan_cleanup() on tree_root and fs_root to the shared rw
> mount routine to effectively add them on ro->rw remount.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/disk-io.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index bff7a3a7be18..95b9cc5db397 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2826,6 +2826,14 @@ int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
>   	if (ret)
>   		goto out;
>   
> +	down_read(&fs_info->cleanup_work_sem);
> +	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
> +	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
> +		up_read(&fs_info->cleanup_work_sem);
> +		goto out;
> +	}
> +	up_read(&fs_info->cleanup_work_sem);

This triggers

ERROR:ASSIGN_IN_IF: do not use assignment in if condition
#10: FILE: fs/btrfs/disk-io.c:2910:
+       if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||

total: 1 errors, 0 warnings, 29 lines checked

I'm not sure I agree with this check, Dave what's your opinion?  Thanks,

Josef
