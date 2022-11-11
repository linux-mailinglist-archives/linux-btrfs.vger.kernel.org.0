Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27906261C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 20:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiKKTM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiKKTMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 14:12:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6E729A0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:12:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E82832229E;
        Fri, 11 Nov 2022 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668193972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2XvopogVDZSzPUBYyLvMmwVURuUk5361f5djxaUckU=;
        b=Ep7mpEZb1Zjg6fV9YxKqeeUdhA7ahsv7GgrWK2u+wGGMzi5rFda77RYQNC4rZc5UW/mVXQ
        PynaFodbRjspzBTr/4/WkpyI8lSJGpZktnKnQUI6+q2uF6W9SHKgTnqA0ifFWZoO8FJvoQ
        Nq7ioGBZL9LBzz+cTjWXCOSxJ6a2rDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668193972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2XvopogVDZSzPUBYyLvMmwVURuUk5361f5djxaUckU=;
        b=9yEt/WH+IjS+XqNVJgvv/yQAE/I+hPFYWUTyCsDxTXIHZ57pH5eFeoOXeGbS0aIKlQd9IE
        g0RXLQsKRcCcYJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9C7A13357;
        Fri, 11 Nov 2022 19:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s1RUMLSebmOlKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 19:12:52 +0000
Date:   Fri, 11 Nov 2022 20:12:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Message-ID: <20221111191228.GW5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668166764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 11, 2022 at 11:50:26AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Here follows a few more optimizations for lseek and fiemap. Starting with
> coreutils 9.0, cp no longer uses fiemap to determine where holes are in a
> file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operation.
> For very sparse files, or files with lot of delalloc, this can be very
> slow (when compared to ext4 or xfs). This aims to improve that.
> 
> The cp pattern is not specific to cp, it's common to iterate over all
> allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA,
> for either the whole file or just a section. Another popular program that
> does the same is tar, when using its --sparse / -S command line option
> (I use it like that for doing vm backups for example).
> 
> The details are in the changelogs of each patch, and results are on the
> changelog of the last patch in the series. There's still much more room
> for further improvement, but that won't happen too soon as it will require
> broader changes outside the lseek and fiemap code.
> 
> Filipe Manana (9):
>   btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
>   btrfs: add an early exit when searching for delalloc range for lseek/fiemap
>   btrfs: skip unnecessary delalloc searches during lseek/fiemap
>   btrfs: search for delalloc more efficiently during lseek/fiemap
>   btrfs: remove no longer used btrfs_next_extent_map()
>   btrfs: allow passing a cached state record to count_range_bits()
>   btrfs: update stale comment for count_range_bits()
>   btrfs: use cached state when looking for delalloc ranges with fiemap
>   btrfs: use cached state when looking for delalloc ranges with lseek

Thanks, the improvements look great, added to misc-next.
