Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE1737A88
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 07:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFUFIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUFIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 01:08:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FE171C
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 22:08:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so1299294e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687324111; x=1689916111;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hy1OYxKpL3Wi66W3LO8Xg3B/oIi0CSfUZq2oGyCWWA=;
        b=fwkvUKG5L/3ZsFNy3vJv2xr2/QUsProBKVh9AO3BBzZOsVxsbMvWjf2vI0R4bhjaay
         +3jqKN089iBNsrm9YV20Z4tJZBtpvSXh6WlwzmDDWOwKcXPlLrjq7teFvrImv6XjRz/Z
         VkcsQ+WRTl0eUQi48TcCCTkRdfHvJoIVgsLRnMHthxZoKAzJgQRXs/LrHXZ0NjQQtT3a
         xeiBD1KIcMABJwkka9pEB6aO8RINgwUEsQJHgqEUA8UiI0Hwz1nmScXZ178n3FovX8MM
         8sDxeu4ynGxK4a24N2YG1DytCoYupYfWGX2V5s4V6LIQW/jvxTxARundbw/0gZgdeATB
         hwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687324111; x=1689916111;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hy1OYxKpL3Wi66W3LO8Xg3B/oIi0CSfUZq2oGyCWWA=;
        b=Fr3aVD8/4ANTwoPAVSgnb2wfwLX2wDMhIpae+7XOVnj0dbc4AMATzCBFrFTTN0Oozl
         HN3tLulPuvUwKWNFnjfdHN17i31OirECv3MFAG9TYnq4zKfLdH3Dk56ffAUwdl5cDpag
         VMQTz4UgYmEiBaUMkyeWZMolgt6WupIlcrD3D4GtQcOrTvwcIJCx/lc9ZWdaCtn3OelC
         rh2lvRyRH63dfzkaD/eYJU7SloIhJAak8lrwPp6IfEGhqAwdmbvfq/Lz932vpqXHzNAQ
         G1R3TGOXGVGc+2Fj6MPuMHBosMhAdZmLP0XAqvYUBSsmzdhuO1UaOMvQw+QZxnj/r3Ml
         DJyA==
X-Gm-Message-State: AC+VfDwVRsLmnloxFmZgiyw+PoxowvEARRmJQyMZpznfT29N8T6KiBWk
        +gQWNOEnhxfHRs0yFXSOFNbD1pRTgjA=
X-Google-Smtp-Source: ACHHUZ5NKeeXr64G5eVqSqcKo+biBjR3cRkKsP75DYc24ZvRuCqrxwgYA54u4TTivzhxJIHjjkpXzg==
X-Received: by 2002:ac2:4304:0:b0:4f3:a878:2c02 with SMTP id l4-20020ac24304000000b004f3a8782c02mr6291583lfh.4.1687324110779;
        Tue, 20 Jun 2023 22:08:30 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.132])
        by smtp.gmail.com with ESMTPSA id n8-20020a195508000000b004e90dee5469sm614440lfe.157.2023.06.20.22.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 22:08:30 -0700 (PDT)
Message-ID: <f8a9ea7b-076d-fe63-7a9f-4441663f765e@gmail.com>
Date:   Wed, 21 Jun 2023 08:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: filesystem inconsistent ?
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB73408AC6484D506DCFEE4D6DD65CA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <PR3PR04MB73408AC6484D506DCFEE4D6DD65CA@PR3PR04MB7340.eurprd04.prod.outlook.com>
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

On 21.06.2023 00:40, Bernd Lentes wrote:
> Hi,
> 
> my log is full with these lines:
> 
> 2023-06-06T10:04:36.136056+02:00 ha-idg-1 kernel: [1787052.358272][ T3665] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 28356128768 csum 0x317097fc expected csum 0x552d7f6f mirror 1
> 2023-06-06T10:04:36.136075+02:00 ha-idg-1 kernel: [1787052.358295][ T3665] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18366, gen 0
> 2023-06-06T10:04:36.156052+02:00 ha-idg-1 kernel: [1787052.380080][ T3665] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 1561939968 csum 0x386bf15d expected csum 0x8b4d4d30 mirror 1
> 2023-06-06T10:04:36.156060+02:00 ha-idg-1 kernel: [1787052.380091][ T3665] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18367, gen 0
> 2023-06-06T10:04:37.148069+02:00 ha-idg-1 kernel: [1787053.373501][T24654] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 1561939968 csum 0x386bf15d expected csum 0x8b4d4d30 mirror 1
> 2023-06-06T10:04:37.148086+02:00 ha-idg-1 kernel: [1787053.373519][T24654] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18368, gen 0
> 2023-06-06T10:04:38.148056+02:00 ha-idg-1 kernel: [1787054.373547][T24654] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 1561939968 csum 0x386bf15d expected csum 0x8b4d4d30 mirror 1
> 2023-06-06T10:04:38.148072+02:00 ha-idg-1 kernel: [1787054.373564][T24654] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18369, gen 0
> 2023-06-06T10:04:39.164062+02:00 ha-idg-1 kernel: [1787055.389162][T24654] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 1561939968 csum 0x386bf15d expected csum 0x8b4d4d30 mirror 1
> 2023-06-06T10:04:39.164082+02:00 ha-idg-1 kernel: [1787055.389178][T24654] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18370, gen 0
> 2023-06-06T10:04:40.164065+02:00 ha-idg-1 kernel: [1787056.389321][T24654] BTRFS warning (device dm-14): csum failed root 5 ino 278 off 1561939968 csum 0x386bf15d expected csum 0x8b4d4d30 mirror 1
> 2023-06-06T10:04:40.164080+02:00 ha-idg-1 kernel: [1787056.389349][T24654] BTRFS error (device dm-14): bdev /dev/mapper/vg_san-lv_domains errs: wr 0, rd 0, flush 0, corrupt 18371, gen 0
> 
> What does it mean ?

It means exactly what it says - that some data on one of disks failed 
verification. You did not provide any information about your filesystem. 
If it has redundant profile (like RAID1), then btrfs got the correct 
data from other copies. Otherwise you can only delete affected files to 
free corrupted areas.

> What can i do ?
> 

Starting scrub for this device certainly makes sense.
