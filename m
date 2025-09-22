Return-Path: <linux-btrfs+bounces-17055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E22B90008
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5933BB37C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6D2FE076;
	Mon, 22 Sep 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G1AT08Mv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JkBAPZiV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8OXeqvf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9lI31nYW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850862773D9
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536936; cv=none; b=Pp4UVtn/UqvZymhrhJGGvyhcSzANxei031VsODSEMrlW3EaoWQA1T+X6fOSoj7u2tIQVRm5dYyO4id1vu32vlf3yaOQxa8Fi4kbujl/r50Qf4+fJtS9PBd5MbnlAMWFs3ag/IJxJ/Ml0NlVlfo+rrKS5/9mLuryXObiPLDLKlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536936; c=relaxed/simple;
	bh=GKNbTJkYnR5VYhj9qSO1W/nnJGH7QggS3jfumZApEXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8lh9iLYYJIAb3vNTT4tS5H1VP8/tyOogoewx3amQWLV1A8D0JxiFhtvev2C8An6E1L5m/LABx1QTjJ+smly3LIT//3c0xUKmYs7gBDfzoqeZDnEKC8Mlhl8d2PjK3yuW7OdpZEMN09VeoSwT1CcLnTwYfWWM3NCrqUCqZ4QY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G1AT08Mv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JkBAPZiV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8OXeqvf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9lI31nYW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B05ED1FE59;
	Mon, 22 Sep 2025 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536932;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNbTJkYnR5VYhj9qSO1W/nnJGH7QggS3jfumZApEXc=;
	b=G1AT08MvHIZWesCigcCrfn1iYSMPRrwrEbfQDBHzAEu+orb7sNt9CYB1F/GEhrkM2FRKV/
	3rsbiNeh0rDKwl6iBw99d8NOQH6EaTi3T0VSf6E1M6ZyQLmI9xWImOaI7kCRkhf6hr0Vza
	h4pDeo/JggfqRL7QZEeZS5VSQSpzQ7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536932;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNbTJkYnR5VYhj9qSO1W/nnJGH7QggS3jfumZApEXc=;
	b=JkBAPZiVtq1fDHcBmdM193S36bjeHM6mIKg446mWmfHN6umRWq6zdY5G3DkHkej+eq/h8X
	eZdeUiPhFvxttrDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h8OXeqvf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9lI31nYW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNbTJkYnR5VYhj9qSO1W/nnJGH7QggS3jfumZApEXc=;
	b=h8OXeqvfpgPKLiM19htaj+JvPW4+VXcv9A3uAPMOql/mjsHtVR85CPRFQPLwhylvwKu9nL
	qEhQtEyz3eXSVl+w2syd5ArUuavrhUNULorT3lLeDaKDqT5KIwl+nWF7bMA3PRSdhYq39g
	rv3XAzVdyjPFp8mYeXvfZ5QY5uhHknc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKNbTJkYnR5VYhj9qSO1W/nnJGH7QggS3jfumZApEXc=;
	b=9lI31nYWubDQlZdRsUE66AaUhtCvCfpVO60odwbco67zJ4QgdbwuRr5r+LczM9hAtoiiQ7
	IrVPh7C+nwlO1vBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9609913A63;
	Mon, 22 Sep 2025 10:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cUR5JOMk0WhyPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 10:28:51 +0000
Date: Mon, 22 Sep 2025 12:28:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
Message-ID: <20250922102850.GL5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250919145816.959845-1-mssola@mssola.com>
 <20250919145816.959845-2-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919145816.959845-2-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,mssola.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B05ED1FE59
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabaté Solà wrote:
> As pointed out in the documentation, calling 'kmalloc' with open-coded
> arithmetic can lead to unfortunate overflows and this particular way of
> using it has been deprecated. Instead, it's preferred to use
> 'kmalloc_array' in cases where it might apply so an overflow check is
> performed.

So this is an API cleanup and it makes sense to use the checked
multiplication but it should be also said that this is not fixing any
overflow because in all cases the multipliers are bounded small numbers
derived from number of items in leaves/nodes.

> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>

Reviewed-by: David Sterba <dsterba@suse.com>

