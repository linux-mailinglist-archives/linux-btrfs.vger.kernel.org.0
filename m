Return-Path: <linux-btrfs+bounces-2159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583084B6D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 14:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C128E2889C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F01131740;
	Tue,  6 Feb 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lUb+bpWX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xwk0HrET";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y4V1zcwH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8lD0HU+g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDF12FF81;
	Tue,  6 Feb 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227305; cv=none; b=twI2CxcUqm6rVXqjdkhPPZJCmiOeXOMFogfuWYRncYgI32iMgUlBmkxNfSnOs4C9+NNfP98XYUgSqvf6Y2pZ5sl/wwvtW2jsLxJXwL2yhmGi4G63p4l0MsBfrLlKA7E5qfW7bl/4IXteWi4Q/ThiBLvp12ZRRH2T6p5JbVFg5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227305; c=relaxed/simple;
	bh=2U7QwUDoV4Y/ITWOYkTXggqHgQkjzGXnlNk2MMceJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JotCjwb4mRjKCF17mcNaGwyaw+VK2YleOEkcHezX2sQLWOYm7OMTI7bNM1owcFzjz4nAFG9B/BfrlvPVEemTcCdL9Th6yXfo/CIrPGsFI5iNe/Prs04w45uoTfo0Ow++WgrRy2wfxhjTtV3U0+4t9UMD8H4/43DvH109tJFUf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lUb+bpWX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xwk0HrET; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y4V1zcwH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8lD0HU+g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED3C1F8C3;
	Tue,  6 Feb 2024 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPQVxYUQQkA4on+GxeQaktk1IGBNhHmBXCNkGvMtf+0=;
	b=lUb+bpWXyXmtC/VAJr/lNvzGHJjV9UWfsWZXbdVnKWxd73TTQPaoATEmcN8tRj+ZExTBs2
	qPx8KdUGGhIyRyfbaDiKulAQ9mjbuncd+Axnt91u/T/waGfgKqtUsQiDQ9CADZ2Y4TSa27
	ZETI0jFuXUVqxUM1da5j9l3NJ8ax+kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227302;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPQVxYUQQkA4on+GxeQaktk1IGBNhHmBXCNkGvMtf+0=;
	b=Xwk0HrETa65xYjA3N7gQqHTik6Vwgn/4PjxNGaakqrkZq3p48O6cb98lnsPzBqHOvx+WJZ
	1jva9h3PKkSuCSCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPQVxYUQQkA4on+GxeQaktk1IGBNhHmBXCNkGvMtf+0=;
	b=Y4V1zcwH0kidvAwF7SMMV9V5aS8nZYivm4PqRhJJOiDYTvcP4jsIrHD989LzdzWjWJscCO
	LujfOU5cIbOwlfix6EQWaxZEJtilqjb1XAKSTCVWwknPH7osx5dnkB4CT5zsTblorlb6pn
	3ilAX7+l34F/RhHXDqukTXTtw86iAoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPQVxYUQQkA4on+GxeQaktk1IGBNhHmBXCNkGvMtf+0=;
	b=8lD0HU+g82B4sozLcysc11QvC5Oke/I+v5OZRMkZFudIv7S2ThAIcwTzaDdTmamQnT5olj
	2zsryRFT5Lbja+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3628132DD;
	Tue,  6 Feb 2024 13:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oDktO6Q4wmVmRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 13:48:20 +0000
Date: Tue, 6 Feb 2024 14:47:52 +0100
From: David Sterba <dsterba@suse.cz>
To: lilijuan@iscas.ac.cn
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: Re: [PATCH] btrfs: mark __btrfs_add_free_space static
Message-ID: <20240206134751.GP355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240206015600.115756-1-lilijuan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206015600.115756-1-lilijuan@iscas.ac.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.02
X-Spamd-Result: default: False [-1.02 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.37%]
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 09:56:00AM +0800, lilijuan@iscas.ac.cn wrote:
> From: Lijuan Li <lilijuan@iscas.ac.cn>
> 
> __btrfs_add_free_space is only used in free-space-cache.c,
> so mark it static.
> 
> Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>

Reviewed-by: David Sterba <dsterba@suse.com>

