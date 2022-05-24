Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837BB532B29
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiEXNVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiEXNVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DB19F95;
        Tue, 24 May 2022 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398492;
        bh=+/FHnf/kkD+0V6dOVPNcqx1KXGbnj7ptIzcASeTBjn8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Zr82zvK7RBGdkK2uPhGIWCfXr9U8rMd4Etwo3+ixm1KkIig43X31LOyY3m0KDxSPH
         HAaQV/p3d0lvoEcQ7ogUOtf/DV/qEvuym8qlNiogYW8RFVED2HoFOswyYt57pdlGUJ
         V+hmQ2eAi4lYUHvHaCGend0lI5MfBJtkCXUM21yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1o9dLc0OOR-00KflH; Tue, 24
 May 2022 15:21:31 +0200
Message-ID: <118b026d-702e-d219-1101-64ba302554c1@gmx.com>
Date:   Tue, 24 May 2022 21:21:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/9] btrfs/143: use common read repair helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MCqHpjXOEvRuRzq8jgTD1znbMiA5R7Yo0mVcciR8BhiJsj3MPp0
 iKzKJ6zrk8Fs7lv1bh9B5m91nXHBoDx1/f95SdEKGdoL1PA5Yw4XDERCNpp9YhbkXRp4uIF
 C7RJ8tbMzqlpXkRwZwkjjRXsm9XnpCbdU23HEqcDkhXF+XcFOPvymMBQQ9Hkt/aTCqDtY0S
 5CZ8qqmQLQh2dRCkx6udA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vgnku79arlg=:l588uhEjixpM2uH1mCcZ8x
 nFEXJv6/SGRDjEnonHhSf+xAj1qPmVMhEp6edm9yfsoJorOG92w08A/RMfKcxNbCQn9gRqiSf
 609WMoE+5b//BNyT1cvqjA5HD3DKyCRXxuGDgsbeGTvnWdZAEQzJ6iX5/s96VW4YAMIZh5Xdh
 ZNASVJR154cwGeqfoT/ibKq6ZYDfS0y5g7vVG73Zh2AoIaONuHFwRtgtQncf0dq5sGPSemBmn
 TxAs0UCQAkAHJEG/m4YH36ZT6rBSMx7/ZngW4Sqw/9XRDCMiwsyx3+KMfAjQqGIeY2DL2FrSt
 TYQjMUClU18X0yraQ1dUjMIsYW7u0p4Pf5IIJAv6LIhjgp081Rp4FEGJJe/pFDGHwobWSAmbe
 8xtxeWPT1+eh77rha4MyWmbN4g2xZRusZ9UmvbLTwP3JTOwgGpjKUCFOVMRQK1G78pJL/6gNQ
 uzYKgzaXon1WBix/QGqOCbHRoJ8oFfBDI7MAwnAxqWsX7qfA9c5HVx9yOlnzsVNFOAgGHcSlX
 EFWMUe7Bv/RdPJK2zTcR2xXzyd9mnEudaP2V1vt56Ydy0WWCzd4W/zhrP6f5XpcX8SWhAmwb1
 0jWbquRTnfy6eCXftfr6bWe0aIF2nW15Qi87uCFN5pG30pAZ1OQDeiQnQ991MnzcAyKHJptpd
 tyEuQxjL/SyJjCg1/ja11Op+CBwwQ2MHbPVGbnBPE9/JGVTOTde6krRZsemNVQLc/LAa4nE7V
 A+kWN911CP1BPHdj7JTy0MHZJFZixTQHIsCickXdnXvAjElKEfqubn1eSOaDdM3W6FuWtz2VJ
 b08bR5BlIkcQa05idFO8IiowOJ5GSaam2oxLResulI/+AsA9n/iaZwMZo17NEHKpnY6+Galji
 jF3Fnhcp+PkugfJ7Oam6yDZeHfTQ64nTlRraRW97/5yJevGgmYl8PUDlYzCwzsPWlK/mQcBJE
 QxlOsTZKUl+xJKFOhY6GmR/mtPv81ay6CMjn8guqmFi2URpKVYhBi8DzOTsg/+2QG8HxrIE3V
 B9ef0y2tf4eLj7TLYUMCQGyxs4bZ7OHJu5paTJkcUtXSwaf6upLiGI2TDpoPghtWLmCYe4/WB
 uNzvIFlPiFsg3BgCBxkjrW8ZnAkxPve1uxXALTB7VSDuTI74P9Vip8HnQ==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Use the common helpers to find the btrfs logical address and to read fro=
m
> a specific mirror.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/143 | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 71db861d..b6ff2a42 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -34,7 +34,6 @@ _require_scratch_dev_pool 2
>   _require_dm_target dust
>
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>
>   _scratch_dev_pool_get 2
>   # step 1, create a raid1 btrfs which contains one 128k file.
> @@ -53,8 +52,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" =
"$SCRATCH_MNT/foobar" |\
>   # step 2, corrupt the first 64k of stripe #1
>   echo "step 2......corrupt file extent" >>$seqres.full
>
> -${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_f=
ilefrag | cut -d '#' -f 1`
> +logical_in_btrfs=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   echo "Logical offset is $logical_in_btrfs" >>$seqres.full
>   _scratch_unmount
>
> @@ -74,10 +72,8 @@ echo "step 3......repair the bad copy" >>$seqres.full
>
>   $DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
>   $DMSETUP_PROG message dust-test 0 enable
> -while [[ -z $( (( BASHPID % 2 =3D=3D stripe )) &&
> -	       exec $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/fooba=
r") ]]; do
> -	:
> -done
> +
> +_btrfs_buffered_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
>
>   _cleanup_dust
>
