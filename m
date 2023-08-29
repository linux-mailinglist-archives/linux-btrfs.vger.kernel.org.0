Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B968878BEA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjH2Gnj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjH2GnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 02:43:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69A18D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693291381; x=1693896181; i=quwenruo.btrfs@gmx.com;
 bh=2v3JfFy+iL0pDXap8+I/hgpE1yBO1PcFAA5uk7V9qSg=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=XxpUCtvhGCa4OzGu9Rh7oYZ3MXvc8GV9obv28mhIR+d/ZY4epglXC3FmVxsDuYISUElHJcF
 gPARQxR3sAPNRdk0s3N2nh69w+jLItupwx6LSZL4V6NwcaL/HLZa4PU//52J9MTUKuIueizBY
 ANclwGhyPRvQxY8Cv7Obe3DlEQisOMMaxwYOCcTLQvQxRUtiHxCk3ws1iktxxBFgC0cW0sjEe
 9P28uqCYTxvHGHZ1pc865KHrCIIKhxdeQrFKT8oaOyoF4TDPQliG55hTCIZbFg14Zp8hZdqRf
 35Snj4UT+jJnh6RV9ZvHAOcqmuv4kVfIhl9GXV9u7LtJC4KY8f8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRMi-1q7IKH0KPE-00TlEu; Tue, 29
 Aug 2023 08:43:01 +0200
Message-ID: <4a9add37-c1ba-4009-adf6-df8ab2aea19f@gmx.com>
Date:   Tue, 29 Aug 2023 14:42:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/38] btrfs-progs: remove useless add_root_to_dirty_list
 call in mkfs
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692800904.git.josef@toxicpanda.com>
 <34ac8f222d475d692faa8d325cf63b5196912644.1692800904.git.josef@toxicpanda.com>
 <afeeda1a-0317-456d-a9b4-0e95a62d3de1@gmx.com>
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
In-Reply-To: <afeeda1a-0317-456d-a9b4-0e95a62d3de1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IORcsILgrp1t5GJcxrVg2lHwqa8KbNGVBPohWyoxm2BCIg9/lno
 zVOLI5CgCChxasHacsl4HNGr1b2WwpJKrg76R76rBqE0381hk+DVRNdAx38dDw9JkgD2i5B
 9UsM9qvaWDkXyrmZhvx5kwDNo7SqX4IYFsg8OASfhdyQbbkxTIsuqbaoo0qzPvbBilnfNPD
 pSc81SOH5ofqoK404+JTQ==
UI-OutboundReport: notjunk:1;M01:P0:q7PUHCuhJzw=;Q1tO21cvMGm0q2pja8DC4k8NLaN
 CS7zVrMJtKgdVTftYy66agxjFtyeBXbtoICiSZ8vW1EI5fNRIor8gxsc1PVJN4vcK/iQfc1Ya
 qvou05VuxA8hHdsMbc6zf0Nxg+Q7qOpvJg/bdfQ1YVkttAiq42xuqXo84fgdksr1qnHpGNLT0
 FkrsoUju3vS2tvoPkrjpVgVuNxr0TFI48vnt8F7GhGR4RHu/8R5upELIFS/kDHQ0jeDCZFbpE
 EXKhO6krYvwd68lm9/pKedPXmmgKcO2UQoPZUd7QZoduB7mJ8MS3TnV6Qohe4neHevijetQcC
 7F95xFz7+dh/i257xLrnwUwkV1U/4M/RP5tXgjczwakSA4y54N3FCIInN3vpUyNX3X+2eebCa
 RGFTBOW95olxlHo12WDDV25KXC5dytKWH0/Y8OOaSyazR/pGi0el4t/WdbVSozlhybIwJ/Pdz
 WDpBnMsFjgmd4jWDh7uCJNMQP9/xfC57OLX1ZbhMssTm83z7u1xVD/zIcZTW8S68/mun0TsJ4
 l8G+I1y0cia0uHUPp81KZFR50fdz1KkRYjau9LWN8HGoqGdg9Rfu8suyYdEm4BZbDdiSWNfqE
 VDAVCJCAoTSxa0rzOhUvAeCfSOYD8EIvZRqxHMEvDUk4PPbFGtKXQpwhjOEZoxar8mP6IBTdW
 Wsxje6hJ6MLTYcZ89VsAU96xhShHqWgAWjZb5lntZWuS1XFLqQTYo9e6sqoxuAMJjn1lCOBaX
 d7fbky1in3jZOKOa+3zlbbKVjY+p/pcXyyjMnRXdUhzPNcmwspXvbQgF1gW3h9A+/QYElPa7c
 t2lduyuWN5onZf0xgRm8G1A7fNtCQtnWw00X9oUcz0MIUN/HhQPsPtvhNoPcujxT+Tg4CDPir
 ASuSQnZsT493QU1KniyFstcx7WxclzVBpVSzxdIiUwQv027HBmn6Ejf2gzc34bJtRJR3jIjmP
 x1sFzK0Tq71yS7+/cGoRATxc2gg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/29 14:32, Qu Wenruo wrote:
>
>
> On 2023/8/23 22:32, Josef Bacik wrote:
>> We are calling this when creating the UUID tree, however when we create
>> the tree it inserts the root item into the tree_root, so this call is
>> superfluous.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Unfortunately this patch is causing extent buffer leakage. (Thanks Anand
> for finding it)
>
> The latest devel branch would cause two eb leaks, one for uuid tree
> (caused by this one), another eb would be from free space tree.

My bad, the other one is from data reloc tree, not free space tree.

Thanks,
Qu

>
> We can remove this one, but we need to add those dirty trees to dirty
> cowonly tree lists at least in btrfs_create_tree().
>
> Unfortunately this means we still need to export
> add_root_to_dirty_list(), and would cause conflicts with later patches.
>
> Thanks,
> Qu
>> ---
>> =C2=A0 mkfs/main.c | 1 -
>> =C2=A0 1 file changed, 1 deletion(-)
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 1c5d668e..1b917f55 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -789,7 +789,6 @@ static int create_uuid_tree(struct
>> btrfs_trans_handle *trans)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 add_root_to_dirty_list(root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->uuid_root =3D root;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_uuid_tree_add(trans, fs_in=
fo->fs_root->root_item.uuid,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_UUID_KEY_SUBVOL,
