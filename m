Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F962E6C90
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgL1Xlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Dec 2020 18:41:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:38117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgL1Xlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Dec 2020 18:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609198802;
        bh=aDqBvudFjh21IkPYt34uVr9xMWs7Roe0tlvu80Fj6Ko=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jfiKknGaNNZs7U6eshs9XkVyMGsaQ9sP1QEIYKHVkvg1pV3A55zw9tKstjpfYF2vH
         hZDs2wax67aENIakwP4oVh1X/MMC7BBRxicvTU1pRAon+H4D5dS4Ik3lq4Fvu2fOB6
         1B1bwOaNbM/hO6PHW/cAWvhFgNFHeJZ2KmNLEPGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49h5-1jukMq2JqD-0106cD; Tue, 29
 Dec 2020 00:40:02 +0100
Subject: Re: 5.6-5.10 balance regression?
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, David Arendt <admin@prnet.org>,
        linux-btrfs@vger.kernel.org
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr>
 <da42984a-1f75-153a-b7fd-145e0d66b6d4@suse.com>
 <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
 <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
 <2846fc85-6bd3-ae7e-6770-c75096e5d547@gmx.com>
 <344c4bfd-3189-2bf5-9282-2f7b3cb23972@prnet.org>
 <1904ed2c92224d38747377b43e462353@lesimple.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com>
Date:   Tue, 29 Dec 2020 07:39:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1904ed2c92224d38747377b43e462353@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3J0wGPGN8Dv+XKDyrBHKnDljNAOR3X46gMHfQmqKkNkLfrUnk3f
 X4kJA4Kdf+yhNOmZNikWnlPiYgSHXCsizhQ2+rOY2KKpEy+9gmuecLMhLYktiQJkfM6zIHP
 szKcIW6QPo2vUk9lvxabDZ/krAiMGNBc2O5dPQtr2AY2YZ4KfngJ0+mZ/AMzBWLpHHN3aP+
 MhCxfq1jJpJdMGz5NvO7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LiuASzQNM/s=:0Gr7hOIZUeyOx3yVHj4HAY
 kZa57Z5fltYIu5kbHP32NIkkTxs7VanNiTnP3EiHyKZUPD3gzradr8bhcFzuu8hJEJW/Sit18
 rRAXmOmqTQssw6vZLvJdH1XsCfqh4aqI5SEpsym93PO7otDzRIpXB7qTwF7eDDad3P8XlKrRu
 44EJA85fVW9pRLJET0i7bPgBkib37V4YOA3QXsdCypNTMhj09RpoLBFicEZQ45PBOdBRy6vSd
 2Vy/zaAirinDsoUdrOhiyxbNoPmNGouJGMDjDqAhUG5yQXcTBeOmKomqjMhWqCN6pYRNd/P+/
 RbiUtWWpljQLUVObkhpHVZoOszHCM+QtN5+vw4lSBiLh6uSRO9KFh201MCfiF21dpBBsKoFIB
 u/SFrQAyMOUrUiR/KpZYVU3uaOABtXOlJLq8PlJW3j/U4Wlozciy48qTqP2gzw/hss7d2VbpR
 JhRaKTvh6LEzP6tR6jjYOIt4tmUIMXuGyeXb2Pys3C/yzm2o44t90EBHMYzOPbjGDL8vvin+X
 Je/Ydqm2hm4vigM6mC7hCxmG63JaGCT7JNaV/BS2JSnTmo5gQNex3FL4fxUwzvzLXVLuCf0w+
 9waAwJhNqYhAF9xCqJkIuvXyrgzoDN6+cJ7D7gENzo3PsSYfzG27SAhLThJXk2O1Ss9GCsg9x
 F/551W5ZATJ9NilwsUAtuBaCil9XQds9QERIxi4HYbK3rWVZQx9HY98EsjvKo8bIgT5BLFPL9
 nieS73Jeulr3OR/JmPdFxe4YR5Mkz8twRFy6PsJYcY7YalQF6VGYg9AtJcbAIoCSb/opgrwH2
 RZTEYQl83vUqz84M5tXPLKT02fHKrl0X05hNTDvfz0oSCYC4Qcllm7G3XRmE53QHiMdztG9u9
 BPKeGXhjLSGB47j6UYOw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8A=E5=8D=883:58, St=C3=A9phane Lesimple wrote:
>> I know it fails in relocate_block_group(), which returns -2, I'm curren=
tly
>> adding a couple printk's here and there to try to pinpoint that better.
>
> Okay, so btrfs_relocate_block_group() starts with stage MOVE_DATA_EXTENT=
S, which
> completes successfully, as relocate_block_group() returns 0:
>
> BTRFS info (device <unknown>): relocate_block_group: prepare_to_realocat=
e =3D 0
> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D 1=
, btrfs_start_transaction =3D ok
> [...]
> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D 1=
68, btrfs_start_transaction =3D ok
> BTRFS info (device <unknown>): relocate_block_group: returning err =3D 0
> BTRFS info (device dm-10): stage =3D move data extents, relocate_block_g=
roup =3D 0
> BTRFS info (device dm-10): found 167 extents, stage: move data extents
>
> Then it proceeds to the UPDATE_DATA_PTRS stage and calls relocate_block_=
group()
> again. This time it'll fail at the 92th iteration of the loop:
>
> BTRFS info (device <unknown>): relocate_block_group loop: progress =3D 9=
2, btrfs_start_transaction =3D ok
> BTRFS info (device <unknown>): relocate_block_group loop: extents_found =
=3D 92, item_size(53) >=3D sizeof(*ei)(24), flags =3D 1, ret =3D 0
> BTRFS info (device <unknown>): add_data_references: btrfs_find_all_leafs=
 =3D 0
> BTRFS info (device <unknown>): add_data_references loop: read_tree_block=
 ok
> BTRFS info (device <unknown>): add_data_references loop: delete_v1_space=
_cache =3D -2

Damn it, if we find no v1 space cache for the block group, it means
we're fine to continue...

> BTRFS info (device <unknown>): relocate_block_group loop: add_data_refer=
ences =3D -2
>
> Then the -ENOENT goes all the way up the call stack and aborts the balan=
ce.
>
> So it fails in delete_v1_space_cache(), though it is worth noting that t=
he
> FS we're talking about is actually using space_cache v2.

Space cache v2, no wonder no v1 space cache.

>
> Does it help? Shall I dig deeper?

You're already at the point!

Mind me to craft a fix with your signed-off-by?

Thanks,
Qu

>
> Regards,
>
> St=C3=A9phane.
>
