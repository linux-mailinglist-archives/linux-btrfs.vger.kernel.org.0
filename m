Return-Path: <linux-btrfs+bounces-8599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67515993AA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A944284A61
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764D18DF8E;
	Mon,  7 Oct 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfKM6VRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXe5CB75";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GfKM6VRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXe5CB75"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8418BC16
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342322; cv=none; b=unEsI12X7m0eelqFJp+BH5eG3AIrXjSL+L4bOAfRD9aXcGtMFzCa6XSO5yND4haYMz2DTHaJ2iwaFIhA/7SN7O8cbHDLoNAvjTUCWzyXWvyA+chcxQ7xRGMRABcEYx0vD3LHjdn56ICeismo4ECFV+v9FqyUqsz8yfH+EO088U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342322; c=relaxed/simple;
	bh=BhztLIey8enPNc7QLweYWDnDVaTNmwJ5Mo/gLvWPQ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVp83ppJbZILR3lYcZ+/l3DMKdQM4sh9V+HDUrvArxji276VAJHeZAbhSz0pWgTJtaG7ymSkm/remN6AJcoo1p52c88Ukm9MXnhjLbcUokc7uA8k77+s9/+3tjdefq+N7cn76vzkmRAdAfVaHkMtor+gK8AebO3UNUSeLdq9fN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfKM6VRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXe5CB75; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GfKM6VRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXe5CB75; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BD2E21B50;
	Mon,  7 Oct 2024 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728342313;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhztLIey8enPNc7QLweYWDnDVaTNmwJ5Mo/gLvWPQ3M=;
	b=GfKM6VRf2VjvwW2Ln75gYra8r3pseLl1kwOsGJ57ieJqJR96yyoQkxssy+J7Y0nSyylGTC
	bGuqKcyhLInTZtXKs+DjTODgfBdoSy+bSqZXGb5rOnXHeAWCbN+p7moWYLTE7rqxovwofR
	J+MEXLtSgKt9wEsziPbr39xn4Zv/G1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728342313;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhztLIey8enPNc7QLweYWDnDVaTNmwJ5Mo/gLvWPQ3M=;
	b=jXe5CB757N7ogx/acNbKe/IImEKmeKMBp1JfMDSkcFPHAgtZ2REOPBxHeDCQq30xGSTQq5
	F4/ang01gy2mwGAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728342313;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhztLIey8enPNc7QLweYWDnDVaTNmwJ5Mo/gLvWPQ3M=;
	b=GfKM6VRf2VjvwW2Ln75gYra8r3pseLl1kwOsGJ57ieJqJR96yyoQkxssy+J7Y0nSyylGTC
	bGuqKcyhLInTZtXKs+DjTODgfBdoSy+bSqZXGb5rOnXHeAWCbN+p7moWYLTE7rqxovwofR
	J+MEXLtSgKt9wEsziPbr39xn4Zv/G1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728342313;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhztLIey8enPNc7QLweYWDnDVaTNmwJ5Mo/gLvWPQ3M=;
	b=jXe5CB757N7ogx/acNbKe/IImEKmeKMBp1JfMDSkcFPHAgtZ2REOPBxHeDCQq30xGSTQq5
	F4/ang01gy2mwGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 265B4132BD;
	Mon,  7 Oct 2024 23:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XJXPCClpBGcTDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Oct 2024 23:05:13 +0000
Date: Tue, 8 Oct 2024 01:05:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: fix clear_dirty and writeback ordering
Message-ID: <20241007230511.GB2833@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Oct 04, 2024 at 01:53:35PM +0900, Naohiro Aota wrote:
> This commit is a replay of commit 6252690f7e1b ("btrfs: fix invalid mapping
> of extent xarray state"). We need to call btrfs_folio_clear_dirty() before
> btrfs_set_range_writeback(), so that xarray DIRTY tag is cleared. With a
> refactoring commit 8189197425e7 ("btrfs: refactor __extent_writepage_io()
> to do sector-by-sector submission"), it screwed up and the order is
> reversed and causing the same hang.

Thanks for noticing it, this kind of things are hard to spot and keep in
mind between the refactoring patches and fixes.

Reviewed-by: David Sterba <dsterba@suse.com>

