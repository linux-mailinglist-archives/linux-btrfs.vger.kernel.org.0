Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE84C9AD7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 03:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiCBCCQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 21:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiCBCCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 21:02:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491AA4187
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 18:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646186491;
        bh=SeOPNEUT1MHPWpJ1AdVQy+75mnAFZnKQafGS4Yckg8c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=K8BUY+7aX2r67GEyVwsoVtb/Ud7iY37R07d15EvRJ8O4ukT4SmKzUhyhtmgnnIafB
         4X1tPv2pgogGvu5J0QvB44aycxQtbpsqPrmVD4HZWWLs75RbCVzIVj1oJ3egvcoWyi
         B9tuaZsI5TcNmknm4CQLtaR058jE8ktXQOzYTwWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAOJP-1nVZon1P7T-00BsTw; Wed, 02
 Mar 2022 03:01:31 +0100
Message-ID: <762abedd-dc50-93c7-7cef-caa1d4625a64@gmx.com>
Date:   Wed, 2 Mar 2022 10:01:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
 <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
 <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
 <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
 <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
 <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
 <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
 <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
 <9049B0C3-5A30-4824-BCED-61AA9AC128E5@scientia.org>
 <66d31354-a6d1-01a0-3674-c4976bd7d557@suse.com>
 <9d4f9c353ffe8a5b0fec426df7bf056904ddf712.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9d4f9c353ffe8a5b0fec426df7bf056904ddf712.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:isRRGsnKy5iV+cxoC3wzQU8C1ehgPasI3zA+tzm++geHNHIspq3
 1JimASQjsm/PxPLijSRT5UxfTkSZsbTEZR3fk9h0qHv7T3yDPlMhe4ULXonUg7V+3/w4V0A
 ccYibG1VA5KGLkkOPLo7gefPbV9+LU4onaCmTz+LL2sLGxLk/UHPibOU5pq0mB+iqFgXuHY
 +0JjZfJVaLBnMrcyqKqOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IVuKEYbF8m8=:MzZWhOkFQXSh/gA7Of3beR
 7LF8H0mh6zSZVmPWlHgSIsI1pprJtPnN+is3ab90OFPreqk/S3XWctyRPKNthMIkHhQTjdFsE
 ZWFMjV1wRb8ucAyeVQwZSkaGAVKJkiu461kyzIB8hPWoq1T1Ht6N1Nq8zo3IsPgdX7OZbozLU
 aHDx8vsU44hcVI3icPKJ/deabdzERmEAwsM4i1bIDd71twt/CrnxXuPNSaIgJZw5pULMPZISq
 XB0Wtw2pDFTr8Ysk9uid3Nf6D4gTdtVInG8khVlSb/IUqRGALR6cXDsP2RpvGWrSYmCUyhQgB
 vWb5d0W+gBbSeepUdhJLZEtsQLOOaeo9wjijK+MekBtXCevUJglpQQ+/+4fvpUYCAoXDWsmGU
 482n3/LpKbCR+QsnTM87D6H44CuEIeDvFt1/FrNvbCHhdGaRTEcwv5WqFzSgXHzhQSs7YeFzD
 0dn4WT3MhsCskzcjzfIHGM/VHNWXC5xlIo9+0tCvzejhiq5k/1ROjLdnYiX2Ja5N6J4RG9uj+
 aLqSEUV2kjrIEsHJQ7DIfULVosQSofx1D5XrBJlcrH48A/5wc1x/431hbUf9+OpW6gLUxY/ry
 c77C7IIdl/SoiglkyEsxzGRvjOPT/I5Diwb4DqQVgad6TUR3ttXzS3j4Bus/zNgBdHAxVBVRL
 sfFc43AD5jd0l3GnyyKHIi2/Fdtt3yoSy5sNmDub2FdZCDgq2NoHD46VV2XnqreNiFahyKEJw
 R4ZF4xR26Ljfevc2yxsHodhz3dTAquGRI5TSThrnjR8JDG8HU2mDnr6LsYhCMtsbC0MNT3D4w
 QxVCzrQe4CCPBtxBvDqfGeVubCGOaCbgDS5HnQP5BYxMmJPXSFMHfIUUSqT5+ZhkbaLlbpq7i
 8pGiVYF9V0FeeLUrA8H8k8RmL87tqDocjj6nRR5iqkZ7t+Tej5gyXJIomGlYVuSTm6TjBdM0f
 v/zt28UwoNFeRuCwKBOn8gCAFLlezHyfsUAjh0LVPB/1eP1shRUoNCwMM4sf7Lo01lCPptY5G
 CMmXOmcpAAmD74GgNwQOKXUsJHuqjMkd22a7oE3DBWmhTqYFp4NBoNbSOr2x5Wcpb2qdrjoie
 BEscB0lHZKD7hk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/2 09:38, Christoph Anton Mitterer wrote:
> On Tue, 2022-03-01 at 10:30 +0800, Qu Wenruo wrote:
>> In that case we should do a tree search and locate that tree block.
>
> ... and ...
>
>> Anyway, I need more investigate to be sure on how this happened
>> without
>> triggering scrub, and find a way to make btrfs a more robust
>> memtester :)
>
> ... still anything needed to do from my side here? Or is that something
> you just meant for your todo list? Cause then I'd recreate the fs in
> the next days.

Please go ahead, I think I have got all I need.
>
>
> btw: I tried:
> # btrfs inspect-internal logical-resolve -P 1382301696 /
> ERROR: logical ino ioctl: No such file or directory

That bytenr belongs to a btree block, thus internal resolve will return
-ENOENT.

Thanks,
Qu
>
> but that fails.
>
>
> Cheers,
> Chris
