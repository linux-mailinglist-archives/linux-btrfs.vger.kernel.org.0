Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F15534AFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiEZHwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiEZHwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 03:52:19 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3E2ACF
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653551536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4umrNi3PYClpyiwEzug2baHlguv7DWJr/axbxQLL7qs=;
        b=ZRSEWIBUDwJBTlk86uHRYDveaLGOjhMQubMJV+NdFh+TUb1zy32mWEPH0ubMY2PNewr6OY
        kjh6VFMasJwKCyjPzSkYEAXQi0XZ5aYtrG2QPmhKa6pcuRYTEajX12I5OSg6KvCeJwhOsz
        Z5A+RYdWsy6klJ7E9S1hat6wqDGTAx8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-P_22bVBhMBiab1CGbsmTAA-1; Thu, 26 May 2022 09:52:13 +0200
X-MC-Unique: P_22bVBhMBiab1CGbsmTAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVm/cS0UZsGgvzQyvR1Cb5A2a2rsniwCylod7ItrffRsEsm66+aE5PZCAiRlycVzBMU+Y5sEYwlCiNXHvhc/j7X8R60+PhW0lCpy9MZnMCXGxqyBr1dc/QqJHjj5A55g8DQ6oNU+5NCAXi34pV9KgTsGCd16Zjgnhn7YmGWZxNQmAvtEfuA4zoEj8KVsF0FboqC0x0m1xxcDFiV45kCM6sWB/2imzCSBfZ+Aoe/bQkKSUoOcK0p/93zHDfWKqg6UFhuuVZqKvyYVWtOeqN4IXk0hDG/s7N8fr2BIg0QRbXufWlsYqBuhNcSFqId97Lve6MPJZmL9vmyM1CHPB27WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4umrNi3PYClpyiwEzug2baHlguv7DWJr/axbxQLL7qs=;
 b=g9La+8E+ziWGcCtejfAWI4OfbW+BJEEMxyxCBDBWk+eYT5Izv3LHbJJ3gXoeboKjasi6WFPJ55Bd94Hcsg3DBx38hRzbELZpkEoi2kZCtQRwflGU0+FanD8tjuRsh9qppQxiBkCdC6Hw73wSgPAMQSgLi6UIB58RCzkTk8pWwGAYJby3U8kPOWUm7E5YDHcKK2l/GDAhIMAMu5cHVJ2+Iny+R9vE7C7W1Y0K7MK5oCqKWh/ZmEv4vqq0z5EaYHQRGUeETjM3kCoYhEVbp9+UHqO3QsWRG6/alZVetxpgdFy1Z+CiCW5bKZ8E74oyXjX3pI0gpMA5Suz5jNgLZKxRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 07:52:12 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 07:52:12 +0000
Message-ID: <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
Date:   Thu, 26 May 2022 15:52:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1653476251.git.wqu@suse.com>
 <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
 <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
 <20220526073022.GA25511@lst.de>
 <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
 <20220526074536.GA25911@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220526074536.GA25911@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f29c604-05cf-4862-3d8b-08da3eeca45c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7721:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB7721233F556047A8788BC9F2D6D99@DBBPR04MB7721.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmcWdy4lIpL7xPPdAYYG0/J9g3Bad9rz/IbW5SCIs24CuRIZzxR523mJREKymqOs4nQ1JzkgvAfhzTtoMeI5I+sTNIH/ogM98DnickZEGvaC9uf71a5/IRbHK63u09YIt0I12sQEUQ7cZZQuaRJUZP1u9q/mrBu/JxGgTAyVeNHgfH4llNmDE4srvv45mk0TiZPcvo9iBwvwPtup1vTmPwoXE2TiLDaCpy6mOhRRgTRE4NcxaBjjh9ulpO2kbP8p9FIK24IwcVWuL0TzQlWmoaIHomqM+XSK2MLqvWkYI3pSSZ7IOaM/ZFCXxWbTP7ueYQFAzQSJ8+8r3Gio0994GNroCSy4eQVmx0kHgKqAtjzz070uoc1liAHcPHPldTrCvmQja8pZTtNWxHtS5JaieQ9puLTvCjRJzKC8tsVUrq5Dzch9i74Q7lNEWhrfwgEZfrD8FiDKMbu0nI67TnZMN7v+a62lKz9UgsXHinNR2fDFN2ayhMMKV0RWKJXBAlV9eqGitQ/U8nvccsC/NpIozZw2XS6jj4Q+7q49P6eGniftOQ9HWYEQjR6wBlXc/yG7XsUKlHCg6ShBMzAGmaC1/+swWlH/OEQ1UMAw/SeOCu38RR91sQqt8Z+8wIHeT5Vm+lLJMtWT4umqD9i1M7m9RUy5jypc+dhGl89/XAS5cC2pglg0oKZ81JHzs6MknG8/K6mbD+OMRQcwiUkNv/pypDqvd/M/W03NoSoURbfOmH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(316002)(31696002)(53546011)(86362001)(6512007)(6486002)(6666004)(31686004)(4326008)(66946007)(8676002)(66556008)(508600001)(66476007)(2906002)(6506007)(38100700002)(186003)(8936002)(110136005)(2616005)(4744005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlTVGZLNHBieFdDTkJEZFhPWGlkNnVzR1c0b01HNW51SDlNRDNYQ0xPRWV5?=
 =?utf-8?B?b2JHRGM1NlloSUl5UC9yRkV4bm9KRzVYZkJIQnoybXowcVpUWHR6d29IY2c1?=
 =?utf-8?B?YityTVkrbUFKbWpZajd0SnFNNGlEOE9ZbDNURjIrbGhkck0wdUM3YzBsMFZz?=
 =?utf-8?B?QS9LVUZGMlc2QzcySDUwQTMvUlZUSTBERDdyRHAvSFZwYlJOK3BwcWZsT1J0?=
 =?utf-8?B?dG9mZUZjbUpGb20xaldzWmlSZEFXMXBDZml4NEt6NnBTZVpSR3YxNm9KNlJU?=
 =?utf-8?B?dmovSGN3T2xVV0RQdFhwaVVoT1VqcTYxWXkzQzBPVnVvd3cwUm92RDFNQ2tl?=
 =?utf-8?B?WVgyZElwRG9hMVZ0TVBnTjczSDluVlluOEw3VVdnTE90ZndlMWVGMEVCQ2ZI?=
 =?utf-8?B?VHMwZW5nYUoySjNsMHI1a28rWktleEFZSzRCdWV3N0k1blhmVHR1Q3J0OU8x?=
 =?utf-8?B?R2JEWFlEczRqd2NTWTFXbVFaNkdnaytqNUtFc042NjV3RjJlYXNNb1dJVy9G?=
 =?utf-8?B?UEdOQm5MUFJ1K1V3TXlGTjFpLzVDSHJYNGh1dy9ndlJUUXM4aHMyTjJpeVFK?=
 =?utf-8?B?eDY5QitwMm1VdCtIYlRPWW9VTFNQZWMzUXVWRDYycElSeldhZml5YjZjS1NR?=
 =?utf-8?B?VWhHWnBjelVlREszYVNjRDNOODdpVVh5MDlScEhNdCsxNE1QeGxhMmwycVFr?=
 =?utf-8?B?RzBsazhMWm5raUJKemg5TVF4eU1Ebi9rUFVWK3E5bmFDcHlxVU43QkRQbDBt?=
 =?utf-8?B?ZlpOeWtxK252ZTgzUEtaWEVlc09YWWxxRjc2ckhpTXcreitQUm5yd1ljcVhJ?=
 =?utf-8?B?cWV4Nys2RnZXaVoxVFpiYkV6NnVkVFNNc3VJMnVIYlBvV1RwQkFxZkZVTzZo?=
 =?utf-8?B?YU5lZ0RmWGRLNnMzSDI2bndTdDB6cis3bFMySVZndERsQWZFTlZ5ajVFYmwr?=
 =?utf-8?B?Vy9nWVNSb3RYTGlVVkpEdTNlMXFqTUR0WGFndnhJZE5qWmVQQXdlUlhmVEF5?=
 =?utf-8?B?UDdpV0JtcCs4WCtqTjVMa0x1cWlHRGJDSzg3QVJXeE9LcEZ2V2wvM25uQ25E?=
 =?utf-8?B?VmFSc3MraXdpdjRybVQ4aUJHc2o1dGVOeW8vd0Y5ckVNaVhiTFhSMVVWRFZP?=
 =?utf-8?B?U28yZWdWZFF4UjNlNFdHcVhITk1Sc1J3dnF5R2paWFhPaWhpbk45WjFFSmt5?=
 =?utf-8?B?QzlicWNHVit1ZlBTaGp2eGRYUjhDMkRFQ1MxOHFRZzE0TXFFV1VWeEp4N1o4?=
 =?utf-8?B?SGp0M1N4dnFjK1pQekliOS9yR0swVzBrU1NXazZZNUxvMS9pWEY1K25CcmFM?=
 =?utf-8?B?c2NLc1EvN3RlK1ZPbUR6SlptbWxhckVnWmVnV1JXeTl3L1JuTkxHeHhqYzRI?=
 =?utf-8?B?bnQydWdERjdOeUh2WUdleDQ2L2tPUWtQejdPWHNwSEtPck51UW5pdisvVURR?=
 =?utf-8?B?cTluZ0NpSWQ5U1R5QUkwMW0vMi9WRVR4STF6TWNZbW1rcGdlQWFpQTFrVlFw?=
 =?utf-8?B?WlpaUnYxTUo2enZiUVJsNFFobnRML091bndyTXV2WTNFbk85ZGJ0ZXJ0bHBu?=
 =?utf-8?B?ZHZTZFVvbTZmSi9lcUQ1eGNHRTBmbkZzN0d2d0gwTytwN09MN0NqSGlHeE5i?=
 =?utf-8?B?TkYvcHFlYS9hbVA0MkZRVVd2L01YQVJQbGVZSzE5aU5BQVEveEhFTGUwbTJ4?=
 =?utf-8?B?ckRzeDgxN3l5WkZNMFd0Z3dGQW1tMDdGbkRJNWV6elFQVVJjZHloUzNMWDhK?=
 =?utf-8?B?anJ4Z0JJWTJzZGJzM3Z5MGNFb1RteG1MY3BUWUdiaHZlWkFLZVlOaEgycHNk?=
 =?utf-8?B?RnNIM3RsczlsVUFlTDJaTXlZSXZ5cFZjN1NOWFFLK3BYR3gxbDEyd2MxWUpl?=
 =?utf-8?B?WTVlYmZWSXcya2VIU29XTm15aWl6UHBzRURUQWExS1JSaVpHSkxtRnpWcEVW?=
 =?utf-8?B?L0R2cU9hZXIvSEtnRkp6MVZFSmlGaTNiUllYMWZSemRnVXVxdnZ2d3RKa1ZI?=
 =?utf-8?B?OWNqa0ttbHArTjJIYjY1S1ZxT3dsV1NDVFcxdVZPWHpPNDErTjIrcDFOb2ly?=
 =?utf-8?B?OU5ZWFYvS1ZOUXg4UVFWeWViOGlCOEZmZXp3bjhmbGZkMzhyM09xMldSblQ2?=
 =?utf-8?B?RkMrVEs4S3RZK2ZQNkU1UFRoLzFFaSt1a1V5aFlKc0FmUllCdFJZK2tLL2ZQ?=
 =?utf-8?B?U081YnQrb3ZzZWJzM0xhaTE3VUhIUmY1UktFTTkrQnFYTzJnczBUZ3FCbXJk?=
 =?utf-8?B?Zm1XZVJaVmlGbVljS1pvNDFTc3Bha3NlWCtWREY2dFQ0OGtYSkU3MGZ4V0NG?=
 =?utf-8?B?cVJrZzBiSjQxTURSZlVLYUNlcks3cTJFdXBPN3B4L3FXRnNTVFZJdzY3K1g0?=
 =?utf-8?Q?eME0TF4pYLJU/Tm3rhbEF5zDavFIjaOK87E6J?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f29c604-05cf-4862-3d8b-08da3eeca45c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 07:52:12.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDMzGQCt5Vsae5Hv2b+5/a+A5iW1wub4xSCIddUrSF1c3Mz97ypS6UlcJxryoCOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 15:45, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 03:37:47PM +0800, Qu Wenruo wrote:
>> Rare case doesn't mean it won't happen.
>>
>> We still need to address it anyway.
> 
> address != build overly complicated code to optimize for it
> 
Well, using seemly simple code, but can lead to read way more loops and 
way more data to read, is neither a good way.

