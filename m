Return-Path: <linux-btrfs+bounces-12386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0FBA6789B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 17:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9EF3B6B04
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E2210185;
	Tue, 18 Mar 2025 16:00:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408B20E6EC
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313622; cv=none; b=UPRB8wajcoQRQM6w4uVBxez0lxc1BHqPgeQuqbQjQOxyczt3qHs9PHOokSqqBwI1ylFUZjexI9MVNzhLmPZSoEpjn8/lc8xyivIZPN0cii+9LGR+SesG5BhVsEud49fbjkLsGJH72p9qhQyYnC9sJmPJe9jZl/iebSlr3UHkW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313622; c=relaxed/simple;
	bh=qfMZojHGQ7hMeNGHUlk4JiGvsujlrj9fFIjKj/xLexQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZYjw1fBMa/YwgbJ8KSyYp9Lv6QTARJ1yY8EnonOl4nDHOSDXmE9Zh+qof/XRMvNpsdYTQHcnzxfxAIq8Eyssy/lATkiLpjoNqtXiNLYYmeDDzI84iOw3MIsV1kovib5REi5i6W7XQu0pmyaerHWI4y/aAO5V2yQ8mx8LlUfabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBD5F21A68;
	Tue, 18 Mar 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77721379A;
	Tue, 18 Mar 2025 16:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wmeTLJKY2WfTLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 16:00:18 +0000
Date: Tue, 18 Mar 2025 17:00:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Message-ID: <20250318160017.GF32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250318095440.436685-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318095440.436685-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CBD5F21A68
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> This flag is set after inserting the eb to the buffer tree and cleared on
> it's removal. But it does not bring any added value. Just kill it for good.

I na similar way the flag EXTENT_BUFFER_READ_ERR is unused (was removed
in eb/io rework in 046b562b20a5cf ("btrfs: use a separate end_io handler
for read_extent_buffer").

