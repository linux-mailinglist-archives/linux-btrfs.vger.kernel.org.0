Return-Path: <linux-btrfs+bounces-542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2880224A
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 10:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660CC1C20845
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Dec 2023 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04C8F55;
	Sun,  3 Dec 2023 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="sVOELg5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C247DA
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 01:45:52 -0800 (PST)
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 912079F396;
	Sun,  3 Dec 2023 10:45:49 +0100 (CET)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 3B39jmS22628699
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 3 Dec 2023 10:45:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 3B39jmS22628699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1701596748;
	bh=6AlWhHbHbNrtsdV6wg/xTvJpRsuBWnWI04+uuhCnJSY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sVOELg5M0m2HuftR1Bwg7IfoP9ntfh0cE3RV3ROjzTnw4okM2KB8wokz0zck5cTzE
	 Lq0bL/tfawbFMqcw0Q9xHFrPsWvAq3N34mHf4lUzycFloBdhFnQWVWgxQPgETkQaAq
	 Sp8jHS5E/lYyyUth4zmFS5PO6umYZZMHDVq6JUpA/Rrmq5b01eYJ5aBnHRYY9hiGZ8
	 Rn6tqL7PbfriGoQdBTJvXZvZ/vOnHRRTARfsFlW/aXFst5C5fbOWQhtX8ZG20aR6JR
	 SJgGZ5J7+O/p6RP9EfYzwlCsV4xaf/33580MoX5is/4YNbI/yJ1QTUlDglbnBcHvIf
	 rHhhNdabVSAcgwhy1uIVmIde9KVGwWF6QK3Xvg/RyrdtJqeV+4R64HyDNdcwqeW4xr
	 7UQYvXdMs1hL2+zCsvXYoAfrSzTm+RPyUzi2Ibo0/G0DOdCDs/nq/cL0tU//usRX06
	 qMhLCXUa3mmvt1HRqAEforUIg3ALOXgOHEI0gwFc55xgr+6Pnkm9uqYc13IMtARdq3
	 4EazSAnk7f1ZDD6k3fcjRHyumrkvojT+QAZOc9BSl0ceUmRe2Hn6lq+JJrGleMNhGP
	 0BjGoVKzksw4FyKjQw2gu2Kk9eFfUvRrW9MbCoWO/UzdkgrII2bwlDqaKhPfNJdHKs
	 rtaqsYfMCVQf7+iWB7uBgGiQ=
Message-ID: <771df9a9-c7c3-40a7-a426-0126118d3af0@wiesinger.com>
Date: Sun, 3 Dec 2023 10:45:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
Content-Language: en-GB
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
 <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
 <6ae85272-3967-417e-bc9a-e2141a4c688a@gmx.com>
 <a9fafe9c-27c8-4465-aafa-a4af6987c031@wiesinger.com>
 <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <6c2424bb-9c91-4ac0-970b-613ca97b3e01@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.12.2023 10:11, Qu Wenruo wrote:
>
>>
>> Thank you for reproducting it. Think we nailed it down.
>>
>> Is there a way to get the output of the file of the chunks/items?
>
> You can always dump the full subvolume (`btrfs ins dump-tree -t
> <subvolid> <device>`), then try to grep the inode which has PREALLOC
> alloc (`| grep -C 5 "flags.*PREALLOC"), which would include the inode
> number, then you can ping down the inodes which has PREALLOC flags and
> not undergoing compression.
>
> I won't be surprised most (if not all) files of postgresql would have
> that flag.

Looks like only a small part has PREALLOC:

find /var/lib/pgsql -type f | wc -l
5569

btrfs inspect-internal dump-tree /dev/mapper/datab | grep -i PREALLOC | 
wc -l
95

For reference:

How to find the file at a certain btrfs inode
https://serverfault.com/questions/746938/how-to-find-the-file-at-a-certain-btrfs-inode

btrfs inspect-internal inode-resolve 13269 /var/lib/pgsql
/var/lib/pgsql/16/data/base/16400/16419

find /var/lib/pgsql -xdev -inum 13269
/var/lib/pgsql/16/data/base/16400/16419

# Get  files from inodes

btrfs inspect-internal dump-tree /dev/mapper/datab | grep -C 5 
"flags.*PREALLOC" | grep -i INODE | perl -pe 's/.*?\((.*?) .*/$1/' | 
sort | uniq | while read INODE; do echo -n "$INODE: ";btrfs 
inspect-internal inode-resolve ${INODE} /var/lib/pgsql; done

# Number of inodes, count is consistent

btrfs inspect-internal dump-tree /dev/mapper/datab | grep -C 5 
"flags.*PREALLOC" | grep -i INODE | perl -pe 's/.*?\((.*?) .*/$1/' | 
sort | uniq | while read INODE; do echo -n "$INODE: ";btrfs 
inspect-internal inode-resolve ${INODE} /var/lib/pgsql; done | wc -l

95

All files are in subdirectories: /var/lib/pgsql/16/data/base/

Already an idea for the fix?

BTW:

if compression is forced, should be then just any "block" be compressed?

Or, what's the problem of the logic?

Thnx.

Ciao,

Gerhard


