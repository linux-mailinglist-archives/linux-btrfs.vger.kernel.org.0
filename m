Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3667252EC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFGEgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFGEgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 00:36:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F71A83
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 21:36:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f13c41c957so734558e87.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686112607; x=1688704607;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFRAj2WQbZjfLQxP71Qb5GMXfbvhEirQzrvh5oS3yZs=;
        b=lpOuNmVnIeITHmri4OpOwd0dBwg3pxFqDeDQNGJvEO4pqc87O7rzqRJgaquc6fzncR
         CPawItQowabwWfwgV/QdGROu6qCr58paSNs0nucY0wPmtRmOOYtNonceUva4YOiKTa4Q
         k9zpeuzsIqmc9VO3CpxiUnmYuVuN6ycqQWc1yT55m5lF/TX9vkp7/UQ7j8b36XIY+Ihi
         TfnNyx9xk5jw0wnx93OIjsGeFQwGR7N7a4MLdDb+39BJ0gOuwtEo6lULNjmcs2e54CQv
         SF/OTADxnIM/lnNdAYDkuMNn+gRxNDxg7pUR+O19gEuX71GxiziubpWVOHu5TqJqdlUd
         kHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686112607; x=1688704607;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFRAj2WQbZjfLQxP71Qb5GMXfbvhEirQzrvh5oS3yZs=;
        b=UlL4QfXnT4KIJgU2JzflAo66SV2cK+HvcNTC3f4t47BxxGIVGxo3RjoxSZSuWnPrSA
         /KiJNXf3mOrz3E5SpwVwaTPjqv9T7IBSHVa4IHAfh4u1o4H/2GNJ4QC+RGwX30uVULFl
         78CYSb+x1UISjpcdfXrNukBlFFQXgTLc0CLJW44NZVVH/tYIlIJjR1Ki4jlp3rYXA0EK
         TQUsCemfVIGxBf8TDPQD9LGKDAsLxqFve0SWNHKs+wyq8xFq01BWgsiWd0IlB4sFSkjl
         IME9BXONRnjmB3vyePIniOu43KE4d6GJCzTTpo5fAdzUNh2EIJ8nm7XYiJbb8WrK55EF
         mRpA==
X-Gm-Message-State: AC+VfDyqvcJF+cKklY/qwXBWwZFRG9fta8t3NuSo234UrSeJW4b1Tuui
        3i3Atznu1BmfgaCT5oslZAa4jds6Uo0=
X-Google-Smtp-Source: ACHHUZ6A60o4ZMAk4YT208DbfZayEQ0TJWna34KwiERZ55IdmJi34XlixDgQyZJQBHGIzmcD1gLGkQ==
X-Received: by 2002:a2e:aa1c:0:b0:2b1:e724:4d08 with SMTP id bf28-20020a2eaa1c000000b002b1e7244d08mr313849ljb.4.1686112607044;
        Tue, 06 Jun 2023 21:36:47 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:1d8:2046:482:10c3:5c55? ([2a00:1370:8180:1d8:2046:482:10c3:5c55])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e80c7000000b002b04fc12365sm2092902ljg.76.2023.06.06.21.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 21:36:46 -0700 (PDT)
Message-ID: <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
Date:   Wed, 7 Jun 2023 07:36:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: rollback to a snapshot
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.06.2023 23:58, Bernd Lentes wrote:
> Hi guys,
> 
> thanks for your help.
> 
> I have an Ubuntu box which I wanted to upgrade. Fortunately I made a snapshot before.
> The upgrade ran only partially and now I want to go back to my snapshot.
> I booted the system now with a recuse cd.
> This is my setup:
> 
> root@Microknoppix:/home/knoppix# mount|grep btrfs
> /dev/mapper/ubuntu--vg-ubuntu--lv on /mnt/btrfs type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)
> 
> root@Microknoppix:/home/knoppix# btrfs sub list /mnt/btrfs
> ID 430 gen 1215864 top level 5 path .snapshots
> ID 434 gen 1213568 top level 430 path .snapshots/06-06-2023--15:16_PRE_UPGRADE
> ID 435 gen 1216086 top level 430 path .snapshots/06-06-2023
> I want to go back to ID 434 or 435.
> 
> I found a lot of different approaches in the net, so I’m a bit confused.
> Changing the default subvolume, moving or renaming subvolumes … A lot of examples have a subvolume @ which I don’t have.
> 

You cannot rename or move because you cannot "rename" or "move" 
subvolume to become filesystem top level. Which is one reason why you 
should never use btrfs top level subvolume if you plan to use snapshots 
and be able to revert. Actually you should probably never use btrfs top 
level subvolume except as container for other subvolumes. Period.

You could simply rsync from snapshot to revert the content of your root. 
It would be the most simple way (it will probably increase space 
consumption slightly). Or you could boot linux with subvol=... rootfs 
option - there is no need to actually change default subvolume.

If you chose "use different subvolume as root" route, keep in mind that

- you will likely need to reinstall bootloader because paths will change.

- any subvolume below / like /.snapshots will be invisible from your 
booted system and you will need to explicitly mount it if you need to 
access its content.

- as mentioned already, do not flip read-only snapshot to read-write, 
rather create new writable clone. I would also chose some different path 
leaving /.snapshots for snapshots. It does not matter in this case (at 
least, with the information provided so far) but it is good habit to 
develop.

- after you booted new root subvolume you will have the old root content 
in top level which cannot be easily deleted because it is not subvolume 
(and it will be invisible as well). You will have to clean it up 
manually, and be careful to not delete your subvolumes doing it :)
