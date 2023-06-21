Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8B7382ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjFULh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 07:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjFULht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 07:37:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE221738
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 04:37:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8680d8bf2so795885e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687347455; x=1689939455;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nIJc8Bq0Yb7h1MPAqQoE4QRaQNniL1HFGb4vUTmAm0=;
        b=FsCub9pP9AFIJZi84XRnl9k5E19kviLhFGS3VkGdKFOgaRXZKYBan0XK7LMmZTtdzR
         mziOr7H/KyBtuPCeZs8yN0+AnMnAPcqOBHiiKI1rNSqbBpQ3QBhJKj0Rf7ccZtoDOXXJ
         dGYkq0zgbpzTmEu59lRbyyNW/6uSyAN5hBV+kjhvTr1vQRF2r/KNM9eEngYFd8Ez7qLU
         f+bzhDxPSaokSCEcVMGgrSRtMFKJp9eF0+LVWLhdoy7tWAuXd7ojYLWFKY+NGjof4Xos
         ahb1TmhxOs98kiIajJnK4BgK3gQj0DPxygCVx0U9r0UCOBdKxUnns0VA7pGK6Nri2/7Y
         EYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347455; x=1689939455;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nIJc8Bq0Yb7h1MPAqQoE4QRaQNniL1HFGb4vUTmAm0=;
        b=joKG0pm0b40tlfN8ngDRG9AmLvZ4r3LFe9vef5B84mzEYy2jG8EjrVs4MzFmjwO+Yg
         1LFqCmzA+YppZrZfsxwC0xL/nGLOF47Tg8sjikgknpQ9avFF0kjmrPu9eTqVanTdHRS/
         2n64tBw7oKDlZ5a/CycEzZKOqPyVmfFnxerWUs49NafCHsWB5IfTdG6onc1pWnfNR0Hr
         I33cnRQK/I5zKbd4Qphgj84nw2FgXEnh/wottw/UytJKCPmGTH7EC395HvyVW2mjvk16
         XLkFqSLIk6orS+6BVKAXRyqqANWMrzJzB9EAAztMO7SUR1hpQDWRfOp7R4PS3MxZLqQm
         VxWg==
X-Gm-Message-State: AC+VfDxMLm9pZ5n+O32yeWqNCBYwLAp632+3XgDTyWP43/i/PvFW6wR6
        L82mI/3cTMhnBISM21fd08s+6dnoWx8=
X-Google-Smtp-Source: ACHHUZ4hNbusURbNq+fMBhWfKy2m8RJXFZpUmWPlmlNbEJ+vevguKe8LpZw3XI+nbP7VsM64/ltK6w==
X-Received: by 2002:ac2:4833:0:b0:4f8:42af:6a51 with SMTP id 19-20020ac24833000000b004f842af6a51mr7502764lft.1.1687347455209;
        Wed, 21 Jun 2023 04:37:35 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.132])
        by smtp.gmail.com with ESMTPSA id d8-20020ac244c8000000b004f85a24d2basm752406lfm.105.2023.06.21.04.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:37:34 -0700 (PDT)
Message-ID: <0204a3a0-0d8e-0545-3eaa-e9324ab6cec7@gmail.com>
Date:   Wed, 21 Jun 2023 14:37:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: filesystem inconsistent ?
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB73408AC6484D506DCFEE4D6DD65CA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <f8a9ea7b-076d-fe63-7a9f-4441663f765e@gmail.com>
 <PR3PR04MB73401431EB21CCCC1A6A959CD65DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <PR3PR04MB73401431EB21CCCC1A6A959CD65DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21.06.2023 11:59, Bernd Lentes wrote:
> 
>> -----Original Message-----
>> From: Andrei Borzenkov <arvidjaar@gmail.com>
>> Sent: Wednesday, June 21, 2023 7:08 AM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; linux-btrfs <linux-
>> btrfs@vger.kernel.org>
>> Subject: Re: filesystem inconsistent ?
>>
>> On 21.06.2023 00:40, Bernd Lentes wrote:
>>
>> It means exactly what it says - that some data on one of disks failed
>> verification. You did not provide any information about your filesystem.
>> If it has redundant profile (like RAID1), then btrfs got the correct data from
>> other copies. Otherwise you can only delete affected files to free corrupted
>> areas.
>>
>>> What can i do ?
>>>
>>
>> Starting scrub for this device certainly makes sense.
> 
> Hi Andrei,
> 
> thanks for your answer. The BTRFS is on a Hardware RAID 5.
> But what could be the reason for the inconsistense ?

It looks more like software bug, but it is better some btrfs developer 
chimes in.

>  From where do i know which files are affected ?
> 

You could try

btrfs inspect-internal inode-resolve


