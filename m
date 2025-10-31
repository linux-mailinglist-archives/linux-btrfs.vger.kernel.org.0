Return-Path: <linux-btrfs+bounces-18430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2645C2308A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 03:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA442581F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D02F0665;
	Fri, 31 Oct 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpr3akTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A675OieE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gpr3akTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A675OieE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7525CC4D
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878035; cv=none; b=EbIgX04SLtqbEG3l/Rp4Qekv7a/VJM725VfzjvnnEulLjpF2qs7nLsbeLyjZg3ZV/CaspB/wfW5W+szZ7Pc9GssfLlQx5LyAHZC8HGwP2FxuY4upI1KzLnXvoUE7aKOdPZPKNHzNirQudUxEt0FCjFPySTZ5ZzpwQO2DJQL42tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878035; c=relaxed/simple;
	bh=7eQB0lNjaS3MRydxHWx0IzR2ITiGdJEWz9Pw4Gf5aaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU+2ACnMfrL9UpvB7jbytrpUDVopg/7Jc53QKm6KVipdEnXkVWrKxDv316FuxlDHLz0OgVcoBpy+kowlPypKk7s72xp80oYNRWO3XemLtLzB/lDl9VE+BiU7dsib9XBznZWSpZErAfH0uExirWkxKl9pUf5R8N7+UGOEPn7WGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpr3akTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A675OieE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gpr3akTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A675OieE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4578D33700;
	Fri, 31 Oct 2025 02:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0JSdGakGAWTQwBif//kbPlum5W7WxWSiEz10xg/72g=;
	b=gpr3akTADynyaI3zZbM4WXYSyjnKNhUNtkrI4PaamhjfAgGFeTQy7bqypNhZZIGQ8/zedd
	0/BFKgLQsYv5wUUMyRce02JFSUesoYHqZX4bz7NcRE5fUsJOM57xqW7lL+1536jTjTUcLw
	C8HuvZgoWxZFx9PWqVhTPPs4pC0x7H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0JSdGakGAWTQwBif//kbPlum5W7WxWSiEz10xg/72g=;
	b=A675OieEJUgWzLoe+Fb5gnKPrVWemzm0wSMpWC1FE68n+KsGwdwc4BO48sPr1PTBS2ItoR
	xRVMF4+BK6M13aAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761878029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0JSdGakGAWTQwBif//kbPlum5W7WxWSiEz10xg/72g=;
	b=gpr3akTADynyaI3zZbM4WXYSyjnKNhUNtkrI4PaamhjfAgGFeTQy7bqypNhZZIGQ8/zedd
	0/BFKgLQsYv5wUUMyRce02JFSUesoYHqZX4bz7NcRE5fUsJOM57xqW7lL+1536jTjTUcLw
	C8HuvZgoWxZFx9PWqVhTPPs4pC0x7H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761878029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0JSdGakGAWTQwBif//kbPlum5W7WxWSiEz10xg/72g=;
	b=A675OieEJUgWzLoe+Fb5gnKPrVWemzm0wSMpWC1FE68n+KsGwdwc4BO48sPr1PTBS2ItoR
	xRVMF4+BK6M13aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38BBA13393;
	Fri, 31 Oct 2025 02:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K0itDQ0gBGnuVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 02:33:49 +0000
Date: Fri, 31 Oct 2025 03:33:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: show statistics for zoned filesystems
Message-ID: <20251031023347.GF13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251022091959.196133-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022091959.196133-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Oct 22, 2025 at 11:19:59AM +0200, Johannes Thumshirn wrote:
> Provide statistics for zoned filesystems. These statistics include, the
> number of active block-groups, how many of them are reclaimable or unused,
> if the filesystem needs to be reclaimed, the currently assigned relocation
> and treelog block-groups if they're present and a list of active zones.
> 
> Example:
>   active block-groups: 4
>     reclaimable: 0
>     unused: 2
>     need reclaim: false
>   data reclocation block-group: 4294967296
>   active zones:
>     start: 1610612736, wp: 344064 used: 16384, reserved: 0, unusable: 327680
>     start: 1879048192, wp: 34963456 used: 131072, reserved: 0, unusable: 34832384
>     start: 4026531840, wp: 0 used: 0, reserved: 0, unusable: 0
>     start: 4294967296, wp: 0 used: 0, reserved: 0, unusable: 0
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

