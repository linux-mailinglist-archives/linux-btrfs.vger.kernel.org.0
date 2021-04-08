Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA18C357A84
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhDHCow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 22:44:52 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:46990 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHCow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 22:44:52 -0400
Received: by mail-il1-f177.google.com with SMTP id p8so484230ilm.13
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 19:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0T4dBN2lN/0Rhs+dOSIlH4GWAZhaTXTwUSmFElYep2A=;
        b=J+4x5tpgU+nrF+Ry0xoQCVC2DblfVG4Ad3IQP/3o3n0TbkzDu/IuY0JKDh7tIBeZhF
         WcTwqGWmpyJCm52xpZZ8ZuaTI65dZTJniolPrj558s1MEGVYMMmAWqInjt/89CcixS3f
         IXbtv4TAtxNjsbcy2cp1UGPTvl3WsFnxUQdVROJp134cYcbYFVAwsqy9JiVA+SCqYJGg
         MmM+M28qy1dhqZdW4vSaYUSyXyL7MDrX/zbH6TgZlmrNOFQ2lCH129hoZ5xpRC50nwmK
         e1rSRSQMEf1DhTeJAy0vx7jacYLY4Hpdf6VeEBBTESKMGe2NhBhtOHcX8u1FvieZ88+2
         Z5wA==
X-Gm-Message-State: AOAM531+6Yw0bA0e3eAbDmxuGE/vIm60uhb64Pcm50UMZvxLvfVL5NM/
        8dRIIO9yOyVYS9l+yrVOINTRwF4stgk=
X-Google-Smtp-Source: ABdhPJwmNE2xv+ybo/jNgpNkjLWw2sSKyUmpjhhjPA94pKn0pZKOreypC6NgiceNc3prItZ3+kFWIg==
X-Received: by 2002:a92:d1cb:: with SMTP id u11mr5122276ilg.184.1617849880308;
        Wed, 07 Apr 2021 19:44:40 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id d1sm15178920ile.16.2021.04.07.19.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 19:44:39 -0700 (PDT)
Date:   Thu, 8 Apr 2021 02:44:38 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: Re: unexpected -ENOMEM from percpu_counter_init()
Message-ID: <YG5uFrWpwDHMhdR1@google.com>
References: <20210407210905.F790.409509F4@e16-tech.com>
 <YG3IJnAjgikZ0PkC@google.com>
 <20210408072800.6C1F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408072800.6C1F.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 07:28:01AM +0800, Wang Yugui wrote:
> Hi,
> 
> > > > > upper caller:
> > > > >     nofs_flag = memalloc_nofs_save();
> > > > >     ret = btrfs_drew_lock_init(&root->snapshot_lock);
> > > > >     memalloc_nofs_restore(nofs_flag);
> > 
> > The issue is here. nofs is set which means percpu attempts an atomic
> > allocation. If it cannot find anything already allocated it isn't happy.
> > This was done before memalloc_nofs_{save/restore}() were pervasive.
> > 
> > Percpu should probably try to allocate some pages if possible even if
> > nofs is set.
> 
> Thanks.
> 
> I will wait for the patch, and then test it.
> 

I'm currently a bit busy with some other things. Adding support I don't
think will be much work, just a little bit tricky.

I recommend carrying what you have minus the change to reserved percpu
memory for now. If I'm the one to write it, I'll cc you.

Thanks,
Dennis
