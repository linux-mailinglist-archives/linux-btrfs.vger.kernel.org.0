Return-Path: <linux-btrfs+bounces-18598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44748C2E467
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 23:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651833B2DE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD13093C3;
	Mon,  3 Nov 2025 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFFY2Vvz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8B1DED63;
	Mon,  3 Nov 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209274; cv=none; b=KZBGRvm2ihS3uWnIguCCuRKiD2mgHpxwwKYV46fOO2F424YtfIR4uSzIzrZe8jjnam33GDzDmkza/6fz+FMDtRDvWBvErk+Ry4Qk4e6oF5BdQNebg0utUwCl37aQU19M9+VvbVfRbRlQRRjj2lLH5Bqeo9C6ANG1N9a7lgpVNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209274; c=relaxed/simple;
	bh=LsXUxhvMAeUZVjm/LWpP6ev4cboYy5/5YXLQMecOvw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XfJntwvnmkT9VWLyegCeYhNCDYwgjep9h5dK41H4kgBwe0Pmx3CWxcQneAjUQlW2WOhHjuOfMb6CNMylYV8/Sj6Lm1z7KXvc3aAJe7W+mJdrBWSJUfZbXedAjixZ42FaPQIDJvNQ7Gz46VFxNVMKBMUcxZ5ipQth6e4+jZkWbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFFY2Vvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F84C4CEE7;
	Mon,  3 Nov 2025 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762209273;
	bh=LsXUxhvMAeUZVjm/LWpP6ev4cboYy5/5YXLQMecOvw0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jFFY2VvzQYU+Obm+NWIDCdqt+t0mze6NzQqidCAeIpMUeETBCZecag9lfPANLOy/Y
	 sK3LIbCRwpgr2lWLJ2v5jbeTzFFfmrj7k+y/Zd0yHArw/vlkQjq52kdnv+kqqKOn52
	 kiDYqkk2c+gaL+Nw+eALDPTrTzEjreZcCsFhRBUYe07Y/AiKJvTEVT8Z165RZS1ug2
	 Uur0wonuF8dTTWC95KKsbwvBDkuoVD2+eORCDj3+PJsQf4q8kjpLYWWIVtR6Gpfbmb
	 zkQTFw0bZ7RMnVYUggJeCmNX8qtltVIKkjjwQZ0dayKOac34P/JGsIQSqDVcgtxSS1
	 f3CHaFbgjoxKw==
Message-ID: <bdf47aae-438c-4eb0-9c96-c0f474ace189@kernel.org>
Date: Tue, 4 Nov 2025 07:34:30 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
 <28a8b421-1c5f-400f-b890-62ebc7d74e88@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <28a8b421-1c5f-400f-b890-62ebc7d74e88@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 03:31, Bart Van Assche wrote:
> On 11/3/25 7:48 AM, Bart Van Assche wrote:
>> On 11/2/25 10:05 PM, Damien Le Moal wrote:
>>> On 11/1/25 06:17, Bart Van Assche wrote:
>>>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>>>> Implement tracking of the runtime changes to zone conditions using
>>>>> the new cond field in struct blk_zone_wplug. The size of this structure
>>>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>>>> end of the structure. For zones that do not have a zone write plug, the
>>>>> zones_cond array of a disk is used to track changes to zone conditions,
>>>>> e.g. when a zone reset, reset all or finish operation is executed.
>>>>
>>>> Why is it necessary to track the condition of sequential zones that do
>>>> not have a zone write plug? Please explain what the use cases are.
>>>
>>> Because zones that do not have a zone write plug can be empty OR full.
>>
>> Why does the block layer have to track this information? Filesystems can
>> easily derive this information from the filesystem metadata information,
>> isn't it?
> 
> (replying to my own email)
> 
> Is this a good way to check what zone type information filesystems need?
> 
> $ git grep -nH BLK_ZONE_TYPE_ fs
> fs/btrfs/zoned.c:96:		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL);
> fs/btrfs/zoned.c:211:		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
> fs/btrfs/zoned.c:488:			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> fs/btrfs/zoned.c:566:		    BLK_ZONE_TYPE_CONVENTIONAL)
> fs/btrfs/zoned.c:815:	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> fs/btrfs/zoned.c:1360:	if (unlikely(zone.type == 
> BLK_ZONE_TYPE_CONVENTIONAL)) {
> fs/f2fs/segment.c:5295:	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
> fs/f2fs/segment.c:5417:	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
> fs/f2fs/segment.c:5473:	if (zone.type != BLK_ZONE_TYPE_SEQWRITE_REQ)
> fs/f2fs/super.c:4332:	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> fs/xfs/libxfs/xfs_zones.c:177:	case BLK_ZONE_TYPE_CONVENTIONAL:
> fs/xfs/libxfs/xfs_zones.c:179:	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> fs/zonefs/super.c:385:		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
> fs/zonefs/super.c:874:	case BLK_ZONE_TYPE_CONVENTIONAL:
> fs/zonefs/super.c:886:	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> fs/zonefs/super.c:887:	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> fs/zonefs/zonefs.h:26: * defined in linux/blkzoned.h, that is, 
> BLK_ZONE_TYPE_SEQWRITE_REQ and
> fs/zonefs/zonefs.h:27: * BLK_ZONE_TYPE_SEQWRITE_PREF.
> fs/zonefs/zonefs.h:37:	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> 
> In the above I see that all filesystems check for the following zone
> types and don't check whether a zone is empty or full:
> * CONVENTIONAL
> * SEQWRITE_REQ
> * SEQWRITE_PREF
> 
> Do you agree with this conclusion?

Absolutely not.

git grep -nH BLK_ZONE_COND_ fs
fs/btrfs/zoned.c:75:    return (zone->cond == BLK_ZONE_COND_FULL) ||
fs/btrfs/zoned.c:97:            empty[i] = (zones[i].cond == BLK_ZONE_COND_EMPTY);
fs/btrfs/zoned.c:212:           zones[i].cond = BLK_ZONE_COND_NOT_WP;
fs/btrfs/zoned.c:491:                   case BLK_ZONE_COND_EMPTY:
fs/btrfs/zoned.c:494:                   case BLK_ZONE_COND_IMP_OPEN:
fs/btrfs/zoned.c:495:                   case BLK_ZONE_COND_EXP_OPEN:
fs/btrfs/zoned.c:496:                   case BLK_ZONE_COND_CLOSED:
fs/btrfs/zoned.c:497:                   case BLK_ZONE_COND_ACTIVE:
fs/btrfs/zoned.c:833:           if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
fs/btrfs/zoned.c:845:                   reset->cond = BLK_ZONE_COND_EMPTY;
fs/btrfs/zoned.c:967:           if (zone->cond == BLK_ZONE_COND_FULL) {
fs/btrfs/zoned.c:972:           if (zone->cond == BLK_ZONE_COND_EMPTY)
fs/btrfs/zoned.c:973:                   zone->cond = BLK_ZONE_COND_IMP_OPEN;
fs/btrfs/zoned.c:1000:                  zone->cond = BLK_ZONE_COND_FULL;
fs/btrfs/zoned.c:1373:  case BLK_ZONE_COND_OFFLINE:
fs/btrfs/zoned.c:1374:  case BLK_ZONE_COND_READONLY:
fs/btrfs/zoned.c:1381:  case BLK_ZONE_COND_EMPTY:
fs/btrfs/zoned.c:1384:  case BLK_ZONE_COND_FULL:
fs/f2fs/segment.c:5319: if ((!valid_block_cnt && zone->cond ==
BLK_ZONE_COND_EMPTY) ||
fs/f2fs/segment.c:5320:     (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
fs/xfs/libxfs/xfs_zones.c:93:   case BLK_ZONE_COND_EMPTY:
fs/xfs/libxfs/xfs_zones.c:95:   case BLK_ZONE_COND_IMP_OPEN:
fs/xfs/libxfs/xfs_zones.c:96:   case BLK_ZONE_COND_EXP_OPEN:
fs/xfs/libxfs/xfs_zones.c:97:   case BLK_ZONE_COND_CLOSED:
fs/xfs/libxfs/xfs_zones.c:99:   case BLK_ZONE_COND_FULL:
fs/xfs/libxfs/xfs_zones.c:101:  case BLK_ZONE_COND_NOT_WP:
fs/xfs/libxfs/xfs_zones.c:102:  case BLK_ZONE_COND_OFFLINE:
fs/xfs/libxfs/xfs_zones.c:103:  case BLK_ZONE_COND_READONLY:
fs/xfs/libxfs/xfs_zones.c:122:  case BLK_ZONE_COND_NOT_WP:
fs/xfs/xfs_zone_alloc.c:985:    if (!zone || zone->cond == BLK_ZONE_COND_NOT_WP) {
fs/zonefs/super.c:195:  case BLK_ZONE_COND_OFFLINE:
fs/zonefs/super.c:200:  case BLK_ZONE_COND_READONLY:
fs/zonefs/super.c:215:  case BLK_ZONE_COND_FULL:
fs/zonefs/super.c:386:          zone.cond = BLK_ZONE_COND_NOT_WP;
fs/zonefs/super.c:986:                          if (next->cond ==
BLK_ZONE_COND_READONLY &&
fs/zonefs/super.c:987:                              zone->cond !=
BLK_ZONE_COND_OFFLINE)
fs/zonefs/super.c:988:                                  zone->cond =
BLK_ZONE_COND_READONLY;
fs/zonefs/super.c:989:                          else if (next->cond ==
BLK_ZONE_COND_OFFLINE)
fs/zonefs/super.c:990:                                  zone->cond =
BLK_ZONE_COND_OFFLINE;
fs/zonefs/super.c:1034:             (zone->cond == BLK_ZONE_COND_IMP_OPEN ||
fs/zonefs/super.c:1035:              zone->cond == BLK_ZONE_COND_EXP_OPEN)) {

And if you are still not convinced, read the mount code for XFS and BTRFS.
You'll see the point of having a fast cached report zones to speed that up.


-- 
Damien Le Moal
Western Digital Research

