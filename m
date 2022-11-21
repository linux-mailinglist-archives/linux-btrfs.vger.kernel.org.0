Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7554F632CF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiKUTYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 14:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiKUTY2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 14:24:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84265B700E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 11:24:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7D41F8BB;
        Mon, 21 Nov 2022 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669058664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItIiE+1w89vsk5h8tr/n/fdhJWh0vtMaHHvZ4Tjayi4=;
        b=aUxV3G8Z+GIc30232dqxanMV3xl5HYvLbyMJPLkjB/NAByxiZJGjRQNsBog6xSgNPq1pNf
        akwhYmRvfiHd2r3hveStfn3WysPKxKFyjfQxiv65qdJxEIFbZlnxPcdrRwP/eka/86RXZE
        xqGOUpL7t0lfQtbNSserDJK4YNQUbTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669058664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItIiE+1w89vsk5h8tr/n/fdhJWh0vtMaHHvZ4Tjayi4=;
        b=NrOA0VsC8OAllNWHfYP5BBy6RVejJ4CctzPFnMI5nTkzgvFAfuC09mUXRwXTq96Xo2URLw
        535PC4Q+ubCjBBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 124CF1377F;
        Mon, 21 Nov 2022 19:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0yeLA2jQe2MKOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 21 Nov 2022 19:24:24 +0000
Date:   Mon, 21 Nov 2022 20:23:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a rare deadlock case when logging inodes
Message-ID: <20221121192354.GC5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1669025204.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669025204.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 21, 2022 at 10:23:21AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Syzbot recently reported a lockdep splat about a potential deadlock case.
> It should be a rare case, but it is indeed possible to happen. The first
> patch in the series fixes that deadlock, the second one unifies back two
> functions that used to be the same, and finally the last one removes some
> outdated logic and adds an assertion (and documentation) to make sure we
> don't forget about that type of deadlock in case overwrite_item() gets
> used in the future for updating items in a log tree. More details in the
> changelogs of each patch.
> 
> Filipe Manana (3):
>   btrfs: do not modify log tree while holding a leaf from fs tree locked
>   btrfs: unify overwrite_item() and do_overwrite_item()
>   btrfs: remove outdated logic from overwrite_item() and add assertion

Added to misc-next, thanks.
