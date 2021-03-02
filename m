Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE96432A159
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Mar 2021 14:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbhCBFuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 00:50:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:27109 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235849AbhCBAT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 19:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614644323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyUB7At0trJam76pIZ/3nPAQ0Ux/fYhTHC5+m1EyJbU=;
        b=PdzvEyvxYf1SjWU6rZTwSKI/GNNsIRnafemAPGR/PSEpYQyuT/QYmyIWivkx5H8qDs7Q2T
        t7F3fH25OVKjlSOnfU9lkTJW5EbkoRo0wbd1Wn5VQwsQcT6EnwAhqDYRw+OOXZVhEEOV17
        45uXlolFpW2fsHVuLHMqnm2o6ACIJjQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-dzUiLhcfMAS-YA-JgC9NJw-1; Tue, 02 Mar 2021 01:18:42 +0100
X-MC-Unique: dzUiLhcfMAS-YA-JgC9NJw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2fiRuXtclhx1lSf1pTMyVjs3uzI2k2Dh+rdfQOkcZ57h43+jdg/RRBhh/Km5ZH9hc9d2ZX+K4IQoqqMqmz6LI+/QC+qkiL+K3w3A68qy5SJTDGCnc0s0/l9AuuY8pH9aIM0DnE54/3QRaBNaJnWDAh3sVAIlfYKtWfj2ce8Jbd28acDZjKN1M4tTcGrt6h2hWhtem/5pKyAzbu4LZ4lb1mt3sZoOtRKyGUUzgMoZZgzvN2GrmqMa2Y1pMLk2842Y5IXPbpGnkaL1ymAPkOdUHCoWFpvD2uZNeP6fi0S0yYi/yaAi9Ah3EaqiMlcLPQrBJCb0JPgAp65Fd2/CDB1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6czF7fsbEhtBA4aE+SUGHTatcnlnLATA61EOsFSLFn0=;
 b=F98RCc5gAubID2cJIUALWZoBLfPRG2Bdx5ex2xpDoBfhwQvI4X8+++NeOX7ZHwt/fE36Je/i/2ccS72S6cz92Dl24TH7fNfblr66NyRe/3XlUwMGf4u9toYVSnOGNahMnUgChSUv6+ZVgnX+8jyiT9h04s/Oj8FzKewMgEi0rHFbbk1Xp8O8wh4NPkNFzczShg8yPgtEd1hZ1n/iPCAay+BWLiPUx03PmVuJIp1h6aKLpcqWW3r/c34LkloqlUP6+nqamjuUuIvKiY9hctrsWG7UjdjTXqXCGDRTooPGbsjZFA6HGbv5p0Yuwhce/+9ketDNJhBHqj/s3XXwbmp6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3155.eurprd04.prod.outlook.com (2603:10a6:206:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 00:18:41 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::355a:d09c:cbf8:657e]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::355a:d09c:cbf8:657e%6]) with mapi id 15.20.3868.036; Tue, 2 Mar 2021
 00:18:41 +0000
Subject: Re: [PATCH 00/12] btrfs: support read-write for subpage metadata
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210222063357.92930-1-wqu@suse.com>
 <20210301163045.GY7604@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <64219e86-9a0e-67a5-25bb-486482204978@suse.com>
Date:   Tue, 2 Mar 2021 08:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210301163045.GY7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393ccc90-e4e8-459f-a51d-08d8dd10bb9a
X-MS-TrafficTypeDiagnostic: AM5PR04MB3155:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4893
X-Microsoft-Antispam-PRVS: <AM5PR04MB3155D8F4644FDF406657C4F0D6999@AM5PR04MB3155.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3j2ipl+GU74AftDQnZA7I0Wa1JF1ztlWjtU3IP1K5ux2oqx9K7RgzQs+xAYPicesGUzgvMmytwFBAf6w7A835UValbbDYWUeD54Baog9cPqvRV0zphKgZBKG9K5+9nrMcc009tVkotBUXKMchPPyUY+yudLhb0b5RGuQceXdkHYYBdh5T5wwTzVp6e+Ruo8ldhymGxN9+uBrzy5Ay/BvOW14GYsxKnoZVcn2+OfGfpmo11RgjG0wyiU19Y08FeOdUWFaZ1E0PxQU91aituaIR1gLNS9Bt579Yi1LpbSQXdV4HySSJuhDwfKw/n+Yk1fdYsIToucV/EolIhTTbWfg/WL/AlReJXYSquc2oFsIcEGm+7s+3ZA07OfdHKNOaCG2efCCs573xC0fTXrUBqtX5R+abL6FVBlLtSOZ4UjhB73g06BBSe41lNQU8UtP82enIyjKL7i5sSKbw59CLFV3mhFewKxBBjw3gSctcRtJ77uBjgW03VaawglrGJimp4CipKPEsyXc1y3r9pg8yNN9CBJ4y9h7Yu4lwMRDUB1MTxBZf2RAIXtdFf+70t9vDo4HvQ27sL4K1iOrqxbs1PzyCReWiKtdiKGdUsSpCWlXhYCEea+1h7+Arsb9cVHP4EiIZp9aXI/PCWL+7iyfCctPX+f8zRK7gRuKJAKuqbnwsgmJxwLFvsuDf2khrEE39sQl6IAvMcBFx5Z+qXmEzZdMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(6706004)(956004)(8936002)(186003)(478600001)(6666004)(36756003)(8676002)(6486002)(316002)(966005)(83380400001)(86362001)(31696002)(26005)(16526019)(2906002)(31686004)(5660300002)(2616005)(66476007)(66556008)(52116002)(66946007)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3Nkrqqe58Q8Hvvgg+CDgjRJVobEJG4JhmWOLtL//dhAzHVpCX4wpbBDlsADI?=
 =?us-ascii?Q?qVK4A4hdKt2Srv1riafFk4/pWil5dM+m0R4wFAcGiSasHrxuGfyrthsH24eA?=
 =?us-ascii?Q?GndiFQtMoi60q41ZUJK04qC3JCGV1XU3RWjrASL5/31FYZvdK3YzD0KAEk8F?=
 =?us-ascii?Q?h13WuFdtXSWeAQuWsfEiWNKy1L0gaRhC2ZXxcYoAp+tGJck6padF3MpUg3IQ?=
 =?us-ascii?Q?LYPcHDWjwfTR64M2BG++z2XpLPdqwAs4HShb2EesmiEI/M/Rvsba7as4WDhT?=
 =?us-ascii?Q?9zZUBaixA2gMakU6bM0iTDuUdQ8hpqJp2Q729vpgXZu0Wg69NvTss+tuRB0f?=
 =?us-ascii?Q?0aHWZkzK3BcX+rXn6CmdfA9hCL2R06huAwtLcyeVTsfUYAyo2Cl6BD9g8eKp?=
 =?us-ascii?Q?66I9chfI+hqoITGtGCu4DqfBhGGJWtYh7ekEG21pqX0fa3aw1ZjEgcesuDQP?=
 =?us-ascii?Q?BNxrSzyh3BmiitSUzx9rY0n3VoQlBNEdc7k5TZVvLIsLXWTpDWXgb1UUOFxS?=
 =?us-ascii?Q?VesTtV/TrSffJtASqxsW8TgrOJcswcjT+6Mon6bQm+5tkgKN0pXIQ8aApy65?=
 =?us-ascii?Q?8xIR3vV+oOVATwaNEWsc74UOv9VF4gYXK2wcEvZzQ3O5KNOFfBZNmjfXZA/a?=
 =?us-ascii?Q?71vMEzPL5FbnoGQBxz0XEWCNL3mpDGOxu02iKj/OdKekdA5hYgrPUPcBsfZ6?=
 =?us-ascii?Q?ebG7/jsJoRBrBeJ2iJ5mnWJrncIBW8TkpjkzGayguXcd8ESjPhbj4dIGEYC6?=
 =?us-ascii?Q?teQdUZhM4qGPKTJV8MxistjQb9oMz3wquxslk2F4hML09zz6G7Jz9JKftLUS?=
 =?us-ascii?Q?/ahmOsNohe7WLb5OizbkPtiNRgWkI7ZCplgH2ZAMeBPbfnwVVMKGFGcM9xyK?=
 =?us-ascii?Q?63oAi5okfBOdhshThsNJje/M0DFWnE79kVUrUVDQDS6xycPnmLiIH77JmBKD?=
 =?us-ascii?Q?//EZ3sf7wPomlS5L+4oWIMT0LPNkdVFITrhth2tmHnrMTYsQXNKg/Nf5bzQp?=
 =?us-ascii?Q?5Nn4c8MULiyCa04A8BCQk2nH49eQBfPL3mT1U/95dPprdi6L9CdAKvCBuRpk?=
 =?us-ascii?Q?NbbJvxj6LR7mcloTLs5HR3So16qmoqVPrtxfF0zT17ngYjqnw/3gl9+/4Ggr?=
 =?us-ascii?Q?dwaSmfeINmQJHcJIUd5Mu6z6r0zUTK5yB1SgkDlzIUVneb7HAYBnrbp36qRN?=
 =?us-ascii?Q?H8b0jrxuc521olCb/3Fgu+if2E+V2vopHR974rk21YMn9hftRgycbKo6/spC?=
 =?us-ascii?Q?AcLdQ1b2zHF1jKMnNo2NgbSTrwU878BXu5usrLjo631kxUgB+W6r3SpLCKEa?=
 =?us-ascii?Q?A5+ao5cb7as+uDaoEUh4miyL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393ccc90-e4e8-459f-a51d-08d8dd10bb9a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 00:18:41.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogcEpwkHEfBAdBYyuun1N/rOcqBZH69Co51flPKSkTN+D5qo1HKr0jrLjeIL5pd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/2 =E4=B8=8A=E5=8D=8812:30, David Sterba wrote:
> On Mon, Feb 22, 2021 at 02:33:45PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from the following github repo, along with
>> the full subpage RW support:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> This patchset is for metadata read write support.
>>
>> [TEST]
>> Since the data write path is not included in this patchset, we can't
>> really test it, but during the lunar new year vocation, I have tested
>> the full RW patchset with "fstresss -n 10000 -p2" on my Aarch64 board.
>>
>> And the full RW patchset survives without any crash for a full week.
>>
>> There is only one remaining bug exposed during the test, that we have
>> random data checksum mismatch, which is still under investigation.
>>
>> But the metadata part should be OK for submission.
>>
>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>> The metadata part in fact has more new code than data part, as it has
>> some different behaviors compared to the regular sector size handling:
>>
>> - No more page locking
>>    Now metadata read/write relies on extent io tree locking, other than
>>    page locking.
>>    This is to allow behaviors like read lock one eb while also try to
>>    read lock another eb in the same page.
>>    We can't rely on page lock as now we have multiple extent buffers in
>>    the same page.
>>
>> - Page status update
>>    Now we use subpage wrappers to handle page status update.
>>
>> - How to submit dirty extent buffers
>>    Instead of just grabbing extent buffer from page::private, we need to
>>    iterate all dirty extent buffers in the page and submit them.
>>
>> Qu Wenruo (12):
>>    btrfs: subpage: introduce helper for subpage dirty status
>>    btrfs: subpage: introduce helper for subpage writeback status
>>    btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check
>>      on subpage metadata
>>    btrfs: disk-io: support subpage metadata csum calculation at write
>>      time
>>    btrfs: extent_io: make alloc_extent_buffer() check subpage dirty
>>      bitmap
>>    btrfs: extent_io: make the page uptodate assert check to handle
>>      subpage
>>    btrfs: extent_io: make set/clear_extent_buffer_dirty() to support
>>      subpage sized metadata
>>    btrfs: extent_io: make set_btree_ioerr() accept extent buffer and
>>      handle subpage metadata
>>    btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
>>    btrfs: extent_io: introduce write_one_subpage_eb() function
>>    btrfs: extent_io: make lock_extent_buffer_for_io() to support subpage
>>      metadata
>>    btrfs: extent_io: introduce submit_eb_subpage() to submit a subpage
>>      metadata page
>=20
> Please don't use "extent_io" nor "disk-io" in subjects.
>=20
Oh, those patches are too old before the naming schema change.

I should recheck all the checklist on them.

Thanks,
Qu

