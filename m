Return-Path: <linux-btrfs+bounces-2931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95286CEAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703A4B2A4E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92713443B;
	Thu, 29 Feb 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VNP3auhV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9Swsebb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VNP3auhV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v9Swsebb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BC13442A;
	Thu, 29 Feb 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222358; cv=none; b=GUGRzdGxNLg/tN+yrcWyuvaiB/Rmo2D0PlRHQzg4PASkTjc10z5SYgUqD0G6q5kgSgCrZWdlXHUPIy2uz0ojTXhmmdLuDDRSbYRA9bP7R0ehZOK2Qb+vqLQnQ9YreJb1C6MMJbtkmBjUWJsHpPac1q1cAuYrxsMNIInLEGgR6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222358; c=relaxed/simple;
	bh=K9Fpeh3sdJ+G4Wuq+GdGrrJ4JISy6co0YpZVHKQ/UT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Vpetx7hlV16/CpiuIVadmmra7doNh2PD7WZjchAwSCuvU6in8tOC2CDH8yOJ0IqgoyJGSuwTyO3qv6Tfu8vjAynApdCE5sB2mWI2S6szyaBGMUrHezpS17VXCqkUJhFOd94k1dV35Lw8kOWkf+ts0W6x2+hdynAkXTqLsYink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNP3auhV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9Swsebb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNP3auhV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v9Swsebb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 747E321227;
	Thu, 29 Feb 2024 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709222354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIdEnYpHZmcsGwhfQfdpgrGo6yqv0axPmnBxwJinK4I=;
	b=VNP3auhV4Lz/0p6UVstn8dPkV0yn/+bf3Y+Jcoe6Was6QeWfVMxiiOzAZWG9hk31/+GUru
	hN1wwGKlV/JQ/DE9jaf+zFzntbIboEuMm6vnCUWXaSM9bVQwwYHVntfzuXFLum+kC6VABY
	qFuu2N6O+jiJInu+PpNhhNgOkxGUKDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709222354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIdEnYpHZmcsGwhfQfdpgrGo6yqv0axPmnBxwJinK4I=;
	b=v9SwsebbqqDi1dNAz8HufuZpU+isTwzPifGAhe9vT+fsFftmEkBLKt65SkGm0O6fc4rUCa
	fAneXOabUhnEtmBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709222354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIdEnYpHZmcsGwhfQfdpgrGo6yqv0axPmnBxwJinK4I=;
	b=VNP3auhV4Lz/0p6UVstn8dPkV0yn/+bf3Y+Jcoe6Was6QeWfVMxiiOzAZWG9hk31/+GUru
	hN1wwGKlV/JQ/DE9jaf+zFzntbIboEuMm6vnCUWXaSM9bVQwwYHVntfzuXFLum+kC6VABY
	qFuu2N6O+jiJInu+PpNhhNgOkxGUKDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709222354;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIdEnYpHZmcsGwhfQfdpgrGo6yqv0axPmnBxwJinK4I=;
	b=v9SwsebbqqDi1dNAz8HufuZpU+isTwzPifGAhe9vT+fsFftmEkBLKt65SkGm0O6fc4rUCa
	fAneXOabUhnEtmBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 55B9A13451;
	Thu, 29 Feb 2024 15:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nOq0FNKp4GXcTgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 15:59:14 +0000
Date: Thu, 29 Feb 2024 16:52:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>, clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 09/26] btrfs: add and use helper to check if
 block group is used
Message-ID: <20240229155207.GA2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240229154851.2849367-1-sashal@kernel.org>
 <20240229154851.2849367-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229154851.2849367-9-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VNP3auhV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v9Swsebb
X-Spamd-Result: default: False [-0.39 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.38)[77.11%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.39
X-Rspamd-Queue-Id: 747E321227
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Feb 29, 2024 at 10:48:28AM -0500, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 1693d5442c458ae8d5b0d58463b873cd879569ed ]
> 
> Add a helper function to determine if a block group is being used and make
> use of it at btrfs_delete_unused_bgs(). This helper will also be used in
> future code changes.

The patch is not a prerequisite for any other stable patch, right? Then
please drop if from all versions, it's a simple cleanup.

