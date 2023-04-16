Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B966E3491
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 02:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDPAQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDPAQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 20:16:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E419B0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 17:16:42 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1pYeJU0fRH-00HQ7Q; Sun, 16
 Apr 2023 02:16:39 +0200
Message-ID: <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com>
Date:   Sun, 16 Apr 2023 08:16:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: scrub/balance a specif LBA range
To:     Torstein Eide <torsteine@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jz8XY8HylMPVWf1RKB0bmgV6kLnp3HgnLPy4onUF6veRdb8MvOY
 aR1cL7uItR5xj3kNh//E3azexwk7UeWMvxpEQwOVMip4nVoCWcBGSomqOg245/CwFIon1eZ
 5l1sKjb1qMMA5ICRSIwsfH1xMU9WM5tuQIKIknU1kALEnyM/Anl5XPoax4cs9fB6Anv0w8V
 HQwjFZnROwoqCayG6RpHg==
UI-OutboundReport: notjunk:1;M01:P0:kInmtxx5eLM=;2wBZYQdKAMaWifq8bX9WcMJxF/H
 BtO1zXiB2+VAqqh4ChYVf7GWrYHuXEQRykEUoMJQPuj8s8X609KI4PLvxBniG+++68mlC3uL0
 F0s+a08gya1oINQ1i87BAmd9oUnNUPCcUel/3O4Sfe4XMO48VwGqxJiUHtxWHYjSWp8/X/S/Z
 YPEpw7/MXez+0BfWj8AfMFe+uDejx1W3lQR61eA8iEb6cKYrEkuf546TZkSruulbjwQqZ/naw
 izEngOGt75ssiWxrUgt30zb6yk1EgoH21dh+YRcpEv4eHVBZn/85l53XpxqzDbbETd/E0vgJ4
 gnK4hlB63f7KJqbRd1h7qj9iGjUPHAoNciUNaAmoZ2Zo/c+zdnDhvOtI48b+Se0KfW6WrnuY4
 n6rfXDgk8Oihxi9HkAWEj8Mbe+P/qrNG4I7c1iawNzc+e6zJn9LCsGGRW88ozYJz8BxVbmlnX
 qbABvIHBlNyf24hPcnyj0qc1z2ZwJg7KXGlu4ntehpVzGKyl97BozxK7eLwSeV6N/HBWgzQb4
 A6VVz3E3+v3PP9aAjcSj99JauPuwwCxwrtH8FPwLkGJc89AJanEpNGHigvzjBuSQF1DCs7m+8
 pq5/ApUvflyBA3C19DnOY/U0ONlzn46KfjE9yAzjpGk+7OF8jxU+hen+TI6b15srnGx5iUQLB
 sX24DDtDn2Ca+lC+Xq3eAz2bhsTAhQbabTYg4SKJ1mO5pfpNoBK/Op5LOqk+ESGNdYebuYkRz
 Er/MpjH9FsMukxRAZJcxS6x7yQZcq6VJgaTjuLFKbEicO+4eFWuCRJaTeJ6SR4m0CZYV7RQhk
 7Vt4R5yAiBPLPnRbUfJ0R/j+IN5fHaMMPplvfhRgtfB+3esA2Eek5oGng4p1hqmsrHT6Q0LSb
 U9g49S7jD274aKpKicG4dOcpJMqzBt53cEap0yy6kG863JbuIyIWqWzWqVeOCD4n3LffECdmG
 Pt9U7oyycsmKiILeixMkOSu4GgY=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/16 02:59, Torstein Eide wrote:
> Hi
> I have a disk with "Pending Sector remap".
> That can be view with:
> 
> ``smartctl -l defects  /dev/sdd``
> 
> ````
> Pending Defects log (GP Log 0x0c)
> Index                LBA    Hours
>      0        11454997800        -
> ....
>      7        11454997807        -
>      8        11455002752        -
> ....
>     15        11455002759        -
>     16        11464481352        -
> ....
>     31        11464486423        -
>     32        11480702000        -
> ....
>      39        11480702007        -
> ````
> 
> Can I tell btrfs scrub or balance to move files on these locations?
> I was thinking the balance `drange` may work but was unsure of the
> correct format.

You can use balance to only balance a logical range.

And it's indeed the drange option.

Although you may need to specify the option for both metadata, data and 
system, or go --full-balance to make sure all chunks are covered.

Thanks,
Qu

