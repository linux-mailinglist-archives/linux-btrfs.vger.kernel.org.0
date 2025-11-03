Return-Path: <linux-btrfs+bounces-18590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD77C2D3F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E73F234B4C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20331A547;
	Mon,  3 Nov 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="mFVkXXAZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77931987E
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188574; cv=none; b=kcYL8uK1Rbh2oPOn4RMeI6oaki/Bmr7idWwQEdQZ6mMnIYojbBjfthSEd5gKVl4iwqfsWKPe4lYDNVUslo8hOV/Q2JP4KJKtha+OZqeK+7pXZ1YAAsB3W6uvwnhBnAH70RKd6E2Q8QndPO4FnM4KHYlAw9OSt3MSRKdqK12moVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188574; c=relaxed/simple;
	bh=d3Z6bOubMmKCm2dtiQv5GB16VgWSwoTz/L3+465/xso=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+m7WEQTqjXS7rU655/5F3GD0pVLE5SvWipK4IGL+WXa2o1+B4z2uf0zHnngDc0XQ3OuA5DvJSaTbAkiWm/2fJiUbKweHt8yeKH+NOj0Lh/q5zFs3kNNllWHg9dOQUcjpvEXSVOJBFD0wZx9fmO3bNiUjy9TW9aEuqPAxcHCCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=mFVkXXAZ; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 31D4A2D5526;
	Mon,  3 Nov 2025 16:49:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762188567;
	bh=Pe/DV0A17vmtgKXNI1x+5tjznCB5XqGuhee9GH4vKRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mFVkXXAZKl9R5bvoAWRMH64za366h7L5TEYnIA6z7H6SU1s5VaSeCmiZbwRln0wzX
	 yeApOmz4ZazXkhPz4JijfaNDsZAkR7NIYORXuPxzPHqe5vMj7D8amrVHB13YR0K3G9
	 vS41Yun3Lgzu3Ycn7rQMrcKiA4wfn0TlttUE2FJI=
Message-ID: <475df362-2bf8-4cfd-b85d-df4579ddc8d3@harmstone.com>
Date: Mon, 3 Nov 2025 16:49:26 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
To: Boris Burkov <boris@bur.io>, kernel test robot <lkp@intel.com>
Cc: linux-btrfs@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <20251024181227.32228-16-mark@harmstone.com>
 <202510272322.N1S5rdDc-lkp@intel.com>
 <aQU0TJLSbEXcSX1s@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <aQU0TJLSbEXcSX1s@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2025 10.12 pm, Boris Burkov wrote:
> On Tue, Oct 28, 2025 at 12:04:11AM +0800, kernel test robot wrote:
>> Hi Mark,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on kdave/for-next]
>> [also build test WARNING on next-20251027]
>> [cannot apply to linus/master v6.18-rc3]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20251025-021910
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
>> patch link:    https://lore.kernel.org/r/20251024181227.32228-16-mark%40harmstone.com
>> patch subject: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block groups
>> config: arm-randconfig-003-20251027 (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510272322.N1S5rdDc-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510272322.N1S5rdDc-lkp@intel.com/
>>
>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>>
>> All warnings (new ones prefixed by >>):
>>
>>     fs/btrfs/discard.c: In function 'btrfs_discard_workfn':
>>>> fs/btrfs/discard.c:596:6: warning: 'discard_state' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>        if (discard_state == BTRFS_DISCARD_BITMAPS ||
>>           ^
> 
> I think this gets set by peek_discard_list() so I don't think this is
> a valid warning.

You are correct. discard_state gets initialized if the return value of 
peek_discard_list() is not NULL, and if it is NULL we return before we 
use it.

This is an ancient version of GCC, the warning doesn't trigger on GCC 15 
- presumably it has better control flow analysis. I don't think the 
robot should be compiling with this warning turned on for old compiler 
versions, if it's prone to false positives.

>>
>>
>> vim +/discard_state +596 fs/btrfs/discard.c
>>
>>     513	
>>     514	/*
>>     515	 * Discard work queue callback
>>     516	 *
>>     517	 * @work: work
>>     518	 *
>>     519	 * Find the next block_group to start discarding and then discard a single
>>     520	 * region.  It does this in a two-pass fashion: first extents and second
>>     521	 * bitmaps.  Completely discarded block groups are sent to the unused_bgs path.
>>     522	 */
>>     523	static void btrfs_discard_workfn(struct work_struct *work)
>>     524	{
>>     525		struct btrfs_discard_ctl *discard_ctl;
>>     526		struct btrfs_block_group *block_group;
>>     527		enum btrfs_discard_state discard_state;
>>     528		int discard_index = 0;
>>     529		u64 trimmed = 0;
>>     530		u64 minlen = 0;
>>     531		u64 now = ktime_get_ns();
>>     532	
>>     533		discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
>>     534	
>>     535		block_group = peek_discard_list(discard_ctl, &discard_state,
>>     536						&discard_index, now);
>>     537		if (!block_group)
>>     538			return;
>>     539		if (!btrfs_run_discard_work(discard_ctl)) {
>>     540			spin_lock(&discard_ctl->lock);
>>     541			btrfs_put_block_group(block_group);
>>     542			discard_ctl->block_group = NULL;
>>     543			spin_unlock(&discard_ctl->lock);
>>     544			return;
>>     545		}
>>     546		if (now < block_group->discard_eligible_time) {
>>     547			spin_lock(&discard_ctl->lock);
>>     548			btrfs_put_block_group(block_group);
>>     549			discard_ctl->block_group = NULL;
>>     550			spin_unlock(&discard_ctl->lock);
>>     551			btrfs_discard_schedule_work(discard_ctl, false);
>>     552			return;
>>     553		}
>>     554	
>>     555		/* Perform discarding */
>>     556		minlen = discard_minlen[discard_index];
>>     557	
>>     558		switch (discard_state) {
>>     559		case BTRFS_DISCARD_BITMAPS: {
>>     560			u64 maxlen = 0;
>>     561	
>>     562			/*
>>     563			 * Use the previous levels minimum discard length as the max
>>     564			 * length filter.  In the case something is added to make a
>>     565			 * region go beyond the max filter, the entire bitmap is set
>>     566			 * back to BTRFS_TRIM_STATE_UNTRIMMED.
>>     567			 */
>>     568			if (discard_index != BTRFS_DISCARD_INDEX_UNUSED)
>>     569				maxlen = discard_minlen[discard_index - 1];
>>     570	
>>     571			btrfs_trim_block_group_bitmaps(block_group, &trimmed,
>>     572					       block_group->discard_cursor,
>>     573					       btrfs_block_group_end(block_group),
>>     574					       minlen, maxlen, true);
>>     575			discard_ctl->discard_bitmap_bytes += trimmed;
>>     576	
>>     577			break;
>>     578		}
>>     579	
>>     580		case BTRFS_DISCARD_FULLY_REMAPPED:
>>     581			btrfs_trim_fully_remapped_block_group(block_group);
>>     582			break;
>>     583	
>>     584		default:
>>     585			btrfs_trim_block_group_extents(block_group, &trimmed,
>>     586					       block_group->discard_cursor,
>>     587					       btrfs_block_group_end(block_group),
>>     588					       minlen, true);
>>     589			discard_ctl->discard_extent_bytes += trimmed;
>>     590	
>>     591			break;
>>     592		}
>>     593	
>>     594		/* Determine next steps for a block_group */
>>     595		if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
>>   > 596			if (discard_state == BTRFS_DISCARD_BITMAPS ||
>>     597			    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
>>     598				btrfs_finish_discard_pass(discard_ctl, block_group);
>>     599			} else {
>>     600				block_group->discard_cursor = block_group->start;
>>     601				spin_lock(&discard_ctl->lock);
>>     602				if (block_group->discard_state !=
>>     603				    BTRFS_DISCARD_RESET_CURSOR)
>>     604					block_group->discard_state =
>>     605								BTRFS_DISCARD_BITMAPS;
>>     606				spin_unlock(&discard_ctl->lock);
>>     607			}
>>     608		}
>>     609	
>>     610		now = ktime_get_ns();
>>     611		spin_lock(&discard_ctl->lock);
>>     612		discard_ctl->prev_discard = trimmed;
>>     613		discard_ctl->prev_discard_time = now;
>>     614		btrfs_put_block_group(block_group);
>>     615		discard_ctl->block_group = NULL;
>>     616		__btrfs_discard_schedule_work(discard_ctl, now, false);
>>     617		spin_unlock(&discard_ctl->lock);
>>     618	}
>>     619	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki


