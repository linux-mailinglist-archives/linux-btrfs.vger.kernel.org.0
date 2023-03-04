Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9111C6AAB92
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCDR0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Mar 2023 12:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDR0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Mar 2023 12:26:03 -0500
Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF21166A
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Mar 2023 09:25:56 -0800 (PST)
Received: from [192.168.1.27] ([84.220.128.202])
        by smtp-31.iol.local with ESMTPA
        id YVdppCOVCYJq3YVdppR2og; Sat, 04 Mar 2023 18:25:53 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1677950753; bh=WM02MeRpTbIcAkCcxGISE8YJA9kRGKIF8NnxZrFNY+A=;
        h=From;
        b=jDnSVsc4oEh54o4TyYhJzGHg59ruyjLGyeZ2/Ixu/Ch79SPb3wCzh6KRUTc+QjR/t
         VCbF6UPX+dFyHmXq2HlUVEJ6OhLEoGLWKyJHc5Q83t7Q/vSdAhrjRmcRmT/7spVYIQ
         QfSZBzO339QYc5Djwy9Q3owxDXLE9AqnP8IlqLZXv746O4JokojeWJPmy/l/FzcLrT
         rY6vPvPE4VbV6i9zhP1pwlmgeyluIatAdQ3jO7PgI0OOZ7JFmBh1buHuR8ad8yoEpS
         +zuOCRYGo+UoNKaZ++Sc2fCA70/fPyCA1u4ymaCFYvRrp9x1Gg6vKy2lSMwo8XWor2
         aeBz/XOjRCC+Q==
X-CNFS-Analysis: v=2.4 cv=Uvyldc8B c=1 sm=1 tr=0 ts=64037f21 cx=a_exe
 a=7XXxH8DXEs6J8bMFqK0LmA==:117 a=7XXxH8DXEs6J8bMFqK0LmA==:17
 a=IkcTkHD0fZMA:10 a=uDh0kDf35YVsM_A6zp4A:9 a=QEXdDO2ut3YA:10
Message-ID: <7fb5b1c3-92db-6ce3-b285-7358b1f779af@libero.it>
Date:   Sat, 4 Mar 2023 18:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: kreijack@inwind.it
Subject: Re: Salvaging the performance of a high-metadata filesystem
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Matt Corallo <blnxfsl@bluematt.me>,
        Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
 <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
 <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
 <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
 <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFhNXkA4+Ap0GjMS913HiTXAu7SMfrPD8w+6PKpFg2Gx0wCqBd3ngu/pxC9DIwxfbQraYSU7BbLD5pcGZJcOoT5X8BHR6XB7mMLAkGsxEo67IoRV52h7
 gr85yofM58lchZPjMtX2xHewgxRy+iICRsLsN1+Q5Put/laWwexQaA1gu2QO6INTB9sTwVn2u+NBruwy/JtuR8cewlobw/Cbx54/YsEeqX+FYysdqcdH9ZmZ
 8U3T4/n3p8dk8z12kXEoaLV7+o9a1LybEsdzwn/RxEzv6LaM/JNVdDzg4hXLLUih
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/03/2023 09.24, Forza wrote:
> 
> 
> On 2023-03-03 20:05, Matt Corallo wrote:

>>> btrfs filesystem usage -T /bigraid
>>> Overall:
>>>      Device size:         85.50TiB
>>>      Device allocated:         64.67TiB
>>>      Device unallocated:         20.83TiB
>>>      Device missing:            0.00B
>>>      Used:             63.03TiB
>>>      Free (estimated):         10.10TiB    (min: 5.92TiB)
>>>      Free (statfs, df):          6.30TiB
>>>      Data ratio:                 2.22
>>>      Metadata ratio:             3.00
>>>      Global reserve:        512.00MiB    (used: 48.00KiB)
>>>      Multiple profiles:              yes    (data)
>>>
>>>                                 Data     Data      Metadata  System
>>> Id Path                        RAID1    RAID1C3   RAID1C3   RAID1C4 Unallocated
>>> -- --------------------------- -------- --------- --------- -------- -----------
>>>   1 /dev/mapper/bigraid33_crypt  7.48TiB   3.73TiB 808.00GiB 32.00MiB     2.56TiB
>>>   2 /dev/mapper/bigraid36_crypt  6.22TiB   4.00GiB 689.00GiB -     2.20TiB
>>>   3 /dev/mapper/bigraid39_crypt  8.20TiB   3.36TiB 443.00GiB 32.00MiB     2.56TiB
>>>   4 /dev/mapper/bigraid37_crypt  3.64TiB   4.57TiB 152.00GiB 32.00MiB     2.56TiB
>>>   5 /dev/mapper/bigraid35_crypt  3.46TiB 367.00GiB 310.00GiB -     1.33TiB
>>>   6 /dev/mapper/bigraid38_crypt  3.71TiB   3.24TiB   1.40TiB 32.00MiB     2.56TiB
>>>   7 /dev/mapper/bigraid41_crypt  3.05TiB  25.00GiB 377.00GiB -     2.02TiB
>>>   8 /dev/mapper/bigraid20_crypt  6.66TiB   2.54TiB 322.00GiB -     5.03TiB
>>> -- --------------------------- -------- --------- --------- -------- -----------
>>>     Total                       21.21TiB   5.94TiB   1.48TiB 32.00MiB    20.83TiB
>>>     Used                        21.14TiB   5.46TiB   1.46TiB  4.70MiB
> 
> Not sure if running with multiple profiles will cause issues or slowness, but it might be good to try to convert the old raid1c3 data chunks into raid1 over time. You can use balance filters to minimise the work each run.
> 
> # btrfs balance start -dconvert=raid1,soft,limit=10 /bigraid

If I remember correctly BTRFS consider the highest redundancy profile as the default one. So having both raid1c3 and raid1 means that the new data is written as raid1c3.




-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

