Return-Path: <linux-btrfs+bounces-10689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C099FFA00
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CE97A1F0C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D068D1AF0DC;
	Thu,  2 Jan 2025 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="270rZuGs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfzawlft";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="270rZuGs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfzawlft"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE411EB2F
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826294; cv=none; b=l016n4Wc0QSkG9G8SWU1kl2ZgmNNMM47xiMGF9SIOZ8RqxILG8s4VIbLUI3rlmO1gTqUH2X7UYiOnJTlUHrnMDlEeEZdHduSpGnZlrx16vFISkqUY6/3tL09OW5TKZgafVcO0gK0y7UvJEiwh0DY+FQ1d4+2tP3pFrznaulTC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826294; c=relaxed/simple;
	bh=5t+LYBzKu7JaEO+DrfZ59AcEtk/P/3VpUC1fM1im1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ/IeNmQUJcIjADLHse94c6dgUFAunnwkO4iAnutc3jewrzLCykK3jaUmLYGiyyhIfqF0/xgeWL5kM5Z8gjJpTi90nXXshTfx41xC0ZoWuVD/eR/q2ZLPRpAS3rwdzN+rx+HVBQmAsHAn2HO64dpWQCuMwsJAUey96/+TGPx9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=270rZuGs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfzawlft; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=270rZuGs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfzawlft; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4996E21137;
	Thu,  2 Jan 2025 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735826290;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlbZwrjZAwoB5dnGlHhOP3H97B7NvDunH+LSsvZKWZ8=;
	b=270rZuGsaX626oiqPAPkqF5WZJckQ937PGCqaG8UqsT+/2D0HBIFsVi5aiySmsKi9fDrWj
	5neenHX3FJdjrhTvXMLlvtT1HMxfmXp55enWdAENmZNIslR+5Q4O3MP57KFKgpPGtJ/afj
	oRMexx6fYbrV7t3By7OL29xYEYz7xpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735826290;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlbZwrjZAwoB5dnGlHhOP3H97B7NvDunH+LSsvZKWZ8=;
	b=wfzawlftYb2L5yjj0237lbHJpCjzRQDz//BHvNFhRVhhrmD99Em+Y/DI95k1g0LNxJSEeJ
	dzO+ddpNVa1UpfBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=270rZuGs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wfzawlft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735826290;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlbZwrjZAwoB5dnGlHhOP3H97B7NvDunH+LSsvZKWZ8=;
	b=270rZuGsaX626oiqPAPkqF5WZJckQ937PGCqaG8UqsT+/2D0HBIFsVi5aiySmsKi9fDrWj
	5neenHX3FJdjrhTvXMLlvtT1HMxfmXp55enWdAENmZNIslR+5Q4O3MP57KFKgpPGtJ/afj
	oRMexx6fYbrV7t3By7OL29xYEYz7xpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735826290;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wlbZwrjZAwoB5dnGlHhOP3H97B7NvDunH+LSsvZKWZ8=;
	b=wfzawlftYb2L5yjj0237lbHJpCjzRQDz//BHvNFhRVhhrmD99Em+Y/DI95k1g0LNxJSEeJ
	dzO+ddpNVa1UpfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26C7A132EA;
	Thu,  2 Jan 2025 13:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id swpACXKbdmdWDQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Jan 2025 13:58:10 +0000
Date: Thu, 2 Jan 2025 14:58:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
	wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v5 00/10] raid1 balancing methods
Message-ID: <20250102135808.GP31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1735748715.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4996E21137
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Jan 02, 2025 at 02:06:29AM +0800, Anand Jain wrote:
> v5:
> Fixes based on review comments:  
>   . Rewrite `btrfs_read_policy_to_enum()` using `sysfs_match_string()`
>     and `strncpy()`.
>   . Rewrite the round-robin method based on read counts.
>   . Fix the smatch indentation warning.
>  - Change the default minimum contiguous device read size for round-robin
>    from 256K to 192K, as the latter performs slightly better.

This depends on the device and load and the read pattern so any number
is fine, I'd rather stick to something that looks sensible if the
difference is slight. Changing that later based on extensive benchmarks.

>  - Introduce a framework to track filesystem read counts. (New patch)
>  - Reran defrag performance numbers
>       $ xfs_io -f -d -c 'pwrite -S 0xab 0 1000000000' /btrfs/P6B
>       $ time -p btrfs filesystem defrag -r -f -c /btrfs
> 
> |         | Time  | Read I/O Count  | gain  |
> |         | Real  | devid1 | devid2 | w-PID |
> |---------|-------|--------|--------|-------|
> | pid     | 11.14s| 3808   | 0      |  -    |
> | rotation|       |        |        |       |
> |   196608|  6.54s| 2532   | 1276   | 41.29%|
> |   262144|  8.42s| 1907   | 1901   | 24.41%|
> | devid:1 | 10.95s| 3807   | 0      | 1.70% |
> 
> v4:

As we're at rc5 we need to get this series to for-next soon, before rc6
is released this Sunday. I'll do one review pass and then move the
patches to for-next. I'm not convinced we should do the module parameter
but as this is to ease testing let's do it.

