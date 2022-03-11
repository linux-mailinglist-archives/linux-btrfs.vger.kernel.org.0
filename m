Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2469D4D6A1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiCKXFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 18:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiCKXFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 18:05:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F52DB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647039881;
        bh=0Fr4lWG5sDRszWFehcYWs5uUaNrJdv9yOv0fKOmVLD0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RcpYbZEtWKUNFxDq3N9femv/C7gnh/a+0phu43WTEvVms3DztpKSkgEU66uwChLjM
         fF20eYueA+/8UQX65gITEqDzgddsCaXKf1HGDcjy0qKkuO6nYWG32csaujE8QjN5XV
         4qhkXVQ+qCyO1LWBzo6S9tEqoP+ajQWG7cwIYeV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49h5-1oAMMD3gkj-0105GN; Sat, 12
 Mar 2022 00:04:41 +0100
Message-ID: <e7df8c6e-5185-4bea-2863-211214968153@gmx.com>
Date:   Sat, 12 Mar 2022 07:04:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FhJJyxKd4kY3J4ezC3QIUZ75kxBfO79r6loPKHeZyJugoIAKDz2
 SiTwE6nIjz6fVzeWAF81TpHd8CYW7vFTDxPoiVc03cmTv/FrlQwCA39Gi7CGAGSntGvNpKZ
 oJiVsRcoNg/EXrCwZew67sgLO3Y6SOZa1mfXP5EsF/2tCQEgwqpNjaDjWOlVL75nu7X4ZYR
 kHkQ+muPwJhneE1LACtFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3nhI71KVxBE=:HYUUvJRNCwCABaIjkdjwhv
 DtCG1lf/oBXFUJe+o0rGK91tJGGA+3dYn7maceSAuNacaTmCDljT8CzsMJCJJ8gB9C89eigP2
 wjXD8rSgjl1pPygyz3bZRETKyNf6Nc4AeNxuUzFnTxYG8j8K8IqhBZYOcyMTTKHtpLIwAzBcM
 PG3h3JW07ddQoBZiquHBgFKAcqcJEmCSZGKjHdkdKKNV6c0FfVhd2UreyhEo1HW4vc/FEyUyd
 xZvhPuUQHBLCjIZ7QDCYwfowit8/VSLIR9hUUwtqWIbgcSDWxcFh316+BuOztN5R7602MVlAB
 T0X9LpQIMqUcN2y8uo0YA/k+ZGrqhjJOjGgjH5JXQXvpvS4nFKrlJh2yvtrx2G/3CkpTywJGM
 v8KkfyZ0iLGJ8JXw20njaSqKwjQ9dz7MiebSTbqjEc73WP0e9UAUfeastd94a4kgkgQXPCeq2
 hl3Ix8nuvFGnuiwoc++WAk74xzBaOI0F4ynznG3i64WZLBtlmPI0ItT5zj7sKTSJPUomPFbGd
 isH0wwi8vpmV6wM5Bx97DLE+fNU+sxQ+WHZz+I0HmjH1TmpPUmyIDrT/wlQ5sXl53u4EwS7f8
 b7Qw8GgIbZko+L0cz8IIvQH2r+XXtbBCMNEK4IbnGWC1UqHH8Y/7qb532h/nP3h67ar1hoUEV
 mgy49iT+KEpUSuVpo3FmcdOT1xMSvqZ0dZqWNkF1zJMst3zi3/YF2sG+0GvTfl++I9gbZe/Wj
 6eVCtZF0siWiqJSVFtNMsYS3q2nLEsDR/MsKYMSIl8qXt6SL5iVGbAUeHmSHjJX6xywDQarRH
 RFQUO4F3WNCWpcf1Y3gvIlHohYHRpQwMaZ5YLPZopVhi2gNNTR382LS3vcEmtRyrvXRasYgL+
 U6bXzjHRZ6XyxTjf4V/vSIYkvSAeu8m5ynTiwzBD5/ISTbnDThU1eZoveDHBd5SBMJe5a1/bP
 KYlAfLBwWn3GebZbZNba52JT9IZsrY1GSudNsbiq0qm5grzxKg+VrSsu/E7MJ3mCd+Dmp7dEG
 ZJwpJl6Yyh3sFEeehadktMUCVPqOe1YQdZAgNRevkZaKxyuQ9b5uCsisjkSN7BbNCRai00YOm
 uRFk485/OI0wcU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/12 00:31, Jan Ziak wrote:
> On Fri, Mar 11, 2022 at 6:04 AM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrot=
e:
>>
>> On Fri, Mar 11, 2022 at 3:59 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>> A few outliners can also be fixed by a upcoming patch:
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/d1ce90f37777987=
732b8ccf0edbfc961cd5c8873.1646912061.git.wqu@suse.com/
>>>
>>> But please note that, the extra patch won't bring a bigger impact as t=
he
>>> previous one, it's mostly a small optimization.
>>
>> I will apply and test the patch and report results.
>
> $ uptime
> 10h54m
>
> CPU time of pid 297: 1h48m
>
> $ cat /proc/297/io  (pid 297 is btrfs-cleaner)
> read_bytes: 4_433_081_716_736
> write_bytes: 788_509_859_840
>
> file.sqlite, before 10h54m: 1827586 extents
>
> file.sqlite, after 10h54m: 1876144 extents
>
> Summary: File fragmentation increased by 48558 extents despite the
> fact that btrfs-cleaner read 4.4 TB, wrote 788 GB and consumed 1h48m
> of CPU time.
>
> If it helps, I can send you the complete list of all the 1.8 million
> extents. I am not sure how long it might take to obtain such a list.

As stated before, autodefrag is not really that useful for database.

So my primary objective here is to make autodefrag cause less CPU/IO for
the worst case scenario.

BTW, have you compared to the number of extents with, or without using
autodefrag?

Thanks,
Qu

>
> -Jan
