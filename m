Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7B70F160
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjEXIsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjEXIs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 04:48:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628E12B
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684918098; i=quwenruo.btrfs@gmx.com;
        bh=IIU4vxNS7iAeyBufDZK6T7ldTFJezz3znUfOdY/ta80=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=bTy/6Pp7CB5xMbeaeRpcvDE8JvVjU05QFiVUcbD8LCTGL0ydXq5nLHyoD+134TTGb
         RpvutKVCjrrRVCMpKD2drrpvlk2mqjkITvUDM5kUpUSDiCF+g2/jnxQE2321E5t/EA
         IwqnR86Aq/vbM3LGT2LahVUqWHw49RekjpFWsmPKkju8YYuWItPssPcNdLYWb5cgGZ
         De/kBawMMq6gbwRqnKocMmJ7qBYV0wuTQgPxFH556rSQQbeIELdpNAqTVbaVRvFoXJ
         5mslcM4QOv6/E25VG088L6uy/lkOV2p12ej4KQXrqXF0wd2wIHCUlEasXXvWtQUyo9
         n5w5ftzXde0tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGNC-1pjWGC0cZq-00JGAe; Wed, 24
 May 2023 10:48:18 +0200
Message-ID: <d718c810-104a-76ee-66bb-2cdf80c4d7f1@gmx.com>
Date:   Wed, 24 May 2023 16:48:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/7] btrfs-progs: tune: add resume support for csum
 conversion
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1684913599.git.wqu@suse.com>
 <838e827b-c0eb-0ed6-7414-c2aeef5a4298@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <838e827b-c0eb-0ed6-7414-c2aeef5a4298@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HY7weTmfiJAztytPk0F5Yyzmtqg+SRiUzPm9NwEUsnifYmY071p
 RnkXeUqiGIf0Q1BE9aSiVTlRZjJPstxe8UEGz3AxfGbKBJoGkKF1LXsf+S/0zSJBbVuMPQ3
 i1fs5dU69g624QvUTpLCoXQ0j1a00+Zztb2MWop32WKQJzyO1qN9sFuH8PX0Rt1TJa31J2t
 LvYF2w4g6xtbBO8/Y73ig==
UI-OutboundReport: notjunk:1;M01:P0:N63+bKFrKSU=;uoXXeYf5hd0syudlI3aIcusAAbz
 roOR+Jyd41oEY0beNV7kJEBj7zXX5kLFWQsR8n5qeyqYGQvCuR79pCBOoLvtuWLRiSyihEXZE
 PcLZHetC3SNKE5gRurx0GOSzAG1VeL7K9ddOUpa/xQUVJ6Yl9YXci3s9RgSEj61s7FQl7blan
 A1Arq7FQmkGhIHB/84s4pgRHQsznVVVofc0znDWlI5k8Ph3c1s9o4QtgU71Tul9QhTcTzjKxl
 xa6NeGXKBE+ns0kFelmF6PMwL18cYf69w7MK41kwS5icorDdQRwQSMarqUXU0JfY8998YPbEd
 my6f/kn5zezZ0Mn6b621aAHYqGLo2WRzWULDuYPsZiniBDczhb1GrGaRSs/0ER60keLnkk24N
 hOBOsC/LVP0CMJBt4Vv1XWMeIvckptYuH0UL1rhDJqfSHsxYMgvKFaC58a0GVJVku6ahf6y9/
 EfQuDDjaEb3Du/xND+2T4NsSIbDoohM7LzH3jSDzWHO7HUvKlANIIEcZsGvF7PxKRtkTF4bab
 xOGGe/3fIrFmcBDC6hjekwwPYWCifBQyHEY/jf1mLacchThZPKeVbd+OdyP2NcV9oPdl1SN7J
 +12n3gtBe6uSjj5lUAD6qf0AX8rWULPaEgUQLvKDXz9ssyGbsXOeOw6jsU4oBYIgrlu+AKUbq
 8puB2/ETsFb0NxAzasiGe/MjB7MpOcza1NCUYnVaL6000VMqJuBLprnXgGBYz+Ney1ex7nY9n
 F80hnUtALLnPlbDZ0y45gKIDSArdYkb4rjfrnal4M6Do1iBTgahAZprsbIMjX5FnizundekEP
 OxLGRhgQtBxEgreVuSDpoPGeoBIO0z4dXl9uJaWFVxbGT8g9RZqeDuo/jvpEjwSTyl2TPFzh6
 zlg/V2X7uqtB0lnsXub2hjXyLSXzN2i1MfBJtvj+L3Qgj610Vl2lIXqCozp4yGfaN4t396/xj
 T+C7lT3otwJVIQsE4DmwZOXp/uQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/24 16:42, Anand Jain wrote:
>
>
> Why not use the generation numbers "From" and "To" for converting
> to the new checksum and keeping track of the generation number of
> the most recent successful conversion?

Firstly, generation only makes sense for COW based operations (data csum
modification part), thus it doesn't work for metadata csum rewrite,
which happen in place.

Secondly, there is only one major generation number, and how do you
define "from" and "to"?

>
> Thanks, Anand
>
>
> On 24/05/2023 15:41, Qu Wenruo wrote:
>> [RESUME SUPPORT]
>> This patchset adds the resume support for "btrfstune --csum".
>>
>> The main part is in resume for data csum change, as we have 4 different
>> status during data csum conversion.
>>
>> Thankfully for data csum conversion, everything is protected by
>> metadata COW and we can detect the current status by the existence of
>> both old and new csum items, and their coverage.
>>
>> For resume of metadata conversion, there is nothing we can really do bu=
t
>> go through all the tree blocks and verify them against both new and old
>> csum type.
>>
>> [TESTING]
>> For the tests, currently errors are injected after every possible
>> transaction commit, and then resume from that interrupted status.
>> So far the patchset passes all above tests.
>>
>> But I'm not sure what's the better way to craft the test case.
>>
>> Should we go log-writes? Or use pre-built images?
>>
>> [TODO]
>> - Test cases for resume
>>
>> - Support for revert if errors are found
>> =C2=A0=C2=A0 If we hit data csum mismatch and can not repair from any c=
opy, then
>> =C2=A0=C2=A0 we should revert back to the old csum.
>>
>> - Support for pre-cautious metadata check
>> =C2=A0=C2=A0 We'd better read and very metadata before rewriting them.
>>
>> - Performance tuning
>> =C2=A0=C2=A0 We want to take a balance between too frequent commit tran=
saction
>> =C2=A0=C2=A0 and too large transaction.
>> =C2=A0=C2=A0 This is especially true for data csum objectid change and =
maybe
>> =C2=A0=C2=A0 old data csum deletion.
>>
>> - UI enhancement
>> =C2=A0=C2=A0 A btrfs-convert like UI would be better.
>>
>>
>> Qu Wenruo (7):
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for metadata c=
hecksum
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for generating=
 new data
>> =C2=A0=C2=A0=C2=A0=C2=A0 csum
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for csum tree =
without any
>> =C2=A0=C2=A0=C2=A0=C2=A0 new csum item
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for empty csum=
 tree
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for half delet=
ed old csums
>> =C2=A0=C2=A0 btrfs-progs: tune: implement resume support for data csum =
objectid
>> =C2=A0=C2=A0=C2=A0=C2=A0 change
>> =C2=A0=C2=A0 btrfs-progs: tune: reject csum change if the fs is already=
 using the
>> =C2=A0=C2=A0=C2=A0=C2=A0 target csum type
>>
>> =C2=A0 tune/change-csum.c | 461 +++++++++++++++++++++++++++++++++++++++=
+-----
>> =C2=A0 1 file changed, 418 insertions(+), 43 deletions(-)
>>
>
