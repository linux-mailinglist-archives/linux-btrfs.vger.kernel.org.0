Return-Path: <linux-btrfs+bounces-10262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FE9ED4E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238A318881DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F5207A18;
	Wed, 11 Dec 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtYClpNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lfUG9g0t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gtYClpNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lfUG9g0t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEE1C3F27
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942960; cv=none; b=t89VQd10UHV0usNNEQjedI6O0xi6w5L+esYi2SRcLZBBz0kuZicjM/Ki3uxqIdlpDHgoC9IQjl6uMMpOwU/zLY5JqJFI6Me7N6THbJrdS8J5ovs7YT+CLNjxK0Duc151+B5aIC4wI8sW8KWg2FAJDQkKbhf8vVb56aSUk2ouxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942960; c=relaxed/simple;
	bh=/Q2+msffpuS+UjrLYDtnRpiAARbRvpUbHkbCrMfj+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcZynpyOcduQEsF1EzDz89hLW5FSb/2Himlh6de3f2/qSoYHXxbJIfRFORnAKoxI3H0FI6uo6IEo//UeWINDeHgFzY8a+/iO5y4GeDgAOytcK7bC72SsIkRn3MMu+08XvcUdoZWyUqIm1clnhgUFCR9c81La4NZLBl+QAB570iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtYClpNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lfUG9g0t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gtYClpNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lfUG9g0t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95F732117A;
	Wed, 11 Dec 2024 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/TAzgU/KC5N9RPSAsVq8436s6TKVKqiN6q0E89MMaWs=;
	b=gtYClpNmpbBVpftZ59TamE3Xx6QHhrV/WT2DiopkaN7tOelvhc9nnIMSwemmxtuZVoMHrF
	3AwM5rfeBMnMZZoui4AJwmTGFHvRgnf7HCZo8wtRdIRwBbY8dAZs9IOMXPuKc9YQa3sGQc
	+82IbR9ckZQ1US9FAjEAFdeQnoLMQug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/TAzgU/KC5N9RPSAsVq8436s6TKVKqiN6q0E89MMaWs=;
	b=lfUG9g0tB8fzZXXyuqQFW6ybVgqLXlMnGyrZCAfu6iLPxjs+z0IPoytyqVMrw85DztiA5A
	5VlG23s4l/aSj7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/TAzgU/KC5N9RPSAsVq8436s6TKVKqiN6q0E89MMaWs=;
	b=gtYClpNmpbBVpftZ59TamE3Xx6QHhrV/WT2DiopkaN7tOelvhc9nnIMSwemmxtuZVoMHrF
	3AwM5rfeBMnMZZoui4AJwmTGFHvRgnf7HCZo8wtRdIRwBbY8dAZs9IOMXPuKc9YQa3sGQc
	+82IbR9ckZQ1US9FAjEAFdeQnoLMQug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/TAzgU/KC5N9RPSAsVq8436s6TKVKqiN6q0E89MMaWs=;
	b=lfUG9g0tB8fzZXXyuqQFW6ybVgqLXlMnGyrZCAfu6iLPxjs+z0IPoytyqVMrw85DztiA5A
	5VlG23s4l/aSj7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A74F13983;
	Wed, 11 Dec 2024 18:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id txUvGazeWWdlAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 11 Dec 2024 18:49:16 +0000
Date: Wed, 11 Dec 2024 19:49:15 +0100
From: David Sterba <dsterba@suse.cz>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 2/6] btrfs: edit btrfs_add_block_group_cache() to use rb
 helper
Message-ID: <20241211184915.GU31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <2c3972c084ab074fd1b6a2e03ada8c20dde6d060.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3972c084ab074fd1b6a2e03ada8c20dde6d060.1733850317.git.beckerlee3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Dec 10, 2024 at 01:06:08PM -0600, Roger L. Beckermeyer III wrote:
> +	exist = rb_find_add_cached(&block_group->cache_node,
> +			&info->block_group_cache_tree, btrfs_add_blkgrp_cmp);
> +	if (exist != NULL)

For pointer checks you can use the shorter form 'if (exist)'

> +		return -EEXIST;
>  	write_unlock(&info->block_group_cache_lock);
>  
>  	return 0;
> -- 
> 2.45.2
> 

