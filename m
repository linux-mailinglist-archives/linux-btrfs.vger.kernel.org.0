Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63D5F75B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGJFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGJFW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 05:05:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9662C92F4B
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665133511;
        bh=KOn7bN0Nx9QOR1ht6qbU/WtuP6ksANppyoWB4sUmBeQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=b78ZdGmqbYbL6DmBGzbVMTupxCQcwB88Ysx8/apXj7tdu+DsCfTd1FeugERO9NnfS
         Pz+3uL92oAY+jX3CsYUfYPa0oC2HPAAlLCg8t/Y56PXx72UdfDumXAH1gZzfVuch+m
         rnQR7ADtb9nZcuWXIUNfv7ld+ATIvcjdIbflOu2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1oa8ek1bAW-006eFy; Fri, 07
 Oct 2022 11:05:11 +0200
Message-ID: <f9131609-e890-1a1a-9fa9-e3a488c614b2@gmx.com>
Date:   Fri, 7 Oct 2022 17:05:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <6df72bf7175552fb966a9529783febdf62bce971.1664934441.git.wqu@suse.com>
 <20221006151811.GM13389@twin.jikos.cz>
 <ba25f7c1-f469-2e51-7671-a0c79303b976@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4] btrfs-progs: fsfeatures: properly merge -O and -R
 options
In-Reply-To: <ba25f7c1-f469-2e51-7671-a0c79303b976@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQe7tQF4PaFJOMbUCgOQealDNKCODLbOTwJVRYiyyOfw3SMHzvX
 EAXNYiFIsn4s6qHCPJ7egU5uNmvf1Kgew2FgCWp9TRQn+YuXuqXpeGqYvXq6PVyALF/EmPn
 v3vWUttxDWSrCXXt42Tzy/UTZGIiL1MzVR+nIqwNqejp/2eHLTvApuHA+2R+3dlIh0R7Csf
 itfCdahx6ru0dOraVN8QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oe+yvtCUKvs=:quM1ZQCGCeZ22iUiUS8FI8
 /SWtP3nk6rur+XHc15ZDZT7BKYFv3Rg6YkShuq8IScrTEMGqpNAggRzl6ryWMxXNyadktUAH2
 n2L+UEbv6fcFW6yZQc9HcgW+O8JDJH5MOeyM+4w36AqMLj1tUj0hyAkAtZoaTLVM9LWdK8FM+
 iCIqBsXok1rxdo1Cn1GojZXJ/Q0J3Phn+4dLii+EWlfdwB8buMG8BMYc2LzCMcCOlZuBnTPUW
 fY6PxpwAK9tcT+NY2GYtqPHPDbaxPwxKpTIUq9V80svwlh0l3ATOEn9F753fu50N/eaZzBkHt
 7fRDufKGe3zxT6hU00hyepxd0SIasvBZW9kGXa+7YVhog8n6ByJOm3l5MleRp5Ac9rB2mpFDO
 HpIXgpLBU9nJMYEsio6LDCzaAV85FQzuivh9xEYO1vSMYePFM6MA7/U/0WmIeIcXpfx/BzdIa
 qiV4NMMgtbhUnKn1FEsQLijcnEp/DXRc3Vg2PqoQaaZ1NIz/HPr1JxMIPZba+GqVcVLx2LXK4
 tSgf071s7CSQRx0wX+GLFl6cFgqgS5NxFe2CSvQIIIqAVpRV6reP3CfxOPevi2BamdJFUM1c6
 n/oaF3BpmHn6y8VJn+SBcwR6E5qRsvNu84zINCsJkFrfsg8O7sowcpOe8vx6R/coZlX1AST7c
 l/l+v1XrvI2ox07f6vOootj1lTcuSi7hjfAOC4/IKu7RnB6nmkIeYKUurTDLQJNyJA/GHiGY3
 E1YhjT+/zKGPY6VZM/VUGpxNLFhqCE9APUpXZNevLrjYdIaexxybhPhyoj459spOwlntpWcAM
 X8iKYZelLa8gLuMV3BBaQJqLwjSoJb7czXSNNqHdA1RQjJXn+IUjxLiS949tbJCoh/G8FR5id
 ICYzZdDJiky5I4RtnSFVHW/Js/+OfT7kUYpYn7WEtoQTtTHO3HFz8X6oXRn/SjOV0hQEtixfK
 9k/umWHmDBXqmnuj3F4VwjSqzKMMHvZuJxdI9trrtno3TBu3BvH9Uh/I7flTkVAygJg+He+mB
 rCxkY1I7csixY0Wl85xKUIzYjCbXUbU1tW6dVV2foRWdxYXzzdhJCyifHn5KThgzzdtNctVMS
 Vni2zQZU6raY9uDtaG4q6pH6s7GXHAo4Rl/6yhbtYLtknlcYWB5/TQnGLX254Eaet+5hhutq4
 eWlZDm7TZ3ikktNc/0yQJQMxErRi325hgEMsLDUo3EwDTlOSCmorYV77GJ6R3sgPv1/BCfmbL
 qXdJywlyjlMet46HxGrq0I+APAHPBau1m0olDDTaiG4+HjG7maWABMF5wEEq/tkJOxX3dLOjb
 XbFTXHHcS3JrAr0B4cCutCq6QD8uN28Rzd/iIFnxAzsvM78+LElR2xArxj5fgiWCzNvWyUvkP
 pVNIsKeSR4yq2HSfvj8vdvsirS8f2Ip7zumN+sex35iCoBBEKpxFnPW1YUaS7Bu7BzIhXZOt0
 Ay5HxM7SIF8r4jWEeSBXOKqTQRQCZoK1uVRzV4FOu6uhfv8ligZP5ae9cfL0oSoOzlZF+EASv
 rFz0ukEjF9fomSNSIUvv/w12y2HBBJzILUUpHue/0KvN0
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/7 16:34, Anand Jain wrote:
> On 06/10/2022 23:18, David Sterba wrote:
>> On Wed, Oct 05, 2022 at 09:48:07AM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> Commit "btrfs-progs: prepare merging compat feature lists" tries to
>>> merged "-O" and "-R" options, as they don't correctly represents
>>> btrfs features.
>>>
>>> But that commit caused the following bug during mkfs for experimental
>>> build:
>>>
>>> =C2=A0=C2=A0 $ mkfs.btrfs -f -O block-group-tree=C2=A0 /dev/nvme0n1
>>> =C2=A0=C2=A0 btrfs-progs v5.19.1
>>> =C2=A0=C2=A0 See http://btrfs.wiki.kernel.org for more information.
>>>
>>> =C2=A0=C2=A0 ERROR: superblock magic doesn't match
>>> =C2=A0=C2=A0 ERROR: illegal nodesize 16384 (not equal to 4096 for mixe=
d block
>>> group)
>>>
>>> [CAUSE]
>>> Currently btrfs_parse_fs_features() will return a u64, and reuse the
>>> same u64 for both incompat and compat RO flags for experimental branch=
.
>>>
>>> This can easily leads to conflicts, as
>>> BTRFS_FEATURE_INCOMPAT_MIXED_BLOCK_GROUP and
>>> BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE both share the same bit
>>> (1 << 2).
>>>
>>> Thus for above case, mkfs.btrfs believe it has set MIXED_BLOCK_GROUP
>>> feature, but what we really want is BLOCK_GROUP_TREE.
>>>
>>> [FIX]
>>> Instead of incorrectly re-using the same bits in btrfs_feature, split
>>> the old flags into 3 flags:
>>>
>>> - incompat_flag
>>> - compat_ro_flag
>>> - runtime_flag
>>>
>>> The first two flags are easy to understand, the corresponding flag of
>>> each feature.
>>> The last runtime_flag is to compensate features which doesn't have any
>
>  =C2=A0I read the commit 5ac6e02665a6 ("btrfs-progs: mkfs: add -R|--runt=
ime-
>  =C2=A0features option") too. But I still can't comprehend the problem t=
hat
>  =C2=A0the runtime flags solved; because the -O option enables the same
>  =C2=A0runtime features.

The old parse_fs_features() can only return one u64, thus it can not
handle compat_ro flags.

Furthermore for quota it has no on-disk format at all, thus not a good
fit for the old parse_fs_features() code.

>
>>> on-disk flag set, like QUOTA and LIST_ALL.
>
>  =C2=A0LIST_ALL is not a (kernel) feature.

No one is saying it is. What's the problem?

The commit message clearly said "which doesn't have any on-disk format
set". And since "list-all" is a valid parameter for "-O"/"-R" option, we
just treat it as a feature.

There is no requirement to bind a "-O"/"-R" feature to any kernel feature.

>
>
>>> And since we're no longer using a single u64 as features, we have to
>>> introduce a new structure, btrfs_mkfs_features, to contain above 3
>>> flags.
>>>
>>> This also mean, things like default mkfs features must be converted to
>>> use the new structure, thus those old macros are all converted to
>>> const static structures:
>>>
>>> - BTRFS_MKFS_DEFAULT_FEATURES + BTRFS_MKFS_DEFAULT_RUNTIME_FEATURES
>>> =C2=A0=C2=A0 -> btrfs_mkfs_default_features
>>>
>>> - BTRFS_CONVERT_ALLOWED_FEATURES -> btrfs_convert_allowed_features
>>>
>>> And since we're using a structure, it's not longer as easy to implemen=
t
>>> a disallowed mask.
>>>
>>> Thus functions with @mask_disallowed are all changed to using
>>> an @allowed structure pointer (which can be NULL).
>>>
>>> Finally if we have experimental features enabled, all features can be
>>> specified by -O options, and we can output a unified feature list,
>>> instead of the old split ones.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Fix convert test failure due to missing allowed features
>>>
>>> v3:
>>> - Fix a bug that we can not unset free-space-tree for non-experimental
>>> =C2=A0=C2=A0 build
>>>
>>> - Fix a bug that free-space-tree compat RO flags are not properly set
>>> =C2=A0=C2=A0 for non-experimental build
>>>
>>> v4:
>>> - Address David's concern of new BTRFS_FEATURE_GENERIC_* defines
>>> =C2=A0=C2=A0 By introducing a new btrfs_mkfs_features structure, so we=
 don't need
>>> =C2=A0=C2=A0 extra re-definitions.
>>>
>>> =C2=A0=C2=A0 The amount of code change is still the same as v3, since =
we have a
>>> =C2=A0=C2=A0 larger interface change.
>>
>> Thanks, this version looks good to me and maybe even better than what I
>> intended to implement myself. The amount of changed lines is high but
>> the core changes are clear and the rest is API update.
>
>
>> Added to devel.
>
> Still, there is something to take care of, I rebase to devel.
>
>
> $ mkfs.btrfs -f -O extent-tree-v2 /dev/nvme0n1
>
> ERROR: superblock magic doesn't match
> NOTE: several default settings have changed in version 5.15, please make
> sure
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this does not affect your deployments:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - DUP for metadata (-m dup)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled no-holes (-O no-holes)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled free-space-tree (-R free-space=
-tree)
>
> Segmentation fault (core dumped)
>
>
>
> static int cache_block_group(struct btrfs_root *root,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group *block_group)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path *path;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_io_tree *free_=
space_cache;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int slot;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 last;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 hole_size;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!block_group)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 root =3D btrfs_extent_root(r=
oot->fs_info, 0);=C2=A0 <--- root is NULL.

I can definitely look into the situation.


>
>
>
>
