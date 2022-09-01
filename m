Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A985A9679
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiIAMPT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiIAMPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 08:15:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5627B0F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662034511;
        bh=IICqHy2nD1zGFPeuJPUrW/PTRJW/HNehpkYWcAlPWT8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=cLwLPVtTeIO+xIAXxK1Mqpnh8ww7icgm7ZqiVv14my3V98VR2ptIdYWLX59CwVXTx
         pnbCqpTfwZN2c+Mq0sqSlbIKyoOJlXRMy7hfLU5gV2mKpd5G//hl8YFhwXAm2MHGX+
         YhClfv+Uq6ZMXhw+Jb7A/7yXb06Q4ns0RJ4Mqk38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1ovoLI3JTi-00S7fv; Thu, 01
 Sep 2022 14:15:11 +0200
Message-ID: <ab123921-773a-9e1b-1d49-9e82614a37d9@gmx.com>
Date:   Thu, 1 Sep 2022 20:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <20220831191442.GL13489@twin.jikos.cz>
 <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from extent
 tree v2
In-Reply-To: <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4HpbioxXWtaY8525P2Se7ScVzmc1BmLioc8e4W3bq5nCWBP0BH
 47ADqQYbH++0HSaBnPwnVziHoGFUTlsWvZgzTMPm+xPN///cpNeSEEG7LJ8Xepr+vSP2aAu
 3tXBSrAvyHImN+hLvmSTzrRO9vkTTVGFGATK4WEf0fjUl3sny03vBsUTQ69Dgv/yMiMVFmT
 FrA0jfSzXij/tDVlnIICg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fA5/V/f1q4A=:jRIodWrmY3jUU67DVH0sK0
 ccuoekGPky3AwXkhtoYl4aZx9ZjuhSwD8ibHbw/AeLGIvxVTuxSJiIGkJpHpWOsl5EYL/l4Pi
 KiksuoccO1flXqYxdt1tkFy+Um5vpgzVxWMiuDibjpDsNpLd1x+Ewr7bnGAYrusOgNUVQqRDs
 ZZ0uSKwWJvAPZm9qGSWxXwKz+8iOd2nDeaBTthp2F83AiZFLMhPrgY2RSQAM6+EQ9I1EVhXr4
 Q03un1g1QoyVwC2wx7BXbj4J3ROodNc0j4wGaIqSsaPUq0MGVCuE74VlhyfevJxYF2vYpTNTU
 2msScS68KFQgDweKD6+UHaf2ECYNGJPeAdBCooOzbyoTQPS9Z1jr4DZiQuYjbcgLOhJ3YwDwb
 dH3SvLO4SUwbHezFbapGsGxDdE4oDnBT8TgpYCuElZ42c8c25oJfwWnIdRSgm20b+1G/3wKK0
 iQLoSgw3tt8JX4QW73bO90yX6hJqboxRyt3RrTIEE3tMHJ9Aqh4jWtx8Wv6/9tSpA+UI2d+/3
 OuEr/FtFvSBj/9f4dDri2+UEhuTxtgn9DXdyHgEXC1+BCW0zd/QZ+23MtU5BzFry5yMxXEotV
 c1YNNRn5nlnjC8Z2ARkuZ6SZgHPu5/vmGomIw0S34gxdXF8dxcpv73yOVk7U0IkwnbK1xUHCl
 bdlc2RuFDXduDJD9BgbwYumiP+H+mc6PC83r9Qlt43C5AT5lBxrYaanLxvfdWdgSaLrovIDxq
 In4w31wgR1fFyvxqnjWUKdiIdLVJhUjUepSOxZs2u+DUzvnL6Le8cMjcBfOtoXc/Y4s32yDuW
 c4aVyrN7e+OiWdNqLsa6CKsNWNk3kB2ScpPA6NwYcZqjesQayVuB3/GJ3zWVYxslcDUIevAEX
 +GGgP297Dn0g3zwRtAGXGMC1SNw0zmWQk8+KmGwtWElIvUXyny3U1A9Ez08Habvuz25oTWp4C
 8l5dnnMCz4L5UHlKvuDmXsRzbq3lDU7sbQzUKe0ZaN2apADJ3Dw7VU5p6PPw5wVnZBBxLSMzM
 qok15q17+PDeagMaJzrBR9nz2BE0GU+BCkYg6QD6IbfUde86UWKkxbAafNk+n+nKdzOAmW5xB
 6SomTij6As5kSQOfiNDzKeMF2XScDHaJvGYauUM9HkFmLbCpOq9uJGcynzcVyPNYCgjKGu55L
 m+R08kKX1JUVDVAnm9gh+O6XMP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 05:43, Qu Wenruo wrote:
>
>
> On 2022/9/1 03:14, David Sterba wrote:
>> On Tue, Aug 09, 2022 at 02:03:53PM +0800, Qu Wenruo wrote:
>>> Block group tree feature is completely a standalone feature, and it ha=
s
>>> been over 5 years before the initial introduction to solve the long
>>> mount time.
>>>
>>> I don't really want to waste another 5 years waiting for a feature whi=
ch
>>> may or may not work, but definitely not properly reviewed for its
>>> preparation patches.
>>
>> This should go to the cover letter but in the commit such ranting does
>> not bring much information for the code change. And I rephrase or delet=
e
>> such things unless it's somehow relevant.
>>
>>> So this patch will separate the block group tree feature into a
>>> standalone compat RO feature.
>>>
>>> There is a catch, in mkfs create_block_group_tree(), current
>>> tree-checker only accepts block group item with valid chunk_objectid,
>>> but the existing code from extent-tree-v2 didn't properly initialize i=
t.
>>>
>>> This patch will also fix above mentioned problem so kernel can mount i=
t
>>> correctly.
>>>
>>> Now mkfs/fsck should be able to handle the fs with block group tree.
>>>
>>> --- a/common/fsfeatures.c
>>> +++ b/common/fsfeatures.c
>>> @@ -172,6 +172,14 @@ static const struct btrfs_feature
>>> runtime_features[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERSION_TO_STRI=
NG2(safe, 4,9),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERSION_TO_STRI=
NG2(default, 5,15),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "free space tree (space_cache=3Dv2)"
>>> +=C2=A0=C2=A0=C2=A0 }, {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D "block-group-tree",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flag=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sysfs_name =3D "block_gro=
up_tree",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERSION_TO_STRING2(compat,=
 6,0),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERSION_NULL(safe),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERSION_NULL(default),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D "block group tree to reduce mount time"
>>
>> Like explaining that this is a runtime feature and I have not noticed
>> until I tried to test it expecting to see it among the mkfs-time
>> features but there was nothing in 'mkfs.btrfs -O list-all'.
>>
>> This is a mkfs-time feature as it creates a fundamental on-disk
>> structure, basically a subset of extent tree.
>
> This comes to the decision to make bg-tree feature as a compat RO flag.
>
> As we didn't put free-space-tree into "-O" options, but "-R" options.
> So the same should be done for most compat RO flags.
>
> Furthermore I remember I discussed about this before, extent tree change
> should not need a full incompat flag, as pure read-only tools, like
> btrfs-fuse should still be able to read the subvolume/csum/chunk/root
> trees without any problem.
>
> So following above reasons, bg-tree is compat RO, and compat RO goes
> into "-R" options, I see no reason to put it into "-O" options.

After more consideration, I believe we shouldn't split all the features
(including quota) between "-O" and "-R" options.

Firstly, although free space tree is compat RO (and a lot of future
features will also be compat RO), it's still a on-disk format change (a
new tree, some new keys).

It's even a bigger change compared to NO_HOLES features.
No to mention the block group tree.

Now we have a very bad split for -R and -O, some of them are on-disk
format change that is large enough, but still compat RO.

Some of them should be compat RO, but still set as incompt flags.

To me, end users should not really bother what the feature is
implemented, they only need to bother:

- What the feature is doing
- What is the compatibility
   The incompat and compat RO doesn't make too much difference for most
   users, they just care about which kernel version is compatible.

So from this point of view, -O/-R split it not really helpful from the
very beginning.

It may make sense for quota, which is the only exception, it's supported
from the very beginning, without a compat RO/incompat flag.

But for more and more features, -O/-R split doesn't make much sense.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>> As it's in one patch please send a fixup so I can fold it. Thanks.
