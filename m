Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9B7B0F7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjI0XMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0XMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 19:12:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D961F4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695856346; x=1696461146; i=quwenruo.btrfs@gmx.com;
 bh=F6ofyMBDTac6C6AoCw1f7FFr4jGY9nbdwIEF01B/MsM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=O5OsMhnIdE0Ofk0EXj8fmuqH7CN0LIatvoNFQwBDFe3Z6DydNzapNxmYitE78DUUJSdS36SepLD
 vCCouk62fZ67H/QJRIXIIr/NxoctnPd7flNXee3QLpUfngk9y05xHL1znIoLCEIMSHJaZcXSHZgB2
 bWCLhjLvjwosz+Wz3on72Lr0cGwuq3TLLec8F5+uTu3M6Ei1Dl4eIZWzlquwqKM1EAa4kfotTkFgc
 6dPU8r4rt/BI9fBt9sWgBnA+x+C2bg7CGEqG8bFn8Y8Z6FvzaijKQPSHM6Uxq/5hrB77bHu7axJq0
 +HWYX7/2fNe82qFFpU/cQ0R2xHgU1uK1bmCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1rboHn1cDG-00sgeG; Thu, 28
 Sep 2023 01:12:26 +0200
Message-ID: <8a89dbf2-c9dc-481a-8fdd-4aa26f86d59d@gmx.com>
Date:   Thu, 28 Sep 2023 08:42:20 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject unknown mount options early
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
 <8b92ecee-e018-6570-880c-878919260e31@oracle.com>
Content-Language: en-US
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
In-Reply-To: <8b92ecee-e018-6570-880c-878919260e31@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/CAGmTFemge+zYLZB+rrWMNoj7BDIKOiyS9ChleAYEbIV7f5U86
 I/r6Jzv9wIKX+RblUg/aTjQ2uTcmTBL/5Wl/x64Y7/0krN+9kBkwfJb92rJkQvbXXF35q/W
 WdYTWQ4G6CbtQbQ6tAGlIXgysUsHqSm+lHwrQZOSlxeXZ1a2hd1RGAb7EdaU8TXESRb4LN7
 92JpqpKE1SjOvQu8RWipw==
UI-OutboundReport: notjunk:1;M01:P0:H9hNHYQkkng=;97s3OdePed0lQJNJO8zr2VzXSKo
 j2tfzzYwI7FWBsAxLxGRh1ka9FieR4J6ZGOJroheyEVdiviTdPtQwBPvGS6KEQLdAPqg9asoT
 boewmveLKk5vi0uINiBPP1jD5a6CxJglaln2bWv5CdXznnz8pSL6WHTRRVislxJFD8sHp/sSP
 c9NdEfXLEOmEgp55a+AzUprfL7nzE5DkUSq4uIzivCdsjSxfTnszXAwvme6CsiZvxm4EUkQsO
 tUPU3KBORYvXjTaQeB3UzerJ/vyr/kF6j67M1S/esbEfA6Tq+bu7NY43Y4RGyYLIEjAsVgZV4
 QQ0LNOUJwbKEd88aTwH/6dFqRRn8eSz3+SQNuJRu61SDDh4OnedIo71NqIGxiSVvzoeuNwNCJ
 n2nEp+ryD4YhJWiYYqJcFpMketdgCuqW/J7mwCA6sezNsab323ed9yCponIe2rvhFCklKJWDb
 drNMtSDeq7jyY8vv57kaWbjUMYNDWGwWCHxu0nJ/RV7NYrHJdCxwYew4QIG+DozlWVGPdi4jV
 HOIhyO3y5johB+04yM+70mm2aeUZoAIi1FsEjXIUdjQZuMvr5czQPtVDQ21JN8O8YXydmzuxP
 zawcRHoprSoHdPOt89UvLVP+3Di0iDewa7+D49OAVXyJ57OFggJj2gQDQfxRETXAEAoCpUlVM
 eo5q1gQmmkfz9hJwd/Nq/rsgNPZDzuu0wpjPP6ik/+WOxqnNkQMu2OmapudkOoZqBNDY4btJO
 Di261gEHG2BNmxBNELU+bFBVPFRNKc5M/X+3guvTvVDqcl4RF8kyp+e+Ny5oIHHfpYCiY4OSO
 8IzCpkTsz1wubPf0ueQoE9PJaPYdvqDY9x2WuMmpKAK2+24PlCZsy7jibLYaUI8oTWcB/9Hy6
 UmGuzOhxKz3Q9nlRcv3IBPpJmaPulM37yCE/RT0S/Uqd84M3Q5rLTw96w3hn1gKsrWe+LFuwk
 +rjjq1PQN1sTvBgK9tqIyK3Cr5M=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/28 08:26, Anand Jain wrote:
>
>
>
> On 27/09/2023 09:13, Qu Wenruo wrote:
>> [BUG]
>> The following script would allow invalid mount options to be specified
>> (although such invalid options would just be ignored):
>>
>> =C2=A0 # mkfs.btrfs -f $dev
>> =C2=A0 # mount $dev $mnt1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <<<=
 Successful mount expected
>> =C2=A0 # mount $dev $mnt2 -o junk=C2=A0=C2=A0=C2=A0 <<< Failed mount ex=
pected
>> =C2=A0 # echo $?
>> =C2=A0 0
>>
>> [CAUSE]
>> For the 2nd mount, since the fs is already mounted, we won't go through
>> open_ctree() thus no btrfs_parse_options(), but only through
>> btrfs_parse_subvol_options().
>>
>> However we do not treat unrecognized options from valid but irrelevant
>> options, thus those invalid options would just be ignored by
>> btrfs_parse_subvol_options().
>>
>> [FIX]
>> Add the handling for Opt_error to handle invalid options and error out,
>> while still ignore other valid options inside
>> btrfs_parse_subvol_options().
>
> As discussed, the purpose of my report was to determine whether we still
> need to return success when the 'junk' option is passed in the second
> mount. I don't recall precisely if this is intentional, perhaps to
> allow future features to remain compatible with the KAPI when
> backported to an older kernel version, or if it may not be relevant in
> this kernel version.

This is not intentional, purely a bug.

As you can see in the proper btrfs_parse_options(), we handle unknown
options correctly and reject it as expected.

Furthermore, both btrfs_parse_options() and the early version
btrfs_parse_subvol_options() are using the same tokens, even if we have
future new features, it would still be rejected by btrfs_parse_options()
for a new mount.

Thus there is really no difference here, just a pure bug that doesn't
properly distinguish unknown options from valid but irrelevant options.

If you're still unsure, you can try the same thing with EXT4/XFS, they
properly handle the situation correctly, and I see no reason why we
should not.

Thanks,
Qu
>
> Thanks, Anand
>
>
>>
>> Reported-by: Anand Jain <anand.jain@oracle.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/super.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 5c6054f0552b..574fcff0822f 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -911,6 +911,10 @@ static int btrfs_parse_subvol_options(const char
>> *options, char **subvol_name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *subvol_objectid =3D subvolid;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case Opt_err:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btr=
fs_err(NULL, "unrecognized mount option '%s'", p);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
