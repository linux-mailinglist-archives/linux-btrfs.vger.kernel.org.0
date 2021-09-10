Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7324E4067B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhIJHb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 03:31:58 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:42888 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhIJHbr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 03:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631259033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pha1gpYpTe3AgL/fcjLMMgMOvKVaOQw3ORDXyMTo9cg=;
        b=XxF0b57XVqYqnACEA55jjGVLhavmxD6s+cKIrQ7Hplt7vm9txOXnRO6/ugbH/jGATn0If5
        0XBoL32WFpX5qiCy0dCR7ttV+Gq0QYGnqDFG8E49a4vBZSxxZsXDFnqemyVLqRhtfL9eav
        E3t8JamjPeYN2vJicUZrpZyMVyG4dNQ=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-zneniYvjOqSglH6CQ0dW1Q-1; Fri, 10 Sep 2021 09:30:32 +0200
X-MC-Unique: zneniYvjOqSglH6CQ0dW1Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiUcL7FrIZI1lB+Rpe5wJrUdFAdsE2hQrje3G1hfQ6Y1wWEYqJcPTdhNcSxqRpmUxnJ3Us/hZMK4ipfbLTVUpgvdCDyb9+tot3Xtneph1TcyllqIG5wljxYd3mmL5OSTxMpTbIdL6bwRyIDUoLgHxtEJiEpJc0ZESXRtU1xquDJsEDED/vvjxTb/uCg9cXAAshxwHqGC94DhxFLjP+pjrRdPFKHuy4Q1wTiOQ7oU0OEr5mqPezslJ984N/wcVGCs8bYIdPzy0AVq7hFuibE/uYkPw8Vu4ZFwdwzgUmW7RdEJBVFIj6rOBEScEUlWdDzuavBgwqrs+gX33UVyF+T1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QKpWPqbuLfgcTjK44DDWrgRSki6Fc/v/ZFCgLjgm8qY=;
 b=RJLmgKeBvpfy15MGHOACRZXu8S16dH2Pt498dACLLCPmxIvfrlrzdc/zH1GXLPIYc6dpA/oPHHgGc/M2ElAqhDMNqtX9E3zRrJagiBcMhtc8YTThYTqMJUcIPAOVvOZD+YDgreHmqseXoDvuFO+f8toFTfNy6CQXi+5ElHyMsiTYb9DbXbBNkcbAPs8Uwp/J1KiVSlULafeEYhW6dJm4mDK+UUB85PYg21l8vT5/TnOS34ekUGebFv3rcytaLJsUAhr3sH0MVluOeAJzbrw4JePZFcvKlwr1RsFvcWU5brqaHkW6fN+5XfLZueX/3iYpDMu7Z8uUjn5WyhZ8hf9Szg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3558.eurprd04.prod.outlook.com (2603:10a6:209:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 07:30:31 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 07:30:31 +0000
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
 <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <2442d845-76fa-ebe6-ec48-e7d0d8ff278f@suse.com>
Date:   Fri, 10 Sep 2021 15:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Fri, 10 Sep 2021 07:30:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28257089-0b9e-4100-c7fd-08d9742cded1
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3558:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB35582607143B0F9AB7A5A8F6D6D69@AM6PR0402MB3558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocw+wl8aocMai8Cs7r1PhMkeGUEaXgV/PfbVSLkmExcB/5s38DpEeXYnBkndv+HE+nu06rNZTQ99STCzZgDIa56Th9HysPZ3JrqZEJQFU+8TiHKeyJN3gGhCyeMbMXq/+c9n9Ucg+CryxEU6mZfVe+RimcOtuuPjReiD6fr0KkqDZ3/YeIIH8lltffzA3YEFPZLEbDORQ64dW5ZSMPtSJ2obbQFIMua74drZ7XC1byqFmT5O/hFW/FS6eMoCftutNlvn2mlQyAWNG8gPKy5sqKbkA/PaMK08U+QwzcjN69FUIVibl/W8FIEeXepsZYyWDMr6Zue+Bp3vVzUhJfjuyZe0H5rtxE94Y1cQEzJL0YBF1HzuKgsVZsmAHuxYfbWi2xl49LLh0vJ0bGyJ0oe2rJ/86692MRp/aSzys/zVvq6k32a1oiXgm/a3HxJwGiYiqdTS1bhQZ/DKDI5D1ryXtQlsZda6O/BLKUoJF4LNdWCSgA0t0yva6J10RtX6mXIw80kWUPKnIfsz74Zk2hP8sEIof+6Dgcy66TRVtlkNsQyv4UEhPvae14mTmREzu3fOU9DOH1Wh//45Ny0+C8165DvyD4EUtRjT+xHeicC2zNUqZpETLBW42RdmUQlded5cKlSKqtjYtRRzQW42ojnRjEDxIyf3eonHiEJm+PNRtahETfeDaTTyZsRrnAcdD1QANAMy4I6n7ooXcdqDQ5BjrxBJUQ2Dd3J4dNhJ4cMnAsZnEsJqHz1/Ibn2fFf4P4ser7dqE16MRF/rSWhM5KqSxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(39850400004)(346002)(6486002)(186003)(478600001)(2906002)(8936002)(26005)(6666004)(36756003)(31696002)(8676002)(66556008)(83380400001)(31686004)(16576012)(6706004)(316002)(66946007)(5660300002)(66476007)(2616005)(86362001)(38100700002)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTyBZubSxXkD69MNj5b7xo5im5c/fNNrMmVyWJIrLlCM1OqIgfSH6kDVIuc/?=
 =?us-ascii?Q?BXOAa4xP5rj8aQ/O8oCvnqh3cDFEv8xa+d3C9OtfPveqrFixCV/XB+xQqqxE?=
 =?us-ascii?Q?elRb9WvTsEEK6/24d0vw8bz5MV9Q5p8jWLLuHG+lTeG3sEW+Kp5oQwA/2NAB?=
 =?us-ascii?Q?yQFGCo3r0Q8De1fiK9t0oMP7sYXijDd5etiQbvEm4mtnpLnvtL5hi1FsxkPP?=
 =?us-ascii?Q?YjvYvFP+X6SyyrrNMx3t4vkzVp8hIXbT404EK6NX/PygXmY86M4bsM16EwAy?=
 =?us-ascii?Q?RUB46V5Ypa7eGA9Q0e1nj7Hy9o+3P20LOHmnVWY7qZscDfxTF+yYu38wLufK?=
 =?us-ascii?Q?F1IewlTxDAXpf2h1BzmEyBsM3naR+Dfjskxrd/mFK4Ji/gmjdONS6GN3BSzD?=
 =?us-ascii?Q?1yEClDfiOGP7ADoPNiAahdW8Yh+vyoF8g53IApSZVX7otevjmOy2xXDtZXvL?=
 =?us-ascii?Q?PeoVYzkZhFr7kt/xC33aSeEIFsn0DWMYmRchDlmb23ui4dU5cuUTrf8EBBXd?=
 =?us-ascii?Q?EyOsjwfbd3kYmlYG9YuyrVU9ykQtYTrF2WHnBocOSdXCz/HVQ09YxHrxB+HX?=
 =?us-ascii?Q?3sagPcp1AJygU19JQg1fTFVtSmU2FyvPXG6bhzqTEBDSC7ykhdd4jP40p3Cs?=
 =?us-ascii?Q?j7dWEcYekwlAgRlAKxKmqqcXWoLfHsciIQmpr1c7q//tOADY5d5ZYsjfAXZ2?=
 =?us-ascii?Q?bJlMdFHEgYP2ctNEPYlxdZMH1dKT3xv1Rgg9NDuKEupQalJbJswApzSSL0gP?=
 =?us-ascii?Q?SAk+BhcSwRpvUPEiTyM5I5jfP+HD8gBR52c/ObQNdA7ybc7DXTrQDIRTzkgU?=
 =?us-ascii?Q?DK1MfL+Rj60CnpVd8yXGPUK9I8wvPrJAqiOHQT55K75a1V6InawEsOcNRIur?=
 =?us-ascii?Q?tgItPHslVns03ccw1HiBTg9jLyjV7BDyV0+14nlawRajfFycGH024qoIS/8G?=
 =?us-ascii?Q?ooLV8enM78JFe6YB9TKM69qfS7LNNmy/TT08pSvCWvTTYf1be0zlJQ7NNFhL?=
 =?us-ascii?Q?QDn7VPbyT7vFhamrUT42tv0Mx90suXLxd1DDMr9GDqhhL+GYRlqfeRzpXgQl?=
 =?us-ascii?Q?41PHN2oVvLt566e21ONuFeGKi+kKH5S2dHJ8mxPU6zq9cXF29Q6KcIbalwW8?=
 =?us-ascii?Q?4AhDIIrwuG5FuxhbtIChgRiCUyf2gnnCpxgMIeTYPR1q14oPUjKlQp73FV2T?=
 =?us-ascii?Q?n/46FL60y4DEvW5lL/SN7n4xkpfDLriHDp94V/2hgNax4qgEtAqlqjgmaSlx?=
 =?us-ascii?Q?PXLFuioyeWUIJS2tp47lxRLzzWinKduV1xZUf4mXgZdxNeNcfwF17f8V5IBt?=
 =?us-ascii?Q?M4MJmyP83l07rLwTqgvFejo7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28257089-0b9e-4100-c7fd-08d9742cded1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 07:30:31.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbTpFecJOVQU2I5EhqibenF/75HrFXkQcJNbebE4Lr76cB8JGFMBl1jnuj9RcJSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3558
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/10 =E4=B8=8B=E5=8D=882:33, Nikolay Borisov wrote:
>=20
>=20
> On 10.09.21 =D0=B3. 9:03, Qu Wenruo wrote:
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-property.asciidoc | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs=
-property.asciidoc
>> index 4796083378e4..8949ea22edae 100644
>> --- a/Documentation/btrfs-property.asciidoc
>> +++ b/Documentation/btrfs-property.asciidoc
>> @@ -42,6 +42,12 @@ the following:
>>  =20
>>   ro::::
>>   read-only flag of subvolume: true or false
>> ++
>> +NOTE: For recevied subvolumes, flipping from read-only to read-write wi=
ll
>> +either remove the recevied UUID and prevent future incremental receive
>> +(on newer kernels), or cause future data corruption and recevie failure
>> +(on older kernels).
>=20
> Hang on a minute, flipping RO->RW won't cause corruption by itself.

It looks like the "future" part is not clear enough.

> So
> flipping will just break incremental sends which is completely fine.

The "breaking" part is more straightforward for newer kernel, but not=20
older kernels (it's definitely breaking, but not that directly observable)

Thanks,
Qu

>=20
>> +
>>   label::::
>>   label of the filesystem. For an unmounted filesystem, provide a path t=
o a block
>>   device as object. For a mounted filesystem, specify a mount point.
>>
>=20

