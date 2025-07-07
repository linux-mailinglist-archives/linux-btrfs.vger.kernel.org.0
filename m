Return-Path: <linux-btrfs+bounces-15294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD0AFB622
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7087B3076
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2D2D94A2;
	Mon,  7 Jul 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqoETbgp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3MPmqOJB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqoETbgp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3MPmqOJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26052D8DAE
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898492; cv=none; b=FAfNTQBq+XbYrr5ug++ga7Qg6t7z7drNZLQSuff0muMIo5esdlB1XJVrs8NNS24tWAepDpU+O+VlsLP01NB8BbJTm9+iGUFjeLIqXNHOABETWQizht12XL3bUrCRbotMcPnyKWcpvdEVmj5JbT1c8WTvmlX7ritEAa/imXJaOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898492; c=relaxed/simple;
	bh=uKlIei8zdH5/WcFAsA4RoKxKwrLKnSnERXLJvhebHGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JskucjJgAjCElBPRtmHkf7Zb5e86VOFRT6BEkk47d08cwI9Wwp3P+piEMc9HcBBtx7L9hdjIDZzA4HBvatCeBEeZTv/u2QzmQ4BbsR9AauTT+FMyVsFrn/pohsGHGsfL5KDXD5ApjK/fkkB7QkM46BFLJUeD41GQzJRRba79kA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqoETbgp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3MPmqOJB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqoETbgp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3MPmqOJB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 045D821184;
	Mon,  7 Jul 2025 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898489;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lL00P0wsOa8O//ZdwN+U9sDQizCRGxa5baAHJwsURBo=;
	b=bqoETbgpkkDducbRQ7QOJKey/pR2Q65AyOdqJjhescxaiIohdP4YK++y/6/JM6hzDj+hbr
	0qW4XGcli9H/nxt2zI/hF4ltmNHe6N3TJBl5hCZPJT0EAf00hD+tYIlOI253nYSDnuIEK8
	2jdZBIjAGN0EEQX/DieP2GBeVH6uOQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898489;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lL00P0wsOa8O//ZdwN+U9sDQizCRGxa5baAHJwsURBo=;
	b=3MPmqOJBT354DDFFw7D/8TDI5ZGsrMA8TH0LbhFoGbNwpyhY4c8jn0eljFLkqu4BTjFEAu
	ycYNKvHxfpo89FDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bqoETbgp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3MPmqOJB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898489;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lL00P0wsOa8O//ZdwN+U9sDQizCRGxa5baAHJwsURBo=;
	b=bqoETbgpkkDducbRQ7QOJKey/pR2Q65AyOdqJjhescxaiIohdP4YK++y/6/JM6hzDj+hbr
	0qW4XGcli9H/nxt2zI/hF4ltmNHe6N3TJBl5hCZPJT0EAf00hD+tYIlOI253nYSDnuIEK8
	2jdZBIjAGN0EEQX/DieP2GBeVH6uOQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898489;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lL00P0wsOa8O//ZdwN+U9sDQizCRGxa5baAHJwsURBo=;
	b=3MPmqOJBT354DDFFw7D/8TDI5ZGsrMA8TH0LbhFoGbNwpyhY4c8jn0eljFLkqu4BTjFEAu
	ycYNKvHxfpo89FDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC61E13757;
	Mon,  7 Jul 2025 14:28:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4h1SNXjZa2iKLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 14:28:08 +0000
Date: Mon, 7 Jul 2025 16:28:07 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Wang Yugui <wangyugui@e16-tech.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Message-ID: <20250707142807.GH4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250630162130.GK31241@twin.jikos.cz>
 <20250630164328.GL31241@twin.jikos.cz>
 <20250702072946.6BE5.409509F4@e16-tech.com>
 <20250704031439.GA31241@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704031439.GA31241@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.79 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 045D821184
X-Spam-Score: 0.79

On Fri, Jul 04, 2025 at 05:14:39AM +0200, David Sterba wrote:
> I've updated the patch, this is basically equivalent to the same
> expression but does not report any RCU violation. This should be safe in
> all cases so the _raw's are justified for this patchset. The handling of
> device->name perhaps does not fit any common pattern for RCU so we can't
> avoid it. The protection involves no mounted filesystem (the scanning
> ioctl) and then access when the filesystem is mounted. We have the
> uuid_mutex for serializing everything.
> 
> For linux-next, I've updated the patch to use rcu_dereference_raw(),
> depending on when the branch is picked for merge there should be no
> warnings anymore.

No new warnings reported.

