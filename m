Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78B7A1245
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjIOAXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 20:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjIOAXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 20:23:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53682102;
        Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgN9eO+1tfY/fvWh6OQu+pXRzXsqpLa2ouTTErhh3RTazNSi4U3ncB8sy9aM+O4eh/uRjLMNCIM5PP76OCOZ0Manggx0/n54KSYnqf6g7PoSpNvzreMcxkTwuIDBxX7nxGd1jIC/8xEriwZR2U2Nvtt8P5VH4SPUM4vUx3FY6PJ+zJmOcgdztJg0Rheya4j9g26hhLrETjVbwsUFrSkWSUKzn+w3CjMaYLeeekfjpV62vCo/sdWX9lxRhdVL4gybtkoCDt+sB0EnsXmeFw9HTCiK3TVxyWiffObtPBTBc8xws7ztRzCXUD9yZMwMbwC85ZySzfCOfHGkjffOg1n1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YWxc7dCvJjhI3JWYAU3pJ35gPZCKNGcEQnQ8ZDSzjI=;
 b=cHky4TOoBomKLJocicWtUZU2ndzkUK8+Uj5eRLnqzvKthDAhyjUQvCR1CC3e1tO4q53stsjmgWMMVNTJJmrTF46vLjy7PssnZ5kNThw7rI9KTkMLy8Wy8vSPnotQrIQaguGZUIysevBqmD13OnXtfMqhVLWG0TrF/4aCVGNggia4aMI5d6EvmEaayPuMKfwFHzOk5z4GykPLZiyxMxKlKlXDa5d3EAa9XJ1Uye15Ukcsu5DHyADmtOWJpcPLElQknMXul4WKsvaLOksbd5xfh5EL+o2NYG3hy7CyhqbHvNjjO9kcnkEI8VTICbLJ3lgXHXwY/vI3dUjJsuSrskzLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YWxc7dCvJjhI3JWYAU3pJ35gPZCKNGcEQnQ8ZDSzjI=;
 b=LTYY55ED4b7hN9RioO4jp9XD4l+KTsKf9t+OnvPEBsgJRRHAU73/j5RYlYrS/fSQvJLTK68OfU0AihbIiCMcw8RneQ4ZI5AXcl/rQsaHT4TDBaqW8leK1vW4/rFKJJ8D8TAqAwcguUd9uG7V99m5UEGKUUQ2iW6wIkRHkxvl3ii4ch31pYWjADl6Bp1SZLi5QYowoJXAwVn4NNZxlJMGMX9MEKSvsJbLfoxqbWpExA+uOtwT3koV+sUCXD53dOiiI+CcL953bSUeYB24gQjkonZW28Ym1Bd3sfVcvqdnuedzsNQU++r0dNLTlnLGzSO7QnwSDFnErLRdjn0O6Fnd+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 00:22:54 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 00:22:54 +0000
Message-ID: <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
Date:   Fri, 15 Sep 2023 09:52:20 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
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
In-Reply-To: <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0284.ausprd01.prod.outlook.com
 (2603:10c6:220:1f1::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 816b8c0d-b4d6-4896-06de-08dbb581e76d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWXUkeTStEupfd88GHU/W2cIAWGc7eIKVbqEQcPT5WUUBdSyntqQG4ewA5z+oudqa1K1t/t/pwD9AUypwnkfuqQ6kSgwBXB+Q7kh7f70LagEB3LtorDbMsMf03P75eC23ht6QVU+Eej6RDIUeTm4RZTB/7kURZHlcjRhYzuMx1zb0JHedRakLEG3is+GMph2+CteEZayupA9cRs7VjpXkCETIb0t2ODbf8OLIUEH5W7aUqu7QrPcWVU4keZ4VcCxbyhtPfpPVqLg+yF9NOgkkJxTPO+LCYqooHu27cw/FuSNJWAazXnGyvPlZ/ayPVxG2s5OkRY412hmml3fr4dEuMIaL5Qas5SMqktYHCt9dVO6VXVkazykMmtNtCnVqqUkIE0T6cKgIPEDnCLabWer9nvln8rFcTOJ+N5PftZGKeNkBZzVLt9yVhtL/yrOeEYnNXToSwBlgY64Hy1IbNtIiiTtuWEjw/IInmUjhayLMOctKmeCOlu0qqgZw0+DV/7BZT+X/I/A2qYzw+1VjOq6CWCVeZVmCOQ56y7ho4BDPEYNOAQ7w/LotWxKPE8OmG3p5YNrqtxiRGjhiFyo6fMF6KwcPSPmBDirIIwFv2NapNn4U0XaaDxnJF33j91aeMDbSz9jkv1cEzqV/dxiplBPog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199024)(186009)(1800799009)(36756003)(38100700002)(31696002)(86362001)(31686004)(6506007)(53546011)(6486002)(478600001)(2906002)(8936002)(4326008)(8676002)(110136005)(41300700001)(5660300002)(6666004)(6512007)(83380400001)(6636002)(316002)(66476007)(66946007)(66556008)(2616005)(54906003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3phRFJYaGVGWU5CUkpoc01rTkJuQ1pocTlqaWM3b01MbG5xd2puakFEZFNx?=
 =?utf-8?B?VkFadFlxdXJqM1crcXAxVU5Oek55bG1wOWo5OWxwcXNyRDByZ1BIQXFaK1Vy?=
 =?utf-8?B?Y05BZEtLc1RNVFdyMWlqY2Z1RFk0b05CZFhsa2FINXNzQy9tV1Ewb1AyWFlE?=
 =?utf-8?B?M082a1pXVkZ3aHMvM3NYeVZ0RmlYMkhVTEJYNCtEWXZyWTk3bzQwU3o2YlYw?=
 =?utf-8?B?d3NxdEdON25lL3N2SmszMFFiWGpBWVhWYkgvRU9UOXZqa1BNK3FNOW14R1Zm?=
 =?utf-8?B?Z28rQXRQNjQzUWxmdHd6K09rbDFWZ3JrVTlIbzZtMTFjTXB4QzBDWms2bzBO?=
 =?utf-8?B?N2hQUjNKZWxmOG5KWEpUQjIzdk9mbG1lTFJBQjc3Vmhad0phOXRwenJFWHRZ?=
 =?utf-8?B?Ukt4Q3N6cU4ydWl2SDQvQU9yL3hpR3hTcCtoQ1diUjEzZ3VMam9yZHJXSnBj?=
 =?utf-8?B?QmhhZ3AvUi93NjMzSE8rakpMdFJVY3ZlQ3lxM1JpTWNUMkthN2VGTkZnQzdS?=
 =?utf-8?B?K2FIRFlHZ1h2U2hIUHhBUlhkZmxaNFMrNFFNcS9sZ2E3R3pJM3VPZERmK3Bx?=
 =?utf-8?B?Wm5xeUJsZFJyZURxc2hkaS85RUxJZ0Jubk52aS9zZzh0RnhlcGw2WFVWSCtn?=
 =?utf-8?B?cmgrUWVTdTE4RFlDRXFKSVVTNXVFVzlNUzFVdjlzall3L3BnL2x5dnlkUzhS?=
 =?utf-8?B?eE42Lzh0ejY3aGpHcENBZ3JPOHVWVUMyRU1sVG5NaDFYUGhsN3BJVGc0VlUr?=
 =?utf-8?B?bC9SRjdjbzFoM2NIMkZrRFRpU1V1YVZ0enBWbDBJTU9UNlJySWMvZTQyUy9j?=
 =?utf-8?B?S3dVWGdxK0kyV0ZWSmg2UUUrT1BiRUdHb1JPYnF3QmtWL1NOcWl6anliRitQ?=
 =?utf-8?B?S1h0dllNYUpCV2JtYUdEMUJoQVptQjZUajc1cURpL3UxRjAvOVNQeWVBUFF1?=
 =?utf-8?B?c3dTZ2V4YXJVcDFaZENxd3N6L0FoOWM2WENEY1VJNTdqUDE2ano0ZnVQd2Jv?=
 =?utf-8?B?T1NIdnhrcWxWRmJVZ0Zqd1FwV1NpYVVHOUlBcUk3c0RJYTkxOEE4b1VRaDRh?=
 =?utf-8?B?SElCNkZCUjdZNEppOVhZaEZIZ082Tkx2dVN4TS9ZLzhZNDJYWkhmcTJMWTRN?=
 =?utf-8?B?N25iVElCazVrUGNEcElCL3ZMSFQyVjViUHN3MFhyYXBLOUNvdnFZRXJQU1Jz?=
 =?utf-8?B?L3hpa0VjaENxZFR3REZ4b1kyUDNzalkzV2VHWmpBUjExRzVTRmxHQ29xbjdl?=
 =?utf-8?B?MnYrQVAydWxpUlhmaGF4RWVUTmo5ZVhvUC9CUTFXRFVSalRaRFRDTVl5dE1O?=
 =?utf-8?B?MDAyOFk2SXZrVE95eHJKOXU0aU1NcFdUakZ2QjBUR3pVay94SWt1aFNYQ3hC?=
 =?utf-8?B?VGVVYVUxS3I3OEg1Tk9iYjR4YXVuRVZvdWJDRmI1RWRYbkgxRlM4bzhiZHB0?=
 =?utf-8?B?NThOMSs5cjVSaGJjSXIzZ3FvU1Q2UWJaYWtRRmdZMkc3ZnRGeDRwdi8wb2dh?=
 =?utf-8?B?c09FMUV2NnZWdnhUazdrZ1VTN2VhYlU3MTNhVTFZUkNTTmlZckc4cVMwbmRV?=
 =?utf-8?B?d0wwUU9MV0pxT3IwS1I3by9KV0Qwci8waTdlZnVhLzVNdFhzalRKUGxpRTRj?=
 =?utf-8?B?Q1VSTWZPeTZDSFkvMldOUDJVazZ2UWFWTmlIYjBjODhnRzk0VFl5VEhBb0M4?=
 =?utf-8?B?WHNZVVo2eW8zZ1dTS2tJalRVWEI5RXdIcXJUZjNkVDNuREpseVZnV2w5MlBO?=
 =?utf-8?B?eWg3SU5ROHNZUllnSVAwRElwaHZHOE1OZjF1RllnOXRHUFo4MEx5My9PODRD?=
 =?utf-8?B?YXhqVGVUaUREYWNvQUdBM3BHTTFVSHBieHVlVVM2NDJUSHNvQzZNYTRwZUFZ?=
 =?utf-8?B?SmlVVkFsY28yYitubWxwWjlUbVFIK0RwOTk1Z0FYOFZ5dkptTWdDcG8yS01M?=
 =?utf-8?B?OWJqblJMN3lkUjJTempEbStJTTRQUlFZTWxlbGdFaXJ4YkVSYXNqR0ZDc2cr?=
 =?utf-8?B?dS9QQzl1bkZBVmQ5eHcrMGRGSytvZ0EwVzJtZVoyR2FQY1VaZmpxZVRqdmw0?=
 =?utf-8?B?WmQ2NHIrbnJHNEpQTG05RklyYjNaanplL0ZPVXAyZk5ma0Y0SHpuVVdUbGdQ?=
 =?utf-8?Q?84i0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816b8c0d-b4d6-4896-06de-08dbb581e76d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:22:54.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFhM5OJZBKgvN4gxR9gwO0B4isfRrmpr17Uv16DhQo/HzF5BWdqNeuKZmKr4FYPm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/15 01:36, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/accessors.h            | 10 ++++++++++
>   fs/btrfs/locking.c              |  1 +
>   include/uapi/linux/btrfs_tree.h | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index f958eccff477..977ff160a024 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
>   BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
>   
> +BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
> +BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
> +BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
> +BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
> +			 struct btrfs_stripe_extent, encoding, 8);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_length, struct btrfs_raid_stride, length, 64);
> +
>   /* struct btrfs_dev_extent */
>   BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
>   BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 6ac4fd8cc8dc..74d8e2003f58 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
>   	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
>   	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
>   	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
> +	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
>   	{ .id = 0,				DEFINE_NAME("tree")	},
>   };
>   
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index fc3c32186d7e..6d9c43416b6e 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -73,6 +73,9 @@
>   /* Holds the block group items for extent tree v2. */
>   #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>   
> +/* Tracks RAID stripes in block groups. */
> +#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
> +
>   /* device stats in the device tree */
>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>   
> @@ -261,6 +264,8 @@
>   #define BTRFS_DEV_ITEM_KEY	216
>   #define BTRFS_CHUNK_ITEM_KEY	228
>   
> +#define BTRFS_RAID_STRIPE_KEY	230
> +
>   /*
>    * Records the overall state of the qgroups.
>    * There's only one instance of this key present,
> @@ -719,6 +724,32 @@ struct btrfs_free_space_header {
>   	__le64 num_bitmaps;
>   } __attribute__ ((__packed__));
>   
> +struct btrfs_raid_stride {
> +	/* The btrfs device-id this raid extent lives on */
> +	__le64 devid;
> +	/* The physical location on disk */
> +	__le64 physical;
> +	/* The length of stride on this disk */
> +	__le64 length;
> +} __attribute__ ((__packed__));
> +
> +/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */
> +#define BTRFS_STRIPE_RAID0	1
> +#define BTRFS_STRIPE_RAID1	2
> +#define BTRFS_STRIPE_DUP	3
> +#define BTRFS_STRIPE_RAID10	4
> +#define BTRFS_STRIPE_RAID5	5
> +#define BTRFS_STRIPE_RAID6	6
> +#define BTRFS_STRIPE_RAID1C3	7
> +#define BTRFS_STRIPE_RAID1C4	8
> +
> +struct btrfs_stripe_extent {
> +	__u8 encoding;

Considerng the encoding for now is 1:1 map of btrfs_raid_types, and 
normally we use variable like @raid_index for such usage, have 
considered rename it to "raid_index" or "profile_index" instead?

Another thing is, you may want to add extra tree-checker code to verify 
the btrfs_stripe_extent members.

For encoding, it should be all be the known numbers, and item size for 
alignment.

The same for physical/length alignment checks.

Thanks,
Qu
> +	__u8 reserved[7];
> +	/* An array of raid strides this stripe is composed of */
> +	struct btrfs_raid_stride strides[];
> +} __attribute__ ((__packed__));
> +
>   #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
>   #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
>   
> 
