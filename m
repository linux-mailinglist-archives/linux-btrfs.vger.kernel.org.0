Return-Path: <linux-btrfs+bounces-11050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCFA1AC7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 23:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A451188CF53
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2831CD210;
	Thu, 23 Jan 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ows8RhBP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWwtOIAL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ows8RhBP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWwtOIAL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF347A7E
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670287; cv=none; b=Y9guBtJ0lDxRxeERe/YKObaw0QtduBytjtOjacsKFbY2UG/zadA9GJf2xyGQQAC1yvXWhdwmURhh5ZKL2CI/0T/q4+C+QKRe7Oo00Jr3ST0yf3xdbSmwdOQR4y1uVks5nUj8+90VEQuqXIf0WrYYCuCLLR7Ogltxavzjp/vWnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670287; c=relaxed/simple;
	bh=xi2nkcUJPAmB/0EpxPEfhdtchVNs9ZVAKvKZzxmsqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVIaslo3kJCIwylr1Zu13CQKEGKxveqWwc3jmZ15qhXlon7hNqStFAr+VVkgfbFcU40NkQuUT5J/SJ/hBBYqLwHgPwe8siAJEG6ZZpB8NuPVseCo4dcFgXNzkQ4jwKlmxYu3TsRduNt2AQx3KdJPdh6Q5AGpvtC1NIG+zeRRsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ows8RhBP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWwtOIAL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ows8RhBP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWwtOIAL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14D922119F;
	Thu, 23 Jan 2025 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737670284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3EtUO6HzbM2acuz/iLAWIX5aEzzPYI3MZ108V7nxVc=;
	b=ows8RhBPWbPzdFyHJavG2jHhXbdwBqIe8LwrNi6JBAB5yDtgoQ5KV1Er7VQ/ObqP2YE9Uk
	V6udqBS1HC2hGyaiEoM9NNQALPuNeTlnR9F/YzT7clmtX8d9XOa/M1oRzuIB6mCetvkLru
	kH1WNf6Ig9lvQ8oLkeqMCDBjKPZCaSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737670284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3EtUO6HzbM2acuz/iLAWIX5aEzzPYI3MZ108V7nxVc=;
	b=FWwtOIALsP12lT5/hyjeS+XwCQTgk/PlDB8OYg/ArVpsPd8sKN8wT07U8+I2KS3uFkbkK4
	+lCbHVvucedP1sDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737670284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3EtUO6HzbM2acuz/iLAWIX5aEzzPYI3MZ108V7nxVc=;
	b=ows8RhBPWbPzdFyHJavG2jHhXbdwBqIe8LwrNi6JBAB5yDtgoQ5KV1Er7VQ/ObqP2YE9Uk
	V6udqBS1HC2hGyaiEoM9NNQALPuNeTlnR9F/YzT7clmtX8d9XOa/M1oRzuIB6mCetvkLru
	kH1WNf6Ig9lvQ8oLkeqMCDBjKPZCaSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737670284;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E3EtUO6HzbM2acuz/iLAWIX5aEzzPYI3MZ108V7nxVc=;
	b=FWwtOIALsP12lT5/hyjeS+XwCQTgk/PlDB8OYg/ArVpsPd8sKN8wT07U8+I2KS3uFkbkK4
	+lCbHVvucedP1sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E23891351A;
	Thu, 23 Jan 2025 22:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5f9BNou+kmfWbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 Jan 2025 22:11:23 +0000
Date: Thu, 23 Jan 2025 23:11:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250123221122.GO5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 22, 2025 at 12:39:21PM +0000, Filipe Manana wrote:
> But now we always increment and then do the check, so after some calls
> to btrfs_get_free_objectid() we wrap around the counter due to
> overflow and eventually allow reusing already assigned object IDs.
> 
> I'm afraid the lock is still needed because of that. To make it more
> lightweight maybe switch the mutex to a spinlock.

For inode number allocations a spinlock should work. For tree ids we may
still need the mutex:

btrfs_init_fs_root
  mutex
  btrfs_init_root_free_objectid
    btrfs_alloc_path
    btrfs_search_slot

The difference is that inode number allocations are per-fs root, while
the subvolume ids are exclusively in the tree_root.

