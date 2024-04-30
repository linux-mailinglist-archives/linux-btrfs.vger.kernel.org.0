Return-Path: <linux-btrfs+bounces-4653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E808B81A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F8B21D7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE51A0AF8;
	Tue, 30 Apr 2024 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+ufuy65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0TOeBXf+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+ufuy65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0TOeBXf+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CAF9D6
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510278; cv=none; b=PLxXE4d5qn1MLovNa5lpM2c1PRlZRqsmRFLC0jKa2IvkJxDwhtOZwahUZYNoIMynq0YbymHgDoQxmlkkUuW9ltbBDFearoxGKu7xUryikaiv9n+4Vojd+peiCyy4yJzyZuUbfTx/g9BtxDOQgRCGH3DPAkIuEwn7KBNul7ry1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510278; c=relaxed/simple;
	bh=LE5Xqfi4v6OB8P4NBggIgswLmBYlFn55pzbGeguP9R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE3Zh9cKt7/aH5h2P3gp8Y3wihvmLtwSS/hUNwI5dvteQOFxUjf1re7Z7iF7JJcXfmSFIKFzZB03Mbw+0uNsUPUWIelB6Jqxb4izv6v5dRYO7BnA21Q+HF1ZcWJlaTc6N4qmluQg/GT60PoTAWZRFjlgJbBs4icgs6ehHB3dpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+ufuy65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0TOeBXf+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+ufuy65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0TOeBXf+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 322F534303;
	Tue, 30 Apr 2024 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714510274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NWa1KtlDCL+eWGqzUNmro37G1iEfPmf3ZPhq4AQWg=;
	b=i+ufuy65DKvuBDhEj3bOnav7IhdJlpqUD5I0eokME/oA27qVeuUPVWTaok2CiH8V1wtZvs
	aIkZVQCHd6sCFd/yaFugsM7Z1k/pDDWx3QNCoJNz2ADaHEbTWINbGX2A5PciK/tMTsr4f1
	ty2FG0A+70F/YFeFbmTQAzXENxAQQQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714510274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NWa1KtlDCL+eWGqzUNmro37G1iEfPmf3ZPhq4AQWg=;
	b=0TOeBXf+0whv7MlO3laCh55iq9WmBifufN32CUfiEup4Ba3RawduNKKvAPQCiwh2JnwmzR
	taWmNUUU/Xl07lBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i+ufuy65;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0TOeBXf+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714510274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NWa1KtlDCL+eWGqzUNmro37G1iEfPmf3ZPhq4AQWg=;
	b=i+ufuy65DKvuBDhEj3bOnav7IhdJlpqUD5I0eokME/oA27qVeuUPVWTaok2CiH8V1wtZvs
	aIkZVQCHd6sCFd/yaFugsM7Z1k/pDDWx3QNCoJNz2ADaHEbTWINbGX2A5PciK/tMTsr4f1
	ty2FG0A+70F/YFeFbmTQAzXENxAQQQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714510274;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NWa1KtlDCL+eWGqzUNmro37G1iEfPmf3ZPhq4AQWg=;
	b=0TOeBXf+0whv7MlO3laCh55iq9WmBifufN32CUfiEup4Ba3RawduNKKvAPQCiwh2JnwmzR
	taWmNUUU/Xl07lBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BFD8137BA;
	Tue, 30 Apr 2024 20:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AurDAsJZMWaIOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Apr 2024 20:51:14 +0000
Date: Tue, 30 Apr 2024 22:43:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	dan.carpenter@linaro.org
Subject: Re: [PATCH v2 12/15] btrfs: clean up our handling of refs == 0 in
 snapshot delete
Message-ID: <20240430204359.GO2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714397222.git.josef@toxicpanda.com>
 <3a191c918331eab2e7c47a3453f1ec0b8f5b5afe.1714397223.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a191c918331eab2e7c47a3453f1ec0b8f5b5afe.1714397223.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.61 / 50.00];
	BAYES_HAM(-1.40)[90.90%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 322F534303
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.61

On Mon, Apr 29, 2024 at 09:29:47AM -0400, Josef Bacik wrote:
> @@ -5775,7 +5789,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
>  				path->locks[level] = 0;
>  				return ret;
>  			}
> -			BUG_ON(wc->refs[level] == 0);
> +			if (unlikely(wc->refs[level] == 0)) {

This still lacks the tree unlock as reported by Dan Carpenter in
https://lore.kernel.org/all/96789032-42fb-41c0-b16c-561ac00ca7c3@moroto.mountain/

> +				btrfs_err(fs_info,
> +					  "bytenr %llu has 0 references, expect > 0",
> +					  eb->start);
> +				return -EUCLEAN;
> +			}
>  			if (wc->refs[level] == 1) {
>  				btrfs_tree_unlock_rw(eb, path->locks[level]);
>  				path->locks[level] = 0;

