Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1064BCBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiLMTHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiLMTHk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:07:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5CB1F
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:07:37 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr11so649246qtb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rFI1ENUcqiksmBNXaAzdgziEzpMgWJxSFe9nJfxrfA=;
        b=Xr6eg4isHN2uLHPpEfKgmnzq+6g5gyllWwc6khBaPOgjv6e35ibSnmhgHm1SY/68oA
         oBZOu3UnHtmoo0lOi2s550XU7+se4qJ5zpcszjN5/PWQocWYmJ2Tj+30p4GbmtK9vzdW
         ma9YAIB/cCmoxOIJ8CCcmpZomNFahih6cmi2LxI2oI8KZpB+Vm+GdgzTMFPxId6izLOD
         7uVD14A4LQh0byeN7DUGPqnieaEfDcK4Y7Xi8djYo77gBh76HbXC+wzMODZpffiPc2gd
         MXNGwWmuTu/uNdABF9p0QigeNzCEL4fX/Vf5ldZ45W+9ocCJkKAwE9VlodBsg6NPPjbv
         RgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rFI1ENUcqiksmBNXaAzdgziEzpMgWJxSFe9nJfxrfA=;
        b=43lrN0jymRvjsT+SPgt3ebE0v4eG/iosqDFlHozdrxxsVa+tIczdfxsUki4kk42xBA
         wic9nuHIHGRUYnWZxHUSOcHEbTBPri96yhsw0R1YQq1zfuQrXlxSd1ngHKHRCe0O3W60
         7LE6qsbiksD/2w8MZbO9UmbKdQglM0N7zMqkf3eL5sDLeCvzTXfx9eVkSQ50b7fTOkKi
         tGN7MQ6FJYoKEQl+E7kRYsIrNlHcIG5fD0NVli9new+FniW2wzR+JFbAv1poO32D0yoW
         icSebgsB19m8jJCiHb6f9KYSVCsQ5dEHegrUcMrdw7JMUDDZbj0kBbfJEBptZjwQgaEK
         kPSg==
X-Gm-Message-State: ANoB5pm0MxiP0GZayA05XZcYjFDG5AlRe2anBmuHhwUr2ujF1TbaXZae
        D9BrRwcw3gquoRbW0iTpWGMSK/fj8EnsiocruiQ=
X-Google-Smtp-Source: AA0mqf4QmWKrADUnic9DFKcRxanyEKyEUseeqm+lUnZI+bJImyyoGx9o7eNUkJh5s9zuvjj/cW6mmA==
X-Received: by 2002:ac8:7551:0:b0:3a7:f424:d1bb with SMTP id b17-20020ac87551000000b003a7f424d1bbmr6444519qtr.21.1670958456296;
        Tue, 13 Dec 2022 11:07:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bz7-20020a05622a1e8700b003972790deb9sm327548qtb.84.2022.12.13.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:07:35 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:07:34 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 10/16] btrfs: decide early if range should be async
Message-ID: <Y5jNdnH8pMyQrvB5@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <a822dc88a07268a9472823a77f17ee2384408e81.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a822dc88a07268a9472823a77f17ee2384408e81.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:28PM -0600, Goldwyn Rodrigues wrote:
> This sets the async bit early in the writeback and uses it to decide if
> it should write asynchronously.
> 
> Since there could be missing pages, check if page is NULL while
> performing heuristics.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


Ooooh ok this makes the comment I had previously not matter, so let's re-arrange
and put this change first so that it's not confusing.  Thanks,

Josef
