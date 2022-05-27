Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0F536471
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352345AbiE0PAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbiE0PAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:00:05 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBD2657D
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 08:00:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AA3EF3FB3E;
        Fri, 27 May 2022 17:00:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.095
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1MD3Ud0vx6BN; Fri, 27 May 2022 17:00:00 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 084373F5A0;
        Fri, 27 May 2022 16:59:59 +0200 (CEST)
Received: from [192.168.0.10] (port=50425)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nubRW-000B8W-G6; Fri, 27 May 2022 16:59:59 +0200
Message-ID: <3b55058e-45c7-685e-433b-212d5eb45a42@tnonline.net>
Date:   Fri, 27 May 2022 16:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Forza <forza@tnonline.net>
Subject: Re: [RFC][PATCH][cp] btrfs, nocow and cp --reflink
Content-Language: en-GB
To:     =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, coreutils@gnu.org
Cc:     Matthew Warren <matthewwarren101010@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>
References: <d1ccc0de-90b0-30ab-6798-42913933dbb2@libero.it>
 <1b6a6413-963c-f612-7b1f-960190c3a323@draigBrady.com>
In-Reply-To: <1b6a6413-963c-f612-7b1f-960190c3a323@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-05-27 16:00, Pádraig Brady wrote:
> On 25/05/2022 18:05, Goffredo Baroncelli wrote:
>> Hi All,
>>
>> recently I discovered that BTRFS allow to reflink a file only if the 
>> flag FS_NOCOW_FL is the same on both source and destination.
>> In the end of this email I added a patch to "cp" to set the 
>> FS_NOCOW_FL flag according to the source.
>>
>> Even tough this works, I am wondering if this is the expected/the 
>> least surprise behavior by/for any user. This is the reason why this 
>> email is tagged as RFC.
>>
>> Without reflink, the default behavior is that the new file has the 
>> FS_NOCOW_FL flag set according to the parent directory; with this 
>> patch the flag would be the same as the source.
>>
>> I am not sure that this is the correct behviour without warning the 
>> user of this change.
>>
>> Another possibility, is to flip the NOCOW flag only if 
>> --reflink=always is passed.
>>
>> Thoughts ?
> 
> This flag corresponds to the 'C' chattr attribute,
> to allow users to explicitly disable CoW on certain files
> or files within certain dirs.
> 
> I don't think cp should be overriding that explicit config.  I.e.:
>    cp --reflink=auto => try reflink but fall back to normal copy
>    cp --reflink=always => try reflink and fail if not possible
> 
> We would need another option to bypass system config
> (like --reflink=force), however I don't think that's
> appropriate functionality for cp.
> 
> thanks,
> Pádraig

The solution is that 'cp' should set +C on the target file before 
appending data to it. I don't think that we need any additional mode, 
but the default should be that '--reflink=auto|always' sets the fsattrs 
in the correct order on the target file. This is important for other 
fsattrs as well, such as +i (immutable), +c (compress) and +m (nocompress).

There is thread from two years about about the same issue:
https://lists.gnu.org/archive/html/coreutils/2020-05/msg00014.html

There is also an existing bug report about this issue:
https://lists.gnu.org/r/bug-coreutils/2021-06/msg00003.html

Thanks,
Forza
