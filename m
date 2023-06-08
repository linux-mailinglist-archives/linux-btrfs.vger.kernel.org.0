Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118C727F94
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjFHMCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjFHMCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 08:02:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4242132
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 05:02:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D40171FDCC;
        Thu,  8 Jun 2023 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686225753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5PgCuaSR3aPFaMXdbUedCL70+6AD+7uFsXdQiGbWjU=;
        b=eUyhDNxdzxow9hm/fiDMr31I00LL/+ZrDY/UjIt0D0zLrPaSm8+8L4Z7gyXXNGQcxUdSJn
        qYqpNFnUnwjdUrhpYRWpOIqF6asUVSQ6QjKHJN/z3ltbJ3fiKfRr0IfF9MLMuUQjsSSuZb
        fZrup0EfhullnhAiQV6KtNbUy4izAqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686225753;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5PgCuaSR3aPFaMXdbUedCL70+6AD+7uFsXdQiGbWjU=;
        b=EK2EEGO3tFqErc2t4OyvXcoBAkgTN8mbi2XqMP/VWSQhqp6jSak1KNG2GwvQ6TIV3i75E0
        BfnPtOqd0xok3uBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD230138E6;
        Thu,  8 Jun 2023 12:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xA7sKFnDgWRWNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 12:02:33 +0000
Date:   Thu, 8 Jun 2023 13:56:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: respect the read-only flag during repair
Message-ID: <20230608115617.GC28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85514d999fd01d20cbabed1b346f58f0fb6f7063.1686017100.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85514d999fd01d20cbabed1b346f58f0fb6f7063.1686017100.git.wqu@suse.com>
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

On Tue, Jun 06, 2023 at 10:05:04AM +0800, Qu Wenruo wrote:
> [BUG]
> With recent scrub rework, the scrub operation no longer respects the
> read-only flag passed by "-r" option of "btrfs scrub start" command.
> 
>  # mkfs.btrfs -f -d raid1 $dev1 $dev2
>  # mount $dev1 $mnt
>  # xfs_io -f -d -c "pwrite -b 128K -S 0xaa 0 128k" $mnt/file
>  # sync
>  # xfs_io -c "pwrite -S 0xff $phy1 64k" $dev1
>  # xfs_io -c "pwrite -S 0xff $((phy2 + 65536)) 64k" $dev2
>  # mount $dev1 $mnt -o ro
>  # btrfs scrub start -BrRd $mnt
>  Scrub device $dev1 (id 1) done
>  Scrub started:    Tue Jun  6 09:59:14 2023
>  Status:           finished
>  Duration:         0:00:00
> 	[...]
>  	corrected_errors: 16 <<< Still has corrupted sectors
>  	last_physical: 1372585984
> 
>  Scrub device $dev2 (id 2) done
>  Scrub started:    Tue Jun  6 09:59:14 2023
>  Status:           finished
>  Duration:         0:00:00
> 	[...]
>  	corrected_errors: 16 <<< Still has corrupted sectors
>  	last_physical: 1351614464
> 
>  # btrfs scrub start -BrRd $mnt
>  Scrub device $dev1 (id 1) done
>  Scrub started:    Tue Jun  6 10:00:17 2023
>  Status:           finished
>  Duration:         0:00:00
> 	[...]
>  	corrected_errors: 0 <<< No more errors
>  	last_physical: 1372585984
> 
>  Scrub device $dev2 (id 2) done
> 	[...]
>  	corrected_errors: 0 <<< No more errors
>  	last_physical: 1372585984
> 
> [CAUSE]
> In the newly reworked scrub code, repair is always submitted no matter
> if we're doing a read-only scrub.
> 
> [FIX]
> Fix it by skipping the write submission if the scrub is a read-only one.
> 
> Unfortunately for the report part, even for a read-only scrub we will
> still report it as corrected errors, as we know it's repairable, even we
> won't really submit the write.

We can maybe present the results in scrub status in an different way
when it's started as read-only, e.g. not to say "repaired" but
"repairable (read-only)".

> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
