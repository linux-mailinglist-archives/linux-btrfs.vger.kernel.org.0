Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384E79DF93
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIMFzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjIMFzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 01:55:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B73172A
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 22:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILbKz6JDzzn9BUCBVQRDA9ThTakBdBDpWkoKLVotTcglLD2Ou/hZM/rCIgfj2sUC1e4Aq7UV6ZXdVwqvMsXqbtLbGHRb3Dl8/9vqG+HtiLUbhox685NfrHm0ZrADU0Gx0crFS8kT+P75/+SQ16koVWs//beGBVGA0Or8UJbX2ZwAhQsWvAUicSSOIwWaITRHoFe3k0xjA8r1D/kZttBkQ2ldy4BNUxEja461WlZ7MR5PQcOq+qOuKZBv4ZS86QdXEaNJw1SbQ8x8qhmT/gZYkjFa2YO2eJREnpff+jQEaWeY7jjrP71IjVZ5usFj0yqiahV0f4rhP94wKY8auIS/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJo5aw54KbYs3gzeVzMYgdQjAflmdhSfX3pB/b5N4VI=;
 b=BPxGMUve/r49oRODdfUo6mo8mdLtJ0kigNd2GJB9/X23JaP1YNRX5DEi2N3g7zNOemqpWykmySRfBUqQvn4lKxrGSFUvZ7BLzYyXhn/chNsigLJDQcg3Z0Yyig0gQkKHehid2pOzIwPsmLnxrPD4/rwDaCknjvuLGWD0jIOC6V2jFfwv1iUZqW5hawYd7lLiTR+EQ0DeNIc/4MN7vp2bpv2b2piLdN2DgxSiVAh2vlFTRRqRTw516HwUfggI3SUa1SbuHwwKiHflqBFnMyXTCZZBRYaDntkv2I3o9vwADPBcBPh7SVeenhJwT8xPsgezFPmQZBabQN4aNrkkI1YkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJo5aw54KbYs3gzeVzMYgdQjAflmdhSfX3pB/b5N4VI=;
 b=lH3oUKN9ZHso++nNfXXfL8Y+HAQsGpqqle0AgrQL3Jd3diq1MIV4LD0flxY4BaAhmuqkesw+ax8BWQPppMG/Ax6K713aI+d3IkEyXk1PvbDUgqgrrnBBY8O+XcDb8bhUsW1usPAHDI77v66jJEpK2BBNmgrOxzLlX8Xo/i4kMaYZEKTX4FBEw8WEtkvI8+rxiFN1gXy1jhq1pSfEiCFjrDyB0z6eLV16C1b3qM3vBNrtbXFeDfAciz+p3ZJg+nKfeR+3Mom+ynv1/fE+qBQZECkAm8RQa7vptxTTxghILFzRYy0VB6cfd5xXHwOvZxzTlTrpGVSV7esQ/Kdw2C8hdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 05:55:34 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 05:55:34 +0000
Message-ID: <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com>
Date:   Wed, 13 Sep 2023 15:25:22 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
To:     fdavidl073rnovn@tutanota.com,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <NeBMdyL--3-9@tutanota.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <NeBMdyL--3-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0302.ausprd01.prod.outlook.com
 (2603:10c6:220:1d8::6) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|GV1PR04MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 150fb2f9-fc26-4063-0ce3-08dbb41e0b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dAxFjqSXwgNgAn7R2YL0MD9CyNAklgmbaTNWX7N5+pWBbXVw7rUPo3SC6IGgBa/fnbG9SshdFiSnY4Sl0Ew5eam+sTNdRc5qwrAnZaVXkTxfdI+67wW0p7z2c77k7J9OlXgSu9YNA3StiY22KoUZc9nyk0DCSgGGpyiTVLV2shLdOthdXuhUnB1Fm+LRuqi6qZhvs3VvjLTBgypP1eS5GkXH6LCxW+fhxcC9EcC7eahKBPn5fBzJ9KU9koJr6aibayb6lhR8j3ft3/UktgEOB2sm7sFdjP4CymZONHpzhKyM+MkCCTvF2I+NB6K3N5RUXEczIw+2qc2doZvFc+Mue+HoFW4C8UhVPSjxvAZ7PjFJmEu48hvge2ddPS5OjTVWr//aQQTF05P7rrQl9N2PyPeTWdlcwjj+3GIu3/fLSpTSaQm9gDjyOrCRNAYbSdpXXJ7h0AN3VyiPXMvbF+tu9GNzzAQYviumAvTodFc60/WJSzyphabvbOC5UeNJxLJXf3nGosfv0IGLENtGuG2hmwgkGH9N1AwReL41fBnX22U3BeqVOMCY+9iWRn2tEBhjPWcH1HNMnaGwbaAWt5s8h7pEHO6fMRrD/BtJKvZUYcHz1wZLUWpa300ePDLssRQq2oo/FzAo3vBOrs+RSidDUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(186009)(451199024)(1800799009)(478600001)(31686004)(6666004)(6486002)(6512007)(6506007)(53546011)(38100700002)(86362001)(31696002)(66899024)(26005)(2616005)(83380400001)(36756003)(66556008)(5660300002)(8936002)(8676002)(66476007)(6916009)(41300700001)(316002)(2906002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VJdU4xQkdySDc5aHkvV1NFR200WW0xSUxVSk9XbFFnQ1ptSFAzZEV1cEds?=
 =?utf-8?B?Zm9qNHFoQkE1bnVPNjRreHlhZmRyZElDNDFGaWJQdVV2MDdULzRWMldGL09H?=
 =?utf-8?B?WkwxZTJjU0hqNHNWWTlGRGdSQkNLbVhicGppdjdSamQxNVk1dGl6cjdMay9F?=
 =?utf-8?B?dHZ4RFJJSXA4Q3RtVWN6ZEtnUk1ac2RqM0xXaVVGWVFtaHlkVndvVjE0LzR3?=
 =?utf-8?B?MDhPTFN0L2U5dnJtaUYrSkdQZWlTVFlCQUY2KzJtYjRUQ1NTSFRSWjNHOTFE?=
 =?utf-8?B?akc4YWpCSjdOdkhYcmE5VG91TUUyUlVNY29wTTM5eTFBUGVCdU04YUthVUxm?=
 =?utf-8?B?L0ZqNFpvaVY0aDRQcnhjc2dHMmlOOHAvUWdjaDVhaWRTa0tobkVPeUpXRXN4?=
 =?utf-8?B?T3h6bm41b0MzYmpXTldtc0NKT2x0UFBOVXRLRjkxZzYyekdhd3ZFTnJ0Qzd1?=
 =?utf-8?B?YTg4cDhheVYzQmxkNWFpZTRXYUtHUlhwMHd2ajFyNTdoM3BTYlNUazdCOThC?=
 =?utf-8?B?a21ubTZWOXRKd2JVcUR6Y1MrdU9YWE5RamptYzNoQk5FelV5M3VCRFNUdU9B?=
 =?utf-8?B?YkpYa0tWLzJjMDNLbXZwdUVuRFJVcHNzWUkwU1RFNGVBWGlzYjRYTTh4dG9P?=
 =?utf-8?B?aThkRVZ1aFNJVForb1RiN2pKVVBxU2dJL1RBUHJkOFNLZ3BkWmlGTWp6dVdz?=
 =?utf-8?B?TWhYUDI0N2VPMDJhSkFiU3lVV05pZmVwa2xqekVhQ2dhZXZkOGlHQkN1Y0Fl?=
 =?utf-8?B?TG1wOGhjN0JKdUt3L3BzRnk2VjFPRUpMNzhSY3hNSjVGMkp3MUl3cjNkaVZn?=
 =?utf-8?B?NjRUS1lJbWsvVllxZnNYZjlxYllBcHJCS041RlNwcnVZbzFYVzg3bGp6Zldv?=
 =?utf-8?B?cElLY09xL1FlZnlBWk1RL1didktJMFQ4MzloK0l3cUQraE5BbTVKRjRQbHY5?=
 =?utf-8?B?T3Blc3pzeDZzYUl0cllab3lnVHlCbGxVNlliMTZNNkthVTRwT2xUeHJ5ZHBL?=
 =?utf-8?B?T2FpY1F0RWovWGsxRndET0s3Q3FlYjFrOUwwNXhDazllMWNZTWJSVHgxRllq?=
 =?utf-8?B?RXo1ZEQrNFlmdHQrVHNFUFUvWUpZWi9sOEwzSURLS2l2VEdLM0FQY2RUMXF0?=
 =?utf-8?B?K05PZDhTQkFkbytrWTRreUtHaXorWFpEK1RCUUZuQXdiRFdEMGU1c2F2UmJF?=
 =?utf-8?B?YjRLOSt3dURRREsvdTlIOTFKWEppVTN1aGxsWEJuaC9TMXR5eFFoK2xPZVFh?=
 =?utf-8?B?S0poNlBvVk5ZUitxUGozS1BOQmxHVXpvU0ZSK2Y3bHZwYUpGRjRzeXZKUTRM?=
 =?utf-8?B?MUFFSFB5clNRRGRDZStwN1kyVFQ0KzR4Vk9teWF2TDdVdCtLbmg2aGUrb2wz?=
 =?utf-8?B?WkVmUzg1T0drdFk4S3g3VHdQUDEwYXFYV2JEVm56Z2ZkSEs2dEZxekUxRzVP?=
 =?utf-8?B?SzBjSVBLNkhyTGRhOEx4cUErR1dyNEUrd0FwbTljRmtqSzgwcUN5QzBZeGE5?=
 =?utf-8?B?M3NMcUljc1h1UnhyaFF1K0czSTZ3LzlzaVBhck5ZSGpOYyt0NE9Fc3RvOCtz?=
 =?utf-8?B?aXkwS21aMW12bjYrNWRQRGZOeTg1Z3VsODE0TzJXSjdJWFk1dWtxaDg3cUwx?=
 =?utf-8?B?YUpNek9OZDNMOWhrUDhsMGplTWl0TEx2aWJsY0NYenpPb0Vic0tlbG02N2Ix?=
 =?utf-8?B?MnF5bHMva3VCd1NpY2tGNjNSRXFleFpBTEVGaVQ5d0FaVWdCVEsxRGpQT0dk?=
 =?utf-8?B?dFFpZmNscGRBY3QzTSsyNlBzKzcrKytaSE9kUFp6Q2w0aFIyNWpIWkdCRlF6?=
 =?utf-8?B?UFJ3bW9nR1V5aHo3UE9xQjNIS3hlWGNZelZVUnlyRkdQKzl2ejVpS0Irb0x4?=
 =?utf-8?B?cjZHVy9QQnhUclI2cWlVSGREWHRyV3MrREFnVjJuMUxDLzJLWTR6YXdPUytv?=
 =?utf-8?B?Tk5lRkkzd0tKSS9tUWxaNE90SXRGVHoybE05UkJUd2F2bDBoSEdvL1lxZ3RO?=
 =?utf-8?B?QzkyZkRSNFNSeldKcFVSQjZScWJVZ0lRcEloY3QyQVpka2lvV2dTbjN6ZDh4?=
 =?utf-8?B?K29zVm4rVDhUbENZTTJlSFFCVFY5Q2VHUW15SjBYSlFITktaY0RlN2F0M3NY?=
 =?utf-8?Q?UwlI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150fb2f9-fc26-4063-0ce3-08dbb41e0b92
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 05:55:34.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN4Cut877rS7oo7uFIlwm4ny6s3EXdgRf8z2XxZsJ3afI9wZjAvrpuGK7t2hCfBs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
> Dear Btrfs Mailing List,
> 
> Full disclosure I reported this on kernel.org but am hoping to get more exposure on the mailing list.
> 
> When I delete several terabytes of data memory usage increases until the system becomes entirely unresponsive. This has been an issue for several kernel version since at least 5.19 and continues to be an issue up to 6.5.2-artix1-1. This is on an older computer with several hard drives, eight gigabytes of memory, and a four core x86_64 cpu. Slabtop output right before the system becomes unresponsive shows about four gigabytes used by khugepaged_mm_slot and three used by btrfs_extent_map. This happens in over the span of a couple minutes and during this time btrfs-transaction is using a moderate amount of cpu time.

This looks exactly like something caused by btrfs qgroup.

Could you try to disable qgroup to see if it helps?
The amount of CPU time and IO of qgroup overhead is directly related to 
the amount of extent being updated.

For normal writes the IO itself would take most of the CPU/memory thus 
qgroup is not a big deal.
But for massive snapshots drop or file deletion qgroup can be too large 
to be handled in just one transaction.

For now you can disable the qgroup as a workaround.

Thanks,
Qu
> 
> While this is happening the free space reported by btrfs filesystem usage slowly falls until the system is unresponsive. If I delete smaller amounts of data at a time memory usage increases but if the system doesn't go out of memory all the disk space is freed and memory usage comes back down. Deleting things bit by bit isn't a useful workaround because this also happens when deleting a snapshot even if it won't free any disk space and I am trying to use this computer for incremental backups.
> 
> The only things that seem to cause a difference are the checksum used and slower hard drives. Checksum changes the behavior of the issue. If using xxhash when I remount the filesystem it seems to try to either restart or continue the delete operation causing another out of memory condition but using the default crc32 remounting the filesystem has it in the original state before the delete command was issued and nothing happens (I haven't tried any other checksums). Having slower (SMR) drives as part of the device causes the out of memory to happen much faster. Nothing else like raid level, compression, kernel version, block group tree have seemed to change anything.
> 
> My speculation is that operations to finish the delete are being queued up in memory faster than they can be completed until the system completely runs out of memory. That would explain what's happening, why slower drives make it worse, and why deleting small amounts of data works. I'm not sure why checksum seems to change the behavior when remounting the filesystem.
> 
> I am willing to do destructive testing on this data to hopefully get this fixed.
> 
> Sincerely,
> David
