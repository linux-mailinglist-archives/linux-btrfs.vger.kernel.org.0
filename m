Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8886306033
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhA0Pud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbhA0PnV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:43:21 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:42:41 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id p5so1232038qvs.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WeQalZ8UFKuQoZez+lNEwBLovMJkRC/g2YE3Sc7rV2A=;
        b=Y5HkyU2xtFBZo142s2YbPghTHHLRwZI7mqAnhSa1Wy8kAHwigRW5GjwcDxSzuAyQgq
         A72L209E60oBCsHiTJ1oYBtDL2C6AUpRNX5/ichbbBXmPU+2nlLYFmzGiPe2sJEnnbB4
         2/T9vDn3XGtnp+sB4YfaeKZeKyZ77lNpX87By8GXsIhmKGAxCdxsM8784SkdnaVWT7nq
         /H6VR6pgTPb0hy5r5TCrVakZC4B4PrQlZQ5Y2F4O90fG9N1nTe8S/Dwrw+xlKSlkTr0d
         FjueAo8Ibl2bL6OiaSkdT5ITR1a222MD4MveMO4fseN8kN7gjWCicBx9w4eUNQIUJ6Ro
         gjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WeQalZ8UFKuQoZez+lNEwBLovMJkRC/g2YE3Sc7rV2A=;
        b=FBhyhpKSvsKaEo/b69lOcAh4v6zqlklEPsdYGQdO+ar/3BOXcS1eOQmc1HJ7M4WhLn
         CxAnIiG8Y4gCZDiKA2dmA++erYrtms1oGuAOttSfZvRZDbw+kzSrS3gCM8/zaQw1G3Jb
         R7xDxEuZVOnSv8ObVEduRQoZt7T9jSx/c6O/fQc0QQY6S8RhoVx7u068D+4tJHqngemR
         hviFbQF3yPSPEIjP93ZCwpfuC1mNMxXFH+u24H8SM1O4SVhnGli65s41Co9FYp1ILSDn
         QEcQOBAGoutc6w47Zr9Dh4XlzKYENCsWHmEWTv3EZ1pqz2VoljsPDShvv0Sii/Ya94Zf
         zA9g==
X-Gm-Message-State: AOAM532IHq6DWykFW+KPV14bKBcfetf84Tyo25+uvzWVSMDMkKJpgMZV
        u3chY3zo56QCfS4ZlQJ1imSUliLg/tEl2eSj
X-Google-Smtp-Source: ABdhPJzbZqYZyAGpFJvSGFkuczn8boSxXeRrQzScerJb1lkLEx4EeabjpRjVypgkBcLXu0awcSrDVw==
X-Received: by 2002:ad4:5241:: with SMTP id s1mr10813351qvq.36.1611762159718;
        Wed, 27 Jan 2021 07:42:39 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 196sm1374233qkn.64.2021.01.27.07.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:42:39 -0800 (PST)
Subject: Re: [PATCH 0/7] btrfs: more performance improvements for dbench
 workloads
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1611742865.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <91fb4c24-8642-1dbf-8ae6-08baea8badce@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:42:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1611742865.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 5:34 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset brings one more batch of performance improvements
> with dbench workloads, or anything that mixes file creation, file writes,
> renames, unlinks, etc with fsync like dbench does. This patchset is mostly
> based on avoiding logging directory inodes multiple times when not necessary,
> falling back to transaction commits less frequently and often waiting less
> time for transaction commits to complete. Performance results are listed in
> the change log of the last patch, but in short, I've experienced a reduction
> of maximum latency up to about -40% and throuhput gains up to about +6%.
> 
> Filipe Manana (7):
>    btrfs: remove unnecessary directory inode item update when deleting dir entry
>    btrfs: stop setting nbytes when filling inode item for logging
>    btrfs: avoid logging new ancestor inodes when logging new inode
>    btrfs: skip logging directories already logged when logging all parents
>    btrfs: skip logging inodes already logged when logging new entries
>    btrfs: remove unnecessary check_parent_dirs_for_sync()
>    btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
> 
>   fs/btrfs/file.c        |   1 +
>   fs/btrfs/transaction.c |  39 +++++++--
>   fs/btrfs/transaction.h |   2 +
>   fs/btrfs/tree-log.c    | 195 ++++++++++++-----------------------------
>   4 files changed, 92 insertions(+), 145 deletions(-)
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series, thanks,

Josef
