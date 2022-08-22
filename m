Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D959C67A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiHVSf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiHVSf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 14:35:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D62AE2D
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 11:35:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB988353B4;
        Mon, 22 Aug 2022 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661193353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC8baRJ7yOzIMtw+FJhqXK6R52oYxRj+T/qpauoASGI=;
        b=BPyrj3EOEX7kWYxf3vvg8UHs+PnBaO0T6vxWV5CVb362/357RyLOyNlufq49I8QcigPln9
        b9EkC9dZmPb4Ur63/A/xS4EOEQZuf8H2JEw7ZTDN/Mp5yi2kcZWwZiyb8nTsYSBtbEHUi0
        PN9BIBPTJiioXIl+GzyCrSBeKXD5QIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661193353;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC8baRJ7yOzIMtw+FJhqXK6R52oYxRj+T/qpauoASGI=;
        b=u9MejIuOicVDCP9CPzRhcWIQu2vUEulvR/817GgXUonK6fMRl4dRxef+y+k4yIBxnz7ZAZ
        mzyTuIRRnxKqzmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86B4E13523;
        Mon, 22 Aug 2022 18:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qxftHonMA2O4WwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 18:35:53 +0000
Date:   Mon, 22 Aug 2022 20:30:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix lost error value deleting root
 reference
Message-ID: <20220822183039.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1661168931.git.fdmanana@suse.com>
 <cover.1661179270.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661179270.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 22, 2022 at 03:47:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a silent failure in case deleting a root reference fails when searching
> for an item. Then make btrfs_del_root_ref() less likely to run into such
> type of bug in the future. Details in the changelogs.
> 
> V2: Fix patch 2/2. If the BTRFS_ROOT_BACKREF_KEY item is not found, but
>     the BTRFS_ROOT_REF_KEY is found, then before we would return -ENOENT
>     and now we were returning 0 (unless an error happened when deleting
>     the BTRFS_ROOT_REF_KEY item). Just return -ENOENT whenever one of
>     the items is not found, all the callers abort the transaction if
>     btrfs_del_root_ref() returns an error.
> 
> Filipe Manana (2):
>   btrfs: fix silent failure when deleting root reference
>   btrfs: simplify error handling at btrfs_del_root_ref()

Added to misc-next, thanks.
