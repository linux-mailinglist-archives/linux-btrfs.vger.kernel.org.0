Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1458753B920
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiFBMtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiFBMtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 08:49:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBC98FD5F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 05:49:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id be31so7635602lfb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=DsAmWfZXUFKpMZjnzeQ5y/LCTEiOQyQ4FrxE6g253u4=;
        b=EHYuRp76Z+ttA9zFRCwp/iwsyV2XhTe7dPOZFUfDC7/AfXOaXmL29Vk6VV8FJOlN4A
         vc2nnNT1z9u59gMTK5SW2BuZwBF1/bhuZC3v0hvYUNuPelOOZzvOvGY8JqBPBG0oLmJR
         d9UKf7emSDfvdEeEhThfwwjQFWEHgG/2lz47g0keSj/IIhneBATWgNvIPz+BSsXOiNjo
         6HH0r2xZlymMgDSkVahV97ApFuT5ceMFlaek73mZxLCO+aXEv/tJrE4S8ZFf4wkLAznW
         5L4h/Vpqpb/W6anSNPGDNLULls4UezJaW07HVGz1YkEbKnjeIy/WNIrvdNo8proEJwS1
         9kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=DsAmWfZXUFKpMZjnzeQ5y/LCTEiOQyQ4FrxE6g253u4=;
        b=iSTPKI2rJmPnDdidBTTU7/5w5PY5kOO6SSqhmTFvtE2LvnwRYVSlM4wJV5eN0iEJMz
         7wdM1HHGnqqG15RrRBje9XwoUHRtSyArgpYCBCZ2XTYZ+VVgtHz2GCsXQj7Ue9XAgKH/
         rzYnSHtdOwr4mPwm6Pl693UM2kt/D3GabkV6B2PALe5wJl63gZjDI2snzL7tA3y/meP8
         XGLzJtateGHiEY1f+aEtzHSD8h3YlpiyG4zoSPIZOZndpp0uUNs+wsg9Sy9lyRDtH9tE
         GFiobMJ9A2enJzHhP7Wocn2AIxttTWAAHQJBIbQ1IdxobAI/yn8VrvMBwLjg10afrPUb
         vf7A==
X-Gm-Message-State: AOAM533MSAZFytapAK3o3g4ntvBKVSQO05C+DCKIhy4nueMvLDLuS8yy
        v+PH1GjAyg5mfC6C6hP/Fsw=
X-Google-Smtp-Source: ABdhPJwpBqJTcFQJW/NMOeEpaxzRScBlDCpt2CcXdzTdx2xJP4PvUZFfYyC9nmvumVQJwUQDn7EafQ==
X-Received: by 2002:a05:6512:2593:b0:478:6327:3672 with SMTP id bf19-20020a056512259300b0047863273672mr40633082lfb.497.1654174175931;
        Thu, 02 Jun 2022 05:49:35 -0700 (PDT)
Received: from [10.0.3.128] (dsl-kpobng11-58c303-5.dhcp.inet.fi. [88.195.3.5])
        by smtp.gmail.com with ESMTPSA id m12-20020a0565120a8c00b0047255d211fbsm1001307lfu.298.2022.06.02.05.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:49:35 -0700 (PDT)
Message-ID: <d26ecc30-409a-ad22-74cb-39da3d83b6f9@gmail.com>
Date:   Thu, 2 Jun 2022 15:49:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [HELP] open_ctree failed when mounting RAID1
Content-Language: en-US
To:     =?UTF-8?Q?Lucas_R=c3=bcckert?= <lucas.rueckert@gmx.de>
References: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
From:   Jussi Kansanen <jussi.kansanen@gmail.com>
In-Reply-To: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/22 22:50, Lucas Rückert wrote:
> Hi,
> 
> i run two HHD's(sda;sdb) in RAID1.
> 
> Kernel: 4.9
> 
> Distro: Linux odroid 4.9.277-83 #1 SMP PREEMPT Mon Feb 28 15:16:26 UTC
> 2022 aarch64 aarch64 aarch64 GNU/Linux
> 
> btrfs-progs: 5.4.1
> 
> I created the filesystem with:
> 
> mkfs.btrfs -d raid1 -m raid1 -L somelable -f /dev/sda /dev/sdb
> 
> 
> And added it to my fstab:
> 
> UUID=<uuid>        /mnt/somefolder     btrfs compress=zstd   0       2
> 
> 
> When running:
> 
> mount -a
> 
> i get an error:
> 
> mount: /mnt/backup: wrong fs type, bad option, bad superblock on
> /dev/sda, missing codepage or helper program, or other error.
> 
> 
> and dmesg reports:
> 
> BTRFS error (device sdb): open_ctree failed
> 
> 
> 
> Yours sincerely
> 
> Lucas
> 

Hi Lucas,

Invalid mount options can be reported as "BTRFS error (device sdb): open_ctree 
failed". The reason for the error is that your kernel version doesn't support 
zstd. 4.14 kernel added support for zstd or 5.1 if you want to set zstd 
compression levels by mount option.

-Jussi Kansanen
