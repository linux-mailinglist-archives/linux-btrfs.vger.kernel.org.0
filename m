Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDEFE3B5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504099AbfJXSyJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 14:54:09 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43609 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408132AbfJXSyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 14:54:09 -0400
Received: by mail-ed1-f50.google.com with SMTP id q24so13483192edr.10
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LaC3r3uYf08XOugI9Pm2KV8ixI8aqHkH3db/U4aO9Qc=;
        b=MNaMmbr1DEXdySEyXABrfSZtggetJz+yCGpUFPNm+0r3H2pL0+IuFc2mCWqhWSwe5m
         urrdy2WUklCj7OG0LNccg4EuKpAVcmwHS5KTad7ouxl1u3OKsct2eSg1XxfAZOK+AGLN
         G0KcFSAjnvpfjzvWzC+lhQ4r+Ml24udZo+h67TdxUm8zsrsd+fG+OLd8zR8bLiFQw9/P
         bMWFIMA3bZv7/PIYDtH+aL4wEzSPrx2AemK88v1cLFw1qsgmvNJ/FxkriawCFi5GHlTa
         +JAeWeLdIPo3DHS8YPGv7ZFnXSBn+sTTt95OUZ+mJw/D9y0xLUfe1oBcTdePZLPY9as3
         2aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LaC3r3uYf08XOugI9Pm2KV8ixI8aqHkH3db/U4aO9Qc=;
        b=AhcwYo2J0utIPe8JCRoNwC24zrNU3ardBFCvgNt6e5G1tm15Q9e1fNNOWxbpjUptDr
         xF9Ja0dmXWrHDf85D619Una6L+DZbIhPzCkTTd2gQQTAG/r9nrSXniBiccC7Tk+3lFpG
         Ao0ERRDWBxgsaN+jeyxLocw57pXufVOqQnYwcO3D0no8oXK4WExdTVhVqzciJqdFfR18
         UjC/vJmVxsRgUT87MNAPyT1mpXyI55citYKokj68A64A06Xx9INqLJLm/09xd6rixA6q
         R0KUYi/2pF/FP3cr/xi5ZwOHqj22L0xooYSYBrBonhEOFOvjyD7TI+w8R5fD3SaB+WLF
         LaIA==
X-Gm-Message-State: APjAAAU6DPLOciZk1TaXEGwkdictNiQGKbo+kZnvznJ4tTgftaak1a1P
        T4fGeOZhUxOTJCH2AdLU17PsrG1D
X-Google-Smtp-Source: APXvYqxQ7qFPRQT/qjwXpG5gcqeTA3vvRbcHtgRhVwOcCBEGHCK6O8f7qKPAADuXOn43Odxv+drXLA==
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr45804217edv.90.1571943246681;
        Thu, 24 Oct 2019 11:54:06 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b027:cc00:e811:3e4e:4af1:29fb? ([2a01:c22:b027:cc00:e811:3e4e:4af1:29fb])
        by smtp.googlemail.com with ESMTPSA id f10sm37809ejd.25.2019.10.24.11.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 11:54:05 -0700 (PDT)
From:   Tobias Reinhard <trtracer@gmail.com>
Subject: Re: Effect of punching holes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <2b75abb1-4dd8-1da4-77be-7557ff53ec75@gmail.com>
 <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
Message-ID: <ffcefdb2-6b97-ada1-35b9-6e7f688f54c9@gmail.com>
Date:   Thu, 24 Oct 2019 20:54:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <67354156-286a-f80e-ebc3-99c32e356fac@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Di., 22. Okt. 2019 um 12:01 Uhr schrieb Qu Wenruo 
<quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>>:



    On 2019/10/22 下午5:47, Tobias Reinhard wrote:
     > Hi,
     >
     >
     > I noticed that if you punch a hole in the middle of a file the
    available
     > filesystem space seems not to increase.
     >
     > Kernel is 5.2.11
     >
     > To reproduce:
     >
     > ->mkfs.btrfs /dev/loop1 -f
     >
     > btrfs-progs v4.15.1
     > See http://btrfs.wiki.kernel.org for more information.
     >
     > Detected a SSD, turning off metadata duplication.  Mkfs with -m
    dup if
     > you want to force metadata duplication.
     > Label:              (null)
     > UUID:               415e925a-588a-4b8f-bdc7-c30a4a0f5587
     > Node size:          16384
     > Sector size:        4096
     > Filesystem size:    1.00GiB
     > Block group profiles:
     >   Data:             single            8.00MiB
     >   Metadata:         single            8.00MiB
     >   System:           single            4.00MiB
     > SSD detected:       yes
     > Incompat features:  extref, skinny-metadata
     > Number of devices:  1
     > Devices:
     >    ID        SIZE  PATH
     >     1     1.00GiB  /dev/loop1
     >
     > ->mount /dev/loop1 /srv/btrtest2
     >
     > ->for i in $(seq 1 20); do dd if=/dev/urandom of=test$i bs=16M
    count=4 ;
     > sync ; fallocate -p -o 4096 -l 67100672 test$i && sync ; done
     >
     > this failed from the 16th file on because of no space left

    Btrfs doesn't free the space until all space of a data extent get freed.

    In your case, your hole punch is [4k, 64M-4K), thus the 64M extent still
    has 4K being used.
    So the data extent won't be freed until you free the last 4K.

     >
     > ->df -T .
     > Filesystem     Type  1K-blocks   Used Available Use% Mounted on
     > /dev/loop1     btrfs   1048576 935856      2272 100% /srv/btrtest2
     >
     > ->btrfs fi du .
     >      Total   Exclusive  Set shared  Filename
     >    8.00KiB     8.00KiB           -  ./test1
     >    8.00KiB     8.00KiB           -  ./test2
     >    8.00KiB     8.00KiB           -  ./test3
     >    8.00KiB     8.00KiB           -  ./test4
     >    8.00KiB     8.00KiB           -  ./test5
     >    8.00KiB     8.00KiB           -  ./test6
     >    8.00KiB     8.00KiB           -  ./test7
     >    8.00KiB     8.00KiB           -  ./test8
     >    8.00KiB     8.00KiB           -  ./test9
     >    8.00KiB     8.00KiB           -  ./test10
     >    8.00KiB     8.00KiB           -  ./test11
     >    8.00KiB     8.00KiB           -  ./test12
     >    8.00KiB     8.00KiB           -  ./test13
     >    8.00KiB     8.00KiB           -  ./test14
     >    8.00KiB     8.00KiB           -  ./test15
     >    4.00KiB     4.00KiB           -  ./test16
     >    4.00KiB     4.00KiB           -  ./test17
     >    4.00KiB     4.00KiB           -  ./test18
     >    4.00KiB     4.00KiB           -  ./test19
     >    4.00KiB     4.00KiB           -  ./test20
     >  140.00KiB   140.00KiB       0.00B  .
     >
     > When doing this on XFS or EXT4 it works as expected:
     >
     > Filesystem     Type 1K-blocks  Used Available Use% Mounted on
     > /dev/loop1     ext4    999320  2764    927744   1% /srv/btrtest
     > /dev/loop2     xfs    1038336 40456    997880   4% /srv/xfstest
     >
     > How to i reclaim the space on BTRFS? Defrag does not seem to help.

    Rewrite the remaining 4K.

    Then the new write 4K will be cowed into a new 4K extent, the old large
    64M extent gets fully freed and free space.

    Thanks,
    Qu

(sorry - for previous bad formated post)

Hi,

okay - thanks for the explanation.

How can I find out that rewriting parts of an extent would free up space?

Tobias

