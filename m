Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89780342BDF
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCTLOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhCTLOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 07:14:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F5C0613BA
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:48:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y1so14959605ljm.10
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9JKZ3ZpKP/jzajSttwIR2wTO37ERNWhSPBHIr/0lRLk=;
        b=YHSQNEOOd0/5IzaAh53lgxWU+cVjbtU5HAKKq1OfFqETjF+D6DNkSuV5O5u1OVWovO
         QAPNSckSg9XasgoygYhZSlR11uQhXEWDdz9lv6FSLQA4ZY0TkWK5nNXRcvvju/xz4JR8
         0xEsxI+jM/qQ3kngLWxFoH1egbX6g4he1JJbDqpb30NhLnN3no5/xdQmgaBZh/+OKFzq
         bnHekh7xEIwSSRuQAmUE5gLwWjvozuD6HHADCtJM0t7aAXIAItTRnwNqINrjqm9HiUk/
         2cEWy+zHGvoX0asak1/SKweBxXP1uJhGe35dbhXfdOuoHHoDDdGoG+nwKHbw3qXcRLgD
         554A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9JKZ3ZpKP/jzajSttwIR2wTO37ERNWhSPBHIr/0lRLk=;
        b=JyxyotZrUsHcvP1ibdUcbRds9gB2Yp19ftoNvkK1vXkj3dxUWDHoFgGSB6TNZzCEVe
         HYfWHhOFGWLXUS+VEumUIdrYESMF5d+SHvbtCA191qakvj8IpiULkxUcVm1upajUe6gz
         RWfvZUyeDZI/z1ygu3WrVHFim4raG1Ru9xYFG6A4bSNpMkyS+1urEeuDrQeOqw4okAJf
         xO6ihOOMxnSYLsDPu9aXDRlOBM+1ZD8SpQxEKlv1NKYe8T6BHho02dcv5AbhBfqbasJn
         9aASLFUfjLZ4xDo5jl0901zkyHKfh6IDKy6J8unPBM4+gryKG1wMz3FAwZ8+yQrFjtpQ
         vUrA==
X-Gm-Message-State: AOAM5315lTWowCLo5ZBVWzb8Tzh24q+QsKFRscCyIytn84LYKYmJgOB+
        L5qOiAu7VazlVB39iXgSAIJZBFmBTWxtEg==
X-Google-Smtp-Source: ABdhPJx4kbr/bDi7lUX6QzM8QPS7YOBgdUNMWeT0gbNFTjbeum4vBVuw1Xw8AhSvRXeDoWZiMBSFcg==
X-Received: by 2002:a17:906:aad5:: with SMTP id kt21mr8886334ejb.160.1616234005939;
        Sat, 20 Mar 2021 02:53:25 -0700 (PDT)
Received: from [10.98.241.150] ([193.16.224.6])
        by smtp.gmail.com with ESMTPSA id gj13sm5104521ejb.118.2021.03.20.02.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 02:53:25 -0700 (PDT)
Subject: Re: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
 <20210313152146.1D7D.409509F4@e16-tech.com>
 <cefa397a-c39a-78c3-5e85-f6a9951de7d8@gmail.com>
 <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
From:   Thomas Schneider <74cmonty@gmail.com>
Message-ID: <359864d4-6f40-b7e2-bf40-a44ffd053f4b@gmail.com>
Date:   Sat, 20 Mar 2021 10:53:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR5zeC=jNRf0iSHpqQXDOBExfFzfGj+PzMTxs_S1JVmVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Chris,

many thanks for your analysis.

I'm not sure how to proceed in order to fix this error.
Obviously both devices, sda and sdb, are not partitioned 100% 
correct/optimal.

Therefore I consider to restart from scratch, means
- creating a file backup of OS
- deleting any partion on sda and sdb
- create 2 partitions on sda, part #1 for OS + part #2 for swap 
(swapfile is not working with BTRFS on multiple drives)
- restoring the (file) backup

Question:
Would you recommend to create a swap partition on sdb, too?

Regards
Thomas


Am 13.03.2021 um 19:02 schrieb Chris Murphy:
> On Sat, Mar 13, 2021 at 5:22 AM Thomas <74cmonty@gmail.com> wrote:
>
>> Gerät      Boot Anfang      Ende  Sektoren  Größe Kn Typ
>> /dev/sdb1         2048 496093750 496091703 236,6G 83 Linux
>> However the output of btrfs insp dump-s <device> is different:
>> thomas@pc1-desktop:~
>> $ sudo btrfs insp dump-s /dev/sdb1 | grep dev_item.total_bytes
>> dev_item.total_bytes    256059465728
> sdb1 has 253998951936 bytes which is *less* than the btrfs super block
> is saying it should be. 1.919 GiB less. I'm going to guess that the
> sdb1 partition was reduced without first shrinking the file system.
> The most common way this happens is not realizing that each member
> device of a btrfs file system must be separately shrunk. If you do not
> specify a devid, then devid 1 is assumed.
>
> man btrfs filesystem
> "The devid can be found in the output of btrfs filesystem show and
> defaults to 1 if not specified."
>
> I bet that the file system was shunk one time, this shrunk only devid
> 1 which is also /dev/sda1. But then both partitions were shrunk
> thereby truncating sdb1, resulting in these errors.
>
> If that's correct, you need to change the sdb1 partition back to its
> original size (matching the size of the sdb1 btrfs superblock). Scrub
> the file system so sdb1 can be repaired from any prior damage from the
> mistake. Shrink this devid to match the size of the other devid, and
> then change the partition.
>
>
>
>> Gerät      Boot    Anfang      Ende  Sektoren  Größe Kn Typ
>> /dev/sda1  *         2048 496093750 496091703 236,6G 83 Linux
>>
>> thomas@pc1-desktop:~
>> $ sudo btrfs insp dump-s /dev/sda1 | grep dev_item.total_bytes
>> dev_item.total_bytes    253998948352
> This is fine. The file system is 3584 bytes less than the partition.
> I'm not sure why it doesn't end on a 4KiB block boundary or why
> there's a gap before the start of sda2...but at least it's benign.
>
>

