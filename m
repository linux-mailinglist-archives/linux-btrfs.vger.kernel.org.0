Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F666A62CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 23:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjB1Wta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 17:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjB1WtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 17:49:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549235257
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 14:49:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E10901FE0D;
        Tue, 28 Feb 2023 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677624553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcIiFQAyxn8EL4uU8Vja6suvlFI1OmSkRaT410kDQ3E=;
        b=sGLWlX5+XiT2NeA3BjLQ+L8UpvaCtSSQxif6/U4AGo37RsGWU3PhrROuKr4LIyollSAqfe
        2gdZin069WcmTmGQeoiUEVmRKu6IltGHMt4dG8PWUijRtHccSC0smlTcWQRb2YwmmNveDu
        l9C4dfP2NkqdJaMHScO9KY73NDtUESk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677624553;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IcIiFQAyxn8EL4uU8Vja6suvlFI1OmSkRaT410kDQ3E=;
        b=BmsSez+cdI0pHR+vu6wz/vq4d+1evBL0pjzRb5dW1I9lK4qZ3F7QaOQ89hEDq20FmAh08A
        2xtbUKU/Anw6iKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B081D13440;
        Tue, 28 Feb 2023 22:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b1zGKemE/mPVKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Feb 2023 22:49:13 +0000
Date:   Tue, 28 Feb 2023 23:43:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: dio partial write corruption fix
Message-ID: <20230228224314.GQ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1677026757.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677026757.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 04:49:58PM -0800, Boris Burkov wrote:
> If there is a page fault while btrfs reads the write buffer for a dio
> write, then iomap will issue a partial bio which ultimately results in
> an effective hole in the btrfs representation of the file. If what was
> being written was not zeros, this means incorrect file contents.
> 
> The patch series consists of a prep patch creating a new ordered extent
> allocation function and the business patch, which contains the fix
> as well as the gory details of the bug itself.
> 
> ---
> Changelog:
> v2:
> - rename new ordered extent function
> - pull the new function into a prep patch
> - reorganize how the ordered_extent is stored/passed around to avoid so
> many annoying memsets and exposing it to fs/btrfs/file.c
> - lots of small code style improvements
> - remove unintentional whitespace changes
> - commit message improvements
> - various ASSERTs for clarity/debugging
> 
> Boris Burkov (2):
>   btrfs: btrfs_alloc_ordered_extent
>   btrfs: fix dio continue after short write due to buffer page fault

Added to misc-next with the suggested updates, thanks.
