Return-Path: <linux-btrfs+bounces-8391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AF798C171
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C06284EC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436041C8FD6;
	Tue,  1 Oct 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9BSP33x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HuYi6gC4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9BSP33x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HuYi6gC4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC01C68AC
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796024; cv=none; b=LZ79113rXYRosyzfWzJ4lBoRsXsGg9FbAijLs3mPn4jPgjvRnTkUXX4zxItlt98tpET0uNwlAToFeGjPsyGX9k1+SWtEDgGo0rplOzghmXvc+tRdrTusuj6DhtUwxquU3SsWsb1B7ZNf7MInG2vUGD416V9LGkTKfmIWnL15oBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796024; c=relaxed/simple;
	bh=fL8xAgNUEM9XVbKSsSH26M30HfBOktR6dlaOAnXMXDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt5hL23K12ME/CmErl3jXQXQ52OrFPMHo5DQEg2DQxQGjL/v+T9lp1GoyJN4rHuUHhW7PLqjzxdLGdP2/+1Ob2lp58I6CEJh6EEoPnCrMB7HyfKcXFyBnPGxFCq4vqnStuaTRifgs7elS0WyDDCgqh3X8kv188FakwbpMICI3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9BSP33x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HuYi6gC4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9BSP33x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HuYi6gC4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 361FB1F88A;
	Tue,  1 Oct 2024 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727796021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+03JVBwYoOd91bMEBfejXrABv6cQGEi0aaGgrlViUM=;
	b=a9BSP33xXuhR0EFkz6bkEgkKVc7PmzuIjWpNXjXINgNgEhZZPw+FvaTQy4Q79t4qH01SN+
	c8umzpxkWUAKtr9EB8tIf566oqwX+bD1H8h/mihoRt48c5Il5TbORZTeA4x87KqwLWxDHl
	IeNa50nZvNw+nfulVelL/ER5PtRlw5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727796021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+03JVBwYoOd91bMEBfejXrABv6cQGEi0aaGgrlViUM=;
	b=HuYi6gC4cOpBUFAZSvXm3GwA4++b4EuE5ewkOOhQVGo/SHSNlPMJltGsjHaQ55+JpMugQk
	7oUDmwnvlrlR4KDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a9BSP33x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HuYi6gC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727796021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+03JVBwYoOd91bMEBfejXrABv6cQGEi0aaGgrlViUM=;
	b=a9BSP33xXuhR0EFkz6bkEgkKVc7PmzuIjWpNXjXINgNgEhZZPw+FvaTQy4Q79t4qH01SN+
	c8umzpxkWUAKtr9EB8tIf566oqwX+bD1H8h/mihoRt48c5Il5TbORZTeA4x87KqwLWxDHl
	IeNa50nZvNw+nfulVelL/ER5PtRlw5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727796021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+03JVBwYoOd91bMEBfejXrABv6cQGEi0aaGgrlViUM=;
	b=HuYi6gC4cOpBUFAZSvXm3GwA4++b4EuE5ewkOOhQVGo/SHSNlPMJltGsjHaQ55+JpMugQk
	7oUDmwnvlrlR4KDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE3813A73;
	Tue,  1 Oct 2024 15:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id siiOBjUT/GYdMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:20:21 +0000
Date: Tue, 1 Oct 2024 17:20:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
Message-ID: <20241001152015.GD28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727660754.git.wqu@suse.com>
 <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 361FB1F88A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Sep 30, 2024 at 11:20:30AM +0930, Qu Wenruo wrote:
> +	if (force_uptodate)
> +		goto read;
> +
> +	/* The dirty range fully cover the page, no need to read it out. */
> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +		return 0;
> +read:
> +	ret = btrfs_read_folio(NULL, folio);

Please avoid this pattern of an if and goto where it's simply jumping
around a block and the goto label is used only once.

