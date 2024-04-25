Return-Path: <linux-btrfs+bounces-4544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52CE8B21CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 14:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0674C1C2232A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8A1494C3;
	Thu, 25 Apr 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amOoiJyg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4odgAL/+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9cyZWV1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZEl/GqA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE712CD8B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048948; cv=none; b=cyhO/gvCMPyTtpT4pP2Vo/qKdClITkItaus44WGdV1vpUQvtCAohxwPA0Smv9gD3reqxv4kTiBUME+QR3HXAFKSL25BFua0hG+bExB9bZhyYeIL6mGqPlyUv3HorKXGECAmmwSB5IDHbC7hljqbeAQ9DgXudTHDu1X6A81ZTtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048948; c=relaxed/simple;
	bh=X4pYV3jIcetZDjncq6+7O5Y+yR0BAiebPo5D8PCEW9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5fa4lQgs313oN7nHf/rG/iMAE0MvbVaByuWbpJtkXInPVaLgLA7IV8BEkHa/kEOfWohWAUoF7bbFUYxzleq92/5x/4BwxB/6fwBZd7a/pEtGRCWb01x8WmaHlv20X2TRdjh0/lU3zkW7H3ZW06JdXTffIDP33jRFcotpfCo+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amOoiJyg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4odgAL/+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9cyZWV1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZEl/GqA0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E2C933AD7;
	Thu, 25 Apr 2024 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714048945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxuglnISm3HwOBFN7/Ybg2Xv2RCkN9+saDyY0yhNvNA=;
	b=amOoiJyg3upI5VHuVDtIPixRT7h/MLKWdDNFm1Ei3LXaMJwRGnp96T8ZH2ONPj5WzFQ0wV
	3WzP2SzvNseuDyCse0OIsaeWCTd4tOKAkprG6sL1w+VxLZmUjHUojf3Zz+Mj1tixo7zuX/
	9dV3yaMAiuSeJU1M3AXmed3PGD80X1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714048945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxuglnISm3HwOBFN7/Ybg2Xv2RCkN9+saDyY0yhNvNA=;
	b=4odgAL/+jNoDKL8yKbUUsD96biXJmf6kaU+6CARoo/xJIBKRyo907N4s6aPZF/Y+337TNX
	/2i8/bhv0eXprzCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s9cyZWV1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZEl/GqA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714048944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxuglnISm3HwOBFN7/Ybg2Xv2RCkN9+saDyY0yhNvNA=;
	b=s9cyZWV18eP45nGpR6rTxHzEk/mx+/KmbkbmjKCxQucwkru0yhgP6WplLLDO5bRnZ127g1
	O5k0j+K4rZOraUjH4Y1svOw0JjE+UJlvBA/4gRehNsht0PlJ0pY2ygosPucJutlrXgs4d2
	rJ9KYSX/1RbPHggutkefAhzN1jgajno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714048944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxuglnISm3HwOBFN7/Ybg2Xv2RCkN9+saDyY0yhNvNA=;
	b=ZEl/GqA0C1H7qfPHdPdnwxjEQFsqbJqt6JZFdr7+5Qq0uoEM7+NTX6M1Uokki9B/sxk+74
	YbXLyhH+jIGJkuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 296F413991;
	Thu, 25 Apr 2024 12:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6d8gCbBPKmY2ZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Apr 2024 12:42:24 +0000
Date: Thu, 25 Apr 2024 14:34:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	boris@bur.io
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240425123450.GP3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E2C933AD7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Apr 25, 2024 at 07:49:12AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/24 22:11, David Sterba 写道:
> > On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
> >> Currently if we fully removed a subvolume (not only unlinked, but fully
> >> dropped its root item), its qgroup would not be removed.
> >>
> >> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.
> >
> > There's also an option 'btrfs subvolume delete --delete-qgroup' that
> > does that and is going to be default in 6.9. With this kernel change it
> > would break the behaviour of the --no-delete-qgroup, which is there for
> > the case something depends on that.  For now I'd rather postpone
> > changing the kernel behaviour.
> >
> 
> A quick glance of the --delete-qgroup shows it won't work as expected at
> all.
> 
> Firstly, the qgroup delete requires the qgroup numbers to be 0.
> Meanwhile qgroup numbers can only be 0 after 1) the full subvolume has
> been dropped 2) a transaction is committed to reflect the qgroup numbers.

The deletion option calls ioctl, so this means that 'btrfs qgroup remove'
will not delete it either?

> Both situation is only handled in my patchset, thus this means for a lot
> of cases it won't work at all.
> 
> Furthermore, there is the drop_subtree_threshold thing, which can mark
> qgroup inconsistent and skip accounting, making the target subvolume's
> qgroup numbers never fall back to 0 (until next rescan).
> 
> So I'm afraid the --delete-qgroup won't work until the 1/2 patch get
> merged (allowing deleting qgroups as long as the target subvolume is gone).

Ok, so for emulation of the complete removal in userspace it's

btrfs subvolume delete 123
btrfs subvolume sync 123
btrfs qgroup remove 0/123

but this needs to wait until the sync is finished and that is not
expected for the subvolume delete command. It needs to be fixed but now
I'm not sure this can be default in 6.9 as planned.

