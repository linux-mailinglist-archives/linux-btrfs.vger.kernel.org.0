Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7F3666F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhDUI1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 04:27:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:48013 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhDUI1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 04:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618993623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wONfnspwZGyZigUQVgxMg6PTAdq7sVAdiFQfX5gRSlU=;
        b=I5pYUbSn5GSr7g1ALOraNa24z5O0wT5KjKOwgTEsbgb5Epq13oOknh4+J73hEkvRhLgd3m
        AfFwRY2+Fy/AXPtlQa6thN7FY22hFnoMtin0fSVxWmof0rmIMX0hMjjDXxolZn0yDPzDRs
        il6o0jf4Fy/m4sh4uTnwPGHoM4UCAtA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32--fgz3DkaPpeAdaMRUFERcA-1; Wed, 21 Apr 2021 10:27:02 +0200
X-MC-Unique: -fgz3DkaPpeAdaMRUFERcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcZrBY3TN2RC+n2m12LCFT+ZBJ/Y0h+LslOaDojj5nSNIn+jzfLZ+H4WdD4NTvaM555mR0BD9sTEHq2k9bTevb9N1mepuPBpjHQK7NN6miLGQGWjEdCNRZaQN81vWB2DDww4dS5h/96AQJ9fjr3TQ2teBfCCR1Z/9lNmEa6yxqBzpGb+UesKe2Jtx9vfhCccSbTtBRJwCyOrEPG6p/3s3I6S09bTi3OdItK1I8cOpnmtx/Ot+ahMkKoFYABarZ2+EkrJSk2I9lzi8cyw7+pwHkzeyWopjBvXpGwpcBIx6c8tqesvY1g6UeMUjI1iRr7iQx89eZUjlGAFapgn3FtyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alglkTtOsmTglu/CT17ARV4yGhkmOfNB7TvS2lmB5OY=;
 b=nmnfwm3KsdeqDUH51/p7kHAN+U/OPspVg10LdxK69Op2lfdqDp80JD7Wpf3G4/KTv6YLBPxup7E1NiogPv24Hl5iFR2uM2O8htw/+iwrxaqD7hZiaZ4jw9R0RbmMLdJjtzdHkUlEN4vePvV7rNl4dbXx6iAJae2SVum1Ys0mToF6YWsJ0XcyNMSMu2sSeRJpx/yOt+14F+C8xM4qhvRnR+wHiQ1ACxajusOEMEi2QXidTWCKlVHXfN5aoWKz9uEyZpUI3GHzN+qVKSGY/mFl6Tq56mHk41c/SxGgWE9x8FqYxjaTu1kRDb1sOFDbMmr+/pLor2sOfWPZEfHtWWPyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3249.eurprd04.prod.outlook.com (2603:10a6:206:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 08:27:00 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 08:27:00 +0000
To:     riteshh <riteshh@linux.ibm.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
 <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
 <344f81af-f36d-1484-3a0c-894d111d0605@gmx.com>
 <20210421070331.r4enns6ticwpan35@riteshh-domain>
 <20210421073020.fwu7a5t4ihl7gzao@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <ca952f24-d0cd-fda7-c9c5-85eba3e7d04a@suse.com>
Date:   Wed, 21 Apr 2021 16:26:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210421073020.fwu7a5t4ihl7gzao@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 08:26:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc2ef7a-dd44-4415-e788-08d9049f3bea
X-MS-TrafficTypeDiagnostic: AM5PR04MB3249:
X-Microsoft-Antispam-PRVS: <AM5PR04MB32493854443FBE202F7F88C0D6479@AM5PR04MB3249.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAIRI6nqMUOX1dqR6PCzuquUPP3kxNZS5qsH5AnmdhThHPgBpp8YBvId5Kfvn1E0cCjIUAl0l73tWLzDdxKD/ItFl37NKOjDVgkJX8Nge2bqiYTg9mK5bXpfPxd46OYymdcS3/bsZ2dQIUVK5dZkqV/DQLl7nps1Bs/qhveCPuq5YPOJP/6Qxt+ZhdUXKShbi88yt2CnWs9fbXVSY4O414LGnzHovKDWXu3vIwEYX9zLtW29UIxfr/tg+olyhzkMsMZjLiiI36g/3CC4wZ89GwR5bnDH/wCndCZIY2JV0azIthK5x/0MaaO2u5Z+xOvcSbFHF/8bqe2XCNdI0UNFWsipIwmaLra51f6Vcby9M2QLUbi2GVwM6aKDM6Y+POQh+h+H/tTDkS83qInKSmqi6N2le5nWT1X81z3vJ4G/901/rt9JTYq89DpQCCorvfstuy6FTIPFfjUUK9yShLHlqS8Pg0xQ22TjyRrWBteXMoUUJF7HJGyUDrbJXmz4AI2euuk3hcxVrQIveqHOyNphYAJysGKcx92UXBMNJGPXHi1ggo4Y2zftSTokkq7IgFZXpruXKbOo/7WO2ktJhyMkviadC4PyOzj07Z3AMyf2SyukVlgbM7+6YpQNux9Mx9NkVPh/p+YrVWFPiPXosznPMiLpKxYQ+WNXe5x9f62iF93qQOOCcvJXLKZde4M+0FnuqYl4LXTG+tIu4rSDtRS3DqkqroTkgdjFrwLtEr7vP8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(110136005)(38100700002)(6706004)(956004)(66556008)(5660300002)(2906002)(316002)(4326008)(6666004)(186003)(86362001)(83380400001)(16526019)(8676002)(66476007)(26005)(36756003)(38350700002)(31696002)(16576012)(66946007)(52116002)(6486002)(8936002)(54906003)(478600001)(31686004)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aRRdBa6pv3PTFYekTMM37adMJFY6F7Kt/QKrHaOAZArxaVkueYMfX++yJ45E?=
 =?us-ascii?Q?NJ0duYxRfh9J538p8jKLWvb6T24Xs34+02MgIsEM/25Z1bhR6Vn20ozTv7gb?=
 =?us-ascii?Q?76URWpu/KVmfcmn66NwT84iZMC0FdGqbrCM+mdUclHRYDH2t2qEr7lI/vtme?=
 =?us-ascii?Q?XuZbUvFrrH2JjZl8E16vB4vj109fd85JCm4qfhYnFyRJzKDUYdbKfskW7XqE?=
 =?us-ascii?Q?AtYKCS7gdMS+sSV7jrrG0EUBPweuObEnhyJeS40XQBHi/ikTNgNlCtDq9zo6?=
 =?us-ascii?Q?syEkqHFRl4cEeAa+gPTYhlBA9KEwAdXDrYbsHTi7vV/uZDQiZP7qK1ErnwUq?=
 =?us-ascii?Q?8N0UeeR0Ju1JI6maq3KcNl0YXkTb6qrdB1OKNakulMujj5QC/e4JXJOZcimC?=
 =?us-ascii?Q?63RhzcOuAwEvTwqytc905h4PpnLR89CTYQ9hajen8cZvFZivBSp3dJ7TCNIk?=
 =?us-ascii?Q?fAlqjptlhqWDSDXVuOvbKyFihAtNGg9lod+o4AT/U3PWG+CXEr4qT2otfKaK?=
 =?us-ascii?Q?tdnaT7v+MRR3wGkKvtMf0ZBC1qjySUMjUxIF00N4VM++6KpFZGruI597OyfJ?=
 =?us-ascii?Q?WBFaq70GmOKZ9/6YgQWiFMuJnla/iydMx4GTS/KxdNma0EqREbhvJ7o927iy?=
 =?us-ascii?Q?gbDsKaEZU17cxTkArKa4koCInYr9ZLdWf/pN6r4Plt9hV0XKtTo8LKpJkI+h?=
 =?us-ascii?Q?pBu1DYWmQLDCmWGl44B3oCXsSGDzDoq7zWAJkxbAAmuRgWEHxmzgYM5upEuX?=
 =?us-ascii?Q?vPjL36NRX6407VSIpPahxPonUm5EamlGQ8FL62JSkEgJmoYwB/xXkUENqJ7Z?=
 =?us-ascii?Q?4+bvQw+v17XqfIAlyUFXDLcUp9GchlrFL1vvS2hwoJ10vtn2WOIo7RdNJRoC?=
 =?us-ascii?Q?BKvkGZo+uuX5sG5Am8wVp8ZoGrZ1Q+O1Nbs4WcCq1dhdI23pst3ODEDPMIjI?=
 =?us-ascii?Q?pYB7Pr0T67PyNMIm8jR023ocPrQ5GGPt9PuxTDoPingrRIiJeTB1RDndvU2d?=
 =?us-ascii?Q?LhGudI5+vFqMXIFNW3mTjbL/LBE+6KUOEWFhnH7pWiftW2iGgoVV+WtllVGB?=
 =?us-ascii?Q?yrxRgpLXeBS/seEhd7YfiOzIPzeOJogwwSXfAkgtQy78IY04YqkE4E+bzIEm?=
 =?us-ascii?Q?C/uzpqjt7iW7HADyoeU2CS2DUHr4aRXK0lFfRAApw86siVZrc/Je56F8P4lX?=
 =?us-ascii?Q?/nxMn98SQCN7G66hGusXkrtSTi3mAiKTC7ZvwyBT3khb+ae+xIuGcUo65Tyk?=
 =?us-ascii?Q?Uopg+XvTrbM0ng03m+kZHoyGUbkjPnyP0sv+rDd1hlxQhOTH/6Y1KHr7GZ1i?=
 =?us-ascii?Q?yvFpS9pVPtS/pGslYAZXSwvE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc2ef7a-dd44-4415-e788-08d9049f3bea
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 08:27:00.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GMqjV8dMRkVmj1R5P2c/1ImkI/xGIhpsmEioerPTGUfAPMR6c9FCOy+Cb3pqg/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3249
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/21 =E4=B8=8B=E5=8D=883:30, riteshh wrote:
> On 21/04/21 12:33PM, riteshh wrote:
>> On 21/04/19 09:24PM, Qu Wenruo wrote:
>>> [...]
>>>>>
>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>> index 45ec3f5ef839..49f78d643392 100644
>>>>> --- a/fs/btrfs/file.c
>>>>> +++ b/fs/btrfs/file.c
>>>>> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode
>>>>> *inode,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
lock_page(page);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EIO;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping) {
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Since btrfs_readpage() will get the page unlocke=
d, we
>>>>> have
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * a window where fadvice() can try to release the =
page.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Here we check both inode mapping and PagePrivate=
() to
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * make sure the page is not released.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * The priavte flag check is essential for subpage =
as we
>>>>> need
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * to store extra bitmap using page->private.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping ||
>>>>> PagePrivate(page)) {
>>>>   =C2=A0^ Obviously it should be !PagePrivate(page).
>>>
>>> Hi Ritesh,
>>>
>>> Mind to have another try on generic/095?
>>>
>>> This time the branch is updated with the following commit at top:
>>>
>>> commit d700b16dced6f2e2b47e1ca5588a92216ce84dfb (HEAD -> subpage,
>>> github/subpage)
>>> Author: Qu Wenruo <wqu@suse.com>
>>> Date:   Mon Apr 19 13:41:31 2021 +0800
>>>
>>>      btrfs: fix a crash caused by race between prepare_pages() and
>>>      btrfs_releasepage()
>>>
>>> The fix uses the PagePrivate() check to avoid the problem, and passes
>>> several generic/auto loops without any sign of crash.
>>>
>>> But considering I always have difficult in reproducing the bug with pre=
vious
>>> improper fix, your verification would be very helpful.
>>>
>>
>> Hi Qu,
>>
>> Thanks for the patch. I did try above patch but even with this I could s=
till
>> reproduce the issue.
>>
>> 1. I think the original problem could be due to below logs.
>> 	[   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
>> 	<...>
>> 	[   83.634710] Page cache invalidation failure on direct I/O.  Possible=
 data corruption due to collision with buffered I/O!
>>
>> Meaning, there might be a race here between DIO and buffered IO.
>> So from DIO path we call invalidate_inode_pages2_range(). Somehow this m=
aybe
>> causing call of btrfs_releasepage().
>>
>> Now from code, invalidate_inode_pages2_range() can be called from both
>> __iomap_dio_rw() and from iomap_dio_complete(). So it is not clear as to=
 from
>> where this might be triggering this bug.
>=20
> I think I got one of the problem.
> 1. we use page->private pointer as btrfs_subpage struct which also happen=
s to
>     hold spinlock within it.
>=20
>     Now in btrfs_subpage_clear_writeback()
>     -> we take this spinlock  spin_lock_irqsave(&subpage->lock, flags);
>     -> we call end_page_writeback(page);
>     		  -> this may end up waking up invalidate_inode_pages2_range()
> 		  which is waiting for writeback to complete.
> 			  -> this then may also call btrfs_releasepage() on the
> 			  same page and also free the subpage structure.

This indeeds looks like a problem.

This really means we need to have such a small race window below:
(btrfs_invalidatepage() doesn't seem to be possible to race considering
  how much work needed to be done in that function)

	Thread 1		|		Thread 2
--------------------------------+------------------------------------
  end_bio_extent_writepage()	| btrfs_releasepage()
  |- spin_lock_irqsave()		| |
  |- end_page_writeback()	| |
  |				| |- if (PageWriteback() ||...)
  |				| |- clear_page_extent_mapped()
  |- spin_unlock_irqrestore().

It looks like my arm boards are not fast enough to trigger the race.

Although it can be fixed by doing the same thing as dirty bit, by=20
checking the bitmap first and then call end_page_writeback() with=20
spinlock unlocked.

Would you please try the following fix? (based on the latest branch,=20
which already has the previous fixes included).

I'm also running the tests on all my arm boards to make sure it doesn't=20
cause extra problem, so far so good, but my board is far from fast, thus=20
not yet 100% tested.

Thanks,
Qu

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 696485ab68a2..c5abf9745c10 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -420,13 +420,16 @@ void btrfs_subpage_clear_writeback(const struct=20
btrfs_fs_info *fs_info,
  {
         struct btrfs_subpage *subpage =3D (struct btrfs_subpage=20
*)page->private;
         u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
+       bool finished =3D false;
         unsigned long flags;

         spin_lock_irqsave(&subpage->lock, flags);
         subpage->writeback_bitmap &=3D ~tmp;
         if (subpage->writeback_bitmap =3D=3D 0)
-               end_page_writeback(page);
+               finished =3D true;
         spin_unlock_irqrestore(&subpage->lock, flags);
+       if (finished)
+               end_page_writeback(page);
  }

  void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,

>=20
>     -> then we call spin_unlock =3D> here the btrfs_subpage structure got=
 freed
>     but we still accessed and hence causing spinlock bug corruption
>=20
> <below call traces were observed without any fixes>
> <i.e. tree contained patches till "btrfs: reject raid5/6 fs for subpage">
> [   79.079641] run fstests generic/095 at 2021-04-21 06:46:23
> [   81.118576] BTRFS: device fsid 0450e360-e0ea-4cff-9f84-3c6064437ef6 de=
vid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (4669)
> [   81.208410] BTRFS info (device loop3): disk space caching is enabled
> [   81.209219] BTRFS info (device loop3): has skinny extents
> [   81.209849] BTRFS warning (device loop3): read-write for sector size 4=
096 with page size 65536 is experimental
> [   81.219579] BTRFS info (device loop3): checking UUID tree
> [   83.634710] Page cache invalidation failure on direct I/O.  Possible d=
ata corruption due to collision with buffered I/O!
> [   83.639921] File: /mnt1/scratch/file1 PID: 221 Comm: kworker/30:1
> [   85.130349] fio (4720) used greatest stack depth: 7808 bytes left
> [   87.022500] BUG: spinlock bad magic on CPU#26, swapper/26/0
> [   87.023457] BUG: Unable to handle kernel data access on write at 0x6b6=
b6b6b6b6b725b
> [   87.024776] Faulting instruction address: 0xc000000000283654
> cpu 0x1a: Vector: 380 (Data SLB Access) at [c000000007af7160]
>      pc: c000000000283654: spin_dump+0x70/0xbc
>      lr: c000000000283638: spin_dump+0x54/0xbc
>      sp: c000000007af7400
>     msr: 8000000000009033
>     dar: 6b6b6b6b6b6b725b
>    current =3D 0xc000000007ab9800
>    paca    =3D 0xc00000003ffc9a00   irqmask: 0x03   irq_happened: 0x01
>      pid   =3D 0, comm =3D swapper/26
> Linux version 5.12.0-rc7-02317-gee3f9a64895 (riteshh@ltctulc6a-p1) (gcc (=
Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) =
#78 SMP Wed Apr 21 01:10:41 CDT 2021
> enter ? for help
> [c000000007af7470] c000000000283078 do_raw_spin_unlock+0x88/0x230
> [c000000007af74a0] c0000000012b1e34 _raw_spin_unlock_irqrestore+0x44/0x90
> [c000000007af74d0] c000000000a918fc btrfs_subpage_clear_writeback+0xac/0x=
e0
> [c000000007af7530] c0000000009e0478 end_bio_extent_writepage+0x158/0x270
> [c000000007af75f0] c000000000b6fd34 bio_endio+0x254/0x270
> [c000000007af7630] c0000000009fc110 btrfs_end_bio+0x1a0/0x200
> [c000000007af7670] c000000000b6fd34 bio_endio+0x254/0x270
> [c000000007af76b0] c000000000b7821c blk_update_request+0x46c/0x670
> [c000000007af7760] c000000000b8b3b4 blk_mq_end_request+0x34/0x1d0
> [c000000007af77a0] c000000000d82d3c lo_complete_rq+0x11c/0x140
> [c000000007af77d0] c000000000b880c4 blk_complete_reqs+0x84/0xb0
> [c000000007af7800] c0000000012b2cc4 __do_softirq+0x334/0x680
> [c000000007af7910] c0000000001dd878 irq_exit+0x148/0x1d0
> [c000000007af7940] c000000000016f4c do_IRQ+0x20c/0x240
> [c000000007af79d0] c000000000009240 hardware_interrupt_common_virt+0x1b0/=
0x1c0
>=20
> -ritesh
>=20

