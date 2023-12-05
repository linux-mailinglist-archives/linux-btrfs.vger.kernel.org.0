Return-Path: <linux-btrfs+bounces-646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B87805975
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB561F21727
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB163DCC;
	Tue,  5 Dec 2023 16:04:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C97C0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 08:04:48 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 427541FBA2;
	Tue,  5 Dec 2023 16:04:46 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1854A13924;
	Tue,  5 Dec 2023 16:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pVQOBB5Kb2W7JwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 16:04:46 +0000
Date: Tue, 5 Dec 2023 16:57:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix mismatching parameter names for
 btrfs_get_extent()
Message-ID: <20231205155756.GI2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4a8d8601602d7ceef622286c259bc4c11d7e3585.1701762681.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8d8601602d7ceef622286c259bc4c11d7e3585.1701762681.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 427541FBA2

On Tue, Dec 05, 2023 at 06:21:29PM +1030, Qu Wenruo wrote:
> The definition for btrfs_get_extent() is using "u64 end" as the last
> parameter, but in implementation we go "u64 len", and all call sites
> follows the implementation.
> 
> This can be very confusing during development, as most developers
> including me, would just use the snippet returned by LSP (clangd in my
> case), which would only check the definition.

It's possible that there are more mismatches, this is clearly a job for
some tool.

> Unfortunately this mismatch is introduced from the very beginning of
> btrfs.
> 
> Fix it to prevent further confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

