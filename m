Return-Path: <linux-btrfs+bounces-2784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C25867108
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F502880B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18B5FB9B;
	Mon, 26 Feb 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxzPjUd9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BM2EhI43";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cxzPjUd9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BM2EhI43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC25F878;
	Mon, 26 Feb 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942489; cv=none; b=CtL0zqmXY03NEmeIe3TJTT0+ELgRe3LbOz8xOI6Jw73/Hr3zKn4sWpjZ61n1gYRDjS/vUT6XA8Lmcqc/lr92qQK0gRzWXaBNcZlSPOjSPyCWY8ihV1/OiKarZnRMY0rkK38W2aXCkrcMkRWJkzIsen8HCIQrzD+xPtIFXGFMIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942489; c=relaxed/simple;
	bh=2csYaxAEgr8WsjWk8jHvZl0989l2gOCNAgvbNuA/seI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0GcuHWuPaUoz4DE2/zNJaPbFMF/PNDuXw9/vuNcguHBUIUMGZzZY3xJt8OgTmPrttuMAwn0b8o6guXIzY1A3cZfWH2w0YPcUoDrUrBrjILMvu1YTsi3LrOq7PKGdh/uKRbOPvMuogO8EVP6eTmE30itGSHHjz7Q3GkqyMMQMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cxzPjUd9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BM2EhI43; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cxzPjUd9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BM2EhI43; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8267022242;
	Mon, 26 Feb 2024 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708942485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXkskOxKBDBBcD+9U+A7ICbHkZoP0qwb9bYnBtamk=;
	b=cxzPjUd9l+MJLfA0Cj/otOtsNIo9yUwvjHPT4h5ypipwYP/+V79bWtfFVkXB/MZdKk6T6K
	pSLMCA2HwL4R93qMWnOerHSQxz4U91i4Ar9Is0hgv/e+DjAVUSOAZl2W1Hz33qircodkeS
	hRmRK5N36Pn0LIHV0HIg0AjgXvilzF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708942485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXkskOxKBDBBcD+9U+A7ICbHkZoP0qwb9bYnBtamk=;
	b=BM2EhI43qb8BcYbTQOzvFcQ3ZlQHXoZd1VBtd6cWcmQYLtwmzvwWH3tF/8/FmQ8ugkt7+/
	/TfMUPeJjbXSpUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708942485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXkskOxKBDBBcD+9U+A7ICbHkZoP0qwb9bYnBtamk=;
	b=cxzPjUd9l+MJLfA0Cj/otOtsNIo9yUwvjHPT4h5ypipwYP/+V79bWtfFVkXB/MZdKk6T6K
	pSLMCA2HwL4R93qMWnOerHSQxz4U91i4Ar9Is0hgv/e+DjAVUSOAZl2W1Hz33qircodkeS
	hRmRK5N36Pn0LIHV0HIg0AjgXvilzF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708942485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3tXkskOxKBDBBcD+9U+A7ICbHkZoP0qwb9bYnBtamk=;
	b=BM2EhI43qb8BcYbTQOzvFcQ3ZlQHXoZd1VBtd6cWcmQYLtwmzvwWH3tF/8/FmQ8ugkt7+/
	/TfMUPeJjbXSpUCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6564E1329E;
	Mon, 26 Feb 2024 10:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id r7UbGJVk3GVEHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 10:14:45 +0000
Date: Mon, 26 Feb 2024 11:14:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240226101405.GQ355@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240224214241.840F.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224214241.840F.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cxzPjUd9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BM2EhI43
X-Spamd-Result: default: False [-0.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.28)[74.18%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.29
X-Rspamd-Queue-Id: 8267022242
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sat, Feb 24, 2024 at 09:42:42PM +0800, Wang Yugui wrote:
> Hi,
> 
> > This tests if a clone source can be read but in btrfs there's an
> > exclusive lock and the test always fails. The functionality might be
> > implemented in btrfs in the future but for now disable the test.
> 
> On linux 6.8-rc5+, generic/733 with btrfs filesystem have some chance(>50%) to
> success now.  Is this expected?

The test may succeed because of lucky timing, but otherwise it's not
relevant for btrfs.

