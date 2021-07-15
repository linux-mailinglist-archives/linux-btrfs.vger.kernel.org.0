Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7203C97C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 06:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhGOEz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 00:55:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:47429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhGOEz0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 00:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626324748;
        bh=m+EXklr8Rcbi5MDRwbs6akfIicEVojfa6gzZsz5g/XU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EzqRLyQ824nzQtwffo6RXftElZ5QRymcacAxcHEUZLDIhEaBpoQhsMnMKPpwT6Fkp
         v8S4kddaGFiNMIVBdffdyJoZ2TwWg0ZNR73Y0vl9V6tyHOnmCeUNud0d21jFRh5hyH
         RgtqX/32p0vbWnywPM+tXUTnKqZ9Kc1ucC8+6fBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY6Cl-1leK2L0Qfd-00YUdt; Thu, 15
 Jul 2021 06:52:28 +0200
Subject: Re: [PATCH v2] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210715022848.139009-1-wqu@suse.com>
 <d3d1dfea-2858-0877-e671-73ef1e1ec7af@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4808cdac-986f-ee84-154e-5a4d90b6a06f@gmx.com>
Date:   Thu, 15 Jul 2021 12:52:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d3d1dfea-2858-0877-e671-73ef1e1ec7af@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KIsn9/xLk1/T1i4pIn+LzModO5qLDVOkuuMapdB+uiLYI5EjdgE
 VumFXMvrw3YRLLwkgWSOafWmMsn5ARmJcVxH3XhXut8e2WuSsvEzF/omrUMhfFSFZnx8+Sq
 A6O58xgfEcPh9QHf+EmgcMiUTnQeyqKWUjKZcikzo+Z5vPrPOk9uufq7ZEsC0g4JOTZ0FJh
 FRZ0K1CVKcEF9zEzD1iIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbUMLulEmE4=:cTTw7vlzfm3EkRtRjTSNhK
 b8Fl/UVlN2kMhMjvEhv7aYXZYoDfQRAr12MllzgmSpR3yAsDBm3LsZ5Rx8D4S4s5WXZiLlhV+
 5C3ImOeGmGH8YvrhX8kDPnEPCN2mNArfqyeeyZ45Z4lynbO315tAG8a4e0khinmdog6OGjXV4
 DX7OxxA0Zq/SiD4tNWt4eMICzMPvb5Y1Y3Yn5WxPCD7zqAzOTAhLK9SQGvCDJvrwWroK5UCFn
 Lv6qnZFNeUXf1TulXz5/OtJ1WdBtvpMiLWTO3uJ8M6ILKNlO09U/66Mhn3+FCPP1wS1U60eI3
 SlN740eoTQsZ8BDZ9/kHMBrxb1vNUwgTh7WMN6WZvaBFlCu8myIrDIShkqsTwgw7LBdHrLCfi
 GKHwE7als+Z3SSf5yy0HfsFFTALVgXS+6FYrNmP/xU+ehtD7KVnSeJu7nz20pzETeuO63MJG3
 Ab2fNppbZ+SFEMVe+boGcwgUfEvvI6BoTE0lVOl5TZ/OyIlWIkSDaCz0vf4vKj1yFyQHuVC6i
 18OoM42l6nWPU5Ekx+4WsN23wKWvcug4IGOO5aCid3gEFAuq8T15Ay6hhyigH3dMN6bS3NGOS
 hgMieCEKhj2Xthn220v/3scVj5fmbuOxzrxF/xoXHAXE5+0s5BofyucZ/9lrvzEw//+Sw9AWt
 MOHun0Z1F7l0WDGko8j8Zd+Vah42JU87py5htRfuX+jR7YSYsMK4wuWRBH0KJBRRB19WCE7Pe
 /HutuxNmitFisaVXcAUCr1pjtO7Fkr9rgt+zICQKOSu+0kWrGa3Cz2DZrzAWuoFPusVVJ09LF
 Tmk+Fw8E5IYUTXiU9w/OzGaJT0Rqnw3v13BCr82Wh4SIRoRmAIqppriNJbrHIeAMUC3lqZbLr
 QZe3OrTipA1jmkGZ4kjXevKD6crUwGTJOOtwwqFXplhtPScluqf/ROSGSFYWn/u1aR+qvZVmX
 vrPld2O4eTFUQO6no1smjLssXgSx40FmmsJPdNEYpyENYuESrXQ8fDHSHgSWI2k4kQUeCa/x2
 Rz+/0mbLLMYw0J10ftTtoPsET5a6Jg5JVlig7aEoBmiyU9T5u/ds3Nhana2S9DXN5E/YDW0Xa
 kf7/NyFWL9HgyMY/Bgps9ZwFv7VSEyQRe9+JF6Fuw2+9tEKiVZLdPhImg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8B=E5=8D=8812:19, Anand Jain wrote:
> On 15/07/2021 10:28, Qu Wenruo wrote:
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
>> =C2=A0=C2=A0 This means we may have some block group items read from di=
sk, but
>> =C2=A0=C2=A0 then hit some error halfway.
>>
>> - Fallback to fill_dummy_bgs() if any error gets hit in
>> =C2=A0=C2=A0 btrfs_read_block_groups()
>>
>> =C2=A0=C2=A0 Of course, this still needs rescue=3Dibadroots mount optio=
n.
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
>> ---
>> =C2=A0 fs/btrfs/block-group.c | 14 +++++++++++++-
>> =C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 5bd76a45037e..240e6ec8bc31 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->used =3D em-=
>len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->flags =3D ma=
p->type;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_ad=
d_block_group_cache(fs_info, bg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We may have some bl=
ock groups filled already, thus ignore
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the -EEXIST error.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && ret !=3D -EEXIST=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_remove_free_space_cache(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_put_block_group(bg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_update_spa=
ce_info(fs_info, bg->flags, em->len, em->len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, &space_inf=
o);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bg->space_info =
=3D space_info;
>
>
>
>> @@ -2212,6 +2217,13 @@ int btrfs_read_block_groups(struct
>> btrfs_fs_info *info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D check_chunk_block_group_mappings=
(info);
>> =C2=A0 error:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_path(path);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Either we have no extent_root (already impl=
ies
>> IGNOREBADROOTS), or
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we hit error and have IGNOREBADROOTS, then =
we can try to use
>> dummy
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bgs.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!info->extent_root || (ret && btrfs_test_opt(in=
fo,
>> IGNOREBADROOTS)))
>
>
>  =C2=A0 I missed this part before, my bad.
>
>  =C2=A0info->extent_root can not be NULL here, which is checked at the
> beginning of the function.
>
> 2138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!info->extent_r=
oot)
> 2139=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fill_dummy_bgs(info);

Oh, you're right.

>
>  =C2=A0=C2=A0 So should be
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && btrfs_test_opt(info, IG=
NOREBADROOTS)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->extent_root =3D NULL;

But this is not needed.

We can have extent_root if only some extent tree nodes/leaves get corrupte=
d.

Thanks,
Qu

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs(info)=
;
>  =C2=A0=C2=A0=C2=A0=C2=A0}
>
> Thanks, Anand
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fill_dummy_bgs(info=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>
>
>
>
