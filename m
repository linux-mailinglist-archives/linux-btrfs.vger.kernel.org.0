Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CADA498D1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbiAXT17 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 14:27:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57404 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiAXTZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 14:25:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E1C52190B;
        Mon, 24 Jan 2022 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643052353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91UgOFkBJpd4JSRQfxG76rgq8lfiIgjrMGoPimE9940=;
        b=sDpQnYdgVAw+m/rijFMWSdPMTkau40niPVPBVxeg9SIruk3DEdvKzo4XdavC3z6yY4dp3/
        taksCK6Z3+MOvb3pFrU1TM7JYHygFpQsvS5vbW4vLTO80G9tx6mg1JN1zpIuqwIft1+ICa
        c+UNd6qK4DQpO3lxwPTGWYjAH/Iy+bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643052353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91UgOFkBJpd4JSRQfxG76rgq8lfiIgjrMGoPimE9940=;
        b=DUrKXYZ/kmdNf5sHez0ahwnkSyq7b9+tq9XdhUdxozAKIXZw14vlrc0rs8hrFwpwmU7gyD
        mcBoMmTfEGOuSVAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23E15A3B87;
        Mon, 24 Jan 2022 19:25:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C737EDA7A3; Mon, 24 Jan 2022 20:25:12 +0100 (CET)
Date:   Mon, 24 Jan 2022 20:25:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free after failure to create a
 snapshot
Message-ID: <20220124192512.GC14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <3ebda64ca2a8b55f924fbf2b9e850ff99e65938b.1642779802.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebda64ca2a8b55f924fbf2b9e850ff99e65938b.1642779802.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 03:44:39PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At ioctl.c:create_snapshot(), we allocate a pending snapshot structure and
> then attach it to the transaction's list of pending snapshots. After that
> we call btrfs_commit_transaction(), and if that returns an error we jump
> to 'fail' label, where we kfree() the pending snapshot structure. This can
> result in a later use-after-free of the pending snapshot:
> 
> 1) We allocated the pending snapshot and added it to the transaction's
>    list of pending snapshots;
> 
> 2) We call btrfs_commit_transaction(), and it fails either at the first
>    call to btrfs_run_delayed_refs() or btrfs_start_dirty_block_groups().
>    In both cases, we don't abort the transaction and we release our
>    transaction handle. We jump to the 'fail' label and free the pending
>    snapshot structure. We return with the pending snapshot still in the
>    transaction's list;
> 
> 3) Another task commits the transaction. This time there's no error at
>    all, and then during the transaction commit it accesses a pointer
>    to the pending snapshot structure that the snapshot creation task
>    has already freed, resulting in a user-after-free.
> 
> This issue could actually be detected by smatch, which produced the
> following warning:
> 
>   fs/btrfs/ioctl.c:843 create_snapshot() warn: '&pending_snapshot->list' not removed from list
> 
> So fix this by not having the snapshot creation ioctl directly add the
> pending snapshot to the transaction's list. Instead add the pending
> snapshot to the transaction handle, and then at btrfs_commit_transaction()
> we add the snapshot to the list only when we can guarantee that any error
> returned after that point will result in a transaction abort, in which
> case the ioctl code can safely free the pending snapshot and no one can
> access it anymore.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
