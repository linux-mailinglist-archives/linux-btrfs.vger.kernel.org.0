Return-Path: <linux-btrfs+bounces-11957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA41A4B1A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 13:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3350C3B0604
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C691E3DC8;
	Sun,  2 Mar 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENxjrcGG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4731DBB38
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Mar 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740919964; cv=none; b=U4QkDQxe5QSelHdK7ntAjpvImAj0vfbKLftmOVS7uqvv7zmX/aA9jqkWXBuTenWb3vOwoHF2cqZBMXt6XOsr8vwhsTR9xImci3/VzdxHi6m/9S2F1w8f0ZBeMrc/ydOln/ohKCHp50VSujy1B9034IgI+a7HvN1ojdUqxrd/Ku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740919964; c=relaxed/simple;
	bh=RjfYsCZT/AjwuuaaU/ShjyImT/Bcghmmvf8ITgZ3S9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYtJkas5yoR26gxqVi1Q8wx3UWk0UScCMPb+Dt3Aov7UvAj5bHQp1rBiwMWRVJigARJhg+9iUfbRl9gMFvp1rIgCcOHa0wYfqjKbMuT3YYg59qkpXUyMc77YxzqNWYGNPrTXN1LcrommcVAt/y4AmDmsTOQM38V6/5nKJ2Qxo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENxjrcGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C57C4CEE6
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Mar 2025 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740919963;
	bh=RjfYsCZT/AjwuuaaU/ShjyImT/Bcghmmvf8ITgZ3S9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ENxjrcGGXrVAiv/eI361KQTfVhFOtODfN8RxATZ7Mg6yXPRY4CKCXdRZWHSS/cKdN
	 9zmOt1Cyy7jwwmI8tppDAqOBTjNB3BW4C9duGVm8PB1nEhyC9Pt/TGAxTTlX5uA75L
	 DKlvaeM/D/S308cRKvgLUR3eq4JYrEMyyLhMKCtmgcRUI2zek2ZV+AQ/Brf7QteJg3
	 I38u73MeG/osRRh74tqxg4n1XbHhB+wvyFltbzUb/wYwP0h0Mib5w3+rgAFjG+IhgR
	 I4ZWyF07OQYdS5nz1l5ZKadOgYhiqiu2xksOG9/jvU+AnlTxmWj+749v9PSq63V8xx
	 /D38Ge6y7immg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf48293ad0so233878366b.0
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Mar 2025 04:52:43 -0800 (PST)
X-Gm-Message-State: AOJu0YwOLpfew1n9J7Nlz0Ut16gpa59M3WDsyEYMHg3EXagnifXmaHfQ
	3Oa5yCEIjQNQ+31Zz6ye9rP6/iCRRqHcsSqUDow5tMErvFGJsjDCWT4m5vXgAzxigMBz4mY4TEF
	ExC8rFPfHetaB5Hdg28D4W3LIyZU=
X-Google-Smtp-Source: AGHT+IF1TzvMaks+3TU8GjAij1dd0rrUzhiAlGUxoLGWdz9TtGLcNzkjQWX6XuwR8/KFzOXqFEaOoZb9RIahpdchRBo=
X-Received: by 2002:a17:907:7f91:b0:ab7:f2da:8122 with SMTP id
 a640c23a62f3a-abf25d945dbmr1299379166b.3.1740919962342; Sun, 02 Mar 2025
 04:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMNwjEKH6znTHE5hMc5er2dFs5ypw4Szx6TMDMb0H76yFq5DGQ@mail.gmail.com>
In-Reply-To: <CAMNwjEKH6znTHE5hMc5er2dFs5ypw4Szx6TMDMb0H76yFq5DGQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 2 Mar 2025 12:52:05 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6A-Ud2hPwjosCjapuye+eDuUjv-bneE73_GO9eDBJvkg@mail.gmail.com>
X-Gm-Features: AQ5f1JqidHBQimAkn7fCYYcbND-yCact4IG3ki3gYeN8-C7o-MWSV9QImPkaU58
Message-ID: <CAL3q7H6A-Ud2hPwjosCjapuye+eDuUjv-bneE73_GO9eDBJvkg@mail.gmail.com>
Subject: Re: btrfs 5.10.234 hangs at shutdown while unmounting
To: pk <pkoroau@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 2:35=E2=80=AFPM pk <pkoroau@gmail.com> wrote:
>
> Hi,
>
> Since the latest Debian 11 kernel update from 5.10.226 to 5.10.234, the
> shutdown hangs while unmounting any of the attached btrfs filesystems, ev=
en if
> the file systems have not ben modified. task:umount and sd-sync have stat=
e D.
>
> Should I report on Bugzilla or here? I see there have been some recent
> locking-related backports in the btrfs code for 5.10.

Reporting here is fine, and it's actually better because we don't look
as much to bugzilla as we do look at the mailing list.

Yes, it's a bad backport that causes the deadlock, likely automated by
the stable scripts.

I've just sent a fix for it, see:

https://lore.kernel.org/linux-btrfs/10637efdde5420993dd0611e3d3d5d8de6937e3=
b.1740919455.git.fdmanana@suse.com/

If you test it, please confirm it fixes things for you.

Thanks.

>
> Call trace for task:umount
>
>     __schedule
>     schedule
>     rwsem_down_read_slowpath
>     __btrfs_tree_read_lock
>     __btrfs_read_lock_root_node
>     btrfs_search_slot
>     btrfs_lookup_file_extent
>     btrfs_get_extent
>     btrfs_do_readpage
>     extend_readahead
>     read_pages
>     page_cache_ra_unbounded
>     ? __load_free_space_cache
>     __load_free_space_cache
>     load_free_space_cache
>     btrfs_cache_block_group
>     ? add_wait_queue_exclusive
>     find_free_extent
>     btrfs_reserve_extent
>     btrfs_alloc_tree_block
>     alloc_tree_block_no_bg_flush
>     btrfs_force_cow_block
>     btrfs_cow_block
>     commit_cowonly_roots
>     ? btrfs_qgroup_account_extents
>     btrfs_commit_transaction
>     close_ctree
>     generic_shutdown_super
>     kill_anon_super
>     btrfs_kill_super
>     deactivate_locked_super
>     cleanup_mnt
>     task_work_run
>     exit_to_user_mode_prepare
>     syscall_exit_to_user_mode
>     entry_SYSCALL_64_after_hwframe
>
>
> Call trace for sd-sync
>
>     __schedule
>     schedule
>     rwsem_down_read_slowpath
>     ? __ia32_sys_tee
>     iterate_supers
>     ksys_sync
>     __do_sys_sync
>     do_syscall_64
>     entry_SYSCALL_64_after_hwframe
>

