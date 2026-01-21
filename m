Return-Path: <linux-btrfs+bounces-20789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOJZJ7tMcGnXXAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20789-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:49:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD765094F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84C54357C63
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AC2836A4;
	Wed, 21 Jan 2026 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJRz/deg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMclVE/Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJRz/deg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMclVE/Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511D328630
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967247; cv=none; b=oLyWrTb1ns3mUJnJCLMRDpnkx6Xy30d5iBQ6FvxFtQRl/0IX5TxjFPH7zsp5goaom3YqWW/HxWFvgvs800iaB22TeIyEYBuBFe1/AhFY2XcWsrSeVY2NUz99SXnDDmLdcgcnfjN9lwH7fSdHdI65dKtP/iQmCRjPxfGVxdbSTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967247; c=relaxed/simple;
	bh=pVxrx8RktgLrZNQYF0hztrOfVUwYuqARz5Jd781pHDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnahpOI22sAiv09vDxSf59ez7ZWc1IsijRhMb7co+yCgyCKhkdSEzMwgWJolSRcs9jAlh/Rnd4h0n7RtAXM7ykr47VHsjkN8otPTc8DQVQ/w5snInRVOp9oj/KpPYQPfQt1Ppl7vUVhjMrsmBLzqDw4I0kGM+NDCkliEupe6cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJRz/deg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMclVE/Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJRz/deg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMclVE/Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D431E5BCCA;
	Wed, 21 Jan 2026 03:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768967238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2S11MoC19OVh0p3A4aMvJuvzyPje3TyP+gB7njM4Ug=;
	b=sJRz/degU2s3eD0pHLawL5cLJYArtslsWvawM2DKi1LcwTlF9AI5tgezLfPSiGAwu87E1x
	NJApMZR4pNrdOZ00BI08x1IdVKQPnCId1obVMFynNpp6SHD5p3xaTKS9eGnH3tRfqsZcto
	3xszbbNIdKbPm3vP+hGQQlxjTf5I/Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768967238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2S11MoC19OVh0p3A4aMvJuvzyPje3TyP+gB7njM4Ug=;
	b=tMclVE/Y0kq7nfPR1Cumw5u5A1BghvwYdFnC0K+kChGkRCfefJQJhgkWkF6QsVGNZBHoy3
	8AGEyVRNotVprFCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sJRz/deg";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tMclVE/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768967238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2S11MoC19OVh0p3A4aMvJuvzyPje3TyP+gB7njM4Ug=;
	b=sJRz/degU2s3eD0pHLawL5cLJYArtslsWvawM2DKi1LcwTlF9AI5tgezLfPSiGAwu87E1x
	NJApMZR4pNrdOZ00BI08x1IdVKQPnCId1obVMFynNpp6SHD5p3xaTKS9eGnH3tRfqsZcto
	3xszbbNIdKbPm3vP+hGQQlxjTf5I/Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768967238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2S11MoC19OVh0p3A4aMvJuvzyPje3TyP+gB7njM4Ug=;
	b=tMclVE/Y0kq7nfPR1Cumw5u5A1BghvwYdFnC0K+kChGkRCfefJQJhgkWkF6QsVGNZBHoy3
	8AGEyVRNotVprFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B994A3EA63;
	Wed, 21 Jan 2026 03:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7ofLUZMcGmRcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 03:47:18 +0000
Date: Wed, 21 Jan 2026 04:47:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: get rid of
 compressed_bio::compressed_folios[] part 1
Message-ID: <20260121034717.GK26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768866942.git.wqu@suse.com>
 <20260120172942.GH26902@twin.jikos.cz>
 <62e58040-033d-42f3-b0b7-be50f2567310@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62e58040-033d-42f3-b0b7-be50f2567310@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20789-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8CD765094F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:11:18AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/21 03:59, David Sterba 写道:
> > On Tue, Jan 20, 2026 at 10:30:07AM +1030, Qu Wenruo wrote:
> >> Currently we have compressed_bio::compressed_folios[] allowing us to do
> >> random access to any compressed folio, then we queue all folios in that
> >> array into a real btrfs_bio, and submit that btrfs_bio for read/write.
> >>
> >> However there is not really any need to do random access of that array.
> >>
> >> All compression/decompression is doing sequential folio access.
> >>
> >> The part 1 is some easy and safe conversion on decompression path.
> >>
> >> The part 2 will handle the compression part, but unfortunately that will
> >> require some changes all compression path, thus will need some extra
> >> work.
> >>
> >> And only after compression paths also got converted, we still need
> >> that compressed_folios[] array for now.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: use folio_iter to handle lzo_decompress_bio()
> >>    btrfs: use folio_iter to handle zlib_decompress_bio()
> >>    btrfs: use folio_iter to handle zstd_decompress_bio()
> > 
> > The change makes sense, however there are some low level effects that
> > are not desirable in the compression callbacks as they're deep in the IO
> > path. Using the folio iterator on stack adds 40 bytes for lzo (144 -> 184),
> > and for zstd it's +24 (120 -> 144). This can be fixed by moving the
> > iterator to the workspace as we're not using the full slab bucket size
> > for either (lzo workspace is 40, zstd is 160).
> 
> Although we're never going to be that deep into the IO path.
> 
> Since commit 4591c3ef751d ("btrfs: make sure all btrfs_bio::end_io are 
> called in task context"), all btrfs_bio::end_io() callback is called 
> inside a workqueue.
> 
> So end_bbio_compressed_read() is now inside a workqueue, pretty shadow 
> stacks, thus the increase of the stacks should still be fine.

Right, it's not necessary after the workqueues, I need to get used to
it.

