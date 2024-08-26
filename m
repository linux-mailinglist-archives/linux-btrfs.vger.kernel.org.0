Return-Path: <linux-btrfs+bounces-7521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48D95FAAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419E82819DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A241991B5;
	Mon, 26 Aug 2024 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ar6tyGy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlVS8Utm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ar6tyGy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlVS8Utm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FE194AEF;
	Mon, 26 Aug 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704147; cv=none; b=AyEUPkE9hjP22AUM9rB5y9/WTqBA9INLvvOsaEnH8d0JTWABqttdpgL2sieurMaLx6Armlsp7HT7PqFuFUgyuTZqeGkcGFl3a15hTmImxdTJcMU8SzamquvVBd/Pb7B1KZnowIHT9S1WX+nYI6puLkJ76P4YfIOht775L0iiGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704147; c=relaxed/simple;
	bh=3Pos2gCIu4d3aIvUSQnRgym+E3vKTifQLzv9/hX9ohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgdIdNFAygBr6r0YvcLAt+jJSHR7UYl+U/pE5A3HzxiwkFTjxYeyCra/Xxrqi5+9AUGSzwv0UTVz7b9a2Ee3o/Fs/iF1LcLTr4DJgw+4WCRN/Jz662/bVhS0Zpfbx7iUYYzxKfbb5YhqNocmNmNmYP5ryF0MHIVqETb5W3Sbc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ar6tyGy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlVS8Utm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ar6tyGy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlVS8Utm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D1D01F8AE;
	Mon, 26 Aug 2024 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724704143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKprshE6/SfW5GPE+D6oU7opiS2N/PVqHSDOoPYmLgU=;
	b=Ar6tyGy+7E4Lvslr65th561vQGmkwdcr5UBOitOXWD4Y7UEp7XP7wdoiZZi+NLEYY+AUsw
	0MneuqHfsIsOgvcYRGbEK6GH5/m2Vpcg+gQpnDDz3bSpXjUaDhj3b1bk5reimaohpoivDD
	ch+KhDsNdg4DHiVfuoF8/qpwXzJKtUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724704143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKprshE6/SfW5GPE+D6oU7opiS2N/PVqHSDOoPYmLgU=;
	b=JlVS8UtmFY2JNWQ9JsmaaMKgvu/yEG4U9dkjUIoafuBZRxtjYKrZn2yfL3aQlVoPorSDV9
	FAC6hjcIGYxBVWCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ar6tyGy+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JlVS8Utm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724704143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKprshE6/SfW5GPE+D6oU7opiS2N/PVqHSDOoPYmLgU=;
	b=Ar6tyGy+7E4Lvslr65th561vQGmkwdcr5UBOitOXWD4Y7UEp7XP7wdoiZZi+NLEYY+AUsw
	0MneuqHfsIsOgvcYRGbEK6GH5/m2Vpcg+gQpnDDz3bSpXjUaDhj3b1bk5reimaohpoivDD
	ch+KhDsNdg4DHiVfuoF8/qpwXzJKtUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724704143;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKprshE6/SfW5GPE+D6oU7opiS2N/PVqHSDOoPYmLgU=;
	b=JlVS8UtmFY2JNWQ9JsmaaMKgvu/yEG4U9dkjUIoafuBZRxtjYKrZn2yfL3aQlVoPorSDV9
	FAC6hjcIGYxBVWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AADE13724;
	Mon, 26 Aug 2024 20:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H/HlEY/lzGbjRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 Aug 2024 20:29:03 +0000
Date: Mon, 26 Aug 2024 22:29:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] block: rework bio splitting
Message-ID: <20240826202901.GS25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826173820.1690925-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6D1D01F8AE
X-Spam-Score: -4.21
X-Rspamd-Action: no action
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
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 26, 2024 at 07:37:54PM +0200, Christoph Hellwig wrote:
> The current setup with bio_may_exceed_limit and __bio_split_to_limits
> is a bit of a mess.
> 
> Change it so that __bio_split_to_limits does all the work and is just
> a variant of bio_split_to_limits that returns nr_segs.  This is done
> by inlining it and instead have the various bio_split_* helpers directly
> submit the potentially split bios.
> 
> To support btrfs, the rw version has a lower level helper split out
> that just returns the offset to split.  This turns out to nicely clean
> up the btrfs flow as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c   | 146 +++++++++++++++++---------------------------
>  block/blk-mq.c      |  11 ++--
>  block/blk.h         |  63 +++++++++++++------

For

>  fs/btrfs/bio.c      |  30 +++++----

Acked-by: David Sterba <dsterba@suse.com>

