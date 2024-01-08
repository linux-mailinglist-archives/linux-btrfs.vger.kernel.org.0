Return-Path: <linux-btrfs+bounces-1316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D453827A3A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FE71C227D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D595646D;
	Mon,  8 Jan 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N+VzWC+Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8vfHaaG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QCzm+SOd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q58J/JVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F45644D
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EE7E1FD1A;
	Mon,  8 Jan 2024 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704749621;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AFjCKXCiAyifbXjTyL/dKyjZvvQE9Vx9x25yhaKf08=;
	b=N+VzWC+ZB7lkB7NMNM2u/+YIVDwGHj5cs4dWgytLJY3PFYoDQb59W4FGbbeQDiv6dbWZAj
	f6u2uX1WYVCvIrun0kjESMDFA55OysKQp6ingcP6ejQigCX6PE4774HFn7jaFiGU5fodiY
	rHkFf9kMIJlXAVY47Pvn1A/gyoXEpgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704749621;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AFjCKXCiAyifbXjTyL/dKyjZvvQE9Vx9x25yhaKf08=;
	b=e8vfHaaGVUF/tpxfKyp3fmeSh3RntpSydawxEq5CpAk/Tv1xtEKsGlpra3yGUqyzTxmr/6
	dwqHxJPeC2U8POCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704749619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AFjCKXCiAyifbXjTyL/dKyjZvvQE9Vx9x25yhaKf08=;
	b=QCzm+SOdE60BqY05nGw51EK7YrbgU+nUySyZsoWgTp0vVBLhWR1QeN43Os4u6p3urn/lpg
	kL3z0+s0etuGUImnSGlJzd0rj4nHysStqBFijmAfiVe11sRrGY2NPDxneD3J7tqYF45awS
	/+e7WlnAxSmy/EnlkfqzUo68MndVqoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704749619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AFjCKXCiAyifbXjTyL/dKyjZvvQE9Vx9x25yhaKf08=;
	b=q58J/JVoayH+SbZJDrm2jWUWsleXXE+Fn2xdbYoYHME6Uv5mx45xQFAR8ZHAP71BcW1kZH
	LDLyOEBbWMez/NCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1934D13686;
	Mon,  8 Jan 2024 21:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r86YBTNqnGWYdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 21:33:39 +0000
Date: Mon, 8 Jan 2024 22:33:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
Message-ID: <20240108213325.GI28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2EE7E1FD1A
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QCzm+SOd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="q58J/JVo"
X-Spam-Score: -2.71
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.71 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[38.27%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]

On Mon, Jan 08, 2024 at 04:31:08PM +0800, Anand Jain wrote:
> For now, to circumvent the build error, create a placeholder file
> named contents.rst.
> 
> Sphinx error:
> master file btrfs-progs/Documentation/contents.rst not found

I don't see that error with sphinx 7.2.6, which version do you use?

> make[1]: *** [Makefile:37: man] Error 2
> make: *** [Makefile:502: build-Documentation] Error 2
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC because the empty contents.rst to fix the error.

Adding an empty file to silence the error is probably ok but what's the
reason to have it?

