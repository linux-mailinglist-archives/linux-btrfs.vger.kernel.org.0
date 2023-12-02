Return-Path: <linux-btrfs+bounces-537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58B801C7D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 13:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A497B20E0B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CD168A4;
	Sat,  2 Dec 2023 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="ZjjEUj4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CB1A6
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Dec 2023 04:03:06 -0800 (PST)
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 9851E9F31E;
	Sat,  2 Dec 2023 13:03:03 +0100 (CET)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 3B2C2urf2569232
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 2 Dec 2023 13:03:02 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 3B2C2urf2569232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1701518582;
	bh=FTomZLGeMY909fZNWxAzcUwEF6vd5Q4lJ25XeACDRdo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZjjEUj4dJ098fWOaCLyjcuzOFR22dbNdioRDE012ncZAm8j+YfN+xZoa0NrPaUQqx
	 9UUI8r3VDPRGfW06Rn0KbtbOb4E9v9xjtsH0kNEy3kMw8hFT/DjUN9yT4Am9ZNv4/J
	 eiuIyjwRj85ATaI7rWOEhF7wvroY8P1KuldPCV7IB60GlK+a9ma4sGd1pDIDmsLOg7
	 nWv0WMKIQP0ILFXVon/RHTiblbXc/oOKZQs0EoC7jb9iU2z7GbLgfUWnD9hPP1mXWx
	 ncHcNozDp6H79nL3+QM1l/717vD1BuOfJ4lgSrVTzaReYmkR4LC7HLOnq/aXOlRLTg
	 n8KheLCrGXkEJyH1xOAYqUdw1nxSm52JfRm03HOl0F0zzY46moiWpSCXcQ6dJ6mCBG
	 3g+0vXIP5rzmQNutI/JaZQ16RviJmZYBzSexXR6T4tzWeANBolFrdeKmB7ltpxBNOs
	 Zxs5wS40XQbHHgSD7auL6SdnCio2+dY8/66qOmVYiF+xxsw55JKXnCsQd7mCtafYLR
	 BsRSWQfuX6GD+VSF6WCuEY2EGt7BtsGKZS1VPqrv6cXHRbb/T5wNBQmqea9SaGegxP
	 1W00e7TIgRrs6EU+2T4Vs9+s0tq5SBrqRBx6HAPZKJxyUZCGY6NRFssjVMaKx+cg0E
	 x34cHkk3SUT4tonpVSyv0HOc=
Message-ID: <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
Date: Sat, 2 Dec 2023 13:02:56 +0100
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
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Qu,

Thank you for the answers, see inline.

Any further ideas?

Ciao,
Gerhard.

On 30.11.2023 21:53, Qu Wenruo wrote:
>
>
> On 2023/11/30 21:51, Gerhard Wiesinger wrote:
>> Dear All,
>>
>> I created a new BTRFS volume with migrating an existing PostgreSQL
>> database on it. Versions are recent.
>
> Does the data base directory has something like NODATACOW or NODATASUM 
> set?
> The other possibility is preallocation, for the first write on
> preallocated range, no matter if the compression is enabled, the write
> would be treated as NOCOW.
>
I don't think so. How to find out (googled already a lot)?

At least it is not mounted with these options (see also original post).

# Mounted via force
findmnt -vno OPTIONS /var/lib/pgsql
rw,relatime,compress-force=zstd:3,space_cache=v2,subvolid=5,subvol=/'

According to the following link it should compress anyway with the -o 
compress-force option:

https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Compression.html#What.27s_the_precedence_of_all_the_options_affecting_compression.3F
Compression to newly written data happens:
always -- if the filesystem is mounted with -o compress-force
never -- if the NOCOMPRESS flag is set per-file/-directory
if possible -- if the COMPRESS per-file flag (aka chattr +c) is set, but 
it may get converted to NOCOMPRESS eventually
if possible -- if the -o compress mount option is specified
Note, that mounting with -o compress will not set the +c file attribute.

>>
>> Compression is not done on the fly although everything is IMHO
>> configured correctly to do so.
>>
>> I need to run the following command that everything gets compressed:
>> btrfs filesystem defragment -r -v -czstd /var/lib/pgsql
>>
>> Had also a problem that
>> chattr -R +c /var/lib/pgsql
>> didn't work for some files.
>>
>> Find further details below.
>>
>> Looks like a bug to me.
>>
>> Any ideas?
>>
>> Thanx.
>>
>> Ciao,
>> Gerhard
>>
>> uname -a
>> Linux myhostname 6.5.12-300.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Nov
>> 20 22:44:24 UTC 2023 x86_64 GNU/Linux
>>
>> btrfs --version
>> btrfs-progs v6.5.1
>>
>> btrfs filesystem show
>> Label: 'database'  uuid: 6ad6ef90-30fa-4979-9509-99803f7545aa
>>          Total devices 1 FS bytes used 15.76GiB
>>          devid    1 size 129.98GiB used 21.06GiB path /dev/mapper/datab
>>
>> btrfs filesystem df /var/lib/pgsql
>> Data, single: total=19.00GiB, used=15.61GiB
>> System, DUP: total=32.00MiB, used=16.00KiB
>> Metadata, DUP: total=1.00GiB, used=151.92MiB
>> GlobalReserve, single: total=85.38MiB, used=0.00B
>>
>> # Mounted via force
>> findmnt -vno OPTIONS /var/lib/pgsql
>> rw,relatime,compress-force=zstd:3,space_cache=v2,subvolid=5,subvol=/'
>>
>> # all files even have "c" attribute, set after creation of the 
>> filesystem
>> lsattr /var/lib/pgsql
>> --------c------------- /var/lib/pgsql/16
>>
>> # Should be empty and is empty, so everything has the comressed
>> attribute (after creation and also all new files)
>> lsattr -R /var/lib/pgsql | grep -v "^/" | grep -v "^$" | grep -v
>> "^........c"
>>
>> # Stays here at this compression level
>> compsize -x /var/lib/pgsql
>> Processed 5332 files, 575858 regular extents (591204 refs), 40 inline.
>> Type       Perc     Disk Usage   Uncompressed Referenced
>> TOTAL       63%       51G          80G          80G
>> none       100%       40G          40G          40G
>> zstd        27%       10G          40G          40G
>> prealloc   100%      5.0M         5.0M         5.5M
>
> Not sure if the preallocation is the cause, but maybe you can try
> disabling preallocation of postgresql?
>
> As preallocation doesn't make that much sense on btrfs, there are too
> many cases that can break the preallocation.


I googled a lot and didn't find anything useful with preallocation and 
postgresql (looks like it doesn'use fallocate).

How can I find something about preallocation out?



