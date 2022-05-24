Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD7532B2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiEXNV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbiEXNV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF6519C35;
        Tue, 24 May 2022 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398482;
        bh=nvD3L0cR3Xs1iu4CtUQOsSPdngYpq1IgyBSUw9cBy9c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MEZW47A7aXZ/sTAyANnTbhZx6gmjFRO8ttQ4cXcgATVLEb7bxtOVmq2tKoo6Q1jRI
         Zx7GDTt9Bc0LoVR02qVwLZ1tryoUHIwvTGzYMse5FT/Lcd57K8AyxVH28bTfpkMAIp
         gQ3UczizQO73ByOa6REOEWTo3h4lPkMSbAcW/rCY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1nXN4b1SPw-00mc5k; Tue, 24
 May 2022 15:21:22 +0200
Message-ID: <4b9d9dc7-b850-41fe-23b5-5848e1445514@gmx.com>
Date:   Tue, 24 May 2022 21:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/9] btrfs/142: use common read repair helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwjOzpySWMxvckSw331asYkAvFfvuXpfekGp3sA3g4tg961PWzh
 wJChuF4dmvG3LR8PWG19INaIdqrnN+AgdoKzymTaB6dtiIX3tiY+B7IMIHt/7BeQHVWw3sK
 JP5wunU9YNjgJxaPM0dqKxTnShraBA20goXo7myuMoYcNy8PdUJFkTKxodfuY+kfW/ClLg2
 eDZ5ytVG9GPWBVxA/GlVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GFwLJHMvkOg=:VbbJ6qVvVoNgp9j8SxLXaj
 2CtItL67vVdn5OI/GIfKlizjN7nwd3gOsQZB6dNx2gpY6WwOXAIkFEWqw2BkFeJICuNwRbbPn
 CYQCAsloR8INygyQ1bzASnvD6sCfB3mEfHZt66YxMz8UpwVziE4g/Zey1Prw8RMMEasvTkyq+
 9S+wMfamyTqLVJDcLyLShayj5+kF+gLciGzIgIGRgkj5pfsQm5bsLMtevb/DxY83mw0b2Idyf
 xL6qic4a0uJhCJ1JFjbmUk8PA3/3k3KQv7Io03aMgFUGAECXVfal0mkDESIa9u8HDshi4k54T
 d35UrufjQR2HZZHeUHbyROBcjemNur2Ay8IlDPud7VQOoZjQy9Or2ZNGAHqX5V4Lo/J47iB4o
 P3ldkkLUErffd4DM3aUSlRjqva6dEcDR6/XH4+yZz/c+4IyV/6BbLPIRpK/+OSUQhy8tuugJ9
 kKuQC80Kfm+TxFXkq7OYFxi3bjUrLaWfhLhi+iizZBo9ligIc1wnQ75EeALNBaXJEEcF7Z4FK
 bzJjVImKU0NVye9kPBHaIeTkf6HDsD94WOhiTstCXfw0p5Tm30QEpELmzsFjOgLuxz1PBrNH+
 UU2CLDcEY4ahOrieNlpGjPRoExvUgTfatpqOu0JcZJbRJIFTg/S8FAiz9b3XGiUTsOhVvkOEz
 Zz9jk/hHAIXjbFtL83hwU+PV5ZxFIN+iK6WR287zLkHpOWd2ldT/nL5UhbUYzI6cg6SHTA1EP
 lcPZc1KLfhz4QH28IYQtmp5BUQVPDpZ2dv7D/EIy+n5dvhz2Yvp0VoZMmHfvbrZUMpDIKXVws
 QtPKwFSoKAHchCCGKyUbc9pWx4sQqP+3vtALbKJf3PoR/Q+28/bYbbszMaetboF6fGJCwjmah
 hPKTzTRNrpETSbFQpes89FimI2nY88LhWzKLCtvVubxYecoY9Jcqd+9uB/azskbuFuxCvHGmw
 PmUhNeYL0cTQQhApioQp9WH8/npWDa6DisihPx2LFXViB6ThA5bJZzW557nY5bhafXPjzxFwY
 VsQVyY+MIlS2DecDKYdwB15KTaZ4s4DJXQ59i7SagIdWM+ajPT9Z7vAeCOorRhBEpKtN8XvIA
 gPoZNNYbR0S79hUbwuUxyZEgvaIglbvxU99d4YOcD/Ndrz4X5lJEPyJHw==
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
>   tests/btrfs/142 | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index 58d01add..7a63fb83 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -27,7 +27,6 @@ _require_scratch_dev_pool 2
>   _require_dm_target dust
>
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>
>   _scratch_dev_pool_get 2
>   # step 1, create a raid1 btrfs which contains one 128k file.
> @@ -46,8 +45,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" =
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
> @@ -67,10 +65,8 @@ echo "step 3......repair the bad copy" >>$seqres.full
>
>   $DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
>   $DMSETUP_PROG message dust-test 0 enable
> -while [[ -z $( (( BASHPID % 2 =3D=3D stripe )) &&
> -	       exec $XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/fo=
obar") ]]; do
> -	:
> -done
> +
> +_btrfs_direct_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
>
>   _cleanup_dust
>
