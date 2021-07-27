Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAB73D7322
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhG0KZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:25:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:55239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhG0KZO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627381510;
        bh=kfM7XvERjnFrcvWTCCSV2kYaw33PGHc7cQpXoEBlQLo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ddGdBy6M9X/4MsETo6X3ZLJlHQe1Cs6lFzI/7hAJL9vgQ4/TRJZLcUxMaY4TNVko1
         004QngpTFY7vz2IodFJ5mL78pVdUYacdnrfgVhKzaNJa134va8u7Sc8BLOeqdT7wEb
         j67zrKHfzpqqLeFhWfCUtx5k3Gr/BCrdDk9jp0BM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1m839g3blZ-000Mzw; Tue, 27
 Jul 2021 12:25:10 +0200
Subject: Re: [PATCH] btrfs: remove the unused @start and @end parameter for
 btrfs_run_delalloc_range()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210727054132.164462-1-wqu@suse.com>
 <20210727101509.GP5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1c41b21e-4900-eab2-8f01-8e54245a570e@gmx.com>
Date:   Tue, 27 Jul 2021 18:25:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727101509.GP5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+8e1HhTcaVd8HAp1Nr2nFNkcduQmf06kLQhSPNeyVCdELnpLmKp
 I0EYU2E5kMwMALczo+PJzASOFOz9HY74cFxi/bW7XkqFHw8IGrfoGmAY9UuhD8xiCj8j9RG
 x10qASFwpm4HwIeRY74PRj75cTgaRUxKzpWrnrm6zMRL+QR32mD2WzUZ6cU3WmFdew0/JjV
 cseSLt0mG74HgzVhv467w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQPjwmXSNSc=:G4GpA9Zke6Cf85iDF/NQUm
 J/dhE/4Si780ApQiRnOT2WBgkYqz6BBhQEucT9sEYZ0GJCsqfiacQ4d7pqoJA8X2q2XNPONSN
 lRdNVjyK15ruhZkIUSAgpcjFf44D26EmpEI9sXEJ52lSg8zOJZEhiqlA/BZfwonsZ8ibsySXf
 heXxNOl/eqSiQcFl1dNnA9n0On10se3XGAWO4XXvKLT54c75uNV0YrVysiMF3MmsKAW6WQcG3
 DfMrBsCACzr1yJYKrJBchOQ1368NOnkl0NBSGzwzQhKA4czphvlaTbrswwiLcrSIX07VodJZy
 4SLhRxdj2QLQo0gRzTpRk3vWQWGsy/LuzXoKcuwN2Qfl54iERwCPNurpYz6BTRTzVpeazvgSp
 ksJuNg8nFyEjGejjuEDaLPHn+9FGjyptmSwUSp0nSrW9P6ytnGIdT4Wj62i4/sBsWSaIBfj4N
 Q3Csfb5eBuIyaV3axhHNcpmYmsQ0lQozb67/jX9bsQg//u0Xoo4iCYEigoDlVI71VH0YSoB+W
 5Q8FOt/kAv/jbzew/zJb1NHh7IsDNroFcJkmolwphFiNnYaDoo3zZ1DVJG0lkKIXw2a8as0lA
 nIjFN+fcKhZp+4VjYz8UBWyR96hfu7Ba86DtpUN1FmDmiAJ35AywzuQR2RoiMlQTOrOnIVV/C
 ToDu0t7uYnoj8J3FOkbVDTLO76Io5Px1LLFSjhwOk4wptgVIwgXftW4B1dQ0/nu7n5hgC3nsN
 kGS/ZIvrSnzi22SwcWcQQUbB6VrGW/lhbF+QR8WO4+/Sgqojayj6ia8/0E0sBdFBk/032/8uz
 zeJT6maEaN6Tg6ZRHKQgOUmIQ+pQAOCTpOhpJanpDweiIZiTLlVD4rjmOJPigCN/wOWr2z+UR
 FFZD5GkSgxBQQpJjMwauPbmrZazfAk0OvprULPsm8zEeO+tXid8YsRLO8AzA526pE62DsJVkS
 22KYh2HbRGzT527AR5OIr1ikbnPQ5gxPXyHgoCzN4Rjns3wdqWl18KKNoS31aLgZlZTd8jN6N
 AAL4IsWAge99/KSv8ZBquADkn7OGJc9MKA9BhK5ii0W2voBmlit9CEYsByQkSEd1bmUZB5P7l
 9+nXNgkwShDE/d4YKl9qJaZoWvFYmlsYJJelyhbLHjvkW0lNUSgy7+wgA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=886:15, David Sterba wrote:
> On Tue, Jul 27, 2021 at 01:41:32PM +0800, Qu Wenruo wrote:
>> Since commit d75855b4518b ("btrfs: Remove
>> extent_io_ops::writepage_start_hook") removes the writepage_start_hook(=
)
>> and added btrfs_writepage_cow_fixup() function, there is no need to
>> follow the old hook parameters.
>>
>> This patch just remove the @start and @end hook, since currently the
>> fixup check is full page check, it doesn't need @start and @end hook.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Then at least start can be removed from __extent_writepage_io too with
> the following
>
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3828,9 +3828,8 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>                                   int *nr_ret)
>   {
>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -       u64 start =3D page_offset(page);
> -       u64 end =3D start + PAGE_SIZE - 1;
> -       u64 cur =3D start;
> +       u64 cur =3D page_offset(page);
> +       u64 end =3D cur + PAGE_SIZE - 1;
>          u64 extent_offset;
>          u64 block_start;
>          struct extent_map *em;
> ---
>
> There's no warning because start is set and used.
>
Awesome finding!

Will update the patch to also include this one.

Thanks,
Qu
