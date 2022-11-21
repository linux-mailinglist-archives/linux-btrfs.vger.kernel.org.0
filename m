Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E632914
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKUQMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 11:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKUQMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 11:12:17 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49BC9A9A
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 08:12:16 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x21so8343207qkj.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wCL3HnbA8XboVxTnnLL/v8/pUUmIVLpxIxzu9GD3vc=;
        b=wdzYHmxpq66KQHvCVZ8w2C7JoS4WJ4zpc2gYmXu5bx0Fh5LPKh57UvihWF25cEi446
         XNuylLtKjzNsVUrMYsmdStieY2z5AjURc3BSn5rVrEW4yAcrEVmY99hlsH9yTveSfAAs
         TKvQsCRLfExiJLuJAJc1lomPAha7vrk5RQfN8pEkREvlAXyWPuLzkGev8O1/o6UAcNL+
         ZAYAE54/nE8tqPe6OcXO2TmaUMWBpAE4PSQ2g62mKwtEqqUqCsUjv6rSUU1M4bHdwMsB
         RJagwnPaK1uw8XeHgDhw2JdF2l7QccLIoqH7hKav0cAaeBmTAlxFc+ZT25gOx9SkBEsC
         580Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wCL3HnbA8XboVxTnnLL/v8/pUUmIVLpxIxzu9GD3vc=;
        b=p/gmOl3MR5BOFTG18OlgrEL92nklmQnPDhlcEKjYo7tYtT8JcpVXgw0qvpIAsXujqR
         wkJRA8Gyf24M/AuFa/KsyEJuJPxYb5l7wv2/H/wdxnikjhvQYwmP3jfxKwgTDjPPSt/s
         mESVsHdaqcB+N1H8dos+Ub73o0Q+nvGbGP/h363WPZ3bPxAhCxjWvpvKQsughEbVa4SE
         vHEx5i9hlZklFcU8ZpztC1nVSEVbsKs08IoWclVlJfWzvQYRb6q4gZ90fdFYg1VGxTL/
         3CgeqDP1Dj8upr776csu6XubMaXtKEpVKJ2oQOaZLuu6FlinGyA6q1sKtYTtO+SGPcyH
         /3SQ==
X-Gm-Message-State: ANoB5pmoRheCZ2jFvwmmlem2EvZQ1/VlOPOd7iT6xGvO5yc30xM5nI1b
        Qaa352OfFMPPLwftXqNsF+PdFg==
X-Google-Smtp-Source: AA0mqf7nhXGcSxs7Z5fi1X8S4h4YBsseYgqmpSIbbn+foqVG5G7ZWb0e25IsiV7lokqqpVtxPx5DKg==
X-Received: by 2002:a37:a53:0:b0:6e2:285e:92ea with SMTP id 80-20020a370a53000000b006e2285e92eamr3356028qkk.213.1669047135906;
        Mon, 21 Nov 2022 08:12:15 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05620a179400b006faa88ba2b5sm8464784qkb.7.2022.11.21.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 08:12:15 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:12:11 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a rare deadlock case when logging inodes
Message-ID: <Y3ujW6Ymz/zbmrPt@localhost.localdomain>
References: <cover.1669025204.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669025204.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 21, 2022 at 10:23:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Syzbot recently reported a lockdep splat about a potential deadlock case.
> It should be a rare case, but it is indeed possible to happen. The first
> patch in the series fixes that deadlock, the second one unifies back two
> functions that used to be the same, and finally the last one removes some
> outdated logic and adds an assertion (and documentation) to make sure we
> don't forget about that type of deadlock in case overwrite_item() gets
> used in the future for updating items in a log tree. More details in the
> changelogs of each patch.
> 
> Filipe Manana (3):
>   btrfs: do not modify log tree while holding a leaf from fs tree locked
>   btrfs: unify overwrite_item() and do_overwrite_item()
>   btrfs: remove outdated logic from overwrite_item() and add assertion
> 
>  fs/btrfs/tree-log.c | 149 ++++++++++++++++++++++++++------------------
>  1 file changed, 88 insertions(+), 61 deletions(-)
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 
