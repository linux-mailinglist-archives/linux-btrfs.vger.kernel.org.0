Return-Path: <linux-btrfs+bounces-4491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2478AE441
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 13:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BAB1C22A1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28A8003B;
	Tue, 23 Apr 2024 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E1jWr0Qn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXdj0yMh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E1jWr0Qn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hXdj0yMh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8EC7D3E6
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872390; cv=none; b=Nfv+KzQi5dh/N3w4BaruB7og0ZUGdjD8C68jvhlKlUvlHS/0ORxKPYd1FCH7QsvVTuPovg9yhQ8EV8ft5bEwAo9kNfH4/wW43g55Uj9ygOYziyXxB79mG28HbX7rmVNIrDp0qEQntc22jT5wxRkndDwuTb/v7i69Uo5RLbH+3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872390; c=relaxed/simple;
	bh=gtB3ifc/DsP09wUU6jOoFmRjkfJRkvacbqw3i8XXFzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+6/Hp5/LGg5H14KzYx8bmNCKZQsI0vcj7aFLkmq/bnmd8P3B5cWQ65b0co03MTfj764XfEBCPuIB1vhIdN10pVnhQYlHOcHk2td9kSHQZt5vh0DifR0JyorDWW4iPDdl1G6+GVajyWcswrrdw3p4cOxABjJ2ka/lVv39JMtrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E1jWr0Qn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXdj0yMh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E1jWr0Qn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hXdj0yMh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11D115FDFF;
	Tue, 23 Apr 2024 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thaX6h3LZfPLzgicQcLbL9PLcG1cxJ18FHhNpcIt64I=;
	b=E1jWr0QnJmZ1YEmqOGIlA8nFVeL5yTGfcyf54jonmU9QEuW8keAUYUXUK547dB6z/Mqks4
	AQFJrOGlWLCaSJh1Y6okmQWvI/N3flTjVjUDlPcr4u3QJMAfhFRl5rhMq7TRcBMcBOoLAY
	/5OV5omGa7MicD7bvWKUsyYgQB0VYdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thaX6h3LZfPLzgicQcLbL9PLcG1cxJ18FHhNpcIt64I=;
	b=hXdj0yMhqXADctj6IubOTVob0nZBj1Rdmeqc7afvzPu8M61bmNhK+2K6K4Ur9m5momVQB/
	+LLDGhSgjVq1X4AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E1jWr0Qn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hXdj0yMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713872387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thaX6h3LZfPLzgicQcLbL9PLcG1cxJ18FHhNpcIt64I=;
	b=E1jWr0QnJmZ1YEmqOGIlA8nFVeL5yTGfcyf54jonmU9QEuW8keAUYUXUK547dB6z/Mqks4
	AQFJrOGlWLCaSJh1Y6okmQWvI/N3flTjVjUDlPcr4u3QJMAfhFRl5rhMq7TRcBMcBOoLAY
	/5OV5omGa7MicD7bvWKUsyYgQB0VYdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713872387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thaX6h3LZfPLzgicQcLbL9PLcG1cxJ18FHhNpcIt64I=;
	b=hXdj0yMhqXADctj6IubOTVob0nZBj1Rdmeqc7afvzPu8M61bmNhK+2K6K4Ur9m5momVQB/
	+LLDGhSgjVq1X4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07BE813929;
	Tue, 23 Apr 2024 11:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HppWAQOeJ2Y7RQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Apr 2024 11:39:47 +0000
Date: Tue, 23 Apr 2024 06:39:46 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 16/17] btrfs: push extent lock down in
 submit_one_async_extent
Message-ID: <r5qtxgmkdkfol7djlvmyzxnpxpjdf4e3o5tublf2qhnfa2kz5d@lqomkwdewd2o>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <24251ec51aaea6cd39b22e3969d4e8e2a878808d.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24251ec51aaea6cd39b22e3969d4e8e2a878808d.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 11D115FDFF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	BAYES_HAM(-1.50)[91.70%];
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
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.com:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 10:36 17/04, Josef Bacik wrote:
> We don't need to include the time we spend in the allocator under our
> extent lock protection, move it after the allocator and make sure we
> lock the extent in the error case to ensure we're not clearing these
> bits without the extent lock held.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.
Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn

