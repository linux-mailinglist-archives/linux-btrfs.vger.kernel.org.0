Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFF397F06
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFBC0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:26:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:58585 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhFBC0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Jun 2021 22:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622600691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MpWJVE/ajX/Up4Ma8o/vgz/aTxboES5eFJP776RDwQ=;
        b=UpDUknFaH8Iyby6K+MegY6wiriTRL67e1Sbr4zIhH9FALHKRk3nrVL8z+o77ZXVDd66VFm
        5yqN08KvM4e6Bi9PvPtYsMvom4h2BpN2iYbjwQ7sB7F7eBUr4dPyn575vp5durlV8hmCCE
        7/9MTmAVSj+TrRgSyryXjm9RbBOj2VM=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-GKv8Um5pMHCEVQ3nVoNPWg-1; Wed, 02 Jun 2021 04:24:50 +0200
X-MC-Unique: GKv8Um5pMHCEVQ3nVoNPWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7YgGp9QKWrCweO44nz8YOyfqOjcTQybgO3AN8Sgu6u0PhtcyrpXTNdqeFaGpq47m3hy+TTgZdSadFsZD4R+G+JzmFEECEajCVeqA8rm+Pf+N5QaDqfG8dqlT4s1XxNEUjWj7D5c63CIEXCF/lmToBJTTKBacy9ZtAuRGfzWLemSmLfYvXyufRh7Mby0ejU8WhSUnZWK/5Z44WM1CWrNVvdCYip16JImn5ruEuCXmglN00CnV0ouP3dMNs0BbZPMlk3+1SiKW0WNe4EJ3XrJwWIo4Agtbgnw4sIF3p6XNCY8SQeZ2ox0yilpmK/jKTRMpuAKkPlfzVj9pCDdfAPMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1QLY3HwD3hRTehmkJGD8n5oDn48SsaVpGkrTibg5WM=;
 b=TVqMWBagbdaewQQXNBihXH1xL0eVE7DfDoRF6Pqt/BeaPB4J8Mf10hP6rx8vX0DenDwgDdjbSCZyeBV1VaOV8+IEPWIjDB/wqiu9Tw7l45rNsFjdq3oTFcXXOu/lYkkOFNF4xTyELltWLTdo4grGURKH6aVkBSnHsdOcJFJGLvMJv08l6Cn5/UYVhEq7ud2SzdsNRCIE9B6yaWQ7tPFaYWYeEXpaQG6gh8eicsBVH6iU4K5y7faakC2egdwrDc9hSWhGeeROTPN3Hv1xqN4K5MLp8bFlwHSPWhTxSzd0TgFZkdtHgZAGVUFU7ZK2k7sJ9puXnwSaDJeWjo83EGRYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2450.eurprd04.prod.outlook.com (2603:10a6:203:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 02:24:49 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:24:48 +0000
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     riteshh <riteshh@linux.ibm.com>
CC:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210602022239.7ueomwrumsbbc5wu@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <1008e8d0-ec68-05e6-19dd-83c5069e3119@suse.com>
Date:   Wed, 2 Jun 2021 10:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210602022239.7ueomwrumsbbc5wu@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:33a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 02:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733340c0-b942-44e0-35bd-08d9256d97d2
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2450:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2450F70BB02AC226253DEB18D63D9@AM5PR0401MB2450.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iT1QiJl0fWM20EbzehVLaoeJKHmFsYYqcZDiO486vL9VQ1OlIMDcsB05dkZYGPobbe5iBxJNYrt1mDbJaQkogfrAGmRwnKixRTbdH+gA4n+OxVh1E7Yu6sEZ4LZ5phowW+yN1VQuZczCWMbunKwlrpql8Wnhc1eF15/aZxcUmKIz5SdpyxOD0LfvhnjImmaCgLUuUKoDpb3ejSMaYZPBfvufMscq1Ihipo+S4lCWRsRSYrZfDO9Ev6LJMhZ5cta0cNDfn2PhfWwA2SnTaHo+De7fSMT1jsORioBe9vjUruoGQiC3IcXN2I8KCVDyKPuawN48FhLjtPbqIyOxbBLle/9jUDT4etI3d2c149Qqrxx/fQMjAa3GF9E4yuYXqYCTNvdPBJVDcZ1TBnP9w8gQNaat5QNoHQQn0mFeu6X4/C/zHtYKjcaG5ANytjOVe/qUXFj/b8JEQQ2dHfh9ZL+5D7nHOueuSWg46hlJS0olz9QgBUt/XOm7i8sZd5vey/lzeJofFe5YIMjKRV0iWuKJJtlsWvhodinxorJsIUCNBfgxxAQHUORIAgjmbMYUlemAsvJnK2xDNJLRmRCGmiaiCl8sGqfvTbaeUeLAk4+tV++AHjoHK3r9g5KSOxln22eIx+8xD5XYeimThzRhlP2XMl/PoCEg/Xz2DtP+CMNmDImQQJhVJpoqQr8DZIDb+dl+t4M1Ha0PxAjSepnHLNQAZlv+WnV7fJpeMRM3PgNZ/4OhRcIsDN+OIKR8s02xx2sRFi7HQizxY5DNvBks5ckR1hStETkf8MwZDkVUO8K0L7is6OkyGL9h1Y8Uh944RVLBBj1EtJlG6P4Oj4cKQSOBy6ytQwf5uiPV1Aah+qr4EtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(66556008)(66476007)(16576012)(2906002)(66946007)(5660300002)(36756003)(316002)(38100700002)(16526019)(186003)(86362001)(956004)(2616005)(4326008)(31686004)(478600001)(6916009)(6666004)(6706004)(8936002)(107886003)(966005)(31696002)(83380400001)(6486002)(8676002)(26005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cRor9WyzsvL/QNGDN0kf0QbuROG47OQFTI2KP7ac5CD+B+sRxtnucrXlo0LN?=
 =?us-ascii?Q?tu3Bk78WVlex+3ITIlCa5UyR/CqRZZH0icMxyAuj1qUK4JELEVbAmIHzQvI4?=
 =?us-ascii?Q?NaADZ3WiDvu/LzKpSecQM4r+jOGNSyjG0SPN0QuOmE50QwBLTy3odUZwgyYn?=
 =?us-ascii?Q?NgD1rfI+rm6ul5Xihjo8x7yfniSCVdQmbstzvYBFTh4+f9/5tfPCzAROelOu?=
 =?us-ascii?Q?xw3ZEtf5v/T7NHSG4k//jsYzOtcMhbK4n01nOo1DwyU77yJ8ibyljILD6Owq?=
 =?us-ascii?Q?1L61SjELY+B8v9sS5coftJVerH8qr1X132WnOnhOq7tnZcmcdUhW1seDKxEO?=
 =?us-ascii?Q?017FBOJHc5zLfajcT8fq5FTto4WFahbku0Ses1ivPVk6/s+R+ePjKq6QqCZK?=
 =?us-ascii?Q?7/d5V6N1sXxQx8+eannq/a488X4kA26sdUZp3BxHWf6vJ+1no5ZtnCbrjVut?=
 =?us-ascii?Q?fQ6ulqfEkxY87P4t/X8I0DTgd7Z2sWSn2fbP6KU6PBP4ldass9br9UGwOvll?=
 =?us-ascii?Q?I47O4uQabIh/TKIsUZ32Oy6swYoQVLKa4zqssjIIjENLtVNXjQybIq60vqFE?=
 =?us-ascii?Q?Zf48iYP2teA+2DKH/4FHN8e7BkBP9B9m5S432iNZG1SzlrFufQP/Uk+F3vi4?=
 =?us-ascii?Q?yBm4TnyT31n38h0TiXES/21+nvonlw2PdYnHQaRs2WRuFRGfJzkFDcVV/OSL?=
 =?us-ascii?Q?hbSEbcBeicYKA4i4YJJq5rJAqxvI0ygmqAs6uzYJ0NS8C9VOS6yb5HajA1JK?=
 =?us-ascii?Q?pGxTG3VDvV5Kc+tCad5Uf6nkOdnRYngUXhIjGYK4fETIBoBHmTKvZyiOdfrb?=
 =?us-ascii?Q?PkeQx4Y+xuERGLQIH7sJxhnc0pn2Zgh8Q6NnTETEuJ/iym4ivoXnCjEF8unp?=
 =?us-ascii?Q?2xHG9rtgo6cr9bn5owN+WmJDNkUzJqLdht9lQRsPXabpN9ocwDhGLXPipwoi?=
 =?us-ascii?Q?pqxDhZ9Bt0GVpxt9iItPFc+9wWDYzA5972Ai11zAFxkJoYI5kxlGi72tQL4v?=
 =?us-ascii?Q?EBcmOA7pLePrBK3Rcn6nv95A/wcWvk2PqYb+pFHg66BnXo+leyKUh1ogHMdb?=
 =?us-ascii?Q?8WGYi6on8HmK03iLEheLGEkoekPDga5AOcyANKmFfbK9mfgNHlYZvcJZ7exl?=
 =?us-ascii?Q?RE/8vYiMeamOIywOfRSBKZ3QkSsKxYnyt177YP0aCib66jDLHeiWk062gQwl?=
 =?us-ascii?Q?Bep+zVsyflm/RrQWYP5TdhpJM96hTmjgr4MtdSt6M53BubvWdLp9HZ+aE0HA?=
 =?us-ascii?Q?v8aMZK2G4hB4uWsexOmLTgmrM+Rnf1pr5U6OznFVWbe9ZdObril1mNrbaUVo?=
 =?us-ascii?Q?ReqlrCMygglEiozH7/13pgGo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733340c0-b942-44e0-35bd-08d9256d97d2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:24:48.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BeiH5uNaqSpi7RjqJYUoTYvcjnREwEVS6F+3TTTlSjJGYqIeelrBlNpe1Y+KH3j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2450
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/2 =E4=B8=8A=E5=8D=8810:22, riteshh wrote:
> On 21/05/31 04:50PM, Qu Wenruo wrote:
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> =3D=3D=3D Current stage =3D=3D=3D
>> The tests on x86 pass without new failure, and generic test group on
>> arm64 with 64K page size passes except known failure and defrag group.
>>
>> For btrfs test group, all pass except compression/raid56/defrag.
>>
>> For anyone who is interested in testing, please apply this patch for
>> btrfs-progs before testing.
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.24=
3715-1-wqu@suse.com/
>> Or there will be too many false alerts.
>>
>> =3D=3D=3D Limitation =3D=3D=3D
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>>    Read is no problem, but compression write path has more things left t=
o
>>    be modified.
>>    Thus for current patchset, no matter what inode attribute or mount
>>    option is, no new compressed extent can be created for subpage case.
>>
>> - No inline extent will be created
>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>    trigger more write than the range specified.
>>    In fallocate calls, this behavior can make us to writeback which can
>>    be inlined, before we enlarge the isize, causing inline extent being
>>    created along with regular extents.
>>
>> - No support for RAID56
>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>    Considering it's already considered unsafe due to its write-hole
>>    problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No defrag support for subpage
>>    The support for subpage defrag has already an initial version
>>    submitted to the mail list.
>>    Thus the correct support won't be included in this patchset.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~19:	Make data write path to be subpage compatible
>> Patch 20~21:	Make data relocation path to be subpage compatible
>> Patch 22~29:	Various fixes for subpage corner cases
>> Patch 30:	Enable subpage data write
>>
>> =3D=3D=3D Changelog =3D=3D=3D
>> v2:
>> - Rebased to latest misc-next
>>    Now metadata write patches are removed from the series, as they are
>>    already merged into misc-next.
>>
>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>
>> - Use separate endio functions to subpage metadata write path
>>
>> - Re-order the patches, to make refactors at the top of the series
>>    One refactor, the submit_extent_page() one, should benefit 4K page
>>    size more than 64K page size, thus it's worthy to be merged early
>>
>> - New bug fixes exposed by Ritesh Harjani on Power
>>
>> - Reject RAID56 completely
>>    Exposed by btrfs test group, which caused BUG_ON() for various sites.
>>    Considering RAID56 is already not considered safe, it's better to
>>    reject them completely for now.
>>
>> - Fix subpage scrub repair failure
>>    Caused by hardcoded PAGE_SIZE
>>
>> - Fix free space cache inode size
>>    Same cause as scrub repair failure
>>
>> v3:
>> - Rebased to remove write path prepration patches
>>
>> - Properly enable btrfs defrag
>>    Previsouly, btrfs defrag is in fact just disabled.
>>    This makes tons of tests in btrfs/defrag to fail.
>>
>> - More bug fixes for rare race/crashes
>>    * Fix relocation false alert on csum mismatch
>>    * Fix relocation data corruption
>>    * Fix a rare case of false ASSERT()
>>      The fix already get merged into the prepration patches, thus no
>>      longer in this patchset though.
>>
>>    Mostly reported by Ritesh from IBM.
>>
>> v4:
>> - Disable subpage defrag completely
>>    As full page defrag can race with fsstress in btrfs/062, causing
>>    strange ordered extent bugs.
>>    The full subpage defrag will be submitted as an indepdent patchset.
>=20
> Hello Qu,
>=20
> I have completed another 2 full iterations of testing this v4 with "-g al=
l" on
> Power. There are no failures reported (other than the known ones mostly d=
ue to
> defrag disabled) and no kernel warnings/errors reported with v4 of your p=
atch
> series (other than a known one causing transaction abort -28 msg, but tha=
t seems
> to be triggering even w/o your patch series i.e. with 64k blocksize too).
>=20
>  From the test perspective, please feel free to add below for your v4.
>=20
> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> 		[ppc64]
>=20
>=20
> I think since this patch series looks good, I can now start helping with =
defrag
> patch series of yours :)
> That should be on top of this v4 I guess.

Exactly, and that has been just submitted.

You can also fetch the branch from 'defrag_refactor' branch from my=20
github repo.

And since that branch only touches defrag ioctl, free feel to just test=20
'-g defrag' test cases if you want a quick run.

Thanks,
Qu

>=20
> Thanks a lot for your effort and help!!
> -ritesh
>=20
>=20

