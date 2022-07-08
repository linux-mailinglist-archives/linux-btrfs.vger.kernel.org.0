Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD556BC1C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiGHPDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiGHPDW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 11:03:22 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4F5C97A
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 08:03:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C02F33F8DA;
        Fri,  8 Jul 2022 17:03:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TvKh-v1Lftqj; Fri,  8 Jul 2022 17:03:12 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 299523F52A;
        Fri,  8 Jul 2022 17:03:12 +0200 (CEST)
Received: from [192.168.0.10] (port=51908)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1o9pVf-000C6I-Np; Fri, 08 Jul 2022 17:03:11 +0200
Message-ID: <4e7b28c9-ad39-19cb-202e-f0efa1d501b5@tnonline.net>
Date:   Fri, 8 Jul 2022 17:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Cannot mount
Content-Language: en-GB
To:     =?UTF-8?B?xJDhuqF0IE5ndXnhu4Vu?= <snapeandcandy@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <CAGXSV6aseVoQJGOBDC7JoNUpW_8UfBxWgsg6ExPQUWajtUeu=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-07-08 14:18, Đạt Nguyễn wrote:
> Hi,
> 
> I have 2 drives in mirror mode in pc A (ubuntu 18.04 server). A
> mainboard problem occurred in pc A, then I attached those 2 drivers
> into pc B (ubuntu 20.04 desktop) but cannot mount them. Here is the
> information.
> 
> ~ ❯❯❯ uname -a
> Linux pc 5.13.0-52-generic #59~20.04.1-Ubuntu SMP Thu Jun 16 21:21:28
> UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
> ~ ❯❯❯ btrfs --version
> btrfs-progs v5.4.1
> ~ ❯❯❯ sudo btrfs fi show
> Label: 'data'  uuid: f6abe13d-a8da-4bf4-9a5c-402fec4a2bce
>      Total devices 2 FS bytes used 656.04GiB
>      devid    1 size 1.82TiB used 701.03GiB path /dev/sdb1
>      devid    2 size 3.62TiB used 701.03GiB path /dev/sda1
> 
> The dmesg log is in the attached file. Basically it just tell
> 
> [111997.422691] BTRFS info (device sdb1): flagging fs with big metadata feature
> [111997.422716] BTRFS error (device sdb1): open_ctree failed
> 

An important line was omitted:

[  576.780013] BTRFS error (device sdb1): device total_bytes should be 
at most 1963658838016 but found 2000397864960

What does `fdisk -l --bytes /dev/sdb` show?


> Please help me recover my data.
> 
> Thanks and regards.
> Dat
