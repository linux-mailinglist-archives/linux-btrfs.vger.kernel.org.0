Return-Path: <linux-btrfs+bounces-6464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADB93148E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4CAB21717
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548118C335;
	Mon, 15 Jul 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2gwLK9nm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="12BWbWm4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7QtKJIg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MaVYswIl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F91891A4;
	Mon, 15 Jul 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047296; cv=none; b=g38v6Fy1vejNfyq/fJol6pmC3jax4LXKbkxJwom7ZHPEzkl93zyanZmXP9KGi3ljuABQWcW4BBZ//xESEvWyimTLIqm7GfM4cr7KAbU93X6VKHpusr8VOsdnup0UxCyHHZAcwsVlyBzKQXiesgygbBiiC1jZtjvLmK5EuCRh6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047296; c=relaxed/simple;
	bh=Kd1x5n31KGsvig77meoWgElqlhgAGmXe/dsL1Y6/vbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAT0ODaXrQ2VlKBafqTn/ZOBvNEI6tOhXQZ+UfdSxhsmKaPY1sAokmOHSwbKgPpwdLKyp4YeiHQER1ue1YENZO1T8TohHpnb5QgyjCM85x1z0Adf6HecvWHc7buKMUpSzD3BCxuusnFT+1fzC0iI7dsnSplldDS5/nK7dNBajzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2gwLK9nm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=12BWbWm4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7QtKJIg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MaVYswIl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3511F21BAA;
	Mon, 15 Jul 2024 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721047293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd1x5n31KGsvig77meoWgElqlhgAGmXe/dsL1Y6/vbE=;
	b=2gwLK9nm19dwNB5Q1x4JW3UghvAJQYBWvZgU+D3xYtjklg//3D6xfLrRj4HVPY8hY1VZ9l
	p4bTdMV5SedJfD/+JBEFeY/zixAiLxZYZs5X6zbE6n7feG+WQEQKSoqoGNLZ7M5TqYhHMk
	6dAjggDJK+OYx4b/7+0JPoDxMU7BOSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721047293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd1x5n31KGsvig77meoWgElqlhgAGmXe/dsL1Y6/vbE=;
	b=12BWbWm4ROd7ik9vkrPggnPmANRKQMoeif/IB0m8gbThXo7rz5Aw6mN2BcqmlxKdzcHRo5
	Ycbf0uyAdX8w+sDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721047291;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd1x5n31KGsvig77meoWgElqlhgAGmXe/dsL1Y6/vbE=;
	b=t7QtKJIgFQlL5BffnoA7VvCAb8FuGN3m4TPtihBXrL1FX4bNpSsD3fecp/DKVEPTjx5VGy
	pkM+fl/pueYISEVQd7B5rJhhqNSl/o25pDauhsR23niEPIypxNZo3q6euz9pcBRehfMGvJ
	dXsdfh3ZGkOKokw+fAwm9y39TdxzxrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721047291;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd1x5n31KGsvig77meoWgElqlhgAGmXe/dsL1Y6/vbE=;
	b=MaVYswIlqnQ02IOYljC3PNz9vGmq+T/CJrLjrMBZfzdamly+gtYQgpdgpl4gYdB2JMx0Z9
	3+jxdem3dae+0JDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A87F137EB;
	Mon, 15 Jul 2024 12:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6jc/BvsYlWZqRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Jul 2024 12:41:31 +0000
Date: Mon, 15 Jul 2024 14:41:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Qu Wenru <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 0/3] btrfs: more RAID stripe tree updates
Message-ID: <20240715124129.GE8022@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: 

On Fri, Jul 12, 2024 at 09:48:35AM +0200, Johannes Thumshirn wrote:
> Three further RST updates targeted for 6.11 (hopefully).

6.11 is doable, all are fixes.

