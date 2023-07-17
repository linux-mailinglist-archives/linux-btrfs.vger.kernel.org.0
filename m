Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338A756B09
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 19:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGQRzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGQRzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 13:55:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26771B6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 10:55:04 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765942d497fso449734685a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689616504; x=1692208504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vOqeomKsAoqbWu4Lg1l0wQOQ6rbp2AkCLw+19AnRnY=;
        b=oGUO2k0HdustWWFG4/5oBoO7XibwQW6vqWzRMFhTZXLpC4Mk3rtpN15YYAwwiqukx7
         +bCOEk9uYeqxG0b/a0ZRpSRIqga8OW2dxGxRqbh/TP8WzWZCRRULZxj9Gg1DJDSpAWnc
         X5S0s7F67rKEehM8bRsHLW5oI1zywsqSE1mX+KIMCiZJeDVopIzALp0ZYyRyCaKtQw/Q
         LR20F2VUdy4KBn9HqJhTliiONXk7KNMQmsXZp0ePOBIzo5azsnQ6ZUYxL6rJceaz1VXw
         QhdWarwAREl7ioqo56eFpVLPdwhFNdTNkqIvqGOCLj0mDF6VGF9E0eEcYr9+/Ck4JAPR
         XnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689616504; x=1692208504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vOqeomKsAoqbWu4Lg1l0wQOQ6rbp2AkCLw+19AnRnY=;
        b=TP2HATkKjgo/ZfwaDyOR1Iii8rNnbQb3Bnja5WESl1/k/DHXQF5cP0TagdkFHTRySN
         0SyxaQMnzwdrZN7P1wa4Dl7TLq2R+9eQxf4G69aBAAFAnXEw1UVrtJUdhZitXjP0/Dah
         OA467Lt/VhQJSoaCpMXMAiXc+/pxOr8yj5WrHZx1AtDV/77vSWbhy2JWVSFVRtoX/38W
         eD3ucj3LcSlft4wu1SlWaGdwq772563rV54yj/A3wqhD4vuqi6EZXAZVoFaTHNDRrdiD
         HYEGToSMixm43iZbq4XgsgrpT8nlwxb1kMI1qPRJz8BUjWjFTvtthg77hSgrnc0fjuSt
         fQTQ==
X-Gm-Message-State: ABy/qLZfyFm+DG7xRVQdKpDvIzeQqTBmiMk34CZ9D5njjK5vIgD0hbFK
        p5pswAnM8NBev+4oO8+ruxC7Cw==
X-Google-Smtp-Source: APBJJlFEMZrJu77OaOsHd+yjw0xsIC+NCqePa7t07IsbDvmVZ3erExTBNwo89dPJUnqj4tVaDT7Frw==
X-Received: by 2002:a05:620a:44c9:b0:767:fe52:d13c with SMTP id y9-20020a05620a44c900b00767fe52d13cmr14977217qkp.22.1689616503786;
        Mon, 17 Jul 2023 10:55:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y5-20020a37e305000000b00766fce8f840sm6231752qki.120.2023.07.17.10.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:55:02 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:55:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 12/17] btrfs: turn on inlinecrypt mount option for
 encrypt
Message-ID: <20230717175501.GM691303@perftesting>
References: <cover.1689564024.git.sweettea-kernel@dorminy.me>
 <303b721e0c738ebb8ee3ada3d4b867a07d6d5bfb.1689564024.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303b721e0c738ebb8ee3ada3d4b867a07d6d5bfb.1689564024.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 16, 2023 at 11:52:43PM -0400, Sweet Tea Dorminy wrote:
> fscrypt's extent encryption requires the use of inline encryption or the
> software fallback that the block layer provides; it is rather
> complicated to allow software encryption with extent encryption due to
> the timing of memory allocations. Thus, if btrfs has ever had a
> encrypted file, or when encryption is enabled on a directory, update the
> mount flags to include inlinecrypt.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/btrfs/ioctl.c |  4 ++++
>  fs/btrfs/super.c | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 91ad59519900..11866a88e33f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4574,6 +4574,10 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		 * state persists.
>  		 */
>  		btrfs_set_fs_incompat(fs_info, ENCRYPT);
> +		if (!(inode->i_sb->s_flags & SB_INLINECRYPT)) {
> +			inode->i_sb->s_flags |= SB_INLINECRYPT;
> +			mb();

Extraneous mb().  Thanks,

Josef
