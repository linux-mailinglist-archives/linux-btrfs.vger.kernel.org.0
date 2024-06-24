Return-Path: <linux-btrfs+bounces-5941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB791555E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3277D281EEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299719DF72;
	Mon, 24 Jun 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmCrR86p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EBvIlgX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmCrR86p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EBvIlgX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D9FC08
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250241; cv=none; b=bZXAJoYNJ+IVqDeaT0A7LEyBjhc5QCp7NKTvxr0qTP0ObRZRyKJiAtvuMdSAN4Ztl9wr5bIG6mF5YO2x1oXD/vAfjxm8ZD9MKuA9rS1Qc+PS1CCVg7c3qROr0IYHz0q9ORZGe4jOular+QZqft3nIpz4BwraeB9SsGrwyqNGdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250241; c=relaxed/simple;
	bh=bJsYX0K21JwTvPNBtfQjQxPdy0ac90ga4bkaIqsiIf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rddke8hPa53bhlWwPFJrNbUoMaebsPb9MLoEYD0PcFYmMzO7ly8FGuRwUSGVKa34g3+ERr/fhReGcDl6A1sZRQUpYfcQDOxBJNvqhKtM1tpUXn2hJYr7SXQBBZatukJFgXgdKSS4Ej8w06zxMUmZSVC80V9tJhFkwH+oLHHQ26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmCrR86p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3EBvIlgX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmCrR86p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3EBvIlgX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A3E51F83E;
	Mon, 24 Jun 2024 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719250237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7qIBCrt3WrQbt/mjlhea5poaOP4d/WdozILILFLx1E=;
	b=RmCrR86pSb8sfoKM64BHwLWkqAPJ/yZKAjHDr7ZwpDIjppjPdFOTOz0LMpL8NwkuESW4RJ
	TEwUwKFwa7R69L+dMp2nYGopn6JwnXAOPY2DRCXJGqJgapp2IhT5EEgGzka6Yw3aEoZHz4
	iXA9kgqwE/yDJj7TiU90K7TNZUBHWhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719250237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7qIBCrt3WrQbt/mjlhea5poaOP4d/WdozILILFLx1E=;
	b=3EBvIlgXmmGhjOg1ABhGWOMTjVhZmMq2DrGh5i4KsKJxHiInKaWMyr7o76XXShng48y/6n
	u+LFQ+JmqP/NvrDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719250237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7qIBCrt3WrQbt/mjlhea5poaOP4d/WdozILILFLx1E=;
	b=RmCrR86pSb8sfoKM64BHwLWkqAPJ/yZKAjHDr7ZwpDIjppjPdFOTOz0LMpL8NwkuESW4RJ
	TEwUwKFwa7R69L+dMp2nYGopn6JwnXAOPY2DRCXJGqJgapp2IhT5EEgGzka6Yw3aEoZHz4
	iXA9kgqwE/yDJj7TiU90K7TNZUBHWhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719250237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7qIBCrt3WrQbt/mjlhea5poaOP4d/WdozILILFLx1E=;
	b=3EBvIlgXmmGhjOg1ABhGWOMTjVhZmMq2DrGh5i4KsKJxHiInKaWMyr7o76XXShng48y/6n
	u+LFQ+JmqP/NvrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D15813AA4;
	Mon, 24 Jun 2024 17:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6xF3Fj2teWbdQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 17:30:37 +0000
Date: Mon, 24 Jun 2024 19:30:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: remove raid stripe encoding
Message-ID: <20240624173031.GU25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240620075455.20074-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620075455.20074-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jun 20, 2024 at 09:54:55AM +0200, Johannes Thumshirn wrote:
> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);

This is too new for LTS distros, I added a copy of the definition to
kernecompat.h.

