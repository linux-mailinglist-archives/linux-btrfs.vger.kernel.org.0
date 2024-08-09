Return-Path: <linux-btrfs+bounces-7069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70194D2EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 17:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF12280D96
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3C197A8A;
	Fri,  9 Aug 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xdHjAC9g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5SliJT01";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OF/spF4S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="31IMFBWy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C97155A25
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216129; cv=none; b=Bym8W9E0Zu6tdsIDrA9pTn66U3E2ng88T6mhoLbGJgKhdlirQGnfeLZLRWXSCiOl/NqKGIgakCmSoxcXtj0fiq07Bnm0K6Wg6sKmJYF3T+8wtmx7E8hiRKpFJugPqB1CbHkARHVvX4k7sggnVCmCn2mJCuMoLok74epCKsQPIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216129; c=relaxed/simple;
	bh=LnDnpaI6ILjDdNN3btRVbAMSAKbi16zEa6pr+Gt52+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOxGF5NnT9Da0Im3IiqsGAQ8v0hCVR3XSEHI7cVWW/efs1TyY0JnK8oj7ST2D228LMV+xmTOXifZ/DBt4D6EhdTSEawWJrqMqS9TOaMT206AhXjuYcxzKFe++jPKR5VPtC+oi36VNud+qW7M7DDjYEF/FUKkwHi4ALXTL9H28dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xdHjAC9g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5SliJT01; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OF/spF4S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=31IMFBWy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D45A41FF90;
	Fri,  9 Aug 2024 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723216126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYmEVQ8eC8F4vKIdXeiCoHZXVIHmCRqwURf9ShbHmrI=;
	b=xdHjAC9gzq7UafM8vQLJAgpz48USmxgZeBsXEMqJaH+0wW4f7Amr2Tzq6BydMjn7dpLo3j
	tF6IVRHJFQLEZonN6xPLFF3r8NfHQQLG1G7vCYoQRmaYbHOZ47Z+STzbF7N4qKBVQdnTFh
	OR+mRNYJw4Ah1yD7F0I0oZhc2Rb+he0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723216126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYmEVQ8eC8F4vKIdXeiCoHZXVIHmCRqwURf9ShbHmrI=;
	b=5SliJT01G2wQ6ylQUEvGX2ZiqTOiH0ibjBmCpfbywEhTb3ff9EWIogMoDNhafQD254ZclG
	Yj1s/0BmbqJfDIBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="OF/spF4S";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=31IMFBWy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723216125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYmEVQ8eC8F4vKIdXeiCoHZXVIHmCRqwURf9ShbHmrI=;
	b=OF/spF4ScJ3EaOmt3KjHxWM1l6tP0JRrXzSZ2uVRBwfcbwv5O/KOZVn+0L9pzAIB2NzEWb
	T3Xjhy2Pk6ni4pKyIZoqPojl+ZcAbp+BzUt3pKqhuP5+5hAhBXwofEyqVdY1aDAchSEcVp
	NlY/RhfSViKdF/H8jQLe2Jjb/1sBV2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723216125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYmEVQ8eC8F4vKIdXeiCoHZXVIHmCRqwURf9ShbHmrI=;
	b=31IMFBWyAtvtlbcOQ0Vm4lsPHPsF61odJkCIJsckmV5NavuNWGJUNeQlpxqQ6kpNUQBkn6
	olOqtGB/wAh1KBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5FC71379A;
	Fri,  9 Aug 2024 15:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JlrpK/0wtmYsHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Aug 2024 15:08:45 +0000
Date: Fri, 9 Aug 2024 17:08:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: fix invalid mapping xarray state
Message-ID: <20240809150844.GA25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cb40bca119cc0519bb5e17f6a9060a35a839ea28.1723189951.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb40bca119cc0519bb5e17f6a9060a35a839ea28.1723189951.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: D45A41FF90
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Aug 09, 2024 at 04:54:22PM +0900, Naohiro Aota wrote:
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 97713b1a2ced ("btrfs: do not clear page dirty inside extent_write_locked_range()")

This is fixing a regression in 6.11 but the patch does not apply to
anything that could be used as a base branch (master, misc-6.11,
for-next).

