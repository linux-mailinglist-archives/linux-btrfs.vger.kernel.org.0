Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA00D4104
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfJKNXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 09:23:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43318 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfJKNXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 09:23:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id t20so8468274qtr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKdLM4gvb6sf8LqgaVTNQkV/XRHRju7FEgEYbdyFdAI=;
        b=wXravQ3zdVe9+xTrmlp22RApFrIp0rQo44YvD4laLqHj5jTR87o3UsKxYZRpnJq22v
         MlXntdqh4aWffz4FhItcEZ7r6IuG6YYNcpEtUcEWwQeyR9KD0DwZXrDliuo+a+rW/0nt
         zbawbzq9H5OrfvEDA3WEwRauE0IKzP9bIM2ZlomA3fHrv+xZrY5ux40ZXHB7ASS+v9dY
         YTqmf78WbJbiwXzq1PIm9vl9+/O7YzT3B2XWigIpRDLT7r9OpnL/4LDZbLswfBKz0WjR
         pVsiC92ovkQIT8qHWHJ0yAoF4LNrn5nk1ntEvqthahjbeMKeKX0xfGDGLMQXTnOi0nCy
         p1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKdLM4gvb6sf8LqgaVTNQkV/XRHRju7FEgEYbdyFdAI=;
        b=nyFGF6lUQEasY66ZPKtB6XRpx+pz9dEZApB5hOWRRiiNzbZl8WLcIHXEVgNOL+GNWW
         /xNsky3gIwXxTRuMVD6cOlFREmslnAnOiKqYIdzic8TTU2hd71wwtOa9afzdLwRtuu5S
         1MmjqsUtBzg/wpIKzgDxlGy+GxgDP0TjeEu2o9kDYji5SP7WTUOtwzsShzEHqyGli5pB
         4deJdCkq7NqrEPCc6HBlaV1rvnmI/832K8vcMpSYMQEMg1fodRODFNVcU+GLp4zc+bcx
         m19VecHb/v8G2/0Fx2NohcJ0Bzd1ejo1msoAX2hcYPvEo3BuqnqAhVlH41m3u0mz0lcN
         MCQA==
X-Gm-Message-State: APjAAAVPf2rcxtkz0AvxOJ4KpRMlDbla1uzzXoLqb390GuHassEjExj2
        QI8ZV+1Cvos0L3eS7vH8cUlp1Ea3q+7WKQ==
X-Google-Smtp-Source: APXvYqxSdZpRkHWt1AD4+4ZwNnxf/eERpYKbbIxv+JywZN3LpRtK/QIY/23Y6h4urpHZ21BuKjNkVw==
X-Received: by 2002:ac8:2a83:: with SMTP id b3mr16893970qta.244.1570800218730;
        Fri, 11 Oct 2019 06:23:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 54sm5500579qts.75.2019.10.11.06.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 06:23:38 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:23:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: Introduce new incompat feature, BG_TREE,
 to speed up mount time
Message-ID: <20191011132335.mo2zsapmmjhftezh@MacBook-Pro-91.local>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010023928.24586-4-wqu@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 10:39:28AM +0800, Qu Wenruo wrote:
> The overall idea of the new BG_TREE is pretty simple:
> Put BLOCK_GROUP_ITEMS into a separate tree.
> 
> This brings one obvious enhancement:
> - Reduce mount time of large fs
> 
> Although it could be possible to accept BLOCK_GROUP_ITEMS in either
> trees (extent root or bg root), I'll leave that kernel convert as
> alternatives to offline convert, as next step if there are a lot of
> interests in that.
> 
> So for now, if an existing fs want to take advantage of BG_TREE feature,
> btrfs-progs will provide offline convertion tool.
> 
> [[Benchmark]]
> Physical device:	NVMe SSD
> VM device:		VirtIO block device, backup by sparse file
> Nodesize:		4K  (to bump up tree height)
> Extent data size:	4M
> Fs size used:		1T
> 
> All file extents on disk is in 4M size, preallocated to reduce space usage
> (as the VM uses loopback block device backed by sparse file)
> 
> Without patchset:
> Use ftrace function graph:
> 
>  7)               |  open_ctree [btrfs]() {
>  7)               |    btrfs_read_block_groups [btrfs]() {
>  7) @ 805851.8 us |    }
>  7) @ 911890.2 us |  }
> 
>  btrfs_read_block_groups() takes 88% of the total mount time,
> 
> With patchset, and use -O bg-tree mkfs option:
> 
>  6)               |  open_ctree [btrfs]() {
>  6)               |    btrfs_read_block_groups [btrfs]() {
>  6) * 91204.69 us |    }
>  6) @ 192039.5 us |  }
> 
>   open_ctree() time is only 21% of original mount time.
>   And btrfs_read_block_groups() only takes 47% of total open_ctree()
>   execution time.
> 
> The reason is pretty obvious when considering how many tree blocks needs
> to be read from disk:
> - Original extent tree:
>   nodes:	55
>   leaves:	1025
>   total:	1080
> - Block group tree:
>   nodes:	1
>   leaves:	13
>   total:	14
> 
> Not to mention all the tree blocks readahead works pretty fine for bg
> tree, as we will read every item.
> While readahead for extent tree will just be a diaster, as all block
> groups are scatter across the whole extent tree.
> 
> The reduction of mount time is already obvious even on super fast NVMe
> disk with memory cache.
> It would be even more obvious if the fs is on spinning rust.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

You need to add

fs_info->bg_root->block_rsv = &fs_info->delayed_refs_rsv;

to btrfs_init_global_block_rsv, otherwise bad things will happen.  Thanks,

Josef
