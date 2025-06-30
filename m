Return-Path: <linux-btrfs+bounces-15112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C548BAEE314
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776643BD13A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBD228E581;
	Mon, 30 Jun 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrxhCKQl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGdHVHvY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrxhCKQl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGdHVHvY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2A153BF0
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298875; cv=none; b=o/FGvSjSWJP+0hP6VUQ1a0wRTjj6B6Y98Nf0o9bnOE4l64jlI+j0i2OaKiY+oIS5SWVWcyGZLfKchTgL39Xs/ipvQ67zd5rYJMmlxcHsOMhnXM1sppzCYfYH+ByDKy88+p+xjZG6jLZWb3nE8jFEqVsnMHJSmkL8d1HwZuDrgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298875; c=relaxed/simple;
	bh=5xcwt5f3DtOFHDNP2NygZPHDxuHMyPKr4VQqodxy7h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4vUZx9DlYDxfBAb7za1XLWY4i66q26ZurtzbpOb22a5cUiIIYZAehWPDHTp0ninh3pbwxLh8d56oluxvOypeGbTUfHGSilZq5VxeIzPN5G5YTRlmVFhnXxGFCN8o2aEML7qJQcK4xBbkGhy23omfCTThSsZtlo045wbt4Q+NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrxhCKQl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGdHVHvY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrxhCKQl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGdHVHvY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EDDF2111F;
	Mon, 30 Jun 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751298871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp9DkCQN7izvy/CqJEowjVR2TfCtkbyQIE8mwpCaCrs=;
	b=xrxhCKQlp5EuUcLI/TQ+Mr+dLkxm9RjLytp5M22gontBzS1STwnmLtrEmkADWGNUkyX5WF
	pSfYN7JkHEDd2JSXTPXTN+XM5Q94GoWVdtOhoZw8UUZU1VjbQni84rK0vVAUHqVjoN1bDB
	83ch2+xW176n029PXcNtzGJA4VNQk14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751298871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp9DkCQN7izvy/CqJEowjVR2TfCtkbyQIE8mwpCaCrs=;
	b=VGdHVHvYtY1DO8nXyC8uhYGzpj5Hn4u3Kpr9XiOO6Fqvbye1STuh2C5n2tyo1hclvgXaG9
	u3MHNLRWYOAf6uBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xrxhCKQl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VGdHVHvY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751298871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp9DkCQN7izvy/CqJEowjVR2TfCtkbyQIE8mwpCaCrs=;
	b=xrxhCKQlp5EuUcLI/TQ+Mr+dLkxm9RjLytp5M22gontBzS1STwnmLtrEmkADWGNUkyX5WF
	pSfYN7JkHEDd2JSXTPXTN+XM5Q94GoWVdtOhoZw8UUZU1VjbQni84rK0vVAUHqVjoN1bDB
	83ch2+xW176n029PXcNtzGJA4VNQk14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751298871;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp9DkCQN7izvy/CqJEowjVR2TfCtkbyQIE8mwpCaCrs=;
	b=VGdHVHvYtY1DO8nXyC8uhYGzpj5Hn4u3Kpr9XiOO6Fqvbye1STuh2C5n2tyo1hclvgXaG9
	u3MHNLRWYOAf6uBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E0913983;
	Mon, 30 Jun 2025 15:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tjKrGDezYmj9DgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 15:54:31 +0000
Date: Mon, 30 Jun 2025 17:54:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Set/get accessor cleanups
Message-ID: <20250630155425.GH31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751032655.git.dsterba@suse.com>
 <2055bb59-b10d-41be-b7f7-f891e4bcac00@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2055bb59-b10d-41be-b7f7-f891e4bcac00@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7EDDF2111F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Sun, Jun 29, 2025 at 10:48:15AM +0930, Qu Wenruo wrote:
> > David Sterba (4):
> >    btrfs: don't use token set/get accessors for btrfs_item members
> >    btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
> >    btrfs: tree-log: don't use token set/get accessors in
> >      fill_inode_item()
> >    btrfs: accessors: delete token versions of set/get helpers
> 
> Looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although it also exposed that we have two different fill_inode_item() 
> functions.
> I know the tree log code needs some special handling, the 
> fill_inode_item() in inode.c looks like can be implemented by the one in 
> tree-log.
> 
> It may be a good time to merge them into one in another patch.

Yes, the difference is not that big so it makes sense to merge them.

