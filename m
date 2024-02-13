Return-Path: <linux-btrfs+bounces-2362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DA853BAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04381F24739
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DB6089A;
	Tue, 13 Feb 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuiqNbvg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FdfTh+PS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuiqNbvg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FdfTh+PS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187658122
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854081; cv=none; b=fKomuwDQQfatYO2w5PjcZGO1dldZ+Y2m9sglrVuhwKVGWWdYvUA8FoxwuZhMGyUvQ9nQM+GXVqnUuU5SUlWAfCf5zvanIBVdBKJn76umtQjBh2IVc/B2GLs6dtVr6viMEwS7RgpIMhricXVbw1h2apEncnl2sCshU0ALL3CD4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854081; c=relaxed/simple;
	bh=GZEoW0IgV8af6qAs09Orzenqd8HYBkOoa6TWFFpNxWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e82A4e4YpRLafI19LdpHj7eYvB6NcsAJKzlkiIPV+CqE+qmJasjS68qa+j9VVI5VqoNTza9VQ4EjPV72adUxWKiTi+NpiZsh/K4iFCMzn78Z/v3dBmlx6Hj1XjyVrq6e1PGmqG80LWBEVdsaY6xxfTTyMCQH7jTC0rt7CnijiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuiqNbvg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FdfTh+PS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuiqNbvg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FdfTh+PS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69128218D5;
	Tue, 13 Feb 2024 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707854077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00jsFakhedjjwDBXQudlMR1om3U7aBkXf/ci2w0L49M=;
	b=tuiqNbvgnxFg59M6fDLOq85W5qDxYnxXdFYzR2DnDuOnOTY+hvB3Dh8hPpcX06kPY4pf0U
	WkiYCsYyZcqGt0KgbH7ze6MtN8HKYJ+7U5P5wRTz7/VNLiLA7WhgoSjoPZqXfzY5A4WXAN
	3qmrU6/Li5PH1F4ryBaYMtxh1c6yspM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707854077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00jsFakhedjjwDBXQudlMR1om3U7aBkXf/ci2w0L49M=;
	b=FdfTh+PSk46tDio5evTQ1XoAyVmlFU0jUz6FeCWjISUG/blNm8AEUBEr/xkhosqHKmo9IY
	S+G4MAJDoDMSbPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707854077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00jsFakhedjjwDBXQudlMR1om3U7aBkXf/ci2w0L49M=;
	b=tuiqNbvgnxFg59M6fDLOq85W5qDxYnxXdFYzR2DnDuOnOTY+hvB3Dh8hPpcX06kPY4pf0U
	WkiYCsYyZcqGt0KgbH7ze6MtN8HKYJ+7U5P5wRTz7/VNLiLA7WhgoSjoPZqXfzY5A4WXAN
	3qmrU6/Li5PH1F4ryBaYMtxh1c6yspM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707854077;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00jsFakhedjjwDBXQudlMR1om3U7aBkXf/ci2w0L49M=;
	b=FdfTh+PSk46tDio5evTQ1XoAyVmlFU0jUz6FeCWjISUG/blNm8AEUBEr/xkhosqHKmo9IY
	S+G4MAJDoDMSbPDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5799D13583;
	Tue, 13 Feb 2024 19:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3XHTFP3Iy2VuNQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 19:54:37 +0000
Date: Tue, 13 Feb 2024 20:54:04 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove no longer used
 btrfs_transaction_in_commit()
Message-ID: <20240213195404.GJ355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00e9779bc56f516852e1488cc89403ca2d7d3a7c.1707838285.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e9779bc56f516852e1488cc89403ca2d7d3a7c.1707838285.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tuiqNbvg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FdfTh+PS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.67 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.18)[-0.898];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.48)[79.56%]
X-Spam-Score: -1.67
X-Rspamd-Queue-Id: 69128218D5
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 03:37:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_transaction_in_commit() is no longer used, its last
> use was removed in commit 11aeb97b45ad ("btrfs: don't arbitrarily slow
> down delalloc if we're committing"), so just remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

