Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7C2F3A9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 20:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406907AbhALTb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 14:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406778AbhALTbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 14:31:25 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E027C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 11:30:45 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id l14so1460456qvh.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2oFLrVJdbx6JLDkzdLKfI6dxGFHt1u344+x+I0x/70Q=;
        b=gmhaQAHlMrfXuPaprcMk/bVxZKoYCj+vKepNFIwOHyuhLAEMWudMwprS25YO82bqeP
         8chyszJzgyPsUMqaoa8Uwg4Vc09EubPQPg1QjEYvE9IiHbx/ecZWTD1tZ8Ubj7Gh+vw+
         4zEEDPCbtvxaIqAlDA9rZ9DMNbG0eau4mZ/pZk3GrTk48lLchZZqpbsZcfvUGkBH8MuB
         m/q8V3d3vK+7uNtb8QLdeTGYktBg4XncgZCm1FPFvHuVqTKSZK7LTudXSzXKZ7ZkmUHv
         qzgq0YcB8ef1N85Qr29h6DIRH4Fs6fifRoX92RTWdw2HpQ9kodcddBZcMcbMVMMYFKj/
         OoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2oFLrVJdbx6JLDkzdLKfI6dxGFHt1u344+x+I0x/70Q=;
        b=FU3q01dDauzuLg2X2OpKJAQvWkgtpu5DdxyIG8ZSqHd0WGJovYe92MqzlQN8Oc6Uf0
         W/XrVpz+yP7cronYtM6l/BH9i1uBiFWe+NP08gRHQoiN0ZSHDnfqracN3MYUlHap3TcO
         G+G9TQ8QQwahlNqPsWqXNUckmTnTK9vuc3ZL0gcaTVxTNkQlzpMGNgmOvTn7DJMLBQ2h
         xZ8XMU8Rlni17bXJwjBeBzdlgkiXFHdsYKniLnq26rxUNu8Z9/EhHMDAuRVof7/T1IU0
         4+WvbS7hyeIVEIWuO9V3Gn/Kym3TxzDVIXfUMRl5n0ZRfgcP99T+cJE/sAbO+dgwFvBf
         ts7g==
X-Gm-Message-State: AOAM533/tnZ7Dub3MjhrOc6/7ejlxcvxdOw4ZADvPEBRqSkeFuHxZ2Mg
        HKEfte4H83c9rNb2UWzvqv0yjg==
X-Google-Smtp-Source: ABdhPJwlzvNe4ffTDoEmVVI2j4PFTGFTAoCt9YjQvG0A41xRG6cPx7n7+US3B9Ic5jNGraGbr9XSHg==
X-Received: by 2002:a05:6214:1227:: with SMTP id p7mr1024381qvv.31.1610479844202;
        Tue, 12 Jan 2021 11:30:44 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r190sm1941860qka.54.2021.01.12.11.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:30:43 -0800 (PST)
Subject: Re: [PATCH v11 31/40] btrfs: mark block groups to copy for
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <ec6780c980e445b0caba100bebc875970fc22a07.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17245e25-a2c4-2c2a-6341-bf2a5f0f90f6@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:30:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec6780c980e445b0caba100bebc875970fc22a07.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is the 1/4 patch to support device-replace in ZONED mode.
> 
> We have two types of I/Os during the device-replace process. One is an I/O
> to "copy" (by the scrub functions) all the device extents on the source
> device to the destination device.  The other one is an I/O to "clone" (by
> handle_ops_on_dev_replace()) new incoming write I/Os from users to the
> source device into the target device.
> 
> Cloning incoming I/Os can break the sequential write rule in the target
> device. When writing is mapped in the middle of a block group, the I/O is
> directed in the middle of a target device zone, which breaks the sequential
> write rule.
> 
> However, the cloning function cannot be merely disabled since incoming I/Os
> targeting already copied device extents must be cloned so that the I/O is
> executed on the target device.
> 
> We cannot use dev_replace->cursor_{left,right} to determine whether bio is
> going to not yet copied region.  Since we have a time gap between finishing
> btrfs_scrub_dev() and rewriting the mapping tree in
> btrfs_dev_replace_finishing(), we can have a newly allocated device extent
> which is never cloned nor copied.
> 
> So the point is to copy only already existing device extents. This patch
> introduces mark_block_group_to_copy() to mark existing block groups as a
> target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
> check the flag to do their job.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
