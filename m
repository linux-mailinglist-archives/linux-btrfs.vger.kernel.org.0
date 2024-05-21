Return-Path: <linux-btrfs+bounces-5156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB96F8CAEC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5451C219D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B974C1B;
	Tue, 21 May 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AoLQQQct";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wi+QDrs9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ItN4dHvc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4Hhnt6r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A721E48B
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296512; cv=none; b=p76niMVgjR2Bw3Y8ae/5a32dMBR1ldFGNPqMV0sNC6HDsO/JWBWItJ1rA6parco4fsTf6l/9cxFZVkBF9RXjpYWGJuoFc2t14amPBs9q+lVUt2E+dCcJfSe0qE6An37M9d8WchTC/VWhrJ4Dga12Tf5jOvj6f+l5+ekNIgmxPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296512; c=relaxed/simple;
	bh=CK1+IVMPJHHHvS4etELfDaTJbkcqsvqu0ZyMCuIbNPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOeeJLMnmNUJ44U5lk1jLtMLdq1riOWv+MdqL9osnGfxpyFYRONCSlEtjIi0sWYvB/F8lObMW0bqnebmeFpI+4JQ6WoOBUgv/xaUXnAA5KRRi/VmlsAMOvb72A1A1wGOjQIqXE3jMYdMQVDH/wI1Sl3sorkxhll3Gi5vqYdDcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AoLQQQct; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wi+QDrs9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ItN4dHvc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4Hhnt6r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8F015C171;
	Tue, 21 May 2024 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716296508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TuUmjBpRU7IZcen/Xmq4TofpwHNKyf671WYWG+IZX0=;
	b=AoLQQQctAs40Q1+1WxOsZOQuy2eXf31axr9vjMmF+tqYhus+PKLULudJokeT3g6ifp7rLA
	GzVT/NeSPpBuTOphEOWrl6jQuNc8sYG7UwjmDJgHB96nDIBDQLKEBEMysj3k2pIOmmbnk5
	n5/n+je7p8mup10g62Fjhv3Z0zy25Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716296508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TuUmjBpRU7IZcen/Xmq4TofpwHNKyf671WYWG+IZX0=;
	b=Wi+QDrs9dD9zEPR4wE6qmwo9r5WuEOaB1OktbcWmjK6XVTxR6CjCmQtjM2aJXhTmVwAygX
	xzQ0o7paPoux17Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ItN4dHvc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k4Hhnt6r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716296507;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TuUmjBpRU7IZcen/Xmq4TofpwHNKyf671WYWG+IZX0=;
	b=ItN4dHvc932spRB+J33HZzXCRjdzJeZoguvtLF87+I+k58kMvbv4G49biMA/YZrOFnW/SM
	9q2uYj3xv/D0aqN/ZF2lTlkoDbrm4mwvMK1z1db/sglNGNOUW/CIOWb5zgtRWe6W7b4xAs
	pwE/xzkzozzvd4uJAK/eAgKYlKVo2gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716296507;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TuUmjBpRU7IZcen/Xmq4TofpwHNKyf671WYWG+IZX0=;
	b=k4Hhnt6rUqsRvzq4B6qxKt7arq1vwlbIaoDOcSJDIFL9An8j7y3zJV6zDta1yqmb1w6JdP
	OmmU6LyYlDUv4JDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C41DF13A1E;
	Tue, 21 May 2024 13:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEKiLzubTGZ1NAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 13:01:47 +0000
Date: Tue, 21 May 2024 15:01:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] btrfs: use for-local variabls that shadow function
 variables
Message-ID: <20240521130146.GK17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716234472.git.dsterba@suse.com>
 <6cebc0c327002303ed351b262396aefbf68cff1b.1716234472.git.dsterba@suse.com>
 <dpysu5cfgcwuqwvfvqzmraunfkt2n5bih3ushtyrx264mz76jp@wfs2eb5whhqq>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dpysu5cfgcwuqwvfvqzmraunfkt2n5bih3ushtyrx264mz76jp@wfs2eb5whhqq>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D8F015C171
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Tue, May 21, 2024 at 04:13:53AM +0000, Naohiro Aota wrote:
> On Mon, May 20, 2024 at 09:52:26PM GMT, David Sterba wrote:
> > We've started to use for-loop local variables and in a few places this
> > shadows a function variable. Convert a few cases reported by 'make W=2'.
> > If applicable also change the style to post-increment, that's the
> > preferred one.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> 
> LGTM asides from a small nit below.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> >  fs/btrfs/qgroup.c  | 11 +++++------
> >  fs/btrfs/volumes.c |  9 +++------
> >  fs/btrfs/zoned.c   |  8 +++-----
> >  3 files changed, 11 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index fc2a7ea26354..a94a5b87b042 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -3216,7 +3216,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  			 struct btrfs_qgroup_inherit *inherit)
> >  {
> >  	int ret = 0;
> > -	int i;
> >  	u64 *i_qgroups;
> >  	bool committing = false;
> >  	struct btrfs_fs_info *fs_info = trans->fs_info;
> > @@ -3273,7 +3272,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  		i_qgroups = (u64 *)(inherit + 1);
> >  		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
> >  		       2 * inherit->num_excl_copies;
> > -		for (i = 0; i < nums; ++i) {
> > +		for (int i = 0; i < nums; i++) {
> >  			srcgroup = find_qgroup_rb(fs_info, *i_qgroups);
> >  
> >  			/*
> > @@ -3300,7 +3299,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  	 */
> >  	if (inherit) {
> >  		i_qgroups = (u64 *)(inherit + 1);
> > -		for (i = 0; i < inherit->num_qgroups; ++i, ++i_qgroups) {
> > +		for (int i = 0; i < inherit->num_qgroups; i++, i_qgroups++) {
> >  			if (*i_qgroups == 0)
> >  				continue;
> >  			ret = add_qgroup_relation_item(trans, objectid,
> > @@ -3386,7 +3385,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  		goto unlock;
> >  
> >  	i_qgroups = (u64 *)(inherit + 1);
> > -	for (i = 0; i < inherit->num_qgroups; ++i) {
> > +	for (int i = 0; i < inherit->num_qgroups; i++) {
> >  		if (*i_qgroups) {
> >  			ret = add_relation_rb(fs_info, qlist_prealloc[i], objectid,
> >  					      *i_qgroups);
> > @@ -3406,7 +3405,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  		++i_qgroups;
> >  	}
> >  
> > -	for (i = 0; i <  inherit->num_ref_copies; ++i, i_qgroups += 2) {
> > +	for (int i = 0; i < inherit->num_ref_copies; i++, i_qgroups += 2) {
> >  		struct btrfs_qgroup *src;
> >  		struct btrfs_qgroup *dst;
> >  
> > @@ -3427,7 +3426,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  		/* Manually tweaking numbers certainly needs a rescan */
> >  		need_rescan = true;
> >  	}
> > -	for (i = 0; i <  inherit->num_excl_copies; ++i, i_qgroups += 2) {
> > +	for (int i = 0; i <  inherit->num_excl_copies; i++, i_qgroups += 2) {
>                            ^
> nit:                       we have double space here for no reason.
> Can we just dedup it as well?

I remember removing it but probably forgot to refresh the patch before
sending.

