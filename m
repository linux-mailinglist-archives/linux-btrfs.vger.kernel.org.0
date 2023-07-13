Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871DE7529A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGMRSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGMRSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:18:17 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4FA26BC
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:18:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57045429f76so8433067b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689268694; x=1691860694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E61GaFoBl49xSj3VQ85JDlHY0SShC8nnQMoI6F3FZEM=;
        b=riONGvrWSIVaD8zlK3yIignNYwjQwyLCgw0OB67kszDhV23j9jpUC2cFvbDYJg76MI
         FZxrgTWuYikQ3w3d2/BSEci6ZpfcbONspzwl9rlm7fTz2SGp7HYD+76iKkFa91ylp6C4
         ZLbih1pOlgZv7k649J98IdqyLood8cc+u4ERUGrMktvbxoKyVuAA/PurHvuCT1NdC0qI
         tPkRp+eHCmxQ2GFkfhfNaDdcsHn4jo2toc4i2HtXcXGbVi+jj7fT4iox5T2qe/bqLM7v
         TNUngTucgO0Ui1B5NOCl+lxwmcy5kQtRYtQ8/j5ZtUQeANU+zYfUqrjtHglIrwQAbTkk
         7oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268694; x=1691860694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E61GaFoBl49xSj3VQ85JDlHY0SShC8nnQMoI6F3FZEM=;
        b=hlolL6092JcH/XGEHtfHt1BWM+BByeWbqFKRedVM8B/ipLCD8zEqA2xvXgX+Gdg6e6
         5wj9WaXKR4XKfB2tMeoPIv7fg7/qur0axv8r+WUQts3t9aUsZsGgoaroC+w2DNPKaJOk
         JuJ+AEjjUtkzPoO83heZaJov8193/eYt8bsUf8G/EqA7ontxYp6Ga78W2sA08LdUQPEH
         YFd144AyMvW6ZfTFjgtnAsJtwj1zkCWs6L+U71OpRD3KvT4qTMgEpnYTguDd9Aa2v+N6
         TRiyAkyR928/mzfgkkGLouI3/aRqw9/c6/7gmRM56ocNJBR27rJI2KnbOOzisWbv5tPS
         Mrmg==
X-Gm-Message-State: ABy/qLZKT4mM69QmAniDqxzJS58qcmhmdFv/8wFvKGxpMEqJybjw5GjY
        mnpO8ImzHrd4gURpTY3luwwKblt/+3Y4bWAFhHz+ig==
X-Google-Smtp-Source: APBJJlHigimQVmJsnjbWrGjhic0LhrcGbLEOA9wksEizC4QX+0JyxXe0UafaDi5+bF9X33hlNexEWQ==
X-Received: by 2002:a0d:c804:0:b0:577:3561:8a81 with SMTP id k4-20020a0dc804000000b0057735618a81mr2301632ywd.22.1689268694313;
        Thu, 13 Jul 2023 10:18:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y80-20020a0dd653000000b0055a21492192sm1856815ywd.115.2023.07.13.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:18:13 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:18:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 13/18] btrfs: inline owner ref lookup helper
Message-ID: <20230713171813.GM207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <d3c4af6907e2198639cf87e61ee17f7ab504f0c0.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3c4af6907e2198639cf87e61ee17f7ab504f0c0.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:50PM -0700, Boris Burkov wrote:
> Inline ref parsing is a bit tricky and relies on a decent amount of
> implicit information, so I think it is beneficial to have a helper
> function for reading the owner ref, if only to "document" the format,
> along with the write path.
> 
> The main subtlety of note which I was missing by open-coding this was
> that it is important to check whether or not inline refs are present
> *at all*. i.e., if we are writing out a new extent under squotas, we
> will always use a big enough item for the inline ref and have it.
> However, it is possible that some random item predating squotas will not
> have any inline refs. In that case, trying to read the "type" field of
> the first inline ref will just be reading garbage in the form of
> whatever is in the next item.
> 
> This will be used by the extent free-ing path, which looks up data
> extent owners as well as a relocation path which needs to grab the owner
> before relocating an extent.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
