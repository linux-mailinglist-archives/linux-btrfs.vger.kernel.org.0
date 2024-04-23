Return-Path: <linux-btrfs+bounces-4492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A28AE527
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF81C22C82
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1D14C5BF;
	Tue, 23 Apr 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0QH5m6cg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IL0vCeg2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0QH5m6cg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IL0vCeg2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609014C594
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872533; cv=none; b=DYz2PZrmXwJ5holaV2fNoe8sTZEgz/Fd/EkexP/i0NzfIzu+YASXh9tugQOZjxfLGQazd1BH4ufAb6i8AUXckuzEDfcc238zGQgrr1Zk52Wwr1ll0A3CJIKX7e5MMEby68QfGrZhDUniM9gok2qqclxmiSqqlkqTUjsB2XqWJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872533; c=relaxed/simple;
	bh=KmZhm+O2+m0yOlOHSjVKDpiRfqDi+ZKUra4FoASP3p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9z9OLqKDTmH1aVkZ7r2UzwPkqEZnjOUWXw8B67JMPdGB8R8MpagxwM7sRRLoCEbWAb7p6fL49pbEKHvNBw7Xjis1TUq3uHg6ACY/rWkaDiZWEnR3cDGVTUvLNfy89GHGeMfCcXnguLE//E87z772LVTyuLqLUq1ae+3RK0sCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0QH5m6cg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IL0vCeg2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0QH5m6cg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IL0vCeg2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5B8437E91;
	Tue, 23 Apr 2024 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvPLNHzaFVsupP1KXs2N3OdOmFuFXyBiuHQzZs8O2d0=;
	b=0QH5m6cg4tVfepYfoFP5+f0D1UvjkTwlyDtj96YFC2oYlmm8nw61MqvZPdR/qegyXBvkY0
	2GI9D1eJNX3W70kx28M+sz7nem4Qg7E6F6cDDyeAYXTxVoGT84RqAg+sHEwzhk1Babl7Bm
	HnNeILV3qPPNWL0jOtbKAljExN04c8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvPLNHzaFVsupP1KXs2N3OdOmFuFXyBiuHQzZs8O2d0=;
	b=IL0vCeg2kII2hUydp0b3fhZk6NDlk0/1P+3wrdp6PvgLcTA3eRkOPQrfAYZK3PG4YupVp7
	5CxkKczWedkLunDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvPLNHzaFVsupP1KXs2N3OdOmFuFXyBiuHQzZs8O2d0=;
	b=0QH5m6cg4tVfepYfoFP5+f0D1UvjkTwlyDtj96YFC2oYlmm8nw61MqvZPdR/qegyXBvkY0
	2GI9D1eJNX3W70kx28M+sz7nem4Qg7E6F6cDDyeAYXTxVoGT84RqAg+sHEwzhk1Babl7Bm
	HnNeILV3qPPNWL0jOtbKAljExN04c8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvPLNHzaFVsupP1KXs2N3OdOmFuFXyBiuHQzZs8O2d0=;
	b=IL0vCeg2kII2hUydp0b3fhZk6NDlk0/1P+3wrdp6PvgLcTA3eRkOPQrfAYZK3PG4YupVp7
	5CxkKczWedkLunDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA32813929;
	Tue, 23 Apr 2024 11:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cz0DKZGeJ2beRQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Apr 2024 11:42:09 +0000
Date: Tue, 23 Apr 2024 06:42:08 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 17/17] btrfs: add a cached state to
 extent_clear_unlock_delalloc
Message-ID: <2snkxhpyjkpuqssosfcl7fokuefnmgabt4cnbzy24rca7uxrks@vpu4a5u24wn4>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <62f3c0fa890b9bebc7f2d1871ec4c885c5287ed5.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f3c0fa890b9bebc7f2d1871ec4c885c5287ed5.1713363472.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.24 / 50.00];
	BAYES_HAM(-1.44)[91.24%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email]
X-Spam-Score: -2.24
X-Spam-Flag: NO

On 10:36 17/04, Josef Bacik wrote:
> Now that we have the lock_extent tightly coupled with
> extent_clear_unlock_delalloc we can add a cached state to
> extent_clear_unlock_delalloc and benefit from skipping the extra lookup
> when we're doing cow.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Yay, for caching!
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn

