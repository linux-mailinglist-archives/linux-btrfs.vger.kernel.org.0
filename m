Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E147E0A43
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjKCUVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjKCUVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 16:21:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D948172D
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 13:21:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 812341F388;
        Fri,  3 Nov 2023 20:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699042868;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+q+6yXK+EIKW6P5hh50kIKGlXHW9qi1MVzUKpSBAIQg=;
        b=CTpUgTj6kBotQdRhogltvOfHFlFNNkkKlhY3JeljWbquxwlnfhzK6uLu5UHWSbVwFQ3irG
        rxnVgxIw5NuCJfXaSTbjVPLmhKEyijz1RV3PcbR5yLBQQgWvbtj0AIk584gL09jpDJ5LMI
        CrXohsN8fb2JGV9lGPxvyUsICKjR23g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699042868;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+q+6yXK+EIKW6P5hh50kIKGlXHW9qi1MVzUKpSBAIQg=;
        b=pCQFDPd0L5FKM783rv/+FC0gfSS9XZwxFDg/4B+6l4tp0MZawN1uMWxrJUFyB4GUtJdPzN
        azN1xuuHzSFrSICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FF351348C;
        Fri,  3 Nov 2023 20:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NSusFjRWRWV6KAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 03 Nov 2023 20:21:08 +0000
Date:   Fri, 3 Nov 2023 21:14:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Updated tarballs (Was: Re: Btrfs progs release 6.6)
Message-ID: <20231103201408.GN11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231103173512.2372-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103173512.2372-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tarballs were first published with version 6.5.3 by mistake. The
updated ones with v6.6 have been pushed to kernel.org site.

Correct timestamp: 03-Nov-2023 20:14

SHA256 checksums (can be verified in the signed list sha256sums.asc):

d40af9e8c8bb7499450503e8d1f494b9f1ef1b8762d1c32ea4873b7bab4335f5 btrfs-progs-v6.6.tar.gz
96792995eefb2eaae051c2ce3b5609b7e9bb2c1a5cb83fe69f92f1101b54b869 btrfs-progs-v6.6.tar.xz

Sorry for the inconvenience.

On Fri, Nov 03, 2023 at 06:35:10PM +0100, David Sterba wrote:
> Hi,
> 
> btrfs-progs version 6.6 have been released.
> 
> A mix of new minor features or commands and bug fixes.
> 
> Changelog:
> 
> * new global option --dry-run, now implemented for 'subvolume delete'
> * fi defrag: new option --step to defragment files in steps, report progress
> * balance: removed support for obsolete short syntax 'btrfs balance /path'
> * mkfs: print zone count for each device in the overview
> * check:
>   * verify inline ref ordering
>   * deprecate --clear-space-cache, moved to the 'rescue' group
> * rescue clear-space-cache: new command moved from 'btrfs check' implementing
>   the same as option --clear-space-cache (to be deprecated and removed in the
>   future)
> * dump-tree: output sequence number for inline refs
> * fixes:
>   * fi resize: fallback to lowest devid when 1 does not exist, previously the
>     command would fail with "No such device"
>   * fi usage: fix "devices 0 != 1" message and broken output on multi-device
>     filesystem
>   * open files in non-blocking mode when reading fsid, this could hang when
>     trying to open fifo files or some special character devices, was observed
>     with 'prop set/get'
> * experimental:
>   * mkfs: parametric zone size for emulated zoned mode
> * other:
>   * cleanups refactoring
>   * new and updated tests
>   * CI updates
>   * documentation updates
> 
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.6
