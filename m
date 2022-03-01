Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241DC4C7F0B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 01:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiCAAOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiCAAOV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 19:14:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64157BC0C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646093613;
        bh=JoVwuy6phGn/v5+giYNCI7Aw+ThrsTNc7PEP+WWTX1c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A2QqqXCitGyE56ZyZ+I9V4rPbUOspkxs5VDZKbWA+8/ZywpJwWBNHr5I5LcQ0Ntsw
         uFXnf3YaIfuMFMzFKyC3PDFCH6eFbDbjpLuoPPaCPAFQtFjwQtE+hoJjB5InTWHpp5
         Q46A6sMB7asyI9fKi1GldqnqAiVq1xFEGwobAZME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1nQTlS3DXa-00H5Bl; Tue, 01
 Mar 2022 01:13:33 +0100
Message-ID: <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
Date:   Tue, 1 Mar 2022 08:13:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
 <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
 <20220228184050.GJ12643@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220228184050.GJ12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yfbu6yLRkR5Lr15xEFQkwayX1GI7kNWtgAyhoiV6TYwmfZq3GLj
 EAbMk5JA/spGF3bBymOjne4cMhpPKEJ8/FYHhU7uD2cr3Vk/X9pNzXhqNKcWyoepOnRVf72
 z4QRVRcyt7wevkOKGKaODnRS38gOAdqQJZxV7c0p7UwlEuF1jvIFhC5iay1ncxp8j4jaN7f
 fVTmkjjNKRr2WClheveIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S7lrn/Zlagg=:CZNgXV6P7+j4BdDblnsPej
 JXTsqQs5SjS918kIKmqw8ul5J5DgRBodAThIQ10tKF0gHAFJtap76y4O9VSGiSrGo0ypV5Ojg
 9rdtswP+pe3CItyBOqWwFWwdHCivBTUgfE7L2B+Rt0QwRyN0amVz9D2RGv67tjPuVO1OXRxTa
 /eBmbzGddRjrpU3y/pkl9kksWtwVlJamyXZuU5Z1hPyftjz0SvXRYXI4P26UhqBqke+emuB6o
 NKc1fEc5WUT1TrP+NEb4wMfTxoBW7y6aMIT2FgkJzT/B+J+3HGY2lblFoUFdwQjjjuTRaQ7Sh
 IXQdlqkQmAywIL3pvgC+YXwN8KVd1oXKEhVXGifJSm+NMd6TT+07IMViSSEtAplpe+xZuYeUb
 Z9DnJN3Jw1lzYYDgEawZXcCQxmt0AU4O8e8cAv12kwP53wqiQ+2PT76ilyeCNw1SMFWwqvGrQ
 dhRTxEaSasSQ3n6LWRPw28xsgk5bR5sl5/Pbt0Yeey1yYmcgV3i/daTfqsxGUZ4XFOqlDZ4z6
 3O65xb8qzVdazjiIffQG4uziVubyzqjK9hTXuZrmpHuVOsoEUJqxYM0BCd2tQGQOkkmkhHsu3
 lGvntC5AA8nUwbv8cGQLNJymNdnMGGkA5Jv2iYo0Mu46N5iBF0EQ9fwi+TUtsF5Pf9131TmL9
 7F6IaCTPTxe1nsBYodVoZ5ODtvkpNnk2M4+Rjv4ch1zqs8uOfjdVS20IduolyXfLICvVutkKk
 4vC5EQHjmiBYfU2pqHt31PSRW1BNfH3toHTwxNIxNx4JQ84YOQy9eKsFpeILGAR5jtvk05KtZ
 gCjiP5bFF1JWbfwUF5Ca+Ah7mKWAdWndhqaXkv6LJkchbi5InMl5lQ9g4U7pLdQCxOWSBMYSL
 G9A+bvqzEGI0Oz87ZxsM2+Zqrvr5Wu6WxgtqJO4IIlCFYpsfwCqX5fJUCTcNKmFaLoTZ8JZcl
 CvzNh5RLS0tiGX3lYEl8DUio8p3rs2RE0yv5OMOw5MtyOmfU2uJzI4C8qvDh1RhjrdkslNmrx
 4iqd/K+2XWw30t4V8fEJKwFUG+XhDf0pyaxuO7lroldecOFmE5RvHTn4vMq5/UAr5xdEtbMdq
 QXyDqnoch107H8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/1 02:40, David Sterba wrote:
> On Mon, Feb 28, 2022 at 11:27:16AM +0800, Qu Wenruo wrote:
>>> Ah. That's fine, IMO. It is a matter of understanding the nature of th=
e
>>> seed device. No?
>>> The RO mount used to turn into an RW mount after the device-add a long
>>> ago. It got changed without a trace.
>>
>> Think twice about this, have you every seen another fs allowing a RO
>> mount to be converted to RW without even remounting?
>
> There's no other filesystem with a remotely close feature so we can't
> follow an established pattern.
>
> The ro->rw transition can be done from inside the filesystem too and
> btrfs sort of does that in btrfs_mount, calling kern_mount.
>
>> Still think this doesn't provide any surprise to end users?
>
> The RO status means the filesystem does not support any write operations
> from the user perspective that go through VFS. Adding the device in the
> seed mode modifies the filesystem structures, ie. changes the block
> device, but does not change the VFS status regarding writability.  The
> read-write remount is mandatory to actually make use of the writable
> device. This is documented and I don't find it confusing from the end
> user perspective.
>
> If you're concerned that there's a write to the block device then yes,
> it's a bug that the mnt_set_write should be done just before we start
> any change operation.

I'm not concerned with that at all.

>
> There was a discussion some time ago if the log replay should happen on
> a read-only mount, or any potential repair action that could happen
> regardless of the ro/rw mount status. The conclusion was that it could
> happen, and guaranteeing no writes to the block device should be done
> externally eg. by blockdev --setro. But I think we opted not to do any
> writes anyway for btrfs.

My main concern is still there, we change RO to RW without any remount.

It's weird from the beginning, but we just accept that.

If we have chance to rethink this, would we still take the same path?
Other than making seed device into user space tool like mkfs?

THanks,
Qu
