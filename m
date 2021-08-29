Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199383FAC0E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhH2NuL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 09:50:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:24490 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhH2NuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 09:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630244957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Zcd+/RvtSSanNKOAciWS481Aw6UlAEN04jn7UZXbq8=;
        b=ZtjO8gR/wvDso0VQx8NFosCNUZbvgbo6b1bEDwP8DvLU6JBYHLf5qcFRbmqO4cSEGeMcAf
        CFdp429AUirc2d4Abx+ALFc2/B5x2/hGDoVFTWXDJnQNqm6V8Cqla7Vscigf/GIThxlCwO
        /srhSN8pAaPe3K3jYMwelRLtL/d2/Z0=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-_DbgiTAcMOaH_W-RyjhVnQ-1; Sun, 29 Aug 2021 15:49:16 +0200
X-MC-Unique: _DbgiTAcMOaH_W-RyjhVnQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER2yl3OhVw+qM7kErZ17r7GnTDRK5RMPWUYnAcJL9NE2xhxcjp8s+xk3VQpOML8nMmIHq0gcojAP+PDg4MuE+g3kmCjv/e+CdvCfFkT1IDUdq7/bW6aXoxHO1bF2vY5vBWk2C5Nrqs14CFhDvv85QhKaIDoI61mme2THMML6SKoHGX7aNnShrGuBqkFnXCtuS/lDimQ0rwwN6huEFKZvZGpscLhE1am/HNaC73DhCy+4tIwIcVbnJoXN7ptIeihnAj3vrvpSNC4dxQrtwzwkewx8Pj55vIwmnk9zr6XhNYYj/1v8y508Zfb+VbBT95EBz4TSzDSNR+SrMhbqsywB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8KMlQ9YQUQ3LtF4t14veKAc3fpDT0PQWeWrQAT/wQI=;
 b=E4QQLYWggLX0dfpO9kC9M1WIBHHcoushyrrfJhlPSN0VQyjGecv8sxIsFfFjyuACqLBSck6rQMVwBVsdFymkcfT5z3FHpkB94o37jRf/6hHEMU0Tb89y/q71jvxH4wjWtS7Y1FQPlZUt4TnAGfRpCSfAQfx2ftJlQLaTUJsOzfUXc+P5NrJeZb/XmWtwhedUBAUYqIky0QRUi3muKugF+cdwn7gwPyyYGZXKLC8O5FfnGLOqV+NAP/a+IoQSpjAFAjyZgjIKM7ecXdvnnUqFk9FJbx1rrFM19zlq2XAj6pUHshCJQuIAB+8uHagWSlo+cxwjQOsicFznwztC+r90wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sun, 29 Aug
 2021 13:49:15 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 13:49:14 +0000
Subject: Re: [PATCH v2] fstests: btrfs/246: add test case to make sure btrfs
 can create compressed inline extent
To:     Eryu Guan <guaneryu@gmail.com>
CC:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210826053432.13146-1-wqu@suse.com> <YSuOr0XhCgVBcnc8@desktop>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <e85d5800-8f4a-5bca-a5a6-e537f2fb998a@suse.com>
Date:   Sun, 29 Aug 2021 21:49:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSuOr0XhCgVBcnc8@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Sun, 29 Aug 2021 13:49:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0be2bd3-134e-4ddc-b97a-08d96af3c9b3
X-MS-TrafficTypeDiagnostic: AM7PR04MB6822:
X-Microsoft-Antispam-PRVS: <AM7PR04MB6822AE9D64295E7BA5714023D6CA9@AM7PR04MB6822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CalH67TWP0Wi9v4yZQwrzb15LZmtqxUXpEj4i0acktKuGOnVajUJ34UvkQ0UkXIcGloGnMmxPs7LWifksdQovXvrsHvJO0MbUqWFp0VXCNR76fYepVBXvdNAn44OrTJPY/EDZhvUxZihfabQ2lSSeHGCrHFTn586FkRRz4Xbg58Jt3bBVHeYm3JmbPN2S1g46gHir8L3TZQm7rgKNf1Ga0Iub5JnAfUIYjGTgHP/2ZnWDmffLVVslm0pjn2jpD7PWbN8wjFKwW6uP280Bmf05N6KceuhTjA3XQTQpAZBIDZrXJnqsjhg0rWyJ1HF002rV1KW+HzsbCeRWDsRf8E9K0UfDcLvnoHxo7ZIxgjvIiFVD6im5U4kjTFSvgpFivdwa0Zo2vzS4/ie1rvtT3HF4zRRTW47crTXNjievr0nKCrGnwjRZI4d7Dn64jsZHYmFNV9vkx4jF7HAlWCMdHK2F1NorjnxlyijVC9+TV8fJbrR1ND+nZWWucMxBqEcS/gfAZ4tudWTuTkHPgLdvlnlaLWKy99Psjj+HMNN4nEMOqffY/IB1xAJE4Emrpl5zIFRXDXLy78jlrOEbhPpfwAnSmTW5eDkx+C286rWFe++GbVXPlq5AkfS0l/XrUtCVCbdeX65sTYtb4tcnjVTJetUmq44S9/zhTmcC5rV53T5EEr7iuW208JU5yHgO++L5PhBOE5VXMU4RBd2IreEgf1uvveHyfVjpznnGlaorqNVKqqG7sjRC5jvAyXp/oZTRRM/pDbYpzApyyWQRpDTqCtqCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(8936002)(66556008)(66946007)(31686004)(5660300002)(36756003)(956004)(6486002)(83380400001)(66476007)(478600001)(86362001)(316002)(26005)(8676002)(2616005)(31696002)(6666004)(38100700002)(4326008)(186003)(6916009)(16576012)(6706004)(2906002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9J3Cs4W6KuxXFYjWUHQwFuLjOD5/pvhTQ8ozsszqVykpZTjbCCdu8agN/lI/?=
 =?us-ascii?Q?2OdpPChl2ZTOafvKzrUOkoo0iVed/uuMNwp268EkJTZ2OgTpLHobaZpXWKyC?=
 =?us-ascii?Q?Z9J5tdShnyZsqayVu0xluOLeeaF13TOLnF93jcYvXGPRefHDOutqoky4T2V0?=
 =?us-ascii?Q?Nmz/8fxuv1op9+D4nvwZWflpW07d65TvYH7VkhR93ddMFwzB5Ldx0CTV5C41?=
 =?us-ascii?Q?YVIhGji1SLosyDCnAGFNAMkzS/47F6LOV5vWQfwQpm+XXDn4d73q6U66Sus0?=
 =?us-ascii?Q?5G6kViuYwwywi8wSLw7TWodXQKzfKCgr7akLnCqcUfoKJ16PTFUY9qUmLxXI?=
 =?us-ascii?Q?w7idKQA61WLss8sj7hQg45UavAci1SnP9wJU939dIu6Joc14ONOcomD3hrYx?=
 =?us-ascii?Q?LOPvgdahfFBtSnuHYisw4Yz+v6E15oOqQ8sPvVTMPXrFY7CzjkODVw6pIa/t?=
 =?us-ascii?Q?A8uuoiC2+IyPv1P0jxM2VbyUKx4tLn0xkylUe9XQmmt0WSXjvtrVwDLgk8Xt?=
 =?us-ascii?Q?/pdnh0W5OxKpmSIh22uu86jbrblswUruzLQZqLDtQU3ZsrCRuVPc7GYaHNUR?=
 =?us-ascii?Q?C+CDN11w1typ83PgBpUXn4/EcMb7KdtA/2hIlEm2RfK/wFYORd9baZrlr6sm?=
 =?us-ascii?Q?ZD+ElD8+6onb1rkBasu14+Q4BtlZSukbK1M9u53kt4a4KRrmjLW9b85soNZ3?=
 =?us-ascii?Q?EmnDlgF8Gt+k5gH2CGkfVSDqxLvhIcQeONVkQNRowKQjXY4FtL5OGVu+3s+p?=
 =?us-ascii?Q?Rs+BQb9rRDEXS4rt9a4NNfUWhTfDBJOYIm5mUxjjo73Y7nCYLosiThAYpYAf?=
 =?us-ascii?Q?u6cIO6i6uToR/0+veGICmAax/1iMW4k1TQHL5NAa74MAxoZND48VjTUv4E6Y?=
 =?us-ascii?Q?b9diViwZsUKcx/xvgihFC8WYcn110jfbqpdLnS5DJ15U9uy7/7VT1ltDXRq9?=
 =?us-ascii?Q?a9/KXQ5ptwPsKTDr/nITXBzDGoTiPMq0v4oTluyF6yyED46WxaS8MW6vgmex?=
 =?us-ascii?Q?ZAfIJhVb7vnS5RtBNGzDHr5yXJaOlccZ8MJJmJFQaW46R1pFCLzWSHbhTKcw?=
 =?us-ascii?Q?IKwHiCg7MrRpznt+9IgDMWhiSczcF5l2zJVMTAF4f/foQ3DJjiRPBJkEsZah?=
 =?us-ascii?Q?CdLmNbyoNyimh/OFnqMF960ELPUB/5OA0kecQ9CVohqGcZX8+5d0mWvwb+ag?=
 =?us-ascii?Q?C0V3uO6WXyy6lobrRdpsmmQepGdfHzWrEJisGEwMG38Glib2GeeEoe/b00C5?=
 =?us-ascii?Q?CeXURF4OvzeySNXGHzx5WSnADoykG1BaFitCwMQk66TKmnFxhGctGKDzNrBy?=
 =?us-ascii?Q?xdkbSVXiVljMJywjOh3bZZtE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0be2bd3-134e-4ddc-b97a-08d96af3c9b3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 13:49:14.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr1TC2gSlGp0Aule13ftrLZ3dbwGwopB2EotJDquoSghUIpt7s3D54F8MrKinywb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/29 =E4=B8=8B=E5=8D=889:42, Eryu Guan wrote:
> On Thu, Aug 26, 2021 at 01:34:32PM +0800, Qu Wenruo wrote:
>> Btrfs has the ability to inline small file extents into its metadata,
>> and such inlined extents can be further compressed if needed.
>>
>> The new test case is for a regression caused by commit f2165627319f
>> ("btrfs: compression: don't try to compress if we don't have enough
>> pages").
>>
>> That commit prevents btrfs from creating compressed inline extents, even
>> "-o compress,max_inline=3D2048" is specified, only uncompressed inline
>> extents can be created.
>>
>> The test case will make sure that the content of the small file is
>> consistent between cycle mount, then use "btrfs inspect dump-tree" to
>> verify the created extent is both inlined and compressed.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Is there a proposed fix available that could be referenced in the commit
> log?

The upstream commit is 4e9655763b82 ("Revert "btrfs: compression: don't=20
try to compress if we don't have enough pages""), which is merged after=20
I submitted the patch.

>=20
>> ---
>> Changelog:
>> v2:
>> - Also output the sha256sum to make sure the content is consistent
>> ---
>>   tests/btrfs/246     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/246.out |  5 +++++
>>   2 files changed, 58 insertions(+)
>>   create mode 100755 tests/btrfs/246
>>   create mode 100644 tests/btrfs/246.out
>>
>> diff --git a/tests/btrfs/246 b/tests/btrfs/246
>> new file mode 100755
>> index 00000000..e0d8016f
>> --- /dev/null
>> +++ b/tests/btrfs/246
>> @@ -0,0 +1,53 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 246
>> +#
>> +# Make sure btrfs can create compressed inline extents
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +# For __populate_find_inode()
>> +. ./common/populate
>=20
> This function starts with double underscore, I take it as a 'private'
> function in common/populate. But all it does is returning the inode
> number of the given file, I think we could just open-code it in this
> test as
>=20
> ino=3D$(stat -c %i $SCRATCH_MNT/foobar)
>=20
> Otherwise test looks fine to me.

Mind me to send an update to include the fix in commit message and use=20
the local ino helper?

Thanks,
Qu
>=20
> Thanks,
> Eryu
>=20
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_scratch_mkfs > /dev/null
>> +_scratch_mount -o compress,max_inline=3D2048
>> +
>> +# This should create compressed inline extent
>> +$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
>> +ino=3D$(__populate_find_inode $SCRATCH_MNT/foobar)
>> +echo "sha256sum before mount cycle"
>> +sha256sum $SCRATCH_MNT/foobar | _filter_scratch
>> +_scratch_cycle_mount
>> +echo "sha256sum after mount cycle"
>> +sha256sum $SCRATCH_MNT/foobar | _filter_scratch
>> +_scratch_unmount
>> +
>> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
>> +	grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
>> +echo "dump tree result for ino $ino:" >> $seqres.full
>> +cat $tmp.dump-tree >> $seqres.full
>> +
>> +grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found"
>> +grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent fo=
und"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
>> new file mode 100644
>> index 00000000..3908cc50
>> --- /dev/null
>> +++ b/tests/btrfs/246.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 246
>> +sha256sum before mount cycle
>> +0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRAT=
CH_MNT/foobar
>> +sha256sum after mount cycle
>> +0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRAT=
CH_MNT/foobar
>> --=20
>> 2.31.1
>=20

