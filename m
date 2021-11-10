Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06B444BA3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 03:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhKJCUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 21:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhKJCUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 21:20:25 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8EC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 18:17:38 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p2so1625898uad.11
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 18:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=BCZ6fJ8P0o5yqFz+qrbVmedcrKN9bMOSwbC2vpvcmV0=;
        b=XkNl67qWPg1RLhd0bxezLTQcTA8s2/F+wYRVBWUNdXC70ecYJnpQkwEZGlESjl2flb
         H0Z+gh5D2cDnS3vSePYCdymjjjLfANKvlZVEG8y320mhpPIlUvCEzYmB3sr9MUmZ/Jc1
         EcMJ1FLs5lurFzw5n5ADa+nadJdKNpr2IiNxLPXfYPfOd4bJE+uhpqCVQsKxhkUNdAmZ
         MXc85UXic9LquPLcwLfC67qsJhL1S58kusbHU6DYNagS+JTn5pr57beC7JhOyAiSfkF3
         27e1M5uvbcR6QQxITztWyy3vog2mxudnmJHrXd9Y7+aA4xD0AqtuvZIG1A7rrmj3gOt6
         Qj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=BCZ6fJ8P0o5yqFz+qrbVmedcrKN9bMOSwbC2vpvcmV0=;
        b=PKHd37W6pNfLjYGVcBT73SryxXcJW8W3ZXSI5pxJz8EYXDphORQlwqgrzpg85oyIEy
         Y5L/E2YxkgMIHG4gmX0lx3Uo03VEDhnWEhdCX3O2Q+Wp7uMgZ7hNYeYQNaZVtLWub0fb
         5T4Y+n+zeMCbbf4XeNwzjZ92nKAzMZSkqwApePAVSJeY40Zc6DGPuA1NJ6ngPedG0hbO
         Zcle9j+o48UmPurjhCWbDpGdPTMl3rb1vc1MilvU8kS+eZLgHNxpf9R2jCQT2tDObKAW
         S20iZq3aBnI/Xx5jVxsLK+HcrrKZVC8HlB+SB+Rc3jwqOQEnq/vmFJ0j59gWRG9tHXwY
         9+yw==
X-Gm-Message-State: AOAM5305+9kKaryiquLV7G1bJli4uO7wphGLcsuoEGPdmXDICnKF16kB
        OeRhdsykcbSG+t3S+Mz07lkBH0Fqs5o=
X-Google-Smtp-Source: ABdhPJyWHoPu7CIdBnM35uA++0f0eiRsxv3Gr3spj5ls9IIXJz4iZ9DkdSsbk+3bRB3NwNtnEDpGjA==
X-Received: by 2002:ab0:6883:: with SMTP id t3mr16980925uar.66.1636510656939;
        Tue, 09 Nov 2021 18:17:36 -0800 (PST)
Received: from ?IPV6:2800:370:144:81b0:f245:e007:48ea:38b5? ([2800:370:144:81b0:f245:e007:48ea:38b5])
        by smtp.gmail.com with ESMTPSA id x9sm2083974vkn.36.2021.11.09.18.17.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 18:17:36 -0800 (PST)
Message-ID: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
Date:   Tue, 9 Nov 2021 21:17:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Firefox/88.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   "S." <sb56637@gmail.com>
Subject: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there, I run OpenMediaVault on an old LaCiE NAS with an armel processor. It has two HDDs, with the Debian root on an EXT4 partition and a simple BtrFS RAID-1 using `/dev/sda3` + `/dev/sdb2` for the OpenMediaVault data. Both drives have a few bad blocks, but I assumed that the filesystem was working around them, because it was running fine for almost 2 years on Buster. The SMART report for both drives says `SMART overall-health self-assessment test result: PASSED`. Today I upgraded to OpenMediaVault 6 and Debian Bullseye, and the BtrFS volume is no longer mountable. Here are my attempts thus far:

https://paste.debian.net/1218866/

For the search engines, these are the key errors:

-----------------------------

     [   86.110770] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
     [   86.125317] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
     [   86.149595] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
     [   86.164280] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
     [   86.173099] BTRFS warning (device sda3): failed to read root (objectid=9): -5
     [   86.268589] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
     [   86.283207] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
     [   86.298934] BTRFS critical (device sda3): corrupt leaf: root=9 block=170459136 slot=0, invalid key objectid, have 1101835439474057344 expect to be aligned to 4096
     [   86.313575] BTRFS error (device sda3): block=170459136 read time tree block corruption detected
     [   86.322394] BTRFS warning (device sda3): failed to read root (objectid=9): -5
     [   86.363745] BTRFS error (device sda3): parent transid verify failed on 78086144 wanted 8060 found 8063
     [   86.390901] BTRFS error (device sda3): parent transid verify failed on 78086144 wanted 8060 found 8063
     [   86.414379] BTRFS error (device sda3): parent transid verify failed on 79216640 wanted 8061 found 8063
     [   86.434284] BTRFS error (device sda3): parent transid verify failed on 79216640 wanted 8061 found 8063
     [   86.465467] BTRFS warning (device sda3): couldn't read tree root
     [   86.500332] BTRFS error (device sda3): open_ctree failed

-----------------------------

     root@OpenMediaVault:~# btrfs check /dev/sda3
     Opening filesystem to check...
     Checking filesystem on /dev/sda3
     UUID: 4a057760-998c-4c66-aa6a-2a08c51d5299
     [1/7] checking root items
     [2/7] checking extents
     Invalid key type(EXTENT_ITEM) found in root(UUID_TREE)
     ignoring invalid key
     [3/7] checking free space cache
     [4/7] checking fs roots
     [5/7] checking only csums items (without verifying data)
     [6/7] checking root refs
     [7/7] checking quota groups skipped (not enabled on this FS)
     found 704343715840 bytes used, no error found
     total csum bytes: 686922316
     total tree bytes: 757006336
     total fs tree bytes: 14794752
     total extent tree bytes: 13795328
     btree space waste bytes: 32551835
     file data blocks allocated: 707684626432
      referenced 707430318080

-----------------------------

Any suggestions? Thanks a lot.
