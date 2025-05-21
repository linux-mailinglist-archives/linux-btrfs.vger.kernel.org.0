Return-Path: <linux-btrfs+bounces-14156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE0ABECC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78264A1027
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5323504B;
	Wed, 21 May 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jq4P79YK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rsXfn0gf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jq4P79YK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rsXfn0gf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EC22B8C3
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811203; cv=none; b=hBvv/enkEcwt1XFtFRXMVpUho7hel2DgjQq3Y13iliVyxKeKkQS3/UBALNQ1vz3sbGpuG+X/2eGRQLv8TRBANp3zPjcRSpNGnAox5FDpFdLMzjPamV4AyogyuQLC0Gj/FdeEw5/oQLPjwhsnPqbOjQkKbjA56djlMySuY2kIkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811203; c=relaxed/simple;
	bh=aPROOibqt7OOY7UY7vh6s2l/hWo7wPzeblL0fff00yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgjWti+Nk2z8NpjFaBlzte3tVHQ5/HdsAJPOrVBwmWFvIreuYR+PNzR+z61iKJfbCWf5L2F5/GtwAI6TlYLYZD3J3VpGWgy5LXsKJKsdN2AXEtfaGK6r9DT2AndHlcWwM9j1ofa5+lHQ90Xz/jV/uO3/jCu5yrGA69DJoBi+x88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jq4P79YK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rsXfn0gf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jq4P79YK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rsXfn0gf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B859021A3E;
	Wed, 21 May 2025 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747811199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXjDJXLnXeJnl2whXnV0KS1rM85ENd79trWuk4mT1bw=;
	b=Jq4P79YKw+7dqfw0qllwerlndQQn3qaxtsb0o5xrATMakKDfeHBDKnosT1i83FkEuyMGVo
	suqSSerPcizbh9wBliIXMcIG9JKBJtnmc6SkxKP7CIYgTylg7WEiu6qjNykCHMtGX8Uzxt
	64qhfAwaRvHrz36wU06hBOw4i2kdz/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747811199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXjDJXLnXeJnl2whXnV0KS1rM85ENd79trWuk4mT1bw=;
	b=rsXfn0gfBh9Aqy+3tx52oZay5uJFyUaH+RGzOFw4sidPsSv6b9i/3yFf8FlgWNaD4/law3
	qbm3RY3upM6wjCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747811199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXjDJXLnXeJnl2whXnV0KS1rM85ENd79trWuk4mT1bw=;
	b=Jq4P79YKw+7dqfw0qllwerlndQQn3qaxtsb0o5xrATMakKDfeHBDKnosT1i83FkEuyMGVo
	suqSSerPcizbh9wBliIXMcIG9JKBJtnmc6SkxKP7CIYgTylg7WEiu6qjNykCHMtGX8Uzxt
	64qhfAwaRvHrz36wU06hBOw4i2kdz/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747811199;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXjDJXLnXeJnl2whXnV0KS1rM85ENd79trWuk4mT1bw=;
	b=rsXfn0gfBh9Aqy+3tx52oZay5uJFyUaH+RGzOFw4sidPsSv6b9i/3yFf8FlgWNaD4/law3
	qbm3RY3upM6wjCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A869613888;
	Wed, 21 May 2025 07:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G6bpKH97LWi+FwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 May 2025 07:06:39 +0000
Date: Wed, 21 May 2025 09:06:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	panchuang@vivo.com
Subject: Re: [PATCH 01/13] btrfs: update btrfs_insert_inode_defrag to to use
 rb helper
Message-ID: <20250521070638.GA3687@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250422081504.1998809-1-frank.li@vivo.com>
 <20250422112137.GA3659@suse.cz>
 <098cfd6e-83c7-4b7f-aeff-7199b751bdb7@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <098cfd6e-83c7-4b7f-aeff-7199b751bdb7@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, May 20, 2025 at 01:14:00PM +0800, Yangtao Li wrote:
> Hi David，
> 
> The new patchset has been send. Could you please consider taking a look？

Yes, next week once the merge window opens.

