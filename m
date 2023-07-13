Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297D27529A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGMRRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGMRQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:16:59 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D13CE
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:16:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5703cb4bcb4so9181547b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689268618; x=1691860618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4e8O1FOHKmfw4bPDQ9ygMaBCDpWY+36jteU52+IyDU=;
        b=UGfbFRVyLQ/JrKCqELG2jh+tBpe4SZaueFH3juxALjNKWxUqEshk2AqLZ5EWGuk1z3
         3GPrT3nvvNvjMssGdaNLy+5nctffZSLs41alYfoI3ALwRPc0jT7tAypoquzfhDKYqemT
         7x+5bvFZm+0qLC9cgfNxE3MR76N5VAB0wwRzB2opMmChARMIPRAr7YpK3PkRMCCA01oh
         W2TpfaffhnMQvP0fnz5OMKF4FObEM40d0WuO0jHCMpQlDi0GLXZmSVXqR4Tu4CdOvdeW
         sMgteY4s2dVdQAe7P3U43NcPxZyEgUFTVK80IxxHdNT2xWsikgDYFc25flAlcNZ8f3wB
         0yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268618; x=1691860618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4e8O1FOHKmfw4bPDQ9ygMaBCDpWY+36jteU52+IyDU=;
        b=QeBdEhozoK0kVV48HsBCsABQ9dQsoxJvZIZcCzaXEGPTTef75zgmoknvZZgjvFSbaq
         XQuG+ZC0pkWV2cGs8EQrYaSL4ZwrtmW59K7o7NncpKzUk7TWrCNBF//ar6TLhtS4xR+H
         luGM/WE6HTUexpoD49yQMBTIo2Q7Hq+4dhDdFt405fCV1Eoc6MoKrn43LeCbvaYXv2M9
         tXutISSAIkmQnxGYox0mLR80WE5+/p+g6vNsQVSTrFPCA5F0CiP2acfYfHPkIyp94e1T
         q8nwSwBLin5wI8JMcBWm1RSUMIk86OR3tjqzUAySFvsvHCHPugNZgf30Nu+wJyBPtA2L
         OkAg==
X-Gm-Message-State: ABy/qLY6rHHiaG2D2MIcNI4wzdch73GCEqaYogtO0Gl3dz5QCqoOuCiV
        OX0yfsdLbCHPrp2ofAnVZxPyBw==
X-Google-Smtp-Source: APBJJlGYaKx0nJWwIACOemPvHjeLVosEzNWqRA/nEvcBGKo7Mznc96m34yo89EUvgDP0u4TjtwEtIA==
X-Received: by 2002:a0d:dc83:0:b0:570:2568:15e with SMTP id f125-20020a0ddc83000000b005702568015emr2840323ywe.43.1689268618020;
        Thu, 13 Jul 2023 10:16:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c124-20020a0dc182000000b0057a05834754sm1856916ywd.75.2023.07.13.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:16:57 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:16:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/18] btrfs: new inline ref storing owning subvol of
 data extents
Message-ID: <20230713171656.GL207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <8d5a36641f7d79b66a1b306cee87f52bf1fb3b23.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5a36641f7d79b66a1b306cee87f52bf1fb3b23.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:49PM -0700, Boris Burkov wrote:
> In order to implement simple quota groups, we need to be able to
> associate a data extent with the subvolume that created it. Once you
> account for reflink, this information cannot be recovered without
> explicitly storing it. Options for storing it are:
> - a new key/item
> - a new extent inline ref item
> 
> The former is backwards compatible, but wastes space, the latter is
> incompat, but is efficient in space and reuses the existing inline ref
> machinery, while only abusing it a tiny amount -- specifically, the new
> item is not a ref, per-se.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
