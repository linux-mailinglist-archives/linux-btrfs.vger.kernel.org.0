Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FE62FAE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbiKRQ4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRQ4b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:56:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77C6A764
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 08:56:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 989BB1FD98;
        Fri, 18 Nov 2022 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668790589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Evspdp6/hktle644Q6FqBzPitv0d6pOX4DESTBEiDLk=;
        b=H0qVXilIEwmnhPXKYk4fIpyChQ/1IOCYHEqUuJc8O3cOva+VT0Ylj8w9x6rgl/LxmvA6sI
        xy9CcQUrKUFZZQ++ay20SaniWxnjomAfZ16hvLuffQBATCgcLRcgA0qo4/bkSK/sNIcAWQ
        zLeYR9lS4kuMLoIckkC+ImIyIVOMIj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668790589;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Evspdp6/hktle644Q6FqBzPitv0d6pOX4DESTBEiDLk=;
        b=i+7TYULoL7niJR7kazF5go2/GSKmZPft/UEGYuImF+6SDdFAJjK3GW5E97bllZF2bG5PcZ
        SYfarJDls1sCIQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CFA71345B;
        Fri, 18 Nov 2022 16:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qP2uHT25d2PEFQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:56:29 +0000
Date:   Fri, 18 Nov 2022 17:56:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] btrfs: data block group size classes
Message-ID: <20221118165601.GV5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668626092.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668626092.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 11:22:01AM -0800, Boris Burkov wrote:
> This patch set introduces the notion of size classes to the block group
> allocator for data block groups. This is specifically useful because the
> first fit allocator tends to perform poorly when large extents free up
> in older block groups and small writes suddenly shift there. Generally,
> it should lead to slightly more predictable allocator behavior as the
> gaps left by frees will be used by allocations of a similar size.
> 
> Details about the changes and performance testing are in the individual
> commit messages.
> 
> The last two patches constitute the business of the change. One adds the
> size classes and the other handles the fact that we don't want to
> persist the size class, so we don't know it when we first load a block
> group.
> ---
> v2:
> - removed 1G falloc extents patch
> - rebased tracepoints patches onto significant header file refactor
> 
> Boris Burkov (4):
>   btrfs: use ffe_ctl in btrfs allocator tracepoints
>   btrfs: add more ffe tracepoints
>   btrfs: introduce size class to block group allocator
>   btrfs: load block group size class when caching

I'd take the first two patches as preparatory work but as commented the
ctree.h should be reworked so the whole patchset will go to next
development cycle.
