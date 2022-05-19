Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899852D9EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiESQMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiESQMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 12:12:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F0C9EC7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 09:12:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87F1B21B40;
        Thu, 19 May 2022 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652976728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FbquoDNk8gOLgzEiCQTAfmx6tU3oqeIpPneQw9cKpZM=;
        b=nQewjpIMkm13YugMjBcIeAdfTMmSueEyx1jNtEpeWi62ff0BpIgYFTePsvMZ3yg3GE3c+d
        zJc2rP79SxZpOFAyYM80Y9uvCcFwVLZomjZ74fmObOxSrO3A2ekWqt4AxSF+eaDSXNb8Tt
        BL93Ba9Bcc2yeYg3i3dECUA+gTQL+Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652976728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FbquoDNk8gOLgzEiCQTAfmx6tU3oqeIpPneQw9cKpZM=;
        b=ELJytvpRwjJ/tlWkEHQQ8eb3/DEE4nL42xTyPi7aA404vEYHdHYZBICU99JX8SSvQsLuke
        9cAMjtwr4B/J39Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47A7813AF8;
        Thu, 19 May 2022 16:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xrlrEFhshmJcdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 May 2022 16:12:08 +0000
Date:   Thu, 19 May 2022 18:07:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Message-ID: <20220519160748.GM18596@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
 <20220518210003.GK18596@twin.jikos.cz>
 <YoVyXsuWEOX6dtXE@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVyXsuWEOX6dtXE@relinquished.localdomain>
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

On Wed, May 18, 2022 at 03:25:34PM -0700, Omar Sandoval wrote:
> On Wed, May 18, 2022 at 11:00:03PM +0200, David Sterba wrote:
> > On Mon, Apr 04, 2022 at 10:29:05AM -0700, Omar Sandoval wrote:
> > > @@ -80,16 +84,20 @@ enum btrfs_send_cmd {
> > >  	BTRFS_SEND_C_MAX_V1 = 22,
> > >  
> > >  	/* Version 2 */
> > > -	BTRFS_SEND_C_MAX_V2 = 22,
> > > +	BTRFS_SEND_C_FALLOCATE = 23,
> > > +	BTRFS_SEND_C_SETFLAGS = 24,
> > 
> > Do you have patches that implement the fallocate modes and setflags? I
> > don't see it in this patchset.
> 
> Nope, as discussed before, in order to keep the patch series managable,
> this series adds the definitions and receive support for fallocate and
> setflags, but leaves the send side to be implemented at a later time.
> 
> I implemented fallocate for send back in 2019:
> https://github.com/osandov/linux/commits/btrfs-send-v2. It passed some
> basic testing back then, but it'd need a big rebase and more testing.

The patches in the branch are partially cleanups and preparatory work,
so at least avoiding sending the holes would be nice to have for v2 as
it was one of the first bugs reported. The falllocate modes seem to be
easy. The rest is about the versioning infrastructure that we already
have merged.

> > The setflags should be switched to
> > something closer to the recent refactoring that unifies all the
> > flags/attrs to fileattr. I have a prototype patch for that, comparing
> > the inode flags in the same way as file mode, the tricky part is on the
> > receive side how to apply them correctly. On the sending side it's
> > simple though.
> 
> The way this series documents (and implements in receive)
> BTRFS_SEND_C_SETFLAGS is that it's a simple call to FS_IOC_SETFLAGS with
> given flags. I don't think this is affected by the change to fileattr,
> unless I'm misunderstanding.

The SETFLAGS ioctls are obsolete and I don't want to make them part of
the protocol defition because the bit namespace contains flags we don't
have implemented or are not releated to anything in btrfs.

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/fs.h#L220

It's basically just naming and specifying what exactly is the value so
we should pick the most recent interface name that superseded SETFLAGS
and the XFLAGS.

> This is in line with the other commands being straightforward system
> calls, but it does mean that the sending side has to deal with the
> complexities of an immutable or append-only file being modified between
> incremental sends (by temporarily clearing the flag), and of inherited
> flags (e.g., a COW file inside of a NOCOW directory).

Yeah the receiving side needs to understand the constraints of the
flags, it has only the information about the final state and not the
order in which the flags get applied.

> I suppose it'd
> also be possible to have SETFLAGS define the final flags and leave it up
> to receive to make that happen by temporarily setting/clearing flags as
> necessary, but that is a bit inconsistent with how we've handled other
> commands.

I'm not sure we can always stick to 1:1 mapping to syscalls or ioctls,
of course it's the best option, but the protocol can transfer eg.
more complete information and it's up to the receiving side to apply it
(like if a file has NODATASUM flag set).

From the other side there are multiple actions for something that could
be just one, like creating file first as an orphan and then renaming it.
So I'd like to look at it from the protocol perspective and not
necessarily blindly copy the OS interfaces.
