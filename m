Return-Path: <linux-btrfs+bounces-12337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7CFA654AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FA31888B30
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D243364;
	Mon, 17 Mar 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JmuqaViv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PM56dExh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aqRDdkmy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZEhfeQZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5B2376E1
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223598; cv=none; b=PGs63SwIGqpM1n/19bvGvHugIi20jpTZqM7RbBQcRi/r/LEsmQRVkU2BMUunJy8PqtCsKTyd5NbrqRcD3a1p5YBQF7WOfsbE6b2XWLEljy0QfYKFOQfM3TBpJFks3CUk+ZkmTP+JyWDSrsoZcokebYgh9qbyD0Adi6oS1Lk+ZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223598; c=relaxed/simple;
	bh=jU7Y92q+Blwf65mVZ9UiBAdBAwo1kENE/pncmb3iFe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQtGoBrDWx0OMjn+852pnb+g9lrdsmGOg7jE06ZahW5VZ6rHS3ZEkqyBz5VS+09lbBWrDZX55DESCaPOTULY4zuX2/cfBjc0IPM+zNR2pxE4bUuDxlxCUoV8CrUr2yxKnbsLUVt3XFw7tMmsO9Z0O04Ur+9xKuU+QN8MTnj2zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JmuqaViv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PM56dExh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aqRDdkmy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZEhfeQZ1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD3D921241;
	Mon, 17 Mar 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742223595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw8kkgkRySJDTDZkyOLqbBAOwHEzsoqj760B6TFJjXw=;
	b=JmuqaVivM6GFNPPjHdF8oJivwN+R+wp1uoS24kZWI96yTU2DIse/TauzSABpUx8+zfsOYe
	Ua32fk9TiZEZGsO1O9vOaC9Gn3Zzw7f/zJrhvuHgX3TGUrCoJKENVNJDjZCPyLjguCgd5V
	LOyUijx2yi570Rz/k6nDRDZrjh+3yfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742223595;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw8kkgkRySJDTDZkyOLqbBAOwHEzsoqj760B6TFJjXw=;
	b=PM56dExhDQCr6r3eiww2jkFU8ub/U5CLyr56eKaueK2nTf6Vn8uBZlc0OBHNDeqN9BgN7o
	7248dArK0ZWypKDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aqRDdkmy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZEhfeQZ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742223594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw8kkgkRySJDTDZkyOLqbBAOwHEzsoqj760B6TFJjXw=;
	b=aqRDdkmy+4biNPmuAIMwj/x3w2NaXEJDyxeU/zbyVKyFrPEmh6V4biXj849khqkm16aOp3
	PikFtboayN0ufmo77sZxx7x/iZZeiNm6f00kz+drvUKBN74GMVHscEqt1v6x4g3FnUiigY
	nPIYnhBtwdWa647hejittoGH27llvms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742223594;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw8kkgkRySJDTDZkyOLqbBAOwHEzsoqj760B6TFJjXw=;
	b=ZEhfeQZ14hVS0RFYtPtWXqsCmGblsEclr74AwobKTPaJ8X1EOquIekrmimoLt961tFj7Q9
	oLrG9tdp4DliVzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B46E6139D2;
	Mon, 17 Mar 2025 14:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e17NK+o42Ge3eQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 14:59:54 +0000
Date: Mon, 17 Mar 2025 15:59:53 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: some cleanups and minor optimization for log
 trees
Message-ID: <20250317145953.GY32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CD3D921241
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Mar 13, 2025 at 05:55:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A series of cleanups, simplifications and a minor optimization related to
> log replay and inode logging. Details in the change logs.
> 
> Filipe Manana (7):
>   btrfs: avoid unnecessary memory allocation and copy at overwrite_item()
>   btrfs: use variables to store extent buffer and slot at overwrite_item()
>   btrfs: update outdated comment for overwrite_item()
>   btrfs: use memcmp_extent_buffer() at replay_one_extent()
>   btrfs: remove redundant else statement from btrfs_log_inode_parent()
>   btrfs: simplify condition for logging new dentries at btrfs_log_inode_parent()
>   btrfs: remove end_no_trans label from btrfs_log_inode_parent()

Reviewed-by: David Sterba <dsterba@suse.com>



