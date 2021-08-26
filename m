Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97823F8D97
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhHZSJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 14:09:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhHZSJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 14:09:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 259FE22301;
        Thu, 26 Aug 2021 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630001306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPJo1teyamndI4lEKoVAD9Qt2Smv/ONWaaScuC4Ve2o=;
        b=LhXtiAYtUaGc/4EiE0bwz6J7z1GB19AVe2Ray/sCSjj7toPIPxourr3Kil0AY2dv1HwaWx
        R6mSpTDwxVLmGy35D2zLnpPYupeLRlmqzWnQO/2HDe5/9ez5t0jVbWWppe3hg2l1ESarXw
        QjBxgqMbRRHaiW3Bk6Wa/aK1SjOx9OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630001306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPJo1teyamndI4lEKoVAD9Qt2Smv/ONWaaScuC4Ve2o=;
        b=TdWpU8d8UCoKO5ykXztEfWhMrp1L+bo7dACzFD94pGg9Lgpnr5QBy0IgrmxgY7OjFf5W/q
        826u4LFP0nezBgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C47A13C9A;
        Thu, 26 Aug 2021 18:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hbu7MZjYJ2F5NwAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Thu, 26 Aug 2021 18:08:24 +0000
Message-ID: <1619bc963c3006b433b19d95a52b68c8fc584a63.camel@suse.de>
Subject: Re: [PATCHv2 0/8]  btrfs: Create macro to iterate slots
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Date:   Thu, 26 Aug 2021 15:06:45 -0300
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
References: <20210826164054.14993-1-mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2021-08-26 at 13:40 -0300, Marcos Paulo de Souza wrote:
> There is a common pattern when search for a key in btrfs:
> 
>  * Call btrfs_search_slot
>  * Endless loop
>      * If the found slot is bigger than the current items in the
> leaf, check the
>        next one
>      * If still not found in the next leaf, return 1
>      * Do something with the code
>      * Increment current slot, and continue
> 
> This pattern can be improved by creating an iterator macro, similar
> to
> those for_each_X already existing in the linux kernel. using this
> approach means to reduce significantly boilerplate code, along making
> it
> easier to newcomers to understand how to code works.
> 
> This patchset survived a complete fstest run.

My bad, I only added v2 to the cover-letter, but the only change from
v1 is that now the xattr changes are in a separate patch.

> 
> Changes from v1:
>  * Separate xattr changes from the macro introducing code (Johannes)
> 
> Changes from RFC:
>  * Add documentation to btrfs_for_each_slot macro and
> btrfs_valid_slot function
>    (David)
>  * Add documentation about the ret variable used as a macro argument
> (David)
>  * Match function argument from prototype and implementation (David)
>  * Changed ({ }) block to only () in btrfs_for_each_slot macro
> (David)
>  * Add more patches to show the code being reduced by using this
> approach
>    (Nikolay)
> 
> Marcos Paulo de Souza (8):
>   fs: btrfs: Introduce btrfs_for_each_slot
>   btrfs: block-group: use btrfs_for_each_slot in
> find_first_block_group
>   btrfs: dev-replace: Use btrfs_for_each_slot in
>     mark_block_group_to_copy
>   btrfs: dir-item: use btrfs_for_each_slot in
>     btrfs_search_dir_index_item
>   btrfs: inode: use btrfs_for_each_slot in btrfs_read_readdir
>   btrfs: send: Use btrfs_for_each_slot macro
>   btrfs: volumes: use btrfs_for_each_slot in btrfs_read_chunk_tree
>   btrfs: xattr: Use btrfs_for_each_slot macro in btrfs_listxattr
> 
>  fs/btrfs/block-group.c |  33 +-----
>  fs/btrfs/ctree.c       |  28 ++++++
>  fs/btrfs/ctree.h       |  25 +++++
>  fs/btrfs/dev-replace.c |  51 ++--------
>  fs/btrfs/dir-item.c    |  27 +----
>  fs/btrfs/inode.c       |  46 ++++-----
>  fs/btrfs/send.c        | 222 +++++++++++--------------------------
> ----
>  fs/btrfs/volumes.c     |  23 ++---
>  fs/btrfs/xattr.c       |  40 +++-----
>  9 files changed, 169 insertions(+), 326 deletions(-)
> 

