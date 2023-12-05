Return-Path: <linux-btrfs+bounces-667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F56805C9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8AD1F21463
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03C56A346;
	Tue,  5 Dec 2023 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tTQfV1lp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2kwmx5b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38B5122
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 09:51:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12E7922052;
	Tue,  5 Dec 2023 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701798693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T25MIfHRhqvOhPKb5xsXr8mYwY74lAmOJaiHP2tT+7M=;
	b=tTQfV1lppLznd63Jl9wk7Jum0xkKNg5wIoSw0oDU5ZF2jW7Dv/pLM4SLBo4UBbAXbXQZkT
	CpNFDFOBFnI29isnuC2Kz1LgNC5Gs5O7AcV6wKQCYhz+A8gfMaA0p5a4TEbUMrrbsJirpQ
	UKrpKCpso69YkvPLrmW3C/6ndeigRbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701798693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T25MIfHRhqvOhPKb5xsXr8mYwY74lAmOJaiHP2tT+7M=;
	b=J2kwmx5bZrrOG6f5BZH/aR0s/K0untW+DhfN/IDpj0ex+cFB/eco7vXSLpxSrG9utk43RM
	Q6LMbjFdq+RVp6DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E810213924;
	Tue,  5 Dec 2023 17:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 78wrOCRjb2UGSgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 17:51:32 +0000
Date: Tue, 5 Dec 2023 18:44:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Goffredo Baroncelli <kreijack@inwind.it>
Cc: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Message-ID: <20231205174443.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
 <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
 <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
 <183599a4-392d-443d-b914-7ac830b3c2d7@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <183599a4-392d-443d-b914-7ac830b3c2d7@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.987];
	 FREEMAIL_TO(0.00)[inwind.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On Wed, Nov 29, 2023 at 09:54:02PM +0100, Goffredo Baroncelli wrote:
> On 29/11/2023 00.28, Anand Jain wrote:
> > 
> > 
> > On 28/11/2023 16:00, Goffredo Baroncelli wrote:
> >> On 27/11/2023 12.48, Anand Jain wrote:
> >>>
> >>>
> >>> On 11/25/23 09:09, Anand Jain wrote:
> >> [...]
> >>>> I am skeptical about whether we have a strong case to create a single
> >>>> pseudo device per multi-device Btrfs filesystem, such as, for example
> >>>> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
> >>>> will carry the btrfs-magic and the actual blk devices something else.
> >>>>
> >>>> OR for now, regarding the umount issue mentioned above, we just can
> >>>> document it for the users to be aware of.
> >>>>
> >>>> Any feedback is greatly appreciated.
> >>>>
> >>>
> >>> How about if we display the devices list in the options, so that
> >>> user-land libs have something in the mount-table that tells all
> >>> the devices part of the fsid?
> >>>
> >>> For example:
> >>> $ cat /proc/self/mounts | grep btrfs
> >>>
> >>> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3  0 0
> >>>
> >>
> >> When I developed code to find a btrfs mount point from a disk, I had to
> >> consider all the devices involved and check if one is in /proc/self/mounts.
> >>
> >> Putting the devices list as device=<xxx>,device=<yyy> doesn't change anything because
> >> the code has to manage a btrfs filesistem as "special" in any case.
> >> To get the map <btrfs-uuid> <-> <devices-list> I used libblkid.
> [...]
> > 
> > Regarding libblkid for Btrfs device discovery, I m little confused what are you referring to, an example would be helpful.
> 
> I developed a little utility to build for each btrfs filesystem:
> - all the devices involved
> - all the mountpoint (if any) where the filesystem is mounted and the subvolume used as root.
> 
> It was nice because it got all these information only using:
> - libblkid
> - parsing /proc/self/mountinfo

I think if there's one consistent approach based on libblkid then all
the related tools and projects can use that.

