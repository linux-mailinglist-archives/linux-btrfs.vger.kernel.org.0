Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640A048A86F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348349AbiAKHbP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 02:31:15 -0500
Received: from mx01.maccuish.org.uk ([116.203.49.71]:49702 "EHLO
        mx01.maccuish.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiAKHbO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 02:31:14 -0500
Received: from [172.16.30.16] (unknown [172.16.30.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mx01.maccuish.org.uk (Postfix) with ESMTPSA id 33B7A3FE69;
        Tue, 11 Jan 2022 07:31:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maccuish.de; s=mail;
        t=1641886273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wpdzXYPWN+iKXJ+TSnQ8jPcm4rZBs89j/y8D+5pIEU=;
        b=c6Vq7/3WG1bRfTdDJl/X3d3j62VYpZrNQYKRmeImpa5E7CeAy8p8jjsoUdn1wNJD5NnQcA
        gYWcstBdQcqvkDE3fX4V/rCAuV21m5ThxFw86RDyKsLR8N3ogin1hO25rbLm7VNpCB93Cf
        kl3txoCxHgBdntNiQHDsWiOieLfEjJ/+yy5iPNdwl5681ZfHQGqB1idhH4y73GmBhj3TN5
        Jkvj2ZjENf1UjJ++/QvPVgDRBjKn3D4LCZC/gxYe75Jh6M6ZxZcaDZFsjw626wjSXRosM0
        PSdSnx6S3ahkqqUylZIipx/NlEoP6hZ/Ax+SmeceP/R39XkQ1e4lhsMcPvjq6A==
Message-ID: <02c7933d-e444-0eba-e46f-2cab8e7601fa@maccuish.de>
Date:   Tue, 11 Jan 2022 08:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Adding a UUID to the top level subvol on an existing filesystem
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <61b5cb09-8bd4-8b25-fbda-73b866a36fd5@maccuish.de>
 <f9e3796c-573a-a577-7a1f-4227b89e4da1@gmail.com>
From:   Alex MacCuish <alex@maccuish.de>
In-Reply-To: <f9e3796c-573a-a577-7a1f-4227b89e4da1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm using btrbk which has worked successfully for me on other systems. 
In their FAQ (https://github.com/digint/btrbk/blob/master/doc/FAQ.md), 
they state:

---

If your file system was created with btrfs-progs < 4.16, the btrfs root 
subvolume (id=5) has no UUID. You can check this by calling:

|# btrfs subvolume show /mnt/btr_pool / Name: <FS_TREE> UUID: - [...] |

Without a UUID, the snapshots would get no parent_uuid, leaving btrbk 
unable to track parent/child relationships. In this case, btrbk refuses 
to create snapshots and backups.

---

I've asked there on whether this can be worked around but no luck.

Am 10.01.22 um 12:38 schrieb Andrei Borzenkov:
> On 09.01.2022 13:11, Alex MacCuish wrote:
>> For use of send/receive, I need my subvolume id 5 to have a UUID. I see
> You always send read-only snapshot and send/receive is using UUID of this
> snapshot, not of original subvolume. Do you get any error or something
> does not work?
>
>> here (https://www.spinics.net/lists/linux-btrfs/msg76016.html) that it
>> was discussed to add this feature to say btrfstune, but I can't find any
>> option to do it. What's the best way to do this and ensure current
>> subvolumes have the correct parent ID?
>>
>> ---
>>
>> Linux xxx.xxx.xxx 5.15.11-051511-generic #202112220937 SMP Wed Dec 22
>> 10:04:02 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>
>> btrfs-progs v5.4.1
>>
>> btrfs fi show
>>
>> Label: 'storage'  uuid: 61538bc8-fc27-4818-9cc9-133938e252da
>>           Total devices 4 FS bytes used 2.35TiB
>>           devid    1 size 1.82TiB used 1.63TiB path /dev/sdd
>>           devid    2 size 1.82TiB used 1.63TiB path /dev/sdc
>>           devid    3 size 1.82TiB used 744.03GiB path /dev/sdb
>>           devid    4 size 931.51GiB used 738.03GiB path /dev/sde
>>
>> btrfs fi df /mnt/storage
>> Data, RAID1: total=2.35TiB, used=2.34TiB
>> System, RAID1: total=32.00MiB, used=368.00KiB
>> Metadata, RAID1: total=5.00GiB, used=4.32GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>> btrfs subvolume show /mnt/storage/
>> /
>>           Name:                   <FS_TREE>
>>           UUID:                   -
>>           Parent UUID:            -
>>           Received UUID:          -
>>           Creation time:          -
>>           Subvolume ID:           5
>>           Generation:             4620363
>>           Gen at creation:        0
>>           Parent ID:              0
>>           Top level ID:           0
>>           Snapshot(s):
>>                                   CN_IMGS
>>                                   CN_PKGS
>>                                   CN_PKGS/.snapshots
>>                                   CN_SHARE
>>                                   CN_SHARE/.snapshots
>>                                   CN_MEDIA
>>                                   CN_MEDIA/.snapshots
>>                                   CN_HOMES
>>                                   CN_HOMES/.snapshots
>>                                   CN_BACKUPS
>>
