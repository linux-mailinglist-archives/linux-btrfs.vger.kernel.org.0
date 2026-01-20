Return-Path: <linux-btrfs+bounces-20780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDjTMPq/b2kOMQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20780-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 18:48:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA1B48D61
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57ECE86903D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10626410D3E;
	Tue, 20 Jan 2026 17:29:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF540757B
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930187; cv=none; b=fSed4VJ2rAjRDbXx6v23cVCHA1d3RgcDdE6OmiJ2AvgXs+iNOs9Ai/kFd43H9ZyPPSwWb/mmKxhawcjuaF1J4XNdSh2POLZHqPJZvbwAViZ+BT6+J/1zAakvA/bJx7xvlrw7yYsAhn7l7akODWN/t3CrF1C44aDP5JzFZ+LhnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930187; c=relaxed/simple;
	bh=+nl2e4PoWLPkVm94j0hmq5w0/ipdEp8JUizHKmURTCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUt/TIcESq90f6vSOo2+j1FF+EQwsePB/6ZffiiSmA+NgGS+ACXzN60K9x0h0CjOToufSsHi7UG1p8hz0rK18JHASvgoBwBG9dZC4AwWWUXB2Es5dXWBM1S2MComEqtfFz13uWsjPAkoXgV1q0gYHOAy0OLpRzRc89JKRoOmfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E8445BCC3;
	Tue, 20 Jan 2026 17:29:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2203E3EA63;
	Tue, 20 Jan 2026 17:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/YTCIi7b2mtFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 20 Jan 2026 17:29:44 +0000
Date: Tue, 20 Jan 2026 18:29:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: get rid of
 compressed_bio::compressed_folios[] part 1
Message-ID: <20260120172942.GH26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768866942.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768866942.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20780-lists,linux-btrfs=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7AA1B48D61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:30:07AM +1030, Qu Wenruo wrote:
> Currently we have compressed_bio::compressed_folios[] allowing us to do
> random access to any compressed folio, then we queue all folios in that
> array into a real btrfs_bio, and submit that btrfs_bio for read/write.
> 
> However there is not really any need to do random access of that array.
> 
> All compression/decompression is doing sequential folio access.
> 
> The part 1 is some easy and safe conversion on decompression path.
> 
> The part 2 will handle the compression part, but unfortunately that will
> require some changes all compression path, thus will need some extra
> work.
> 
> And only after compression paths also got converted, we still need
> that compressed_folios[] array for now.
> 
> Qu Wenruo (3):
>   btrfs: use folio_iter to handle lzo_decompress_bio()
>   btrfs: use folio_iter to handle zlib_decompress_bio()
>   btrfs: use folio_iter to handle zstd_decompress_bio()

The change makes sense, however there are some low level effects that
are not desirable in the compression callbacks as they're deep in the IO
path. Using the folio iterator on stack adds 40 bytes for lzo (144 -> 184),
and for zstd it's +24 (120 -> 144). This can be fixed by moving the
iterator to the workspace as we're not using the full slab bucket size
for either (lzo workspace is 40, zstd is 160).

The code increases by ~2800 due to specialized cold versions of the
decompression callbacks but other than increasing the size it's
acceptable.

