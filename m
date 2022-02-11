Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC54B2C11
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 18:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352331AbiBKRug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 12:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352333AbiBKRuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 12:50:35 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49509CCC
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 09:50:33 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j14so13537317lja.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=R05HdrHwjd2wpdde4e5JI/WDixjyA+u2rHn+Iy4rgW0=;
        b=LEeKTLUNMYmzR1mcuCRJc6iWhCA7TvAmofZyCU6CEbdoZxUiNrK64wPXkVN8ags41n
         G2wB3eFxlXfBvTUrZBeA7fLa/r76QWFsVWPvFI4LMM0yQRf92wz80UnuQDBl8snBc3FA
         B7Wd6T+on7zewO+78O1FhSkKKxunRga0Om5/c1uo7bIuwiS0rlllxea2oJBbPu0F9uM6
         ub4JmbXXj4HjWUErj7r8Exf0MqyfTVcWIx1pO+qx1xLzQP2ZVdYEeDs+ui8Sl5Dfswmo
         gRKoVElxNdwUplznwUPh00WGE39vBkdcehPQ3STgOXg/6pKfJGLPzt+t0xt2/1pIZ+yU
         Vllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R05HdrHwjd2wpdde4e5JI/WDixjyA+u2rHn+Iy4rgW0=;
        b=BKbM1ROt0e43MmUHs5ZNo1qYyET631lKIwW3WkGvW9jgcSQk/aNXpVnqgtzRMvznnd
         PENxecVGb2a9uXLO9M0PHASK128CthcXHiZyuH0G7x3P7m/keu9d2wvA98Y7cGz19aKV
         2Hr3aD+ucFTVngG6YqieULTDhdN4UnfLNQE67vRywEEgSb8gMrnuGwARsHZPQF4/Luj4
         jItFNQAvPmhfcBioMHUGBpDzmc6BrDph5kZ/mIINKlJkGpFMmuvdFUSnDY6lTv9RkMBZ
         xAm+OxnE4gOzlqJ3Qky0XlL7ScFG9j+U2yCeal4RHCXMn0pxsm4NWkffmZBlp/1n0Ly/
         +rGg==
X-Gm-Message-State: AOAM531Xp18xe2ZhfUzHKF5OH/FuZ7p+jbA0eSlfpMggEOgU+46imtj8
        HKfPvvsK1h9JhfLC+zK/o70=
X-Google-Smtp-Source: ABdhPJzNPsXt4GrSn4il/FMw36WFSXoQh/09QdKoVyFQxPcMj00+0kmkfQOufo2SeDTzZq4OtSG4LQ==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr1636329ljj.215.1644601831493;
        Fri, 11 Feb 2022 09:50:31 -0800 (PST)
Received: from ?IPV6:2a00:1370:812d:59de:2181:1f23:e38:739a? ([2a00:1370:812d:59de:2181:1f23:e38:739a])
        by smtp.gmail.com with ESMTPSA id a5sm1211391lfl.179.2022.02.11.09.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:50:31 -0800 (PST)
Message-ID: <84ab21a7-877a-390c-0792-f7059fdb0e91@gmail.com>
Date:   Fri, 11 Feb 2022 20:50:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Used space twice as actually consumed
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
 <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
 <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
 <3a654f5d-e210-5c3e-4bcf-f0eae626cde2@gmx.com>
 <c75599fa-3b4e-5a5a-c695-75c99b315a06@gmail.com>
 <dbe39a73-9366-9f95-a3af-3dea7f1dd1ae@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <dbe39a73-9366-9f95-a3af-3dea7f1dd1ae@gmx.com>
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

On 11.02.2022 08:31, Qu Wenruo wrote:
> 
> 
> On 2022/2/11 13:02, Andrei Borzenkov wrote:
>> On 11.02.2022 07:48, Qu Wenruo wrote:
>> ...
>>>>>>
>>>>>> This apparently was once snapshot of root subvolume (52afd41d-c722-4e48-b020-5b95a2d6fd84).
>>>>>> There are more of them.
>>>>>>
>>>>>> Any chance those "invisible" trees continue to consume space? How can I remove them?
>>>>>
>>>>> They are being dropped in the background.
>>>>> You can wait for them to be completely dropped by using command "btrfs
>>>>> subvolume sync".
>>>>>
>>>>
>>>>
>>>> It returns immediately without waiting for anything
>>>>
>>>> bor@tw:~> sudo btrfs subvolume sync /
>>>>
>>>> bor@tw:~>
>>>>
>>>>
>>>> Also
>>>>
>>>> bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /
>>>>
>>>> 0 orphans left to clean
>>>>
>>>>
>>>>
>>>> btrfs check does not show any issues.
>>>
>>> There used to be a bug that some root doesn't get properly cleaned up.
>>>
>>> To be sure, please provide the following dump:
>>>
>>> # btrfs ins dump-tree -t root <device>
>>>
>>> Thanks,
>>> Qu
>>
>>
>> btrfs-progs v5.16
>>
> 
> There are two "ghost" subvolumes still there:
> 
> 	item 72 key (1331 ROOT_ITEM 82831) itemoff 6938 itemsize 439
> 		generation 87340 root_dirid 256 bytenr 8514846720 byte_limit 0
> bytes_used 313589760
> 		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0
> 		drop_progress key (0 UNKNOWN.0 0) drop_level 0
> 		level 2 generation_v2 87340
> 		uuid f2a928cf-d243-774b-b2bb-4e80e3d37bdf
> 		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
> 		received_uuid 00000000-0000-0000-0000-000000000000
> 		ctransid 82830 otransid 82831 stransid 0 rtransid 0
> 		ctime 1614330605.649484116 (2021-02-26 09:10:05)
> 		otime 1614330616.574128143 (2021-02-26 09:10:16)
> 		stime 0.0 (1970-01-01 00:00:00)
> 		rtime 0.0 (1970-01-01 00:00:00)
> 
> 
> 	item 73 key (1332 ROOT_ITEM 82904) itemoff 6499 itemsize 439
> 		generation 87340 root_dirid 256 bytenr 8515452928 byte_limit 0
> bytes_used 313589760
> 		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0
> 		drop_progress key (0 UNKNOWN.0 0) drop_level 0
> 		level 2 generation_v2 87340
> 		uuid b9125452-fb5d-e14d-a79e-2a967b992ea1
> 		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
> 		received_uuid 00000000-0000-0000-0000-000000000000
> 		ctransid 82904 otransid 82904 stransid 0 rtransid 0
> 		ctime 1614539496.823057032 (2021-02-28 19:11:36)
> 		otime 1614539499.212006544 (2021-02-28 19:11:39)
> 		stime 0.0 (1970-01-01 00:00:00)
> 		rtime 0.0 (1970-01-01 00:00:00)
> 
> Their timestamp should give an hint on which kernel is affected.
> 

This was likely 5.10.16 at this point.

> I remember I submitted some patches for btrfs-progs to detect such
> problem and even kernel patches to remove such ghost subvolumes.
> 
> But none of them seems get merged yet.
> 
> You can try the following patchset.
> 
> https://patchwork.kernel.org/project/linux-btrfs/cover/20210625071322.221780-1-wqu@suse.com/
> 
> Then btrfs-check should be able to report such problem and --repair
> should be able to fix it.
> 

This worked (and freed 11GiB). Thank you!
