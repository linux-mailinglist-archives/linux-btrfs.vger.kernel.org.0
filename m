Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7547C8D5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJMS5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMS5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 14:57:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC883
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 11:57:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D03A4219FF;
        Fri, 13 Oct 2023 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697223431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI8rph3VQ/DDtNqS9N2xTVx8/z/QI7RLDqM6v1JtiBE=;
        b=r1MAfLCfugsTKUFU7+f8vfUOjHm/EsJDVh/4/P6vs3oie7udbLdPm3iBsoUBjv3cAa084k
        lrIEBvOoJUNKu/W7f++w4T+5ni8wd4csxc4Em4GVV+o2t+METQ9c1S4ZjaeFEaYPMRyRQ+
        FmdVyiHqwQQ9+qzOovwlJfqTKdrMhoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697223431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI8rph3VQ/DDtNqS9N2xTVx8/z/QI7RLDqM6v1JtiBE=;
        b=ijleEP4t/FJub7TjauPgqRaZkp1juUhsYTtOiACkVIJfrAfMZgOlxCfxWjPNyWNLQ7EQBC
        pMWeDWAqt65tPFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD7DC1358F;
        Fri, 13 Oct 2023 18:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wHxIKQeTKWVxKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 18:57:11 +0000
Date:   Fri, 13 Oct 2023 20:50:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
Message-ID: <20231013185023.GV2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693900169.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[20.95%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 05, 2023 at 03:51:42PM +0800, Qu Wenruo wrote:
> This is the first step to convert btrfstune functionality to "btrfs
> tune" subcommand group.
> 
> For now only binary features, aka set and clear, is supported,
> thus uuid and csum change is not yet implemented.
> (Both need their own subcommand groups other than set/clear groups)

There are the easy on/off features that can be added first but you also
added the block-group-tree _conversion_. That's a different category and
IMHO requires a separate command so we can add options to check or reset
the unfinished state. And we also have the the conversion 'to' and
'from'.

My current list of 1st level command groups is:

- enable - for the simple on/off features (on)
- disable - dtto, (off)
- convert-to - for the BGT, checksum
- convert-from - subset where the back conversion like BGT may make sense
- analyze - go through the structures and identify features (all, subset)

We can add aliases like set for enable and clear for disable, the two
conversion commands may not be necessary or even confusing when it's not
clear which direction is the right one.

Actions:

- extref (on/off)
- skinny-metadata (on/off)
- no-holes (on)
- seeding (on/off)
- uuid rewrite (one time)
- metadata_uuid (set value)
- change checksum (convert-to)
- currently there's the simple quota, this may change

This should give examples of all categories of actions we might have in
the future.

> And even for set/clear, there is some changes to btrfstune:
> 
> - Merge seed feature into set/clear
>   To enable seeding, just go "btrfs tune set seed <device>".
> 
> - All supported features can be checked by "list-all" feature
>   Please note that, "btrfs tune set list-all" and
>   "btrfs tune clear list-all" will have different output.

As the help test works, we would get that for free if all the
implemented actions are also command names, i.e. 'btrfs tune convert-to'
would list 'block-group-tree'.
