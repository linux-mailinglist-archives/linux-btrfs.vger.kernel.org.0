Return-Path: <linux-btrfs+bounces-5258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E218CD8E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB731F214BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B36EB60;
	Thu, 23 May 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJuoPr41";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vWCiLBp5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TJuoPr41";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vWCiLBp5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CB6E615
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483834; cv=none; b=IeP3vxMjZSwqFnRdkGaF1Vb6Mw3vAEJn0102nUTn0QamEIrR63ge+o5Gv8pR91yDekH4bCSBl9ipDXW5fJJj/2L+Qu4hhcudns0SGHYvJK0Ag2r90Qj1v2sYVcWvHbBATt85WccIfprHzST1lf4mdK3L5wt/RDzQDTalxcfNXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483834; c=relaxed/simple;
	bh=gexoFEhSUloMybqNI9WY3ObEavMdSiFztDOJ4mPCVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrZV8cSU+o1Lzq10YzlCivwsnf/0WCMnek+GJk1Cw1OeeUaQ2AJyb6uaDY5oh2bRtQNeINqvVLA+on1tppZKmQmhdlM5kpDJvA1bmxRvm+TOdnBmBRK4y0rgo7mPlNDbCfvJ7kGMc1ApG++6QeVyEA/2ncnct749OOcWh4wfwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJuoPr41; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vWCiLBp5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TJuoPr41; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vWCiLBp5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C855320379;
	Thu, 23 May 2024 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716483830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f7DsnUP/iHiNYtwckPgateaPW19pKAB2ktcsl+thc=;
	b=TJuoPr41pq/4KIfQYe56R7hPqaVwH+M4A7jUeTva7bYZthxhPyd32CMzRjUg48ddfNrUMM
	6FwMLGKrb7Yv+7az+9mAYWGYIpnI0pbqdAxfpw9zTnqT9qwKRL6mCdvklLm0aMc05CK5//
	Yxyz32NW0c1WfnM+xcDnsAOpi80ofWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716483830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f7DsnUP/iHiNYtwckPgateaPW19pKAB2ktcsl+thc=;
	b=vWCiLBp5GubofEWKiFewGF34QQ9qrUh5+RZPunQyCZGsV7aZAJxvfTdufLXbyKNek9OXuH
	3ip7l+IpE1kA0sDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716483830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f7DsnUP/iHiNYtwckPgateaPW19pKAB2ktcsl+thc=;
	b=TJuoPr41pq/4KIfQYe56R7hPqaVwH+M4A7jUeTva7bYZthxhPyd32CMzRjUg48ddfNrUMM
	6FwMLGKrb7Yv+7az+9mAYWGYIpnI0pbqdAxfpw9zTnqT9qwKRL6mCdvklLm0aMc05CK5//
	Yxyz32NW0c1WfnM+xcDnsAOpi80ofWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716483830;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+f7DsnUP/iHiNYtwckPgateaPW19pKAB2ktcsl+thc=;
	b=vWCiLBp5GubofEWKiFewGF34QQ9qrUh5+RZPunQyCZGsV7aZAJxvfTdufLXbyKNek9OXuH
	3ip7l+IpE1kA0sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B48E913A6B;
	Thu, 23 May 2024 17:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GkekK/Z2T2bUJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 May 2024 17:03:50 +0000
Date: Thu, 23 May 2024 19:03:45 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: avoid some unnecessary commit of empty
 transactions
Message-ID: <20240523170345.GE17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716386100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Wed, May 22, 2024 at 03:36:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few places can unnecessarily create an empty transaction and then commit
> it, when the goal is just to catch the current transaction and wait for
> its commit to complete. This results in wasting IO, time and rotation of
> the precious backup roots in the super block. Details in the change logs.
> The patches are all independent, except patch 4 that applies on top of
> patch 3 (but could have been done in any order really, they are independent).
> 
> Filipe Manana (7):
>   btrfs: qgroup: avoid start/commit empty transaction when flushing reservations
>   btrfs: avoid create and commit empty transaction when committing super
>   btrfs: send: make ensure_commit_roots_uptodate() simpler and more efficient
>   btrfs: send: avoid create/commit empty transaction at ensure_commit_roots_uptodate()
>   btrfs: scrub: avoid create/commit empty transaction at finish_extent_writes_for_zoned()
>   btrfs: add and use helper to commit the current transaction
>   btrfs: send: get rid of the label and gotos at ensure_commit_roots_uptodate()

Reviewed-by: David Sterba <dsterba@suse.com>

