Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FB39B771
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFDLD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 07:03:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48518 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhFDLD5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 07:03:57 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A86ED1FD4C;
        Fri,  4 Jun 2021 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622804530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ39B/3QMbCpOKXvacBxheoVdqRJ9bzTYIQXuv1uNTI=;
        b=0gOxidYaZlPUZItU9vXLD8N6ATt0Olb03aGuWxgmWTmm7+MdcfYeo3HwPbtLjIGkIBcNBq
        /12L9dSD8XoVW8a5ID+51LVkGBv7oEriSU+3/T6DYO8euoHXgjORVHpEGuCeJuzAe2TBj2
        MvOX9bU+zRPvPSw7F0kpEhWotu8zdT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622804530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ39B/3QMbCpOKXvacBxheoVdqRJ9bzTYIQXuv1uNTI=;
        b=5o2l6o0WfadfMoE9P53RcBKGopQ0tNjMKek9+y+9n/ck7hq5OQzSi12fzANnxL7miJGgQS
        v+FBBSEAhD6KbXCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A2D9FA3B85;
        Fri,  4 Jun 2021 11:02:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32FE4DB22A; Fri,  4 Jun 2021 12:59:29 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:59:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Slightly how START_SYNC and WAIT_SYNC work
Message-ID: <20210604105928.GZ31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1622733245.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622733245.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 03, 2021 at 05:20:19PM +0200, David Sterba wrote:
> The async transaction commit ioctl has a subtle semantics that used to
> work for ceph. We need more straightforward semantics in progs (eg. when
> waiting for commit after subvolume deletion) and otherwise the async
> commit does a few annoying things.
> 
> Long explanation is in patch 3. I hope it works, but somebody please
> double check. It's a minor change in the commit logic, but merely
> removing some waiting, no other changes in state transitions.
> 
> David Sterba (4):
>   btrfs: sink wait_for_unblock parameter to async commit
>   btrfs: inline wait_current_trans_commit_start in its caller
>   btrfs: replace async commit by pending actions
>   btrfs: remove fs_info::transaction_blocked_wait

btrfs/011 hangs so no dice. I maybe pick the two first patches as
cleanups, and the rest will go to some future dev cycle.
