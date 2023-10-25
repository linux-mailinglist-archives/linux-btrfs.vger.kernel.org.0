Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95137D71AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjJYQZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJYQZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 12:25:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACE92
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 09:25:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71FEC21DBD;
        Wed, 25 Oct 2023 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698251127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iK3JszagL3gOxqlIeYVxsAHCpCmFfKH+wG1tLnicyqM=;
        b=Nos+jyi+8qFzpy458WaAg5la+E8ENSBaAxzRZtLlk/OxQ6uSHxLxlM3iyAiln01l5LTcg1
        wjm1uHFPt5R2nxNawQGVHgrKTQW3mfs2ynsIPQg03wfAK8+XyYYUA9H3aHES+MtEtpziHO
        X84WXu1bUpwZIoSXZToFFsHZqEPcvVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698251127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iK3JszagL3gOxqlIeYVxsAHCpCmFfKH+wG1tLnicyqM=;
        b=i50unxSYx+/zkayhL6POfIS3tkCGP6bxIcNNtcLkL+Gu2sDK5SxmcIB+nKfa8P7MeJRxrt
        N51Am5sqp40HQcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3963713524;
        Wed, 25 Oct 2023 16:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WwZCDXdBOWWvUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 Oct 2023 16:25:27 +0000
Date:   Wed, 25 Oct 2023 18:18:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Message-ID: <20231025161832.GA21328@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz>
 <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
 <20231024173806.GR26353@suse.cz>
 <136e8bf5-3b77-4e66-be24-54cd7e14b83a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136e8bf5-3b77-4e66-be24-54cd7e14b83a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         FREEMAIL_ENVRCPT(0.00)[gmx.com];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         FREEMAIL_TO(0.00)[gmx.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 07:14:58AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/25 04:08, David Sterba wrote:
> > On Wed, Oct 18, 2023 at 10:20:57AM +1030, Qu Wenruo wrote:
> >>>>> We're moving towards a world where kernel-shared will be an exact-ish copy of
> >>>>> the kernel code.  Please put helpers like this in common/, I did this for
> >>>>> several of the extent tree related helpers we need for fsck, this is a good fit
> >>>>> for that.  Thanks,
> >>>>
> >>>> Sure, and this also reminds me to copy whatever we can from kernel.
> >>>
> >>> I do syncs from kernel before a release but all the low hanging fruit is
> >>> probably gone so it needs targeted updates.
> >>
> >> For the immediate target it's btrfs_inode and involved VFS structures
> >> for inodes/dir entries.
> >>
> >> In progs we don't have a structure to locate a unique inode (need both
> >> rootid and ino number), nor to do any path resolution.
> >>
> >> This makes it almost impossible to proper sync the code.
> >>
> >> But introduce btrfs_inode to btrfs-progs would also be a little
> >> overkilled, as we don't have that many users.
> >> (Only the new --rootdir with --subvol combination).
> >
> > I have an idea for using this functionality, but you may not like it -
> > we could implement FUSE.
> 
> In fact I really like it.
> 
> > The missing code is exactly about inodes, path
> > resolution and subvolumes. You have the other project, with a different
> > license, although there's a lot shared code. You can keep it so u-boot
> > can do the sync and keep the read-only support. I'd like to have full
> > read-write support with subvolumes and devices (if there's ioctl pass
> > through), but it's not urgent. Having the basic inode/path support would
> > be good for mkfs even in a smaller scope.
> 
> The existing blockage would be fsck.
> If we want FUSE, inode is super handy, but for fsck doing super low
> level fixes, it can be a burden instead.
> As it needs to repair INODE_REF/DIR_INDEX/DIR_ITEMs, sometimes even
> missing INODE_ITEMs, not sure how hard it would be to maintain both
> btrfs_inode and low-level code.

I'd have to look what exactly are the problems but yes check is special
in many ways. It could be possible to have an "enhanced" inode used in
check and regular inode everywhere else.

> There are one big limiting factor in FUSE, we can not control the device
> number, unlike kernel.
> This means even we implemented the subvolume code (like my btrfs-fuse
> project), there is no way to detect subvolume boundary.

This could be a problem. We can set the inode number to 256 but
comparing two random files if they're in the same subvolume would
require traversing the whole path. This would not work with 'find -xdev'
and similar.

> Then comes with some other super personal concerns:
> 
> - Can we go Rust instead of C?

I know rust on the very beginner level, and I don't think we have enough
rust knowledge in the developers group.  The language syntax or features
are still evolving, we'd lose the build support on any older distros or
distros that don't keep up with the versions. The C-rust
interoperability is good but it can become a burden. I'm peeking to the
kernel rust support from time to time and I can't comprehend what it's
doing.

> - Can we have a less restrict license to maximize the possibility of
>    code share?

The way it's now it's next to impossible. Sharing GPL code works among
GPL projects, anything else must be written from scratch. I don't know
how much you did that in the btrfs-fuse project

>    Well, I should ask this question to GRUB....
>    But a more hand-free license like MIT may really help for bootloaders.

You can keep your btrfs-fuse to be the code base with loose license for
bootloaders, but you can't copy any code.
