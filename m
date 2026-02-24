Return-Path: <linux-btrfs+bounces-21885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HOEMWnanWk0SQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21885-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:05:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50918A472
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D665320E79C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F63A9616;
	Tue, 24 Feb 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExOWNS6k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="efZazxD8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExOWNS6k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="efZazxD8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8DB3A9014
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952229; cv=none; b=MprNAZuhDcDaeuvC/1aI1Go1pYRC2jHWikbFOXcfpVDqBnY3HXnvz0CgWM0zAP/DG7MxZkMUJO2CcuahN2ZW/ttT9WWDc2kLcyxYl4N69cDqMawGYXdlQ8pA6ootk9WN3wivCXITihbFSvjcMiG5vtZpgqXaCPhROhiGe8MprTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952229; c=relaxed/simple;
	bh=iNXXyJcpCizCtc8eWlCcV3MiMwFPprAij8g7u/gG+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL1vD7GAlf3YaIxVsKRH8Jmu4NJR6I2Tq8u/wxEkDFnQgKpMsS/wOQ86q5/apfcxEcEy2nFIZK8KXA5fuZejaXDyH30wZKvgVO7wt3uOF1F8cGyj/4CeeCpK3WNCcKTcxoIDUlcxLXfqGdoySyGr/qAv53y3LQrLig/v4Mb6Yco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExOWNS6k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=efZazxD8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExOWNS6k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=efZazxD8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1D5E5BCEE;
	Tue, 24 Feb 2026 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771952225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20F2P/N5R7RFsLy/D/Uafv5Pss6/5v2JoW18iJJjU9c=;
	b=ExOWNS6kKDT0xPTLaoNxeQK0nId60wcTS6jqUPdrHZlC29PiFnuPJJEBS5rRRV66x5hScX
	jmZf885zenHW+rjLngs9BTbVxC+HtcFrGkxDg7KtGN3IyEsUNa74HlCnf/7sXHb3OvzVAy
	05ISdyawuFdH/1bH4jLy8BM2vrtYZDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771952225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20F2P/N5R7RFsLy/D/Uafv5Pss6/5v2JoW18iJJjU9c=;
	b=efZazxD8ssIELET5fzKWNcWveAVhMzPF4dLEP7yTIwFHZ6RY8s8rVmDFtdH+S5WtsexU12
	QlfByJXgniNDoSCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ExOWNS6k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=efZazxD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771952225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20F2P/N5R7RFsLy/D/Uafv5Pss6/5v2JoW18iJJjU9c=;
	b=ExOWNS6kKDT0xPTLaoNxeQK0nId60wcTS6jqUPdrHZlC29PiFnuPJJEBS5rRRV66x5hScX
	jmZf885zenHW+rjLngs9BTbVxC+HtcFrGkxDg7KtGN3IyEsUNa74HlCnf/7sXHb3OvzVAy
	05ISdyawuFdH/1bH4jLy8BM2vrtYZDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771952225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20F2P/N5R7RFsLy/D/Uafv5Pss6/5v2JoW18iJJjU9c=;
	b=efZazxD8ssIELET5fzKWNcWveAVhMzPF4dLEP7yTIwFHZ6RY8s8rVmDFtdH+S5WtsexU12
	QlfByJXgniNDoSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9471C3EA68;
	Tue, 24 Feb 2026 16:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dfUWJGHYnWnVagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 16:57:05 +0000
Date: Tue, 24 Feb 2026 17:57:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use inode->i_sb to calculate fs_info
Message-ID: <20260224165704.GY26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21885-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,suse.com:email]
X-Rspamd-Queue-Id: 2C50918A472
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:11:37PM -0500, Goldwyn Rodrigues wrote:
> If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
> super block and fsid assignment will lead to a crash.
> 
> Use inode->i_sb to calculate btrfs_sb.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Added to for-next, thanks.

