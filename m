Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A76DF7B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDLNvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDLNvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 09:51:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBB01705
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:51:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54c0c86a436so339842707b3.6
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681307467; x=1683899467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBwLp09JHuI8VFayoPJ4kUQ/8aP6wDV67itipsTlOlE=;
        b=yau0VhpRk9W59hPFKbd2+6qZE8P1oxQh0LjrfwdIsJuudrIzVSdO70sTmo0rPtXVij
         zO4b5xc9tmAvmrzAeus9TRsjM9NZ7H6roltY4sOsNwukqKMijExJFebUVcClfSwuchZG
         kdIUsCrng6TQSSpvXJiuhwh0udS/9U+UYNU3ApRX8WHBOsuh0xL99qWy7yb84LYotfjD
         BRKh+CgbytG/7BMlFDeIiCNRwoNC0nx3KUbx/hT9e0SOEv6Kh4KodvxQnBsEcGH09DKq
         +GdibKChrHXNj/dQ9FaBXsmlTKXH7VFutv3gCA5SxWlojxDI8ZcRSKnaOgh6ZpOQQBBN
         vG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307467; x=1683899467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBwLp09JHuI8VFayoPJ4kUQ/8aP6wDV67itipsTlOlE=;
        b=DBQD2fNXmoUQAlEa/EVFkA9HPffBWryOd7mQy24xp4kwCM8xUKSiypl3bAXVT6xT0j
         1YZwfx9ht6dCjJYGrVAlqf7M4hLbOPJo8+a/NvrvcQ0fEIUXFB65ilWvMfHBHOU0H3+q
         mxHtfT+rjB1TgqWFSqEH88WdyMRZhR4pssSIhBN8sSdT1emtaV6LAnnSnxRq/AHVdIrN
         S+4GNyrv3UmEPzm8k7uhRae+i9za4AsO79T1PJ76JYxHfAM7cPjmEiS9Y3yjQt+ytHE2
         KZPcgKto184Gw3qWIcB2JwP1vfy+sTSlRBcmZo7a/trDuTqiXqluT8UzJ3O4rFIOcHgX
         ZfmA==
X-Gm-Message-State: AAQBX9daLEvtyNdsX9bIPvELyo/ieeyvOlkEIdrTsf0ng5qMgWc0d9aK
        awgfy18PmSoXcq8obL1q4dczttga47it7VcnQq1QXw==
X-Google-Smtp-Source: AKy350ZVc4UqRF7XFLwiut2LdLn3zroBMlBFQiAZs/NWLMIqudjtMpxTBekZ/0DBK/N5yDVgc3rLrg==
X-Received: by 2002:a81:5b45:0:b0:541:8abb:1f7a with SMTP id p66-20020a815b45000000b005418abb1f7amr13074067ywb.30.1681307466656;
        Wed, 12 Apr 2023 06:51:06 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a140-20020a0dd892000000b0054c055b8ffcsm4228902ywe.41.2023.04.12.06.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:51:06 -0700 (PDT)
Date:   Wed, 12 Apr 2023 09:51:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Message-ID: <20230412135105.GC3162142@perftesting>
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 11, 2023 at 03:10:53PM -0400, Sweet Tea Dorminy wrote:
> Recently a Meta-internal workload encountered subvolume creation taking
> up to 2s each, significantly slower than directory creation. As they
> were hoping to be able to use subvolumes instead of directories, and
> were looking to create hundreds, this was a significant issue. After
> Josef investigated, it turned out to be due to the transaction commit
> currently performed at the end of subvolume creation.
> 
> This change improves the workload by not doing transaction commit for every
> subvolume creation, and merely requiring a transaction commit on fsync.
> In the worst case, of doing a subvolume create and fsync in a loop, this
> should require an equal amount of time to the current scheme; and in the
> best case, the internal workload creating hundreds of subvols before
> fsyncing is greatly improved.
> 
> While it would be nice to be able to use the log tree and use the normal
> fsync path, logtree replay can't deal with new subvolume inodes
> presently.
> 
> It's possible that there's some reason that the transaction commit is
> necessary for correctness during subvolume creation; however,
> git logs indicate that the commit dates back to the beginning of
> subvolume creation, and there are no notes on why it would be necessary.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
