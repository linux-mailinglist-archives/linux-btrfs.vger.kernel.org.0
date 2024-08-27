Return-Path: <linux-btrfs+bounces-7535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF395FDF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 02:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D91C21BD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E323CE;
	Tue, 27 Aug 2024 00:26:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB06FDC
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718377; cv=none; b=c2wKZODWSK6jsm6HefxMz3JmwhJPt3wwn7vaVlJb0xgF6d9g0gYWXHn7lkbskxiM3dPV7/aZGQ5j4wp11K6zEdAT96zwxOPOlbgRdEWExk6xPmJwk57jVD5d3CtymOmMxaP5IyUa6r2wJ08p4NqsNRgl9JicEKQ929WNtWe+DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718377; c=relaxed/simple;
	bh=Iphi4F06gIh3sG70NiNwrUBEHcbhxwDYIk4pkL3Bhvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imVOu8nL8pjN3eD0i2LavBCJoQoBnqGAvXAlnEJsZFqB8Zei8FvLKcXIWMC2AJJodeLEZgua3f/W4D9D2nwL/umoR370x/aziZtdM4MLc/+ID8pyZM4UAiGNTAW42bVrcOpm8EIFkYqCL/otsKGbnAr+BKYpjqnRAOM8Yog6otQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77FB321AF0;
	Tue, 27 Aug 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6009513724;
	Tue, 27 Aug 2024 00:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mML2FiUdzWbHCQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Aug 2024 00:26:13 +0000
Date: Tue, 27 Aug 2024 02:26:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: remove btrfs_fs_info::subpage_info member
Message-ID: <20240827002608.GU25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8512554a857739211a80e7f52cc8269c8a9fb791.1724654447.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8512554a857739211a80e7f52cc8269c8a9fb791.1724654447.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 77FB321AF0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Mon, Aug 26, 2024 at 04:11:11PM +0930, Qu Wenruo wrote:
> The member btrfs_fs_info::subpage_info is to store the cached bitmap
> start position inside the merged bitmap.
> 
> However in reality there is only one thing depending on the sectorsize,
> bitmap_nr_bits, which records the number of sectors that fit inside a
> page.
> 
> The sequence of sub-bitmaps have fixed order, thus it's just a quick
> multiple to calculate the start position of each sub-bitmaps.
> 
> This will slightly increase the text section size due to the extra
> needed calculation.

I don't see much difference in the generated assembly, the overall size
of module decreased by 216 on my reference release config, which is
probably because of removed functions initializing the subpage_info
structure.

Otherwise it's almost the same asm code, looks like compiler recognizes
it's multiplication by a small constant so there are tricks using LEA
and ADD instructions.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

