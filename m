Return-Path: <linux-btrfs+bounces-5777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6190C34E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 08:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD4B284564
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 06:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC31CAAE;
	Tue, 18 Jun 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="csI1twWX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E1AXu13j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xg8M8mQQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k8Y7WWJO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349D81E
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718690606; cv=none; b=iwXjqxUzIuCoN6DzTzOs5KJmcMtvbRInKg+gDqxtL7Yt4Wjwq4Sf5XIPeASxWw5syITpF8s/wNaiVfIfWjewNMe2hwp54dMzo5TrBw90s58s/PShP+R9jql4/l9yB0g5Sg5/8t24AG7dZ3c+d/xkiLDqBiLoFO57W4tdpHMxq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718690606; c=relaxed/simple;
	bh=Ip8PmimKYCNENTlEK3PoTgQMRWcqlkctV/0zkPkBbPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPtNSPCRuDagSqZ1a6WHWBftr5Do4d3qH5DQSh3lxgdz+h1YQIJM2QWEeG4WLT+A6uNEVhUg/8Hhy+SixyTotEhgCV3ZaeY2ltQDolzyo6wr33cWEaKIjibSTHBRLmGudLYiObzjd9c8Ozp4PKfHlcQUPxEHuh+/gzEvLMd+eNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=csI1twWX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E1AXu13j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xg8M8mQQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k8Y7WWJO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E70D722733;
	Tue, 18 Jun 2024 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718690603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dRdd8L/QYZXP9sTDT3+f4Q3yfiiwvfCoF57q2OXq7c=;
	b=csI1twWXDoZAh7JQ6i1MeUkqsR7+Wqyw3xkw7hdOjNI26rtQDPonhat4XBg+spmcaaufna
	sKu0aTBYywQxW+M32obkRLS1EH44USi2BMKb7N0dm2MynVZB7+EozNsDqVQuJPRi6U/cn8
	Xm8O+bmdB3SF+imZRoEQI9VlzY71Xrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718690603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dRdd8L/QYZXP9sTDT3+f4Q3yfiiwvfCoF57q2OXq7c=;
	b=E1AXu13j6vrdpofRkqCK3d6ufPJN5fD4+2qyQBotqgJzVUka6iNVOpU/PfJKziN5aPxi/Q
	bApC42boO1CyeDDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718690601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dRdd8L/QYZXP9sTDT3+f4Q3yfiiwvfCoF57q2OXq7c=;
	b=Xg8M8mQQXkU976Tq4KhUXCcGQBIs8cvNj7e0ABDhxz5/DRASWtMOJo4qpVsvql7Pork9WV
	7qiSx/T1CH92ClxPirnftEcg8LOmCGomHcM9VVLOovGoS93qm0GeOoUgLFZSlOTbhPp7G+
	dLnfuC9W6K4AF3TCkUd344d1s79hQuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718690601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dRdd8L/QYZXP9sTDT3+f4Q3yfiiwvfCoF57q2OXq7c=;
	b=k8Y7WWJO8mJEiT1cxevs1TxFLqYEsnb8qXokgX3MAmDYh4C2BCOtfW26Vr1EldAsYKWWgy
	cr+VEbh4D1dehADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E5C13AA0;
	Tue, 18 Jun 2024 06:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uCf0JCYjcWZ2WAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 18 Jun 2024 06:03:18 +0000
Date: Tue, 18 Jun 2024 16:03:08 +1000
From: David Disseldorp <ddiss@suse.de>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>, Tom Rini
 <trini@konsulko.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
Message-ID: <20240618160308.5660ba6d.ddiss@suse.de>
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
References: <20240617194947.1928008-1-alexthreed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, 17 Jun 2024 22:49:47 +0300, Alex Shumsky wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> ---
> 
>  fs/btrfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..b51f578b49 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>  	extent_type = btrfs_file_extent_type(leaf, fi);
>  	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>  		ret = btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		memcpy(dest, buf + page_off, min(min(page_len, ret), len));

This looks (still) broken for the compressed inline extent error paths,
where ret=-errno .

nit: please prefix your patch subject with "uboot" so that casual
linux-btrfs readers like me don't get confused by matching kernel file
paths.

