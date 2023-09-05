Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1828793223
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjIEWvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:51:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A27EB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693954290; x=1694559090; i=quwenruo.btrfs@gmx.com;
 bh=a9KxAiei06S5x4uf8ZLbWH8Tdr70BE1Eh2gcGKj/7yE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=h67JCq2sg2r3WnkK0hIdEMu92FI3ZHLN8NVmA/5uIBxlapLUa8A21oQUEUMOIrthMI/AwUN
 h1cIkiU003WrsJpgmCSE/UzjpHtszd71IJiHqy5864kN+kaCYFjKEm29Cs7uUEanCTH5QaN+x
 5FcKyViAZV8GArp1WOxChqF0FklfoRl+LM9iMqFQSodA6a8GvqYMxkA9B0dZK0kVbEYet309v
 KODsaOQp25sclUCEveAFY9Kyl9/KF0ZjL3aFWRvkh9chDhKRcttm/PT4JYn0X+/D0aEB7ycvM
 2dYBpjv3VXyZV+k7H/qmvC14tRlMg40KKLg0pX21GDIbD5neN2UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1pYRhl1gcW-015KPB; Wed, 06
 Sep 2023 00:51:30 +0200
Message-ID: <2ef62e1e-a642-4dc8-9aec-427334a51e45@gmx.com>
Date:   Wed, 6 Sep 2023 06:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: initialize start_slot in
 btrfs_log_prealloc_extents
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Jens Axboe <axboe@kernel.dk>
References: <cover.1693930391.git.josef@toxicpanda.com>
 <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
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
In-Reply-To: <e0192694760936031cae7b4633ba738506eacdc1.1693930391.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ORd+AWvyAViJbI979iMthX27+YWmsvdAZEPqt9vEiEexStMFYUh
 DcS1f74we2pTnt3pjjkTNXJONhxzfES+NgxPB+w+3VyVRc7mwXZu3BeqWZvcaiqkF9J2BA5
 dIJROeE5/0qnScYAaXLWG0Erkk+kUWFKBTKcfefvH7MgRqtIoEcKLmnGaz7LQNCXOTizHDU
 trKgWSF89VfZhQ7bkIkFw==
UI-OutboundReport: notjunk:1;M01:P0:dXRnYJf4/mA=;Qn7sSWCiNywf87bHTMWYrCuz3vR
 KSllAsntERjBJ+vkBD/mJtq/MamMuSnGmrH+zs6qRsh6LVpBjxfcF9ox8eSjyy/sXeEam6dC9
 It82gOtM3ld/OoQmjLpfNtIIVNJ1Bt3Ca6LMYPeJkS0hDKtawv5KUDWBuc7j7+DLbG0FIeruC
 zcP71UdH8WzWGbEpKi+FapZE3Ci/A+0cIpyBiaAQz5Z+K0YgCA0b9NDieqqg6jDsnGUO65gwR
 L3fmZrnnfHN66OTwg1ptKFJAw78rtwZ3NfLeEc/Ie7YyTHLHhPWVRuZRnkcxC3E/SOhvWL/f7
 qFqEeLUQcnOraDSQHxzY0iADrHLNFU9XBHmzeHjyH76/Xw8murVZdapn2zuryNgEreaKTTsEL
 9Ro7tew9V4XDr/xjKHabvL6qQY5d284omPW+JYnzxLZ2ZNDQRROcz3P9h1XBbOnN/nVQJ23cT
 zY7ALa3WD6i09mxfF0FsLp+vgd8bFwYEvEb8hPKG7sZzhs9yaiaMu3XWPpOUkGYKeEGGKNxuN
 1mYFJjaPeZ2ZS2/7LUajjFYAFW9WG0lxRoVqkYZjDhBgXv8lXrQUgazRQ+zd2DoCU328maYkZ
 pP0K+1e9yQq9LUfLZftsTqmGNGKiGa3v8g04KdF5gVAqQiFzRNwLX8Yldl+13tsLUXSYBqLh+
 mOtN/oI/wP4wZpwKIIxoWjqf3YxpDvod6M7n1dkVMJ5CBl4S5Td5jnIhul2qJ+of/ZXlYl9Mt
 Nv3LLAx30rB47jfkdP5+62ZgjakK1rGQQ7NcnwwHPX2zN/mRejWTMQnElkJGy0WricrsGS3HE
 b9NsTHvbXv4nK3hbwcSvf+16p3qCTA65XakJ2yV6IAw1uUdLbjJxh43SxAi3A8VDjlEqx4kvj
 z22HAC8Gw2tmMCiLr5IbUGUy2zq7AwowVbUpgxV+vwqXSnAwVqtHbpxhFUqZUeKigawKG97RS
 NejSYEk/FX45x6h8DyOH9gaz7rc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 00:15, Josef Bacik wrote:
> Jens reported a compiler warning when using
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy that looks like this
>
> fs/btrfs/tree-log.c: In function =E2=80=98btrfs_log_prealloc_extents=E2=
=80=99:
> fs/btrfs/tree-log.c:4828:23: warning: =E2=80=98start_slot=E2=80=99 may b=
e used
> uninitialized [-Wmaybe-uninitialized]
>   4828 |                 ret =3D copy_items(trans, inode, dst_path, path=
,
>        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   4829 |                                  start_slot, ins_nr, 1, 0);
>        |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/tree-log.c:4725:13: note: =E2=80=98start_slot=E2=80=99 was decl=
ared here
>   4725 |         int start_slot;
>        |             ^~~~~~~~~~
>
> The compiler is incorrect, as we only use this code when ins_len > 0,
> and when ins_len > 0 we have start_slot properly initialized.  However
> we generally find the -Wmaybe-uninitialized warnings valuable, so
> initialize start_slot to get rid of the warning.
>
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I think we're in a dilemma, if we don't do the initialization, bad
compiler may warn.

But if we do the initialization, some static checker may also warn...

Thanks,
Qu
> ---
>   fs/btrfs/tree-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index d1e46b839519..cbb17b542131 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4722,7 +4722,7 @@ static int btrfs_log_prealloc_extents(struct btrfs=
_trans_handle *trans,
>   	struct extent_buffer *leaf;
>   	int slot;
>   	int ins_nr =3D 0;
> -	int start_slot;
> +	int start_slot =3D 0;
>   	int ret;
>
>   	if (!(inode->flags & BTRFS_INODE_PREALLOC))
