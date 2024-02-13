Return-Path: <linux-btrfs+bounces-2361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE726853B8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5B31F23011
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E766089C;
	Tue, 13 Feb 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l8noWXWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbVQorL3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bcxSONh2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="20UkX9sV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996D60879
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853713; cv=none; b=j13fGpf85ltvA1CAoG7NaGPxoLt/oyiP7CnCBrqooaaQ62Jw0AKNeH4o7SnXjS1c/0puAIraXi6jHn+db8QbbebOCj4ezvjnMW+1swKnIUUVx5bedyihd43bfp7P1k1+D2kZ6BYrY6DLHXfFsWA2W8ChThclwm8p1zIZ1Rnmggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853713; c=relaxed/simple;
	bh=eCHhdacobvgJQcG80c2HJVN3DxCCJ/t6LteFSvkFcLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmBMt0qW1p4H03UyIED/sEgOawbVc0HsDZK/0aMacI/qIijZo/tGgdfHeLAR8lN/cTSn2TTIpHEjp4a6smjnRTPpjUzC/uAtaBMYlvzVUuXUz6Sgcm/quIOuALuX2KIuRPuzgYJIqVxtRfvSEx4N4e20skuScHfsAl9/4/B8rV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l8noWXWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RbVQorL3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bcxSONh2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=20UkX9sV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF79C1FCF0;
	Tue, 13 Feb 2024 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707853710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fPfnlhk5uCfnvm2FBZl3W5ROmTkwgas4ig1wx82gD8=;
	b=l8noWXWfvBdVj1RHrdzM4zfh8NfIfFiz0mMZqGidJYdI98gLyQr9L0Mz6nuwlxMahANYrh
	w3Ku9NhqdF9ew0iJpijXVr7DvSTjtxuiVTP3vJCwAGYPo1E5Ak+NRcIvQNQ2p5f7VKMlUC
	4qiRNwm66bFrb36/cNCfpPh/cwNlECI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707853710;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fPfnlhk5uCfnvm2FBZl3W5ROmTkwgas4ig1wx82gD8=;
	b=RbVQorL3592r8QzbKhSqZVFBh404iOWmZN8Tt6iNpIheD8abciw1kkOcMgGTTvH9F4i0JZ
	wrH5nZ21bND2vGBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707853708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fPfnlhk5uCfnvm2FBZl3W5ROmTkwgas4ig1wx82gD8=;
	b=bcxSONh222KHRZv14oKjcXNQDaZxHW72bIl1hUSLyJHZSmA3m80VQPv3Hac+p/atjS1++b
	dCAM4vJm1y4p/ToR5VGmCG9JsXz5jbau9DzWGLC2+QRSRNhf0ZgVgqm2QcCXYZIHACHFR6
	UF+bEOfNLeFqCA5YVq7VP0MaXaLeOEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707853708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fPfnlhk5uCfnvm2FBZl3W5ROmTkwgas4ig1wx82gD8=;
	b=20UkX9sVq6XWgnOD6G3Ohv0mLNAajBxFPy/FSzaHx35tgqTsmv7rkU+GoS8fO/LexT3m8l
	94p+O5tdfxK7QQCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CC30013583;
	Tue, 13 Feb 2024 19:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WHprMYzHy2VBNAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 19:48:28 +0000
Date: Tue, 13 Feb 2024 20:47:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Davide Cavalca <davide@cavalca.name>
Subject: Re: [PATCH] btrfs: sysfs: Drop unnecessary double logical negation
 in acl_show()
Message-ID: <20240213194755.GI355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240212013449.1933655-1-neal@gompa.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212013449.1933655-1-neal@gompa.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bcxSONh2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=20UkX9sV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.22 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.80%]
X-Spam-Score: -1.22
X-Rspamd-Queue-Id: DF79C1FCF0
X-Spam-Flag: NO

On Sun, Feb 11, 2024 at 08:34:44PM -0500, Neal Gompa wrote:
> The IS_ENABLED() macro already guarantees the result will be a
> suitable boolean return value ("1" for enabled, and "0" for disabled).
> 
> Thus, it seems that the "!!" used right before is unnecessary, since
> it is a double negation.

Double negation is used to force 0/1 boolean values if it's from an
unknown source or value range but IS_ENABLED says it's returning 0/1 so
yeah it's not needed.

> Dropping it should not result in any functional changes.
> 
> Signed-off-by: Neal Gompa <neal@gompa.dev>

Reviewed-by: David Sterba <dsterba@suse.com>

