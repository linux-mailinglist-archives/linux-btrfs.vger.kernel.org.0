Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387A529B95
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiEQH6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiEQH6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:58:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB649256
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774286;
        bh=BivfIGb/I/eRmkza3zgG5ffZAc1lq449i8KGjgY1bAM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CAIAW8IF9QftP0uDfiDLz4r8iGfahNyGZSegW12RxKpqWyzuuWBw4IrUFWaf7J0DE
         Yw1GsPcUINpRovAiDwAlf9mdA3KRXtApMFAnnCeHBSku5qbOhiJAXAgpzyzXh1vRts
         TqjQ90J3J3AsVCm5XwXi6dzgmmVdLEHZf/CiUWxw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1neGtP12v8-00x2Kq; Tue, 17
 May 2022 09:58:06 +0200
Message-ID: <23307134-5651-281a-c6e3-359d3c846e4b@gmx.com>
Date:   Tue, 17 May 2022 15:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
 <51ac74ff-ada4-a3ee-5638-2fad8fc14f03@gmx.com>
 <PH0PR04MB7416045672918E66690ADE8D9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416045672918E66690ADE8D9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:99bvEtJnviCpW/tLnIsNH0YKltPu+Zh53cibz1/LFybCxFM+X/0
 Cty1vwMczzxmrcn+DmUMrC2o/dsnY64qZRO0Tl/33HKiH1JU7oWtOyP/56jM+vdJYCWyBpu
 +XqfAjAOdsQJmWtEQA0T0A40dz0W4fZRuenZ10kBNszUHLnz4+rjEi2SgbSsIJe9cI4N74H
 tnebjUYGcge2rU2civmlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEEidnBc60k=:q9d+wYefqT8UXhqTsnQ9hV
 ie6qoNb7tl1WVIj9Cv+BYqRhymfrIoG2QVk4JfncdysB2WSoju8aMYAK8euYuhB/Bu1G72t2H
 C602zlvgl1KH/jUqMv2atrf117zMYTtmqf+UlVD2Wd5uJIx3Sav4ZQ084ug7fErJSggmquU4E
 a1VPaRUEkBz8dzuEOAGd670VAf0eAxaPN9uRGs+N0FKHPf/RCUraXjBXO4reNpnjDxJnWcA8u
 7I2ruKOz7Bdm73eV1dc1CaLybEPa807UfT+k5PKvGlCoQ5cLDyKs6psMjTJVaUeRrLLw0VED2
 iBJldOI6IIX6sFt9U/Nah/di8+7atRcZkHgRkuP1anf4AS73OKD3zOIdvuhFmQI34w6X/x6hW
 4KiIf5Fbs7PFFwnrdTRMWxY/dSixTIo8FZduzNbwfaJHj4heYuNo6Qi9DLAz/zQ8JXt+THzRa
 HOHllLTSGwXmBpyRrcTFltE1zeCCnW65cdCIyMULdYjdbZkTEbHOCCIOBzlInNBDsoBD5b91D
 TFmHdyqVNEgZqjpVVdrQZPMfsMwRlH3AdH38IFs9FhNVbit+/fJhXm4JBJBfuVW6Hmh0OF1yo
 mGTbC7oqvPQIcSZU2zcLEOyH3p3PnYyF2d9BmQkpcUywP2vuswPgvkCPWCwVUTRuRDEamlEq5
 T4ixSvT1SE9m7v+gl6BSi+zuOG6H7gQnEjvsKHKOIOD2B04KZXS8PcDGQmNx0mgNFj2/EhC01
 YYqGnqeRD2SJULUUBjhH3OGSsMPjRsQpwlzqjEG0wCc3GFy3KHuxzlGekdvWJh7cj1ohoWBuk
 ImBWSW+M/vuyWf9zZklP9d7jnVpNOqk6+GUQQjf1+WskoKCtVw6rxGHdadVao+nGoAmNUFcDu
 +feS2uEYngKCd/+qFzoVKgx2lbbDQDYdnOXjKdIo1GnJQjW5AYAUt7iE8zJk4Iid1dh0y1EcC
 U8repQpeBeAcj4WeS84Ns0mMggC8JrOB/TuiOtjiKHQf+QNfRhMdwcH7vYkOATLH4iLG10/fe
 6XrTeuV+9KJjC8wSDfPuRydCSKthBjku3pIabWX8FvvVGzSCVnS0jNTAuJw4TbFSSafJFWqcf
 XzaJTsbfx/qG4E=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 15:51, Johannes Thumshirn wrote:
> On 17/05/2022 09:42, Qu Wenruo wrote:
>>
>> On 2022/5/16 22:31, Johannes Thumshirn wrote:
>>> In preparation for upcoming changes, move 'struct btrfs_io_context' to
>>> volumes.h, so we can use it outside of volumes.c
>> In fact I don't think the naming itself (from myself) is that good.
>>
>> It maybe a good idea to also do a rename here.
>>
>> I have some bad alternatives, but doesn't seem better than the current
>> generic naming either:
>>
>> - btrfs_io_mapping
>> - btrfs_mapping_context
>>
>> Thus I guess the current name is chosen mostly due to lack of better on=
es.
>
> Yep but I'm not any better in naming *cough* btrfs_dp_stripe *cough*. Ma=
ybe
> someone else has an idea.

Forgot to ask in that thread, what does the "dp" naming mean?

Thanks,
Qu
