Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E5752B9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjGMU0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGMU0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:26:46 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380EF2120
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:26:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57045429f76so10373007b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280005; x=1691872005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAFyEuWmp8RdtEW4aU7EhT8/zwVwXLZebdZ2swkg5XY=;
        b=hUQapxNltJkLDiYwCFdiC1uk2TBCdsvQJzERJHS307b3PGYxbsPeDaOcZSKJmza261
         xLKgXMQmhb1JRWtc+01j54OgE5KPzcrxsMzn/YDVCDKmEls0JFrvUDz/UoKIVJoPfoYo
         K95LlTpxy1PS2QrqYl4NkbMaURKTf20XtQqzFPBy3bUgCfdakEZi3O+RrkR4CsH2xNuZ
         L1b/d33/Jh9hRt1jC8QedSFEzZNSzNrtTJmuMeBcQYHEsVVyP3j7fwuKjuvwlMULMWM+
         WFq1JAimo/ZSKty9xeaRBEgXQ7WBvgzlCfstFPCyNxQtYiJ9DTpIeJG+paWcyWgIrTlJ
         c/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280005; x=1691872005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAFyEuWmp8RdtEW4aU7EhT8/zwVwXLZebdZ2swkg5XY=;
        b=VrrMXLPP38Z2MjXcv17N5AB82lmniOwFxNa6HaE7RAg8kOW6dNrkYB87D/c10VaTW4
         8Tkz+BaN0BoQhddR0/6xNhCX5gbMlIp0JzXcaC+seFOa0FTyYMy+elwLqyrIPf9ldX4t
         wDyEBmIYjKqsg+EeXIamA0etORAxb6+vUOrjEZtUisFx6IcQw/L/7N+3nfdP7DO9mDC5
         iTtbhcp7TujsV0r6cfuQl0TBvOiIAHZRGRIWa6/mwymhJNk/f1vu0Hp0RpZHY3/oaG4V
         fokc+DZDYOQu7jYhzJScNUkgmiQ4HYQSku2ZaqnFZRxJwFfeTNd3H26prOhBTCaEpku3
         o/rA==
X-Gm-Message-State: ABy/qLYS5NyP9ktiSVwINfDP/Q9tX9eNSQ8a2sW9AAcTAanQhcA+DRmC
        o/XNPxRtvH2C2ws6+wthxuuJTg==
X-Google-Smtp-Source: APBJJlGkHzfiWlAT9/8E5R7P0vY2Xa9+cqXotf/eeeoz1nQpfWdLVGn+KylahQwCteqR/ZfuzGJTKA==
X-Received: by 2002:a0d:d445:0:b0:575:4b1c:e5f0 with SMTP id w66-20020a0dd445000000b005754b1ce5f0mr2657234ywd.32.1689280005227;
        Thu, 13 Jul 2023 13:26:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a187-20020a818ac4000000b0057a9a46e2b7sm1933704ywg.80.2023.07.13.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:26:44 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:26:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs-progs: simple quotas enable cmd
Message-ID: <20230713202644.GY207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <83c39c42c2d04a3d6bf7fdb7f63a31d3def1223f.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c39c42c2d04a3d6bf7fdb7f63a31d3def1223f.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:26PM -0700, Boris Burkov wrote:
> Add a --simple flag to btrfs quota enable. If set, this enables simple
> quotas instead of full qgroups.
> 
> This re-uses the deprecated 'status' field of the quota ioctl to avoid
> adding a new ioctl.
> 

Same comment here as the kernel review about just using cmd.  Thanks,

Josef
