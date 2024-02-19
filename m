Return-Path: <linux-btrfs+bounces-2524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502685A647
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC59B21F97
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C5381AB;
	Mon, 19 Feb 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I6CMoeb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2sbfVsGJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="urak0O6H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0VR5Nj9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCB376E1
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354008; cv=none; b=NR8QZGZmeznqLGUZ6KNMEewNlqQONGy+Jm3UNwVjJJZkzCaIvv1BMTwERYoXO/6yQ2G9yt534UGePUjzGDWAKO3DpBDzBOXzD455uTSSkF/EmXmiQ902cman9Dxc0noInFWxuuK/CLyexGEPb2+RfT0wtfXIdLjw2OtYtjO7iBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354008; c=relaxed/simple;
	bh=sshhaY3ot7jK6IivkcffqxusiXMnE/E6zEWfKaOxBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWXJGDycYf4Tk5Eng4yzx+1riqpXNayyWHZRINAiTMb3IOb8tyGlXYctHYNboJLQPihUBlyCtgWOPlwXFuas8D6OAs8T3LcRcW9Ql1VJBZF+1ZDWxC9/QS8YWchihh+LmniDq7X02V/MrmOSa+nnUF3PnP12VJyELauorhLOV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I6CMoeb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2sbfVsGJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=urak0O6H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0VR5Nj9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D45D11F804;
	Mon, 19 Feb 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708354005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/lS9IxFVX4foIbPXn/RajzzpZS1Cs6LP9PiYtynwg0=;
	b=I6CMoeb7KThR+KLfGLefygF9AV6Bv1pYqzmUgRUaLBBQX7OM9kVaUU425YFvMDot7oYD9M
	lIt0yWYx10h5B7yD51be6zDMAPGhPAFyQSrH29ZYkp7rO/5aVzDLqwA3kJ7qnK1C48jmaT
	uHzKv4KLFN1EqmQdDnfks5Bx403ZmQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708354005;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/lS9IxFVX4foIbPXn/RajzzpZS1Cs6LP9PiYtynwg0=;
	b=2sbfVsGJ0bfYyDzicRRjJyDiyFyQGpnNWLkxDiIdOoyQZSfrzL+JBShxwXJgGZqo+mVPfb
	K9G/zZYSOhuM/aDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708354004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/lS9IxFVX4foIbPXn/RajzzpZS1Cs6LP9PiYtynwg0=;
	b=urak0O6HL2ZZDxrOLYGfU5P77fcZnF23u4g2ikbiB5916lXyDxng/SvrGuCMT0NOXXVhPs
	O5FYLB9vDWwcSCw/UUeOAvmSHGnKAFpIe6lPCOad7eotVIr8rre2xRh/BVI5THOLgitn39
	SiaBguOlqLFBqM+eFQkksiBNM61DeKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708354004;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/lS9IxFVX4foIbPXn/RajzzpZS1Cs6LP9PiYtynwg0=;
	b=k0VR5Nj9Fz6USEcLz5ZImTpRnrcS/6mOB2KZBUUFTlG1xbeVC1HRKDGhrIkdZqgT/khu1P
	XaAoS81LHtUYPcCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC8F1139C6;
	Mon, 19 Feb 2024 14:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pRzdLdRp02X9FwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 14:46:44 +0000
Date: Mon, 19 Feb 2024 15:46:04 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid unnecessary ref initialization when freeing
 log tree block
Message-ID: <20240219144604.GW355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <06acd07b61968eaecded7c22d07cd72030fbef6b.1708347488.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06acd07b61968eaecded7c22d07cd72030fbef6b.1708347488.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=urak0O6H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k0VR5Nj9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.96%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: D45D11F804
X-Spam-Flag: NO

On Mon, Feb 19, 2024 at 01:00:22PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_free_tree_block(), we are always initializing a delayed reference
> to drop the given extent buffer but we only use if it does not belong to a
> log root tree. So we are doing unnecessary work here and increasing the
> duration of a critical section as this is normally called while holding a
> lock on the parent tree block (if any) and while holding a log transaction
> open.
> 
> So initialize the delayed reference only if the extent buffer is not from
> a log tree, avoiding unnecessary work and making the code also a bit
> easier to follow.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

