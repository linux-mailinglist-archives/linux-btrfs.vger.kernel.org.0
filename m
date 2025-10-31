Return-Path: <linux-btrfs+bounces-18496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA57C271CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 23:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090FC3AD1DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2632AADA;
	Fri, 31 Oct 2025 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eHgOypQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKO5JMoR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4267405F7
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948754; cv=none; b=ULmW49sT3FbMIAlc3g/4OQkyszKvWOlwRdnV1U+ou/nC2hlt7fLcq2PIItpIm8HIwKkEXUZ61DLkqSgOf/5aslz1I4lD3Cd1exXuQTTpsGJyTUzW8oLYEEIbgufvv/qxxU6Ww+HfHwSoqNylychnal1ogTnHduEDAe3xmCdJswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948754; c=relaxed/simple;
	bh=I8McIG3NDEv1t1TgzExmsrBc4wE+mFyo4ceHeh4Q5pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzRRZ/ffplnEcCF2p8ew1BSgtbQbPR6AqEUvSFPexBXmr4HYE7nomYGGPXlb/ohQrDvCCL9vot4LTxtPLQx9Ja4g5zBjjhfPvP+VXOInErzIjTY2y3LNmydvt5bMXaV/VUg/NIPcIzh9B81LmsEvXcCkNWLEaSxpVtcsBqEpl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eHgOypQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKO5JMoR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFA321400096;
	Fri, 31 Oct 2025 18:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 31 Oct 2025 18:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761948751; x=1762035151; bh=FjFmiz1qOH
	/LlnNN60N/rrL2LWQgVcR59Z4VMRF4VII=; b=eHgOypQG21+zS7Ei3ubiefRRoj
	f5llBb6y+wjb3uUVnzRjOp2GIfCubmYK2QLpZzJB+zlHXr9Z24xgrnBG4+15y/rt
	flq4+iExxQaDbEFZ0DG7boTLcAz9D87ZHijjjt2BnztBUXzmoDbY78Q+PtpKdxHd
	fpCrWMhyEtWfSv7DYer1oC70peP+BWnzB/CFepzlYphAm5Mpxg9SAXm9xXGMNBVP
	V+MZiewv3Fk9wPFjLJBC8GDKL4aCa/7HxrzOfSF+KcOpd89uwfnDKgnslOtKtSt3
	+N8euVVDXKYG7u0hUhaMCNb8hePAYJB9GkSr67oVwX0a94FLymo0Lrkroplg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761948751; x=1762035151; bh=FjFmiz1qOH/LlnNN60N/rrL2LWQgVcR59Z4
	VMRF4VII=; b=KKO5JMoRqClNnZH5q90odmj0b3JJFrjihZphGWsJVGNYo7h2xdU
	9FqfaVlOKnSLurbEOsa+LaYl8sI1RHk3LbGZqjfbdRaMwbfkoOZiRhYtwz7rZK8u
	r6jmfAApC3689uPrm/mVtbvKKfK1r6sKpcJp3klEmvhMpKRofz9oedmDum+e2z5f
	Epk/a8oHw9CtndMH0m6encWljeeP6jo96NzRNNCY7bLuQT9LWR5w3WjQXZ2Vb3Q9
	4KHYiRi6Qc1r9Sx+u+hUhLIOcbQdcmbSDGi5qycyVA3UBXrZAE6Zep+asbD5HYYx
	XU6/vUN4jMctuw5n/4QTsOD4+/ityyDr5sw==
X-ME-Sender: <xms:TzQFafS_sWbI7x2cCkVXMjtU6ik7yJZcQWCiQZ1-G6PRwf_jyx-tAA>
    <xme:TzQFaekANNJ-nsKNJNLuwKR9k9fLeIU6aNV76vbrIx6cWH9GxoatcL4IkDTIfcQB1
    uRDZIAlPSJxJfH3Sf3n3x11ZCaj41h_O63jTaV7WX_lJeapmiGgNV5J>
X-ME-Received: <xmr:TzQFafTuAsuo2EHTnHu2U_fvTzYWnH7D0rmckv0h1PX3W4bd090e4y3uePFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpedvud
    dvueehleffueeghfegtdfhvefggfejvdfghefgueetueeuveehtdeufedtueenucffohhm
    rghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdroh
    hrghdptddurdhorhhgpdhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:TzQFacNDdULAWtxHjpfJ9LdrxHpGHbV6jKutZxCWmButoHIXw1iiKA>
    <xmx:TzQFaYUffsDog8U9NLoVwNEBpS4YWB8-R2saXp3yM7eoTk_A2JitHw>
    <xmx:TzQFaTfQzcXcwc24TGEKIY1y46Z6naZLIvz9-NPVs5pv_rP530iYBg>
    <xmx:TzQFaUukeWmLqdOLfngaTZQP8WaaXTw1V0YsFsClQ1YULHCyHKO1zw>
    <xmx:TzQFadMqbSa4E5J9yirp7scGv33f2otBD6oIoV4X8AcfloVjdfX0onVC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 18:12:31 -0400 (EDT)
Date: Fri, 31 Oct 2025 15:12:28 -0700
From: Boris Burkov <boris@bur.io>
To: kernel test robot <lkp@intel.com>
Cc: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <aQU0TJLSbEXcSX1s@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-16-mark@harmstone.com>
 <202510272322.N1S5rdDc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510272322.N1S5rdDc-lkp@intel.com>

On Tue, Oct 28, 2025 at 12:04:11AM +0800, kernel test robot wrote:
> Hi Mark,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on next-20251027]
> [cannot apply to linus/master v6.18-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20251025-021910
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/20251024181227.32228-16-mark%40harmstone.com
> patch subject: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block groups
> config: arm-randconfig-003-20251027 (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510272322.N1S5rdDc-lkp@intel.com/
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/btrfs/discard.c: In function 'btrfs_discard_workfn':
> >> fs/btrfs/discard.c:596:6: warning: 'discard_state' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       if (discard_state == BTRFS_DISCARD_BITMAPS ||
>          ^

I think this gets set by peek_discard_list() so I don't think this is
a valid warning.

> 
> 
> vim +/discard_state +596 fs/btrfs/discard.c
> 
>    513	
>    514	/*
>    515	 * Discard work queue callback
>    516	 *
>    517	 * @work: work
>    518	 *
>    519	 * Find the next block_group to start discarding and then discard a single
>    520	 * region.  It does this in a two-pass fashion: first extents and second
>    521	 * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
>    522	 */
>    523	static void btrfs_discard_workfn(struct work_struct *work)
>    524	{
>    525		struct btrfs_discard_ctl *discard_ctl;
>    526		struct btrfs_block_group *block_group;
>    527		enum btrfs_discard_state discard_state;
>    528		int discard_index = 0;
>    529		u64 trimmed = 0;
>    530		u64 minlen = 0;
>    531		u64 now = ktime_get_ns();
>    532	
>    533		discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
>    534	
>    535		block_group = peek_discard_list(discard_ctl, &discard_state,
>    536						&discard_index, now);
>    537		if (!block_group)
>    538			return;
>    539		if (!btrfs_run_discard_work(discard_ctl)) {
>    540			spin_lock(&discard_ctl->lock);
>    541			btrfs_put_block_group(block_group);
>    542			discard_ctl->block_group = NULL;
>    543			spin_unlock(&discard_ctl->lock);
>    544			return;
>    545		}
>    546		if (now < block_group->discard_eligible_time) {
>    547			spin_lock(&discard_ctl->lock);
>    548			btrfs_put_block_group(block_group);
>    549			discard_ctl->block_group = NULL;
>    550			spin_unlock(&discard_ctl->lock);
>    551			btrfs_discard_schedule_work(discard_ctl, false);
>    552			return;
>    553		}
>    554	
>    555		/* Perform discarding */
>    556		minlen = discard_minlen[discard_index];
>    557	
>    558		switch (discard_state) {
>    559		case BTRFS_DISCARD_BITMAPS: {
>    560			u64 maxlen = 0;
>    561	
>    562			/*
>    563			 * Use the previous levels minimum discard length as the max
>    564			 * length filter.  In the case something is added to make a
>    565			 * region go beyond the max filter, the entire bitmap is set
>    566			 * back to BTRFS_TRIM_STATE_UNTRIMMED.
>    567			 */
>    568			if (discard_index != BTRFS_DISCARD_INDEX_UNUSED)
>    569				maxlen = discard_minlen[discard_index - 1];
>    570	
>    571			btrfs_trim_block_group_bitmaps(block_group, &trimmed,
>    572					       block_group->discard_cursor,
>    573					       btrfs_block_group_end(block_group),
>    574					       minlen, maxlen, true);
>    575			discard_ctl->discard_bitmap_bytes += trimmed;
>    576	
>    577			break;
>    578		}
>    579	
>    580		case BTRFS_DISCARD_FULLY_REMAPPED:
>    581			btrfs_trim_fully_remapped_block_group(block_group);
>    582			break;
>    583	
>    584		default:
>    585			btrfs_trim_block_group_extents(block_group, &trimmed,
>    586					       block_group->discard_cursor,
>    587					       btrfs_block_group_end(block_group),
>    588					       minlen, true);
>    589			discard_ctl->discard_extent_bytes += trimmed;
>    590	
>    591			break;
>    592		}
>    593	
>    594		/* Determine next steps for a block_group */
>    595		if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
>  > 596			if (discard_state == BTRFS_DISCARD_BITMAPS ||
>    597			    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
>    598				btrfs_finish_discard_pass(discard_ctl, block_group);
>    599			} else {
>    600				block_group->discard_cursor = block_group->start;
>    601				spin_lock(&discard_ctl->lock);
>    602				if (block_group->discard_state !=
>    603				    BTRFS_DISCARD_RESET_CURSOR)
>    604					block_group->discard_state =
>    605								BTRFS_DISCARD_BITMAPS;
>    606				spin_unlock(&discard_ctl->lock);
>    607			}
>    608		}
>    609	
>    610		now = ktime_get_ns();
>    611		spin_lock(&discard_ctl->lock);
>    612		discard_ctl->prev_discard = trimmed;
>    613		discard_ctl->prev_discard_time = now;
>    614		btrfs_put_block_group(block_group);
>    615		discard_ctl->block_group = NULL;
>    616		__btrfs_discard_schedule_work(discard_ctl, now, false);
>    617		spin_unlock(&discard_ctl->lock);
>    618	}
>    619	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

