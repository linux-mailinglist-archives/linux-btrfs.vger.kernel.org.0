Return-Path: <linux-btrfs+bounces-7180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE645951054
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA61F24870
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEB1AC438;
	Tue, 13 Aug 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bv3GCNBE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7wXcqEMi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bv3GCNBE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7wXcqEMi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FA1ABECE
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590712; cv=none; b=JJg3tu171iUhATII0j2fQEX1wL5exCrGgMBTGH0Fw5nqQMPKTgw3wRZIk4DXwamJv2cXmD7kzgWhPboxEtdV2SfqxVsRWsROgKl6r5s5b/o8CW1vUWv+UROO5/Ri41zsmelzmsa1ywa3VOacu7/evNs156mx96Njq8DRlNV9Ovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590712; c=relaxed/simple;
	bh=C7WA4Ud775Y77uJezcqiMgNanAdRC9HW2ESYVCuRUxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2oxbxXOesg+eroZeXin5rUCsUTChkpttJv3UsUpY6A0UAeK2IvP7tWEFNOs/m/j8qWbxXri5GIvdtHWpg6pzE6waQ89DcXh2v3B3vGwRcKvS6G9FE7Frn8tWVBiojmlo5X6tfhj0kF14b4IOvK6V1qhDEQZgHb2v8g7pC18hm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bv3GCNBE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7wXcqEMi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bv3GCNBE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7wXcqEMi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4421D22698;
	Tue, 13 Aug 2024 23:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723590708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqowB+vXEGXuRsK4pxlwSwM+93309+GpdAV20Uip98=;
	b=Bv3GCNBEMIgpU6QlPY8ELul9JqJogDS9avoowVfFfnveQWMIdPcij1CJrfiWgZ4Y61XVGA
	fmg3Q3kyDjy19b+y3xnE/2gUmAiRLe+CBGST8weSHYzf/NnQPcwoMDTO0eezae5SLNBicP
	VVlBB+6lE2m0EZnGBGt5mmr01J3dQYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723590708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqowB+vXEGXuRsK4pxlwSwM+93309+GpdAV20Uip98=;
	b=7wXcqEMijdVVaWSXhzGbagfr74IoLuLJHrcXW0/bGt2RwhJAFcWxC++D1rI7JEODw89lus
	XvwpT6W6jsLnKECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723590708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqowB+vXEGXuRsK4pxlwSwM+93309+GpdAV20Uip98=;
	b=Bv3GCNBEMIgpU6QlPY8ELul9JqJogDS9avoowVfFfnveQWMIdPcij1CJrfiWgZ4Y61XVGA
	fmg3Q3kyDjy19b+y3xnE/2gUmAiRLe+CBGST8weSHYzf/NnQPcwoMDTO0eezae5SLNBicP
	VVlBB+6lE2m0EZnGBGt5mmr01J3dQYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723590708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcqowB+vXEGXuRsK4pxlwSwM+93309+GpdAV20Uip98=;
	b=7wXcqEMijdVVaWSXhzGbagfr74IoLuLJHrcXW0/bGt2RwhJAFcWxC++D1rI7JEODw89lus
	XvwpT6W6jsLnKECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24F0113983;
	Tue, 13 Aug 2024 23:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j/x2CDTou2aeMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Aug 2024 23:11:48 +0000
Date: Wed, 14 Aug 2024 01:11:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
Message-ID: <20240813231146.GW25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Aug 11, 2024 at 03:20:08PM +0930, Qu Wenruo wrote:
> [REPORT]
> There is a corruption report that btrfs refuse to mount a fs that has
> overlapping dev extents:
> 
>  BTRFS error (device sdc): dev extent devid 4 physical offset
> 14263979671552 overlap with previous dev extent end 14263980982272
>  BTRFS error (device sdc): failed to verify dev extents against chunks: -117
>  BTRFS error (device sdc): open_ctree failed
> 
> [CAUSE]
> The cause is very obvious, there is a bad dev extent item with incorrect
> length.
> Although we are not 100% sure of the cause before getting the dev tree
> dump, I'm already surprised that we do not have any checks on dev tree.
> 
> Currently we only do the dev-extent verification at mount time, but if the
> corruption is caused by memory bitflip, we really want to catch it before
> writing the corruption to the storage.
> 
> Furthermore the dev extent items has the following key definition:
> 
> 	(<device id> DEV_EXTENT <physical offset>)
> 
> Thus we can not just rely on the generic key order check to make sure
> there is no overlapping.
> 
> [ENHANCEMENT]
> Introduce dedicated dev extent checks, including:
> 
> - Fixed member checks
>   * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
>   * chunk_objectid should always be
>     BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)
> 
> - Alignment checks
>   * chunk_offset should be aligned to sectorsize
>   * length should be aligned to sectorsize
>   * key.offset should be aligned to sectorsize
> 
> - Overlap checks
>   If the previous key is also a dev-extent item, with the same
>   device id, make sure we do not overlap with the previous dev extent.
> 
> Reported: Stefan N <stefannnau@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks like we missed some simple tree item checks indeed.

Reviewed-by: David Sterba <dsterba@suse.com>

