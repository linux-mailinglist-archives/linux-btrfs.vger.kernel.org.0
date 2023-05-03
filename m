Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137DF6F5886
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjECNDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjECNDP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 09:03:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DE5B9C
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:02:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83ABF20091;
        Wed,  3 May 2023 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683118972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7WL0qxAUCS4+sAES7xZEXRTFBdt5gihY7f86MIX9ks=;
        b=yq3L3rNnIYp1Wbew7PcTe9aIdOgRL/l7/t2yXn8OdKEMsnCz4ERUyej9rq38hvvFrB9skq
        HgzGechqvXO4kNyS3rSQClez7Q6BrDEpMKFEf4D5GOHGgRf9OFYhOy6xEd9jNRfSY8gBsx
        tsai1GCNitFg/nsi0rvKJaEHmJTxF6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683118972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7WL0qxAUCS4+sAES7xZEXRTFBdt5gihY7f86MIX9ks=;
        b=uZhB05bHeO5hKV4wBzS4LrSnlgYFwDOW32H2KaK0djDGnWLV/ZKc4l+c9EyG/eVFYLe4HK
        lqSXZFFLZx7xy7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60DAF13584;
        Wed,  3 May 2023 13:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wDjQFnxbUmSREgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 13:02:52 +0000
Date:   Wed, 3 May 2023 14:56:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't free qgroup space unless specified
Message-ID: <20230503125656.GB6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 02, 2023 at 04:00:06PM -0400, Josef Bacik wrote:
> Boris noticed in his simple quotas testing that he was getting a leak
> with Sweet Tea's change to subvol create that stopped doing a
> transaction commit.  This was just a side effect of that change.
> 
> In the delayed inode code we have an optimization that will free extra
> reservations if we think we can pack a dir item into an already modified
> leaf.  Previously this wouldn't be triggered in the subvolume create
> case because we'd commit the transaction, it was still possible but
> much harder to trigger.  It could actually be triggered if we did a
> mkdir && subvol create with qgroups enabled.
> 
> This occurs because in btrfs_insert_delayed_dir_index(), which gets
> called when we're adding the dir item, we do the following
> 
> btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
> 
> if we're able to skip reserving space.
> 
> The problem here is that trans->block_rsv points at the temporary block
> rsv for the subvolume create, which has qgroup reservations in the block
> rsv.
> 
> This is a problem because btrfs_block_rsv_release() will do the
> following
> 
>   if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
> 	  qgroup_to_release = block_rsv->qgroup_rsv_reserved -
> 		  block_rsv->qgroup_rsv_size;
> 	  block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
>   }
> 
> The temporary block rsv just has ->qgroup_rsv_reserved set,
> ->qgroup_rsv_size == 0.  The optimization in
> btrfs_insert_delayed_dir_index() sets ->qgroup_rsv_reserved = 0.  Then
> later on when we call btrfs_subvolume_release_metadata() which has
> 
>   btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
>   btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
> 
> qgroup_to_release is set to 0, and we do not convert the reserved
> metadata space.
> 
> The problem here is that the block rsv code has been unconditionally
> messing with ->qgroup_rsv_reserved, because the main place this is used
> is delalloc, and any time we call btrfs_block_rsv_release() we do it
> with qgroup_to_release set, and thus do the proper accounting.
> 
> The subvolume code is the only other code that uses the qgroup
> reservation stuff, but it's intermingled with the above optimization,
> and thus was getting its reservation freed out from underneath it and
> thus leaking the reserved space.
> 
> The solution is to simply not mess with the qgroup reservations if we
> don't have qgroup_to_release set.  This works with the existing code as
> anything that messes with the delalloc reservations always have
> qgroup_to_release set.  This fixes the leak that Boris was observing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
