Return-Path: <linux-btrfs+bounces-9375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D489BF829
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 21:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FD4B22FEF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6920C498;
	Wed,  6 Nov 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+4dtNH0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDxTYWdC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o+4dtNH0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDxTYWdC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16C20C487
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925767; cv=none; b=qkVSO7tQ5x4ArteLEK2dCeQZhSsZbDWPuHdqomiNZTPoP0K5DtUURuEwXLZl19TnA3xRaSLTqO33PQ5tr41Tx5nSqM1M6sPDV2xbmeO8/ihC5XE01L4sZoTUsBoCXnmRUyqMmxWDUCRButMTDq0mBSQu+/NumfyJ5A2L41RCbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925767; c=relaxed/simple;
	bh=Nv//esu+F9kw+DOKMw+/FfVc3Kn8R1oLH3BJG2t1XPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVWhPJdMnlPXiIc16dImc66nf3ha09OOmmF/oNEUHXpXs4bQYX/tPvtS7u+gRUDA48/VGyYfMM97ZsAt9klxM2ohsPdb5gL/zEqQEtk6Pk11yslGMK4PhmEhBQ8Uf/5Zf32OEZvbaepZC3aHDlAaJ/nE18XnHNfkORX+LAlyMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+4dtNH0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDxTYWdC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o+4dtNH0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDxTYWdC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 829F61FD34;
	Wed,  6 Nov 2024 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730925763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv//esu+F9kw+DOKMw+/FfVc3Kn8R1oLH3BJG2t1XPU=;
	b=o+4dtNH0+kKC/+oQeVJPEFyv75se2vu0bvFFY3TRUeJxXIA/Gj0kLICx0p5iigIVBnCgCM
	XGrS3SUrfqA4ORtl1YvmmMbLP5nGgGjWxXULeXY8bAZPDNO7G525uAxgeSvaFC3pXx4fKP
	RTnWm0YZ9QKgb6v9Sw1m5JEPlEXZsm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730925763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv//esu+F9kw+DOKMw+/FfVc3Kn8R1oLH3BJG2t1XPU=;
	b=cDxTYWdCrevKXms2CcBq29xOCkbnDmvh99uBvgUjyKnQd+76cVs11k9iS4afK8BvITRPMZ
	AQFOB4USlUozPkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730925763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv//esu+F9kw+DOKMw+/FfVc3Kn8R1oLH3BJG2t1XPU=;
	b=o+4dtNH0+kKC/+oQeVJPEFyv75se2vu0bvFFY3TRUeJxXIA/Gj0kLICx0p5iigIVBnCgCM
	XGrS3SUrfqA4ORtl1YvmmMbLP5nGgGjWxXULeXY8bAZPDNO7G525uAxgeSvaFC3pXx4fKP
	RTnWm0YZ9QKgb6v9Sw1m5JEPlEXZsm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730925763;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nv//esu+F9kw+DOKMw+/FfVc3Kn8R1oLH3BJG2t1XPU=;
	b=cDxTYWdCrevKXms2CcBq29xOCkbnDmvh99uBvgUjyKnQd+76cVs11k9iS4afK8BvITRPMZ
	AQFOB4USlUozPkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 605F2137C4;
	Wed,  6 Nov 2024 20:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /pHuFsPUK2dhKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 20:42:43 +0000
Date: Wed, 6 Nov 2024 21:42:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a typo in btrfs_use_zone_append
Message-ID: <20241106204242.GL31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241031140317.177800-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031140317.177800-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Oct 31, 2024 at 03:03:17PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to for-next, thanks.

