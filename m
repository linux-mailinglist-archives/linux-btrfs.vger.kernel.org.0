Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE2277EE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIYEYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 00:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgIYEYI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 00:24:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBBC0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 21:24:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so1447286pgl.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 21:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Y7a5rfhlYMEscAbNsfHE3GMELk5InRYRzwULr0YJiy4=;
        b=Vvtn5aQ3rVakv1OHMnsgwlYzN7B6yIwOhJXrzQVT7u8yH37BrU6PKn7j4LHH+sXOye
         +nJ5dFUFKMaoLBaqP+UIYCIn55DtTJicezraf8eGQcHIGpJgpL8KJ8JQ+fSHHz/FjCuf
         PAnEV445foOLBSdTm5tZEfevgJJg50oz+7Z73BZlWrekUFdPCPR+Zn0/AZLs8om3IK9a
         LWUwDl/E+ghjsymaSbUthUqyI9J7WWkLNFRGq13XJpuS1GhvOTxgZhYH2WLKmzx6gwOh
         TVr+kq4VF90XB0YxStyG87i7evou2hQS2nNh4AezSZulBmiCACQerTm9qhbGDo+VKti2
         1elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Y7a5rfhlYMEscAbNsfHE3GMELk5InRYRzwULr0YJiy4=;
        b=mZJcpLsluNOxQ1UAAvxvGYo8yFBoPGNwD4wpEGDU2VOkBdRkMy5ck5ByYuLOk4m6JZ
         WNHjibEZ5s9oqP7hxmC1ZzU30Bpdqc5BU8MykNcoQJm4NaPwuydd0d8oT+duTO9CugGm
         PB28fjnxM7MGY7hSyMikjCjFj55sGWv33BwXcmOUGEBcB3WMKGeMpgxrf5FE4uCsQCjo
         rc3irNKRE9po3ChqKPdQE2zkOvraQRNXsNnZ3Z0ZRsLNPEU5V1C3f7ulwaFhNH2tuFgV
         c7PfgmF2p680s9bZOeOpCTHASEOEyKwPWFa+eL6Fvhi3KZdc7Lgez3QCdfhdntPER3T/
         inSw==
X-Gm-Message-State: AOAM530+nLWZeEcoPkfohapCbpT7Eu0ELbvFUEWpuc9OIjUJJ15U8v0/
        C69+xhB6DxBvnwnQ0+mAioHQj1oZEExLRg==
X-Google-Smtp-Source: ABdhPJwHrfcJGZ4xUPmba/0irRNiFMhVmWZNzqPEYl0Cj1xYnpCyKjM1FxSCRsOBHqh5jcyQNZgzDQ==
X-Received: by 2002:a05:6a00:2387:b029:142:2501:3970 with SMTP id f7-20020a056a002387b029014225013970mr2349121pfc.53.1601007847929;
        Thu, 24 Sep 2020 21:24:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-166-9.hsd1.or.comcast.net. [67.170.166.9])
        by smtp.gmail.com with ESMTPSA id z63sm980351pfz.187.2020.09.24.21.24.06
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 21:24:07 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Jacob Riddle <ironlenny@gmail.com>
Subject: Error: failed to read chunk root
Message-ID: <00fe2cbb-e5ef-72a9-9702-4992f1b5954e@gmail.com>
Date:   Thu, 24 Sep 2020 21:24:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Information requested by 
https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list:
 > uname -a
Linux ranger 5.8.7-1-default #1 SMP Sun Sep 6 07:39:46 UTC 2020 
(7fc52c0) x86_64 x86_64v x86_64 GNU/Linux
 > btrfs --version
btrfs-progs v5.7
 > btrfs fi show
Label: none  uuid: 3570f55b-a52a-482f-9629-ba282cdd3ada
         Total devices 1 FS bytes used 17.01GiB
         devid    1 size 20.00GiB used 20.00GiB path /dev/nvme0n1p3

Label: none  uuid: 9d1911ef-773e-4a73-978a-5814fcf46f68
          Total devices 1 FS bytes used 870.93GiB
          devid    1 size 1.82TiB used 874.08GiB path /dev/bcache0
 > btrfs fi df /home # Replace /home with the mount point of your 
btrfs-filesystem
Cannot provide for /home as filesystem is unmountable
 > dmesg > dmesg.log

Error is in the body.

I am running OpenSUSE Tumbleweed. My home mount is a Bcache device with 
BTRFS. I
did an update and restarted the computer. Everything seemed to be going 
well,
untill KDE stopped loading. I switched to a virtual terminal to see what the
problem was. Upon logging in, I was presented with a stream of BTRFS 
errors. I
don't remember what the errors were, as I prompltly forced the computer 
down. I
booted into the recovery kernel, and tried doing `mount /home`. I now 
get this
error:

[    6.848351] BTRFS info (device bcache0): use zstd compression, level 3
[    6.848352] BTRFS info (device bcache0): disk space caching is enabled
[    6.848353] BTRFS info (device bcache0): has skinny extents
[    6.848802] BTRFS error (device bcache0): bad tree block start, want 
1129766191104 have 1123189522432
[    6.848806] BTRFS error (device bcache0): failed to read chunk root
[    6.884205] BTRFS error (device bcache0): open_ctree failed
mount: /home: wrong fs type, bad option, bad superblock on /dev/bcache0, 
missing codepage or helper program, or other error.

Can I recover from this? If so, what steps do I need to take?

