Return-Path: <linux-btrfs+bounces-21617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDJxHg6Bi2m+UwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21617-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:03:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B911E7CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 20:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D1D303B7FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 19:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5C2C11D3;
	Tue, 10 Feb 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFjxud5h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jxBGop6b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D++e4UWZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1E48Dajw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49B1F03EF
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750214; cv=none; b=B7RqGr3/54pv/cF2JNiI4+gtV4UzwrP9Cytl/o32Y900UeSTP/QMsb01ZfoZer7PRNLqCeKzEqPBvo1RalJWp4LNAaoLq2ZgDaZblwcpFBN5h72usc6yjlypMmrn9s7xypXcgOLLm2tMTteOqUznaQnrdlzehqgIj/Y5308ioQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750214; c=relaxed/simple;
	bh=ogJF0LO+pJzbL9iPH8LPsopO7A9ySrqOwnBh2c7r1yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNyuwrI9j1006SbKIUn14Z6ZEY3YXDLvb848nlg5vRvS/RHMHy5t/nwVPUYg8/OA0gb+UzdVYiIyYrgXpQNPeLNDttVIaDfDiOCdY1Z2vYyQfh6FroikKaHYoecztTHjvAgCPpg0URvPVoRkOAnp2Apo8XESfM5KgKLZEx214gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFjxud5h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jxBGop6b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D++e4UWZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1E48Dajw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 315CB3E71C;
	Tue, 10 Feb 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+z4ML/SOl0KJXzf8lts5kOWOo+FQo2sg0HCTLWlI0k=;
	b=GFjxud5htJVSgiCgpnmu/hQky2uHDxRB0qD8RDm8WUlmRj8BYc7bA3c1b7hfMIryGRJnDh
	RcReK+K/ko4jMpkcpDwqiHd4sU3efot9ve9IIuGry+6HD6UXPwQOCZ36twoOiT0MRVxKb4
	KTIUAz/xDzBCbVjyQBHf/eKuA1phKMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+z4ML/SOl0KJXzf8lts5kOWOo+FQo2sg0HCTLWlI0k=;
	b=jxBGop6bz71HBSLu5Suw0L/5s14Jl5kIJ6BJfui19C3M+0m8rLX2VUmWnadxCFunw5PyC4
	Fl6iN8ePDnpZESCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770750210;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+z4ML/SOl0KJXzf8lts5kOWOo+FQo2sg0HCTLWlI0k=;
	b=D++e4UWZ83gndA8P7vvL8ENPd3DXeK/xnVNiWudUheL41YNdZG6hdrDqsZmBZRn1mogCPo
	0tzw6Yc03BpBV8ixWrCK8hoNRNTh1k98N0MGqDlndxistYU3P+hTL2+zk3bXMIIkoexXtb
	yXKuwULmt9/L7zzRLrgrSHG6Y3tsGUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770750210;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+z4ML/SOl0KJXzf8lts5kOWOo+FQo2sg0HCTLWlI0k=;
	b=1E48DajweuPaKjL61YAurpgocZWKV6a0pBzhqe+//I/Tnlpvho5Pfpa4f7z7giXl3f5EFq
	HR7Itikjfq1ey4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9973EA62;
	Tue, 10 Feb 2026 19:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sM1UBgKBi2nhPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Feb 2026 19:03:30 +0000
Date: Tue, 10 Feb 2026 20:03:28 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: convert log messages to error level in
 btrfs_replay_log()
Message-ID: <20260210190328.GF26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fdf43710fac61ba7efd4933dd8c3832f95fbd9a2.1770719576.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf43710fac61ba7efd4933dd8c3832f95fbd9a2.1770719576.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21617-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF4B911E7CE
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:33:27AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are logging messages as warnings but they should really have an error
> level instead, as if the respective conditions are met the mount will
> fail. So convert them to error level and also log the error code returned
> by read_tree_block().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

