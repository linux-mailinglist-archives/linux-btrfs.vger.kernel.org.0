Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA87E1CE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 10:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKFJEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJEB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 04:04:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12924AF;
        Mon,  6 Nov 2023 01:03:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A93321846;
        Mon,  6 Nov 2023 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699261436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+LnALA1bH7I7XhoW/fW8HToug50/WbBtjw2JR5AvvM=;
        b=Oxuy7cDnRzDecphg4+i9Hj8gMZguuybtn7luJGThg1NlTuXoCX35UoecIigStZ4JmDnojc
        ZbXiTNbbc0CKCrAv8hScwfdlJZf9tcjuCk41KkgFECMtAQ1iHnbtaBunQdIOgiRF/6Pffs
        BWkpDAKqdHNXFRDzgw2sR+xFurUa44U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699261436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+LnALA1bH7I7XhoW/fW8HToug50/WbBtjw2JR5AvvM=;
        b=dfxY1WdG2VXN6/11Ek59g/bEVYmP5DZrr1OmwHF/aXJ1+Ysz1VMvvHT34ozxetrC3Osq71
        WHEf+oUjD4N9y+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C7BB138E5;
        Mon,  6 Nov 2023 09:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M6vTCvyrSGVcagAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 06 Nov 2023 09:03:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8522EA07BE; Mon,  6 Nov 2023 10:03:55 +0100 (CET)
Date:   Mon, 6 Nov 2023 10:03:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106090355.2awzqis2buil4blx@quack3>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 03-11-23 16:47:02, Christian Brauner wrote:
> On Fri, Nov 03, 2023 at 07:28:42AM -0700, Christoph Hellwig wrote:
> > On Thu, Nov 02, 2023 at 12:07:47PM +0100, Christian Brauner wrote:
> > > But at that point we really need to ask if it makes sense to use
> > > vfsmounts per subvolume in the first place:
> > > 
> > > (1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
> > > (2) By calling ->getattr() from show_mountinfo() we open the whole
> > >     system up to deadlocks.
> > > (3) We change btrfs semantics drastically to the point where they need a
> > >     new mount, module, or Kconfig option.
> > > (4) We make (initial) lookup on btrfs subvolumes more heavyweight
> > >     because you need to create a mount for the subvolume.
> > > 
> > > So right now, I don't see how we can make this work even if the concept
> > > doesn't seem necessarily wrong.
> > 
> > How else do you want to solve it?  Crossing a mount point is the
> > only legitimate boundary for changing st_dev and having a new inode
> > number space.  And we can't fix that retroactively.
> 
> I think the idea of using vfsmounts for this makes some sense if the
> goal is to retroactively justify and accommodate the idea that a
> subvolume is to be treated as equivalent to a separate device.
> 
> I question that premise though. I think marking them with separate
> device numbers is bringing us nothing but pain at this point and this
> solution is basically bending the vfs to make that work somehow.
> 
> And the worst thing is that I think that treating subvolumes like
> vfsmounts will hurt vfsmounts more than it will hurt subvolumes.
> 
> Right now all that vfsmounts technically are is a topological
> abstraction on top of filesystem objects such as files, directories,
> sockets, even devices that are exposed as filesystems objects. None of
> them get to muck with core properties of what a vfsmount is though.
> 
> Additionally, vfsmount are tied to a superblock and share the device
> numbers with the superblock they belong to.
> 
> If we make subvolumes and vfsmounts equivalent we break both properties.
> And I think that's wrong or at least really ugly.
> 
> And I already see that the suggested workaround for (2) will somehow end
> up being stashing device numbers in struct mount or struct vfsmount so
> we can show it in mountinfo and if that's the case I want to express a
> proactive nak for that solution.
> 
> The way I see it is that a subvolume at the end is nothing but a
> subclass of directories a special one but whatever.

As far as I understand the problem, subvolumes indeed seem closer to
special directories than anything else. They slightly resemble what ext4 &
xfs implement with project quotas (were each inode can have additional
recursively inherited "project id"). What breaks this "special directory"
kind of view for btrfs is that subvolumes have overlapping inode numbers.
Since we don't seem to have a way of getting out of the current situation
in a "seamless" way anyway, I wonder if implementing a btrfs feature to
provide unique inode numbers across all subvolumes would not be the
cleanest way out...

> I would feel much more comfortable if the two filesystems that expose
> these objects give us something like STATX_SUBVOLUME that userspace can
> raise in the request mask of statx().
> 
> If userspace requests STATX_SUBVOLUME in the request mask, the two
> filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> return the _real_ device number of the superblock and stop exposing that
> made up device number.
> 
> This can be accompanied by a vfs ioctl that is identical for both btrfs
> and bcachefs and returns $whatever unique property to mark the inode
> space of the subvolume.
> 
> And then we leave innocent vfs objects alone and we also avoid
> bringing in all that heavy vfsmount machinery on top of subvolumes.

Well, but this requires application knowledge of a new type of object - a
subvolume. So you'd have to teach all applications that try to identify
whether two "filenames" point to the same object or not about this and that
seems like a neverending story. Hence either we will live with fake devices
on btrfs forever or we need to find some other solution to "inode numbers
across subvolumes overlap" problem within "standard unix" APIs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
