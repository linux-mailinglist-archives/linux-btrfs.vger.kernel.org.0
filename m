Return-Path: <linux-btrfs+bounces-7200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86936952503
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE74284E6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476C1C8FA1;
	Wed, 14 Aug 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F/u0L7NA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j37mVjxO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F/u0L7NA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j37mVjxO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595741C824C
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672633; cv=none; b=bPtEBbkvfIdeHDeY14An4r2TumkQYUPo+f391Tdpd/5z1IlULCm3kZ7QC+RLA2sdTP6KQJQGcxtyB4JpfmW2zFT0p/iVQU58N7kkDpjYhn0j0zmq/8Al9q2/HEn0mVxazPF2EngQf62nEkXJHGoLfGHh0YMBiHM5idZS559Hm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672633; c=relaxed/simple;
	bh=xI45Rn6Y2WBweCDJJNcmEQfFvtbvO0Ygun4JqHqe9zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3yE6EYb9azORkdVRLvBaQRKGHS4NoKyafxGrh1KSbsFofRZnEg6QO5372haqbawHijIYkXaLfyRPTnHW19jMhz0Oc+5zk+psXvKM1qLVinD5i3ES35U6bojOJNwHU1koVpuNCG2OgK/vV9wpggxbO5t0ogAvWL2isGT8qgfr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F/u0L7NA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j37mVjxO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F/u0L7NA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j37mVjxO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AE6E1F81C;
	Wed, 14 Aug 2024 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723672629;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7SZBKBsJLAPr6Q2bLq3SzzM24DczRySpWj726Nwq6Y=;
	b=F/u0L7NA1xpWXgocfi6v6dsxourMeJLBw7Rq7Zr3ZgI5fXHXE+9PyvcY2iwmedVKYc1aIN
	gG1Zh5NPMmt535mj/TSYGjtqb6Lg58oAFFkQd9Mx+Rodi00ORCVC9VZMBEHXMvG6Aoa6of
	8ulEwJS5UmZ2qhIouBborNSpdEYVECk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723672629;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7SZBKBsJLAPr6Q2bLq3SzzM24DczRySpWj726Nwq6Y=;
	b=j37mVjxO1E/ozzJF/BbqhYx8e0y1oMQnwzxOfWsyPdn/7uCm3ELbTuL8uJJfoBWigoPmEF
	l7QWlGEO/pOLrrCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="F/u0L7NA";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j37mVjxO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723672629;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7SZBKBsJLAPr6Q2bLq3SzzM24DczRySpWj726Nwq6Y=;
	b=F/u0L7NA1xpWXgocfi6v6dsxourMeJLBw7Rq7Zr3ZgI5fXHXE+9PyvcY2iwmedVKYc1aIN
	gG1Zh5NPMmt535mj/TSYGjtqb6Lg58oAFFkQd9Mx+Rodi00ORCVC9VZMBEHXMvG6Aoa6of
	8ulEwJS5UmZ2qhIouBborNSpdEYVECk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723672629;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7SZBKBsJLAPr6Q2bLq3SzzM24DczRySpWj726Nwq6Y=;
	b=j37mVjxO1E/ozzJF/BbqhYx8e0y1oMQnwzxOfWsyPdn/7uCm3ELbTuL8uJJfoBWigoPmEF
	l7QWlGEO/pOLrrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4FB1348F;
	Wed, 14 Aug 2024 21:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O91rNTQovWYfWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 Aug 2024 21:57:08 +0000
Date: Wed, 14 Aug 2024 23:57:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kreijack@inwind.it, Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240814215703.GB25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
 <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
 <77cda2a4-08ae-47b9-8efd-e3ca0e8fe9bc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77cda2a4-08ae-47b9-8efd-e3ca0e8fe9bc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,inwind.it];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[inwind.it,fb.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1AE6E1F81C
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Score: -4.21

On Tue, Aug 13, 2024 at 07:38:22AM +0930, Qu Wenruo wrote:
> 在 2024/8/12 21:12, Goffredo Baroncelli 写道:
> > On 11/08/2024 00.40, Qu Wenruo wrote:
> [...]
> >>
> >> Personally speaking, I would prefer the current scheme way more than the
> >> out of tree subvolumes.
> >>
> >> It's super easy to have something like this:
> >>
> >> rootdir
> >> |- dir1
> >> |- dir2
> >>
> >> Then you specify "--rootdir rootdir and --subvolume /somewhereelse/dir1"
> >>
> >> This is going to lead filename conflicts and mostly an EEXIST to end the
> >> operation.
> >
> > I am not sure to fully understand to what you means as "filename
> > conflicts";
> > anyhow, now you have the ENOEXIST problem :-)
> 
> I mean, if you support specifying a out of rootdir subvolume, along with
> rootdir, then it's going to cause conflicts (the file from rootdir with
> the same filename conflicts with the out-of-rootdir subvolume)
> >
> >>
> >>
> >>  From my understand, the "--rootdir" along with "--subvol" is mostly
> >> used to populate a fs image for distro building.
> >>
> >> If you really want just a single subvolume, why won't "--rootdir rootdir
> >> --subvol dir1" work for you?
> >>
> >> If your only goal is to reduce parameters, then your next question is
> >> already answering why the idea is a bad one.
> >
> >
> > The use case that I have in my mind is to create a filesystem with a
> > default
> > non root sub-volume, and nothing more.
> 
> You ignored all the things like owner/group/privilege bits and maybe
> even xattrs (for SELINUX) that will be needed.

There are probably two main use cases:

- create something simple, with files copied from a directory and now
  newly also to make some directories subvolumes

- create a filesystem where any detail can be specified, like uid/gid,
  access rights, ACL, XATTR, ...

So far the focus is on option 1 and it seems we have the most common use
covered. For option 2 the command line options are probably the wron
interface.

I suggest to use an approach using a list of definitions, e.g. in a
file, where each line says what should be done on the filesystem. This
is not a new idea, XFS has a protofile, which is ancient and we don't
have to copy the exact format, but it's the same idea.

The structure is like this:
  COMMAND OPTIONS...

and we can define anything, like "ROOTDIR dir" that will mimick the
--rootdir option, but also "CHMOD RWX PATH", to do mkfs-emulated
"chmod RWX PATH". And custom commands like default subvolume.

This is obviously more work than option 1 so does not need to be
implemented right now. For the command-line options the most common use
case should work. If we allow to take the proto file from stdin it can
be created on the fly too.

