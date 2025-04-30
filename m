Return-Path: <linux-btrfs+bounces-13534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4446AA44B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB0B4E2506
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051F214810;
	Wed, 30 Apr 2025 08:03:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF2213E83
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000203; cv=none; b=K4Ks5sinvyKp8ufsKy5mfFilbb2DnSOJOoLMIX9+FK3nmDt5RHvpNe2i3Aadm6qvGnmxGhbRG7CAaz2FIUVniL9exjlGTA69vegOaClQ/NVDbA/fQrdXXoc4ZFEBgwkHKvSfc11Y0zeb5ZZxUpNKqWj1WvcDcx3K19xcOGHXb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000203; c=relaxed/simple;
	bh=CXsTHkWQEAL72OBe7l8/qFCxgil1OjuIPzgRVi9MxnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKKvkc08GTEEHPBR6Zicv1oA0IfxM2x+F6JlEsgND6NSQHBMDjymb4aTQRcEjSPxUWrzwBxx7tSKxBltC0dHmPy17TGDmcQ+JJUvpC7kMozb79VDdrDO6DMm1K0N/NKvtJMfOIGU8UUbBlutvKtY4l4IrF8TQMN/vGdk6qxxxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1826C1F7BD;
	Wed, 30 Apr 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0B47139E7;
	Wed, 30 Apr 2025 08:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nxaLOkbZEWjfCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 08:03:18 +0000
Date: Wed, 30 Apr 2025 10:03:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <20250430080317.GF9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250429151800.649010-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429151800.649010-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 1826C1F7BD
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, Apr 29, 2025 at 05:17:57PM +0200, Daniel Vacek wrote:
> Even super block nowadays uses nodesize for eb->len. This is since commits
> 
> 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> 
> With these the eb->len is not really useful anymore. Let's use the nodesize
> directly where applicable.

I've had this patch in my local branch for some years from the times we
were optimizing extent buffer size. The size on release config is 240
bytes. The goal was to get it under 256 and keep it aligned.

Removing eb->len does not change the structure size and leaves a hole

 struct extent_buffer {
        u64                        start;                /*     0     8 */
-       u32                        len;                  /*     8     4 */
-       u32                        folio_size;           /*    12     4 */
+       u32                        folio_size;           /*     8     4 */
+
+       /* XXX 4 bytes hole, try to pack */
+
        long unsigned int          bflags;               /*    16     8 */
        struct btrfs_fs_info *     fs_info;              /*    24     8 */
        void *                     addr;                 /*    32     8 */
@@ -5554,8 +5556,8 @@ struct extent_buffer {
        struct rw_semaphore        lock;                 /*    72    40 */
        struct folio *             folios[16];           /*   112   128 */
 
-       /* size: 240, cachelines: 4, members: 14 */
-       /* sum members: 238, holes: 1, sum holes: 2 */
+       /* size: 240, cachelines: 4, members: 13 */
+       /* sum members: 234, holes: 2, sum holes: 6 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 2 */
        /* last cacheline: 48 bytes */
 } __attribute__((__aligned__(8)));

The benefit of duplicating the length in each eb is that it's in the
same cacheline as the other members that are used for offset
calculations or bit manipulations.

Going to the fs_info->nodesize may or may not hit a cache, also because
it needs to do 2 pointer dereferences, so from that perspective I think
it's making it worse.

I don't think we need to do the optimization right now, but maybe in the
future if there's a need to add something to eb. Still we can use the
remaining 16 bytes up to 256 without making things worse.

