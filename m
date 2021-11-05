Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C944622C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKEK1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhKEK1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 06:27:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFCC061203
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 03:25:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bq14so8304071qkb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dz8dds0Rn/D4rFasHh96BwfSdSGLmDlGTRd0pT7oXAQ=;
        b=cOm2KV/7BCZZQiJh7QnV+LeJHbRIPQDc8kplQH0kcQGHgIKDNxYSSsBab56rf5vRKg
         avGh5MWPTZlg0mcrfd2YSit7hhEI7wC0CrwJK2beK+ZSthVLg8G55vM3JQbKFLMO9gmf
         5IG6n8poU5+/HsxlXiyp027cuSaCFRslaFLjewlrX0dVDc1v1yZ7Nx36elNiNxIjLalo
         U9Ik1j3uJDlWvbiZvrqRXcv+pgJW5rxZt3zwlt+DWggMj4f9gILvTKxj6n09O4jzfy1t
         T9aJyMmC3+KsacbgWqYNuNQLkr/z56159WI6PiY9pjntkRbGWki+oVm4P8VnRuxgO1k/
         eVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dz8dds0Rn/D4rFasHh96BwfSdSGLmDlGTRd0pT7oXAQ=;
        b=5Uvknn2SczkoA9aWjatOx3HPmPNJdeEsyxtXl57yh85RwnxHu1grExajqiddRtppmb
         +yFn2twvHTKxt/iep+00CZVttMK4HU/tUZjIIT5Ynql3X/UUMY7dmhEP99TpZ0d9jEoe
         hSaruJODWRY9wEzUlkSokiYjAMvH/qxGPXVetFnBWqPepEEei2X1k5fByYwJQRdmXpSg
         RbtEbojTH2E81AN6aAQMhe/5c5zhv/641lOZ4EiU1KEhvr/hDH7rPX/CB93J1mAL2Ilb
         dg8psqeZtw2ZovjQQM50AjKnhPQW/h+lgLt65W9ni03z5gue6ActTkl1IIQAmZUApbde
         ucgg==
X-Gm-Message-State: AOAM5300CcRXtev1AKgIY30x9iuJR16AoqcZeduLIz78sEx3ki9T0wOh
        j9BX8bYvGJLpNXhAOwX2bX1FxpkE/Jl9gg==
X-Google-Smtp-Source: ABdhPJyUbA8qVmO3lqY8kItZUHcuMyuaTZHibRhSnIu8jpgd4MM3N3I8eS7Kl0DvN284kGZXv2W/tQ==
X-Received: by 2002:a05:620a:3705:: with SMTP id de5mr10147809qkb.41.1636107905001;
        Fri, 05 Nov 2021 03:25:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j192sm1903934qke.13.2021.11.05.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:25:03 -0700 (PDT)
Date:   Fri, 5 Nov 2021 06:25:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: make nospace_cache related test cases to
 work with latest v2 cache
Message-ID: <YYUGfguehWpzCE6d@localhost.localdomain>
References: <20211104005553.14485-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104005553.14485-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 08:55:53AM +0800, Qu Wenruo wrote:
> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> v2 cache by default.
> 
> However nospace_cache mount option will not work with v2 cache, as it
> will make v2 cache out of sync with on-disk used space.
> 
> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> to reject the mount.
> 
> There are quite some test cases relying on nospace_cache to prevent v1
> cache to take up data space.
> 
> For that case, we can append "clear_cache" mount option to it, so that
> btrfs knows we do not only want to prevent cache from being created, but
> also want to clear any existing v2 cache.
> 
> By this, we can keep those existing tests to do the same behavior for
> both v1 and v2 cache.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This will re-generate the free space tree needlessly, and in fact won't be
allowed for extent-tree-v2, so we'll just have to mess with it again.  Instead
add a helper to get the options if they're needed, something like

_btrfs_nocache_opt() {
	$BTRFS_UTIL_PROG inspect-internal $SCRATCH_DEV | grep FREE_SPACE_TREE
	if [ $? -eq 0 ]; then
		return "-o nospace_cache"
	fi
	return ""
}

or something like that.  Thanks,

Josef
