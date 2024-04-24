Return-Path: <linux-btrfs+bounces-4516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883018B09B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA65B1C23FE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A253398;
	Wed, 24 Apr 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Omrvais2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3VXU+5x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Omrvais2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3VXU+5x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C82F52
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961844; cv=none; b=T5/ufhuLpul+uG10BEHvGQQXXK/IK9n/Pri+7trd5gx60OczOa+eqMl29S16YyjhPTsyRLBpXqWQ/R+nY9vXPb2OYEbSk0CFmDLGMUsf0ftiYA2dmV9VIZ571CquS+Ll4RueTpeiU3c9ZJ8rc8UfNWAL28J2XnnknJinH34CaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961844; c=relaxed/simple;
	bh=6Ks92NyU0l9BvskkFp3t4dT9TntchVooD7w1Cq2FJHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwrejFdca6NalHzSdHYNMsffrlLkRmyNvUYNfrgf3j2tjqOU+2yntBKDu5Hvwi8EUu0RSuH/kC8nVbioF6ItoJXtnZak/SkCJfgdX6QY+IqfJ8MEy1Mcoou1qKpnoQ5XvWzzxsUlsJmcE6mcRlgzaVF6nPKTAoCBDMqT6Crnfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Omrvais2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3VXU+5x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Omrvais2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3VXU+5x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C6063E708;
	Wed, 24 Apr 2024 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713961840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWmhW90rWJ4DwIlvtVJpszELQIT5DN/CgOd7eAzfPAs=;
	b=Omrvais2HBPmPikszu0X1mykPPh7y87PAySdrLemIlglFbGoA0tUc/6bFLzbrfNte61hUI
	nOTkeDRWp9FmMO6cKur6304js3luBXZvbh/mkNTagbLomcHcgyDpqo0PAJ7OnMtZjd9jgy
	oswFbqtobYinkshr0G86evHNpmaE4xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713961840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWmhW90rWJ4DwIlvtVJpszELQIT5DN/CgOd7eAzfPAs=;
	b=b3VXU+5xl+BC2tWQ2tsh7aLryMAEwnxj9zDrwUs0diQ2pd2nC++SAbSokgPthV1c9L7QnV
	kaT5ty2y+PBcYCAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713961840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWmhW90rWJ4DwIlvtVJpszELQIT5DN/CgOd7eAzfPAs=;
	b=Omrvais2HBPmPikszu0X1mykPPh7y87PAySdrLemIlglFbGoA0tUc/6bFLzbrfNte61hUI
	nOTkeDRWp9FmMO6cKur6304js3luBXZvbh/mkNTagbLomcHcgyDpqo0PAJ7OnMtZjd9jgy
	oswFbqtobYinkshr0G86evHNpmaE4xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713961840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWmhW90rWJ4DwIlvtVJpszELQIT5DN/CgOd7eAzfPAs=;
	b=b3VXU+5xl+BC2tWQ2tsh7aLryMAEwnxj9zDrwUs0diQ2pd2nC++SAbSokgPthV1c9L7QnV
	kaT5ty2y+PBcYCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D80C1393C;
	Wed, 24 Apr 2024 12:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AWXGnD7KGanbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 12:30:40 +0000
Date: Wed, 24 Apr 2024 14:23:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/15] btrfs: clean up our handling of refs == 0 in
 snapshot delete
Message-ID: <20240424122307.GL3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713550368.git.josef@toxicpanda.com>
 <ef416b593a77b2b4c4b8faed51390bb3cc36ae1c.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef416b593a77b2b4c4b8faed51390bb3cc36ae1c.1713550368.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Fri, Apr 19, 2024 at 02:17:07PM -0400, Josef Bacik wrote:
> In reada we BUG_ON(refs == 0), which could be unkind since we aren't
> holding a lock on the extent leaf and thus could get a transient
> incorrect answer.  In walk_down_proc we also BUG_ON(refs == 0), which
> could happen if we have extent tree corruption.  Change that to return
> -EUCLEAN.  In do_walk_down() we catch this case and handle it correctly,
> however we return -EIO, which -EUCLEAN is a more appropriate error code.
> Finally in walk_up_proc we have the same BUG_ON(refs == 0), so convert
> that to proper error handling.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 43fe12b073c3..5eb39f405fd5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5352,7 +5352,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
>  		/* We don't care about errors in readahead. */
>  		if (ret < 0)
>  			continue;
> -		BUG_ON(refs == 0);
> +
> +		/*
> +		 * This could be racey, it's conceivable that we raced and end
> +		 * up with a bogus refs count, if that's the case just skip, if
> +		 * we are actually corrupt we will notice when we look up
> +		 * everything again with our locks.
> +		 */
> +		if (refs == 0)
> +			continue;
>  
>  		/* If we don't need to visit this node don't reada. */
>  		if (!visit_node_for_delete(root, wc, eb, refs, flags, slot))
> @@ -5401,7 +5409,10 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
>  					       NULL);
>  		if (ret)
>  			return ret;
> -		BUG_ON(wc->refs[level] == 0);
> +		if (unlikely(wc->refs[level] == 0)) {
> +			btrfs_err(fs_info, "Missing references.");

Has this message been copied from somewhere? It's quite useless and
could be either dropped completely or at least be more specific about
the error.

> +			return -EUCLEAN;
> +		}
>  	}
>  
>  	if (wc->stage == DROP_REFERENCE) {
> @@ -5665,7 +5676,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
>  
>  	if (unlikely(wc->refs[level - 1] == 0)) {
>  		btrfs_err(fs_info, "Missing references.");

Ah right, so this looks like the source.

> -		ret = -EIO;
> +		ret = -EUCLEAN;
>  		goto out_unlock;
>  	}
>  	wc->lookup_info = 0;
> @@ -5776,7 +5787,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
>  				path->locks[level] = 0;
>  				return ret;
>  			}
> -			BUG_ON(wc->refs[level] == 0);
> +			if (unlikely(wc->refs[level] == 0)) {
> +				btrfs_err(fs_info, "Missing refs.");
> +				return -EUCLEAN;
> +			}
>  			if (wc->refs[level] == 1) {
>  				btrfs_tree_unlock_rw(eb, path->locks[level]);
>  				path->locks[level] = 0;
> -- 
> 2.43.0
> 

