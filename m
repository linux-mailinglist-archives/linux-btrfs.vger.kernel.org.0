Return-Path: <linux-btrfs+bounces-5759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30590B3D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662FEB245CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E1134DE;
	Mon, 17 Jun 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1etOR1g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cYEFZtF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YtJFsCGL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7O9Dz0G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55010A2B
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632832; cv=none; b=iJVQiSYgAkZCrsNO0Sg8jm0E2JpnBjTH8xisUSSjMJd2o1JO/x/GnUB8G9Y0B9QTf/3Wjqj9Q6XjuiHYz57LfsqgUEAK1UyhoJZbHjwBbTBLhFUGG+qvHdxMgfPew6oknFQmAHDeBkVVrgXhmK5cCBBVkYCMnwjJWrZ/t3nujXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632832; c=relaxed/simple;
	bh=+87k0fR0qTmykrch0lcCAQOcF3fr94XXij8jRLBuE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtE4ASOyWNmpkgBBmrJDcZTNhtebqd5jcPSLmbAS0XHy0w153qvtqfsciIgMfpK07065NEnVRdH8R5KvcPV3t2Hnu3ex7HTmfkUmZxhKwmwXnILv6LZSFqfgT+H/JF6Cl0sI36Tf/KIOkjRAsngkBoJkqZdbtl7ZqzTj1cOyAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1etOR1g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cYEFZtF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YtJFsCGL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7O9Dz0G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F170E601C2;
	Mon, 17 Jun 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718632829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI8hYFAkVO8jkrEp7UrJSmXxBSKCQRfn/IJyAhtyRlI=;
	b=j1etOR1gPIrzr/QCFtLxaPD86HEeXjWfRdOQf+rDP7cdTVc3mAJCuHQNrwfeIp+O9AveLZ
	t8wdV6sGeQSLwcdNVFH1YEdZgkzX7ASsG1LHh/RglnF3OlvQ0pZMap8/D235v7r96M4pnB
	hLrA0/X+1xMOAOL9K20JYY0s43tlb3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718632829;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI8hYFAkVO8jkrEp7UrJSmXxBSKCQRfn/IJyAhtyRlI=;
	b=1cYEFZtFcOmH8scUMsN3VCTaFyMn7G7dRagOx2NqgDeGeXSS42IWH1gE8MrfIxKQJWy7x6
	7qZm3YFixVcc23Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YtJFsCGL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T7O9Dz0G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718632828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI8hYFAkVO8jkrEp7UrJSmXxBSKCQRfn/IJyAhtyRlI=;
	b=YtJFsCGL0eLWqGrlokTpbEsqfM96YAytBWoM8M1dDLVrNGBulHl/SaojNx6Kes8GES1/7j
	oZXjvvaSVEa00QE/+fEjnCxLDlPVqCSxfBBnfxEm95NA6UsKIlYRcCgpE/JbVUUQ7bHbTO
	ck26q8kcobCWhjkRynvAwwHOCJ93GLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718632828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NI8hYFAkVO8jkrEp7UrJSmXxBSKCQRfn/IJyAhtyRlI=;
	b=T7O9Dz0GROKBixeJCNXGB/PP9HSaxZd0Dp9+YugGYxkVC9xit1voqEEo5nkWY7K3NHVjn7
	bKDTy3yB+52uUFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA278139AB;
	Mon, 17 Jun 2024 14:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KATNXxBcGZSTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Jun 2024 14:00:28 +0000
Date: Mon, 17 Jun 2024 16:00:23 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use label to deduplicate error path at
 btrfs_force_cow_block()
Message-ID: <20240617140023.GH25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e90b065e5a906581eaf604999504acb67371a8b7.1718623308.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90b065e5a906581eaf604999504acb67371a8b7.1718623308.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F170E601C2
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Jun 17, 2024 at 12:24:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_force_cow_block() we have several error paths that need to
> unlock the "cow" extent buffer, drop the reference on it and then return
> an error. This is a bit verbose so add a label where we perform these
> tasks and make the error paths jump to that label.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

