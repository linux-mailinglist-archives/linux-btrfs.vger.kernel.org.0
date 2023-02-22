Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0B69ECC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 03:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBVCQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 21:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVCQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 21:16:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF72E0E3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 18:16:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1p0peZ2pNk-00YEHV; Wed, 22
 Feb 2023 03:15:48 +0100
Message-ID: <5a84db70-d60a-dd96-0fcd-7ae6fa18814d@gmx.com>
Date:   Wed, 22 Feb 2023 10:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: something in the last misc-next update made btrfs/261 fail
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
References: <Y/UvMqKqO1Wpy39l@infradead.org>
 <d4c6e5e2-023e-415f-0eb9-5086c43de816@gmx.com>
In-Reply-To: <d4c6e5e2-023e-415f-0eb9-5086c43de816@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yREb3+9KgFgnZ6B5S7Sw3hAl9eNLZTPaeOUszxJ0GlyGCaRHdfT
 R8PC/Tkq6ex77c1GgyHvC74tNnH/YEEnAywcLjXvBFU1W9nG9iIFILdEHx2xUU5vuQ1M8t3
 jRPH8J7uA6OjxEjdH81xAoOlP2iglRzy3l16wx+6+1g2/OVDjZDlt7/eOfNBJL9xpTAjRb8
 W1odRJ60R6LNwKKhcDySw==
UI-OutboundReport: notjunk:1;M01:P0:Xj+SMBTWUH0=;nTSsVk1P14cqGhr/HJwc1d2JluI
 7B/hs1j0BliHXZdWxWZb8ApTNIt1dNSfvMe+Txs22MEtJUkyU1TyP1FohvUtBgilNHPww1agg
 nD6gV4IZjtkrWD89aU46Tz6vX5a5Wut2nkv+FAId6L2rMlZvaPij6Qxab5OdcA0G8RRCvT6+h
 MWIE1X3125NvcQgw9oxv9DUfUiMSHlJzQrHeZhnu79f1g5zIJB7seWV0Ey1HohH1MtzoO0kSr
 BrpIyO+Y6I/7orameQkroKY9Hb8YzElXbfJ7ninVB1rPJpFj1hLGBvJkOdrAPgh/6euSdZDNg
 i/Fq4y7vb+UW9XdskEGUVTh/zWIHQsQ0ZSf3j6xbZiEQx4liPfCMCQDpTOUsP4cxl9DhB2ZpL
 OyJYlnErnVSt/vo63dJkVwCBeJj2lGYsa4ipFSz5MfWHfsMv7d/sEPtvi4Eqi6jbb0rew/KwR
 X1obJrnGAgti3CATC9MKny3Gg10aw7RuA2+MiG6uJSdb35j+HKB9HsH+t+jhpZb07SKqUEku2
 p0GQp/gKwQoXsAvCTKg2GoFTiHha6/v+3sG4nVtphCYCOcCaZGhQw7iHaeBrF//bCPU87SeKy
 9PSRvTZ7PhxkCIi+hsFRBTDqrUJdg4puoOYbySV/YV6cB/UtsK7zVUR0ESdyb/N4ndE4qyLs/
 AIVdDP1BCoPuMuUvDABsrD/0L88f48GL3xZsQyXHjG3yo6CoLVcAONjx+WDWKsbP/Ne/HtPSX
 U/DcaUwFcmxc3cCSq6bl+WBmDz7jspVYTiHxcYUlB5aN1zk0RgInEC84wLdjE598Nq+OVTCQV
 Hr5FEh+K+HTm4gvxAY93QrCXS/hznBVR4r7FEsIj2mzH5LJdQD6GLSscOb/Ar0oOICCuxkfhr
 eLsYCX7JAwLOSPwcQaWTcmKdCmWZC4/SgRYSaBqRiEoOjZLmKUmHmRoS0G307l+Cu1RRuPiiA
 HFIHielZe49a16m78sdp4MgumqU=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/22 08:25, Qu Wenruo wrote:
> 
> 
> On 2023/2/22 04:53, Christoph Hellwig wrote:
>>
>> --- tests/btrfs/261.out    2022-08-23 16:09:54.526648628 +0000
>> +++ results/btrfs/261.out.bad    2023-02-21 20:50:17.796750095 +0000
>> @@ -1,2 +1,6 @@
>>   QA output created by 261
>> +ERROR: there are uncorrectable errors
>> +scrub failed to fix the fs for profile -m raid5 -d raid5
>> +ERROR: there are uncorrectable errors
>> +scrub failed to fix the fs for profile -m raid6 -d raid6
>>   Silence is golden
>>
> 
> Also confirmed here.
> 
> Bisecting.

It's the commit "btrfs: replace btrfs_io_context::raid_map with a fixed 
u64 value".

Still looking into the code, but no obvious clue.

Would do more debugging on this.

Thanks for the report,
Qu
> 
> Thanks,
> Qu
