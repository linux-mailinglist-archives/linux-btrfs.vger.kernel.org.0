Return-Path: <linux-btrfs+bounces-2531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05E85AC24
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EA7281B51
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1C51026;
	Mon, 19 Feb 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNlRQs0y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzMqHY98";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNlRQs0y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzMqHY98"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024B50A7E
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371540; cv=none; b=r4f+/6i7TCNrCmMU1MMdwgYk6qojz2ULxzhU3+GwRb/PmexvP5tx+/JeBeBCZyA5XMkbpVLbuR+dhi65AnoEX+2J8l3SNKcTeqVBaMl8tDK0ZCqvJvxBAH+9/hXdfJwjydjLexLGls3XD92m0kvGcKvD5EKixK/2iZ7p998Hq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371540; c=relaxed/simple;
	bh=dKwmDuDHqJDrVAp3NHMWwykp2FGyNgyUGWCgz0pvKiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcko8mngWKfAeeSNt3Vz4ZEzdoqwTIePzsreDnjFzeZbH5NZ8+RgWgxe8bKWQhZ7AFxe4yvYrDAAh7bt6S8jJGraY9medEEvuAQ/GH+8F+Gx8QJCVjYAmyK1xZ1e/YfvkN7ekKiwED3OGga25IAmPpgFQUmd3VvimEMqaGY9z/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNlRQs0y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzMqHY98; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNlRQs0y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzMqHY98; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3941F81C;
	Mon, 19 Feb 2024 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708371537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0APygDZcKdnMRDgF/qcJlTW6T1Rlt1tudCyjAohrpA=;
	b=JNlRQs0yFOw9VVZNzJHeNm8psyL8HvLei2VuFsVPFIE6h29Y8flQZw/PAyNE5h+ho7gwzp
	YJOw74OKvLiO4Eo8uTdyF3Oar2E2kMN1J1pKtf+bKKLwUFvXacPzsCM76kBVVG8VIXjUuZ
	4b1MMd6sXX+mFBMYf7hpkNOkNZ46QV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708371537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0APygDZcKdnMRDgF/qcJlTW6T1Rlt1tudCyjAohrpA=;
	b=AzMqHY98aXguCR5vG+Zfm0B46GRjXktx/ANP57FHkTe0y+C85W8LtNtFE7jYmQOBPWCsmB
	0fB9LFl8KtVt4lCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708371537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0APygDZcKdnMRDgF/qcJlTW6T1Rlt1tudCyjAohrpA=;
	b=JNlRQs0yFOw9VVZNzJHeNm8psyL8HvLei2VuFsVPFIE6h29Y8flQZw/PAyNE5h+ho7gwzp
	YJOw74OKvLiO4Eo8uTdyF3Oar2E2kMN1J1pKtf+bKKLwUFvXacPzsCM76kBVVG8VIXjUuZ
	4b1MMd6sXX+mFBMYf7hpkNOkNZ46QV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708371537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0APygDZcKdnMRDgF/qcJlTW6T1Rlt1tudCyjAohrpA=;
	b=AzMqHY98aXguCR5vG+Zfm0B46GRjXktx/ANP57FHkTe0y+C85W8LtNtFE7jYmQOBPWCsmB
	0fB9LFl8KtVt4lCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EEF9B13585;
	Mon, 19 Feb 2024 19:38:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uCrXOVCu02XPVQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 19:38:56 +0000
Date: Mon, 19 Feb 2024 20:38:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [RFC PATCH 0/6] btrfs: dynamic and periodic block_group reclaim
Message-ID: <20240219193820.GZ355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706914865.git.boris@bur.io>
 <20240206145524.GQ355@twin.jikos.cz>
 <ZcKrE0iFnga94kIA@devvm12410.ftw0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKrE0iFnga94kIA@devvm12410.ftw0.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JNlRQs0y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AzMqHY98
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 1D3941F81C
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 02:07:52PM -0800, Boris Burkov wrote:
> On Tue, Feb 06, 2024 at 03:55:24PM +0100, David Sterba wrote:
> > On Fri, Feb 02, 2024 at 03:12:42PM -0800, Boris Burkov wrote:
> > A common workload on distros is regular system update (rolling distro)
> > with snapshots (snapper) and cleanup. This can create a lot of under
> > used block groups, both data and metadata. Reclaiming that preriodically
> > was one of the ground ideas for the btrfsmaintenance project.
> 
> I believe this is pretty similar to my workload 2 in spirit, except I
> haven't done much with snapshots. I would love to run this workload so
> I'll try to set it up with a VM. If you have a script for it already, or
> even tips for setting it up, I would be quite grateful :)
> 
> I think that the "lots of random deletes leave empty block groups"
> workload is the most interesting one in general for reclaim, and I
> think it's cool that it happens in the real world :)

As a simulation of that I'm using git based workload that randomly
checks out commits and does a snapshot. A once working script is
herehttps://github.com/kdave/testunion/blob/master/test-snapgit/startme
(I maybe have some updates but I'd have to find the most recent version).

The used git repo should provide large files too so it's closer to what
eg. rpm does.

> > The exact parameters of auto reclaim also depend on the storage type, an
> > NVMe would be probably fine with any amount of data, HDD not so much.
> 
> Good point, have only tested on NVMe. Definitely needs to be tunable to
> not abuse HDDs.

I think we'll need an automatic classification of devices, now it's
third type that I know could use it (raid mirror balancing, checksum
offload and this one).

There's more to reply to, I'll continue on another day.

