Return-Path: <linux-btrfs+bounces-2267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF184EECA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 03:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A8B1F2397B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00E1865;
	Fri,  9 Feb 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9VwVKm+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M35VoIsS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3+HUh48";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QO3aizpJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073915C9
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444235; cv=none; b=VmeqvlF+G+hs1+dZVoDmX/1SBFtygDzYDMj80xu0lKZuhyF3McLR4NROgls9QzJUhMuLGYS0goENQlM+kTonxJdBAp4yUMkpuifDEW9dPAkM030rYr7X9j+dvqDuIGulesg3OdHdeHrqWb/fempAC0s76wjUDLLwydDEN/UodKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444235; c=relaxed/simple;
	bh=1vIlzifYtN7vCOVarEMaNjeNz+KbbgUIWEaqGo8ZT5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLcqJ30JUyvyE5CXHjl0c+G0eEERk2bB53/ZVjm4YoHPWRQMlojvrPnVO0vNJCeLA8qnh3s4q05+iNID9IuxoUS42ziOu1W7clYJuk2KQ9BrLk5K2QlxxokereNvHzo1qAZaOwPPmU6Sg+bXCS4iW3Tvu/8BhRgpkVHoTXB40DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9VwVKm+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M35VoIsS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3+HUh48; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QO3aizpJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF34622110;
	Fri,  9 Feb 2024 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707444232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSt6xDC+K3Rm/qkBcRgdzOL6/S+xeh3RtD0wfkWCjjE=;
	b=E9VwVKm+2rLg9ICRh2UV8pPY9CMVY7PSLb2dHlKlthYnq9tZqKx+PYCBp9NbILj04iV9RL
	fZ4KpQAcMyxH7CSbqRpZUdn2Mi2WeHYD8yFO08GYQItbrSxZPHPrLl7kND3FWQS0+VPlqu
	mHoWpWPEyOLuMYMETeDfCsZKayCf0fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707444232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSt6xDC+K3Rm/qkBcRgdzOL6/S+xeh3RtD0wfkWCjjE=;
	b=M35VoIsSf9v3h/4f4lU/URIaVVdfwpO+h5wDLXA2mB30l32v9BKqMztqdGDMvula0/Ss62
	T/6dUHUiL0+skuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707444231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSt6xDC+K3Rm/qkBcRgdzOL6/S+xeh3RtD0wfkWCjjE=;
	b=Y3+HUh48CNXBJpjSEfk34R/Wu4KkOFw+S5D7DdHTH7mUo1qwzvMZPfjYIWIrfJOVmtcfUW
	Cq/1GNxuzhj/q91aFqHNFdkwuSnlQbQjLDYDH6iAp6PE8Cy+s1O0GI2FKoQCKBh4JX7iaU
	cbr7rX5YLWhNAlwqF6FE7a0jeFrXrRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707444231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSt6xDC+K3Rm/qkBcRgdzOL6/S+xeh3RtD0wfkWCjjE=;
	b=QO3aizpJOtnTz9BYecdaxX0ImPqDa+2HQ5a/OSlWIWoBTal4qYekMOx4shXdk1RQwZMBm0
	b2Ab+Lz4ZzL/CfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB70F137D4;
	Fri,  9 Feb 2024 02:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X8SAMQeIxWXoIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Feb 2024 02:03:51 +0000
Date: Fri, 9 Feb 2024 03:03:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/14] More error handling and BUG_ON cleanups
Message-ID: <20240209020317.GY355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1707382595.git.dsterba@suse.com>
 <80792cd4-d06e-4cb4-8db0-c40d2b551aa3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80792cd4-d06e-4cb4-8db0-c40d2b551aa3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Thu, Feb 08, 2024 at 08:20:55PM +1030, Qu Wenruo wrote:
> >    btrfs: handle invalid extent item reference found in
> >      find_first_extent_item()
> 
> For bad extent item offsets, I'm totally fine with the current -EUCLEAN
> even it doesn't have any error message.
> As tree-checker has already verified the extent items, thus it's way
> much harder to get runtime corruption to create a -1 key.offset.

Yeah, this is the same as for the previous patchset, tree-checker
catches things early and the new error handling makes sure any
improbable error will not propagate further.

Regarding the messages, I'll add them in the futre, currently I'm
analyzing all cases we might need and prototyping the error/warning
message macros. I've been going over BUG_ONs only but we have too many
random WARN_ONs too, this should be better converted to warnings or
assertions with clear purpose and use case.

> >    btrfs: handle invalid root reference found in may_destroy_subvol()
> 
> But for this, I strongly recommend a new tree-checker entry for
> ROOT_REF, before returning -EUCLEAN without an error message.

Right, we don't seem to have a case for BTRFS_ROOT_REF_KEY in
tree-checker, at least the allowed value range could be there.

> >    btrfs: send: handle unexpected data in header buffer in begin_cmd()
> >    btrfs: send: handle unexpected inode in header process_recorded_refs()
> >    btrfs: send: handle path ref underflow in header iterate_inode_ref()
> >    btrfs: change BUG_ON to assertion in tree_move_down()
> >    btrfs: change BUG_ONs to assertions in btrfs_qgroup_trace_subtree()
> >    btrfs: delete pointless BUG_ON check on quota root in
> >      btrfs_qgroup_account_extent()
> >    btrfs: delete pointless BUG_ONs on extent item size
> 
> The above ones look good to me.
> 
> >    btrfs: handle unexpected parent block offset in
> >      btrfs_alloc_tree_block()
> 
> For this one, I'd prefer one error message or at least something noisy
> enough (aka, ASSERT()), just to make life a little easier when we
> screwed up in our development environment.

Well, there are too many BUG_ONs that somebody just sprinkled over the
code, it still documents the invariants but in a very random way.
Getting rid of them is much harder as it requires reasoning in a much
broader context. I looked at all callers, this looks like a proper API
usage check rather than a random error that would need a message.

Each call site with EUCLEAN can be revisited if we really want to get
noticed about that or not, but I'm not doing that right now unless I'm
convince we do from the context.

