Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A613A1B4357
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDVLe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVLe3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 07:34:29 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6AC03C1A8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 04:34:29 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jRDe5-0000pa-E0; Wed, 22 Apr 2020 13:34:26 +0200
Subject: Re: RAID 1 | Newbie Question
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
 <20200422104403.GE32577@savella.carfax.org.uk>
 <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
 <20200422110646.GF32577@savella.carfax.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <e000c0cc-132d-04ad-dcfd-d808efbff76d@peter-speer.de>
Date:   Wed, 22 Apr 2020 13:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422110646.GF32577@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587555269;518696f0;
X-HE-SMSGID: 1jRDe5-0000pa-E0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.04.20 13:06, Hugo Mills wrote:
>> "It is possible with all of the descriptions below, to construct a RAID-1
>> array from two or more devices, and have those devices live on the same
>> physical drive. This configuration does not offer any form of redundancy for
>> your data."
>     There's a difference between "device" and "disk" here. If you make
> two partitions on one device, and that device fails, then there's no
> (disk) redundancy.
> 
>     If you make two partitions on one disk and one partition on another
> disk, and use all three partitions (block devices) to make a RAID-1,
> then you're still going to lose the filesystem if the disk with two
> partitions on it fails.


OK, this makes sense to me and cleared things up.
I still do not get the clue why it is explicitly mentioned in the wiki 
that there will be no redundany for the data if one uses just one disk 
in case of a disk failure. This is pretty obvious instead.

Thanks,
Steffi
