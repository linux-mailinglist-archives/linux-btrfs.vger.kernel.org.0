Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EA4F669
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2019 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVPL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jun 2019 11:11:59 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36085 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVPL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jun 2019 11:11:59 -0400
Received: by mail-lf1-f46.google.com with SMTP id q26so7071357lfc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jun 2019 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uNYxg62Ew+1AkQX6bUs4BgW6yjhqtHw93fCeGVCRKZ8=;
        b=H5Jv7swbUZQipU7GMzkagoHXAQwU76H8ShQdxUxA7EgAabEG9Dwe+15equRYbiOw2q
         CqN2QqS2II5f7avldPJg9yBqbv39xRsj3r6xlO8cp0NTyvt3rn8R1sViKymlD/K+gYO0
         6M2V5MmKw7HedI85UmmDMv8Uxi3V3PsHY7BsqYhS/p/l0k1RpN7DJ/6Qr+MZskqT+w8x
         FgsnuOggc+w5ykqaHWTGrOR6RcP9SW0EZioFlkYoHN8SjO5BgbC50N3Oxedbjl2IzLdb
         XJC9X6gnOw2PARwrx2xVMrAYv553XDwyeR1w0y1VsHvfCs9bTUFjbGfAmiQW5mUovJne
         Thdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=uNYxg62Ew+1AkQX6bUs4BgW6yjhqtHw93fCeGVCRKZ8=;
        b=bZC8s2e9EvNWjP7Lw22UHQ9pT3OpsZ04zIgnuZxh82hRYsQdmeWii6rcOo9xU//k4y
         iZaJ/nTO7jdPQLqf6mqeqC+i5Bl22y3fbsUZciV8OVGRqi03H88D8BYIml5d95b6ZTfJ
         ksEup6w08GiJD37qgBwTe4neehyJU7inX0Au3cIXUo4Nffgw3SwBAUd8p6YjnEhREzzN
         KTBrRMrE2fPiujoIVax+ZvqFmTFyC6X9ViAdnPxWr2cczGYgc2S7iIhiQryStXITNPfs
         K6NmmtQq37SHGXpEyKHWcRoloElwn015c+rQKEwQdduI1ItejhP6vYlPhWAIAaCiRU7b
         40qQ==
X-Gm-Message-State: APjAAAXIdXyCJX/6pM+nbbqSMwj4JMdFJqkn/bhW1Viznh0KEar/AQcx
        QJq+/2hv+3fkGfI8Gdd4EubtxZgC
X-Google-Smtp-Source: APXvYqwy7kMl3jGOaaQMlKL8kMc4rQTkCH6TtDK4I2jwFPtFki5chvFU1Aj1DPb5RtJJEXRluqMDnA==
X-Received: by 2002:ac2:546a:: with SMTP id e10mr24035929lfn.75.1561216315505;
        Sat, 22 Jun 2019 08:11:55 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id b11sm880057ljf.8.2019.06.22.08.11.53
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 08:11:54 -0700 (PDT)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Confused by btrfs quota group accounting
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
Date:   Sat, 22 Jun 2019 18:11:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Linux 10.0.2.15 5.1.7-1-default #1 SMP Tue Jun 4 07:56:54 UTC 2019
(55f2451) x86_64 x86_64 x86_64 GNU/Linux

Consider the following:

10:~ # mkfs.btrfs -f /dev/vdb /dev/vdc
btrfs-progs v5.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               d10df0fa-25aa-4d80-89d9-16033ae3392d
Node size:          16384
Sector size:        4096
Filesystem size:    2.00GiB
Block group profiles:
  Data:             RAID0           204.75MiB
  Metadata:         RAID1           102.38MiB
  System:           RAID1             8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  2
Devices:
   ID        SIZE  PATH
    1     1.00GiB  /dev/vdb
    2     1.00GiB  /dev/vdc

10:~ # mount /dev/vdb /mnt
10:~ # cd -
/mnt
10:/mnt # btrfs quota enable .
10:/mnt # btrfs sub cre test
Create subvolume './test'
10:/mnt # dd if=/dev/urandom of=test/file bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 6.71373 s, 160 MB/s
10:/mnt # sync
10:/mnt # btrfs qgroup show .
qgroupid         rfer         excl
--------         ----         ----
0/5          16.00KiB     16.00KiB
0/258         1.00GiB      1.00GiB
10:/mnt # filefrag -v test/file
Filesystem type is: 9123683e
File size of test/file is 1073741824 (262144 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   43135:      33664..     76799:  43136:
   1:    43136..   97279:      86048..    140191:  54144:      76800:
   2:    97280..  151551:     143392..    197663:  54272:     140192:
   3:   151552..  207359:     200736..    256543:  55808:     197664:
   4:   207360..  262143:     258080..    312863:  54784:     256544:
last,eof
test/file: 5 extents found


OK, we have 1Gib file consisting of 5 extents ~200MiB each, btrfs quota
reports 1GiB exclusive in subvolume test which is correct.

10:/mnt # btrfs subvolume snapshot -r test snap1
Create a readonly snapshot of 'test' in './snap1'
10:/mnt # sync
10:/mnt # btrfs qgroup show .
qgroupid         rfer         excl
--------         ----         ----
0/5          16.00KiB     16.00KiB
0/258         1.00GiB     16.00KiB
0/263         1.00GiB     16.00KiB
10:/mnt # filefrag -v test/file
Filesystem type is: 9123683e
File size of test/file is 1073741824 (262144 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   43135:      33664..     76799:  43136:             shared
   1:    43136..   97279:      86048..    140191:  54144:      76800: shared
   2:    97280..  151551:     143392..    197663:  54272:     140192: shared
   3:   151552..  207359:     200736..    256543:  55808:     197664: shared
   4:   207360..  262143:     258080..    312863:  54784:     256544:
last,shared,eof
test/file: 5 extents found

Also correct, content of test and snap1 is shared so we have two
subvolumes with zero exclusive usage. Also good.

10:/mnt # dd if=/dev/urandom of=test/file bs=1M count=100 seek=0
conv=notrunc
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.685532 s, 153 MB/s
10:/mnt # sync
10:/mnt # btrfs qgroup show .
qgroupid         rfer         excl
--------         ----         ----
0/5          16.00KiB     16.00KiB
0/258         1.01GiB    100.02MiB
0/263         1.00GiB     85.02MiB
10:/mnt # filefrag -v test/file
Filesystem type is: 9123683e
File size of test/file is 1073741824 (262144 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   22463:     315424..    337887:  22464:
   1:    22464..   25599:      76896..     80031:   3136:     337888:
   2:    25600..   43135:      59264..     76799:  17536:      80032: shared
   3:    43136..   97279:      86048..    140191:  54144:      76800: shared
   4:    97280..  151551:     143392..    197663:  54272:     140192: shared
   5:   151552..  207359:     200736..    256543:  55808:     197664: shared
   6:   207360..  262143:     258080..    312863:  54784:     256544:
last,shared,eof
test/file: 7 extents found
10:/mnt # filefrag -v snap1/file
Filesystem type is: 9123683e
File size of snap1/file is 1073741824 (262144 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   43135:      33664..     76799:  43136:
   1:    43136..   97279:      86048..    140191:  54144:      76800: shared
   2:    97280..  151551:     143392..    197663:  54272:     140192: shared
   3:   151552..  207359:     200736..    256543:  55808:     197664: shared
   4:   207360..  262143:     258080..    312863:  54784:     256544:
last,shared,eof
snap1/file: 5 extents found


Oops. Where 85MiB exclusive usage in snapshot comes from? I would expect
one of

- 0 exclusive, because original first extent is still referenced by test
(even though partially), so if qgroup counts physical space usage, snap1
effectively refers to the same physical extents as test.

- 100MiB exclusive if qgroup counts logical space consumption, because
snapshot now has 100MiB different data.

But 85MiB? It does not match any observed value. Judging by 1.01GiB of
referenced space for subvolume test, qrgoup counts physical usage, at
which point snapshot exclusive space consumption remains 0.
