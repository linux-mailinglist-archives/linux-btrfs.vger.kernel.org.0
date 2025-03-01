Return-Path: <linux-btrfs+bounces-11954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C2A4AC41
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Mar 2025 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02554169F25
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Mar 2025 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E91E32D6;
	Sat,  1 Mar 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh+1wT1p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0091ADFFE
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Mar 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839357; cv=none; b=V7aJ+E2mzTpDYln4LnOAiNfDGEBMy6t5P4FFLQf6G7NsLxCIgpz0uaasHn3MfHrXVKgg2zEvR5SzwQnakvnbMlhrtaajFhjVjSzUygZGEX6AQGLF23JGvPC+qK1/DA4oalbja81J1FX9LJYja6k1UWmOps+P4zsuES6jY347teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839357; c=relaxed/simple;
	bh=/7+pX3/fbhLXHwFpgo6JPBCGykd1YFnHHDH7fi88ObU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZcAq3pqfdcxYNCKxl3y9nKqItEutLQ2laOEf3MIp4q5AIzUqAZek1Qbth6xC4PQ5nIfa0S9KPExxsQeECQZmzif1CvUp2kbV+v4V3gXMzrKkxWErLDMcnp/x2Cv73eCBtWyKCN1fIndwF6Sj00A2u32Er+QALwvPQhvJEYVcjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh+1wT1p; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e461015fbd4so2192130276.2
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Mar 2025 06:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839355; x=1741444155; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oY9fIXy5GkvGjfn4JPKcOxHA8yYmMlAcTK1bB0/O9Vk=;
        b=nh+1wT1pzC0XzTMekgklmiptpvrDp0PKbal9PEFdDZ1NXj7B7J/QNgDCiXXPmno903
         Kfvhr0pOaecX03Ae6UPfew3k9D2PjV8szgibg57nDpl731cZM7dvYcUfkYsHCVL/pTQ4
         A1MwDeY2hRA38M40727p4fCfxkhrpNj6H/HiQeCfkt6kKcHf4HXa3rSdBXLIRTjaTP9u
         ydfSoQOGTr4oepAUCb/EmRW12Ofg2nBz8xbaXbI3e1QNJHc+uAHgZWq9DQ9aXJctpKwE
         6WI7496Q+wQFh2zB9t+M+jx8K3esb4FlG5OJ9TFDZfSfA4g6AvoFQDnvZHZVKDgz0veq
         5n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839355; x=1741444155;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oY9fIXy5GkvGjfn4JPKcOxHA8yYmMlAcTK1bB0/O9Vk=;
        b=qzgjO8IvhT0qzXGwWcTKa46uA3Q7OSwO4E0RJzsksj9BdwK7O2Q5Tp9dOPZKVrUAIN
         sjCkLlbo40EhExneiXwbE0eKmVKlek3OQB4S15M+R3DRNzds+ei9c2eK/UtQ2a3MwBnZ
         NBFhcDRAwpAUtkxUAzoD2spzS4TKdomMOuvc8NBJr3NvUgs7EjlBAs/DDBO/Fjn20llk
         NKFJ9KGR2xClnm3XIWEkL+fnYkfbuCnIqZAvaVlWI+6xO8aXwAlrYHhGu2hVpRV5s1a1
         /MPMuwxql9bnWs8JGbN2SVkoSzTPqtPA6mRMlGWZkR3AIlJfiADMGbMcYPJM0BtherPb
         GL7g==
X-Gm-Message-State: AOJu0YwFIQc2JPgxOzyt6Hn2unKzHoy6bVFucLkLInCGJWo5DrBzh7z7
	xYKgzjD52ypda1AIaGz6ad920G2p9I2ixKRWcuQQFUvyUKUXFPFivEGgewIofqduDYWB/D4d1oJ
	nY5xikvwgT5XKMbqVzY8mbffMqiGWoqhf
X-Gm-Gg: ASbGnctxZdP3BTDb0IuIjqVDSSNVg4mWQ6lFRaKLuZ0eBCGQ80zXP+RTXiY8Te5Xhrc
	vBt5j3O1dN2/2QM7J9fh9VIW+lnd4HCjacmWttDRj0vA4mdDFQIIlGEzI9Xpp4MoFnAX84HFp9f
	mI3uLVmQj45G/gXklTdnxvG3yX
X-Google-Smtp-Source: AGHT+IGvvz3JhZowBj+3r0eITYK7qnKq/4zJsUX6WfkFEFSFHecno8XXQVsMWR6ggZZaZfEILyBn2UsHqj/nYm+2Y/Q=
X-Received: by 2002:a05:690c:45c6:b0:6ef:92e0:a989 with SMTP id
 00721157ae682-6fd4a0c29edmr84296387b3.23.1740839355131; Sat, 01 Mar 2025
 06:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: pk <pkoroau@gmail.com>
Date: Sat, 1 Mar 2025 15:29:03 +0100
X-Gm-Features: AQ5f1Jqbt6nX-Fa5Uwbk9MyaFrQHBGd0MvVkeOZn7EHqumTZylWTTniPPE7IRvg
Message-ID: <CAMNwjEKH6znTHE5hMc5er2dFs5ypw4Szx6TMDMb0H76yFq5DGQ@mail.gmail.com>
Subject: btrfs 5.10.234 hangs at shutdown while unmounting
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Since the latest Debian 11 kernel update from 5.10.226 to 5.10.234, the
shutdown hangs while unmounting any of the attached btrfs filesystems, even if
the file systems have not ben modified. task:umount and sd-sync have state D.

Should I report on Bugzilla or here? I see there have been some recent
locking-related backports in the btrfs code for 5.10.

Call trace for task:umount

    __schedule
    schedule
    rwsem_down_read_slowpath
    __btrfs_tree_read_lock
    __btrfs_read_lock_root_node
    btrfs_search_slot
    btrfs_lookup_file_extent
    btrfs_get_extent
    btrfs_do_readpage
    extend_readahead
    read_pages
    page_cache_ra_unbounded
    ? __load_free_space_cache
    __load_free_space_cache
    load_free_space_cache
    btrfs_cache_block_group
    ? add_wait_queue_exclusive
    find_free_extent
    btrfs_reserve_extent
    btrfs_alloc_tree_block
    alloc_tree_block_no_bg_flush
    btrfs_force_cow_block
    btrfs_cow_block
    commit_cowonly_roots
    ? btrfs_qgroup_account_extents
    btrfs_commit_transaction
    close_ctree
    generic_shutdown_super
    kill_anon_super
    btrfs_kill_super
    deactivate_locked_super
    cleanup_mnt
    task_work_run
    exit_to_user_mode_prepare
    syscall_exit_to_user_mode
    entry_SYSCALL_64_after_hwframe


Call trace for sd-sync

    __schedule
    schedule
    rwsem_down_read_slowpath
    ? __ia32_sys_tee
    iterate_supers
    ksys_sync
    __do_sys_sync
    do_syscall_64
    entry_SYSCALL_64_after_hwframe

