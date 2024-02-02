Return-Path: <linux-btrfs+bounces-2066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082D846FD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D237729B131
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397713F007;
	Fri,  2 Feb 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aOPAkMNf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHvlkYuX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aOPAkMNf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHvlkYuX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479813DB9B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875768; cv=none; b=q9vEgyX9ahQGZLaAKFJBHF7bgMD0cuX5LljCwY72c0rU5VlXHLQjflBefoJ6aUI+Dir49m6mv1FteiVX5ri1H6Wb2XlPrh61plWeVtyTN27Vgpk6z9+JobQc9w19pqzCfX/3LJEwFmel2BPNkeMRt0dw1RV2cQXy9G68n7Sb6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875768; c=relaxed/simple;
	bh=S+0r2XQK12ar2Gh5wGyl0/JDV+ihqTk/gl+ZxOXJt9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH34lfjlbtHXaMLMOc566u7/gNqAAUI3HJzzST//hVA6MYsxH9bKd9+hQVFZl82rYx5YsOb59I+487/7aC1u15td+zBX1pXJauzyW/0O5WF+MBkg4pXgbFNOyfY6/xqYThwBvL01ukSdi9v7yNAFJvYt7jgXRctMGc4WSmzF09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aOPAkMNf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHvlkYuX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aOPAkMNf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHvlkYuX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68BAE1F76E;
	Fri,  2 Feb 2024 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706875764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLKHmCNv7vmW8pF5J0MirJ4jPJ+tn0TLf9736FHcsGI=;
	b=aOPAkMNfywOqlBPPpza1u48Xjfsep9CXt10ZIN4PUO4SYXKeb5XLKs1vS0tUwuLVv78R4+
	I2EJnZX+cyppI116ix4rdT45nSMIFtymXeKBRezWCMWTJJ9fTg5J0IgVuCRLJjmwsLdyb3
	3IOVtDir13IFAYCJeoo0UEjqhiUkbeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706875764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLKHmCNv7vmW8pF5J0MirJ4jPJ+tn0TLf9736FHcsGI=;
	b=kHvlkYuXWOHIlW+IfT64e1SZ0kGpKFHVcAeNbrxOuSWsjxmFc6gzGJAZyl7Tf6LbhTrx0a
	Y9/cjKUSmMgYQjAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706875764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLKHmCNv7vmW8pF5J0MirJ4jPJ+tn0TLf9736FHcsGI=;
	b=aOPAkMNfywOqlBPPpza1u48Xjfsep9CXt10ZIN4PUO4SYXKeb5XLKs1vS0tUwuLVv78R4+
	I2EJnZX+cyppI116ix4rdT45nSMIFtymXeKBRezWCMWTJJ9fTg5J0IgVuCRLJjmwsLdyb3
	3IOVtDir13IFAYCJeoo0UEjqhiUkbeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706875764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLKHmCNv7vmW8pF5J0MirJ4jPJ+tn0TLf9736FHcsGI=;
	b=kHvlkYuXWOHIlW+IfT64e1SZ0kGpKFHVcAeNbrxOuSWsjxmFc6gzGJAZyl7Tf6LbhTrx0a
	Y9/cjKUSmMgYQjAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EACD133DC;
	Fri,  2 Feb 2024 12:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6tnwFnTbvGUCNgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 02 Feb 2024 12:09:24 +0000
Date: Fri, 2 Feb 2024 13:08:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use (READ_/WRITE_)ONCE for fs_devices->read_policy
Message-ID: <20240202120857.GZ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ff28792692e72b0888fff775efad8178889b9756.1706858039.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff28792692e72b0888fff775efad8178889b9756.1706858039.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aOPAkMNf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kHvlkYuX
X-Spamd-Result: default: False [-1.53 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.07%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 68BAE1F76E
X-Spam-Level: 
X-Spam-Score: -1.53
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 04:14:57PM +0900, Naohiro Aota wrote:
> Since we can read/modify the value from the sysfs interface concurrently,
> it would be better to protect it from compiler optimizations.
> 
> Currently, there is only one read policy BTRFS_READ_POLICY_PID available,
> so no actual problem can happen now. This is a preparation for the future
> expansion.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

