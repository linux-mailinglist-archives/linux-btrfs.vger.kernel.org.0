Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A4570F34
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 03:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiGLBGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiGLBGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 21:06:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A32613B
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657588009;
        bh=91In2+jHkPlTLmQ3FLvGAKSga2ubqRMCAiHVTBhdVOA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A6iyNvMUBKybXnL4enwUdRs68AtbTx2ycDxxaMGHKMborydEQ8UplcwqGuW7aLehb
         KSLqi6nd+fVfHsfN3Mj7Hty2ZnpziBDfuxygAI87xYzCEZ5NqrE35Kbzjjs54jMyK6
         OtfULU/V8myRWQgU4OH8XQPN9BV8grgi8qgljUBo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1o0qxf3AUN-00TUKw; Tue, 12
 Jul 2022 03:06:49 +0200
Message-ID: <d59d1df3-2ec8-d5e4-55e9-b351dd90570a@gmx.com>
Date:   Tue, 12 Jul 2022 09:06:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
 <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
 <20220624134706.GV20633@twin.jikos.cz>
 <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
 <20220624154436.GW20633@twin.jikos.cz>
 <7ac6d505-6806-338d-d1f2-100737749e89@gmx.com>
 <20220711152329.GY15169@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220711152329.GY15169@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DE50EPLiTfaBlmBgPmfv2c2sFrDmufwGZPGOkxYozKD5Nfu9dUk
 SX0jtpHNq+MfKsLJiDeOUsx1FW1Ju71/pVRfvGUjURB/PGWpnZqn1sXSNjgwcuJALGOwL3N
 rCfb9iBlPV7n7ujp2oCEZEiG9h5Y1O4ovczhgaEN2560itZbuRlHRaAxKCTpFwWG8esHORf
 X0pOH+CbIVKaIdzAdznSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dG/2DIYiblI=:b2pePJ71AsSf+U2WOk9xrb
 4ZbwwnfcYWYML4imIzHmkgVSsj5E1MCcXZh++YkkjxdDSbtzP+7/6zPHDemkL7nUZSAOY4MEa
 CJnnJqkAcxBNQt/IOFL2QYoCnHARVT0nf3gmiYds8L+UaEmUZE75vQf0n9017JiYSeioOpkpJ
 OCHpnA+Bd8LDWDSFXbxr7FQu/DjOhjuGv7DRV+pfXG/t+wSHWvdrt8UUI9Am8cJFg9gzurUZv
 tiwMNwKP4XVJtmYV3TNN7ebLJmUhw3qkmIyhtZLFxRpl6L+jj/WpFTaGxp0EmzX8EtbCLmgih
 MvUrOSag3sTNAv30FoX9fdrN/J5hb7/f/npluEGfYZPgDMdfo73dZVoQhxv4OG58V6KSnbDDF
 agsaAp9GJON+eMG7IquPKWsuWM5w56lvOoJlxxk6dIYOMPuLFsX23qiXes0W8MvEmw+gfXqsx
 yXzXJj3sHzp1kgaPq6dHpdwVv76pmQV4e1BX9GtI6g6si9eTEIPmAd/yykGQF/1eWTHT9n8/8
 uYcJ57Zag3vGinDXmiSLYhKjlKdD5AXS1C9rTnAzR3rZxruD4cUR5j4p5+WtnqkvpGuubBrgC
 RF5T/ZUlyM/iO8LjlCjOJsxA5uJRqGkAfhS20/kI50/tIytH5N5XAxJepb2MvC6v/3vmR+mdV
 agda2UbeKYKvU4MtfmBbvXD0uY0tM6IBrsVIM66uc160d672QZ/jjfNMGLtNGJLyaIjXWO4T9
 eDWoQqPbT7KnxRw2spiSSe+rrZS1+lfySrebnKRa6FTVcvUS+q99uxuHoYtLuf76lZ90unXL5
 4jOcLcf9+xMUHnNsPzPuhQwnw2NRUjgEFvFPNKa7s2udsfzKpjy25BqCVx0kAoy3ykGOcwVyH
 wtShvVmhUCIMKhiEryLkZQnswIrBChtcGLYrB2Xrlus1ywJamuUFDBK4nClE3dTF8wBAq+k/4
 g8wyfTKmstbVOpNWqJQ0ei0IPFoy0i+8mwjo13HIutqp9qNhLvhrxMIu9l0A6tRRxTVcT62Um
 wKB9c8AVa+1fsfTcMTcrFShUy4zlPIgCankDhRsbhYbPmSmOUhuQAvyysa7s0S8t7hOR3uBNL
 1ixGn/otVfklyuufWYBLS5l2rbjwLIGeu37t6n9OqqcWmF0FfkHkFui9A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/11 23:23, David Sterba wrote:
> On Sat, Jun 25, 2022 at 01:53:47PM +0800, Qu Wenruo wrote:
>>> Removed functionality is documented, the sysfs feature files are in
>>> manual pages and we can add a notice in which version it was removed.
>>
>> Then have all the old features get removed one by one, until one day we
>> have a dozen of bits set, but only one or two still show in sysfs featu=
res?
>>
>> No, this definitely doesn't look sane to me.
>
> And nobody is suggesting that either,

Doesn't the patch just remove the sysfs file for both global and per-fs
features?
Or did I miss something?

> the big data and mixed backrefs
> are something that's exceptional in this regard. Removing other features
> would take some significant time to remove and a check if it would still
> not break some testing setups.
>
>> It's just trying to hide some bad behaviors which we didn't get it righ=
t
>> in the first place.
>> It's fine to didn't get those things done correct in the first place,
>> but not fine to hide them.
>>
>> Especially those sysfs is already hidden to most users, way less
>> invasive than the dmesg output/mkfs features/etc, why we still want to
>> remove them?
>
> To unclutter the namespace a bit, in case of the mixed_backrefs it's a
> bit confusing with the mixed block groups but I think I've mentioned
> that already.

If you're just to avoid the namespace conflicts/confusion, then just
rename them with some prefix like "__always_on_" or something similar.

Thanks,
Qu
