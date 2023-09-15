Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5B7A1249
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjIOA07 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIOA06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:26:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFA2696;
        Thu, 14 Sep 2023 17:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt1EDQLKvcMoxWWDXP8ODlyTeJWtytZNAelCY51iRl1a8rt15ZlT0LgVn7QgP1hwu7x7XX3gbynueK0ALhhpCAhfED3t4iHKhRihiG5lgllQRP9iqcR0oiG5XAd1QGjHUjl2aJT8abb+5xcFJ1g7fVgcwdJNG44c9fYVaW/xU8mTknPygWCjQk0RVnkIFtYm58OpIrs96/jP9sG4PV1vQc/VLrLO1xW2HGGn5rF7TuUHKHCI8J7tuXQPRl8iyLPQP2gOYMeN7YVuYsReV1eBPU2XU0GzWrbigRtpVsIDTwZlmkBHP6cTcHeK9UbRXMzLYxMboW76WZs90GGYhTvtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baNx4wVD9QJDMZrIrX3VJAlPUR1FA9wQ2ErPjqnJJd4=;
 b=fnTZ5NCMZQCi5VrJUO9KuSMRiHRjDq19j8O+Sb2k8OtEI03x78ptV9ISpjvmxZFh4l9g3h7dmFY0TkGrf7VJxBqOWbhmM6nmiYZUqSgQyYhe9hpeYDhCUW7zyuPDcsL9mj4NcE7/sqrLT78OlFdEiTY3tRjLsA957OrogJS9RyaMRLpT/PGi8SXs3kz5341BSfQ0M9Qdxy66uMB+Y4tWbtMG0dVttVqA48fGqnBO84Fj+5uUTxfpWPW+iSkbaIsm1JWMujdnd6T9ZctvTNb5QlDOLQ96FFOXAQA04jPRLR1c/jr55tcicfWW3OXEeWYd5Ub85fQkcajqiHQyZhVXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baNx4wVD9QJDMZrIrX3VJAlPUR1FA9wQ2ErPjqnJJd4=;
 b=d11n3C0S8bOUFapbR9uYHuHLqcFTnxIe3VAI3lWVDkOxvaBTJOEPNdoGrZbRnFbmXLQwae/0Wz7phfixvHWcip3xEkmAZQjpuUCSU5o33EfJtME3FQjeFCoQSaUbSKf87Mll+LAx96RjuCLL/6SUiVsTjDu2vzYtDPoXH8vCnKDKWh3cOU2mKYJ4M21KKzTX7fSyuVsdQ4OD+GxiTLkhZs+HCwlxnGgUkHIuzcmFiIr+wMAYvUGqD6nPPbxhh61QfC41LYrJnv02BBXur1epvCwEi5FZ+pibTHj+np6c395iHCT/ZhyQ35jMzOOa3foGykPEbjEaF3pMxlTNtkafaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 00:26:51 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 00:26:51 +0000
Message-ID: <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
Date:   Fri, 15 Sep 2023 09:56:35 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
 <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME2PR01CA0177.ausprd01.prod.outlook.com
 (2603:10c6:220:20::21) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM8PR04MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8bfb89-6861-45b1-11f2-08dbb58274a5
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHTisYLWFYAwadLziHSDQXDXLSCh5xovLZm9t3sjwEhBDN7Oth/57QIzk3H58PGnaiSWMSFVxLfB856URS4HGbFRSTE9uGN6DHvLfxnTBJwLr6Y2rgknR/Vj0BEBgS2xXEuWHEIuRlsTakNN5uKrM+Kp93B3k0SAD9fNof4nEt26WsFip6Ro+s82mz+FHNkM/SMEv1iFvk3WM7EIg5x1cvdefN4628beX18DAARLUVuRNHKx6mezbmyuV1w5dT1SJcn0XpBmIVl0rJNRPQffdh/Y+wqGwcyWPGhoGMe2Zo75xCHrccj4ZPLIzpiYcYfXHGEiBbFu6zPTwfMaH0ZZKkCE2GyTVIUYN3SjIZqQYAuKC+YWCyt1tb7WCffRz5H2cqeSiC2UK+sChe3XCvOlSMbg+mXxUZyFvOPbHCAZaRORBz1B4EtVIZSlBdaiKjytj4OYEEgjmUMha0dSzC31DlcClWNbxMDQaq+gmsGsc2rbhaevBrRaJHdoQWmgYxuYXfG2YS8aziGSumn8tePdZCn7/0Mtp7j7MmZxAWyIidG67naug9NakiODVMUWXJODTwm2CsdoBp6VS7KT/DQZwDhSBUQSeF12DwBJC1/vFVtuWlViTL3RjZGEsrjGX9C8wY3QYImwWnJdAKS6yNQYaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(41300700001)(478600001)(66946007)(54906003)(66556008)(66476007)(2906002)(36756003)(110136005)(31696002)(86362001)(2616005)(6636002)(316002)(8676002)(8936002)(6666004)(6506007)(26005)(31686004)(4326008)(5660300002)(6512007)(83380400001)(6486002)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjNvckM0UzJTdzhJVlRNd3g5RWp5THNqMXZVLzg5dGNkTlpxbzlNQys5YlQr?=
 =?utf-8?B?eGlzU1JWVlZBc29sM29Ia25maWJRdG9KSDNqaWlvUHFHZFNycVFwSDhPQzc4?=
 =?utf-8?B?cjJacW9KVHZXaCtIbGgwL0tTTnQ1Qk1PV01PenVlVkQrWFpBbnYzb0JybmFp?=
 =?utf-8?B?YzRQdzhSbWdtQWVCSVhSd3pvbTN3YUJpb09uSU1HaU9tSlZpaWVSQWtnN21D?=
 =?utf-8?B?YktDMmZYRTJKVDlFSW9EdFBrVnFvb01FR1ozUGhSd1hYNmFvOGs3ZVdHc0gw?=
 =?utf-8?B?OFB5ejZwWjNDRWprT0hsMVhzamtIQzNGZDcwOHFzT3dwTnFQZGNDWXR6cEND?=
 =?utf-8?B?eHd3WXNCVVY2eFo2TU0vWUN2UGJGZ3J2clMyeXY2cXMyN3BYMjB5aTR0YlNV?=
 =?utf-8?B?ajYxdlBqRnVKaFRZSjlBUDByNjZsb2NsQUU2cE9LbHJuVWc4cWxnQTBoR0J0?=
 =?utf-8?B?dXZ1ZUlsS1BQTC91VUZNeVcycldBVFNQM3JHdVRZNkNsRjluNm04WWZvL0Y1?=
 =?utf-8?B?aUZhUWZQRlZrTjE2aUVCMXY5S3l2a08rVlFnM2NTK2VjN3ZZQ1pvWkdSeXBO?=
 =?utf-8?B?T0Y0SndDMWo3VjQvQlYxcGVIUDU1WE9FZ3RBWm1vZzF5MjRidW5UVXd1dzR1?=
 =?utf-8?B?NDNNVjd6VmFSdTJTR0VWaEpLKzZBQUlwVW92dm5MOFVNU09remxhSWRvcDg1?=
 =?utf-8?B?QTNHK0NQWEpzSThraW5LV2IvMERtTmVVK2tDblFUVXBjM3JqV0xmUFA5ZUhs?=
 =?utf-8?B?a01MNGhJRm9KbHJEVXg4eThFNTZzWmM5TlZQamlXQ2hZSjJ0MnVDVUV6eFo2?=
 =?utf-8?B?OXpJaW80b0FDY25ISWV2bTVDcGd4L3d4RCtJT2pOUzdncEZFWmdVU3dEb2Ew?=
 =?utf-8?B?MW5KR2xaNFM0blhGWnZUT3RiT2tycWtQRUpPd1k5UXJGeDZ6V3BLVmU0ZGRQ?=
 =?utf-8?B?b0ZvSGlKeUVEazg5N1BseVRuSE83M3VISVdRSW1pMitSenFVUnByYlpkWThR?=
 =?utf-8?B?UURlTFdBQVZ1NFBzRWx2M3p5eDBOZTQydVdMWmZMR21kYzFRUmNkazdvTEQ2?=
 =?utf-8?B?ZEdpVHRBTU4ra05nYm1kRGEwQ043dE8xcE9zcmI0dWtNdGs2STZnTG83K0Rv?=
 =?utf-8?B?Y2c5WklMeWJ2ZkJsWGdtNHJwU1QrdnBEYU1UUnpsNEJzMUl4R3lvNlhGWEph?=
 =?utf-8?B?SUxXVjZDaGdybWhrNEZ2a01BZnlpQy9FSkViYTYrVGpsTjhZYWUramxlTTNj?=
 =?utf-8?B?dkMrKzd6elo0a2Q0NlRLMG5MWmdaVjJVU3N6bkM0TGp4Q0E3QitybG1IUlRB?=
 =?utf-8?B?ZFdiZ01jZUd1L1BualUyaFVXYUFzV2VDZDQ4T01Xc2xHWXNXSHlkNUU0a1dG?=
 =?utf-8?B?WFFZT0pXdzhlMGkvMU0wWVJuZ2VHREovS0FpM1B2b0FUdkp4S3YySkZyTDl1?=
 =?utf-8?B?K0hFckU0dEJvek0xVTc4NkJwSXNueUJna2xmd0lVNkxnYTlXQzdpemphcVpO?=
 =?utf-8?B?S2RyYU05RXBDSjRSbGNBZ3NSVU5QTTdwVXhldFFxemFFTzRweU5RSGdPVWRJ?=
 =?utf-8?B?YUlIVUpJWURsT05WYUlYL0FmRnlPVHV0aEI4RG8wV2ZqU1FFdnVyZFcrYTVZ?=
 =?utf-8?B?YjAzUUJtWVcxNmRoOUN2SGVpb1ZCVTJFYkx2WjJzOXo2djJhbzVZR0x4NnhY?=
 =?utf-8?B?U21QOEw2VmFMOGY3ZStsVzFvemJUU3RNM0RGaVBLTkxlSERvT29TaE4rYVlu?=
 =?utf-8?B?N3psc1B2OHh3OHJQQmJVbk0zT3U1SDVIcERmK2ZNSWFwbWkyMXBuQjJ4S1Fr?=
 =?utf-8?B?dWVZSUUxOU5lSHR0RzNxQms0bTl5VCtDUTd4bWhJTStNTm4rY1VKWjg5bWJO?=
 =?utf-8?B?MDQxbmNndGZhMmdFRVd1dXFlNTNkUVR6UzJPdTMyUm1JN202c3cvb1lkZ0ln?=
 =?utf-8?B?dFJ0eDBiVStocmMzRFJvajh0K2gwOFRrOGRiT1Z5TS96NTMvOGhra2VOajVJ?=
 =?utf-8?B?c1MwZ0xQWVNyQUh6Z1IzbkN3eUFic2hRUGVtWHA0YlNPVnNpKytoSEE1aWZS?=
 =?utf-8?B?NlhwY2Nkc0tYTzRYb1dGWHNvZ2RnK2ZLMlBrQmF4aXk1WWJ2MmdzY1B6b01C?=
 =?utf-8?Q?awj8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8bfb89-6861-45b1-11f2-08dbb58274a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:26:51.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5kz+64kFEFFXz4z81j+528X0lWUYlPkwDSdOQ0EpLbcPFK0Ge/+CrAdxSa+1qaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/15 09:52, Qu Wenruo wrote:
> 
> 
> On 2023/9/15 01:36, Johannes Thumshirn wrote:
>> Add definitions for the raid stripe tree. This tree will hold information
>> about the on-disk layout of the stripes in a RAID set.
>>
>> Each stripe extent has a 1:1 relationship with an on-disk extent item and
>> is doing the logical to per-drive physical address translation for the
>> extent item in question.
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   fs/btrfs/accessors.h            | 10 ++++++++++
>>   fs/btrfs/locking.c              |  1 +
>>   include/uapi/linux/btrfs_tree.h | 31 +++++++++++++++++++++++++++++++
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>> index f958eccff477..977ff160a024 100644
>> --- a/fs/btrfs/accessors.h
>> +++ b/fs/btrfs/accessors.h
>> @@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct 
>> btrfs_timespec, nsec, 32);
>>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, 
>> sec, 64);
>>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, 
>> nsec, 32);
>> +BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct 
>> btrfs_stripe_extent, encoding, 8);
>> +BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, 
>> devid, 64);
>> +BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, 
>> physical, 64);
>> +BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, 
>> length, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
>> +             struct btrfs_stripe_extent, encoding, 8);
>> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct 
>> btrfs_raid_stride, devid, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct 
>> btrfs_raid_stride, physical, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_length, struct 
>> btrfs_raid_stride, length, 64);
>> +
>>   /* struct btrfs_dev_extent */
>>   BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, 
>> chunk_tree, 64);
>>   BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
>> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
>> index 6ac4fd8cc8dc..74d8e2003f58 100644
>> --- a/fs/btrfs/locking.c
>> +++ b/fs/btrfs/locking.c
>> @@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
>>       { .id = BTRFS_UUID_TREE_OBJECTID,    DEFINE_NAME("uuid")    },
>>       { .id = BTRFS_FREE_SPACE_TREE_OBJECTID,    
>> DEFINE_NAME("free-space") },
>>       { .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, 
>> DEFINE_NAME("block-group") },
>> +    { .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, 
>> DEFINE_NAME("raid-stripe") },
>>       { .id = 0,                DEFINE_NAME("tree")    },
>>   };
>> diff --git a/include/uapi/linux/btrfs_tree.h 
>> b/include/uapi/linux/btrfs_tree.h
>> index fc3c32186d7e..6d9c43416b6e 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -73,6 +73,9 @@
>>   /* Holds the block group items for extent tree v2. */
>>   #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>> +/* Tracks RAID stripes in block groups. */
>> +#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
>> +
>>   /* device stats in the device tree */
>>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>> @@ -261,6 +264,8 @@
>>   #define BTRFS_DEV_ITEM_KEY    216
>>   #define BTRFS_CHUNK_ITEM_KEY    228
>> +#define BTRFS_RAID_STRIPE_KEY    230
>> +
>>   /*
>>    * Records the overall state of the qgroups.
>>    * There's only one instance of this key present,
>> @@ -719,6 +724,32 @@ struct btrfs_free_space_header {
>>       __le64 num_bitmaps;
>>   } __attribute__ ((__packed__));
>> +struct btrfs_raid_stride {
>> +    /* The btrfs device-id this raid extent lives on */
>> +    __le64 devid;
>> +    /* The physical location on disk */
>> +    __le64 physical;
>> +    /* The length of stride on this disk */
>> +    __le64 length;

Forgot to mention, for btrfs_stripe_extent structure, its key is 
(PHYSICAL, RAID_STRIPE_KEY, LENGTH) right?

So is the length in the btrfs_raid_stride duplicated and we can save 8 
bytes?

Thanks,
Qu
>> +} __attribute__ ((__packed__));
>> +
>> +/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */
>> +#define BTRFS_STRIPE_RAID0    1
>> +#define BTRFS_STRIPE_RAID1    2
>> +#define BTRFS_STRIPE_DUP    3
>> +#define BTRFS_STRIPE_RAID10    4
>> +#define BTRFS_STRIPE_RAID5    5
>> +#define BTRFS_STRIPE_RAID6    6
>> +#define BTRFS_STRIPE_RAID1C3    7
>> +#define BTRFS_STRIPE_RAID1C4    8
>> +
>> +struct btrfs_stripe_extent {
>> +    __u8 encoding;
> 
> Considerng the encoding for now is 1:1 map of btrfs_raid_types, and 
> normally we use variable like @raid_index for such usage, have 
> considered rename it to "raid_index" or "profile_index" instead?
> 
> Another thing is, you may want to add extra tree-checker code to verify 
> the btrfs_stripe_extent members.
> 
> For encoding, it should be all be the known numbers, and item size for 
> alignment.
> 
> The same for physical/length alignment checks.
> 
> Thanks,
> Qu
>> +    __u8 reserved[7];
>> +    /* An array of raid strides this stripe is composed of */
>> +    struct btrfs_raid_stride strides[];
>> +} __attribute__ ((__packed__));
>> +
>>   #define BTRFS_HEADER_FLAG_WRITTEN    (1ULL << 0)
>>   #define BTRFS_HEADER_FLAG_RELOC        (1ULL << 1)
>>
