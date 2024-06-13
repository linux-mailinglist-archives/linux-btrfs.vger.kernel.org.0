Return-Path: <linux-btrfs+bounces-5720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97E3907E13
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C28284E85
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342CF143743;
	Thu, 13 Jun 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqdYFVy7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gc91HSZ8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqdYFVy7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gc91HSZ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DF5F876;
	Thu, 13 Jun 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313832; cv=none; b=s0dZ5fApv0td4FzCBCVTUx3nLfPPHSGgjw4921K+/ww7+JPhvOatu57jTcKn68HZszRd9lziej8Kx4WU5im7M7QSkoky8dPQTCLIZp4a8qDo/4FOPU0yscfBRl/i1JQV0iAuZ8GmqQNCZA51EsDia5G2nT8eRKyWiW/Tz3x5Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313832; c=relaxed/simple;
	bh=0e5n79aLATvuB1/2ElVZjScMa+tpXIZU785EGzKNUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djfUMr78D3K0r/GcrJ7a2fhY8HlAce7JHyJxuf4K1uVPWmb8PFxz8FVIhee+yX+y9dYfTdNgnuCh++u5++5LUoHpV77w2+bZ+PcZiM56wLsPvXKZ7bD01st6oTnqVlhDQQKRBp8R3hQS0nil5J5SguF6QMcSIzkrKk+RC3W9wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqdYFVy7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gc91HSZ8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqdYFVy7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gc91HSZ8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 640D71F82B;
	Thu, 13 Jun 2024 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718313828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbGoObSKEK+boPipuuF+cGubTNj9k+qbQoQL5MJJUfA=;
	b=qqdYFVy7/ZrWG5nlY6pg5GlG2svqVgK24zWWf3DdBOrkqMKO1v5BQpl0DIOC54uR1ea/lz
	DYm999Cy8Qs/Xe+GmborZX5LaLjUEg1tY0M07nzgexLs5epccWD9vAuil0+kyB1PqsobYd
	sDL15gkbfC31R2bH1WqCtaN6NcROezc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718313828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbGoObSKEK+boPipuuF+cGubTNj9k+qbQoQL5MJJUfA=;
	b=gc91HSZ8l7JJclSWZbT/dj0tXF3pYNN5WcdZWRXXsJR1yVjjw8JXgwLyYbmUTObcS8IZ+1
	X3FZVUo76E65mUBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qqdYFVy7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gc91HSZ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718313828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbGoObSKEK+boPipuuF+cGubTNj9k+qbQoQL5MJJUfA=;
	b=qqdYFVy7/ZrWG5nlY6pg5GlG2svqVgK24zWWf3DdBOrkqMKO1v5BQpl0DIOC54uR1ea/lz
	DYm999Cy8Qs/Xe+GmborZX5LaLjUEg1tY0M07nzgexLs5epccWD9vAuil0+kyB1PqsobYd
	sDL15gkbfC31R2bH1WqCtaN6NcROezc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718313828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbGoObSKEK+boPipuuF+cGubTNj9k+qbQoQL5MJJUfA=;
	b=gc91HSZ8l7JJclSWZbT/dj0tXF3pYNN5WcdZWRXXsJR1yVjjw8JXgwLyYbmUTObcS8IZ+1
	X3FZVUo76E65mUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41FE813A87;
	Thu, 13 Jun 2024 21:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IjHjD2Rja2bpQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 21:23:48 +0000
Date: Thu, 13 Jun 2024 23:23:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>,
	Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Message-ID: <20240613212347.GB25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
 <20240611143651.GH18508@suse.cz>
 <c7246728-aadb-4699-8fdf-060502c1092a@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7246728-aadb-4699-8fdf-060502c1092a@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 640D71F82B
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 11, 2024 at 04:33:19PM +0000, Johannes Thumshirn wrote:
> On 11.06.24 16:37, David Sterba wrote:
> > On Mon, Jun 10, 2024 at 10:40:25AM +0200, Johannes Thumshirn wrote:
> >> -#define BTRFS_STRIPE_RAID5	5
> >> -#define BTRFS_STRIPE_RAID6	6
> >> -#define BTRFS_STRIPE_RAID1C3	7
> >> -#define BTRFS_STRIPE_RAID1C4	8
> >> -
> >>   struct btrfs_stripe_extent {
> >> -	__u8 encoding;
> >> -	__u8 reserved[7];
> >>   	/* An array of raid strides this stripe is composed of. */
> >> -	struct btrfs_raid_stride strides[];
> >> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
> > 
> > Is there a reason to use the __ underscore macro? I see no difference
> > between that and DECLARE_FLEX_ARRAY and underscore usually means that
> > it's special in some way.
> > 
> 
> Yes, the __ version is for UAPI, like __u8 or __le32 and so on.

I see, though I'd rather keep the on-disk definitions free of wrappers
that hide the types. We use the __ int types but that's all and quite
clear what it means.

There already are flexible members (btrfs_leaf, btrfs_node,
btrfs_inode_extref), using the empty[] syntax. The macro wraps the
distinction that c++ needs but so far the existing declarations have't
been problematic.  So I'd rather keep the declarations consistent.

