Return-Path: <linux-btrfs+bounces-7199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B1F9524E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638A61C217F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC581C825B;
	Wed, 14 Aug 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5sZFs0c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="esNQY8uQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZGpg1rx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bC16Cqp/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF857346D
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672057; cv=none; b=tgK/HdNgdycl4FvDOiaaHbzZbuWSEQTHnX3eJpPHFN4AtRZ2NQvQxrWGOjKLuMMxs3sGMae7U6Mrf7hTMec5oiEfGDVd0D+FmD2EBpXLa7fiqhYbWGjCRwxw7CarQSgyju/0yKe8eB8DUvclRsOF9l0PwW73NJgHWZG42LFvHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672057; c=relaxed/simple;
	bh=6NAiPZvrgPVWWltDER7GEO2RztQOTSu8QvedGb5I6Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1OENGeud1Fjb7NUPHDhrLrgpYmIdMeddu4mP8qJvEQk4mDGHkriJ5iJBwq05oPj3/7ThILjNYTd9LylBqhzTcVYRvDhgLndbuG5TK6SNQ2bPWF67caksfPg/5qZ8kCAFbNEkAFLzXOzp2XrrwRwWnqCI5TQnCfZosCbqSw2dRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5sZFs0c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=esNQY8uQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rZGpg1rx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bC16Cqp/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8862322035;
	Wed, 14 Aug 2024 21:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723672053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dI88J+kfKeO3pGehfM/eNBHPz6qC5JjkdJYWB+MZDL4=;
	b=y5sZFs0cgg2ningPzPVwMfWYkDi4Tf9vGQP3IUKfWqK2oyrwDwUBrtFWXGH1On5sKgrwy8
	AXOs7kRltR16D+Wjfgn8R1Ld6to0F9cRx3ctlREGW3eetIWqtJBFIL19ApJ5yPuKVC9mX6
	5WE+/1POPAUVKIbQRxpQ4kCfS65Q3pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723672053;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dI88J+kfKeO3pGehfM/eNBHPz6qC5JjkdJYWB+MZDL4=;
	b=esNQY8uQFB3KVL8LU0GOsbbFdcawNuve6fmsd0BQhprrp8EyFkoonY8pMq79qXJTqPx6Ai
	T8ah5cQi9HKJugDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723672052;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dI88J+kfKeO3pGehfM/eNBHPz6qC5JjkdJYWB+MZDL4=;
	b=rZGpg1rxgNNKD0AwHT9M3anCuVVvcNGNCWXbWx0lmKvtBJ5rw4eq16DaOe98I4X2aJBrEi
	x4cQsnoSwlIsUL1F+6ApykRbWkey3mZ96OI8rw701FuWZ7o1JJHqa2nufYvYOgL7ZpSv5e
	r4BXJyRVpoqXfzh2DG8RmllEeERLIJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723672052;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dI88J+kfKeO3pGehfM/eNBHPz6qC5JjkdJYWB+MZDL4=;
	b=bC16Cqp/4PjjqT9IP1ONp1BtCUDwO7wZKIr3FUfqaD35eG4DqppHOMs1tbsssO1FMce59P
	kMBWGk2VsRozXyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7123B1348F;
	Wed, 14 Aug 2024 21:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqvwGvQlvWa8VQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 Aug 2024 21:47:32 +0000
Date: Wed, 14 Aug 2024 23:47:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240814214731.GA25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <83f9b6b1-9027-41e5-b0ee-c667dd181fa4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f9b6b1-9027-41e5-b0ee-c667dd181fa4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Tue, Aug 13, 2024 at 08:52:04AM +0800, Anand Jain wrote:
> 
> Nice feature.
> 
> >> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than normal directory"),
> > 
> > Please mention that it can be specified multiple times.
> 
> Nitpick..
> 
> Should '--subvol' be '--subvolume' for consistency? use the full names.

For convenience both can be accepted, there are aliases for options. The
subcommand names are recognized if abbreviated and still unique, I'm not
sure getopt does the same for long options, if not adding another line
to define another name is no problem.

