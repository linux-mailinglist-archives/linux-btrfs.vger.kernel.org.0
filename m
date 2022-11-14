Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762DD628A85
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiKNUeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiKNUeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 15:34:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E16C299
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 12:33:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8841D202CF;
        Mon, 14 Nov 2022 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668458037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQZRMHHKNb2fhqZwRW032zv6oc8gpP6BwiB85vsWWiE=;
        b=24XvEzisuoT6Xulk2ibP/K5e1sNGsrdSEo/ifXwbi1bO6WvZrWVEq5F5Q8oSZxY12AfI20
        3ewhPaGloP8I0n/IggdEF7fvDKez3XlVknzhR+kWjt9r8lXRRQcY1Tq3jPQyNshKlPNtOD
        st/6q7qRYK5o1B+T1GCdAzOstyPM614=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668458037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQZRMHHKNb2fhqZwRW032zv6oc8gpP6BwiB85vsWWiE=;
        b=LOkYG3t5BSvT+dgqXJnZx8d8GESBXpwXERaQnVS7wA8LMAjRBfEZheuFQoQFZVpFgNl+/B
        AHRAXSY1y7sPZsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65DF313A92;
        Mon, 14 Nov 2022 20:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ax6pFzWmcmOHNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 20:33:57 +0000
Date:   Mon, 14 Nov 2022 21:33:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: option to mount read-only subvolume with read-write access
Message-ID: <20221114203331.GZ5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <G1N4LR.84UPK81F80SK3@ericlevy.name>
 <20221110121249.GE5824@twin.jikos.cz>
 <X4X4LR.21Q66E3SQOHF@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X4X4LR.21Q66E3SQOHF@ericlevy.name>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 08:50:57AM -0500, Eric Levy wrote:
> > So that would be a silent change in the subvolume and not detectable 
> > by
> > eg. checking the generation. That would break incremental send at 
> > least
> > and goes against the point of read-only subvolume.
> 
> > Yeah but the other mount points would see the old data, depending on 
> > the
> > cached status of the blocks.
> 
> Perhaps a different feature would be needed, then, of a new property 
> that makes a subvolume appear as read-only, at least from the 
> standpoint of the VFS, when accessed through a mount point higher on 
> the file tree, but not when mounted directly.
> 
> >> I think it does not have a well defined semantics, what you ask 
> >> seems to
> > be some kind of multi headed subvolume that could appear different
> > depending on the way it's accessed from the VFS mount point which is 
> > out
> > of reach in many cases.
> 
> I'm not sure whether this means the same as I just wrote, or not.
> 
> > I'd probably need to understand what you mean in the first sentence 
> > "At
> > times it is helpful", I don't have an idea where it would be helpful.
> 
> In some scenarios, upcoming changes to a file tree, intended to become 
> the default mounts in future boot sessions, will be staged in a closed 
> environment, which may include use of "chroot". It is helpful for the 
> subvolume to be read-write in the environment created by temporary 
> mount points, but still protected from accidental modification through 
> its physical location on the root tree.

This sounds like the transaction update that is in openSUSE,
https://github.com/openSUSE/transactional-update . The difference is
that you would like it to work on the same subvolume and that all the
work is done on the filesystem level, not completely managed by
userspace utilities.
