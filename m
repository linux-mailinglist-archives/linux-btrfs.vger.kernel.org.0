Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436A33FC67E
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhHaLV0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:21:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhHaLV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:21:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A580D2015E;
        Tue, 31 Aug 2021 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630408830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbju5Uwme8n6nE1Z2+MWXDxB3OFFN0N6fGxCnXaMfYQ=;
        b=xuiTyapUDeqLnIP1LSDgSlg8ix3uk5JoKSlD6Pso8bAIsoq5iU2z158bHb5XvKU83MfwoH
        c8XXbr/I58G2AIGxWvYsuIAe2GMsz2pFhc0Ik6C08GaQxJlWFIuRsvbjjMWoxueX7ZZfpb
        3RdNI3cBawR6zS0CD7PZAeeTgaSV+pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630408830;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rbju5Uwme8n6nE1Z2+MWXDxB3OFFN0N6fGxCnXaMfYQ=;
        b=eSnlhbE5TpvUYi1+i9pJvujTgCZyR82IIpGoJhtTQU3tUNkZCTw8Ffatmjoq8Nn5NCDEWI
        QaM1ZCTzzIzN3jAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9DBA5A3B91;
        Tue, 31 Aug 2021 11:20:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB7C3DA733; Tue, 31 Aug 2021 13:17:39 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:17:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCHv2 0/8]  btrfs: Create macro to iterate slots
Message-ID: <20210831111739.GI3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 01:40:46PM -0300, Marcos Paulo de Souza wrote:
> Marcos Paulo de Souza (8):
>   fs: btrfs: Introduce btrfs_for_each_slot
>   btrfs: block-group: use btrfs_for_each_slot in find_first_block_group
>   btrfs: dev-replace: Use btrfs_for_each_slot in
>     mark_block_group_to_copy
>   btrfs: dir-item: use btrfs_for_each_slot in
>     btrfs_search_dir_index_item
>   btrfs: inode: use btrfs_for_each_slot in btrfs_read_readdir
>   btrfs: send: Use btrfs_for_each_slot macro
>   btrfs: volumes: use btrfs_for_each_slot in btrfs_read_chunk_tree
>   btrfs: xattr: Use btrfs_for_each_slot macro in btrfs_listxattr

There are few comments regarding patch organization. Please:

- drop the file prefixes from the subject (like "inode:", "send:")

- change "fs: btrfs:" to just "btrfs:" in the first patch

- unify the subjects that switch to the iterator to be
  "btrfs: use btrfs_for_each_slot in FUNCTION"

- do one patch per function, even if there are several in one file
