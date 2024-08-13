Return-Path: <linux-btrfs+bounces-7170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAA9506A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F186728963A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473119B5BB;
	Tue, 13 Aug 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUD0SUb8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7wMN2EpR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oq1bNyCi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDRwbvMU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3660EC4
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556222; cv=none; b=NWa76iaFH0014IdfiU6+Fkh+tuM4drkQS6v2MR3vyKyhkjiVOQbQkH1uddGy8paYRmEw59s3WYimuabHzzTExEHZ08R/bccESOMuNRo0ftkBTWme0F8CmjfbdZgqaQblg6z40ovM/nNxX0uovL03iwLK6ffuLWIlXJhzpVU3DOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556222; c=relaxed/simple;
	bh=vKN/vcUb8whOpXl77sVjX9wg0i+vMXk5TSBgHYKdsP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK2f/TP+ww5upExnN3lz2qYNEajSWDe4zVKjPJ9OOw0rfrG3PTHeN6ybUkjC50Qlb4y+fBrwPOsTwecr1GxmlSYHMdoKuoiwASVfoqeGn8X4PaMpnIPgqGK9CYCLp5IM6pouhX3nQiCPWxGGXkGU525M2aANcSgQlS+PvYNAIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUD0SUb8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7wMN2EpR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oq1bNyCi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDRwbvMU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 856ED203B9;
	Tue, 13 Aug 2024 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723556217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImuZU+frRjP93FNgCuAYcHXv0fJOCD96tyYdDmdZqU=;
	b=vUD0SUb8NrlOCIxBMs3aKTlgqC8jlaD5c7MFx89Z0ijUZ4kTAe2Fo5ejYx+XP39LL4evkj
	xMBlLO6lnW4UE6wcdpwy2rlqRdBXjwJtA6/xJcDWdumF3eilQQh/TIiLiEQ01zY1y6jFO2
	3imkiH6vegWuRzwgZxQ+pW3CJDX4RA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723556217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImuZU+frRjP93FNgCuAYcHXv0fJOCD96tyYdDmdZqU=;
	b=7wMN2EpRunslh7CU1MDcIf4+48HHJzXF864n4/OlH+6Vzsncx4u4UtcDU3Waa5v3Z56/EW
	iCoRgV3LrL2dYYBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723556216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImuZU+frRjP93FNgCuAYcHXv0fJOCD96tyYdDmdZqU=;
	b=oq1bNyCiVv5VU9vZGnVLJi7520vLziHU/5Otxyw4/Qnvr89+bzVEJhKjosRfa7RXt8EbW7
	8KJeoJse4uy8/oK1rojYIxcfoFzlX1EUALsx9IDa3svaPwX/OXiU3hI4BSyvAlNBxm788G
	je8rii+QLpvD5LPMnaTOlWdr4FQwbxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723556216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImuZU+frRjP93FNgCuAYcHXv0fJOCD96tyYdDmdZqU=;
	b=aDRwbvMU88cbU4lNBbC1NrKZZmjAEAXxzYELDixHiQQEWw6vRIIm4xFCHonyHWIZGpo7xV
	oMaIFzBWIT0kwGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54BCD13ABD;
	Tue, 13 Aug 2024 13:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jl19E3hhu2YpGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 13:36:56 +0000
Date: Tue, 13 Aug 2024 15:36:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: fix invalid mapping xarray state
Message-ID: <20240813133651.GR25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cb40bca119cc0519bb5e17f6a9060a35a839ea28.1723189951.git.naohiro.aota@wdc.com>
 <20240809150844.GA25962@twin.jikos.cz>
 <9bedda40-76fc-427e-8cbc-dfa613dafa7e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bedda40-76fc-427e-8cbc-dfa613dafa7e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 02:47:04PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/10 00:38, David Sterba 写道:
> > On Fri, Aug 09, 2024 at 04:54:22PM +0900, Naohiro Aota wrote:
> >>
> >> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >> Fixes: 97713b1a2ced ("btrfs: do not clear page dirty inside extent_write_locked_range()")
> >
> > This is fixing a regression in 6.11 but the patch does not apply to
> > anything that could be used as a base branch (master, misc-6.11,
> > for-next).
> >
> 
> Are you using a wrong branch?
> 
> This patch can be applied without any conflict (although a typo, beging
> -> being) on for-next (89af55f1ed3d4354a629f08b87dfcafa3aabb90e).
> 
> For upstream RCs, it's only conflicting with the recent change on the
> folio usage, only a `page_folio(page)`->`folio` change.

Yeah, now it applies to for-next cleanly and the page/folio is minor
conflict.

