Return-Path: <linux-btrfs+bounces-8654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1F9957A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B328B823
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50243213ED9;
	Tue,  8 Oct 2024 19:32:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from freki.datenkhaos.de (freki.datenkhaos.de [23.88.67.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBF1E0DCC
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.67.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415953; cv=none; b=Hsgpbh4TFsDe/sESNehBG6zpFrTfFABhUoBFiV7JcpIkmQsWf0zzkSkYt18+CVzvZbWAsYLSJBkAvER/eu51Vd1Go4fVJh/cDpJl14o2SPoMDn/JCC8y3Aze2YB46b5smjYmr3EIO8nXI6ilbXvecqZ2XlhCk7NCSVK/0gQ6fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415953; c=relaxed/simple;
	bh=4uY7nHoSRoiGN8qFKweGBwdCa3g5KLGSIYzIfEdX2zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahYq3KDYVuCpKlUsUECxY4ZSr/6L218zvxd4jsem9isFcIxmsSrAL4RUKEDYVv4KOfZQJCV/7iFsFLhsfxmsJxxhLSW+33PXsRWo4tDjiNjrOKa6JQydthXaNhXoOXiIlcczydtqhTFQ5UiqY7XKC89RvZcJflLMCCa0FpG8SxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=datenkhaos.de; spf=pass smtp.mailfrom=datenkhaos.de; arc=none smtp.client-ip=23.88.67.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=datenkhaos.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenkhaos.de
Received: from elitebook (unknown [134.19.35.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by freki.datenkhaos.de (Postfix) with ESMTPSA id 73FDED76D99;
	Tue, 08 Oct 2024 21:32:29 +0200 (CEST)
Date: Tue, 8 Oct 2024 21:32:25 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "cwalou@gmail.com" <cwalou@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
Message-ID: <cuab5thyorquonghaxpqwxkfhog7lgrxzv3a5kdjs2zfw4ulaj@gutzirf5ipiv>
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>

On 2024 Okt 03, Qu Wenruo wrote:
>  
> 在 2024/10/3 17:02, cwalou@gmail.com 写道:
> > Hello.
> > 
> > A 4TB drive taken out of a synology NAS. When I try to mount it, it
> > won't. This is what I did :
> 
> Synology has out-of-tree features that upstream kernel doesn't support.
>

Hello,

I've noticed similar errors on my server too. It's a gentoo box with
vanilla kernel. It happend first with linux-6.10.9 and happens with 6.11
too:

[   67.310316] BTRFS: device label bigraid1 devid 1 transid 98985 /dev/sdd1 (8:49) scanned by mount (4069)
[   67.313109] BTRFS info (device sdd1): first mount of filesystem 83a02224-c807-4e70-a2cd-8b7156bfbbd2
[   67.313137] BTRFS info (device sdd1): using crc32c (crc32c-generic) checksum algorithm
[   67.313156] BTRFS info (device sdd1): using free-space-tree
[   67.527088] page: refcount:4 mapcount:0 mapping:000000004bf8c7c2 index:0x2ffb1be8 pfn:0x11b55c
[   67.527114] memcg:ffff8881174ab800
[   67.527120] aops:0xffffffff8206c960 ino:1
[   67.527129] flags: 0x2000000000004000(private|node=0|zone=2)
[   67.527144] raw: 2000000000004000 0000000000000000 dead000000000122 ffff8881022c9678
[   67.527152] raw: 000000002ffb1be8 ffff88811b5304b0 00000004ffffffff ffff8881174ab800
[   67.527157] page dumped because: eb page dump
[   67.527162] BTRFS critical (device sdd1): corrupt leaf: block=3297221967872 slot=47 extent bytenr=2176663552 len=36864 invalid data ref objectid value 259
[   67.527179] BTRFS error (device sdd1): read time tree block corruption detected on logical 3297221967872 mirror 1
[   67.535814] page: refcount:4 mapcount:0 mapping:000000004bf8c7c2 index:0x2ffb1be8 pfn:0x11b55c
[   67.535872] memcg:ffff8881174ab800
[   67.535877] aops:0xffffffff8206c960 ino:1
[   67.535886] flags: 0x2000000000004000(private|node=0|zone=2)
[   67.535900] raw: 2000000000004000 0000000000000000 dead000000000122 ffff8881022c9678
[   67.535907] raw: 000000002ffb1be8 ffff88811b5304b0 00000004ffffffff ffff8881174ab800
[   67.535912] page dumped because: eb page dump
[   67.535917] BTRFS critical (device sdd1): corrupt leaf: block=3297221967872 slot=47 extent bytenr=2176663552 len=36864 invalid data ref objectid value 259
[   67.535931] BTRFS error (device sdd1): read time tree block corruption detected on logical 3297221967872 mirror 2
[   67.535996] BTRFS error (device sdd1): failed to read block groups: -5
[   67.539666] BTRFS error (device sdd1): open_ctree failed
[   70.026232] BTRFS info (device sdb1): first mount of filesystem cae06473-5f45-4cd4-a822-733c036e36d9
[   70.026270] BTRFS info (device sdb1): using crc32c (crc32c-generic) checksum algorithm
[   70.026300] BTRFS info (device sdb1): disk space caching is enabled
[   70.026306] BTRFS warning (device sdb1): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
[   70.130069] page: refcount:3 mapcount:0 mapping:00000000a884d48d index:0x5abd618 pfn:0x11b665
[   70.130094] memcg:ffff8881174ab800
[   70.130100] aops:0xffffffff8206c960 ino:1
[   70.130110] flags: 0x2400000000004020(lru|private|node=0|zone=2)
[   70.130126] raw: 2400000000004020 ffffea00046d9908 ffffea00046d9988 ffff888102262618
[   70.130134] raw: 0000000005abd618 ffff88811b63a4b0 00000003ffffffff ffff8881174ab800
[   70.130139] page dumped because: eb page dump
[   70.130144] BTRFS critical (device sdb1): corrupt leaf: block=389724340224 slot=7 extent bytenr=12652544 len=36864 invalid data ref objectid value 258
[   70.130160] BTRFS error (device sdb1): read time tree block corruption detected on logical 389724340224 mirror 2
[   70.136382] page: refcount:3 mapcount:0 mapping:00000000a884d48d index:0x5abd618 pfn:0x11b665
[   70.136404] memcg:ffff8881174ab800
[   70.136409] aops:0xffffffff8206c960 ino:1
[   70.136418] flags: 0x2400000000004020(lru|private|node=0|zone=2)
[   70.136431] raw: 2400000000004020 ffffea00046d9908 ffffea00046d9988 ffff888102262618
[   70.136439] raw: 0000000005abd618 ffff88811b63a4b0 00000003ffffffff ffff8881174ab800
[   70.136443] page dumped because: eb page dump
[   70.136448] BTRFS critical (device sdb1): corrupt leaf: block=389724340224 slot=7 extent bytenr=12652544 len=36864 invalid data ref objectid value 258
[   70.136462] BTRFS error (device sdb1): read time tree block corruption detected on logical 389724340224 mirror 1
[   70.136555] BTRFS error (device sdb1): failed to read block groups: -5
[   70.138216] BTRFS error (device sdb1): open_ctree failed
[   71.825004] BTRFS: device label BIGBIGRAID devid 1 transid 4121 /dev/sde1 (8:65) scanned by mount (4102)
[   71.826496] BTRFS info (device sde1): first mount of filesystem c9fa0269-733e-4e76-88c9-68c8247c81e5
[   71.826532] BTRFS info (device sde1): using crc32c (crc32c-generic) checksum algorithm
[   71.826561] BTRFS info (device sde1): using free-space-tree
[  140.718646] BTRFS info (device sdb1): first mount of filesystem cae06473-5f45-4cd4-a822-733c036e36d9
[  140.718683] BTRFS info (device sdb1): using crc32c (crc32c-generic) checksum algorithm
[  140.718711] BTRFS info (device sdb1): disk space caching is enabled
[  140.718717] BTRFS warning (device sdb1): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
[  140.845547] page: refcount:4 mapcount:0 mapping:0000000049bde2be index:0x5abd618 pfn:0x11d9a3
[  140.845571] memcg:ffff8881174ab800
[  140.845578] aops:0xffffffff8206c960 ino:1
[  140.845587] flags: 0x2000000000004000(private|node=0|zone=2)
[  140.845602] raw: 2000000000004000 0000000000000000 dead000000000122 ffff888102262de8
[  140.845611] raw: 0000000005abd618 ffff88811d96f5a0 00000004ffffffff ffff8881174ab800
[  140.845615] page dumped because: eb page dump
[  140.845621] BTRFS critical (device sdb1): corrupt leaf: block=389724340224 slot=7 extent bytenr=12652544 len=36864 invalid data ref objectid value 258
[  140.845636] BTRFS error (device sdb1): read time tree block corruption detected on logical 389724340224 mirror 1
[  140.846180] page: refcount:4 mapcount:0 mapping:0000000049bde2be index:0x5abd618 pfn:0x11d9a3
[  140.846202] memcg:ffff8881174ab800
[  140.846208] aops:0xffffffff8206c960 ino:1
[  140.846216] flags: 0x2000000000004000(private|node=0|zone=2)
[  140.846229] raw: 2000000000004000 0000000000000000 dead000000000122 ffff888102262de8
[  140.846236] raw: 0000000005abd618 ffff88811d96f5a0 00000004ffffffff ffff8881174ab800
[  140.846240] page dumped because: eb page dump
[  140.846245] BTRFS critical (device sdb1): corrupt leaf: block=389724340224 slot=7 extent bytenr=12652544 len=36864 invalid data ref objectid value 258
[  140.846259] BTRFS error (device sdb1): read time tree block corruption detected on logical 389724340224 mirror 2
[  140.846329] BTRFS error (device sdb1): failed to read block groups: -5
[  140.848015] BTRFS error (device sdb1): open_ctree failed


It seems following commit is responsible:

commit f333a3c7e8323499aa65038e77fe8f3199d4e283
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon Jul 15 16:07:07 2024 +0930

    btrfs: tree-checker: validate dref root and objectid


After reverting this, I'm able to mount the filesystems again. There are
three filesystems on this server that are affected, two single disk and
one with two disk in RAID1/0. I was able to copy all data from all
filesytems via rsync without noticing any error when running without
this commit. Also btrfscheck doesn't notice any error. It's just this
commit that prevents these three filesystem from mounting. As I was able
to get all data this is not critical to me. But I think this should be
addressed in some way.

regards,
  Johannes

