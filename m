Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF073D7232
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG0Jm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:42:28 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:37576 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235897AbhG0JmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627378944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWSCQgtxChSCaAAbKJQIgcJAsfv4IbTWnqruFDIfPfE=;
        b=gWg9q312mldCPXLYQLb7cFSHex9bkQ8nPdaHXP+SA39x5/eMKoDI1fxn0K/4rtErq79DJ8
        IHN55AuVpN1LFLEarvIMZk6Bf0ihwrNht9DBhVSaPNiR4n45MO94JgicnEZVq2TvLfcSYk
        ZdDbpMnVyPBLPUUJim6ba+ZiG0dBK8s=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-LK4cuvJSM4-ahiP-fqJjOg-3; Tue, 27 Jul 2021 11:42:23 +0200
X-MC-Unique: LK4cuvJSM4-ahiP-fqJjOg-3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV+GWDyjza6Tm6JCQaEY7y5vSDVYcCUguT9XESVmVesCaAFGjUM6GQbeiWLbtdR31ZuUlfIZmMFnT+vUaK+Cgq0jZB97tfWEaTh/XgGTcm05KbT4eXRSIsedNLroLqomJlJ872RLYdB6GF1f1KD5PU8LvqdJ1JUqPJFjxGuoU9eu7LWUBtLat2CqP96NdnM3Zhg+GXCp7Fri5AlkcNlV5kw9E7pjcWg5xqeJ4jPdkXSzAjMghbZIjOHFDuQeyoTBdV66DfkBoK2sL3zh9xgyPe+rpvtktpukkFNBbKaks499XMcXHxgM+pDU74rkMJ/doGk+FAOyNzq/wc/sB2Vqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xn3Ur0xcOOAUAJRV0ojyLePR0uUwPrbp7LXEFtCld8=;
 b=lnF3MKJI3FmYl3a41bOv7LVY85NgZ4SskdZFBWkonnFI8v5I4optqYNa8mvS95Fl1mHg1cD5RYvlW4byNkHjaMrDstEnX5APZ1YU1UysLQlYUAzeOIHIbZ+c6pBYjlZymRn4ELL1Qn9Tm5czPjLv/LYfxD3buc+IwNPZx3F9IFSo3anaPX3rGZdHEM78GEpZGS/EuAr89wildfntD8RIypxpMZPCyW7eh+YBNVgEiEUJIEpPmNfj+1Gi8cHoJAqhuMjXm8ZlVoGawoViY7ch4OflneJwbWyQyhK4HrLTD4OY87lkOfKq7RxDWLSRZNfqWDlPDmX7MpbURLJVPu0HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3156.eurprd04.prod.outlook.com (2603:10a6:206:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 27 Jul
 2021 09:42:20 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 09:42:20 +0000
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
 <6cac34b2-39ba-f344-d601-b78a3f0c7698@gmx.com>
 <20210726150953.GG5047@twin.jikos.cz>
 <cc110ee1-c1bf-2b83-b5db-f70468b159f7@gmx.com>
 <20210727084552.GK5047@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 10/10] btrfs: add and use simple page/bio to inode/fs_info
 helpers
Message-ID: <aee4baab-b288-0520-545e-f1c28cac3e09@suse.com>
Date:   Tue, 27 Jul 2021 17:42:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210727084552.GK5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.12 via Frontend Transport; Tue, 27 Jul 2021 09:42:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 677ecda9-a9fc-4837-c1d2-08d950e2d3e8
X-MS-TrafficTypeDiagnostic: AM5PR04MB3156:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB3156F991140E3A8D65B22C21D6E99@AM5PR04MB3156.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9LGn+KUfDCwJx3RWKHWW45JUmVkwT/gwKufqccjb3ZqRTtOTPaXUQ/ysXUJNIrfLdB75dvHunIX+VjoxkOxqqjo9meQxMfQIF5Q8zvK+sFIcbjyjGXEDLcPvJNE9AwrZ6ndmIRumG5BSQrKQHK3/chRF7oUUnas2A4TNRujo5Z+rC2N2ACmquDnn7fcsdtmTlXyTwMv8yM5TiDFBWAW1BNyveBYTPQr4nDn5VYvEzDo5ATZNpTsQTHp2/XCWmDGV7IEwqadlcqsLhoGUIXr3AiLoVYIVaRCOPmwFg9PI6gjJVoWTUAcTh76203PF7G63y0KFH7lMUINXssMq744VSHqrr/fcltHbk4GO5Qg/mXl1HJC9DN+DgF/HSGZHY0MdtATwsaa5i5mqHZCzkY4Kg1cRls/C0jdc72qrCnSbvCqdubElleqVlCzyLjqPtIBOef+xJ58UkIluPSTPsdGGPl0v84vVL+PKMfR+IW+IQc3aP8xprXF7qZahheG5rdAiQwc6Qy0j9ELSRN4qOcb/Vlx1lLIVdyEy3nBXzHuJxQsDKoTGERpUwLG3IjqULGrFc2Ea6lr5KE7M5eXzC8p+3s3fLs+7tY3//4z+6I/F+F0v/fWaU5TH+wOJfkfVI0ImHP+u1Atm5H4hQ3dER+b9wtATpZB7SD7JBU5oJlVH+6FO2zGw7b+rvZs1KBqdPhuVLRxPVNxquCDGyuwIW1IF+71bhx6b79d46K6BrcUvvc1viaLmwLREwrfOGXRGZcV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39860400002)(346002)(186003)(2906002)(31686004)(16576012)(26005)(478600001)(66556008)(36756003)(38100700002)(31696002)(6666004)(86362001)(66476007)(316002)(5660300002)(66946007)(6706004)(2616005)(8676002)(956004)(8936002)(6486002)(110136005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWPJNaMLoo0AXWCk8LIO+7qUazRgSkkgQJjsvQo85kBKXbQ3HwVVEIAzPirQ?=
 =?us-ascii?Q?mUHaSwp6JdCjpwEHUYtOFppcV80kcywtr4Hy+MQlct2Q8HzsKgQF+yW2FRo/?=
 =?us-ascii?Q?Vxv6/wZWTjyTfL1LbzaNS1URi7w2ZdS2zjo2F572J+od2MmLmIVAzBqPJTeh?=
 =?us-ascii?Q?3We0ZDiCxVYff0nNyRpCBHnp1nSodI42YN6RG1Zu6tYXMoq1hoM6nS2PS/7o?=
 =?us-ascii?Q?WegyDYoO0/GlsOS1b1jtHvMaTxkpcFufufXLKuNb56kx3qD4afjZeK+e2E7q?=
 =?us-ascii?Q?sZKQjIw4eF2/qQlqvq59Xb7Wrj15jZiswfEKrmPOWIQN9kgG785G0WVUBvhS?=
 =?us-ascii?Q?Eyrn/dYm35dvGvfUf3R2xJDlTtxf7vJisG7MgLODiye4FgACJ/kF0gGJApKm?=
 =?us-ascii?Q?VG+QnWNx25KJcfc8874BlXOdlagYfsKlTpHeK78Z2pjnFW2E5aSzu0kxYiPZ?=
 =?us-ascii?Q?qSIq+xTIP6NVoCjUsS425+LCNi/GC6yn7dLm67JI3sEVPJzSGFbm9eh/G7yt?=
 =?us-ascii?Q?6eRGakxm5XO0PNOmAy65CsEem+1//pcwVCNCRp/0xNq5jKopgRohKHC6iDHf?=
 =?us-ascii?Q?kGW3dIGhJx5IpbJU8ROOPenRnN5SD1mmOTiORo+fXsw46STocW3aXxPtTa+Q?=
 =?us-ascii?Q?GSiwJa8qvmrBqkF1L5acozM9POEfWI+4VVEi9aFls5t8/vSUHSlFaFoNHjEU?=
 =?us-ascii?Q?TxSH6Xn5DLOsQGG73rjO1BenJycQRFXSXW52hlb3E8Et+EhQl2eYWFwMPYdz?=
 =?us-ascii?Q?f9g83FR8qKhTfYEB9s/wvkEwL0NiZKiVIj4CU5HyIz5iON6S+mSRgjgYvCz7?=
 =?us-ascii?Q?z/lkVqJGXN1K4az97gYgev6qnxtGb0TQ+Nn8zptlc/P9hLotxLg+fKGykAsS?=
 =?us-ascii?Q?6Y6sjX6zpTOVlzKyC0TW2IJW8UsW5XdSVAJWYtrK+8//NPQCBbVRNSlIWr/K?=
 =?us-ascii?Q?8OPpFYPmM3ZpqTOlVFB/MW0nR3OlX1AsJNgNsRtot3HwS+yhBSW6YhVTtQyd?=
 =?us-ascii?Q?POesHiIpxLr1hPJpzIEp07nIz4AuQFk4Ay0Jm4Q5IgFW6dNWZAO2xGQug5NZ?=
 =?us-ascii?Q?cATHlOOwhlMrG4bWqUCKFBjTAAPFwtEjSFK6+uRj9lIIxis6ZjdWyEfyRD6I?=
 =?us-ascii?Q?cV12YQE43vjZGIrSrgTZH1Du6t1lTFyjg10sukoZrHoroD0cRvLBdiWr8eH0?=
 =?us-ascii?Q?b0XS9C1XzrE4qIKB59jmQQTxmHtHN2+b1cBVnP3iEBZHy1HZOV4U32gxwDkP?=
 =?us-ascii?Q?DVgAXKJ5YUEs/TsJ9NjadAQYSNdBRxSevZ6dLhWjdO3m6NQ1AK/myCWafIWX?=
 =?us-ascii?Q?V3u/rqFVpnm09JmG6NMkSCoL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ecda9-a9fc-4837-c1d2-08d950e2d3e8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 09:42:20.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGhZ6vLmrYP9Vy6r501LZIV/4p2c+Jz1YIEhdLUidbbkb7M2MYECL0MSrYv06I+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3156
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=884:45, David Sterba wrote:
> On Tue, Jul 27, 2021 at 06:26:47AM +0800, Qu Wenruo wrote:
>> On 2021/7/26 =E4=B8=8B=E5=8D=8811:09, David Sterba wrote:
>>> On Mon, Jul 26, 2021 at 08:41:57PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
>>>>> We have lots of places where we want to obtain inode from page, fs_in=
fo
>>>>> from page and open code the pointer chains.
>>>>
>>>> All those inode/fs_info grabbing from just a page is dangerous.
>>>>
>>>> If an anonymous page is passed in unintentionally, it can easily crash
>>>> the system.
>>>>
>>>> Thus at least some ASSERT() here is a must to me.
>>>
>>> But we can only check if the pointer is valid, any page can have a vali=
d
>>> pointer but not our fs_info. If it crashes on an unexpected page than
>>> what can we do in the code anyway?
>>
>> What I mean is to check page->mapping for the page passed in.
>>
>> Indeed we can't do anything when we hit a page with NULL mapping
>> pointer, but that's a code bug.
>> An ASSERT() would make us developer aware what's going wrong and to fix
>> the bug.
>=20
> The assert is a more verbose crash, so that's slightly more developer
> friendly but I'm still not convinced it's worth the assert. Right now
> the macros are not static inlines so they don't need full definitions of
> page and mapping and the other types. Embedding the asserts into macros
> would look like
>=20
>    ({ ASSERT(page); ASSERT(page->mapping); page->mapping->host; })

ASSERT(page) is not needed.

ASSERT(page->mapping) is what I think is necessary.

With something like ({ ASSERT(page); page->mapping->host; }), it still=20
looks fine to me.

>=20
> Or perhaps also page with a temporary variable to avoid multiple
> evaluations.
>=20
> The helpers are used in a handful of places, if we really care about
> consistency of the assertions, something like assert_page_ok(page) would
> have to be in each function that gets the page from other subsystems.
>=20

The call site that should really be concerned is compression, which=20
utilize anonymous pages, along with cached pages.
(Scrub is another case, but scrub never mix cached pages with anonymous,=20
thus it's less a concern)

In fact, during subpage compression development, I have already exposed=20
several locations where we are trying to pass anonymous page with=20
manually populated page->i_mapping.

Thus I'm sensitive to this problem.

So far in your code, it's not touching compression code, thus it's fine=20
for now.

But it's just a problem of time before next refactor to use this macros=20
for compression code.

Without proper ASSERT(), it's super easy to cause problems IMHO.

Thanks,
Qu

