Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507253F6FAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbhHYGjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 02:39:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:44581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239038AbhHYGjO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 02:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629873496;
        bh=uoCj8ETCxAaS3r9Ofoxl3BGiNpOBBkm1QsIh4BwbbSc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KUbyJFmR3lg+qJEhBCspDdQn8w8zZ8YbKLJe+ikr2Aeuc+mQFk+bChJXXVlCOtcKK
         eJeH4qlgHgPit9Iw7i7DMPMDSocNgt+zxcxbPekHfowSVdSNQBwz7w7YPExY8eMdiO
         SZJnBwsB2LYtvdXw59b6NE9tb06u4hBmeDmQYPnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1mr0yH49lX-00bNq8; Wed, 25
 Aug 2021 08:38:15 +0200
Subject: Re: [PATCH linux-next] fs:disk-io: emove unneeded variable
To:     CGEL <cgel.zte@gmail.com>, Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210825062717.70060-1-deng.changcheng@zte.com.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cf66c150-5587-9537-051a-b80cf81df245@gmx.com>
Date:   Wed, 25 Aug 2021 14:38:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825062717.70060-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HxCRVG4Y9Ahkw8UVC0qIZ/sVlzeea7kdTYwWCtsjaDNt7hpd/Ie
 sV7RPQd1FcqA14hau48Y8XMvVBLtv7JlQLfpFG3OPHC/wvymsXnmoDKNLvdQTS57s9Vr1IH
 /ZVCV0FJhSklxqKZ9tDFW3lXtrrbRdhxGmZZtnO2o5mD+tkw53hsv/VcYLECZ+KDiRERV3Q
 sv3E5PE4relQhF23O/clg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SH1AuHbgyLI=:ac0SJb7Qrt/Z3WaHGnSk8o
 pbhFaasq+KGUW2Z4QhTgd1xZaZnvU6dsp2wvvrUHreQ6f/AmzGk3ckqBVJ1Wx5ABY4yenkbaw
 vQ/I3fd+mcFo5TTNCKmuIz+vdy3xZJE4IT5tSOi0djcr7VI4bDM+hunsYKonkMSgUh19m21wb
 UmHJ0715HTDIppIN52sf+61Fv93kxK+fX9NqyVLNmxrCAUJKnzSieGKc2/VpLU9H4kw8Sq8hj
 28O/t+JoqxpCjK91RkPrGS9g2IAucUV1U1tKFX238k8tn6yiNRQ6v2PzKRDCpW5C//YDEJNdH
 aahO62O1v0EKMHxzQGPr6rVLI5bkKFLzSY5yug+nzbIO/3fSYmn7CA/VkfH/t6TL5SSyaZBfx
 hraQW+alENZ/B7St+7fO7uVE5w+PsDPSy4eF5R16IWrXATPmspB4BUUK9H85cWx+DH+Gcssh1
 3GShBht/L2egDyjgvH1fd8NVd3bJQUWGZTonHYQFYBY5Yqxdv2FPFn0hBSivdySUFzElU9O/2
 bElfpfPkO1dDYmVdbE2LOmaGKC2uWLzjUx95QLTfxUE1S+/Q9sxFHupv//NAmDxnHEs5I4L/2
 CcPEal0E7MrOUs0P3YKyMSBoghjwF2rLGpDTR+lEp58jig4BsG7CzYQzvBzs2I2o2Yy9MMJKs
 F1RABRxXWzpocU04tv9DEGcRcyFKPCOcMxgS/59BSDwfo/GsqK0yGpy0yEDd2JU+Uh7vIJ1/D
 RDAj4YAsgicwr4TiCxVaaD2a0CxjPoVtqQdaEAd0ltcbQfnYaJOUN8sHfzjXXGm08YLn5S9vu
 zQZ+zKBPGMnL01lMd98pZmuIMHaAmInyBh4NFNIarSvtR2wm5BjEaykam2AHcLCi0BMZrMaXo
 cCkXEiPBg+D/vJDlWPZirPX5Xiu926FYCzIgRz1AAGMOfrecL9AwMq5AnA9/F+Yy0Ama7SRbE
 /VEOpXYP1DP1nMzERtgIly/8p7FkkFN5xxW9A7b9eywIcTiZr3NkJNdyDJzr/2aubUYsh6s8X
 /bxId+lnASLq7jTPrZ2Z/tUE13qjjqxWs0Ocq+A3ka74eNXyboLo/m1pZG7joO/fCjdWPmUHz
 V3pN1qlXV5Nn4pk7gQTx8J3gxtglTDJOdDQE+bDMCf6NXiu3si+dcfe1fA84+ZMIV/nz6CnB6
 /S6z8wDZlREs0qt9BAOOApe3VITEsSqVkJgfNuswHyY6eETnzBqlj2ga7SoVT3gur16i/7fdg
 L8hfwHgvc9gvEs7Hc8FxpR1q8ec2E2DpaAxvAS5Zi5aeNSm2ZuXV/Yj8FGmrPC3M1HM0XKyj+
 Co00w405UcSZG6UHW8Dof6/TIrJJvg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/25 =E4=B8=8B=E5=8D=882:27, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
>
> Eliminate the following coccicheck warning:
> ./fs/btrfs/disk-io.c:4630: 5-8:
>   Unneeded variable  "ret". Return "0" on line 4638
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>

There is a big BUG_ON() in the code, indicating missing error handling.

Ignoring it and just removing the @ret is never a real fix, please add
proper error handling first.

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a66e2cb..e531c4c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4627,7 +4627,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	struct rb_node *node;
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
> -	int ret =3D 0;
>
>   	delayed_refs =3D &trans->delayed_refs;
>
> @@ -4635,7 +4634,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>   	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>   		spin_unlock(&delayed_refs->lock);
>   		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return ret;
> +		return 0;
>   	}
>
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
> @@ -4698,7 +4697,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs=
_transaction *trans,
>
>   	spin_unlock(&delayed_refs->lock);
>
> -	return ret;
> +	return 0;
>   }
>
>   static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
>
