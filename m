Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB447538B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjGNKsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjGNKr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:47:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866791720
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 03:47:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 413DA22113;
        Fri, 14 Jul 2023 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689331674;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhfsDU/gO7qZeNjsuIlmUPBh+kWAKJWSULLDWyo7/5Q=;
        b=lbQpaxzA4yk3qc/BSl74NotAmjhl8qoK/ZjkDGg9rAkbT7gs8cwipgQj0lhu56PKH84nZk
        lQiAoEp0iUjIgz3gNU2aCqC1O3jgfHnnR5C6J64stN1sDgURQAlxIs2YUb8lIFhN9acc15
        u+tK/IL5r+sg4TkBovoqM4gNtRdCfJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689331674;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhfsDU/gO7qZeNjsuIlmUPBh+kWAKJWSULLDWyo7/5Q=;
        b=CCwG9eexBq0FRS7fcNW2g9j13ngakmWV2hRt0lbwk/KY+u1v/b+ptF3F5PfG+JOdvlQ88R
        K6S3aN8JgGnsbNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 163B113A15;
        Fri, 14 Jul 2023 10:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V7mDBNonsWSSHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 10:47:54 +0000
Date:   Fri, 14 Jul 2023 12:41:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230714104117.GG20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <20230713120935.GU30916@twin.jikos.cz>
 <20230713163908.GW30916@twin.jikos.cz>
 <9251d155-2e2e-a126-579e-2765e98a4a9d@gmx.com>
 <20230713220311.GC20457@suse.cz>
 <6c7b397a-8552-e150-a6fd-95ae73390509@gmx.com>
 <20230714002605.GD20457@suse.cz>
 <1bab3588-9b53-c212-3b45-91ee61f5b820@gmx.com>
 <20230714100349.GF20457@suse.cz>
 <3414dd0b-7b69-28d4-28c4-3405e9b8139f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3414dd0b-7b69-28d4-28c4-3405e9b8139f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 06:32:27PM +0800, Qu Wenruo wrote:
> >> Already running the auto group with that branch, and no explosion so far
> >> (btrfs/004 failed to mount with -o atime though).
> >>
> >> Any extra setup needed to trigger the failure?
> >
> > I'm not aware of anything different than usual. Patches applied to git,
> > built, updated VM and started. I had another branch built and tested and
> > it finished the fstests. I can at least bisect which patch does it.
> 
> A bisection would be very appreciated.
> 
> Although I guess it should be the memcpy_extent_buffer() patch, I didn't
> see something obvious right now...

5ebf7593abb81ec1993f31e90a7573b75aff4db4 is the first bad commit
btrfs: refactor main loop in memcpy_extent_buffer()

$ git bisect log
# bad: [5c6c140622dd7107acb13da404f0c682f1f954a6] btrfs: copy all pages at once at the end of btrfs_clone_extent_buffer()
# good: [72c15cf7e64769ca9273a825fff8495d99975c9c] btrfs: deprecate integrity checker feature
git bisect start 'ext/qu-eb-page-clanups-updated-broken' '72c15cf7e64769ca9273a825fff8495d99975c9c'
# good: [85ab525a6a63c477b92099835d6b05eaebd4ad4b] btrfs: use write_extent_buffer() to implement write_extent_buffer_*id()
git bisect good 85ab525a6a63c477b92099835d6b05eaebd4ad4b
# bad: [cd6668ef43a224b3f8130b78f4e3b922a7175a05] btrfs: refactor main loop in copy_extent_buffer_full()
git bisect bad cd6668ef43a224b3f8130b78f4e3b922a7175a05
# bad: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: refactor main loop in memcpy_extent_buffer()
git bisect bad 5ebf7593abb81ec1993f31e90a7573b75aff4db4
# first bad commit: [5ebf7593abb81ec1993f31e90a7573b75aff4db4] btrfs: refactor main loop in memcpy_extent_buffer()
