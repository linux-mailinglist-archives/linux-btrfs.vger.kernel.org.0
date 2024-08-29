Return-Path: <linux-btrfs+bounces-7679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEA96533A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1729E1C21361
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6018E341;
	Thu, 29 Aug 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3ch8Dih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u2YBKFbL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3ch8Dih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u2YBKFbL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28A18A6D2
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972527; cv=none; b=AUQyq80ukhlfA9aZS/EMMV0TCjoXEyqri61WpCL8TbaU2qO5j1LRfMRwLo++9kFkPvlmeF7Y4yHqnIVXUmDjIK0dZf0JlQlmH2W0pHSUpauQtt4hMwsgLw9j21uhtWuGVNqX+DSHmNrZiKdonV1PSs/z5hBIvGjq9e/ZFY3ga5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972527; c=relaxed/simple;
	bh=2dfnu8YVvRBLw3XWZHZ3TFxT9RTbelc0fUlklCzCmpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdxvrOEqQPly4WRwjRr5NTFU0v/r0jvT/apwylYrJaSyb6ivnXdK60t2AG1+whcqidqn5U2QmoKF0h3HFIUmRG83tSASd9/z1NTv2v/RUafyW2unXqFelDpMOSgQTejB1JkQI+78YOGbczD7AyntBJZJdSmfbcHb9JJbyGvQ+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3ch8Dih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u2YBKFbL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3ch8Dih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u2YBKFbL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4F8B219E6;
	Thu, 29 Aug 2024 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724972523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnIi8KjhPbkkg1pQCCkxic7Qm5VOXRCm67JNi2vjOQ=;
	b=W3ch8Dihg9mdk9L2ca/1U0/tI0zdeNpF7v6fVZwfiXqvg0CkjNr+ho00BGl9pMfu5oaWOw
	Z68M52U1Q2RyHTKOm0FysGxrBrape51wXdzmxjXCndLMhqSzxv8H736DwIQ7rBqgoRuMoQ
	1x1r6VAjKC3g9tM/T1aEvg38CV+c0ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724972523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnIi8KjhPbkkg1pQCCkxic7Qm5VOXRCm67JNi2vjOQ=;
	b=u2YBKFbLph8a32Lru00OqmUegL3sTf8xuQTKAG3R8B7N/GQC1UjoI5FxncC9MLHc4KwB6O
	jeguciO97jJyJaDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724972523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnIi8KjhPbkkg1pQCCkxic7Qm5VOXRCm67JNi2vjOQ=;
	b=W3ch8Dihg9mdk9L2ca/1U0/tI0zdeNpF7v6fVZwfiXqvg0CkjNr+ho00BGl9pMfu5oaWOw
	Z68M52U1Q2RyHTKOm0FysGxrBrape51wXdzmxjXCndLMhqSzxv8H736DwIQ7rBqgoRuMoQ
	1x1r6VAjKC3g9tM/T1aEvg38CV+c0ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724972523;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcnIi8KjhPbkkg1pQCCkxic7Qm5VOXRCm67JNi2vjOQ=;
	b=u2YBKFbLph8a32Lru00OqmUegL3sTf8xuQTKAG3R8B7N/GQC1UjoI5FxncC9MLHc4KwB6O
	jeguciO97jJyJaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68198139B0;
	Thu, 29 Aug 2024 23:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +iY6GOv90GZ/YAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 23:02:03 +0000
Date: Fri, 30 Aug 2024 01:02:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Miroslav =?utf-8?B?xaB1bGM=?= <miroslav.sulc@fordfrog.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: recovering btrfs filesystem from synology raid5
Message-ID: <20240829230202.GS25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0eb0e2f033f40a0b14d652a6b7c220e4@fordfrog.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb0e2f033f40a0b14d652a6b7c220e4@fordfrog.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.99
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 26, 2024 at 12:56:39PM +0200, Miroslav Šulc wrote:
> hello,
> 
> i have here a broken btrfs filesystem that was on a synology nas with 
> raid5 (mdadm + lvm)

AFAIK synology has some patches that connect btrfs and MD raid5 so it
fixes the problems that btrfs-raid5 has. But the patches are not
upstream and I don't know how it works.

> where one disk started to be broken and another was 
> removed from the raid roughly two months ago (but the number of events 
> on that disk isn't that much lower). more details about the raid can be 
> seen here: 
> https://lore.kernel.org/linux-raid/d6e87810cbfe40f3be74dfa6b0acb48e@fordfrog.com/T/

This looks like the problems are on the MD level with the device
removed, added back and interrupted synchronization. The analysis points
out there are some old data or stats. More below.

> i was able to assemble the raid5 from 4 disks (3 with up-to-date data 
> and one with older data) to the extent that i can use lvm to see the 
> logical volume and btrfs filesystem on it, though the filesystem reports 
> to be broken.
> 
> # cat /proc/mdstat
> Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]
> md127 : active raid5 dm-19[4] dm-16[3] dm-13[1] dm-10[0]
>        31236781824 blocks super 1.2 level 5, 64k chunk, algorithm 2 [5/4] 
> [UU_UU]
>        bitmap: 0/59 pages [0KB], 65536KB chunk
> 
> unused devices: <none>
> 
> # btrfs check /dev/vg1000/lv
> Opening filesystem to check...
> parent transid verify failed on 4330339713024 wanted 2221844 found 
> 2221848

This error typically means old data were read, the difference is 4
transactions.

> parent transid verify failed on 4330321559552 wanted 2221843 found 
> 1957353
> parent transid verify failed on 4330321559552 wanted 2221843 found 
> 1957359
> parent transid verify failed on 4330321559552 wanted 2221843 found 
> 1957359
> Ignoring transid failure
> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
> have 16079 expect 16105

This kind of error does not apper often, the 'transid verify failed'
from above usually has a consistent b-tree node/leaf but from a
different transaction "epoch". A wrong item end means there's a mismatch
in the stored and calculated data. Reasons for that can vary, a software
bug can never be ruled out (but we'd see more reports) or the recovery
of the b-tree node/leaf was partial and the item descriptor (the stored
part) is older than what's actually found in the leaf (the calculated
part).

> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
> EXTENT_TREE
> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 

UNKNOWN.164 must be some synology NAS specific thing

> itemsize 179
>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 

Same.

> itemsize 39
>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
> itemsize 44
>                  refs 14078082519432455026 gen 151715012486066369 flags 

The numbers 14078082519432455026 and 151715012486066369 are likely a
complete garbage, either a block that was randomly overwritten or a
random block read and interpreted.

> |FULL_BACKREF
>                  tree block skinny level -1444450301

Levels are 0..7

> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
> leaf data limit 16283
> ERROR: skip remaining slots
> parent transid verify failed on 4330321559552 wanted 2221843 found 
> 1957359
> Ignoring transid failure
> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
> have 16079 expect 16105
> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
> EXTENT_TREE
> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 
> itemsize 178
>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 
> itemsize 39
>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
> itemsize 44
>                  refs 14078082519432455026 gen 151715012486066369 flags 
> |FULL_BACKREF
>                  tree block skinny level -1444450301
> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
> leaf data limit 16283
> ERROR: skip remaining slots
> corrupt leaf: root=2 block=4330321559552 slot=1, unexpected item end, 
> have 16079 expect 16105
> leaf 4330321559552 items 87 free space 11792 generation 1957359 owner 
> EXTENT_TREE
> leaf 4330321559552 flags 0x1(WRITTEN) backref revision 1
> fs uuid 7138daf1-5d16-4053-b559-0eb7da7d0a23
> chunk uuid 55d47533-7e1e-4dda-bc51-f5ad0006fc9f
>          item 0 key (142836266048 UNKNOWN.164 1478857) itemoff 16105 
> itemsize 178
>          item 1 key (142837019712 UNKNOWN.189 818382621) itemoff 16040 
> itemsize 39
>          item 2 key (142836675648 METADATA_ITEM 2850516995) itemoff 16218 
> itemsize 44
>                  refs 14078082519432455026 gen 151715012486066369 flags 
> |FULL_BACKREF
>                  tree block skinny level -1444450301
> ERROR: leaf 4330321559552 slot 3 pointer invalid, offset 16369 size 33 
> leaf data limit 16283
> ERROR: skip remaining slots
> ERROR: failed to read block groups: Operation not permitted
> ERROR: cannot open file system
> 
> i have the disks mapped in read-only mode with overlay set up over them 
> so that i can freely experiment with the filesystem. but so far i was 
> not able to get the filesystem to a state where i could read files from 
> it, even with btrfs restore.

The recovery options for btrfs are to try to read partially consistent
data from past generations, this is what 'btrfs restore' does, but it
seems that the block data are mixed and even inconsistent within
somethign that btrfs would consider a unit.

> there are some data on the filesystem that are crucial for the client so 
> my goal is to be able to recover at least those. so, i'd like to ask 
> whether there is any chance to resolve these issues shown above to be 
> able to at least list the files from the filesystem and recover at least 
> a selection of them.

You can try 'btrfs restore' if you haven't done that yet but this may
also require to write some custom code to work around the specific
issues you find. This is also from a custom kernel from synology with
apparent modifications that the upstream linux kernel does not have so
we can't help with that beyond the common points.

