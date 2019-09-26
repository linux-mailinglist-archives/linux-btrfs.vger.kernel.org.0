Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A5BF935
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfIZSdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 14:33:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33356 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSdn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 14:33:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so4151950qtd.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw2YUjU2wyGFm12ix3imaT/vhDKor/qR243JvrEnR8I=;
        b=mDIIqHc2uODVCX+gVDHtI3ioGiFH8XaR5UBsMBKtjSwgBspcjpl773hjgg6GPmxaip
         NC+1kCikkkBho5Ny20DnP/O5VUb3jt1v2KK1KjhCLg6yxBjMh8IRgGurcDPpvsvsABVS
         lkvRO1CcxsCctt3tOv9myz6V8IEa7nyUi+CII9vvQOZ7QrXgm3FU8T+d8xevlOj95T/G
         IKmLkiwLf3VTWwNIjDUtpzKg5KN/nbZufaImwy1pcPvzWC6D4WRiZV8NFf7ZpAGxGqWz
         B7hlirmFS26yJ186o87eJjxqpE2Scj95+M1wizXIo9TQAiiT9Xpid+na78RFOVeBWGLG
         eKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw2YUjU2wyGFm12ix3imaT/vhDKor/qR243JvrEnR8I=;
        b=adRcvtSAe18/hZ2fh5sAucf+EWM+RNfbYH6z3C/Tu8Vt/6WJatEcgYqnqUKnDJzQSS
         +Jq1eybgt678UXa3Twe4cipdFAI+ffhK2jwLTzX3+cpOY997H4Ao8a9qXfYsRE4YP8hJ
         FEcuVmy0RhhIq0Lq3EcNjvdi/pLXWwDpuuiH5dso8yGuVZT09QIoNDqrp1VOBjdHQuh0
         PL9qJfoWIzAdsXDkAU9lgfndHX9rrssksblrOgnvLPRxU9i/728PV+tuhPpAJ7vUSOE8
         0WiBNDwUuKI36SxdJCefC/NyAQ/oOY3QYRrmobLpiSNnye1uukphL43LJCKDRg3O1NOq
         //+Q==
X-Gm-Message-State: APjAAAUqVQiLwkOv5DHwedvjUVKoliqmWBvyRYKH5/7YdQilfuwA5jt3
        3R2E1D4APKSy7asVRb1nvEL5IQ==
X-Google-Smtp-Source: APXvYqwvTZ27nm9FvGwl+K8SeFgM8TWPzyh2bjwPk8cbAAAOGPqhX1tR3teMaAbfXdDqBRqwD2N/zg==
X-Received: by 2002:ac8:550a:: with SMTP id j10mr5678629qtq.230.1569522821370;
        Thu, 26 Sep 2019 11:33:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c9a9])
        by smtp.gmail.com with ESMTPSA id 131sm31896qkg.1.2019.09.26.11.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:33:40 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:33:39 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in
 merge_reloc_roots()
Message-ID: <20190926183338.uwylopkth7pal5zd@macbook-pro-91.dhcp.thefacebook.com>
References: <20190926063545.20403-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926063545.20403-1-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:35:45PM +0800, Qu Wenruo wrote:
> [BUG]
> There is one BUG_ON() report where a transaction is aborted during
> balance, then kernel BUG_ON() in merge_reloc_roots():
> 
>   void merge_reloc_roots(struct reloc_control *rc)
>   {
> 	...
> 	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)); <<<
>   }
> 
> [CAUSE]
> It's still uncertain why we can get to such situation.
> As all __add_reloc_root() calls will also link that reloc root to
> rc->reloc_roots, and in merge_reloc_roots() we cleanup rc->reloc_roots.
> 
> So the root cause is still uncertain.
> 
> [FIX]
> But we can still hunt down all the BUG_ON() in merge_reloc_roots().
> 
> There are 3 BUG_ON()s in it:
> - BUG_ON() for read_fs_root() result
> - BUG_ON() for root->reloc_root != reloc_root case
> - BUG_ON() for the non-empty reloc_root_tree
> 
> For the first two, just grab the return value and goto out tag for
> cleanup.
> 
> For the last one, make it more graceful by:
> - grab the lock before doing read/write
> - warn instead of panic
> - cleanup the nodes in rc->reloc_root_tree
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

If we're going to do these things we might as well add the ability to error
inject and add an xfstest to verify they don't break anything.  The
BUG_ON(root->reloc_root != reloc_root) isn't able to be tested, but you can at
least make read_fs_root() and merge_reloc_root() and then test this patch by
triggering errors in these paths.

If you do that I'm ok with not being able to explain the leaking nodes, getting
rid of the BUG_ON()'s is good enough reason.  Thanks,

Josef
