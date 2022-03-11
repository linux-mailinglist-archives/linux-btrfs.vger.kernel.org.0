Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078014D5882
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 03:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiCKDA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 22:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiCKDA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 22:00:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE635F24E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 18:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646967561;
        bh=c467SGGAeAzXoCz+R4QJ3eREPCFyiLYjCs5Sxj9AiS8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g8/BLSyXt130ub4cZHXoxbgxeh5NXq0rWDq0fbSWLZ6E8pdOG+drD9G5LtHpJFIwC
         kSPo3njPmzWHlzcpTG7VE8/+ADa+euy2lybe8NrqN+g/VqV5ygy9PwiCyQdTdoL9+0
         wfSITls/kXwgX3qliDAgXgrbLCp3WMgbtRf+iIXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1neLEF3SwR-00Z2ir; Fri, 11
 Mar 2022 03:59:21 +0100
Message-ID: <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
Date:   Fri, 11 Mar 2022 10:59:18 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDJG1WKDahvruMU8a4a4/YAG3yRYKc2DKgcUJ81KKzQ9YV4Dq+/
 oA3niYpWAlEQznoq0EZqpipC6A2e18J3bxU8bN1zKQlVYs93mBaPNQO2c9eCt/WpL0HIO/l
 e6ZcX27WBiAoNfAePOHxXQ08aVJ7p+wmovI/ljifPeN4ND/e4rvATCe95bX1+aWJpmETT5L
 mdh8zEv7KqhS/njfrfXnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h9Z5M8xOpRk=:zedvq4VNzWIG7q09hIHUTU
 G2Fv91uJRpPuW9hHj1upxu2zCZUYsIsJGKCNOfwVxAfTJ9XcHCanT5oH+GSz5ODVU82GuUlTX
 wry9QClSNfdwXCgQ/q0LTzWCIvXq2dN7a+L1XQIABGEXdiNRLQcBwgYx5Ehz/Ru25q9dvB9vi
 btQHwfNZ+Zqs4B5xRn0CMJZk2StysuS9WiRQ2I0RKYTdZbMigjdCWDH2bEecMOSIqGiqlhss9
 8GoBeKKlMzDE2QQD7y6wnR0BjG3lq95aZTji4CMycadQZY+Db5qy/UiHT6x61dWtApBIUYOyr
 61q+kzO56zmtyUKZmiul1PBg17DXiGAPERZPfwEgkVyaxSIM8X85QgbgBK3kFOZ6CT7ys+Llx
 dvfxp91KdcryE/e0ErXJHdQ3zznSGs7U3Ccd1Nr3bhwVLlpxi/Ikyo9kSrx5EmYRqlqASC9Hd
 PaziMi0lS/6O1/3c2LCXIyAH183P3TKh/XJYK+8qE7N6eApXbRIkvX3LlDk6B4G7z5IvVnVy1
 mjakN+7Fevtrey3kEjt4nAppeoD2URyeeWzEbBFseVWzswovPXwc7kG2KsKYhgmcTRpRb7rsp
 uJCufBkxAqCLD+TRkQzqLF1aIkABkhg5VM5MBrJTeB3snQGz3CaPFXlX3cVnAuixunfPoi6F2
 +glHOa140hB6oiWSoIBWZY/SqEGadBhHWa2uFCbT94xPf60+1MIKQ6LrkbbSMaF89FEIoxvN6
 hFVqv5bmhntLeTUQpBoKgPFVRriUZaGMhvw0xmjKyETNV/QrAStjO7sH0G3oEZhowI0HMTB6k
 TviDABA8saA4U4N57F90zK5lnJdpMbrHHX/nafdQHk+z4SrEHZNe7RDs7hPtErMh8C4eH0F45
 7CvzvaSjFPDAVY5GlVM9Fa35jmDgoB4dZBMvji0rD0DK/hxBxDPHW0BW/VNh9HVMpyEqX2IdD
 HAJw6tpGi25fpH+kbySNNCK8dIreKWI3QYZiBNxCw6OZTgnqAjq+9kJY41gGeSw/u5EippAtH
 BA1KqT4NoYdX+vGO4yZxv0SjXkJAomDsL2mY/UXlDa8ALAr8xBDSAviiCfrC60oueZOLq5Phx
 RFAelNVuN/+ibo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/11 10:42, Jan Ziak wrote:
> On Fri, Mar 11, 2022 at 12:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> The unexpected behavior is the same reported by another reporter.
>> (https://github.com/btrfs/linux/issues/423#issuecomment-1062338536)
>>
>> Thus this patch should resolve the repeated defrag behavior:
>> https://patchwork.kernel.org/project/linux-btrfs/patch/318a1bcdabdd1218=
d631ddb1a6fe1b9ca3b6b529.1646782687.git.wqu@suse.com/
>>
>> Mind to give it a try?
>
> New trace (patched kernel):
> http://atom-symbol.net/f/2022-03-11/btrfs-autodefrag-trace-patch1.txt.zs=
t

Mostly as expected now.

A few outliners can also be fixed by a upcoming patch:
https://patchwork.kernel.org/project/linux-btrfs/patch/d1ce90f37777987732b=
8ccf0edbfc961cd5c8873.1646912061.git.wqu@suse.com/

But please note that, the extra patch won't bring a bigger impact as the
previous one, it's mostly a small optimization.
>
> $ cat /proc/297/io
> read_bytes: 217_835_884_544
> write_bytes: 319_139_635_200
>
> btrfs-cleaner (pid 297) read 217 GB and wrote 319 GB, but this had no
> effect on the fragmentation of the file (currently 1810562 extents).

That's more or less expected.

Autodefrag has two limitations:

1. Only defrag newer writes
    It doesn't defrag older fragments.
    This is the existing behavior from the beginning of autodefrag.
    Thus it's not that effective against small random writes.

2. Small target extent size
    Only targets writes smaller than 64K.

If 1. is the main reason, even if we allow users to specify the
autodefrag extent size/interval, it won't help too much for the workload.

And I have already submitted patch to btrfs docs, explaining that
autodefrag is not really a perfect fit for heavy small random writes.

Thanks,
Qu

>
> The CPU time of btrfs-cleaner is 20m22s. Machine uptime is 3h27m.
>
> -Jan
