Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D044571B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhKSPkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 10:40:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81640C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Nov 2021 07:37:30 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a2so9789397qtx.11
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Nov 2021 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uSiFALQeJdjIsHpo19crR1r9PfkDBTxo2788sCMhKQ4=;
        b=JpEa9krjbna6rzdICxB+t199Dwne5cJ9gcj7UkmcuhEVSr+xhs73D6BDdMV5/EeSlg
         bkFkYWEeUGScyo84J5hdLthPql9m0fO+wnYGvx+APkHSOJEKHTYhpkLS4ShjNblIe3QJ
         A5q8MS9w7MPcoCokKxQZFdT8VDxZIXxXGa4p3N6cCbt1nLfHETFPlQjTlB+uiYRtbRG1
         lv0Z6En9QivrvU2CnsTOei56Dn+E50DnseB6XjD35C5dY9aivYx3cYvl2MmSQf+1tPv8
         DsFxBr7O0QKmpPfP7AIYOTIvJTgYJomtHtf4LcWlYUdJvd1jwfIxiTT9Urr3MMjtJs0S
         qNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uSiFALQeJdjIsHpo19crR1r9PfkDBTxo2788sCMhKQ4=;
        b=bvvY5wOOv9mqilh7gHwWjhiCMtKpzSaLgHDRwccjT4hcDVSF8PJ1LroD0wQQ3PUbr9
         yTa4jLhYrS2Kie/kCDIGEAP43a4khEWQx4xu+VWhdqNJgN6R4l697sk5G5ld6M2g8SB+
         TmaTzfvMwK02xkWi0J7cSBbGwZbE6xQfLZ7oKY7cJWh2rxNITnXgkiqgDfpKDr60pZ7i
         zzj8he9l+UBovv602Vi3yVAtUMaFRplyJQDhU9uQJqq51fmw00IuSATLW9zoR+WOIpVt
         j9LDis9OHRH6W2ocQPJvmZcBEgqRpC7i+fRYkxwPBMtmFsUQ9JD7pHk6hsC8c84WJFxG
         dU9A==
X-Gm-Message-State: AOAM531JDM5Gf1M+NjzU9FT/NmiSDSpVwnwOyf4Rn0DfS4oJN/xv07qJ
        KjGerLwWIxeVvwcsiS7WB5iwjQ==
X-Google-Smtp-Source: ABdhPJylaPNjJC3PeKutd2T41IcL2y79QYeXiXFkoQrZWHFDFqt2EvmjdG0WaddLJPbP3YQ+yqePvw==
X-Received: by 2002:ac8:7dcd:: with SMTP id c13mr7023943qte.133.1637336249511;
        Fri, 19 Nov 2021 07:37:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f12sm48650qtj.93.2021.11.19.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 07:37:28 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:37:27 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v5 2/3] btrfs: index free space entries on size
Message-ID: <YZfEt/i0E87N+FmG@localhost.localdomain>
References: <cover.1637271014.git.josef@toxicpanda.com>
 <afe97640a3d170bea4be47e7ac1487bc81be3a89.1637271014.git.josef@toxicpanda.com>
 <PH0PR04MB7416BDFF1C613094C64689639B9C9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416BDFF1C613094C64689639B9C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 19, 2021 at 10:52:38AM +0000, Johannes Thumshirn wrote:
> On 18/11/2021 22:33, Josef Bacik wrote:
> > +/*
> > + * This is a little subtle.  We *only* have ->max_extent_size set if we actually
> > + * searched through the bitmap and figured out the largest ->max_extent_size,
> > + * otherwise it's 0.  In the case that it's 0 we don't want to tell the
> > + * allocator the wrong thing, we want to use the actual real max_extent_size
> > + * we've found already if it's larger, or we want to use ->bytes.
> > + *
> > + * This matters because find_free_space() will skip entries who's ->bytes is
> > + * less than the required bytes.  So if we didn't search down this bitmap, we
> > + * may pick some previous entry that has a smaller ->max_extent_size than we
> > + * have.  For example, assume we have two entries, one that has
> > + * ->max_extent_size set to 4k and ->bytes set to 1M.  A second entry hasn't set
> > + * ->max_extent_size yet, has ->bytes set to 8k and it's contiguous.  We will
> > + *  call into find_free_space(), and return with max_extent_size == 4k, because
> > + *  that first bitmap entry had ->max_extent_size set, but the second one did
> > + *  not.  If instead we returned 8k we'd come in searching for 8k, and find the
> > + *  8k contiguous range.
> > + *
> > + *  Consider the other case, we have 2 8k chunks in that second entry and still
> > + *  don't have ->max_extent_size set.  We'll return 16k, and the next time the
> > + *  allocator comes in it'll fully search our second bitmap, and this time it'll
> > + *  get an uptodate value of 8k as the maximum chunk size.  Then we'll get the
> > + *  right allocation the next loop through.
> > + */
> > +static inline u64 get_max_extent_size(const struct btrfs_free_space *entry)
> > +{
> > +	if (entry->bitmap && entry->max_extent_size)
> > +		return entry->max_extent_size;
> > +	return entry->bytes;
> > +}
> 
> This part is also present in 
> [PATCH v5 1/3] btrfs: only use ->max_extent_size if it is set in the bitmap

Yeah I moved it up here, you'll see the removal lower down in the patch.
Thanks,

Josef
