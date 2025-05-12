Return-Path: <linux-btrfs+bounces-13947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5BAB4567
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73928868410
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C3298CCE;
	Mon, 12 May 2025 20:20:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4F254B10
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747081258; cv=none; b=dqOTPTur5H7c71HiB+XYsP9KzXwJj8N2MqwYv8F0r1Nn4FrtiTOpKBniepPpPBynbhd4gNBs3JlJCT4BavbwnBZKJOoOfKO5XLPTVqsfF06WThMZdBs0zxCnCt5Atsl8OJvnm/8XYSKh3dODnXiq1Gy334DA6pXAim3zJuiiuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747081258; c=relaxed/simple;
	bh=i66jy7ZCV17NzaeBNibM967xqN0nswGBEagfC/4hDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EutjRCPwGgOUxPXGaeujycYPsOtCtPCaFg5wC5ha+QUMF+Q/ZjASjJR+D1i+SyYbBl0y+zHps371x99CUqTF1dcMxqQIQ1Pkw82+2lhB+Lx+5GRBRYZN9+Yz4HgwT/0w8XdsXvOXPpp3K3c7f7HeszWkwptKSIXpTTTHj/i/h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82B8821184;
	Mon, 12 May 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 660181397F;
	Mon, 12 May 2025 20:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5dKmGCdYImg8JQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 20:20:55 +0000
Date: Mon, 12 May 2025 22:20:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
Message-ID: <20250512202054.GX9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250512172321.3004779-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512172321.3004779-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 82B8821184
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> So far we are deriving the buffer tree index using the sector size. But each
> extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> 
> For example the typical and quite common configuration uses sector size of 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using up to
> the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> slots are wasted as never used.
> 
> We can score significant memory savings on the required tree nodes by indexing
> the tree using the node size instead. As a result far less slots are wasted
> and the tree can now use up to all 100% of it's slots this way.

This looks interesting. Is there a way to get xarray stats? I don't see
anything in the public API, e.g. depth, fanout, slack per level. For
debugging purposes we can put it to sysfs or as syslog message,
eventually as non-debugging output to commit_stats.

