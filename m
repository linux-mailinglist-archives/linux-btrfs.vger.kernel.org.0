Return-Path: <linux-btrfs+bounces-7212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633D952E36
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856E8B23524
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3B198A3B;
	Thu, 15 Aug 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4fASIfI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhAosDmL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4fASIfI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhAosDmL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098917C9A8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724718; cv=none; b=WGq24bbJU4foh5vU7zk3KoE3WqQARysJv6Nx9a85rY5vuBVhEThk8PR00bV9mxCnAvqGw5fx2gRBDugYPY3dimZEsf4WOnbIiXBzizpGMch3Sp4AAzVDPOLjvbcpYRy279iyz/ok/bF41jXQF6d8pWCG6duAOIJ/fUncKMdayyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724718; c=relaxed/simple;
	bh=ZLrhZk8J7u1c7ays+wA5pdUXl3pDIg5gG0ln8evRsbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvnlwBkSoqJVIQASKrf0BfC1AWW85X82ZBKmeOH0F++w35VelCJ17+hxXbqNCqc/EJlKNUGhytVSBMHdP3OmaqKKeWWYfbrgijz6JYU7Gtw26qqn9ljHx9SZIiU9+TorQ0NJTafwQYoC9ETgTZDIi8m486SugHMh2cQpWGAdkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4fASIfI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhAosDmL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4fASIfI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhAosDmL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9224B1FD12;
	Thu, 15 Aug 2024 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723724714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Isu0dHuefsMCHLjEGYjNHx3tnuiIvznlcwWATeBMaU=;
	b=i4fASIfIjo7TKnP8QGA4SvcZo7Yy6s9obS9sd6u7UlPxsTBdaQWGdxSMU+fpQwM34n120u
	a7iyU8HY600ACmh3ABpvcEjzwvMraEfZeruV4Apcz+N5af9J+FfVNXZFPa/F3OJDy/8tsD
	FrspOisYwJ/bXyFsFp3Jc/WqHL0cg5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723724714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Isu0dHuefsMCHLjEGYjNHx3tnuiIvznlcwWATeBMaU=;
	b=EhAosDmLh5iH0DQ3YTB9c+Qj4z6357xY7Ka8viZMMFfbYHOCA92dt4vrOqMOgTARcnUZB/
	gcV5cvPVViunkACQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723724714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Isu0dHuefsMCHLjEGYjNHx3tnuiIvznlcwWATeBMaU=;
	b=i4fASIfIjo7TKnP8QGA4SvcZo7Yy6s9obS9sd6u7UlPxsTBdaQWGdxSMU+fpQwM34n120u
	a7iyU8HY600ACmh3ABpvcEjzwvMraEfZeruV4Apcz+N5af9J+FfVNXZFPa/F3OJDy/8tsD
	FrspOisYwJ/bXyFsFp3Jc/WqHL0cg5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723724714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Isu0dHuefsMCHLjEGYjNHx3tnuiIvznlcwWATeBMaU=;
	b=EhAosDmLh5iH0DQ3YTB9c+Qj4z6357xY7Ka8viZMMFfbYHOCA92dt4vrOqMOgTARcnUZB/
	gcV5cvPVViunkACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66E8413983;
	Thu, 15 Aug 2024 12:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m0K3F6rzvWYNTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 Aug 2024 12:25:14 +0000
Date: Thu, 15 Aug 2024 14:25:04 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
Message-ID: <20240815122504.GD25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
 <209d5658-01bd-4c06-ad2b-c7fc281a0c0f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209d5658-01bd-4c06-ad2b-c7fc281a0c0f@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Thu, Aug 15, 2024 at 01:17:00PM +0800, Anand Jain wrote:
> On 11/8/24 1:50 pm, Qu Wenruo wrote:
> > [REPORT]
> > There is a corruption report that btrfs refuse to mount a fs that has
> > overlapping dev extents:
> > 
> >   BTRFS error (device sdc): dev extent devid 4 physical offset
> > 14263979671552 overlap with previous dev extent end 14263980982272
> >   BTRFS error (device sdc): failed to verify dev extents against chunks: -117
> >   BTRFS error (device sdc): open_ctree failed
> > 
> > [CAUSE]
> > The cause is very obvious, there is a bad dev extent item with incorrect
> > length.
> > Although we are not 100% sure of the cause before getting the dev tree
> > dump, I'm already surprised that we do not have any checks on dev tree.
> > 
> > Currently we only do the dev-extent verification at mount time, but if the
> > corruption is caused by memory bitflip, we really want to catch it before
> > writing the corruption to the storage.
> > 
> > Furthermore the dev extent items has the following key definition:
> > 
> > 	(<device id> DEV_EXTENT <physical offset>)
> > 
> > Thus we can not just rely on the generic key order check to make sure
> > there is no overlapping.
> > 
> > [ENHANCEMENT]
> > Introduce dedicated dev extent checks, including:
> > 
> > - Fixed member checks
> >    * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
> >    * chunk_objectid should always be
> >      BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)
> > 
> > - Alignment checks
> >    * chunk_offset should be aligned to sectorsize
> >    * length should be aligned to sectorsize
> >    * key.offset should be aligned to sectorsize
> > 
> > - Overlap checks
> >    If the previous key is also a dev-extent item, with the same
> >    device id, make sure we do not overlap with the previous dev extent.
> > 
> > Reported: Stefan N <stefannnau@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Looks good.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

I'm doing some updaets to for-next so I've added the tag.

