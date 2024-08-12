Return-Path: <linux-btrfs+bounces-7118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245E94EBD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F143B1F220FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E1175D24;
	Mon, 12 Aug 2024 11:30:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9D3C0B
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462252; cv=none; b=FCr/80BsXJ3uSpA9RGN1BgX/RLeodWUG8YU8hyNbN85G26CHDY62E5vi174E6VjWwoSSvjdJtJDjDO8L+ALdsgw2rxu+77o+2PTHpfzFyRcrqCHnWEAQQmtlhu1A23mgcHMrdUd1U0uZ5tlzRGjkJWEAtdjBdEKQ7IkaSQCjtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462252; c=relaxed/simple;
	bh=xlAUwd3BDZtwBRfuE8IGeJPPUkMaPSX1VcbjPJjhQDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUq18xRLeyB/buCnWLwDphjgHNn1O1ugWsUYG35Ua25lM8kEWZIsNPqvFwGDNrTYa/uIMhHF49KYmlCNaqWLmWVsbkNiengdZlC9V5sjYeZ7Iv4MxNVM/cL4iuttRG7Ot9BfEY5/9xDAkMpge83f5yZnhExtS6+lmJQnl/sfJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7A042251F;
	Mon, 12 Aug 2024 11:30:48 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1DBB137BA;
	Mon, 12 Aug 2024 11:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z0YyK2jyuWYhVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 Aug 2024 11:30:48 +0000
Date: Mon, 12 Aug 2024 13:30:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Kota <nospam@kota.moe>
Subject: Re: [PATCH] btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type
Message-ID: <20240812113047.GF25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f8cf038608f5da4a94d95f435cc24065afb2c21f.1723419296.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cf038608f5da4a94d95f435cc24065afb2c21f.1723419296.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C7A042251F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 12, 2024 at 09:05:34AM +0930, Qu Wenruo wrote:
> [REPORT]
> There is a bug report that kernel is rejecting a mismatching inode mode
> and its dir item:
> 
> [ 1881.553937] BTRFS critical (device dm-0): inode mode mismatch with
> dir: inode mode=040700 btrfs type=2 dir type=0
> 
> [CAUSE]
> It looks like the inode mode is correct, while the dir item type
> 0 is BTRFS_FT_UNKNOWN, which should not be generated by btrfs at all.
> 
> This may be caused by a memory bit flip.

I haven't read the report but according to your analysis it most
certainly is a bitflip, there's no logic that would accidentally use the
0 value and not lead some error.

> [ENHACENMENT]
> Although tree-checker is not able to do any cross-leaf verification, for
> this particular case we can at least reject any dir type with
> BTRFS_FT_UNKNOWN.
> 
> So here we enhance the dir type check from [0, BTRFS_FT_MAX), to (0,
> BTRFS_FT_MAX).
> Although the existing corruption can not be fixed just by such enhanced
> checking, it should prevent the same 0x2->0x0 bitflip for dir type to
> reach disk in the future.
> 
> Reported-by: Kota <nospam@kota.moe>
> Link: https://lore.kernel.org/linux-btrfs/CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

