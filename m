Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE646FD2FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjEIXPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEIXPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:15:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D27D30DB
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 16:15:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C4C421B56;
        Tue,  9 May 2023 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683674100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwhBJBOAQbfPjhdUPgIPnFQBrSh1XR67dYlJWfqjgWk=;
        b=e2pYuUC8w+IO4jGM05i1AamJsr0RzNGmP2/vNhIeUUOA1ZZ2fWajxTWOlUSh+3PZSGcXA0
        +w6FyidhB6j9Kh+J3RbzADojbekNu70PM8NCVPl6x2VXH3PI6jZuaPT7w4Kt0izYj3FdiU
        U5hgfc8YEx25ukH6BHUDKf7GBu+ax/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683674100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwhBJBOAQbfPjhdUPgIPnFQBrSh1XR67dYlJWfqjgWk=;
        b=Ds74l3slvhI6Gmm6ezJG87HagvSKarCEAZzBi8ReubbWoEhxeRVaIzZk3duMLq/L9NdFoU
        gyMzTRqdfFN3SPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF847139B3;
        Tue,  9 May 2023 23:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1heeNfPTWmQ4BgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 23:14:59 +0000
Date:   Wed, 10 May 2023 01:09:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make clear_cache mount option to rebuild FST
 without disabling it
Message-ID: <20230509230900.GL32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f104498c17b3d428a6bb6071ccf46b19d6ac8ace.1682662078.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f104498c17b3d428a6bb6071ccf46b19d6ac8ace.1682662078.git.wqu@suse.com>
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

On Fri, Apr 28, 2023 at 02:13:05PM +0800, Qu Wenruo wrote:
> Previously clear_cache mount option would simply disable free-space-tree
> feature temporarily then re-enable it to rebuild the whole free space
> tree.
> 
> But this is problematic for block-group-tree feature, as we have an
> artificial dependency on free-space-tree feature.
> 
> If we go the existing method, after clearing the free-space-tree
> feature, we would flip the filesystem to read-only mode, as we detects a
> super block write with block-group-tree but no free-space-tree feature.
> 
> This patch would change the behavior by properly rebuilding the free
> space tree without disabling this feature, thus allowing clear_cache
> mount option to work with block group tree.
> 
> Now we can mount a filesystem with block-group-tree feature and
> clear_mount option:
> 
>  $ mkfs.btrfs  -O block-group-tree /dev/test/scratch1  -f
>  $ sudo mount /dev/test/scratch1 /mnt/btrfs -o clear_cache
>  $ sudo dmesg -t | head -n 5
>  BTRFS info (device dm-1): force clearing of disk cache
>  BTRFS info (device dm-1): using free space tree
>  BTRFS info (device dm-1): auto enabling async discard
>  BTRFS info (device dm-1): rebuilding free space tree
>  BTRFS info (device dm-1): checking UUID tree
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Currently this patch is dependent on the patch
> "btrfs: properly reject clear_cache and v1 cache for block-group-tree".
> 
> The size of the patch makes me wonder if it's a good candidate for
> backports.
> It's at my personal border line for patch sizes.
> 
> But if we choose to backport this patch (with the dependency),
> then we can make bgt support much more consistent.
> 
> The final decision is still on David, I am happy to update both patches
> if needed.

The prerequisite patch has been merged to master and tagged for 6.1 so
this one can follow. The patch size is still reasonable and within the
scope that stable trees accept (about 100 lines of diff), but that it
fixes a real problem works for backports.

This makes the block-group-tree feature work with clear_cache and we
want to make BGT default in the future so patches like that are good to
extend the coverage in advance. We may need to test this for some time
but I'll make a note to put it to some -rc. Thanks.
