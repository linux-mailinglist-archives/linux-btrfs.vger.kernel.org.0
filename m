Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF678B1CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjH1N1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjH1N1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 09:27:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB1A7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:27:18 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d66f105634eso2841138276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1693229237; x=1693834037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz3iEWQ9SHz1Q5Tw79xdnHjBMrxmTQoc412/3ePklVY=;
        b=ILbTWW4zy0e17exOC7ckb9dvQ5si3SewNHfSJMHL3/1GRuLlwcsIHTg08e1F4m0j/B
         75Kng6xYjB/hfF16/wPNWifkUY5Hy3HJHQOFNq87P0pSSHJA++uxLWMZTc0tuTTmJhHr
         hIBFI7IMviPKJfOT+Xqb0aHJ2uqdafl1DnBDU+p7KTONUxbrUX/mTQMP9BVeSYi9rk53
         MoECxdNiI+qfEm603TX9g/oAS923UT14F0LmgVmFJXJBZGR56hidmZcYLsJxXuQjCS+g
         +VkdKos7510/C77DzDchKqDl89T7N4OOIx/ubueXIQdE7h8dhVgXYgHJxNBfPgd31fx7
         qG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229237; x=1693834037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz3iEWQ9SHz1Q5Tw79xdnHjBMrxmTQoc412/3ePklVY=;
        b=gaVPfiCDG436GF5rhfnTD8tHPXiGFM3/BhHistrxiI8locGsQxexsGio1YVBA0uT84
         Gr0JpNYjHaR70pXCmKS5MNFFqL1ME/oy1xA8ihzaaEokE4eUKr9Xf2eZI2r6HOTIO99l
         5qYV0MNMl/hAB81vFWVFDH+LvbuALVSelEmxVBM7d5zUE82/9gGFqQ4LmKFxs3fDjtrx
         pZOv9NuZK4IPnA8f8d8YCqtUU6IbfzDN/1TAB+Mqr35Db0MKUUkx5Okpz9jRsi4YqVZc
         vqJUejzU9boPaej4vwP4YaqA1rk2mOp6OnXil2PClumVyu1ZyxDdz/S8es7MvwRXGa7m
         Nhtw==
X-Gm-Message-State: AOJu0Yx/CXJJcPf9V9At4sQDxOTmeTxRIDQNIc4l/kljRRSONdFNMXJl
        Cx9sAirhxw6SeBMyM9FjubdTZnMEwxZRWwkhPic=
X-Google-Smtp-Source: AGHT+IHe3Rb1x56Gt8eDsDayF9XLLUXEBrPkm7WEAueUjPRmsmVg3Bj1YKc7loKvoN4HiRcNqRnFNQ==
X-Received: by 2002:a25:b291:0:b0:cfd:1bb9:e356 with SMTP id k17-20020a25b291000000b00cfd1bb9e356mr25046331ybj.32.1693229237146;
        Mon, 28 Aug 2023 06:27:17 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v5-20020a05690204c500b00d74c9618c6fsm1592742ybs.1.2023.08.28.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:27:16 -0700 (PDT)
Date:   Mon, 28 Aug 2023 09:27:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment for reservation of metadata space
 for delayed items
Message-ID: <20230828132716.GC875235@perftesting>
References: <283a7c5087a950342a862fba42922fad4fc71365.1693208275.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283a7c5087a950342a862fba42922fad4fc71365.1693208275.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 28, 2023 at 08:38:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The second comment at btrfs_delayed_item_reserve_metadata() refers to a
> field named "index_items_size" of a delayed inode, however that field
> does not exists - it existed in a previous patch version, but then it
> split into the fields "curr_index_batch_size" and "index_item_leaves"
> in the final patch version that was picked. So update the comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
