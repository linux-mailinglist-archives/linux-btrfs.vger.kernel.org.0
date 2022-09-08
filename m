Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173925B2706
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIHTnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiIHTnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 15:43:19 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A51E114A45
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 12:42:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cb8so13796413qtb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Sep 2022 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4JTqoy5zFg2/U4/g61VXpsJ15O36VhwkskAP9knZ9Aw=;
        b=SFUPjD1uZHspNPtLt1jPHjuKBHEKtSMqOFTBAIKz09+gP18HijDsU8DgcFKt602OGr
         a9RE3dIj4sWBf1dvlrj13KzJ5TZc3AuMJ3ztb+kddB9jYDY/5iRJ5xtX57Jija7BM0Hr
         b1ivktV+sJbPYmHO8RBQldlx/tp9mWbZ/bG6AKezh8XAFFg1/Z/ri5eEm4T4JJYDnkMg
         3TO9dp9ahcz+BiJ6OsmrDhH6q378fHhoUyxd+9TJh6nBI9tkdXG7AlqeGQuWmkdraOyd
         QCiKe48O7Y/QgPB6bEts9F1kupF6qAzCToxw0XyzVILqQlZZ1oMxEfRX3EFjm5P1db56
         x8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4JTqoy5zFg2/U4/g61VXpsJ15O36VhwkskAP9knZ9Aw=;
        b=ZQ2VdYbouNNWCA0DFvM/cKo19fZ3qzGXqedb9NLlLuV+pE8QFzfQahBaaYmeAHTBim
         l2Cc5G1NoFLEd8wNFHKEjV/hEtlVI3UXwdxP1PC6I4fJ/X8SiTvEDK0zwic74OFe+HVI
         sDaNxblKt1yKhAXZVZSVkG1DRToSh+xY10bRvdf4b6GxgvcoimFgjvRdsREILeIKuApT
         9Vi2TCgeMq0Bq+l9VCTWrce8sWEj2WOgo1mOvG7TjpUJsUCS8qjrPaBNAKYbwrMa/lll
         26ndSjNIXh2jS6NcRLkFyWhTIAe9A02Bppx2uzoTO/mJRHWh9vWOVlIihteI8iG8Iwz1
         2P0Q==
X-Gm-Message-State: ACgBeo0RVoZDsYt3pkfV9ughkJRM/y8gAvDMRLxOzn3BngwrgMhHxv0K
        Swd7wH/pnm36+xPHSvSlLfXSyQ==
X-Google-Smtp-Source: AA6agR5b8Jd1/86SssvvayJeaEWk0hJiGkA2gROu3cOU0Ptn1nCtnRiUG3rltIQTg1PGgdjIsChmtQ==
X-Received: by 2002:a05:622a:14cd:b0:344:6cfa:42f9 with SMTP id u13-20020a05622a14cd00b003446cfa42f9mr9399931qtx.147.1662666163097;
        Thu, 08 Sep 2022 12:42:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a166300b006b5c061844fsm16539412qko.49.2022.09.08.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:42:42 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:42:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 12/20] btrfs: start using fscrypt hooks.
Message-ID: <YxpFsHExmVfH/x+W@localhost.localdomain>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
 <4b27b127a4048a58af965634436b562ec1217c82.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b27b127a4048a58af965634436b562ec1217c82.1662420176.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 05, 2022 at 08:35:27PM -0400, Sweet Tea Dorminy wrote:
> From: Omar Sandoval <osandov@osandov.com>
> 
> In order to appropriately encrypt, create, open, rename, and various symlink
> operations must call fscrypt hooks. These determine whether the inode
> should be encrypted and do other preparatory actions. The superblock
> must have fscrypt operations registered, so implement the minimal set
> also.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/file.c    |  3 ++
>  fs/btrfs/fscrypt.c |  3 ++
>  fs/btrfs/fscrypt.h |  1 +
>  fs/btrfs/inode.c   | 91 ++++++++++++++++++++++++++++++++++++++++------
>  fs/btrfs/super.c   |  3 ++
>  6 files changed, 90 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 230537a007b6..2b9ba8d77861 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3416,6 +3416,7 @@ struct btrfs_new_inode_args {
>  	 */
>  	struct posix_acl *default_acl;
>  	struct posix_acl *acl;
> +	bool encrypt;

This doesn't appear to be used in this patch.  Thanks,

Josef
