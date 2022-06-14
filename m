Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2154B2B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFNOAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFNOAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 10:00:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15033E94
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 07:00:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 926D321B21;
        Tue, 14 Jun 2022 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655215242;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVXjMz3UxTg6WX4Xnuy+Hc54j0GDGYOU/FB605MVAPI=;
        b=vOtYMYD5muIr+RLXJaHmTt7wGkXFzrlbbQeMVj5T0LZb7XnbSrgrKUeiW5aLCO90Wetu9e
        lRYXn8wYRa9fWjLQMmtt4wrukBJYkS8MyWBSY6VN7flTET9uPG78as0glb3WNdBOM1Mbu2
        sQoVVZNluX0wni+9K44kL71VQ9seI3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655215242;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVXjMz3UxTg6WX4Xnuy+Hc54j0GDGYOU/FB605MVAPI=;
        b=QqaCxp3a8ffodJ1sHjTE+DtS9AYVvKD0uheLhxPe5/2Z9hILFbcBvtl8HTUEac2sHqR0rD
        YhAOo3SCjHPtvnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A9E4139EC;
        Tue, 14 Jun 2022 14:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5JkkGYqUqGLmOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Jun 2022 14:00:42 +0000
Date:   Tue, 14 Jun 2022 15:56:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: cleanup related to the 1MiB reserved space
Message-ID: <20220614135609.GK20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <20220613182034.GC20633@twin.jikos.cz>
 <0441092d-db6d-000a-8652-026720bbb931@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0441092d-db6d-000a-8652-026720bbb931@gmx.com>
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

On Tue, Jun 14, 2022 at 07:50:25AM +0800, Qu Wenruo wrote:
> My bad, kernel part is indeed doing the reservation from the very beginning.
> 
> >
> >> But there are two small nitpicks:
> >>
> >> - Kernel never has a unified MACRO for this
> >>    We just use SZ_1M, with extra comments on this.
> >>
> >>    This makes later write-intent bitmap harder to implement, as the
> >>    incoming write-intent bitmap will enlarge the reserved space to
> >>    2MiB, and use the extra 1MiB for write-intent bitmap.
> >>    (of course with extra RO compat flags)
> >>
> >>    This will be addressed in the first patch, with a new
> >>    BTRFS_DEFAULT_RESERVED macro.
> >
> > Cleaning up the raw 1M value and the comments makes sense, but I'm not
> > sure about making it dynamic. We used to have mount option and mkfs
> > parameter alloc_offset and it got removed.
> 
> The dynamic part will be done at mkfs time, and will introduce new RO
> compat flags for it.
> 
> So no mount option to change that.
> 
> >
> >>    Later write-intent bitmap code will use BTRFS_DEFAULT_RESERVED as a
> >>    beacon to ensure btrfs never touches the enlarged reserved space.
> >
> > Ok, I'll wait with further comments until I see the patches.
> 
> So do I need to include those two patches in the incoming write-intent
> series?

For the preview series yes, so it can be applied and tested. The
preparatory work or cleanups do not need to be perfect or finalized for
that reason (though we might want to take them independently).

You've sent several series tackling the raid56 problems but we don't
have the final solution yet, so you don't need to spend too much time on
the less important bits.

The ro-compat bit can be a new one or we can reuse the raid56 incompat
bit that's currently not used for anything, but I can't say which way to
go until I see the patches.
