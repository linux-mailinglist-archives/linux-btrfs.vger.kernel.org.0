Return-Path: <linux-btrfs+bounces-8817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C30998E43
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BCBB243AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8967019CC00;
	Thu, 10 Oct 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SlHL0VeI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOH+HSgv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SlHL0VeI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOH+HSgv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4019B3D7
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580737; cv=none; b=rRJZLymOam3ecA06empGybI8UfVzaLSh1z8q1ijBt2mH+jXv0alm5wngq9kRzf8treVAwfnK0cp5YCgyUqn4f5vy7mum4Q7JgKQL9L3lMHCeP+ODm7ftNU0ZGS3f4rLvymeetEXVPabVpND8D1lHFY3UnFZvidggjxkUqO1bpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580737; c=relaxed/simple;
	bh=GLZNR2paWpqJSnJ1A9FRQswkUVgFlGwSpzbaD5W6kro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd+kaLtsAYB7EI/81HMvK6z8xazKtMHSehbqJTF1sdDZHMLCtlQ7AUSACheYAfwKucVXqIizw+0MRyvVOWzKt2pZWSGXjQnYEyK54qTW28qvAtz2927o+3Q8bugnQFyAovm06dVCML3OY21KOKcXOKhnXMw4G4iSp0JW8r30i/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SlHL0VeI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOH+HSgv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SlHL0VeI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOH+HSgv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E04C821D49;
	Thu, 10 Oct 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580731;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1r2UIncjR140btD/DzIezeN4WQgvLxOc0k+jJchBLI=;
	b=SlHL0VeIPsJH66iUlHwCLIidxQlPZVx9upMvZpAHTGYPA5bBKxmGe9n5mMqa3OLSUFAndq
	7Gcs+nukDugBuR6dqcdRe/9ROQHZtcI5Ms5X6+yQPbfOixM+n7RSzu9+PDy1Mn36u4a2tK
	k1vtvOEgsB70xMh3+n05tKbJI+PK15E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580731;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1r2UIncjR140btD/DzIezeN4WQgvLxOc0k+jJchBLI=;
	b=hOH+HSgveaUsz09eDh5Q8Nb2DRZadyWWMhGgR2NJToqN1BFP9Vb9OEZIyoViy4GlJxelXG
	/adHZBzA86zzshDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728580731;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1r2UIncjR140btD/DzIezeN4WQgvLxOc0k+jJchBLI=;
	b=SlHL0VeIPsJH66iUlHwCLIidxQlPZVx9upMvZpAHTGYPA5bBKxmGe9n5mMqa3OLSUFAndq
	7Gcs+nukDugBuR6dqcdRe/9ROQHZtcI5Ms5X6+yQPbfOixM+n7RSzu9+PDy1Mn36u4a2tK
	k1vtvOEgsB70xMh3+n05tKbJI+PK15E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728580731;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1r2UIncjR140btD/DzIezeN4WQgvLxOc0k+jJchBLI=;
	b=hOH+HSgveaUsz09eDh5Q8Nb2DRZadyWWMhGgR2NJToqN1BFP9Vb9OEZIyoViy4GlJxelXG
	/adHZBzA86zzshDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEE3013A6E;
	Thu, 10 Oct 2024 17:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGpHMnsMCGflHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 17:18:51 +0000
Date: Thu, 10 Oct 2024 19:18:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_set_range_writeback()
Message-ID: <20241010171850.GT1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sun, Oct 06, 2024 at 11:10:22AM +1030, Qu Wenruo wrote:
> The function btrfs_set_range_writeback() is originally a callback for
> metadata and data, to mark a range with writeback flag.
> 
> Then it was converted into a common function call for both metadata and
> data.
> 
> >From the very beginning, the function is only called on a full page,
> later converted to handle range inside a page.
> 
> But it never needs to handle multiple pages, and since commit
> 8189197425e7 ("btrfs: refactor __extent_writepage_io() to do
> sector-by-sector submission") the function is only called on a
> sector-by-sector basis.
> 
> This makes the function unnecessary, and can be converted to a simple
> btrfs_folio_set_writeback() call instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

