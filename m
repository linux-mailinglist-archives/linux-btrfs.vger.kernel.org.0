Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26950E5EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiDYQg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiDYQg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 12:36:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3EDE09D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 09:33:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99CC4210E4;
        Mon, 25 Apr 2022 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650904400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPSx54+xM5bs/FUwkK0wKpRg5c2Tqqc3cFjpILoQJdg=;
        b=E2V1np6pYnoEyLeFWQdV72zJ2E3iT80CBQ8qSq3qVZ1/xjwIH1dVK67GtU5QItPQjRvoBy
        ObogvNS42frCqseZlZiy4PhY+qQiFY1sZSTIe31cZsKte9GC94/FOEPzTc8P4AgbGdG1N9
        6wQTLIAUijJhFFBIqH8ep8EIdS7TbqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650904400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPSx54+xM5bs/FUwkK0wKpRg5c2Tqqc3cFjpILoQJdg=;
        b=HxoUVtMTLgxIL9GE983RPc3U/tJcm/Dr5XbrUvVuDpr0Bau1BXFr2jaVEFnIg4wfS47gk9
        cBxEOeAJElygPVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B87813AE1;
        Mon, 25 Apr 2022 16:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a7wnHVDNZmLiWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 16:33:20 +0000
Date:   Mon, 25 Apr 2022 18:29:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs-progs: add RAID56 rebuild ability at read time
Message-ID: <20220425162913.GP18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649162174.git.wqu@suse.com>
 <20220411150149.GP15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411150149.GP15609@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 11, 2022 at 05:01:49PM +0200, David Sterba wrote:
> On Tue, Apr 05, 2022 at 08:48:22PM +0800, Qu Wenruo wrote:
> > This branch can be fetched from github:
> > https://github.com/adam900710/btrfs-progs/tree/raid56_rebuild
> 
> The mkfs tests fail in 001 with the following last command:
> 
> ====== RUN CHECK root_helper .../mkfs.btrfs -f -d raid5 -m raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
> WARNING: RAID5/6 support has known problems is strongly discouraged
>          to be used besides testing or evaluation.
> 
> kernel-shared/transaction.c:155: __commit_transaction: BUG_ON `ret` triggered, value 65536
> .../mkfs.btrfs(__commit_transaction+0x197)[0x43a107]
> /...mkfs.btrfs(btrfs_commit_transaction+0x13b)[0x43a26b]
> /...mkfs.btrfs(main+0x174b)[0x40f68d]
> /lib64/libc.so.6(+0x2d540)[0x7f969b5ea540]
> /lib64/libc.so.6(__libc_start_main+0x7c)[0x7f969b5ea5ec]
> /...mkfs.btrfs(_start+0x25)[0x40d965]
> /...tests/common: line 540: 29172 Aborted                 sudo -n "$@"
> failed: root_helper .../mkfs.btrfs -f -d raid5 -m raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
> test failed for case 001-basic-profiles

It's caused by patch [PATCH 4/8] btrfs-progs: use write_data_to_disk()
to replace write_extent_to_disk()
