Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E36F43D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjEBM0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjEBM0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:26:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052414C2B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:26:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E3931F8BE;
        Tue,  2 May 2023 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683030401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mXG1AdPRZqlMt32SJES4mYXqAv+dQXZme3a8Yw+nLtU=;
        b=jNkEEmmTYTai+p9myyQ0ns61LaCReDqNvqhANscU4FVmcbi1GYlac+huxORwmoko6+ClG3
        e6Ug5vFCdrzUAJUQqbS8+ML626uqdCCP9Es6OZueeiT5bDDsMFvtb6UAjondaQbkja6Qx4
        JsgqudzTRn5NhUNpkGmT52xkRqXQLNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683030401;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mXG1AdPRZqlMt32SJES4mYXqAv+dQXZme3a8Yw+nLtU=;
        b=zr9yYGLiCUySPBqvyn9Bl3BqLLsBm/vk0caUpKYPRZnRLCiGp6NnEegVv1llOJx2P7PVvY
        519SNIGXEaJWmmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E167139C3;
        Tue,  2 May 2023 12:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7ExAEoEBUWQKOQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 12:26:41 +0000
Date:   Tue, 2 May 2023 14:20:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix encoded write i_size corruption
Message-ID: <20230502122046.GC8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e340cd5aef01df9826746dab5a74cb2fcce19a8e.1682714694.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e340cd5aef01df9826746dab5a74cb2fcce19a8e.1682714694.git.boris@bur.io>
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

On Fri, Apr 28, 2023 at 02:02:11PM -0700, Boris Burkov wrote:
> We have observed a btrfs filesystem corruption on workloads using
> NOHOLES and encoded writes via sendstream v2. The symptom is that a file
> appears to be truncated to the end of its last aligned extent, even
> though the final unaligned extent and even the file extent and otherwise
> correctly updated inode item have been written.
> 
> So if we were writing out a 1MiB+X file via 8 128K extents and one
> extent of length X, isize would be set to 1MiB, but the ninth extent,
> nbyte, etc.. would all appear correct otherwise.
> 
> The source of the race is a narrow (one code line..) window in which a
> noholes fs has read in an updated isize, but has not yet set a shared
> disk_i_size variable to write. Therefore, if two ordered extents run in
> parallel (par for the course for receive workloads), the following
> sequence can play out: (following "threads" a bit loosely, since there
> are callbacks involved for endio but extra threads aren't needed to
> cause the issue)
> 
> ENC-WR1 (second to last)                                         ENC-WR2 (last)
> -------                                                          -------
> btrfs_do_encoded_write
>   set isize = 1M
>   submit bio B1 ending at 1M
> endio B1
> btrfs_inode_safe_disk_i_size_write
>   local isize = 1M
>   falls off a cliff for some reason
>                                                             btrfs_do_encoded_write
>                                                               set isize = 1M+X
>                                                               submit bio B2 ending at 1M+X
>                                                             endio B2
> 							    btrfs_inode_safe_disk_i_size_write
>                                                               local isize = 1M+X
>                                                               disk_i_size = 1M+X
>   disk_i_size = 1M
> 							    btrfs_delayed_update_inode
>   btrfs_delayed_update_inode
> 
> And the delayed inode ends up filled with nbytes=1M+X and isize=1M, and
> writes respect isize and present a corruted file missing its last
> extents.
> 
> Fix this by holding the inode lock in the noholes case so that a thread
> can't sneak in a write to disk_i_size that gets overwritten with an out
> of date isize.
> 
> Fixes: 41a2ee75aab0290 btrfs: introduce per-inode file extent tree
> Signed-off-by: Boris Burkov <boris@bur.io>

Added to misc-next, thanks.
