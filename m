Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FC58E723
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiHJGKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHJGKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 02:10:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8067CD7
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 23:10:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so19848292lft.8
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=T+NN90y9gPhLV+F0IRQg2DuVvbvHifr5dOe5YZkss7s=;
        b=XKKY1GA/KRaquJfPK7XpG87hredbMcXRjz62tNgHBprxPU6wBVNIyjxuuGha/S/Kyy
         rG14uQ3Ee6sZKPRYckQ5VEk8uZynXV4QU8lRxJStR6HewN6PpIKJ1XadWBnQjCXLbEqq
         MqVMD7HEmL77CUQ6BLqGETwlO9ewXE+H2m4J0NjSLrZOs3PYL1b5J+rT92CO/aBZDVuZ
         Bsn1+uB99gwnhavvKEuiCdiDGSkaq3S6p3kOqkeyvpv2hAZXAuaAb2c+HZFnUfjWrixj
         WppdK1+AXmFDr9cgazw8rys1a76bD9ProImz7E84olCMv5TUn9KJ2sSAdb93alPMWjfQ
         EahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=T+NN90y9gPhLV+F0IRQg2DuVvbvHifr5dOe5YZkss7s=;
        b=Lgdg6eeFaZQ9nmDZlcmec+wMVQKY7bLB4yRzXNq/Z/novFhJe5yhjR3c4qgTp6AJXO
         mDe/pVvdqYxsCuTDUKGOxZeXZ16OBOcsl6Z8KxCzMDBRkeT6Y6G2WhgiGILrgT/WcBjP
         QKbR4AIX9fJkbjZZtvIjINLlGjdjcy0Pes2wO/oR3/XtQP8zPWSI4O349elY8/gjlu0z
         /BVsnztkl5fwmgHyClgSA/SuHSHOVRbewrARKs2SdG22TmKhSG8j1keyHZIfOGF0GSaS
         pZVMbkURnI4PoHCLnQyqkcuxUffKTcUkHkcax3unJyICl+AacgRpbaeP/tCMmuFjtNDT
         O8dg==
X-Gm-Message-State: ACgBeo0PmuX0oIRfcPCbtMxbEp4ULdufdjvyo1Dk7pmi9EGt+Rz7y5tc
        8rvKpyoIpvBdOtvnK8prPoA=
X-Google-Smtp-Source: AA6agR7qcU+ErQkju715GL3RyBbAG0t+Ae2JnXRgu2fl8x/tgzoJTmsfY0hai9CgdWW/NatBmr9Mcg==
X-Received: by 2002:a05:6512:3dac:b0:48b:694:bb35 with SMTP id k44-20020a0565123dac00b0048b0694bb35mr10058021lfv.215.1660111829890;
        Tue, 09 Aug 2022 23:10:29 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.232])
        by smtp.gmail.com with ESMTPSA id p21-20020a2eb7d5000000b0025fde1697b0sm266480ljo.135.2022.08.09.23.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 23:10:29 -0700 (PDT)
Message-ID: <6ab45148-cf37-43cc-1bd0-809af792e24a@gmail.com>
Date:   Wed, 10 Aug 2022 09:10:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
 <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
 <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.08.2022 14:37, Qu Wenruo wrote:
...
>>
>> I think what happened is having had mounted the FS twice by accident:
>> The former system (Mint 19.3/ext4) has been cloned to a USB-stick which
>> I can boot from.
>> In one such session I mounted the new btrfs nvme on the old system for
>> some data exchange.
>> I put the old system to hibernation but forgot to unmount the nvme prior
>> to that. :(
> 
> Hibernation, I'm not sure about the details, but it looks like there
> were some corruption reports related to that.
> 
>>
>> So when booting up the new system from the nvme it was like having had a
>> hard shutdown.
> 
> A hard shutdown to btrfs itself should not cause anything wrong, that's
> ensured by its mandatory metadata COW.
> 
>> So that in itself wouldn't be the problem, I'd think.
>> But the other day I again booted from the old system from its
>> hibernation with the forgotten nvme mounted.
> 
> Oh I got it now, it's not after the hibernation immediately, but the
> resume from hibernation, and then some write into the already
> out-of-sync fs caused the problem.
> 
>> And that was the killer, I'd say, since a lot of metadata has changed on
>> that btrfs meanwhile.
> 
> Yes, I believe that's the case.
> 
...
> 
> Personally speaking, I never trust hibernation/suspension, although due
> to other ACPI related reasons.
> Now I won't even touch hibernation/suspension at all, just to avoid any
> removable storage corruption.
> 

I wonder if it is possible to add resume hook to check that on-disk
state matches in-memory state and go read-only if on-disk state changed.
Checking current generation should be enough to detect it?
