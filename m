Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590BA4461F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhKEKKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhKEKKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 06:10:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD384C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 03:07:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id b17so7030579qvl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMinWJ6w3SOlpNtxcDCgvFrcUeDiA/5bTAWKPgJJWOs=;
        b=3d77SjndvyM6q3wveyb88pPH8g9aCIYL2UMocSRayf6VvAsfrCI7ZEY2ZJ1orPBoPv
         rD2TxSU7ACz1b/LshTULemTRd2o+0FUp8aJSuEn7/V/J4zHkAnGO7b5bMBIrfAMih0Vd
         oSerERhhnPjYrbzg9YqpfcLwyfLvW8Ckk+n5KDY1UASkQqp9azMR/EcOkLff7ArxA8qt
         +naFjAbsdEvQQso3kT0VJRAS6uvA3R8kAABI3F8Nz6rQpXnZqKIEp8EiXXMvVEfbXdQI
         zaB2A2MCtUcct0+B4pNYTgCWfrN4smYqK1dVy0wz/Ho8I32DzqiS/zHee6SEV0EbPXyT
         rVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMinWJ6w3SOlpNtxcDCgvFrcUeDiA/5bTAWKPgJJWOs=;
        b=2GeKImZtUFk6z4+7hr8hJB+Fm0qBORxbSz4VrdYvvG2MawrJjc1OvitUJub4ZbZt4c
         81XxzQjFJlFsCp7VmrK/fsQwbeBaOfypD3yUVI2D8k+/rzCQWiy0WUO9X6Wv8EmvI2KN
         Jx8uIMcR3OickIpW6bA4dOJ/LnvswERmio5L2Im+HUuvNZpTBa3AP+8noBpoKxBdgaiM
         Y0rO59dNAUsvkn+loC7Mhgix6FZFZvhkg4B3vTaxaD5WwHBrqjUQhGRyHAguHBbADJti
         j6tFP1GA2QVbgyvQD1NKS2EW55hsdUEFRTAcV26Vzuf0TqJ0oU999ox7amxu2ABHJlca
         ifYw==
X-Gm-Message-State: AOAM531Vy2VRQXgS607Yisd/8B2qSopmI+DMgiBUHQzlxzK9L2O+i445
        /SfZ/tW//mY07JgZ0VjFDo3hDQ==
X-Google-Smtp-Source: ABdhPJzPWMPlIuNsctMM3lQA0eW5aHtZU2z/+IZrkDbSwVn9Lkkx1kxRUDGqPpgDfpIi6XzYd8QYBQ==
X-Received: by 2002:a05:6214:2aa3:: with SMTP id js3mr29996042qvb.49.1636106857887;
        Fri, 05 Nov 2021 03:07:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n19sm5709011qta.22.2021.11.05.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:07:37 -0700 (PDT)
Date:   Fri, 5 Nov 2021 06:07:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: send: two tiny unused parameter cleanups
Message-ID: <YYUCaGKz7sCSbcLi@localhost.localdomain>
References: <cover.1636070238.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636070238.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 05:00:11PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> I encountered some places where we pass around btrfs_dir_type()
> unnecessarily while I was working on fscrypt support. I might need to
> stuff a flag in btrfs_dir_type() for fscrypt, so using dir_type in less
> places makes it easier to audit that change. Either way, these are
> unused parameters so we should just drop them as a cleanup.
> 
> Omar Sandoval (2):
>   btrfs: send: remove unused found_type parameter to
>     lookup_dir_item_inode()
>   btrfs: send: remove unused type parameter to iterate_inode_ref_t
> 
>  fs/btrfs/send.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
