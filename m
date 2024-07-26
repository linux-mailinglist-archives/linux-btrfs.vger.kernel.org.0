Return-Path: <linux-btrfs+bounces-6727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963193D683
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8EB283DED
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886A17C7A6;
	Fri, 26 Jul 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gogcZ6Qd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqeVhEXh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gogcZ6Qd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqeVhEXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C317C226
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009824; cv=none; b=cK1BDgLGd+h6Q0fw5otVo/G5R9XnajGDNo8Z95EWVabV6b9XpxQvkR29LscXiZR7r0KCgdVVknYoEctroVkboq309jE8W4DijwHjh7aNrEPRN5tjfpSwCaIEOfBlk2otjaIA4uKq8DG0GBCvycmDGVgQguJCiqQff7tVgCcJpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009824; c=relaxed/simple;
	bh=PgLYfjdZ8rTRJLURkI49YxIESBz8iyiWmBqm/7GjEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSUY8kMIshONlRlDGAnvLzKlUXe5msRZuLjhPT9XEYCNfLZn9iVkOAWTMXJprM0IaNavB2VHwFYXw4J79321Uw67s3xyRUA9mOVdXbqbz/SSN7rKFlnS2PFe1FFmncieOGi23/e7URiLFA44SSqqqgacp+E199FGQm9OEFkePOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gogcZ6Qd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqeVhEXh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gogcZ6Qd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqeVhEXh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 236EE1FD00;
	Fri, 26 Jul 2024 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722009821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhlvayQ+VETRE5fH/+9kOA5BUwAHvamln48oOaU/6HI=;
	b=gogcZ6QdQul7byd3bxMo5Gv5ptjIgTfmmDsSd1j03c5ivmswetX9B8APGx8ylYYvxF0JlH
	vKN59LfpZdFGdMGfc0xYcuQXNfda3P26iC61j2MnMWzCq6jb55lK+z9DLHPAvIjfCjqnDm
	o4P0A3i9fmjX9lfj0BWuIIrEE/aYa6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722009821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhlvayQ+VETRE5fH/+9kOA5BUwAHvamln48oOaU/6HI=;
	b=DqeVhEXhCgjX9g4pEtnYfHLnm2wvjoDuJxTJfiK9Y4Jxrfo8NCqlLYl+G19wyeca/hzjjI
	VmH5puAecomnVWAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gogcZ6Qd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DqeVhEXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722009821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhlvayQ+VETRE5fH/+9kOA5BUwAHvamln48oOaU/6HI=;
	b=gogcZ6QdQul7byd3bxMo5Gv5ptjIgTfmmDsSd1j03c5ivmswetX9B8APGx8ylYYvxF0JlH
	vKN59LfpZdFGdMGfc0xYcuQXNfda3P26iC61j2MnMWzCq6jb55lK+z9DLHPAvIjfCjqnDm
	o4P0A3i9fmjX9lfj0BWuIIrEE/aYa6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722009821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhlvayQ+VETRE5fH/+9kOA5BUwAHvamln48oOaU/6HI=;
	b=DqeVhEXhCgjX9g4pEtnYfHLnm2wvjoDuJxTJfiK9Y4Jxrfo8NCqlLYl+G19wyeca/hzjjI
	VmH5puAecomnVWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03B4D1396E;
	Fri, 26 Jul 2024 16:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9auAN3Io2ZsOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 16:03:41 +0000
Date: Fri, 26 Jul 2024 18:03:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>,
	Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH v2] btrfs: avoid using fixed char array size for tree
 names
Message-ID: <20240726160339.GJ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 236EE1FD00

On Fri, Jul 19, 2024 at 06:56:46PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that using the latest trunk GCC, btrfs would cause
> unterminated-string-initialization warning:
> 
>   linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
> 
> [CAUSE]
> To print tree names we have an array of root_name_map structure, which
> uses "char name[16];" to store the name string of a tree.
> 
> But the following trees have names exactly at 16 chars length:
> - "BLOCK_GROUP_TREE"
> - "RAID_STRIPE_TREE"
> 
> This means we will have no space for the terminating '\0', and can lead
> to unexpected access when printing the name.
> 
> [FIX]
> Instead of "char name[16];" use "const char *" instead.
> 
> Since the name strings are all read-only data, and are all NULL
> terminated by default, there is not much need to bother the length at
> all.
> 
> Fixes: edde81f1abf29 ("btrfs: add raid stripe tree pretty printer")
> Fixes: 9c54e80ddc6bd ("btrfs: add code to support the block group root")
> Reported-by: Sam James <sam@gentoo.org>
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

