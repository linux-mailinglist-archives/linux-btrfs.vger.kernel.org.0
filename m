Return-Path: <linux-btrfs+bounces-9212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AE9B5475
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613271F2391C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E36208226;
	Tue, 29 Oct 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rkLyIenx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3skIrWCE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fTjYt4cr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EdJjFUAk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CA201279
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234986; cv=none; b=VoYS2jIBKG5oRGdfNOmbWjuPFleURmYNwhQdlwvkV98rCcbs+InTXcoJkCWfBCTIi+hKz2JbesXDYD8QguwI3SiWcC7nFLNUn3lKgAyab80Yt5qRdR9qvkUeg+wxC1+JDw2SiP7ZJf0KFBC6fog+h+CM18I73Gtsu5KJW8n4Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234986; c=relaxed/simple;
	bh=aneqxCO0s9OhJtxlkB5XJCFbxF02NWXFiEsLkzG6TIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7tP2Aaa6Eg2f8w+9In+BCCGm4iIEEccM25EIYVVutZhk+3XkH9ogwT9h+q1ZYNblDex1KzzpT6CZZC9ZGB2/W1zdFUpE5fypF7fQY7Il8cuY/WLZYV2VXWBpYf6oNVWGkpZjnappaSHmMs02iUujbl5QLpCukbEIRE2e1hs5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rkLyIenx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3skIrWCE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fTjYt4cr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EdJjFUAk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDBB6211D0;
	Tue, 29 Oct 2024 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730234977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOx3gzFkPiESx+UeCWJ+yQyCSTm2hnVNQB/hGLCtYU=;
	b=rkLyIenxxBuBBgD79gVOzzexVPd4MGc14ZCk09cS767RskP9OwCXfo2YVMiZGddJWUfW8t
	a+MN8NKq1G+fPztBk7W4d+lGKXbOqfigq9u1as98oZs4jEi4tzg4xDFiSUtNmuyan5r9h6
	Z8FC9BbALDw2kmbKF1nw7YfKoptYiZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730234977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOx3gzFkPiESx+UeCWJ+yQyCSTm2hnVNQB/hGLCtYU=;
	b=3skIrWCEgQ+yKR6xl3OxU3hCodSFpyY22c/s9z5h7wmrNCaP6JSIFrJqa1VJUM0h8zTOaG
	qMKTqh1b6wqpa9Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fTjYt4cr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EdJjFUAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730234976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOx3gzFkPiESx+UeCWJ+yQyCSTm2hnVNQB/hGLCtYU=;
	b=fTjYt4cri2bpu+hCsOygTy1m+cO+EFDRq7fDlF4bsw5yA49NCwDv4eIO+LwhVbYm+c4wBK
	5gW3//Ztregfes1njr1KGvmJ1xF5iNkQ5HLVa+cTTFGbQEdT+NoYn6GsszSWrChcY+XslZ
	pMnB81vxsT3Sfpw5mztTtNihqq7aMnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730234976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gOx3gzFkPiESx+UeCWJ+yQyCSTm2hnVNQB/hGLCtYU=;
	b=EdJjFUAkGax/2zaKbZ2/yJcDyp1FXYsVuq+Edq37THMUzmGBrhklRHBFQc2vePSmNd0v/D
	8mrrtFEQfBh56vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBE5B136A5;
	Tue, 29 Oct 2024 20:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VVKKMWBKIWe9aQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Oct 2024 20:49:36 +0000
Date: Tue, 29 Oct 2024 21:49:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: convert delayed head refs to xarray and
 cleanups
Message-ID: <20241029204934.GQ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1729784712.git.fdmanana@suse.com>
 <256a805f-c6cc-46d4-a024-92ddb1c7fe36@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <256a805f-c6cc-46d4-a024-92ddb1c7fe36@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: DDBB6211D0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Oct 29, 2024 at 07:25:35AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/25 02:54, fdmanana@kernel.org 写道:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This converts the rb-tree that tracks delayed ref heads into an xarray,
> > reducing memory used by delayed ref heads and making it more efficient
> > to add/remove/find delayed ref heads. The rest are mostly cleanups and
> > refactorings, removing some dead code, deduplicating code, move code
> > around, etc. More details in the changelogs.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

For the record, rev-by added to the whole series in for-next.

