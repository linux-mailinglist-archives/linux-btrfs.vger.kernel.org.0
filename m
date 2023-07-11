Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47A74FB22
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGKWn7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGKWn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 18:43:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82419E5F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689115431; x=1689720231; i=quwenruo.btrfs@gmx.com;
 bh=HLX9Q/dUtU7/I9lJVuzpz96mHLuaGzPDJxDyljmyQeo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ZEqLg9hZdJUBiVruRsOpumQ6/DhyTrM6TrNJY6BUWTjo9hv9u6kPf8vWKSJ0a8fFDn2T0yE
 dDLJ1WIvOMVx9yJ1za31nvbXmUVJazn97JL+cBmWyxAHYff0+O+tA5dIXMA39VNsgG6TDLCSO
 U9PP1XYQo6V8+OjyMz/nhRh3qRqbDM3h/1Wn3xwhfVmbNCaQ+GqwR9G/tplTpw2sabwMpYZxx
 hgXwst80oDc8H2Nyi5RCBr5PNTwpOXoqD38cIjB4/ANx/9E7oPxRYmwHXQS41QYpxE4sDt3IY
 MjMmghXnT7WBwbmXuayWyR3STZUwAEM8fpdJL5nG1yDbGoWZKSIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MirjY-1pnJ7i3Fcy-00exRw; Wed, 12
 Jul 2023 00:43:51 +0200
Message-ID: <cde5e7d1-1d19-80a8-876d-6af548f24b07@gmx.com>
Date:   Wed, 12 Jul 2023 06:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] btrfs: use write_extent_buffer() to implement
 write_extent_buffer_*id()
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689061099.git.wqu@suse.com>
 <e86267202871b02aad2359dc42aab05e96102aaa.1689061099.git.wqu@suse.com>
 <b0a7f7a2-1aca-836e-f59e-ffd55869c9d6@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b0a7f7a2-1aca-836e-f59e-ffd55869c9d6@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGq+lEwl4bAvNLbX956bUTgfsii3Xp0z/W69vhWkNoQjXKl6Yjp
 eZakFFl18YWpelnQPbIIm567HuVNXBL9dKsm+y1yRX3EjJyWpy4Dbjs5OlGLWQWiX8x/nlj
 DhIiVeA0VHiE56JH8RawcLSm/53EhvbVcv3piDGnTaUANoj0khpFnqYV3eTBYfw7ZnvWbr+
 a8gk2LlNhY/vQnRXwEJDw==
UI-OutboundReport: notjunk:1;M01:P0:shLRNqdB8Zg=;2LsfnVGsJt5nADkgfcPaJnLuyT7
 1QeLrqEfnpY2m57jfw/ga8c9UfLFrpAVmS1mB1zIv09KGOCRmB4O8SsCmoOGtPA0ziItBw+td
 H+UbSN3PtU+9MWPcjE8kJdQSNbilmeK9pA2L1Mmr4CLkzPuzZ8Oux0gs7IwZsrCjmj2O18U2w
 Dlq91I0+MI9zszgaFsoMDHWwlnOA/IhTrmEaCQAR9OCQFKFaG4hyCWqNO2wXh01EW6Hj2LTft
 oLMW1gNlRDwXJhw3TjV/CWrRL4o6JXPxgftbixcevRXqvIZMVvmup1FHkKiSzY/X/JjP/i//z
 Ay0v8koJ0sdT0QNhUshILn/rCK22/QWsxj8MjRq0lbLVQBjpjg80dnRBJaMVEpwjt/mOu0XpZ
 Sz8sFSCwhhwHwzxxzUWLE3GZevqIIjZbJCwTc9jtjallDnZwSOgk0cd4HL7jbXW4qELXOTEkE
 rwFgJeFP6Kq1/87kVZCk6TSwyXoLZWacIJ0oZY1Uaw2KyBsB45rw9x6DxBnpwKMNkFDtcKmHh
 EXfWeKH8ei6SLO9c/NrhpwN7+c4csb3HN+52D+od6aVvb65Q3VSiJb6vPYRTrOKTLjoBuquv9
 z90QQknXWYCVCXIwScvztsqFQPSd1T1dw1yQyS9jxF4gAAhvAP5unVMIBXRHSRybZIXHw11F0
 s62VhRPux3oTmKE0mbcYFOZDsFo2f6SQlrL1tkhD6ZLzO/ZwF2kEsWCt4pvHbQscAy/8MU6ds
 ynaKMOE9N+6WwbIHn42iUQGvtnMrX3dghhvd5TN+BAV8ughBGPgQ2/c46gyCMi5bbgIohTDcX
 RTybbIkkNt2IS0hayjfMkoT8gDoHdgNgGUZ83Tgmi3r9+9SML1ETRVBjGS3MWVAHDAZutgWTK
 AUNQFpu878dcWCNYmZ0XEoW3TuIp6ytHZIkCK70MQ1tyApkvUm/y8XCa0lY1Q1STFtTtYJuF7
 b+5FC7ujloTY2ovrVr5QmFgzmws=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/12 01:02, Sweet Tea Dorminy wrote:
>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 6a7abcbe6bec..fef5a7b6c60a 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4178,23 +4178,16 @@ static void assert_eb_page_uptodate(const
>> struct extent_buffer *eb,
>> =C2=A0 void write_extent_buffer_chunk_tree_uuid(const struct extent_buf=
fer
>> *eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *srcv=
)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 char *kaddr;
>> -
>> -=C2=A0=C2=A0=C2=A0 assert_eb_page_uptodate(eb, eb->pages[0]);
>> -=C2=A0=C2=A0=C2=A0 kaddr =3D page_address(eb->pages[0]) +
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_eb_offset_in_page(eb, o=
ffsetof(struct btrfs_header,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 chunk_tree_uuid));
>> -=C2=A0=C2=A0=C2=A0 memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
>> +=C2=A0=C2=A0=C2=A0 write_extent_buffer(eb, srcv,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 offsetof(struct btrfs_header, chunk_tree_uuid),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BTRFS_FSID_SIZE);
>> =C2=A0 }
>> =C2=A0 void write_extent_buffer_fsid(const struct extent_buffer *eb, co=
nst
>> void *srcv)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 char *kaddr;
>> -=C2=A0=C2=A0=C2=A0 assert_eb_page_uptodate(eb, eb->pages[0]);
>> -=C2=A0=C2=A0=C2=A0 kaddr =3D page_address(eb->pages[0]) +
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_eb_offset_in_page(eb, o=
ffsetof(struct btrfs_header, fsid));
>> -=C2=A0=C2=A0=C2=A0 memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
>> +=C2=A0=C2=A0=C2=A0 write_extent_buffer(eb, srcv, offsetof(struct btrfs=
_header, fsid),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BTRFS_FSID_SIZE);
>> =C2=A0 }
>> =C2=A0 void write_extent_buffer(const struct extent_buffer *eb, const v=
oid
>> *srcv,
>
> write_extent_buffer_chunk_tree_uuid() has only one caller in kernel now;
> perhaps inline the function into its only callsite? On the other hand,
> it has several more in -progs, so maybe the name is useful and it could
> be moved it into extent_io.h since it's such a thin wrapper around
> write_extent_buffer()?
>
> write_extent_buffer_fsid() has three in kernel and five in -progs, maybe
> also into the .h?

This sound very reasonable, would go this direction in the next update.

Thanks,
Qu
