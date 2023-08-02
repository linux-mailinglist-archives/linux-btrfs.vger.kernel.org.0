Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8B76C287
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHBB5J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 21:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHBB5I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 21:57:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA52116
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690941419; x=1691546219; i=quwenruo.btrfs@gmx.com;
 bh=wL8KPQrwtO7XFcmEa8Tbtzs/FqVWnQLV2ia4WSg9QSs=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Smp4cP0kjKCECfVAYM0N8xnLYM14jUw/ng6sc8RCPSkMB+azvnf8cRlMOkYhbz7bwBJ715X
 yZb2pVkfrNWYm3LzhWXVXIHT2o0A1Ec6xj7+UDGzRbcXTbl81nDWE+NT5TrdvRtuI/4WToHG7
 dZTj1Jnp5LrA7JJXmRLVVF3KkBjR7BkUtoHSObp1ueFoTRr6XNcV/x29upkeUJU7A85QdoCzb
 yIktCYbqhFIMCtP7R+kQQB0YPF7mwxBXXQcPWT98qzg5VDB/jHdLi32usp4OZzm/RFUib4Nyf
 ba0/b/Y8oosQHg3GhnTZRQrbK9m8J1qieZj7VggG57L5xBIMyLnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYv3-1pYEOP3B2x-00u0Fd; Wed, 02
 Aug 2023 03:56:59 +0200
Message-ID: <021d0dbc-344a-2515-f819-3905be15b4d9@gmx.com>
Date:   Wed, 2 Aug 2023 09:56:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
Content-Language: en-US
To:     Jani Partanen <jiipee@sotapeli.fi>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1690542141.git.wqu@suse.com>
 <2d45a042-0c01-1026-1ced-0d8fdd026891@sotapeli.fi>
 <48dea2d4-42ba-50bc-d955-9aa4a8082c7e@gmx.com>
 <ffd7ece2-6ee1-7965-ba9c-47959c1f5986@sotapeli.fi>
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
In-Reply-To: <ffd7ece2-6ee1-7965-ba9c-47959c1f5986@sotapeli.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RorQaIUlwFdVSw6E5JXAFeTDMulLBNPOtww2V7trNvfzFIuL+96
 PZepRxM/eZNh2XgioqWbFZWHs4Jy8+NG0msTg+9B2cBXUM/ZFxtr3Yvm0ve/ZVCn6JMRgfy
 E/KUZ0jTBFnalkQOPiAk8m2UEmcmLyBIsCnhSdu9w0nGtDU8Y9YLCf7EpE6aAsfto18m2pr
 9fhrUYcV4XFjgJx/ulaDg==
UI-OutboundReport: notjunk:1;M01:P0:1JtufSJ+xOk=;mDo6KWlXQLGkh7BTsz6G2mZkhlu
 AYnu35qjrTaY2wLuV4wa+UXUs0gCUtbO6OhxsjLB/5ClIxOp/KGut8HSUxUh5yRBv8QPfYIjT
 T6ezgFa/iENkPCMTnAicpAruiVIVGddvVVqUQGqvAqkmVJmMFcDoqru15G1A10dEE8BOoz9iw
 Wfi2wQ+e+mZoaCkBvzFSYScOxZkEU2ETrnBSv9PBX9kzd/aKNlWarq+N/3DcJHv+W07n7PYS8
 MzIVfP+4NZWPRutGvoifuRjj/UNdkGHL1Rm8ncBhD2yjheZXHXEGoxwInh40KgXD9TCcXuWxb
 ATqIw7+jubKHE8ZUmUwv6ioXBsO3hIzkOjDVTdshWy4m/On0e+IZZZ1J0PTAefMj+ToyAnD5w
 8P5QwMRjeg2KGEDMmcjz6OKUNVCa5oO9j0GFFC2kXIy9OLUFu3LyhEvZrW0dLfiWpKN24yRbR
 8TXhdlARKRo/3Qgktg8dvsvQ2c8b2U/GTLYmtqwBhXx/WwukJoV9sG2M+ela5i6lXecWUofXK
 E1A4IBa4wcQ5L2YGnigFM6W6kvd/pUMA2Q67jYGB1mk1nli8QosAHKtjxyk2fSY7WcvvM0sAz
 cyZlXKFwhV7wi/JZDLeZHlrE0lMrjtW3+WV2mhJjfnwqMxTGakxa+iF1aOUox3DU9KqtrjrF3
 WiqpTmjl8ku4yNLwM2DUz/xEwIg6wP8lD2rFFPMIMa8ajT1HM/3l5uuPTXrHWk4hsmyWnJszx
 SKj3leWF3IN3S2t5CoEUBk11qvz7SFI+HKdbU71Hmb48MKT875VV/iVc5mmnG1tMxyLaJW9m6
 1IRRz4Nb4/Geoi2y2fXWk8GucJfwgZ2JNSFS7IpPiFQaan+yqUV+4iU6YRB7VZZe70o5Td1oz
 iu4rIeS5QOfd2pt8ljmBTOW0/kP6AsBctrIBRK7oDXYXmH6MdCz3beAB1ZRZhbF8XyotIMPaO
 qknnCwg++g41fmyig1wtBV+C5Js=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/2 07:48, Jani Partanen wrote:
>
> On 02/08/2023 1.06, Qu Wenruo wrote:
>>
>> Can you try with -BdR option?
>>
>> It shows the raw numbers, which is the easiest way to determine if it's
>> a bug in btrfs-progs or kernel.
>>
>
> Here is single device result:
>
> btrfs scrub start -BdR /dev/sdb
>
> Scrub device /dev/sdb (id 1) done
> Scrub started:=C2=A0=C2=A0=C2=A0 Wed Aug=C2=A0 2 01:33:21 2023
> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fini=
shed
> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:44:29
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_extents_scrubbed: 49029=
56
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tree_extents_scrubbed: 60494
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_bytes_scrubbed: 3213010=
20672

So the btrfs scrub report is doing the correct report using the values
from kernel.

And considering the used space is around 600G, divided by 4 disks (aka,
3 data stripes + 1 parity stripes), it's not that weird, as we would got
around 200G per device (parity doesn't contribute to the scrubbed bytes).

Especially considering your metadata is RAID1C4, it means we should only
have more than 200G.
Instead it's the old report of less than 200G doesn't seem correct.

Mind to provide the output of "btrfs fi usage <mnt>" to verify my
assumption?

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tree_bytes_scrubbed: 9911336=
96
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csum_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verify_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_csum: 22015840
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csum_discards: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 malloc_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uncorrectable_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unverified_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrected_errors: 0
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_physical: 256679870464
>
>
> I'll do against mountpoint when I go to sleep because it gonna take long=
.
>
>>> What about raid 5 scrub
>>> performance, why it is so bad?
>>
>> It's explained in this cover letter:
>> https://lore.kernel.org/linux-btrfs/cover.1688368617.git.wqu@suse.com/
>>
>> In short, RAID56 full fs scrub is causing too many duplicated reads, an=
d
>> the root cause is, the per-device scrub is never a good idea for RAID56=
.
>>
>> That's why I'm trying to introduce the new scrub flag for that.
>>
> Ah, so there is different patchset for raid5 scrub, good to know. I'm
> gonna build that branch and test it.

Although it's not recommended to test it for now, as we're still
handling the performance drop, thus the patchset may not apply cleanly.

> Also let me know if I could help
> somehow to do that stress testing. These drives are deticated for
> testing. I am running VM under Hyper-V and disk are passthrough directly
> to VM.
>

Sure, I'll CC you when refreshing the patchset, extra tests are always
appreciated.

Thanks,
Qu
