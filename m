Return-Path: <linux-btrfs+bounces-5921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F79152DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD8D1C21780
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65A19D8B0;
	Mon, 24 Jun 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tu/l8xgf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/nNzT8C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tu/l8xgf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/nNzT8C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F319D8A0
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244189; cv=none; b=e9fE4I48izcQ/tUc+zEIxgYxN7/pkh697r8Jl8K4lu3Hp/DSnJm4TglwNg1wkUrQ0VBTwKP3iWlTu9SF6GPaHapubA5Awg62y5LEhyRN85zRa1FDRhlVQZA9hbGuMPFsAcMQGwkQFsSskIx09kXAEvCPpAC0xvFz/tr9CF5/ZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244189; c=relaxed/simple;
	bh=wNhOpcSLm6p7YO4s1OM/ewChkSN+7CDv97tnG9BWEzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0ANHC4YyN8zOcojcI+6Tnio0dwsyv7o5kqvfqTVlhSOFl9j6iJtuqMhPV+ZAAwRn2oL46MEBdCcUDPcF5Q9FLGtLBJ9F9Ife/vU9rdNLbDqU9cLMVb5fA0zeWiysQTMt6qgl9y2Tk1ug5iFZWO6uEfkHTNVxX3s+pRoVc9cV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tu/l8xgf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/nNzT8C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tu/l8xgf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/nNzT8C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 718131F7DC;
	Mon, 24 Jun 2024 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpKbzQa13rkbATAjmkDI/OP0zWOY4HZCMO05orFSTVE=;
	b=tu/l8xgfj9uRvTweRDKYk4dh60iuKKLsaM4tmZoISYzOrzl/qUEmzsi8+/5/ccTaOfTqn6
	xQPczLyupLQXEQHC5TKYqYXuhgf32KVn6ezmluHLWCHyC6I3HUxcPEolewuUzC7OYE5E3n
	xGKvzohfvCa1E3ov0wyIuPiHIxQXHHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpKbzQa13rkbATAjmkDI/OP0zWOY4HZCMO05orFSTVE=;
	b=r/nNzT8CDZPTuOZGMmVOvBnXRrQpjuvyuLL4YqodHF1vywWmfONVn4i8Du5meSbJrzW7gd
	Ve7+jAU56q/7ZhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpKbzQa13rkbATAjmkDI/OP0zWOY4HZCMO05orFSTVE=;
	b=tu/l8xgfj9uRvTweRDKYk4dh60iuKKLsaM4tmZoISYzOrzl/qUEmzsi8+/5/ccTaOfTqn6
	xQPczLyupLQXEQHC5TKYqYXuhgf32KVn6ezmluHLWCHyC6I3HUxcPEolewuUzC7OYE5E3n
	xGKvzohfvCa1E3ov0wyIuPiHIxQXHHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpKbzQa13rkbATAjmkDI/OP0zWOY4HZCMO05orFSTVE=;
	b=r/nNzT8CDZPTuOZGMmVOvBnXRrQpjuvyuLL4YqodHF1vywWmfONVn4i8Du5meSbJrzW7gd
	Ve7+jAU56q/7ZhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 603C913AA4;
	Mon, 24 Jun 2024 15:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5dTF5iVeWYIJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 15:49:44 +0000
Date: Mon, 24 Jun 2024 17:49:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Huang Xiaojia <huangxiaojia2@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	yuehaibing@huawei.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: convert to use super_set_uuid to support
 for FS_IOC_GETFSUUID
Message-ID: <20240624154943.GM25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240624063835.2476169-1-huangxiaojia2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624063835.2476169-1-huangxiaojia2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.94
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-2.94)[99.76%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,huawei.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]

On Mon, Jun 24, 2024 at 02:38:35PM +0800, Huang Xiaojia wrote:
> FS_IOC_GETFSUUID ioctl exposes the uuid of a filesystem. To support
> the ioctl, init sb->s_uuid with super_set_uuid().
> 
> Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
> ---
>  fs/btrfs/disk-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 38cdb8875e8e..e5235dbf9016 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3369,7 +3369,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	/* Update the values for the current filesystem. */
>  	sb->s_blocksize = sectorsize;
>  	sb->s_blocksize_bits = blksize_bits(sectorsize);
> -	memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
> +	super_set_uuid(sb, (void *)fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);

How does this work when the metadat_uuid is set?

