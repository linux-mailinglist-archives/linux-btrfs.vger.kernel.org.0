Return-Path: <linux-btrfs+bounces-20777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DD+IkTIb2mgMQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20777-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 19:24:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9C49651
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 907627E73B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF4322A24;
	Tue, 20 Jan 2026 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="luhoqj2Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cw4FZwjD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="luhoqj2Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cw4FZwjD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FD31ED90
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926679; cv=none; b=FpfEfATOe93wAdseWJbKKvPAKk+TlB1i/0B0AVN/q+SUHrF9BQocEEmXmEpfJxnW74ARkHor+qfqwNAV/9q/aE41ktCPGAQOqPLM4EFzJWE0EtTNkkasCKATMc0R7MwZMZigjacHeqvbF2NKlPeCSjlqfWYYCwS62RSJRNcpLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926679; c=relaxed/simple;
	bh=9HamItLjRXBuKVqKPyvyYYOg62R7bjP5C7a9SnzhnBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gym83pc5bE2cVGl9nijnJQRv3/ZZz3nQ7DuHdhT7e8xAH103s0emXf5HEn/HaH6IZ3MJvlKIyJ+/mi2e4Y3pyAAvCn60fGnLio6vrJgE6DsOsk1eK6M6mFaLj1Wrlr32lkjzKVHAxarz0iIZt0JDQ6+peCDY8XzVdg2qnvHxDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=luhoqj2Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cw4FZwjD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=luhoqj2Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cw4FZwjD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 502CC5BCF7;
	Tue, 20 Jan 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768926675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqJpAFl5dp2sTiJYKyBtEXFrRBQxQXB9W+ziHR+qbZQ=;
	b=luhoqj2QnfDzNYt3j5voVINNVNDQkQKkhyUXGib763g/Lz9LY9k22mQh1Ny0WgZ11yf435
	CZoKzGw6dIRTh+fDtZ/5nBxE3b83LebafhgxmapEVyDJbcg0TDsXIlSFvnL5B+kjXl1xrK
	HITxn/1B1lGtmIeBwKLrrgFpeD4NMd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768926675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqJpAFl5dp2sTiJYKyBtEXFrRBQxQXB9W+ziHR+qbZQ=;
	b=cw4FZwjDf1PGL1+17ucu7VoXXICxhw07zYaHZPnSL4byz/RFDA4BDpDyJM4jqaTDCJNu6e
	Z4xlrsu+REpFG2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768926675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqJpAFl5dp2sTiJYKyBtEXFrRBQxQXB9W+ziHR+qbZQ=;
	b=luhoqj2QnfDzNYt3j5voVINNVNDQkQKkhyUXGib763g/Lz9LY9k22mQh1Ny0WgZ11yf435
	CZoKzGw6dIRTh+fDtZ/5nBxE3b83LebafhgxmapEVyDJbcg0TDsXIlSFvnL5B+kjXl1xrK
	HITxn/1B1lGtmIeBwKLrrgFpeD4NMd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768926675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqJpAFl5dp2sTiJYKyBtEXFrRBQxQXB9W+ziHR+qbZQ=;
	b=cw4FZwjDf1PGL1+17ucu7VoXXICxhw07zYaHZPnSL4byz/RFDA4BDpDyJM4jqaTDCJNu6e
	Z4xlrsu+REpFG2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4317F3EA63;
	Tue, 20 Jan 2026 16:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Ns0ENOtb2lsWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 20 Jan 2026 16:31:15 +0000
Date: Tue, 20 Jan 2026 17:31:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid spurious -Wmaybe-uninitialized warnings in
 do_remap_reloc_trans()
Message-ID: <20260120163110.GE26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260120125000.26588-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120125000.26588-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20777-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:replyto,suse.cz:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: 18F9C49651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:49:58PM +0000, Mark Harmstone wrote:
> find_next_identity_remap() sets the values of the start and length
> pointers if it returns 0. Some versions of GCC are unable to analyse
> this properly and give spurious -Wmaybe-uninitialized warnings, so
> initialize the values in do_remap_reloc_trans() to avoid this.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Folded to for-next patch, please also mention to which patch it's
supposed to go to so I don't have to guess.

