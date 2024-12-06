Return-Path: <linux-btrfs+bounces-10094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47D9E765E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF7165C76
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753E1F3D31;
	Fri,  6 Dec 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYXMXvcX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCakIdB4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYXMXvcX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCakIdB4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C314BFA2
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503683; cv=none; b=EtirEVr8HL+G5LuGcG6BgUAuhi1pLx85NCTF5W9VHaAKsQk2MaKCnIGi2C0fMdGRMvgiZ8HWkSCedF9ySwf70e9ICtYSY1+ZIEO9pivZM9lvyImzIB1icPH+1enCQtOHX+GCPFvu1XgaTDgnm2RtM8QaQ/WvSayNNiuzUKwEXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503683; c=relaxed/simple;
	bh=tscihvhAT/sYtdmtxAH/L88BpcINIf+gj2w3m6EEEIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuegkpNfADdDRmAU+cyxF4wXZWKoWLfMmXm4ja/Y8GEn/VzJKAIPN9ZI7ZHEREFh2GzvB69llmN35Soph/NkTLcOvzkZtyx8vh9jN4S73UwAhflyVgla8XE93i4NQYnmHIHjukdBHdVn/JQw3lpksfxKk+oeSY+lwWaEJYSr2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYXMXvcX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCakIdB4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYXMXvcX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCakIdB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B770B1F45F;
	Fri,  6 Dec 2024 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733503679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7uvrSYHHHZ03Bh2ybvCudt//5MeuwownlK1S74qd98=;
	b=GYXMXvcX27k3F4+3RIui3L8J/fIyZfAOO5HQhwst3iKN3kVeTESqU3P0xN1iejb0rszJ84
	k37ZpVckjajtxrrcoLZ7HLH3dF2awegz42eE8zlddxrJO15wW964HsSYZPP08EiYFv2rgE
	TH08VyFCSWenMseyqibvjpHu8rdbARE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733503679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7uvrSYHHHZ03Bh2ybvCudt//5MeuwownlK1S74qd98=;
	b=eCakIdB4uNCokIWZcTJ1gGPTCG5nWkJbH9yyx39Up4OFlk7AgutXFt21NgGaa2bzuysT3d
	iGodAoLNdwjgT/DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733503679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7uvrSYHHHZ03Bh2ybvCudt//5MeuwownlK1S74qd98=;
	b=GYXMXvcX27k3F4+3RIui3L8J/fIyZfAOO5HQhwst3iKN3kVeTESqU3P0xN1iejb0rszJ84
	k37ZpVckjajtxrrcoLZ7HLH3dF2awegz42eE8zlddxrJO15wW964HsSYZPP08EiYFv2rgE
	TH08VyFCSWenMseyqibvjpHu8rdbARE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733503679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7uvrSYHHHZ03Bh2ybvCudt//5MeuwownlK1S74qd98=;
	b=eCakIdB4uNCokIWZcTJ1gGPTCG5nWkJbH9yyx39Up4OFlk7AgutXFt21NgGaa2bzuysT3d
	iGodAoLNdwjgT/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1099138A7;
	Fri,  6 Dec 2024 16:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p28MJ78qU2egEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 16:47:59 +0000
Date: Fri, 6 Dec 2024 17:47:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 03/10] btrfs: add btrfs_read_policy_to_enum helper and
 refactor read policy store
Message-ID: <20241206164753.GF31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731076425.git.anand.jain@oracle.com>
 <4664157d202c375536d3c7d3d8545b38611e35bd.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664157d202c375536d3c7d3d8545b38611e35bd.1731076425.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,oracle.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 15, 2024 at 10:54:03PM +0800, Anand Jain wrote:
> Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
> conversion of a string read policy to its corresponding enum value. This
> reduces duplication and improves code clarity in `btrfs_read_policy_store`.
> The `btrfs_read_policy_store` function has been refactored to use the new
> helper.
> 
> The parameter is copied locally to allow modification, enabling the
> separation of the method and its value. This prepares for the addition of
> more functionality in subsequent patches.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index fd3c49c6c3c5..7506818ec45f 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1307,6 +1307,34 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>  
>  static const char * const btrfs_read_policy_name[] = { "pid" };
>  
> +static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
> +{
> +	bool found = false;
> +	enum btrfs_read_policy index;
> +	char *param;
> +
> +	if (!str || !strlen(str))

For ineger values please use '== 0'

> +		return 0;
> +
> +	param = kstrdup(str, GFP_KERNEL);

Why do you need the dynamic allocation? The policy strings won't be
long, so a 32 bytes on stack can be sufficient.

> +	if (!param)
> +		return -ENOMEM;
> +
> +	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
> +		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	kfree(param);
> +
> +	if (found)
> +		return index;
> +
> +	return -EINVAL;
> +}

