Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A880A234407
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbgGaKVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:21:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:47308 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgGaKVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1596190874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=I5cu61SQZPZI9kzyupOw2wStqw3CKapfexoBaKJAD08=;
        b=NTI650/yRhQdsgEQQkLw1L3PASO3bdasOZvwJQXp9rEZuAifLFprCVIW2PUdVCxX8jJaB/
        ibWBGDZd5DmSFsr+rU3a6XPQntEIFvaEVCD6zRqGsT/wnivkKOlhUSdY/kXWWLx0nsUqZ9
        eMuCMpl3TnSv6dM3W3PjECNeeRzrIA8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-i1ePc_hLNEqn-gkQ-1fJ7Q-1; Fri, 31 Jul 2020 12:21:13 +0200
X-MC-Unique: i1ePc_hLNEqn-gkQ-1fJ7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQoJHA+DQxrbQUXXuSScPMFZGG039fi3zNB3lhQMw47uQyZfwITKV1jISh43sK/cWk6ev+5/rjyU3UctkVPb6V3wjY/wO8mmzjkZfZMOqanO2CRHCUZC3lu/DoB0S38hysb5Ghp3UP5N3BoMzyOWzqzTkKsbOAPMZMHSuSQ5RPqy+aTmWzyu1bKWzX+Zjd0DTEbHTuaAaRuezz5MIZDn5JJzS3U/FZ1bleLi/9pY2h2PQjulLmj5Gu7PZdNr2EIClqA45TXy5loydLGqaLc85zMPkHmh1WCtKEhPkDpvZOkMmRvs8PCtobiF312vdksVXtNdQ/DngXn4Q1wFH5H+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XGT0McbwUwg23dFyuB793EmvXQTbUk3wFqdA/MxNJk=;
 b=FddAd20RqVgJKfDIScJCs5RIHrWailSBgzq+hrUaQbmbm+RYt0vTcKXJiT62/YtEw5kI+2So1UXvDLpbdw9xggFNUcC5feAI4g6N42chcArImdTCtO7BjAOqLWQ1ojZmOZ/pI0To6QRyntrh0Y+MW2cq+12wYAv5IGUzUNAQMmx57ER6lJmCu0/KfxSaZbTwL6+j2fG15a54K/Kb90m/MD6c2hXF/4cGorNh/fnbYR2eCD4qG7ur2IPux6hdglzx/ZBWrT+J/uRwgGPSIRGDiw1baP/gHSx1vnQZP5uNaTeYCVlb3yBRWyNC50GEjzC4l2y1zR7rCloSJ+sIOCjBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6689.eurprd04.prod.outlook.com (2603:10a6:208:172::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 10:21:11 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 10:21:11 +0000
Subject: Re: [PATCH v3] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     fdmanana@gmail.com
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200731094815.104794-1-wqu@suse.com>
 <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com>
Date:   Fri, 31 Jul 2020 18:20:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0165.jpnprd01.prod.outlook.com (2603:1096:402::17)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY1PR01CA0165.jpnprd01.prod.outlook.com (2603:1096:402::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 10:21:09 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a391a103-6b7b-48b1-3b33-08d8353b725e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6689:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6689535E759B4ECA395A368CD64E0@AM0PR04MB6689.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtkIc+9JfZwYWpRl98x0ccDEXh48bHZGlgm60LFazB7sgUgzT+4URoZ0Mdcf2Tbxnf/Je0hpasBmqfkK7emhL6lM6Gke+2M7FYkXhZhhk11dsFjUA1lSntyLbasixwvEft7aeAtMOfE4b9ioTBUoHJjQcNXQSNdBuPBHZtE4rRHShcu/jAyXQuohoT6yOXHCLWa//2whZjhd18Bz0jLlav2E3ijiuLrKtYRIcXKxTDijQVi9y3ATEb/h5LgWF6jFgCMFwqV4Ooz/gRkxAnufv/F6ab+jY78hCBJJz60l5p2BRTAUM/p6bS+dzDaz+nuzjsjLACypYg298Wh38Fnc1bPe2UQNDOrN1xEYIivL/DSvuVIAn5KEp0ZJwOv/ORAWMab74virNsu7xUpV7BAX8w2HtnMaHOQNkVCgmaR6xmstviuIHR4cmX73M2HEQaOfX0YCtnAQ0ZBKil9iJSGgHB8voxoNG3QlE0VpOC6PG6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(26005)(16576012)(186003)(16526019)(55236004)(54906003)(5660300002)(31686004)(316002)(6706004)(6486002)(4326008)(6916009)(107886003)(8676002)(6666004)(53546011)(8936002)(52116002)(66946007)(966005)(2906002)(83380400001)(478600001)(956004)(66476007)(66556008)(31696002)(86362001)(36756003)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uGOVh8f0psKQYGm0FV5iHXii45S1oHy0UO+y+Se+M3NwnwiO8GJ84cnx+7DR3IdJmYMM17dyUmEtuFZZI88W6FqziHx/DRCTnrKXqEJlZc2Y8O5wEpXcUnPlKrxDgHS0llGXkgLu2Cb48uw8nVhwR6ieAhAc97Js+o5+Vmy47HSrH5B3Wb76eD/5UgqpsjABPGlvj+I7OMiknqZ8L7QKCMYKGPeojlobho5wxDlwIqq5uwLlw0CAQwyv9ud8FSbL5pbsntzPEBx7JSCCoSbsfyU27nX0Umjb9F4n6RS7yqCpGACFUl+sHm5IYDbaAuL5p/UklYo6NXYa0T65qp6MBVD1vqlGLshfQy6dYWaFFktpI9ELtdcaBMogWDEqyoCIyUeFiOjogFw4So2dtO0vDEIwDbnG1vB4JNAb+b4AoQSLhN2WeIj12pEMTfAWfNIooIYlvls7U5Ia2pomWm8P+3mqscxFn2cDGrKEtA8l7+/KV4NHwYVhK7OPNQ1Ky2WU5YXcpv7EKbmWxyHe7UbihKVqy9GLa28wWJlZwGb0vMjt8qUomRRR48vD317KVzKiZjlCpC6/OpoDJqB9pw0GLnhlCphYSNSaKHHnh5Gu9HaIE/hFz3c4+Yiolsk401xHDTx1FpfILpbO3xR4vb6SMw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a391a103-6b7b-48b1-3b33-08d8353b725e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 10:21:11.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbWzTAi+eNrxq4+tv9dz6V8jFe3VYcfv6ZQyl1W6mq1pHs7Rwm0REB+Tjt3TPetX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6689
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/31 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
> On Fri, Jul 31, 2020 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can lead to tons of beyond device boundary access:
>>
>>   mkfs.btrfs -f $dev -b 10G
>>   mount $dev $mnt
>>   trimfs $mnt
>>   btrfs filesystem resize 1:-1G $mnt
>>   trimfs $mnt
>>
>> [CAUSE]
>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>> already trimmed.
>>
>> So we check device->alloc_state by finding the first range which doesn't
>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>
>> But if we shrunk the device, that bits are not cleared, thus we could
>> easily got a range starts beyond the shrunk device size.
>>
>> This results the returned @start and @end are all beyond device size,
>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>> smaller than device size.
>>
>> Then finally we goes "len =3D end - start + 1", totally underflow the
>> result, and lead to the beyond-device-boundary access.
>>
>> [FIX]
>> This patch will fix the problem in two ways:
>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>   This is the root fix
>>
>> - Add extra safe net when trimming free device extents
>>   We check and warn if the returned range is already beyond current
>>   device.
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/282
>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_firs=
t_clear_extent_bit")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add proper fixes tag
>> - Add extra warning for beyond device end case
>> - Add graceful exit for already trimmed case
>> v3:
>> - Don't return EUCLEAN for beyond boundary access
>> - Rephrase the warning message for beyond boundary access
>> ---
>>  fs/btrfs/extent-tree.c | 21 +++++++++++++++++++++
>>  fs/btrfs/volumes.c     | 12 ++++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index fa7d83051587..7c5e0961c93b 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -33,6 +33,7 @@
>>  #include "delalloc-space.h"
>>  #include "block-group.h"
>>  #include "discard.h"
>> +#include "rcu-string.h"
>>
>>  #undef SCRAMBLE_DELAYED_REFS
>>
>> @@ -5669,6 +5670,26 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>>                                             &start, &end,
>>                                             CHUNK_TRIMMED | CHUNK_ALLOCA=
TED);
>>
>> +               /* CHUNK_* bits not cleared properly */
>> +               if (start > device->total_bytes) {
>> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +                       btrfs_warn_in_rcu(fs_info,
>> +"ignoring attempt to trim beyond device size: offset %llu length %llu d=
evice %s device size %llu",
>> +                                         start, end - start + 1,
>> +                                         rcu_str_deref(device->name),
>> +                                         device->total_bytes);
>> +                       mutex_unlock(&fs_info->chunk_mutex);
>> +                       ret =3D 0;
>> +                       break;
>> +               }
>> +
>> +               /* The remaining part has already been trimmed */
>> +               if (start =3D=3D device->total_bytes) {
>> +                       mutex_unlock(&fs_info->chunk_mutex);
>> +                       ret =3D 0;
>> +                       break;
>> +               }
>=20
> Sorry I missed this earlier, but why is this a special case? Couldn't
> this be merged into the previous check?
> Why is an offset matching the ending of the device not considered unexpec=
ted?

For such example:
		0		1g		2g
device 1:	|///////////////|               |
|//| =3D Allocated space
|  | =3D Free space.

After one fstrim, [1G, 2G) get trimmed.
So in the alloc_state we have
		0		1G		2G
device 1:	|  		|***************|
|**| =3D CHUNK_TRIMMED bits set

Here we just focus on the unallocated space, ignoring the block group parts=
.

Then we run fstrim again.
We call find_first_clear_extent_bit(start =3D=3D 1G), then we got the resul=
t
start =3D=3D 2G, end =3D U64_MAX.

In that case, we got start =3D=3D device->total_bytes, and it's completely
valid.

>=20
> I also don't understand the comment, what is the remaining part?

The remaining means the unallocated space from the @start of
find_first_clear_extent_bit().

Any better suggestion?

Thanks,
Qu

>=20
> Thanks.
>=20
>> +
>>                 /* Ensure we skip the reserved area in the first 1M */
>>                 start =3D max_t(u64, start, SZ_1M);
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d7670e2a9f39..4e51ef68ea72 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *devi=
ce, u64 new_size)
>>         }
>>
>>         mutex_lock(&fs_info->chunk_mutex);
>> +       /*
>> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond =
the
>> +        * current device boundary.
>> +        * This shouldn't fail, as alloc_state should only utilize those=
 two
>> +        * bits, thus we shouldn't alloc new memory for clearing the sta=
tus.
>> +        *
>> +        * So here we just do an ASSERT() to catch future behavior chang=
e.
>> +        */
>> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-=
1,
>> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> +       ASSERT(!ret);
>> +
>>         btrfs_device_set_disk_total_bytes(device, new_size);
>>         if (list_empty(&device->post_commit_list))
>>                 list_add_tail(&device->post_commit_list,
>> --
>> 2.28.0
>>
>=20
>=20

