Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99BF7AA323
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjIUVtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 17:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjIUVsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 17:48:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71CA256
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695332162; x=1695936962; i=quwenruo.btrfs@gmx.com;
 bh=C7SgP6hD5YbErciU773trYhwkBpPW9p9xkUU/hmhlRY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=GjKNc0IwL6+PoVGHhi9VaGJNZPvAzanN0dzo/6nGg4xM3YKAHO8EwVnd3it2PHFom45XhdPwe6R
 y6PywI8Izd0L3s2clBIToMcFLtWXGbUGWV3yaThh9haKaWOAsNNcvC3eA8nJ4s/iTNGu5dOoEho7N
 nO+sFAf1vn8NNo7yE3YH72DnJdAOSO1qyWV08EyEHC4rLuNX7MMAb1oaCPXlaz4K9sGhQ8dn8TQIn
 MkfrBwum/kCHHVBjbQMh4/IsevW+ZUhtjekKbPfImRMtBVVeOJ1R9VjQEJJdbSGQaYWDoZYZFHu7Y
 sUI/WF8dUnI3y3bCNjFBjcFAciTH/3PsyAWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma20q-1rD9Px1mqa-00VzWq; Thu, 21
 Sep 2023 23:36:02 +0200
Message-ID: <6ed45260-6038-4d0b-907d-8a432cf3914d@gmx.com>
Date:   Fri, 22 Sep 2023 07:05:57 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs-progs: export btrfs_feature structure
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <512e1bb1572d5ffc3557a86a4ce3860420352214.1693900169.git.wqu@suse.com>
 <51ca231b-7245-354a-a7d4-0449000ea4e6@oracle.com>
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
In-Reply-To: <51ca231b-7245-354a-a7d4-0449000ea4e6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUn8STqI/5okj+vunQC3uiwyb2NIRe5E0pQMegfZr0kLLmJ62Vq
 QWEfLQy7HQ8Dv1EEL7X75mkHvnscwUuPzv3iit+LK3gC+h+t86XskfS//iqrIB00PhoMKGe
 Ai5CbaqPnWZdUWKU5fEk+dpZcAsPLO7Rq+UEgAf1VFQTWGXXBswg3DKPEFn+sh0lCopESD2
 7wR5lYnongbZh3X6Qo7jA==
UI-OutboundReport: notjunk:1;M01:P0:+b/bKNLbN6c=;W6fcHskmzAyQvjMPDvwSYr1Q21A
 dFFIgEfB2lYG0Ek/tUIe31/J0fzVQK1gFCQsANwxBM7tpn2Ol2fo25FbiuOyZdFQocjgPwpAc
 jgYqU4+2RN/jD0s483MqHhbuDIa96HGlcxxLEE/qpXGi/MpmyL4gC3LEvItK0KZczzHzEUeMm
 oZDFnkN7tHaAIJtF94RWeULPl4CYEDxb6sVPEWpKts9pVMxFT5oLJBmrEHv/4eS4zpm9CG/oQ
 w4cPc/c+7lv5MsX0ldZoBPMLL0aihSkj7eGUqHP4wEKifPqczWLsnkM8E2HRaYI7zRLZ3z0Sv
 edJ1b93s/2uPKcQollBGJYBsyQVPjrOtFTQd1FW9kt2PlHxG3YEUCb3U+XBXc4AQ4fh1jHva+
 pZO+7vmzf9X6hV0PWzmADYy66vCNbmMOoObU9bYxHuMB2IFkMTVSkINoA2yU2EBXsPmbqTjOE
 bni6UB/XKNCxGBrE+DuumXUIBYIzM3VpYjU28NSzz1pkznO/nKbNf2Q/65TMrzWg1mtQkGOCp
 T4TGxvbZ9FK2LebpIY9ZT0tGpYa8Tspt3oQ5uiA7vshdZYTIMDF2Gd/HCnKa4N7unYckkM6GI
 WCksyMcvS/pPVov64f9n3MMUpQ+ntjUuMNZUzTV44Brzom5vKgBxnF9BH0IZikaAybxkLY2qx
 ekLi5IZg9kWrnBZMfVNBA1QysGEliaPgSZbDwf4hCHche3xFFzJBqlHU2WQexOEcod8yWWpIv
 vKpXICGwr1BlRkMSFOuzhpCFKd1N5G5SqzQLJIoAvZh5HLZF8iBHwgHUyloB+bsSmOcWDYZBL
 3rwxkUx8ng/Lm67v5iScWGs9La3DzpwbLAzJBtB+bwzP7Zq011fBgHB6Kg0N/c0kvyVsSQUUh
 QEQaZ60xQKn+YR2L1T1BRZ2LrgLT5B4XNMfGzdsRb+wdociIw2xJpO2vM3z1/UGr4vM8skx0l
 Gpthv9GaGShHuHeJymYKE5PkvU8=
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



On 2023/9/21 10:02, Anand Jain wrote:
> On 05/09/2023 15:51, Qu Wenruo wrote:
>> For the incoming "btrfs tune" subcommand, we will have different
>> features supported by that subcommand.
>>
>> Instead of bloating the runtime and mkfs features, here we just export
>> btrfs_feature, so each subcommand can have their own definition of
>> supported features.
>>
>
> Looks good.
>
>> And since we're here, also add needed headers for future users of
>> "fsfeatures.h".
>>
> I don't see anything added, missed?

My bad, the line is not clear enough.

There are two added #include lines inside "fsfeatures.h", as during
development I found if we just include "fsfeatures.h" by itself, there
would be some missing definitions.

Thus we have the following lines:

=2D-- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -19,7 +19,9 @@

  #include "kerncompat.h"
  #include <stdio.h>
+#include <linux/version.h>
  #include "kernel-lib/sizes.h"
+#include "kernel-shared/uapi/btrfs.h"

Thanks,
Qu
>
> Thanks, Anand
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 common/fsfeatures.c | 53 ---------------------------------------=
------
>> =C2=A0 common/fsfeatures.h | 50 +++++++++++++++++++++++++++++++++++++++=
+++
>> =C2=A0 2 files changed, 50 insertions(+), 53 deletions(-)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 9ee392d3a8a6..f8eeea7695c1 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -32,64 +32,11 @@
>> =C2=A0 #include "common/sysfs-utils.h"
>> =C2=A0 #include "common/messages.h"
>> -/*
>> - * Insert a root item for temporary tree root
>> - *
>> - * Only used in make_btrfs_v2().
>> - */
>> -#define VERSION_TO_STRING3(name, a,b,c)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _str =3D #a "." #b "." #c,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _ver =3D KERNEL_VERSION(a,b,c)
>> -#define VERSION_TO_STRING2(name, a,b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _str =3D #a "." #b,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _ver =3D KERNEL_VERSION(a,b,0)
>> -#define VERSION_NULL(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _str =3D NULL,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 .name ## _ver =3D 0
>> -
>> =C2=A0 enum feature_source {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_FEATURES,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RUNTIME_FEATURES,
>> =C2=A0 };
>> -/*
>> - * Feature stability status and versions: compat <=3D safe <=3D defaul=
t
>> - */
>> -struct btrfs_feature {
>> -=C2=A0=C2=A0=C2=A0 const char *name;
>> -
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * At least one of the bit must be set in the =
following *_flag
>> member.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 *
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * For features like list-all and quota which =
don't have any
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * incompat/compat_ro bit set, it go to runtim=
e_flag.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 u64 incompat_flag;
>> -=C2=A0=C2=A0=C2=A0 u64 compat_ro_flag;
>> -=C2=A0=C2=A0=C2=A0 u64 runtime_flag;
>> -
>> -=C2=A0=C2=A0=C2=A0 const char *sysfs_name;
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Compatibility with kernel of given version.=
 Filesystem can be
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * mounted.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 const char *compat_str;
>> -=C2=A0=C2=A0=C2=A0 u32 compat_ver;
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Considered safe for use, but is not on by d=
efault, even if the
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * kernel supports the feature.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 const char *safe_str;
>> -=C2=A0=C2=A0=C2=A0 u32 safe_ver;
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Considered safe for use and will be turned =
on by default if
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * supported by the running kernel.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 const char *default_str;
>> -=C2=A0=C2=A0=C2=A0 u32 default_ver;
>> -=C2=A0=C2=A0=C2=A0 const char *desc;
>> -};
>> -
>> =C2=A0 static const struct btrfs_feature mkfs_features[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "mixed-bg",
>> diff --git a/common/fsfeatures.h b/common/fsfeatures.h
>> index c4ab704862cd..c9fb489d2d79 100644
>> --- a/common/fsfeatures.h
>> +++ b/common/fsfeatures.h
>> @@ -19,7 +19,9 @@
>> =C2=A0 #include "kerncompat.h"
>> =C2=A0 #include <stdio.h>
>> +#include <linux/version.h>
>> =C2=A0 #include "kernel-lib/sizes.h"
>> +#include "kernel-shared/uapi/btrfs.h"
>> =C2=A0 #define BTRFS_MKFS_DEFAULT_NODE_SIZE SZ_16K
>> @@ -43,6 +45,54 @@ struct btrfs_mkfs_features {
>> =C2=A0=C2=A0 */
>> =C2=A0 #define BTRFS_FEATURE_STRING_BUF_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (160)
>> +#define VERSION_TO_STRING3(name, a,b,c)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _str =3D #a "." #b "." #c,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _ver =3D KERNEL_VERSION(a,b,c)
>> +#define VERSION_TO_STRING2(name, a,b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _str =3D #a "." #b,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _ver =3D KERNEL_VERSION(a,b,0)
>> +#define VERSION_NULL(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _str =3D NULL,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .name ## _ver =3D 0
>> +
>> +/*
>> + * Feature stability status and versions: compat <=3D safe <=3D defaul=
t
>> + */
>> +struct btrfs_feature {
>> +=C2=A0=C2=A0=C2=A0 const char *name;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * At least one of the bit must be set in the =
following *_flag
>> member.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For features like list-all and quota which =
don't have any
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * incompat/compat_ro bit set, it go to runtim=
e_flag.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 u64 incompat_flag;
>> +=C2=A0=C2=A0=C2=A0 u64 compat_ro_flag;
>> +=C2=A0=C2=A0=C2=A0 u64 runtime_flag;
>> +
>> +=C2=A0=C2=A0=C2=A0 const char *sysfs_name;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Compatibility with kernel of given version.=
 Filesystem can be
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * mounted.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 const char *compat_str;
>> +=C2=A0=C2=A0=C2=A0 u32 compat_ver;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Considered safe for use, but is not on by d=
efault, even if the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * kernel supports the feature.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 const char *safe_str;
>> +=C2=A0=C2=A0=C2=A0 u32 safe_ver;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Considered safe for use and will be turned =
on by default if
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * supported by the running kernel.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 const char *default_str;
>> +=C2=A0=C2=A0=C2=A0 u32 default_ver;
>> +=C2=A0=C2=A0=C2=A0 const char *desc;
>> +};
>> +
>> =C2=A0 static const struct btrfs_mkfs_features btrfs_mkfs_default_featu=
res =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .compat_ro_flags =3D BTRFS_FEATURE_COMPA=
T_RO_FREE_SPACE_TREE |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID,
>
