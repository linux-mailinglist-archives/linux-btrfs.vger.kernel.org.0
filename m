Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D76CD709
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjC2JyV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjC2JyS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 05:54:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F944B0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 02:53:47 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1qbmZV3PIi-00wVw0; Wed, 29
 Mar 2023 11:53:10 +0200
Message-ID: <2985833a-72d2-6df9-057c-02dc7cc1982e@gmx.com>
Date:   Wed, 29 Mar 2023 17:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
 <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1680047473.git.wqu@suse.com>
 <b9b3f8e8-1838-a40d-57c3-100955563541@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b9b3f8e8-1838-a40d-57c3-100955563541@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n/JanRtats4PfSTT3lierAA4IzpYbuaCos5VudGxbCuN5JtsY1Y
 7NoeYfy0BtcrwtnNe9v70x0JTqxs4e7C8N5y9RAzm9ETjWl9VRQw6nxeswKdjmTa/dg7X6w
 GEwrQ0cR6jVUS7u5RTGJVnnNrzHaQZkLuM/9pkAS/KQ/nhpqqv8SnUXBovQrWw/Z8ODe3fS
 k5aoX3lCu6czFjH7Qb0zA==
UI-OutboundReport: notjunk:1;M01:P0:VL0GiYeTTiU=;1RMUNiUrya2MNWaKkqjJm2y4DdY
 7LYHx5W12ZLV/p8qEt9GY7ePzPn5sYNJwVjI76bt7w9hImKQWae5/QVgBZFq4DV1qqtoe/G5U
 K8Dcrfs1Kz3997kQl7RQGKi0Pkb1ae9MPJi6YUP3DFyIwl2kXmlKPbbiqR491A69Mo7P05Cti
 yPs/BSurSlHpkm+Y1qVUF3BJENsLWlJb5Ez/lqqArYRwl0W6y0hViRANPeLgtGYjuSbEfnMdX
 udLMLU4OiFsRGHHTTRp/RAyzi7Uhh2mL/tBmqF+l+5Fn69mgSsTGVai+iFzxaRmBVxqiTZm0O
 k75iTN743baXOcMR3KzU8Veai0LCzcIgChzOGad77u9R6t7WB7v75fKVJxMzaqoMDqe7cHhqM
 HaSp1ZA7lqRP0bbhzqEpv864xE21PIAnpqyxRQzd88qUgC2c/iy2ku69FIMIgKPdGcN/l2MjM
 4+2db9rvfYyNkHvEDm/EGTpz7E5VRoM17C4pfZ70rdTdin5lLUjfgLJopR02zITemZpbABtKc
 fhAOHEOyO9QvojcB+ExVHWckzGpV5R94YKARvFSCn1t505c9Duju3TlD2CdQhHonFOJQmarAf
 k8jMcN//wzpe5r0/xl3ciQdfMY1tKxmX2djpKnvGdcQdb1POvKrXWfE/2OnUeR8lB8uhjP7E3
 2h8H4NizMsSly0uNTQ1P0Me+dUOGsV/Cem22B+lS7rD5c6HwdMQhJnO56C0pxOYcRWVmO20zC
 lgnK12srvr39ZB9vorQAlcnaEa5lpVCXKdDTyg+YDbZ364SInJn3OB80zUgbZZNffGyNa3QNV
 zIhi/MIGIUF+lbFJF+r24dwaDooIWNl5kDcI8af0EGipzIXxLNt1vEUI60tuXIxkrmBQJ2RQz
 uenIuaEUkqV57t8r3D7eRRRxxjvjYM5nLAmhJwz7akC9o7SnwUxFR/rHFCbkQPCPdA9yHOkr0
 olLJ2mNrQtZDruMQPCwGqjDq7fM=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/29 17:20, Johannes Thumshirn wrote:
> On 29.03.23 01:57, Qu Wenruo wrote:
>> +
>> +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
>> +	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
>> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> 
> Shouldn't we use __bio_add_page() here, as it is only adding
> one page to a newly crafted bio?

Oh, I always forgot that helper....
