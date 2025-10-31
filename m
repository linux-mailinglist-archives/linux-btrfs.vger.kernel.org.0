Return-Path: <linux-btrfs+bounces-18427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E207C22D79
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F186C34D188
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 01:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33FB2206BB;
	Fri, 31 Oct 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+79zjMx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mo6fMdry";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+79zjMx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mo6fMdry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A025190664
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872907; cv=none; b=VojX7kN2kqb4aA3uOu6OW+IzI0YUWRRdfQcoDZl6jWQtfEG8OvQNi0ee+lxjgw+xTxEu5JQCUoieL3adE1FEkqV0L8WEA0hh/hFObOuKkX/yQLH+M8Lhx/BnD6lezFSQbfH7dF6i/h0g0wjI+K45+tZlntOw0qbckFCjWbG3KFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872907; c=relaxed/simple;
	bh=ArJ//lgpVe6VXGndQ0nrdLix9pYx0H9A21946E/xf3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X24qFxcLU8YydAuBltiCl8D6QT9tOMKikeqveLXBlYbXQOt7wDlJxg9xrqSCv7CT/Nok5SBFJnSzGTjNOFrwg1FL/90jOHsSkNIiRpuE1i84La3A/jwSgb2WyxxVnu3AXebpYIvQPCjkU3cHOnNs8OgvqE1mw4YbpbaLTLXH2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+79zjMx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mo6fMdry; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+79zjMx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mo6fMdry; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90DDC1F6E6;
	Fri, 31 Oct 2025 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761872903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzV1S3aSM2iT1vGEb903a6Lf49wcwYZt0MjgGnu3oxE=;
	b=o+79zjMxBPP6OPmY/v6YcoC0qojR/+1ij+YYvtaEKVaaYvtQq8PQJ0jRoBx7qPkHvFGAyx
	pNDk2F6i1owHu5RF1KXRcgZM9tRbmlGIZBHm/jywhd6S18mOBDb+f7Q8WhJME3dtfg97OO
	Kuq+aM3aEUZwHGX+8QMs8a92cHExlt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761872903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzV1S3aSM2iT1vGEb903a6Lf49wcwYZt0MjgGnu3oxE=;
	b=mo6fMdrykD8d6RE2paaIdEyiAUebt1l594AvVayl3Kar2EbaEx6RbYrZTelnZxrWP0tmyu
	QVZ1nBUtLBa48yCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761872903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzV1S3aSM2iT1vGEb903a6Lf49wcwYZt0MjgGnu3oxE=;
	b=o+79zjMxBPP6OPmY/v6YcoC0qojR/+1ij+YYvtaEKVaaYvtQq8PQJ0jRoBx7qPkHvFGAyx
	pNDk2F6i1owHu5RF1KXRcgZM9tRbmlGIZBHm/jywhd6S18mOBDb+f7Q8WhJME3dtfg97OO
	Kuq+aM3aEUZwHGX+8QMs8a92cHExlt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761872903;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzV1S3aSM2iT1vGEb903a6Lf49wcwYZt0MjgGnu3oxE=;
	b=mo6fMdrykD8d6RE2paaIdEyiAUebt1l594AvVayl3Kar2EbaEx6RbYrZTelnZxrWP0tmyu
	QVZ1nBUtLBa48yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DC9513393;
	Fri, 31 Oct 2025 01:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fSoUHgcMBGllBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 31 Oct 2025 01:08:23 +0000
Date: Fri, 31 Oct 2025 02:08:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Gladyshev Ilya <foxido@foxido.dev>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make ASSERT no-op in release builds
Message-ID: <20251031010822.GD13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251030182322.4085697-1-foxido@foxido.dev>
 <6409438c-43b7-484c-bf8c-be5f3849ef2f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6409438c-43b7-484c-bf8c-be5f3849ef2f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Oct 31, 2025 at 07:35:29AM +1030, Qu Wenruo wrote:
> 在 2025/10/31 04:53, Gladyshev Ilya 写道:
> > The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
> > because all checks are without side effects and don't affect code logic.
> > 
> > However, some checks has READ_ONCE in them or other 'compiler-unfriendly'
> > behaviour. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
> > was compiled to redundant mov because of this.
> > 
> > This patch replaces ASSERT with BUILD_BUG_ON_INVALID for
> > !CONFIG_BTRFS_ASSERT builds.
> > 
> > Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> > 
> > ---
> > .o size reductions are not that big, for example on defconfig + btrfs
> > fs/btrfs/*.o size went from 3280528 to 3277936, so compiler was pretty
> > efficient on his own
> > ---
> >   fs/btrfs/messages.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> > index 4416c165644f..f80fe40a2c2b 100644
> > --- a/fs/btrfs/messages.h
> > +++ b/fs/btrfs/messages.h
> > @@ -168,7 +168,7 @@ do {										\
> >   #endif
> >   
> >   #else
> > -#define ASSERT(cond, args...)			(void)(cond)
> > +#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
> 
> And I do not think it's a good idea to use BUILD_BUG_ON_INVALID() here, 
> most ASSERT()s are checking runtime conditions, I understand you want to 
> avoid real code generation, but in that case there are more 
> straightforward solutions, like "do {} while (0)" as no-op.

It's supposed to be no-op but also compile checked, so the do/while(0)
will not do that. What BUILD_BUG_ON_INVALID is basically a sizeof(cond)
so it's the right thing but the naming is confusing, we can possibly
open code it.

