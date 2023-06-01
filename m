Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03195719211
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFAFEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjFAFEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:04:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19312C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685595886; i=quwenruo.btrfs@gmx.com;
        bh=q6Iio/omcLarZha6Lmn4AjDLZfueiqRKwlNRHk5epbc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SRHeeIEtAHXbCzqvSVOO5WPSxh+9D+k3osCP2LUwc5mUyzbbY0rzC2LS7/PqUyife
         D8ok7nDXZnr6WQ1bjbxyFaW4QyjPfZGyUuMzb1024aokIN6RS2a2wpQRlljRfpFZCv
         JRaokLg5OeeYoByOU3Ui3X5U7u0RDefGxtL6y9AyqDLqhb8+BarXcyv/hDiKzJZ1lI
         EooSRjW629zcJnf1jgnWGe0n3i/5iLs60/HwWqIHpze7XWNy9k9F+tOyxyrun9KLHV
         ShN4Sg4FiZUKflhL53FP+b+4BdNoa+bG25LNSsNw/NoLDQwz5V2R7JrxbgoRMplkCn
         xA/ED5YPBuKJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1qJeXL3ago-00x1WN; Thu, 01
 Jun 2023 07:04:46 +0200
Message-ID: <e6ffff18-c51a-169d-35e8-e452dab81b22@gmx.com>
Date:   Thu, 1 Jun 2023 13:04:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: new scrub code vs zoned file systems
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com>
 <ea984319-decb-ce86-aed4-d4520bf3ad3d@gmx.com>
 <20230601045302.GA22596@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230601045302.GA22596@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1mmjrSpLa0MY6lTyN/PPs3KLKIeu8KUQa5CbZs9haOhcNe7TCxC
 YMu6O4M7r3yPjDZJhH9NyprzOMFTd8vHCjNFfiCTy8w5TnrAgmWe6MzYFORuqrvV/5MI4I6
 kFkVPLZ9FoEitKgsh/ZDvCfAxRxqeT3qqqUdHejkZr3A9GwPiFeBDYd+2a5oLp6EncRmQT8
 KIVm1vYC9z/CPVg3EVjKw==
UI-OutboundReport: notjunk:1;M01:P0:oQBnKlkxOow=;6xCKRaEQjJdjZH8U3/4yaBu+VfO
 xQOK0MY5OlygR0Iqg53Q6oeBYFxCAQzwtj+49/Omd4hLpJhZ82aBfjxXj4h89YWtt9MDhTkxb
 6tQEkuZdUmvWIew8fKwGmKFzkkjivPP8BBwkfJLmmNao1iIPLw5uYMraMW8wZ7aKWxPKz+QxE
 KE8a6ET1ZCpVVo+y2Osb9Jo+UGcDdyUEAT2j5r+3i9iCG6IEMltQpRrOpDQr3VoU85TZpBveB
 aRxVMvKTg2eS53ka+Dbgw17jsQvWFeItD6tkE9knpGqdgWxFeas6UDEYCm2eTBwuS10PTOWLw
 tnam9Cv2GuTMtAzREqwjeZqlOgPC03Z74yCwLaKC/JqoR+rZ+9vNn+p94nnhuT3zlYScf6bnq
 GRpTu7QiQ6v584KO3On7F15KP6OPKFQ5Zn154S+c2kAM5TOnbVVprpIEZ1mgzsAHkNjjg8odn
 g2nCuF9bulaYtZ1S0i54QFFnQdKnINy6Y5+sYBFVDTrF9cFAhTDrps80qNIYoml7HBwpZOhM6
 u1SGqVrzKJvKc2qjHh41vrJ1HDrR4HLQj+2XUR+iiwkTSRg8Y/GwqdZ06stbOGWAhf+T7OHVa
 sjeqHkiafuoiPBmtOQ2lGDYftld7WdJG9hPpjn10A4ZRvtrqvUlzoFSPVICAdqH7KHlX4mss2
 X9CAH5vSHC8ysKEZfE5TlZYU3J2+oB8Dts+LUQI+194DEv2HkePmgskjIvgNZc15URbKcKflj
 yjMUSZ4ARGBHt4WXhXCUwud2BsEE28f8yekaVOX+YB8xbSRPJlLcZLXewETIyyoHULoGZKeVe
 mmZN7pMtVYhvcphNNdX7WGPZW8HfNWpSIMR9/LmsE0cVsVJd1kcK2cFN6Q2FFK/W1lGl8cV10
 fADKu7VeGe4Xn1417lyTSs+lmbrH5usNACi4NPvYv9dvnWYdWnPYP65huN6KkgoY8tOquHhNY
 fswWhJuOppWv7MTTPDzH06xRVKA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 12:53, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 06:25:59AM +0800, Qu Wenruo wrote:
>> To me, the problem can be solved in a much simpler way, if it's
>> dev-replace for zoned device, let's write the whole stripe to the targe=
t
>> device, and wait for it.
>>
>> For the btrfs_record_physical_zoned(), we can skip the OE things if
>> bbio::inode is NULL.
>>
>> Would the following change solves the problem?
>
> It can't, as we need to record the actually written location.

We don't need, it's scrub, the target block group is marked RO, and we
won't duplicate writes for zoned devices (the FLAG_TO_COPY thing), thus
only scrub can write into the zone.

Furthermore, in the context of scrub, we have always do write and wait
(QD=3D1, just like metadata writes), and fill the gaps using
fill_writer_pointer_gap() when needed.

In fact, if there is something so basically wrong, we should have all
the replace tests before that b/169 failed.

Thanks,
Qu
