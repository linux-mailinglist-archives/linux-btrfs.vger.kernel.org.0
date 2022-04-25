Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1637150E6E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbiDYRUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiDYRUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:20:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBDF2A25D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:17:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A97B3210E6;
        Mon, 25 Apr 2022 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650907041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTyPo0o1BrnaKlUX9/OqpKRiP/5+6zAonj6JDSCFAfk=;
        b=zpJTjDD4fQ6wIvWIrY3xHwxAd7P8OUNt5iQEfcImtMCJR45rxWT5oJZfkDYTNh50ibudao
        mpHYMKxu+Z8KxtEp5sJSUwAtN8d+PfEWFWJQih4QRc3Sr4xQqApb8Vt6YMPJFV3JnNFHS/
        X+/hHMvac5A06NruPkcasSHoDupRKl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650907041;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTyPo0o1BrnaKlUX9/OqpKRiP/5+6zAonj6JDSCFAfk=;
        b=omQgw6ysr7B3ydRAiLPl2xgi/ceDskNFw18sHWWdfp9TZiAG50zyMTa/aH3PuNBxmD0Jm0
        27QYbN8P0u9TYsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF21713AED;
        Mon, 25 Apr 2022 17:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h27tLKDXZmItbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 17:17:20 +0000
Date:   Mon, 25 Apr 2022 19:13:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix a wrong return value for
 write_and_map_eb()
Message-ID: <20220425171312.GT18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <d3d68b4a612208acf1624238d11a3cf414f65ace.1650246860.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d68b4a612208acf1624238d11a3cf414f65ace.1650246860.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 09:54:24AM +0800, Qu Wenruo wrote:
> [BUG]
> With commit "btrfs-progs: use write_data_to_disk() to replace
> write_extent_to_disk()", "mkfs.btrfs -m raid5" will always fail:
> 
>  kernel-shared/transaction.c:155: __commit_transaction: BUG_ON `ret` triggered, value 65536
>  ./mkfs.btrfs(+0x57dd2)[0x557e610addd2]
>  ./mkfs.btrfs(+0x57e70)[0x557e610ade70]
>  ./mkfs.btrfs(__commit_transaction+0x139)[0x557e610ae4d4]
>  ./mkfs.btrfs(btrfs_commit_transaction+0x214)[0x557e610ae746]
>  ./mkfs.btrfs(main+0x19d9)[0x557e61066d34]
>  /usr/lib/libc.so.6(+0x2d310)[0x7f2bf222d310]
>  /usr/lib/libc.so.6(__libc_start_main+0x81)[0x7f2bf222d3c1]
>  ./mkfs.btrfs(_start+0x25)[0x557e61062925]
>  Aborted (core dumped)
> 
> [CAUSE]
> Commit "btrfs-progs: use write_data_to_disk() to replace
> write_extent_to_disk()" refactor write_and_map_eb() very slightly, but
> it changed the return value on successful writeback for RAID56.
> 
> Previously we return 0, but now we return the stripe length, causing
> btrfs_commit_transaction() to freak out.
> 
> [FIX]
> Fix it by just reseting ret to 0 if nothing wrong happened for RAID56.
> 
> Please fold this fix into commit "btrfs-progs: use write_data_to_disk()
> to replace write_extent_to_disk()".

Now folded and the original series with raid56 repair added to devel
again, thanks.
