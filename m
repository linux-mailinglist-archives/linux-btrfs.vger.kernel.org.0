Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E54AB066
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiBFPvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 10:51:33 -0500
X-Greylist: delayed 19642 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 07:51:31 PST
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE31C06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 07:51:31 -0800 (PST)
Date:   Sun, 06 Feb 2022 15:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliethoever.de;
        s=protonmail3; t=1644162686;
        bh=jINSep8pdDIhBebG2d5S/KMqslPX+BHW1L+ERcG/7eo=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         From:To:Cc;
        b=SiMbaoSathclHw1Hg1Dc04sXESk0D+/pkkNQkGd+QgMWXYEx2SU1O5YfJscrt+HY1
         rupKpwRrtU4lMAreqgN9vhvJ35MGX6j3a0TpIfB/Vn6NGdfy1CMMAuCoI1rCySCUKs
         mT90yV45gveBz3ddj0XhsMW8XXOimSitXEP9wROcgMiJVVA5nDZ69hf0TdYoRhwvce
         svmHEg+gEusZo4Zgqg+fm/UYCjzV86wyDTOZEU1oUUr2kUkjjPo6DbIRq9a0gIUUoF
         QSnBxe3meX1Pv8t4okcw03SoYEXQLTdv3D9H4QFS78zIH85jE9h0m3WLAChLX0ee5c
         ygKjskAm4CcoQ==
To:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Reply-To: =?utf-8?Q?Max_Splieth=C3=B6ver?= <max@spliethoever.de>
Subject: Re: btrfs RAID1 upgrade
Message-ID: <ee2e295c-3bae-b497-b690-57c210a77022@spliethoever.de>
In-Reply-To: <2fa6e081-cccd-d3aa-456c-f31911a42bdd@tnonline.net>
References: <bfd8a745-3480-70c8-155a-3ee7f5200647@spliethoever.de> <2fa6e081-cccd-d3aa-456c-f31911a42bdd@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey!

On 2/6/22 12:18, Forza wrote:
> Hi,
>
> On 2022-02-06 11:23, Max Splieth=C3=B6ver wrote:
>> Hey everyone.
>> As the available space on my BTRFS RAID1 setup with 2x 4TB drives gets a=
 bit low (a little over 10% left), I plan to upgrade my setup. The current =
idea is to add a single 8TB drive to the RAID1. The RAID is not used as sys=
tem drive, but is merely mounted as storage. According to [1], I could simp=
ly add the new drive to get 8TB of raw file storage in total, with the data=
 and metadata ratio remaining at 2.0.
>
> Do you mean you want to end up with 1x4TB and 1x8TB? This will only give
> you 4TB usable space in a RAID1 configuration. If you want to add this
> 8TB drive as a third drive, then you will have 8TB of usable space in a
> RAID1 configuration.
>

Yes, the goal is a three-drive setup.

>>
>> Before I do so, I would like to know whether there are any problems with=
 such a three-drive setup or I misunderstood something, and it isn't actual=
ly possible to extend the RAID1 in this way.
>>
>> Also, I would love to get some feedback on the series of steps I plan to=
 execute to extend the RAID with the 8TB drive:
>>
>>
>> 1. Stop all applications depending on the storage.
>> 2. Unmount storage device.
>> 3. Mount storage device degraded at `/btrfsmount`.
>>        ```
>>        $ mount -o degraded /dev/sdX /btrfsmount
>>        ```
>> 4. Add the new drive to the raid.
>>        ```
>>        $ btrfs device add -f /dev/sdY /btrfsmount
>>        ```
>> 5. Run a full balance to fully balance the data including the new device=
.
>>        ```shell
>>        $ btrfs balance start --full-balance /btrfsmount
>>        ```
>> 6. Unmount the raid and remount it in non-degraded mode.
>>
>
> Assuming you want to add the drive as a third drive, there is no need to
> unmount the existing mount points, or mount degraded. It can all be done
> live, while your services are running.
>
> Simply do:
> $ btrfs device add /dev/sdY1 /mnt/btrfs
> $ btrfs balance start -dusage=3D100 /mnt/btrfs
>
> There is no need to balance metadata.
>

I see, thank you for the help. Much appreciated!

>>
>> Lastly, if there are any other "best practices" one should follow when d=
oing such an extension (apart from backups, of course), please let me know.
>>
>> In case it helps, below is the btrfs filesystem usage output:
>> $ btrfs filesystem usage /btrfsmount
>> Overall:
>>        Device size:                   7.28TiB
>>        Device allocated:              6.43TiB
>>        Device unallocated:          871.98GiB
>>        Device missing:                  0.00B
>>        Used:                          6.41TiB
>>        Free (estimated):            442.47GiB      (min: 442.47GiB)
>>        Free (statfs, df):           442.47GiB
>>        Data ratio:                       2.00
>>        Metadata ratio:                   2.00
>>        Global reserve:              512.00MiB      (used: 0.00B)
>>        Multiple profiles:                  no
>>
>> Data,RAID1: Size:3.21TiB, Used:3.20TiB (99.80%)
>>       /dev/sdd1       3.21TiB
>>       /dev/sde1       3.21TiB
>>
>> Metadata,RAID1: Size:5.00GiB, Used:4.31GiB (86.19%)
>>       /dev/sdd1       5.00GiB
>>       /dev/sde1       5.00GiB
>>
>> System,RAID1: Size:32.00MiB, Used:480.00KiB (1.46%)
>>       /dev/sdd1      32.00MiB
>>       /dev/sde1      32.00MiB
>>
>> Unallocated:
>>       /dev/sdd1     435.99GiB
>>       /dev/sde1     435.99GiB
>>
>>
>>
>> Thank you very much in advance. :)
>>
>>
>> -Max
>>
>>
>> [1]: https://carfax.org.uk/btrfs-usage/
>>

