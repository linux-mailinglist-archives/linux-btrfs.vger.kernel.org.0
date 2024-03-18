Return-Path: <linux-btrfs+bounces-3375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F02887F30D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027BCB220BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD35A0E9;
	Mon, 18 Mar 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Px22ufHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ATVvlW9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Px22ufHK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ATVvlW9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8E59B64
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800530; cv=none; b=e0rFb2ungUq6XAMxcDR11FDgyxSq/o0yE90rgJugGSQ3+GVBRgtCj8/kB8yjObIjEHkRcuHpO50Zu0DoPa8MCMNjHloUb8GX+0ZzsSo58UGAyyIoUI2WdrrITPc261pgE0sAAL9++keuSVwLg7tKnhcsN2ZHS5C0/8VunSE5ADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800530; c=relaxed/simple;
	bh=bzVC8XEHdIr2uieGqAuNCcN8jdB+KHB/h7DeE0Ayxck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9cXvcuRqtzlY1MCw2mWunZiLUulrZDcaBfG3woQwRBp0gjjwmGBfIU8BWW8AOiPrK8VBZ09NlmEK+vkgWiN7yYI6IypeDiEg3w7Qv6hHocTCyx+8WsOQvO9fUAoJklJLxS/FHGBUnQyvzCmCI+uMcL03eWiIbUMIUpmDJnjN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Px22ufHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ATVvlW9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Px22ufHK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ATVvlW9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2C705CBCB;
	Mon, 18 Mar 2024 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710800526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6rfIFHcv5Eip3R7Q9exBSMIwrjsPilqRS76rE3HMMc=;
	b=Px22ufHK1iE4uGBiIGyPcw8I7PAgh60eH7E91C6GDoLf84ed/b4dhWeBEJF4gJFZ9WcwU7
	MmOYSQhJmcqIOigS06Rr8CYvVY4i9A70llx1rdTVd8cTLmjLlaqfG1IeFLiBcOCmah6aSP
	6asC9eUtTa/Ls1ktiXsx1Nu6sjuJ8GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710800526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6rfIFHcv5Eip3R7Q9exBSMIwrjsPilqRS76rE3HMMc=;
	b=6ATVvlW9E+OsmgOws+voGpVr1daeCRZbk6ipPcgDou9f6EA1myJa94zlME6fmP7XfENQdv
	rN4NO0OB+s12ucAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710800526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6rfIFHcv5Eip3R7Q9exBSMIwrjsPilqRS76rE3HMMc=;
	b=Px22ufHK1iE4uGBiIGyPcw8I7PAgh60eH7E91C6GDoLf84ed/b4dhWeBEJF4gJFZ9WcwU7
	MmOYSQhJmcqIOigS06Rr8CYvVY4i9A70llx1rdTVd8cTLmjLlaqfG1IeFLiBcOCmah6aSP
	6asC9eUtTa/Ls1ktiXsx1Nu6sjuJ8GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710800526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6rfIFHcv5Eip3R7Q9exBSMIwrjsPilqRS76rE3HMMc=;
	b=6ATVvlW9E+OsmgOws+voGpVr1daeCRZbk6ipPcgDou9f6EA1myJa94zlME6fmP7XfENQdv
	rN4NO0OB+s12ucAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD3DC1349D;
	Mon, 18 Mar 2024 22:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KzkfKo6++GXiUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 22:22:06 +0000
Date: Mon, 18 Mar 2024 23:14:49 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid pointless wake ups of drew lock readers
Message-ID: <20240318221449.GJ16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ed6897d89e53696370450d72a366f96ad954edbd.1710760179.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6897d89e53696370450d72a366f96ad954edbd.1710760179.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.24
X-Spamd-Result: default: False [-1.24 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.24)[72.78%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 11:11:56AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When unlocking a write lock on a drew lock, at btrfs_drew_write_unlock(),
> it's pointless to wake up tasks waiting to acquire a read lock if we
> didn't decrement the 'writers' counter down to 0, since a read lock can
> only be acquired when the counter reaches a value of 0. Doing so is
> harmless from a functional point of view, but it's not efficient due to
> unnecessarily waking up tasks just for them to sleep again on the
> waitqueue.
> 
> So change this to wake up readers only if we decremented the 'writers'
> counter to 0.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

