Return-Path: <linux-btrfs+bounces-19343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D12C85F76
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039BA3AD6FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377623E25B;
	Tue, 25 Nov 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3eMjGAi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUMp8cSG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3eMjGAi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUMp8cSG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF623D2A3
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087899; cv=none; b=vGoPLc6rL4myS8UwJsRpl+6xrlI3hy5LHjeRYnAowEhoq+i4/20hry56PTfwEqngg9bWBMypOv8qV7Bm+4iUhYR3n3miuuRB4dNT4ioARMLFCJjOPWoMK6NH+nWvEcw8lHYm6q+6QeT1Vo+IUdn+XTnUwaT+XMkoc/a4h5DyOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087899; c=relaxed/simple;
	bh=gvsCroJT/dSkAS26RKd8zRodeLy+HJFCHwBu9iowU7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8RhK7bAStskFCN4MnqGztIzMag18iZRRhrJTwu9O/KsE5xZH0Ve8IEVCKHKywrdH9RJvYwuHLduZ757EW4oH1Bogbf8bjAL/ewHRGNvbYfsTCe2XbvcdvfTlgGZ+xpVJL2csrSvguzY7KSRDQEczXjnDEvgAdllinoqkLa3MWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3eMjGAi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUMp8cSG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3eMjGAi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUMp8cSG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E5012299C;
	Tue, 25 Nov 2025 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764087895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUhx37/A6W4FsrsLTJewLIxMA38ouj4xABMZh76dBFY=;
	b=o3eMjGAiZJKJIG66UGK73zLcq9TBrAn6b6V/RhH2CxgChMSqqFO+NtChM8yok3n2UknFC+
	yaoks4MuG+eFk564k3uXriO8Pnx3X1WagAQv/vu8xOp9xFHHuaF450sufa9bVXaHCUNQt5
	C38FMcWWwdl4xsk6YoM0oVSMyNhOvlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764087895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUhx37/A6W4FsrsLTJewLIxMA38ouj4xABMZh76dBFY=;
	b=iUMp8cSGvZ+DIIhqhDMT96Yx5QLzGUrnPGtmCbAUbN+JK2HhqwFMg8luk2RvnFYoGJRYwW
	s3ArcLzTdyNmrZAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764087895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUhx37/A6W4FsrsLTJewLIxMA38ouj4xABMZh76dBFY=;
	b=o3eMjGAiZJKJIG66UGK73zLcq9TBrAn6b6V/RhH2CxgChMSqqFO+NtChM8yok3n2UknFC+
	yaoks4MuG+eFk564k3uXriO8Pnx3X1WagAQv/vu8xOp9xFHHuaF450sufa9bVXaHCUNQt5
	C38FMcWWwdl4xsk6YoM0oVSMyNhOvlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764087895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUhx37/A6W4FsrsLTJewLIxMA38ouj4xABMZh76dBFY=;
	b=iUMp8cSGvZ+DIIhqhDMT96Yx5QLzGUrnPGtmCbAUbN+JK2HhqwFMg8luk2RvnFYoGJRYwW
	s3ArcLzTdyNmrZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD6C3EA63;
	Tue, 25 Nov 2025 16:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PvQ2ElfYJWmTWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 16:24:55 +0000
Date: Tue, 25 Nov 2025 17:24:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update comment for visit_node_for_delete()
Message-ID: <20251125162450.GW13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124035328.12253-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124035328.12253-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Nov 24, 2025 at 11:53:05AM +0800, Sun YangKai wrote:
> Drop the obsolete @refs parameter from the comment so the argument list
> matches the current function signature after commit f8c4d59de23c9
> ("btrfs: drop unused parameter refs from visit_node_for_delete()").
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next, thanks.

