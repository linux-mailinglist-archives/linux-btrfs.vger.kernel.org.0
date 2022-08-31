Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E55A7BA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 12:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiHaKr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 06:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiHaKrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 06:47:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465AC9276
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661942867;
        bh=T7qaXbnB5xQTCtdOxUQityyRSYCSZG1yvs5u0DjNScw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dfLZQXz5D+iYFlNtgfqkdzkExeYeyGdQQYgf7YMjygI1ic4FGY/sxE+ETT329aaed
         xISkJHUHD9ULXDpQrbMHlU2v+3pni4UcSU8p/+4OK9+HYhUP6GKuRIQMiG9+7LmX2a
         7u09NR3DSCfzBPPhal1xnNb+q/T10Cqx7X6/re+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1olX011818-00PqmI; Wed, 31
 Aug 2022 12:47:47 +0200
Message-ID: <fdf31228-c047-ea0f-be3c-0c6198301c0b@gmx.com>
Date:   Wed, 31 Aug 2022 18:47:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: free extent buffer after repairing wrong
 transid eb
Content-Language: en-US
To:     Su Yue <glass@fydeos.io>, linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
References: <20220830124752.45550-1-glass@fydeos.io>
 <bd6749cf-d04c-a26e-992b-a0f40a4461c5@gmx.com>
 <f47485f4-5d98-f4ed-b5f9-2cfb2bbe09db@fydeos.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f47485f4-5d98-f4ed-b5f9-2cfb2bbe09db@fydeos.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:94BjhGlbai2//6gIDvVhPtcyCQyjvH7Wun6JWUonXVAcUBXSvmf
 IDWTwoXJbxTgDV2jJZWXM1nuP9B7omylBmqkybKisxwPGCtKY14VlWpIILFFWQhdXAlklRi
 dbNC0uSwoD2U9irm5omNlTcwaCFCc2PtUX5K5Lre9oX03BuZxeEDGo8Ub/SpvBSx27E8+di
 QmhxBUw6oeNbmkmWla4rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Paot8NoJeGQ=:5bncJfexzMg/nP5koQddIz
 /8YKy1eoM7UG/XUBR9D/Ox1IYxX5Ey1Gs9xuyqlIoqmWJvfSdcVVHOWTaEtTGwr12B0YbEZkK
 EVk9FG6QlTrvzvr2kh1YF/875rl5QypTIQ9CdOYtmTMfWsMpyZzlcX+j4b7sMdE/Csydi+Nq3
 EOsUk3AVe2KkJy93I4m5sUeGUzfy//99qMoPH9fUfbYB6VMtORmfBaopXPlyfgH6+Yb2w/A6Q
 0li/+saR8b7SL9MzWG3usUHD0LfHGe10gR0eTIwq8N8+9uYI50GQPVjcERkQ4noQWcGZiIKSv
 gdEcRVWocLSNgZb5hCvooYXL/RH/NvK/CumA/Jp1ogkYvgXkIDrnBkmd/SmvXUYP4SRIN2en6
 C5KtoEKQ0kwLVM9yF2hCEMj5WyaSsGDUe0k7LUukDFoZYnauC+q8VMmAd4ArrPCsuoYKFYtr8
 VI1AXq0tgj9XPdWoLaxpXLqqsqHLTcX5lSNJlHHu/LQMAtjlFms96gM8Ethje46oP9Tjqtkcg
 iXokq93sZmxIMLiSBydqyCpf5j3owzeqjaTcAav+5Y/HDXoXTrKUteYUJlIbEG88MqJufJ5J8
 9gtYpBcM7xuAMm0jmtND9j1rYq8C0tfUxe/fM7Rzt6csMRBCNrJECw6L4y77t5DuXxDhunQ3a
 ql0lmJEu2gKhWBNAb4Ja16ICFtcQ7g+7u4h5Q7K/C/6iq4LXjy2B8p2l7wSRhXui+6UFhLCim
 DThXhecVaEpmrN72d2TlSFdhC6/npmdKoDH9l/T5MnoTMBO/eFbdkorAcNpO6RRqbwOrn9WEr
 XKn+C2VnujECI4d1pxgfOjlvulEYLiHrriboWMRWodeoQDWRdOSMeTrL1AytIuMPMSFGcsp4Y
 h8rk+jflNusiT4dvOqP58gFTFOw2bc4suPex7Y+th1Jby14J0Qx/TgzLXfeMDUp5Yfim4UjEm
 E05JPINFcY5yasW12EbVTZQrAWGxq+Ls21x5JSXcbrWlxhXHlDbwyLdOaSwHaQwL7K2ZmXwDT
 xGwODzMZB7csd+lTPQK+jl3yK5zN49CiUD6B+xT1/TsSeT52ImEyLHHQyt+i85d8vHvoBWV8K
 2u91Bdkvu/nlM7tjUgTqO5kpRlVkvi5WZ0x/d76nfstMwlyLnElRUAxsZIcbakbmUb37HvhBW
 dpEQqKyDswARWsTQswj3C7Ha8i
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 18:45, Su Yue wrote:
>
>
> On 2022/8/31 16:00, Qu Wenruo wrote:
>>
>>
>> On 2022/8/30 20:47, Su Yue wrote:
>>> In read_tree_block, extent buffer EXTENT_BAD_TRANSID flagged will
>>> be added into fs_info->recow_ebs with an increment of its refs.
>>>
>>> The corresponding free_extent_buffer should be called after we
>>> fix transid error by cowing extent buffer then remove them from
>>> fs_info->recow_ebs.
>>>
>>> Otherwise, extent buffers will be leaked as fsck-tests/002 reports:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =3D=3D=3D=3D=3D=3D RUN CHECK /root/btrfs-progs/btrfs check --repair --=
force
>>> ./default_case.img.restored
>>> parent transid verify failed on 29360128 wanted 9 found 755944791
>>> parent transid verify failed on 29360128 wanted 9 found 755944791
>>> parent transid verify failed on 29360128 wanted 9 found 755944791
>>> Ignoring transid failure
>>> [1/7] checking root items
>>> Fixed 0 roots.
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> extent buffer leak: start 29360128 len 4096
>>> enabling repair mode
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Fixes: c64485544baa ("Btrfs-progs: keep track of transid failures and
>>> fix them if possible")
>>> Signed-off-by: Su Yue <glass@fydeos.io>
>>
>> Great to fix the fsck/002 runs.
>>
>> Have you hit any other eb leaks? My extra noisy patch to crash progs
>> when eb leaks failed at fsck/002.
>>
> No other eb leaks found with your patches.

Awesome, and it looks like I should look into the problem more carefully
before claiming we have tons of eb leaks.

Thanks,
Qu
>
>> Not sure if there are any other remaining.
>
> At least `make tests` seems happy for now.
>
> --
> Su
>>
>> Thanks,
>> Qu
>>> ---
>>> =C2=A0 check/main.c | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/check/main.c b/check/main.c
>>> index 0ba38f73c0a4..0dd18d07ff5d 100644
>>> --- a/check/main.c
>>> +++ b/check/main.c
>>> @@ -10966,6 +10966,7 @@ static int cmd_check(const struct cmd_struct
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct extent_buffer, recow);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&=
eb->recow);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D recow_e=
xtent_buffer(root, eb);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_extent_buffer(eb);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err |=3D !!ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error("fails to fix transid errors");
