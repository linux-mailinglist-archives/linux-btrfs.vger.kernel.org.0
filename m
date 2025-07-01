Return-Path: <linux-btrfs+bounces-15172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D21AEFF89
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0841344071F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC852797AA;
	Tue,  1 Jul 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qWyFclSl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkvhwkag";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qWyFclSl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkvhwkag"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A695270EA4
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386848; cv=none; b=ZtIfeSeU7cxsG8j7tBAuhfhyqvcoayjfja1tXciCMlMrfMZC/ARu4DLBdx82vlUaEdbCc0ARkOEnxqGgYAORhpEOGRDTf5ixEMJ+BI2HNk3z4Ammirw40QYXwDfd5dR/VbUdFrPYvHWvhQp9P8xB+GSLFbS+i+WGZ6rIrlo2HgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386848; c=relaxed/simple;
	bh=uHYlpXF5PW6YqdcvGueXnmksphry+S9IGeCtf6V3oA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0U3jOPeU8SRVZBbibHOOAaEQ/QLD2uMkbjh5JQVbC/hh4NewkF2h4WOtG6zvEmLjHHhawYiBV4zxdCtx/rW7cUqcBQ7IihIn4AHE+4zG9bfr/IDyAz2QXyPvZv0vzBK5s4Q2UkBOvatpS/dW5Dp0VUgDwEhqmN6aD8iUleFyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qWyFclSl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkvhwkag; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qWyFclSl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkvhwkag; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51C2021181;
	Tue,  1 Jul 2025 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751386845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqUoLYE/cliEFQlnUV8gcItWsOCAa0zsYfjcTsjI45w=;
	b=qWyFclSljar/6tyIQ0dra5wuzFuAFSIQyPkZoeFzio/ziUSlsT1Jwla4YbbwqSmrAPLFnV
	aK3M/NfhQANIJYHyEBUixfJdPyzY8H5NRjjKPsOJQLOR0AwentZeN7d9Dg24cDHG76HKnW
	BNGsyQ/ePQI1Be4dbCo4HmGw46XMcS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751386845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqUoLYE/cliEFQlnUV8gcItWsOCAa0zsYfjcTsjI45w=;
	b=gkvhwkag9LM78FhN5dxZRbcwEv+GP5DmVqp1TfRMQgWQBa+noZ00gG/Rt+dHMS1uYr7NAd
	w03ZMbPBObMi9XCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qWyFclSl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gkvhwkag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751386845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqUoLYE/cliEFQlnUV8gcItWsOCAa0zsYfjcTsjI45w=;
	b=qWyFclSljar/6tyIQ0dra5wuzFuAFSIQyPkZoeFzio/ziUSlsT1Jwla4YbbwqSmrAPLFnV
	aK3M/NfhQANIJYHyEBUixfJdPyzY8H5NRjjKPsOJQLOR0AwentZeN7d9Dg24cDHG76HKnW
	BNGsyQ/ePQI1Be4dbCo4HmGw46XMcS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751386845;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqUoLYE/cliEFQlnUV8gcItWsOCAa0zsYfjcTsjI45w=;
	b=gkvhwkag9LM78FhN5dxZRbcwEv+GP5DmVqp1TfRMQgWQBa+noZ00gG/Rt+dHMS1uYr7NAd
	w03ZMbPBObMi9XCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E4C01364B;
	Tue,  1 Jul 2025 16:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oSuZDt0KZGgdNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Jul 2025 16:20:45 +0000
Date: Tue, 1 Jul 2025 18:20:36 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: qgroup fixes and a cleanup
Message-ID: <20250701162036.GU31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751383079.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751383079.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 51C2021181
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Tue, Jul 01, 2025 at 04:42:19PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple fixes and a cleanup, details in the change logs.
> 
> Filipe Manana (3):
>   btrfs: qgroup: set quota enabled bit if quota disable fails flushing reservations
>   btrfs: qgroup: fix qgroup create ioctl returning success after quotas disabled
>   btrfs: qgroup: use btrfs_qgroup_enabled() in ioctls

Reviewed-by: David Sterba <dsterba@suse.com>

