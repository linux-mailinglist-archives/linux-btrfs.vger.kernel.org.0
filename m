Return-Path: <linux-btrfs+bounces-1798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B383C7F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA4C1F27B66
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402D129A83;
	Thu, 25 Jan 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hkw75Y7r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utZbwYcp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hkw75Y7r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utZbwYcp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77470129A7B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200125; cv=none; b=E0HOXX5Xjt9oyIzYSZDW5SmOqQ6W3jsBYjy1/bOcoapvyzZpq2griBLnSr47eR8vf1LR5GQkuFn48CI9z8ONEBrkDoqbpjI9V7+/uKWO0LwjCLbBreFhsItsA5mkKqPao+u/vo6eTLVpApWqjtZ1ZW1Tk892UjUEs/3dAAI/Umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200125; c=relaxed/simple;
	bh=dgv5hYgJph9ZBfFrRjPy2oFoGxtYx5jWaub0m/vd3og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/WsIegktOY0VXSjclrLkCqnZ1syrSwMLvvGe1Ip+8dhli3Jp/Aq/+rINE38gFDRdZnrYV8xHZXeZ2WH8B4FPED9GR5UA7RxmZKfRdT+waA8Wo2MlWn33jAVelY28G0RllkVvuX2fuuoDHdUfuLLaSr620XopwOvmQLyKSl+yqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hkw75Y7r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utZbwYcp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hkw75Y7r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utZbwYcp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A969A21EFC;
	Thu, 25 Jan 2024 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVprpDtZP0elaPD31NI11BWggPqJmteCs3/MWjQnzA=;
	b=Hkw75Y7rMhaBpy3CAMHDWtA4FNoXGQDFmzGoWZB40jxXmYwvXUnSWGTCClWdDZ2RUIhrbP
	nZMziuXxvs6mU7I7ly0BiHFEjWvk9w8q4G62C8SKCXgbuPxl83NVA88RufOcDVwCZXLaLK
	2M6DlQ1N8NqCtGCNzCAZ3eamfhWgPv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVprpDtZP0elaPD31NI11BWggPqJmteCs3/MWjQnzA=;
	b=utZbwYcpFPoNhL/JAxKTlY/u6O/P8pyc2bgXyyzqrO9CZmn9vL0sSItSdLDg8cS4gnF4zP
	beBU0qV0fDaJFcDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706200121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVprpDtZP0elaPD31NI11BWggPqJmteCs3/MWjQnzA=;
	b=Hkw75Y7rMhaBpy3CAMHDWtA4FNoXGQDFmzGoWZB40jxXmYwvXUnSWGTCClWdDZ2RUIhrbP
	nZMziuXxvs6mU7I7ly0BiHFEjWvk9w8q4G62C8SKCXgbuPxl83NVA88RufOcDVwCZXLaLK
	2M6DlQ1N8NqCtGCNzCAZ3eamfhWgPv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706200121;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiVprpDtZP0elaPD31NI11BWggPqJmteCs3/MWjQnzA=;
	b=utZbwYcpFPoNhL/JAxKTlY/u6O/P8pyc2bgXyyzqrO9CZmn9vL0sSItSdLDg8cS4gnF4zP
	beBU0qV0fDaJFcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9222613649;
	Thu, 25 Jan 2024 16:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UH5BIzmMsmWyegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 16:28:41 +0000
Date: Thu, 25 Jan 2024 17:28:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Message-ID: <20240125162818.GP31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
 <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hkw75Y7r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=utZbwYcp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: A969A21EFC
X-Spam-Flag: NO

On Thu, Jan 25, 2024 at 02:33:53PM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/1/25 07:48, David Sterba wrote:
> > The btrfs_find_root() looks up a root by a key, allowing to do an
> > inexact search when key->offset is -1.  It's never expected to find such
> > item, as it would break allowed the range of a root id.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/root-tree.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index ba7e2181ff4e..326cd0d03287 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
> >   		if (ret > 0)
> >   			goto out;
> >   	} else {
> > -		BUG_ON(ret == 0);		/* Logical error */
> > +		/*
> > +		 * Key with offset -1 found, there would have to exist a root
> > +		 * with such id, but this is out of the valid range.
> > +		 */
> > +		if (ret == 0) {
> > +			ret = -EUCLEAN;
> > +			goto out;
> > +		}
> 
> Considering all root items would already be checked by tree-checker,
> I'd prefer to add an extra "key.offset == (u64)-1" check, and convert
> this to ASSERT(ret == 0), so that we won't need to bother the impossible
> case (nor its error messages).

I did not think about tree-checker in this context and it actually does
verify offsets of the item keys so it's already prevented, assuming such
corrupted issue would come from the outside.

Assertions are not very popular in release builds and distros turn them
off. A real error handling prevents propagating an error further to the
code, so this is for catching bugs that could happen after tree-checker
lets it pass with valid data but something sets wrong value to offset.

The reasoning I'm using is to have full coverage of the error values as
real handling with worst case throwing an EUCLEAN. Assertions are not
popular in release builds and distros turn them off so it's effectively
removing error handling and allowing silent errors.

