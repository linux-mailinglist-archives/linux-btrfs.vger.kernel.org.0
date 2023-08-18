Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3778083F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbjHRJ2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359079AbjHRJ16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 05:27:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88A35B3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 02:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3sTlv3UnKysURs5fRHiNvOhTi0hbJXKh8M4jNkd0dcqHQ9GUcFWTWLsKoy/MXLQQNxNT3N4qmeTl6XHCTMy4kRoIO5gNJHTt5MIC9hBdEhz0x+iThVIixDsyj55bczQU9GZ0r2gQ9YQ9oD/BlrECT5RjvLC6GD8tNFF2ncpiq9SfJEdzr0RURgt3g01bQOGuOGxB3tD1n1cGtz5DfYtFvtzRmqINDvZhjZbholU09ZsXAfO2SorIgLqZGI/1LEKl59LMbcNpk/9M2GYmiON976twlUahBH5y+ngV8QtViQEtmhOoM3TVzsbJy3PSOq4E2jn+9A4eCZZHK9hvz/kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8tmuVAguqasN9Lltth13BawKyTJT88AGf6N5/KoyCI=;
 b=CVgB841iI/i7oXCMUDBET4NayfigufZBWwCaXUayW2QSgVLZe5mdDbmM2N1JNCQ7ysBlV9hu8jKe1ijPammDvu5EFo/n7syk7QHwG6LnBbuqurZUZjlCuD5chDGaZd/JGTRVG8wuLqsqlI8nEXBnt5HJYOpH6FK5FB4rJmkj/AGfnTMR3p64b6ABhWXTQwJ37Hhe93mf/58eazxbWENyO0Tq2ImD8wUOQ2ygYnY9EDgVY4S9S2KeGhMwc0gJmj+M6nHnjwL3pjWkwPbegxusbA6sB+16NzobsWiZferMsUJM7ZutDxWseSjRP8vZpCEEZs0xVdOw5P2IzbIBdnyN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8tmuVAguqasN9Lltth13BawKyTJT88AGf6N5/KoyCI=;
 b=j85GiNwGflQJJAsvMhtA5f35Y8lHq28bmgLsxPuSrH3KBylHBOM4qrSfKqZDIRFcAjMXVvkd9lL5JLp+ugrdrRup1wqwnYTqNAu+CVl3Xa7v0wymIN6nddzGjHAJjpfgosna3GKvI9CX25OW1wHZ9LWRlxaLH8UpSLd6uWZNyNMTDE0KarhxewolbKeO3YfLU+9kxjP/GvFMp68zZPUTMZXoLTwk4yY7M3omskcbMHWXlKUJHF0Sj9Yn2fFsBjF8Tf+Oo5IxR8D7vZihNO23otv0dzLDCp+hJfbRfl8Tn2gG+0s+AQc0VRw6stNxtsvRljaSc+FOYTKKo/tHxjtL4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by GVXPR04MB9733.eurprd04.prod.outlook.com (2603:10a6:150:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:27:50 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 09:27:50 +0000
Message-ID: <ef88fc2a-b845-4637-b006-43ecc511d9fd@suse.com>
Date:   Fri, 18 Aug 2023 17:27:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
 <20230817115229.GJ2420@twin.jikos.cz>
 <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
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
In-Reply-To: <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::35)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|GVXPR04MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df7881a-30cc-4ee5-57dc-08db9fcd645b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 468CD81TW6GzdourdH5BXUHsqXwaKIoTmNgPpI+GWi98+VwhgkDC55hcv0HbfIsCbpw6hljazOQdS7d08GcXTbcPBq1QjHqvSZ4Z4RA89EBIgBERtvkDo+J027VsIlamMZCgZxEuIJtorYGrRifduzobEnWU7PFR7ZxepUf7tje3V7fpkhym+quKWmrhlLJj4Ca1yPQ/Pq4dqXCaxAtKpLW6sXA3EnMr086P+Xgy/r3OHN7IHIBOrkG6ruIcbmWYL8bPejJmWZBCedn5Bvp7eVgG3gUP7dF0f5z5YRUnCP1tUFBDI0aUFVAs2w3j+7iVwdR4WsWHxK7i7ykS40w5umZpDwWjki4L3ddtOTawnipeOiq7yqsUHZ17nf0VsBY11KMPeuZb5iK5EEc4ExbrjvSaMJQfEMt1tJbNJgQKBwToSBqPEFcrs4sg8NfvN2H2lnr17BfEhg/2tUT0zZpEd3sZJ/OgWpnfkJdbyq5IvSLQjOVxQHST4dN2blHDwqJzgfw4b6FU9ev+jKMuqslmQpjq9088l2cJO3MaLTOpdxiLRVDtmDsagaJZ+24LX37631zM/hO2RtrURnBH9z7Sxa0d7fQFft8kU76VY6WAYWTvqYm3JoB8NoqdtzIYsI2Gr05hT/RhcHVk2620KseQew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199024)(1800799009)(186009)(2616005)(6486002)(53546011)(6506007)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(316002)(66476007)(66556008)(66946007)(6916009)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxSVlpnT2dXZjZ6VWQ2TGliUktNK1FmaTJ1a2NCZ3VSZFVBeUJTWnFvbncz?=
 =?utf-8?B?Qm9yeHg4ZDNSS1ZHN0c5czA3ZjdxeXR1Qlk0QTFycDg3KzV5NnlaKzNQUDBE?=
 =?utf-8?B?ZVFwcGNwZ1BaUy9aUGprZ0k2T3dGYUVDamx5V2R0MWpNQ0hXQ1ZlRElJUis0?=
 =?utf-8?B?UGtWYzNtc0JWemQyWk1uaDhyTTh3QkhuZU1DM1NjQ2JESDdiSU1HbmNxbnBB?=
 =?utf-8?B?OTYwamtFYXNockpmRzNsLzRoYVBmSEVWclNWczdLWWZING9XZzUzeHJYMmVs?=
 =?utf-8?B?SlppaVpDVFY1WXdodFpsWG1GMHZSeUFaOHRtTCtUUnVXbVNCamUzRXU3eXdT?=
 =?utf-8?B?b2FtYklwaW5HNlhjQVVyOWRra2d5K01RZWFaUUZrS3RRcWRsMmdHMXhnZnhy?=
 =?utf-8?B?UlM5OWsva0pOM0lsYnVWc3g4ejhPVDVYTEh5RVdUR0d0V3dzSmNQbzhRU1hm?=
 =?utf-8?B?SXJKNmExaGNGTCt1b3g5NWdUV2FncHJyei85RkxhK2FiYTZEYnR3S2xjR2wv?=
 =?utf-8?B?MG5kbVprUmhacUt2d05ucFkwN0dOMGJCTkZPVTNlN2dVQy9RYzlJbDdIYWZS?=
 =?utf-8?B?TGt4YTlhUXFIczdmT2F3VHJZVkFxT29RVnhWclFDaUVCUDY3QUJDZGhTQi9I?=
 =?utf-8?B?K2RkWno2ekp6MTVMZkJMZ3djTlJ5Y1U3dzd1TjdzRjJvY01paDl5aVQrdlF5?=
 =?utf-8?B?SmxldnBWRHdjc1JmTldaM0dvRHkwaHZTWUZJU0lWVm1pTHdXT0wzbzVkWEN6?=
 =?utf-8?B?NHc0anhjL1ZJdFc1Znd3aW5SZmUxdzRpM3NIZFo4UHc3VVJiVlcycS9qSHNv?=
 =?utf-8?B?ei9MOFRoNmt5cWJncTJpY1VGS1R0TmdMNzBPdnZtMTd0OU9hUnhlSENkOWk3?=
 =?utf-8?B?VG5NQlJPdmk2TmdwTE41cjRTc2RKWkxyQy8wMnpUVFhhY1BHUHJ1eGxVcEtI?=
 =?utf-8?B?VVJaem43OWpvcWl0b1NLeUd1eDYyZVk5WmMyemdNbEJtaUFuVWxxaEYwU1By?=
 =?utf-8?B?YjdqVm5SRVkzVUxpWk13UzhLVjloN2lCeE5JTXgySkxDSzZ1RTBxSVk2bER1?=
 =?utf-8?B?Uk9vc1NEZHFlT04rK0tSd2pIMm5nTm41MzlXb2VLbGJEZmIweDN4b01MQXJH?=
 =?utf-8?B?QWs1eXRiT20xejV1R2w1UW5kNFdjWExWbkQwdG5pQk1mNkR5WGhBQ2xLU01R?=
 =?utf-8?B?L2xIaFBxMXdCSUNzb3FLVU10R2dIeWIyQlhXaDVsMEFQZzRMZGtVQmlJemJR?=
 =?utf-8?B?YmpiZnR6ZWFiTDEzTUd6QjRoRFlKME1MSmowYVgzK1Nsb05pamdTQjBFeG9Z?=
 =?utf-8?B?VUVQMEVUNVNYNUZPUjZHbE16VDhBc3QwTkdPUE1KTU51SGpoSEpKZUJ3TFdq?=
 =?utf-8?B?TVp1VVJ3N29xbVJ3c1lOT1JTczlUZGpIb0JuV3NIZ2Rxa3FpUkp4djVrY0JI?=
 =?utf-8?B?ekdVTElXUE1TUUJsZVRPVDUrS3pRZW8zcWI2UFNMM1B2NFhYRWRidS90ajZi?=
 =?utf-8?B?bzNSRVFUWFhRRWdyS3oxNlF0KzdPRDFscVhBR2hpN2xiWFJvTytqQlJ2cTR1?=
 =?utf-8?B?ODdUTWpVSEtSa0IybGJUME9VdkxGbTFESENIOWVkSjAvS1MxTXVsR3piaUN6?=
 =?utf-8?B?dytiQnpnay8rQXZSY3lYdnlVbjQ5bkVuckw4bFMwZnhQdWNYYytKWU1zOXdr?=
 =?utf-8?B?SzkyTmVZTW16TGRlMms5QVp3aUkwb2s3VUlRb0I3QjE2ZEFsZ0w2QjBNOFdK?=
 =?utf-8?B?UlN2dHFtU0VmM0QrSTBZLy9UTHVjb2VPVHdGcEJPN2JndnN2Uk9uUkF0NThy?=
 =?utf-8?B?OUFIbzE1T3Rlc0cyR2RaM3cxSHB0WUxYU2pLSkpxaUJ0dVNRR25icFNKV0Jq?=
 =?utf-8?B?eXFkUzJMM2N2eEtrQ050c2cwbHJ1ODB4eE5tclp6eFVVY0wrV3BYQjBOaDB0?=
 =?utf-8?B?L2hDSGtteVlnSnNvNWFvajRkOUdMQTBLTklnM3JRZnhReS9oK1NWSzh5VTQ4?=
 =?utf-8?B?ZDNuUWV3Q1dwRW0rZzRmcHRucnoxTHJEWTd2N0ZBa0U5Tm5ycHg4YTBUZjBG?=
 =?utf-8?B?SzJ0RFJTellEVjRFaFEzckdnMzhXbFVodEFDeEQvU2JibXB4OHdYNjVhY2p0?=
 =?utf-8?Q?HqOGyY0/vOnTjYOOE9AFhbBaU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df7881a-30cc-4ee5-57dc-08db9fcd645b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:27:50.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciCK1ttWN6sI5QZfFuDLrRc+rGTslF+RsT7gP2llOZxZ+V3nNphn/W3yfrbYJ5l7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/18 17:21, Anand Jain wrote:
> On 17/08/2023 19:52, David Sterba wrote:
>> On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
>>> The btrfstune -m|M operation changes the fsid and preserves the original
>>> fsid in the metadata_uuid.
>>>
>>> Changing the fsid happens in two commits in the function
>>> set_metadata_uuid()
>>> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
>>> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>>>    resets the CHANGING_FSID_V2 flag (local memory),
>>>    and then calls commit.
>>>
>>> The two-stage operation with the CHANGING_FSID flag makes sense for
>>> btrfstune -u|U, where the fsid is changed on each and every tree block,
>>> involving many commits. The CHANGING_FSID flag helps to identify the
>>> transient incomplete operation.
>>>
>>> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2 flag, 
>>> and
>>> a single commit would have been sufficient. The original git commit that
>>> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for 
>>> changing
>>> the metadata uuid"), provides no reasoning or did I miss something?
>>> (So marking this patch as RFC).
>>
>> I remember discussions with Nikolay about the corner cases that could
>> happen due to interrupted conversion and there was a document explaining
>> that. Part of that ended up in kernel in the logic to detect partially
>> enabled metadata_uuid.  So there was reason to do it in two phases but
>> I'd have to look it up in mails or if I still have a link or copy of the
>> document.
> 
> 
> On 18/08/2023 08:21, Qu Wenruo wrote:
> 
>  > Oh, my memory comes back, the original design for the two stage
>  > commitment is to avoid split brain cases when one device is committed
>  > with the new flag, while the remaining one doesn't.
>  >
>  > With the extra stage, even if at stage 1 or 2 the transaction is
>  > interrupted and only one device got the new flag, it can help us to
>  > locate the stage and recover.
> 
> It is useful for `btrfstune -u`
> when there are many transaction commits to write. It uses the
> `CHANGING_FSID` flag for this purpose. Any device with the
> `CHANGING_FSID` flag fails to mount, and `btrfstune` should be called
> again to continue rewrite the new FSID. This is a fair process.
> 
> 
> However, in the case of `CHANGING_FSID_V2`, which the `btrfstune -m` 
> command uses, only one transaction is required. How does this help?
> 
>                  Disk1              Disk2
> 
> Commit1     CHANGING_FSID_V2   CHANGING_FSID_V2
> Commit2     new-fsid           new-fsid
> 
> 
> 

Instead if there is only one transaction to enable metadata_uuid 
feature, we can have the following situation where for the single 
transaction we only committed on disk 1:

	Disk 1		Disk 2
	Meta uuid	Regular UUID

Then how do kernel/progs proper recover from this situation?

Although I'd say, it's still possible to recover, but significantly more 
difficult, as we need to properly handle different generations of super 
blocks.

For the two stage one, it's a little simpler but I'm not sure if we have 
the extra handling. E.g. if commit 1 failed partially:

	Disk 1			Disk 2
	Changing_fsid_v2	no changing_fsid_v2

In this case, we can detects we're trying to start fsid change using 
metadata uuid.

The same thing for the 2nd commit.

Thanks,
Qu
