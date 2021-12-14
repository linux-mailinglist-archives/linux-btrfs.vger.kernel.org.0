Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83E47432E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhLNNIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 08:08:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhLNNIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 08:08:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C77E21124;
        Tue, 14 Dec 2021 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639487285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeZ4+UhJBuKxSKb4JG5+Os/lAmUclo9+8WQHzyGj7uU=;
        b=vgEI63D5u+ZYGW8zq6s/geb334NYI9ASxJzhW2CDp+pzGAc8xM3dZp9P+o2/UUR42hYdeB
        oXeM6b3WtJNV6tk7q2BajmQwiQ5+Y8AzgQ6qO98PQhtudP8qmxUNjcpXBoCCwzLsLzsIEg
        uk51sdkcvq6FZ8cfy/cevGvtW0wjKvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639487285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeZ4+UhJBuKxSKb4JG5+Os/lAmUclo9+8WQHzyGj7uU=;
        b=AhG0y3rzKJhB3ySbr68wQHSDxvc456+17LuZgeB3EHYmPqybUcWZubEVMb4csYw4XmL9+l
        HaT3swVajIfhToAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 436A3A3B83;
        Tue, 14 Dec 2021 13:08:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34DF9DA781; Tue, 14 Dec 2021 14:07:47 +0100 (CET)
Date:   Tue, 14 Dec 2021 14:07:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double free of anon_dev after failure to
 create subvolume
Message-ID: <20211214130746.GR28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <b6c30d9569d56552e38dc6bd305c6eb6578f3782.1639162814.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c30d9569d56552e38dc6bd305c6eb6578f3782.1639162814.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 10, 2021 at 07:02:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a subvolume, at create_subvol(), we allocate an anonymous
> device and later call btrfs_get_new_fs_root(), which in turn just calls
> btrfs_get_root_ref(). There we call btrfs_init_fs_root() which assigns
> the anonymous device to the root, but if after that call there's an error,
> when we jump to 'fail' label, we call btrfs_put_root(), which frees the
> anonymous device and then returns an error that is propagated back to
> create_subvol(). Than create_subvol() frees the anonymous device again.
> 
> When this happens, if the anonymous device was not reallocated after
> the first time it was freed with btrfs_put_root(), we get a kernel
> message like the following:
> 
>   (...)
>   [13950.282466] BTRFS: error (device dm-0) in create_subvol:663: errno=-5 IO failure
>   [13950.283027] ida_free called for id=65 which is not allocated.
>   [13950.285974] BTRFS info (device dm-0): forced readonly
>   (...)
> 
> If the anonymous device gets reallocated by another btrfs filesystem
> or any other kernel subsystem, then bad things can happen.
> 
> So fix this by setting the root's anonymous device to 0 at
> btrfs_get_root_ref(), before we call btrfs_put_root(), if an error
> happened.
> 
> Fixes: 2dfb1e43f57dd3 ("btrfs: preallocate anon block device at first phase of snapshot creation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
