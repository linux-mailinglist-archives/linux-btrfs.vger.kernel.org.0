Return-Path: <linux-btrfs+bounces-3608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA988C754
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05201F67633
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBFD13CA90;
	Tue, 26 Mar 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDxrDSuz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cZAsHj4j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDxrDSuz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cZAsHj4j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20513C838;
	Tue, 26 Mar 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467248; cv=none; b=EvpphA8ILOdBqSGbD9ObAoHZNVG1hmXfWhcjVUNiXjSAV5r1Brb2nfjlqM5CYH6K56wv1N2FWJZ8CfuosqWiQ3mGuTGP9HXXR0vytAVb6URJFMGuUmCrjEAsz2agWK+KpWTHheOLQ2+r9TdhG5Ji6tiEb6gqP5OjVoJRxg7DQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467248; c=relaxed/simple;
	bh=voHU8CXUO9rULptOoqbMxaCGiQWg8c8+PXZAh+/GUZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT9pOy/tZOp3ljKyS4QER2sZ58YYPYXqkN9Zn/3/gQ6rjkotJFNd7IGVN1JqmffMJmkPf8KhuBpx0ZGmsXEhLDOwEGxeM9+9vPSwbbVv3PRyKh7HOUqPxB8n7sl0F3SDZeF4bmZK3u30kU9NDc3Ns0gC6tKty5CjFZLDdbp0Qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDxrDSuz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cZAsHj4j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDxrDSuz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cZAsHj4j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865865D7A2;
	Tue, 26 Mar 2024 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711467244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t65TdSxXFIxn9BLM0RNbweNcsBs25Tsa2iIZM848EpM=;
	b=EDxrDSuzGdTIZEvFJXQ/KrhdNkm2lnAFm2OIi6u7+CbwrDFoKhAA/UsX7nzlgnm/WC8YoY
	LXY3eEDAKDMaJEZYSk42GAo7r9t0kx/Li2DVEHJm1oqf5JZ4UMULbxYD24XAJWqNNshDOj
	7QJXOAwv5Mftg9AXGKmlq0zd6HOUHQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711467244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t65TdSxXFIxn9BLM0RNbweNcsBs25Tsa2iIZM848EpM=;
	b=cZAsHj4jo9izmPjkI7dgpCRG9bs2SeweJWTtflaoDNug5DSJT0da4cLMj0CBXGhTvK0qWP
	bHNapEx6KYA7QlDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711467244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t65TdSxXFIxn9BLM0RNbweNcsBs25Tsa2iIZM848EpM=;
	b=EDxrDSuzGdTIZEvFJXQ/KrhdNkm2lnAFm2OIi6u7+CbwrDFoKhAA/UsX7nzlgnm/WC8YoY
	LXY3eEDAKDMaJEZYSk42GAo7r9t0kx/Li2DVEHJm1oqf5JZ4UMULbxYD24XAJWqNNshDOj
	7QJXOAwv5Mftg9AXGKmlq0zd6HOUHQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711467244;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t65TdSxXFIxn9BLM0RNbweNcsBs25Tsa2iIZM848EpM=;
	b=cZAsHj4jo9izmPjkI7dgpCRG9bs2SeweJWTtflaoDNug5DSJT0da4cLMj0CBXGhTvK0qWP
	bHNapEx6KYA7QlDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F63913587;
	Tue, 26 Mar 2024 15:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fry3GuzqAmbmVgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 26 Mar 2024 15:34:04 +0000
Date: Tue, 26 Mar 2024 16:26:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chris Mason <clm@fb.com>, Qu Wenruo <wqu@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: delete unnecessary check in
 btrfs_qgroup_check_inherit()
Message-ID: <20240326152643.GT14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cb21ce67-e9d8-4844-8c70-eb42f6ac4aee@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb21ce67-e9d8-4844-8c70-eb42f6ac4aee@moroto.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.21
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.04%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EDxrDSuz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cZAsHj4j
X-Rspamd-Queue-Id: 865865D7A2

On Thu, Mar 07, 2024 at 05:53:47PM +0300, Dan Carpenter wrote:
> This check "if (inherit->num_qgroups > PAGE_SIZE)" is confusing and
> unnecessary.
> 
> The problem with the check is that static checkers flag it as a
> potential mixup of between units of bytes vs number of elements.
> Fortunately, the check can safely be deleted because the next check is
> correct and applies an even stricter limit:
> 
> 	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
> 		return -EINVAL;
> 
> The "inherit" struct ends in a variable array of __u64 and
> "inherit->num_qgroups" is the number of elements in the array.  At the
> start of the function we check that:
> 
> 	if (size < sizeof(*inherit) || size > PAGE_SIZE)
> 		return -EINVAL;
> 
> Thus, since we verify that the whole struct fits within one page, that
> means that the number of elements in the inherit->qgroups[] array must
> be less than PAGE_SIZE.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Added to for-next, thanks.

