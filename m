Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2D79322E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjIEW4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjIEW4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:56:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C611F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693954549; x=1694559349; i=quwenruo.btrfs@gmx.com;
 bh=e559csZ5+bDFk0IeDaUFfID7riJ9NEV+pt3CqiCWz5U=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=p8Xcn0RZGPSrtJe8VjMBaJdB5137lWy3YqKbXsBRdPAIxZDboLBU4rGAT8ADH26SybQUmul
 LYT+2+D3zAKnVSBqYsMGIGDm2TOhSV9M8VlU0l6P/GBZjM0J2qqwe9EKZPrpv2MZT+JsE74Lo
 aAgChGkOGqi/XlD+cGP7IR7VBTW5NtoCF4M1yt6uYVnvBIuo1+h7hLKjjN9HSkFPICkqYJ6lb
 F6ZBP16bSZF9YPa0s+Zp1YA64pUDL3PJAR/5IqkqzZTDa9qI2n2sFuXV7aQv6OFOIvNVkYMUC
 7g71Kz9W1MZGsKQXBpxz7aEjrR2tC1n1FXXaxeV9vP1RvYGiTudw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1qDaHr3whr-00UaiM; Wed, 06
 Sep 2023 00:55:49 +0200
Message-ID: <36a8f250-5545-45ce-8185-5451fbb0ebf4@gmx.com>
Date:   Wed, 6 Sep 2023 06:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: properly cleanup aborted transactions in
 check
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1693945163.git.josef@toxicpanda.com>
 <d24c0b846b150fa9e5638fc90258bf2728f88351.1693945163.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <d24c0b846b150fa9e5638fc90258bf2728f88351.1693945163.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q7I/OcZ+lDvk/dTLwrSVfTs78HGoMCQ1zBkoCz+7gd6EsqZ7q1I
 UrH5iUaPDHirzELqAiNAXbnwgKGTIpIlu734G0MKuxR9FWg47roOyG/RNd2/L4T2lzWD2ZG
 bjYgK68F7JJzJUGMipQbE1wG7VR5Numx5Ljz4qonumc/u8JhzsO1Hm/e9NkvwerkRVbngeA
 jl6LCrp2Q/8FQTTcOkpAg==
UI-OutboundReport: notjunk:1;M01:P0:RsGfdWo0D38=;oGAVIldnrBrrbdUPJPbFFF7CHW5
 ZqS2uaoF/kILzGPM1hhN6o6GUbxogB9LMxQyAIh/ADA1EtVBxRq0qtI0MJjPE2nKa1Ei2ifsb
 zs3a8kadkPSrY+w3SlRwTugLaNXS9QLRkrHmEnIGOSzIVUlvIfAiTqleiF97B1GxVmrT0p31Z
 vC+N7bmLEYJ46dkR92sjuHuD09N73f95pgCkOqaYzDZVC0FIFtS5buyo+/G/8tJHHsdXAu0nq
 d7EdVWFIoHI5jXGg5rwJSd/59wnmNFbUkc94Ot77AspkZgYCzju3t6Jr/3jMZBUnZZxbl8Ck0
 GoTFG1E/3VvsSbRE0R3GlaRN4uhljQA5aCUYLnQqznuP07/TBjdv3yKj+ooWf3EYPN7A6/JTx
 rmuiw/UkrsQbBGQcV/3v9Qhq7gk635sCJYSzcQbv6E+Jq+H7U/Ht3Q8BClDYrpzrP7LTJmcv4
 OQ8Gj7my7P/ppSxfjvFj+iQXu3bPE9BMfNkwvtXRYejb2A4AEQulSHWinrZQGE/d3Sriq/ZID
 196REHaGBOwdXh9J/93JkM7Gqtcf/HkbzCDCbhzZr7MxdpNRiIz7npMGyODouHNNF0C7zI9Ej
 RfiVQPCYjMNzLjPZHafeGH7V8FrKIN594WKY27b2nWVGPHGuiPTiyTgxES7/b6cDa91KcP7zg
 sLjWmtV6p45pVPyADTjhGVFohSe15BWL0uq/MvQ1eg6AHDVIrHNxa/kPBYYSVxG2CWXiUUm32
 7mx8IBlplWc8qAO/aSNglK2zQbEqQf+qfohF9Gni8ZOTQcD0JRcANRGCVtf5Ks4mx6WTAk96B
 Pps1hcwjtzrdFk0X8pln5wswXQLT5ZhAL+tZfVSJpOPgktJJrxnT6B0zLC/rjB72HNWYNZkXN
 iPHCYyw/1oYFA+JLAXlPceWPk8vO39g6FtXW3OFo1TQAVaPzJzo2Mo/tVmOX/amUpmZBUz0pY
 EpNE5eisnoxhH1nbGLWZlgIVE6U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 04:21, Josef Bacik wrote:
> There are several places that we call btrfs_abort_transaction() in a
> failure case, but never call btrfs_commit_transaction().  This leaks the
> trans handle and the associated extent buffers and such.  Fix all these
> sites by making sure we call btrfs_commit_transaction() after we call
> btrfs_abort_transaction() to make sure all the appropriate cleanup is
> done.  This gets rid of the leaked extent buffer errors.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'd say wouldn't it be better to make btrfs_abort_transaction()
more standalone?

It's pretty instinctive to think btrfs_abort_transaction() should handle
everything.

Thanks,
Qu
> ---
>   check/main.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index c99092a2..1d5f570a 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -3114,6 +3114,7 @@ static int check_inode_recs(struct btrfs_root *roo=
t,
>   			ret =3D btrfs_make_root_dir(trans, root, root_dirid);
>   			if (ret < 0) {
>   				btrfs_abort_transaction(trans, ret);
> +				btrfs_commit_transaction(trans, root);
>   				return ret;
>   			}
>
> @@ -8011,8 +8012,10 @@ static int repair_extent_item_generation(struct e=
xtent_record *rec)
>   	rec->generation =3D new_gen;
>   out:
>   	btrfs_release_path(&path);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		btrfs_abort_transaction(trans, ret);
> +		btrfs_commit_transaction(trans, extent_root);
> +	}
>   	return ret;
>   }
>
> @@ -8223,8 +8226,11 @@ repair_abort:
>   			}
>
>   			ret =3D btrfs_fix_block_accounting(trans);
> -			if (ret)
> +			if (ret) {
> +				btrfs_abort_transaction(trans, ret);
> +				btrfs_commit_transaction(trans, root);
>   				goto repair_abort;
> +			}
>   			ret =3D btrfs_commit_transaction(trans, root);
>   			if (ret)
>   				goto repair_abort;
