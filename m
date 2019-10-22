Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE1E0105
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfJVJrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:47:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbfJVJrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:47:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so16728465wrt.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kPCWgJUjQTSaOIotW7A1LEBR2LumT5v9MKoPGuvdXuQ=;
        b=eav5bDHbTKS4NOwkKz/cPq4Jq3Wjmnp9Bi/d6oU3J8xpfliEQ+lPj1cgiEsPslZcLy
         5e2jBrb4FFA5zOuFkoNAE1GsAaAz9eFUCMGDn3TRVrkZ9QV26je0Ld2vzO4WX5FZYhWN
         chQoKo9WXj4p5P1J0APaOknwbZj1eifLGufot4d1row1WHAVSkFOZRokW+6NwwYi7tje
         eHg5POzC4RnXRw92QMyR4jxI56ozPTJovYRV+/UTj0arElpLZIPlKzSyNrd6YnbGFACM
         vqz9tSpBGqnxw8ROF2bx5qkaRWAGiHB1VROXNml86nvEp39Zk4QRL9tz9wy2PJ1bDpRL
         TlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kPCWgJUjQTSaOIotW7A1LEBR2LumT5v9MKoPGuvdXuQ=;
        b=D4PgzyMDdWj302OYgm4FUTD9722fh8yUiDC3mlW6FTgU+zKh4nYhllIN88irarOX9C
         nphmQPJSwgHyuajA+UvU3WhT1t9Y/r0Py14Z3L7JfWzW9pxLMvdRaU2Lz5/l8RCWah2n
         Oe4K8FWpFPFqCBsJx9fhIGz1sMrbsN6iFm2arlYsoFi0zSvFmzOrz49hRWegDWnmEZPP
         5w/TiWKjQAFN3QzC4yGvM+jggTpgZYqyHwbTswqDveo69A6B/ZWTayLOQ4iUVHVvbZX9
         yr0xdvNatiQ8nimPalTLWKhWzVoc+XQOIcchlo4GTIaLhi1A+OXr3ggDeUnZ8tkdYgua
         HuCg==
X-Gm-Message-State: APjAAAWoiXpF2ZKYCmyqEpUdV7YK5D8oPl7wWNqTTuU/MeroNXvvqKun
        KcZjgubJe8XBd9iAG7jrUWzaVkov
X-Google-Smtp-Source: APXvYqw8mav5i+lbGpboH3UJJYKvbAsjzKJz1Jgk1Def6dMujslpfiJFCb8P7DBSS4h2zTCTAJS9kw==
X-Received: by 2002:adf:e292:: with SMTP id v18mr2615247wri.190.1571737652242;
        Tue, 22 Oct 2019 02:47:32 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b075:6c00:7cb4:8171:de45:155c? ([2a01:c22:b075:6c00:7cb4:8171:de45:155c])
        by smtp.googlemail.com with ESMTPSA id o15sm222122wrv.76.2019.10.22.02.47.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 02:47:31 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Tobias Reinhard <trtracer@gmail.com>
Subject: Effect of punching holes
Message-ID: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
Date:   Tue, 22 Oct 2019 11:47:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,


I noticed that if you punch a hole in the middle of a file the available 
filesystem space seems not to increase.

Kernel is 5.2.11

To reproduce:

->mkfs.btrfs /dev/loop1 -f

btrfs-progs v4.15.1
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if 
you want to force metadata duplication.
Label:              (null)
UUID:               415e925a-588a-4b8f-bdc7-c30a4a0f5587
Node size:          16384
Sector size:        4096
Filesystem size:    1.00GiB
Block group profiles:
   Data:             single            8.00MiB
   Metadata:         single            8.00MiB
   System:           single            4.00MiB
SSD detected:       yes
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
    ID        SIZE  PATH
     1     1.00GiB  /dev/loop1

->mount /dev/loop1 /srv/btrtest2

->for i in $(seq 1 20); do dd if=/dev/urandom of=test$i bs=16M count=4 ; 
sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done

this failed from the 16th file on because of no space left

->df -T .
Filesystem     Type  1K-blocks   Used Available Use% Mounted on
/dev/loop1     btrfs   1048576 935856      2272 100% /srv/btrtest2

->btrfs fi du .
      Total   Exclusive  Set shared  Filename
    8.00KiB     8.00KiB           -  ./test1
    8.00KiB     8.00KiB           -  ./test2
    8.00KiB     8.00KiB           -  ./test3
    8.00KiB     8.00KiB           -  ./test4
    8.00KiB     8.00KiB           -  ./test5
    8.00KiB     8.00KiB           -  ./test6
    8.00KiB     8.00KiB           -  ./test7
    8.00KiB     8.00KiB           -  ./test8
    8.00KiB     8.00KiB           -  ./test9
    8.00KiB     8.00KiB           -  ./test10
    8.00KiB     8.00KiB           -  ./test11
    8.00KiB     8.00KiB           -  ./test12
    8.00KiB     8.00KiB           -  ./test13
    8.00KiB     8.00KiB           -  ./test14
    8.00KiB     8.00KiB           -  ./test15
    4.00KiB     4.00KiB           -  ./test16
    4.00KiB     4.00KiB           -  ./test17
    4.00KiB     4.00KiB           -  ./test18
    4.00KiB     4.00KiB           -  ./test19
    4.00KiB     4.00KiB           -  ./test20
  140.00KiB   140.00KiB       0.00B  .

When doing this on XFS or EXT4 it works as expected:

Filesystem     Type 1K-blocks  Used Available Use% Mounted on
/dev/loop1     ext4    999320  2764    927744   1% /srv/btrtest
/dev/loop2     xfs    1038336 40456    997880   4% /srv/xfstest

How to i reclaim the space on BTRFS? Defrag does not seem to help.

Best regards


Tobias

