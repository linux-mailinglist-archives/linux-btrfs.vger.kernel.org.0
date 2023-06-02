Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004D720A27
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 22:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjFBUOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBUOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 16:14:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBA1AD
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 13:14:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04E1C21A81;
        Fri,  2 Jun 2023 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685736852;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ky4wQQ1pM7DJEO5fT9r5WWtngMO7r7VEm2SZOtFVKuY=;
        b=Gdg9ShZnZHDyVD1feubFZcGgEP9uYFE0igSz7Ixvt1Ok4VTe0/zSyRplWYKav34OvgDos8
        NXbdxKxqVMHO1S//RK9M04sBqru3P3/+tdi/WuwkS8BTzPmX88I/0KDh/3QA8mg0ZqFAOc
        X2liKC1KShBivjIhdH2WSTVS5aBfRnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685736852;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ky4wQQ1pM7DJEO5fT9r5WWtngMO7r7VEm2SZOtFVKuY=;
        b=pYqC1hhD3FwfvbWtu0eOkDz94aSAd1SXOJ1wDMgxAwLxhnTX7ZUb15qm4dqh7xjC4HgDyu
        7BzeERrW0JpHR1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA8E5133E6;
        Fri,  2 Jun 2023 20:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d9iLNJNNemRFZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 02 Jun 2023 20:14:11 +0000
Date:   Fri, 2 Jun 2023 22:07:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: Re: [PATCH v4 0/2] btrfs: fix logical_to_ino panic in btrfs_map_bio
Message-ID: <20230602200759.GA15048@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1685645613.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685645613.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 11:55:12AM -0700, Boris Burkov wrote:
> The gory details are in the second patch, but it is possible to panic
> the kernel by running the ioctl BTRFS_IOC_LOGICAL_INO (and V2 of that
> ioctl).
> 
> The TL;DR of the problem is that we do not properly handle logging a
> move from a push_node_left btree balancing operation in the tree mod
> log, so it is possible for backref walking using the tree mod log to
> construct an invalid extent_buffer and ultimately try to map invalid
> bios for block 0 which ultimately hits a null pointer error and panics.
> 
> The patch set introduces additional bookkeeping in tree mod log to warn
> on this issue and also fixes the issue itself.
> 
> ---
> Changelog:
> v4:
> - actually include the changes to Patch 1 cited in v3, my mistake.

Added to misc-next, thanks.
