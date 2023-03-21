Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F46C27F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 03:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCUCRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCUCRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 22:17:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EFD3845B
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 19:17:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADB871FD66;
        Tue, 21 Mar 2023 02:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679365036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8y+dHBwkiE769JhnpEFyWjwCm97nC4VbHWI2vdWR4Y=;
        b=wKterj4fKgstkGMn+Nc/8UmdbWB6c+pEjPOdCM6voPaQuj2hzDSUGuuPeMnGmo43jLU4rz
        BdpRkxu60twHoTYzPqzcHCrqm8fUWx7aqaGur1n8Uk7zBxOjVpPWmsHcr2ECX0tXTWNOmc
        8cm2GhDBahovKUMg8pGwA1Z36DU7As0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679365036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8y+dHBwkiE769JhnpEFyWjwCm97nC4VbHWI2vdWR4Y=;
        b=LZ62JbI1IjtWb+Vyx2NQ4d9TgkqxAp7S4Gnjl5OBLsI8Ul/ZcjqBkNvJ5oNSC8hZEPKdTJ
        jHNUnis9jSB4bPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8378A13451;
        Tue, 21 Mar 2023 02:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y7AMH6wTGWRpdQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 02:17:16 +0000
Date:   Tue, 21 Mar 2023 03:11:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: use alloc_dummy_extent_buffer() for
 temporaray super block
Message-ID: <20230321021106.GR10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <80b02fbfe6796c85322244f2e3110295787df3a6.1679098721.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b02fbfe6796c85322244f2e3110295787df3a6.1679098721.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 18, 2023 at 08:18:42AM +0800, Qu Wenruo wrote:
> [FALSE ALERT]
> There is a false alert when compiling btrfs-progs using gcc 12.2.1:
> 
>  $ make D=1
>  kernel-shared/print-tree.c: In function 'print_sys_chunk_array':
>  kernel-shared/print-tree.c:1797:9: warning: 'buf' may be used uninitialized [-Wmaybe-uninitialized]
>   1797 |         write_extent_buffer(buf, sb, 0, sizeof(*sb));
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  In file included from ./kernel-shared/ctree.h:27,
>                   from kernel-shared/print-tree.c:24:
>  ./kernel-shared/extent_io.h:148:6: note: by argument 1 of type 'const struct extent_buffer *' to 'write_extent_buffer' declared here
>    148 | void write_extent_buffer(const struct extent_buffer *eb, const void *src,
>        |      ^~~~~~~~~~~~~~~~~~~
> 
> [CAUSE]
> This is a false alert, the uninitialized part of buf will not be
> utilized at all during write_extent_buffer().
> 
> [FIX]
> Instead of allocating such adhoc buf, go a more formal way by calling
> alloc_dummy_extent_buffer(), which would properly setting all the
> members.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
