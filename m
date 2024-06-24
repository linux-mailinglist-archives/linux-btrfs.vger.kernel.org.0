Return-Path: <linux-btrfs+bounces-5937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E839154E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 19:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9744AB23BE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FB19E80C;
	Mon, 24 Jun 2024 17:00:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901019E829
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248405; cv=none; b=FYkyd8ysT+63k1V8Y+AODV5Iof/c9mueU701bYSBS8UapCTQVpWETu4IcgzxKwCjlbVXnB0rlgd2LTR4NoBG8AM6bRQpFMn0K//GsaSP0sbF49IY2tXuoOntLjIhf8oqMTCOQONRzIGkjRfzK1Cc9r/ekh6kr6IP0RLzRxV/wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248405; c=relaxed/simple;
	bh=8DJXBY4G/7hW7gx2Tcq6HbFdoaAQa0Pn8BmPdheizVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcvgUGi6BXQX8f5DhryIZowUqWxu5gKb5/WmX8cK0w43HNY47xwZnu0SlFc8q8Mv0bEdiJ7UHU8GrcXJQ3pGn7MXTqNPbIO53oPMvSsoohvHxNOND3wMqBteXCvJnGmeI7iJMd3DY4YnU4xxLNwAg5XyrNFonhptgvtzFe+fBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00D3D1F7A4;
	Mon, 24 Jun 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E32D413AA4;
	Mon, 24 Jun 2024 17:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 64sANxGmeWZWOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 17:00:01 +0000
Date: Mon, 24 Jun 2024 19:00:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: print-tree: add generation and type dump for
 EXTENT_DATA_KEY
Message-ID: <20240624170000.GQ25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0ff7d2afbab9518e677a725935c3f4e3224a4229.1719205115.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff7d2afbab9518e677a725935c3f4e3224a4229.1719205115.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 00D3D1F7A4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jun 24, 2024 at 02:28:54PM +0930, Qu Wenruo wrote:
> When debugging the recent ram_bytes mismatch bug, I can hit it with
> enhanced tree-checker for file extent items at write time.
> 
> But the bug is not that easy to trigger (mostly triggered with
> btrfs/06*, which uses 20 threads fsstress), and when I hit it, the only
> info is the kernel leaf dump, but it doesn't include things like the
> file extent type (REGULAR or PREALLOC).
> 
> Add the dump for generation and type (although only numeric output) to
> make debugging a little easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

