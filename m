Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69D94D9E61
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 16:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiCOPM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbiCOPM2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 11:12:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A34AE03
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:11:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t1so24397703edc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xbs94pgAr6d26kh4ZkL/FOyE1X0en+94P1wF5dstScY=;
        b=MPsGdg239VV6aADSuvc7wcuF4+xuED3y00LONqqUMOOqkG7hI9BNpNJ2tSdl65cD8s
         DOKAZQFI3Gc0D84JYPbRcFHyUySvh8RM5B0inkurWrFVfRtnUMfv40NiQX7/uBHqFLdx
         Xj9M+gnI0uTDazsGC/xjEP25ea5M1VfbWldJMY1gwbHQmub2TF3MLDnM7Y55s7ZqVXGT
         9vcHawkUBkHfH5JJgN0b1V0m9rrvfI3KsGpI41isX+QFe4R9Q4IaVJ4Xc3brvCMy4L8Q
         oE/mWEJMj4MloUNkIxKt0+AZBTRZDNOrVBJ1EY3GhFtw03p/KGHs+eDf8eML0K3rV6Y0
         n1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xbs94pgAr6d26kh4ZkL/FOyE1X0en+94P1wF5dstScY=;
        b=xp4MCHgu2hxchyZvapaDMwjbweI0d2fCqaDD742HFDlE/ZIMKUp272wGnAMZGGglDG
         yoURSql6HidNSAi/h8bD6HcfkmbFaspsYwGPBSPRPS6zN4yq5QZK/2CSZEtYpd0pDdgv
         CRZK/M7qzHIhD3YIyhHkU/eeapcyHVSGHcxvM9x+/hiClGGTAms97wD4WJ+GkaAqoyvE
         b2J/CeBUdc6Jkj1Ae2CyNXWtFMYk957xp1a9g0a/sQPd1eO/lngKHGzlUKWM7MmHvAeA
         WSlTFw1riyQnwgI+YU5dk6r04vByZg2XWcxDqNi3oo1rouFlDEKRL50FFxgVjhTxdPcF
         ghQA==
X-Gm-Message-State: AOAM533qFQYFPwhxhlxXepn15B2O1bxBdakYWHJCkVJuyY+ehrTTMARN
        HKarQTM5G5oPE9KYa2BY+jFhww==
X-Google-Smtp-Source: ABdhPJxWm4DexO8aldPYblCK2E4OP07WJOcqFYNyVLfZ67k2vZEOO+Q65ku6NMtFdvD0cJAhqb+yrA==
X-Received: by 2002:a50:d79d:0:b0:415:d5a1:2a13 with SMTP id w29-20020a50d79d000000b00415d5a12a13mr25897105edi.375.1647357074620;
        Tue, 15 Mar 2022 08:11:14 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm8142436ejd.152.2022.03.15.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 08:11:14 -0700 (PDT)
Date:   Tue, 15 Mar 2022 16:11:13 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315151113.6xvepugdoes7l23a@unifi>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.03.2022 14:14, Johannes Thumshirn wrote:
>On 15/03/2022 14:52, Javier González wrote:
>> On 15.03.2022 14:30, Christoph Hellwig wrote:
>>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
>>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>>> file-system. As other interfaces arrive, this work will become natural.
>>>>
>>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
>>>> still do the work in phases to make sure we have enough early feedback
>>>> from the community.
>>>>
>>>> Since this thread has been very active, I will wait some time for
>>>> Christoph and others to catch up before we start sending code.
>>>
>>> Can someone summarize where we stand?  Between the lack of quoting
>>>from hell and overly long lines from corporate mail clients I've
>>> mostly stopped reading this thread because it takes too much effort
>>> actually extract the information.
>>
>> Let me give it a try:
>>
>>   - PO2 emulation in NVMe is a no-go. Drop this.
>>
>>   - The arguments against supporting PO2 are:
>>       - It makes ZNS depart from a SMR assumption of PO2 zone sizes. This
>>         can create confusion for users of both SMR and ZNS
>>
>>       - Existing applications assume PO2 zone sizes, and probably do
>>         optimizations for these. These applications, if wanting to use
>>         ZNS will have to change the calculations
>>
>>       - There is a fear for performance regressions.
>>
>>       - It adds more work to you and other maintainers
>>
>>   - The arguments in favour of PO2 are:
>>       - Unmapped LBAs create holes that applications need to deal with.
>>         This affects mapping and performance due to splits. Bo explained
>>         this in a thread from Bytedance's perspective.  I explained in an
>>         answer to Matias how we are not letting zones transition to
>>         offline in order to simplify the host stack. Not sure if this is
>>         something we want to bring to NVMe.
>>
>>       - As ZNS adds more features and other protocols add support for
>>         zoned devices we will have more use-cases for the zoned block
>>         device. We will have to deal with these fragmentation at some
>>         point.
>>
>>       - This is used in production workloads in Linux hosts. I would
>>         advocate for this not being off-tree as it will be a headache for
>>         all in the future.
>>
>>   - If you agree that removing PO2 is an option, we can do the following:
>>       - Remove the constraint in the block layer and add ZoneFS support
>>         in a first patch.
>>
>>       - Add btrfs support in a later patch
>
>(+ linux-btrfs )
>
>Please also make sure to support btrfs and not only throw some patches
>over the fence. Zoned device support in btrfs is complex enough and has
>quite some special casing vs regular btrfs, which we're working on getting
>rid of. So having non-power-of-2 zone size, would also mean having NPO2
>block-groups (and thus block-groups not aligned to the stripe size).

Thanks for mentioning this Johannes. If we say we will work with you in
supporting btrfs properly, we will.

I believe you have seen already a couple of patches fixing things for
zone support in btrfs in the last weeks.

>
>Just thinking of this and knowing I need to support it gives me a
>headache.

I hope we have help you with that. butrfs has no alignment to PO2
natively, so I am confident we can find a good solution.

>
>Also please consult the rest of the btrfs developers for thoughts on this.
>After all btrfs has full zoned support (including ZNS, not saying it's
>perfect) and is also the default FS for at least two Linux distributions.

Of course. We will work with you and other btrfs developers. Luis is
helping making sure that we have good tests for linux-next. This is in
part how we have found the problems with Append, which should be fixed
now.

>
>Thanks a lot,
>	Johannes

