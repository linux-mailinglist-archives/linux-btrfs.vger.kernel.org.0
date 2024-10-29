Return-Path: <linux-btrfs+bounces-9216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284C9B5813
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760961C23626
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379920CCC4;
	Tue, 29 Oct 2024 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LeIFIY+Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H8IokqUh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jy6la8HU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VB4smbFI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCE207A12
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246050; cv=none; b=AGG+hUmVj4q+iBxniClipE5ngNBqutOq2rlEpSl+QSAazkm0FIb1tqNqz+66t2nEWSzgAPuINxe8PjoEpJElF6lelj0TRsN2OxSTTYpzfgdPhQzNIDWCgoXoQXhVHkdrAH7J3Wkd+pu7dbR6xb+ML9cLNAHkdoNMB1UFe4jFskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246050; c=relaxed/simple;
	bh=FIZkQRdkqILG6ojOQ2wHuTcsTSTx5kLHmzubhabed/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/CoK+A3+bR9MqCH+vZRZnpsXQ7IAfnjmIbMo80gA+m8Vm+7/MyX42uxzt4qYctDo9byZeRTTHz04omQJbFUVFsrYjqsW+KE5oiwXMIPd4pnmQn7W9wogljSF0FzlD1NdzGKU8feq5dMSSqz7K4dvEE4bEncCInePW2N2Ykz6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LeIFIY+Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H8IokqUh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jy6la8HU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VB4smbFI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 181D91FB92;
	Tue, 29 Oct 2024 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730246045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KF6TBGNqyDekzbyAATUyPXY1TllJzMbebZxcJQ1c58=;
	b=LeIFIY+ZJYYAhgl1tXc31adWS9Bmgym9ePGwyZEQaMlllhMIoQ924SZqrCUx6cq2R+1ohp
	DX4Eli1ts2BF2Zq+7gyH+3o39bUxuyTRBUT9L5ZssdzquNQbMEE8jFxy4xFRjbNJARm19e
	WvbJtbvpTZ/BjBqvnuZGRsd1K4Ng94Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730246045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KF6TBGNqyDekzbyAATUyPXY1TllJzMbebZxcJQ1c58=;
	b=H8IokqUh4tTNXkCrleEJMNluOowHVzee68bKZrLqqvdfrvYYMD+0nrLilLHDwJ8/j9TJII
	0AG3t2DnjIyQ4jCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jy6la8HU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VB4smbFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730246043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KF6TBGNqyDekzbyAATUyPXY1TllJzMbebZxcJQ1c58=;
	b=Jy6la8HUVtB8YJq07uEzJqFNfWoPLH27rO3Mp+CVvdu0B6SiT+C4wnlw9C0ht2dtZLjGbl
	NGTBZG2je+NFc8Au/QnqXRJlptK8vFue2zQ5SGFzJlDcViFLvp27qK/OsTg0sDw6ifS687
	jVpnooznnRYOt9jTTq9R3B6Z+X6nBVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730246043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KF6TBGNqyDekzbyAATUyPXY1TllJzMbebZxcJQ1c58=;
	b=VB4smbFIb2JCwrpbgBzUes2O1X9cVBgUY7TgqQfEXYijhBIdzJEPbwtvdiSlFEbuu5+cOB
	f6k/admd8XUfivAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEB0A13503;
	Tue, 29 Oct 2024 23:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsbGOZp1IWfXFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Oct 2024 23:54:02 +0000
Date: Wed, 30 Oct 2024 00:53:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/2] btrfs: iget_path cleanup
Message-ID: <20241029235346.GU31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724970046.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724970046.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 181D91FB92
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Aug 30, 2024 at 01:24:53PM -0700, Leo Martins wrote:
> Updates from v3:
> Previously I allocated a path in btrfs_iget and called btrfs_iget_path
> with it. However, Josef pointed out that there is a case in
> btrfs_iget_path where the inode was found in cache and no path
> allocation was necessary. In this patch series I no longer call
> btrfs_iget_path from btrfs_iget, instead I duplicated the code from
> btrfs_iget_path with a path allocation.
> 
> This patch series is a cleanup of btrfs_iget_path and btrfs_iget. It
> moves some cleanup and error handling from btrfs_iget_path into
> read_locked_inode. In addition it also removes a conditional path
> allocation that occurs in read_locked_inode, instead reworking
> btrfs_iget to allocate and free the path.
> 
> Leo Martins (2):
>   btrfs: push btrfs_iget_path cleanup into btrfs_read_locked_inode
>   btrfs:

I had the two patches in my misc-next, I was not sure about something
that I forgot meanwhile. Removing the conditional parameter is a useful
cleanup.  After a fresh look I moved the patches to for-next with some
minor tweaks. Thanks.

