Return-Path: <linux-btrfs+bounces-4535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F818B1175
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 19:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D4D1F22531
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF116D4EE;
	Wed, 24 Apr 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tEZJlRB4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+hP9WdY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tEZJlRB4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+hP9WdY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADE16D4E2
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980984; cv=none; b=fPo1hAgr7SLk7req0oZUhWza7vnA/h5alJ31z/M4SC7z/qqCsPZhRXidZmHo5dzfk/CsMGjgCbE5sF79eB0/eK1kjWjlsrE/FD62cjltOhxJhRZO4hZFgFSbGZw6KP9yKhQxj0i0nw3cneuqV9oi1mIMsfzERxXYYylWOShjOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980984; c=relaxed/simple;
	bh=K6prLD8vlNxHEGKE99NQ4IwK+HzZb1533/W8VyKC7Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9khyg5pTxaY79DtWo5T0Ejkg7Tmdww7CEr+9Qx7wM4ZYSPiTPOetvXCjWTQzS9db5r62gBWm8ZGl1/VnEX1WuJHkHgYp2psxuDLUvLv6FipbbT+A4MEJ81nlVwYzOLB4MyObDODuFUrDCYoE/E9rZ039A/iBUJR6t7jsHvIDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tEZJlRB4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q+hP9WdY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tEZJlRB4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q+hP9WdY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE60C21280;
	Wed, 24 Apr 2024 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecKJXGHN7u5Mh5fIsI408JrqwVew3/lSjAmLqQUAe4I=;
	b=tEZJlRB4YZsZXMxiagenJi4Iv11x1lAbnW+qr0SrzAJg2AG8zuDsLMBBNA2/TsAmsF4VVo
	TuNoR+qjwsrb+pgRSe4bjAULtrKAwiO3XxKfZMMFsFGAQfdUw6SgOjPH7lK4ipRImwSKYr
	ZB2RnKmLhc8O9SzeQR7Jrwi9lABFWJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecKJXGHN7u5Mh5fIsI408JrqwVew3/lSjAmLqQUAe4I=;
	b=Q+hP9WdYrZQ1tcGOM2uJ8c7+dMCaWBpj4srEDNcTVgH+8fTWNB6ZMJfHEkYVgsvABzuPWb
	OYlCvYl4+clpbLBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tEZJlRB4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q+hP9WdY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713980980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecKJXGHN7u5Mh5fIsI408JrqwVew3/lSjAmLqQUAe4I=;
	b=tEZJlRB4YZsZXMxiagenJi4Iv11x1lAbnW+qr0SrzAJg2AG8zuDsLMBBNA2/TsAmsF4VVo
	TuNoR+qjwsrb+pgRSe4bjAULtrKAwiO3XxKfZMMFsFGAQfdUw6SgOjPH7lK4ipRImwSKYr
	ZB2RnKmLhc8O9SzeQR7Jrwi9lABFWJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713980980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ecKJXGHN7u5Mh5fIsI408JrqwVew3/lSjAmLqQUAe4I=;
	b=Q+hP9WdYrZQ1tcGOM2uJ8c7+dMCaWBpj4srEDNcTVgH+8fTWNB6ZMJfHEkYVgsvABzuPWb
	OYlCvYl4+clpbLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3CF713690;
	Wed, 24 Apr 2024 17:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bJI2KzRGKWbxTgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 24 Apr 2024 17:49:40 +0000
Date: Wed, 24 Apr 2024 12:49:40 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 15/17] btrfs: push lock_extent down in cow_file_range()
Message-ID: <dwytaw4h3xvvqze5r7j65goj2lpnhuu4p7wzm2bhtqu66hpni5@o2vmgceklvre>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <88e255b855e917caa3ca7c2ffca2f3d974a6cce6.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e255b855e917caa3ca7c2ffca2f3d974a6cce6.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE60C21280
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.00

On 10:35 17/04, Josef Bacik wrote:
> Now that we've got the extent lock pushed into cow_file_range() we can
> push it further down into the allocation loop.  This allows us to only
> hold the extent lock during the dropping of the extent map range and
> inserting the ordered extent.
> 
> This makes the error case a little trickier as we'll now have to lock
> the range before clearing any of the other extent bits for the range,
> but this is the error path so is less performance critical.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

