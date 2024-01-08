Return-Path: <linux-btrfs+bounces-1309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A482768E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9662843D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469B55790;
	Mon,  8 Jan 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVEKFdf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeNGg6hx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0hijc6s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyV1559Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE954BDF;
	Mon,  8 Jan 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2A2D1F797;
	Mon,  8 Jan 2024 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704735724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7KQlLmOTJKpEmRk56cHZq9qEZEUX3aGCyOQwo4iXiM=;
	b=jVEKFdf+g1K8KXO0cz1Gy5FB9bO2BM/KvhRXokFt9GSVK3EWK/iuyW3agXhCkE9cBvU1Dt
	HebI+GB6zJmw8E9u7k1sSIKxVjCzrJtDoeaPQI/LETBm7hFlQpc7KJbctJcABf91+5BVql
	mEnFhWI1pQgSdQRpwqFrm+n28eSz4DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704735724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7KQlLmOTJKpEmRk56cHZq9qEZEUX3aGCyOQwo4iXiM=;
	b=CeNGg6hxuPN9PEeD0Um6sl3wFQroBo72n4pkDF/hDQCkhJREFzqXxrskZ34op0YmEqXay7
	edLXUHL9dfgH7UDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704735721;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7KQlLmOTJKpEmRk56cHZq9qEZEUX3aGCyOQwo4iXiM=;
	b=m0hijc6sMBA4WgBxL3u8U8pCYrNlNRfDKAJGF8nkTtiu4/8LMJt/XAto1oia9Ry3VqGd0Y
	esD9iPIliLM6JkIgEf6OUrcTy6JX8uiRIyZ9HjAdmPpiTYxi0jmzruMOV0qtSEToUsJX6U
	bb1jXuj5x5XOE6ZVlll2DgyPal6vb9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704735721;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7KQlLmOTJKpEmRk56cHZq9qEZEUX3aGCyOQwo4iXiM=;
	b=KyV1559QLJ88ce4WTz5av2GXayWWs98k6PqRGBtHxWadsjyRYaspJA2Ws1N1zLUYFQJ2xX
	aBIwXeS7Xt+EnEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C78713686;
	Mon,  8 Jan 2024 17:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u9/vJekznGWrQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 17:42:01 +0000
Date: Mon, 8 Jan 2024 18:41:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Denis Efremov <efremov@linux.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: Silence build warning about kvcalloc()
Message-ID: <20240108174147.GC28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240108041351.9847-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108041351.9847-1-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m0hijc6s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KyV1559Q
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.94 / 50.00];
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
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,loongson.cn:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.73)[93.34%]
X-Spam-Score: -2.94
X-Rspamd-Queue-Id: C2A2D1F797
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 12:13:51PM +0800, Tiezhu Yang wrote:
> There exist the following warning when building kernel v6.7:
> 
>   CC      fs/btrfs/send.o
> fs/btrfs/send.c: In function ‘btrfs_ioctl_send’:
> fs/btrfs/send.c:8208:44: warning: ‘kvcalloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>  8208 |         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
>       |                                            ^
> fs/btrfs/send.c:8208:44: note: earlier argument should specify number of elements, later size of each element
> 
> tested with the latest upstream toolchains (20240105):
> 
>   [fedora@linux 6.7.test]$ gcc --version
>   gcc (GCC) 14.0.0 20240105 (experimental)
>   [fedora@linux 6.7.test]$ as --version
>   GNU assembler (GNU Binutils) 2.41.50.20240105
>   [fedora@linux 6.7.test]$ ld --version
>   GNU ld (GNU Binutils) 2.41.50.20240105
> 
> just switch the first and second arguments of kvcalloc() to silence
> the build warning, compile tested only.
> 
> Fixes: bae12df966f0 ("btrfs: use kvcalloc for allocation in btrfs_ioctl_send()")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks, a fix has been already sent
https://lore.kernel.org/linux-btrfs/20231221084748.10094-1-dmantipov@yandex.ru/

