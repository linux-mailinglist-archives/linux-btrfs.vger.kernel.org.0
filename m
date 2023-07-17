Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAF756AFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGQRvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQRvh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 13:51:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12C191
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 10:51:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635dc2f6ef9so29725036d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689616296; x=1692208296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BHlfVsfPhnxlsUEOKcKKn0IbD3InDVMiiAUdF+JrOQ=;
        b=cqygkbLhW48YW0z750e3ImorRMNd0UWUHikUfX0irhju3he78RXtCw2u46AVP/w9Sg
         EJ+k2TgHHIcnsO4a5GnZCBzy6hAtesTnawAec+Uk5Xz4Xo0aGnZPCzEeI2YbZRKjidFN
         wx+vuL4Ghznfet7zpuxNMOpJ+9XDS9XbFUNs5CP6PkAUDUYG2JgZLQ7pxzbuEtfF0EQ7
         JkxAkk7HSz5AzkCBCMwfQOU82fcw8NDFqOT1peqgzdGIHPf82Ywaf7uD8fDcYq0XsVaR
         ktNFh90S/Epu7dgGjpsmtk/ssxt8CMalZbJEfvIcZyp2yiPiWuEc+eKJLxlLjJyvB16m
         Ra8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689616296; x=1692208296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BHlfVsfPhnxlsUEOKcKKn0IbD3InDVMiiAUdF+JrOQ=;
        b=Z0kvNEpYUtthRcVfj+++4zEkKTu5d9n/ur6yS3KUEKizfCuEjrd0cXp3txohLzcacL
         tPlIUlMj+8aKVJBbcIaUhuD29otkce2ti1TEYPaO/44ITfiJ+NWqm8Pe0TQ+J8Jf94Zy
         chrvSdK7JErl4VvvygdpwczuY+2qyMW0v/uuUAc6iKUA+50ewWoAf7avUDB/NDoklDSD
         5ZkEN+bB+VxpnNmW7r5uhPihKnZH24RmoXyGatjCRjypNHgY5i6CDO1FkKcRqGG3ZKy0
         jXUxoBG1waSaxh/GJFP34RWkluyiOWEjGd9lGy4co2BSrYX49iOYpM5zqClKq2xhIfER
         STyQ==
X-Gm-Message-State: ABy/qLb/FQH8aB7b3Igk06XsrxDrJP3d+ssGRZZhhD0NtmoO6s59GrOZ
        bjqJgqeeAu9Fyb9Xa7eHHjG+8Q==
X-Google-Smtp-Source: APBJJlEr+gMm4IYHpsZdQulmEhtYnBrS6hQKVOhvyhN8kVZ6Cy6ezb/Yw3SfvmbspPuBsXAb5D22sg==
X-Received: by 2002:a0c:aac4:0:b0:625:1c04:6761 with SMTP id g4-20020a0caac4000000b006251c046761mr4448213qvb.27.1689616295692;
        Mon, 17 Jul 2023 10:51:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t13-20020a0ce2cd000000b00630228acc55sm59038qvl.118.2023.07.17.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:51:35 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:51:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 11/17] btrfs: add get_devices hook for fscrypt
Message-ID: <20230717175134.GL691303@perftesting>
References: <cover.1689564024.git.sweettea-kernel@dorminy.me>
 <4fb0338787fec0233075a2bff7014f5f34342445.1689564024.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb0338787fec0233075a2bff7014f5f34342445.1689564024.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 16, 2023 at 11:52:42PM -0400, Sweet Tea Dorminy wrote:
> Since extent encryption requires inline encryption, even though we
> expect to use the inlinecrypt software fallback most of the time, we
> need to enumerate all the devices in use by btrfs.
> 
> I'm not sure this is the correct list of active devices and it isn't
> tested with any multi-device test yet.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/fscrypt.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
> index e03157c367a2..6875108f4363 100644
> --- a/fs/btrfs/fscrypt.c
> +++ b/fs/btrfs/fscrypt.c
> @@ -11,7 +11,9 @@
>  #include "ioctl.h"
>  #include "messages.h"
>  #include "root-tree.h"
> +#include "super.h"
>  #include "transaction.h"
> +#include "volumes.h"
>  #include "xattr.h"
>  
>  /*
> @@ -164,9 +166,46 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
>  	return inode->i_size == BTRFS_EMPTY_DIR_SIZE;
>  }
>  
> +static struct block_device **btrfs_fscrypt_get_devices(struct super_block *sb,
> +						       unsigned int *num_devs)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	int nr_devices = fs_devices->open_devices;
> +

Extraneous newline.  Thanks,

Josef
