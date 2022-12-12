Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171A649E9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 13:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiLLMX5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 07:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiLLMX4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 07:23:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A0B1DE
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 04:23:54 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MysW2-1oiLhb3F2o-00vyiA; Mon, 12
 Dec 2022 13:23:46 +0100
Message-ID: <3ad0e998-f4d7-1d51-50c0-5f7609fdabfe@gmx.com>
Date:   Mon, 12 Dec 2022 20:23:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0c1d274f-a917-9b12-1915-8a8346ebfa0c@dirtcellar.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Metadata RAID1c4 balance issue
In-Reply-To: <0c1d274f-a917-9b12-1915-8a8346ebfa0c@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:brp7p2+WYDfMzvWOK/czfqcupFo8o6JWmavMKmJx4AXDi4hnZP/
 x4+b9O3T/B3iNw1cNSJeFs7rucKh00QH7+hFu54YxviRLnT7e2CKgOLmtVtDb1hfpR9/YXK
 PlembfKbjMw59rmcRi3H/6KDnZb92cnbNWc59IepumeUFyIeaVMkQR2eR+wbD84eWDXAEz7
 0Gik3ElCWWTgEh2akEP6g==
UI-OutboundReport: notjunk:1;M01:P0:DGIEcnVcOhU=;k749Mp9Lb+XbMW6ZakKAQbXCh21
 JAJsYmEXpRLNr7sC1bPrD4Z6jaNBCaAz+3F57s/c4K97bwpG+MQWkX42CiNtgFart9B/GH00+
 NfRzTw5fAVO4TRi68Qtd/pY11HqjueVEydlKoqpxqLoK+d3Y/iZVmqmktz4k7pfS2Shj7Xupk
 xfZJKhrdDhafZGoATVTtB9UdcIAvJjxjeZRVDlNn13oOrUoL0d19tNTUPD18qBbFrWoYuwXUS
 lGB8ZbOGGMKDN45jgkWIFQuE8PTkSy7NZp+ukPrnMDyzG4T2aCOPfB+IHg0J/TX5qffqwLEFa
 OQGkFVac4xbH6kU4WmDOw/cgf/MN3qyZ2RonzXq90CYC5MUhCMKCYi1ZVgLDftOtZQd+igEVL
 bjm2tvOoS1CyrZOouJRapZS2JRheOsyh6/MY4PmLLtnx6wW/qqULkGLxRCgRiE332TMKvuxmC
 oYticX9kwkA2QGj+ckb0TspnyJMVw/ctp++z4FyPqg0PtfwwgWSIZS6DHULtVYdaU3ucXbDLu
 RtKJSeiikp/cliWCgvJ/+bvGGfwRyjGiQs9aROiURDb6lbwabcDLrWwKxe2WbL0ILDoyeW+dC
 DsstwcRZREXBnsN2BKXviwS5/1KG1haf8G06XlCTjIKoaT2EGozJkuu0S0qeHIPb358P1DaAV
 CIz6obyEswChLMoteO8r4RbaY8Q+r6favI0WOXsSilM99xGxciqW3yY1ytIkVOuz5EWSaOn66
 EHoNqzSGYM01wWvTHJ7iYc+kNrLX31nYd2lxSA3jXB4B1Jp0KoZtkdwxcbGnCubYWHBAxl4r1
 6/B1yzwGKjUimn6whDO1DD+Ks2PbE+DcqbSVmkSxahS3iJfEdjHfZX125eqQZQIoLmdLj3SBE
 uPJZsb9ibQeompLnPEASxiIIzrv9mGpjezXT59fuU6wZDJq5mWTZR+aRSGEnae8x9G+g0XkFx
 lDleyVl6Z6/XbiVNdjYMcCMOXSo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 18:22, waxhead wrote:
> Howdy,
> 
> I have just recently fired up a clean fs (kernel 6.0 (current in Debian 
> testing)) and have started rsyncing files to it.
> The system has 24 x 3TB drives e.g. same size devices.
> 
> Not that it matters much from a practical point of view, but I notice 
> that metadata seems to be quite unbalanced. As shown below there are 
> some drives which does not have metadata at all yet, and other drives 
> that have several chunks allocated. I would expect that metadata was 
> allocated more evenly across the drives.
> 
> I do however realize what is going on (at least I think so) , when 
> data-chunks are allocated the they of course consume space, and 
> therefore the metadata allocation simply picks the drives with the most 
> free space which is optimal as far as the unallocated space is concerned.

This understanding is completely correct.

Although I'd say that's one part of the cause.


The other part contributing to the unbalancing allocation is, your 
metadata is really too small, thus making the unbalanced behavior much 
more observable.

Remember, you only have 10G metadata, which are just 10 metadata chunks.
And by pure average, one disk should only have 1.67 metadata chunks.

Missing one metadata chunk or having one extra metadata chunk would be 
2/3 of the average, thus super obvious.

In fact, your data RAID1C4 has a similar amount of unbalanced chunks.
(I use 557G as the average data allocated size)

ID  Data diff
--  ---------
1   -1G
2   -1G
3   -1G
4   -3G
5   -1G
6   +1G
7   +1G
8   +1G
9   +2G
10  +2G
11  +1G
12  0
13  -3G
14  +1G
15  -3G
16  +2G
17  -2G
18  +2G
19  0
20  0
21  0
22  +1G
23  -2G
24  0

But with a base of 500+GiB, several GiB diffs really makes it hard to 
observe.

> 
> Would it not make more sense for the metadata allocation to try to 
> allocate space on the drive with the LEAST metadataspace used first (at 
> least up until a certain point), and if that fails, then fall back to 
> allocating from the device with the most free space?.

That would only benefit cases with very little metadata (compared to data).

And may not handle corner cases well (e.g unbalanced device sizes).

If you can 10x your metadata usage, I guess the unbalance would be less 
obvious.

Thanks,
Qu

> 
> As I see it - that would help spreading out metadata and reducing the 
> risk / amount of data that needs to be repaired if something goes 
> haywire. Also the chance of hitting a idle device to read metadata off 
> (as in the example below) might be higher which may be good for speed.
> 
> So I am not searching for a solution, this is just an observation.
> 
> btrfs fi us -T /mnt
> 
> Overall:
>      Device size:                  65.50TiB
>      Device allocated:             13.09TiB
>      Device unallocated:           52.41TiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         13.08TiB
>      Free (estimated):             26.21TiB      (min: 13.10TiB)
>      Free (statfs, df):            26.21TiB
>      Data ratio:                       2.00
>      Metadata ratio:                   4.00
>      Global reserve:              512.00MiB      (used: 64.00KiB)
>      Multiple profiles:                  no
> 
>               Data      Metadata System
> Id Path      RAID1     RAID1C4  RAID1C4   Unallocated Total    Slack
> -- --------- --------- -------- --------- ----------- -------- -----
>   1 /dev/sdb1 556.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
>   2 /dev/sdu1 556.00GiB  2.00GiB  32.00MiB     2.18TiB  2.73TiB     -
>   3 /dev/sdw1 556.00GiB  2.00GiB  32.00MiB     2.18TiB  2.73TiB     -
>   4 /dev/sdv1 554.00GiB  4.00GiB  32.00MiB     2.18TiB  2.73TiB     -
>   5 /dev/sdq1 553.00GiB  5.00GiB         -     2.18TiB  2.73TiB     -
>   6 /dev/sdx1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
>   7 /dev/sdr1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
>   8 /dev/sds1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
>   9 /dev/sdt1 559.00GiB        -         -     2.18TiB  2.73TiB     -
> 10 /dev/sdm1 559.00GiB        -         -     2.18TiB  2.73TiB     -
> 11 /dev/sdn1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 12 /dev/sdo1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 13 /dev/sdp1 554.00GiB  4.00GiB  32.00MiB     2.18TiB  2.73TiB     -
> 14 /dev/sdi1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 15 /dev/sdj1 554.00GiB  4.00GiB         -     2.18TiB  2.73TiB     -
> 16 /dev/sdk1 559.00GiB        -         -     2.18TiB  2.73TiB     -
> 17 /dev/sdl1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 18 /dev/sdg1 559.00GiB        -         -     2.18TiB  2.73TiB     -
> 19 /dev/sdf1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 20 /dev/sdc1 557.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
> 21 /dev/sdh1 557.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 22 /dev/sda1 558.00GiB  1.00GiB         -     2.18TiB  2.73TiB     -
> 23 /dev/sdd1 555.00GiB  3.00GiB         -     2.18TiB  2.73TiB     -
> 24 /dev/sde1 557.00GiB  2.00GiB         -     2.18TiB  2.73TiB     -
> -- --------- --------- -------- --------- ----------- -------- -----
>     Total       6.53TiB 10.00GiB  32.00MiB    52.41TiB 65.50TiB 0.00B
>     Used        6.52TiB  9.57GiB 928.00KiB
