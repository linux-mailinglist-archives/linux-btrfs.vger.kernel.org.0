Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBFE6D704F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 00:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjDDWwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 18:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjDDWwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 18:52:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21721732
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 15:52:34 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1phcaV1x0a-002Gat; Wed, 05
 Apr 2023 00:52:32 +0200
Message-ID: <3af78c98-3d14-4145-c57e-2fc761fcd1ad@gmx.com>
Date:   Wed, 5 Apr 2023 06:52:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Bug] Device removal, writes to disk being removed
To:     Torstein Eide <torsteine@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAL5DHTE6ffo2PUdOEeN1OqaCen_an15L3suOXS4cNkz__kPzXQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL5DHTE6ffo2PUdOEeN1OqaCen_an15L3suOXS4cNkz__kPzXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Zhq5V/VyTlUgXOgsIbgvsdNj/i5Ti3npC/E/m2OAtR5vZr+HDWp
 257dz037bP2Qtfm1IOWvMBdQ88EiPJqNpSsPSZ+TJZxT0pHW7SBO1J398rCYXZtORxmNYqg
 z4M0iAgwkomFlDDDIrrRaBywZAqAO2/muzUliEebH3FfK/dhFaGT2tn7zaiQjOKl11WENWN
 QLmkG72EBxXqtii/3i+3w==
UI-OutboundReport: notjunk:1;M01:P0:cQapKsqKU8Y=;akxtOlTUB0vAs6aDP5yywOW6Ksd
 /qRX7zSW4CPHPHYlqaojut3f/sNVpsr4uHqMSzb3/Y8V3RikqKOVHn60iW0q1JQULirW/XNue
 /PmCRzlp2wI3o45aVXc5ym50FDd4ECi1fy3/wGPNWb/0xraymkc9juUkqz8d00pf4ZiU8+O40
 3WHlhKyaYY8jmiJoh5CWVhlv65/eENEF72sevuTtoTi7aVaK2WaIBUv5/6faru1liamdGvtyu
 a7nqsOKv4S8qtvckT4DzS8iR9ZqomwBCyTVf9mMEIVT/NJLoYdWcy3tlx29TTrFrmnFuESOkn
 7PGVoXRiL4mud8GIlPxrPsx70VOMY30D2Td5abD/pqssv6lwKmTsZWHyRD79Tej7Ck+ujTtDY
 7Q5w14CXg69VyV5JvVSDFMTAMw5sii4yFUFFdY9ruiW2IVi4x3qRYNebEPedExYErtg+rrGhg
 exUCA6by3DV3hUzNXi0IKnMNTdIi7oUrjXheBDYZ2eiGCtltrN1piUQooBGs1yBO7172ZPYcW
 IKQcm7NcxGSKLNPqYMWp1mLWBSfT/7O2jjOXG34+wDwLqaF4ujkVfaWXB7WuQ+QJWtxZSwabu
 Gg/5RvOv3hG6NEUmup+T4Vx7p5YjvPGVl7IFoj2Y2OdE6bf2fGmpRdjLUS6/GgCtKTypSzYGQ
 zAqiSvsUECwg9Tt4U0yD1SWgvUYWS9UnjlxGVWu39XiY62TRppbJYXVEQR7IGi+Umk6CaWPOd
 gg+LkPtkftwJDNa8OfIwNR6605AqrRYQBlrJnH7yDSLnRvuLQzfvn3FgzEJh+f6gml2FYDov7
 hIIBpJAupUtv0C56BuBdXobZl9SMRgBfsDy0hyJIvyjvTsPnZlh/27fM3n/hPDRsOlzDO7SLZ
 8r0e2SfhT6vKsjgay9t+x1bmasC2fYuQAaGCaZuHURZYytIwQVhYDC/pTO7TjrdDBHaXc7RSb
 qbh5nJSnrqcMakK1aY/k7gtUWY4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/5 04:21, Torstein Eide wrote:
> There is a bug with:
> -  `btrfs device remove $Disk_1 $Disk_2 $volume`
> 
> When multiple devices from a volume, it still writes to $Disk_2, will
> removing $disk_1.

Device removal is done by relocating all the chunks from the target 
device, ONE BY ONE.

Thus it means when removing disk1, we can still utilize the space in disk2.

In fact, even removing disk1, it's still possible to write data into it 
until the last chunk is being relocated.

Thanks,
Qu
> 
> ## Command used:
> ````
> btrfs device remove /dev/bcache5 /dev/bcache3 /volum1/
> ````
> 
> ## iostat
> ````
> Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
> MB_read    MB_wrtn    MB_dscd
> sdc (R1)       225.00        27.19         0.00         0.00
> 27          0          0
> sdd (R2)        94.00         0.00       105.56         0.00
> 0        105          0
> sde              324.00        27.19       113.06         0.00
> 27        113          0
> sdf               322.00        26.75       113.13         0.00
>   26        113          0
> sdg              310.00        26.00       108.06         0.00
> 26        108          0
> sdh              325.00        27.19       113.06         0.00
> 27        113          0
> ````
> 
> ## uname -a:
> ````
> Linux server2 5.15.0-69-generic #76~20.04.1-Ubuntu SMP Mon Mar 20
> 15:54:19 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> ````
> 
> ## btrfs version
> ````
> btrfs-progs v5.4.1
> ````
