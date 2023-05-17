Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32142706484
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEQJuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 05:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEQJuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 05:50:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D901B3;
        Wed, 17 May 2023 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684317003; i=quwenruo.btrfs@gmx.com;
        bh=gMvX1Vdcf7GS5NPrv3mBVzBZ0A12ERDnvFl7Ho1pPRM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=F3TQOtxKnQSWfiHRsHqMGUch6IP8xqddV6G4LTGISCMS954eADt1w/tfW11VV9E7E
         tFjruVcEqM3Vk3HCfjs2hICLEUO2hG3Nf/kBAdnD1OVbpBXC1PbOXLLmUwH63/N7on
         nIAp1jyJobkNg7zRtaRCU9u/p4SSIUM+1n9toVmKDfcmrx92JNF8TfUmVLV8IY9c/h
         6YhzfWnTBLrQnZcA2P/lhIl6CuQIdcAajzw0gIees27Qe8HfwqCzkHwa4Zl7G1Vm+x
         4guDtB+aS7hXIO89eK3XJfrLnY7+P/M2DhLXxEO7+XktABG5j5F83th4i7DCODd4aB
         PJZBi0Za9L6Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1prV6E4552-00C8XM; Wed, 17
 May 2023 11:50:03 +0200
Message-ID: <7f016ae8-b44d-8a50-849a-39fa484f348e@gmx.com>
Date:   Wed, 17 May 2023 17:49:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
 <CANubcdVZ4tUZo=HDytwYFTZiQwo8QSABskBfZXL+y_swXvb_DA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
In-Reply-To: <CANubcdVZ4tUZo=HDytwYFTZiQwo8QSABskBfZXL+y_swXvb_DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0TePxA/KP6E93wmgVH1Ta4OEudWYZ/KAd7dtwhjW5Uw5Xx/IKV9
 1HGPKILy8LlOKe6K3prd+MzprfMhFhIYXcRAVHngalpfP/kSy2oQ3QMOGlTCRp6qDwAX/GW
 7s4DMsaT8No6NXhZBOZ26r6b18EpW5pEdy6CDKeN4lcYGKj5hPpMj3nESb9BMdPd84g9swf
 HEPvR3d7poNSHJ+5sf7Jg==
UI-OutboundReport: notjunk:1;M01:P0:USVIveoIOC4=;fkMBjX/9h+GtsCsxGepHq128VrT
 dwVrGmu2ruuugCbvl+eem3NQRM7yLACNo72TWAaiT1n5xFQnjLM8v7WBl+6XX4Rgq6f/l1xTH
 Z8DePcDJWDPJTFMmZu4DYFZVAEl00pNF43XKg8tpyW0Kkg5/8Ekx7EgEfMGp4V7+C9OtYh3l1
 HGb7yuhhyBCK+YhsK1LhT0UpOjNhW3FeWrPdPBzeiwIiXlQiywq5a5cz+wVfr8gw2nYKO2WH5
 0nLcaksktpc09U8PMEy5d7xiuYrGB3xPAmgLKNVdoVAjDgyXgquQd/VfoJnn9uLS98uAydd6q
 oPTjyazrtoj1A4FIryYiTbNB5/cTRDL58MkrEF7flJCQxTbjrkSA7I5pKcfax8h779TTvktOl
 00aHSNvSTpxNY1jFwu1425UeMiF4ckq7WYP2HG0Q+UoXlOpTP6oe/DqgDk+jMJZA+GjsF48m8
 LHZ//fsmKGxeqJ6PZUmtNOUWLMvdfdX3s1KVDwP+wq72rsJOs8TZH9ekZFZyhXSISUsGnv/3/
 x7SaIyrnstlW13VxffkMcTg+zWZ9s8jXPAyPQWdnbhsOFGhAdwV/Nyy2F1Bbw3WJ2yEBsP5xL
 oMRuGp/EZXdJP0ujqPhHaeHv1dxOEfZ0I7FAu9c0Y6PElTohjK8Dj3NXkjGbnWanAIDBKFCSQ
 JRlqgd3a5cJEr3V1suS98NPiQaKXswjDT7B+F7aIceD3cQdL8sq5vJnR4OxhpwBfDhr10yf5i
 cgSfciFGmfTqpRyPhh/BvCmca0GAE/fUrVFe5dyCJapjIlMWcguWf1Ks4n9DcDCY36PQfqJz9
 JDNOZEqE+Wxu3FqnJkeWHAyMghKtwCPiRJ6D/U6iDx4yeO/tHlNwEq/Kc9UH2wRKKdvCBTqOg
 M1lioWsKOicnDZON7UqReishHT/zbr12qIsbVPyAYgFXFMyy15dHT48n13wnQlnBk5gzwl491
 JW4XNlDYtrkNkZbdwPZ7vX/IuxA=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/17 17:07, Stephen Zhang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=89 15:47=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>>
>> On 2023/5/16 09:34, zhangshida wrote:
>>> From: Shida Zhang <zhangshida@kylinos.cn>
>>>
>>> From: Shida Zhang <zhangshida@kylinos.cn>
>>>
>>> This fixes the following warning reported by gcc 10 under x86_64:
>>
>> Full gcc version please.
>
> it's "gcc (Debian 10.2.1-6) 10.2.1 20210110".

 From GCC 10 release notes:

 > GCC 10.4
 >     June 28, 2022 (changes, documentation)

Please upgrade to latest 10.x, at least Debian should already have gcc
10.4.x in their repos.

>
>> Especially you need to check if your gcc10 is the latest release.
>>
>> If newer gcc (12.2.1) tested without such error, it may very possible t=
o
>> be a false alert.
>>
>> And in fact it is.
>>
>> @first_dir_index would only be assigned to @last_range_start if
>> last_range_end !=3D 0.
>>
>> Thus the loop must have to be executed once, and @last_range_start won'=
t
>> be zero.
>>
>
> Yup, I know it's a false positive. What I don't know is the criterion
> that decides whether it is a good patch.
> That is,
> it doesn't look so good because it is a false alert and the latest gcc
> can get rid of such warnings, based on what you said( if I understand
> correctly).
> Or,
> It looks okay because the patch can make some older gcc get a cleaner
> build and do no harm to the original code logic.

To me, we want every variable not to be initialized unless necessary, so
compiler can do us a favor to detect unexpected corner cases.

Just unconditionally silent it is not a good way to go, not to mention
the initial value may even be wrong for other cases (not this particular
case).


If you want to fix the situation (other than upgrading your tool chain),
please do it in a way that is also improving the code.

For this particular case, I don't have a particular good suggestion.

But I may introduce a bool to indicate if we have hit any ranges before,
like @has_last_range, then assign no initial value to  @last_range_end.

With this, we bind everything requiring the loop to be executed at least
once to a single bool variable, then maybe older compiler is also able
to detect it's a false alert.

Thanks,
Qu

> In fact, I've seen Linus complaining about the warning generated by
> some gcc version in another thread.
>
> https://lore.kernel.org/linux-xfs/168384265493.22863.2683852857659893778=
.pr-tracker-bot@kernel.org/T/#t
>
> so it kinda make me feel confused :<
>
> Nonetheless, I appreciate your review.
>
> Thanks,
> Shida
>
>> Please do check your environment (especially your gcc version and
>> backports), before sending such trivial patches.
>> Under most cases, it helps nobody.
>>
>> Thanks,
>> Qu
>>
>>>
>>> ../fs/btrfs/tree-log.c: In function =E2=80=98btrfs_log_inode=E2=80=99:
>>> ../fs/btrfs/tree-log.c:6211:9: error: =E2=80=98last_range_start=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitiali=
zed]
>>>    6211 |   ret =3D insert_dir_log_key(trans, log, path, key.objectid,
>>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    6212 |       first_dir_index, last_dir_index);
>>>         |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../fs/btrfs/tree-log.c:6161:6: note: =E2=80=98last_range_start=E2=80=
=99 was declared here
>>>    6161 |  u64 last_range_start;
>>>         |      ^~~~~~~~~~~~~~~~
>>>
>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>>> ---
>>>    fs/btrfs/tree-log.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>>> index 9b212e8c70cc..d2755d5e338b 100644
>>> --- a/fs/btrfs/tree-log.c
>>> +++ b/fs/btrfs/tree-log.c
>>> @@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(str=
uct btrfs_trans_handle *trans,
>>>    {
>>>        struct btrfs_root *log =3D inode->root->log_root;
>>>        const struct btrfs_delayed_item *curr;
>>> -     u64 last_range_start;
>>> +     u64 last_range_start =3D 0;
>>>        u64 last_range_end =3D 0;
>>>        struct btrfs_key key;
>>>
