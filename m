Return-Path: <linux-btrfs+bounces-4942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB48C475F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48308285D0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27657CB6;
	Mon, 13 May 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZIPavBLk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dgubL7wx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZIPavBLk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dgubL7wx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3C54FB8;
	Mon, 13 May 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627150; cv=none; b=e2feHp8QMcuaKs4oll578pC+LDkQnVyP9q3XgMgYLZbuirFJcRj8i0iCw5ZWbE8BM7etpQJQt4Q0JtUxL8avx6s6PFWFB1k0oe44D6U7ls4VxcTw6AmDUOuVav0dlFGqFKGk30MEO52eKidrzzn/mv4NAF/5sdnBTuz9BqAwALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627150; c=relaxed/simple;
	bh=X11Zb28Qgg4Meh/uCzRmFOrxVfytCsNy90Luv0dNZKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGd2IiBW2nnfKGe4xgDkUzJa5Bz8AJ2/kL68pYAc9uRz6SsOHU6KwIUNalmY9RrAxSzzvJjpHMzcCsYpwi36sO4CDCqGFsnCyHW2qE2fmVExD0ilSs8h5FlLN+XqF2R1hxHw9dQoQq1aaOu/L4TP5/F9cVzsx14WeAMc8z9ps2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZIPavBLk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dgubL7wx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZIPavBLk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dgubL7wx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 444175CC3E;
	Mon, 13 May 2024 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715627147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCivkb5dEggnfF6c49cGdN6dbXYInwCyfzA9Or7AmVs=;
	b=ZIPavBLk3ptqm/mk50HNqvx5BrdOYgJHa2kr60mg9BH98agBTycly0YkJid8UUhAIPgG5Z
	OHWmAuGWNd19v4dbk+hV6dAJylJVLGahuW/Yilz1aeeRTynAtfrxLhXFYEReg9uyYGwvdg
	j9z/7FEYF+cd3ULRcY1HT1PrM/PN3Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715627147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCivkb5dEggnfF6c49cGdN6dbXYInwCyfzA9Or7AmVs=;
	b=dgubL7wxTTdj0PFM1Y6QQ2ikoIjwb88KVMXngo1qma92aTpxh1SL/Ohh2FcSWQpH8BnmhY
	afrfoT1pPvY9LJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715627147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCivkb5dEggnfF6c49cGdN6dbXYInwCyfzA9Or7AmVs=;
	b=ZIPavBLk3ptqm/mk50HNqvx5BrdOYgJHa2kr60mg9BH98agBTycly0YkJid8UUhAIPgG5Z
	OHWmAuGWNd19v4dbk+hV6dAJylJVLGahuW/Yilz1aeeRTynAtfrxLhXFYEReg9uyYGwvdg
	j9z/7FEYF+cd3ULRcY1HT1PrM/PN3Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715627147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCivkb5dEggnfF6c49cGdN6dbXYInwCyfzA9Or7AmVs=;
	b=dgubL7wxTTdj0PFM1Y6QQ2ikoIjwb88KVMXngo1qma92aTpxh1SL/Ohh2FcSWQpH8BnmhY
	afrfoT1pPvY9LJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25C7413A52;
	Mon, 13 May 2024 19:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AD+6CItkQmasEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 13 May 2024 19:05:47 +0000
Date: Mon, 13 May 2024 20:58:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Lu Yao <yaolu@kylinos.cn>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: fix a compilation warning
Message-ID: <20240513185822.GD4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240507023417.31796-1-yaolu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507023417.31796-1-yaolu@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.42 / 50.00];
	BAYES_HAM(-1.42)[91.10%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -2.42
X-Spam-Flag: NO

On Tue, May 07, 2024 at 10:34:17AM +0800, Lu Yao wrote:
> The following error message is displayed:
>   ../fs/btrfs/scrub.c:2152:9: error: ‘ret’ may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]"
> 
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> gcc version: (Debian 10.2.1-6) 10.2.1 20210110

The compiler version should be in the changelog as we want to know which
version produces the warning, but otherwise ok. Patch added to for-next,
thanks.

