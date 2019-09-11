Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979A5B00BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfIKQCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:02:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45903 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfIKQCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:02:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id r15so25851093qtn.12
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNEVc57AMNBiRM9Y+oQ1xAuXBuovJun/Hb9+9z2k57Q=;
        b=tF1uL25AGbRBwYaT/hcVpD36KyKWBfbSNLYC1tUqyZ3MctuwcuqlqyShVDkbZ/AIqx
         DSDbVYITY7AwpXRK9BOYm9YMJyckwTMKgauQWu7+kYTR+EHGTlbwlg/9wsjMbUHabxuB
         vMhlAfbF8ZIvxFFc5Byit/D9qrT8jPDFxP7qeSCbrqdGfD9ZAdSK2V5YzUQUy8/iymX/
         a5yZm3Q3N965bw7cGvUM2fJpsKC6E9JisYmcDSsnlKNF0bZrsEFJL2ikSp1mJIJVy3H5
         Rsjt3Pn/NiJA5Gm5P2wqTdGVmqqf5aG5KzGOuV3zqUM+H9uc1mzyzEw2oq/VCszi37I6
         aQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNEVc57AMNBiRM9Y+oQ1xAuXBuovJun/Hb9+9z2k57Q=;
        b=l6NnhFcrFigfh3YHv2ciXBvG1Ch7curSsoSXFv7VtmBf33AZSVODmUNzWlVYyRCjgQ
         bQtrDAUMjc8gG1s8w9Kg+r+/dBudNsyLbdqznYc0jmgtITn28Ae/dj78GL4RUYl0hR4a
         R0JlXfLh5egec7onXujRhpVJo7v2pwLvENIEHLffWNmZgOGxhNo6Y4Y70JDNWXaUkhAv
         5PRNZSn0ftkZDz8ouQHbNvobcS/VigRL72rBkEpHF6yMHFGAWqH12yWUSGWo2m21dOFh
         GTc9cSeBGqMN9SIniJo+osE38w70ewLMRBa+IF6W5Irty/+clVgt0vYGZl5RYkHohZ+1
         wnvA==
X-Gm-Message-State: APjAAAX0nUcMOX6Sh13REFmlkVdH4aE0AscCsOJ3NkV2+w1coz+HrQY2
        dpzs7X7XBBICHH795r3wgpjnnfeWF2Z4Fg==
X-Google-Smtp-Source: APXvYqy04hp5m9cKno8K/vv3fgrdWOtDHir2eLPxDET0nbm+SdeMR6mKE9MrdlkuX80bChymvsnBNg==
X-Received: by 2002:ad4:4104:: with SMTP id i4mr22356955qvp.94.1568217725533;
        Wed, 11 Sep 2019 09:02:05 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i23sm9189679qkl.107.2019.09.11.09.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:02:04 -0700 (PDT)
Date:   Wed, 11 Sep 2019 12:02:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs child tree block verification
 system
Message-ID: <20190911160202.wtprsigurzfxwtic@MacBook-Pro-91.local>
References: <20190911074624.27322-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911074624.27322-1-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 03:46:24PM +0800, Qu Wenruo wrote:
> Although we have btrfs_verify_level_key() function to check the first
> key and level at tree block read time, it has its limitation due to tree
> lock context, it's not reliable handling new tree blocks.
> 

How is it not reliable with new tree blocks?

> So btrfs_verify_level_key() is good as a pre-check, but it can't ensure
> new tree blocks are still sane at runtime.
> 

I mean I guess this is good, but we have to keep the parent locked when we're
adding new blocks anyway, so I'm not entirely sure what this gains us?  You are
essentially duplicating the checks that we already do on reads, and then adding
the first_key check.

I'll go along with the first_key check being relatively useful, but why exactly
do we need all this infrastructure when we can just check it as we walk down the
tree?

<snip>

> @@ -2887,24 +2982,28 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  			}
>  
>  			if (!p->skip_locking) {
> -				level = btrfs_header_level(b);
> -				if (level <= write_lock_level) {
> +				if (level - 1 <= write_lock_level) {
>  					err = btrfs_try_tree_write_lock(b);
>  					if (!err) {
>  						btrfs_set_path_blocking(p);
>  						btrfs_tree_lock(b);
>  					}
> -					p->locks[level] = BTRFS_WRITE_LOCK;
> +					p->locks[level - 1] = BTRFS_WRITE_LOCK;
>  				} else {
>  					err = btrfs_tree_read_lock_atomic(b);
>  					if (!err) {
>  						btrfs_set_path_blocking(p);
>  						btrfs_tree_read_lock(b);
>  					}
> -					p->locks[level] = BTRFS_READ_LOCK;
> +					p->locks[level - 1] = BTRFS_READ_LOCK;
>  				}
> -				p->nodes[level] = b;
> +				p->nodes[level - 1] = b;
>  			}

This makes no sense to me.  Why do we need to change how we do level here just
for the btrfs_verify_child() check?  We've already init'ed verify further up,
and we're not changing b here, so messing with level here just makes the code
less clear.  Thanks,

Josef
