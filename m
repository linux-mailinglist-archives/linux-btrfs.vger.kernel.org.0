Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EF69B86A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBRG5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 01:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRG5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 01:57:11 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5E2595B
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 22:57:09 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v11so569253lft.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 22:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+9e5Ix56yjIRHs60u07wB6V2ADVt/cLX6W3j606CYU=;
        b=Q/xvx65gSwyLvc1e5KdVboxRm0kmaeHqsLvCz67JelLO3KhuW8F94aKLI9Bmgofnd9
         0c2UpuvT1Xne908xfn+dsylNOKTbTipdrHj7D7nT5eDlJ7OUFguUpgZl15CO/A/ZiNVQ
         hKauTMP1vycWj70xlgWDtawsz5IP89qob6tyfg9TGjngEvkPj1rK75rarKBZzksvMXgG
         qzJdxVBA4ijZe/Su0oOiGp1BgeTAbq4z9xCHkNWWwk+vGll/MeFM2BCJmUF0Fpz3NeLa
         QbHWHisOE17oFVqhkjAVVOzmSn+bvK+FRmpX2rXQFgE0mkwD6SGyKZsMr8j9Dt91okjU
         8lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+9e5Ix56yjIRHs60u07wB6V2ADVt/cLX6W3j606CYU=;
        b=IcRCQ9U5yYrqdNeNsiPOsGKhZQHN34cYKrbrdi/OBhA2H1Qr2j4B03BWpPOd6o7F3X
         18eAXB+HWmZcLxpiz6aWbX6kI3TbkrNk4P28Nprr1cHD0emm2WEzuOIoca//xz8M9P6e
         fNUMQhOglAALlBGfiL/jXU15XisyWEvMdGGS9Ygng0qUKV4OjpdbYzErqk8gIfxF7a8N
         2wqSyKOqBeZ33dFUCDUquzQHbWkmghzUEcrGToLc+OcDRWb5vmUCCALTvvjj/SnndmfZ
         K0wsX5Xif5tzG0OaFN2freiSeUuy4S5mp/1QuokGkBaK8Mib1kyQcZ91qMimowmsiZZK
         ZpQw==
X-Gm-Message-State: AO0yUKXJDa6rr+Cgf7jPHRTtnU9GflbUDR+qF3DLZJ7JlgPPUl8L3vdi
        Z27rV5xiptq5kV9RUAuY6j2RwVDqZ7I=
X-Google-Smtp-Source: AK7set97dT+5x+1MRK9IopA5U4fysaIX5j0yBZKz7Jvp4gY7thWbea2vCQ6hYzTcwT5dlKFqjjWafA==
X-Received: by 2002:ac2:4ac7:0:b0:4db:1e4a:749c with SMTP id m7-20020ac24ac7000000b004db1e4a749cmr1084299lfp.0.1676703427557;
        Fri, 17 Feb 2023 22:57:07 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:4f6:b0ee:d8e5:5c8a? ([2a00:1370:8182:1876:4f6:b0ee:d8e5:5c8a])
        by smtp.gmail.com with ESMTPSA id l12-20020ac24a8c000000b004db1b99055dsm912462lfp.229.2023.02.17.22.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 22:57:07 -0800 (PST)
Message-ID: <f55d595a-e96c-b890-bc40-81f7d5d389d0@gmail.com>
Date:   Sat, 18 Feb 2023 09:57:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: back&forth send/receiving?
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
 <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
 <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
 <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
 <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
 <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
 <d02fb95aecf51439c7784c990784f73a11412e4b.camel@scientia.org>
 <c0e00d00-20ff-642f-bbfd-ecbd17669502@gmail.com>
 <b492bb2878c839b2ea9cb8a9c94124062e29f42d.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <b492bb2878c839b2ea9cb8a9c94124062e29f42d.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.02.2023 03:29, Christoph Anton Mitterer wrote:
> On Fri, 2023-02-17 at 20:25 +0300, Andrei Borzenkov wrote:
>> So copy1 and copy2 are identical. This is not what you said earlier
>> (at
>> least, it is not how what you said earlier sounded).
> 
> Well that are based on the same master, but their most recent snapshot
> from that *may* be a different one.
> 

We are going in circles. To continue incremental chain on another copy 
after switching to a new master you need common base snapshot on the new 
master and the other copy. If such base snapshot exists, you can 
continue - starting with this base snapshot. If such base snapshot does 
not exist - you cannot.


