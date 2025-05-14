Return-Path: <linux-btrfs+bounces-14019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3DAB7674
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8897AE3E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 20:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657B2951DC;
	Wed, 14 May 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBOJW229";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sA2aunRf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBOJW229";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sA2aunRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE11F4623
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253479; cv=none; b=P6aGX+KXmEX7/fV99IAChLoFyOmd2E09yQKnnBdEU0dKBKwqgwTup6ocSzu+XnVAg4VfOAvnDtkAhmG3Nh1n+9hslMi1p3DUFzSg88aE+jKS+HqNfCNxsxWdRArqANAkBeQ0uEB1CWN1rYWx7Ay7ghBBMnkqGUk8hZVLXYh8G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253479; c=relaxed/simple;
	bh=BP8KEPHbIJzvx6tf6QYVCNB8iRcpF9UVoji9iB4Vorg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp3xGEsmMYQ3N/2BbytKri1C5k/A4VyvoDfZ5Im9IaBlFfU78vmVGM7LA5Q5KYjCye1PaSB+ThSQokIWHASA3UZEnbgkrGCAhOiJHDXfh+iCb/9EtwskVbS9INoFIzx98Iym/kr3qMBo05YQ0QucPnE41Nxs+hPfOt+OPdjPqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBOJW229; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sA2aunRf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBOJW229; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sA2aunRf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A14292120B;
	Wed, 14 May 2025 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747253475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmPVDx8UG4ZVOii4AcVVDQWJ3uH8WN6cD227b9gyuH4=;
	b=vBOJW229NmdBBuF3K/VptcQw6RWL0lgZh6GrRfIDS0RYCQ+Fh7rlKyfWm6oJw2LfLMYMtp
	VYKnF4OfsCF+xV4hBu9zS2iNDWl3MzyRjcJwLN+rv6Tx6Pi+fN02S/SgmkvnL4oPKQb2lV
	7Zgx4wlbbvdxrD+Ogjb1jnbOy5l1O08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747253475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmPVDx8UG4ZVOii4AcVVDQWJ3uH8WN6cD227b9gyuH4=;
	b=sA2aunRfvzxzVm8lhcIWT0QsthrSpJWm+wxGrx/pll6csSERuJXhIQ3gJC82XxT8e9nzQN
	upQNdM5CIvTvvkBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vBOJW229;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sA2aunRf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747253475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmPVDx8UG4ZVOii4AcVVDQWJ3uH8WN6cD227b9gyuH4=;
	b=vBOJW229NmdBBuF3K/VptcQw6RWL0lgZh6GrRfIDS0RYCQ+Fh7rlKyfWm6oJw2LfLMYMtp
	VYKnF4OfsCF+xV4hBu9zS2iNDWl3MzyRjcJwLN+rv6Tx6Pi+fN02S/SgmkvnL4oPKQb2lV
	7Zgx4wlbbvdxrD+Ogjb1jnbOy5l1O08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747253475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JmPVDx8UG4ZVOii4AcVVDQWJ3uH8WN6cD227b9gyuH4=;
	b=sA2aunRfvzxzVm8lhcIWT0QsthrSpJWm+wxGrx/pll6csSERuJXhIQ3gJC82XxT8e9nzQN
	upQNdM5CIvTvvkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CF0913306;
	Wed, 14 May 2025 20:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dj3rIeP4JGhAeAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 May 2025 20:11:15 +0000
Date: Wed, 14 May 2025 22:11:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add prefix for the scrub error message
Message-ID: <20250514201114.GF9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A14292120B
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Wed, May 14, 2025 at 09:45:32AM +0800, Anand Jain wrote:
> Below is the dmesg output for the failing scrub. Since scrub messages are
> prefixed with "scrub:", please add this to the missing error as well.
> It helps dmesg grep for monitoring and debug.
> 
> [ 5948.614757] BTRFS info (device sda state C): scrub: started on devid 1
> [ 5948.615141] BTRFS error (device sda state C): no valid extent or csum root for scrub
> [ 5948.615144] BTRFS info (device sda state C): scrub: not finished on devid 1 with status: -117
> 
> Fixes: f95d186255b3 ("btrfs: avoid NULL pointer dereference if no valid csum tree")
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

The prefixes are useful, please add them to all relvant messages, there
are a few btrfs_err() that still miss it (the repair messages).

