Return-Path: <linux-btrfs+bounces-13625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1237AA72FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF5E7A80F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A725A327;
	Fri,  2 May 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ca3UVPVP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rb5t2w7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ca3UVPVP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1rb5t2w7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86326256C9D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191331; cv=none; b=ocYbqDDcLV4waJMsLsv2GnQ2qnPpHc1SkkmeplDp7kKmdR4Ct/SefqvRVVjADA6nM9Q30rgf8o3/N8uIrEbMzQwxdDRxFpm5r1U3fy2wUapxfYpKjkzm2M0Bmjtyp/NF3UCRtd9iQoQP9mWdveZVw+TaXWmm45c0na4KY80OHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191331; c=relaxed/simple;
	bh=BWNKSigP89QWytwaeh5joGRuA5JywaQu4QZZJSHSPsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNOe23AW/ifXc0se2OEtl+vWM0uKDIHk2Zct0S+v2fHS/C1NstjULvxyJKiZvhgdTdYI+wbmBqJhU8bf32GnvtdXuaDhXf3nLMiahOgI36+JMJUsT7VjwZQLkyCpYyXJGPCYllo2nQVtUgQF+46eye2sWWe/uHAdUhmVit1+m6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ca3UVPVP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rb5t2w7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ca3UVPVP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1rb5t2w7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 81DEF1F801;
	Fri,  2 May 2025 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746191324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coGTOfKsIkQkFzaUJikzP4OqEiV9ieiGK/6h4SqzkY=;
	b=ca3UVPVPux50fus+a7q0Uk48dBc3f0G+9ZMF9gZDs1MhaRVR36ewcdkhnPa6HxyhRPWbr6
	HnXLupqdqzf8P62HKDShB894adQJUd9AS+Ct5QQy8H56e4rtbAnRY6cUX4G7Izi3hfCaQu
	Z+r122mfLv0mjda3HcKnLDk/CXjOPt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746191324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coGTOfKsIkQkFzaUJikzP4OqEiV9ieiGK/6h4SqzkY=;
	b=1rb5t2w7BK42TRWpJAp/BVlnWBcQbQfqSrYH6cuJTSbLmNRsccWMBMXuTb5czzToahHyA+
	s1Wzr66Gc5YcfOCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746191324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coGTOfKsIkQkFzaUJikzP4OqEiV9ieiGK/6h4SqzkY=;
	b=ca3UVPVPux50fus+a7q0Uk48dBc3f0G+9ZMF9gZDs1MhaRVR36ewcdkhnPa6HxyhRPWbr6
	HnXLupqdqzf8P62HKDShB894adQJUd9AS+Ct5QQy8H56e4rtbAnRY6cUX4G7Izi3hfCaQu
	Z+r122mfLv0mjda3HcKnLDk/CXjOPt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746191324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coGTOfKsIkQkFzaUJikzP4OqEiV9ieiGK/6h4SqzkY=;
	b=1rb5t2w7BK42TRWpJAp/BVlnWBcQbQfqSrYH6cuJTSbLmNRsccWMBMXuTb5czzToahHyA+
	s1Wzr66Gc5YcfOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69A4A13687;
	Fri,  2 May 2025 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOelGNzDFGi1FQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 13:08:44 +0000
Date: Fri, 2 May 2025 15:08:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/13] btrfs: zoned: split out space_info for
 dedicated block groups
Message-ID: <20250502130843.GQ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745375070.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 11:43:40AM +0900, Naohiro Aota wrote:
> As discussed in [1], there is a longstanding early ENOSPC issue on the
> zoned mode even with simple fio script. This is also causing blktests
> zbd/009 to fail [2].
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1731571240.git.naohiro.aota@wdc.com/
> [2] https://github.com/osandov/blktests/issues/150
> 
> This series is the second part to fix the ENOSPC issue. This series
> introduces "space_info sub-space" and use it split a space_info for data
> relocation block group and metadata tree-log block group.
> 
> Current code assumes we have only one space_info for each block group type
> (DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
> manage special block groups.
> 
> One example is handling the data relocation block group for the zoned mode.
> That block group is dedicated for writing relocated data and we cannot
> allocate any regular extent from that block group, which is implemented in
> the zoned extent allocator. That block group still belongs to the normal
> data space_info. So, when all the normal data block groups are full and
> there are some free space in the dedicated block group, the space_info
> looks to have some free space, while it cannot allocate normal extent
> anymore. That results in a strange ENOSPC error. We need to have a
> space_info for the relocation data block group to represent the situation
> properly.
> 
> Changes:
> - v4:
>   - Pass down space_info from top of call tree, instead querying it at the bottom.
>   - Make BTRFS_SUB_GROUP_* id distinct.
>   - Use treelog_rsv on regular btrfs too.
>   - Fix NULL dereference bug.
>   - Some format and commit log fix.

The patches have been in linux-next, I've moved them to for-next. The
non-zoned mode is mostly unaffected.

