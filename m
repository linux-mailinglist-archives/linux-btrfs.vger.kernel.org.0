Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B039F190C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 15:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKFOsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 09:48:08 -0500
Received: from server.roznica.com.ua ([80.90.224.56]:38952 "EHLO
        server.roznica.com.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfKFOsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Nov 2019 09:48:08 -0500
Received: from work.roznica.com.ua (h244.onetel95.onetelecom.od.ua [91.196.95.244])
        by server.roznica.com.ua (Postfix) with ESMTP id B8220725A88
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2019 16:48:05 +0200 (EET)
Subject: Re: Read-only snapshot send speed very slow after modify original
 data. Need help
From:   Michael <mclaud@roznica.com.ua>
To:     linux-btrfs@vger.kernel.org
References: <af5343ac-2896-51ef-18f5-de05498c01f9@roznica.com.ua>
Message-ID: <66dfd39b-7a40-0cce-0cbf-1b5ba1a629d1@roznica.com.ua>
Date:   Wed, 6 Nov 2019 16:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <af5343ac-2896-51ef-18f5-de05498c01f9@roznica.com.ua>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.10.2019 14:07, Michael пишет:
> Hi linux-btrfs,
>
> Step to reproduce
>
> 1) mkfs.btrfs -draid6 -mraid6 /dev/sd[abcdefgh]
>
> 2) mount 
> -onoatime,nodiratime,thread_pool=24,max_inline=0,ssd_spread,compress-force=zstd 
> /dev/sda /mnt/test/
>
> 3) btrfs subvol create /mnt/test/subvol/
>
> 4) dd if=/dev/zero of=/mnt/test/subvol/test.dat bs=1M count=65536
>
> 5) btrfs subvol snapshot -r /mnt/test/subvol /mnt/test/subvol.ro
>
> 6) btrfs send /mnt/test/subvol.ro | pv >/dev/null
>
> 64,1GiB 0:01:18 [ 833MiB/s]  - fast
>
> 7) for i in {1..16384}; do echo $i; printf '\x01\x02\x03' | dd 
> of=/mnt/test/subvol/test.dat bs=1 seek=$(($i * 1024 * 1024)) count=3 
> conv=notrunc; done
>
> 8) btrfs send /mnt/test/subvol.ro | pv >/dev/null
>
> I stop it at 0:01:18
>
> 464MiB 0:01:18 [4,67MiB/s] - very very slow
Does this problem concern me only?
>
>
> uname -a
> Linux storage.domain.com 5.3.7-200.fc30.x86_64 #1 SMP Fri Oct 18 
> 20:13:59 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>

