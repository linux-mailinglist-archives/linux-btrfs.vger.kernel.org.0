Return-Path: <linux-btrfs+bounces-1313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651618277C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC11B2318B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856DB5730A;
	Mon,  8 Jan 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="guxBsYRK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s33c6lwu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="guxBsYRK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s33c6lwu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6957302
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A96B321A44;
	Mon,  8 Jan 2024 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704738893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5LUupcU+O6cESYP5wG49FtyS0i3jMeJYd6c4ZK5/Xs=;
	b=guxBsYRKo7UbrE5sODpo5qTxiPymc4KvGsqqdbuc2cuURFd6phmWff9HCCa4VhqGOIATTm
	mwh2ZCDjmhUjxP1DGdrQqNj28ZSv/6jMuUXq1776cFqbVuTtPVoLTecDd2ZBQS6Hzw0zY5
	cy2/knpXJdo1srw5/8TbrL1f0KSYwzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704738893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5LUupcU+O6cESYP5wG49FtyS0i3jMeJYd6c4ZK5/Xs=;
	b=s33c6lwu30Cg91X9ZBRRGZQVo6t7xlSzH0eve/qjD9D0J1SKnIijiz4YkbvofxjcoNFLjA
	kV3ok3+FY5ACh5CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704738893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5LUupcU+O6cESYP5wG49FtyS0i3jMeJYd6c4ZK5/Xs=;
	b=guxBsYRKo7UbrE5sODpo5qTxiPymc4KvGsqqdbuc2cuURFd6phmWff9HCCa4VhqGOIATTm
	mwh2ZCDjmhUjxP1DGdrQqNj28ZSv/6jMuUXq1776cFqbVuTtPVoLTecDd2ZBQS6Hzw0zY5
	cy2/knpXJdo1srw5/8TbrL1f0KSYwzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704738893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5LUupcU+O6cESYP5wG49FtyS0i3jMeJYd6c4ZK5/Xs=;
	b=s33c6lwu30Cg91X9ZBRRGZQVo6t7xlSzH0eve/qjD9D0J1SKnIijiz4YkbvofxjcoNFLjA
	kV3ok3+FY5ACh5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DCE91392C;
	Mon,  8 Jan 2024 18:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d9GWIU1AnGXjawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 18:34:53 +0000
Date: Mon, 8 Jan 2024 19:34:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: cache folio size and shift in extent_buffer
Message-ID: <20240108183439.GG28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b4e58a4cbe2b457e5d0a7f844cdbe035103179c2.1704432940.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e58a4cbe2b457e5d0a7f844cdbe035103179c2.1704432940.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.15%]
X-Spam-Flag: NO

On Fri, Jan 05, 2024 at 04:05:55PM +1030, Qu Wenruo wrote:
> After the conversion to folio interfaces (but without the patch to
> enable larger folio allocation), there is a LTP report about observable
> performance drop on metadata heavy operations.

Please add link of the report.

> This drop is caused by the extra code of calculating the
> folio_size()/folio_shift(), instead of the old hard coded
> PAGE_SIZE/PAGE_SHIFT.
> 
> To slightly reduce the overhead, just cache both folio_size and
> folio_shift in extent_buffer.
> 
> The two new members (u32 folio_size and u8 folio_shift) is stored inside
> the holes of extent_buffer. (folio_size is shared with len, which is
> reduced to u32).

The size of eb hasn't changed, currently it's 240 for me, so that's
good. The object code has shrunk by 1970 bytes from 5880.  The assembly
of accessors looks a bit better, but I don't see much options to
optimize that significantly.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

