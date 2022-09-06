Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2829B5AE55E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 12:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiIFKaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiIFKaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 06:30:16 -0400
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD6527FF3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 03:30:13 -0700 (PDT)
Received: from [192.168.2.28] ([202.252.247.10]:24093)
        by kyoto-arc.or.jp with [XMail ESMTP Server]
        id <S167E84> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Tue, 6 Sep 2022 19:30:10 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p0600104fdf3cd102623f@kyoto-arc.or.jp>
In-Reply-To: <20220906091203.GY1103@savella.carfax.org.uk>
References: <p0600104adf3cb2552d24@kyoto-arc.or.jp>
 <20220906091203.GY1103@savella.carfax.org.uk>
Date:   Tue, 6 Sep 2022 19:28:29 +0900
To:     Hugo Mills <hugo@carfax.org.uk>
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: Re: delete whole file system
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Hugo

Thanks for your inform.

I know wipefs.
But it's too primitive.
I will try to later.
Thanks again

kengo
At 10:12 +0100 2022.09.06, Hugo Mills wrote:
>On Tue, Sep 06, 2022 at 05:59:21PM +0900, Kengo.M wrote:
>>  Hi folks
>>
>>  I made raid5 file system by btrfs like below
>>
>>  sudo mkfs.btrfs -L raid5.btrfs -d raid5 -m raid1 -f /dev/sda /dev/sdb
>>  /dev/sdc /dev/sdd /dev/sde
>>
>>  And mount /mnt/raid5.btrfs
>>
>>  sudo btrfs filesystem show
>>
>>  Label: 'raid5.btrf'  uuid: 23a34a45-8f5e-40f5-8cda-xxxxxxxxxxxx
>>          Total devices 5 FS bytes used 128.00KiB
>>          devid    1 size 2.73TiB used 1.13GiB path /dev/sda
>>          devid    2 size 2.73TiB used 1.13GiB path /dev/sdb
>>          devid    3 size 2.73TiB used 1.13GiB path /dev/sdc
>>          devid    4 size 2.73TiB used 1.13GiB path /dev/sdd
>>          devid    5 size 2.73TiB used 1.13GiB path /dev/sde
>>
>>
>>  So,I want to delete this file system.
>>
>>  btrfs device delete /dev/sda /mnt/raid5.btrfs
>>
>>  But delete /dev/sda only.
>>
>>  Please Someone tell me how to delete whole this file system.
>>
>>  BRD
>>
>>  Kengo.m
>
>    "btrfs dev delete" remove a device from the SF leaving the rest of
>it intact. To destroy the filesystem completely, wipe the start of the
>device on each device. You can do that with any tool that will write
>data (dd if=/dev/zero is a popular one here), but there's a generic
>tool called wipefs that will do it for any filesystem with minimal
>writes to the device and a good level of recoverability if you get it
>wrong.
>
>    Hugo.
>
>--
>Hugo Mills             | Klytus, I'm bored. What plaything can you offer me
>hugo@... carfax.org.uk | today?
>http://carfax.org.uk/  |
>PGP: E2AB1DE4          |                      Ming the Merciless, Flash Gordon

