Return-Path: <linux-btrfs+bounces-2946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1BE86D3D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDA22897A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95513F453;
	Thu, 29 Feb 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="mBjgJsd2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710513C9F7
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236745; cv=none; b=OQjuVfu1Th/bx+uOAhYGmf1kIPQrpnJww71LHqbESBL4KSUwOET3GxuCgVe5qujdYK8NcZ+xqMCW/OvXA0KATEu7Ujurc1+73yyy3fIdcTnfxJTqe7c9LQA/UjIyG3R8MJPv5I/W9jN9b2WtSxdYqm+4CFV+ojh+5iBKbonImXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236745; c=relaxed/simple;
	bh=+/0AdQcFnCfKSegEZy9hvrIJ2WMIF7WuqRskgOhMmvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2v16WXYTc8Ln8n00fLZ+jCmbraGuYdxS0SVF94lv+P9GyK35aud1mgciCPcfWtg2CjuzJzmgy3K7MXqO+XEt7ZmnZv4VH1BmdReIKUi8VorOKB0JHbcU3CAOjtZ6KovT7YidjR4lS9OCVu/xonbQBwDedxi7JEoFnpAPCLNw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=mBjgJsd2; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id fmVzrGLJ8Qc3jfmVzrPC4e; Thu, 29 Feb 2024 20:56:24 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1709236584; bh=KNMmVtwjCgAMs7Ls0x332y2Nu0DyVg7DMv03VS4jYnw=;
	h=From;
	b=mBjgJsd2FOM5gF2X3VPG0AuVkNN6Bm8VfgzC0+ewg4jEWxiSA1A5QXp/H2hb89RHa
	 bgfOVBAAV19uFqXAqfL8eol3Hbmq1DmxiNyhPK22ojbAApB2pzizRcrVvnUd56/nNg
	 cRis+zv4GThU+oS9Y/MkfK3uhf1PEir76RU6bJwm8ZZQj2SK+c2N8sObqEvYcnfPJs
	 DMeLI+Y/8ItwwZ/cLvPhI9SGgpDLVCuNMZvWwkePjF5FKtaw0v569VKBigaQHtyh+X
	 vW8Uhv4zOvxjhu84QdVIzN9LtHdURh0/RHMGJXW5re2loQ/csVbBZj4p+tIkL4QUx7
	 /ARychO+EPSbQ==
X-CNFS-Analysis: v=2.4 cv=eux8zZpX c=1 sm=1 tr=0 ts=65e0e168 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=9R-lXduunLBbFm3wDKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
Date: Thu, 29 Feb 2024 20:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [REGRESSION] LVM-on-LVM: error while submitting device barriers
To: Patrick Plenefisch <simonpatp@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 regressions@lists.linux.dev, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFFPqikg0kgTh/gIJQWHawLgDrsbPCU3GCW7mI9p9TSSqH9ewwJnrsRrMdphS9tkBIF5fOvJni9wo8Gah+BIW7X+kkX5zc6NSs3NqYbBFaiquGYpqp+/
 kezzOE5v/asqjI4k/ZfXiQC/iciMe0oDQCZOdqceT4R+QNdO76S+w6I39N+czryMoJMIZQW2ViS2RJd4D6OhdHfLpyoOPEa7d+I37byQMUvwLTwLkVbD4Yi5
 MdyTy9Dr0PZA66HKuRZKIIH3Y6Fdbo1dJIdi5bkHEVAIUSPRnYGePlWlzY2Hzf/s6tajwwmxFTjjF14t1UfQOlhtbEBWmXZevo+t7kgvyfF6iuBFzBcAF382
 7otqpKvUDLut7JHTiGQBuOkiwiD00LGAbYJocSh/Aoq/7zOmwzdMg2a2YRtkP3hlM3rZZoqtVXX+tu8f68NSHfEGFy1+GwgTHW3DpF/PVuNfHx3JBv5pB2Zz
 9A26lW/pGrfxGMQIBNyTtrljGtrtjQzb5q8MagRRNIZFt2yzW6Ww/V2CL1HWW1X2yrcXsJk/xqNz48tP

On 28/02/2024 20.37, Patrick Plenefisch wrote:
> On Wed, Feb 28, 2024 at 2:19 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>
>> On 28/02/2024 18.25, Patrick Plenefisch wrote:
>>> I'm unsure if this is just an LVM bug, or a BTRFS+LVM interaction bug,
>>> but LVM is definitely involved somehow.
>>> Upgrading from 5.10 to 6.1, I noticed one of my filesystems was
>>> read-only. In dmesg, I found:
>>>
>>> BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
>>> 0, rd 0, flush 1, corrupt 0, gen 0
>>> BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
>>> tolerance is 0 for writable mount
>>> BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
>>> failure (errors while submitting device barriers.)
>>> BTRFS info (device dm-75: state E): forced readonly
>>> BTRFS warning (device dm-75: state E): Skipping commit of aborted transaction.
>>> BTRFS: error (device dm-75: state EA) in cleanup_transaction:1992:
>>> errno=-5 IO failure
>>>
>>> At first I suspected a btrfs error, but a scrub found no errors, and
>>> it continued to be read-write on 5.10 kernels.
>>>
>>> Here is my setup:
>>>
>>> /dev/lvm/brokenDisk is a lvm-on-lvm volume. I have /dev/sd{a,b,c,d}
>>> (of varying sizes) in a lower VG, which has three LVs, all raid1
>>> volumes. Two of the volumes are further used as PV's for an upper VGs.
>>> One of the upper VGs has no issues. The non-PV LV has no issue. The
>>> remaining one, /dev/lowerVG/lvmPool, hosting nested LVM, is used as a
>>> PV for VG "lvm", and has 3 volumes inside. Two of those volumes have
>>> no issues (and are btrfs), but the last one is /dev/lvm/brokenDisk.
>>> This volume is the only one that exhibits this behavior, so something
>>> is special.
>>>
>>> Or described as layers:
>>> /dev/sd{a,b,c,d} => PV => VG "lowerVG"
>>> /dev/lowerVG/single (RAID1 LV) => BTRFS, works fine
>>> /dev/lowerVG/works (RAID1 LV) => PV => VG "workingUpper"
>>> /dev/workingUpper/{a,b,c} => BTRFS, works fine
>>> /dev/lowerVG/lvmPool (RAID1 LV) => PV => VG "lvm"
>>> /dev/lvm/{a,b} => BTRFS, works fine
>>> /dev/lvm/brokenDisk => BTRFS, Exhibits errors
>>
>> I am a bit curious about the reasons of this setup.
> 
> The lowerVG is supposed to be a pool of storage for several VM's &
> containers. [workingUpper] is for one VM, and [lvm] is for another VM.
> However right now I'm still trying to organize the files directly
> because I don't have all the VM's fully setup yet
> 
>> However I understood that:
>>
>> /dev/sda -+                +-- single (RAID1) -> ok             +-> a   ok
>> /dev/sdb  |                |                                    |-> b   ok
>> /dev/sdc  +--> [lowerVG]>--+-- works (RAID1) -> [workingUpper] -+-> c   ok
>> /dev/sdd -+                |
>>                              |                       +-> a          -> ok
>>                              +-- lvmPool (raid1)-> [lvm] ->-|
>>                                                      +-> b          -> ok
>>                                                      |
>>                                                      +->brokenDisk  -> fail
>>
>> [xxx] means VG, the others are LVs that may act also as PV in
>> an upper VG
> 
> Note that lvmPool is also RAID1, but yes
> 
>>
>> So, it seems that
>>
>> 1) lowerVG/lvmPool/lvm/a
>> 2) lowerVG/lvmPool/lvm/a
>> 3) lowerVG/lvmPool/lvm/brokenDisk
>>
>> are equivalent ... so I don't understand how 1) and 2) are fine but 3) is
>> problematic.
> 
> I assume you meant  lvm/b for 2?

Yes

>>
>> Is my understanding of the LVM layouts correct ?
> 
> Your understanding is correct. The only thing that comes to my mind to
> cause the problem is asymmetry of the SATA devices. I have one 8TB
> device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> extents, lowerVG/single spans (3TB+3TB), and
> lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> the other leg of raid1 on the 8TB drive, but my thought was that the
> jump across the 1.5+3TB drive gap was at least "interesting"


what about lowerVG/works ?

However yes, I agree that the pair of disks involved may be the answer
of the problem.

Could you show us the output of

$ sudo pvdisplay -m

> 
>>
>>
>>>
>>> After some investigation, here is what I've found:
>>>
>>> 1. This regression was introduced in 5.19. 5.18 and earlier kernels I
>>> can keep this filesystem rw and everything works as expected, while
>>> 5.19.0 and later the filesystem is immediately ro on any write
>>> attempt. I couldn't build rc1, but I did confirm rc2 already has this
>>> regression.
>>> 2. Passing /dev/lvm/brokenDisk to a KVM VM as /dev/vdb with an
>>> unaffected kernel inside the vm exhibits the ro barrier problem on
>>> unaffected kernels.
>>
>> Is /dev/lvm/brokenDisk *always* problematic with affected ( >= 5.19 ) and
>> UNaffected ( < 5.19 ) kernel ?
> 
> Yes, I didn't test it in as much depth, but 5.15 and 6.1 in the VM
> (and 6.1 on the host) are identically problematic
> 
>>
>>> 3. Passing /dev/lowerVG/lvmPool to a KVM VM as /dev/vdb with an
>>> affected kernel inside the VM and using LVM inside the VM exhibits
>>> correct behavior (I can keep the filesystem rw, no barrier errors on
>>> host or guest)
>>
>> Is /dev/lowerVG/lvmPool problematic with only "affected" kernel ?
> 
> Uh, passing lvmPool directly to the VM is never problematic. I tested
> 5.10 and 6.1 in the VM (and 6.1 on the host), and neither setup throws
> barrier errors.
> 
>> [...]
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


