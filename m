Return-Path: <linux-btrfs+bounces-8937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B699F296
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D50BB20FA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70541F668A;
	Tue, 15 Oct 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQdRX1I5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsxhuhcL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQdRX1I5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsxhuhcL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD741F667D
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009289; cv=none; b=UojBY0AS44sndhz4dz7Q3t36GEcIXlEpiumyeZ6zRCcSs7PFcXjuRC8W9PXfuZ+34h30nm2Y/+fhusnxdFz9yOXVIycxTwsOsRaDqKs+ASzXW/VZLFa/AXP5Zcp/VgAk1kmOL3vSw+dLbhYCMip8N17m+Svj7dk9bKeCtItcpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009289; c=relaxed/simple;
	bh=4YazJgprFsWVQ3m0QD5K9O1I8d5rjBCrxv31hBE/Wyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW80lQIu+Xm83gdl/i+hM+8pMm8LiOzQu+uqAr0abhFSk8T7thbpON2OhNRVEPrQ2m97tFWk2NzjAPr+zJuWzo1RdphGiA6JixVgjAlH/yfZvFzBhqdQZxjGRmNyP/879WSRqhXb/Fr1o8MkAxsbckfTO5MYv8K5nT8BzXVLXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQdRX1I5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsxhuhcL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQdRX1I5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsxhuhcL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0586021D1C;
	Tue, 15 Oct 2024 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729009284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0wvteaslbiS7x37k+GVabb2TaOgs/vTJE111mUDnSY=;
	b=lQdRX1I5L3OcMRv/xAzH0AmO/afGLdKXSvb1MSn/BQeE1045x7lqz36VMcNmv2JMRttrfT
	eA3xItNY4WHP8ww91vM3kl8+nkJ+USL2WgtjJPcK5exuotnrp/0jEXIYJkZyI8FSdje8TD
	PqsE24hS7M5yVrJjOTPRLwM7Iw3wFts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729009284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0wvteaslbiS7x37k+GVabb2TaOgs/vTJE111mUDnSY=;
	b=LsxhuhcLf2LBylin5LAtZCu2nPuCgqtwkSk2AN6ccdWfUPZjQ6SsHF7orVvKfwtDDxfVKI
	NXw0pjKZUPQ/IGAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729009284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0wvteaslbiS7x37k+GVabb2TaOgs/vTJE111mUDnSY=;
	b=lQdRX1I5L3OcMRv/xAzH0AmO/afGLdKXSvb1MSn/BQeE1045x7lqz36VMcNmv2JMRttrfT
	eA3xItNY4WHP8ww91vM3kl8+nkJ+USL2WgtjJPcK5exuotnrp/0jEXIYJkZyI8FSdje8TD
	PqsE24hS7M5yVrJjOTPRLwM7Iw3wFts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729009284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0wvteaslbiS7x37k+GVabb2TaOgs/vTJE111mUDnSY=;
	b=LsxhuhcLf2LBylin5LAtZCu2nPuCgqtwkSk2AN6ccdWfUPZjQ6SsHF7orVvKfwtDDxfVKI
	NXw0pjKZUPQ/IGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E853913A53;
	Tue, 15 Oct 2024 16:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gW92OIOWDmcgKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Oct 2024 16:21:23 +0000
Date: Tue, 15 Oct 2024 18:21:22 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free on head ref when adding
 delayed ref
Message-ID: <20241015162122.GJ1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Oct 14, 2024 at 05:24:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At add_delayed_ref(), if we added a qgroup record, we can trigger a
> use-after-free on the head reference when calling
> btrfs_qgroup_trace_extent_post() since we are not holding the delayed refs
> spinlock anymore at that point and in the meanwhile other task may have
> removed the head reference after running delayed refs.
> 
> So fix this by extracting the bytenr from the generic reference instead
> of the head reference.
> 
> Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/670d3f2c.050a0220.3e960.0066.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> This is meant to be squashed into the following patch that is in for-next
> but not in Linus' tree:
> 
>   "btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record"

Thanks, I've updated the for-next branches and now it should be all
sorted.

