Return-Path: <linux-btrfs+bounces-7194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9C9521C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0742840AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32971BD4F8;
	Wed, 14 Aug 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiQQtrCh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96731BBBDC;
	Wed, 14 Aug 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658541; cv=none; b=b1bA00vNaG0jUg43JJPI8Xbvy1JvsXvlonWgPJhvInPT+4bHYJc08ZPBW7bPinRIYClunNWaZpR/0ibb7bTDMoSQAD6K4OV3nMDo0+IRjmAYoox6rrVoKF3nayIjPp+O0Ed3jGo9SGOOBYqVOEU4+T5uRNKYEw5k66pRz6nl8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658541; c=relaxed/simple;
	bh=b3IL0IuKAL/2fFGkzh5hUHW0BTCue6XPE1uAmeSBXSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfMRn94PVqPZ4ujq535te2awgMJB4Cnpsox1wSLrFdRlcW43PBWVp5PyDvzwZlLtF234yrqcoNC2j5TyZE1JJH2kbUQkib/U69+XvUwLRjRvA0LpePjOw+SQEeJ4qSDjMc1nI+wreHEk/K5O+21w5G/rp8ZzTvs5UN5o6H11tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiQQtrCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B202EC116B1;
	Wed, 14 Aug 2024 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723658541;
	bh=b3IL0IuKAL/2fFGkzh5hUHW0BTCue6XPE1uAmeSBXSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiQQtrChhx1PuqevUgzHPsGXtsoqQLZaxr1lhUlcLAgyVH/lAum0ssFnLZRwu0HMM
	 IwVI5t/6aKHU2GO9waNqBNrrxVI67HMFIfuNMo+A6NHW0BqE/UvJ88gG0ej2wiRWu2
	 WYhJl6AdTST7MLRYWdVviguexw/Yi6/fs5rxsldgEtmyhdl0RQTQDUyZXpTXXTCO3r
	 i8TQlr9XtSi7X4H8eBDB7tfw+8In1oDUb1DceRgP24se5d0/SSmT0LX+jjsdXPdIeu
	 16WvWCnNozuZpioNgAV3sLhqUo8tHPsASR0a0ikVHqI8BS67KAcmS+Xo2clYXrKGes
	 01Nng+NdQwuIQ==
Date: Wed, 14 Aug 2024 11:02:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
Message-ID: <20240814180219.GA2542470@thelio-3990X>
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
 <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
 <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>

On Mon, Aug 12, 2024 at 02:03:44PM +0200, Thorsten Blum wrote:
> On 12. Aug 2024, at 12:54, Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:
> > On 12.08.24 12:37, Thorsten Blum wrote:
> >> Add the __counted_by compiler attribute to the flexible array member
> >> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >> ---
> >>  fs/btrfs/volumes.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> >> index 37a09ebb34dd..f28fa318036b 100644
> >> --- a/fs/btrfs/volumes.h
> >> +++ b/fs/btrfs/volumes.h
> >> @@ -551,7 +551,7 @@ struct btrfs_io_context {
> >>   * stripes[data_stripes + 1]: The Q stripe (only for RAID6).
> >>   */
> >>   u64 full_stripe_logical;
> >> - struct btrfs_io_stripe stripes[];
> >> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
> >>  };
> >> 
> >>  struct btrfs_device_info {
> >> @@ -591,7 +591,7 @@ struct btrfs_chunk_map {
> >>   int io_width;
> >>   int num_stripes;
> >>   int sub_stripes;
> >> - struct btrfs_io_stripe stripes[];
> >> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
> >>  };
> >> 
> >>  #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
> > 
> > Looks good to me,
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > Out of curiosity, have you encountered any issues with this patch applied?
> 
> I only compile-tested it.

This change is now in next-20240814 and I see a UBSAN warning at runtime
as a result because the assignment of ->num_stripes happens after
accessing ->stripes[] (which breaks one of the requirements for using
__counted_by [1]), meaning that UBSAN thinks this is a zero sized array
due to bioc being allocated with kzalloc().

  [   24.992264] ------------[ cut here ]------------
  [   25.009196] UBSAN: array-index-out-of-bounds in fs/btrfs/volumes.c:6602:11
  [   25.021963] index 1 is out of range for type 'struct btrfs_io_stripe[] __counted_by(num_stripes)' (aka 'struct btrfs_io_stripe[]')
  [   25.036463] CPU: 28 UID: 0 PID: 1171 Comm: systemd-random- Not tainted 6.11.0-rc3-next-20240814 #1
  [   25.048172] Hardware name: ADLINK Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.04.100.11 (SYS: 2.06.20220308) 11/06/2
  [   25.064754] Call trace:
  [   25.069965]  dump_backtrace+0x114/0x19c
  [   25.076564]  show_stack+0x28/0x3c
  [   25.082642]  dump_stack_lvl+0x48/0x94
  [   25.089068]  __ubsan_handle_out_of_bounds+0x10c/0x184
  [   25.096883]  btrfs_map_block+0x540/0xb3c
  [   25.103570]  btrfs_submit_bio+0xf8/0x654
  [   25.110256]  write_one_eb+0x290/0x444
  [   25.116682]  btree_write_cache_pages+0x44c/0x5a8
  [   25.124063]  btree_writepages+0x2c/0x8c
  [   25.130662]  do_writepages+0x10c/0x34c
  [   25.137175]  filemap_fdatawrite_wbc+0x84/0xb0
  [   25.144295]  filemap_fdatawrite_range+0x74/0xac
  [   25.151589]  btrfs_write_marked_extents+0xa0/0x140
  [   25.159143]  btrfs_sync_log+0x298/0xa98
  [   25.165743]  btrfs_sync_file+0x440/0x608
  [   25.172429]  __arm64_sys_fsync+0x90/0xd4
  [   25.179115]  invoke_syscall+0x8c/0x11c
  [   25.185628]  el0_svc_common
  [   25.191185]  do_el0_svc+0x2c/0x3c
  [   25.197264]  el0_svc+0x48/0xf0
  [   25.203083]  el0t_64_sync_handler+0x98/0x108
  [   25.210118]  el0t_64_sync+0x19c/0x1a0
  [   25.216552] ---[ end trace ]---

The fix might be as simple as something like

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4a259bdaa21c..0cabc2ebde71 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6561,6 +6561,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 	bioc->map_type = map->type;
 
+	bioc->num_stripes = io_geom.num_stripes;
 	/*
 	 * For RAID56 full map, we need to make sure the stripes[] follows the
 	 * rule that data stripes are all ordered, then followed with P and Q
@@ -6621,7 +6622,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	}
 
 	*bioc_ret = bioc;
-	bioc->num_stripes = io_geom.num_stripes;
 	bioc->max_errors = io_geom.max_errors;
 	bioc->mirror_num = io_geom.mirror_num;
 

but I am not sure of the implications of this change on quick glance
with regards to error handling and such.

[1]: https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribute-in-c-and-linux

Cheers,
Nathan

