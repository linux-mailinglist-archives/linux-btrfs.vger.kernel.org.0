Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2276064C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJTPht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJTPhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:37:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25A1B7F31
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:37:47 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f22so13927809qto.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8h8UrC5l2n+VQKq7gk4XIve35CwgnkkwzRpA1GUZj8M=;
        b=ReN/yw4aRktbdUuWikRluOaGunCtb/IsJJ6Tw7Z5wSeIvmkuyBsidHPbXn6gzVQwBL
         T9qJZsLL4eMUnRtwl1mY7sOpfHd0POxFzR++ChZB1/7g2dVgyIFSZMeCt4aMYdskr2L0
         NaeA1mnmoBtFBiJ+0grxTfv69NdmdZNnYf2eue5QdP4iPJ7dQofskDVfODX3N3BdQrO0
         j8RNcLTiE+p9jNdAv2RGnPsgXfjB25jLEx/hMhHIgB0HPMtk8tC2LLbgjNDr57TfXeIv
         Sk+xOFiSpO2/rQruRRxt//ETntYVXNEtwgbGIyRafLecThFNksoEjCHsXqo9VZhov0ql
         hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h8UrC5l2n+VQKq7gk4XIve35CwgnkkwzRpA1GUZj8M=;
        b=oVzZ7GuJs+OxOpAOs1fa4vmZ31BkAOgXMoE9DZ08qdLgG7Kqn8Fh89zgOJO7G6rmZx
         7z+xMKHmoIwPU461Ga/MAY5UTcoSDd1yCDP9iBJuOVaaZ2XSAjmf+0OUdnYwc7x17Xrx
         MV2wAnN5A/5g8Q3tzHX7mXwxVrlSH0hcMEQzo3cJQ90gbKYjiBRR7IFbXi1qUMrYEO2s
         4KqcpGWfYdjqMb1HRQ7ESH1kmDuYpd5IVi7tSG/NmqPPtdQ28wyh6UTxUnIH+w3Si02W
         mViiqZG+0uMwi9WmeraArss0B5rvzr5pM7BACY7X2dcPapx4BYSh3zpPv4ZmZTzCw0fX
         zoiw==
X-Gm-Message-State: ACrzQf1zjnYCZNcbgcipLm4RJEbD5cxmJfUbYtOGEqU3TziSMSlxDOT5
        IESlLV0uB1DIokn5RjOFEw1ypQ==
X-Google-Smtp-Source: AMsMyM7FsPdwW87LJzK5K+/RZ0aExcjEHvIl2M/R+McRv+8jx0AaGdqEPEJ/zzGkIjilojUuPg+0tw==
X-Received: by 2002:a05:622a:83:b0:39c:fa14:efeb with SMTP id o3-20020a05622a008300b0039cfa14efebmr9332880qtw.643.1666280266608;
        Thu, 20 Oct 2022 08:37:46 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id do35-20020a05620a2b2300b006b95b0a714esm486882qkb.17.2022.10.20.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:37:46 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:37:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 10/11] btrfs: check for leaks of ordered stripes on
 umount
Message-ID: <Y1FrSaKIMNI3bWDm@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <c939c2fdd361800a4361707bf9d5cc68e30e7907.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c939c2fdd361800a4361707bf9d5cc68e30e7907.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:28AM -0700, Johannes Thumshirn wrote:
> Check if we're leaking any ordered stripes when unmounting a filesystem
> with an stripe tree.
> 
> This check is gated behind CONFIG_BTRFS_DEBUG to not affect any production
> type systems.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c          |  2 ++
>  fs/btrfs/raid-stripe-tree.c | 29 +++++++++++++++++++++++++++++
>  fs/btrfs/raid-stripe-tree.h |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 190caabf5fb7..e479e9829c3e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -43,6 +43,7 @@
>  #include "space-info.h"
>  #include "zoned.h"
>  #include "subpage.h"
> +#include "raid-stripe-tree.h"
>  
>  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>  				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -1480,6 +1481,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_put_root(fs_info->stripe_root);
>  	btrfs_check_leaked_roots(fs_info);
>  	btrfs_extent_buffer_leak_debug_check(fs_info);
> +	btrfs_check_ordered_stripe_leak(fs_info);
>  	kfree(fs_info->super_copy);
>  	kfree(fs_info->super_for_commit);
>  	kfree(fs_info->subpage_info);
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 91e67600e01a..9a913c4cd44e 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -30,6 +30,35 @@ static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
>  	return ordered_stripe_cmp(&stripe->logical, rbb);
>  }
>  
> +void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info)
> +{
> +#ifdef CONFIG_BTRFS_DEBUG
> +	struct rb_node *node;
> +
> +	if (!fs_info->stripe_root ||
> +	    RB_EMPTY_ROOT(&fs_info->stripe_update_tree))
> +		return;
> +
> +	mutex_lock(&fs_info->stripe_update_lock);
> +	while ((node = rb_first_postorder(&fs_info->stripe_update_tree))
> +	       != NULL) {
> +		struct btrfs_ordered_stripe *stripe =
> +			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
> +

Can we get a WARN_ON_ONCE() in here?  That way xfstests failures will get
noticed as we'll get the dmesg failures.  Thanks,

Josef
