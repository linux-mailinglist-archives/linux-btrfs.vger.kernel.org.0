Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301BC265D7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgIKKNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 06:13:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:35616 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgIKKNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 06:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599819224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2Oru8GU6OEjubGRH1uQdPFyBNLvJDVWuDeYVBSGXPY=;
        b=HBZpFSPQrthNQKPsO055VcAnemWHAIPbPOf57Nl44R2zPpLwNyHEuTkJbEW5f3bHQlmcKR
        a1BdgajKSOWRkbtsF0TYMfACdetZUdqmAROIs77EzFBPSQ2Nx9rIbwQEFoLSuqlxhYp9Gs
        i1T2ml/ukfFTTLPAFR1vq1Y7Pi9+BPI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-pzZbawv1MmSVriCYQv9FGw-2; Fri, 11 Sep 2020 12:13:43 +0200
X-MC-Unique: pzZbawv1MmSVriCYQv9FGw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaUwDK2OnkrioDLqbF3o4lLX6mbBJ2vahUCFDjOTc4RL09KEaojU5uf8v7hy3nW/qbkWe6FTQ65Nn63KyouqGIgUITgwe+DaWtOkyslADd8mQuae4LtO6l9tqwNsHC9QDe42DIgCxktYz8B4o26OXTvujSf2hdFHcMGxK/K72IKKPn5pC4MUEraQGGIPx5f//yjwRr6DyU1A0cFb7uC6rm6HLalMh1eX6MdwukZFGhP2OQpCrBZM8tDPJ0uGikCs0VeFHVlwX7RaxRZu0HYOFM4TsV+PMSYPPYOSxqB+1xXCm+SYT7N89LD69/6OEmVWSJd9JhE/+DhUSrII935c6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zrNEfE/8C0k6m3upbGdSoY18azS/u2AFVgto2FImSQ=;
 b=agTfANXydaDIOT456yTthJK+aH8un2izMMWzHN41jGQMNlo1kHgi3zz7ZUdp1JBbG5wx1GluQNFAa2WsE9EPOC1KeZI/sL3Oltlc/5Q6iJD+9zI9JSTJa23K1119wMASam9FmaNJCVZkyyyyCzEtZW2+v08IwrmCW6WtVOBAPugrHPJ6rSRVAnVajLUxiUoHeLyO5FDoliX2D1TmNoYov/FVtnYla0sMsnKlB2+2LqjB/dU+e+w6HJk88s57r2u9ZkovPxFWf67nXdj0CFJ/QcNm+uU4kTFcMrPUPhhC4VifaL51gq1huCpZZqGCSEi//ci/QNXautCeF1bbgSqHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 10:13:39 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 10:13:39 +0000
Subject: Re: [PATCH 02/17] btrfs: calculate inline extent buffer page size
 based on page size
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-3-wqu@suse.com>
 <9bc8bd10-dc66-3215-1ef2-b5df3cd00883@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <412ce381-bb2a-ffd1-cb93-339ded4f44f7@suse.com>
Date:   Fri, 11 Sep 2020 18:13:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <9bc8bd10-dc66-3215-1ef2-b5df3cd00883@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 10:13:38 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0418d896-ce7a-4c10-40fb-08d8563b5a9f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7236:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB723604A4783F54E2F278222AD6240@AM8PR04MB7236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjiI3BYwdvrGSkShEwcsPCDUwvjrq6mhkVASmG0MGpvg8lu35cs2PzbEo63anACFGAPfPuEVkF/bw2MXg5XdZ3L+eDRsq2ig4KPjOavz9tTC5pCid9z3w9IjCPKTd6KF0I6LZikfa2202X3JOJLpUf2pGHIZsTC59m3QqlF25OvGDPZC9CUqXc1mVaBhxkB9cpu0DJOvcQAfgy+7NUu2SFFb8OUSUpz8TNN4q+96z0WLHwRMuFnUX3OYT2UiKp/phF9rEl4zszA/M8Ck3uYUOZBNk9tB74xPYShUxolM9XHhKriHwOnwtg04d3zqUXlwoFTLhCok0Si1LEC+mMoziRqCJEVkgwFbuHPiY2HhTfVVyyf5qN1vSS1xUspesKWyaYdDH1Z3YhtH20eWn+Jp9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(6666004)(8936002)(186003)(956004)(2616005)(16526019)(83380400001)(8676002)(478600001)(6486002)(316002)(6706004)(16576012)(52116002)(26005)(66556008)(5660300002)(66946007)(2906002)(36756003)(31696002)(86362001)(66476007)(31686004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TFky/l2tfnYuSTjdR6NH5IHQRQX6FsMrq20yKGIW8e5a3p0+XK9JrnqWZDMeXD/o9ue+iu+4/aiew9S5hgruTKLj+jTj80sk30iR+Gugt6mFgHzzJ8nWd7UdHIdPexEJHo/s3DoVLVpOCuNX2LaZTjnEXAm3OMJZTSTw+B5ad17Dxcu0DuKyc4t86RhLNXz7cyf1UMc6GNJD2wti9+5Akj+YLgIfciU/A/OPe9nH9RqcfX8dj9KCvwDBkGSIv+z4ZE8ct65aR5yYR3mFahPrLArXkOFHignl4jWvdpAUxr23U1k2m74dTurOiWn0R7TRECCyDslGbm7EZtPP1dP2YkZHParZoHtoc7HRnDGbEZ656U5ZxylMbNjucyK9X+MJj362tCeEULLQDWHkJU7qc/MILu/1qRotIOQZLHxK7rf3j+tiNJyq7CCD0ZSpaEmtMxISeUXF3+ETa0ICGVHoo7bGcb5m7VSXmcOZ4KU00fnBUW7DwprxBjXfxA3aaoMaWlHz1dTNPmpQ8n9KcotFChg9QY1Zq7nNuxLDh+/wYXtFFNV9gKWKwbF4DLThiY7xAjYL5F4/GbxdtERGO+iEv7VAmd5K5Kgy+u226vjK2HO5o4HYNUKFSR20w05XPjzXGcG4974PzvvZGRtINZ4HBA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0418d896-ce7a-4c10-40fb-08d8563b5a9f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 10:13:39.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccwz/ssUv5dXrG2Zp5tDN1QRgtksX9gMy2cwQhxYPJXUb7CXDnVZ+N8+yW7etPWd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/11 =E4=B8=8B=E5=8D=885:56, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> Btrfs only support 64K as max node size, thus for 4K page system, we
>> would have at most 16 pages for one extent buffer.
>>
>> But for 64K system, we only need and always need one page for extent
>> buffer.
>=20
> -EAMBIGIOUS. It should be "For a system using 64k pages we would really
> have have just a single page"
>=20
>> This stays true even for future subpage sized sector size support (as
>> long as extent buffer doesn't cross 64K boundary).
>>
>> So this patch will change how INLINE_EXTENT_BUFFER_PAGES is calculated.
>>
>> Instead of using fixed 16 pages, use (64K / PAGE_SIZE) as the result.
>> This should save some bytes for extent buffer structure for 64K
>> systems.
>=20
> I'd rephrase the whole changelog as something along the lines of :
>=20
> "Currently btrfs hardcodes the number of inline pages it uses to 16
> which in turn has an effect on MAX_INLINE_EXTENT_BUFFER_SIZE effectively
> defining the upper limit of the size of extent buffer. For systems using
> 4k pages this works out fine but on 64k page systems this results in
> unnecessary memory overhead. That's due to the fact
> BTRFS_MAX_METADATA_BLOCKSIZE is defined as 64k so having
> INLINE_EXTENT_BUFFER_PAGES set to 16 on a 64k system results in
> extent_buffer::pages being unnecessarily large since an eb can be mapped
> with just a single page but the pages array would be 16 entries large.

Really? Turning 3 small sentences into one paragraph without much
separation?

It doesn't improve the readability to me...

>=20
> Fix this by changing the way we calculate the size of the pages array by
> exploiting the fact an eb can't be larger than 64k so choosing enough
> pages to fit it"
>=20
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> This patch must be split into 2:
> 1. Changing the defines
> 2. Simplifying num_extent_pages

That's OK to do.

>=20
>> ---
>>  fs/btrfs/extent_io.h | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 00a88f2eb5ab..e16c5449ba48 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -86,8 +86,8 @@ struct extent_io_ops {
>>  };
>> =20
>> =20
>> -#define INLINE_EXTENT_BUFFER_PAGES 16
>> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAG=
E_SIZE)
>> +#define MAX_INLINE_EXTENT_BUFFER_SIZE 	SZ_64K
>> +#define INLINE_EXTENT_BUFFER_PAGES 	(MAX_INLINE_EXTENT_BUFFER_SIZE / PA=
GE_SIZE)
>=20
> Actually having the defines like that it makes no sense to keep
> MAX_INLINE_EXTENT_BUFFER_SIZE around since it has the same value as
> BTRFS_MAX_METADATA_BLOCKSIZE. So why not just remove
> MAX_INLINE_EXTENT_BUFFER_SIZE and use BTRFS_MAX_METADATA_BLOCKSIZE when
> calculating INLINE_EXTENT_BUFFER_PAGES.

That's indeed much better.

Thanks,
Qu

>=20
>=20
>>  struct extent_buffer {
>>  	u64 start;
>>  	unsigned long len;
>> @@ -227,8 +227,15 @@ void wait_on_extent_buffer_writeback(struct extent_=
buffer *eb);
>> =20
>>  static inline int num_extent_pages(const struct extent_buffer *eb)
>>  {
>> -	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
>> -	       (eb->start >> PAGE_SHIFT);
>> +	/*
>> +	 * For sectorsize =3D=3D PAGE_SIZE case, since eb is always aligned to
>> +	 * sectorsize, it's just (eb->len / PAGE_SIZE) >> PAGE_SHIFT.
>> +	 *
>> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
>> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.
>> +	 * So in that case we always got 1 page.
>> +	 */
>> +	return (round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT);
>>  }
>> =20
>>  static inline int extent_buffer_uptodate(const struct extent_buffer *eb=
)
>>
>=20

