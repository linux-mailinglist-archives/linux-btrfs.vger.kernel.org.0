Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3207B3823
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjI2Qxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjI2Qxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 12:53:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016701AE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 09:53:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A099E218E7;
        Fri, 29 Sep 2023 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696006425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpiN76DbYQzWqGFMFrJvcEmeu7qc+NOT3NCM9N3IjIk=;
        b=osTtGr85ZiKYauPQCuK6xthRVYLLyELxEuh6T2Kd8bIfCmJ0ttHrPSxLfQ8GIcSjDIJTzM
        oi4VGvacN2xzp3G0hxtUQJxatXZdpcfuxSrw7e/c3hCnMvPCenR5hxMHJ5Py1Q/dkOGWX0
        wTpPjUOx4nM1BbSis8G1GicXCQBeFCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696006425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpiN76DbYQzWqGFMFrJvcEmeu7qc+NOT3NCM9N3IjIk=;
        b=4d+ywiCxxx1F5XeRlcAngU8r46gt1E9KdCRq2pWFcL2piI8S38rQ54ze90Jn51KlkDN96Z
        ySbU+X33X9dc6aDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728661390A;
        Fri, 29 Sep 2023 16:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RaBeGhkBF2V7XwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Sep 2023 16:53:45 +0000
Date:   Fri, 29 Sep 2023 18:47:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: some speedups for io tree operations and
 cleanups
Message-ID: <20230929164706.GI13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
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

On Fri, Sep 22, 2023 at 11:39:01AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These are some changes to make some io tree operations more efficient and
> some cleanups. More details on the changelogs.
> 
> Filipe Manana (8):
>   btrfs: make extent state merges more efficient during insertions
>   btrfs: update stale comment at extent_io_tree_release()
>   btrfs: make wait_extent_bit() static
>   btrfs: remove pointless memory barrier from extent_io_tree_release()
>   btrfs: collapse wait_on_state() to its caller wait_extent_bit()
>   btrfs: make extent_io_tree_release() more efficient
>   btrfs: use extent_io_tree_release() to empty dirty log pages
>   btrfs: make sure we cache next state in find_first_extent_bit()

Added to misc-next, thanks. The commit message for patch 4 was changed.
