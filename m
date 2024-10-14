Return-Path: <linux-btrfs+bounces-8895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4699CC8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73ABFB232B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6541A76AC;
	Mon, 14 Oct 2024 14:16:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6BE571
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915396; cv=none; b=R/N9YAAswdTeVBrdmY5kGZ6WMGYK+nfTzQqIQUe+UvPNjdZv/v6AeEhOe5v61h24CQjHPlpTptAkGJnUPMkFraTnMUXHHd531zJY7vqcoXo0NEWIXZxj8vVRkK2jkibyvl1LeCWmtQoVtcmCIrzg7o0QCJ/eWmtncL2P7TlmWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915396; c=relaxed/simple;
	bh=njjn/jMNtdY3fykk365cNORYosJpmvlMlFit+ux6sDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au7vgsBRcxThR0yMmaiObJGMI80ZqdQdnf0YYfDzvcFCc8SF9g3+tgQlAr9HScWc/h0t7hQCqEBAsBmC358m4bG8ZkuzO3GhfuGCCJzQ/D5rhqdio/Fn3Y1gYvkIryLzO7Sxz8UquIK35F6iMn4udvM9U6Dwkr002EkUdrNJxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAC0B21D30;
	Mon, 14 Oct 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA2F13A51;
	Mon, 14 Oct 2024 14:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SliaNb8nDWfOZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Oct 2024 14:16:31 +0000
Date: Mon, 14 Oct 2024 16:16:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use FGP_STABLE to wait for folio writeback
Message-ID: <20241014141622.GB1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b564309ec83dc89ffd90676e593f9d7ce24ae77.1728880585.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: EAC0B21D30
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Mon, Oct 14, 2024 at 03:06:31PM +1030, Qu Wenruo wrote:
> __filemap_get_folio() provides the flag FGP_STABLE to wait for
> writeback.
> 
> There are two call sites doing __filemap_get_folio() then
> folio_wait_writeback():
> 
> - btrfs_truncate_block()
> - defrag_prepare_one_folio()
> 
> We can directly utilize that flag instead of manually calling
> folio_wait_writeback().

We can do that but I'm missing a justification for that. The explicit
writeback calls are done at a different points than what FGP_STABLE
does. So what's the difference?

