Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEE5FE5D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 01:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMXOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 19:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMXOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 19:14:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616516D8A9
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665702862;
        bh=SnSGjDqt7gdgrBU8kMyKiJg2+8fBXFuxbCE4RlHSdU0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=O8k1/xwonDv6d6xBiVwpw+DSQCDIdlRnKEpLFEqlePHtHLokwHdM7vx0zPmFjGpxk
         1qnwyPIPQK3XulrTtGx1Y/ZrF9v4XREhacIfnokdmst2BfZVyGdoSubZ4/ffB63aOO
         f7+0vmx23OI0RRkajM7Bj4u8Rq96dMQYrfBi4Za4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybGX-1p4CSe2jLZ-00z1Gs; Fri, 14
 Oct 2022 01:14:22 +0200
Message-ID: <96de6625-fb23-b44b-b4ab-9aae52ab70c3@gmx.com>
Date:   Fri, 14 Oct 2022 07:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <63038e02-81fc-92b7-4e33-0a2c6c356698@oracle.com>
 <a2633456-dd2f-534c-6505-fa4c8121f3e5@gmx.com>
 <65b15910-fe1a-b6d7-2431-4badcfa0b134@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <65b15910-fe1a-b6d7-2431-4badcfa0b134@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKoa17I/6rD6M0fBPJuY4TWc0rb6jFjbWqnJykmLuvfeH0n6iE9
 Dj+WPX+4rsxnigsar57yA0xmNVE9dRPGh1pDLrS8w64uPFmz0/HSS5kPEm7AE3sbI6Y0WIP
 q7FsLJ/JFLw0DOuofG1QeyL/lIMJ1wvDB2LJCH0Zn2EHHZjDVOnxtHpGNXnfZRT+NwU7gh1
 xJCOVtxHw76u/fckFcGtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L6q74i2BLOI=:Yc7KP8sBKWnZbwKQXtyegv
 UdXJNruO/FdQyAr3sB770M1oELfZ7JtFuDfYTai72Iqe3l7V+UDWxkPwKVT406p1YTBOgbr/A
 NScd4UkZhsO2aqbu9DUUC5pPWCX7/wKXlfavxUoAg+H4D1i9SLsCnwPBT2NGRTtAmmzZ5ox5J
 yp1LzpOpACBD/EjcYLA77C3e4vwpTO4EBXwTqjtR/fLQ6Nqvu1LeOStjjXHcMWRti0m+tc09G
 9nwx2GCdVjc5qarRdSbet0lnthYDxWbHYcvawk4BT+pf7kwX3orHwr9opgWietYIwZn7FYpXc
 OAbwm7kxi6UPTe8bLlrew1sjSclhbcSqGYBPrpzb+LTIwxH54Fy39SCJJYPhLKEP5eomzaDR+
 HDkCgFgy93jSBq+6uKfPasGdlqfbBqhn45oD/hucpys8FKhr7CW1hV9SBxCyecGTcLlVorz4h
 BbqFB08wfp0LvVPpWa/qYou9f4/Lnik0F1JTj0lW6HLDi9buzI3qM90gLuHP5J+H9zeqCE5og
 VCvklrJ57GEx6JT3JjlqDltnuHoJ8YJw8Ge+TtweT57lBScNjmzs3/amltx9HbO6SBMUopo8n
 k9EfxoC6rWIhN9UCitsFCxpgsXs02DGk1DYDp2YbuwjBaE6eLqykZYC4/Jv/LetIFVyy3Wcrn
 JiUvwAJ3DrzJup7rJNAc1hGcO0rIHg3Ibd22PAteFawl2EdFMJHFqo/ts7nN8jRl6RpDsYqKq
 S6qh4vmWsEMgZu6Onwpq9ybwiwIKSVEa0B7rQQQEdneboNm/bIul8PgcNFY1TNWdJFBkxbhue
 Pxb//ljfaJqrHFObRTdyw/zW8NgGsdoW0e0jzW0U70DZ9CJHiZu0fYWHERWV3jucBGR14yr/Q
 iEHnZtaUJeaP0UYnT76G0tXwFU9WMG9iVg8JlHeJCZrDk20CuovCHu+c+RVUuBjvQUtpFS5zr
 rQA5tUj4IFB4P/EU/q9hka+H8uxAiOMcw7oKYwMGAQEW7AfRTsCWsnSc6G3GDC/vsOD1+LgoF
 sdOVsjdQO1UA0gLthTx/bsQPwrNpQKfDc2Gps7hb9x3r9dh2JZbrmkByrQ9F1f7OF3OBUwpWH
 6OZPocLRg8kyHlVPbcMAvObAIsuvxqXfEF7QuWgs/5wXot9gy9UB1LPDjB6zXNt6p4VDo8Qw/
 1rHVLdjlXXnWltxlUYA208bR8JcDlM4nyQD0dH6+w4eu8BKBW7JjylzdwCcPXyu3p5kEioO0x
 yXC6yo0rWa/7lCgOUNkEMyQipNWNGZqwbdwpdMxMNzb+P0FFyzRKb3QBpxjqoeSUKxx37iMfG
 Wc4daYv9Cx3JHIEkoX8yCGVfIXTpbHzx/5Noiilz/3+wkZuf1d+b7NMO6aq3oC69MrcdUBOyt
 OVhSZs7sIN0/skZ5pQ44D+fWcior+HXNNx1Z1somjNfJWI4SfqTvK9PMhI5xpgvRacj6tYqqC
 NYTMyUOmzonxLxsY4CNA3FFRqnNYCxq1lM+mJNHOLL6QVyxKoFLKUPC+visfs5GbhryBIGOW4
 114Qq8lJXXy0IZ4OkOlMVtHlel3LUo4NZxtovXI6J4Hx8
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/13 21:46, Anand Jain wrote:
>
>
> On 10/13/22 14:44, Qu Wenruo wrote:
>>
>>
>> On 2022/10/13 14:03, Anand Jain wrote:
>>>
>>>> With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier =
to
>>>> expand and will always follow the strict order.
>>>>
>>>
>>> Nice idea.
>>>
>>>
>>>> -=C2=A0=C2=A0=C2=A0 btrfs_print_mod_info();
>>> ::
>>>> -=C2=A0=C2=A0=C2=A0 err =3D btrfs_run_sanity_tests();
>>>
>>> ::
>>>
>>>> +=C2=A0=C2=A0=C2=A0 }, {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_func =3D btrfs_run_=
sanity_tests,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .exit_func =3D NULL,
>>>> +=C2=A0=C2=A0=C2=A0 }, {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init_func =3D btrfs_prin=
t_mod_info,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .exit_func =3D NULL,
>>>> +=C2=A0=C2=A0=C2=A0 }, {
>>>
>>>
>>> =C2=A0=C2=A0Is there any special reason to switch the order of calling=
 for
>>> sanity_tests() and mod_info()?
>>
>> Mentioned in the commit message:
>>
>>
>> =C2=A0=C2=A0 Only one modification in the order, now we call btrfs_prin=
t_mod_info()
>> =C2=A0=C2=A0 after sanity checks.
>> =C2=A0=C2=A0 As it makes no sense to print the mod into, and fail the s=
anity tests.
>
> Oh got it. My bad missed it.
>
>>
>>>> +static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>>>
>>> =C2=A0=C2=A0Why not move bool mod_init_result into the (non-const) str=
uct
>>> init_sequence?
>
> Any comment on this suggestion?

Why you want to change the init_sequence array into non-const then?

>
>>>
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we call exit_btrfs_fs() it would cause=
 section mismatch.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * As init_btrfs_fs() belongs to .init.text,=
 while exit_btrfs_fs()
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * belongs to .exit.text.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0Why not move it into a helper that can be called at both e=
xit and
>>> init?
>>
>> IIRC the last time I went the helper path, it caused section mismatch
>> again, as all __init/__exit functions can only call functions inside
>> .init/.exit.text.
>>
>> Thus the helper way won't solve it.
>
> Really? Maybe it was something else because, I see it as working.
> As below.

You removed __exit, which removed the section type check.

>
> ---------------------------------------
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2356b744828d..0c48bf562aa8 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2791,7 +2791,7 @@ static const struct init_sequence mod_init_seq[] =
=3D {
>
>  =C2=A0static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
>
> -static void __exit exit_btrfs_fs(void)
> +static void btrfs_exit_btrfs_fs(void)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>
> @@ -2804,6 +2804,11 @@ static void __exit exit_btrfs_fs(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0}
>
> +static void __exit exit_btrfs_fs(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_exit_btrfs_fs();
> +}
> +
>  =C2=A0static int __init init_btrfs_fs(void)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> @@ -2812,26 +2817,13 @@ static int __init init_btrfs_fs(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE=
(mod_init_seq); i++) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ASSERT(!mod_init_result[i]);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D mod_init_seq[i].init_func();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_exit=
_btrfs_fs();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mod_init_result[i] =3D true;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> -
> ---------------------------------------
