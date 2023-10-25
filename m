Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D77D75B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJYU3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYU3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 16:29:48 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD718B
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1698265782; x=1698524982;
        bh=eh8FqFJ3iRnc8RZX7Fh9oxtknBlTiwtp+opRBlNGn8Q=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=pVHR26Di1l9kAzdanoukxNQXtdLTncwI8jVNnrDNHGLTVd5h4u2gbsGB4ga5XqeOD
         pJoiFlq34HIov4KNKle1qJnLKSyEFDY7Q/5H43rj765EbX9j2nTiXwt0+mp2SkZnaF
         9b5A1d19DRhGywSONaldHzQ5yST6Fen8rH4s4+9+ZwELm0X5BbVftYHMG0Cf38BSEy
         SksynH/zDet3Io1h4MvyvVQqWtIFcYSxDJDIApBEhP4O0qy/CfHAQmpM7zNcxyhAZv
         plnavPwAwWXdyL4o+fr7sJU0gxK1dUnQQPTsK1YmvBdCMkH94tC3nyyWINqexRXSHP
         WvNjwyIkR11sQ==
Date:   Wed, 25 Oct 2023 20:29:31 +0000
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Peter Wedder <pwedder@protonmail.com>
Subject: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest empty
Message-ID: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
Feedback-ID: 42199824:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I had a RAID1 array on top of 4x4TB drives. Recently I removed one 4TB driv=
e and added two 16TB drives to it. After running a full, unfiltered balance=
 on the array, I am left in a situation where all the 4TB drives are comple=
tely empty, and all the data and metadata is on the 16TB drives. Is this no=
rmal? I was expecting to have at least some data on the smaller drives.

Using btrfs-progs v6.3.2 on kernel 6.3.11, Fedora Server 38.

# btrfs fi show
Label: none  uuid: 6f6bf357-774d-4e1f-8cad-a2ed801533a8
        Total devices 5 FS bytes used 5.57TiB
        devid    1 size 3.64TiB used 0.00B path /dev/sde
        devid    2 size 3.64TiB used 0.00B path /dev/sdd
        devid    3 size 3.64TiB used 0.00B path /dev/sda
        devid    5 size 14.55TiB used 5.58TiB path /dev/sdb
        devid    6 size 14.55TiB used 5.58TiB path /dev/sdf


# btrfs device usage /media/raid1
/dev/sde, ID: 1
   Device size:             3.64TiB
   Device slack:              0.00B
   Unallocated:             3.64TiB

/dev/sdd, ID: 2
   Device size:             3.64TiB
   Device slack:              0.00B
   Unallocated:             3.64TiB

/dev/sda, ID: 3
   Device size:             3.64TiB
   Device slack:              0.00B
   Unallocated:             3.64TiB

/dev/sdb, ID: 5
   Device size:            14.55TiB
   Device slack:              0.00B
   Data,RAID1:              5.58TiB
   Metadata,RAID1:          8.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             8.97TiB

/dev/sdf, ID: 6
   Device size:            14.55TiB
   Device slack:              0.00B
   Data,RAID1:              5.58TiB
   Metadata,RAID1:          8.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             8.97TiB

# btrfs filesystem usage /media/raid1
Overall:
    Device size:                  40.02TiB
    Device allocated:             11.17TiB
    Device unallocated:           28.85TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         11.14TiB
    Free (estimated):             14.44TiB      (min: 14.44TiB)
    Free (statfs, df):            12.62TiB
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID1: Size:5.58TiB, Used:5.56TiB (99.71%)
   /dev/sdb        5.58TiB
   /dev/sdf        5.58TiB

Metadata,RAID1: Size:8.00GiB, Used:6.87GiB (85.93%)
   /dev/sdb        8.00GiB
   /dev/sdf        8.00GiB

System,RAID1: Size:32.00MiB, Used:816.00KiB (2.49%)
   /dev/sdb       32.00MiB
   /dev/sdf       32.00MiB

Unallocated:
   /dev/sde        3.64TiB
   /dev/sdd        3.64TiB
   /dev/sda        3.64TiB
   /dev/sdb        8.97TiB
   /dev/sdf        8.97TiB

