Return-Path: <linux-btrfs+bounces-21123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHmVON8eeWkQvgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21123-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:23:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 420949A572
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482A830329BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56836EAA5;
	Tue, 27 Jan 2026 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGKsFInw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbT/M5+0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s0VnZpwG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZtY7eMHt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6A36682B
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545429; cv=none; b=WZ2siOeeWQrnOstLdA6AnwkVtey/jU5iYyNwz0Eh1rF+wYjRUj0sV+WTCZt6M4SmBsb5AJTaInJnU6mthMdwCO+heA2CWjmQYAemQAE3mCuot7WVMqROE1oxJHAr67Yglnoe7GHCyMycIBz+Ec0OOJl3aQPKC7xf1Q6q6QDTJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545429; c=relaxed/simple;
	bh=Ba3Lt78m/78bqYrsIvAFGC4boPBMdepWb/gjDswCTJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W53Q+DpyWyGz6XkhsmICZq7zFU05YDNBrxkvk3stRR2H8OvOQe2TiC8VvXc7EnrUVwMOUclXLa/2UUmQPcMbg1ckLCZEcubaWvc1SZ27g+O3pUroBdiGa3V48ZK9AdsICzO8OFuiCyqhgJZ1GS4XwedjsvopJ3Wh2zF0DdGAgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGKsFInw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KbT/M5+0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s0VnZpwG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZtY7eMHt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEFAF338A7;
	Tue, 27 Jan 2026 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769545425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGfcDbfJQtfe/MB7RBVZkmLtoAwPgruDdLc/AQd9UUk=;
	b=JGKsFInwMhUaZxyU2WbkTqz7SuXyJujjqXtMLE/XnjUjKP3QCMdWYt503nIixUicxvWgU4
	yq7sc5SJGIXzhSVPjd/EmU7ZmiS5TA5X3FFE9aDU0XSk8qodMvLvHm9q1nWlkyarPfgtD/
	Obs4vSXAxHJr78iN31bQEmiwWnMf7Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769545425;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGfcDbfJQtfe/MB7RBVZkmLtoAwPgruDdLc/AQd9UUk=;
	b=KbT/M5+0qQzHH98b+Peaq4PWtwDCyRoCPQGJdWIsyRucxjRT6WpNT2WrpcTJYAQuc+5q8x
	DYJ8bgAPqfj+drDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s0VnZpwG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZtY7eMHt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769545424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGfcDbfJQtfe/MB7RBVZkmLtoAwPgruDdLc/AQd9UUk=;
	b=s0VnZpwGKRSNCc3mzAm1zLvcIqZe5erME4UR2nVRRCJBrjqDF/fvdkXSZLwkvxVoGqZ1mB
	UvQBEXsbgKYbxaq4Ifhl2ucz1Ot7V6s+JA5Q+LqrJDaVe8snkhcd8+53Y5tqC+rYFN3VfN
	A6hycsE86+HZnnLZFN2qIVJYm6Dkpk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769545424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGfcDbfJQtfe/MB7RBVZkmLtoAwPgruDdLc/AQd9UUk=;
	b=ZtY7eMHtmzCHtA6IJKSPwRPyh5+NHMTkrdGmpa9GHJzUftYSxY7fpCxlKOWaBXODsUPMnO
	CX34yA7iGbMzT2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA9D23EA61;
	Tue, 27 Jan 2026 20:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZTlPMdAeeWlnFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Jan 2026 20:23:44 +0000
Date: Tue, 27 Jan 2026 21:23:43 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: add missing kernel commit IDs to tests 784 and
 785
Message-ID: <20260127202343.GC26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ac7a142858d625cb5921568918b1b9615a650f25.1769525657.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7a142858d625cb5921568918b1b9615a650f25.1769525657.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21123-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 420949A572
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:01:52PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The respective kernel patches are already in Linus' tree (landed in
> v6.19-rc2), so update the tests to include the commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

