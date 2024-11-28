Return-Path: <linux-btrfs+bounces-9950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588B89DB861
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A654B211DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6211A2631;
	Thu, 28 Nov 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tS8eBNpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgf110mQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tS8eBNpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgf110mQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414B19EEB4;
	Thu, 28 Nov 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799647; cv=none; b=rC2cUZ9E+EbzRpIUlzYSDjypI9xaA4zeU8eOTFvB/9PS31VyG/0Y9AjR6dYY88fq2qildA6lhrP459ioLXeqcsI3iy67F6CzIEZj3ZFnmjUC7BqmQo+6K5uODESmumgbNZpO0nHBn1bQUs759WcueaoPYzwNNwPbWvD8RdtgtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799647; c=relaxed/simple;
	bh=Rz1Qg2X8UnDaLDOZGQs95vUG/d4IbZhxX8cRQHIK5hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvytdAk+dyg6pqjsZtNTNs85NVZ6fybU5cDBaJ0MMVkwNVJn20BOQpYpyO+MPOGYg0nCxWPSDzjhx4zu193HLr/zcbp5AdYrNRSeAdsHj+QCUgmDFKNa156eHnCF/+QzpMbTm+gs08tFyTLxODh5J0kEiGdChZCI0/KbpU+MzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tS8eBNpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgf110mQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tS8eBNpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgf110mQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F417D1F44F;
	Thu, 28 Nov 2024 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXncd2gcmOzdxbWvBZejdLk86kCrNQ0yrsA8I3klF6U=;
	b=tS8eBNpLXQAQ7d1GoF6hwQfAD3N/aVtrYYitnMhK+dECpQEknprCwHO4Hp0rU+qdjGzYyX
	dWHQEtoxZynsB/EtJDc9XaKCD/1XyARRErdkdGyWIBg03QBFXIldyEapQ7ihbrHwkvDOP5
	1j7ova3Sw1bIf77mYJaQApibi5uCnIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXncd2gcmOzdxbWvBZejdLk86kCrNQ0yrsA8I3klF6U=;
	b=mgf110mQiu+zLe0hQPyIgCjtfnRW5lIUZH68opNaPhhVNGNMLqzdH4ZQfP+dlm+ZEi0oN8
	/CoP7eYPtCpeQJBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tS8eBNpL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mgf110mQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXncd2gcmOzdxbWvBZejdLk86kCrNQ0yrsA8I3klF6U=;
	b=tS8eBNpLXQAQ7d1GoF6hwQfAD3N/aVtrYYitnMhK+dECpQEknprCwHO4Hp0rU+qdjGzYyX
	dWHQEtoxZynsB/EtJDc9XaKCD/1XyARRErdkdGyWIBg03QBFXIldyEapQ7ihbrHwkvDOP5
	1j7ova3Sw1bIf77mYJaQApibi5uCnIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXncd2gcmOzdxbWvBZejdLk86kCrNQ0yrsA8I3klF6U=;
	b=mgf110mQiu+zLe0hQPyIgCjtfnRW5lIUZH68opNaPhhVNGNMLqzdH4ZQfP+dlm+ZEi0oN8
	/CoP7eYPtCpeQJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D882213690;
	Thu, 28 Nov 2024 13:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tC2eNJtsSGfleAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 13:14:03 +0000
Date: Thu, 28 Nov 2024 14:14:02 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <20241128131402.GR31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F417D1F44F
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 28, 2024 at 12:14:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we interrupt the test after it spawned the fsstress and balance
> processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
> kill them and they stay around for a long time, making it impossible to
> unmount the scratch filesystem (failing with -EBUSY).
> 
> Fix this by adding a _cleanup function that kills the processes and
> waits for them to exit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

