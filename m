Return-Path: <linux-btrfs+bounces-6856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40B9400D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 00:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28531C2189D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469618E744;
	Mon, 29 Jul 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="srYzlGeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9dX1MKH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="srYzlGeJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9dX1MKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9B1B86D6
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290771; cv=none; b=YzO7ea4VyphJ75Xk4tIMHW3xNmhGdoaDKCZpWpsBkbmwymdyYB54xg0d9RBMF7beqKyzISgPn7vddqzzc79f2nY+FosTIBA6CtE+8fspLv962ecz5TgQFx66MEwmQh+pyYuRW4k2A6U38Y+7gQl2cqzpvbqpk5v9IA/i/P5PjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290771; c=relaxed/simple;
	bh=s8Hu13bno4btlUCdaQvZOEx3WMF8Jf4keWm9ryLDTgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNtjp4MwkUCeXG5wWoAeQg9Oxp/coEZPNTc45j1BvJw2C5MyPN2acYmeNxrSdgJpvbK2W1L1vxOBzvp9PtGZ0RqT5NiFd8Jwamqx0k9tge6OGgyMR6KNv6O81HQ2EPJ0jmVgaYRLSxst5HqmU4KuBUzHkuwH+TGCX/amn1T7bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=srYzlGeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9dX1MKH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=srYzlGeJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9dX1MKH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D7E421AA1;
	Mon, 29 Jul 2024 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722290767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC3SUhLMsCVy+bejhfiIJdPOKynekzJ447troIRLZY=;
	b=srYzlGeJIiVguOsjNq68OYGIRZL3LGRvGoGX+cGMfUuE6LGdc3p4yXP2Bv+f6FLS61bVoK
	1nPuuz+MJTbQF2jfs+Y/QGhmK6cqbpuClb0pLc3v74dYvC8HefeGex4qCob9xAGfKPlGJB
	No+uEdlVlih3n8zS548lk7iwK8gqzQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722290767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC3SUhLMsCVy+bejhfiIJdPOKynekzJ447troIRLZY=;
	b=G9dX1MKH4KzqMO/oeMxaIoLaSXHRXdVOJL77eCodOYmlrP6EvC8D4yCMP8w+MoJ0W6bsK+
	efVT2g2dvJ0byEDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722290767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC3SUhLMsCVy+bejhfiIJdPOKynekzJ447troIRLZY=;
	b=srYzlGeJIiVguOsjNq68OYGIRZL3LGRvGoGX+cGMfUuE6LGdc3p4yXP2Bv+f6FLS61bVoK
	1nPuuz+MJTbQF2jfs+Y/QGhmK6cqbpuClb0pLc3v74dYvC8HefeGex4qCob9xAGfKPlGJB
	No+uEdlVlih3n8zS548lk7iwK8gqzQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722290767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CC3SUhLMsCVy+bejhfiIJdPOKynekzJ447troIRLZY=;
	b=G9dX1MKH4KzqMO/oeMxaIoLaSXHRXdVOJL77eCodOYmlrP6EvC8D4yCMP8w+MoJ0W6bsK+
	efVT2g2dvJ0byEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E85F1368A;
	Mon, 29 Jul 2024 22:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0FoMD08SqGZeYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 22:06:07 +0000
Date: Tue, 30 Jul 2024 00:06:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	geert@linux-m68k.org
Subject: Re: [PATCH] btrfs: initialize location to fix -Wmaybe-uninitialized
 in btrfs_lookup_dentry()
Message-ID: <20240729220606.GU17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240729200608.10722-1-dsterba@suse.com>
 <92c6004f-9742-4abc-91bc-347cccaa44b9@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92c6004f-9742-4abc-91bc-347cccaa44b9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,linux-m68k.org:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Tue, Jul 30, 2024 at 07:04:36AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/30 05:36, David Sterba 写道:
> > Some arch + compiler combinations report a potentially unused variable
> > location in btrfs_lookup_dentry(). This is a false alert as the variable
> > is passed by value and always valid or there's an error. The compilers
> > cannot probably reason about that although btrfs_inode_by_name() is in
> > the same file.
> >
> >     >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.objectid' may be used
> >     +uninitialized in this function [-Werror=maybe-uninitialized]:  => 5603:9
> >     >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be used
> >     +uninitialized in this function [-Werror=maybe-uninitialized]:  => 5674:5
> >
> >     m68k-gcc8/m68k-allmodconfig
> >     mips-gcc8/mips-allmodconfig
> >     powerpc-gcc5/powerpc-all{mod,yes}config
> >     powerpc-gcc5/ppc64_defconfig
> >
> > Initialize it to zero, this should fix the warnings and won't change the
> > behaviour as btrfs_inode_by_name() accepts only a root or inode item
> > types, otherwise returns an error.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/linux-btrfs/bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org/
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I hate to update our code for bad compilers, I guess it's
> unavoidable anyway.

Yeah, but the number of such fixups is bearable, we have added like one
per release.

