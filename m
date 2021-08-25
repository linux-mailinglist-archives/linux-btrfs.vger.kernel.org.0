Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86C3F74C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 14:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhHYMIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 08:08:01 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:54902 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232681AbhHYMH6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 08:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629893232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJL9s4XfWqv2+aHInagyf9nbJ6QqcaTWBUyQmlCa9KU=;
        b=li44LRzy37BZeiOQX0kssriwkiMiMIezbICwccDnCFSv0fQMzgi021xaXYcZlbs6hkgfeG
        djcVTwDml05HtO+q3p1zQ6AYAHu/vkU2sU5UMABDjFOphXXnuJToTJfxSOlD+m65DRCxUC
        2m3mW1aLpcsN7wGV4lZWOVUlDhSio2s=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-5-hznXtAJDP7G-88Jw78ZZoQ-1; Wed, 25 Aug 2021 14:07:10 +0200
X-MC-Unique: hznXtAJDP7G-88Jw78ZZoQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoOquMYail1n/o7QuFRM8kKCT/sqNCm5wvvjLDDq0FnwC48nZbwmwSlc43JDsoZFcXrJz+bt2+QMun15PDlKrUZGBH6h7H6AQ66cQAQhrs9GmqXBaR/D66gdM+fbpz1iFjarbiFkJVTlEoJXP606f+GWd6wAWVbkFNqW9KqU4ToS48VcOJfNUERnahsi7cbv7esZa8ptrMW1gxIH1A5q5HYjgqIkpHYb483gsgNmA1tz1dyF1A4gO+u/rGRdhcRENQoM+nXlICNHuB9i6cisBTt5kwincXV22RZQhp4bz+5FinCoeKmI2MKOfqhOlO4FjYdFQa8gKmNGd7M5OhUCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUrmXMSDevN3GzW2XiQnjOLDtw8DrfuX7wvWVhM0vug=;
 b=JyUBg3uACy2JClrj5loowLpIT3UQOc3A4/X99PInDvY7QQDr42dbDoEY9feAdOM12WOzai0abLWOex7BGfR1w5RR/XHpWenMotsM0Q3JZC0sfnGk3bJZ7skSh68QgbcVDWOw8m1ZSE3AFUkl5dP8V3dZvZHP1YHwBs22hY6Mcg+Bx9V3O29vVq2xMzK0d7g+xH2LuiAlG4WXSfmUf+gZ7p2lUfE2F7hLp9iA4OcRDfjaDfu+tRpt7fFHjUSzPSmm74JriDIgglcXmH6aNt+Jyx/mQolvtcrTPRecwWBr0gPReAbh9TqPReTWmafmbdzOKQ2yrbm583Aru5g5rWSKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3893.eurprd04.prod.outlook.com (2603:10a6:209:16::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 12:07:09 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48%7]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 12:07:09 +0000
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
 <20210825115559.GG3379@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
Message-ID: <d0dccd5e-c67f-a18d-8d6e-559504b5ee91@suse.com>
Date:   Wed, 25 Aug 2021 20:06:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210825115559.GG3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 12:07:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d69757-e119-4dba-9c11-08d967c0dd0b
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3893:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3893F01D1C3C95B31BAB90C5D6C69@AM6PR0402MB3893.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrokoe6DLTVRhPe5ex1Up4BcsJCiMh/mzNznIDTKZWhWNZXzZaym99D8e85YDilh5IgAlR6z/TPIH2z6lHLpGD5WwIB6OaeOMorfwfx4SsZjIjhI47JaAEI9Yftpk42kmwAN/1beK6nmBiO3PdaX1e4pODkvPglUOK0cGdpVuiPmv1QIYe9cm2FoGjPbQOg1U9u+1XHi4a0JKL0NOgZUtw1wcaLvN8FCvAIZ8SlmpMjRcCPT6WJT62DgdTA//wVAjTq3jj4Wft6/zmx1FMe6PjpvpdcleImK0MmoRsv/4uDbVZjOvonRVk1L3ym+8yaVPslQbI7hUL6GNgRq9kR9hlipRt6EyFTfxFmqbQqCzjCqqI2lzj7dC6YP4N5lgVd6ypJxJozIi0AF7t22e2+ekSOKPpsBPtOS3bc767mmOx5xtcXIqrhTJG4LRtTZT/aWet4qefKXQO9wgaMJsO2/bylus/Mc2cYWxtIPxX3hnZh935N9Jq0w63UBCz9iR6T/5MFiI58IAWDSAxyodAoLX/dEkJSkR5unKPuKFcGSvLtlNQZOFOHWcOVuNsCVR/klhov3UzaM8vuBeSOxdBCfRzdDvV6Xki2kYnTPRzQddd/V05AFiqSQm7gyLo+sD2LyWg4YzR8eLKOFXO4Zm0Suk0Oc3CcqY1Elqa4KhfMovRkV1Dp8Am6x3QWkunheL0J50gH5n6H8ybdVClJZHbqO6yEyhyJij7rlKufjvZHPHMIjfus0GOxvlzHEnbZ7ubsC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(186003)(86362001)(26005)(83380400001)(6706004)(31696002)(6666004)(316002)(6486002)(2616005)(8676002)(31686004)(8936002)(66556008)(66946007)(2906002)(66476007)(956004)(36756003)(16576012)(5660300002)(478600001)(38100700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Byptc6efaadskb6s5ndiU3sCz1kaptWWha4qVKZjfpZVRBR8JHXSzeuxbBFJ?=
 =?us-ascii?Q?p+dYqcStioKp3hpZs7py2Pk16Y9O0lOqieBX+gQZ2+o8cCMiXKoVOy4ULc5/?=
 =?us-ascii?Q?NCSSvdLLGyiHYcu+vdvnIz3Bf1264pQXYDbkxJ2JsoCAlmhenvzKJA2WK6pO?=
 =?us-ascii?Q?RK92tEj5t2hB7FQRsdQKHjyomPuyAi3CbPCkxOocUyq8cG5dnqLkUOcKsRhH?=
 =?us-ascii?Q?RcXidP7/Dk8xHEcpIdgqKMhwcmdFOoobX5+I6l3WCJWMGY0Sf714HrH5dtfT?=
 =?us-ascii?Q?JmhhQ/8hCmzM6XGY4P3g2OfbvYOhwCV7iLPTvmqRaEj5yYoMrB5NLx7hoOrR?=
 =?us-ascii?Q?C8Lsard1mOnsSHT/bEfbHiYlSUM5VoZ0aZGiFdE6kY6gZBRiGToX99vKR4Gs?=
 =?us-ascii?Q?5RsZo3j0JmCJE32+D2AXC64j2WGm3j3yrcVACIlK/t2TAWSGmzbHpPgUd9aV?=
 =?us-ascii?Q?DjGM+ECCw674QKQi+/tJl2mIaZDuAP7U68gf+XixejsnwLODLxDCBhSo4YJZ?=
 =?us-ascii?Q?rkVcclUlfxbU50CXnCQhhxHWm8GDWbOq1ufPa9fQMy23Y3piZWTg43cVyequ?=
 =?us-ascii?Q?HWVOoVlDjmQYPOAaUzcDCArHf4zh12JPdBr3BTULbQR5kUQgP2yjpk65wo0+?=
 =?us-ascii?Q?ZszU0iXEdkwMTB0BJV5K8nhncMYSXs3OfsIc1H0/hqQadXVzVhpJwHEZ8Q53?=
 =?us-ascii?Q?F7ThKMMSzSwBFzyRCmhmTzn+RFmo5MFiSCG9o/VY1x0iaHlxtjmr1J1frU1L?=
 =?us-ascii?Q?x35owgwEkmEY9LAj+f++MdAkQdzrc8hHKFK6eCA4WYyY5YE9KDpYUWutDCs6?=
 =?us-ascii?Q?AQfPiXR68H0Xct7ZtHmUhIy3AFbYhFkgmNszMIiITRjI0/IJqccBOE67i6WL?=
 =?us-ascii?Q?oCJvSbijM9HTHRdYe2iq8JNby9WTSa9f3yPsEN0LESSCGQyFXP7BR1COcAk0?=
 =?us-ascii?Q?hvELEgSM8fBc83G8g4n5Oa3+snX3LdC6iyGKjZqLPVvZtcm2P0sIw+/Ldf0n?=
 =?us-ascii?Q?PIN+8ddiWsHhQ7kHj3iOqQTGuIWpzt+Gj66YosxYlhW/Rsae6EMZxAmSN3ml?=
 =?us-ascii?Q?9dFvcyp9OGt83LANs0BP4xchIRP1ZReogOFG3ZCnULFXFzcyIsljqgUTVKuE?=
 =?us-ascii?Q?Fi9Fn9V50/8eCFcHNfHXbykoEchSSex2QygvUH3DL1HJhmdIUNAWdYO4wfYM?=
 =?us-ascii?Q?LvVPTwCpTd7ZS0wOU4P79aAx5LphR3B2kc0959ODjDnzvvAgCZrApb0dqAbI?=
 =?us-ascii?Q?qKeJLsWYaIQ4iMjyLm/M4m2g+RdXuc4L8zhfY5Mh7Fi1Ucv5vW8hUm/MwoQn?=
 =?us-ascii?Q?MZ2qCvlWuBhrJa8+KKt/2yQE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d69757-e119-4dba-9c11-08d967c0dd0b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 12:07:09.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrQA1XjUHC8JYi3sQwH/l4PGbLqwrPBu4rLFrLDtEx4VrAHjbP3PUFp2Q9vCNJ8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3893
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/25 =E4=B8=8B=E5=8D=887:55, David Sterba wrote:
> On Wed, Aug 25, 2021 at 01:41:42PM +0800, Qu Wenruo wrote:
>> This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.
>=20
> At this point the revert is the simplest way to restore the inline
> extent compression so that's what I'll probably do. However.
>>
>> [BUG]
>> It's no longer possible to create compressed inline extent after commit
>> f2165627319f ("btrfs: compression: don't try to compress if we don't
>> have enough pages").
>>
>> [CAUSE]
>> For compression code, there are several possible reasons we have a range
>> that needs to be compressed while it's no more than one page.
>>
>> - Compressed inline write
>>    The data is always smaller than one sector.
>=20
> The missing logic was for the true inline extent. The patch was supposed
> to skip compression for single pages other than inline extents, due to
> efficiency. So I wonder if we want to do that or just don't bother as
> it's probably a negligible amount of wasted time.

Yeah, I guess that's the case.

We may be able to do such check in the future, but at that time, we need=20
to take inline extents into consideration.

Thus it won't be just a simple @nr_pages check, but with extra=20
@start/@len check.

>>
>> - Compressed subpage write
>>    For the incoming subpage compressed write support, we require page
>>    alignment of the delalloc range.
>>    And for 64K page size, we can compress just one page into smaller
>>    sectors.
>=20
> Oh so the logic would have to be updated to distinguish sectors and
> pages, but to simplify the code for subpage compression support it would
> be easier to revert it and start from there.
>=20
For subpage support, there will be no conflicts inside the that function.

Just a reminder that we need to change our mindset to distinguish page=20
and sector more in the future.

Anyway, if we really want to do the same check in the future, it will=20
take into @start, @len, and sectorsize into consider, and maybe more=20
factors to be consider.

Thanks,
Qu

