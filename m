Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D041782FF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjHUSHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHUSHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:07:53 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203EE8
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:07:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58c92a2c52dso41650397b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641270; x=1693246070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOyrYfS6ou+rPpKaBStsmd/9PPwQwSItJUuhHPbyt7g=;
        b=N2pMaCbFV5TD3y7ArCCJqg+eIvcInUSxWMHK01rWvHbZGkhlYXZrlW69g9pfnFuA9b
         /TZHaSaKAJ+c2DkqSNl0KYdqADx5yHqENg9h38A5/qc/uaUSSPiHjtZSQEytPB5X8sG6
         cP7zz1JLx3lzEKPeSVJwOfqLMNiGQENJQsRjQw2F8AVm9o7zdC/KQQt3B2LGUGXS3WMN
         1ClWhi4oinEtdsVPwL4OfWGw7zjNbDKyMre7lm4aQsNV0paFylxxp2g7Nm6+SCXYnYD0
         /roFiuvCtPTE/PEjPIWwHBDDq/onh4SDEn9OzuNBLBoRRfpehUGC0ZytyS65+GnQXWJ1
         Z3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641270; x=1693246070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOyrYfS6ou+rPpKaBStsmd/9PPwQwSItJUuhHPbyt7g=;
        b=WlnKFNWgrwZqlF/todOg2aKKalNGIOgTxXLkB5G915LOqcv31NIoFaNtbhdVf9DUzZ
         8uZJRJLTINrnxu9kYUQkO2pfX9n+epi+Sq/cpJ75znf1xqAZ1qinkL3yCtWaiDu7hKPn
         OmKgIrXXiPw1zVJmcLgnMAUPmjBC0QRwvVKD8wY/7OV0DGcl/IoFBiebKbMhgRoJvsy7
         +oMCcqseWTu02HFlCV1J8pCkAXLOvVFUhXbNrX7lr8LNjCJOTtD95iHv294tu6citPat
         ydFwnzHKaVwNof63/1paAXb+knRAucsAH07jiUoNF/5NjNiAXTRi08ww6xzRvXkzB1W7
         VnEQ==
X-Gm-Message-State: AOJu0YwCWTgMkr4kzPqkvbdc6BRv67/h4OmzFU/+tk+7Hy7Mmqmoo39D
        x/6fJkXiaONb/m/kLC+KTLfSE08ZuiMxN9/Fhes=
X-Google-Smtp-Source: AGHT+IHXBEusMcTHlKF7OMQpx66BCLsMJwZByvBe4nz34//pQZKFEj1PJz7MKsIp7/QrwBFLv93gKw==
X-Received: by 2002:a0d:d585:0:b0:577:1be8:c1ae with SMTP id x127-20020a0dd585000000b005771be8c1aemr9006161ywd.24.1692641270037;
        Mon, 21 Aug 2023 11:07:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p204-20020a815bd5000000b00589fb1f296dsm2358037ywb.51.2023.08.21.11.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:07:49 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:07:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 11/18] btrfs: new inline ref storing owning subvol of
 data extents
Message-ID: <20230821180749.GH2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <deb2d2bcfb7d6a9dbe9657b1a39659efc0e9f258.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb2d2bcfb7d6a9dbe9657b1a39659efc0e9f258.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:58PM -0700, Boris Burkov wrote:
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
