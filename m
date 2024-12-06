Return-Path: <linux-btrfs+bounces-10101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E989E7924
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C902C164B64
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00671C5483;
	Fri,  6 Dec 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRD3tLDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbkh9rnR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oRD3tLDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbkh9rnR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831651C5480
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513943; cv=none; b=fclK2kHbHzj7/YncTdgY17yKYi0skjcNSsgWfcIwGamZMwG4aATXGr3Kuci7K8AfASe7iLvWZRWdi7tnzKy2rnVqpHqrrWor+XO+GX7vKFkSXx9xqMcHSc25V7pdx2aCT2oY5J1gvMyfcAbou1+c8sPIPxVdodHDWi3299BFsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513943; c=relaxed/simple;
	bh=XWJPAcDOxZfUzGRDtw7CFoV8PJyNxBNuOGiJbbidgoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnjweaSWui/pCLjsURFpOS76Y1YENlYKU+ME4L6kKqk6h6bvKssAouprNJYgUhbTqgiBdpURsxKasZ595SYxwyMt1jRY22ZsE6YlvmjuHS1ZbYh69WFdMHHZsZk6Co7F0/acuxToangR8feks+8escwCXwOZk/icQToV10W6x4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRD3tLDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbkh9rnR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oRD3tLDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbkh9rnR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98FB0211E7;
	Fri,  6 Dec 2024 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733513939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osKyc8FJNOVkBaSRUKv6C0YgKlfsO+xsoONJshQ0Htk=;
	b=oRD3tLDWN6mKvscMLQFjEDpigvJoVLHcWnirZ4n1zj0tp7AuqnE+NK6hAOMU1H/uAseVU+
	AiyXasKlDxzZJoUfsqgH47EEhtyBkatDfu0x2Zs8DICCX9I0PTfSVIllnStGRD2FStChIP
	pZZscPKdWbZel24byyw8iLPYQW50sJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733513939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osKyc8FJNOVkBaSRUKv6C0YgKlfsO+xsoONJshQ0Htk=;
	b=zbkh9rnRoWoLAmUUZEpcQRq1+Id2NlAQ8Mf+FQN5tVDG2XHSe7uhaEl3uFC8FSOv72xmwt
	PuTk8vah/AK/QBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733513939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osKyc8FJNOVkBaSRUKv6C0YgKlfsO+xsoONJshQ0Htk=;
	b=oRD3tLDWN6mKvscMLQFjEDpigvJoVLHcWnirZ4n1zj0tp7AuqnE+NK6hAOMU1H/uAseVU+
	AiyXasKlDxzZJoUfsqgH47EEhtyBkatDfu0x2Zs8DICCX9I0PTfSVIllnStGRD2FStChIP
	pZZscPKdWbZel24byyw8iLPYQW50sJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733513939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osKyc8FJNOVkBaSRUKv6C0YgKlfsO+xsoONJshQ0Htk=;
	b=zbkh9rnRoWoLAmUUZEpcQRq1+Id2NlAQ8Mf+FQN5tVDG2XHSe7uhaEl3uFC8FSOv72xmwt
	PuTk8vah/AK/QBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BEF813647;
	Fri,  6 Dec 2024 19:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zXzAHdNSU2edQQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 19:38:59 +0000
Date: Fri, 6 Dec 2024 20:38:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/10] btrfs: backref cache cleanups
Message-ID: <20241206193854.GL31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 03, 2024 at 11:43:02AM -0400, Josef Bacik wrote:
> Hello,
> 
> This is the followup to the relocation fix that I sent out earlier.  This series
> cleans up a lot of the complicated things that exist in backref cache because we
> were keeping track of changes to the file system during relocation.  Now that we
> do not do this we can simplify a lot of the code and make it easier to
> understand.  I've tested this with the horror show of a relocation test I was
> using to trigger the original problem.  I'm running fstests now via the CI, but
> this seems solid.  Hopefully this makes the relocation code a bit easier to
> understand.  Thanks,
> 
> Josef
> 
> Josef Bacik (10):
>   btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error
>     handling
>   btrfs: remove the changed list for backref cache
>   btrfs: add a comment for new_bytenr in bacref_cache_node
>   btrfs: cleanup select_reloc_root
>   btrfs: remove clone_backref_node
>   btrfs: don't build backref tree for cowonly blocks
>   btrfs: do not handle non-shareable roots in backref cache
>   btrfs: simplify btrfs_backref_release_cache
>   btrfs: remove the ->lowest and ->leaves members from backref cache
>   btrfs: remove detached list from btrfs_backref_cache

The patches have been in misc-next as I've been expecting an update. We
want the cleanups so I've applied the series to for-next. I've removed
th ASSERT(0) callls, we need proper macros/functions in case you really
want to see something fail during development. As the errors are EUCLEAN
they'll bubble up eventually with some noisy message so I hope we're not
losing much.

