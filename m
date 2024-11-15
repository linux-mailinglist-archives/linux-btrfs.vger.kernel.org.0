Return-Path: <linux-btrfs+bounces-9736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AE9CF401
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFD81F216BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0399127E18;
	Fri, 15 Nov 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZqOZ0b/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P+8VBZBT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="urtIJzvC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dmqDh472"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7217BB32
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695591; cv=none; b=M0lMrqNLPyi/rcIAQ0VMBjTMNQdRvtIEsqyphxJg7qHr9QXgtDsMYWUeEawBwGJL/ALoinxh7SGQ8JQBaDoKShgS0gRWqLi6A2C5MX89WG7jUv9CgTpOZW6dOIGs7qKRTXfokdKMSzi0rHFdDtIU+aG3m93tSGn9aeCzUqpF0x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695591; c=relaxed/simple;
	bh=e1tVTM+GMTy3G6GuuY1IhakQ7YHm2fCkR/PdopBb4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzIAK4abS8uZ0qpc+Ni31tRtWANrlZ0NZcGgBbxTfOEbg88P0gJG18N8caeuNEuc8ps203GCuZNwSHyzr9on4FBtskgAGA/A8VGRKvj7M2j9Vk3GZtaQI0LkI2NrLg9nxR4GoeKb/HVsgu4O9bvf/EVop87QyeFPfEasGgcDZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZqOZ0b/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P+8VBZBT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=urtIJzvC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dmqDh472; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AD5B2116D;
	Fri, 15 Nov 2024 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731695588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rQskchxlvFbVB9/OGYCE9mhhE9Ga6ffi03/Hd8CLTA=;
	b=tZqOZ0b/Q98wQQsBBf7G4cnCvPFuxeXqsFLShCwFMKoTFcoLXfNddRf0F9yVjpac1AqlM/
	7eO7NmsM9D7EvvzI/KrtbU7u0MglhavEb66prkZU+Q9mvKH6x0enmWY+NCN1yrxlNbnOLR
	o3SZJ7JujCeABlpkDzA/LpvVXrW/ciQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731695588;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rQskchxlvFbVB9/OGYCE9mhhE9Ga6ffi03/Hd8CLTA=;
	b=P+8VBZBTWTWK/5j2R/tuaNm42/5dvjVLaTD3Tq3hjNNXKx46lrApJaqfYff7lNvlP1cphc
	nYO3oy2h17jRqWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731695587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rQskchxlvFbVB9/OGYCE9mhhE9Ga6ffi03/Hd8CLTA=;
	b=urtIJzvCFGvLObzxqhWmZvJw61KTUFZcQ5PDCl4M+A03Y7nZ7Sjon6qz//yZyMrRYB0Lsd
	lkCN4ZsAUyUVFfJc244XqoG4iLf37vEQZr3jKaZrTFA92GrkZaOplvKhhUHpX/KFl3C3Em
	11zMcFGWBRbY8dZk9IK+X8ITvZfLTXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731695587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rQskchxlvFbVB9/OGYCE9mhhE9Ga6ffi03/Hd8CLTA=;
	b=dmqDh472aYnwgsJwfrt47CDbxKuNsSW9tZxLljhUuucfiWLcK/BrUXEaFC6GyUcBuJEMTt
	ETTqON4KckTqbrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2280113485;
	Fri, 15 Nov 2024 18:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YZbuB+OTN2f4cgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Nov 2024 18:33:07 +0000
Date: Fri, 15 Nov 2024 19:33:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add delayed ref self tests
Message-ID: <20241115183305.GW31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731614132.git.josef@toxicpanda.com>
 <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 14, 2024 at 02:57:49PM -0500, Josef Bacik wrote:
> +	node_check.root = FAKE_ROOT_OBJECTID;
> +	if (validate_ref_node(node, &node_check)) {
> +		test_err("node check failed");
> +		goto out;
> +	}
> +	delete_delayed_ref_node(head, node);
> +	ret = 0;
> +out:
> +	if (head)
> +		btrfs_unselect_ref_head(delayed_refs, head);
> +	btrfs_destroy_delayed_refs(trans->transaction);
> +	return ret;
> +}
> +
> +int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
> +{
> +	struct btrfs_transaction transaction;
> +	struct btrfs_trans_handle trans;

Build complains

  CC [M]  fs/btrfs/tests/delayed-refs-tests.o
fs/btrfs/tests/delayed-refs-tests.c: In function ‘btrfs_test_delayed_refs’:
fs/btrfs/tests/delayed-refs-tests.c:1012:1: warning: the frame size of 2056 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Please change that to kmalloc so we don't get warning reports on configs that
bloat data structures. On release config the sizes are like 480 + 168, which is ok.

