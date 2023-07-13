Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A493752868
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGMQeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjGMQdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 12:33:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B353A92
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 09:33:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso822873276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689265991; x=1691857991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOxnWdm8mkRxV2Ugznr452z7oXz8LC/kWwxvNCLlUL0=;
        b=of111xdFkVAB7jhjC7E35q7npH+WfxW5LFxSKmQ7aH0e7EHXfE0I8yGaAXOzheuUNB
         xxr4n5tE1knYGyEu+D4yv/NDMFCFDAB3LD5v8qrhrHQExEBv6d45XFhgxhMrLW+r55Uk
         /GVryX4/FvDxgHSotspERIs/uZAHrPPm6GUY/KK+t+D+cNGjIbvhu+a0jzRbAH/peKir
         mkWvayQ5WErCGFhuUZ3OzxBZg50mp0ZXcgFHaVGiV97CAWfI7asbaY2z9cmU94Q3cwWP
         Y27TU1huXaoTb+n1zw3PtVcWP2xpBMoHdUNH6UWgAr+OxQmiHN5ZCCFIR6qkUCfN6mkT
         5blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265991; x=1691857991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOxnWdm8mkRxV2Ugznr452z7oXz8LC/kWwxvNCLlUL0=;
        b=ccWIUlYIoEkqjfYmj3DWN8Aa8PEEDjRc4lzez3GBdGvTsjs3wr+2vN8XLcHM51qUNU
         7xfMVXfq90rLxqJJ2xDbDe9UPP9qnHa+Mrigx5KabqMqrwZlUVPVfldvr28F05+BjhGX
         ZtOiy2qeGRA+GyRdTsmKNmdnt9523GHX5AQ8mq5MbL4Q2Cf1fOwmiU35T193StuMqFHx
         y6CIIveMauYPrBl8BzO2YtI6+zRe7sZ02AFUEE58X/L2TNsGI6AxVuhDAXTWiHGn7HZi
         AEryou1bBweIBHaeSIM1nHv7vjqUMLRZwGeR8YDeYLNyFQ2QdU/iZ2DYIGR2NnYBX7mA
         HruQ==
X-Gm-Message-State: ABy/qLY1sotvT1zmSIu4pz0DB49z5+mwGYxO2zRu8DZQytZIFCCtYF6R
        u9WQr2px7qS2I5uy5iWUTOOkjA==
X-Google-Smtp-Source: APBJJlE/vB6Zyj2zpmWUS6dp1bhKROSs6+Fuf3Fm2tfhlQOQM0ZCMjGwZZX9E2gmPDmaNVQbkMfQUw==
X-Received: by 2002:a0d:ead0:0:b0:579:f163:dc2f with SMTP id t199-20020a0dead0000000b00579f163dc2fmr2194069ywe.3.1689265990971;
        Thu, 13 Jul 2023 09:33:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o8-20020a0dcc08000000b0054c0f3fd3ddsm1861538ywd.30.2023.07.13.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:33:10 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:33:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/18] btrfs: rename tree_ref and data_ref owning_root
Message-ID: <20230713163309.GI207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <76805ec21163d519e27b073110f70f9eba214021.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76805ec21163d519e27b073110f70f9eba214021.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:46PM -0700, Boris Burkov wrote:
> commit 113479d5b8eb ("btrfs: rename root fields in delayed refs structs")
> changed these from ref_root to owning_root. However, there are many
> circumstances where that name is not really accurate and the root on the
> ref struct _is_ the referring root. In general, these are not the owning
> root, though it does happen in some ref merging cases involving
> overwrites during snapshots and similar.
> 
> Simple quotas cares quite a bit about tracking the original owner of an
> extent through delayed refs, so rename these back to free up the name
> for the real owning root (which will live on the generic btrfs_ref and
> the head ref)
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
