Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1654F7AB323
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIVNyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIVNyt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 09:54:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BEE92
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 06:54:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CBC8D21C4E;
        Fri, 22 Sep 2023 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695390881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okdpfsDuybTXdDbSZgc2dz7dRq+akVz6tgI2/Ugi8pQ=;
        b=IMrLMrGBhGES9uWZMW3gzXDUOJ+GTUcP6MVT6+P7TMqRruMMubVaRReEp8ThPP6dHojdfp
        +Rmjli71Zg/stakODP/B3fQ/C/u/jte11Pfzv4LNgIplCEXErSq+oXKYyr17gGmAT9KyQb
        0f/b/FVmzXJPTpF2N7BurbYuhO8sNS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695390881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okdpfsDuybTXdDbSZgc2dz7dRq+akVz6tgI2/Ugi8pQ=;
        b=kKckELl2YkEPLxwNc7RZRcTF7a30TmhaDGwz76LCyDWRnJWHmrS9rxPPriCT/h4JnYOxr8
        JO6su+1q39QQKnDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B156813478;
        Fri, 22 Sep 2023 13:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jmz0KaGcDWW0bAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 13:54:41 +0000
Date:   Fri, 22 Sep 2023 15:48:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: some cleanups around inode update and helpers
Message-ID: <20230922134806.GD13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695333082.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 11:37:18AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some cleanups mostly around btrfs_update_inode(), its helpers and some
> callers, mostly to remove the redundant root argument, which can be taken
> from the given inode. More details in the changelogs.
> 
> Filipe Manana (8):
>   btrfs: simplify error check condition at btrfs_dirty_inode()
>   btrfs: remove noline from btrfs_update_inode()
>   btrfs: remove redundant root argument from btrfs_update_inode_fallback()
>   btrfs: remove redundant root argument from btrfs_update_inode()
>   btrfs: remove redundant root argument from btrfs_update_inode_item()
>   btrfs: remove redundant root argument from btrfs_delayed_update_inode()
>   btrfs: remove redundant root argument from maybe_insert_hole()
>   btrfs: remove redundant root argument from fixup_inode_link_count()

Added to misc-next, thanks. The effects of removed parameters:

btrfs_finish_one_ordered                      -8 (208 -> 200)
btrfs_update_inode                            -8 (48 -> 40)
clone_finish_inode_update                     -8 (72 -> 64)
btrfs_cont_expand                             -8 (184 -> 176)
btrfs_xattr_handler_set_prop                  -8 (64 -> 56)
btrfs_fallocate_update_isize                  -8 (40 -> 32)
btrfs_add_link                                +8 (120 -> 128)
btrfs_update_inode_fallback                   -8 (32 -> 24)
btrfs_write_out_cache                         -8 (144 -> 136)
btrfs_setxattr_trans                          -8 (72 -> 64)
