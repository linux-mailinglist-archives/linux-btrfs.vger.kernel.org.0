Return-Path: <linux-btrfs+bounces-22237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIMtBtLlqGk3ygAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22237-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:09:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603020A1A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFF10301BFBB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473425A2C9;
	Thu,  5 Mar 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kXVHvZJZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dXA9rwae";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eidFt8VX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvV2juby"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4C25524C
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676551; cv=none; b=HejoFXv31d7zBwCoCtQtMAA8Xbt7H+/Rb8uFvquwg6wB4RP9pxXc37JC728rtsHjwB0XSXOduQimmMY5xOGurSboBL4PWulDEqSkTSDKBhwXC21jRkSla4vZ4vffEsqZLZpCB6uYTVFLyVSa9ryehH7Sn51BnjgV4vfxcP2kwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676551; c=relaxed/simple;
	bh=eh/NDTNde3nrGm9moehKrub2drCBeOYgKCwyLWhlTxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc3hNCC+KKSAawYkx9S9JvdGqxIZxA8heaarHhxBhXB00L9qfnkT3xYG9oRe0qwSm0z/qp30W+Vu86B5WxUvPpUKYDxzyfVfIItsRuK1TKsy1mDmM50FTzQK9JK5hsSlYkKo07giiWBcym7MD6O+DuNazwF8qppXr+Kienfu26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kXVHvZJZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dXA9rwae; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eidFt8VX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvV2juby; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED1C13F97D;
	Thu,  5 Mar 2026 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772676548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqAvnANs/kFfbXgsB2p/cZnJ4km6ppCDPnPRiYDkEi8=;
	b=kXVHvZJZzynnK5ZvJFgJp4gSC8TmG3h5RHXfZUPmfkLt+SXIfRlAFmdHCGQUCtJioUBRrV
	3am20uGv3CUC8NWPpjJtzgb/iblRsEgyTXbNjLjEoUk7dLZzDGyt1KFhK8SoB6yW/AMhbp
	k4QtosADtJOXuw7TqIgdE6nRqA5+5Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772676548;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqAvnANs/kFfbXgsB2p/cZnJ4km6ppCDPnPRiYDkEi8=;
	b=dXA9rwaeiTZ+y/o5prSRIlO/3Zl/qw1DerSS5FuB9w5B/2bMlsbK2ZbF6qPwUE55ICkAgM
	g00dNZyH5FuZb+Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772676547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqAvnANs/kFfbXgsB2p/cZnJ4km6ppCDPnPRiYDkEi8=;
	b=eidFt8VX4EFIrzz8IyxJXfZgZX7bhMkCNFciRDby2Ibg56GnbyIc9ecK8koWxxuFiqpqd2
	2uKodbU5AeQzrxfqOi+r09fetE6D4zQNZV8p/VQUY07K+DL2Q8EbgDchw/ECeguIVYQ/TJ
	9w4JlVqkZ4ihqdJSBeWUCnmN6XTn4Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772676547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqAvnANs/kFfbXgsB2p/cZnJ4km6ppCDPnPRiYDkEi8=;
	b=HvV2juby8FXJYypqqzeYyTWIMNY8LrtwgB8AqYJUkHBJxCvZ8pjISwfonaZeHX+ejJOAmI
	Bv94lHyNiwUsJ7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9AFA3EA68;
	Thu,  5 Mar 2026 02:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a5QMMcPlqGnaZwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Mar 2026 02:09:07 +0000
Date: Thu, 5 Mar 2026 03:09:02 +0100
From: David Sterba <dsterba@suse.cz>
To: ZhengYuan Huang <gality369@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject global extent/csum roots without offset 0
 when extent_tree_v2 is off
Message-ID: <20260305020902.GA5735@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260302110202.790279-1-gality369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302110202.790279-1-gality369@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 1603020A1A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22237-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,suse.com,toxicpanda.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 07:02:02PM +0800, ZhengYuan Huang wrote:
> Without EXTENT_TREE_V2, btrfs_extent_root() and btrfs_csum_root() always
> look up the global roots at offset 0. A crafted image can provide only
> non-zero offsets for the extent/csum global roots, so the offset 0 lookup
> returns NULL and later leads to a NULL dereference
> (e.g. in backup_super_roots()).
> 
> Fix this by detecting this at mount time: when loading extent/csum
> global roots without EXTENT_TREE_V2, require that an offset 0 root item
> exists, otherwise fail the mount with -EUCLEAN.
> 
> Tested with a crafted image that has only non-zero offset global roots,
> which triggers the KASAN null-ptr-deref in backup_super_roots() before
> the fix, and fails the mount with -EUCLEAN after the fix.
> 
> Fixes: f7238e509404 ("btrfs: add support for multiple global roots")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>

You've cut the changelog here but the rest of the information should be
also there, perhaps in a more condensed form. You can add other things
under the "---" line in case it's relevant for the patch submission but
not for the long term git history.

> ---
[...]

> CPU: 0 UID: 0 PID: 34 Comm: kworker/u8:1 Tainted: G           OE       6.18.0 #1 PREEMPT(voluntary)

> Reproduction (v6.18, x86_64, KASAN)
> ===================================
> 1. Download the crafted image (tested with Linux v6.18 + KASAN):

This seems to be testing 6.18 and probably the exact release, not the
updated stable branch which is 6.18.16 right now. It's OK to test on
older versions but please use the latest available one as the fixes get
backported.

As Filipe said this has been fixed and the patch is in for-next, not yet
in master or any stable tree. For fuzzing or crafted images it makes
more sense to test on recent development branches. If you don't track
each subsystem individually you should use linux-next, where the btrfs
for-next branch gets merged and the updates happen every other day.

I'll queue the fixes for some of the upcoming -rc. Thanks.

