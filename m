Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02376BAA82
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 09:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjCOILt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCOILo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 04:11:44 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5394265AC
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 01:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiIfcuHQ5qcFkjqbUcb55HA3ItjvkGfXlOkWXu1Sdz6Vrzorq+nqGWAY7O1W37P+6aCS3H9j5e9Y1sT4abT5rfYyNdW1YAEN9COwJeBfNX+I56gn51NugwjVu/4orvsb+bRPCcvJnl2xvMVnwoVQLqU2Hr7+6ZlE3Dmmj5Cwzvwwz8qbcYKQsYbqFRN88UoR1OfqgxFViWL1WE9lIKSovgUIx6JJoRdQp8U/qtA3ZzGguRDVWRTGTvWpMUo5jRw84jDCeYlgUY5s3DKzRGgm4lPD6zmJ4RbZ5DHKpBQvYONQUho/knHbO5f00vT5dYboj5rYBFgxmb/e8Os9ALsCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoqvKqfc4Nv82H3bjcQpcFdXvfcbv/sOUrS/A6TeiKQ=;
 b=OTMLAFrdWYvPgGFEI6i36uxskt3ja2VPHe2t3tOjzIC/zwkcTU0oBxDb6UoKRDGeM8uAqRa/p2HluF1o/DzY7GoGIZ9qsmEI0hTxvqoc5hB5mgBK/22VWfqYshSV3KxhiBw7VOZLODcBOHusNsZ+K7En121wQLLF+jt7dTFSjtUckLd37zjFQ0TjUhyLPhVzgNq2yo7NAjzmlfBosOe0+zemQxcxt4eHbUz4X/OXYdUdyFRZkMgu8YFnMFPQp045BcvMPcrKW6RvsMLe9fm9vbym22J9pCgCLewMBPjcexZa7/VtaaEDLbZkldh7KvkBbZqWrUeIbDr66lWa2CjslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoqvKqfc4Nv82H3bjcQpcFdXvfcbv/sOUrS/A6TeiKQ=;
 b=wvxTkjo8dlc2vlOAMXz9/T4n6iud/ZyO9Y4Xf7fQ7ZVmxi7Dm6CgAaIHna5jMkuQhyI8dNWN9iYbC78wYUWbFwo2cH9jMEpiS5nlovcuFOnphZWUU08uAx7QmPfSnHVQx0/yt8AoP2OPU9tgG6NNMOYu0n2Y1/wSkJBVBY+8PDevV7OhWA2IgyrKcGsoaUr1pQFFNhQf9q1JJs8DNyUX/SIQC4Pi9zTtZeg3jt/mfEfdQ2uyZVU5/HPOqqumoCMo4rdE5FIpO+sTeS1e1qcgs9aD0g1b44TevYXat8WRFFD3NnnVRlMD3q9T7bkC6pY7euXLPqVMe+ilm7IEo09E8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB6925.eurprd04.prod.outlook.com (2603:10a6:803:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 08:11:39 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 08:11:38 +0000
Message-ID: <480aa54d-d752-5b1f-e0d3-9fb2bbc5db88@suse.com>
Date:   Wed, 15 Mar 2023 16:11:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <ZBF5M5R3pDdp/075@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
In-Reply-To: <ZBF5M5R3pDdp/075@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0307de96-f4f7-43ec-4faa-08db252ce6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YK01Kj1aFyh6knsKVemXX0oIt8dTUBUceEpVlVxyWCVtzd/0QAeWzIjA/4iojaWupwVRXQnaeOA4Z7S4OUJ3ObVzPt4/ptPOzM6g3Jdfq4wtWiuF+VvIPZtf9ObAH5yqptMCsdJVP7I/E/aXcYgoAM6K6wFueAlI7T6r3ey4fsj+ucJ0FL1sBAj/pc/I/Dsmyvci8No4F1oBVzimPYuCeSDLg1Bbeejh8/pPP2n/7c41sOC3FShS/3JFxmsTNVIk9jLkWZQzG11RDgYbjFdJ1bA4uGx626iqrHU8hUf7BB7fKkl02W3eiEcC6vKQF5k6VlTAlpukp+sHFV8jNGKMQuax8246Cr6lZ6fIpr0pVgMzudr7ySnjaDYQT26VLXTpVabNmDiGYX/OeHSQJDmwvn+BMjwPRMPOfYxticQMCTQMaMCwYutujCw87hP+VoPDC6GddPwENQfD4wi4TWL83OV7G6J3ioIEU4JRMrWrdwbDu97vn+SCh5QPktUpWe0HRDmXmFyDXfIs/LbkwMTHh/lm+sBre/IUXHAJnIbjzdYTTv0TLQDHEfzp/DCGZFp15RZEI6RXjRD8Bl2dlD3EuffU8asHbQGG5Db7i9H6CWKAv+5Qa2g8gXnW5b6OeZtD39EXpmlOKZSQtUm3AZxfP9o9P6UAT0mKedWcyYYpP0KNSd+VTast3262XTdY6NSDo50sR/CEufINE+ht9OhxDaNGuAMAeekA6rN6QnVNuEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39850400004)(366004)(136003)(451199018)(5660300002)(8936002)(36756003)(8676002)(478600001)(6512007)(6486002)(6666004)(6506007)(53546011)(66476007)(2616005)(4326008)(31696002)(186003)(41300700001)(38100700002)(6916009)(66946007)(86362001)(316002)(66556008)(31686004)(2906002)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2x5R0lxb3R3Y0M3TlZwUFZLVE41WHZ4amUwS0R3YjlIV2YvRE0rYzhZWTln?=
 =?utf-8?B?bG0zd3ZuTkFtNi8zYStWWFkvY3lTOUhucXBDbmFDMzFXYlFVbWJQQ3BYemgv?=
 =?utf-8?B?dDJQSGwzMGJnSUR1MytLVFpiZ01xZzlFVGFXeVZJczRPeU0xcE03KzhwVWVw?=
 =?utf-8?B?T3h5enAzYlpGU1htalNmajJiemRyUEczRjU5SlJKMTB2UUgxODVmSXAxTHNv?=
 =?utf-8?B?MXV2WTRiSzR5Um1nRnNIckduUXpDR2VLelZjZXB1ZkJRbmhxZkNsTDFSblJy?=
 =?utf-8?B?dHVydkdkaS9wRW5JQk5ML0lCU2NwYlpFamRBSG5LR0ZIczlOS0RMQ1VWeVpE?=
 =?utf-8?B?SzFnY0lqbmtIdjFKUWYzMWxFMnlyZlpBaTVxTFJzb2poQ2JxNUg0UlM5YUZT?=
 =?utf-8?B?TjJ2czNzT3l0Rk5jYW1CR1pWYmNIaGtmTm52VjN0WTJITUp3Q2pNanl4MUpa?=
 =?utf-8?B?bHZ2dzdFTFhsNW55UFFYZmpVQ0J3WkNNbFNQQUJ6MFJJbTdld3NKQXRpK24y?=
 =?utf-8?B?K0RRYWFDWnRTOWdQVk9IdTVaanF2amxUUExPV3ZPazlOb2N6bTNRT1g0RXhV?=
 =?utf-8?B?SmpYSkxLZFlWZTFQRDJmMEZiMWlyRXNoTHlOSTJvMnRkaSswMHhFUG55bWV2?=
 =?utf-8?B?aUpmMGxaQ0E4eGlLNklrNWhKanpvU1lMMVpPNlFYcFhFY2U3SXh3ZzZaK2o4?=
 =?utf-8?B?czBiR3dtSVJNK0NIK25PN2x3NVJYNFZuNElObmlKNERGeEtqK2ZVcnhubHJH?=
 =?utf-8?B?WnRWYXpjNmlqVTNFcnJOTFJmWTFPQVdWVVNJYlhVN2pLTVVKQmJYTUxQcjJa?=
 =?utf-8?B?OEQ1dXZmR2g0OG5zZlMzTWgzY25FVjBPVE9aeDZLUE41a1NRQ25vNTRGUjht?=
 =?utf-8?B?eGhSYWdtTTF4c3pKREZrK2dkUVpEQUM4dmluV09oWktzL2xRSmNDUFBSeHJQ?=
 =?utf-8?B?N2kybDNjeEUzZzZCTm1kK3Jxeno5alBDVGNiV041RXZqbERnbFFOSHhTZnJS?=
 =?utf-8?B?UjA3Ky9TQzJROVBpbWc5cjVkcXlTT2RuUzQ1N2VKNW5zakQwSitrTDlKcEhW?=
 =?utf-8?B?eklwNUJHcjVFbGRGYjQ3aXdHUDM2RWFRRGFQSWxXZVNDOU9tQmxTcTVPMEQv?=
 =?utf-8?B?Y2lEL1JDZHZxMThvaGZGN3BiQjQydHdBZm55dm1Kb25HeFF2RzlDNW55ZnUz?=
 =?utf-8?B?QUpQZzBhMjZLWW5JYXMzQmhoM1BNWXpqOU9ZREIzSStCTVc3b2FnazE4MXg2?=
 =?utf-8?B?bGgxMWwvcVk2c0M1d0c2YXlqL2lNZC9KQ3lNM0VBa044VXJDOVYwL3ZIU3V6?=
 =?utf-8?B?QW9EcEQrYVVvWWpHNGJZZndaNkhJOWZweVU4MTY4Z2hoTnBTMVVrZGhFOVB4?=
 =?utf-8?B?Ulp6ZUVtNVpTT1NEdDJWeFNhNXp0d011TUhwVmZ1ZU9ZYU01WGdITk9ZazNN?=
 =?utf-8?B?WVA3bExnZGEwYUx4dDNmeU9VQm1BdnZhU0xlYXJTOUR2TGF5KzJubFpDaDhG?=
 =?utf-8?B?SDNMNFJBZ1R6ZFc0dnJVeFJqanMrV29hNTZYUkYyQnlDY1hhd0ZKQVNkYlo3?=
 =?utf-8?B?UW9JQ2I4bnoyUnJyNUFSV2o4WTVTRGhPUi81QjQ2cE94bkpiZFhPTjFMS29w?=
 =?utf-8?B?UlFwT09BM1M3cU1SLzR5UVVsdGlDWFp4VnZvdHF2MXRNbUJWZjlvUTFpcjY2?=
 =?utf-8?B?dG1POUViUCtOTzVQOGFCUjZ1eFJqWTVhMW95ajBmcUN4bVA3Z3NXeDk0WWZt?=
 =?utf-8?B?QmZGVEZjTXpnRW9PQS9Jcmpta0lBbllKa3JtV1paU2pMNUdYMlUwMEJBUXdl?=
 =?utf-8?B?UnJqNHRlbUg2clRzM1c0dFZVMnZLazU4SkVjYkNycktZVGZhbUdab3F3OWtz?=
 =?utf-8?B?b3FxTmhVNlJ0ekR3bDFmS2paN2xNM0srWmVHT2E1enJvSEFKK0IzOXJkVDIw?=
 =?utf-8?B?L1BhdGg4NllJNGhRdXhSN0p6STNMMDZvc3REa3Z5dys4SklDUktNTVhUcFRD?=
 =?utf-8?B?VlN1cTJpL2ZjTHNhWVFicVNiZ1dTbkt0VEtRUnNJR3pEZXhvdEtiVEphU0I3?=
 =?utf-8?B?djZaNEFtM1lRRnNETVE2TXVlSFpZTnRHcW95bjd2d2lyTDYvMnJDWEN6V1kz?=
 =?utf-8?B?Z1RaSTFXTHcxMGJUM0RiVE0zQU9XYW9zMFdoeWpMK3VrSXEyNGNNUzNBdlpr?=
 =?utf-8?Q?Xqg6wIZLhBGTmNPGGN7yblc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0307de96-f4f7-43ec-4faa-08db252ce6f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:11:38.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGR5GPPKQh9ag/oTW1RviUroZTRZZayH8r5gvxeRPjv1OZo/oVZ5JMrmrABwD5tI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 15:52, Christoph Hellwig wrote:
> On Tue, Mar 14, 2023 at 03:34:55PM +0800, Qu Wenruo wrote:
>> - More cleanup on RAID56 path
>>    Now RAID56 still uses some old facility, resulting things like
>>    scrub_sector and scrub_bio can not be fully cleaned up.
> 
> I think converting the raid path is something that should be done
> before merging the series, instead of leaving the parallel
> infrastructure in.

The RAID56 scrub path is indeed a little messy, but I'm not sure what's 
the better way to clean it up.

For now, if it's a data stripe, it's already using the 
scrub_simple_mirror(), so that's not a big deal.

The problem is in scrub_raid56_data_stripes_for_parity(), which is doing 
the same data stripes scrubbing, but with a slightly different behavior 
dedicated for parity.

My current plan is, go with scrub_stripe for the low hanging fruit 
(everything except P/Q scrub, perf and readability improvement).

Then convert the remaining RAID56 code to the scrub_stripe facility.

The conversion itself maybe even larger than this patchset, although 
most of the change would be just dropping the old facility.


So for now, I prefer to perfect the scrub_stripe for the low hanging 
fruits first, leaving the days of the old facility counted, then do a 
proper final conversion.

Thanks,
Qu
