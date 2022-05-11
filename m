Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9E5233C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiEKNOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiEKNOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 09:14:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC964BED
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 06:14:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FBAF1F8FD;
        Wed, 11 May 2022 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652274870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kULMmq/csoqBWpF05Fmud1OobvQo4g5VTBuujDXUloc=;
        b=dijY7chEi17hMKvvq4TQSZUZm9jhJYWopoAic/lEY65nOKf6A6QrEmItv3Ufexab2/7PNu
        AWV4h5et+NxwXG7Agq8SrvkcefG3UmjV7yNDQi1TD2pJAGRU0+Qmbx5jg9Xxu+zUjcwaIw
        mSIbyMW7P+lYsQtYCeiP6DjLgl1KAL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652274870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kULMmq/csoqBWpF05Fmud1OobvQo4g5VTBuujDXUloc=;
        b=Izt378bqV/nbFP5z8KYohwDu5RZCbXsK6LWex5dL+lnihuPsk8kwjwerSTdoFoc/4g3t/0
        aDrKhLUJvfn3nNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1952139F9;
        Wed, 11 May 2022 13:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FHXnMbW2e2LlfAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 May 2022 13:14:29 +0000
Date:   Wed, 11 May 2022 15:10:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gniebler@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <20220511131014.GP18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dan Carpenter <dan.carpenter@oracle.com>,
        gniebler@suse.com, linux-btrfs@vger.kernel.org
References: <YnKbzreg3dLw9QTa@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKbzreg3dLw9QTa@kili>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 06:29:18PM +0300, Dan Carpenter wrote:
> Hello Gabriel Niebler,
> 
> The patch eb8da5bf4831: "btrfs: turn fs_roots_radix in btrfs_fs_info
> into an XArray" from Apr 26, 2022, leads to the following Smatch
> static checker warning:
> 
> fs/btrfs/disk-io.c:4453 btrfs_cleanup_fs_roots() error: uninitialized symbol 'i'.
> fs/btrfs/disk-io.c:4453 btrfs_cleanup_fs_roots() error: uninitialized symbol 'grabbed'.
> 
> fs/btrfs/disk-io.c
>     4408 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
>     4409 {
>     4410         struct btrfs_root *roots[8];
>     4411         unsigned long index = 0;
>     4412         int i;
>     4413         int err = 0;
>     4414         int grabbed;
>     4415 
>     4416         while (1) {
>     4417                 struct btrfs_root *root;
>     4418 
>     4419                 spin_lock(&fs_info->fs_roots_lock);
>     4420                 if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
>     4421                         spin_unlock(&fs_info->fs_roots_lock);
>     4422                         break;
> 
> "i" and "grabbed" are uninitialized if we hit this break statement on
> the first iteration through the loop.
> 
> roots is also uninitialized.  This error handling is badly broken.
> 
> If we hit it on the second iteration then we are also toasted.  Double
> frees.  I think.  (Trying to send emails quickly and then head out the
> door).

Thanks for the report, this has been meanwhile fixed in the tree,
Nikolay sent a fixup that replaced break with return.
