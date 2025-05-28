Return-Path: <linux-btrfs+bounces-14272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC984AC6AFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 15:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786FA1BC8363
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434942874F5;
	Wed, 28 May 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2DFOzbax";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+3ISVBDi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="njwsjI/0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxt+/BTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DB284B37
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440204; cv=none; b=QC7YCB67A5aDrSMWdPeWXS8UgvvwC6YrT92cgnzopeZDNmjVqlKmOEJMS1uJM/oY1mAn5oGdK1cfJV37th40qRddP3aBKoIb5Kr1OM7OmIKp64iqCKQh5wUOfcIngz0v0mVf3E4Rl52t9uPlq9inYHMvBTRS1Gmd8SfJFteMdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440204; c=relaxed/simple;
	bh=9AzEwSDHHKomWFbEq/sjRw8e6CvhAZHLrit3XBRwkQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZODt5GJBKv/PiZWLmqmpySCyj7/McJrgKtAjJ031IWwU1e39zxd05jCaxrKeoskAs3yiYD3ZASz0qbiW6leuy+N3O5qnL3SlYk4lWZIf1znvG2PHjmnlFy6w6kQYSbYmaAXYHveJfZR66Z4nEgKJcVZGhVOuK40S+WDHKRNhD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2DFOzbax; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+3ISVBDi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=njwsjI/0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxt+/BTu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B17031F79D;
	Wed, 28 May 2025 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748440201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A755bG+olifsAOcML4+KXw6j+iAqZibTx7u9mU0AD94=;
	b=2DFOzbax2WUx70OTN6Za0gvmUW/dMefLXm7+eSL2RlRAL6Lj6M4g9ET42p6VyVHsaCMV0I
	o6t0r3tnnCw8vAKYQzwewHBg7JLT/wDnInp8tjZbrBDUjms9hJNtWN71kJa6GSxg9AzPTB
	bDcwFRFaIAQCcbS0U09DUelOiCuhbqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748440201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A755bG+olifsAOcML4+KXw6j+iAqZibTx7u9mU0AD94=;
	b=+3ISVBDiMQbrsreY0NiE0vHtewpV5eP9P1EhDY/RlCpRObgugs/+kZhBVD1msIydJfKtZo
	v5W3kJigcwqw2ZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748440200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A755bG+olifsAOcML4+KXw6j+iAqZibTx7u9mU0AD94=;
	b=njwsjI/0KHwvd+8y9A0ZKoBIs7+OmuckRmMNfQAzUCnTuvCRZIzGXWhI2eZSw22jf5fXtz
	rBUD1tA1joT8sGUIzU7jVNCXivPBNu2u4VOpenu6RmTv79R0t9OK2GogOaPFEGprJ3dPX7
	9sJfIeeJ864I/aZ/jrjs+9f2tBpaecs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748440200;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A755bG+olifsAOcML4+KXw6j+iAqZibTx7u9mU0AD94=;
	b=pxt+/BTuZMP4/oLhGE6ldmmhKBb06t5GrbejPGw3wvl/xGIWB/tBcd0/vS/WaQoYqXZAr+
	jdrz7mc3z8/7nwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984D3136E3;
	Wed, 28 May 2025 13:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id odv9JIgUN2jTQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 13:50:00 +0000
Date: Wed, 28 May 2025 15:49:59 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 __btrfs_update_delayed_inode()
Message-ID: <20250528134959.GF4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a6bf92c79d644323883eb18bbde8f45dde8e6476.1747652848.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bf92c79d644323883eb18bbde8f45dde8e6476.1747652848.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, May 19, 2025 at 12:08:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

