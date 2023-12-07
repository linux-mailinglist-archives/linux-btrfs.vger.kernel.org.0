Return-Path: <linux-btrfs+bounces-751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF5808A03
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 15:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4218C1C20899
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235641A84;
	Thu,  7 Dec 2023 14:16:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00410E7
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 06:16:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22F9B21D72;
	Thu,  7 Dec 2023 14:16:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C5CF5139E3;
	Thu,  7 Dec 2023 14:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lhFRLaHTcWUcIwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 07 Dec 2023 14:16:01 +0000
Date: Thu, 7 Dec 2023 15:09:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Disseldorp <ddiss@suse.com>
Subject: Re: [PATCH] btrfs: get rid of memparse() for sysfs operations
Message-ID: <20231207140906.GY2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <69524a828a08d8d88face116ea7563fd34275815.1701920169.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69524a828a08d8d88face116ea7563fd34275815.1701920169.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 22F9B21D72

On Thu, Dec 07, 2023 at 02:06:11PM +1030, Qu Wenruo wrote:
> [CONFUSION]
> Btrfs is using memparse() for the following sysfs interfaces:
> 
> - /sys/fs/btrfs/<uuid>/devinfo/<devid>/scrub_speed_max
> - /sys/fs/btrfs/<uuid>/allocation/<type>/chunk_size
> 
> Thus we can echo some seemingly valid values into them (using
> scrub_speed_max as an example):
> 
>  # echo 25e > scrub_speed_max
>  # cat scrub_speed_max
>  10376293541461622784
> 
> This can cause several confusion:
> 
> - The end user may just want to type "0x25e"
> - Even if it's treated as decimal "25" and E (exabyte), the result is
>   not correct
>   25 exabyte should be 28147497671065600, as 25 with 2 ** 10 would lead
>   to something ends with "00" in decimal (25 * 4 = 100).
> 
> [CAUSE]
> Above "25e" is valid because memparse() handles the extra suffix and do
> proper base conversion.
> 
> "25e" has no "0x" or "0" prefix, thus it's treated as decimal, and only
> "25" is the valid part. Then it goes with number detection, but the
> final "e" is treated as invalid since the base is 10.
> 
> Then we do the extra left shift based on the suffix.
> 
> There are several problem in memparse itself:
> 
> - No overflow check
>   The usage of simple_strtoull() lacks the overflow check, thus it's
>   already discouraged to use.
> 
> - The suffix "E" (exabyte) can be easily confused with 0xe.
> 
> [FIX]
> For btrfs sysfs interface, we don't accept extra suffix, except the
> mentioned two entries.
> 
> Furthermore since we don't do pretty size output, and considering the
> sysfs interfaces are mostly for script or other tools, there is no need
> to accept extra suffix either.
> 
> So here we can just replace the memparse() to kstrou64() instead, and
> reject the above "25e" example.

No, please read the reasoning why we want the suffixes,
https://lore.kernel.org/linux-btrfs/20231207135522.GX2751@twin.jikos.cz/

That memparse accepts 0x is fine but I'd say highly uncommon to be ever
seen as input.

If memparse is not able to correctly parse exabytes then it's not our
bug, as the comment says

"This function has caveats. Please use kstrtoull instead."
https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L93

