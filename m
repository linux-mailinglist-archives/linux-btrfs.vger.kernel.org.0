Return-Path: <linux-btrfs+bounces-7168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE676950630
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5F288095
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250E519B3CE;
	Tue, 13 Aug 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmihEcfC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kbIklZMq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UmihEcfC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kbIklZMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2741E4A4
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554880; cv=none; b=PB/FL7TeSSWuhQZS39Ta+P3HY6kPJkOiHtlecxAcs23RN0WN9tNRhIuie7kAkR2mo6rWD2IpbsFcF38zIW4mxzDOJw6SOAC3k1w/jd3P1KNHEOaipXgToDS/yhiXM/IGhLwmzEz7rpmQazwDxxpIKP8weU5dcETK8Vn8rSMCo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554880; c=relaxed/simple;
	bh=G93dZ7ZqQhH6bULy7/PRBQqK8cs33jq1nBnC8CXwU8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKrcNFTI+T44UwOp2QMcVh8izKFW+KOC5tMrsQJoJ/eRR2LOTz5/FA1zOWckLqYK3bcfgTIVED2VWvYMO60r2xwmVbCHNSYChoC3ld5NHSoZEcjRV6polQ40Ol/Fiove7vd1CGUintnd3WgGiNEmOsxFM89FMmTLwVFqgtvitGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmihEcfC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kbIklZMq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UmihEcfC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kbIklZMq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2F9A203AD;
	Tue, 13 Aug 2024 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723554876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdXoi2S73BBZ42GzQgomNwDQKwdZ2stGAPLAVY0DOg=;
	b=UmihEcfCQuerPMQZyLJb0k5Vv6HoMnw6qcUNVh4aScALCjLlOD8PHIm5DKajh+LmCmX0Tb
	qcl6TVwxU8mdH6KPCOEKRbVhgi0v5rba5KiIqEnLz19SDoXw/hy3sBnfMrO/HGIQvtaU16
	omXOqBYHz7Y1WiMt3zLKKoN/ffWirkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723554876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdXoi2S73BBZ42GzQgomNwDQKwdZ2stGAPLAVY0DOg=;
	b=kbIklZMqKIk6vuC9c93FLZtGfUK+B3PcysP8IwjhfMK4Ux0ZJRK7ZPR3CeKEEkWwig57vL
	sLUpYTy4d0UmX4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UmihEcfC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kbIklZMq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723554876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdXoi2S73BBZ42GzQgomNwDQKwdZ2stGAPLAVY0DOg=;
	b=UmihEcfCQuerPMQZyLJb0k5Vv6HoMnw6qcUNVh4aScALCjLlOD8PHIm5DKajh+LmCmX0Tb
	qcl6TVwxU8mdH6KPCOEKRbVhgi0v5rba5KiIqEnLz19SDoXw/hy3sBnfMrO/HGIQvtaU16
	omXOqBYHz7Y1WiMt3zLKKoN/ffWirkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723554876;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCdXoi2S73BBZ42GzQgomNwDQKwdZ2stGAPLAVY0DOg=;
	b=kbIklZMqKIk6vuC9c93FLZtGfUK+B3PcysP8IwjhfMK4Ux0ZJRK7ZPR3CeKEEkWwig57vL
	sLUpYTy4d0UmX4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A194613983;
	Tue, 13 Aug 2024 13:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1H3Jjxcu2a5EAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 13:14:36 +0000
Date: Tue, 13 Aug 2024 15:14:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Message-ID: <20240813131435.GQ25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a7453cfe31daeb0e7ba0950b611ded4640ecbca1.1723190260.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7453cfe31daeb0e7ba0950b611ded4640ecbca1.1723190260.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B2F9A203AD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 09, 2024 at 04:59:22PM +0900, Naohiro Aota wrote:
> __btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
> ro, and zone_unusable, but without taking the lock. It is mostly safe
> because they monotonically increase (at least for now) and this function is
> mostly called by a transaction commit, which is serialized by itself.
> 
> Still, taking the lock is a safer and correct option and I'm going to add a
> change to reset zone_unusable while a block group is still alive. So, add
> locking around the operations.
> 
> Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> v3:
>   - Rewrite the initial freeing detection with "if"

Reviewed-by: David Sterba <dsterba@suse.com>

