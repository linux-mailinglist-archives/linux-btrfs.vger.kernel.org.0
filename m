Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EF7529DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGMRaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjGMR37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:29:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0482C2D71
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:29:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bff27026cb0so901694276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689269396; x=1691861396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX4lUtkTmxSABtsdsIO9skUcqXDjhJctoqtz90HSgF4=;
        b=UMQiw0BaKEAhvcqtLQ5oECs2xrsQGF3SlacChx8NtDpz/FujZko7SmIOkxQoYMXlnu
         KmCbaYBwTK+2rBffH9Df6CEVwQVFJfY0SkbF/LsUggDqciHD1NIuzX8M0PzxRgcmPZJn
         H9O8nC7NK9EK/g7+K8fl5OQkc5xl/kMb7avu3ojJ/0AoiE1GmbO+6X77GxDW2zeeOvrj
         8TGm9Mt7mh+U+eQKotFg8dZwQKiq1V9Abczrezn1/ROIUspOLN/Y7GfmVXZVR4nAnUhe
         julLzDfD6BOxX+ybdAki4s7IRI9KxZXPTZjmxdNh7ohVA+N3FGGrs5VDE/pjlevtHKmN
         uNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269396; x=1691861396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX4lUtkTmxSABtsdsIO9skUcqXDjhJctoqtz90HSgF4=;
        b=UUarts90aFSqHSdkAmP/fqBaK87ScN7NdSZqqn4GfnTDPWbNQx3FoN4VW6hjGquNKK
         cull0OPpeLIk/2jDb+sirVxaszJDEKY7dY4iM0eL3z0dRIsT+uDZalEuIvmdJVDPWgGq
         Ug+RzvaGYrl9HKxDP5YgehtVva6EKeduvYJuq0E+m6KrxKxzeP45g7qw6sUpHLJ8XEpN
         f34z02Nkmi2ldcrPJJppNhMUNGR9LihCIZkIMiIeKZqK9ZgcBxmFKGvSaLO8/8qGVsHG
         Y6PzcQigVkp3XsVF/V4rlE2pjO/nFD3l5BeB2Nqe3V7Uk+BaNY+uWAbQl87KAIUlMzKy
         Yq3Q==
X-Gm-Message-State: ABy/qLYSG4Gn6irefFLVtiR+YwKhmlort+RmXgQoBlXTI+8ccmM0WYVn
        xVkK4VCd/KcaRs+cD4PC+sLdNApp8IUhdgDpTuqrEw==
X-Google-Smtp-Source: APBJJlHqjcdOnsBb3riO/ToGM/luxbpKy/Mkglu0seoBNmhx4Kw3sP/OIjR88Ak5roYZF6Eu0hlBmg==
X-Received: by 2002:a25:f814:0:b0:ca3:d324:8d3 with SMTP id u20-20020a25f814000000b00ca3d32408d3mr2103720ybd.51.1689269396003;
        Thu, 13 Jul 2023 10:29:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i14-20020a056902068e00b00c61125a3a6bsm1428035ybt.47.2023.07.13.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:29:55 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:29:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 16/18] btrfs: check generation when recording simple
 quota delta
Message-ID: <20230713172955.GP207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <53936613c2fc11671997383e1f5a5b5878687784.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53936613c2fc11671997383e1f5a5b5878687784.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:53PM -0700, Boris Burkov wrote:
> Simple quotas count extents only from the moment the feature is enabled.
> Therefore, if we do something like:
> 1. create subvol S
> 2. write F in S
> 3. enable quotas
> 4. remove F
> 5. write G in S
> 
> then after 3. and 4. we would expect the simple quota usage of S to be 0
> (putting aside some metadata extents that might be written) and after
> 5., it should be the size of G plus metadata. Therefore, we need to be
> able to determine whether a particular quota delta we are processing
> predates simple quota enablement.
> 
> To do this, store the transaction id when quotas were enabled. In
> fs_info for immediate use and in the quota status item to make it
> recoverable on mount. When we see a delta, check if the generation of
> the extent item is less than that of quota enablement. If so, we should
> ignore the delta from this extent.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
