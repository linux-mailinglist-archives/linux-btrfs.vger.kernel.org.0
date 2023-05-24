Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF070FB45
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEXQCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbjEXQCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 12:02:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E4199E
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 09:01:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27D7A1F892;
        Wed, 24 May 2023 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684944070;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHtkigjFUajSMUMbiRr5IQckUIL1INw5M0kQXzrqepE=;
        b=II0z+Vpgo84/Xeh7oDLc9cW82pNWC8FnnkO0f4aS0eeuj5lt5ROqHnvV3GtsriVGDToXqA
        ZR850xR6TJv9189iGtbJlxkbIq+Q2esRyNcs+d70FJ4URtaS19wciLb2nPdKVNy0sOxKUr
        acyjuXNdRKXwMZDBjo7ID5X3kKjvCSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684944070;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHtkigjFUajSMUMbiRr5IQckUIL1INw5M0kQXzrqepE=;
        b=4wEOqRIV6SPhKLaxwywusW/shaHBcTJiRT7rt526cCl+JqEraIAijFD9tcaHNKoekT/4NJ
        /+V4An/g0L0LJ4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0E8D133E6;
        Wed, 24 May 2023 16:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aUQQOsU0bmRUWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 24 May 2023 16:01:09 +0000
Date:   Wed, 24 May 2023 17:55:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: tune: add resume support for csum
 conversion
Message-ID: <20230524155502.GA30909@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684913599.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 03:41:23PM +0800, Qu Wenruo wrote:
> [RESUME SUPPORT]
> This patchset adds the resume support for "btrfstune --csum".

Great, thanks.

> The main part is in resume for data csum change, as we have 4 different
> status during data csum conversion.
> 
> Thankfully for data csum conversion, everything is protected by
> metadata COW and we can detect the current status by the existence of
> both old and new csum items, and their coverage.
> 
> For resume of metadata conversion, there is nothing we can really do but
> go through all the tree blocks and verify them against both new and old
> csum type.
> 
> [TESTING]
> For the tests, currently errors are injected after every possible
> transaction commit, and then resume from that interrupted status.
> So far the patchset passes all above tests.

So you've inserted some "if/return EINVAL", right?

> But I'm not sure what's the better way to craft the test case.
> 
> Should we go log-writes? Or use pre-built images?

Log writes maybe, the device mapper targets are already used in the test
suite. You could use your testing injection code to generate them.

But it's clear that we could generate them only once, or we'd have to
store the image generators (possible).

Alternatively, can we create some error injection framework? In the
simplest form, define injection points in the code watching for some
conndition and trigger them from outside eg. set by an environment
variable. Maybe there's something better.

> [TODO]
> - Test cases for resume
> 
> - Support for revert if errors are found
>   If we hit data csum mismatch and can not repair from any copy, then
>   we should revert back to the old csum.
> 
> - Support for pre-cautious metadata check
>   We'd better read and very metadata before rewriting them.

Read and verify? Agreed.

> - Performance tuning
>   We want to take a balance between too frequent commit transaction
>   and too large transaction.
>   This is especially true for data csum objectid change and maybe
>   old data csum deletion.
> 
> - UI enhancement
>   A btrfs-convert like UI would be better.

Yeah it's growing beyond what one simple option can handle. The separate
command group for btrfstune is in the work, so far still on the code
level, the subcommands are roughly matching the conversion features but
not yet finalized.
