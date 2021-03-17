Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF933FBFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCQXuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 19:50:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:46219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQXtx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 19:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616024975;
        bh=uQy2IJrGeO8wIQItIx+2y0cV60IFwhc9/SJwP1eDCcg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W34pltpX5QRvgFlfI2zqVPVQ5TgTUYmwt9wvPXp4FNh7pXcQqhJs5QxTS2hClgXOH
         vd1eGmAKcJN77Qgq02zmLKXMDdILX6LegnvhYU0lg/mNLYZtqUGzC/LcmP4tk7V01e
         kflv/hjGwlutWZLDcXt++aBUsjYF+ZmEgiBbhmT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2V0H-1lq4LB2NZf-013vtk; Thu, 18
 Mar 2021 00:49:35 +0100
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210317012054.238334-1-davispuh@gmail.com>
 <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
 <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
Date:   Thu, 18 Mar 2021 07:49:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cDEum2fnhp1094X7TyNDbCZKiOUpYAfBlfqYkKoVifF3GFQchOx
 uPIZzYj/BGDIv4HKjwnkxomz/mpQIPkTjS4AYtQZHeiIIIs84GKkBrYeICMEceGsGAjkPHy
 ysFCxzegVXbHU11EkGVrGeh+Ru8sr5vGqNP+C95VVJgsoquaKRCS19YhoddFFJDo6mkv0mb
 j1ygW7gH6gs2g/mtb/q8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RxC0gFOoub0=:LOoa0KPWouP4XZdXSth1wo
 Ahg3jyG0DAAJHQp9/PPJ8ckQLPpjXkZFpgOuENqJeB3t/u2HPIpddb1I1PINr+s8zyNHs9qho
 YyvtVpeWAUCO/ddMkk8eqiodu5KBrHYxf9JOahKcI2O61OGCMatnxAs+6F84CQF6yAQyWewZr
 tq0xBiHrlRz5HyVsW8hLOwxI3fBKcEoTrH8XVJkMh4iut77cLuvkr3JPpyBcx7q4IGB3cOpAF
 sQD1SVaP1yOG3Lm4W/GashTMJ+ojXAxUB1q8HYhsZ36jVyKtDpU1gSs60cxKYjIeaiWAe0BuO
 jFUiqods1xKQNVB4iod1xEYrHqW8+Ex7a6uIGHNi6PJYibRugH8MT0591umfFwafiw+1FEyae
 F+8IeY26MdpTzxA9g0SQuqijM4xbFY4+hrUOTzPNHVm1x9qmyHBvEXPBZS+oBCfYWydB7q/qj
 AAkcoIWi3U4vysfTIl1hb902WxPWQdIZZZwrl9+rsjLG9q969YXOXXNy32KC6cwlW+gp7w34W
 DiGjFMezqZYfYluFYaHwPj5PlqDbofDteoLSjIh0wHiIBwnYBoxivJanKYED58uzs0cDamshl
 SBUUMknxFvXpBoRRfnafJyBL267X8w5YG23UEOP7sxI1dK8/HPKCAd8SnFsB5jbhUmKCuihV9
 yD6Dqi8xCPr8g2InlN/xpJrpVD4rGQGGlm0EN8zRzR27p4v3CvS/BuxAnkLF1mVt+pa7UHs4h
 4OG27WTXYAdUxCT7yJ2IGonWqJWVQ2wLFMh5GQ111CZM+Ox/JI+emWDTyQtFWTUxQyAW04HM8
 UFPfNLaEbldNFsIy7N+Liwcb+y43gp7tkaPMH5dWICZwcbGUN/iBreItN8X3iFQo8haNo33x+
 Pxm6UiMXCUjE7LPUjI1jmzmbvkNACzCeyrXT4AewER1I6jwD1wt3xvB43RGlDfmPoIRmQinAZ
 v1K+TMCd8Qoj0OpxdcnGDD+qs8sp7etS4yNdTaWJHni2/EX4nut+1ndF1Dak51oAgejUPsPOr
 tgE9hU/uTiV2CMc5EJVISUZMITFrXwCYRvqeQs1keBi4uSTmCqXwdggD/YofwYXKzdHW8ayOZ
 iuP1fSX1yYTBtlakoxg/7JMr3KKfOLAVfOYT89iwhr+XOluKkmkLXGnusCn2ncSRIlEFz4NFg
 HfVYs/4bbkDJnZyNd+dfE0cGxlhpkbPhzeTxbjrCn49LQ32t5hJk5UHMfP3YhmM5Sk2WlnLAm
 XB3Ty924kV8bOYaQp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/18 =E4=B8=8A=E5=8D=885:03, D=C4=81vis Mos=C4=81ns wrote:
> tre=C5=A1d., 2021. g. 17. marts, plkst. 12:28 =E2=80=94 lietot=C4=81js Q=
u Wenruo
> (<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>>
>>
>>
>> On 2021/3/17 =E4=B8=8A=E5=8D=889:29, D=C4=81vis Mos=C4=81ns wrote:
>>> tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81js=
 D=C4=81vis Mos=C4=81ns
>>> (<davispuh@gmail.com>) rakst=C4=ABja:
>>>>
>>>> Currently if there's any corruption at all in extent tree
>>>> (eg. even single bit) then mounting will fail with:
>>>> "failed to read block groups: -5" (-EIO)
>>>> It happens because we immediately abort on first error when
>>>> searching in extent tree for block groups.
>>>>
>>>> Now with this patch if `ignorebadroots` option is specified
>>>> then we handle such case and continue by removing already
>>>> created block groups and creating dummy block groups.
>>>>
>>>> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
>>>> ---
>>>>    fs/btrfs/block-group.c | 14 ++++++++++++++
>>>>    fs/btrfs/disk-io.c     |  4 ++--
>>>>    fs/btrfs/disk-io.h     |  2 ++
>>>>    3 files changed, 18 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>>> index 48ebc106a606..827a977614b3 100644
>>>> --- a/fs/btrfs/block-group.c
>>>> +++ b/fs/btrfs/block-group.c
>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_in=
fo *info)
>>>>           ret =3D check_chunk_block_group_mappings(info);
>>>>    error:
>>>>           btrfs_free_path(path);
>>>> +
>>>> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) =
{
>>>> +               btrfs_put_block_group_cache(info);
>>>> +               btrfs_stop_all_workers(info);
>>>> +               btrfs_free_block_groups(info);
>>>> +               ret =3D btrfs_init_workqueues(info, NULL);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +               ret =3D btrfs_init_space_info(info);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +               return fill_dummy_bgs(info);
>>
>> When we hit bad things in extent tree, we should ensure we're mounting
>> the fs RO, or we can't continue.
>>
>> And we should also refuse to mount back to RW if we hit such case, so
>> that we don't need anything complex, just ignore the whole extent tree
>> and create the dummy block groups.
>>
>
> That's what we're doing here, `ignorebadroots` implies RO mount and
> without specifying it doesn't mount at all.
>
>>>
>>> This isn't that nice, but I don't really know how to properly clean up
>>> everything related to already created block groups so this was easiest
>>> way. It seems to work fine.
>>> But looks like need to do something about replay log aswell because if
>>> it's not disabled then it fails with:
>>>
>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
>>> errno=3D-5 IO failure
>>> [ 1398.218828] BTRFS: error (device sde) in
>>> btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
>>> errno=3D-5 IO failure (Failed to recover log tree)
>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
>>
>> This is because we shouldn't allow to do anything write to the fs if we
>> have anything wrong in extent tree.
>>
>
> This is happening when mounting read-only. My assumption is that it
> only tries to replay in memory without writing anything to disk.
>

We lacks the check on log tree.

Normally for such forced RO mount, log replay is not allowed.

We should output a warning to prompt user to use nologreplay, and reject
the mount.

Thanks,
Qu
