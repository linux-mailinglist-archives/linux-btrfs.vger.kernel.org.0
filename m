Return-Path: <linux-btrfs+bounces-4468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2B8AC11D
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Apr 2024 21:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA7C1F21027
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Apr 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344841C87;
	Sun, 21 Apr 2024 19:52:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE3111AD
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Apr 2024 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713729168; cv=none; b=IqPeketTaU44KgMkp8NJxbxRHGsK3AfR1IHPP6VPRPdFWp7ZUx7INx88PSJ0T7Zx7vgw0Lyo3Dbf1WmHuTGdRuxLgT9CuqCHqAL9jgkUMhJ1kGDre95ToRZLDPw7aMG/hbLQvHcdgYf73oJmn4ktLnjB+eq+oZiWohq1Nmz2NlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713729168; c=relaxed/simple;
	bh=LDxTXMF1jDDx15KyrHW9fgyzBIDCLLWExk3RERTARl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2tTfEt97eHjJxEO4vz3wcUtVPMpdYuJAUNgVWyQI++za8PGuBOID7qKRwauOScahCa8kuMEalrgMS2YgsrIGGdBlfvDjyLjlC3Ry9klbnQX5Jr3JnZ7K8ahUyf+bcQZVAke89mdCZFMN7hkgspU+5sw+dvnVHdv/Lxq5QplHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id E252FC035BF;
	Sun, 21 Apr 2024 21:52:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DcQfMWR7cauk; Sun, 21 Apr 2024 21:52:33 +0200 (CEST)
Received: from [192.168.55.110] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 2CB08C035BE;
	Sun, 21 Apr 2024 21:52:33 +0200 (CEST)
Message-ID: <355d9764-f0e9-4c9d-9b3b-b78ae7f63562@dubiel.pl>
Date: Sun, 21 Apr 2024 21:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_enospc_errors_during_balance_=E2=80=94_how_to_preve?=
 =?UTF-8?Q?nt_out_of_space?=
To: Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
 <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
 <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
 <3aefeb1.20bf1a80.18ee7da3d40@tnonline.net>
 <99701acc-161b-477c-b1b3-d61e95903045@dubiel.pl>
 <909ed27.f7893fdf.18f020ff6fc@tnonline.net>
Content-Language: pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <909ed27.f7893fdf.18f020ff6fc@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



 >>
 >>
 >>> It would be better to have more, to be safe.
 >>>
 >>> An option that could be used is 'bg_reclaim_threshold', which is a 
sysfs knob to let the kernel automatically reclaim (balance) block 
groups that fall under a specific threshold.
 >>>
 >>> https://btrfs.readthedocs.io/en/latest/ch-sysfs.html
 >>
 >> On my system it is set to 75.
 >>
 >
 > It is '0' as default. There are two different sysfs files with that 
name. You should look the one at:
 >
 >  /sys/fs/btrfs/<uuid>/allocation/data/


Thank you.

One file has 75 and other 0.



# grep . /sys/fs/btrfs/*/{,allocation/data}/bg_reclaim_threshold

/sys/fs/btrfs/6ff9a384-3dad-4309-803d-c1b9555941f6/bg_reclaim_threshold:75
/sys/fs/btrfs/772bbbcf-78b6-45a5-9d50-e7fd100f09e0/bg_reclaim_threshold:75

/sys/fs/btrfs/6ff9a384-3dad-4309-803d-c1b9555941f6/allocation/data/bg_reclaim_threshold:0
/sys/fs/btrfs/772bbbcf-78b6-45a5-9d50-e7fd100f09e0/allocation/data/bg_reclaim_threshold:0





# btrfs dev usa /mnt/*
/dev/sdb2, ID: 1
    Device size:             5.43TiB
    Device slack:            3.50KiB
    Data,single:             4.95TiB
    Metadata,DUP:           80.00GiB
    System,DUP:             16.00MiB
    Unallocated:           409.00GiB


/dev/sdc1, ID: 1
    Device size:             1.82TiB
    Device slack:            3.50KiB
    Data,single:             1.77TiB
    Metadata,DUP:           48.01GiB
    System,DUP:             64.00MiB
    Unallocated:             1.00GiB    <--- low unallocated





Current script to take care of Unallocated space.


         findmnt --types btrfs --output "SOURCE" --nofsroot --noheading 
| sort | uniq |
         while read dev; do
                 mnt="$(findmnt --types btrfs --first-only --noheadings 
--output "TARGET" --source "$dev")"

                 # no balance if plenty of unallocated space
                 btrfs dev usage "$mnt" -g |
                 perl -ne '/Unallocated: +([0-9]+\.[0-9]{2})GiB/ and $1 
< 9 and print $1' |
                 grep -q . || continue

                 for typ in dusage musage; do
                         for usa in $(seq 0 10 90); do
                                 # if relocated, then get out of two 
loops for next "$dev"
                                 btrfs balance start -$typ=$usa,limit=3 
"$mnt" 2>&1 |
                                 grep -Eq "Done, had to relocate 
[1-9][0-9]* out of [0-9]+ chunks" &&
                                 break 2
                         done
                 done
         done










