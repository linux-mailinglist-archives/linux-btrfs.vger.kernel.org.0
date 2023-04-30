Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163236F2871
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Apr 2023 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjD3KU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Apr 2023 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Apr 2023 06:20:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5419A5
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Apr 2023 03:20:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-64115eef620so21434049b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Apr 2023 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682850023; x=1685442023;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aMEVi2VU88fMuA7O+x8Bfh40yy+hJxgcDCOw15LPkl0=;
        b=mwhkcpEgrKwG5sxfIAgb+I1KaO87GZ1IbKSiS38+aTSmbyxzQI/97V2Ik9sxCVlvmr
         fJCNzCrXW1cCZHFDzG6IO/aH8s79mej36fMS7gCdZcBaFyNSxIOakyTrW5bLIEwlLbzx
         Lbfyn9a3OMKngfvGBKU8VYZ8SSCz0ylLc5xZvxeDqPw4tiPFJARRLwXrj3YD1hQYojOc
         Nbs61AlWXwr9UAEfpO5HyyF8UCwhfS2PH+F71VIcJPq3lvVjySu7gRrdnfYcADRygfLS
         86w2ELDxy7mr3LChACtfCVTYZo2zNc5gG7MFElYKCQTCXr9VI4FbI8aZ173oXJHm/zF9
         ZXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682850023; x=1685442023;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMEVi2VU88fMuA7O+x8Bfh40yy+hJxgcDCOw15LPkl0=;
        b=VJZKfwE4FTedQvMCTR37Isxk1Z9LFFHw+lJrc/WGn4Bmbv67xPUYz6SGpWD5WnbX3T
         yKE5snN60yrQGsFRHKX7GoyP3TMGzLJ7vjSx4CZzRqcZ/PDSsQkLZ7FKOH74KKZQwbaD
         8HFaF7huAY/Swi8UEw7ztnwHgR6zxhfDFNryC7UPWjuP6giT3Vvi3urHf9aS/QE9fiA9
         bhlKIC/qL1Q9D1JMoVHOBx6wLmSkgXkgv6wNhWUUs4sxMdMxAM3RC7ZAxr7fliWFxtkU
         Jsss29P3SDgxWiwvIINab4X5DrxB5MXMTCbsu/aQdJA5ZyEfseWg9yBuxQtuFQkq7Bei
         60/w==
X-Gm-Message-State: AC+VfDzt/+qgRSoIQ+AvE8qoFr0APFbkOhFjHHr5PbdBpZfG6JvFHSxs
        oDR+8sQeAb84y1fwuuTPSc/6BWYvr2rsEouZLNbuNtYuvXq/Xe7567w=
X-Google-Smtp-Source: ACHHUZ4iA0f+NFLHmJWJfLSOLGIN+2oMf+2p6M9QN7St0xdtZ5LDvx4u2l70VHssrM24SPPAjebxgYvcM0pcu7s3gq8=
X-Received: by 2002:a17:903:189:b0:1a9:90bc:c3da with SMTP id
 z9-20020a170903018900b001a990bcc3damr14191091plg.11.1682850023198; Sun, 30
 Apr 2023 03:20:23 -0700 (PDT)
MIME-Version: 1.0
From:   Gowtham <trgowtham123@gmail.com>
Date:   Sun, 30 Apr 2023 15:50:11 +0530
Message-ID: <CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com>
Subject: Filesystem inconsistency on power cycle
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

We have been running our application on BTRFS rootfs for quite a few
Linux kernel versions (from 4.x to 5.x) and occasionally do a power
cycle for firmware upgrade. Are there any known issues with BTRFS on
Ubuntu 20.04 running kernel 5.4.0-137?

On power cycles/outages, we have not seen the BTRFS being corrupted
earlier on 4.15 kernel. But we are seeing this consistently on a 5.4
kernel(with BTRFS RAID1 configuration). Are there any known issues on
Ubuntu 20.04? We see some config files like /etc/shadow and other
application config becoming zero size after the power-cycle. Also, the
btrfs check reports errors like below

# btrfs check /dev/sda3
Checking filesystem on /dev/sda3
UUID: 38c4b032-de12-4dcd-bf66-05e1d03143a8
checking extents
checking free space cache
checking fs roots
root 297 inode 28796828 errors 200, dir isize wrong
root 297 inode 28796829 errors 200, dir isize wrong
root 297 inode 28800233 errors 1, no inode item
   unresolved ref dir 28796828 index 506 namelen 14 name
ip6tables.conf filetype 1 errors 5, no dir item, no inode ref
root 297 inode 28800269 errors 1, no inode item
   unresolved ref dir 28796829 index 452 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800270 errors 1, no inode item
   unresolved ref dir 28796829 index 454 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800271 errors 1, no inode item
   unresolved ref dir 28796829 index 456 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800272 errors 1, no inode item
   unresolved ref dir 28796829 index 458 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800273 errors 1, no inode item
   unresolved ref dir 28796829 index 460 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800274 errors 1, no inode item
   unresolved ref dir 28796829 index 462 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
root 297 inode 28800275 errors 1, no inode item
   unresolved ref dir 28796829 index 464 namelen 30 name
logical_switch_info_config.xml filetype 1 errors 5, no dir item, no
inode ref
found 13651775501 bytes used err is 1
total csum bytes: 12890096
total tree bytes: 267644928
total fs tree bytes: 202223616
total extent tree bytes: 45633536
btree space waste bytes: 59752814
file data blocks allocated: 16155500544
referenced 16745402368


We run the rootfs on BTRFS and mount it using below options

# mount -t btrfs
/dev/sda3 on / type btrfs
(rw,noatime,degraded,compress=lzo,ssd,flushoncommit,space_cache,subvolid=292,subvol=/@/netvisor-5)
/dev/sda3 on /.rootbe type btrfs
(rw,noatime,degraded,compress=lzo,ssd,flushoncommit,space_cache,subvolid=256,subvol=/@)
/dev/sda3 on /home type btrfs
(rw,noatime,degraded,compress=lzo,ssd,flushoncommit,space_cache,subvolid=257,subvol=/@home)
/dev/sda3 on /var/nvOS/log type btrfs
(rw,noatime,degraded,compress=lzo,ssd,flushoncommit,space_cache,subvolid=258,subvol=/@var_nvOS_log)
/dev/sda3 on /sftp/nvOS type btrfs
(rw,noatime,degraded,compress=lzo,ssd,flushoncommit,space_cache,subvolid=292,subvol=/@/netvisor-5)

# btrfs fi df /.rootbe
System, RAID1: total=32.00MiB, used=12.00KiB
Data+Metadata, RAID1: total=36.00GiB, used=34.19GiB
GlobalReserve, single: total=132.65MiB, used=0.00B

# btrfs --version
btrfs-progs v5.4.1

Regards,
Gowtham
