Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C2234423
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgGaKi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:38:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:40144 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732397AbgGaKi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1596191902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ZgWOi6DesQlCMEQI36aWMGhz6CoevTYxjf0da/wGU5k=;
        b=HGQoGq9kBb1aTmqs9tV/jyUVjIckdhZN/AHOOmxkI/SpUJCPgKFVdpy57RHLzslmQ07ZCn
        9NCypdPf/yXK+YK9OgEdMNiImiBQ8DL98oTyUeZzNOdr+yH8oBHlcYUgvbfSnCXfspE2hn
        8xCNgDvaiCuSOeZlfFQFKs58KkjDFgs=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-fsJtJOGROK-AnaflkvhWmA-1; Fri, 31 Jul 2020 12:38:20 +0200
X-MC-Unique: fsJtJOGROK-AnaflkvhWmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eohd10towCaBt5zrXCbepji8iskQ2Q9BD9Bq3s3EbW8dP1idD5XVnA7lXX+fwVB+93GAdTGDUmeRerue2KX4+xY3GwNaiImgksNJebSwLHzlX3g+XYuItwi6jHfDDdrZX4QE/p/TrdBJwDxgcQo9qQR3yy6vRxvjYwdNxru+l+ZPqlgPh2AfOlE3XfZhlku2vxijATcyeJNWZ5L0DFXbK54xiLTlo8r9cyqLlD4yzz8YHBs/kGoqGdm1x0f28k0b0Aina4jYLpSa6AkDfjWKYkFR2d3axKKdj+956D9zCc6xp1WY5SfI3gE+K2Nj4zplCWs4XcE7NyTPNAjb2+spFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgWOi6DesQlCMEQI36aWMGhz6CoevTYxjf0da/wGU5k=;
 b=DjkMDEDBNaMUkVKNuqFotj+3dcdBPUiHL1OAT3vjQ7sYUbfKL5BSDhzK7BEcVn6hmJT4WC0CMrFIMz/YRNRxka34ze+XFC1j3Zq6E+Pobt2kFfkY9eL2AXazyqJfdWVnidbhRpM8geUG/sCKJ/89ByZ7Ca5k/MChu9dP+GwYKkAq4UVY4MbNhTMprbBZG2KO83Msv0V25j5pcghHBgm6hbITjUgPApMU5VDacAXs+AGvsGMJp8bDrQeP+47544nuZlgo5fYMX3nOLO6QfhnktGTFUXYqO0MqKAAfTSws/CkiKGhuNQkWa2fRi+khgFyBAq7B5RZBRizpW69PfDdrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5249.eurprd04.prod.outlook.com (2603:10a6:208:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 10:38:18 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 10:38:18 +0000
Subject: Re: [PATCH v3] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
From:   Qu Wenruo <wqu@suse.com>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200731094815.104794-1-wqu@suse.com>
 <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
 <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com>
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
Message-ID: <36a8de60-9f22-8bbf-39fe-e582afa448b0@suse.com>
Date:   Fri, 31 Jul 2020 18:38:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NWSlOCKu9XnPPa14Bfs6tySFlv6tuJeO5"
X-ClientProxiedBy: TYAPR01CA0231.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::27) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0231.jpnprd01.prod.outlook.com (2603:1096:404:11e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 10:38:17 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140d11d3-bfd4-4b98-d364-08d8353dd6d8
X-MS-TrafficTypeDiagnostic: AM0PR04MB5249:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB52497E8AF815437985462750D64E0@AM0PR04MB5249.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM+8V0PDBlg3YC+yn4efRUo3deUcAVSN8laG4n7W3bmYMOJtsF/LNieNCRKRjZYMAXliSuIS+kO22KRWoHwrPZxJBJkCTs+olXzwAgg0IyRGPAvsOAx6bFiBDM5Q4SE4wa90jLneLtyGx889I4M9hNsfIm/LClymsNKQovFRwMkE4b7q9hng+szP8wI+PfWoSH1RXerWPOgkp0Vbkltm+uQwHm5KLd46KDl837HkgqP6xfPcmLA8ZwN9Sm0REBlkp620DUEvzcZ2EVynjjU7e1ATDuKXbBzFjZN74CRPNjWpBoWEDbl6t+DVXT+Uec4gg+WS1xI93/Bm+9bC1H+VbUwo8pxbtpX59/8Fz/vlEddDvkvrnouAFPII/CqAR5aZ/MZuOfh2FaPWHM1kxmnP20q4i1QCMLRh0JQ15U0ebVr2LHMw/I9DqZ3RB8zRZ6h7B7ymTN2346qjTAe4L5f81GPJmObV1r3UbfwhqCr0qG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(66476007)(4326008)(66556008)(66946007)(2616005)(956004)(478600001)(86362001)(6706004)(6486002)(6666004)(16576012)(54906003)(235185007)(55236004)(21480400003)(107886003)(966005)(26005)(5660300002)(186003)(53546011)(31686004)(33964004)(83380400001)(6916009)(36756003)(52116002)(2906002)(8676002)(316002)(31696002)(16526019)(8936002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NtlLmQ5E2sXC3NFia/0jnqE+Fcb5iG6YD9mQYv0wuopYaG9kDTHYJq9yYDgwuXjb2LUHPbJBBJF7TRoKN9HPVgH7+s5qeLzx3eZAS3mMkCCDgTzHLtWARU4d3Ecent2GWsDyIT9EDVKUTlNt/7os7OpHoOTG51GQBNJS/wt7Xw52cwETgKZ2QPRSNKZwBwWypoP+WGmD+MSV4kF8ivINgwDtGxyMz0kaQpPTKk64Nga1z9KVg9S7vPBq4vqDtgVzE/FEJzR58MjtH7nXSMe3Z+tCy6uSUmdLzDzEOhDJ7CzsHr8kw8NDPUh7jbbvQAZdF71aUZD6t321fqUuTxBEg8drq8mYAEn6hvlee23U1zwJ6e4nztm/u4CYbhexVygscnayHdma/+mqNkBudtFkQPgOTbM8vJfddzIb7fktyRO9EteHSLX3ihQf0xrV9EIAbW2to1Bce6twHcm105g0pTS0avuxnIDULhy8s3KM5FqD4kLBYsE6qzeSAd1Ji08wTqch0FEpwnDX2fXFyrUKlMnAcTOHucSh07QcIdqXhm7+tpn8Ol4Cv1nfChGQMaaWr1RpvjYcidMq8ZrXdQS77Cw68yMiAotmWpwDkSgAzrumyR1d5QANKeUeWabBtW8oX0jpYtMQEXm6HDLqHxlgvw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140d11d3-bfd4-4b98-d364-08d8353dd6d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 10:38:18.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe8xGnTO/Pjn532eHr6QDoG10poam/ZlRS0MD9FcOZI5MO+f7nKHR++QQaP//HrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5249
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--NWSlOCKu9XnPPa14Bfs6tySFlv6tuJeO5
Content-Type: multipart/mixed; boundary="aZfYHwo7F5DMetLyBrY01O8raAzjm5hgO"

--aZfYHwo7F5DMetLyBrY01O8raAzjm5hgO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/31 =E4=B8=8B=E5=8D=886:20, Qu Wenruo wrote:
>=20
>=20
> On 2020/7/31 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
>> On Fri, Jul 31, 2020 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> [BUG]
>>> The following script can lead to tons of beyond device boundary acces=
s:
>>>
>>>   mkfs.btrfs -f $dev -b 10G
>>>   mount $dev $mnt
>>>   trimfs $mnt
>>>   btrfs filesystem resize 1:-1G $mnt
>>>   trimfs $mnt
>>>
>>> [CAUSE]
>>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's=

>>> already trimmed.
>>>
>>> So we check device->alloc_state by finding the first range which does=
n't
>>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>>
>>> But if we shrunk the device, that bits are not cleared, thus we could=

>>> easily got a range starts beyond the shrunk device size.
>>>
>>> This results the returned @start and @end are all beyond device size,=

>>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>>> smaller than device size.
>>>
>>> Then finally we goes "len =3D end - start + 1", totally underflow the=

>>> result, and lead to the beyond-device-boundary access.
>>>
>>> [FIX]
>>> This patch will fix the problem in two ways:
>>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>>   This is the root fix
>>>
>>> - Add extra safe net when trimming free device extents
>>>   We check and warn if the returned range is already beyond current
>>>   device.
>>>
>>> Link: https://github.com/kdave/btrfs-progs/issues/282
>>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_f=
irst_clear_extent_bit")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Add proper fixes tag
>>> - Add extra warning for beyond device end case
>>> - Add graceful exit for already trimmed case
>>> v3:
>>> - Don't return EUCLEAN for beyond boundary access
>>> - Rephrase the warning message for beyond boundary access
>>> ---
>>>  fs/btrfs/extent-tree.c | 21 +++++++++++++++++++++
>>>  fs/btrfs/volumes.c     | 12 ++++++++++++
>>>  2 files changed, 33 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index fa7d83051587..7c5e0961c93b 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -33,6 +33,7 @@
>>>  #include "delalloc-space.h"
>>>  #include "block-group.h"
>>>  #include "discard.h"
>>> +#include "rcu-string.h"
>>>
>>>  #undef SCRAMBLE_DELAYED_REFS
>>>
>>> @@ -5669,6 +5670,26 @@ static int btrfs_trim_free_extents(struct btrf=
s_device *device, u64 *trimmed)
>>>                                             &start, &end,
>>>                                             CHUNK_TRIMMED | CHUNK_ALL=
OCATED);
>>>
>>> +               /* CHUNK_* bits not cleared properly */
>>> +               if (start > device->total_bytes) {
>>> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>> +                       btrfs_warn_in_rcu(fs_info,
>>> +"ignoring attempt to trim beyond device size: offset %llu length %ll=
u device %s device size %llu",
>>> +                                         start, end - start + 1,
>>> +                                         rcu_str_deref(device->name)=
,
>>> +                                         device->total_bytes);
>>> +                       mutex_unlock(&fs_info->chunk_mutex);
>>> +                       ret =3D 0;
>>> +                       break;
>>> +               }
>>> +
>>> +               /* The remaining part has already been trimmed */
>>> +               if (start =3D=3D device->total_bytes) {
>>> +                       mutex_unlock(&fs_info->chunk_mutex);
>>> +                       ret =3D 0;
>>> +                       break;
>>> +               }
>>
>> Sorry I missed this earlier, but why is this a special case? Couldn't
>> this be merged into the previous check?
>> Why is an offset matching the ending of the device not considered unex=
pected?
>=20
> For such example:
> 		0		1g		2g
> device 1:	|///////////////|               |
> |//| =3D Allocated space
> |  | =3D Free space.
>=20
> After one fstrim, [1G, 2G) get trimmed.
> So in the alloc_state we have
> 		0		1G		2G
> device 1:	|  		|***************|
> |**| =3D CHUNK_TRIMMED bits set
>=20
> Here we just focus on the unallocated space, ignoring the block group p=
arts.
>=20
> Then we run fstrim again.
> We call find_first_clear_extent_bit(start =3D=3D 1G), then we got the r=
esult
> start =3D=3D 2G, end =3D U64_MAX.
>=20
> In that case, we got start =3D=3D device->total_bytes, and it's complet=
ely
> valid.

Sorry, although this is correct, it's duplicated with the later checks:

                end =3D min(end, device->total_bytes - 1);

                len =3D end - start + 1;

                /* We didn't find any extents */
                if (!len) {
                        mutex_unlock(&fs_info->chunk_mutex);
                        ret =3D 0;
                        break;
                }

If we got a returned start =3D=3D device->total_bytes, then here we would=

hit len =3D=3D 0, and exit.

So my (start =3D=3D device->total_bytes) is duplicated.

I guess the existing one is easier to understand, thus my extra check
should be removed.

Thanks,
Qu

>=20
>>
>> I also don't understand the comment, what is the remaining part?
>=20
> The remaining means the unallocated space from the @start of
> find_first_clear_extent_bit().
>=20
> Any better suggestion?
>=20
> Thanks,
> Qu
>=20
>>
>> Thanks.
>>
>>> +
>>>                 /* Ensure we skip the reserved area in the first 1M *=
/
>>>                 start =3D max_t(u64, start, SZ_1M);
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index d7670e2a9f39..4e51ef68ea72 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *d=
evice, u64 new_size)
>>>         }
>>>
>>>         mutex_lock(&fs_info->chunk_mutex);
>>> +       /*
>>> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyo=
nd the
>>> +        * current device boundary.
>>> +        * This shouldn't fail, as alloc_state should only utilize th=
ose two
>>> +        * bits, thus we shouldn't alloc new memory for clearing the =
status.
>>> +        *
>>> +        * So here we just do an ASSERT() to catch future behavior ch=
ange.
>>> +        */
>>> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u6=
4)-1,
>>> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
>>> +       ASSERT(!ret);
>>> +
>>>         btrfs_device_set_disk_total_bytes(device, new_size);
>>>         if (list_empty(&device->post_commit_list))
>>>                 list_add_tail(&device->post_commit_list,
>>> --
>>> 2.28.0
>>>
>>
>>
>=20


--aZfYHwo7F5DMetLyBrY01O8raAzjm5hgO--

--NWSlOCKu9XnPPa14Bfs6tySFlv6tuJeO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8j9I0ACgkQwj2R86El
/qj7XAgArT+fKqZClX+e/+3KEnbLvPCLnfPEtBUWi0SsmzSk3x+j32phpdERLNV3
TebADsxN6kq9lX6lYxVsxLaGQ16f5U4y9SBnZzhPJalCchKRYXz6sZdvth4nvSs0
aELdflVVsoPyIyTuE9rdPMCQvklnC7mALQbIo5sieWUTAadX0FO+konifAAm17F1
hzFNc4aU4Isyei6LJVKDg2kKUQLlkf0GkYg2uxSF7V2LhwR1efMPFVQpovS79YXo
4dqfvl5/LXDcduPNUdz1ZrUS4RDPofn3d/Uo8Qj8DMmBfpDvKb85I7Nq+UAN0jVB
AERVBFRnWiYhxl/Oudh1XD/Pf3bCmA==
=9Sms
-----END PGP SIGNATURE-----

--NWSlOCKu9XnPPa14Bfs6tySFlv6tuJeO5--

