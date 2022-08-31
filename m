Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946155A8843
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 23:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiHaVn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaVn0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 17:43:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E4DDB4A
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661982202;
        bh=WaTRMiWEkLnbRw/s6qtdJKdwhxSB2jZ5BzTI7/g7WnQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=SF3Wy74Gju37agdAMrfRJrudLAr0anIJTQYrjk+Vq1RRdyYeK4TKTKIWQGtlJhY+d
         8Kb+LvAV8/S9lzvpq1u366V3284BIOnUOCk7Yl73Bp8P4tnGoYkJcfJEwOilNW7wGE
         6kBDrh2bfGg42MhIke2LFTbxJ18I7/tY+zlPB7Ko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1owKCc45EV-00WkPH; Wed, 31
 Aug 2022 23:43:22 +0200
Message-ID: <66396669-7174-dd04-aaa9-d8322bc39fdb@gmx.com>
Date:   Thu, 1 Sep 2022 05:43:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/5] btrfs-progs: separate block group tree from extent
 tree v2
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1660024949.git.wqu@suse.com>
 <5eef4fd2d55a02dab38a6d1dec43dbcd82652508.1660024949.git.wqu@suse.com>
 <20220831191442.GL13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220831191442.GL13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CUOXP2MZx9T3J4PFyGYJq2F2hAliBmBwM+HzIwhP6iXAtkLsjwn
 hhGtVf4rcncX64qP2tFMgRRrgEoQ50PS6lujuk4iUWzJdneoC/Z07LKgE1+GVzfl2w0TSo4
 7HfTgV9X9uR0gKTPwqgviGP1dDgR5bDDYRFleesqlccVManu9KxMwMF8Pwh5fVMGpZZBZsn
 PYSBtuEJQqf3Swe1Ydi0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fq1ps9rrzkI=:orF1tpXWmzVI2ELBzQ+soL
 KAoeZzosSzNw0vv511MQaC7n7Ix400RM26hEYbyST0hCBld93FNVub6NkmwddBlpJiQ6UC0I+
 NnTn9dtGfmGZHs9zQPPcWBZ11uLcC3+RRn/vgxcF22tXPCyWKt3gzNof+0vSNDZJfLJ1vGOaH
 Xf+Rdc4CBDkcNhhYvAT1z19F7adRLG+Uq4R8GQ1w8S4yXdvWcjv6zntaiWxAePc8AMQsudEi4
 n5+5iBl5kwHCnHOKXkamhSxcHhKnoZR45Co73IIps2IWy3osPsXKArGISsi2EvgAvZ/2Cje95
 IEpxvrq7KwZFa3eoQa6RLX6ZX8fTwReefn2LJ1IBo92hB4AR2k3BfWhIIqEsXRFWDlp4H6pFl
 WcOlLe+nzaOzFVJ5An3W8sQZJYzt6gGTbH02ru1qNx/POcMEcdh31Qtja4MpulQkQujE2ide9
 AS5BqLCj7ygq2Qdp0LVfKPwRZGnG6WC1+8t2AlL+tryf4dHIt80V5BIklpj7YwIC/0KckyA/T
 t+0OgU94DzR05Z3R9JBWG9t1BM7D/+d7SkJNVbiwhmiyknsMlBbeVBqYE03ya4MiJN8N4RGZA
 nKX6nsJLwKRdZN7vCWrDQvTjd5u3YXHm9w21stVYedY4cF80WWEXABCXscvQuhCFa5/fK+brL
 1CrVwlIka9c8gEHO6XksUBjOGgzRpQj/ZOs3DnBhNFuqPiVA4cdkZxJbs415m25P137v7/jjI
 RGcGNR6aLhDaHPW7/SvD1iZ/IF2YIhDck1oHwDSGN1PQCTtry0OSTrZ7cReb1Nqe3MSEyK1Do
 KARJ+9xghuvuLhYzL8RyyLV8965quvmxo8EC/LEA/YDrozS4109dDUsooUDXFNqKLgypTNdpa
 Rr20v8lpaQ+Zac32lr3Na5aKcbcnnEnV3KRns7imYH1Ku9b9aLJeuvAN5pj6I4MpUh3oMkPR/
 DDts9IuUoxcRxefj2TxDJc3H8HwQrQoQIX/StAMbARsfoFpR/ehSFtthBYTtYuh+LPp6KmZwm
 qz+U+CCYcNJPfWYnEu0k7QrRO/0165l1XbXOQAwZT/HGG+gAKuK2+5ADUKl4Cbvxnm+iBKn0E
 f3UbfXXbJ6g2jgkjjnOjUwVknRT088356BwPyEVbgOF2PbhM+xwu+n9ag==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 03:14, David Sterba wrote:
> On Tue, Aug 09, 2022 at 02:03:53PM +0800, Qu Wenruo wrote:
>> Block group tree feature is completely a standalone feature, and it has
>> been over 5 years before the initial introduction to solve the long
>> mount time.
>>
>> I don't really want to waste another 5 years waiting for a feature whic=
h
>> may or may not work, but definitely not properly reviewed for its
>> preparation patches.
>
> This should go to the cover letter but in the commit such ranting does
> not bring much information for the code change. And I rephrase or delete
> such things unless it's somehow relevant.
>
>> So this patch will separate the block group tree feature into a
>> standalone compat RO feature.
>>
>> There is a catch, in mkfs create_block_group_tree(), current
>> tree-checker only accepts block group item with valid chunk_objectid,
>> but the existing code from extent-tree-v2 didn't properly initialize it=
.
>>
>> This patch will also fix above mentioned problem so kernel can mount it
>> correctly.
>>
>> Now mkfs/fsck should be able to handle the fs with block group tree.
>>
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features=
[] =3D {
>>   		VERSION_TO_STRING2(safe, 4,9),
>>   		VERSION_TO_STRING2(default, 5,15),
>>   		.desc		=3D "free space tree (space_cache=3Dv2)"
>> +	}, {
>> +		.name		=3D "block-group-tree",
>> +		.flag		=3D BTRFS_RUNTIME_FEATURE_BLOCK_GROUP_TREE,
>> +		.sysfs_name =3D "block_group_tree",
>> +		VERSION_TO_STRING2(compat, 6,0),
>> +		VERSION_NULL(safe),
>> +		VERSION_NULL(default),
>> +		.desc		=3D "block group tree to reduce mount time"
>
> Like explaining that this is a runtime feature and I have not noticed
> until I tried to test it expecting to see it among the mkfs-time
> features but there was nothing in 'mkfs.btrfs -O list-all'.
>
> This is a mkfs-time feature as it creates a fundamental on-disk
> structure, basically a subset of extent tree.

This comes to the decision to make bg-tree feature as a compat RO flag.

As we didn't put free-space-tree into "-O" options, but "-R" options.
So the same should be done for most compat RO flags.

Furthermore I remember I discussed about this before, extent tree change
should not need a full incompat flag, as pure read-only tools, like
btrfs-fuse should still be able to read the subvolume/csum/chunk/root
trees without any problem.

So following above reasons, bg-tree is compat RO, and compat RO goes
into "-R" options, I see no reason to put it into "-O" options.

Thanks,
Qu

>
> As it's in one patch please send a fixup so I can fold it. Thanks.
