Return-Path: <linux-btrfs+bounces-19142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A722C6E695
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 049DF2DD8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B240351FDE;
	Wed, 19 Nov 2025 12:16:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D81E2307
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554615; cv=none; b=BUc6DaBkH4bleN3wU8m5Kktghxz4k+dFE0OSB0+NWM3Y0nomMzoj/tvvbNKeToljRg6I3zuO5IPUwTnrpHDJl+Eb8tCTzAu+XrRVdTDQ7JJnY3cbAXMN2j3Gm61hXUzQCFkjyHcetKT8/2oNN/NxwtMY9Wu6SBWY0/TY0K8T3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554615; c=relaxed/simple;
	bh=AO+9l1AlaexgLTVb+lmn2OO97YReHnCxT8p3+Jylrvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbf75QP6RDEDRru8rYAmnAPuVpGHRwUkklzqd7T7BpCqj8qJJuZj67gDAQdYzEIv6vK7Fq1rTmv67+4YoNjrwSGoCgKA2NxBUXMS5vAcLPjkfFWgQYX0Nj3lZm4QmKSG59acAQrz7cFNFoDLsHa4xgBVSdn1NrzARWY8b7O5+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A60A720413;
	Wed, 19 Nov 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B83B3EA61;
	Wed, 19 Nov 2025 12:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bBLmIS61HWkxcwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 12:16:46 +0000
Date: Wed, 19 Nov 2025 13:16:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Message-ID: <20251119121645.GF13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251118160845.3006733-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160845.3006733-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A60A720413
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Nov 18, 2025 at 05:08:37PM +0100, Daniel Vacek wrote:
> This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
> native encryption support to btrfs.
> 
> It will come in more parts. The first part this time is splitting the simple
> and isolated stuff out first to reduce the size of the final patchset.
> 
> Changes:
>  * v8 - Clean my mistakenly added Signed-off-by:
>  * v7 - Drop the checksum patch for now. It will make more sense later.
>       - Drop the btrfs/330 fix. It seems no longer needed after the years.
>  * v6 vs v5 [1] is mostly rebase to the latest for-next and cleaning up the
>    conflicts.
> 
> The remaining part needs further cleanup and a bit of redesign and it will
> follow later.

Thanks, I've added it to for-next with the following note:

    Note: The patch was taken from v5 of fscrypt patchset
    (https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
    which was handled over time by various people: Omar
    Sandoval, Sweet Tea Dorminy, Josef Bacik.

And added your signed-off as you're submitting it.

