Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8C2F94BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbhAQSuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 13:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbhAQSuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 13:50:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E29C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 10:49:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ce17so5891429pjb.5
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=cK/EhkytdLm669CisA7BWs5hUZCCOgpXdodFpRrc1P8=;
        b=aZy0X/fXYcnd9N5yuhikjbLoujpkhCHog1rTgZr5WkzFA3ZSF3sZWPk6U7MwlTSIqj
         c1zoDasYC/XmI266aeF+a6Et2078Q9RcwUwZgJvp/+n4q61jjM2CMebbTNofXfSWLs4z
         /O+U6RKFUcusmRiF4L2AgmVr65YYbLAFLN7EbFWhtARUy7waKCbWiK0Hkycm3AQv9zph
         iBT9ucJbuJZ+BjVIy+zFKXjN2ItqXSs7lcd+171dgLVxCd6PRCkzVi6OG4cldeyBjyRq
         shmED+5ZAWwrzZ7inPOVpNjnux1tAGj3r4pSQ3d6ZL445YzEM7Ki4E6ruEa7h6ju6j73
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=cK/EhkytdLm669CisA7BWs5hUZCCOgpXdodFpRrc1P8=;
        b=YWRtgZZR7xHefHFMgtTVNUtlFbW5Knh8UtQ5ZaXEsw6fI6hxv1LUkvXCkPSBBcYkpP
         CpMj7ofkLycLsyWiPsM1z8U9q4Aan8FKCvBzZ6DzBUYqeBsl0kzjERChJ8ezFHiC3TBW
         xDXf/uGGSMK21KfZwdlRwku7TpWMgpSX19Mplfmidt0mtAwWH5e7BnGek1iorLCv6Mg8
         tYWb4qLudBX1uTtRPQRk6IOnVnEkiL01gdjFFr8Y/rweOsUrKpa8AU2NxYRBeka8goHs
         M0kWX0aheBrPMS4VMF8dfIjpjqffwtCuWkPKcFTejI1mHwGOYpNCmAWN+VKcZBUiRAUH
         f0aw==
X-Gm-Message-State: AOAM533iNzKMRTam8lvhtQR2J19jX6G0pLyYHUWTva6NxmyWUby2yDWX
        oonBIiGSn1tDoZmf3bi6elJ6JtnIoQw=
X-Google-Smtp-Source: ABdhPJxGXfkzcvHvdizSzYN8CwXgJzv6Xih2IFICoRA7bjg4OAVKDwQ+sLRa/NyOn7WF7A2QVuHutQ==
X-Received: by 2002:a17:90b:11cb:: with SMTP id gv11mr6824824pjb.4.1610909368466;
        Sun, 17 Jan 2021 10:49:28 -0800 (PST)
Received: from [192.168.1.74] (d206-116-119-5.bchsia.telus.net. [206.116.119.5])
        by smtp.gmail.com with ESMTPSA id z2sm13873570pgl.49.2021.01.17.10.49.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 10:49:27 -0800 (PST)
From:   Anders Halman <anders.halman@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: received uuid not set btrfs send/receive
Message-ID: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
Date:   Sun, 17 Jan 2021 10:49:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I try to backup my laptop over an unreliable slow internet connection to 
a even slower Raspberry Pi.

To bootstrap the backup I used the following:

# local
btrfs send root.send.ro | pigz | split --verbose -d -b 1G
rsync -aHAXxv --numeric-ids --partial --progress -e "ssh -T -o 
Compression=no -x" x* remote-host:/mnt/backup/btrfs-backup/

# remote
cat x* > split.gz
pigz -d split.gz
btrfs receive -f split

worked nicely. But I don't understand why the "received uuid" on the 
remote site in blank.
I tried it locally with smaller volumes and it worked.

The 'split' file contains the correct uuid, but it is not set (remote).

remote$ btrfs receive --dump -f split | head
subvol          ./root.send.ro uuid=99a34963-3506-7e4c-a82d-93e337191684 
transid=1232187

local$ sudo btrfs sub show root.send.ro| grep -i uuid:
     UUID:             99a34963-3506-7e4c-a82d-93e337191684


Questions:

- Is there a way to set the "received uuid"?
- Is it a matter of btrfs-progs version difference?
- What whould be a better approach?


Thank you


----

# local

root@fos ~$ uname -a
Linux fos 5.9.16-200.fc33.x86_64 #1 SMP Mon Dec 21 14:08:22 UTC 2020 
x86_64 x86_64 x86_64 GNU/Linux

root@fos ~$   btrfs --version
btrfs-progs v5.9

root@fos ~$   btrfs fi show
Label: 'DATA'  uuid: b6e675b3-84e3-4869-b858-218c5f0ac5ad
     Total devices 1 FS bytes used 402.17GiB
     devid    1 size 464.27GiB used 414.06GiB path 
/dev/mapper/luks-e4e69cfa-faae-4af8-93f5-7b21b25ab4e6

root@fos ~$   btrfs fi df /btrfs-root/
Data, single: total=404.00GiB, used=397.80GiB
System, DUP: total=32.00MiB, used=64.00KiB
Metadata, DUP: total=5.00GiB, used=4.38GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


# remote
root@pih:~# uname -a
Linux pih 5.4.72+ #1356 Thu Oct 22 13:56:00 BST 2020 armv6l GNU/Linux

root@pih:~#   btrfs --version
btrfs-progs v4.20.1

root@pih:~#   btrfs fi show
Label: 'DATA'  uuid: 6be1e09c-d1a5-469d-932b-a8d1c339afae
     Total devices 1 FS bytes used 377.57GiB
     devid    2 size 931.51GiB used 383.06GiB path 
/dev/mapper/luks_open_backup0

root@pih:~#   btrfs fi df /mnt/backup
Data, single: total=375.00GiB, used=374.25GiB
System, DUP: total=32.00MiB, used=64.00KiB
Metadata, DUP: total=4.00GiB, used=3.32GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


dmesg is empty for the time of import/btrfs receive.
