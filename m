Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01BC7D3A62
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJWPKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWPKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 11:10:41 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC590
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 08:10:34 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59b5484fbe6so35673077b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698073833; x=1698678633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KT/yC7uPar1/8Ex9cQ/S9J2X1+tzCHBSayZxtj5rwtA=;
        b=S18kDEOj6zG/riOsexBU/GJAOiI0WmxUg1KXoqZlH3+ZP+rHf5MUyZ3uC9ozEzZU7g
         SzHvvHgEXWeP+T0CToHBGm6wy9hT5Pi/BqUnh7lh8VA3cFz0kNDoW0Q+BU/1p0G4z8WG
         rw8TlVZ+AY6IlCudc1WtgfTZg7u1mKRGY8mRegBlYPJ2ivGkptez394Ntp7BIzSkPR5k
         G9oGQB29PFc0vQTtoWpNjKtpsW0BZQBVEr2hmuIRYIzBbeLIvLuX/wbIXXpB/KtSPZT7
         qlXUzToEHvGq6sUtUGnmkIkJ9ZU944OqSaN7zjEQ0iBFKp8S5HTBYuk75+UKK7jVSZZl
         utcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073833; x=1698678633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT/yC7uPar1/8Ex9cQ/S9J2X1+tzCHBSayZxtj5rwtA=;
        b=LrPSsC8Tfw4QUoYIafh0qSZUxrqHll6sVSgGqAhvlVFCOPnMiyQUbgjY5J1yvH5au3
         FiGWk+7Y9lCB49bt9FEZt8s8B/nxi+zcWp9X0Ib+x0DBJe0T1XjKzsyOcbGbtvKkfcao
         JJsr3yevbZqfUlk47LOcwNBgr8CotZYCHFcCazVIGADLKDk9y1S8+tKIZc9EdpzvMQxH
         +b+lawE96Sn9+HN4K1zKrvFesgmEjGNkHS/AyEpYm+Wu27IowknMlKC/Y+SgqE2Ism4J
         V5tF7z7drp95ow/YpF5fP+2IqgSte0LiYiTnf4hVcH0PL6itY/xUzb3lGkILdkmd7TCj
         M18w==
X-Gm-Message-State: AOJu0YxN6oACsF/NHOKdErMVf+l70lReq/s50iUG+gG++w0ZDj9cyY/8
        J2fF2m9NAoQQtH5QkWrts1KocA==
X-Google-Smtp-Source: AGHT+IFikmGkJ7Nzuv7LRFMijQJRvhXqDUCUJXPVUuEPr4RZpR/9XtNJFAPFSsvg+ch/pYzgZToz+Q==
X-Received: by 2002:a0d:e347:0:b0:5a8:1d75:65c3 with SMTP id m68-20020a0de347000000b005a81d7565c3mr10397114ywe.13.1698073833709;
        Mon, 23 Oct 2023 08:10:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d5-20020a0ddb05000000b005a80102fe3bsm3227059ywe.13.2023.10.23.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:10:33 -0700 (PDT)
Date:   Mon, 23 Oct 2023 11:10:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test snapshoting a subvolume that was just created
Message-ID: <20231023151031.GA2798160@perftesting>
References: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3149ccc2900f5574a046e675a6db79b019af2bac.1697718086.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 01:23:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that snapshoting a new subvolume (created in the current transaction)
> that has a btree with a height > 1, works and does not result in a fs
> corruption.
> 
> This exercises a regression introduced in kernel 6.5 by the kernel commit:
> 
>   1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
