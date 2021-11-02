Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4849F442D7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 13:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBMID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 08:08:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47527 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhKBMIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 08:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635854727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jTNz4EufKDN9ShK7/qCck1R/rIQiYZuYZoSodfgPzU=;
        b=O43ms2S9d8Vw6v9SLL3T/IiDwD0Ph1+b3xC0oYZty2zE2iaRrj1jLIlwSkx3aQ3oIb/quP
        D3yxCw6zZsX5b8qLnI4vi10dCNAHZ+/CFhbWgzD7uaYDMir9S4Q88zqQNPXo/F/5HJ7xCF
        o5LysavEQ77rsbjT94UoqaruYraFnyc=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-_s73q8gwOTWddi1i8GQJhQ-1; Tue, 02 Nov 2021 13:05:26 +0100
X-MC-Unique: _s73q8gwOTWddi1i8GQJhQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfDfJLKhYVYjKh7rCDzSWttP4kBRv7wEGyaTxH+qeO7iahpO/aDpkjMriX73R/rfTs1+YxehSoqu6YfCx98SzZKG/uuxFLfk+sag1VL7FcW9aEn291fl374Os2FIbfQE8yFTu3E4tyTjIZ7Bi4j28mwN7W6yag3afItOd90TyrgVfPKXIkorGx3Ik8ZMf1c7tmyFCUHF1pn7lv+4f/97K8pzU0OZ1vgIiAgPzVuMFHHv5NG++nNyycH2orE4jI4NT/fYxmoxH9gKukgX9HSjkf6qZHO9MXhD2cvXoC+HqP7+a5Gf0Lt90j1EoEAduySWq6K+wpncL4YCFyJs6v+SFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO4/x09dCc86Gl/HxVoHJATi88KM5V90JLJSa2YVo5c=;
 b=dLm1erzI3pUQ8NAdXJ5Ctw/G+eoNVxMAhrhkhZKITpiBDYgSJQuNyyAQR80L/41wh41tQ3cRi21sAueXQ4QzkuklfGjJ/XHjLK0cRUMs9Oy18gVLEP/gxHOmIwpI+X0WYiOdYGwtEUU/0Le2JJLUdK5w7R3hOdaENnIujbbu2zONHMOIlfFjoj8OtWBaGuqwC9fj+SBXMPDeNKmXr1T5uyc+bfuMHKAD9P2msamLXTewE+Op4mcR3ACFzcp1lkrtEtVvqg3SJv9AISzo9w0NAlL10I79BcL8pgOQEJdUVu8OHBkz+UIIt7d1u+3L1/kvUlb8urvX9LSmCQuS9ffI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3783.eurprd04.prod.outlook.com (2603:10a6:209:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Tue, 2 Nov
 2021 12:05:25 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 12:05:25 +0000
Message-ID: <ed23bdd9-d336-f7cf-5704-2e02dcdb018f@suse.com>
Date:   Tue, 2 Nov 2021 20:05:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] btrfs-progs: Make "btrfs filesystem df" command to show
 upper case profile
Content-Language: en-US
To:     Su Yue <l@damenly.su>
CC:     linux-btrfs@vger.kernel.org
References: <20211102104758.39871-1-wqu@suse.com> <8ry6hiu2.fsf@damenly.su>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <8ry6hiu2.fsf@damenly.su>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Tue, 2 Nov 2021 12:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ee5720-02f9-4197-9dbf-08d99df90dad
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3783:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB378307DB80FCFAFA9FF0ECDBD68B9@AM6PR0402MB3783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7KR8Rv2U5uq30oBaUA0oafgeH1cVTFESDLuVH5nWJMyIceBr647nK0P1TU+LBcpv2sKMey3a6fOOXiOZ1nJEx7QH+suM5252+5XNEXZc/v9w2m5gVZgJu7tcCap+SyDurLlA9E9ONldzbbkYOOp3b6RjhN3Mm/6+cmIgmdlqQhdv0XpeSd+4hbWoVrjab5ceRK00z257f5VzsrRx3S+cbho04t8oi4cp270AhqDZ2X5UJQbgjnaPhnlXStkM7wOpwQnnQeD/1f67NnP03QHtF6YXhgsKDtWXOqX06zJX8ZV9Dx1Zg/6rqvo05+yKhsD64ta0KlaRSbWj/PmYTVLAP6Z7/ea/OfvCkwA/r+BmJEZSljOH3DMTpp/7ZRUr6PHqHiZYp+r81VDXn5yzyBNy2p1al3rRGepQhVDcM+R7xBwStGp8/ffsve9EqRCRbAdhMJ7waCpVZWyPqeGVxHJNIZrzHykFuxcu/zjfLooIQkH0+DIW9eVyyXweYfRf/RetGnwJVp5Ryg9QVRxFeUqJ08jC5UrjbNJP1iaXHETq4ID9CqNJA/AnAr5FhxPQX50ne4iqdYtRx1+ht3IEGLmPlpXOU8LUQBBJsN4z0LAcdeFVAUosMuJPrMH1iJV9zA7TUWTkBBPswlW9A3rHeLEeb1hiYdvLVmymwzZD8jkB4tvrSOLy3g5gZ7Dop26FjxZAV5waS6aJCV7E30jp81WCK22PpzF8QRVOB1rieBK0Vj1QrKGyzXUB3pH+WhIg3konCtsFxeYqjtKZAkhnwCQQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(66476007)(6486002)(53546011)(4326008)(5660300002)(8936002)(8676002)(2906002)(31686004)(36756003)(26005)(86362001)(16576012)(4001150100001)(186003)(31696002)(6916009)(316002)(6706004)(38100700002)(956004)(6666004)(2616005)(508600001)(83380400001)(781001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhlxO/8P6geNIwIEepqO/DM0LxMYjYTj6UskmDGkb2ywe1y5ziPfzp8b5/Yh?=
 =?us-ascii?Q?zrXstVGp3+LIRkod32AzCODMjq3ox5u+QE/QUIYn8N/CvQraiDowFtJm6Mdn?=
 =?us-ascii?Q?00pxW9+55487NarvxU9qVd0uyGWGPPvmuv4ORl84M9QxqCdozCr3bZG4jMyx?=
 =?us-ascii?Q?u7Co82CW39D7+TdvvZSPRQjhqcMV1JZYdxGaqkpB4DNWHanLeBMntI+hTQTb?=
 =?us-ascii?Q?GKb0BxKEffVlm3KKTuQgwTuB5n6KRhOuuXbAbZiKRthqElxvvrVNM9wEt7M6?=
 =?us-ascii?Q?DsgMTMXHLbInouxBGcDOGxGBosklRc9kgfhjkb0T95wu4OxQYUa2IIm+fNEY?=
 =?us-ascii?Q?fmxFSgpS0wV9PgQENK1I1whx4J/IHUr8iaQHnyFp4ut9Z0/aQXYzgqfuJuqh?=
 =?us-ascii?Q?+PwtBQtG1qrD9ie37vZ/4buXroFhCG4lOSWR6CVY4iRAPP/nom5Q3TQRDER1?=
 =?us-ascii?Q?tHyIlabuKllce7wfTnRAxX3CTdoKacId0WGVb0MG9r2OsF1P6+BoZP/NHN0V?=
 =?us-ascii?Q?ik+CmUw+KlSjqvztt4Zc2AA0aKFAKboGtbukVosKChW9KX8DOjA8XsEfHok0?=
 =?us-ascii?Q?/QZVcgmEGdYMuQzFuZu7Xr3yQ+BxvmI8J+I3N1Ou0rzq+zfxwkzldFD1YZ2H?=
 =?us-ascii?Q?SXb3YvHI43Ea8393idf2Nx04vwJHgHmHyplbgacgn91JLhUv0i8p5X+j2Wv/?=
 =?us-ascii?Q?czgxw7DEXcDVL7Y7xo5pIfyv9J5ErtLx1rMhPNqWzYb4ZJ/SYw8gaWlqXDv/?=
 =?us-ascii?Q?6HJS6u2XLTsZYnVZrBqni3pAxI3yFnDwlnOU8WneaT5LvVDNMiaVd1gLizjl?=
 =?us-ascii?Q?E/CrMt37Zz68YhU6+YADt/nKmlQN2jtLnLxjBspy9NC8/0lbfroYaP1Sqtro?=
 =?us-ascii?Q?qrq9tgfpajZKeHmi8V77iacccaqr2rALKwWJ6lTMWUBW3Co24Pizo+GyMMWw?=
 =?us-ascii?Q?4OQ5Fvo88gY1eeWZoLJf/uEG3D1je4jag8DY+RBTEpLQWNqquQR6dFGbudZ0?=
 =?us-ascii?Q?D6iTLDq2W9D9OnvytNR5+gO7VOiNhYy+Ox+8PIUs68I5+Krogr/9V1/EJ2kc?=
 =?us-ascii?Q?5BlgbgIgOx+YD9JdEjeyoLn4uFG+b8vFd5BVjoYZ5UYQNP8la4+gtqXnh23x?=
 =?us-ascii?Q?IDiaj+zt+GXD9Y1i9WhuizcwrXQ0l0zC5jQWFnb1OteYJ4qdhiFTuSj+WIQ3?=
 =?us-ascii?Q?eiaHRDh1+gTsXzAW33tljRmO52jO5hi0C5oBzLPQuMze1r8VAPEVmkEVOCB6?=
 =?us-ascii?Q?TeSFux8/kiWKSVeUfuADggeY7Ngl6pJoxCv65or3hevzzcKusJ+xnjTcNqks?=
 =?us-ascii?Q?Ol5CMD4aipxRsqqhZjCwMdyRxvgMBAJwP7nLWdNN0ESQk2Z7I3zzqv48/8kc?=
 =?us-ascii?Q?F1gRMPM9rUqsjg8GvpSjoxc2QwO11s+PrprE+sE2QJzLQWJcCoDYL00pgtbx?=
 =?us-ascii?Q?zbbfvUHPp3SVw4gfudsnL2iJXDqa5b1KhxQTBNBVFHsPKYd8Qkh/Y48uSKud?=
 =?us-ascii?Q?gdn2GviN4JORcKIu8z0g77+B/xP5/5e+irGzYHm/vuSjODI1uXxnfQsmb8xQ?=
 =?us-ascii?Q?vKlnl0QmlnmgXoC6Ejw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ee5720-02f9-4197-9dbf-08d99df90dad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 12:05:25.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zq7ZdKr8j6VpfCrDEsHBDFlSZZA2aJdS9y/NCht3Jw7yVbE0yWglWBzK953xvFF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3783
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/2 19:52, Su Yue wrote:
>=20
> On Tue 02 Nov 2021 at 18:47, Qu Wenruo <wqu@suse.com> wrote:
>=20
>> [BUG]
>> Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
>> to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.
>>
>> The failure of btrfs/151 explains the reason pretty well:
>>
>> btrfs/151 1s ... - output mismatch
>> =C2=A0=C2=A0=C2=A0 --- tests/btrfs/151.out=C2=A0=C2=A0=C2=A0 2019-10-22 =
15:18:14.068965341 =C2=A0=C2=A0=C2=A0 +0800
>> =C2=A0=C2=A0=C2=A0 +++ ~/xfstests-dev/results//btrfs/151.out.bad=C2=A0=
=C2=A0=C2=A0 2021-11-02    =20
>> 17:13:43.879999994 +0800
>> =C2=A0=C2=A0=C2=A0 @@ -1,2 +1,2 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 151
>> =C2=A0=C2=A0=C2=A0 -Data, RAID1
>> =C2=A0=C2=A0=C2=A0 +Data, raid1
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0 (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out    =
=20
>> ~/xfstests-dev/results//btrfs/151.out.bad'=C2=A0 to see the =C2=A0=C2=A0=
=C2=A0 entire diff)
>>
>> [CAUSE]
>> Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
>> raid table") will use btrfs_raid_array[index].raid_name, which is all
>> lower case.
>>
>> [FIX]
>> There is no need to bring such output format change.
>>
>> So here we adds a new helper function, btrfs_group_profile_upper_str()
>> to print the upper case profile name.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0cmds/filesystem.c |=C2=A0 4 +++-
>> =C2=A0common/utils.c=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
>> =C2=A0common/utils.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>> =C2=A03 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 6a9e46d2b7dc..9f49b7d0c9c5 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -72,6 +72,7 @@ static void print_df(int fd, struct=20
>> btrfs_ioctl_space_args *sargs, unsigned unit
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 u64 i;
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_space_info *sp =3D sargs->sp=
aces;
>> +=C2=A0=C2=A0=C2=A0 char profile_buf[BTRFS_PROFILE_STR_LEN];
>> =C2=A0=C2=A0=C2=A0=C2=A0 u64 unusable;
>> =C2=A0=C2=A0=C2=A0=C2=A0 bool ok;
>>
>> @@ -79,9 +80,10 @@ static void print_df(int fd, struct=20
>> btrfs_ioctl_space_args *sargs, unsigned unit
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unusable =3D device_get=
_zone_unusable(fd, sp->flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ok =3D (unusable !=3D D=
EVICE_ZONE_UNUSABLE_UNKNOWN);
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_group_profile_upper_st=
r(sp->flags, profile_buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s, %s: total=
=3D%s, used=3D%s%s%s\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 btrfs_group_type_str(sp->flags),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_group_profile_str(sp->flags),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prof=
ile_buf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pretty_size_mode(sp->total_bytes, unit_mode),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pretty_size_mode(sp->used_bytes, unit_mode),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (ok ? ", zone_unusable=3D" : ""),
>> diff --git a/common/utils.c b/common/utils.c
>> index aee0eedc15fc..32ca6b2ef432 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -1038,6 +1038,16 @@ const char* btrfs_group_profile_str(u64 flag)
>> =C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_raid_array[index].raid_name;
>> =C2=A0}
>>
>> +void btrfs_group_profile_upper_str(u64 flags, char *ret)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 strncpy(ret, btrfs_group_profile_str(flags), BTRFS_P=
ROFILE_STR_LEN);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < BTRFS_PROFILE_STR_LEN && ret[i]; i=
++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret[i] =3D toupper(ret[i]);
>> +}
>> +
>> =C2=A0u64 div_factor(u64 num, int factor)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (factor =3D=3D 10)
>> diff --git a/common/utils.h b/common/utils.h
>> index 6f84e3cbc98f..0c1b6baa7ae3 100644
>> --- a/common/utils.h
>> +++ b/common/utils.h
>> @@ -75,6 +75,9 @@ int find_next_key(struct btrfs_path *path, struct=20
>> btrfs_key *key);
>> =C2=A0const char* btrfs_group_type_str(u64 flag);
>> =C2=A0const char* btrfs_group_profile_str(u64 flag);
>>
>> +#define BTRFS_PROFILE_STR_LEN=C2=A0=C2=A0=C2=A0 (64)
>>
> May it be 8?
> struct btrfs_raid_attr {
> ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char raid_name[8];
> ...
> };

Right, and even UNKNOWN with tailing \0 can fit into 8 chars.

Will update in next version.

Thanks,
Qu

>=20
> --=20
> Su
>> +void btrfs_group_profile_upper_str(u64 flag, char *ret);
>> +
>> =C2=A0int count_digits(u64 num);
>> =C2=A0u64 div_factor(u64 num, int factor);
>=20

