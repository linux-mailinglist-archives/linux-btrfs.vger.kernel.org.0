Return-Path: <linux-btrfs+bounces-5940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C066991551C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E466E1C2231B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B619F484;
	Mon, 24 Jun 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2Z9h3KF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2IOzamPs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDgfUhvv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y7RyrvJm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF1EA87
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248996; cv=none; b=XxyeQPv01WoBoCRkRLdiaKJmEiCkAtlDCQuAXjMMGzK2J4W7Hp671Ma6BszV2uSJWtOLVkCMnbvzjj2Bxo56DuhmpfGnE4d9fEGbvrMHj9a+GXLLl+LYi6yv7URRst6fmDRaZ8WFowy5CZ6XojYBm2N/ddDDuZ3lrsU4Y1X5pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248996; c=relaxed/simple;
	bh=No03t0YZsfolduvMo7HyCo8aNyLzSXlRRYC7kbju/lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoLpJB9MjEsSrUve53dlhRgwjFTGxShRRXLh1PEnFQQ0ZIScQu8wZivC5GgcGqRScFHaAsOao43GUA2fJtY4B6ioqNT68ZC2n4XlT2HhGYuqMGXMouFA0vDWSc8vRWdIpB8WbB7IvNi6LqVAooW/MsN4K+c/UOM5B+b+UmBKHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2Z9h3KF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2IOzamPs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDgfUhvv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y7RyrvJm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC4B61F7A4;
	Mon, 24 Jun 2024 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248993;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpczya+jGK7Sq8lDbWA60HRyxu4ii8TR1xOvxvhz9+0=;
	b=W2Z9h3KFnpEyKdeBUUPfkzWS5xZq5WUXPiYZ89SgFSKZqkkxaLqyzA8bLoN8i9EymfzV6g
	CHnRlpM1TbZNkIVb50tNwciJy5KvoPqCDFTvQC+bS53nDSIsAbmA0EAOL26ztyfrPdsYmL
	4OWIwQcXSDU1gkL0DzqZIHcCpS6rvFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248993;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpczya+jGK7Sq8lDbWA60HRyxu4ii8TR1xOvxvhz9+0=;
	b=2IOzamPsC4s9SUR4rSphewXHzPy9u0UExHBAfVrQU9WBcG8Hkgq65DJO3LyVr9iiv8WRe7
	xdxzj+LHzNVGJyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248992;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpczya+jGK7Sq8lDbWA60HRyxu4ii8TR1xOvxvhz9+0=;
	b=yDgfUhvvDHd/9EeBWQp6gx7qSG4WDNLdVuLm9RN+agtKb9WhwVRSYYDtEKJrwS/H38tQoV
	Ck3RrFAph1uWUrETRqYnsOA0d5D12rp3dBA5O8GpX2vUrjapmDsDPHEY6gI0zvpc/aTf7s
	+XtXFUK98cas9q+YHK8b8/IoCe1fk2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248992;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpczya+jGK7Sq8lDbWA60HRyxu4ii8TR1xOvxvhz9+0=;
	b=Y7RyrvJmTf6xjtDN1j2yienT0dHiXTBU+qWTEYYx8hqi0JRIhJ/SRTyBsqGbHWy18w5FDe
	D7m0KSt/EL3N/zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C78BA13AA4;
	Mon, 24 Jun 2024 17:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TDGNMGCoeWYOOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 17:09:52 +0000
Date: Mon, 24 Jun 2024 19:09:51 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: remove raid stripe encoding
Message-ID: <20240624170951.GT25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240620075455.20074-1-jth@kernel.org>
 <20240624170715.GS25756@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624170715.GS25756@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spam-Level: 

On Mon, Jun 24, 2024 at 07:07:15PM +0200, David Sterba wrote:
> On Thu, Jun 20, 2024 at 09:54:55AM +0200, Johannes Thumshirn wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Remove the not needed encoding and reserved fields in struct
> > raid_stripe_extent.
> > 
> > This saves 8 bytes per stripe extent.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  kernel-shared/accessors.h       |  3 ---
> >  kernel-shared/print-tree.c      | 33 +--------------------------------
> >  kernel-shared/uapi/btrfs_tree.h | 14 +-------------
> >  3 files changed, 2 insertions(+), 48 deletions(-)
> 
> This fails to compiler because the tree-checker.c code still references
> the removed functions:
> 
> kernel-shared/tree-checker.c: In function ‘check_raid_stripe_extent’:
> kernel-shared/tree-checker.c:1740:17: warning: implicit declaration of function ‘btrfs_stripe_extent_encoding’; did you mean ‘btrfs_file_extent_end’? [-Wimplicit-function-declaration]
>  1740 |         switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixed in devel.

