Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C69549EC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbiFMUQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350671AbiFMUQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:16:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7262C120
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:52:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B013B1F91E;
        Mon, 13 Jun 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655146374;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRklqgcGRVSTFWrVmufGM2hTxbbfy16FW2NPX8DM//c=;
        b=wcXt+QiHkkoQjig5zyutTRt2lN89jl1GK4O1esblP4q7t/upWEosy9or78M54HP0LHHDLV
        8wHk9GpDx0iduPa0qMzy+lY07jNZRUWkzQRjL9fDMWAA8Rzv8xLgwQ6DacXkEeiXQ6qgKO
        Rnpg+Aakb3XOALjIgDPZo54cSNL32wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655146374;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRklqgcGRVSTFWrVmufGM2hTxbbfy16FW2NPX8DM//c=;
        b=+OuNTUbXMNzC0WFpRJWAXgNzXi2ypltc1QaQiaPdmPTk/m6BOG8J7dL+A9BW/ANB2f7sIN
        8yy8QSlC7NLN6DBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93E0A134CF;
        Mon, 13 Jun 2022 18:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2c4ZI4aHp2KeJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 13 Jun 2022 18:52:54 +0000
Date:   Mon, 13 Jun 2022 20:48:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't set lock_owner when locking tree pages for
 reading
Message-ID: <20220613184822.GF20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609023936.6112-1-ce3g8jdj@umail.furryterror.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 10:39:36PM -0400, Zygo Blaxell wrote:
> In 196d59ab9ccc "btrfs: switch extent buffer tree lock to rw_semaphore"
> the functions for tree read locking were rewritten, and in the process
> the read lock functions started setting eb->lock_owner = current->pid.
> Previously lock_owner was only set in tree write lock functions.
> 
> Read locks are shared, so they don't have exclusive ownership of the
> underlying object, so setting lock_owner to any single value for a
> read lock makes no sense.  It's mostly harmless because write locks
> and read locks are mutually exclusive, and none of the existing code
> in btrfs (btrfs_init_new_buffer and print_eb_refs_lock) cares what
> nonsense is written in lock_owner when no writer is holding the lock.
> 
> KCSAN does care, and will complain about the data race incessantly.
> Remove the assignments in the read lock functions because they're
> useless noise.
> 
> Fixes: 196d59ab9ccc ("btrfs: switch extent buffer tree lock to rw_semaphore")
> Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

Added to misc-next, thanks.
