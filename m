Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448ED7529C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGMRXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGMRXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:23:11 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485E2699
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:23:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5776312eaddso8968937b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689268989; x=1691860989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leCb0+w6tGr2f0NgLDAxs0Vzh3uY+ixsKtGBpzx3FzA=;
        b=QDciy97l7Aq4tua5Rpc3UjUWYDK4uAzv6PUZSP36PIWWEUS4Res3cGc7Ps1eO88Yml
         bSDU2rWjPjYRlwG3UbhSwHqJ8KbkLaRsbE8/fmH4/7Iw9FIpyUsoKgKnvVs4EFbmJ9RU
         rfngj3N2COH1ujm5ecXHwuJlNC5ilgdEjCZolb9G3tI+1LBGxbxfBt8LZA1DDPNgu1yB
         VkBy2y6a8pf7UnjmZheEKcCR3BjolXR1N+uxGRmNfih8w7Mw7icChdWiyLZAclHWzzaV
         kkbRDFDWUx+qYrRpejD6ay5bqerfa0DqW8nj91V8bG+YFI7QzcHdJ/1dsjQDhLHgiLqm
         TxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268989; x=1691860989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leCb0+w6tGr2f0NgLDAxs0Vzh3uY+ixsKtGBpzx3FzA=;
        b=Ltk4PkW+zrxnHNnWHwuAPhZNjBcqAKaXKqWoc+eNFGGJGsPrY9fpyR1mWkXQUMTOKi
         oeM4KyKKUvwpv5D/lyf8+qIbgsoaGyuKBrJUuuTcEO8+9sRff2T8fm0AiFVcl4FoV9M7
         cCXmGKwe1XvJoavPt2OnUwoZfFrvIQECZ6mcZ+E81ZBSRc7QxO8QE5rE4qeid5ArkMgu
         l633LOBRPahRSZxmAJcY7A930mOB+LOkwuWb128s6fKygH11YWm5tjASv6stiYkGP3j8
         VjNgPAOGEBKViOq60Udu1a50j0g3b4L7Z22WaAXej4RJw1Zo9oxhH4Z/XbMro/1LMx9M
         7XSQ==
X-Gm-Message-State: ABy/qLbgfnPfp6jEtiZJHtjJ/DQD6KBFVwRzZ0VDW5YDprTQfyjSYbkX
        joKr3Wvqa6Y6L7qZJKU+BwNHlaI59aKAemaNYq4JWw==
X-Google-Smtp-Source: APBJJlGBICQ+b/CICA3qSJ5/Uo2A1970QJopbk132qkdPJ5wDxqS+VagNM7sw9lMLb4lcySuiLVdEQ==
X-Received: by 2002:a81:8a43:0:b0:576:8dd5:8943 with SMTP id a64-20020a818a43000000b005768dd58943mr2663449ywg.34.1689268989313;
        Thu, 13 Jul 2023 10:23:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x13-20020a81a00d000000b0056d51c39c1fsm1839700ywg.23.2023.07.13.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:23:08 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:23:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 14/18] btrfs: record simple quota deltas
Message-ID: <20230713172308.GN207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <ebe324c9b3ab85f6ba4fca00a398e8e17ebe3c8c.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebe324c9b3ab85f6ba4fca00a398e8e17ebe3c8c.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:51PM -0700, Boris Burkov wrote:
> At the moment that we run delayed refs, we make the final ref-count
> based decision on creating/removing extent (and metadata) items.
> Therefore, it is exactly the spot to hook up simple quotas.
> 
> There are a few important subtleties to the fields we must collect to
> accurately track simple quotas, particularly when removing an extent.
> When removing a data extent, the ref could be in any tree (due to
> reflink, for example) and so we need to recover the owning root id from
> the owner ref item. When removing a metadata extent, we know the owning
> root from the owner field in the header when we create the delayed ref,
> so we can recover it from there.
> 
> We must also be careful to handle reservations properly to not leaked
> reserved space. The happy path is freeing the reservation when the
> simple quota delta runs on a data extent. If that doesn't happen, due to
> refs canceling out or some error, the ref head already has the
> must_insert_reserved machinery to handle this, so we piggy back on that
> and use it to clean up the reserved data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c |  3 ++
>  fs/btrfs/delayed-ref.h |  6 ++++
>  fs/btrfs/extent-tree.c | 79 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 89641bcd6841..04e124a93049 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -735,6 +735,9 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
>  	head_ref->bytenr = bytenr;
>  	head_ref->num_bytes = num_bytes;
>  	head_ref->ref_mod = count_mod;
> +	head_ref->reserved_bytes = 0;
> +	if (reserved)
> +		head_ref->reserved_bytes = reserved;

This is just

head_ref->reserved_bytes = reserved;

Thanks,

Josef
