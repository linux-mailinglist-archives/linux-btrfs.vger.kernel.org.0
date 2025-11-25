Return-Path: <linux-btrfs+bounces-19344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36449C85FD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B58A04E1ECD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28932937C;
	Tue, 25 Nov 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfJmD/Mi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pw15L4Hq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HfJmD/Mi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pw15L4Hq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A4328B46
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088436; cv=none; b=sUFhsbi78jOz9ZVWu14O1uyESndEVCXwwAbBU35KyKJOjZVqb0VuGHdDIA3dtK4phvlZtobgToO8YMc4y4+NTWUb+ZlA8hTb9xIwShxXij3C2g6Bz3BPPHTI1LbpGC1/v3ipwff8Z5q+jxfCqU1i5qRHee1fU7A1d2GYjLTUStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088436; c=relaxed/simple;
	bh=tWeFJQXjvGUH75D2OvnXp9+G6H3Wf39Zx1HECP23DqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0S6SWy9rqG6mAkA0THkyn6TTpHPeHc5bpiTBylIdcCG9mw9dd0+qAf0NVfXUkYQxMxnuDJJyV6GxkinqD3V5xE/gc80gBALZKjMQaSQEWonEyngo9DVlr3Vjbu8B98NTk4bKreS43UfubBiojWUASy9qTzdYCmbyJ895pBuqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfJmD/Mi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pw15L4Hq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HfJmD/Mi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pw15L4Hq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5B2022778;
	Tue, 25 Nov 2025 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764088432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtopP64BXhMOSox3ky/v4aJ7+I69+R1yWjG7+1ih9wQ=;
	b=HfJmD/MiAjJxkWT4uqZg4EE3GDMFFmtvxHX1RmI7Ir66CT4MGsyjjrxPsOYFIn6qBj3FXO
	+tNGP45qCGVdUhJZv4LMVWy8E00xbY/q7vkOplTKkEiQSBkHSR8mjZfdEyMHgtWf4y7JSg
	rAgVstkiIxBb4RfKDz7d40gsE6cxJro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764088432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtopP64BXhMOSox3ky/v4aJ7+I69+R1yWjG7+1ih9wQ=;
	b=Pw15L4HqNXkU7XoxgtRk0alEjZPMH5IYEWU49FVFWySyFBA6Klao4/plog7Wp3YP8zYyuS
	TbZVWyrn+QaXf0CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764088432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtopP64BXhMOSox3ky/v4aJ7+I69+R1yWjG7+1ih9wQ=;
	b=HfJmD/MiAjJxkWT4uqZg4EE3GDMFFmtvxHX1RmI7Ir66CT4MGsyjjrxPsOYFIn6qBj3FXO
	+tNGP45qCGVdUhJZv4LMVWy8E00xbY/q7vkOplTKkEiQSBkHSR8mjZfdEyMHgtWf4y7JSg
	rAgVstkiIxBb4RfKDz7d40gsE6cxJro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764088432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtopP64BXhMOSox3ky/v4aJ7+I69+R1yWjG7+1ih9wQ=;
	b=Pw15L4HqNXkU7XoxgtRk0alEjZPMH5IYEWU49FVFWySyFBA6Klao4/plog7Wp3YP8zYyuS
	TbZVWyrn+QaXf0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF77A3EA63;
	Tue, 25 Nov 2025 16:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SaWILnDaJWl5YQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Nov 2025 16:33:52 +0000
Date: Tue, 25 Nov 2025 17:33:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun Yangkai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
Message-ID: <20251125163351.GX13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251122063516.4516-2-sunk67188@gmail.com>
 <20251122063516.4516-4-sunk67188@gmail.com>
 <7c74f2ae-3d8e-4743-b528-78861859cf09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c74f2ae-3d8e-4743-b528-78861859cf09@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Sat, Nov 22, 2025 at 02:51:08PM +0800, Sun Yangkai wrote:
> > -	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
> > -		ret = btrfs_inc_ref(trans, root, cow, true);
> > -		if (unlikely(ret))
> > -			btrfs_abort_transaction(trans, ret);
> > -	} else {
> > -		ret = btrfs_inc_ref(trans, root, cow, false);
> > -		if (unlikely(ret))
> > -			btrfs_abort_transaction(trans, ret);
> > -	}
> > -	if (ret) {
> > +	ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
> 
> Now we have something like this:
> 
> ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
> 
> As suggested by Daniel, it would be helpful to add a comment explaining why we
> pass true to @full_backref when dealing with a relocation tree (is_reloc_root).

The relocation tree is special in many ways, there was no comment in the
old code and I'm not sure how much explanation we'd need here because
the code dealing with relocation tree is scattered everywhere.

