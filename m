Return-Path: <linux-btrfs+bounces-7196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5E9522A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 21:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942111F23FE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345C1BE87B;
	Wed, 14 Aug 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHHjKRFK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJ3lkZ34";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHHjKRFK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJ3lkZ34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86D1BE863;
	Wed, 14 Aug 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663609; cv=none; b=lvLHzE18J9+ItoTTszQn+9qFx+qDXCHeR7fEZPHCVoiZ/1Du21SIvy0LQqpXxOTWYvwrz+liI/tmEAu7DVkj7DYuopVQt33UuN9C7cf6b5iRLdQ4CBiZb0IXyZTbriU884H4kiyktWtHvZ8JGK2XxZ1LPthbl6Ljkb/dppNti2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663609; c=relaxed/simple;
	bh=curiTEWnbqI+DW8sJ6iZ6HjnJrBnKPBoV6oYJ6oT75U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt/su/H8KzRHLXf+mdbUaoea2AtNgMrxIORvEyRmfV1SStFmSoVLef4yTvhzxD3n3rEYs7P5EfbijiEMS4y8bOicIOxHWAuXZNCuI+BRDZOqRJXmhAx+QdjSBkoTSgT97ZdDACguC7CmyFtBJBWL+SVZVjDNrPl1qOSupc7NsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zHHjKRFK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJ3lkZ34; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zHHjKRFK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJ3lkZ34; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D77921F25;
	Wed, 14 Aug 2024 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723663604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+IuFyxR5Q9PaIlGbBfEbSCVWVyZuJ7A516dgIt8BMk=;
	b=zHHjKRFKrQ1nwaQCyvJEsBbTAULIRD+HGZEBnu/G8PlLrt/UICAgkYlzfvE14bObzbiWoj
	ZKakUrdepJPd0CmrWwUbiHg+XDgITjdbUgbah+A9hiLMCZICuammeO57TQbaX6rlXyLP3t
	VaSRXrMSQ7qjiccmlp4sorI/2GgtcZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723663604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+IuFyxR5Q9PaIlGbBfEbSCVWVyZuJ7A516dgIt8BMk=;
	b=GJ3lkZ34jIz4DWUsX+bKafvzUrwjLnYeTh7diw0rgoi+2dGsegqgatClQYxOrR+CsPYdJA
	n7krkR9vAGYhU4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723663604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+IuFyxR5Q9PaIlGbBfEbSCVWVyZuJ7A516dgIt8BMk=;
	b=zHHjKRFKrQ1nwaQCyvJEsBbTAULIRD+HGZEBnu/G8PlLrt/UICAgkYlzfvE14bObzbiWoj
	ZKakUrdepJPd0CmrWwUbiHg+XDgITjdbUgbah+A9hiLMCZICuammeO57TQbaX6rlXyLP3t
	VaSRXrMSQ7qjiccmlp4sorI/2GgtcZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723663604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+IuFyxR5Q9PaIlGbBfEbSCVWVyZuJ7A516dgIt8BMk=;
	b=GJ3lkZ34jIz4DWUsX+bKafvzUrwjLnYeTh7diw0rgoi+2dGsegqgatClQYxOrR+CsPYdJA
	n7krkR9vAGYhU4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CFD21348F;
	Wed, 14 Aug 2024 19:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dqSnDvQEvWbbLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 Aug 2024 19:26:44 +0000
Date: Wed, 14 Aug 2024 21:26:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
Message-ID: <20240814192642.GZ25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
 <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
 <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>
 <20240814180219.GA2542470@thelio-3990X>
 <7747116F-BA20-455C-84AF-80D0EAD8B152@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7747116F-BA20-455C-84AF-80D0EAD8B152@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Wed, Aug 14, 2024 at 09:01:42PM +0200, Thorsten Blum wrote:
> On 14. Aug 2024, at 20:02, Nathan Chancellor <nathan@kernel.org> wrote:
> > On Mon, Aug 12, 2024 at 02:03:44PM +0200, Thorsten Blum wrote:
> >> On 12. Aug 2024, at 12:54, Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:
> >>> On 12.08.24 12:37, Thorsten Blum wrote:
> >>>> Add the __counted_by compiler attribute to the flexible array member
> >>>> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >>>> CONFIG_FORTIFY_SOURCE.
> >>>> 
> >>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >>>> ---
> >>>> fs/btrfs/volumes.h | 4 ++--
> >>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>> 
> >>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> >>>> index 37a09ebb34dd..f28fa318036b 100644
> >>>> --- a/fs/btrfs/volumes.h
> >>>> +++ b/fs/btrfs/volumes.h
> >>>> @@ -551,7 +551,7 @@ struct btrfs_io_context {
> >>>>  * stripes[data_stripes + 1]: The Q stripe (only for RAID6).
> >>>>  */
> >>>>  u64 full_stripe_logical;
> >>>> - struct btrfs_io_stripe stripes[];
> >>>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
> >>>> };
> >>>> 
> >>>> struct btrfs_device_info {
> >>>> @@ -591,7 +591,7 @@ struct btrfs_chunk_map {
> >>>>  int io_width;
> >>>>  int num_stripes;
> >>>>  int sub_stripes;
> >>>> - struct btrfs_io_stripe stripes[];
> >>>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
> >>>> };
> >>>> 
> >>>> #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
> >>> 
> >>> Looks good to me,
> >>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>> 
> >>> Out of curiosity, have you encountered any issues with this patch applied?
> >> 
> >> I only compile-tested it.
> > 
> > This change is now in next-20240814 and I see a UBSAN warning at runtime
> > as a result because the assignment of ->num_stripes happens after
> > accessing ->stripes[] (which breaks one of the requirements for using
> > __counted_by [1]), meaning that UBSAN thinks this is a zero sized array
> > due to bioc being allocated with kzalloc().
> > 
> >  [   24.992264] ------------[ cut here ]------------
> >  [   25.009196] UBSAN: array-index-out-of-bounds in fs/btrfs/volumes.c:6602:11
> >  [   25.021963] index 1 is out of range for type 'struct btrfs_io_stripe[] __counted_by(num_stripes)' (aka 'struct btrfs_io_stripe[]')
> >  [   25.036463] CPU: 28 UID: 0 PID: 1171 Comm: systemd-random- Not tainted 6.11.0-rc3-next-20240814 #1
> >  [   25.048172] Hardware name: ADLINK Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.04.100.11 (SYS: 2.06.20220308) 11/06/2
> >  [   25.064754] Call trace:
> >  [   25.069965]  dump_backtrace+0x114/0x19c
> >  [   25.076564]  show_stack+0x28/0x3c
> >  [   25.082642]  dump_stack_lvl+0x48/0x94
> >  [   25.089068]  __ubsan_handle_out_of_bounds+0x10c/0x184
> >  [   25.096883]  btrfs_map_block+0x540/0xb3c
> >  [   25.103570]  btrfs_submit_bio+0xf8/0x654
> >  [   25.110256]  write_one_eb+0x290/0x444
> >  [   25.116682]  btree_write_cache_pages+0x44c/0x5a8
> >  [   25.124063]  btree_writepages+0x2c/0x8c
> >  [   25.130662]  do_writepages+0x10c/0x34c
> >  [   25.137175]  filemap_fdatawrite_wbc+0x84/0xb0
> >  [   25.144295]  filemap_fdatawrite_range+0x74/0xac
> >  [   25.151589]  btrfs_write_marked_extents+0xa0/0x140
> >  [   25.159143]  btrfs_sync_log+0x298/0xa98
> >  [   25.165743]  btrfs_sync_file+0x440/0x608
> >  [   25.172429]  __arm64_sys_fsync+0x90/0xd4
> >  [   25.179115]  invoke_syscall+0x8c/0x11c
> >  [   25.185628]  el0_svc_common
> >  [   25.191185]  do_el0_svc+0x2c/0x3c
> >  [   25.197264]  el0_svc+0x48/0xf0
> >  [   25.203083]  el0t_64_sync_handler+0x98/0x108
> >  [   25.210118]  el0t_64_sync+0x19c/0x1a0
> >  [   25.216552] ---[ end trace ]---
> > 
> > The fix might be as simple as something like
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 4a259bdaa21c..0cabc2ebde71 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -6561,6 +6561,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > }
> > bioc->map_type = map->type;
> > 
> > + bioc->num_stripes = io_geom.num_stripes;
> > /*
> > * For RAID56 full map, we need to make sure the stripes[] follows the
> > * rule that data stripes are all ordered, then followed with P and Q
> > @@ -6621,7 +6622,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
> > }
> > 
> > *bioc_ret = bioc;
> > - bioc->num_stripes = io_geom.num_stripes;
> > bioc->max_errors = io_geom.max_errors;
> > bioc->mirror_num = io_geom.mirror_num;
> > 
> > 
> > but I am not sure of the implications of this change on quick glance
> > with regards to error handling and such.
> > 
> > [1]: https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribute-in-c-and-linux
> > 
> > Cheers,
> > Nathan
> 
> My patch should probably be reverted as I somehow missed quite a few
> things and need more time to rework this properly.
> 
> Sorry about that and thanks for reporting this!

Patch removed from for-next.

