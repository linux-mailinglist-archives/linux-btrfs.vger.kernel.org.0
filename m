Return-Path: <linux-btrfs+bounces-2948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A686D3FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4991C21FB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC313F447;
	Thu, 29 Feb 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENxPk2bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZ++Ahzx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENxPk2bh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dZ++Ahzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0C7E76F
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237652; cv=none; b=iVbD5aFzgsYGgB7+6dnbBKfr+KgprtTxGun+ZXGwQE2GFF2gtvIZzkn2JU9Yc/Fv2In01Lak39Pq5cM1AUc82ufyXUg06Qe51xzgefW55Amm3x1gX5qAxKsr91IEh+W25OfWaZlcvlBmeJVnBF53rFVnk4nHfDKQddp97aL3lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237652; c=relaxed/simple;
	bh=9/39jl9MyYDC6+WPyySq+4kZgv2bg2TPcqvBS4PuwF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnErt1n6uiYz+sI/+PafUggYuAVxJ61nzquSOrT/XjFDSn6I36ZOaWPAY2f1nGmas8yX0OJyYcW9ZBY7vqixk4oSyrqqe3lvbcpYIvNoKF+nCtL31AB9MAy8nkTg4Vw1AKIPBfvSgWRBxdwIo3Ry81D/+0FJDuIPOIi9TMoJtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENxPk2bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZ++Ahzx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENxPk2bh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dZ++Ahzx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7CCB1F807;
	Thu, 29 Feb 2024 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709237648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVud7Mf0oVDAUcZi71UFTr925eL0yW/kMM5wh4LzUcM=;
	b=ENxPk2bhtUtMTr1KLccnG9ZYlINfdz9iPJJBBav+AMVAKE9ag01iq1v0VZxV14dBp1X9xn
	cpoWBCruD4JUzCarR18QEBNEnXEg/JOIsa8vAnRnZNNBsdbUp5tkH9XjWQtMAlAp5KwHYx
	jZMtgR6wa+cfFxMWeIGxib2v3RrDsiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709237648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVud7Mf0oVDAUcZi71UFTr925eL0yW/kMM5wh4LzUcM=;
	b=dZ++AhzxRh/JJ/BsEICFRuPKItShw25oBrcvVRVModg38IiP4V+IU3UmVhRRXowVmoMgTv
	YwV6U/WQ00xVQSBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709237648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVud7Mf0oVDAUcZi71UFTr925eL0yW/kMM5wh4LzUcM=;
	b=ENxPk2bhtUtMTr1KLccnG9ZYlINfdz9iPJJBBav+AMVAKE9ag01iq1v0VZxV14dBp1X9xn
	cpoWBCruD4JUzCarR18QEBNEnXEg/JOIsa8vAnRnZNNBsdbUp5tkH9XjWQtMAlAp5KwHYx
	jZMtgR6wa+cfFxMWeIGxib2v3RrDsiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709237648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVud7Mf0oVDAUcZi71UFTr925eL0yW/kMM5wh4LzUcM=;
	b=dZ++AhzxRh/JJ/BsEICFRuPKItShw25oBrcvVRVModg38IiP4V+IU3UmVhRRXowVmoMgTv
	YwV6U/WQ00xVQSBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A6513451;
	Thu, 29 Feb 2024 20:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fe6eJJDl4GUuAwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 20:14:08 +0000
Date: Thu, 29 Feb 2024 21:07:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: qgroup: allow quick inherit if a snapshot if
 created and added to the same parent
Message-ID: <20240229200701.GG2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <77ffdac5a4f20ae19c35142f03f59fb1a086495b.1709177609.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ffdac5a4f20ae19c35142f03f59fb1a086495b.1709177609.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ENxPk2bh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dZ++Ahzx
X-Spamd-Result: default: False [-0.07 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.69%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.07
X-Rspamd-Queue-Id: A7CCB1F807
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Feb 29, 2024 at 02:04:44PM +1030, Qu Wenruo wrote:
> Currently "btrfs subvolume snapshot -i <qgroupid>" would always mark the
> qgroup inconsistent.
> 
> This can be annoying if the fs has a lot of snapshots, and needs qgroup
> to get the accounting for the amount of bytes it can free for each
> snapshot.
> 
> Although we have the new simple quote as a solution, there is also a
> case where we can skip the full scan, if all the following conditions
> are met:
> 
> - The source subvolume belongs to a higher level parent qgroup
> - The parent qgroup already owns all its bytes exclusively
> - The new snapshot is also added to the same parent qgroup
> 
> In that case, we only need to add nodesize to the parent qgroup and
> avoid a full rescan.
> 
> Add the extra quick accounting update for such inherit.
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/qgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 67 insertions(+), 7 deletions(-)
> ---
> Changelog:
> v2:
> - Move the case of source subvolume without a parent into
>   qgroup_snapshot_quick_inherit()
> 
> - Exit early if the source subvolume has too many parents
> 
> - Small commit message update on the last sentence

Reviewed-by: David Sterba <dsterba@suse.com>

