Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E3557546
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiFWIWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiFWIWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 04:22:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223148325
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655972551;
        bh=Kp5xoHmNLTjOrIBxJsJuoBYWm1Dd7lTIYl6OXNJOs0Y=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=dmW5wPS3xQlLsSbl6KfQn9bjR0CoWrFPJRULZfRx0Ecwz+ctKvyisT2e5+0I+n5Qw
         doEwB9QL/jMJ1cShUYntmxl9+bl8IqG1w8dZAA4nYrjF9nhvWDMDNJSAMkc2g4dZ8W
         lPTktRp1kTgj6hIYTu1haKKO0MEbTLhajHF01CAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHAB-1nTsdB0aKp-00go13; Thu, 23
 Jun 2022 10:22:30 +0200
Message-ID: <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
Date:   Thu, 23 Jun 2022 16:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
In-Reply-To: <20220623080858.1433010-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S89MldI3GAZ3WfUD6Fin7YH9mc/Oa6euTV1B4kFuyhz8L1S5XWh
 lx8S6MAzJG5GC2uZ8M/GcJCzKtQ1eHW46JcVuVsDAO/vCksdMOJjNSjJmFKwgZUHi8oC444
 ZTyFZlK1QNEYomZunYZn0vsN2irftsGsUYDR+n2o+TPXVhTseNWDF+kt6Jn2QJebRxwhNDF
 kROGbn9kpOkQ0sgp798Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JftuVbpHH+0=:2Mje//wf+0fqhRyicDGZgR
 DezEObY5l4UOvd9NdcClvufekH3/zFEoYlX6ZY+W+ZiUfW7BLZhJCM4W3q8TCV6BBpjnfmnnQ
 NQwgUpMlqJ0N4JVU0CRh0OE20/9GQUu0M/+j6rE01wQNLPRMmltu7IP7eT16V90gTkO1P2d28
 4ubmaL3G4zZxL3VFJtj/xYsuKegj5Eb+jdYgQBCbScs0w2QuXsnC1iKH5UXWxW8BX0EYad7wf
 l2GuPA9Zudncu0k9PCbcGUKtOTZ+fsAVmXBoxCS5lEJ+ESkc0U79+Lgkn741ytJX+965dCG/m
 hwTM8LQQviUtgdf3e8bednsBFmF6BxtvmAyqL1vgzl1rjQmfuAvMc15TgyS37xBkNpHUyNceG
 9ajcrXvkLAahCkZdNZkN3tO7rkaGsSljONblu2wGcB5LrozJEeUCtMRLJ0fdvTL2XlWLMij5j
 +1OabAV2ZPvDl9q5DKNjyCTXpUZJLDxcVdfXDWaiCW1rjUcEQfzUvSfx+nP2OS0wBkNuBTODG
 6I4hxM+1K3VAUnfUIshTl48po/urwJcdNTKIAAl8S2K9mQQ9/UW5tAh8rpkDovzJRGn/U0am4
 yDMHvJTW89+ZjYw5TLIfYQV2tiLWGiY3ddqhb7jO5Qwnh7PggLifs56YaPTJTnAoofxLQWbzH
 0gw8ejyGnW7XYn9j3XO0DewYl+srvdbnOFC6kLzd2hjdJQ7igDHnMeOBaHOLtGcWgm/JsZLSM
 xR6DZDbw29vGmDrt05i6XO7z8OPU9oFvvgEb0o+U8lEcPKu+x2JuIiNxh1Mp5P59lWyoiHBbR
 nU7eluCrF1yn17PXVBZU/31aVDp0Z059Rg7H0wiMjNL9GkzPEG8J0ShkselZqIIK7zmubRi0i
 L0a23M1GnUBw4RSsZxM5a35LfpznFB2fJmRhtwaafd1BhkuAZfNhAT7mj/7YhFnYCkovQMi/8
 D8SUyNr9trvLyDlO5Y1cxzaK0DnzzYgsJepsyoxqNXe6wN/h79eBj1s1wOYAH0loGo0oQ6cGQ
 5sNh9ITdDD+zg02Db4wKLBz30aP3puglrX4puJ1bvDZHoKQvq7jYnWWQSD90BpdTpfVNCh3j0
 vo4CGPB3AXpwbi069A6elVJG84ndH7Km62wkmocc65OooGJv6bqxr6eGg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 16:08, Nikolay Borisov wrote:
> Skinny extents have been a default mkfs feature since version 3.18 i
> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
> make skinny-metadata default") ). It really doesn't bring any value to
> users to simply remove it.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks fine to me.

But this means we need to define the level of (in)compat flags we want
to show in the dmesg.

By default, we have the following lines:

  BTRFS info (device loop0): flagging fs with big metadata feature
  BTRFS info (device loop0): using free space tree
  BTRFS info (device loop0): has skinny extents
  BTRFS info (device loop0): enabling ssd optimizations
  BTRFS info (device loop0): checking UUID tree

For "big metadata" it's even less meaningful, and it doesn't even have
sysfs entry for it.

For "free space tree" it may be helpful, but if one is really concerning
about the cache version we're using, it's better to go sysfs other than
checking the kernel dmesg.

For "SSD", it's a good thing to output.

For "UUID" tree, it's definitely not useful, even for developers.

For skinny metadata it's the one you're cleaning.

So I guess you can clean up more unnecessary mount messages then?

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c34d08e3c64..0af4c03279df 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3501,9 +3501,6 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>   	else if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_ZSTD)
>   		features |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>
> -	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> -		btrfs_info(fs_info, "has skinny extents");
> -
>   	/*
>   	 * Flag our filesystem as having big metadata blocks if they are bigg=
er
>   	 * than the page size.
