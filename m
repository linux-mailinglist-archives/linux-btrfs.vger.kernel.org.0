Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C668C612
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 19:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBFSqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFSqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 13:46:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A18270E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 10:46:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C38103F7A1;
        Mon,  6 Feb 2023 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675709192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CmuLdQv5qvD7Bqho96c00uPJKdpRdLwtg73zssY3pc=;
        b=HyuCQNCYlAAgeO6uyDYqvMXOvgzCDG086CqhhIJiTqwG5tXGPAKVaGY9yG3g0v4pZVSW1T
        vpzHTRlLjX+QBu5auLzDtYaOvhRnGggrI9oUHYPUtzoq68w8LFgXwGoypxb9W1C5HAn3fC
        ehN0m/e219BaAzGuqpLOd7kUOOKdNAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675709192;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CmuLdQv5qvD7Bqho96c00uPJKdpRdLwtg73zssY3pc=;
        b=6Gh/6CjcdmFFxSiD8EPA9zfKRxSKZdDIuhGU0xzloCtE/In3EFdsZKnXj7O3g9sxqldY+J
        SfxCnef5cz+uGKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94B1E138E7;
        Mon,  6 Feb 2023 18:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0P5aIwhL4WO9TwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Feb 2023 18:46:32 +0000
Date:   Mon, 6 Feb 2023 19:40:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6/8] btrfs: simplify update of last_dir_index_offset when
 logging a directory
Message-ID: <20230206184044.GD28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1673361215.git.fdmanana@suse.com>
 <ff77f41924e197d99e62ef323f03467c87ef43a0.1673361215.git.fdmanana@suse.com>
 <CAL3q7H6rUwk4XiEim6qwLZDLs2qtnZzuLWbDLUDJU361=7xRJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6rUwk4XiEim6qwLZDLs2qtnZzuLWbDLUDJU361=7xRJA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 31, 2023 at 05:42:12PM +0000, Filipe Manana wrote:
> On Tue, Jan 10, 2023 at 3:20 PM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When logging a directory, we always set the inode's last_dir_index_offset
> > to the offset of the last dir index item we found. This is using an extra
> > field in the log context structure, and it makes more sense to update it
> > only after we insert dir index items, and we could directly update the
> > inode's last_dir_index_offset field instead.
> >
> > So make this simpler by updating the inode's last_dir_index_offset only
> > when we actually insert dir index keys in the log tree, and getting rid
> > of the last_dir_item_offset field in the log context structure.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> Reported-by: David Arendt <admin@prnet.org>
> Link: https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
> Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/Y8voyTXdnPDz8xwY@mail.gmail.com/
> Reported-by: Hunter Wardlaw <wardlawhunter@gmail.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1207231
> CC: stable@vger.kernel.org # 6.1+
> 
> David, can you please add the following tags to the patch?
> It happens to fix an issue those users reported, all on 6.1 only.

Updated and added to pull request queue, thanks.
