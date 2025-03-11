Return-Path: <linux-btrfs+bounces-12204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA9A5CEFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 20:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B8A3B93E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864026463F;
	Tue, 11 Mar 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rFiiDLy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XotfXO0o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rFiiDLy+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XotfXO0o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3D2641F3
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720081; cv=none; b=h4X17vAKh0ri4/8NDUsCg6QM3BadTRmifNNWpPIrR7d+YczEN689UFjovTnkJ3is3Bo8+9pdI81Qlun/EKKiYsG5zTkoQbW75IvMO1YZqAdfnSKsuoeTwSjsaEJpRJMo1LIHUSTuc7b+p/tOORIQSAP06BI1ZnwuASSjUyb/FQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720081; c=relaxed/simple;
	bh=OyWzd+iP5TskN8XPkWYSNdDKMxym3H8JiYS0MXU/THs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgV8yjx2gOG5KMwCJ9eBL3/OPColKgR+A9L4LZ4oHIlvGgp5Mb873LfXWVykYhWszTV9HhkXlMhPoh1UHefeR1/I4IaFA7M3uObB1clLO3UT6iCVdimNhw0XuaXpnfDLxW22f36IFuuVYNBkgN822kwE7UXzkgiaqrLhMgLo7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rFiiDLy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XotfXO0o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rFiiDLy+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XotfXO0o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4441221182;
	Tue, 11 Mar 2025 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741720078;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4u17CbUxV85r1r/A7IFM6NmJKU6i1VGwji73vngxLU=;
	b=rFiiDLy+pB2PhrNNk/q80FFDxtoeiFqIrZ6ogDnMjkdo0md9A6hwxYL86819EjnM1yF5Za
	wWhp9nzm1c++SFXJDTHQQnUnVA9yhcvtedahfRdpkarrxetzSZv3MQB+1cIixx8b3qE5SX
	lClAGCRxyBP6zF2IN+aw5VsPbk6VhBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741720078;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4u17CbUxV85r1r/A7IFM6NmJKU6i1VGwji73vngxLU=;
	b=XotfXO0ow5eQR2xYR9cTejqFRVCwfqK80+cLCfkXdzgrAh2NIxzTuL4PPpjnG0GDgFyGhK
	Be2DhnLBs/7UcGCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rFiiDLy+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XotfXO0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741720078;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4u17CbUxV85r1r/A7IFM6NmJKU6i1VGwji73vngxLU=;
	b=rFiiDLy+pB2PhrNNk/q80FFDxtoeiFqIrZ6ogDnMjkdo0md9A6hwxYL86819EjnM1yF5Za
	wWhp9nzm1c++SFXJDTHQQnUnVA9yhcvtedahfRdpkarrxetzSZv3MQB+1cIixx8b3qE5SX
	lClAGCRxyBP6zF2IN+aw5VsPbk6VhBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741720078;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4u17CbUxV85r1r/A7IFM6NmJKU6i1VGwji73vngxLU=;
	b=XotfXO0ow5eQR2xYR9cTejqFRVCwfqK80+cLCfkXdzgrAh2NIxzTuL4PPpjnG0GDgFyGhK
	Be2DhnLBs/7UcGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2709B132CB;
	Tue, 11 Mar 2025 19:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jUX3CA6K0GfXLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 19:07:58 +0000
Date: Tue, 11 Mar 2025 20:07:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2 0/3] btrfs: random code cleanup
Message-ID: <20250311190752.GK32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250311081317.13860-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311081317.13860-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4441221182
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 04:13:11PM +0800, Sun YangKai wrote:
> These patches are not intended to change any behavior of current code.
> Just trying to make the codes easier to read, and, maybe, perform better.
> I'm working on btrfs_search_forward(), trying to improve it and fix some
> misbehaviors. And I'll send some patches that will change the behavior of
> the code later.
> 
> I'm new to the maillist, trying to read the implements, and improve it from
> my perspective.
> If you have any feedback or questions, please let me know :)
> 
> --
> Changelog
> v2:
> - Improve the commit messages advised by David Sterba
> - Fix some code style issues advised by David Sterba

Added to for-next with some minor tweaks, thanks.

