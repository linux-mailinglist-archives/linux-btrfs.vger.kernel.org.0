Return-Path: <linux-btrfs+bounces-2795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88037867438
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E021F2C959
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC35B206;
	Mon, 26 Feb 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PU1+U8qg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FjGl/u3Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PU1+U8qg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FjGl/u3Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820141D532;
	Mon, 26 Feb 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948957; cv=none; b=PiI8a7v27XjuKcodnpWXx1NSy2s7FJOzdCcecyRLweiBYu5Kz2/GDwjgck/iRIE2UeSv3L9MI8niRi8ESLPgt5jmfLuf5dJLTQLBcQ0t60CSeZ4OZg8gMUEfUsg7kR1hQRPnuvJX+TDseQd3eO0liXJaJAtfRhRuqP378/LPeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948957; c=relaxed/simple;
	bh=R0bYipXFlTOZvTe5fV+Adrs80Qr5LxNydRcEE3UlGf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA6mvDU8EOcBg8tDxAjOj42eZBlS3WdLzipgGkrHdrpB3dIiEpG8Gxnh/4wMCEOC48Sb4CJeY9c2UQ0bBlXCeGwRk647LDB5ieq8qWCcPYg1FRSytHbv79A8ElbrwjznC066VSlXMIwUzFLMyCRL6S6CZiIl+yPZxzYslyCBlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PU1+U8qg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FjGl/u3Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PU1+U8qg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FjGl/u3Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 613381FB45;
	Mon, 26 Feb 2024 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708948953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvU0aeOcgvZwzKTSEwnjKYR9fxJF8eCUqO3achE2sHo=;
	b=PU1+U8qgbDw+Zr33sjPUkMjcg6lA7lv3NpmW9iQNDevk4JWvJZP+wddq/z2TFbpfqorL0x
	ph/AEvprYLltWgwaakUPozCKZB1ALEW7In9T5OUFKPVRYi8LtwO715BzX5Sncpa1nhXMIY
	WpJORZwdUl4qcoNO+N9EalteCHtiNXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708948953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvU0aeOcgvZwzKTSEwnjKYR9fxJF8eCUqO3achE2sHo=;
	b=FjGl/u3Ql1ILaii+3NS8eVvDAgrDG35o3oQdV6iiMx8gRXnzjWn80OCnGDmkTt/SEZ6vvN
	y6UH1AfpZLzPmTCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708948953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvU0aeOcgvZwzKTSEwnjKYR9fxJF8eCUqO3achE2sHo=;
	b=PU1+U8qgbDw+Zr33sjPUkMjcg6lA7lv3NpmW9iQNDevk4JWvJZP+wddq/z2TFbpfqorL0x
	ph/AEvprYLltWgwaakUPozCKZB1ALEW7In9T5OUFKPVRYi8LtwO715BzX5Sncpa1nhXMIY
	WpJORZwdUl4qcoNO+N9EalteCHtiNXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708948953;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvU0aeOcgvZwzKTSEwnjKYR9fxJF8eCUqO3achE2sHo=;
	b=FjGl/u3Ql1ILaii+3NS8eVvDAgrDG35o3oQdV6iiMx8gRXnzjWn80OCnGDmkTt/SEZ6vvN
	y6UH1AfpZLzPmTCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 50A0C1329E;
	Mon, 26 Feb 2024 12:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /lIqE9l93GWLOAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 12:02:33 +0000
Date: Mon, 26 Feb 2024 13:01:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/224: do not assign snapshot to a
 subvolume qgroup
Message-ID: <20240226120149.GD17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240226040234.102767-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226040234.102767-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PU1+U8qg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="FjGl/u3Q"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.09)[88.06%]
X-Spam-Score: -3.80
X-Rspamd-Queue-Id: 613381FB45
X-Spam-Flag: NO

On Mon, Feb 26, 2024 at 02:32:34PM +1030, Qu Wenruo wrote:
> For "btrfs subvolume snapshot -i <qgroupid>", we only expect the target
> qgroup to be a higher level one.
> 
> Assigning a 0 level qgroup to another 0 level qgroup is only going to
> cause confusion, and I'm planning to do extra sanity checks both in
> kernel and btrfs-progs to reject such behavior.

I think this was never intended, the higher level were meant to group
the leaf subvolumes. But it's possible that somebody is using it like
is in the test. In that case we'd have to define the semantics or at
least start warning about that and then remove it completely.

