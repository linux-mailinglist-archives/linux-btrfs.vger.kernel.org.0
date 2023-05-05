Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38856F8122
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjEELAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjEELAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 07:00:38 -0400
Received: from mail.render-wahnsinn.de (unknown [IPv6:2a01:4f8:13b:3d57::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDE1A49B
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 04:00:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F29A20D5D6
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 13:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1683284427; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language;
        bh=boxcQgwXgSqEba5ZohE2LEBxWbRODyNbaUGARuCt8+4=;
        b=X2Jl827JVANVMWhSMmuohSp9Nb7gnbxDkUA/kRC9ct0NPuXP349+Mtdt0maDlXCJMZCN8v
        1putTWmS+UN8KLE0mqXdgox296O5MlgCQp1vPlbNfQ78xPzrplCNWeFo+RoqeSBSmXiue6
        MYQKKsiVdqa1gvx/PbGPI93zLXDAqZ2TjpVS+AVIuD3hr/P9xjYghfpNH5X7G2BRrI3Ru1
        8JiwhPfFU77q5xggXgXtsXJlUGdbi4yFSokgjLgc2xlmN/x767xLhUAWQBN2Q/hpolqRvR
        Hr8Vr6ijpadkqcIjjEU3bVTYsf+DUVeAd+0rnsik7qRADLjZQpz4iXLo8gmK0g==
Message-ID: <a71a484f-f686-186b-c46b-17a1c3af84cf@render-wahnsinn.de>
Date:   Fri, 5 May 2023 13:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Language: en-US
From:   Robert Krig <robert.krig@render-wahnsinn.de>
Subject: unexplained missing free space
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Hi, I have a strange issue.
>
>
> On one of my debian systems btrfs shows that about 165GB are used.
> But if do a du -csh on that volume it shows I'm only using about 16GB 
> of data.
>
> I've tried balancing, defragging, scrubbing, trimming, but the used 
> space remains.
>
> I did have a subvolume on there which I deleted. However I do not 
> currently see any IO on this system by any BTRFS processes. I should 
> also mention that this is a nvme drive, in case that's relevant.
>
>
> Does anyone have any ideas what might be causing this?
>
>
> Here are a few details about the system:
>
> Debian Bookworm running kernel 6.1.0-7-amd64
>
> BTRFS Progs version 6.2
>
>
> root@hades:~# btrfs fi df /mnt/BTRFS_TOP/
> Data, single: total=158.00GiB, used=150.45GiB
> System, DUP: total=32.00MiB, used=48.00KiB
> Metadata, DUP: total=9.00GiB, used=7.60GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
>
> root@hades:~# btrfs fi usage /mnt/BTRFS_TOP/
> Overall:
>    Device size:                 952.41GiB
>    Device allocated:            176.06GiB
>    Device unallocated:          776.35GiB
>    Device missing:                  0.00B
>    Device slack:                    0.00B
>    Used:                        165.65GiB
>    Free (estimated):            783.90GiB      (min: 395.73GiB)
>    Free (statfs, df):           783.90GiB
>    Data ratio:                       1.00
>    Metadata ratio:                   2.00
>    Global reserve:              512.00MiB      (used: 0.00B)
>    Multiple profiles:                  no
>
> Data,single: Size:158.00GiB, Used:150.45GiB (95.22%)
>   /dev/nvme0n1p2        158.00GiB
>
> Metadata,DUP: Size:9.00GiB, Used:7.60GiB (84.46%)
>   /dev/nvme0n1p2         18.00GiB
>
> System,DUP: Size:32.00MiB, Used:48.00KiB (0.15%)
>   /dev/nvme0n1p2         64.00MiB
>
> Unallocated:
>   /dev/nvme0n1p2        776.35GiB
>
>
> root@hades:~# btrfs fi du -s /mnt/BTRFS_TOP/
>     Total   Exclusive  Set shared  Filename
>  15.38GiB    15.38GiB       0.00B  /mnt/BTRFS_TOP/
>
> root@hades:~# mount | grep /dev/nvme0n1p2
> /dev/nvme0n1p2 on / type btrfs 
> (rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@rootfs)
> /dev/nvme0n1p2 on /home type btrfs 
> (rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=257,subvol=/@home)
> /dev/nvme0n1p2 on /mnt/BTRFS_TOP type btrfs 
> (rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=5,subvol=/)
> /dev/nvme0n1p2 on /var/lib/docker/btrfs type btrfs 
> (rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvolid=256,subvol=/@rootfs)
>
>
>

