Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFDC1C098D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 23:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD3VkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 17:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3VkU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 17:40:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872792064C;
        Thu, 30 Apr 2020 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588282819;
        bh=mJs5hluqduo9dtI8ms49qYStG1gIgUgTJaDMGc0TwsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bC8IorIvBOl0MDL52/kEKkObD8oM2TuQj0h4qMWCgw91RtBB3hNmYby7KsliyZY/M
         zZl0imt5lRxodssgDt7UYZkzSoJBk7pK5roliimn5FjgWANZtHDXpfsNqtHfYlO33c
         JCGyBuuntmyuEFjLJdo7KY8mjVnUhjBCyuK81QjY=
Date:   Thu, 30 Apr 2020 14:40:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     fdmanana@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] percpu: make pcpu_alloc() aware of current gfp context
Message-Id: <20200430144018.c855f031b321d68e5c89b30c@linux-foundation.org>
In-Reply-To: <20200430164356.15543-1-fdmanana@kernel.org>
References: <20200430164356.15543-1-fdmanana@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 30 Apr 2020 17:43:56 +0100 fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Since 5.7-rc1, on btrfs we have a percpu counter initialization for which
> we always pass a GFP_KERNEL gfp_t argument (this happens since commit
> 2992df73268f78 ("btrfs: Implement DREW lock")).  That is safe in some
> contextes but not on others where allowing fs reclaim could lead to a
> deadlock because we are either holding some btrfs lock needed for a
> transaction commit or holding a btrfs transaction handle open.  Because
> of that we surround the call to the function that initializes the percpu
> counter with a NOFS context using memalloc_nofs_save() (this is done at
> btrfs_init_fs_root()).
> 
> However it turns out that this is not enough to prevent a possible
> deadlock because percpu_alloc() determines if it is in an atomic context
> by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
> case) and it is not aware that a NOFS context is set.  Because it thinks
> it is in a non atomic context it locks the pcpu_alloc_mutex, which can
> result in a btrfs deadlock when pcpu_balance_workfn() is running, has
> acquired that mutex and is waiting for reclaim, while the btrfs task that
> called percpu_counter_init() (and therefore percpu_alloc()) is holding
> either the btrfs commit_root semaphore or a transaction handle (done at
> fs/btrfs/backref.c:iterate_extent_inodes()), which prevents reclaim from
> finishing as an attempt to commit the current btrfs transaction will
> deadlock.
> 

Patch looks good and seems sensible, thanks.

But why did btrfs use memalloc_nofs_save()/restore() rather than
s/GFP_KERNEL/GFP_NOFS/?
