Return-Path: <linux-btrfs+bounces-2245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942684DDE1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9338F1F28DE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D246D1AC;
	Thu,  8 Feb 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3XjdpIF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xq7GTIQy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3XjdpIF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xq7GTIQy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF26D1A2
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387141; cv=none; b=MF162z21xk30ZydQ2J0rPy9WFJo3rr7gXkFgmQhjhNdfIZISuQneH7UXGCOhLmnLULqr0tPVR6xhEPELoe6qaq4e1Aoin5jthZeDqxYBnWjkVY4FmgI4phDTO/GCiigC00MA4DsxPGBUZRHGY0gEHeeH8ZJ8SQ1PSnDXYTaX/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387141; c=relaxed/simple;
	bh=cQLRFFTZpp0V5HiMLIwuGfzozigzgdtO1SHzosYwrUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4mcnXZrVShDTakiuLsg3+l/SnzIPZvnY9V89qmJBYi1skV/GIpWVdSjNtWPPO+p6xWwDQoboa+0OmuGB/ZtEDJi+QHJoIz1oCAin0A4Pw8Vi2jBnTCKuLt8Kd2CQOSbjoUQZiK/Z8ma4oJxpLwTvS6P3pZF/N12KPZK04OXf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3XjdpIF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xq7GTIQy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3XjdpIF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xq7GTIQy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A25151FCDA;
	Thu,  8 Feb 2024 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707387135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NasJSj8KeZP0TvhjZhFIVbvZ6FnWH/K9d5OUGlWCt6M=;
	b=x3XjdpIFtvxkkn3uEqDv65jAY6vFXmgmFNfcoM6jRhQAQNakc6AkH+IG8q4bBalJ4r9iEB
	NdyxgsTUxlVZrylp0uQXO/ZOQkp9uqsLRlxAwMwtOX9pXvVOHCeedaRWQJDmomvUd4HGiE
	C9q1I7549q7GDb8XkZOYYkYxO9uTYC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707387135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NasJSj8KeZP0TvhjZhFIVbvZ6FnWH/K9d5OUGlWCt6M=;
	b=xq7GTIQydLxS3anIMFE+CNs9H105+9q1mMJU+AzFU9J0U6Ir6zb6m7+jmgpLKELMwFysFG
	Q6A//ZBhkaseC9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707387135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NasJSj8KeZP0TvhjZhFIVbvZ6FnWH/K9d5OUGlWCt6M=;
	b=x3XjdpIFtvxkkn3uEqDv65jAY6vFXmgmFNfcoM6jRhQAQNakc6AkH+IG8q4bBalJ4r9iEB
	NdyxgsTUxlVZrylp0uQXO/ZOQkp9uqsLRlxAwMwtOX9pXvVOHCeedaRWQJDmomvUd4HGiE
	C9q1I7549q7GDb8XkZOYYkYxO9uTYC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707387135;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NasJSj8KeZP0TvhjZhFIVbvZ6FnWH/K9d5OUGlWCt6M=;
	b=xq7GTIQydLxS3anIMFE+CNs9H105+9q1mMJU+AzFU9J0U6Ir6zb6m7+jmgpLKELMwFysFG
	Q6A//ZBhkaseC9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C91A1326D;
	Thu,  8 Feb 2024 10:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rAoIv+oxGXEIwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Feb 2024 10:12:15 +0000
Date: Thu, 8 Feb 2024 11:11:45 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't reserve space for checksums when writing to
 nocow files
Message-ID: <20240208101145.GW355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9024eabd5bd2419cb4ca94f276a1c54a3b2c18cc.1706798197.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9024eabd5bd2419cb4ca94f276a1c54a3b2c18cc.1706798197.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x3XjdpIF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xq7GTIQy
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.20%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: A25151FCDA
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Feb 01, 2024 at 02:42:16PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently when doing a write to a file we always reserve metadata space
> for inserting data checksums. However we don't need to do it if we have
> a nodatacow file (-o nodatacow mount option or chattr +C) or if checksums
> are disabled (-o nodatasum mount option), as in that case we are only
> adding unncessary pressure to metadata reservations.
> 
> For example on x86_64, with the default node size of 16K, a 4K buffered
> write into a nodatacow file is reserving 655360 bytes of metadata space,
> as it's accounting for checksums. After this change, which stops reserving
> space for checksums if we have a nodatacow file or checksums are disabled,
> we only need to reserve 393216 bytes of metadata.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

