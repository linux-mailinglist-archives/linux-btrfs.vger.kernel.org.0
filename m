Return-Path: <linux-btrfs+bounces-7817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958F96C5AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 19:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BB1C23D5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867861E1A0B;
	Wed,  4 Sep 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4tHTXI8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XIDUJcOS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5DtVrRa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QLe+ZCvL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC531DFE1A;
	Wed,  4 Sep 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471999; cv=none; b=fp7pT4y7YWd3sk3ZdQlqsREnofl0X8gTAmqPGT6FuN2PBYoMwaBx7+7pbemODsdPSFdObXRWmP0fOcwVSJtiZT/tnRHcnPNt5dHk4IQkdHtqiNH8cbBJXRgqNP2P4V5t6TeQp9w1NWTz4Je8JO7rsyv+J6S0qMIOnOwCIzy+a9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471999; c=relaxed/simple;
	bh=OLEa0qrKgCpqJxEBIBOa/IRqvVidi/D1LKVs6fG6eug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A36UAPEkmWZVbBQfs8Fid74Sb0nAw3yHVHkCv37EcO+LVm7DTd0bgeUWlQYV4RMNyo2i67Gvf98AfNjx6t2sGgBMoP+lcNeUguoGTL13qWWmFA31nr5WqIRcRm3s4bcQTrM5+bUqrg5Q8KmY8e8bfYBjSf6h5j4SuZMI7lbtZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4tHTXI8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XIDUJcOS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5DtVrRa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QLe+ZCvL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEDEF21A34;
	Wed,  4 Sep 2024 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725471996;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56KFaELrTK1OiibukGva1dPNRnbkcmwTmcJziUt8hiI=;
	b=h4tHTXI8ABm5BtGNd7Nrmiz1zs+Mf6l7LPypYh1xmHhujzBqqXEBhynYyOAb/tNkgh8EaW
	nUDqRoe1qd3fhw+VFyz0BUsjAhj8Wuc9zzyt7tRySR8930Qvsw20/SPHZkxagX1tw2RqTG
	DnRWhR5i89IDE+nfeHm4q32EwuDh4Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725471996;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56KFaELrTK1OiibukGva1dPNRnbkcmwTmcJziUt8hiI=;
	b=XIDUJcOS97XA4FyQ6FcX9zJjKpaWH5c1gZIFuL1SOLy2c/rWEMT5a7J1hf1zCZMN2WSTJf
	+ZzO5mj2vjNQh8Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J5DtVrRa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QLe+ZCvL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725471995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56KFaELrTK1OiibukGva1dPNRnbkcmwTmcJziUt8hiI=;
	b=J5DtVrRaLArcF4ikE9hBT0RLGamqpKWnseTfD2Seoyn+TUWAOL/RrusUafnnVRYokzWkb1
	Sp0DzVVe6Zk9nLFUVDAGz5hbKGO95V0OvMJpYu9rZDwNjryy7Te206AysOv12yBaDbd2rE
	rTQxksroNRgD1nhhukig/cOih34KS+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725471995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56KFaELrTK1OiibukGva1dPNRnbkcmwTmcJziUt8hiI=;
	b=QLe+ZCvLY6sBsbE3JR1t5xF1AZt3jKjkiy4vK2fMFKpBOnMzv/YRMqIwKjWONcOf9pnGZB
	65MGfhKP61VQv2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C83D6139E2;
	Wed,  4 Sep 2024 17:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6aiMPuc2GZwMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Sep 2024 17:46:35 +0000
Date: Wed, 4 Sep 2024 19:46:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: Added null check to extent_root variable
Message-ID: <20240904174630.GP26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240904023721.8534-1-ghanshyam1898@gmail.com>
 <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EEDEF21A34
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org,syzkaller.appspotmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[9c3e0cdfbfe351b0bc0e];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Sep 04, 2024 at 03:21:34PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/9/4 12:07, Ghanshyam Agrawal 写道:
> > Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
> > Closes:https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >   fs/btrfs/ref-verify.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> > index 9522a8b79d22..4e98ddf5e8df 100644
> > --- a/fs/btrfs/ref-verify.c
> > +++ b/fs/btrfs/ref-verify.c
> > @@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
> >   		return -ENOMEM;
> >
> >   	extent_root = btrfs_extent_root(fs_info, 0);
> > +	if (!extent_root)
> > +		return -EIO;
> > +
> 
> Can you reproduce the original bug and are sure it's an NULL extent tree
> causing the problem?
> 
> At least a quick glance into the console output shows there is no
> special handling like rescue=ibadroots to ignore extent root, nor any
> obvious corruption in the extent tree.
> 
> If extent root is really empty, we should error out way earlier.
> 
> Mind to explain the crash with more details?

In the stack trace it looks the ref-verify mount option is enabled, I
don't think we've tested that in combination with the rescue options as
ref-verify is a debugging tool, must be built in config (by default is
not and is not on distro configs).

We should fix the bug where it crashes when run in syzkaller so we can
allow it to continue coverage but otherwise I wouldn't put too much
effort into that. I.e. if we can do a simple fallback and exit gracefully
and not try to continue ref-verify + missint extent (or other trees).

