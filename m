Return-Path: <linux-btrfs+bounces-1611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723883742C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F7928DE88
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB51482CD;
	Mon, 22 Jan 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il9RkaGo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UsZpHmVL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S0a/xH4i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJPoLH5x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923A482C0
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956226; cv=none; b=jLFmJkjWal405tUiUrQsi1/3fRQoVvoAnArnMknn+wzmQhDY8HLf0GUs3twfT615w+BSsPMSCnCPaaw6ggocbUPFO8Wk403wJBqpg9e37IrA/jQllcuNZMsD6YW+vrpNM2TnQYa2nWj3V/GsV+u8YDOP07Z7jCMTwezScJPnaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956226; c=relaxed/simple;
	bh=OnU5XSzkXmtrrY+laITLnRBL5dZKu6jW+LSZT3B7rtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvry6U+S3ZQtSUnVWMKWBGLYCL2IbFdWuTQ1wKK/miKGLEi4l2XP87XEiB4Lub/+dIsvF/hUwEoAXJaUgnIiSQ6AQYsCF1tPvqN5O2WLPJtnzPgxsWabCKW8k5c2O4p7WQTF3qR69e9BQCcIXq0U8qvf5ntQCGn92rBNFiZ1L3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il9RkaGo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UsZpHmVL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S0a/xH4i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJPoLH5x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D92201FCD7;
	Mon, 22 Jan 2024 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956223;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=025zkzz9ltKXJgAE1HxASCk/9GgGfzuz/sxfIfqTztc=;
	b=il9RkaGoDiX2xaNZNoh8peczWrg1bPUIw+z4v4Vn+0hOC1sag5QxBAhFBCQ6fLEpktxP1T
	AZSlK5FzTfu4svg9/9lPvQiaptEtB90PHTjHXYjQpZ2Ze/NNiIW/Szr4EKgsbDdm8qpqvK
	V+VS8KEmrXpXCB4xoF75xLscdS7nVO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956223;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=025zkzz9ltKXJgAE1HxASCk/9GgGfzuz/sxfIfqTztc=;
	b=UsZpHmVLklNxz21CiYA8HsZWkcRl8ctKXqwO3P9um/UhLRb+9WB6acI7sdIUrX8CqHeQ3S
	om3zLkBka+Qpx3CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956222;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=025zkzz9ltKXJgAE1HxASCk/9GgGfzuz/sxfIfqTztc=;
	b=S0a/xH4iEaY5PGL9YFcIjbX9PfyHUZULE/najGrFrp9K+XGiLR42IFBteKmhnCHrAUwz6x
	btqH3xFmUqmKsKEsyG2btK4E6yABYw7hPTrCh6663sbTiXtjy98JRQefyhwMDqaAIV/pe4
	ynmIdjuKey1SRctbxMv4OpDXh81xAeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956222;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=025zkzz9ltKXJgAE1HxASCk/9GgGfzuz/sxfIfqTztc=;
	b=lJPoLH5xzUUQvRrgzbo0+EdVGD70eS/vNInikFCFlmhi2yc6deqbuXyT85REVcZg+IiY2A
	b0Uw86s9P3NkfLAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C952A13310;
	Mon, 22 Jan 2024 20:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e0K5MH7TrmU3ewAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:43:42 +0000
Date: Mon, 22 Jan 2024 21:43:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
Message-ID: <20240122204321.GV31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705711967.git.boris@bur.io>
 <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.93
X-Spamd-Result: default: False [-1.93 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.94)[86.44%]
X-Spam-Flag: NO

On Fri, Jan 19, 2024 at 04:55:58PM -0800, Boris Burkov wrote:
> This leads to various races and it isn't helpful, because you can't
> specify a subvol id when creating a subvol, so you can't be sure it
> will be the right one. Any requirements on the automatic subvol can
> be gratified by using a higher level qgroup and the inheritance
> parameters of subvol creation.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: David Sterba <dsterba@suse.com>

