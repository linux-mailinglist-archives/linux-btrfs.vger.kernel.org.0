Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCA58547C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbiG2R2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiG2R2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:28:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1562ED64
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:28:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38AE834DAB;
        Fri, 29 Jul 2022 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659115729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXOp+Q+MOf+9HBHuvJIg0UtNXyJRcIi2qL9yvRmYy3I=;
        b=jawmUQsB6PhDf6KtD+16dJS3cTJ+tx3v0ospiB/5yxXVC+lMBN3ObVSEbrK44EHNPfsxLE
        z7VI+g/6F7eScGcQkQwp6OZb7hBluJyS/N7dkgEcnjepe0z+rKL9lydnCEVwLxUmGjZC+s
        ZIzDIw5fon7TOizLTzDeHfF0gnsai1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659115729;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kXOp+Q+MOf+9HBHuvJIg0UtNXyJRcIi2qL9yvRmYy3I=;
        b=VzCW0knZmMjyVOXraOklIwfw6EbHWrTFL2E3WC1n9IsEeWtKwLCGagVkV2H98bgQlCY8HQ
        qX1qFHTd6g35ZFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1709A13A1B;
        Fri, 29 Jul 2022 17:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6sawBNEY5GKdJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Jul 2022 17:28:49 +0000
Date:   Fri, 29 Jul 2022 19:23:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Selectable checksum implementation
Message-ID: <20220729172349.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659106597.git.dsterba@suse.com>
 <YuQSMGYOl8iWqbqn@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQSMGYOl8iWqbqn@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 29, 2022 at 10:00:32AM -0700, Boris Burkov wrote:
> On Fri, Jul 29, 2022 at 04:59:06PM +0200, David Sterba wrote:
> > Add a possibility to load accelerated checksum implementation after a
> > filesystem has been mounted. Detailed description in patch 3.
> 
> What branch is this based on? I am having trouble applying it to
> misc-next or for-next.

It's v5.19-rc8, I pulled it from another repository that does not track
misc-next. I'll rebase it and resend.
