Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BE4323BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhJRQYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 12:24:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJRQYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 12:24:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D19F21FD6D;
        Mon, 18 Oct 2021 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634574148;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AFiZaMMS7KXt7g2IVQobFgsRKpXhAA77R+4qWALsdu8=;
        b=SJarSHI0iK7M9j96c+g402HJsGjA7aDQQs8XW1hiQIJtzhH/73qQv6h5VIqMPT9x4QzB+A
        LmEyOvD7LCMoZEcpV4v/V5nok2sHNxYJS3UOqrwhYVuaBGDwbZtfozk6ZCt/UK/iZIYr8C
        btOUqJJHmkCURwc3eH7zKmmGQt+wBnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634574148;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AFiZaMMS7KXt7g2IVQobFgsRKpXhAA77R+4qWALsdu8=;
        b=K5+4Pe9ZC8BpXzmIKDDUXSGZDAnw6WFDlkK/+FeayrMdAysIqB2SKp5hyK/xk3n5YjC/AU
        9FjzbTMscAIGXJAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CADAFA3B89;
        Mon, 18 Oct 2021 16:22:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58C58DA7A3; Mon, 18 Oct 2021 18:22:01 +0200 (CEST)
Date:   Mon, 18 Oct 2021 18:22:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
Message-ID: <20211018162201.GO30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1634115580.git.fdmanana@suse.com>
 <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
 <f281ca42-cd64-7978-b4c0-17756dd7689c@suse.com>
 <CAL3q7H62eWcTZWCkN8ZMDEOjgjJBXYgESSdhcdWHxzfVzUBUqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H62eWcTZWCkN8ZMDEOjgjJBXYgESSdhcdWHxzfVzUBUqA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 03:21:47PM +0100, Filipe Manana wrote:
> > > @@ -3724,19 +3718,13 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> > >       left = info->total_bytes - btrfs_space_info_used(info, true);
> > >       spin_unlock(&info->lock);
> > >
> > > -     num_devs = get_profile_num_devs(fs_info, type);
> > > -
> > > -     /* num_devs device items to update and 1 chunk item to add or remove */
> > > -     thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
> > > -             btrfs_calc_insert_metadata_size(fs_info, 1);
> > > -
> > > -     if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> > > +     if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> > >               btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
> > > -                        left, thresh, type);
> > > +                        left, bytes, type);
> > >               btrfs_dump_space_info(fs_info, info, 0, 0);
> > >       }
> >
> > This can be simplified to if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> > and nested inside the next if (left < bytes). I checked
> > and even with the extra nesting the code doesn't break the 76 char limit.
> 
> This is a bug fix only, I'm not reformatting code blocks I'm not
> really changing.

I tend to agree to keep the fix minimal and do unrelated cleanups if it
happens in the scope of the fix. Backporing such patches is easier but I
understand the comment that sometimes it's worth to do the collateral
cleanups. No hard rules here.

> > > +/*
> > > + * Reserve space in the system space for allocating or removing a chunk.
> > > + * The caller must be holding fs_info->chunk_mutex.
> >
> > Better to use lockdep_assert_held.
> 
> reserve_chunk_space() does that, that's why I didn't add it here again.

I'm not sure what's the overhead of lockdep_assert_held but it could be
potentially a perf hit, where we would care even for a debugging build.
If the call chain is not spread over many functions/files I'd say it's
ok to do lockdep_assert only on the entry function and not each in the
call sub tree.
