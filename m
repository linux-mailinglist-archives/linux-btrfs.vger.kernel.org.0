Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454F613B4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiJaQ0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJaQ0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 12:26:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995D12761
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:26:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F01E022996;
        Mon, 31 Oct 2022 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667233597;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3Zcm+GOvwolpYsPaNKqbDF02HNpwu+3IGEHS/dtQN8=;
        b=E7iZAALJ4d1d7f5iisCbnCAL7cA12oJyFAinSs9xI3sadJTheVMNwoeFBLHE09fwYImGOK
        F+DQbDtZU+H8oIV+eq45D2o+TwmpmrWc08gceIDzN5zyd9cuj2rY+G4ODeWiRUxqyrYepG
        ijQUobqz2SVKHwvamqJ9ck7DJDrLquY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667233597;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3Zcm+GOvwolpYsPaNKqbDF02HNpwu+3IGEHS/dtQN8=;
        b=xB+Sfoax+HjEuqWlaenyEGJISFwZx6ERlKWj2czkueJM+oMBQs0iDVHEqImyiJWDnPBaWI
        cdzXWxCZ5VHM++CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3C8613451;
        Mon, 31 Oct 2022 16:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q0GmMj33X2O/OgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 16:26:37 +0000
Date:   Mon, 31 Oct 2022 17:26:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix direct IO writes with nowait and dsync
 iocb not syncing
Message-ID: <20221031162620.GD5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667215075.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667215075.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 11:43:54AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This fixes direct IO writes with nowait and dsync not getting synced after
> the writes complete (except when we fallback to blocking context). The first
> patch is the fix, while the second one only updates a comment that is now
> stale after 6.1-rc1.

The nowait + dsync combination is proably not a typical one but maybe
there are use cases I don't know about. Anyway, thanks for fixing it.

> Patch only applies to current misc-next, because a function prototype
> declaration was recently moved out of ctree.h into btrfs_inode.h. I left
> a version that applies cleanly against 6.0.6 and 6.1-rc at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=async_dio_fsync_fix_6.1_6.0

Great, thanks, that helps.
