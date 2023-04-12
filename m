Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439A46DF79B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDLNrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjDLNrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 09:47:12 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B64C1F
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:47:11 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fb615ac3dso6985717b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681307230; x=1683899230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEEJkacZCSFfDJE5/H/8V90AiwLxi8jk5p34+Hb4FVU=;
        b=vL8HXhFp8B6/N4jKB7jG17Y1rAe2e6kWF1d6pUxmjlnww/cyxs17Q7nBZ3iYq8BSdr
         kmyNjRKYFQsy71PlPAxs1gPir7eGnfVIsL2ez7sIq/iPMBVDNW5dTELZBkdV/RZpJRk+
         TBOzbXHAoM5WyRctA98ZStFuHekRH5LiaZQKYb8GDM41UNFqQGzwdaWkY6Hg3jwYAXXc
         SjA3BGUnfy1qG+Wg0mTPZ9WLlfKlF+wgXZdLSVSzswd+b11b1RadEQqqBITa9Z4tFJLT
         MWhRHTjCQx0VGMyPCjU/55Dd3P6XtQk7mZfVaNAh4jyRzvhfVbpAdJ7byGNpZ/90Mx5j
         jrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307230; x=1683899230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEEJkacZCSFfDJE5/H/8V90AiwLxi8jk5p34+Hb4FVU=;
        b=le+L4QlWB4T1tIPz15U2tUdcupfc71kLKEZH17tKphY2yIJDb3cbzj5mVwL2obMGoJ
         rN8kayisULNzKSKHLltGhGn8ziyNFoGMa9Xfcp5KeuoQU7Z1/V8sMSG9/d7qZBukZ1/l
         SMQeXA2TVnF0wASqO8AHdYUEVJEGqbMXqVT4/yZ1XAdJqyaG/10v/o0RBot4Sex3FW64
         VdSXHavXOYCGpE5vpLOZscuBT2uHJvN6bPuCZ6FAY8avLCe1nZ1z1SMrE9S5ZaCJko2+
         l+zdrSbpzUoq9rJqHOdxiWXfycajfJywAothr1txIeDI2Z2gddfzZP3yfQmBtRmLvu5o
         yDGA==
X-Gm-Message-State: AAQBX9f7wUf0iwiEAKqdA423jLDF2Av2IYU6NckEHmYwWuVw2AhUFncc
        Om/tLHcW0ASA0zT19p78xugkkntjukPTdAmwKrcP1Q==
X-Google-Smtp-Source: AKy350bEU0KLEq/04dWwj8Zp5OtS0Vp4VyGmw8ftrod4CyVTViUgMyPxh9smoiajC59cvdNdkgZDzQ==
X-Received: by 2002:a0d:d5d0:0:b0:54f:b7e1:8724 with SMTP id x199-20020a0dd5d0000000b0054fb7e18724mr107204ywd.1.1681307230118;
        Wed, 12 Apr 2023 06:47:10 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z35-20020a81ac63000000b005463f6ae720sm4153963ywj.68.2023.04.12.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:47:09 -0700 (PDT)
Date:   Wed, 12 Apr 2023 09:47:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix for btrfs_prev_leaf() and unexport it
Message-ID: <20230412134708.GA3162142@perftesting>
References: <cover.1681295111.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681295111.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 12, 2023 at 11:33:08AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A fix for btrfs_prev_leaf() where due to races with concurrent insertions,
> can return the same key again, and unexport it since it's not used outside
> ctree.c. More details on the individual changelogs.
> 
> Filipe Manana (2):
>   btrfs: fix btrfs_prev_leaf() to not return the same key twice
>   btrfs: unexport btrfs_prev_leaf()
> 
>  fs/btrfs/ctree.c | 131 +++++++++++++++++++++++++++++------------------
>  fs/btrfs/ctree.h |   1 -
>  2 files changed, 81 insertions(+), 51 deletions(-)
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
