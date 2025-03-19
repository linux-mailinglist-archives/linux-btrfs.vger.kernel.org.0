Return-Path: <linux-btrfs+bounces-12431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE014A6976C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4B016D3E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B4207DF9;
	Wed, 19 Mar 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cnlvPbH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O54E8pkD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cnlvPbH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O54E8pkD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4E18D63E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407461; cv=none; b=MXsiAvXtPHqQPGeZHO+eLCIikHpAsvYSt7nXUwUnxq1Q+yaqJPZ8gHq6+GTXzP3oefablhxc2lel/Mquo+v+mE6XiRM6HwgvxsWfV+4t4ul0XdJY1NXIHkM8aQdkWt19EjVoXTrtsiaI1BYs7r4VnOc+QOFV6SXP25Ua2HphmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407461; c=relaxed/simple;
	bh=2pzqCOahNSULXjdHNCdM8s/C3iaoZv8ZOdgXFYu6n88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7X0wXZ3jVkpCYAwERT0XTBgP1NRQfQqFZ829s166bNbB3OWnpuGg8dN86HGVRRcRvURLcU9TDaSap+ErRKtsLDQxSJp8z47JRTmTTJpYlalXfSoe5BjvrZkSIFanwliiOhsAu9QVqxZX5TxioaCE9cOBaYsIGRAaJAclMNLbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cnlvPbH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O54E8pkD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cnlvPbH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O54E8pkD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F23812120D;
	Wed, 19 Mar 2025 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742407458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OK8MKDKvNk4m60cK8RjEe33phTavyjXdJ3CyZZA+vM0=;
	b=1cnlvPbH/b3SHfViRXIR1MWDj3HfUyjslW6fFqajvl3bL9/REiwzTEhIKsMAhFplGZRdsB
	QTZtnIlS9zCi8F6zzMetI+Whe4iuwXI9QSYPDpyqzGpLnoGMC8f/Y40IOQXZic2FWIoFmo
	nsSlGK6nJMN6ekM6eSv51YosbtsWBuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742407458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OK8MKDKvNk4m60cK8RjEe33phTavyjXdJ3CyZZA+vM0=;
	b=O54E8pkDqdeZc+w1TgSlnJm7aOiJ1oy5wB2wTfhPwHn6M6OcckjLozDbdU+1zuOyjhm9PA
	QpFlIEMmYLBCHhCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1cnlvPbH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O54E8pkD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742407458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OK8MKDKvNk4m60cK8RjEe33phTavyjXdJ3CyZZA+vM0=;
	b=1cnlvPbH/b3SHfViRXIR1MWDj3HfUyjslW6fFqajvl3bL9/REiwzTEhIKsMAhFplGZRdsB
	QTZtnIlS9zCi8F6zzMetI+Whe4iuwXI9QSYPDpyqzGpLnoGMC8f/Y40IOQXZic2FWIoFmo
	nsSlGK6nJMN6ekM6eSv51YosbtsWBuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742407458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OK8MKDKvNk4m60cK8RjEe33phTavyjXdJ3CyZZA+vM0=;
	b=O54E8pkDqdeZc+w1TgSlnJm7aOiJ1oy5wB2wTfhPwHn6M6OcckjLozDbdU+1zuOyjhm9PA
	QpFlIEMmYLBCHhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6FAC13726;
	Wed, 19 Mar 2025 18:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k6csNCEH22egewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 18:04:17 +0000
Date: Wed, 19 Mar 2025 19:04:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@meta.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: ioctl: don't free iov when -EAGAIN in uring
 encoded read
Message-ID: <20250319180416.GL32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250319112401.22316-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319112401.22316-1-sidong.yang@furiosa.ai>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F23812120D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Mar 19, 2025 at 11:24:01AM +0000, Sidong Yang wrote:
> This patch fixes a bug on encoded_read. In btrfs_uring_encoded_read(),
> btrfs_encoded_read could return -EAGAIN when receiving requests concurrently.
> And data->iov goes to out_free and it freed and return -EAGAIN. io-uring
> subsystem would call it again and it doesn't reset data. And data->iov
> freed and iov_iter reference it. iov_iter would be used in
> btrfs_uring_read_finished() and could be raise memory bug.
> 
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>

Thanks, added to for-next, with a bit updated changelog and added stable
tag for 6.13.

