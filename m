Return-Path: <linux-btrfs+bounces-22205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQsAQunp2kHjAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22205-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:29:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD21FA55F
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6803E3053657
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D0365A15;
	Wed,  4 Mar 2026 03:29:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDE3537D6
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594947; cv=none; b=LhhzV5NZa/L22agUfVYjPEmLRRJivF3doYnZpD6XHiyje/uIj/8D1+4eclfNnSBnpNpY7oRW+/0WNr450aflk/Z3O6XRDVUwf2p3BwjFxZNYUHrYySGO+OLPBPCN66djZT8PEWswNec0pRgVjRaWae7ewSZyDjbPRH5zEzU7130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594947; c=relaxed/simple;
	bh=3CUiyg73Cn+4dMoXbPs8yN/8scGEszVe153gSUaG1iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhxPlDgp5ujBbTOEHI1vZKE4ALSE7LrCHyMQsUMR15zapMxPDl9eYya9qTE9RVuaZChiI1aLcRSgeaPwN9zQQqFF7vHKrCWNP6O00sJt5GZlQ6EBhpVqf8utr11axwZqyfxXnxCUSYaz0R6KQzJYHUWF6DQEyTB11aix4gKWQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 313FD5BE2A;
	Wed,  4 Mar 2026 03:29:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1813F3EA69;
	Wed,  4 Mar 2026 03:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jai+BQGnp2kgXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Mar 2026 03:29:05 +0000
Date: Wed, 4 Mar 2026 04:29:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: trivial cleanups in end_bbio_data_write()
Message-ID: <20260304032903.GF8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1772525669.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772525669.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 4BBD21FA55F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22205-lists,linux-btrfs=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:replyto]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:45:08PM +1030, Qu Wenruo wrote:
> Please check the changelog of each patch. All of them are pretty
> trivial.
> 
> Qu Wenruo (2):
>   btrfs: remove the alignment check in end_bbio_data_write()
>   btrfs: move the mapping_set_error() out of the loop in
>     end_bbio_data_write()

Reviewed-by: David Sterba <dsterba@suse.com>

Please update 1st patch changelog with the historical notes about the
checks.

