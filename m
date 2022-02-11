Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3C4B1D6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 05:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiBKEpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 23:45:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBKEpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 23:45:40 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5F21AE
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 20:45:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t14so10912853ljh.8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 20:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tuhjeyCfGGnDd+kvQUXUoEnV0Nvxp3McK7eEKDfOE4M=;
        b=mE4T/8Yt6OAvHapIf9+54fff2CzV4ClCFGTTzLiibPUPaDMn7r+fDNCGLg2Cv1NtoU
         OIl9jxI+afoS7VdOLIRBPhc0toVCINmNaG5jJyAszl2bGx++lQm/E1VSb9QyDrMwqNdQ
         Q5wyPpicFQmcJyRZIP0utUMT7ye4SyvBt3FnEt0tniCIGzgYbB9/khaLRl3JVQtFGrMu
         uTXtmgiwBAgJjHiB1/Q9b8s05+FhQT62lAffO51/1LxMZk1WtuHf5yc38iRhdJIEJJkt
         2bY64Tg5HqptM/PwhRXUmt1H+dMp8+OK9/YWR9P3H3ozsS5kyyoasfIpJXYnMrHBdRhK
         oI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tuhjeyCfGGnDd+kvQUXUoEnV0Nvxp3McK7eEKDfOE4M=;
        b=Krx4Biw8Q8sRkjWmeAdtZ7Yt+g7mW26SjVQWgcOhEbFYzjdejJOiZaY/T2V2DUNfya
         1F6gtiOpW/ut2ywZjOecYF39PYnJ8WH6eLK/P87BQxTPbTQwrAOif5gpwjR42/k23pGc
         tAqzmccbo5Fd1mUJg/sfHeI0BqxQVU7TsQEj5iGq3A2CLk6DfuCvsNai3MwUQ1kg5oLa
         BIPSEx2n5oPJMZcwo4NVH91SELOdzlhKmbQSDsVEv293ebZaAmwEV3hSFW7twIDvScL/
         ou80kIYdLh9D++DkCVP28A36Y2vtlLbJYdcfqaBDdykrZvcN9EWcNIIyITegUxzIgOYq
         Ic2g==
X-Gm-Message-State: AOAM532GadS3ORIi14DjMqGCELzmZKeME1EZPDIyeq3dh3lmo5VhuIGw
        qGe13B5P6X3zFN48N0vU0Wo=
X-Google-Smtp-Source: ABdhPJwJcPf8y0s7N4WBOefXKeEup4WZbBMMMh6kg9seDRdwF4lFksqnhRZm6r9u4gqkpmatnvNPvQ==
X-Received: by 2002:a2e:8008:: with SMTP id j8mr7084192ljg.365.1644554737734;
        Thu, 10 Feb 2022 20:45:37 -0800 (PST)
Received: from ?IPV6:2a00:1370:812d:59de:2181:1f23:e38:739a? ([2a00:1370:812d:59de:2181:1f23:e38:739a])
        by smtp.gmail.com with ESMTPSA id y11sm3059935ljj.122.2022.02.10.20.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 20:45:37 -0800 (PST)
Message-ID: <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
Date:   Fri, 11 Feb 2022 07:45:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Used space twice as actually consumed
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
 <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
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

On 11.02.2022 03:12, Qu Wenruo wrote:
> 
> 
> On 2022/2/11 02:54, Andrei Borzenkov wrote:
>> I am at a loss.
>>
>> bor@tw:~> uname -a
>>
>> Linux tw 5.16.4-1-default #1 SMP PREEMPT Sat Jan 29 12:57:02 UTC 2022 (b146677) x86_64 x86_64 x86_64 GNU/Linux
>>
>>
>> opnSUSE Tumbleweed.
>>
>>
>> bor@tw:~> sudo btrfs fi us -T /
>>
>> [sudo] password for root:
>>
>> Overall:
>>
>>      Device size:		  38.91GiB
>>
>>      Device allocated:		  38.91GiB
>>
>>      Device unallocated:		   1.00MiB
>>
>>      Device missing:		     0.00B
>>
>>      Used:			  23.91GiB
>>
>>      Free (estimated):		  13.14GiB	(min: 13.14GiB)
>>
>>      Free (statfs, df):		  13.14GiB
>>
>>      Data ratio:			      1.00
>>
>>      Metadata ratio:		      2.00
>>
>>      Global reserve:		  85.95MiB	(used: 0.00B)
>>
>>      Multiple profiles:		        no
>>
>>
>>
>>               Data     Metadata  System
>>
>> Id Path      single   DUP       DUP      Unallocated
>>
>> -- --------- -------- --------- -------- -----------
>>
>>   1 /dev/vda2 35.34GiB   3.51GiB 64.00MiB     1.00MiB
>>
>> -- --------- -------- --------- -------- -----------
>>
>>     Total     35.34GiB   1.75GiB 32.00MiB     1.00MiB
>>
>>     Used      22.19GiB 877.94MiB 16.00KiB
>>
>> bor@tw:~>
>>
>>
>> Well, that's wrong for all I can tell.
>>
>> bor@tw:~> sudo btrfs qgroup show /
>>
>> qgroupid         rfer         excl
>>
>> --------         ----         ----
>>
>> 0/5          16.00KiB     16.00KiB
>>
>> 0/257        16.00KiB     16.00KiB
>>
>> 0/258        16.00KiB     16.00KiB
>>
>> 0/259         9.04GiB      8.92GiB
>>
>> 0/260         2.69MiB      2.69MiB
>>
>> 0/261        16.00KiB     16.00KiB
>>
>> 0/262       708.24MiB    708.24MiB
>>
>> 0/263        16.00KiB     16.00KiB
>>
>> 0/264        16.00KiB     16.00KiB
>>
>> 0/265        16.00KiB     16.00KiB
>>
>> 0/266        16.00KiB     16.00KiB
>>
>> 0/1411        2.12GiB      1.91GiB
>>
>> bor@tw:~>
>>
>>
>> So it is about 11GiB in all subvolumes. Still btrfs claims 22GiB are used.
>>
>> There are no snapshots (currently). There is single root subvolume which
>> is 259. All snapshots have been removed.
>>
>> bor@tw:~> sudo btrfs sub li -u /
>>
>> ID 257 gen 96090 top level 5 uuid 257f04e8-e972-1a42-956f-1252b88713a4 path @
>>
>> ID 258 gen 120221 top level 257 uuid 2b9cfacf-5c3d-924e-90e6-8f01818df659 path @/.snapshots
>>
>> ID 259 gen 120339 top level 258 uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84 path @/.snapshots/1/snapshot
>>
>> ID 260 gen 120221 top level 257 uuid 40812ba2-102c-ae42-bf07-2b51e531d923 path @/boot/grub2/i386-pc
>>
>> ID 261 gen 120221 top level 257 uuid 9105e591-b3d9-a84a-93e9-6902fd78897b path @/boot/grub2/x86_64-efi
>>
>> ID 262 gen 120339 top level 257 uuid be0f25f1-8505-7a4d-87bf-29bcb06ce55c path @/home
>>
>> ID 263 gen 120186 top level 257 uuid e95e8fd5-5bc0-e94a-bc56-c355357479dc path @/opt
>>
>> ID 264 gen 120221 top level 257 uuid 4b0f5496-dc32-9d43-a36c-333b18b9370c path @/srv
>>
>> ID 265 gen 120331 top level 257 uuid d658c9bd-dbe2-e842-9e31-c943119b725f path @/tmp
>>
>> ID 266 gen 120221 top level 257 uuid 71717a12-5b0c-8240-9ef4-907586ed935c path @/usr/local
>>
>> ID 1411 gen 120340 top level 257 uuid f5f4dae5-fdbc-9141-8fba-83e95b9ea132 path @/var
>>
>> bor@tw:~>
>>
>>
>>
>>
>>
>>
>> Any idea what's going on and where to look? I seem to have strange roots
>> that are not visible as subvolumes, like
>>
>>          item 71 key (1329 ROOT_ITEM 81748) itemoff 7377 itemsize 439
>>
>>                  generation 81749 root_dirid 256 bytenr 70449102848 byte_limit 0 bytes_used 313655296
>>
>>                  last_snapshot 81748 flags 0x1000000000001(RDONLY) refs 0
>>
>>                  drop_progress key (9414435 INODE_ITEM 0) drop_level 1
> 
> This subvolume is still being dropped, thus it still takes up some space.
> 
> I believe There are similar subvolumes waiting to be dropped, thus they
> may be the reason they are taking up the extra space.
> 
>>
>>                  level 2 generation_v2 81749
>>
>>                  uuid 2c5e44c6-cb4d-1b4f-a3f0-df1ee3509f47
>>
>>                  parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
>>
>>                  received_uuid 00000000-0000-0000-0000-000000000000
>>
>>                  ctransid 81748 otransid 81748 stransid 0 rtransid 0
>>
>>                  ctime 1614326844.216735782 (2021-02-26 11:07:24)
>>
>>                  otime 1614326844.284742808 (2021-02-26 11:07:24)
>>
>>                  stime 0.0 (1970-01-01 03:00:00)
>>
>>                  rtime 0.0 (1970-01-01 03:00:00)
>>
>>
>> This apparently was once snapshot of root subvolume (52afd41d-c722-4e48-b020-5b95a2d6fd84).
>> There are more of them.
>>
>> Any chance those "invisible" trees continue to consume space? How can I remove them?
> 
> They are being dropped in the background.
> You can wait for them to be completely dropped by using command "btrfs
> subvolume sync".
> 


It returns immediately without waiting for anything

bor@tw:~> sudo btrfs subvolume sync /

bor@tw:~> 


Also 

bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /

0 orphans left to clean



btrfs check does not show any issues.
