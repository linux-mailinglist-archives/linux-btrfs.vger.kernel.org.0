Return-Path: <linux-btrfs+bounces-16558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE95B3DD09
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67A67A8367
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52A2FF15A;
	Mon,  1 Sep 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cr5kX9Mu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VH2mh5ZY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUYk3Hlb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X4Drcld/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F22FE596;
	Mon,  1 Sep 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716668; cv=none; b=nH1/vbBCoQiXukTC6+3LAl6dqnMZqLFpSIcuHOdIN+a3xV1uMQ/Ux6O4jlV6+a2Vf8JVcNBAxlkqz0Rz1ZkDiPUjfYMgW9F9GbP3dMtxiD62uQypaZD35BaZT6XpCH8JboSYX6qzC9ThEiS/fDv8UvKJ1uwNEF4eoNbtI0HgPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716668; c=relaxed/simple;
	bh=ry3aXsNJ+Saubz52UQSHyvp2HMlK3CnrNk/OMqxoz7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZTtzH2kcxVU/PKGS96w1ady34O8rX85Vs6fsHO5cb0FdZUd+DERyfab15e9YWVkTUHCGAzLnB1mISFdLiy9wTDeT0diwYmtmqTCVs12xYPq44/BPnChnrBWgt7pM9RfyCWphlok5AaEnTQaq32yh+4T8HLgpYDpPshynaxhxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cr5kX9Mu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VH2mh5ZY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUYk3Hlb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X4Drcld/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FBBE2120D;
	Mon,  1 Sep 2025 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcMxcalDsD5aaMOvrM77e7lUk4Tnk43fj8ZO7Jx72PM=;
	b=cr5kX9MuZfd8njLj75CgBe0A6kB97hn1VjC9LJNH9vV1O8JO5smi5K9fdm1D9PtcMti3HS
	aVEPzJLHKdHL7EYzcGjMdbRwG5INj/K9Q1C8wigH35tHLWW/Z1nyk1a8EwPVo7P3wdViW2
	JLmjc3EDovfpQ/hlmfuwhvaDks6BcM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcMxcalDsD5aaMOvrM77e7lUk4Tnk43fj8ZO7Jx72PM=;
	b=VH2mh5ZY1wEN2STLC5mBc51nvWFJS1/7qe3f2nBsrLmFpR8wXx0FcRiBnNkG5jRprNnzgP
	bAs215N6F/6DKrCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756716664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcMxcalDsD5aaMOvrM77e7lUk4Tnk43fj8ZO7Jx72PM=;
	b=uUYk3HlbyS8gc8sLHWSptzdlpDOw29CmaEtFAzfBGsST3Eq5M5zt0IdhFxYAwEFYJC9RTc
	0xSzJaZXId+lYDzmen9XtED4LguwIMU99RMpdwDsCbo/H6bpI4vgiwjOhzer7sjw8jk/wL
	uK0tXjZPn74d40UXc0NmWiMKCah30AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756716664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcMxcalDsD5aaMOvrM77e7lUk4Tnk43fj8ZO7Jx72PM=;
	b=X4Drcld/+sJ+rYAL2y/CD8PkqUO37MbHCbnFCCRNgDblbGSylbV5UsNNpXXicwxsNxyxWg
	KtThJ53xaKN8bjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B43C1378C;
	Mon,  1 Sep 2025 08:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMtXEnhetWisYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 08:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0807A099B; Mon,  1 Sep 2025 10:50:59 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:50:59 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: revamp iput()
Message-ID: <ox654jni32s6hlqqdney7trtmlp3c7i6vorebi4gizecou4wb6@o5tq3eax3xsz>
References: <20250827-kraut-anekdote-35789fddbb0b@brauner>
 <20250827162410.4110657-1-mjguzik@gmail.com>
 <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat 30-08-25 17:54:35, Mateusz Guzik wrote:
> I'm writing a long response to this series, in the meantime I noticed
> this bit landed in
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries&id=3cba19f6a00675fbc2af0987dfc90e216e6cfb74
> but with some whitespace issues in comments -- they are indented with
> spaces instead of tabs after the opening line.

Interesting. I didn't see an email about inclusion. Anyway, the change
looks good to me so Christian, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

