Return-Path: <linux-btrfs+bounces-15992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02ECB20D12
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 17:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE533B0BD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9E2DEA89;
	Mon, 11 Aug 2025 15:05:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B41E5B73
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924727; cv=none; b=o7CiCz447aIXUrLzv16UPQIYu5SPvCiDdNqYR7zkeOjZNK+UndjfvcfJk7zQHOdZubFjFw6RGSw+t24ZB/0Wo3suWzXVHCS9sHMNixf9gBl+2nmiZgjKFZS/hO6kkpYquxyQxznerhJKSX62hUTRfZaExv7Sy75j/6EQ4S1lTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924727; c=relaxed/simple;
	bh=MI+E8SrEuuYGRN77u2xLt2jZUmrB9KVRDwAc3ec3bGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7X6pATW+eDlf6WBk1UI3ksA9PvkmooPvKUftAgiMGyCR814StCmueESSxr+qmJf0IRubhdHPi2Q+zqIxTVbMz4XnawhwVJXFOXExDdV2UtmZeMJhPGiYqLWGvgYisX/FUZVk/KkSTWuZ9ljd3OuQJuLvY6yoZz62HtZ2PDJsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B73BD1F443;
	Mon, 11 Aug 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7E9C13A7E;
	Mon, 11 Aug 2025 15:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ecuBKLMGmmhZYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Aug 2025 15:05:23 +0000
Date: Mon, 11 Aug 2025 17:05:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use blocksize to check if compression is making
 things larger
Message-ID: <20250811150522.GY6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B73BD1F443
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

On Mon, Aug 11, 2025 at 09:43:42AM +0930, Qu Wenruo wrote:
> [BEHAVIOR DIFFERENCE BETWEEN COMPRESSION ALGOS]
> Currently LZO compression algorithm will check if we're making the
> compressed data larger after compressing more than 2 blocks.
> 
> But zlib and zstd do the same checks after compressing more than 8192
> bytes.
> 
> This is not a big deal, but since we're already supporting larger block
> size (e.g. 64K block size if page size is also 64K), this check is not
> suitable for all block sizes.
> 
> For example, if our page and block size are both 16KiB, and after the
> first block compressed using zlib, the resulted compressed data is
> slightly  larger than 16KiB, we will immediately abort the compression.
> 
> This makes zstd and zlib compression algorithms to behave slightly
> different from LZO, which only aborts after compressing two blocks.
> 
> [ENHANCEMENT]
> To unify the behavior, only abort the compression after compressing at
> least two blocks.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I think it's ok and makes sense to compare to some number of units and
not an arbitrary number, which likely is 2 * page size.

