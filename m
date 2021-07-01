Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3D3B9896
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhGAWdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 18:33:22 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:48053 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhGAWdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 18:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625178649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWzxR1GzjU6S5tCT4FVRXYnJ0rFuVqgHcZ5IzkDmn5o=;
        b=A/U6VAlkBTui3SZt8hRJzbrAacCe45fBrqesepv99+7D2JbL2AzX0AuT5om+r58o4AWMkY
        o54nkXIviRshTywXbhl5AWtom4lLh74r0GyAW8zAGD4Awj5ElFqDK46Ov5LcvwMf6GLUs1
        c0CqXTx+tMw/CFLACRFjzqBfZ5BoHiM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-mD833GW-NmW5PWD-WeTlUg-1; Fri, 02 Jul 2021 00:30:48 +0200
X-MC-Unique: mD833GW-NmW5PWD-WeTlUg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJTkv+zBuEpGz0yywiPjGzyJLgE4mX6fCXIXx+INufPrik0dJMZrE7r1SvI2E6EEQxwg24c+bfIoddMKObfI6EXxglVEijt60tdpB4AYpApvNdscGl2IQ7Dj1xUiGUb81uI9LBSwVpK98sMYzzJwawO9I/s/wXFhMG0OA6aLvSrsqg1cf2ebSzwYsJp35PUF90/DFx4KTKu8aVbbCPJ5dx1K1vuGqOgQEcq94KpnWJPImoFg9osdvT2gwq1aZlI+OAzKyKkQpPMKoeTOHH2EciX0MZcdBEH4hkfkBdmlsspKEvmxOwjNh5iCeGhhLx9iNmpR0E10TosRRvO/h1LAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdnGd6/JSNAtxCeDBiSWdD/3bMK4xKuxSuqxs0LEDYI=;
 b=btZaH87VAqdQQ/2Ea3LuIbTxzapyr38C+sSpwlAx6RQxR6o4o5dKKVZ82gdrzQ+tVQUj03MCoNp/NUAZwryEnqkjZ35P5HltTsOH/2h8ziHdRADg/fFBsm9aw1hb/1acF6BwgKZ8+G0SldyS/Y2yQGHMy8O6PDjs68Ff5GPyVUM5awXSfAJCcFwzXdadk+aF2g4E/NyV2lRmEi52RZl7kIwP3LT5VUVAvGKpYkGt89dSA0UvtjB6aDcSBTOJNp6j+3EoyXXW71Vqef0WpY3TljscizEiTtG6MbiXI8QaD8MZMsXfisIKeSDMNX9pe0HnhgqgFYlUXrU5Bmysh1kbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 22:30:48 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 22:30:47 +0000
Subject: Re: [PATCH] btrfs-progs: mkfs: follow sectorsize for mixed mode
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210517095516.129287-1-wqu@suse.com>
 <20210701194129.GC2610@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <958e28b6-17cf-cdf2-dbbc-0fc341a3b656@suse.com>
Date:   Fri, 2 Jul 2021 06:30:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701194129.GC2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:404:42::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 22:30:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c1cb039-b5ad-4388-85fb-08d93cdfdfb3
X-MS-TrafficTypeDiagnostic: AS8PR04MB7671:
X-Microsoft-Antispam-PRVS: <AS8PR04MB767181EE10E4150CF32A5CB6D6009@AS8PR04MB7671.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ce2pU/Cyko2Z0Q81vYdW5xkA47nPIiakIV/+/K1bY1sXV19jvk2HBpUkdUvmvqHHhnhu8bvHdTu7CcGqXNMq/2zvLRoeBTKcppL0wddcXV1rOzqkyU0YAyC5bI9yr1+CvHd8nPGxJWYugsQYTsLUYVNsTJKibToBsA9MIA3ho8xrqflj9NR7Ze7vfs+f5l57mdEKaPrnIpvuO0wY86FctJIV1WAirQllc6yRhnl6owg7P5i4pjZ3LuU3/fT9H/IldqHa7g+e2AcdGflAaYtPERfJJrjZb/UXS3hwBQwGeuo9vuC+lfzve1pf3Y0RAyRNrRCyiTp+s5nCZx8DYMiNM+cNGcwllDENUkcN8ghJ1Hp1aDeIi1nQCQuSVyt3hfTjqtzFmJ7jg47SqYtyQWBpBQ48L2ztDMBWDoQttbRTB85bzb6JzMl2VeW5zijNDSOgXukq52ETCuCbo+P0Xid0DNnNSqeqwCJ4Z9l0dlVpsDBDuRuGWteKXAkgL5WwzBAf5oTS8CCEQSztZ97h36IhbiN6sjLV4Drhe4kZsUmL87BR79xV8LNHsbNoLLIAb4ytMhfNztSR7j4DkHm0Wcps3wjQibC9rIvNiZnDuAO1SIqt6HJ4AxTweqQ7jzMOYZRWmDNfd68iKSbcO0iLiY2SquqatI7qCEpoNqDMzsDEhUZsj/60QyrGJbxw5tTe+Z/PiGwoX+ql7FQ1jqqoBNaPZe4emkEEdmWOw0k2ef49iLtb/k1X+BrUR539lsespQyyH1+h3+++1aKsnIbWgasujCKD94zDTm5KwAahactJvrpiWFEuGxkTAkbOTMVyHFMyILHHe0faiMuTkLkPjVEnkV/EW7sY/fchk0hxaX8ul7hrG3x5KpmOJqYdvUEF6S3UjOoZ3oRlPWuOc9WxcPPmQll9j3qFubhF1A777LZkVto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(8676002)(16526019)(316002)(26005)(186003)(8936002)(6666004)(66476007)(55236004)(2906002)(38100700002)(16576012)(66946007)(66556008)(6706004)(86362001)(956004)(83380400001)(966005)(478600001)(31686004)(6486002)(2616005)(5660300002)(31696002)(21314003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61eqGVo/aVzXT/vbUZVH2nbWLWkgxv8ASMuN7o+LWzyVCzGzKGPh4b7KxO1t?=
 =?us-ascii?Q?o3k9Wm3UyB8uM2phb3gzlhV8KK4WiuyVmqQRzawG9vtifSjpswZe1ykfb4LB?=
 =?us-ascii?Q?csPARuP7GOINVNvUV6vw/RkQWDtKPyDxztThiv+Sb+Hy4IyrVBcbWXSnRvMA?=
 =?us-ascii?Q?GPeifAsYPWOOs3A3willps78UjZzRXYiOQ2S4vdOnutwoPNA/eoA/zE1JOy6?=
 =?us-ascii?Q?27rYzD0wQfUIotdPjmDA39usFiHoujPaIQ/gKumArWGNDf/FKQHnj0ozOEa/?=
 =?us-ascii?Q?beUCBOGhaqXMEcpoPu2JeLn77e/ZrJgBw/0Z07a2MDUqZxobjlEj3Tqj7fpp?=
 =?us-ascii?Q?PyzSlnb0bqX72bMicAJG/p58Q0+3HyxzNEgLeDbKV5DPeqfzSd7vGJF/gl9G?=
 =?us-ascii?Q?Ktx8kSTt6Ok7m7ees1GOcjbWUVOEuzzo/ZXfsDnWhHEfXY6r/6vTgM8Usazj?=
 =?us-ascii?Q?S+V7BBMgyYgM/AFGqPmsGO1PldvPkk7dFqQVVaOOpBUPbjIYjJk2X17Js2pF?=
 =?us-ascii?Q?bwlcvJ+jhwH/tD7v3wFh1k6RtLOIJtgA8MLwjn3RCJ9f5eO3Wf4QDgD9Ok2Z?=
 =?us-ascii?Q?eea1vD1D2Lpk499o2MImds4UrJZLsfetBzHcV06APPk5m1ggPMlsDJdTJDNn?=
 =?us-ascii?Q?EvPqpG1AiyGxfq9bD7SvLzp0c9l8dENn9EeYuLE57oN+5IGG3LYCAj+JX5NZ?=
 =?us-ascii?Q?azg6l/44ne1GqiDjq93aUgDHFLnTwEIkMYiTa+yEEKkj7iXc27V+qfN3iNM6?=
 =?us-ascii?Q?5qeka+TXboyUtLND3+rhwf+fruJ6CtxUI/SRGbU6xfnerJrldtt7GaHMl+jo?=
 =?us-ascii?Q?q+j6dvt/fHajlyZCdQ8yg94I1JE488pqm1cWPIGGv5GDXllj5KFdNM2Y7Txj?=
 =?us-ascii?Q?WHjeKaTp7JR9QuJ1Qk0uk/mrWd9AwspZeEzftu/S1K0VNH7bnL4NS81QjqPk?=
 =?us-ascii?Q?3Mxutue9xLfixun/VFMwkD0zhYPxDOYOQakMBZoMokew/Uz9G5FplCUdIB68?=
 =?us-ascii?Q?fmTC00N0ZE2+/eqa9v6j01HqtnsLe5HYJOK8SgLPxAW+MB82HJ0PVwuTdM2Q?=
 =?us-ascii?Q?s44ykx/C+69LhCeFL5MbdJ5wGa7hIeCdd6DoYh7dYDgvg+BG/HT8aQML3Ztn?=
 =?us-ascii?Q?8VH7TldQgTtkYV8oArRMF8ZSD2bKPWjXH0rRU9OE7ryZflrk6YV4mxAuBsZa?=
 =?us-ascii?Q?P4XynCV9XhQ6zUgNYEkVkkcIFnFR/yoBUDTz+dRLsxPsRLkPGKZjhiHCvgos?=
 =?us-ascii?Q?p0Y3zgaCiuN4E94Vn8ZI0Cxywk0yIn0H65Z29QJpgF/IiyE3lxUkX6imKqR3?=
 =?us-ascii?Q?qYhZ+krHFqaSds5/9OPfo59b?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1cb039-b5ad-4388-85fb-08d93cdfdfb3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 22:30:47.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpWO/4nqQBcVf1MOGyF1Ilx0bpmxa40gKFfuKaFkK2If2+WDf0srKabqQ+K5TMTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/2 =E4=B8=8A=E5=8D=883:41, David Sterba wrote:
> On Mon, May 17, 2021 at 05:55:16PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When running fstests with 4K sectorsize and 64K page size (aka subpage
>> support), the following tests failed:
>>
>>    $ sudo ./check generic/416 generic/619
>>    FSTYP         -- btrfs
>>    PLATFORM      -- Linux/aarch64 rockpi4 5.12.0-rc8-custom+ #9 SMP Tue =
Apr 27 12:49:52 CST 2021
>>    MKFS_OPTIONS  -- -s 4k /dev/mapper/arm_nvme-scratch1
>>    MOUNT_OPTIONS -- /dev/mapper/arm_nvme-scratch1 /mnt/scratch
>>
>>    generic/416     [failed, exit status 1]- output mismatch (see ~/xfste=
sts-dev/results//generic/416.out.bad)
>>       QA output created by 416
>>      -wrote 16777216/16777216 bytes at offset 0
>>      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on =
/dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other=
 error.
>>      +mount failed
>>      +(see ~/xfstests-dev/results//generic/416.full for details)
>>      ...
>>      (Run 'diff -u ~/xfstests-dev/tests/generic/416.out ~/xfstests-dev/r=
esults//generic/416.out.bad'  to see the entire diff)
>>    generic/619     [failed, exit status 1]- output mismatch (see ~/xfste=
sts-dev/results//generic/619.out.bad)
>>       QA output created by 619
>>      -Silence is golden
>>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on =
/dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other=
 error.
>>      +mount failed
>>      +(see ~/xfstests-dev/results//generic/619.full for details)
>>      ...
>>      (Run 'diff -u ~/xfstests-dev/tests/generic/619.out ~/xfstests-dev/r=
esults//generic/619.out.bad'  to see the entire diff)
>>    Ran: generic/416 generic/619
>>    Failures: generic/416 generic/619
>>    Failed 2 of 2 tests
>>
>> [CAUSE]
>> Those two tests call _scratch_mkfs_sized to create a small fs, all of th=
em
>> are smaller than the 256M.
>>
>> Since the fs is small, fstests choose to pass -M to make a mixed btrfs.
>> (Let's just ignore whether we should pass -M here).
>=20
> I think this is actually the problem, this should be fixed in fstests.

Yeah, but this still expose a problem.

When -s is specified, why nodesize is not chosen automatically when -M=20
is also specified.

For current -s 4k specification, nodesize is chosen automatically by the=20
16K default value, not the PAGE_SIZE anymore.

But with -s 4K and -M together, we go 64K as default nodesize which is=20
totally wrong.
>=20
>>
>> Then on 64K page size system, "mkfs.btrfs -s 4K -M -b 128M $dev" will fa=
il
>=20
> When --mixed is used, use both --sectorsize and --nodesize.

Nope, on 4K systems, when -s 4k and -M is specififed, nodesize is=20
automatically chosen as 4K.

No need to specify the nodesize.

In fact, when possible the nodesize should be automatically chosen.

Thus this is the problem I am going to solve.
The fstest failure is just an easy way to expose the bug.

Thanks,
Qu

>=20
>> with the following error message:
>>
>>    btrfs-progs v5.11
>>    See http://btrfs.wiki.kernel.org for more information.
>>
>>    ERROR: illegal nodesize 65536 (not equal to 4096 for mixed block grou=
p)
>>
>> This is caused by the nodesize selection, which always try to choose the
>> larger value between pagesize and sectorsize.
>>
>> This hardcoded PAGESIZE usage in mkfs.btrfs makes us to choose 64K
>> nodesize even we specified to use 4K sectorsize.
>>
>> [FIX]
>> Just use sectorsize as nodesize when -M is specified.
>>
>> With this fix, above two tests now pass for btrfs subpage case.
>=20
> This is changing the mkfs behaviour for everybody just to fix a fstests
> test case. I disagree to do that. Fstests get weekly releases so if the
> test is failing now, it won't next week once a patch is applied.
>=20

