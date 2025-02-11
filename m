Return-Path: <linux-btrfs+bounces-11376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E217A30DC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 15:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481CD3A69E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737624C69C;
	Tue, 11 Feb 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEERkML3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UiUGwSd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qEERkML3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UiUGwSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3924C67A;
	Tue, 11 Feb 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282900; cv=none; b=ciFGc325G/YqFwckKgvzZ2RnxJYVrfEet7QuMnJRZ10HpNQogx45jstjIYOHAMd9QRvKIs9brLGKSDI6CyF1MSgD2Douu6As68eFFIzWo4vv15KxDAHdscJxGmb8Kz7C5+gASiLsHzQvj9c6LOrEwfFVQHBh+EIrW5CoAlORfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282900; c=relaxed/simple;
	bh=Vw/O5t5y+OGLBWHGVYCZ5Gb3SsKiP2ZpTgbaezjt3Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYq9ldp1Ur/4g2ySkcg9JG8xIHlr9wSnIWnq73ikmkYGZ3hVrQWpL2OCHP9epKggJAj4jYGMDwsq0L9i+jO1FeLOcQO+lukR6ZuS3K1OaViZJSDkp1qtLBKcwC+jalHBxbMEgr+BwEtXsyfNq7Mhx1bNI6iHJXWGHEWKAylg7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEERkML3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UiUGwSd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qEERkML3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UiUGwSd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32AFC5C441;
	Tue, 11 Feb 2025 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739276351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjjzWe4XOTVAHDSZ7T43SXMiq1qjV4KZKLIpGkFuIc=;
	b=qEERkML3SbEW5FrU52Q6qSOsuZmMWDrY4NHm1gT6qw4U5EB9gR/NVViBaMAPB91wRtRZXM
	kFlGqIzBFvzrT3Ww2/M4V+66VXV2SBnn9eDNjR9vDS5H0V0nOReemRGAeCqD8B5/DYrkM7
	CkEwiqDt/bosma2/lXeZS9o/MCV5cf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739276351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjjzWe4XOTVAHDSZ7T43SXMiq1qjV4KZKLIpGkFuIc=;
	b=/UiUGwSdPyCnYA14RWvmUVkM8FCK0bLoegGSrod6wbYaCg0T78c1LEMBQZsiQ3QkKC98oH
	MqDTsEXVwVOwWMAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739276351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjjzWe4XOTVAHDSZ7T43SXMiq1qjV4KZKLIpGkFuIc=;
	b=qEERkML3SbEW5FrU52Q6qSOsuZmMWDrY4NHm1gT6qw4U5EB9gR/NVViBaMAPB91wRtRZXM
	kFlGqIzBFvzrT3Ww2/M4V+66VXV2SBnn9eDNjR9vDS5H0V0nOReemRGAeCqD8B5/DYrkM7
	CkEwiqDt/bosma2/lXeZS9o/MCV5cf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739276351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjjzWe4XOTVAHDSZ7T43SXMiq1qjV4KZKLIpGkFuIc=;
	b=/UiUGwSdPyCnYA14RWvmUVkM8FCK0bLoegGSrod6wbYaCg0T78c1LEMBQZsiQ3QkKC98oH
	MqDTsEXVwVOwWMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 601D513782;
	Tue, 11 Feb 2025 12:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHJFBj1Aq2fCHwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 11 Feb 2025 12:19:09 +0000
Date: Tue, 11 Feb 2025 23:19:02 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH v2] fstests: add a generic test to verify direct IO
 writes with buffer contents change
Message-ID: <20250211231902.5e8c0694.ddiss@suse.de>
In-Reply-To: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
References: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 11 Feb 2025 16:22:57 +1030, Qu Wenruo wrote:

...
> diff --git a/src/dio-writeback-race.c b/src/dio-writeback-race.c
> new file mode 100644
> index 000000000000..f0a2f6de531b
> --- /dev/null
> +++ b/src/dio-writeback-race.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dio_writeback_race -- test direct IO writes with the contents of
> + * the buffer changed during writeback.
> + *
> + * Copyright (C) 2025 SUSE Linux Products GmbH.
> + */
> +
> +/*
> + * dio_writeback_race
> + *
> + * Compile:
> + *
> + *   gcc -Wall -pthread -o dio_writeback_race dio_writeback_race.c

nit: hyphens instead of underscores: dio-writeback-race.c

...
> +	fd = open(argv[optind], O_DIRECT | O_WRONLY | O_CREAT);
> +	if (fd < 0) {
> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[2]);

argv[optind] instead of argv[2] in the error msg. With that fixed:

Reviewed-by: David Disseldorp <ddiss@suse.de>

