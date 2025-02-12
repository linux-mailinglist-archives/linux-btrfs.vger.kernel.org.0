Return-Path: <linux-btrfs+bounces-11426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5364A3335D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D14188B3D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1772512EE;
	Wed, 12 Feb 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NOtDF4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTSVVjGS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2NOtDF4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTSVVjGS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF61E3DED
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402972; cv=none; b=N9AAVm6yiDaMQjXZri0/zze2OyGX08lSQQNn893EJVYVP5zY/XXoNVAEKWxZV590tSOL3E8NWjJAI+9tey//XGRB6ag3BbCfR2bW0ExddXBqFCgfv2W/5CZ4/QSveF9DPY7ziyEr9R+lDmmKgTDCp6QXB3oCE+5gtZAky8+yncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402972; c=relaxed/simple;
	bh=+3kvrFe7p225kjwrL2XtFkZbYh8NgA5HOSWJxcRtPFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCBIu8j1vIwZWnToq1f/O5XEleQOEVh9YoFK0e6rN1CyLLMas6TWW2JH7MWkWASx4Sul4Lknsr3L1BleLAVgFr/5yRpcnuVoY+dQIf6l0q+YoylbVqHV4ueCFA36Yi0j30GjOOeDbibFl8INGTB9lvuMGl2fdFxAin1sOv5lBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NOtDF4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTSVVjGS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2NOtDF4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTSVVjGS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CBB31F74D;
	Wed, 12 Feb 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLD2TWmotVnKCJ5RRS/uaI8Q6Lh3HGLoYofXY059Ths=;
	b=2NOtDF4cPJ+oXRPWsBtpP7PBKGnbCKrDZBOdCO9iCeJ2626MfgUyUhnsJ/OVI7n9irZoBO
	SXB0+eTDRIVb3f7Bz4fuFr+UMYs0Q2WiN0HdAoMOhemLouPMw4XRtRp/7dFcO4Bh3RqrU1
	UBOU59l0nzeYoOrzTTsiRU026pH8zAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLD2TWmotVnKCJ5RRS/uaI8Q6Lh3HGLoYofXY059Ths=;
	b=fTSVVjGSzUFYvY2prcJwaecCMSIsIRXXH5L44wkLbaUAwVKwWvewE8rB7InS9yS592aXmM
	0Q+5IkM2xbrxGfDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2NOtDF4c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fTSVVjGS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLD2TWmotVnKCJ5RRS/uaI8Q6Lh3HGLoYofXY059Ths=;
	b=2NOtDF4cPJ+oXRPWsBtpP7PBKGnbCKrDZBOdCO9iCeJ2626MfgUyUhnsJ/OVI7n9irZoBO
	SXB0+eTDRIVb3f7Bz4fuFr+UMYs0Q2WiN0HdAoMOhemLouPMw4XRtRp/7dFcO4Bh3RqrU1
	UBOU59l0nzeYoOrzTTsiRU026pH8zAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLD2TWmotVnKCJ5RRS/uaI8Q6Lh3HGLoYofXY059Ths=;
	b=fTSVVjGSzUFYvY2prcJwaecCMSIsIRXXH5L44wkLbaUAwVKwWvewE8rB7InS9yS592aXmM
	0Q+5IkM2xbrxGfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64B2213874;
	Wed, 12 Feb 2025 23:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h2YQGNgurWcwWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Feb 2025 23:29:28 +0000
Date: Thu, 13 Feb 2025 00:29:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: tchou <tchou@synology.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Preserve first error in loop of
 check_extent_refs()
Message-ID: <20250212232927.GA5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250212064501.314097-1-tchou@synology.com>
 <cac8d40a-b631-4c58-b8b8-70db3ab58443@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac8d40a-b631-4c58-b8b8-70db3ab58443@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7CBB31F74D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Feb 12, 2025 at 05:44:57PM +1030, Qu Wenruo wrote:
> 在 2025/2/12 17:15, tchou 写道:
> > Previously, the `err` variable inside the loop was updated with
> > `cur_err` on every iteration, regardless of whether `cur_err` indicated
> > an error. This caused a bug where an earlier error could be overwritten
> > by a later successful iteration, losing the original failure.
> >
> > This fix ensures that `err` retains the first encountered error and is
> > not reset by subsequent successful iterations.
> 
> SoB line please, otherwise looks good to me.

For btrfs-progs teh SoB line is optional, I think it's mentioned in the
README. It makes sense for kernel to insist on the attribution and some
trace to real people but btrfs-progs are much smaller and I think it's
better to lower the contribution barriers.

> Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks, feel free to add the commit to devel.

> And if it's a case you hit in real world, mind to extract or craft a
> minimal image as a test case?

From my experience, casual contributors will rarely write tests and I do
not do that when I'm sending a fix or reporting a problem to other
projects. In order to keep the track of that it may be best to open an
issue, unless you or me will write the test case.

