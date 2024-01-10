Return-Path: <linux-btrfs+bounces-1352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB38292C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 04:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BF31F268F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3C613D;
	Wed, 10 Jan 2024 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iluhg0sP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xX7PHLHm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iluhg0sP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xX7PHLHm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AE6107
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 514DE1F849;
	Wed, 10 Jan 2024 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704857368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKlr6udfYaNkUsvMd+oD4xJtk7JEZStqyWAEANidc2o=;
	b=iluhg0sPp2GJGWdcKIoE9l0XQuq+obcpq8UmxaiD8ggEdRYXZ/isRCluH6qcpkrRR8XE9m
	plibojYlWuqEMZfnPKCLhLgadouA48mQt6HVXn3tY+xLGWealeTBHmgX4d+9vb/qj/xzxN
	lSMsrIXBAr7oruuEbpVPg0rgmBJ95ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704857368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKlr6udfYaNkUsvMd+oD4xJtk7JEZStqyWAEANidc2o=;
	b=xX7PHLHmsYLQdh7ja/buB0Y8o6IknAIVnTJVE19aUhRKJEkb4Xw1K11hqjg7eb7kOlENHf
	ot26hDhU5B9T4jAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704857368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKlr6udfYaNkUsvMd+oD4xJtk7JEZStqyWAEANidc2o=;
	b=iluhg0sPp2GJGWdcKIoE9l0XQuq+obcpq8UmxaiD8ggEdRYXZ/isRCluH6qcpkrRR8XE9m
	plibojYlWuqEMZfnPKCLhLgadouA48mQt6HVXn3tY+xLGWealeTBHmgX4d+9vb/qj/xzxN
	lSMsrIXBAr7oruuEbpVPg0rgmBJ95ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704857368;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKlr6udfYaNkUsvMd+oD4xJtk7JEZStqyWAEANidc2o=;
	b=xX7PHLHmsYLQdh7ja/buB0Y8o6IknAIVnTJVE19aUhRKJEkb4Xw1K11hqjg7eb7kOlENHf
	ot26hDhU5B9T4jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5A213C94;
	Wed, 10 Jan 2024 03:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBPBDhgPnmXYPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 03:29:28 +0000
Date: Wed, 10 Jan 2024 04:29:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix and simplify the inline extent
 decompression path for subpage
Message-ID: <20240110032913.GT28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704704328.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1704704328.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iluhg0sP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xX7PHLHm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.29
X-Rspamd-Queue-Id: 514DE1F849
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 07:38:43PM +1030, Qu Wenruo wrote:
> There is a long existing bug in subpage inline extent reflinking to
> another location.
> 
> The bug is caused by an existing bad code, which is from the beginning
> of btrfs.
> The bad code is never properly explained and got further copied into new
> compression code.

I think there was an idea to let an inline compressed extent to span
more than one page, but it never materialized. There could be code
handling it but due to the invariants (like that inline extent is always
smaller than a sector) it's never executed.

> The bad condition never got properly triggered by different reasons for
> different platforms:
> 
> - On 4K page sized system, the @start_byte is always 0
>   Thus the existing checks are all dead code, thus never triggered.
> 
> - For subpage (4K sectorsize 64K page size) cases, inline extent
>   creation is disable for a different reason
>   Since no inline extent can be created, there is no way to reflink
>   any inlined extent thus no way to trigger it.
> 
> The fixes are mostly going to rework the decompression loop, making sure
> the input and output buffer are always large enough for inline extent.
> Thus no need for any loop, but a single decompression call.

Yeah, as long as we have the page == sectorsize it's not necessary.

> But the difficulty lies in how to properly test the bug.
> For now I'm only doing cross-platform tests, using image created on
> x86_64, and do the reflink on aarch64.
> Not sure if it's possible to upload a binary image for fstests, or I
> don't have any good way to test the bug.

We had this discussion year ago (no crafted images) but the maintainer
of fstests changed meanwhile so you can try again. You can always add
that to progs but it won't get the same level of testing due to its
primary purpose to test the userspace code.

> Qu Wenruo (3):
>   btrfs: zlib: fix and simplify the inline extent decompression
>   btrfs: lzo: fix and simplify the inline extent decompression
>   btrfs: zstd: fix and simplify the inline extent decompression

Added to misc-next, thanks.

There are new error messages when the decompressed length is not
expected, this could be still improved (and made more consistent). The
name of the file or inode number and filesystem identification are
missing, but that's how the current code works.

