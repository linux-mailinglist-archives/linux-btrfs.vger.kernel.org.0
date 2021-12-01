Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA6465352
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 17:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhLAQwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 11:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbhLAQwQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 11:52:16 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322FC061756
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 08:48:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 8so24668813qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36mbXOhaVhlTWQLQHkSfWgD4m7VJ0qP/QESzXqNxP0w=;
        b=jQaYplIi0VLaoK82sBgIqfIY9XSH06wmy/vEzhwrw/AsIlsT45gg6cJsf4H0ZlL3ow
         lcH7DWIM16b0pEpzbGERvohGqB264UeOKBHL1lYdqX5MiUAyRYlhEaf3q3krAhL3WVPN
         9etmwMCtNPAWCOKA7OqahhXlzvGoQJYtx6KZ4dQe2LoT2Z3cCq7HnPTYBRxiqC06mQqs
         OkwXvbnHtLgCTaTgvW2eBdE9GLv1mZint2D6tca/DpUsefGglEV3DwkN64v2YpraM/te
         TaqimbpuztDBHI/ZbCDH6jCHboylRACueZrG8Y4ieqRoZY4QBzu6rvXDQ7GCUXG2r4Hg
         IZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36mbXOhaVhlTWQLQHkSfWgD4m7VJ0qP/QESzXqNxP0w=;
        b=u6H9mKjajRfJXJxKwQZtBRDNg/sWtyT9SU9x3LOYy1L18PSevoL78NbrUT+imA7cv5
         pJ+ZMntPjriy+tROgl6gEVSpjhyvN+ijLaxmp2NBe/RtKGnovEv8UFeBw3MMxh2vTDJ2
         LpR2EUHlSew++y44eqgMu4bSmuVaJs89dV4pKWSkh1HwOgp/RkVnCWlhrVgHNwY6APUd
         E8/mg9o8lULIxSBmGGo+QRfG5trelq0qqXo40rjmr39Nfb9b/WkTfPrBGht6/rUt+NdR
         EwuaYUBe4uIBWFOPQI0fNI+3rILZKgftNEOcWe6CFgYaDJra9lfYyfm1q9rcFAip0Vc4
         3FZw==
X-Gm-Message-State: AOAM533WULG7gpeTs/8S01MjGC8swf41v8TCPLMtJI7gieuji5yOgQ3J
        BOb7EIQv05oLrHiRze6NpYvgXO6UMMsQBQ==
X-Google-Smtp-Source: ABdhPJzp2Au8XRqUZNOt31djr7PQQZqbaPLdVAwqDp25kudVpf5vFWpWp0KWGSqkPbLTW2amaFqOxQ==
X-Received: by 2002:a05:622a:181d:: with SMTP id t29mr8056983qtc.338.1638377331942;
        Wed, 01 Dec 2021 08:48:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de13sm138040qkb.81.2021.12.01.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:48:51 -0800 (PST)
Date:   Wed, 1 Dec 2021 11:48:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace the BUG_ON() in btrfs_del_root_ref() with
 proper error handling
Message-ID: <Yaencnx4r/mRsAw2@localhost.localdomain>
References: <20211201115617.144434-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201115617.144434-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 01, 2021 at 07:56:17PM +0800, Qu Wenruo wrote:
> I hit the BUG_ON() with generic/475 test case, and to my surprise, all
> callers of btrfs_del_root_ref() are already aborting transaction, thus
> there is not need for such BUG_ON(), just go to @out label and caller
> will properly handle the error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
