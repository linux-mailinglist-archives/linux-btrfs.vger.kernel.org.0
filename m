Return-Path: <linux-btrfs+bounces-20975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBB0GpoZdGnS2AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20975-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 02:00:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D77BD62
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 02:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CB5F3015842
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787338D;
	Sat, 24 Jan 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rkKyI0fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rV/x4Hug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rkKyI0fo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rV/x4Hug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56941DE4CD
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216407; cv=none; b=hFEwIpDt5MNXo89o3yz2yl5vsKaOzUllfscuoKenamLhKewSQUup3RHIw9WgHnBpRD4YiBjkfOEgKafcfqrXXd4dCKlkD+DLUpxjJ3XqkEFPaNF2i8ZtpZt8mGA8eBaB6Vx4JlOluFnBneA3CAloH4xyU9k4fHZR3e9YfemRtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216407; c=relaxed/simple;
	bh=VgTyhSgXfoXFefdGPbh8EFXrDTE/w5GyXbEKxN0vyF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfctFacjFhqXOWrcGXujpsZ2n7wazWmdXBvJGxCuYK1tVTc8LjPaLnEMEdMogGzFBgnbj9i7bpga9PdRooqCJoeu92R1XPZfwOfhlgGh4LeET50mLNqqc5++GFNkUWdh89GtiWPqcGc/PCLMjiGBahoo+WQzYCgdWmBMR3WtL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rkKyI0fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rV/x4Hug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rkKyI0fo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rV/x4Hug; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E63C65BCED;
	Sat, 24 Jan 2026 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769216403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7DAM8HAgg6vLWYJlOA5rGQqyMftgPKyPs+SlNmxwc=;
	b=rkKyI0fow/DsGDqT3Zt1ERpl/7+u4nplYsxevDr+Zcsyq3PZtJ3oBdOl6YhLI9HbF5798p
	WfMjTfnwJvpWuPRlyZBqHTx6xQ9kmXq23/l01YujC3VYe5x3aETvh8HijQbo5TsMzL89LC
	yUsfNS6SqY/ZZqQgN5xsl282DB3cwus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769216403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7DAM8HAgg6vLWYJlOA5rGQqyMftgPKyPs+SlNmxwc=;
	b=rV/x4HugyCYlx9094wcPU4iaPhktQMmEBkigByvN4Ds63cTRKR+pAT2S4gdPKJhfYwYyAj
	70YMDZPSSOgm0hBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769216403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7DAM8HAgg6vLWYJlOA5rGQqyMftgPKyPs+SlNmxwc=;
	b=rkKyI0fow/DsGDqT3Zt1ERpl/7+u4nplYsxevDr+Zcsyq3PZtJ3oBdOl6YhLI9HbF5798p
	WfMjTfnwJvpWuPRlyZBqHTx6xQ9kmXq23/l01YujC3VYe5x3aETvh8HijQbo5TsMzL89LC
	yUsfNS6SqY/ZZqQgN5xsl282DB3cwus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769216403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO7DAM8HAgg6vLWYJlOA5rGQqyMftgPKyPs+SlNmxwc=;
	b=rV/x4HugyCYlx9094wcPU4iaPhktQMmEBkigByvN4Ds63cTRKR+pAT2S4gdPKJhfYwYyAj
	70YMDZPSSOgm0hBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1D69139EE;
	Sat, 24 Jan 2026 01:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4HApL5MZdGkeDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 24 Jan 2026 01:00:03 +0000
Date: Sat, 24 Jan 2026 02:00:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: check: properly fix missing INODE_REF
 cases
Message-ID: <20260124010002.GZ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1765958753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765958753.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20975-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 9A3D77BD62
X-Rspamd-Action: no action

On Wed, Dec 17, 2025 at 06:38:12PM +1030, Qu Wenruo wrote:
> This is inspired by a recent corruption report that an INODE_REF key hits a
> bitflip and becomes UNKNOWN.8 key.
> 
> That cause missing INODE_REF, and unfortunately neither original nor
> lowmem mode can properly handle it.
> 
> For the original mode it just completely lacks the handling for such
> case, thus fallback to delete the good DIR_INDEX, making things
> worse.
> 
> For the lowmem mode, although it is trying to keep the good
> DIR_INDEX/DIR_ITEM, it doesn't handle index number search, thus using
> the default (-1) as index, causing incorrect new link to be added.
> 
> Fix both modes, and add a new test case for it.
> 
> Qu Wenruo (3):
>   btrfs-progs: check/original: add dedicated missing INODE_REF repair
>   btrfs-progs: check/lowmem: fix INODE_REF repair
>   btrfs-progs: fsck-tests: add a test case for repairing missing
>     INODE_REF

Added to devel, thanks.

