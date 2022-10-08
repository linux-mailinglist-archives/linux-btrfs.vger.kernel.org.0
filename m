Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9095E5F886E
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJHXNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 19:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHXNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 19:13:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28C32B92
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Oct 2022 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665270826;
        bh=UfJQv9IRomDv8dE4An84VXVnL0d4i18+wS4fXER2NFE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=jxsH7H30wLUea4505EkNqaScL05p5SqbMH++izrO45XOO6clkACKhxk8e77rnjvYl
         2PzZ6DQIufsVuAx0gwFjJHY5YyIPQv736aK3fNvtEMoToc7V8kdWSrw7dqWE19Hcgv
         lfs9m3fC2OeQZQ3THZXfFElothPy6LFIYHycQdcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4JmT-1oha801l1F-000KXz; Sun, 09
 Oct 2022 01:13:46 +0200
Message-ID: <764d5754-62bf-232a-a6c2-67724111a72b@gmx.com>
Date:   Sun, 9 Oct 2022 07:13:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs-progs: add extent-tree-v2 support to dump-super
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <78ebe492ca09e716ca5ca2b6fabec0934aaa0370.1665219233.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <78ebe492ca09e716ca5ca2b6fabec0934aaa0370.1665219233.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAuX9tZk+lxb978LeFEySgeVEyBMZRjlelGu7dnwSrFFQipKcts
 i9VoROeWjBhFgQ2VmaT8H1OreYViyNfeJrerk/phoKhDH//am7QbPbkmGoV9j0+l4XA+7z4
 uI5lPmJMNl7ADvIRosaVYwUwXBWsP9w6KGFVYH6RmMCTvT/iCQUdAtEvIOABKVKlaGFDzdj
 Rty/9W0lC/HT+mWmpwu2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQI0CY5WZyk=:pITV9tVEH6uMqOc1v9SNtg
 OkDP1YRiE5g4lPSwoPt8r0I48c/U7guWZNdpA+iZh6EXdFVogIiDvHEyBY7BeyuXLXAu9KnlZ
 SBzm88GMB7zlOFQf+7FI2fBvjXsAhimTfnuf1YET2qA+CQ5547FO8WGor5IhAgP0+ikXExS9l
 IXiU6h1v+Yy/aVLCSy6lFVtWuBjhsPKz5Vfn23FFW7/ax6ywS32YmDUUjNhObb+rRPNBjeze6
 3zAEsS6Lo8zTZ1VBnO+gC+zgLVnN4r+X0bvwOccYHHtBj+r8y+Lif3oL642N//YaZbaQA+IPI
 V2D7GOnJdk/t/miaK6bmtvR2NayfXUdk+sqIEL3Uw6KKi36x5/wPMQnaXMnKyXh33OZgynop1
 FtidUJfa+igFlIz19UXRTbTc7m1dL5mwbNCvrOZ/QjoJ+/A6f1PDyS8UVo8+pOAj8BTdhKLz9
 n7UR8G6da6R2bDVmqXOy7lWeNLvC4F3Twu1aLE/545Pbsq017h4MT/uVoWOQ5N8O4m/KiwhY9
 LyTymbk3E4JmPL1uAud8e8N+JIunY5PAmfaDyjGxczB19ec5/gT7weT22i1ZfKJut/qqD90Xp
 qRBp/ew74mkf1O/35olqIYeFtDATWVIU7pMtY0Il8NCFrjWzHDo+kganqel14XLU75FVE86WS
 Z+dKv94UMq4bkYjuMxtf1+ClFyW0vt4RV9EE0s934W5MD9EIE3BotCf2Loep06a2W3eYNbCUS
 U/tM7ncXnI3GH/nJ6XsR+vdcASkBycoLbKb7Nu9mGRwQxnfIE4G9Bj1vF2MLkEJ6n5NyJHmpV
 aseuWFCnjPfY+ttgDrpjOhaaQTIdQbwfe5QDC4GKRrD9G6V9mL01sbCJhkbsDgnmPSXEoD2ZY
 m2NhfBvh7pC62fqvx+YalHJ6PuTxyTuQmOFb9uejA1M/LPE/Uy8ONE0Qfk/UcwwarUyiu25MW
 SFknS/5VivNuC2IiCmLRwA8BUUKqztBvFICs646sJjRkb/lhaNQeM/pZ5JNdbHU31iygCXV4G
 3DUVv2MqLsnu97I52iKzeVvcwJtehG8hrMjzKE9GzaK7pSzHWr9JdZcQtqiCDLS3/cN2DJPPu
 A/i+fHJ1O6pIBNyQbXjw/wU2I/diEC5C4cpF2aRQmd4O4wa83iNI7gnSbYxFf+GcDIrew1xKE
 CH3jLHxCRzW8gqn6ak9dP+vd9coOxv0hBBq5zJsMMSLEuPWTQzjVGCCoW4U0wSO3DxBWbIQmY
 rZtmdYcMtES+Pl1nA0dc+Lx3Mh5oXhvJQ8vXq3K+qrGTyrPpFmfBvF4jsH6HUJgDDuf69/Smt
 YLG+MyMgQbitTs68ObOHAT2GrvxiW6wHkHSQNT+i9hzU6bVa1T7qoDW/RBlr2ej8KK4ddmW+s
 F0VUmvlTYpl8qY0ccVCCokdGpRocMQE1CFvlJ60NN/hJzhQEWG//71tRpqej4FFzYOHpfzfjS
 qnDDCzCAtPun5uTSaGiwiula+6HT8tESVSQZ+IAMoO8EgxZ+qTmwxp2Wb+wrzOae0CmQSMbXO
 IWL+WZu9iw+LscpMjZqknWvaX6GVxJsEXKWdFWdLc6e9F
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/8 17:02, Anand Jain wrote:
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   kernel-shared/print-tree.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index 5c3d14298b58..6b5fd37ab2bc 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1689,6 +1689,9 @@ static struct readable_flag_entry incompat_flags_a=
rray[] =3D {
>   	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
>   	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
>   	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
> +#if EXPERIMENTAL
> +	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
> +#endif

That's in fact one solution I want to go.

But later I found that, we can enhance __print_readable_flag() to
iterate the incompat_flags_array[] with extra check on @supported_flags,
so we can skip the EXPERIMENTAL macro inside the array.

By that, we can reduce the number of EXPERIMENTAL macros, which I
believe is already causing burdens for testing.

Thanks,
Qu
>   };
>   static const int incompat_flags_num =3D sizeof(incompat_flags_array) /
>   				      sizeof(struct readable_flag_entry);
