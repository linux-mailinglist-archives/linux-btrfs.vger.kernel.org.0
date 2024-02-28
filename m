Return-Path: <linux-btrfs+bounces-2878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BB786B80A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036FAB266F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1C74435;
	Wed, 28 Feb 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="dJ8ixu9x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765E7442D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148115; cv=none; b=RnFTsxgjY4D6rs7OQUEGh/pvM9EJrlMHIYQHzB813Wkf9TwDAElhnmsNTNaLd/E9TfkWZG1EB5r+qNoKUW+zDzlKdZDfAUnsfKvgfAA6CtMF+giNgPMdWQbZB3UyYXbQXLW+T32ENIBYFzH6x78oNZgDaiWYT/+Vd4LH1TWMDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148115; c=relaxed/simple;
	bh=2/xQVcpUfKY89HPCRFaCviw7T/ATDKBu5ZO5Q6qlbv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDV6LqBECzbimWAubPk4HNSGCvnmBMISmFhSvt8oiGJayR7uwlfpGDdt5ACLzgpoqDltox6kDKun3XBWEMns4PIZ+rubJhK3GLelqwgF+KuvrAvbr7U6OW0u5Z5VkXRQvWhOCM5btK/j107Er/rg8JrFN4rVfuz7lzLUFe3tuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=dJ8ixu9x; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id fPSSrAlQ5L93EfPSSrxO42; Wed, 28 Feb 2024 20:19:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1709147953; bh=QnVc41Vw/MytZeyexdJ1gTgi6wR39ywRKKBoBHj680w=;
	h=From;
	b=dJ8ixu9xmNhsLcqXVychkqIhappcQAp8glpWGeYRKdwFeH7Qnu1f+lggBVk7Jc2c4
	 ky7YbRyfElBUT15VypuHso/LKUBa+EIMbA3tjGuMFgcNZJLq1Tq9vrVPl4J3L2vP2Z
	 NehP7krhNrKYvJ2IR6ZBxkTvyPhF+gSWcnmm4kveXSzfPQ80w+Ke2+HDL05yTEJYzl
	 XwKvJ4OYl2H0mKoICG4MUNB7vTxUvY4r+eWcazBU3eekdu/wFY3W3f0d62gNfePP0B
	 pD4z+X12Do+KtYv0GqhpSBWolL+CwPteo/zDuWPDfb/wVSnbrNGC4rJIdVsCn1gDmf
	 73jB/KlppweZg==
X-CNFS-Analysis: v=2.4 cv=B7Ia0/tM c=1 sm=1 tr=0 ts=65df8731 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=zCnXDZGV-rsmL1SA_eoA:9 a=QEXdDO2ut3YA:10
Message-ID: <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
Date: Wed, 28 Feb 2024 20:19:12 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [REGRESSION] LVM-on-LVM: error while submitting device barriers
Content-Language: en-US
To: Patrick Plenefisch <simonpatp@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 regressions@lists.linux.dev, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org
References: <CAOCpoWc_HQy4UJzTi9pqtJdO740Wx5Yd702O-mwXBE6RVBX1Eg@mail.gmail.com>
 <CAOCpoWf3TSQkUUo-qsj0LVEOm-kY0hXdmttLE82Ytc0hjpTSPw@mail.gmail.com>
 <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOO9Lg10Vh7tBG+9Jztc8Unc4rdDDgR6F/QFGXRd/XEj/mZa1KA/dgldmapSAy81XrNXTTQP8r1n+By0Gxmdm/c/BH0AhwKBI3pIC+9d50HIB7NvNX3O
 v/WArD0gmEWPm5D5Whpz0j3+XBQtpOsinXkJIJzqdusMkcLEnnqKYgiX58/eQFV6zvxC4FpnLvaZSqqAyijnCF9D9eMkFHfXGUMDpXN/YDElPUSn0af/nrBG
 rLFeStdBZ4TgS3EUV+W0Omn+cq6c/XRd66BUpLv28H+6CUDazT0QXLoDcDplCp0U29zQLMavNy3fSTrwt3uG0ZE2p3X9VsQVTOrgVvSjBdaZdrN9rSb+oPuw
 dhlOY5UO7nv355jUDip50bIVRU089ePxpGLSdt9kvuWCLkBGGdU+NeoB9ZD4AxK8COSDiZF9BBHcV/sMPKAy7YojKFgVWAwEFeO6iDzIZ/OLVP78qOU09/Vq
 FgzAO9/usFFKZvdd1fAbSxj23FP0SKJcF+vyQYgppy1bIjZPIPrLI/Klgs9nbQf6sCwDF6QKLgnd+5pX

On 28/02/2024 18.25, Patrick Plenefisch wrote:
> I'm unsure if this is just an LVM bug, or a BTRFS+LVM interaction bug,
> but LVM is definitely involved somehow.
> Upgrading from 5.10 to 6.1, I noticed one of my filesystems was
> read-only. In dmesg, I found:
> 
> BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> 0, rd 0, flush 1, corrupt 0, gen 0
> BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> tolerance is 0 for writable mount
> BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> failure (errors while submitting device barriers.)
> BTRFS info (device dm-75: state E): forced readonly
> BTRFS warning (device dm-75: state E): Skipping commit of aborted transaction.
> BTRFS: error (device dm-75: state EA) in cleanup_transaction:1992:
> errno=-5 IO failure
> 
> At first I suspected a btrfs error, but a scrub found no errors, and
> it continued to be read-write on 5.10 kernels.
> 
> Here is my setup:
> 
> /dev/lvm/brokenDisk is a lvm-on-lvm volume. I have /dev/sd{a,b,c,d}
> (of varying sizes) in a lower VG, which has three LVs, all raid1
> volumes. Two of the volumes are further used as PV's for an upper VGs.
> One of the upper VGs has no issues. The non-PV LV has no issue. The
> remaining one, /dev/lowerVG/lvmPool, hosting nested LVM, is used as a
> PV for VG "lvm", and has 3 volumes inside. Two of those volumes have
> no issues (and are btrfs), but the last one is /dev/lvm/brokenDisk.
> This volume is the only one that exhibits this behavior, so something
> is special.
> 
> Or described as layers:
> /dev/sd{a,b,c,d} => PV => VG "lowerVG"
> /dev/lowerVG/single (RAID1 LV) => BTRFS, works fine
> /dev/lowerVG/works (RAID1 LV) => PV => VG "workingUpper"
> /dev/workingUpper/{a,b,c} => BTRFS, works fine
> /dev/lowerVG/lvmPool (RAID1 LV) => PV => VG "lvm"
> /dev/lvm/{a,b} => BTRFS, works fine
> /dev/lvm/brokenDisk => BTRFS, Exhibits errors

I am a bit curious about the reasons of this setup. However I understood that:

/dev/sda -+                +-- single (RAID1) -> ok             +-> a   ok
/dev/sdb  |                |                                    |-> b   ok
/dev/sdc  +--> [lowerVG]>--+-- works (RAID1) -> [workingUpper] -+-> c   ok
/dev/sdd -+                |
                            |                       +-> a          -> ok
                            +-- lvmPool -> [lvm] ->-|
                                                    +-> b          -> ok
                                                    |
                                                    +->brokenDisk  -> fail

[xxx] means VG, the others are LVs that may act also as PV in
an upper VG

So, it seems that

1) lowerVG/lvmPool/lvm/a
2) lowerVG/lvmPool/lvm/a
3) lowerVG/lvmPool/lvm/brokenDisk

are equivalent ... so I don't understand how 1) and 2) are fine but 3) is
problematic.

Is my understanding of the LVM layouts correct ?


> 
> After some investigation, here is what I've found:
> 
> 1. This regression was introduced in 5.19. 5.18 and earlier kernels I
> can keep this filesystem rw and everything works as expected, while
> 5.19.0 and later the filesystem is immediately ro on any write
> attempt. I couldn't build rc1, but I did confirm rc2 already has this
> regression.
> 2. Passing /dev/lvm/brokenDisk to a KVM VM as /dev/vdb with an
> unaffected kernel inside the vm exhibits the ro barrier problem on
> unaffected kernels.

Is /dev/lvm/brokenDisk *always* problematic with affected ( >= 5.19 ) and
UNaffected ( < 5.19 ) kernel ?

> 3. Passing /dev/lowerVG/lvmPool to a KVM VM as /dev/vdb with an
> affected kernel inside the VM and using LVM inside the VM exhibits
> correct behavior (I can keep the filesystem rw, no barrier errors on
> host or guest)

Is /dev/lowerVG/lvmPool problematic with only "affected" kernel ?

[...]

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


