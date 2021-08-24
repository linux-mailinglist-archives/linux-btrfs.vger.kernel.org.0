Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008383F5401
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhHXALb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 20:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhHXAL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 20:11:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747F4C06175F
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 17:10:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q2so18143192pgt.6
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newfietech-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ag1ozIgp2ix31x0/NAjHxYjrvCY3kKsNrgBLVa/SLp4=;
        b=lxIC24PGt2H836ccstc0Gb7xQDDzPzwhVmard/Z0f7P4rUOCRwBXEXk38AyotfTm/t
         VNZxsHTekycTzvQ0nc5TicN2L3oPSr+E7dX2CcrJmbP6MHNfeI73wXqoLwtLEvv+Ya0j
         uFj0EaYx6hre8VrFkxlouZ9aCOIwWf+Q8W5b9meODtzanXiIWgQuOWdCLFX8d7z+6o6G
         9YEbyaR7UxOL95AtiIlxUTE2RL8MTF5XfJM4RtdE0oVtL63Desl+6n3Fovz1leZa7+vJ
         tW724PEC/3qKLZNsx6FfK5wmdjGpo0W8c3ULB9p9YEE6XDEBDMmgPSjsRbc+IjxBGt4U
         Tajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ag1ozIgp2ix31x0/NAjHxYjrvCY3kKsNrgBLVa/SLp4=;
        b=Rw4XwlhnPgCLo/OZqAflfkULwK5ZaxX4gtC4rJp6CDEnsyjyJgYG6Qyrg4ean4bDGi
         m41iVS9k2R2gkF6iB1sk1doKaiKwfdBbQBQPAu2cgpIXzVP7I/dzlwh0tFJmrVRgIaFg
         JCBYbmJlCTMTrqgH0mt6jSzdeCMvhLru8P/TgY74UHukCNCrKOnTTe81aSl6FetzgOt+
         6PiWv+hlenveaZz7FLdqKQhUIEtPugHVrSPBAZNVnAXU0xV7kwGfOmxfaEv/rsU+uOUT
         2xk2KFVWbuAzBZL5VxpW8wiaNfPoOD25wtNhzOCaq4qdrIlOdfdVcDIN0jYqrM8x1v48
         w7YQ==
X-Gm-Message-State: AOAM531oIQ4dKmfelRn8seV/yR2bG93UweWCs+NH18vDhZtZ7p8TdV4R
        Jj/QILgR1zp1DSmN2+5tRhpFC4p0Mxg3GEG3
X-Google-Smtp-Source: ABdhPJzqZW/f0H/brXcTcW/8kdooaSvDcKjsy44ofctCYg0Clt2G12xK8YDTpblSZj81opRwe656WA==
X-Received: by 2002:a62:8491:0:b029:3dd:a29a:a1e4 with SMTP id k139-20020a6284910000b02903dda29aa1e4mr36038294pfd.13.1629763845539;
        Mon, 23 Aug 2021 17:10:45 -0700 (PDT)
Received: from R9 (d137-186-110-25.abhsia.telus.net. [137.186.110.25])
        by smtp.gmail.com with ESMTPSA id gg6sm331308pjb.46.2021.08.23.17.10.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Aug 2021 17:10:45 -0700 (PDT)
From:   <weldon@newfietech.com>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <005201d79860$befd1b60$3cf75220$@newfietech.com> <0be8ec2b-7226-f3d1-a02b-608e757bda24@gmx.com>
In-Reply-To: <0be8ec2b-7226-f3d1-a02b-608e757bda24@gmx.com>
Subject: RE: BTRFS fails mount after power failure
Date:   Mon, 23 Aug 2021 18:10:44 -0600
Message-ID: <001401d7987c$7bb81ff0$73285fd0$@newfietech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEIZy1INtDtZmceAeIsl4SJmEEvRgJ4+LE+rQxfalA=
Content-Language: en-ca
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the reply Qu.

The hardware setup is a bit wonky in a home lab, but is as follows:

Dell PowerEdge R510 Chassis
Dell PERC H700
6 * 4TB SATA Disks in a RAID 5 configuration
ESXi 6.5 hypervisor sees storage as local DELL Disk, 18.19TB

17.66TB Provisioned as a Datastore on the hypervisor, VMFS5.
- 14.5TB provisioned as a vmdk and presented as local disk to Ubuntu =
virtual machine, mounted as /data (btrfs)
- 200GB provisioned as vmdk and presented as local disk to Ubuntu =
virtual machine, mounted as / (ext4)

Happy and willing to try any suggestions you may have.

root@onyx:/home# btrfs ins dump-tree /dev/sdb1
btrfs-progs v5.4.1
parent transid verify failed on 7939752886272 wanted 120260 found 120262
parent transid verify failed on 7939752886272 wanted 120260 found 120265
parent transid verify failed on 7939752886272 wanted 120260 found 120265
Ignoring transid failure
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
ERROR: unable to open /dev/sdb1
root@onyx:/home#


Thanks in advance,
Weldon


-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
Sent: August 23, 2021 5:55 PM
To: weldon@newfietech.com; linux-btrfs@vger.kernel.org
Subject: Re: BTRFS fails mount after power failure



On 2021/8/24 =E4=B8=8A=E5=8D=884:52, weldon@newfietech.com wrote:
> Good day folks,
>
> I awoke this morning to find that my UPS had died overnight and my=20
> Ubuntu server with a 14.5TB (Raid 5) BTRFS volume went down with it.

RAID5 has known write hole bug, and although that bug won't cause =
immediate problems, it slowly degrades the whole array with each =
corrupted sector or unexpected power loss.

This would eventually bring down the array with enough degradation.

>  The machine
> rebooted fine and the hardware reports no errors, however the BTRFS=20
>volume  will no longer mount.  The OS boots fine, the 14.5TB volume is=20
>for data  storage only.  gparted shows the volume/partition,  and=20
>correctly reports  space used as well as total size.  I've never=20
>encountered this type of issue  over the past year while using btrfs=20
>and I'm not sure where to start.  A  number of google search results=20
>express caution when attempting to  recover/repair, so I'm hoping for =
some expert advice.
>
> My dmesg log exceeds the 100,000 bytes restriction, so I'm unable to=20
> attach it, so please ask if there's anything specific I can include =
otherwise.
>
> # uname -a
> Linux onyx 5.4.0-81-generic #91-Ubuntu SMP Thu Jul 15 19:09:17 UTC=20
> 2021
> x86_64 x86_64 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.4.1
>
> # btrfs fi show
> Label: 'Data'  uuid: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
>          Total devices 1 FS bytes used 7.17TiB
>          devid    1 size 14.50TiB used 7.40TiB path /dev/sdb1
>
> # dmesg | grep sdb
> [    2.312875] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.313010] sd 32:0:1:0: [sdb] 31138512896 512-byte logical blocks: =
(15.9
> TB/14.5 TiB)
> [    2.313062] sd 32:0:1:0: [sdb] Write Protect is off
> [    2.313065] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
> [    2.313116] sd 32:0:1:0: [sdb] Cache data unavailable
> [    2.313119] sd 32:0:1:0: [sdb] Assuming drive cache: write through
> [    2.333321] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.396761]  sdb: sdb1
> [    2.397170] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
> CAPACITY(16).
> [    2.397261] sd 32:0:1:0: [sdb] Attached SCSI disk
> [    4.709963] BTRFS: device label Data devid 1 transid 120260 =
/dev/sdb1
> [   21.849570] BTRFS info (device sdb1): disk space caching is enabled
> [   21.849573] BTRFS info (device sdb1): has skinny extents
> [   22.023224] BTRFS error (device sdb1): parent transid verify failed =
on
> 7939752886272 wanted 120260 found 120262
> [   22.047940] BTRFS error (device sdb1): parent transid verify failed =
on
> 7939752886272 wanted 120260 found 120265

This already shows some mismatch in on-disk data and recovered data from =
parity.

This shows the on-disk data and parity have drifted from each other, =
exactly the write hole problem.

Furthermore, the disk has newer data than what we expect.

What's the device model? It looks like a misbehavior, not sure if it's =
from the hardware, or the btrfs code.
As RAID56 is already marked as unsafe for a while, not that much love =
nor code fix is directed to RAID56, thus both cases are possible.

> [   22.047949] BTRFS warning (device sdb1): failed to read tree root
> [   22.089003] BTRFS error (device sdb1): open_ctree failed
>
> root@onyx:/home/weldon# btrfs-find-root /dev/sdb1 parent transid=20
> verify failed on 7939752886272 wanted 120260 found 120262 parent=20
> transid verify failed on 7939752886272 wanted 120260 found 120265=20
> parent transid verify failed on 7939752886272 wanted 120260 found=20
> 120265 Ignoring transid failure
> WARNING: could not setup extent tree, skipping it Couldn't setup=20
> device tree Superblock thinks the generation is 120260 Superblock=20
> thinks the level is 1 Well block 7939758882816(gen: 120264 level: 1)=20
> seems good, but generation/level doesn't match, want gen: 120260=20
> level: 1 Well block 7939747938304(gen: 120263 level: 1) seems good,=20
> but generation/level doesn't match, want gen: 120260 level: 1 Well=20
> block 7939756146688(gen: 120262 level: 1) seems good, but=20
> generation/level doesn't match, want gen: 120260 level: 1 Well block=20
> 7939751559168(gen: 120261 level: 0) seems good, but generation/level=20
> doesn't match, want gen: 120260 level: 1
>
> *** A large selection of block references was removed due to character =

> count... if needed, I can resend with the full output.
>
> Well block 1316967743488(gen: 1293 level: 0) seems good, but=20
> generation/level doesn't match, want gen: 120260 level: 1 Well block=20
> 1316909662208(gen: 1283 level: 0) seems good, but generation/level=20
> doesn't match, want gen: 120260 level: 1 Well block 1316908711936(gen: =

> 1283 level: 0) seems good, but generation/level doesn't match, want=20
> gen: 120260 level: 1 root@onyx:/home#
>
> Any help or assistance would be greatly appreciated.  Important data=20
> has been backed up, however if it's possible to recover without=20
> thrashing the entire volume, that would be preferred.

First thing first, don't expect too much about magically turning the fs =
back to fully functional status.
Transid error is always tricky for btrfs.


But for your case, I'm guessing your sdb1 does not have the latest super =
block.
We have newer tree roots on disk, but older super block.

Maybe you would like to try "btrfs ins dump-tree" on all the involved =
disks, and find if there is newer super blocks.

Thanks,
Qu
>
> Regards,
> Weldon
>

