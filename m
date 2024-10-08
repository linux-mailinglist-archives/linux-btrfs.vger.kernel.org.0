Return-Path: <linux-btrfs+bounces-8651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A8995553
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789551F21D82
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446581E0DDB;
	Tue,  8 Oct 2024 17:09:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594917BD9
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407360; cv=none; b=RguY0WL03WW2ULmAHN094mmNqyksuUV6xXPq8dEM6GHWFVSfuKDFENG74TNrH4IjgeYueBP9OFOXWyd5O6HvGpeKHWqxxgQnSes2IZPtpY4weYMvDCuwJwawzb21tZPFKdU7ggv0lVJ1Juads0ImJHAE/xZ3pJbTDD0XLRrNV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407360; c=relaxed/simple;
	bh=Id/xZvuT+4zFVfOP8YKS2CyXFSXfurcM+5IS9vLwUO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlDUxmBELe/jGJycJlBNqTXNxyKlo4Ep4Y3yZx3Um//Plgck8XuvHClS2jqyx9hXg1bu3PmC5R6G0c9gc5gOP/xyzF5FCsn+6l7kzwtu7om2QAnT7mRlUqq222NtwTJXjndXrIlwfbhp+zjZC2SU/omDJRzHJgjop+y4KmtPQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D7DF1F365;
	Tue,  8 Oct 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C27F137CF;
	Tue,  8 Oct 2024 17:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1K7IT1nBWdPVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 17:09:17 +0000
Date: Tue, 8 Oct 2024 19:09:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: rename
 btrfs_folio_(set|start|end)_writer_lock()
Message-ID: <20241008170916.GF1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728338061.git.wqu@suse.com>
 <d5f42da1109269ad9a4a88000e78eb3a66248591.1728338061.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f42da1109269ad9a4a88000e78eb3a66248591.1728338061.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9D7DF1F365
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, Oct 08, 2024 at 08:28:45AM +1030, Qu Wenruo wrote:
> Since there is no user of reader locks, rename the writer locks into a
> more generic name, by removing the "_writer" part from the name.
> 
> And also rename btrfs_subpage::writer into btrfs_subpage::locked.

'locked' looks confusing in connection with atomics. It sounds like a
predicate but is in fact a counter, so I'd suggest to rename it to
nr_locked or nr_locks or something like that.

