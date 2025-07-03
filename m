Return-Path: <linux-btrfs+bounces-15230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE32AF8255
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412D67A94DC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128942BE643;
	Thu,  3 Jul 2025 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0prnCv6D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVNavfso";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+4LH8dI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZtkW7Dg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B7770E2
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576243; cv=none; b=auz4jdHhopWirTryRfYlVJlYJSUa/I85J45sPYI5w+MEAaifPnzYF+UX6ZrwIppp5TR1bS3zG2tRnUrm/X0fIjbyM8Ao1KB9Ese1LNlgJ9sce5q+Bn8Cf24zVIx47MU+f5HmwgWVdt7/GnK4FO27NSOhmtqa650t4uD1tNPJXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576243; c=relaxed/simple;
	bh=s4pCe8fleBoXDvdhvfGnYIOl55Iy0dZk3X2NWZiT528=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um6uQe+/0v4u4TQRddObAj7zA0LysnYGbgdLYL7FCWzCYbTUmlVPtvkGRIcuo8PEnIX8HloNXNgRz3v77mvdW5bBXPCZTtA/2aD5Sq0o7cC4XPJ8+PfQiRmc+pRXxdqmHhP1/TqIFc2S761OjTQ3rJtQisYGapn2hzAsMyDUeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0prnCv6D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVNavfso; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+4LH8dI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZtkW7Dg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B231121185;
	Thu,  3 Jul 2025 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751576237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TateqvmmRKYA9Al2Kr2Ixdaolsmn3AGnez5p4BZWcfQ=;
	b=0prnCv6DYRJCTHWjQBYWe9Nx59XS/PaTQfy5D7X+gCEDb5/MGPwL/OyYwph00MJx5+DsJa
	mv8GzWv1Lbn9J4R42UdPjJCIgmZZeIrDpBBo8Mzw0Ty+zOfjmazD8CTQ4umZGQA7AFeKNr
	ZC2y1sd7WJoa+MNn/8cuYjZhSPMoj4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751576237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TateqvmmRKYA9Al2Kr2Ixdaolsmn3AGnez5p4BZWcfQ=;
	b=AVNavfsouWcWBMimFlAozjbgSCT0dwl3FTdJm4vjKXeGtiFF1SLMu/OplsLf1ByDNluBNE
	2yPzOxZUyXD6iiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f+4LH8dI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NZtkW7Dg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751576235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TateqvmmRKYA9Al2Kr2Ixdaolsmn3AGnez5p4BZWcfQ=;
	b=f+4LH8dI08mnbM567JsN79lYjJQt5P6brdAUcoxxC02vEfKeaAjGsZ1luu5kw0alv0uTwi
	IH7AzK/qTYSGLhkAC2hBSHFS9F0cCwy1MujoE9a87bgMJcB5owaEOSn7T8ENfWH3yLkZAg
	28bIrJFBdMa/XnN3MkXUNiEFxPQlDMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751576235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TateqvmmRKYA9Al2Kr2Ixdaolsmn3AGnez5p4BZWcfQ=;
	b=NZtkW7DgljlwZGShCn5OVlQ1EK6o2oWs4jR3Oo3Wa6RvhXmC871D727bIb1nt+1FqODjJP
	0GtVDzZcQeqTGRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9BB1368E;
	Thu,  3 Jul 2025 20:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xMiTIqvuZmiKVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Jul 2025 20:57:15 +0000
Date: Thu, 3 Jul 2025 22:57:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/7] btrfs: accessors: factor out split memcpy with two
 sources
Message-ID: <20250703205710.GX31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751390044.git.dsterba@suse.com>
 <1db66bf81b5790c6e14183a5c30a8abf6d1b1126.1751390044.git.dsterba@suse.com>
 <20250702185337.GC2308047@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702185337.GC2308047@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B231121185
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:replyto]
X-Spam-Score: -4.21

On Wed, Jul 02, 2025 at 11:53:37AM -0700, Boris Burkov wrote:
> On Tue, Jul 01, 2025 at 07:23:54PM +0200, David Sterba wrote:
> > The case of a reading the bytes from 2 folios needs two memcpy()s, the
> > compiler does not emit calls but two inline loops.
> > 
> > Factoring out the code makes some improvement (stack, code) and in the
> > future will provide an optimized implementation as well. (The analogical
> > version with two destinations is not done as it increases stack usage
> > but can be done if needed.)
> 
> Is there some fundamental reason for this, or does it just happen to be
> so? Sort of interesting either way. Does it make you worry that this
> stuff will regress randomly in the future?

My explanation for that is that it's in the compiler optimization black
box, the function is inline and when evaluated in the context of the
caller it just came out worse.

This is the patch:

--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -29,6 +29,14 @@ static __always_inline void memcpy_split_src(char *dest, const char *src1,
        memcpy(dest + len1, src2, total - len1);
 }
 
+static __always_inline void memcpy_split_dest(char *dest1, const char *src,
+                                             char *dest2, const size_t len1,
+                                             const size_t total)
+{
+       memcpy(dest1, src, len1);
+       memcpy(dest2, src + len1, total - len1);
+}
+
 /*
  * Macro templates that define helpers to read/write extent buffer data of a
  * given size, that are also used via ctree.h for access to item members by
@@ -105,9 +113,9 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,    \
                kaddr = folio_address(eb->folios[idx + 1]);             \
                *kaddr = lebytes[1];                                    \
        } else {                                                        \
-               memcpy(kaddr, lebytes, part);                           \
-               kaddr = folio_address(eb->folios[idx + 1]);             \
-               memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);  \
+               memcpy_split_dest(kaddr, lebytes,                       \
+                                 folio_address(eb->folios[idx + 1]),   \
+                                 part, sizeof(u##bits));               \
        }                                                               \
 }
 
---

And the evaluation:

  btrfs_set_64                                           +8 (24 -> 32)
  btrfs_set_32                                           +8 (24 -> 32)

     text    data     bss     dec     hex filename
  1454157  115665   16088 1585910  1832f6 pre/btrfs.ko
  1454173  115665   16088 1585926  183306 post/btrfs.ko

  DELTA: +16

I excluded the patch because of the worse stack and code diff, because
the other patches were all an improvement. This one was preparatory for
the fancy optimization I have so it can be placed to a helper instead of
the macro. Given the remaining time before code freeze it would not
leave enough time for testing and it might also be a generic helper in
the end.

