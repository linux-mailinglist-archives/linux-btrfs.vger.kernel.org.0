Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB96548333
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 11:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiFMJgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 05:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiFMJg1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 05:36:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF53911A24
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655112983;
        bh=UqZb1k8CmrUy1CrdhDvV5+zY+KAwdmY5rj9M5RLibKQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Xmvnwjygpjnck2LecRREQhoaMKZEXZO3GFuJ/1Mnix5G9M5og965uVGda+cdObEVz
         7ck84GyaJZ/y3Eojoc8JnJ8EEf+cYcriedy0aqnK3Pne96x+jkGkmyL984pJcqtzdZ
         798Ag2SFD8y7GKUnKfv014IFKAph3eppjfivf5qQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1nugU439PS-00EtDa; Mon, 13
 Jun 2022 11:36:23 +0200
Message-ID: <2307850a-4f38-19ab-48fd-47246f11cb4b@gmx.com>
Date:   Mon, 13 Jun 2022 17:36:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
 <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ZEcCBW6354y79s0du5qZwhKT2/wMSc0mVuilQx/aMSeTP+TBTA
 jFvf6kKzZxoVqgKWJ4ck+1nucj+7YgqP5h0L9Dfm5f0tZWNeJdS0ZnetQk5xiJuEW9bi1xZ
 MTP+E/1QmbS9zHBG4i7cUoGQOTb9i4xXqKf9kASqqCgUvXLwCli/XiNrBLkQGw4tdhu/LrL
 8+U9uJ1eEdxPv6bxkVZwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nSQD0e9XUr0=:H5pk4G3TcCVhntwnMIjr5e
 xXPLxL1ESc0xbe9qFmG4fShJBDOq2IZxqjHXV0W5vLO9dljlpIIB1HTLYBcvuudXk6Zu2r2iJ
 KtqQyQtA4padMPRTAQQxpRxiAGs9owN6tdarDfPTWJixYuBd2M7PJWrv85piows5wZ775qp4N
 uG9k21mpAmXAikbk7PAiKN1TloyXXr4uErHyXUXQ0bq2iTLWOf7B17Ktw5AW3cp5MDH4SyBIt
 /SNe+BT+hzBBcgybncrLkCu6wz+Cabi9J40LrQOFLxLn/kb/5l1vHRSIAnEVOhQBff5kMIKhR
 /KW5PlzUJGAHWee13IjrFh13nTRr4CBP42pxRuONDFFBTOEWTjxmuRt5Bj7oY7bo23o0y46GK
 Vt4NvuSK5rkrU7MBldpg6XBDqiXp8MJvZl9rIxxaaRCteUqzzQN1aIUdHjJF0LPnRIs/ysiyr
 1pOxg2bcTDThbBBxhHpj1gH7Itj9Ez6wjAm9+o4Lmz1wQMsJ5t5a72DDj0ofdA0UCwB4s67cU
 tlKdjmuDMJMJNAt2cPrzAJB8dlelLBRRe7GdXUtTxnxwVYWAjAIP3Og6Oq5GiEPwzqo6haqMK
 S7XXe3YmlMzGroavRp8sP52v+Wz+XW+ofVLS/Ql9gdh+t8MHZYCMHbEBTX7UHpkEweO2abd2g
 7SGHXzK5oVUz12y23e2URZ/jhIoD/0ZfgVeiVCNJb4vT7vI05CM9/L+PoyEIpkFbS7fNvIH4l
 /BhKtVRGjqqiOt4Y0eX0cUC0nwN4vR9zc931QrpEqXoRwz4HOciuwszTBSIaduwmWngfqM681
 agYQ9KFGk/vNXSVQDwut/641lOpKpkSz3XuIrjB83A2aMrPDot0ika/NSL6gpnSSYEEVyNPvx
 3iqZP4/0BSPBtEhgwciDc6yIr2ayVGuUJao3arVkUIxah/hWQsDTRGHAdJU29XHlM5We4s2a0
 IA8F37/5N9LMdQe5O6xEevWBcDn6xX7Rpdm0JBHYEitjNh4LEO2bdgXQIWsLIB/bWZsi2HmHJ
 z2jnIXMWMXdnbBTUsFVMPFlM81ozyXDPwg1TRGvwYU3TxwR4ARUyxV0emAPjEDxEd9/4rPdkD
 ZjNjtHSDiyL25qNuHK7oX96rTePI7t1zvfIpi0aBqBwGE7wQ6yIS/fWFw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/13 17:13, Nikolay Borisov wrote:
>
>
> On 13.06.22 =D0=B3. 10:06 =D1=87., Qu Wenruo wrote:
>> Since btrfs-progs v4.1, mkfs.btrfs will reserve the first 1MiB for the
>> primary super block (at offset 64KiB) and other legacy bootloaders whic=
h
>> may want to store their data there.
>>
>> Kernel is doing the same behavior around the same time.
>>
>> However in kernel we just use SZ_1M to express the reserved space,
>> normally
>> with extra comments when using above SZ_1M.
>>
>> Here we introduce a new macro, BTRFS_DEFAULT_RESERVED to replace such
>> SZ_1M usage.
>>
>> This will make later enlarged per-dev reservation easier to implement.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +=
++++++
>> =C2=A0 fs/btrfs/extent-tree.c |=C2=A0 6 +++---
>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-=
----
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +------
>> =C2=A0 4 files changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index f7afdfd0bae7..62028e7d5799 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -229,6 +229,13 @@ struct btrfs_root_backup {
>> =C2=A0 #define BTRFS_SUPER_INFO_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SZ_64K
>> =C2=A0 #define BTRFS_SUPER_INFO_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
>> +/*
>> + * The default reserved space for each device.
>> + * This range covers the primary superblock, and some other legacy
>> programs like
>> + * older bootloader may want to store their data there.
>> + */
>> +#define BTRFS_DEFAULT_RESERVED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SZ_1M)
>> +
>
> The name of this macros is too generic and uninformative. How about
> BTRFS_BOOT_RESERVED or simply BTRFS_RESERVED_SPACE, because
> BTRFS_DEFAULT_RESERVED implies=C2=A0 there is something else, apart from
> "default" and there won't be ...

BTRFS_RESERVED_SPACE sounds good. The "BOOT_RESERVED" part will
definitely lose its meaning in the long run, since now there is no
modern bootloader really doing that.
(Either go full ESP, like systemd-boot, or extra reserved partition like
GRUB2, or use unpartitioned space after MBR like the legacy GRUB1)

But "DEFAULT" is here because later we will enlarge the reserved space
(for write-intent map, and will introduce a new super block member to
indicate exact how many bytes are reserved), and I don't want to add
"DEFAULT" when we introduce that new reserved behavior.

Any clue on the naming part?

Thanks,
Qu

>
> <snip>
