Return-Path: <linux-btrfs+bounces-5179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDC8CB346
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 20:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56AE283574
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238C1494C1;
	Tue, 21 May 2024 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWnKZ00M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="myslhqaD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWnKZ00M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="myslhqaD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57314AD10
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314396; cv=none; b=LrbE6dsZlKtM0OlIj+j9WDzfpb+3/73f7wDua09cBsvuwvs/KT8soH578jmHtruvTG0OJBocRpKc5nKlpyQC55X8Gouwz18b4tjCjjev1m588h4oa+7970yMfgI4jL+VY3fSaNMMz5tmwjrDEgmfClxAlpK58dZ8TsyiQbs8eTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314396; c=relaxed/simple;
	bh=aWhnMLme1MEqw5YS6t6x8bQV+Nlnu/ElBdS8N4J8jl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd9K9xGI3m+K3om2krnP4hREUXw024RcqtIO+GPHdZjWdwoAXby/ewaqMftKhur29mkjL4OQbeFvUe2+PKyn2QyYgpPWEFFw2swQbLu7+ese1qwsniqbtrqPFylnV0p7SJPpJ67cqn4JX5sFvFD8ArvqhYYi5Qrf1yZ/e/NW46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWnKZ00M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=myslhqaD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWnKZ00M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=myslhqaD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17BA65C32F;
	Tue, 21 May 2024 17:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716314391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCt4aH8r2nLjCzu2bdPuaYRE7iMY+tpU8BEgamt8gds=;
	b=DWnKZ00MrnIeVgm/7q2NCQ6fdhbn2lDddeSASN+JutWYasjt1lT53vrKjhiqhjLRzWol1Z
	uTaIU8+tO8xBGzQQmJ17PRuReD0yYbVvw+3NhsTMi94WjkPznF8LdelFT9Yt08DeJxGW08
	ELnqwkEbqbcxCKk0pT6rZ2TUBCkV33A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716314391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCt4aH8r2nLjCzu2bdPuaYRE7iMY+tpU8BEgamt8gds=;
	b=myslhqaD/5mQIMdxK9K/m+lyO5Jtw/tpmW9is3ObrOiQvsJpSBLS+SH4i3q470GVTwMKIk
	fluhCODSx1FNCICA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DWnKZ00M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=myslhqaD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716314391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCt4aH8r2nLjCzu2bdPuaYRE7iMY+tpU8BEgamt8gds=;
	b=DWnKZ00MrnIeVgm/7q2NCQ6fdhbn2lDddeSASN+JutWYasjt1lT53vrKjhiqhjLRzWol1Z
	uTaIU8+tO8xBGzQQmJ17PRuReD0yYbVvw+3NhsTMi94WjkPznF8LdelFT9Yt08DeJxGW08
	ELnqwkEbqbcxCKk0pT6rZ2TUBCkV33A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716314391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCt4aH8r2nLjCzu2bdPuaYRE7iMY+tpU8BEgamt8gds=;
	b=myslhqaD/5mQIMdxK9K/m+lyO5Jtw/tpmW9is3ObrOiQvsJpSBLS+SH4i3q470GVTwMKIk
	fluhCODSx1FNCICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FE713A1E;
	Tue, 21 May 2024 17:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lt1zOBbhTGbKKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 17:59:50 +0000
Date: Tue, 21 May 2024 19:59:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 6/6] btrfs: rename and optimize return variable in
 btrfs_find_orphan_roots
Message-ID: <20240521175949.GS17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715783315.git.anand.jain@oracle.com>
 <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
 <20240521151820.GP17126@twin.jikos.cz>
 <3c9cdd87-87ce-444e-a576-7e9626df04ca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9cdd87-87ce-444e-a576-7e9626df04ca@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 17BA65C32F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, May 22, 2024 at 01:10:08AM +0800, Anand Jain wrote:
> 
> 
> On 5/21/24 23:18, David Sterba wrote:
> > On Thu, May 16, 2024 at 07:12:15PM +0800, Anand Jain wrote:
> >> The variable err is the actual return value of this function, and the
> >> variable ret is a helper variable for err, which actually is not
> >> needed and can be handled just by err, which is renamed to ret.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >> v3: drop ret2 as there is no need for it.
> >> v2: n/a
> >>   fs/btrfs/root-tree.c | 32 ++++++++++++++++----------------
> >>   1 file changed, 16 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> >> index 33962671a96c..c11b0bccf513 100644
> >> --- a/fs/btrfs/root-tree.c
> >> +++ b/fs/btrfs/root-tree.c
> >> @@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
> >>   	struct btrfs_path *path;
> >>   	struct btrfs_key key;
> >>   	struct btrfs_root *root;
> >> -	int err = 0;
> >> -	int ret;
> >> +	int ret = 0;
> >>   
> >>   	path = btrfs_alloc_path();
> >>   	if (!path)
> >> @@ -235,18 +234,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
> >>   		u64 root_objectid;
> >>   
> >>   		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> >> -		if (ret < 0) {
> >> -			err = ret;
> >> +		if (ret < 0)
> >>   			break;
> >> -		}
> >> +		ret = 0;
> > 
> > Should this be handled when ret > 0? This would be unexpected and
> > probably means a corruption but simply overwriting the value does not
> > seem right.
> > 
> 
> Agreed.
> 
> +               if (ret > 0)
> +                       ret = 0;
> 
> is much neater.

That's not what I meant. When btrfs_search_slot() returns 1 then the key
was not found and could be inserted, path points to the slot. This is
done in many other places, so in the orphan root lookup it should be
also handled. 

