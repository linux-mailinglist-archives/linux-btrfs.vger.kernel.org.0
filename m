Return-Path: <linux-btrfs+bounces-250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E37F3255
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F205CB21C94
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178058101;
	Tue, 21 Nov 2023 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZVbhIsA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Lbn/sTl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC96123
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 07:26:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D41E1218FA;
	Tue, 21 Nov 2023 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700580402;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0byYdch5FVCPuyxD0G0j96Lq2BSAWZ//n2oPGxyo5k=;
	b=nZVbhIsAyV/jpZVcsvb1+ohUFb52qZGRj7Sxk0BuppLiZdQBJQyEtCnTpjoVhcRYYpzbaY
	aLfkVobnDGO4bt690ZjRf2Bj3i5k9LR8upcQVMd3oE9rCgp8zrKrIP+CjcKguOcdpVSgjZ
	bC2hQwV29F8xoDkr0//UHwv49LV23c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700580402;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0byYdch5FVCPuyxD0G0j96Lq2BSAWZ//n2oPGxyo5k=;
	b=3Lbn/sTlRBndZtIq1r8zi8ooDiYePGSXT4OnSHBTY6IsPD6h7HpLe3uzEsmYvSv03RKbay
	L7aNZEw94EzlgdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3BF8139FD;
	Tue, 21 Nov 2023 15:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 88gnJzLMXGVKdQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Tue, 21 Nov 2023 15:26:42 +0000
Date: Tue, 21 Nov 2023 16:19:33 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
Message-ID: <20231121151933.GR11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1700573313.git.fdmanana@suse.com>
 <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we abuse the extent_map structure for two purposes:
> 
> 1) To actually represent extents for inodes;
> 2) To represent chunk mappings.
> 
> This is odd and has several disadvantages:
> 
> 1) To create a chunk map, we need to do two memory allocations: one for
>    an extent_map structure and another one for a map_lookup structure, so
>    more potential for an allocation failure and more complicated code to
>    manage and link two structures;
> 
> 2) For a chunk map we actually only use 3 fields (24 bytes) of the
>    respective extent map structure: the 'start' field to have the logical
>    start address of the chunk, the 'len' field to have the chunk's size,
>    and the 'orig_block_len' field to contain the chunk's stripe size.
> 
>    Besides wasting a memory, it's also odd and not intuitive at all to
>    have the stripe size in a field named 'orig_block_len'.
> 
>    We are also using 'block_len' of the extent_map structure to contain
>    the chunk size, so we have 2 fields for the same value, 'len' and
>    'block_len', which is pointless;
> 
> 3) When an extent map is associated to a chunk mapping, we set the bit
>    EXTENT_FLAG_FS_MAPPING on its flags and then make its member named
>    'map_lookup' point to the associated map_lookup structure. This means
>    that for an extent map associated to an inode extent, we are not using
>    this 'map_lookup' pointer, so wasting 8 bytes (on a 64 bits platform);
> 
> 4) Extent maps associated to a chunk mapping are never merged or split so
>    it's pointless to use the existing extent map infrastructure.
> 
> So add a dedicated data structure named 'btrfs_chunk_map' to represent
> chunk mappings, this is basically the existing map_lookup structure with
> some extra fields:
> 
> 1) 'start' to contain the chunk logical address;
> 2) 'chunk_len' to contain the chunk's length;
> 3) 'stripe_size' for the stripe size;
> 4) 'rb_node' for insertion into a rb tree;
> 5) 'refs' for reference counting.
> 
> This way we do a single memory allocation for chunk mappings and we don't
> waste memory for them with unused/unnecessary fields from an extent_map.
> 
> We also save 8 bytes from the extent_map structure by removing the
> 'map_lookup' pointer, so the size of struct extent_map is reduced from
> 144 bytes down to 136 bytes, and we can now have 30 extents map per 4K
> page instead of 28.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c            | 165 ++++-----
>  fs/btrfs/block-group.h            |   6 +-
>  fs/btrfs/dev-replace.c            |  28 +-
>  fs/btrfs/disk-io.c                |   7 +-
>  fs/btrfs/extent_map.c             |  46 ---
>  fs/btrfs/extent_map.h             |   4 -
>  fs/btrfs/fs.h                     |   3 +-
>  fs/btrfs/inode.c                  |  25 +-
>  fs/btrfs/raid56.h                 |   2 +-
>  fs/btrfs/scrub.c                  |  39 +--
>  fs/btrfs/tests/btrfs-tests.c      |   3 +-
>  fs/btrfs/tests/btrfs-tests.h      |   1 +
>  fs/btrfs/tests/extent-map-tests.c |  40 +--
>  fs/btrfs/volumes.c                | 540 ++++++++++++++++++------------
>  fs/btrfs/volumes.h                |  45 ++-
>  fs/btrfs/zoned.c                  |  24 +-

I see a lot of errors when compiling zoned.c, there are still map_lookup
structures. Do you have the zoned mode config option enabled?

  CC [M]  fs/btrfs/zoned.o                                                                                
fs/btrfs/zoned.c:1293:40: warning: ‘struct map_lookup’ declared inside parameter list will not be visible outside of this definition or declaration
 1293 |                                 struct map_lookup *map)                                                                                                                                                      
      |                                        ^~~~~~~~~~              
fs/btrfs/zoned.c: In function ‘btrfs_load_zone_info’:                                                     
fs/btrfs/zoned.c:1296:42: error: invalid use of undefined type ‘struct map_lookup’                                                                                                                                   
 1296 |         struct btrfs_device *device = map->stripes[zone_idx].dev;                 
      |                                          ^~                                                       
fs/btrfs/zoned.c:1302:29: error: invalid use of undefined type ‘struct map_lookup’                        
 1302 |         info->physical = map->stripes[zone_idx].physical;                         
      |                             ^~                                                                                                                                                                               
fs/btrfs/zoned.c: At top level:                                                                           
fs/btrfs/zoned.c:1396:46: warning: ‘struct map_lookup’ declared inside parameter list will not be visible outside of this definition or declaration
 1396 |                                       struct map_lookup *map,                                                                                                                                                
      |                                              ^~~~~~~~~~                            
fs/btrfs/zoned.c: In function ‘btrfs_load_block_group_dup’:           
fs/btrfs/zoned.c:1402:17: error: invalid use of undefined type ‘struct map_lookup’
 1402 |         if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {       
      |                 ^~
...

