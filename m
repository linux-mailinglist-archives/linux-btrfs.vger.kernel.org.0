Return-Path: <linux-btrfs+bounces-6547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC92935020
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CA28324B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AE1448EE;
	Thu, 18 Jul 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmoU9w7P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9q8jQ3eK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmoU9w7P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9q8jQ3eK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567701448E9
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317633; cv=none; b=FZ/XrWy84T/3GIq9NldYgQ0yaXNpc8XsToeABrOp5qJiaFKyJE9nELZpJQpjZqUf2rTMsgOV8TcCHhgLtp8lZUdFvVPfBQZRnd2a70JU9iu4w3h2ujEGkNIpVtSKnEqy4Ur9mfKoDK3y70y3M10BzZEh5dH3Fx7Ilu99hyulc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317633; c=relaxed/simple;
	bh=vdFqhf9H9skwgIyJsV9lHrkX5f9qPNrC28pgcYCjih8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kURO3334L2YaxgaQt4uYRYJAFN0i1L+VYKK968TwAlW2526HIWfbE7G1V/YELR85fyf/SAVFY/jB5w3U8/t7g3FMRM2dvdHldNd3wtAFM/jAVC/I6FeUWJ1T1IZjdTod9BVa58CnedFVy0rx0rpjc3KM2AycG1qAq/ELOJqGdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmoU9w7P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9q8jQ3eK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmoU9w7P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9q8jQ3eK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6544A1F747;
	Thu, 18 Jul 2024 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721317624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwJZfk7EwtRL1Z86oPxZmO4YNtzbcbDQGfowzNfHpw=;
	b=nmoU9w7PTM1l0ayh+CJxY4Qce9yI7ZEq4FSOynN0cj32rwQvmqJ3Da9gUDcQIySZC0RS72
	Icfem78SQxk6op7Z3wjKi+5S048KDGVwgQK2S6zNYi3DGm0/qWP0tQWwwcktwaDAnFIy/c
	coIQ4bX8B5/we7izMWmKnqP4SacJqNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721317624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwJZfk7EwtRL1Z86oPxZmO4YNtzbcbDQGfowzNfHpw=;
	b=9q8jQ3eKXghCZDX0FswA2avIJ0FWP3widxS46dV9IxbjwRzarvCWfmEAWoDMI5qpxctBLV
	is+JS0Svj/PPQ9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nmoU9w7P;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9q8jQ3eK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721317624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwJZfk7EwtRL1Z86oPxZmO4YNtzbcbDQGfowzNfHpw=;
	b=nmoU9w7PTM1l0ayh+CJxY4Qce9yI7ZEq4FSOynN0cj32rwQvmqJ3Da9gUDcQIySZC0RS72
	Icfem78SQxk6op7Z3wjKi+5S048KDGVwgQK2S6zNYi3DGm0/qWP0tQWwwcktwaDAnFIy/c
	coIQ4bX8B5/we7izMWmKnqP4SacJqNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721317624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzwJZfk7EwtRL1Z86oPxZmO4YNtzbcbDQGfowzNfHpw=;
	b=9q8jQ3eKXghCZDX0FswA2avIJ0FWP3widxS46dV9IxbjwRzarvCWfmEAWoDMI5qpxctBLV
	is+JS0Svj/PPQ9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 460C61379D;
	Thu, 18 Jul 2024 15:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ByVxEPg4mWYFMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jul 2024 15:47:04 +0000
Date: Thu, 18 Jul 2024 17:47:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/4] btrfs-progs: fix the filename sanitization of
 btrfs-image
Message-ID: <20240718154703.GI8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1720415116.git.wqu@suse.com>
 <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6544A1F747
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Mon, Jul 15, 2024 at 07:39:32AM +0930, Qu Wenruo wrote:
> Ping?
> 
> Any update on this?

Tracked as https://github.com/kdave/btrfs-progs/pull/837

