Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D752F3D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiETTi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiETTix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 15:38:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C36A18C056
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 12:38:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDCE81FA6F;
        Fri, 20 May 2022 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653075529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PDOtjEeEMKB9NUahEoTbmLOWlKhUY4eMoWttJ3kNEWE=;
        b=aTE4T9KoB0Eu2ikK6keHp7DLJ6lsNrrGyC57HOHJ8FgcY8VNjBnV/7MKR6b6PJJrPseUIU
        UibmoZTnG2QoxwV0LZEY94stRwDzdnKr5kq1Uj2eCFQPQ39vJo5oxdRQvQKahuLtTEvQP6
        9qkvlsGiW5ya6eHuHA7+umMWQr2xn5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653075529;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PDOtjEeEMKB9NUahEoTbmLOWlKhUY4eMoWttJ3kNEWE=;
        b=UDz5dxko0sjk/U1vNbhRt7jhl9E3iHZs/yIdcJbrm/ScCjBdBJa/ndaYV3hI6jZDJ3Gjgo
        5Xq83yllGJmVjyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD11E13AF4;
        Fri, 20 May 2022 19:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FUsaLUnuh2IaZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 20 May 2022 19:38:49 +0000
Date:   Fri, 20 May 2022 21:34:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Message-ID: <20220520193429.GT18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
 <20220518210003.GK18596@twin.jikos.cz>
 <YoVyXsuWEOX6dtXE@relinquished.localdomain>
 <20220519160748.GM18596@suse.cz>
 <YobFXNs0TVBV8xCc@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YobFXNs0TVBV8xCc@relinquished.localdomain>
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

On Thu, May 19, 2022 at 03:31:56PM -0700, Omar Sandoval wrote:
> On Thu, May 19, 2022 at 06:07:49PM +0200, David Sterba wrote:
> > The SETFLAGS ioctls are obsolete and I don't want to make them part of
> > the protocol defition because the bit namespace contains flags we don't
> > have implemented or are not releated to anything in btrfs.
> > 
> > https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/fs.h#L220
> > 
> > It's basically just naming and specifying what exactly is the value so
> > we should pick the most recent interface name that superseded SETFLAGS
> > and the XFLAGS.
> 
> This is the situation with FS_IOC_SETFLAGS, FS_IOC_FSSETXATTR, and
> fileattr as I understand it. Please correct me if I'm wrong:
> 
> - FS_IOC_SETFLAGS originally came from ext4 and was added to Btrfs very
>   early on (commit 6cbff00f4632 ("Btrfs: implement
>   FS_IOC_GETFLAGS/SETFLAGS/GETVERSION")).
> - FS_IOC_FSSETXATTR originally came from XFS and was added to Btrfs a
>   few years ago (in commit 025f2121488e ("btrfs: add FS_IOC_FSSETXATTR
>   ioctl")).
> - The two ioctls allow setting some of the same flags (e.g., IMMUTABLE,
>   APPEND), but some are only supported by SETFLAGS (e.g., NOCOW) and
>   some are only supported by FSSETXATTR (none of these are supported by
>   Btrfs, however).
> - fileattr is a recent VFS interface that is used to implement those two
>   ioctls. It basically passes through the arguments for whichever ioctl
>   was called and translates the equivalent flags between the two ioctls.
>   It is not a new UAPI and doesn't have its own set of flags.
> 
> Is there another new UAPI that I'm missing that obsoletes SETFLAGS?

That was supposed to be FSSETXATTR, new flags have appeared there, the
reason for btrfs was to allow the FS_XFLAG_DAX bit as people are were
working on the DAX support, and potentially other bits like
FS_XFLAG_NOSYMLINKS or FS_XFLAG_NODEFRAG. Or new flags that we want to
be able to set, NODATASUM for example.

> I see your point about the irrelevant flags in SETFLAGS, however. Is
> your suggestion to have our own send protocol-specific set of flags that
> we translate to whatever ioctl we need to make?

Yes, that's the idea, the flags are not protocol-specific but rather
btrfs-specific, ie we want to support namely the bits that btrfs inodes
can have.

> > > This is in line with the other commands being straightforward system
> > > calls, but it does mean that the sending side has to deal with the
> > > complexities of an immutable or append-only file being modified between
> > > incremental sends (by temporarily clearing the flag), and of inherited
> > > flags (e.g., a COW file inside of a NOCOW directory).
> > 
> > Yeah the receiving side needs to understand the constraints of the
> > flags, it has only the information about the final state and not the
> > order in which the flags get applied.
> 
> If the sender only tells the receiver what the final flags are, then
> yes, the receiver would need to deal with, e.g., temporarily clearing
> and resetting flags. The way I envisioned it was that the sender would
> instead send commands for those intermediate flag operations. E.g., if
> the incremental send requires writing some data to a file that is
> immutable in both the source and the parent subvolume, the sender could
> send commands to: clear the immutable flag, write the data, set the
> immutable flag. This is a lot like the orphan renaming that you
> mentioned.

I see, so the question is where do we want to put the logic. I'd go with
userspace as lots of things are easier there, eg. maitaining some
intermediate state or delayed application of bits/flags.

> If we want to have receive handle the intermediate states instead, then
> I would like to postpone SETFLAGS (or whatever we call it) to send
> protocol v3, since it'll be very tricky to get right and we can't add it
> to the protocol without having an implementation in the receiver.

Yeah it would be tricky to generate the sequence right, while if it's on
the receiving side we can simply ignore/report it or implement a subset
where we know how to apply (eg. immutable) and don't need to postpone
it.

> On the other hand, if send takes care of the intermediate states and
> receive just has to blindly apply the flags, then we can add SETFLAGS to
> the protocol and receive now and implement it in send later. That is
> exactly what this patch series does.

It adds a command to the protocol but does not outline the plan how to
use it, not counting this discussion.

> I'm fine with either of those paths forward, but I don't want to block
> the compressed send/receive on SETFLAGS or fallocate.

I get that you care only about the encoded write, but I don't want to
rev protocol every few releases because we did not bother to implement
something we know is missing in the protocol. Anyway, encoded write will
be in v2 scheduled for 5.20 and I'll implement the rest plus will have a
look at your fallocate patches.
