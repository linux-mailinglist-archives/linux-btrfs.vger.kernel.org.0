Return-Path: <linux-btrfs+bounces-6187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D89926C94
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394501C22928
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF4194A5C;
	Wed,  3 Jul 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C0rxL9AV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+IZNdbj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C0rxL9AV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+IZNdbj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CA1C68D
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720050071; cv=none; b=eA9SCNhc9YtMj0Eo0noJT8s9DEQi7tM5ugjCHzXMBG6Jib5/84ZsxSmP1HP+91N52o3G3O41dhOXISUoB0c9Cf2SLlSIyuHkyy6ZjZt/deJTtW1t9By8Ir4NE94bGALsJ+rVpuhCry/Z44305q4cEUvERX8yw9VDhXdVMYfuI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720050071; c=relaxed/simple;
	bh=J1ERe+qIYdEf6KALdEAtmQ36CIUH+0kmzV3RUYLGZb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwN/mPDslfiB2w+pF6Bu4sDSlMKyZZusjCP9ED8LL84PaunAa+wGFt9dkIFSPo7syVtmULD61uLDc+9Cew5Fuops/twUNpVByYkaFF6SJ2yU6SRLn3I0+OQlTlImzjHXuN3B/2urR4S3y8T3BDNtIIK+NgXnOzt8Bv50nhQenms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C0rxL9AV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+IZNdbj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C0rxL9AV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+IZNdbj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4551F37E;
	Wed,  3 Jul 2024 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720050064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0PAbnyrNPQqOndiMsv8EvaJpelo57C63ST7tFQZzGE=;
	b=C0rxL9AVUpbzJe8msqtaC0VxllJQWE7BUEE+trKkYPCnogWc43T5pGPOzHpNCBwahYOeiV
	LkTAvjNWkjv1iWcOJzQYC+o6iwSOwtpZcBvMI76HXxmqlCSiWwzVXUGPSouYoZWCW1Pyw5
	+vEpFaQ+aonGevZkfweQ1NOWdy299zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720050064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0PAbnyrNPQqOndiMsv8EvaJpelo57C63ST7tFQZzGE=;
	b=7+IZNdbjl4wVrb7v2Av5Nn3SuhvmTf3WnSaAvrZd3GKnHA/e9E+SHaT0taIQlAOZAcb+aL
	9e92wm6g+5iQXaCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720050064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0PAbnyrNPQqOndiMsv8EvaJpelo57C63ST7tFQZzGE=;
	b=C0rxL9AVUpbzJe8msqtaC0VxllJQWE7BUEE+trKkYPCnogWc43T5pGPOzHpNCBwahYOeiV
	LkTAvjNWkjv1iWcOJzQYC+o6iwSOwtpZcBvMI76HXxmqlCSiWwzVXUGPSouYoZWCW1Pyw5
	+vEpFaQ+aonGevZkfweQ1NOWdy299zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720050064;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0PAbnyrNPQqOndiMsv8EvaJpelo57C63ST7tFQZzGE=;
	b=7+IZNdbjl4wVrb7v2Av5Nn3SuhvmTf3WnSaAvrZd3GKnHA/e9E+SHaT0taIQlAOZAcb+aL
	9e92wm6g+5iQXaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 118C813974;
	Wed,  3 Jul 2024 23:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id csvGA5DhhWZcTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Jul 2024 23:41:04 +0000
Date: Thu, 4 Jul 2024 01:40:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/8] btrfs-progs: add subvol list options for sane path
 behavior
Message-ID: <20240703234054.GU21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718995160.git.osandov@fb.com>
 <20240625153438.GW25756@twin.jikos.cz>
 <ZoMlAvDuVIikCuuW@telecaster.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoMlAvDuVIikCuuW@telecaster.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jul 01, 2024 at 02:52:02PM -0700, Omar Sandoval wrote:
> On Tue, Jun 25, 2024 at 05:34:38PM +0200, David Sterba wrote:
> > On Fri, Jun 21, 2024 at 11:53:29AM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Hello,
> > > 
> > > btrfs subvol list's path handling has been a constant source of
> > > confusion for users. None of -o, -a, or the default do what users
> > > expect. This has been broken for a decade; see [1].
> > > 
> > > This series adds two new options, -O and -A, which do what users
> > > actually want: list subvolumes below a path, or list all subvolumes,
> > > with minimal path shenanigans. This approach is conservative and tries
> > > to maintain backwards compatibility, but it's worth discussing whether
> > > we should instead fix the existing options/default, or more noisily
> > > deprecate the existing options.
> > 
> > I'm working on a replacement command of 'subvolume list', there seems to
> > be no other sane way around that.
> 
> I love this idea. Do you have a work in progress anywhere?

Yes, the initial version is in my branch dev/subvol-list-new but I have
recent updates adding more optional columns. The patches are not
polished, I'll update the branch once it's done.

> > The command line options are indeed
> > confusing and the output is maybe easy to parse but not nice to read.
> > Changing meaning of the options would break too many things as everybody
> > got used to the bad UI and output.
> > 
> > We can add the two new options but I'd rather do that only in the new
> > command so we can let everybody migrate there.
> > 
> > > One additional benefit of this is that -O can be used by unprivileged
> > > users.
> > 
> > This should be the default (and is supposed to be in the new command).
> > 
> > > Patch 1 fixes a libbtrfsutil bug I encountered while testing this.
> > > Patches 2 and 3 fix libbtrfsutil's privilege checks to work in user
> > > namespaces. Patches 4 and 5 remove some unused subvol list code. Patch 6
> > > documents and tests the current, insane behavior. Patch 7 converts
> > > subvol list to use libbtrfsutil. This is a revival of one of my old
> > > patches [2], but is much easier now that libbtrfs has been pared down.
> > > Patch 8 adds the new options, including documentation and tests.
> > > 
> > > Thanks!
> > > Omar
> > > 
> > > 1: https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/
> > > 2: https://lore.kernel.org/all/6492726d6e89bf792627e4431f7ba7691f09c3d2.1518720598.git.osandov@fb.com/
> > > 
> > > Omar Sandoval (8):
> > >   libbtrfsutil: fix accidentally closing fd passed to subvolume iterator
> > 
> > I've picked this patch now as it's a fix.
> 
> Patches 2 and 3 are also fixes, so those would be nice to have, too, if
> you don't mind.

I picked only the first one for the 6.9.2 release that had little time
for testing.

> My real motivation for this series is so that some internal workloads in
> user namespaces can use subvol list. I'd love for the unprivileged use
> case to be unblocked in the short term. Would it be better to add just
> the -O option without -A and all of the big documentation changes? (This
> still requires the libbtrfsutil rework.)

I think for the time being the saner -O and -A options can be added.
Their functionality resemble the lower case options so it's still
understandable and can be released without delays. For the new command
I'd like to do a public poll and comment round that will take some time.

