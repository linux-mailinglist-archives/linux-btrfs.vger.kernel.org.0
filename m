Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED152AAA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbiEQSW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 14:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiEQSWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 14:22:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCE49F91
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 11:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A9AB21C44;
        Tue, 17 May 2022 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652811755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwdNGsYumWeymI6N8o4ECYmXx6NVJrpLop8eEy0Jp+U=;
        b=K+BbAsKQdFkdfVZxdY2OXnuv69W3GyDoLlkaEQL6BsEvMBRXXrYqW2b5LvHFTKuVwoPuKd
        L3B/7NZ8v2Cs54kduV8tD18kwNydKeIpoSRhUr/PfqNSwsPChpt+9S8lISb0ePeTTYxj2Q
        ssvc3cceTpp+NuvyFkELQijp19pWdS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652811755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwdNGsYumWeymI6N8o4ECYmXx6NVJrpLop8eEy0Jp+U=;
        b=6bGVxUkvwXMq7HoqHgGmWL7STh0knkBlPY0h6VvZ1DuZLKLjNhYru0Lvb8tOo0YJdepQs5
        hFycThAA1BPbKlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4D413AA2;
        Tue, 17 May 2022 18:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B5qGHevng2LTPwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 18:22:35 +0000
Date:   Tue, 17 May 2022 20:18:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: teach send to avoid trashing the page
 cache with data
Message-ID: <20220517181817.GE18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1651770555.git.fdmanana@suse.com>
 <cover.1652784088.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652784088.git.fdmanana@suse.com>
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

On Tue, May 17, 2022 at 11:47:28AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a send operation, we read the data of all extents we need to
> send into the page cache, which almost always is wasteful as it can lead
> to eviction of other things from the page cache that are more useful for
> applications (and maybe other kernel subsystems). This patchset makes send
> evict the data from the page cache once it has sent it. The actual work
> is in the second patch, while the first one is just preparatory work.
> More details in the changelogs.
> 
> V2: Fixed it to work with subpage sector size. It was broken as we could
>     end up zeroing out part of a page when extents are not sector size
>     aligned. Reported by Qu.
> 
> Filipe Manana (2):
>   btrfs: send: keep the current inode open while processing it
>   btrfs: send: avoid trashing the page cache

Patch 1 is the same so I kept the committed version and 2 has been
replaced, still queued for first 5.19 pull as it's fixing a problem
that hampers testing. Thanks.
