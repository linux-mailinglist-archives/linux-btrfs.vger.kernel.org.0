Return-Path: <linux-btrfs+bounces-22212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNfxNsqzp2k6jQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22212-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 05:23:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 817461FAAE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 05:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47583081071
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4D37F73D;
	Wed,  4 Mar 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z6JfVIQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eiPUZ9XT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z6JfVIQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eiPUZ9XT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552D37754D
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772598178; cv=none; b=GUUNFBASjNjTuuum2BQvdnAeBiTGhReyJ7oAn2z/hvyll8FCTziGlWx4SOY2Q++KpuIACzwlZVV/3aBjMt4YWL+vVqyTIRqdu2CS9bkZ+eZh3FZlaSZ+7KIS1f5rB6+WuRqBJFzxGpJ9PoBdV/JFsaooq+3zHFVVuKJGQdGN7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772598178; c=relaxed/simple;
	bh=c3sI1rzeuHbgM50UmwIGTmBWOw/BIJBlAAQ7UJn02ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6s8E5374QY7JHFYz5VW1dLgq2DU5tQcGFJ4hM6qUhNSBBCDz4FFOc516xhzErYmeyZOmO7cqHbYwG59UXBDglhXr0YUsLMYVHwyf5iGzcbCXdlZdlu59v9ESfmiDmZdEcgTqAX5UAd1mszUvNLs9fZ7f0n4Tc7asbg4hZDvDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z6JfVIQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eiPUZ9XT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z6JfVIQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eiPUZ9XT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 568683F921;
	Wed,  4 Mar 2026 04:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772598175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsdwVW8ueyPW6xcc741YoFnld9icFCAdtE2/Qi0O0VM=;
	b=z6JfVIQHChZ8tGRQG2IujnoGI+YuvltyKT4LxKurcaeP05f82UYQ7N6E41IlEDeUWz0a0t
	Ov4qwzVnlv5j09BiShSCcFXCCAfQlKJ5Ruz7kA6rNf9hDpAJ65oy8s36d+qzPmYwU5sD87
	jHt39xUe7AyEE144bohdnQcDL9gpFoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772598175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsdwVW8ueyPW6xcc741YoFnld9icFCAdtE2/Qi0O0VM=;
	b=eiPUZ9XTmC+5r45UZO68civOAA+5WhDRPiED3HNGPXp4iMgDB6zwONtKR46Oh5gXqLRKWA
	b566TgZsZ5BY+PCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z6JfVIQH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eiPUZ9XT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772598175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsdwVW8ueyPW6xcc741YoFnld9icFCAdtE2/Qi0O0VM=;
	b=z6JfVIQHChZ8tGRQG2IujnoGI+YuvltyKT4LxKurcaeP05f82UYQ7N6E41IlEDeUWz0a0t
	Ov4qwzVnlv5j09BiShSCcFXCCAfQlKJ5Ruz7kA6rNf9hDpAJ65oy8s36d+qzPmYwU5sD87
	jHt39xUe7AyEE144bohdnQcDL9gpFoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772598175;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsdwVW8ueyPW6xcc741YoFnld9icFCAdtE2/Qi0O0VM=;
	b=eiPUZ9XTmC+5r45UZO68civOAA+5WhDRPiED3HNGPXp4iMgDB6zwONtKR46Oh5gXqLRKWA
	b566TgZsZ5BY+PCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37A8E3EA69;
	Wed,  4 Mar 2026 04:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OSdUDZ+zp2maEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Mar 2026 04:22:55 +0000
Date: Wed, 4 Mar 2026 05:22:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 2/3] btrfs: inhibit extent buffer writeback to prevent
 COW amplification
Message-ID: <20260304042249.GI8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1772097864.git.loemra.dev@gmail.com>
 <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 817461FAAE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22212-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:51:07AM -0800, Leo Martins wrote:
> +/*
> + * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during transaction.
> + * @trans: transaction handle that will own the inhibitor
> + * @eb: extent buffer to inhibit writeback on
> + *
> + * Attempts to track this extent buffer in the transaction's inhibited set.
> + * If memory allocation fails, the buffer is simply not tracked. It may
> + * be written back and need re-COW, which is the original behavior.
> + * This is acceptable since inhibiting writeback is an optimization.
> + */

Minor thing, please check how functions should be commented, with the
parameter block.

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#comments

> +/*
> + * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers.
> + * @trans: transaction handle to clean up
> + */

Same

> @@ -102,6 +102,8 @@ struct extent_buffer {
>  	/* >= 0 if eb belongs to a log tree, -1 otherwise */
>  	s8 log_index;
>  	u8 folio_shift;
> +	/* Inhibits WB_SYNC_NONE writeback when > 0. */
> +	atomic_t writeback_inhibitors;

The extent buffer is a sensitive data structure so the layout and size
is closely watched. You increase the size to 248 bytes which is still
under 256 so it fits fine to the slabs. What is not good is the
placement after the s8/u8 members as this leaves 2 byte hole before and
4 byte hole after it

@@ -5666,15 +5669,19 @@ struct extent_buffer {
 
        /* XXX 2 bytes hole, try to pack */
 
-       struct callback_head       callback_head __attribute__((__aligned__(8))); /*    56    16 */
-       /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
-       struct rw_semaphore        lock __attribute__((__aligned__(8))); /*    72    40 */
-       struct folio *             folios[16];           /*   112   128 */
+       atomic_t                   writeback_inhibitors __attribute__((__aligned__(4))); /*    56     4 */
 
-       /* size: 240, cachelines: 4, members: 14 */
-       /* sum members: 238, holes: 1, sum holes: 2 */
-       /* forced alignments: 4, forced holes: 1, sum forced holes: 2 */
-       /* last cacheline: 48 bytes */
+       /* XXX 4 bytes hole, try to pack */
+
+       /* --- cacheline 1 boundary (64 bytes) --- */
+       struct callback_head       callback_head __attribute__((__aligned__(8))); /*    64    16 */
+       struct rw_semaphore        lock __attribute__((__aligned__(8))); /*    80    40 */
+       struct folio *             folios[16];           /*   120   128 */
+
+       /* size: 248, cachelines: 4, members: 15 */
+       /* sum members: 242, holes: 2, sum holes: 6 */
+       /* forced alignments: 5, forced holes: 2, sum forced holes: 6 */
+       /* last cacheline: 56 bytes */
 } __attribute__((__aligned__(8)));

We can't get rid of the holes unfortunately but at least placing it after
mirror_num the hole becomes contiguous:

@@ -5664,14 +5664,11 @@ struct extent_buffer {
        spinlock_t                 refs_lock __attribute__((__aligned__(4))); /*    40     4 */
        refcount_t                 refs __attribute__((__aligned__(4))); /*    44     4 */
        int                        read_mirror;          /*    48     4 */
-       s8                         log_index;            /*    52     1 */
-       u8                         folio_shift;          /*    53     1 */
+       atomic_t                   writeback_inhibitors __attribute__((__aligned__(4))); /*    52     4 */
+       s8                         log_index;            /*    56     1 */
+       u8                         folio_shift;          /*    57     1 */
 
-       /* XXX 2 bytes hole, try to pack */
-
-       atomic_t                   writeback_inhibitors __attribute__((__aligned__(4))); /*    56     4 */
-
-       /* XXX 4 bytes hole, try to pack */
+       /* XXX 6 bytes hole, try to pack */
 
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct callback_head       callback_head __attribute__((__aligned__(8))); /*    64    16 */
@@ -5679,8 +5676,8 @@ struct extent_buffer {
        struct folio *             folios[16];           /*   120   128 */
 
        /* size: 248, cachelines: 4, members: 15 */
-       /* sum members: 242, holes: 2, sum holes: 6 */
-       /* forced alignments: 5, forced holes: 2, sum forced holes: 6 */
+       /* sum members: 242, holes: 1, sum holes: 6 */
+       /* forced alignments: 5, forced holes: 1, sum forced holes: 6 */
        /* last cacheline: 56 bytes */
 } __attribute__((__aligned__(8)));

The placement to first cacheline cannot be avoided but the access pattern seems
consistent with the other members like refs or lock so this should be OK.

