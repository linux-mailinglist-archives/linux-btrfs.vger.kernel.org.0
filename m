Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE192A85CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKESM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgKESM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 13:12:57 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F2C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 10:12:57 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so1767473qtj.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 10:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=65Xy42dlr+q8dsSXSG5YNCEFPJbGdLzIg/nTMEEIsz0=;
        b=D4B/mOYR4X0V1bWJ8vJB+BhuAkuj8u6M8p8tnDHj0UkpetqyIZZlBxbD3u8DDVH9NY
         Z2slAU6vbtM9GYqX1U6wfa2CA28aJ1xdfasnGU9SoWlIpyO0+hEwHrW3udNVxepeXKxE
         /ljccw4KWbgwS+3hFSiWIt9KOMDoe8dAJJSHvXIpwItWI9JOG4okq4Nk6DH4cnC3Piss
         IOT6pZpjdEdGVT+0rakIFSFSvyqlftT9p18jPQGpWCTbwnh/HIlYyabjl3bLLCAOVEoC
         i1Ixj+uxLII9hlZKP9yrTiNstf8VQoCW+7yU0l73qvJCLLMp7JzcJFCaqDFn1Ox5RhPj
         f+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65Xy42dlr+q8dsSXSG5YNCEFPJbGdLzIg/nTMEEIsz0=;
        b=YDkmTjG64qu6QCTIySxXgvDx7rehEUzdzvMbObpLIQSo3tJwBWHJ4qOfLjf04bWhrJ
         YSPVAL3bAdIXpJgZwcPjrSiLmspuKW8uc0X9liy1JZbYS3tSiQ9LHV7NMpVv7pelqyNQ
         QpWLygqS5yROsmfS1YA3lA9flxGyZSxOqx91vzF0MN8bEgFp/ylxG6LF6dvGn83yyTtc
         yjVWtdDSDewDJuTONRzD2nhrPfXm/cqviQX9HKwwiFBOPGt2U6kzn10m/HL0OO5FL5zR
         FMhvLOF/BTubBbXwGUuN5BASsr0JCmRb3l2h3ehVH2OtHinwwSgXLswna79NPYAG4z6q
         n3Wg==
X-Gm-Message-State: AOAM533LElUQQeNUmWsEuoZsx7rOhP9V298DHvhygsYBMM7PmEUkHoF4
        B2FgFfTMiCB+zaCC3V/SBzPs7YrE6rSLfI+8
X-Google-Smtp-Source: ABdhPJw/NvdivGnvlBygQaN570eyRlFVrMWZ0ziKkkFsujgpm3+zdla7PHxuWg3ByplzF3UIyCv64Q==
X-Received: by 2002:ac8:4808:: with SMTP id g8mr3078353qtq.18.1604599975771;
        Thu, 05 Nov 2020 10:12:55 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p5sm1457880qtu.13.2020.11.05.10.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:12:54 -0800 (PST)
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103211101.4221-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dfebd678-a204-3ec2-9ea0-da49af3aedc0@toxicpanda.com>
Date:   Thu, 5 Nov 2020 13:12:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103211101.4221-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/20 4:11 PM, David Sterba wrote:
> After the rwsem replaced the tree lock implementation, the extent buffer
> got smaller but leaving some holes behind. By changing log_index type
> and reordering, we can squeeze the size further to 240 bytes, measured on
> release config on x86_64. Log_index spans only 3 values and needs to be
> signed.
> 
> Before:
> 
> struct extent_buffer {
>          u64                        start;                /*     0     8 */
>          long unsigned int          len;                  /*     8     8 */
>          long unsigned int          bflags;               /*    16     8 */
>          struct btrfs_fs_info *     fs_info;              /*    24     8 */
>          spinlock_t                 refs_lock;            /*    32     4 */
>          atomic_t                   refs;                 /*    36     4 */
>          atomic_t                   io_pages;             /*    40     4 */
>          int                        read_mirror;          /*    44     4 */
>          struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          pid_t                      lock_owner;           /*    64     4 */
>          bool                       lock_recursed;        /*    68     1 */
> 
>          /* XXX 3 bytes hole, try to pack */
> 
>          struct rw_semaphore        lock;                 /*    72    40 */
>          short int                  log_index;            /*   112     2 */
> 
>          /* XXX 6 bytes hole, try to pack */
> 
>          struct page *              pages[16];            /*   120   128 */
> 
>          /* size: 248, cachelines: 4, members: 14 */
>          /* sum members: 239, holes: 2, sum holes: 9 */
>          /* forced alignments: 1 */
>          /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
> 
> After:
> 
> struct extent_buffer {
>          u64                        start;                /*     0     8 */
>          long unsigned int          len;                  /*     8     8 */
>          long unsigned int          bflags;               /*    16     8 */
>          struct btrfs_fs_info *     fs_info;              /*    24     8 */
>          spinlock_t                 refs_lock;            /*    32     4 */
>          atomic_t                   refs;                 /*    36     4 */
>          atomic_t                   io_pages;             /*    40     4 */
>          int                        read_mirror;          /*    44     4 */
>          struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          pid_t                      lock_owner;           /*    64     4 */
>          bool                       lock_recursed;        /*    68     1 */
>          s8                         log_index;            /*    69     1 */
> 
>          /* XXX 2 bytes hole, try to pack */
> 
>          struct rw_semaphore        lock;                 /*    72    40 */
>          struct page *              pages[16];            /*   112   128 */
> 
>          /* size: 240, cachelines: 4, members: 14 */
>          /* sum members: 238, holes: 1, sum holes: 2 */
>          /* forced alignments: 1 */
>          /* last cacheline: 48 bytes */
> } __attribute__((__aligned__(8)));
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
