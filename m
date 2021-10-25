Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC38E439A98
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhJYPi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJYPiz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 11:38:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A21C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 08:36:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id r15so12070251qkp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RYZB1oAT/ItXmC2NBzcBdbSxPq+6KoiymqV2Kz2l7rw=;
        b=BXIBWWDFU3Gpnzb2oobp+bfCp0pfQlcMgiEYTY7AHc9YC3XnNy23pKwcE6c0wFR3z+
         fLvs2YQ8enbZfvZIVJ0lKrsz5TT090Vl/up21jLvb14xnBnjWA9lmdc6lyFg6aIcuBoU
         najNfvjlpTQMzHrBsmXwel6tRJDmRkJMzlT92QPaDE+oYIMcYPK0lxD/U50NiyhWlgu2
         x0Y1V1CNjCBVJZJ5fyA/5AsSKC+EU3tVeqjZMwCM4spkbxyvsSJTpQleyJqTdz5JBE0s
         sqwgHgc8hhCtrOavc2EskBct6Sv653UKR7J4v108DkLcgf0L3ahu9mp63Noyfl+Zz7kr
         W4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYZB1oAT/ItXmC2NBzcBdbSxPq+6KoiymqV2Kz2l7rw=;
        b=yNh9ha1ibaE7Esb9W/QIv45KmF4ybkViBx+RF1wE5uLdluJ6ESXr1qqtKVup91mrYT
         20KF6Xf0mtawboHkiV5YcKfNJ/KFOB1qn4sItvBkr1VM+R9CuHXj458MdqBvRRKhJuYU
         EwK3nRtOXKkNxDlsnGlcG+yS/WK+b3K02jEMPa+DeEY5GkleT9lKf89vJJzuNj2aH0Jc
         Xro7zmX6eyZsgC1XJcuT9+07RnE8tNCjehEaABMlDx+EnUA4e3UFsERawgDY0ncbVYF2
         N08HbltTn6aaCat00saqbgUd5kuge12RnDu8rpSAXoDPd9UniSC065LmEhDWhwoVhwmo
         3DGw==
X-Gm-Message-State: AOAM532nIIr0ebTAK3bPs73ZIyqjh7w6aqkYpaI7Jw3vsbNiH28oTi8D
        8z+xEn5JuSL7rgJU6C2I/CwrwRcvr+zFFw==
X-Google-Smtp-Source: ABdhPJz3w2zM9hfNohY0HOKwNgaff3ogeZnrLpbVE56KKFu6jD/1ab0ViQvsJp8+cNrOxhgXJOuEuw==
X-Received: by 2002:a05:620a:d96:: with SMTP id q22mr1268564qkl.219.1635176192680;
        Mon, 25 Oct 2021 08:36:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s203sm8682039qke.21.2021.10.25.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:36:32 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:36:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: only copy dir index keys when logging a
 directory
Message-ID: <YXbO/lfI2RvMNz+W@localhost.localdomain>
References: <cover.1635155473.git.fdmanana@suse.com>
 <9c22f976b9bc0a5725d80f2a365316c1ea3706ed.1635155473.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c22f976b9bc0a5725d80f2a365316c1ea3706ed.1635155473.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 10:56:25AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently, when logging a directory, we copy both dir items and dir index
> items from the fs/subvolume tree to the log tree. Both items have exactly
> the same data (same struct btrfs_dir_item), the difference lies in the key
> values, where a dir index key contains the index number of a directory
> entry while the dir item key does not, as it's used for doing fast lookups
> of an entry by name, while the former is used for sorting entries when
> listing a directory.
> 
> We can exploit that and log only the dir index items, since they contain
> all the information needed to correctly add, replace and delete directory
> entries when replaying a log tree. Logging only the dir index items is
> also backward and forward compatible: an unpatched kernel (without this
> change) can correctly replay a log tree generated by a patched kernel
> (with this patch), and a patched kernel can correctly replay a log tree
> generated by an unpatched kernel.
> 

This took me a very long time to grok, so it deserves more explanation.

The problem I had was how this worked in general, and I was missing the fact
that we're only calling drop_dir_item() if we find the name in the root,
otherwise we either goto insert if we're DIR_INDEX or bail if we're DIR_ITEM.

So whichever we find first in the log, we call drop_dir_item() only if there's a
conflict.  Then the heavy work is done once we find the DIR_INDEX item.

Which means that the only work we do if we find DIR_ITEM is drop_dir_item(),
which we do in the case if we find DIR_INDEX and the item is there.

This is why we don't actually need the DIR_ITEM to properly replay the log for
older kernels, because DIR_INDEX does the same work, and actually does the heavy
lifting of adding the BACKREF's and such.

This took probably 30-45 minutes for me to work out, and I'm only 90% sure I
have it right, so an explanation as to why it's ok for older kernels would be
very helpful.  Thanks,

Josef
