Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E967F1C0A59
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD3WXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 18:23:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36973 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgD3WXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 18:23:54 -0400
Received: by mail-ua1-f67.google.com with SMTP id s5so3157081uad.4;
        Thu, 30 Apr 2020 15:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6zNCoweAOaTHQK115+b2oJjIZJeyrUxI9RbZEeQ0t38=;
        b=Nl9jKJPnqu8bxXGmd/fg7ItjhviUtVDYhlZBOiuEsSXpNlJt2U8bAA92Yl4YMmlAmA
         XBJ28GcRSlFyciFclmxePOarfkKzEkSazAS7xnT5XFfEoUmmplbQzMctSQifexwu2X2w
         aaJCB2k0OQR4q9vkkmFOth8xvsCRQYRsS4hq14QGWz6Tl1iLxqIm3Cy1GKcHOGY7hBmK
         EsoaWZurlFMxSq6Qf/lPDrowpWBQteAyGM0VUepZYMz0qgh+gG66NpNuHLmGKUGDF2Vv
         P/hetxAhY+qHtmkpARj9XHGFVo/xmhNjDqhYFbrmgkB+/ybrePLccwlS0okN4WBN/Qdb
         lk0A==
X-Gm-Message-State: AGi0Pubpx49YT+bOOF0hzTwdfChPUaq1O/tj9dy1TwakKp9IlnDGHatE
        ctQwURLKgfsNuOB1g1jOXVfFOmuY
X-Google-Smtp-Source: APiQypLNvQTFk79922E/NOe1BWAd7Mvdk4sJ5qDzLZOce97xmW+K33M2X6OjUhReBqgbsNp/EM146w==
X-Received: by 2002:ab0:2095:: with SMTP id r21mr860426uak.92.1588285432586;
        Thu, 30 Apr 2020 15:23:52 -0700 (PDT)
Received: from google.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id s74sm308968vkb.48.2020.04.30.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:23:48 -0700 (PDT)
Date:   Thu, 30 Apr 2020 22:23:47 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     fdmanana@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] percpu: make pcpu_alloc() aware of current gfp context
Message-ID: <20200430222347.GA164259@google.com>
References: <20200430164356.15543-1-fdmanana@kernel.org>
 <20200430144018.c855f031b321d68e5c89b30c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430144018.c855f031b321d68e5c89b30c@linux-foundation.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 02:40:18PM -0700, Andrew Morton wrote:
> On Thu, 30 Apr 2020 17:43:56 +0100 fdmanana@kernel.org wrote:
> 
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Since 5.7-rc1, on btrfs we have a percpu counter initialization for which
> > we always pass a GFP_KERNEL gfp_t argument (this happens since commit
> > 2992df73268f78 ("btrfs: Implement DREW lock")).  That is safe in some
> > contextes but not on others where allowing fs reclaim could lead to a
> > deadlock because we are either holding some btrfs lock needed for a
> > transaction commit or holding a btrfs transaction handle open.  Because
> > of that we surround the call to the function that initializes the percpu
> > counter with a NOFS context using memalloc_nofs_save() (this is done at
> > btrfs_init_fs_root()).
> > 
> > However it turns out that this is not enough to prevent a possible
> > deadlock because percpu_alloc() determines if it is in an atomic context
> > by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
> > case) and it is not aware that a NOFS context is set.  Because it thinks
> > it is in a non atomic context it locks the pcpu_alloc_mutex, which can
> > result in a btrfs deadlock when pcpu_balance_workfn() is running, has
> > acquired that mutex and is waiting for reclaim, while the btrfs task that
> > called percpu_counter_init() (and therefore percpu_alloc()) is holding
> > either the btrfs commit_root semaphore or a transaction handle (done at
> > fs/btrfs/backref.c:iterate_extent_inodes()), which prevents reclaim from
> > finishing as an attempt to commit the current btrfs transaction will
> > deadlock.
> > 
> 
> Patch looks good and seems sensible, thanks.
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

> But why did btrfs use memalloc_nofs_save()/restore() rather than
> s/GFP_KERNEL/GFP_NOFS/?

I would also like to know.

Thanks,
Dennis
