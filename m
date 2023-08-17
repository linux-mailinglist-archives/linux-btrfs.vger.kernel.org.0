Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138BD77FEA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 21:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352703AbjHQTlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 15:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354756AbjHQTlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 15:41:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381210E9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 12:41:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC34E21833;
        Thu, 17 Aug 2023 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692301270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGtGI+dCsrKDK/qBKG8REnGJ67btRdzPK+xwLESIbDI=;
        b=UkvAShKR9dz0bKViSk5hVPHAaBNFJ4Gv3xkOGRVDKstYegLVnXHbXdi7X53vP39Pgsl9rZ
        pODBJzFGy+p+Y0Bmc0EItMssCKQOSIvZn8aXRv1gjRTbFwAD/lBuPLn88qfy5J8f8QR+PQ
        U6PheHh++7hjMdGV2APn4UEagziuCTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692301270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGtGI+dCsrKDK/qBKG8REnGJ67btRdzPK+xwLESIbDI=;
        b=nCE41+b1b+RMjycW3B/lLiKxaL5IF6VEczF+OUJJ9EQIH4CKOa5vn6nCNFJ1cB3goIC3Qu
        KWFwzUJmxltbkUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B27141392B;
        Thu, 17 Aug 2023 19:41:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ytytKtZ33mRNTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 19:41:10 +0000
Date:   Thu, 17 Aug 2023 21:34:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: implement json output for subvolume
 subcommands
Message-ID: <20230817193437.GU2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 11:44:55AM +0200, Christoph Heiss wrote:
> JSON as output format is already implement for some of the commands in
> btrfs-progs, which is a very useful feature to have for e.g. scripting.
> 
> This series adds the same for `btrfs subvolume list`, `btrfs subvolume
> get-default` and `btrfs subvolume show`.
> 
> #1-#3 are some small preparatory fixes & refactors, #4 introduces the
> `struct rowspec` containing all fields needed by the series.
> 
> The actual implementation of the JSON output is mostly pretty
> straight-forward, only cmd_subvolume_show() needed some refactoring
> first.
> 
> I probably will go about implementing the same for more commands, but
> wanted to get this out now to get some feedback.

Thanks. There are a few things regarding the json output that are still
to be figured out and to set examples to follow. The plain and json
output does not match 1:1 in the printed information, here the
'top level' does not need to be in the json output or there could be
more subvolume related info in the map. The textual output is
unfortunatelly parsed by many tools nowadays so we can't change the
format. With json it's easier to filter out the interesting data so
"more is better" in this case.

The formatter is designed in a way to allow plain text and json to be
printed by the same lines of code but this is namely for line oriented
output, like 'subvolume show'.

For the 'subvolume list' this may not be that easy so two separate
printing functions make more sense, like you did it in the series. So
that's fine.

I'll put some guidelines to the documentation, the key naming must be
unified, e.g. 'gen' or 'generation' but there's also 'transid' used in
some cases etc.

As the json format is also an ABI we need to get it finalized first so
I'll merge the series but put the actual support for --json option under
experimental build.
