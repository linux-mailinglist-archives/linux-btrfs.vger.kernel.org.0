Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801B5212401
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgGBNAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgGBNAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:00:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947BC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:00:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j10so21078641qtq.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=65R/e5CJxwdEMY00s+ld9tnLhtV6OuqjmlZArYFW0YA=;
        b=UXBf/dR0QdC8swM1LwBWfAHCUVPfogGjXdigypP3NIWuhsTe8TUbR966kfMdKvw7Y8
         fc8TdxIYvfc7X0cUlhMfkzIKCOaYfmlaGg21GE+VPWd35ICcMjW/Btd62l801KsDku2m
         hdWPXeI1CAP4dWjFIKFuspjvtC9IbjZXMv/vtDhQ+ODHCMYmDgqxgGp0EoeAOaYQ5VEl
         XgzDVvB+Rbh+Y31epQON500FQfTwlpW5vMIdgo+pzs3W9X+5tPFpOkYnX6DHCw84H9Kz
         IOPbuTnxNdXfUG2PZYCm10yB5Ayzm5I7/6PXB4eTwINbR7+5J2FobYEeLCJJeKyxOc0I
         oi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65R/e5CJxwdEMY00s+ld9tnLhtV6OuqjmlZArYFW0YA=;
        b=JjR61rm9Tr1XXV9m4BZwJQ29UQxKqutOI0RBfQYHp5d9ulVaALvcrIHe2yJPyrOwNV
         iEMpOPicpIpbutydzhvz5sqtU/hhKig27zDTK/aaub69EoQfzJjX9nM9H7TlFBQnaSm6
         lMSLI2+tuks9LUUbXSSuuAGwnET8oixZ7tuuzx78hkPrvK3xCEZtN691o0Ppvnk6wcEw
         8++LjqQIoOkEvjhWyN/j9ibYXzIwt3d8/uwCw7eAsTx/asrR0qB2GojSxMdPp7ddlOCG
         PXYH8mFan9m8yKjFMKIiSdYVjgwHD/95CtT6ba5fj3oS2A6MCVBygWRlsdR4/C7RV0b2
         WSMw==
X-Gm-Message-State: AOAM531sO9G6SXBTEy1CtFklpMeO6SxpW15W5zvrFqfDfeF5aGAx1m9m
        YxaYxcorJ1+nfhDEBAQMr0BAF56JmQC65g==
X-Google-Smtp-Source: ABdhPJx8qYjqqr0Qlc2IYcvhHjTkB5i/WgJ/k4IIcYozruq7DJ1QmJFxAEVm0mAxImkaH666J3HJqw==
X-Received: by 2002:ac8:1c36:: with SMTP id a51mr31306410qtk.138.1593694803828;
        Thu, 02 Jul 2020 06:00:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d13sm7986717qkc.105.2020.07.02.06.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:00:03 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: only commit the delayed inode when doing a
 full fsync
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200702113159.153135-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fea5eee9-95ff-c8a8-4f1f-3682378d1813@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:00:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702113159.153135-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 7:31 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 2c2c452b0cafdc ("Btrfs: fix fsync when extend references are added
> to an inode") forced a commit of the delayed inode when logging an inode
> in order to ensure we would end up logging the inode item during a full
> fsync. By committing the delayed inode, we updated the inode item in the
> fs/subvolume tree and then later when copying items from leafs modified in
> the current transaction into the log tree (with copy_inode_items_to_log())
> we ended up copying the inode item from the fs/subvolume tree into the log
> tree. Logging an up to date version of the inode item is required to make
> sure at log replay time we get the link count fixup triggered among other
> things (replay xattr deletes, etc). The test case generic/040 from fstests
> exercises the bug which that commit fixed.
> 
> However for a fast fsync we don't need to commit the delayed inode because
> we always log an up to date version of the inode item based on the struct
> btrfs_inode we have in-memory. We started doing this for fast fsyncs since
> commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").
> 
> So just stop committing the delayed inode if we are doing a fast fsync,
> we are only wasting time and adding contention on fs/subvolume tree.
> 
> This patch is part of a series that has the following patches:
> 
> 1/4 btrfs: only commit the delayed inode when doing a full fsync
> 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> 
> After the entire patchset applied I saw about 12% decrease on max latency
> reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
> ram, using kvm and using a raw NVMe device directly (no intermediary fs on
> the host). The test was invoked like the following:
> 
>    mkfs.btrfs -f /dev/sdk
>    mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
>    dbench -D /mnt/sdk -t 300 8
>    umount /mnt/dsk
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
