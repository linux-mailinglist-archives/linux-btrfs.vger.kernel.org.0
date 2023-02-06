Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFD68B4CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 05:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBFEQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 23:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBFEQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 23:16:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4FF753
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 20:16:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr8so30621297ejc.12
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Feb 2023 20:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ikxed9ftIIEGuIrrTPwALfN25nhmhnppGNOxa2EIxTs=;
        b=Q4jQG4byrpluFfoW8LDGNr0Nf5dS+HGgPDixx8Gf91/LPUAlAYPgnmx2OIMGT8jfB6
         bkncKzPXmIKJPg+ezJb9tQrT+sXaMK/4aBuzLfANbFE/SdZLJxcSGD7QWy23nqA81lHz
         VmKehw+jlKljYT9ffvksapPVD1jXjDVHjOJx8p0OxQ5xKMeKYS9Bj1OpIiogDV2B6f+W
         JXtdcim8D2evzdAfCcU9kzmDJH4oNtDS6fYYA2ALuYtxsQ3OwABTvkH7soAEZByXXn88
         16l8VQyacaHmY4iXZTcthERWoGwWoQ2e4IZD5dEDJNiyt90J7vtA3Tt/wxLFXeyTerB6
         mzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikxed9ftIIEGuIrrTPwALfN25nhmhnppGNOxa2EIxTs=;
        b=lkWBwIcz+pQnsSei49ulAa1gjPDC/WOPF8J7lIk5ILPjYbBh6xirSKSk92rhFaEeAR
         W/QuXB2ugbGySk7Q+x5sMvkdX8ODbyoPpcCaknYDqowhpV1w1KcZLH82ahEpXyvwzYiG
         oy6Papl+BT69B1OmpZKvF2Qg79l76Dk1Xh3L1ix03D+DWiIARHDAjZpp6pBLOpKUijcy
         Ajr7RQ/crd8sMVn4+XUmbDhk+aqogs4NZTuo9+jLN4E8c7Yc1bT4AqdbOuiEXQt27Kbl
         YhDDnMDg5bm5vUfgU5OYruKVoJoYy7fJphOeN8TquO0y5IazwsYEMJHRUCPr8dZo35/n
         T+3A==
X-Gm-Message-State: AO0yUKWUujfgAMLUn2bosJiQumOaobaPC0Yv+Qn/0zQzagAkDwELN8OX
        NVD8tmJtZRZUfN8bC5uRbbxy1yM1LVA=
X-Google-Smtp-Source: AK7set934gNuFGe9vlkIXBWxqtgfiD00+Q3+24ie7KCOBLbX0Va/v2FjMriqvM4Wg9Bqhjj1iRrTZQ==
X-Received: by 2002:a17:906:191:b0:889:3f95:3c3d with SMTP id 17-20020a170906019100b008893f953c3dmr22556898ejb.4.1675656994045;
        Sun, 05 Feb 2023 20:16:34 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:82aa:6335:699e:143f? ([2a00:1370:8182:1876:82aa:6335:699e:143f])
        by smtp.gmail.com with ESMTPSA id aa21-20020a170907355500b0088eb85e29c5sm4909710ejc.6.2023.02.05.20.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 20:16:33 -0800 (PST)
Message-ID: <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
Date:   Mon, 6 Feb 2023 07:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: back&forth send/receiving?
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
 <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
 <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.02.2023 06:07, Christoph Anton Mitterer wrote:
> On Sat, 2023-02-04 at 09:10 +0300, Andrei Borzenkov wrote:
>>> So one might have a setup, where a master is send/received to
>>> multiple
>>> copies of that like in:
>>>
>>> master-+-> copy1
>>>          |-> copy2
>>>          \-> copy3
>>>
>>> with those all being different storage mediums.
>>>
>>
>> Then you do not have incremental replication and your question is
>> moot.
>> Incremental btrfs send/recieve is possible only between the same pair
>> of
>> filesystems.
> 
> I don't quite get why this shouldn't be incremental backups.
> 
> Whenever the files on master have changed and a new snapshot is created
> on it, and the copies shall be synced with the current state of master,
> the new snapshot from that is send|receive(d) to the copies, using
> previous snapshots on them as -p parent.
> 

You stated that copies are on different media which means there is no 
previous snapshot to apply changes to. If I misunderstood you, then you 
need to explain what "all being on different mediums" means.

> 
> 
>> You seem to misunderstand how btrfs send/receive works. There is no
>> inherent relationship between copy1, copy2 etc nor between master and
>> copy1, copy2, ... As mentioned as each copy1, copy2, ... is on
>> separate
>> medium, each one is the complete copy of master and you can make new
>> complete copies as you need.
> 
> I rather believe that there was a misunderstanding of my setup
> respectively what I do :-)
> 
> 
> Cheers,
> Chris.

