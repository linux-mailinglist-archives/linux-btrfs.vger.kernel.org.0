Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F1532B2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiEXNVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiEXNVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BF19C35;
        Tue, 24 May 2022 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398476;
        bh=k/DVv/5OHchR9TCRvuuH/VIzJ/mYD8rtMQfn33bKNuI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Bzy4ec9wyr9ElpfRUw0X68mQMq4ERkRy33sTZWnrNq5mX3HGdeDZW1w4olCzfgGRu
         TXVE3u84keEG2cXeLbBX31zkZEIhQxgY+FCuzkll4rWf7XqxLiNii6eqbmj5cfxU/R
         xL2o/TaGK3uYQ3paOHklchj5veSXJ9BnnqABQD6E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1o8XPo0opj-00LpW1; Tue, 24
 May 2022 15:21:15 +0200
Message-ID: <48103e91-6f74-ee94-b8d4-6a8ea8b8d8c6@gmx.com>
Date:   Tue, 24 May 2022 21:21:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/9] btrfs/141: use common read repair helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tWpGsCTJPT4hJje1kPcWD+/O462tItzls7ZgmwL1/VFAcnlyrey
 SnSU4mixkw9qJA4HNPHbrQoO2p8e5fG0c1mrlSWihHkOLceGqjOPCELnnSVjqj4GTe7pg/W
 aOI5DJoudvyzZWoe5E6IJZkCJMblOZgTVqkfx+fYerGZjMKrfXll7dqAXKxMPBYUfZOlFP1
 1FUULBv4eCEREtco7g4Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SFJekPwgmo=:+Vwmn6RRtEvd6pz57x6GaE
 wbXeD/4tkKqZZRJJlfUTcqmdtBKV33PjU4SHDjEZ8Tx1Z8hVL3KWfeVa0YKfirJpIhdGybkn5
 EP6AyPEFaSXsLq6/I3QURV36YKWNunxlNhYmnSHoL86qqVvFAFWHONQSNVh0ETg/r1y/ivOB1
 FtQ0RJf7rHPflbJYYMT40+snOntpHB6LHtOvbK7E/mD2+Sq3822kZrhixQixexn9psqS1aGc/
 4dy6PW1K+7wkvtNudY+p03mltikj4FIFqMLdA4Sy55fO6WPztlbJn5K7scvSn3R+p1zUhINyb
 HBptyMFn+AmrmzCCmvsjEjp2qArmCMJgKifFcSUvYEKT0nD9qParQx6Q5V4wKHM9EctpckJld
 snJgCzx9BsHW5okw7p4G6jQyWoL+vy79u1tJbP1aWkO+TxPJxzJRHmb5As9MhIoOboJes7een
 FV9LnHMx85a/zRaPZjtMDG0IGQxoUnIOFolAM3KfeMOnoB0R7dnRN1czHofWcMsV5IPZqoURT
 aE9S0mQ35EjH4v+cKcUv36Weptf3MDSX3KrA3aiMA8fl6IanZmWQOp9pWfLpdXTKKGBpRkBAz
 tPfUzCv55FOwg11TVvG8tSOl3EQtxQIaRf23Agio3Xt3Al/VRF1ERBsj4XQ6ewmYrhg+b8WoR
 R6C1+DqBkl8hM6mq1X212GCWBpkvflRZClfwTFcnzrDWAkmYi6hoBdkWVKGJzSCy8fxFfIs2N
 7er/zP2sWunXPXeDqa9jUYBz/uIdBjmEZxWH7vzRwfYT4Qa9nYKv6Mhn2eFm5GM/u4oqdrKNw
 jtGdL5THzKwR7U661Xw8SykH4B6Xa0D/zs8DZV8V20oBZjj5knxuaeYjSaYd41WSpfBYubw/w
 AUiF3U1AB7j7+3zXqgHMT6hJ7iDdr8pXh1cUsKkRDlW8CQx5Ljbgqx61Haajems5ja7fcbIce
 2ggGHzvnD+IrzgdU7NlmQeNbK3D4TrM6Qb6ytuEjIR0PwvyJABfV248hUzt4C+7wP7dLYWHV+
 9I9CRS+8FWxco2+f4DG8XoWuXTckHorXRUSUkGpuxSKda8PyAr1Rt8YsRvWEqRzzGOFW8uj1X
 5TodjBQ7Ktyhjlv49gmdH/q7JPB/NNMLqX+yLTjlSSnGwG9AMO3xkDVQg==
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
>   tests/btrfs/141 | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index 9fdcb2ab..90a90d00 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -25,7 +25,6 @@ _supported_fs btrfs
>   _require_scratch_dev_pool 2
>
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>
>   get_physical()
>   {
> @@ -69,8 +68,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" =
"$SCRATCH_MNT/foobar" |\
>   # one in $SCRATCH_DEV_POOL
>   echo "step 2......corrupt file extent" >>$seqres.full
>
> -${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_f=
ilefrag | cut -d '#' -f 1`
> +logical_in_btrfs=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical=3D$(get_physical ${logical_in_btrfs} 1)
>   devid=3D$(get_devid ${logical_in_btrfs} 1)
>   devpath=3D$(get_device_path ${devid})
> @@ -85,16 +83,7 @@ _scratch_mount
>   # step 3, 128k buffered read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>
> -# since raid1 consists of two copies, and the bad copy was put on strip=
e #1
> -# while the good copy lies on stripe #0, the bad copy only gets access =
when the
> -# reader's pid % 2 =3D=3D 1 is true
> -while true; do
> -	echo 3 > /proc/sys/vm/drop_caches
> -	$XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/nu=
ll &
> -	pid=3D$!
> -	wait
> -	[ $((pid % 2)) =3D=3D 1 ] && break
> -done
> +_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>
>   _scratch_unmount
>
