Return-Path: <linux-btrfs+bounces-8107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE097BBC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BF1C22034
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE81189BBE;
	Wed, 18 Sep 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikPsSUig";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0dHbUJo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikPsSUig";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p0dHbUJo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B9189519;
	Wed, 18 Sep 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660331; cv=none; b=IbkBwCT/8yEO6BDF5oo+xGAgcmJ4/Z2emurIPbMOHm0sbd6OSXpvT5u0ktKFE/TesX+a3lWwBJrsZA/bfRP1a4neFlANlhpIqRol41UZ7A9Nne+Gik9JapP0qdYOSO5dldHEqXCr/OXrgXeuA5VzITeuP4XUL734gFfyX6hFUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660331; c=relaxed/simple;
	bh=48Z2iZdbf6+ycYO27SMN56v/CSwAWGPFvELSzBoEKrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaVZBwg86VINB4ZrtcIAFA0aRDGab4WIWYBQdIfzw40Yid/T3uJC+Z6U4ieo+idS91q6LbXAxGHgSBp5Tev3gTGL12woy4HTH9U8Xb1sh9Lx8oWqxYG1QBo4l/3pzJp61y1YNB+HWz+PT882mXjQC2WxJ59B1sZUiM/Xp6CR9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikPsSUig; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0dHbUJo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikPsSUig; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p0dHbUJo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46C8720482;
	Wed, 18 Sep 2024 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726660327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjSItfN0Yod1iiX2tZIjMqSYHogR8o+X3kiUaqum8aQ=;
	b=ikPsSUiga/54eMCbUf9CPLgjM0dAWOtLVlkIhEZIBJlV/9Dc/zMIre+7UPpI6GNXn6f2Vt
	KeFYgU1bpH0IXMJ6eIkDSmgyn/y8cFv8MVA1DSO3uoUaHmtvPO7L/Skan0CQ+G9kd41neY
	J1HMrqhpjBd4N3xnyBQYJuoC4yQIGE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726660327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjSItfN0Yod1iiX2tZIjMqSYHogR8o+X3kiUaqum8aQ=;
	b=p0dHbUJowK689vtvdzYY3UQ4kn3L7ka/JsdsDzCdh8JpoDpMQP60v7e7PKSQHeuU7loMcy
	0WZ1LN4+LxjS00AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ikPsSUig;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p0dHbUJo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726660327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjSItfN0Yod1iiX2tZIjMqSYHogR8o+X3kiUaqum8aQ=;
	b=ikPsSUiga/54eMCbUf9CPLgjM0dAWOtLVlkIhEZIBJlV/9Dc/zMIre+7UPpI6GNXn6f2Vt
	KeFYgU1bpH0IXMJ6eIkDSmgyn/y8cFv8MVA1DSO3uoUaHmtvPO7L/Skan0CQ+G9kd41neY
	J1HMrqhpjBd4N3xnyBQYJuoC4yQIGE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726660327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjSItfN0Yod1iiX2tZIjMqSYHogR8o+X3kiUaqum8aQ=;
	b=p0dHbUJowK689vtvdzYY3UQ4kn3L7ka/JsdsDzCdh8JpoDpMQP60v7e7PKSQHeuU7loMcy
	0WZ1LN4+LxjS00AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350C813508;
	Wed, 18 Sep 2024 11:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQ67DOe+6mZsGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Sep 2024 11:52:07 +0000
Date: Wed, 18 Sep 2024 13:52:04 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] btrfs: Don't block system suspend during fstrim
Message-ID: <20240918115204.GJ2920@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 46C8720482
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Tue, Sep 17, 2024 at 10:33:03PM +0200, Luca Stefani wrote:
> Changes since v5:
> * Make chunk size a define
> * Remove superfluous trim_interrupted checks
>   after moving them to trim_no_bitmap/trim_bitmaps

Thanks, I haven't spotted anything left to fix or update. The patches
are short enough to be backported so that can happen around 6.12-rc1
time.

