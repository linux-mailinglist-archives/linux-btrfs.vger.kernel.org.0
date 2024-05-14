Return-Path: <linux-btrfs+bounces-4976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB28C59BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68E51C215E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7321802B6;
	Tue, 14 May 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQb8Bic9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0VMv9F9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQb8Bic9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O0VMv9F9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56691802A3
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704193; cv=none; b=Xwr03FQQlhetdQnGTd0I1Mws/vPjZyesOBa7ZINTkfht+G8R+6sw246B4lxe5LfRoJ8p/qnuhAv2jlYJutrfgAGTn/As8MxD9F2BTdwJ6bkR/G2qgmSb4S3b8Q345zBpHtj+0EbDTetJfJgTFVyJFPtHv05Wisl6KCBqTwzRNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704193; c=relaxed/simple;
	bh=ssnAQy2P2QakByZgZF+zpEGBESbkvsjk8NKwzn1fyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMpPnODLgiGHyAZenal8rxNw8H2Gh1iU297B6mXMjiFOInWZ41n+2l4BGNXM97eDbeVBlcpzt63AwpcczSIykTfs0Z0OR0RfbzyzhEx58ur7rKxcKY/bAporFv0I6hK2t67KdbNhUU5WWINq0yJE5U6Fg7fCapayJBWj0CEJK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQb8Bic9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0VMv9F9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQb8Bic9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O0VMv9F9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02A6C6033A;
	Tue, 14 May 2024 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715704190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EhDYNzHq2gupwuyzmJQsByITWyNmIGXDjTjiB3b1H8=;
	b=WQb8Bic9ejb+SfN2iAuuTxNX/2xZN8JVjRuAEb3MksMbPo78PWiPGc+te7JSv7yn+wTPS5
	AfL0rdBsGQjvnvaLbizvaMO+h//no7QMZbvpDVZ9rY3ZumgpaQCBGD1eSJngbHNo33gyvg
	RT/3QJgIUyltMjoFx5wMahLjwDGRrso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715704190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EhDYNzHq2gupwuyzmJQsByITWyNmIGXDjTjiB3b1H8=;
	b=O0VMv9F9SxAvt6s28hpr5klLl4qCxnqEO2wP+c+DFEIjlEoS4IfJHgPa+u1KFrZx5fShrW
	h+rWtvv+4FWvgDAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715704190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EhDYNzHq2gupwuyzmJQsByITWyNmIGXDjTjiB3b1H8=;
	b=WQb8Bic9ejb+SfN2iAuuTxNX/2xZN8JVjRuAEb3MksMbPo78PWiPGc+te7JSv7yn+wTPS5
	AfL0rdBsGQjvnvaLbizvaMO+h//no7QMZbvpDVZ9rY3ZumgpaQCBGD1eSJngbHNo33gyvg
	RT/3QJgIUyltMjoFx5wMahLjwDGRrso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715704190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3EhDYNzHq2gupwuyzmJQsByITWyNmIGXDjTjiB3b1H8=;
	b=O0VMv9F9SxAvt6s28hpr5klLl4qCxnqEO2wP+c+DFEIjlEoS4IfJHgPa+u1KFrZx5fShrW
	h+rWtvv+4FWvgDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E004B1372E;
	Tue, 14 May 2024 16:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SVeGNn2RQ2YuXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 16:29:49 +0000
Date: Tue, 14 May 2024 18:22:32 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix end of tree detection when searching for data
 extent ref
Message-ID: <20240514162232.GJ4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d025098ef2c013545df5f37ef85128805a104571.1715699835.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d025098ef2c013545df5f37ef85128805a104571.1715699835.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.68 / 50.00];
	BAYES_HAM(-2.68)[98.61%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email]
X-Spam-Score: -3.68
X-Spam-Flag: NO

On Tue, May 14, 2024 at 04:26:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At lookup_extent_data_ref() we are incorrectly checking if we are at the
> last slot of the last leaf in the extent tree. We are returning -ENOENT
> if btrfs_next_leaf() returns a value greater than 1, but btrfs_next_leaf()
> never returns anything greater than 1:
> 
> 1) It returns < 0 on error;
> 
> 2) 0 if there is a next leaf (or a new item was added to the end of the
>    current leaf after releasing the path);
> 
> 3) 1 if there are no more leaves (and no new items were added to the last
>    leaf after releasing the path).
> 
> So fix this by checking if the return value is greater than zero instead
> of being greater than one.
> 
> Fixes: 1618aa3c2e01 ("btrfs: simplify return variables in lookup_extent_data_ref()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

