Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3B7ABB95
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIVWAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVWAv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:00:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D7583
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695420039; x=1696024839; i=quwenruo.btrfs@gmx.com;
 bh=Q+zyNtxxiWzV97TYaW+VLyeoXXNoMEu8+B7eLzuDB3s=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=iv38jvmj6049BdCJ6sRLlIjOVC2xSkGLoEpno1cOYqECYZGpXIt8soCJaKoNTqrNpc5UnMgmm9L
 tRBXca3Z7Utuzth7JEsRyVKaeufCnIGoKGggrwYvw6tWlrWBqzd+xwDy95FJsX0qTSlUGwNbOdFtt
 KRoL8C6gIOBdGzFq2DjEI3qt7kTZ5ONnej1RbLxn0vThzxWlZMMndWoebbkRn4l7orLajikU4BThr
 JhMy4cMdbhQlfWXLb32nwf2MuulZVvlHCCE8gZU1tg8LGUC3l3/GMY+BoqVS6OEQmR6xUigY+lTzd
 FuByBEnie+xbXQ2q0TajJSxOFf1GUdImQdqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzOw-1r2a4o1sEe-00PInN; Sat, 23
 Sep 2023 00:00:39 +0200
Message-ID: <6d5825ac-fd5d-4f1d-952a-58a9a23c0ab8@gmx.com>
Date:   Sat, 23 Sep 2023 07:30:37 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs: remove noline from btrfs_update_inode()
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333082.git.fdmanana@suse.com>
 <dcf9aac4d009439f8becedb0d50b6f2702c0897f.1695333082.git.fdmanana@suse.com>
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
In-Reply-To: <dcf9aac4d009439f8becedb0d50b6f2702c0897f.1695333082.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dfD9mT08GNnYSehTxmq71kzqkqPoc3SG2YwlGnwyujGc+9Xn7tE
 shYATici4G7/ZtIfyJUw1Z9cN7UXERcv1G8u6xi3LRoWIX1a/Qsc/IqUBe+eHs4Lr/iH6S5
 t7TOkJZqvFTrPaDInHRFV03N8nJXXDHzD4Fx4/lQslVjWW2qVAEjGTz0DqCE+xT9ypcqYKW
 umfyefmeOjOOeegmBFacQ==
UI-OutboundReport: notjunk:1;M01:P0:BDxo5eAWam0=;+rHAdDBAWbQijHo8isM/vWDnNYC
 64CczC2On4Zf2u+kybugQACJiJxvgx4gw2v0p9xXsNURAm/wAI7oNmYfRoMpQqQjTgAjRAvih
 m0pgG6u/flVsr/BUfFtlVswWj1XHAS4cK0q63JKeMVNd6YjBLEHKeFbolBLUZ9rYYjflOblf4
 WHw0dB8Osu/t0m6T9HgwS3yswwM2/g5p4ounHoBGTM7vQeaWaXqGkfvVOnJqhWzAswwE/HHHu
 9jkICv5OdENb2gz8RrJ/gVNRqmQGV3P69jht5Gobq5CZBJszLl5aPJ0P/DU8KEUKUPF8F4fKy
 xCiWAq+naQj19RQQxKp/83Akt1UxxgSiXBmJQBSFf6JKcngjY8ikqEtH/X/Nx0e7o8jQ7+zo+
 BJSraY0MUEjJdRMUZ0bgsTL77U56ph/ve/8420OLFy/XemhSIfDitGdpWtWk45/EFJxz0z441
 1IaRs1ZaSv1RTVNUeHKE5jFpyDK2m2JWRQBpf0EtyiMOtwF+jwTuRGHtBpeaeZfVKLkcRcCPY
 osn+Up2yYQF8e84WczXhCtpbdLgBi/yJIDYWxBsElMLDDWzJwPmL5Gg4NFuWrPslhVn5PXJVF
 PYq0CVXrYLtzs7ZpEcQss7wcxqj4wZFBvsT9BQzS3HMjrzfd55qgHSICJ5MJTrQ4aGzpfnYg/
 k/m507qBawxzPvZ/ILSwhYRhvbUCDt8ZD2aSOaH8Q1S60TjlcAVeO7bZXMbhru6cruHTg/FDv
 6gaV8KFuERBuumCu7qbDDttBa687kowjLXJYw1Who60g/FRSFuN+gXeeJZgLwRY8bET58PVpl
 bu9AchPoAsZru/4a5/beJXTOT1w0d9AJLvy9RL10Y6U3B5Bp1ngzwAhkXkp6HZedNLucM75GX
 GzLPPSF5Lcg0oYOGgX22gKaAhtEUnzRyiDbfOYtZJzmdCC4iOnlZYMBafAyK7DcMniu6VXMFu
 kVaB8TVD4lPeHOFL6vR6x+UVB+w=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 20:07, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The noinline attribute of btrfs_update_inode() is pointless as the
> function is exported and widely used, so remove it.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f16dfeabeaf0..fb7d7d0077f0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4001,9 +4001,9 @@ static noinline int btrfs_update_inode_item(struct=
 btrfs_trans_handle *trans,
>   /*
>    * copy everything in the in-memory inode into the btree.
>    */
> -noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
> -				struct btrfs_root *root,
> -				struct btrfs_inode *inode)
> +int btrfs_update_inode(struct btrfs_trans_handle *trans,
> +		       struct btrfs_root *root,
> +		       struct btrfs_inode *inode)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	int ret;
