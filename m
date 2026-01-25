Return-Path: <linux-btrfs+bounces-20998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMwIEIo3dmmTNgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20998-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 16:32:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F398136B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22D33007F48
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78E3242DE;
	Sun, 25 Jan 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UN+3A7pa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4B4594A
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355134; cv=none; b=CQHQHTlcIVMMmrdZNY5jL2Hmujs9kScNblPu+Ly923+VDu/+FqpX2v7Myumf/Bss6WA3pM19wpfjq40ZmkQ6Nv6EL3S/Hg1rvGlvKNrgSLh3xJxJW4aHj6dsMba7MI4G8DCOi78Yg6ZW/IgiQ9uUSTzEOl0L1I1lR7Znyr7nxOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355134; c=relaxed/simple;
	bh=VvlCRxa4oszW//m5pUQSOdcpmk3Bc5UbGlLQ/mutS5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCQEuGoH8cEBd9Aljv3khLZPkf9Hj10SwhiB87us+0KC4Zp54Al/BW9a1rTxalzoXAgitgpfz+FV08uAZw8H6a5Ts+44y/ejw4EhJH9poLRxLHOLhIEJl3UIf8ad6FAhmUOTuQd4Hjdak3iPrtvxBKpt0A9XoN6ByqKBoHzde08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UN+3A7pa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769355133; x=1800891133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VvlCRxa4oszW//m5pUQSOdcpmk3Bc5UbGlLQ/mutS5E=;
  b=UN+3A7pag/c6Cv2q/83pGCjdC8vaIxK5pRXt+MkD6zHD3xLl+kAKPcvY
   FfvZq5AHMymjFhpY9tPlHSFGfv4nM0YU5l8VkkBasLiwfodA4htYVeaIZ
   IGNR3Uy9u5FuDDQJbidhVEJeGBRK9RxiXeCdsQZznvMilK2G01G3shnTk
   9bdbgQxzj7qM0zik130hy02jh4TqVFQ5F/lTHQYbIfLsMww3SiXDl8JNa
   FFmyN9I6gLbAZTvNyK9rzM9TTesyYIGF6t6ppQXDBXklm5kY171iMrFCp
   6yCvuKZFaMG6+Az2r0wuLilhpTzSioDpKwV9wH7ShFUd+TibcnfrX1Cdv
   w==;
X-CSE-ConnectionGUID: I4zO1RuUQ7GSj45OyvNFvg==
X-CSE-MsgGUID: LPpOz2QvRcGN4fcHU3O7WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70705452"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="70705452"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 07:32:12 -0800
X-CSE-ConnectionGUID: x6n+OXRxQjeiOHt4U+n2CQ==
X-CSE-MsgGUID: CojWatiQQmiq5TMcYM6pDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="207727210"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 25 Jan 2026 07:32:10 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vk25w-000000001IP-1R3k;
	Sun, 25 Jan 2026 15:32:08 +0000
Date: Sun, 25 Jan 2026 16:31:40 +0100
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] btrfs: unit tests for pending extent walking
 functions
Message-ID: <202601251610.dH67mNZI-lkp@intel.com>
References: <efc4b5a3fbcbc7473afc228badd3e1306298bf33.1769290938.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc4b5a3fbcbc7473afc228badd3e1306298bf33.1769290938.git.boris@bur.io>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20998-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D8F398136B
X-Rspamd-Action: no action

Hi Boris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.19-rc6 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/btrfs-fix-EEXIST-abort-due-to-non-consecutive-gaps-in-chunk-allocation/20260125-054609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/efc4b5a3fbcbc7473afc228badd3e1306298bf33.1769290938.git.boris%40bur.io
patch subject: [PATCH v2 2/3] btrfs: unit tests for pending extent walking functions
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260125/202601251610.dH67mNZI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260125/202601251610.dH67mNZI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601251610.dH67mNZI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/volumes.c:1529:6: warning: no previous prototype for function 'btrfs_first_pending_extent' [-Wmissing-prototypes]
    1529 | bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
         |      ^
   fs/btrfs/volumes.c:1529:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1529 | bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
         | ^
         | static 
>> fs/btrfs/volumes.c:1570:6: warning: no previous prototype for function 'btrfs_find_hole_in_pending_extents' [-Wmissing-prototypes]
    1570 | bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
         |      ^
   fs/btrfs/volumes.c:1570:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1570 | bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
         | ^
         | static 
   2 warnings generated.


vim +/btrfs_first_pending_extent +1529 fs/btrfs/volumes.c

  1510	
  1511	/*
  1512	 * Find the first pending extent intersecting a range.
  1513	 *
  1514	 * @device: the device to search
  1515	 * @start: start of the range to check
  1516	 * @len: length of the range to check
  1517	 * @pending_start: output pointer for the start of the found pending extent
  1518	 * @pending_end: output pointer for the end of the found pending extent (inclusive)
  1519	 *
  1520	 * Search for a pending chunk allocation that intersects the half-open range
  1521	 * [start, start + len).
  1522	 *
  1523	 * Return: true if a pending extent was found, false otherwise.
  1524	 * If the return value is true, store the first pending extent in
  1525	 * [*pending_start, *pending_end]. Otherwise, the two output variables
  1526	 * may still be modified, to something outside the range and should not
  1527	 * be used.
  1528	 */
> 1529	bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
  1530					u64 *pending_start, u64 *pending_end)
  1531	{
  1532		lockdep_assert_held(&device->fs_info->chunk_mutex);
  1533	
  1534		if (btrfs_find_first_extent_bit(&device->alloc_state, start,
  1535						pending_start, pending_end,
  1536						CHUNK_ALLOCATED, NULL)) {
  1537	
  1538			if (in_range(*pending_start, start, len) ||
  1539			    in_range(start, *pending_start,
  1540				     *pending_end + 1 - *pending_start)) {
  1541				return true;
  1542			}
  1543		}
  1544		return false;
  1545	}
  1546	
  1547	/*
  1548	 * Find the first real hole accounting for pending extents.
  1549	 *
  1550	 * @device: the device containing the candidate hole
  1551	 * @start: input/output pointer for the hole start position
  1552	 * @len: input/output pointer for the hole length
  1553	 * @min_hole_size: the size of hole we are looking for
  1554	 *
  1555	 * Given a potential hole specified by [*start, *start + *len), check for pending
  1556	 * chunk allocations within that range. If pending extents are found, the hole is
  1557	 * adjusted to represent the first true free space that is large enough when
  1558	 * accounting for pending chunks.
  1559	 *
  1560	 * Note that this function must handle various cases involving non
  1561	 * consecutive pending extents.
  1562	 *
  1563	 * Returns: true if a suitable hole was found and false otherwise.
  1564	 * If the return value is true, then *start and *len are set to represent the hole.
  1565	 * If the return value is false, then *start is set to the largest hole we
  1566	 * found and *len is set to its length.
  1567	 * If there are no holes at all, then *start is set to the end of the range and
  1568	 * *len is set to 0.
  1569	 */
> 1570	bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
  1571						u64 min_hole_size)
  1572	{
  1573		u64 pending_start, pending_end;
  1574		u64 end;
  1575		u64 max_hole_start = 0;
  1576		u64 max_hole_len = 0;
  1577	
  1578		lockdep_assert_held(&device->fs_info->chunk_mutex);
  1579	
  1580		if (*len == 0)
  1581			return false;
  1582	
  1583		end = *start + *len - 1;
  1584	
  1585		/*
  1586		 * Loop until we either see a large enough hole or check every pending
  1587		 * extent overlapping the candidate hole.
  1588		 * At every hole that we observe, record it if it is the new max.
  1589		 * At the end of the iteration, set the output variables to the max hole.
  1590		 */
  1591		while (true) {
  1592			if (btrfs_first_pending_extent(device, *start, *len, &pending_start, &pending_end)) {
  1593				/*
  1594				 * Case 1: the pending extent overlaps the start of
  1595				 * candidate hole. That means the true hole is after the
  1596				 * pending extent, but we need to find the next pending
  1597				 * extent to properly size the hole. In the next loop,
  1598				 * we will reduce to case 2 or 3.
  1599				 * e.g.,
  1600				 *   |----pending A----|    real hole     |----pending B----|
  1601				 *            |           candidate hole        |
  1602				 *         *start                              end
  1603				 */
  1604				if (pending_start <= *start) {
  1605					*start = pending_end + 1;
  1606					goto next;
  1607				}
  1608				/*
  1609				 * Case 2: The pending extent starts after *start (and overlaps
  1610				 * [*start, end), so the first hole just goes up to the start
  1611				 * of the pending extent.
  1612				 * e.g.,
  1613				 *   |    real hole    |----pending A----|
  1614				 *   |       candidate hole     |
  1615				 * *start                      end
  1616				 *
  1617				 */
  1618				*len = pending_start - *start;
  1619				if (*len > max_hole_len) {
  1620					max_hole_start = *start;
  1621					max_hole_len = *len;
  1622				}
  1623				if (*len >= min_hole_size)
  1624					break;
  1625				/*
  1626				 * If the hole wasn't big enough, then we advance past
  1627				 * the pending extent and keep looking.
  1628				 */
  1629				*start = pending_end + 1;
  1630				goto next;
  1631			} else {
  1632				/*
  1633				 * Case 3: There is no pending extent overlapping the
  1634				 * range [*start, *start + *len - 1], so the only remaining
  1635				 * hole is the remaining range.
  1636				 * e.g.,
  1637				 *   |       candidate hole           |
  1638				 *   |          real hole             |
  1639				 * *start                            end
  1640				 */
  1641	
  1642				if (*len > max_hole_len) {
  1643					max_hole_start = *start;
  1644					max_hole_len = *len;
  1645				}
  1646				break;
  1647			}
  1648	next:
  1649			if (*start > end)
  1650				break;
  1651			*len = end - *start + 1;
  1652		}
  1653		if (max_hole_len) {
  1654			*start = max_hole_start;
  1655			*len = max_hole_len;
  1656		} else {
  1657			*start = end + 1;
  1658			*len = 0;
  1659		}
  1660		return max_hole_len >= min_hole_size;
  1661	}
  1662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

