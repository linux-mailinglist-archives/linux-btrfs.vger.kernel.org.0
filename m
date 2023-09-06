Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FBD794153
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbjIFQU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbjIFQU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:20:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC51992
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:20:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C86C22431;
        Wed,  6 Sep 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694017223;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HJMBseNJFg72JpmA3SeEi6X1TV+LecUh+O/B5V/l5I=;
        b=uQYdD3YZxSi8vc3RILhMWlgLOBNC9KBScT4nLmwmlIhYk6i1jnGER+7R2Y5HZWD4Pwk7CI
        RMU2x985fXe7GFcP8/v31CsxjZeOrtjctE3BeFviWtUfSDbabzmKCWBnRusIdo0kz8rVAX
        xJ3d63dcpdFvkz/LOxGLpLVfhj9azwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694017223;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HJMBseNJFg72JpmA3SeEi6X1TV+LecUh+O/B5V/l5I=;
        b=Lt53UV7YhuZbTBta5EmBahAX1BbXkaCUtwj/llHEHPIbz9jZ88KGq2rSoDGE1OfoYZq/6O
        6EwPCpyrM6ul7LBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19FEF1333E;
        Wed,  6 Sep 2023 16:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a2mbBcem+GSIfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 06 Sep 2023 16:20:23 +0000
Date:   Wed, 6 Sep 2023 18:13:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] btrfs: make sure to initialize start and len in
 find_free_dev_extent
Message-ID: <20230906161342.GN14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693930391.git.josef@toxicpanda.com>
 <3223c8646dd74cc0252e3b619a7a2cd6b078d85a.1693930391.git.josef@toxicpanda.com>
 <06cfc805-0bac-4479-bf66-690bf83f3f0b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cfc805-0bac-4479-bf66-690bf83f3f0b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 06, 2023 at 06:48:41AM +0800, Qu Wenruo wrote:
> > -	search_start = dev_extent_search_start(device);
> > +	max_hole_start = search_start = dev_extent_search_start(device);
> 
> IIRC we don't recommend such assignment, it would be better to go two
> lines to do the assignment.

Right, fixed in the commit, thanks.
