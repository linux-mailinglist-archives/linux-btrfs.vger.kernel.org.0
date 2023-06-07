Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C05F725374
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 07:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjFGFit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjFGFir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 01:38:47 -0400
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C719BC
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 22:38:44 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.231])
        by smtp-33.iol.local with ESMTPA
        id 6lsXqxdokN3DF6lsXqoyz0; Wed, 07 Jun 2023 07:38:41 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1686116321; bh=crEr/G/bNXSVmoU588Bd7j/Bf0xIwRKI4uibf3cwGD0=;
        h=From;
        b=f04XYwmH1mEoorz0jsbnMQZ25GJ1lc3zN4+R1khTwqQ0jBToaXTLtlIKSiu1K0Iog
         ICmyhlG80nNXo44RkoLOMyJEV44IkZkTgN2jALaLyUqaY1QzPe3mg/FkkcOz1qvKlL
         Y6sNCOMxjP00gxJIA62x0ZlQCSl4ULUt7LFC4LZj5eygidJPQqa8nTF1VPpbvt8Qos
         DJoRTq0iFFKE/5EI1SHastb2iQKUsuEP6gQ5bC65NHASn1MmIZUMaAkU0Rc8wOdb5I
         gLsKqEG9Y8WNFQ8Lye1CwrHV4PODOn/iYhaliEuYuyM3iHc2ZAr3yIix3FNodDrku9
         X77ScTB0Tj3Cw==
X-CNFS-Analysis: v=2.4 cv=Iu3YMpzg c=1 sm=1 tr=0 ts=648017e1 cx=a_exe
 a=AlzuFy159jchtczrxo9BKw==:117 a=AlzuFy159jchtczrxo9BKw==:17
 a=IkcTkHD0fZMA:10 a=WDPRdmt1CDQvWstU1hoA:9 a=QEXdDO2ut3YA:10
Message-ID: <11552d49-cbd0-fc15-07b7-77f73b8cb955@inwind.it>
Date:   Wed, 7 Jun 2023 07:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v3] [btrfs] Add handling for RAID1CN/DUP to,
 `btrfs_reduce_alloc_profile`
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <276ea9bf-13f3-1349-a5b6-4dfcaaab7ef2@bluematt.me>
 <ed8c45b9-1b83-d706-add9-fa2d5f41576d@libero.it>
 <e3636d48-92c7-27e3-b63e-b3605fcc1dbf@bluematt.me>
 <a7851ed8-8b1f-3ec0-56a4-fe059bdf6183@inwind.it>
 <8f857c05-446e-dab1-5863-e6fdf737acff@bluematt.me>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <8f857c05-446e-dab1-5863-e6fdf737acff@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAvW3hsJl/uT2/RC5wZnpPCdcuTSim11pBQHmYSd+KnlxHSWxc+wRazvuUeXujBm+a44+kP5h6TmCkhpjVoS1TLRXrZSpQDtaCjgrt4Dq3td7KZDp9O7
 lsr48DfOaW9dv2zgThmjfIfJk1rmTV6/qiMZx3Zuw2nM2JCX0mN2X/YlIsimNplAUQwrC54Y5UddmF8Jbgj3de3UDnMfpoRhrwc51KHbkzUC9JNDU6piTVHC
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi Matt
On 07/06/2023 00.31, Matt Corallo wrote:
> 
> 
> On 6/6/23 11:27 AM, Goffredo Baroncelli wrote:
>> On 06/06/2023 01.45, Matt Corallo wrote:
>>>
>>>
>>> On 6/5/23 2:10 PM, Goffredo Baroncelli wrote:
>>>> Hi Matt,
>>>> On 05/06/2023 21.31, Matt Corallo wrote:
[...]

> 
> Having a fallback here which wipes all the bits but single and forces us to single still feels like very much the wrong fallback, if we want a fallback, we should pick a bit that exists on the fs, not make one up, and we should definitely not make one up that has a lower redundancy level than what the user is expecting.

See below

[...]

>>>
>>> No, having a case where we randomly go from a RAID system to falling back to SINGLE is really not an okay fallback. We should just remount-ro.
>>
>> Even thought I don't like the logic too, this logic is used from several years (if
>> not from ever); and nobody complained.
> 
> Not sure what you're referring to here, 

Basically, the original code try to find a valid combination between the available disks and the existing profile.
If there is no combination, the function return 0, which means SINGLE.

This is the logic that I don't like (I am not referring to your patch).


> I'm just a user trying to fix a transaction-abort I saw on my system and needed this patch to get my fs to mount RW :). 
> At least the specific code in get_alloc_profile has no such fallback.

> 
>> Anyway for me it is enough to have a WARN_ON; but without that the patch losses most of
>> its interest.
> 
> I don't really get this - the current code isn't just kinda messy, its also very broken, a patch that fixes the brokeness, which I ran into as a user, should be "interesting" irrespective of if it also cleans up the code, which is messy but certainly far from the worst code in kernel anywhere :).
> 

You find a bug, you did an deep analysis and you wrote a patch to solve this issue.
This is a valuable work and I my intention was not to dismiss it in any way.
Sorry if I was not clear about that.

What I meant is that the patch will get a lot of *more* value if you try to address the risk of the reoccurring of the problem when someone will add a further profile.

Told that, I agree on the "complexity" of the code;

> Matt

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

