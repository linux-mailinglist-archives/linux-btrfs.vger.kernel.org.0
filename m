Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C365E75A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiIWIXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiIWIXj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 04:23:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC5E0A0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663921412;
        bh=vG8GA+HJh5ocBsAilsJtlqnyOyrFX5PvcMfWwRiLuE0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ahv4KBq835jXb0DYcrXqLiJ2kMb3Mn768vpAohwIWEaevhybRTcz20BZefDAEffv9
         O9N/Pc1gMyN1bnIgFnxxhyoDEwb56DtbYhMwb51Ii5Yz0z4NJH0iSWAFDPO1MOOOKh
         JtULY3J7zPompXOO8A6FGmFVaktHQuN62Vh3nKCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1oixaY2Ax3-00RrLQ; Fri, 23
 Sep 2022 10:23:32 +0200
Message-ID: <9d52f9b6-e313-36f5-6796-6b1fe3b824f9@gmx.com>
Date:   Fri, 23 Sep 2022 16:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] fixup btrfs: relax block-group-tree feature dependency
 checks
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220923113120.DC30.409509F4@e16-tech.com>
 <20220923072607.24584-1-wangyugui@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220923072607.24584-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34yxvqjcdrB9T/K8hfVqT4UYp/nM0ulgO3OHgL5uHnIs2Hm5iQW
 y9uZ5eO2//PrWZqGElmZcXyOfaSj9+vaKasH3wu8ujnNs62sVCdR3wsVH3SRABV3y3wTdhf
 8c/Kkd9f9NFY5fuBjsxKVeaVis0hTBG8Fx1qNei4P/9wc0+PVW2Iy9hnpi1xMWRouldooaT
 epsJzAO63ZjdH35CN37rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4iw0wbxL+l0=:6tZAuo3N2NefbFS3P970dX
 O8UJjcsOi28eu07ve0cFEVIOW1IwGOZs0FiBdCJoeIJi8DG1+swGKBnaaJewlkgHniMgkJgfY
 fcELB+7tQC/A0j5PhmbJldSOi3Q7DiwcGLqWgmNfFvFSHgbm4gUt4BqAZ17N4ejOHispxraVH
 vsEIe6m4D5tYmz2SDJD794zWPAXXyaWuSeZxIDolU/ORgC2qZdUhmw2PgbPEaHT3K8NjPveTZ
 FL/HnDxMZOVdr5zf4JZUPustE1LBk/YvXsHYEjE7UkiWbHlLG7OqLCtjao7oEsvFkxynSJ451
 mWTT+8hvPvyeCJgZA77GYBVCG+Ij7YOF/UIyaKw3Dp4pI2WsXmf53MorDsQm+NydaP+5ckHQc
 igJmuR5BPYiHt8HR5uvQWZp6sHWpBqDF3+2EZoUt2M9qYW0Ca/8MqZ53Wn6qcXXIcLovN+xAe
 pRB4efEkHeQ5nyC8cigq6i44wGLWUN3b8V8qeFdYbgaFRXVDPbAAaGUI+COPKJD0gY43FOJpw
 xD/887QoWW0d40wCRh88MzLVj+w6S2MM2pKszfwwV8EpfBSWM47wbRdzafDkT+BbJlGGuZHJK
 2t5Q0KXONhwiVj3kNoJdRW6aibci2s5Hn+twjGe0spIyLv8AMmI/SvtnzhhCnWBsyxeYgd8xR
 wqKN/EvFUPAkUNRu/7UfqrcewtNPgRIi6ouVjqQgMn1gSXhvIeDFJq64v3vKsfrIgrxt2oYK9
 kOzIURVDF8m4Ebu7fz3ONIImffCOG05ChHgNZ28Ub801sb+Qcwy00XPSD1+V4U179/n3wg7SL
 MnJJQ/s3i1mizVp2bAwQXDx9AG0Xf+vsfcfgCG+/sEUfdrmgZCNbhG7kKgbQvOz0RlzgVsHmI
 5CbhA6zkKwOvpHit53jOSO9bmjxIPIyyHiu5JkTbTHadPSfNa4cpt8x1QETi/ld8El6iOj/p1
 3xhJQ4rU8nQky4QcgJqV7UDr21B7UN4UO6Jk70IUUdIFtKFgXrTGJPWSoE30r9+wdC3l02BCd
 ostcaK94m6nR/hG7L7HOCPzgXU26FKI5K7L3MlS/k8Dwahpu+AqllSSxODjsf7buuTv90s6Wx
 NGZ3B3wbCWQPdGKc7WE2zFhd/CZof1rncJ4Xwil5OMYoKIGU/gnbB7y+EkiqBKl/nPFAh9u9f
 a4/tlvRnZtgdGRQcnwrlATxrtI
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/23 15:26, Wang Yugui wrote:
> btrfs misc-next broken fstest btrfs/056.
>
> dmesg output of fstests btrfs/056 failure.
> [  658.119910] BTRFS error (device dm-0): cannot replay dirty log with u=
nsupported compat_ro features (0x3), try rescue=3Dnologreplay
>
> there are 2 problems.
> 1) this error should not happen.
> 2) the message 'unsupported compat_ro features (0xXX)' should only outpu=
t the unsupported part of compat_ro.

The root problem is just the last check on log replay is checking all
compat_ro flags, not the unsupported one.

So the minimal fix is just to fix the last one with "&
~BTRFS_FEATURE_COMPAT_RO_SUPP" for the compat_ro value.

Anyway, thanks for the fix.

Thanks,
qu

>
> so fixup a4c79f3f1c2a (btrfs: relax block-group-tree feature dependency =
checks).
>
> please fold it in because the orig patch is still in misc-next.
>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>   fs/btrfs/disk-io.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c10d368aed7b..9262d7af99b0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3311,11 +3311,13 @@ int btrfs_check_features(struct btrfs_fs_info *f=
s_info, struct super_block *sb)
>   	struct btrfs_super_block *disk_super =3D fs_info->super_copy;
>   	u64 incompat =3D btrfs_super_incompat_flags(disk_super);
>   	u64 compat_ro =3D btrfs_super_compat_ro_flags(disk_super);
> +	u64 incompat_unsupp =3D incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP;
> +	u64 compat_ro_unsupp =3D compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP;
>
> -	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
> +	if (incompat_unsupp) {
>   		btrfs_err(fs_info,
>   		"cannot mount because of unknown incompat features (0x%llx)",
> -		    incompat);
> +		    incompat_unsupp);
>   		return -EINVAL;
>   	}
>
> @@ -3344,10 +3346,10 @@ int btrfs_check_features(struct btrfs_fs_info *f=
s_info, struct super_block *sb)
>   	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>   		incompat |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>
> -	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
> +	if (compat_ro_unsupp && !sb_rdonly(sb)) {
>   		btrfs_err(fs_info,
>   	"cannot mount read-write because of unknown compat_ro features (0x%ll=
x)",
> -		       compat_ro);
> +		       compat_ro_unsupp);
>   		return -EINVAL;
>   	}
>
> @@ -3356,11 +3358,11 @@ int btrfs_check_features(struct btrfs_fs_info *f=
s_info, struct super_block *sb)
>   	 * should not cause any metadata writes, including log replay.
>   	 * Or we could screw up whatever the new feature requires.
>   	 */
> -	if (compat_ro && btrfs_super_log_root(disk_super) &&
> +	if (compat_ro_unsupp && btrfs_super_log_root(disk_super) &&
>   	    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
>   		btrfs_err(fs_info,
>   "cannot replay dirty log with unsupported compat_ro features (0x%llx),=
 try rescue=3Dnologreplay",
> -			  compat_ro);
> +			  compat_ro_unsupp);
>   		return -EINVAL;
>   	}
>
