Return-Path: <linux-btrfs+bounces-7815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E196C4ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17AD1C25155
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D51E0B93;
	Wed,  4 Sep 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OljvneZw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXTzRR+b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OljvneZw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iXTzRR+b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69B1E0081
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469570; cv=none; b=mDpTbwc9f0AMWe6H5N/xQ0ZqFUTQA1xo6h2JNCIuVuaZKdkNQ5OzFWdPgujvRyF5qSJaoaYG7ZBf6Y2BWnZANL9/6UAEsTmLjVQB3ptY3yIOiwQuvqW+m1yNrIqWQraPjVVwV3hJ7+tSjNw/7Tgi9The8SIjDhcwy/klYnztSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469570; c=relaxed/simple;
	bh=HFjBk6ctl0ImBYarGoEJZlcqvJxEmasMBiYn73qgIKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk4o6wF78b+z7zjiPQtkD+JcYHWyraAKchX573QzJHv1RklqL8+nlOZFukkcXr7AfsOmc2ebHOloMQrB2xoWtIdS+WQaPfYlNnR3o3sLwQyMmYQs5QPoCnr8Ie34/dBXKLWnQcyWr21GMpwGc/2Kf0sgT9VYJP+vYmZHpjX83kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OljvneZw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iXTzRR+b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OljvneZw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iXTzRR+b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFA531F7D7;
	Wed,  4 Sep 2024 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10Z8jegw3xmyDtII9ri9Yxgtpn5RMNJzWN4eI9jilSo=;
	b=OljvneZww0OepY/QyP+bP+csJ9jLRAUCro2Xd3exKQRT9a5oZuyo0rSRrtFnF/5rFvT8cf
	EbFo/MX6LDICiCtgB3FMMcIEwKuWm3QZhTPbQmdX72AK4eBxHKCC838K8EuZsCLAf3+fnX
	hsk1h75JSXToeHuuyctxZdEliy+SQC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10Z8jegw3xmyDtII9ri9Yxgtpn5RMNJzWN4eI9jilSo=;
	b=iXTzRR+bs4EoWi0QK8gM9LJITu+DgHKP7nPBl/R+8gWsFtt23W330BIfw2+FAuxtdlqrW+
	aT980mAutbsK6eBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725469565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10Z8jegw3xmyDtII9ri9Yxgtpn5RMNJzWN4eI9jilSo=;
	b=OljvneZww0OepY/QyP+bP+csJ9jLRAUCro2Xd3exKQRT9a5oZuyo0rSRrtFnF/5rFvT8cf
	EbFo/MX6LDICiCtgB3FMMcIEwKuWm3QZhTPbQmdX72AK4eBxHKCC838K8EuZsCLAf3+fnX
	hsk1h75JSXToeHuuyctxZdEliy+SQC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725469565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10Z8jegw3xmyDtII9ri9Yxgtpn5RMNJzWN4eI9jilSo=;
	b=iXTzRR+bs4EoWi0QK8gM9LJITu+DgHKP7nPBl/R+8gWsFtt23W330BIfw2+FAuxtdlqrW+
	aT980mAutbsK6eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1CC139E2;
	Wed,  4 Sep 2024 17:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eZWwKH2T2GaYJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Sep 2024 17:06:05 +0000
Date: Wed, 4 Sep 2024 19:05:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: merge btrfs_folio_unlock_writer() into
 btrfs_folio_end_writer_lock()
Message-ID: <20240904170549.GN26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4201e46852d085bf6e1790ea2cd12f5f970abb8a.1725251192.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4201e46852d085bf6e1790ea2cd12f5f970abb8a.1725251192.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Sep 02, 2024 at 01:57:08PM +0930, Qu Wenruo wrote:
> The function btrfs_folio_unlock_writer() is already calling
> btrfs_folio_end_writer_lock() to do the heavy lifting work, the only
> missing 0 writer check.
> 
> Thus there is no need to keep two different functions, move the 0 writer
> check into btrfs_folio_end_writer_lock(), and remove
> btrfs_folio_unlock_writer().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

