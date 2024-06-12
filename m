Return-Path: <linux-btrfs+bounces-5674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C35905C53
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D48283366
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB5483CD5;
	Wed, 12 Jun 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/hcHXdl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOv1msu3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/hcHXdl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOv1msu3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12F83CD3
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221962; cv=none; b=Vf7fceBdRD02jc0AJBWG31G082YW5OqYfNP4lDeyGpKWqnuq08ITxhHdRgiNqK20+XCArv63TZ2SuYQ4FSD2pIElETYyhADlJF5WngBmZ/GXBjPl34bGI5IpxZoYWIC84a3PH3hxN/CmIz0a996HA4mVUQe+B4To2wdUa9cquCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221962; c=relaxed/simple;
	bh=G9pCrR1+8KHEXX+UrUDzf0XOKJTOsokHhkwu9j3H0k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHk488s05jxarAH6vIp0x3r/bvBwSpzOuzeev7l566XpGt7RMpj1P5n5p60O8HfWrSd8huBmYpi2J6KIFf8eUupg2Hj299QXG9zjR7sdyBaPbQM7U507qmCi5f90EkJhrpwbsmTIez9rWF4nT4vE1Wy3FOz26NfsLVYoggpnzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/hcHXdl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOv1msu3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/hcHXdl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOv1msu3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DD2034852;
	Wed, 12 Jun 2024 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JlU3whQDhf19h2vcam8yn72sSvFc/oeEPrb7vVPhEH4=;
	b=g/hcHXdlsAG/ArUOM5VbO/lYqajefqUVKLvyZzfkYMShg8EqTmwVUAKJwvu4vWsxcdaZxH
	jhGVHdPNtGMaLzBPW6Of3qeoTqKmXRyUPy4mi5pwmXkcYlVVaZ3NTcbsQ7szhL2RVguKsm
	bTKNfUUGG9GjPNGZeWeFav0iEJa/PKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JlU3whQDhf19h2vcam8yn72sSvFc/oeEPrb7vVPhEH4=;
	b=fOv1msu3A7IEMcH1ydlaO5D1NxKEI5w+3ZfKRx6eScSnhgZ18BwMkCgmwwz97TsFt48BhA
	9erd0YcwvLKR/+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JlU3whQDhf19h2vcam8yn72sSvFc/oeEPrb7vVPhEH4=;
	b=g/hcHXdlsAG/ArUOM5VbO/lYqajefqUVKLvyZzfkYMShg8EqTmwVUAKJwvu4vWsxcdaZxH
	jhGVHdPNtGMaLzBPW6Of3qeoTqKmXRyUPy4mi5pwmXkcYlVVaZ3NTcbsQ7szhL2RVguKsm
	bTKNfUUGG9GjPNGZeWeFav0iEJa/PKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JlU3whQDhf19h2vcam8yn72sSvFc/oeEPrb7vVPhEH4=;
	b=fOv1msu3A7IEMcH1ydlaO5D1NxKEI5w+3ZfKRx6eScSnhgZ18BwMkCgmwwz97TsFt48BhA
	9erd0YcwvLKR/+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8118F1372E;
	Wed, 12 Jun 2024 19:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kf5YH4b8aWbSIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:52:38 +0000
Date: Wed, 12 Jun 2024 21:52:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: remove the unused error bitmap dumpping
Message-ID: <20240612195237.GO18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b965322f7a4825bc5f4a094f3138e1369534f8bb.1717966923.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b965322f7a4825bc5f4a094f3138e1369534f8bb.1717966923.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto]

On Mon, Jun 10, 2024 at 06:32:07AM +0930, Qu Wenruo wrote:
> Since commit 2b2553f12355 ("btrfs: stop setting PageError in the data I/O
> path") btrfs no longer utilize subpage error bitmaps anymore, but the
> commit forgot to remove the error bitmap in btrfs_subpage_dump_bitmap(),
> resulting possible meaningless result for the error bitmap.
> 
> Fix it by just removing the error bitmap dumping.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

