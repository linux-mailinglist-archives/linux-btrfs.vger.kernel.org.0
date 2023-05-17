Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8D706448
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEQJjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 05:39:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698B3C3B;
        Wed, 17 May 2023 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684316356; i=quwenruo.btrfs@gmx.com;
        bh=DHH7Gy/vEckTg1RB4coyQiaYDdNENZlldSJfNEnyU5g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JqU2v0jg1j890szxRGhR2YlCFRTSOBV4foAphbWG7faHDkY5p56cx75inMR4JiKqj
         w78XyUETy9f6CHXK/WvWJQoGRw6dtpHG7nNfOAuisO4mrHZheVtQenVudQ1JopjN+D
         vdSCKzpnWDzE7aFYyjKRPUVfJOioP7JCQ1jf0qK8wgFBPLD5q51AcDYiRrbCX6AxT9
         kghghsgBys+7nOis4qXlndJbbaqQFu6fN3YMTvctfL7Kmxh94khSObk14tZ3NANYgD
         wZc88NAwB5C8iihDmMfqqnvWsCmjSHaYF8dsGBEU38pglJWfBIbvnJjrRWu9XVIrqD
         xb1f6NyCtVyfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1qdWWe3jrX-00ebJx; Wed, 17
 May 2023 11:39:16 +0200
Message-ID: <315c0548-835c-d54b-2086-cd3823c9b7b9@gmx.com>
Date:   Wed, 17 May 2023 17:39:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>,
        zhangshida <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
 <28116d72-d3a6-540d-fea8-542dd5d5ca54@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <28116d72-d3a6-540d-fea8-542dd5d5ca54@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0X96EA4zO27tv5BJuvwU6eHHHQrqt+OunrQpM1ijsqbxfwWAKgM
 89bJVdwxrPrJn3/mTDj+23tnvslZOr/ZQgGdSDVRO+SN/fGazTBvVcRXqv+c7/H1HF53R7R
 /DP7xo/qutpobgsercnrr0PCTGxdj9uriScNuvIf1tkv92rhEvECRmKu/nCOWhWMe9/LfSt
 wW+tjKxh2UtGiXXwxAVSg==
UI-OutboundReport: notjunk:1;M01:P0:eE1OXBaLrT8=;FbPxv5JL3G8rz8VBes+5eXP1SsJ
 Gr3wuwPnlFVTpETH58Biy7t1k/L9lvKbJKkeI5uKY1mtijSFzioFwrhBlR7gzyxMYKSj+MVwm
 3aGC/M1D8hyzyHd1/c2UEG58jZENEFLixL5ACfI3uftzPAFP+SWQHNvl3NSwVBpKOSj/7JCYv
 tViBjbkWo2hVfSybjOYl4cS54Y8dPmIq/HQowT9xvTVkbm5or/iQ4Qw0NPmrTJBZdk/iskwT5
 hXS1WiLAbCLmjmk6ER9abMhYw4xpeUuVcn/hJ1zv+KJTaaY1UkciCNEB2nHKj+QQv65TIKAMh
 2X9fAtnjUIgigAZslbH7h6qzgWK47vKV/711EVQ9fVKUcOkORI8JIs7TQg0Da3unQkTonjzYz
 s7OgVOkQDLN67RXjJ5mb9oa2IjkYondROhXk6Q4KOdEoP4UG+og6ShVkZ0SfYK9RCMX+psTKx
 ZEYvs7EK/0Ha3Zff+o0t13TVqtWIXT/CtvalWBqKal2l4ezIFJnG1BGL3VNk42ijWt6cw9rWy
 AIy/BZGEgfAw0Gyp5e2NGotP8c2j7C2sgmXrAEK5KTOvkMRF9zI3Jht1VunOxKfc0WetCbzfb
 capTWzcaZ6TJ40jMoCbPxL+TtpYSDl6xfmIYRMBNg6HlU7O6cOu0cLJjZ8KCj+bAJqbeKLSb7
 cUbfCXyAMcVYb1Kc8qm6NWjlNKPmBEkLci11MW9vOCzpLpmW6SPl+9I/cIraX5Lxpn2lxP+Ey
 lDFGC+CcAlF1n0osUs9AwI+U70SPblquUUOo/Sj9uJS9skRm11lS6uoNy1Do3tlWQZIKmzzKQ
 3YeCG7zJLEZIKE/kYcoKqTvoRODNp3sJewnu4bPsF5xz+Ei9jcesN97j1KE7n+FH8MyW/dJOh
 Jrxhb8ag4ZpcjZNMn45+IGnpfoyVmg9L/XRfdJVxzH9PwKvCcUF88sjcuZk5mvuG5dWnwLgyc
 yQrlxek7thli7wWNJ6DoW1jqGpw=
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



On 2023/5/17 17:13, Anand Jain wrote:
> On 17/5/23 15:46, Qu Wenruo wrote:
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
>> Especially you need to check if your gcc10 is the latest release.
>>
>> If newer gcc (12.2.1) tested without such error, it may very possible t=
o
>> be a false alert.
>>
>> And in fact it is.
>>
>
> I also noticed that last_range_start is not actually uninitialized.
> However, it is acceptable to initialize a variable to silence the
> compiler if necessary, right? We have done something similar in the
> past.

I tend not to. Uninitialized variable warning itself is a good indicator
to let compiler help us to expose branches we didn't consider.

Without a no-brainer "int whatever =3D 0;" we may even hit bugs that some
corner cases may even use that initialized zero, but we didn't even
expect to go.

Thanks,
Qu
>
> Thanks, Anand
>
>> @first_dir_index would only be assigned to @last_range_start if
>> last_range_end !=3D 0.
>>
>> Thus the loop must have to be executed once, and @last_range_start won'=
t
>> be zero.
>>
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
=99 may be used
>>> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>> =C2=A0 6211 |=C2=A0=C2=A0 ret =3D insert_dir_log_key(trans, log, path,=
 key.objectid,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> =C2=A0 6212 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first_dir_index, las=
t_dir_index);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../fs/btrfs/tree-log.c:6161:6: note: =E2=80=98last_range_start=E2=80=
=99 was declared
>>> here
>>> =C2=A0 6161 |=C2=A0 u64 last_range_start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=
~~~~~~~~~~~~~~~
>>>
>>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>>> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>>> ---
>>> =C2=A0 fs/btrfs/tree-log.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>>> index 9b212e8c70cc..d2755d5e338b 100644
>>> --- a/fs/btrfs/tree-log.c
>>> +++ b/fs/btrfs/tree-log.c
>>> @@ -6158,7 +6158,7 @@ static int
>>> log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *log =3D inode->root-=
>log_root;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct btrfs_delayed_item *curr;
>>> -=C2=A0=C2=A0=C2=A0 u64 last_range_start;
>>> +=C2=A0=C2=A0=C2=A0 u64 last_range_start =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 last_range_end =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>>
>
