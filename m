Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D459ED5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiHWUfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiHWUeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:34:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48F17049
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 13:14:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CD1E336A3;
        Tue, 23 Aug 2022 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661285676;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpW7hZawx8fyqMT0jqL+tjGhg59k90Gm8xQ6KKFWvUM=;
        b=B0YXZLd76iErWqpxmodRvF6JwZHxuJ/xmfUTa/r0i6pRpx3S2Yxt4JSUwuA4MXiSpj6/sr
        NeI3QgMgKo9eh4ix0o2uw8khALe/+r3rl0N7pAQqfXHkxAN1ACe9NmNPmfYt4oRJEtP9TH
        xPTSYNc8XlQkX7vMyq30RTfM1NwuXj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661285676;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpW7hZawx8fyqMT0jqL+tjGhg59k90Gm8xQ6KKFWvUM=;
        b=6ewzAEJxuLETEDG3eubVvhRuNUhiCXlSeGfbGHWMt7Nrx3ZdCaw5x40T21TK3k6g5tfDOC
        GE/QpyhtM175XJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06E1113A89;
        Tue, 23 Aug 2022 20:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Ne1ACw1BWMuAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 23 Aug 2022 20:14:36 +0000
Date:   Tue, 23 Aug 2022 22:09:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, yebin10@huawei.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix race between quota enable and quota rescan
 ioctl
Message-ID: <20220823200921.GO13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, yebin10@huawei.com,
        Filipe Manana <fdmanana@suse.com>
References: <a95c38a253bedfa00d073e120a2599faa0f8139d.1661254155.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95c38a253bedfa00d073e120a2599faa0f8139d.1661254155.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 12:45:42PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When enabling quotas, at btrfs_quota_enable(), after committing the
> transaction, we change fs_info->quota_root to point to the quota root we
> created and set BTRFS_FS_QUOTA_ENABLED at fs_info->flags. Then we try
> to start the qgroup rescan worker, first by initalizing it with a call
> to qgroup_rescan_init() - however if that fails we end up freeing the
> quota root but we leave fs_info->quota_root still pointing to it, this
> can later result in a use-after-free somewhere else.
> 
> We have previously set the flags BTRFS_FS_QUOTA_ENABLED and
> BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with -EINPROGRESS at
> btrfs_quota_enable(), which is possible if someone already called the
> quota rescan ioctl, and therefore started the rescan worker.
> 
> So fix this by ignoring an -EINPROGRESS and asserting we can't get any
> other error.
> 
> Reported-by: Ye Bin <yebin10@huawei.com>
> Link: https://lore.kernel.org/linux-btrfs/20220823015931.421355-1-yebin10@huawei.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
