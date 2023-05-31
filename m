Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BE717382
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjEaCIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjEaCIn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 22:08:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E3124
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 19:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685498910; x=1686103710; i=quwenruo.btrfs@gmx.com;
 bh=KNwAHudWpe1PHhAuMYIhDxLKpUd0RLsd5z/WVTwoRgU=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=TIWUm1nsleurQiq/jMG6QY41bSjTwXuY/0ZN6esLLveK2j4seUYaGHpowM49P03fsxkOeT+
 ayjJ6LGhJOxdm3F3LKErK5prrNL6vtKOnuOLIa7Jp0jznEMnG9CQI6v5/VeJFuF9l6a7DfaIE
 ZFKhCFQgnlSmKYMQemb+Uia+ZgxLlUl+b94hafCrccfLiXjS/vpz1nZ585V3zbIEP1NDA0l8o
 DAc42py9KqEeP3JTgHmricSxFJjSdoPa50YoxOdUQCXHCjnZUQSlPJADH5H/HWRUE+fqjeUfX
 XBtxIH3J5GWZ58k4Vt6jvYwac215PRXcK+Y/rTcFmpzYYhI0+i2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1qQZ3D2KdC-00qVYR; Wed, 31
 May 2023 04:08:30 +0200
Message-ID: <48115fe9-e181-9045-3d10-e1549e67478d@gmx.com>
Date:   Wed, 31 May 2023 10:08:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
 <9ffdb317-e679-0fb9-4181-c40526d7668d@gmx.com>
In-Reply-To: <9ffdb317-e679-0fb9-4181-c40526d7668d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yy38ia0M9t8wfF9RXPP1WHJQe6HC8e8um1m5WLQYyfWrK9p07xw
 btFKMX3KYEG0DHAOBVV9hKc6vI2CyD89qnJmaDyN4CIOrfPXRtC2G6BLZvfQhaIJuAxXtGE
 eMwUZRcCSpHsmIj169iAxDMKdsMUS0NLTbVuRBvxNiXUu7BCJtqEsWJgIZNC/7URujKyJZ7
 Hx1sfOEq4a0lpwFNAhkgw==
UI-OutboundReport: notjunk:1;M01:P0:RNCzrjIbMPk=;7/LWEYNlkNZDAVP7uLExBY45F7r
 DJylP5zAv0OR+XrueaZnU8PJidYM65uRXGT+9+LH6TNc5/rwP5zkqkwgKD28jrJBfde5fjSIo
 RZbDE0z8vubn99f5yetaXEd42is1O7tHKM5EZUNKWL+FFTe5iegjHbGGukSFl1WuwSX3QfIiw
 Stk6zsKlGLaix+CU436k02FW/ZQmvv0qGqyQVOQ4jyWJD4Bt0EFlvYWfdhzEXNU8krpndqD5O
 b1NfSYv0ZvBaU+oOC/PM2hW7bafQ4C71QPnqFlFjbf4NONo5C8FaaH09D4sI0OOHNij1VJkqV
 8K7iIA+b6x70Lkter8/iSGeotChXIkrSu+jQ+ZpO56lI682juMolnCGRMe/XJT2PU3gdwdclk
 /nPK5gpw1yRAZmlzZ0erVNOY90JmGN+4FrauL75L7nDGJhFvfkSUXFSJ3FfJowE3nFSt87Jz5
 +0tATZkjUHhmyow9D7InAnKZXEXls+41GcahKh+0B26J+yIo7zj/nxDu2BiB/eHhDPPGD0pCY
 xwufTV8WL6egiXpb5QKN7J65AnQH5AAKnFY7xyxCL8MRnY3ukwiIPJ0Ke+UswKQb44DZh4LCR
 zZaqQLcijaiz5nkWJSSKaNU1DxhTWJ3FI78BTz62RWjBqKRqVk/bBpFhYKSXnGLLZu+QCFH6G
 RyS10AARI8CRgi8CxfdbR5kEgzmHEqnvx2YB9Q6i8Tzu0CRRSdnpHtrwFJA6P3qxTBO+NJkiP
 AepOnf6dtY9XP/Z0ATWuSghqY9PRfXb9yG62cQ8hi+3nSkli+iIPvSKRnTnvVFl1XYVjEH4W9
 GYWTnQ0PX1xMd9qmHzsndxLejzG9DKwx6SuxF7y309t34mlkzCKdG0TwnrrN14NHRMJvULfSZ
 ws2skRvfk63vR9DI2xHIUAOFWZzascZN2P+ewRjK2x0ORk26hfu5kFdpV8LRCla6BMfNh+KEA
 j3wdoJmMSpdpoC9x4KHlaBPZDQ4=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 08:01, Qu Wenruo wrote:
>
>
> On 2023/5/30 18:15, Anand Jain wrote:
>> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
>> print-tree.c, as it is currently missing in the dump-super output, whic=
h
>> was too confusing.
>>
>> Before:
>> flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1000000001
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( WR=
ITTEN )

But my concern is, why we didn't show something like " | Unknown flags
..." in the first place?

Isn't this a bug already?

Thanks,
Qu
>>
>> After:
>> flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1000000001
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( WR=
ITTEN |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CHANGING_FSID_V2 )
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>
> The patch itself looks fine.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>> ---
>> =C2=A0 kernel-shared/print-tree.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>> index aaaf58ae2e0f..623f192aaefc 100644
>> --- a/kernel-shared/print-tree.c
>> +++ b/kernel-shared/print-tree.c
>> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry
>> super_flags_array[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_HEADER_FLAG_ENTRY(WRITTEN),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_HEADER_FLAG_ENTRY(RELOC),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
>> +=C2=A0=C2=A0=C2=A0 DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_SUPER_FLAG_ENTRY(SEEDING),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_SUPER_FLAG_ENTRY(METADUMP),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
