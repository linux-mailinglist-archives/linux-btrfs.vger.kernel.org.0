Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FB3C9A49
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbhGOIQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 04:16:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:56711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234408AbhGOIQU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 04:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626336804;
        bh=4gskJI/LX3XGmnr5QK8PP3ShwEGMJndl6Y/nd9GlhJQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kg7X/N62krtZy4X52JB9v76713svLpzgJukeHH8XorL9WuPUOi0xnzwrEb7COeKzZ
         6NCeAGZbTTIiY3as20e+GNV601UYqNTfgC2zUP+LkgjWS+mjAFo9wpmb/p9Cw3qy9T
         sfitgLJpsTyZlKXexX4sinpQ90v3qXNrdScv2IO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1lxrwz2aqU-00Ex7c; Thu, 15
 Jul 2021 10:13:24 +0200
Subject: Re: [PATCH v3] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Su Yue <l@damenly.su>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Zhenyu Wu <wuzy001@gmail.com>
References: <20210715050036.30369-1-wqu@suse.com> <r1g0vwm4.fsf@damenly.su>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d3b58bc6-5649-88b2-60ad-a2ed48cb60b7@gmx.com>
Date:   Thu, 15 Jul 2021 16:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <r1g0vwm4.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TPXBoQ53porCNXS2bHxiUOdUf0iU7koFaC/5zUxAg4HmIxnlTyP
 /IF5l8whqg3Fo7boo3BYbEHdONpTx7195m+3REH0DxHqsf4zX2c/zAuvGW7uzXf741q8p4V
 C3ieJJKlKfhw9BzoJBa+z03SkkXE3sqZD+SeOQkW1bRH8l1yi73mKEPgk2Juc8xVTavskJA
 Z37FvYL3u6vrExIyjQejw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:frJBhAouIzk=:4KV6yIHRrSuU+0xU9j11+A
 GxBRx3+l1xJEN/td6AAKL1J7Gtk8wyvt1g6cNyZUhdWyJsTkS5uDACeiFjr68jeftMR+7fcav
 +MVkEwVv6XmP3qY1UB1uel81zwde7mIgZA3e8xJfaHX1s3gFt6HKWu7wCZmPdxbIgD5hh7twN
 qiqO+UTvHKdChHrodbWBYgrduBz/hI50MYfD+qjFoYL92Tz6n+dALp7PmyaUMvQGTg+6Nsf+T
 nKl6jUlnq2kh97ufejtmSoPMZgf2kR5ZHSMC+77IlnsEdLcAW85k9LJGKDz4mij+EdmSk1XfH
 yKdQssDMRqrjbOj1MvGiWs6ympqCYH7tOMVKcFVnsS3YyJrOs1Gh8NIJBOVVwrZxtPzBHRKwi
 2LdUOmJMKgmNO6pQM+5CUXISXhDbWVHF0hgKXMj+b+JwJtAEQaABqCMzW9dGYbiM5cEb1NAbs
 V4SlxzGTnmqTxVnsXKYiPYtmcsFGjaE1IxFURn4NVu/9I07wofPrLzNo0MWBKSmNymSCzyYX6
 G5ynhHgLwt9CPwPAJVWTxn+CjGSSCVjo+L12a26rqR4RGzbTBk5VDaBiC+S/4euLDTE7Rcvt1
 Klc5RKGK6TXNIPHPd9051A5MxDIRqi0cLyV3DAM9igkBCWcNjXpfILSljAkSH4+Ll3BEW1JVr
 sTvt3zzzOtZih93gG0tLyMjZDu7VsMnIYtX1jRXSSeOokyX18y3J8TfCsYCy14sgauK9MHTjA
 8QhJd3O0m/CaAB3MnLa0Gcx73lsQVBddBtiLSlAMK2jfBjvmHo5+xd3NeIV6v0iMV9nzdnjDv
 KzTbndxDf69LCioZNTPffwfa61ccgOByvBctTDAEY9Jv2uXPvn2hxodRAJ1IH+1z3MGi4CwJF
 E7ppX9N/c8iVPqi1s1rp/M8MLyVZFHllsINqL5Fs9bkj2LvC/4Icb5ujqsnHuN+Zut3slHkjd
 Xs6hovk9iuMdiOkEDTYEQf8p0rcLcFj6RoLdYA+Awcj524P9vjwZejZ3S1TP734n3iNsORNkk
 DPDbclZaYoeuH1Gq+lZsZkNIlO4vj8LOdE3SbdNcB7+i9ndIfRntZfdaNJe/WYWqk9w4AYZIc
 lrw1v6HLvy4ml/fhr1rw7OJzh96GqQMJJh2n+XUVFZ0oM/iJcZpfAdNbw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8B=E5=8D=883:50, Su Yue wrote:
>
> On Thu 15 Jul 2021 at 13:00, Qu Wenruo <wqu@suse.com> wrote:
>
>> When extent tree gets corrupted, normally it's not extent tree root, bu=
t
>> one toasted tree leaf/node.
>>
>> In that case, rescue=3Dibadroots mount option won't help as it can only
>> handle the extent tree root corruption.
>>
>> This patch will enhance the behavior by:
>>
>> - Allow fill_dummy_bgs() to ignore -EEXIST error
>>
>> =C2=A0 This means we may have some block group items read from disk, =
=C2=A0 but
>> =C2=A0 then hit some error halfway.
>>
>> - Fallback to fill_dummy_bgs() if any error gets hit in
>> =C2=A0 btrfs_read_block_groups()
>>
>> =C2=A0 Of course, this still needs rescue=3Dibadroots mount option.
>>
>> With that, rescue=3Dibadroots can handle extent tree corruption more
>> gracefully and allow a better recover chance.
>>
>> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
>> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Don't try to fill with dummy block groups when we hit ENOMEM
>> v3:
>> - Remove a dead condition
>> =C2=A0 The empty fs_info->extent_root case has already been handled.
>> ---
>> =C2=A0fs/btrfs/block-group.c | 15 ++++++++++++++-
>> =C2=A01 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5bd76a45037e..9bc68515bc4a 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->used =3D em->len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->flags =3D map->typ=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_add_bloc=
k_group_cache(fs_info, bg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We may have some bl=
ock groups filled already, thus ignore
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the -EEXIST error.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && ret !=3D -EEXIST=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 btrfs_remove_free_space_cache(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 btrfs_put_block_group(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
> So we continue to link_block_group() bellow even -EEXIST. The new
> allocated bg will be inserted into &space_info->block_groups[index].
> Then while calling close_ctree(), it only frees bgs not allocated by
> fill_dummy_bgs(). The bgs still exist in
> &space_info->block_groups[index]. Memory leaks!

Right, when -EEXIST is hit, we should skip to next chunk, not continuing
the remaining works.

Thanks,
Qu
>
> --
> Su
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_update_space_inf=
o(fs_info, bg->flags, em->len, =C2=A0em->len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, &space_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->space_info =3D spa=
ce_info;
>> @@ -2212,6 +2217,14 @@ int btrfs_read_block_groups(struct
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_chunk_block_group_mappings(info)=
;
>> =C2=A0error:
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We hit some error reading the extent tree, =
and have
>> rescue=3Dibadroots
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * mount option.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Try to fill using dummy block groups so tha=
t the user can
>> continue
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to mount and grab their data.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ret && btrfs_test_opt(info, IGNOREBADROOTS))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs(info=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0}
