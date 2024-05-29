Return-Path: <linux-btrfs+bounces-5354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E485E8D3A7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1B283244
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DC18133A;
	Wed, 29 May 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zhEmngZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GwRRaGn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zhEmngZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GwRRaGn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF7181325
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995775; cv=none; b=MUaLKxpCAHIp4ozjwiXc0CCC7ZSdwo5bQvlqIeRqI2DqzkYO1lkMqzdzUdZ/eVwZCRjAtMwqUD4SbKqF2PaRUOHCO7joU+8r8/tlL0MP5mBTxwWHL6uIMlr9DTzXVmMqftD+3h6Fe01YrlSWyHtuskfwxkcPT2Cyh5/X+xgzllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995775; c=relaxed/simple;
	bh=x9xANo3t6vNM1rWyUzaLdpgs1ADJGTLkcs07XJGUWDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOXdLsLUuv6lX8ImGlzYpZqLJNNJagyj26Sy/BQWhrqD48I8HwuWhdWX/3pKP8VUnQsp4jtHyIpsZE2iyie7VHH6D1fYnO5e42cg5EbeLg3+1VKRgR3whHCq6g6puMC/XkUOKQsB1NxlIgDD+zJM2ujqPqDpTdCfaJti1mwV+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zhEmngZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GwRRaGn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zhEmngZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GwRRaGn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 095912058E;
	Wed, 29 May 2024 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716995771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0qrtGWkIdVJD5OWkLK8exj+o+KsNEXFfuDNS43L7UM=;
	b=zhEmngZs2BQbx4tTGW5/vdK2u+yZej80Y8UPDC8wNF+fKWg3H2+cKOPFvoP6iJMyT3QRep
	z5QyGc72at1IFbgcGwsUvaZdcl8rO51iW7cBJ8gddmkwSp6bQdniUfFSbCuKlBmzU3WVhx
	hpjp1CZtb6V1JTb6+RkrDcWPafhBXBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716995771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0qrtGWkIdVJD5OWkLK8exj+o+KsNEXFfuDNS43L7UM=;
	b=0GwRRaGnIyaC7PYeYum02+uGrg9XcZxPzLmngCaw61edplyr5wU/jUG4tuY8w68MHbG6Y2
	HqEd4QwqlXrsWHBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zhEmngZs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0GwRRaGn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716995771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0qrtGWkIdVJD5OWkLK8exj+o+KsNEXFfuDNS43L7UM=;
	b=zhEmngZs2BQbx4tTGW5/vdK2u+yZej80Y8UPDC8wNF+fKWg3H2+cKOPFvoP6iJMyT3QRep
	z5QyGc72at1IFbgcGwsUvaZdcl8rO51iW7cBJ8gddmkwSp6bQdniUfFSbCuKlBmzU3WVhx
	hpjp1CZtb6V1JTb6+RkrDcWPafhBXBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716995771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0qrtGWkIdVJD5OWkLK8exj+o+KsNEXFfuDNS43L7UM=;
	b=0GwRRaGnIyaC7PYeYum02+uGrg9XcZxPzLmngCaw61edplyr5wU/jUG4tuY8w68MHbG6Y2
	HqEd4QwqlXrsWHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA9C513A6B;
	Wed, 29 May 2024 15:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tT/nOLpGV2ZCcAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 29 May 2024 15:16:10 +0000
Date: Wed, 29 May 2024 17:16:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reduce ordered_extent_lock section at
 btrfs_split_ordered_extent()
Message-ID: <20240529151605.GL8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <719ec85c5bda1d711067e5b1c20a2de336240140.1715688262.git.fdmanana@suse.com>
 <6bd1663678f119791c1e2b6071f4973f35dcf049.1715708811.git.fdmanana@suse.com>
 <20240528222252.GJ8631@twin.jikos.cz>
 <CAL3q7H7BeHGskUeNf+mAbGXPqBMWzf-34xftiEuwdQz8GoCyXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7BeHGskUeNf+mAbGXPqBMWzf-34xftiEuwdQz8GoCyXQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 095912058E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, May 29, 2024 at 12:51:13PM +0100, Filipe Manana wrote:
> On Tue, May 28, 2024 at 11:22 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, May 14, 2024 at 06:54:18PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > There's no need to hold the root's ordered_extent_lock for so long at
> > > btrfs_split_ordered_extent(). We don't need to hold it in order to modify
> > > the inode's rb tree of ordered extents, to modify the trimmed ordered
> > > extent and move checksums between the trimmed and the new ordered extent.
> > > That's only increasing contention of the root's ordered_extent_lock for
> > > other writes that are starting or completing.
> > >
> > > So lock the root's ordered_extent_lock only before we add the new ordered
> > > extent to the root's ordered list and increment the root's counter for the
> > > number of ordered extents.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Reviewed-by: David Sterba <dsterba@suse.com>
> 
> This needs to be dropped for now as there are some problems there.
> I'll address those in a patch set.

I had the patch in my testing branch and did not notice anything that
would point to this patch but I did not do any target testing.

Moving the IRQ context was fixed in v2, the pattern of independent
ranges of ordered_tree_lock and ordered_extent_lock changes the
semantics, another case is in insert_ordered_extent() but it could be
fine there.

