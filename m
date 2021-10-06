Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC50423FFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhJFOY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 10:24:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbhJFOY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 10:24:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9788E20381;
        Wed,  6 Oct 2021 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633530155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDo4ML9Z43l0t4nDFSzbP3gd0AxefxKdA+l08igYvN0=;
        b=N23uBKNRvuJ8+5xP3Llja37xOUNZfRAs75bJL5STHu6XeoKBN79TnsHlBv1G7cl+9g76ly
        Jp5CHqm7CyFGi8clgMCMlVBp9YmCeSDkKzXCrDKRaQQa2gfBZpjMzGa4Ns6OX1GR7q4J37
        oFcu+3ChaHStDQtIH3nBzq9BB6xLufo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 675D913E4F;
        Wed,  6 Oct 2021 14:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DFjEFiuxXWG7fQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Oct 2021 14:22:35 +0000
Subject: Re: [PATCH v4 0/5] Miscellaneous error handling patches
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633465964.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3c335928-1eec-6a92-b657-a9ac5f4d2895@suse.com>
Date:   Wed, 6 Oct 2021 17:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.10.21 г. 23:35, Josef Bacik wrote:
> v3->v4:
> - Added another abort() call that I missed in btrfs_recover_log_trees.
> - Updated the commit message for 'btrfs: change error handling for
>   btrfs_delete_*_in_log' as it pre-dated me figuring out there was a corruption
>   problem in sync log.
> - Fixed commit message for 'btrfs: add a BTRFS_FS_ERROR helper'.
> - Made it so 'btrfs: do not infinite loop in data reclaim if we aborted'
>   actually compiled, I guess my compile after rebase git hook didn't quite work
>   as expected.
> - Updated the comment in 'btrfs: fix abort logic in btrfs_replace_file_extents'.
> - Rebased onto misc-next.
> 
> --- Original email ---
> Hello,
> 
> This series is left overs from a few different series.  The error handling
> patches look like they just got missed somehow.  The FS_ERROR helper has been
> updated based on the comments from Dave.  I'm attaching this to the open GH
> thing that I was looking at to update, but really just has the FS_ERROR helper
> patch from that series.  Thanks,
> 
> Josef
> 
> Josef Bacik (5):
>   btrfs: change handle_fs_error in recover_log_trees to aborts
>   btrfs: change error handling for btrfs_delete_*_in_log
>   btrfs: add a BTRFS_FS_ERROR helper
>   btrfs: do not infinite loop in data reclaim if we aborted
>   btrfs: fix abort logic in btrfs_replace_file_extents
> 
>  fs/btrfs/ctree.h       |  3 ++
>  fs/btrfs/disk-io.c     |  8 ++----
>  fs/btrfs/extent_io.c   |  2 +-
>  fs/btrfs/file.c        | 18 ++++++------
>  fs/btrfs/inode.c       | 22 ++++-----------
>  fs/btrfs/scrub.c       |  2 +-
>  fs/btrfs/space-info.c  | 27 +++++++++++++++---
>  fs/btrfs/super.c       |  2 +-
>  fs/btrfs/transaction.c | 11 ++++----
>  fs/btrfs/tree-log.c    | 62 ++++++++++++++++--------------------------
>  fs/btrfs/tree-log.h    | 16 +++++------
>  11 files changed, 85 insertions(+), 88 deletions(-)
> 


All the changes are straightforward so:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
