Return-Path: <linux-btrfs+bounces-3737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B4890A6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8837F1C2F57F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99167137C55;
	Thu, 28 Mar 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ong2+2yx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nt5DTixw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAB1DDEE
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655876; cv=none; b=fM4EpsXDadetm0XBbglxCwt5PRT9UmbeCdq8qqSgIyl6byAuBLrkQfzgkE5O5NoDlUCYtlIbNM+P38oSntrDa83bka5qjSmoTHLCrSRs+hgl6/ZITrvYFFEZOx5lh48jI0c2AbwMcluxLcVsPZyWOxELoMjMaqk+WvKiGzRj57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655876; c=relaxed/simple;
	bh=xj651c7ZuH1vGLXIb7aN5/kcVNnQkZlBSRaIvaiQFgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKopVnVTX9ntThp85tNHw6k0r2JQP0+clFag3D8LwTh9WdnUOZDmemT1ESC7p22tR3NvRsZ1LWW41xIiApnHXLjq+Hh8lGUV2+8IZbGhLBhBWK+XvAOI4jK6ziLCGw2Q6D3hSvEyfUyoZ4Of8XPKd7dX0MnFLPY8sKX85WkRues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ong2+2yx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nt5DTixw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C50B343A5;
	Thu, 28 Mar 2024 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711655873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NuKi6eDgfNRdM9LeTE/HIF6qAR6sSd0Q8LP3vCgqTEM=;
	b=Ong2+2yx/T7KSpvLCRlHHQbhbFYAeGr6weANeqfF5oDKqbW2uiwNqkfr0H/CsoRjcu393j
	1s4ewtwzS1vm430KS/LeYdU2WEOXFLngElI7d8IRvOlcul2g+vvyfKm4WiA/ovUN/9LjNd
	78s9lnE13HTi9msORKrC3FbmaK/hw3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711655873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NuKi6eDgfNRdM9LeTE/HIF6qAR6sSd0Q8LP3vCgqTEM=;
	b=nt5DTixweQu44N8Rt51RwHA7nsStjJ/6ag9em3kzlf+54mI3bRGZu2rxpcDEcU3poT2ZX3
	Cjazc1CpxciNKYDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 461F113A92;
	Thu, 28 Mar 2024 19:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tXjuEMHLBWYDOQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 28 Mar 2024 19:57:53 +0000
Date: Thu, 28 Mar 2024 20:50:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: zoned: add ASSERT and WARN for
 EXTENT_BUFFER_ZONED_ZEROOUT handling
Message-ID: <20240328195034.GC14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711416290.git.naohiro.aota@wdc.com>
 <69ea90cc5f4610a85fc59181b3cd28c6fcab8bbd.1711416290.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ea90cc5f4610a85fc59181b3cd28c6fcab8bbd.1711416290.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.11 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.969];
	BAYES_HAM(-0.11)[65.81%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	R_DKIM_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Level: 
X-Spam-Score: -0.11
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 5C50B343A5

On Tue, Mar 26, 2024 at 02:39:21PM +0900, Naohiro Aota wrote:
> Add an ASSERT to catch a faulty delayed reference item resulting from
> prematurely cleared extent buffer.
> 
> Also, add a WARN to detect if we try to dirty a ZEROOUT buffer again, which
> is suspicious as its update will be lost.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

