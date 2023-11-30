Return-Path: <linux-btrfs+bounces-450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543467FEDD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB6A1F20B59
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10F33C693;
	Thu, 30 Nov 2023 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="JA6e2HI7"
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 03:29:14 PST
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A2170B
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 03:29:14 -0800 (PST)
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 9AEAA9F38F
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 12:21:59 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id 3AUBLwK42435928
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 12:21:58 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 3AUBLwK42435928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1701343318;
	bh=fyM2cnoJIlcDVFEWJE7Y/R6O7J/LFUnGoRyJVwlZo8Y=;
	h=Date:To:From:Subject:From;
	b=JA6e2HI74d9bJ9yTglClgtKMltpNF5td1UQAVbIpSu3ocuLIaNj8kTLOyG9FeoMTQ
	 h4tyIJBQEpI8FnR2gpMETcDodcusjQ6gMMTcM3Qj61+rgyXZh0Li2FDB1Tsb4OCdnz
	 pMdCQGMJ3O99FFqDxIpGbNeySFsa6V3hHaJ5EswRGKZjHC6qIwOVuS39e25sJ1O3kA
	 W7gU668iFj5GHXWaRrp1y6en4K9H7Lr61eODD2NFnfginxALq4icb7bFzc0UL33DkA
	 0kyjYCl+hRIsyNmXZRS00hXMZXE6SZx+nzsm06z0ZIUsqyVa/Bb52E7fGvyXRZRIbN
	 ZOKb2c8HvHSgdFZUi9R0HiJaOGLmvYx9n44TNxrHMwbIqwGDUWP5WWjaBU734vsSVK
	 IQaitG+dia50hR8tzZWhjM9WAC0Gdm/rlFdmZQc3I19ObRpI6+oQzTIt2+59v9nf97
	 iPLkq3DJ+FSKIHYSt0qyaWT2QNimnNPQn5CTes3Vs7vItnGjX3OZs886RhZ8K99U8A
	 W26Aw5TDB564QNgUaHlvkLHFOZh5dtF1OkF6fGUxAjNRZPf+PZWJiYFUr4rD/GTcA4
	 gHmZiYDhkhOAdke/4+43effmoecXXh2+qpEJD5uhbP0u11MngqkfOvEV5hxumyOgDj
	 45y4Lba0VNCT6yT6TPuwvXtE=
Message-ID: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
Date: Thu, 30 Nov 2023 12:21:58 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-btrfs@vger.kernel.org
From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: BTRFS doesn't compress on the fly
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear All,

I created a new BTRFS volume with migrating an existing PostgreSQL 
database on it. Versions are recent.

Compression is not done on the fly although everything is IMHO 
configured correctly to do so.

I need to run the following command that everything gets compressed:
btrfs filesystem defragment -r -v -czstd /var/lib/pgsql

Had also a problem that
chattr -R +c /var/lib/pgsql
didn't work for some files.

Find further details below.

Looks like a bug to me.

Any ideas?

Thanx.

Ciao,
Gerhard

uname -a
Linux myhostname 6.5.12-300.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Nov 
20 22:44:24 UTC 2023 x86_64 GNU/Linux

btrfs --version
btrfs-progs v6.5.1

btrfs filesystem show
Label: 'database'  uuid: 6ad6ef90-30fa-4979-9509-99803f7545aa
         Total devices 1 FS bytes used 15.76GiB
         devid    1 size 129.98GiB used 21.06GiB path /dev/mapper/datab

btrfs filesystem df /var/lib/pgsql
Data, single: total=19.00GiB, used=15.61GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.00GiB, used=151.92MiB
GlobalReserve, single: total=85.38MiB, used=0.00B

# Mounted via force
findmnt -vno OPTIONS /var/lib/pgsql
rw,relatime,compress-force=zstd:3,space_cache=v2,subvolid=5,subvol=/

# all files even have "c" attribute, set after creation of the filesystem
lsattr /var/lib/pgsql
--------c------------- /var/lib/pgsql/16

# Should be empty and is empty, so everything has the comressed 
attribute (after creation and also all new files)
lsattr -R /var/lib/pgsql | grep -v "^/" | grep -v "^$" | grep -v 
"^........c"

# Stays here at this compression level
compsize -x /var/lib/pgsql
Processed 5332 files, 575858 regular extents (591204 refs), 40 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       63%       51G          80G          80G
none       100%       40G          40G          40G
zstd        27%       10G          40G          40G
prealloc   100%      5.0M         5.0M         5.5M

# After running: btrfs filesystem defragment -r -v -czstd /var/lib/pgsql
compsize -x /var/lib/pgsql
Processed 5563 files, 664076 regular extents (664076 refs), 40 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       19%       15G          80G          80G
none       100%      120K         120K         120K
zstd        19%       15G          80G          80G

# At the first time creating the filesystem I had also the problem that 
I couln't change all attributes, didn't find a way to get rid of this. 
Any ideas.
chattr -R +c /var/lib/pgsql
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/1/2836
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/1/2840
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/1/2838
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/4/2836
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/4/2838
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/5/2836
chattr: Invalid argument while setting flags on 
/var/lib/pgsql/16/data/base/5/2838


