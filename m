Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FA6C70A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCWTEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjCWTEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 15:04:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E629729E
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 12:04:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A974F33836;
        Thu, 23 Mar 2023 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679598242;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WW1jcg5j2ZzLqMnfLGvBT05wx7W8rjARUM5OZq68dzI=;
        b=njvoEOotWvSR92qraRgTUW474TN+Wyxv8q8dL51N2c5UG0aqKP+CRMz+PbJXnq58DpFrHY
        x4jMB1d6sbNYeyPJxAjZnIcST6aFlJaTH0badAPX9+r0VwSx20exhQjFtz1VWlioA7CVin
        avA/42mD2GrGCUxNMkDjzgHqXGO3gTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679598242;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WW1jcg5j2ZzLqMnfLGvBT05wx7W8rjARUM5OZq68dzI=;
        b=poffpfGqEjL6wgF4w48naD9jKu/Xr3aY0S6miekN2IOsik9ADoKEIV23FBlFONjLU4r4YC
        JuQ764c8inZAL+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C4FF132C2;
        Thu, 23 Mar 2023 19:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vNfFHKKiHGQqHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 19:04:02 +0000
Date:   Thu, 23 Mar 2023 19:57:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert: handle ext4 orphan file feature
 properly
Message-ID: <20230323185751.GZ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c481f192c76a98d5d750aa42f2d268a9bc20be5f.1679538836.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c481f192c76a98d5d750aa42f2d268a9bc20be5f.1679538836.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 10:33:59AM +0800, Qu Wenruo wrote:
> [BUG]
> Since e2fsprog 1.47, even a newly created empty ext4, btrfs-convert
> would result an fs that btrfs-check would complain:
> 
>  # mkfs.ext4 -F test.img
>  # btrfs-convert test.img
>  # btrfs-check test.img
>  Opening filesystem to check...
>  Checking filesystem on test.img
>  UUID: e45da158-8967-4e4d-9c9f-66b0d127dbce
>  [1/7] checking root items
>  [2/7] checking extents
>  [3/7] checking free space cache
>  [4/7] checking fs roots
>  root 5 inode 266 errors 2000, link count wrong
>  ERROR: errors found in fs roots
>  found 26333184 bytes used, error(s) found <<<
>  total csum bytes: 25540
>  total tree bytes: 180224
>  total fs tree bytes: 49152
>  total extent tree bytes: 16384
>  btree space waste bytes: 145423
>  file data blocks allocated: 33947648
>   referenced 26284032
> 
> [CAUSE]
> Ext4 has a new compat feature, COMPAT_ORPHAN_FILE, as a better way to
> track all the orphan inodes.
> 
> This new feature would create a new special inode for this purpose, and
> such orphan file inode would not be reachable from any other inode, but
> only from super block.
> 
> Unfortunately btrfs-convert only skip ext2 known special inodes, not the
> newer one.
> 
> [FIX]
> According to the kernel document, we can locate the orphan file inode
> using ext2 super block s_orphan_file_inum, and skip it for
> btrfs-convert.
> 
> And such skip would only happen if we have the definition of
> EXT4_FEATURE_COMPAT_ORPHAN_FILE, to be compatible with older e2fsprogs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks. I don't have e2fsprogs 1.47 on any testing host
yet, it's stuck in the QA because the change in defaults broke grub2,
but I could update the Tumbleweed CI image to pull packages from the
devel repos.
