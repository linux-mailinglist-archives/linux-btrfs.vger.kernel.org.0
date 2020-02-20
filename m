Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C76166158
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBTPs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:48:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40180 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgBTPs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:48:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so3173265qto.7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j7UqOLx4FKB3O3OsMpRSCpY5Dpdzfq+rXgGPAGNIChQ=;
        b=RHGodba5W0pJjl2eXcqGhzCpi3TCy+ZDBB397PR+D0l5qShdVz+yD+TwFk8cPPAWJp
         6qcN6amhzBWeuk7wF2mX+06U7S5W0dzMhrAY2TcvA2QJsg4+ys5RGCq+YwTOWXTScYHH
         C0WRqflA5mCGWJWxTdQQ60InDGhn7Zz0mLuPByAdddvh7pnGPSVbAe3TVKmEMVfnNVAe
         jNDnQnVbWuUDBhxgrEKOylyy1hlL4+fv6WloCuLxji9/H5Hz2TP3JRJKEhY5u2zIRwbn
         wFYKlUyLFrR+rgBwt+sW/bPauBL+AHA1LsSKd4kpCbeTRI7ffPnjgNUt/+ecDR2mX+oq
         wdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7UqOLx4FKB3O3OsMpRSCpY5Dpdzfq+rXgGPAGNIChQ=;
        b=j4PdAV9W0jaQS/S87xhSSwJlCCd9bwzdJssc/YiSkiMUbO8PrvpZ6m1S1PUKy0hU/R
         Ukjsn3Bfj7e+EjpB5qniXcvuWYeed4S2NmTVmXiIqQG+hBgftuE/QE8l5/P8Zn3nr0sg
         S0MI+Ho9lTFiZ6yG+3C5c2UGvcxubatahflF4fq/Na+msIz4qdt6VgHM64wWezcgWIWZ
         Y201YLBFvj6haPSWVThBtP0BqeTV9xb3fzBZrMAAxH9gdLIC2Pmmw16ucfhKVr+cPdBG
         hK4RxMQVqy7NAgDLPeYehklPIazqcXOTxbghyOsol6v4guW052qCHt0djHFofYnr/0Gi
         jqag==
X-Gm-Message-State: APjAAAWvgFjv2xnuJI9N/EdWwN3zaB3QEClYyWGtG3ziHdhYFDHQdaym
        xTATSyomNMZUqHV2qayeyv33zNzuQ5Y=
X-Google-Smtp-Source: APXvYqzGAsEhS6R1P0tjFuQrtK03e6ucDYVuj8NFgw5MVRAILOB+9qtf5vq5cpBhfS2sf0lVobFiRg==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr26765960qti.238.1582213706330;
        Thu, 20 Feb 2020 07:48:26 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k4sm1872024qtj.74.2020.02.20.07.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:48:25 -0800 (PST)
Subject: Re: [PATCH 3/8] btrfs: move the root freeing stuff into
 btrfs_put_root
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200214211147.24610-1-josef@toxicpanda.com>
 <20200214211147.24610-4-josef@toxicpanda.com>
 <058f94f8-7fb6-9dfb-61e0-21dc989e22bc@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <842ad5d0-fada-40da-2d20-bf255a36691f@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:48:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <058f94f8-7fb6-9dfb-61e0-21dc989e22bc@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 10:10 AM, Nikolay Borisov wrote:
> 
> 
> On 14.02.20 г. 23:11 ч., Josef Bacik wrote:
>> There are a few different ways to free roots, either you allocated them
>> yourself and you just do
>>
>> free_extent_buffer(root->node);
>> free_extent_buffer(root->commit_node);
>> btrfs_put_root(root);
>>
>> Which is the pattern for log roots.  Or for snapshots/subvolumes that
>> are being dropped you simply call btrfs_free_fs_root() which does all
>> the cleanup for you.
>>
>> Unify this all into btrfs_put_root(), so that we don't free up things
>> associated with the root until the last reference is dropped.  This
>> makes the root freeing code much more significant.
>>
>> The only caveat is at close_ctree() time we have to free the extent
>> buffers for all of our main roots (extent_root, chunk_root, etc) because
>> we have to drop the btree_inode and we'll run into issues if we hold
>> onto those nodes until ->kill_sb() time.  This will be addressed in the
>> future when we kill the btree_inode.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Nit: This patch obsoleted the last comment in btrfs_init_fs_root, namely:
> 
> /* The caller is responsible to call btrfs_free_fs_root */
> 
>> ---
>>   fs/btrfs/disk-io.c           | 64 ++++++++++++++++++------------------
>>   fs/btrfs/disk-io.h           | 16 +--------
>>   fs/btrfs/extent-tree.c       |  7 ++--
>>   fs/btrfs/extent_io.c         | 16 +++++++--
>>   fs/btrfs/free-space-tree.c   |  2 --
>>   fs/btrfs/qgroup.c            |  7 +---
>>   fs/btrfs/relocation.c        |  4 ---
>>   fs/btrfs/tests/btrfs-tests.c |  5 +--
>>   fs/btrfs/tree-log.c          |  6 ----
>>   9 files changed, 50 insertions(+), 77 deletions(-)
>>
> 
> <snip>
> 
>> @@ -4795,7 +4803,6 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>   
>>   static void __free_extent_buffer(struct extent_buffer *eb)
>>   {
>> -	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
>>   	kmem_cache_free(extent_buffer_cache, eb);
>>   }
> 
> This function becomes a trivial wrapper so should be eliminated altogether.
> 
> <snip>
> 
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 034f5f151a74..4fb7e3cc2aca 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -2549,10 +2549,6 @@ void free_reloc_roots(struct list_head *list)
>>   		reloc_root = list_entry(list->next, struct btrfs_root,
>>   					root_list);
>>   		__del_reloc_root(reloc_root);
>> -		free_extent_buffer(reloc_root->node);
>> -		free_extent_buffer(reloc_root->commit_root);
>> -		reloc_root->node = NULL;
>> -		reloc_root->commit_root = NULL;
> 
> Shouldn't you do btrfs_put_root(reloc_root) here ?

No, but I can see how this is confusing.  The reloc root is actually cleaned up 
in clean_dirty_subvols(), so it's final put happens there.  Thanks,

Josef
