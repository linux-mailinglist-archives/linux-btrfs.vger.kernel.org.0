Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142963EE073
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 01:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhHPXa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 19:30:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50095 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234592AbhHPXa6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 19:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629156623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiZF6FR8Lftkh+eSv3ptItH+qfVcmLy/f1OFn2oT7lU=;
        b=R6zR3pw8X6UguSnp+EV6nJfxY9haxOexf0EmsXP3BH1QK0beP11l4F9iPFGzjjW4X+ti7r
        f2DOAHuo0w7OGOWRpD+0CqlVZnKBAvZlIAiCXoE3vPBCfrc9XTo9j+p6Py/PdOKkvN8UKI
        OJrpGx6+sRPi9ccDcnWWxlKpQtYRBko=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-P-9sI_CsNXayWRno4BbmmQ-1;
 Tue, 17 Aug 2021 01:30:21 +0200
X-MC-Unique: P-9sI_CsNXayWRno4BbmmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUIqiuTFzWkleXajfQqVGE1Dz9oUXrgP8jtDuuPBLoW8eKBwPAwH9qBpk4RuInOLFsYrYpZ7LqHJOJNy4TmKuuO9YI1damdTNIkO/0aJfWqsficZc+ldhtLEtxpNGS6j0L5+Pm5u7iYAkcaw3f7bSbjbOuWUETq/1EXOwuqzWWUDtwoGDn9Qo0TxPE6aPAsvMARbgRn8pP1VZQ70oC1h5KxtDvBxcsrCiiHQNYdTp/c5grwVuirBza5FEJeNNoLh0gGlFAxHIHu4uJZ3ya9jqMxfllyME3hN2jZT1AapuEFj5cCl1W1L4TfTgwfUCnHThtAqZUP8FRvSPpl/lqufhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6jmR18HXlEpvjVz+75wafgPisRBCeLR6f7sn+Spgcs=;
 b=WrpeIRpx2rz9O7UiB97rupsvHXIUG15sh2Nnv+pCw9tqyF/W02U3gFOdcDo9TSshRM9ddrJuJSKNarirF2PSBdZaDEpMXxjn3ORTu5tBW0AqkOCHJNACsYQSMMsb36wnSNaBSpBYNO29juUWV81mLfSn620sVY8FpAHmL4nZohnog4zGzrsza0721Ttq18pH39oahO3kLlTrn+vVbN0ArrVgQRNh2YVFp13r83RnwEh4xTMT2deupYDpKWCRCSpDgqslpT0SZYQ3/A+n8S7Zv4+ssSi31xvOBN/mSL7r5cqzWUzdR3fxxotpLlLosUda1y0VHbJexDKDAzY4lWy/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 23:30:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 23:30:19 +0000
Subject: Re: [PATCH 2/2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210802065447.178726-1-wqu@suse.com>
 <20210802065447.178726-3-wqu@suse.com>
 <594df624-3895-8787-9058-a00dba01c0cc@suse.com>
 <5e516629-05f1-7750-1f0d-34cd73e8b52f@gmx.com>
 <7953dbaf-7b7a-2279-0ac0-63bb51a51f1d@suse.com>
 <20210816142100.GD5047@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <148c6012-602d-fedb-5d5d-e5533583c480@suse.com>
Date:   Tue, 17 Aug 2021 07:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210816142100.GD5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:39a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Mon, 16 Aug 2021 23:30:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0f2ed24-8a88-46b7-9811-08d9610dcf22
X-MS-TrafficTypeDiagnostic: AS8PR04MB8312:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8312DABBE2DC1002689B27D3D6FD9@AS8PR04MB8312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcmbrQj6PZ5+QE+a7AiqMmNdS8P5B7MsR5fRjVdjKYTuv8vq+2RHmcP5Fcsd86V0Fe6Q5le9aQ0egyy5PsJkGvc6qB7Ean1n5DgOgCZncPlCNQUTWbfH4xYlLwABHlMl73U91tuIi15XguLIdvQPA//SYjFF1JP/oeQ0pOQgmxonGXapYvRl3LJXdnE5Ma6CYMchhWQ0oUDi3ziZh74Z4SY8PV262K3cJ6Tay4JUu/0VvLnGwL53RFYlBv1Lc/zg3CZ8ndGw3qea/CVWzWDzXFfj7RBmk1wB0AZc2TRG91dRJOZLYWOV4dHRZBojnbe4rcwWY3NQnPyVm6o9PdkMf0vHNHYfAfE9XLiwHWU8isVQnCzHE50GmOF/ncytZVsS6C+ewn7Sth3yOzeY+u4r1Y4Z5Y3sgxRDt1UppWQGoR5JqrNNomSRQKbgfTYu8K62kniByt+vFjvRh10QtgEJWknr9Fb0E6Xl9PFJfk/x7pzv3bl5rOCmTo3Mf2ZR32pfW4yJaWZJ8vL3jCMvECTIAhlUd4A3f6vKtUzOHPCDXUj6aX4fwPyIJUbRvd2/QK+9rk9hz7RSZKlT28616klKNqPA6jFifKVJ/t3lPVyYSpCCPN/fsB2Bp5K9kFzyVwaPM0e/uZE3aZ5Whg8NBw6nBsDvH8c9YkTh2knskQkYXvVaOG7TCWfHphRD3AlBSQ+aPuzkBywfTrygNf0um2BNEVCd7OUGKf2ayHhtGC+Nx4aCefYGPbCnKdThEZKnlU49
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39830400003)(6706004)(2906002)(5660300002)(66556008)(66476007)(66946007)(36756003)(38100700002)(83380400001)(316002)(8676002)(956004)(2616005)(186003)(86362001)(31686004)(26005)(478600001)(6486002)(31696002)(16576012)(8936002)(6666004)(110136005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abuPwpAbykqAvZakegqEzdcPAsNvkzX2Ie2XYNqVTO9b90a/Lye5vmV91MwI?=
 =?us-ascii?Q?z0fr7eNm6LcSBvvNM84DP15+y2NbXNPgXouQo/IRjVifvki2mpGJX16X0Om0?=
 =?us-ascii?Q?wBVroS+iTLLzxg5M8npbGz93R5uyOdHTsWynV83skvMgoUJdNRBrUS0ctAyO?=
 =?us-ascii?Q?vay+8Fcohl5ShWTG3jXElHhgGdshpIw6YOx/cTOz8eiQ9LtZEvIhFM3TlQrt?=
 =?us-ascii?Q?/c0e0C9VRpi75iBI1rys1gVyZASs5iBNsy40ba5CFH1A8nY4+hTxOo1Zkl6V?=
 =?us-ascii?Q?/ol17NUxDtaHNJpKA9iqD+nEfJxW1xsMnFwFDiziwK/XzeGlgv5X8UCb69BN?=
 =?us-ascii?Q?KBc8Og03vAV6Sng3zI4tFK/eQgwUDFk54v0Ogior2hG5xSwR5GeOUSdUELuQ?=
 =?us-ascii?Q?/0HjwlwnyDZSK/Ldfq89qIuYQz3PR3WQllDLGVtZ6MDHmZKY+jB3D6dmWILl?=
 =?us-ascii?Q?+nw93v3TpQvYrdT0DYHpqdamp8vCaEadUEdEQ8PEoO1rfDSllAs4dIvaSPLL?=
 =?us-ascii?Q?ny6Se0nFHuTbFILPGTzQ9nhakBUii26NrQ5ikmtaF8sxDbz4DOXP+hnyoLtL?=
 =?us-ascii?Q?4Un2R5i0vq6vmYwaoIaPWjrYEd/vS9LpZexT9L/TjRnvlTzmpQFrOOsx91XH?=
 =?us-ascii?Q?IAqBjHjVMT9oTKOOZ4ikZfPedL0MZAugcoEqHnHCRocB5jH30xYNyJlS5A0p?=
 =?us-ascii?Q?cPJ3Ojn1Xf3IZmJMSzUJ7gH0d5XyqoDW+rU6qAZBc+ddux/PCFqTKk3IrP/Z?=
 =?us-ascii?Q?/6j2PX6UK57qbUbG1SoZ0XLCio7WTU3Hn8GboygGa55VFzkDtKf6Ff72MSKe?=
 =?us-ascii?Q?N0r6RZJMblAWB9UupOl49ozzIQ27Akm27FxNo4zd9T0AIXjfZD1kFm99tsxn?=
 =?us-ascii?Q?r9RVStqZA3mg/YYWUmRpL5S4mRbnT+tcE89RvhKO4Kc2Gkqm41AyUr97VqbN?=
 =?us-ascii?Q?VZukZttNLS/6a2UkApWqvnpUtEs3WWQF4RPtpcCShgvYLVcICTTcSeaxM041?=
 =?us-ascii?Q?biQ0qamjCuqzu4jFpDgax321R42hsEODFztx9mKbndpRpLUpVv7zWSF6pKeN?=
 =?us-ascii?Q?O95FACzgaeZJCRexdTNBsCzA8l3Cy5F3azIfQ1yMW+1iyAHuGbuQGruHHxDC?=
 =?us-ascii?Q?dQhf+cx2mcQgX5I8x/3dFkETh5Txk64nGVlFyXH/S+FIGe6Rj/mK/50Voua+?=
 =?us-ascii?Q?p+ZoorTgMlj5LxgGbHKo/HprUaLSP6YGyqfoA50VOMeIbKt4Ty7R1vtNVvsD?=
 =?us-ascii?Q?vWIG7ALkyVLC1TEdQUM67G+k9BB1wJ0venKjvVbpInnzx2Lnu9ZYDmZRaGlG?=
 =?us-ascii?Q?FUCKm+D169VaA26idkLXUB8W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f2ed24-8a88-46b7-9811-08d9610dcf22
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 23:30:18.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRU/d0ybLAOsObxcKTQFx4vf6qlkbIdpEfOkat6KuDpVp950yXO5PrDmlT/D9bgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/16 =E4=B8=8B=E5=8D=8810:21, David Sterba wrote:
> On Mon, Aug 02, 2021 at 11:49:38AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 2.08.21 =D0=B3. 11:03, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/2 =E4=B8=8B=E5=8D=883:53, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 2.08.21 =D0=B3. 9:54, Qu Wenruo wrote:
>>>>> The BUG_ON() in btrfs_csum_one_bio() means we're trying to submit a b=
io
>>>>> while we don't have ordered extent for it at all.
>>>>>
>>>>> Normally this won't happen and is indeed a code logical error.
>>>>>
>>>>> But previous fix has already shown another possibility that, some cal=
l
>>>>> sites don't handle error properly and submit the write bio after its
>>>>> ordered extent has already been cleaned up.
>>>>>
>>>>> This patch will add an extra safe net by replacing the BUG_ON() to
>>>>> proper error handling.
>>>>>
>>>>> And even if some day we hit a regression that we're submitting bio
>>>>> without an ordered extent, we will return error and the pages will be
>>>>> marked Error, and being caught properly.
>>>>
>>>> Would this hamper debugability? I.e it will result in some writes
>>>> failing with an error, right?
>>>
>>> Yes, it will make such corner case way more silent than before.
>>>
>>> But IMHO the existing BUG_ON() is also overkilled.
>>>
>>> Maybe converting it to WARN_ON() would be a good middle land?
>>
>> If this can occur only due to code bugs I'd prefer to leave it as a
>> BUG_ON. Ideally this should only trigger on developer machines when
>> testing code changes.
>=20
> I'd rather see a WARN_ON + the error handling code, a BUG_ON will shoot
> down the whole machine. In this case it's probably serious enough but
> in the long run we want to get rid of BUG_ONs that can be reasonably
> handled.
>=20
OK, I'll re-send the patch with WARN_ON() and error handling.

THanks,
Qu

