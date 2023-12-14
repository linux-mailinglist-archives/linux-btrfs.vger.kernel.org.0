Return-Path: <linux-btrfs+bounces-957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64181360A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640B61F21DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900C5F1EE;
	Thu, 14 Dec 2023 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="frEzd1YL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNRnZzID";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="frEzd1YL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNRnZzID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6CE8
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Dec 2023 08:18:00 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4A7D21C78;
	Thu, 14 Dec 2023 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702570678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oYDGU+DjAXL19mWHeqkjqYO32IPBsjpBPSQEXTuQwI=;
	b=frEzd1YLVzxfELTiFtjeCYBsh2uWYZevY83G5/hmifiq6u0aGOdD64G8Psn1uK49nKZdlD
	sZuZPOg+EqUK/dt5LqWecQgMRA5/rkoTYitA2QLfEyIFVMYuXI42nn0gW1wRcuZk4uCg27
	88DsjUFFC6Ap4ihbuWphbg9oT+tWLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702570678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oYDGU+DjAXL19mWHeqkjqYO32IPBsjpBPSQEXTuQwI=;
	b=pNRnZzIDrjWlIbdNmXG+WLgOHxxTHisS6AKl4bA7uJ229vk2kZlmChSCMwfE9IhVi1bcgV
	BCAAK7trRYVo0/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702570678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oYDGU+DjAXL19mWHeqkjqYO32IPBsjpBPSQEXTuQwI=;
	b=frEzd1YLVzxfELTiFtjeCYBsh2uWYZevY83G5/hmifiq6u0aGOdD64G8Psn1uK49nKZdlD
	sZuZPOg+EqUK/dt5LqWecQgMRA5/rkoTYitA2QLfEyIFVMYuXI42nn0gW1wRcuZk4uCg27
	88DsjUFFC6Ap4ihbuWphbg9oT+tWLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702570678;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3oYDGU+DjAXL19mWHeqkjqYO32IPBsjpBPSQEXTuQwI=;
	b=pNRnZzIDrjWlIbdNmXG+WLgOHxxTHisS6AKl4bA7uJ229vk2kZlmChSCMwfE9IhVi1bcgV
	BCAAK7trRYVo0/Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86488138F2;
	Thu, 14 Dec 2023 16:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TPyDH7Yqe2U7OgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 14 Dec 2023 16:17:58 +0000
Date: Thu, 14 Dec 2023 17:17:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-btrfs@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Message-ID: <20231214161749.GA9795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1702148009.git.kreijack@inwind.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702148009.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=frEzd1YL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pNRnZzID;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.60 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[inwind.it,libero.it];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(1.20)[suse.cz];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.970];
	 FREEMAIL_TO(0.00)[libero.it];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,inwind.it];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.60
X-Rspamd-Queue-Id: B4A7D21C78

On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
> directory returning the 'fd' and a 'dirstream' variable returned by
> opendir(3).
> 
> If the path is a file, the 'fd' is computed from open(2) and
> dirstream is set to NULL.
> If the path is a directory, first the directory is opened by opendir(3), then
> the 'fd' is computed using dirfd(3).
> However the 'dirstream' returned by opendir(3) is left open until 'fd'
> is not needed anymore.
> 
> In near every case the 'dirstream' variable is not used. Only 'fd' is
> used.

As I'm reading dirfd manual page, dirfd returns the internal file
descriptor of the dirstream and it gets closed after call to closedir().
This means if we pass a directory and want a file descriptor then its
lifetime matches the correspoinding DIR.

> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
> 
> Aim of this patch set is to getrid of this complexity; when the path of
> a directory is passed, the fd is get directly using open(path, O_RDONLY):
> so we don't need to use readdir(3) and to maintain the not used variable
> 'dirstream'.

Does this work the same way as with the dirstream?

