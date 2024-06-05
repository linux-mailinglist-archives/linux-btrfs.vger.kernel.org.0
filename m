Return-Path: <linux-btrfs+bounces-5475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043118FD19A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613491F243A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098348CFC;
	Wed,  5 Jun 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNfiUy1R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="exZ1bN2X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/pgMMVf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U6+D64JV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFF20B20;
	Wed,  5 Jun 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601247; cv=none; b=jP4WLsiUnpyBoNaQBIN1ZFtAK85MPIoYA7E5kxu5HvmFIAedNgNfnnAzt8M2Dt/Xt5W01ki0sVrkxwxw6v6h2J3kdJre/c0cSQUe2OAapKMemgD/MQm5coED0V6RUKgL4bqMRJcQAD0lVh3cTmambmf1CZKgMpp8WGItfrGX40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601247; c=relaxed/simple;
	bh=ANIcH6w+PBo1907vZDzIpdSxKlFagETHXucAHWx1K0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyanDuioGIf3fQx/6oALeslVMMhYrLexCj+NsDKFk3gDX0KLYMG6+4ERqsgaMzXLK+zblLdYgoHhqNwZj26PekiYUCmGzblwGUyezPCg7QkUdkvfIKoaBlInLsNBaKhn+D1zHnLv01YuvxD6RiD/0OSlk6dZxCU9XyIg0qbFrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNfiUy1R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=exZ1bN2X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/pgMMVf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U6+D64JV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5C1C1F821;
	Wed,  5 Jun 2024 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717601244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noUMJVyDubt6kaOq7zH8mVI8aPzXaL2Lg59//Gck0xY=;
	b=mNfiUy1RA6FhAxhbPJLM1xKebudJFgG5QORrU19Cl2Fy1XaUR0YuvSf3a27IAQvqyAotbK
	1fBmE44LqEx3Ago0aaJB2t490tVVcZFVMZ8TW+PXFoq5chEQJwbXmVhPaCNfAeuNESOPFX
	NhvXyLkRjiSamkNktVh699HU3oNT7v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717601244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noUMJVyDubt6kaOq7zH8mVI8aPzXaL2Lg59//Gck0xY=;
	b=exZ1bN2XSYVjxbJ7q81QdjelrvxSSHWE6wAblpO5AtfYmhIFEeqxP9QMX/X9DaDm0Q5Ldi
	4cMdGQqDjWZWcsDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="R/pgMMVf";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U6+D64JV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717601243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noUMJVyDubt6kaOq7zH8mVI8aPzXaL2Lg59//Gck0xY=;
	b=R/pgMMVfRsvOyV0B0LiOmBcY0l3VsCciIztZ/U2gLpz0hfjmVd3r33QymR9nIu4yqUOPtr
	ZIo/S2xdAYZ6iNBXKHSV918Ydw6NkAW+qxVVx71fd7gwQrbVDnWwBRuwQswr8Z2CsJ9adP
	beyFBlMsJhyHTlouu/jixNAXNkh9Vmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717601243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noUMJVyDubt6kaOq7zH8mVI8aPzXaL2Lg59//Gck0xY=;
	b=U6+D64JVXYaiJCf/EkOlvoGyMqY0Fh+cMaD5c9y64WRq28JENwgOI8V2YICu2Ivq/kF1aS
	tndzpaHGwwOV+oDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCCF813A42;
	Wed,  5 Jun 2024 15:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jr3uLduDYGb0RgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Jun 2024 15:27:23 +0000
Date: Wed, 5 Jun 2024 17:27:22 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/280: run defrag after creating file to get
 expected extent layout
Message-ID: <20240605152722.GA18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D5C1C1F821
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, Jun 05, 2024 at 12:26:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test writes a 128M file and expects to end up with 1024 extents, each
> with a size of 128K, which is the maximum size for compressed extents.
> Generally this is what happens, but often it's possibly for writeback to
> kick in while creating the file (due to memory pressure, or something
> calling sync in parallel, etc) which may result in creating more and
> smaller extents, which makes the test fail since its golden output
> expects exactly 1024 extents with a size of 128K each.
> 
> So to work around run defrag after creating the file, which will ensure
> we get only 128K extents in the file.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

