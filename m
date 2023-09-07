Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F360797414
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjIGPfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245069AbjIGP1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 11:27:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B600CE7
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 08:27:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D22E621872;
        Thu,  7 Sep 2023 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694087286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR+n4/4VD6Juf6BPsfTkyKYsr9rWGg3rDle7QwAq+qk=;
        b=y85pWPV0op/zSwuis8JzfudooSrQzKdGWHksaYZSerDdYKGin+KZUPQdAUvgE7ZnojWkCU
        RG/o8DslIYjaM46yaZkpHHenIO4yg7FaP/C4f143eMLGsRIqn73UjU/UVeimw8IiJHpDf0
        xV+3NrKdvfXOXV8mW5glmBmGu2SVfcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694087286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR+n4/4VD6Juf6BPsfTkyKYsr9rWGg3rDle7QwAq+qk=;
        b=MaOv/mCVOe/knmbDaCGeyVEIfxGndtqU8rqm/spFVrbra9Cj/QMfuC+sgloWTT8wyO6bQF
        Pwha+JFOjA6aOVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6C93138F9;
        Thu,  7 Sep 2023 11:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IlipK3a4+WQTBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 11:48:06 +0000
Date:   Thu, 7 Sep 2023 13:41:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 06/18] btrfs: create qgroup earlier in snapshot
 creation
Message-ID: <20230907114135.GE3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:53PM -0700, Boris Burkov wrote:
> Pull creating the qgroup earlier in the snapshot. This allows simple
> quotas qgroups to see all the metadata writes related to the snapshot
> being created and to be born with the root node accounted.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/qgroup.c      | 3 +++
>  fs/btrfs/transaction.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 18f521716e8d..8e3a4ced3077 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1672,6 +1672,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	struct btrfs_qgroup *qgroup;
>  	int ret = 0;
>  
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> +		return 0;
> +
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
>  		ret = -ENOTCONN;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 89ff15aa085f..25217888e897 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1722,6 +1722,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>  	}
>  	btrfs_release_path(path);
>  
> +	ret = btrfs_create_qgroup(trans, objectid);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);

This adds and error case to the middle of a transaction commit.
Snapshots are created in two parts, first is the ioctl adding the
structure and then commit actually creates that. So the first phase
preallocates what's needed (the root_item and path) and should do the
same with the qgroups as much as possible.

Also check all the things that btrfs_create_qgroup() does, searches the
qgroup tree, adds the new item, takes the qgroup_ioctl_lock mutex, and
adds the sysfs entry (that does allocations under GFP_KERNEL).
If you really need to create the qgroup like that then it needs much
more care.
