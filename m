Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E5403185
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 01:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhIGX3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 19:29:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:43941 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhIGX3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 19:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631057321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yazTwV00M/ij8v3yAuBARi0jKRY66WZtSGjmOugK3co=;
        b=BAtMNm+I5BhRuCzIyH+r+ZVBzViSRG7O0IENXiMPvYunQTPryE/n3R8LmYSZv0Ii5o++oo
        lwFcFTjphDbdodJFfvB7627XCEJAnSlGf+ppRQm278hzT7bzNG8IwGJXutzaNzCoVfTYXd
        q2+TV7VFoM0fXU/yz1HduUvtaE4YxK0=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2058.outbound.protection.outlook.com [104.47.6.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-vomn0eL9Ppecdx82qhNknw-2; Wed, 08 Sep 2021 01:28:40 +0200
X-MC-Unique: vomn0eL9Ppecdx82qhNknw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDIKMWqkAa8bIFs7RXrRk9nosDAt3ahBTCWDTU98nDqWJxr8hEyNhZDu7fTbP7V//UAT6/1t9IMWr006jgeCsMkhRAAww9xRLgAA4O/QMX/V7kLNOEB834C2t3uvmxhqXoJdSM4wqzqpS2q1DEBVPGwMclNYx5NOFklm9XS35LkiwCV4HOInILe3nDRiwmKU3EqZ7rpa3K/s90y+ccgdzxT6T/bq0ejIzphw/7S/EYkc0fFQxNw/pQCINgPsjEkIAdQ6JTj48Oj+C/iZjDw72Yc3mglfQ/bTKGNzLYVdXPHSFMwxPEnwRl3NLub6dg5DwnHAkVaskV9cUZsoPSgIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Pg8iA+1TH6mpdeho7jcjIqKe7fRsaXfujsPBcpBDOYM=;
 b=oenrzMzCYkf5jpO9k+0KKGH+SlS/9XVDZkSrSPmRRS7ieY2ZapsiFjJ+jo7BCTwRolVq1GXSjm3BcRduUw3FCBr7O/eclJvBhCe/B7ftMuL/9zJLd3BPTMKFDtZx85rA0jHcMq3hc9Wnu2PALpxPbf74K8t4ttpdHfZBoJmRdc/3G2UBYGtvHIwg1hrqZhgEPvw7ghzHipZU3xNvtpXDH7KmYnwiGODltT9qfGcSRSkW697Kze7gzrNk9RclNdC5vKuJO8d9dRJSEn5fMMNLV4+bqNup6NgeHxOipKKQW8wnbestQrKEK47Ye3aFyZKf/R5j+wY7fnQFUzP8wUBVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 23:28:38 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 23:28:38 +0000
Subject: Re: Next steps in recovery?
To:     Robert Wyrick <rob@wyrick.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
 <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
 <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
 <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
 <7f8fde51-f920-06be-fdad-0cf59816adca@gmx.com>
 <CAA_aC98-x6vKp53gbtw+Ds5gF+LH6yYn2vqK0TPLE4GduHjsEA@mail.gmail.com>
 <dbf70317-43af-4c70-b5d8-22a993228065@oracle.com>
 <CAA_aC9-2ZA2+MOYbzMK+Sm_iwyPGCoaZYotJ0gShJURFv0-Xog@mail.gmail.com>
 <362347bd-dca2-6074-c2c1-e453edd2a455@gmx.com>
 <CAA_aC98_gr2Gt+1YO=meG7b5mEofVLok88Hgf4605CN1zYp+ow@mail.gmail.com>
 <CAA_aC9_oZiJkxpXcDGRQK=TtXgE4tNBGHxgZWtY8LZB3qfLw7Q@mail.gmail.com>
 <CAA_aC9_EnoeDpVQgzChKBLi1D=asG+KLvrWAz8r4KGe-1BAHTQ@mail.gmail.com>
 <ce27caed-c6fb-3674-39be-3fe39157554f@gmx.com>
 <CAA_aC9-0hzYAyb_5t6akSFme-OKGjPQTPSRToRHu5OBJpS9YzA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <4ed39f51-cfa7-7b8b-47f0-81050a65f597@suse.com>
Date:   Wed, 8 Sep 2021 07:28:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAA_aC9-0hzYAyb_5t6akSFme-OKGjPQTPSRToRHu5OBJpS9YzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 23:28:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c5116c-63c2-4ab1-2ced-08d972573826
X-MS-TrafficTypeDiagnostic: AM7PR04MB6773:
X-Microsoft-Antispam-PRVS: <AM7PR04MB67736E8F0EFA8236D25D96B3D6D39@AM7PR04MB6773.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EA9EvK5XxOl7CUK09St4d5xwWyV0wnJgtTyZf3QUOoyluSQaYN2RT3BrTbKxo8bH/GpxeaoeaR9wLdi9sJYiEq+9k2PF9vMW48v+J+9ZKiHbt3lIHNrsqw8tYBB99SK4rP0VXyshXOHJkHmKVHnHmikv+0SAPZGVAft5jILmQw32AOCvywU1O0j0YL0kgvddplDUjkCveOWdcp15lda26Af9DX+FwIy0kcgf97BR+TuwTBARE3ULpIAJ8xROfrwhZVnh2wQ4YkDT95F+RlvtvECvwrT3BVZHSi3RchghKKGr86iJn3GKfL4PD0mHhnwLT0hbcFz9x9HVCpiutn0L/uY/YgmFTZG1pAlw6MnmDhnckbJwhxWerMMhwVMw/6jeHEcsMn477XMR5V8tRQd5BNE7xznCtjvgEcRgdQMsBTFknvwdtw3yFwOkEMOPbpmOFXJdmDaHpX/lHEXXu0XOBsw+3QJODWJG1qTfP9KyM8dtLd+JKT5rc5DKRsj0aMbr4vOtvBluunPncFdwdppQ/gMYjUO7HC6+Bd02eyAmZZ6MrvgmP3Ex7BV9fzfIE728dsfJJ/d2A7auVFHEBwrJ11gLIy+KWyDfKV/CHaWCsA5r4y483gh5Sx+KftRKt5KDT9muL2Y/PRcS36aSXCPgQeoI3TeSOF8Hm67DNlJOfKFqO2aEK8aFqtHuMhLyxjrXeNVxRNlUoFro3TKALRgZ6wBFGvHKKK35QdbjG9MIV/DeyB0aFMBszlzBiQaBHAx/mVFtXCHA1nETpgivT7g9Pjl1RYefJGJOxJjPOgAlxkIciuh/TMxI2L7z7bDlkjgmX2DHM7TjkK2/6JkoY1ALZSh9NDaHVzXPyUErqlNDxxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(38100700002)(83380400001)(86362001)(31696002)(8676002)(53546011)(4326008)(186003)(6706004)(6666004)(26005)(30864003)(66556008)(6486002)(8936002)(54906003)(66946007)(66476007)(3480700007)(31686004)(316002)(478600001)(16576012)(2906002)(36756003)(5660300002)(2616005)(956004)(966005)(110136005)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZwZ9bfvpqk2DmRN0mPP0n9ObSwBPF5PgyE4pr3v/Jm8Qehy7bY5mZmPcu5R?=
 =?us-ascii?Q?KJvDSGv9zulN1HvK/fwdC58H99ju1DChGhjuBwHXrihwOP2tUvzv4aBGYa1f?=
 =?us-ascii?Q?ZjYfbSogBMCu9H2dO3Fi4wZhANF/Tn/J7OkTICuiXirGeJEpe/4dbe9tIsSA?=
 =?us-ascii?Q?Lj8I7gfmkUeeF15YUvINFsJqpvdD29ZRzED2/W4Cyrg0aAXbzUH8uUZAyRi2?=
 =?us-ascii?Q?mkCbGNBo/mHAMFLVdjLWd4OAaUVhhG4L02+d+x9jTaiWC0g63bBY9TC0cSZS?=
 =?us-ascii?Q?JJ0w7fmMKQIhS0tNjSb/MW3c2pIX+tudGT+0eY/gfJKw/bQRadUZ4WCJ3bbw?=
 =?us-ascii?Q?+mRMQyxpF/IOJB/lAa3mCc15r0s2zSjL9qaZrmvm3iCEQKatc+46hSxVlI6T?=
 =?us-ascii?Q?LYOrXyLcPnt/cb3f8DkUPo05IpBJLFTIEaSma7dayg6M/Jjty6ktbSuuACNB?=
 =?us-ascii?Q?pe+GN0IeKpJp/nfaBBH8eu5YJq/whyuWjHSoCUcVK2LNvLYddRJ6X4R6AMm3?=
 =?us-ascii?Q?+eKo2rEpp+hxbDVT+vRJCb/PdGntYHkvZsNr2mKbUgRdcZKzKHWNPbfnlylI?=
 =?us-ascii?Q?MnuZoGWkL9qLEJ5rYTXqIfTb6a7YtGwhco28ftlIhvEwyzXCZeEHNuDEOhPP?=
 =?us-ascii?Q?j2VbPzQmjXhjumqd29r28y9dX0xCjl0tMZybzUro0DI1usk3HtR94771Ut5F?=
 =?us-ascii?Q?uLQiq7kE4DKD4ebfTb+YHk86PoJU9hJaoA9kF2Z49+PJk6+JY1EzNTMLb20E?=
 =?us-ascii?Q?jwV7ISzy1k8aiVgdfVIDw4+nWMF1dgHQdijpKyv1S5oZl8os5g5M3371gPAq?=
 =?us-ascii?Q?i3SYeuL0bcZQz2wxMgAPWTCq7sE/X9ER4yqIcYkzH9yYK9mL1j5aKxwNCt2T?=
 =?us-ascii?Q?N4fO0D8DmA8hheWe325behx/niNs5imCcxpWhJ9XSW1ybv1EYQd0bEVd0DxU?=
 =?us-ascii?Q?n1pmmViNwEEhCSC2iX70gqObGy2lHlJGZyCKzy0A9ExGfIRC2dSns4ZBvHCK?=
 =?us-ascii?Q?121Ha4WD1FHaEmkQ32VZALRc5VrTXqA980wLWstciLbD30ZZJSg5rkOiqIrI?=
 =?us-ascii?Q?V9vSEY0qS1NdK8vg01bI+rK8pQoUz8tTzHN8lHBITzGp/azjEZBbysSVmeNy?=
 =?us-ascii?Q?Jq4lj9VQp4RFmgj2K1+1nHZRPfMlG6YRv+wDHteUXefkie6otcaA9U3CpvZg?=
 =?us-ascii?Q?Qh+8eopvqzW3oimMwqE6UEYuj4rRsiGia9t4TvtQyIa6ZAu1RMV9A7VfcuEo?=
 =?us-ascii?Q?NujAfucfGu/IBQnO2S+Day2ZkxPSV572Ig5l4UiYySOhsMZXw2+uw0b1OdgA?=
 =?us-ascii?Q?ea+EmE7gbv+TKojOmZUcJ9SB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c5116c-63c2-4ab1-2ced-08d972573826
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 23:28:38.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwBcYatQ23vpF4mOrdwyDFJ7hxxoTalj8MGEFlOVGewwBaXB3OesGijfaO/F1B8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/8 =E4=B8=8A=E5=8D=887:20, Robert Wyrick wrote:
> Anything specific to address the dmesg error?

The dmesg seems to be caused by the corrupted free space cache.

Thus as long as it doesn't cause long last problems (aka, committing bad=20
data to disk), after clearing v1 space cache, it should be safe.

But to be extra safe, you'd better run btrfs check again after v1 space=20
cache clearing to be sure.

Thanks,
Qu
>=20
> On Tue, Sep 7, 2021 at 5:17 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/9/8 =E4=B8=8A=E5=8D=884:47, Robert Wyrick wrote:
>>> Re-running check now shows:
>>>
>>> [1/7] checking root items                      (0:00:55 elapsed,
>>> 2649102 items checked)
>>> [2/7] checking extents                         (0:02:13 elapsed,
>>> 1116141 items checked)
>>> there is no free space entry for 18365358505984-18365358522368d, 130
>>> items checked)
>>> there is no free space entry for 18365358505984-18366416814080
>>> cache appears valid but isn't 18365343072256
>>> there is no free space entry for 19764429062144-19764429078528d, 348
>>> items checked)
>>> there is no free space entry for 19764429062144-19765502410752
>>> cache appears valid but isn't 19764428668928
>>> wanted bytes 49152, found 16384 for off 254016221675521 elapsed, 1534
>>> items checked)
>>> wanted bytes 1058373632, found 16384 for off 25401622167552
>>> cache appears valid but isn't 25401606799360
>>> there is no free space entry for 28659399229440-28659399245824d, 2636
>>> items checked)
>>> there is no free space entry for 28659399229440-28660413235200
>>> cache appears valid but isn't 28659339493376
>>> wanted offset 29154336178176, found 2915433616179200:33 elapsed, 2792
>>> items checked)
>>> wanted offset 29154336178176, found 29154336161792
>>> cache appears valid but isn't 29154334474240
>>> there is no free space entry for 30899331825664-30899331842048d, 3585
>>> items checked)
>>> there is no free space entry for 30899331825664-30900272234496
>>> cache appears valid but isn't 30899198492672
>>> there is no free space entry for 32134011568128-32134011584512d, 4474
>>> items checked)
>>> there is no free space entry for 32134011568128-32135075332096
>>> cache appears valid but isn't 32134001590272
>>> wanted offset 33148689629184, found 3314868961280000:59 elapsed, 4963
>>> items checked)
>>> wanted offset 33148689629184, found 33148689612800
>>> cache appears valid but isn't 33148687613952
>>> there is no free space entry for 34611225755648-34611225772032d, 6036
>>> items checked)
>>> there is no free space entry for 34611225755648-34612197720064
>>> cache appears valid but isn't 34611123978240
>>> there is no free space entry for 37374972723200-37374972739584d, 8051
>>> items checked)
>>> there is no free space entry for 37374972723200-37376042729472
>>> cache appears valid but isn't 37374968987648
>>> there is no free space entry for 37484494651392-37484494667776d, 8172
>>> items checked)
>>> there is no free space entry for 37484494651392-37485564395520
>>> cache appears valid but isn't 37484490653696
>>> wanted bytes 49152, found 32768 for off 377572293017606 elapsed, 8381
>>> items checked)
>>> wanted bytes 1065517056, found 32768 for off 37757229301760
>>> cache appears valid but isn't 37757221076992
>>> there is no free space entry for 38414356250624-38414356267008d, 9004
>>> items checked)
>>> there is no free space entry for 38414356250624-38415424815104
>>> cache appears valid but isn't 38414351073280
>>> there is no free space entry for 41509957402624-41509957419008d, 11792
>>> items checked)
>>> there is no free space entry for 41509957402624-41511022493696
>>> cache appears valid but isn't 41509948751872
>>> there is no free space entry for 42293815459840-42293815492608d, 12469
>>> items checked)
>>> there is no free space entry for 42293815459840-42294887579648
>>> cache appears valid but isn't 42293813837824
>>
>> All free space cache related problems.
>>
>> You can just clear all v1 cache:
>>
>> $ btrfs check --clear-space-cache v1 <dev>
>>
>> Then it's also a good time to migrate to v2 cache, which is safer and
>> faster.
>>
>> # mount <dev> -o space_cache=3Dv2 <mnt>
>>
>> Thanks,
>> Qu
>>> [3/7] checking free space cache                (0:04:18 elapsed, 14910
>>> items checked)
>>> [4/7] checking fs roots                        (0:00:26 elapsed,
>>> 108894 items checked)
>>> [5/7] checking csums (without verifying data)  (0:00:03 elapsed,
>>> 12350321 items checked)
>>> [6/7] checking root refs                       (0:00:00 elapsed, 4
>>> items checked)
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 15729059287040 bytes used, error(s) found
>>> total csum bytes: 15313288548
>>> total tree bytes: 18286706688
>>> total fs tree bytes: 1791819776
>>> total extent tree bytes: 229097472
>>> btree space waste bytes: 1018811836
>>> file data blocks allocated: 51587230765056
>>>    referenced 15627926974464
>>>
>>> On Tue, Sep 7, 2021 at 11:17 AM Robert Wyrick <rob@wyrick.org> wrote:
>>>>
>>>> Looks like I spoke too soon.
>>>>
>>>> I can now mount the FS readonly.
>>>>
>>>> I see this error in dmesg:
>>>> [58995.896369] CPU: 10 PID: 83845 Comm: btrfs-transacti Tainted: P
>>>>         OE     5.11.0-27-generic #29~20.04.1-Ubuntu
>>>> [58995.896373] Hardware name: System manufacturer System Product
>>>> Name/PRIME X370-PRO, BIOS 0515 03/30/2017
>>>> [58995.896376] RIP: 0010:btrfs_run_delayed_refs+0x1af/0x200 [btrfs]
>>>> [58995.896422] Code: 8b 55 50 f0 48 0f ba aa 48 0a 00 00 03 72 20 83
>>>> f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 50 7e 77 c0 89 45 d0 e8 96
>>>> d4 4d d3 <0f> 0b 8b 45 d0 89 c1 ba 4c 08 00 00 4c 89 ef 89 45 d0 48 c7
>>>> c6 c0
>>>> [58995.896425] RSP: 0018:ffffb89a4a0dfdf8 EFLAGS: 00010282
>>>> [58995.896428] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 000000=
0000000027
>>>> [58995.896430] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff96=
0fdf098ac8
>>>> [58995.896432] RBP: ffffb89a4a0dfe40 R08: ffff960fdf098ac0 R09: ffffb8=
9a4a0dfbb8
>>>> [58995.896434] R10: 0000000000000001 R11: 0000000000000001 R12: ffff96=
036a7d5378
>>>> [58995.896435] R13: ffff960115028888 R14: ffff96036a7d5200 R15: 000000=
0000000000
>>>> [58995.896437] FS:  0000000000000000(0000) GS:ffff960fdf080000(0000)
>>>> knlGS:0000000000000000
>>>> [58995.896439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [58995.896441] CR2: 00005616936891e8 CR3: 000000010fe46000 CR4: 000000=
00003506e0
>>>> [58995.896444] Call Trace:
>>>> [58995.896450]  btrfs_commit_transaction+0x2c3/0xa80 [btrfs]
>>>> [58995.896500]  ? start_transaction+0xd5/0x590 [btrfs]
>>>> [58995.896549]  transaction_kthread+0x138/0x1b0 [btrfs]
>>>> [58995.896596]  kthread+0x114/0x150
>>>> [58995.896604]  ? btrfs_cleanup_transaction+0x570/0x570 [btrfs]
>>>> [58995.896649]  ? kthread_park+0x90/0x90
>>>> [58995.896653]  ret_from_fork+0x22/0x30
>>>> [58995.896661] ---[ end trace c8ba04bdf2113cae ]---
>>>> [58995.896664] BTRFS: error (device sdf) in
>>>> btrfs_run_delayed_refs:2124: errno=3D-17 Object already exists
>>>> [58995.896669] BTRFS info (device sdf): forced readonly
>>>> [58995.896672] BTRFS warning (device sdf): Skipping commit of aborted
>>>> transaction.
>>>> [58995.896674] BTRFS: error (device sdf) in cleanup_transaction:1939:
>>>> errno=3D-17 Object already exists
>>>>
>>>> Read-only is better than nothing, but what would be my next steps?
>>>>
>>>> On Tue, Sep 7, 2021 at 11:02 AM Robert Wyrick <rob@wyrick.org> wrote:
>>>>>
>>>>> Ran a repair:
>>>>>
>>>>> $ sudo ./btrfs check --repair -p /dev/sda  # I did NOT make install,
>>>>> just ran from the compiled directory
>>>>> enabling repair mode
>>>>> WARNING:
>>>>>
>>>>> Do not use --repair unless you are advised to do so by a developer
>>>>> or an experienced user, and then only after having accepted that no
>>>>> fsck can successfully repair all types of filesystem corruption. Eg.
>>>>> some software or hardware bugs can fatally damage a volume.
>>>>> The operation will start in 10 seconds.
>>>>> Use Ctrl-C to stop it.
>>>>> 10 9 8 7 6 5 4 3 2 1
>>>>> Starting repair.
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/sda
>>>>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
>>>>> [1/7] checking root items                      (0:00:59 elapsed,
>>>>> 2649102 items checked)
>>>>> Fixed 0 roots.
>>>>> Reset extent item (38179182174208) generation to 4057084elapsed,
>>>>> 1116143 items checked)
>>>>> No device size related problem found           (0:02:22 elapsed,
>>>>> 1116143 items checked)
>>>>> [2/7] checking extents                         (0:02:23 elapsed,
>>>>> 1116143 items checked)
>>>>> cache and super generation don't match, space cache will be invalidat=
ed
>>>>> [3/7] checking free space cache                (0:00:00 elapsed)
>>>>> Deleting bad dir index [8348950,96,3] root 259 (0:00:25 elapsed,
>>>>> 106695 items checked)
>>>>> repairing missing dir index item for inode 834922400:26 elapsed,
>>>>> 108893 items checked)
>>>>> [4/7] checking fs roots                        (0:01:04 elapsed,
>>>>> 217787 items checked)
>>>>> [5/7] checking csums (without verifying data)  (0:00:04 elapsed,
>>>>> 12350321 items checked)
>>>>> [6/7] checking root refs                       (0:00:00 elapsed, 4
>>>>> items checked)
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 15729059057664 bytes used, no error found
>>>>> total csum bytes: 15313288548
>>>>> total tree bytes: 18286739456
>>>>> total fs tree bytes: 1791819776
>>>>> total extent tree bytes: 229130240
>>>>> btree space waste bytes: 1018844959
>>>>> file data blocks allocated: 51587230502912
>>>>>    referenced 15627926712320
>>>>>
>>>>> I can now mount the filesystem successfully!  Thank you for your help=
.
>>>>>
>>>>> I do have some additional questions if you don't mind...
>>>>> I am already using RAID 1 to handle single disk outages.  I assume
>>>>> things could have gone much worse and I could have lost the whole
>>>>> filesystem.  Aside from backups (I know, I know), is there anything
>>>>> else I can do to prevent such issues or make them easier to recover
>>>>> from?  Could this problem have been avoided/detected earlier?  This
>>>>> wasn't a disk failure and according to memtest86+, it wasn't due to
>>>>> bad memory either....  I don't run scrubs very often.  Should I?  I
>>>>> guess the more general question is:  What are the best practices for
>>>>> maintaining a healthy btrfs file system?
>>>>>
>>>>> Thanks again!
>>>>>
>>>>> On Mon, Sep 6, 2021 at 10:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2021/9/7 =E4=B8=8B=E5=8D=8812:36, Robert Wyrick wrote:
>>>>>>> What exactly would i be disabling?  I don't know what zoned does.
>>>>>>
>>>>>> The zoned device support.
>>>>>>
>>>>>> If you don't have any host-managed zoned device, there is no reason =
you
>>>>>> would like to enable it.
>>>>>>
>>>>>> https://zonedstorage.io/introduction/
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> On Mon, Sep 6, 2021, 9:07 PM Anand Jain <anand.jain@oracle.com> wro=
te:
>>>>>>>>
>>>>>>>> On 07/09/2021 10:36, Robert Wyrick wrote:
>>>>>>>>> Trying to build latest btrfs-progs.  I'm seeing errors in the con=
figure script.
>>>>>>>>>
>>>>>>>>> $ cat /etc/os-release
>>>>>>>>> NAME=3D"Linux Mint"
>>>>>>>>> VERSION=3D"20.2 (Uma)"
>>>>>>>>> ID=3Dlinuxmint
>>>>>>>>> ID_LIKE=3Dubuntu
>>>>>>>>> PRETTY_NAME=3D"Linux Mint 20.2"
>>>>>>>>> VERSION_ID=3D"20.2"
>>>>>>>>> HOME_URL=3D"https://www.linuxmint.com/"
>>>>>>>>> SUPPORT_URL=3D"https://forums.linuxmint.com/"
>>>>>>>>> BUG_REPORT_URL=3D"http://linuxmint-troubleshooting-guide.readthed=
ocs.io/en/latest/"
>>>>>>>>> PRIVACY_POLICY_URL=3D"https://www.linuxmint.com/"
>>>>>>>>> VERSION_CODENAME=3Duma
>>>>>>>>> UBUNTU_CODENAME=3Dfocal
>>>>>>>>>
>>>>>>>>> $ uname -a
>>>>>>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>>>>>>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>>>
>>>>>>>>> $ ./configure
>>>>>>>>> checking for gcc... gcc
>>>>>>>>> checking whether the C compiler works... yes
>>>>>>>>> checking for C compiler default output file name... a.out
>>>>>>>>> checking for suffix of executables...
>>>>>>>>> checking whether we are cross compiling... no
>>>>>>>>> checking for suffix of object files... o
>>>>>>>>> checking whether we are using the GNU C compiler... yes
>>>>>>>>> checking whether gcc accepts -g... yes
>>>>>>>>> checking for gcc option to accept ISO C89... none needed
>>>>>>>>> checking how to run the C preprocessor... gcc -E
>>>>>>>>> checking for grep that handles long lines and -e... /bin/grep
>>>>>>>>> checking for egrep... /bin/grep -E
>>>>>>>>> checking for ANSI C header files... yes
>>>>>>>>> checking for sys/types.h... yes
>>>>>>>>> checking for sys/stat.h... yes
>>>>>>>>> checking for stdlib.h... yes
>>>>>>>>> checking for string.h... yes
>>>>>>>>> checking for memory.h... yes
>>>>>>>>> checking for strings.h... yes
>>>>>>>>> checking for inttypes.h... yes
>>>>>>>>> checking for stdint.h... yes
>>>>>>>>> checking for unistd.h... yes
>>>>>>>>> checking minix/config.h usability... no
>>>>>>>>> checking minix/config.h presence... no
>>>>>>>>> checking for minix/config.h... no
>>>>>>>>> checking whether it is safe to define __EXTENSIONS__... yes
>>>>>>>>> checking for gcc... (cached) gcc
>>>>>>>>> checking whether we are using the GNU C compiler... (cached) yes
>>>>>>>>> checking whether gcc accepts -g... (cached) yes
>>>>>>>>> checking for gcc option to accept ISO C89... (cached) none needed
>>>>>>>>> checking whether C compiler accepts -std=3Dgnu90... yes
>>>>>>>>> checking build system type... x86_64-pc-linux-gnu
>>>>>>>>> checking host system type... x86_64-pc-linux-gnu
>>>>>>>>> checking for an ANSI C-conforming const... yes
>>>>>>>>> checking for working volatile... yes
>>>>>>>>> checking whether byte ordering is bigendian... no
>>>>>>>>> checking for special C compiler options needed for large files...=
 no
>>>>>>>>> checking for _FILE_OFFSET_BITS value needed for large files... no
>>>>>>>>> checking for a BSD-compatible install... /usr/bin/install -c
>>>>>>>>> checking whether ln -s works... yes
>>>>>>>>> checking for ar... ar
>>>>>>>>> checking for rm... /bin/rm
>>>>>>>>> checking for rmdir... /bin/rmdir
>>>>>>>>> checking for openat... yes
>>>>>>>>> checking for reallocarray... yes
>>>>>>>>> checking for clock_gettime... yes
>>>>>>>>> checking linux/perf_event.h usability... yes
>>>>>>>>> checking linux/perf_event.h presence... yes
>>>>>>>>> checking for linux/perf_event.h... yes
>>>>>>>>> checking linux/hw_breakpoint.h usability... yes
>>>>>>>>> checking linux/hw_breakpoint.h presence... yes
>>>>>>>>> checking for linux/hw_breakpoint.h... yes
>>>>>>>>> checking for pkg-config... /usr/bin/pkg-config
>>>>>>>>> checking pkg-config is at least version 0.9.0... yes
>>>>>>>>> checking execinfo.h usability... yes
>>>>>>>>> checking execinfo.h presence... yes
>>>>>>>>> checking for execinfo.h... yes
>>>>>>>>> checking for backtrace... yes
>>>>>>>>> checking for backtrace_symbols_fd... yes
>>>>>>>>> checking for xmlto... /usr/bin/xmlto
>>>>>>>>> checking for mv... /bin/mv
>>>>>>>>> checking for a sed that does not truncate output... /bin/sed
>>>>>>>>> checking for asciidoc... /usr/bin/asciidoc
>>>>>>>>> checking for asciidoctor... no
>>>>>>>>> checking for EXT2FS... yes
>>>>>>>>> checking for COM_ERR... yes
>>>>>>>>> checking for REISERFS... yes
>>>>>>>>> checking for FIEMAP_EXTENT_SHARED defined in linux/fiemap.h... ye=
s
>>>>>>>>> checking for EXT4_EPOCH_MASK defined in ext2fs/ext2_fs.h... yes
>>>>>>>>> checking linux/blkzoned.h usability... yes
>>>>>>>>> checking linux/blkzoned.h presence... yes
>>>>>>>>> checking for linux/blkzoned.h... yes
>>>>>>>>> checking for struct blk_zone.capacity... no
>>>>>>>>> checking for BLKGETZONESZ defined in linux/blkzoned.h... yes
>>>>>>>>
>>>>>>>>> configure: error: linux/blkzoned.h does not provide blk_zone.capa=
city
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Info on the file in question (linux/blkzoned.h):
>>>>>>>>>
>>>>>>>>> $ dpkg -S /usr/include/linux/blkzoned.h
>>>>>>>>> linux-libc-dev:amd64: /usr/include/linux/blkzoned.h
>>>>>>>>>
>>>>>>>>> $ dpkg -l linux-libc-dev
>>>>>>>>> Desired=3DUnknown/Install/Remove/Purge/Hold
>>>>>>>>> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-=
aWait/Trig-pend
>>>>>>>>> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
>>>>>>>>> ||/ Name                 Version      Architecture Description
>>>>>>>>> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>>> ii  linux-libc-dev:amd64 5.4.0-81.91  amd64        Linux Kernel
>>>>>>>>> Headers for development
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So it appears that linux-libc-dev is way out-dated compared to my
>>>>>>>>> kernel.  I don't know how to update it, though... there doesn't a=
ppear
>>>>>>>>> to be a newer version available.
>>>>>>>>
>>>>>>>> You could disable the zoned.
>>>>>>>>
>>>>>>>>       ./configure --disable-zoned
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>=20

