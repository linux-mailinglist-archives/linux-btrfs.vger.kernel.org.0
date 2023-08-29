Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE078C2DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjH2LAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjH2K7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 06:59:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEF9CD3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 03:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2czLhbHKBrhwblKkWVllRN5XZ6OfKGYOUU+G76IrwOvVWJpfW4lEfyY0tASBDXC4urt+MN3LhLrxujF4kCeVeq23dh+GADZiT9kL3phFAtyhz+C0PHpHqyjo2zonIr1XVNBYw1jQlPq5EHoQlZtDKLq+pbV7l9udI0N1MFoe4lUERRkxEa3vvC4Cn8YcxxYXYKrApiss9wTd9hoYR2JbWvM2YLNVRzYujOJZec9XIsYAnObwyXL55k/Wdt/XTS6h/d7As8oiuM4Kgr46NpOy4dBqUJaS0tyJYzjm6kw+K3+7ufG0xhLX+JKdillCyhhmqD2pSuZnw26nVs9EGTS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGCFTrD9VLeN6GsbvP0n3GbYpQkRJ4GyQ4ocuHuXWEk=;
 b=BKEPz3JxgdaKIg/nRqh/exqsaDd4X0FGSjlqLtnd3Ornzv5S8kAUpZhNtdxzLHht6ap12Z6RoQqYK+tSXNRSfndS+RaAIheWtUjN9aS90hQUE107dPlFuretyxUjJxwBlzPQZhcYK0HiZkn6gceV6IkERAuuLgK2FJLBA3q7+JeXxBDPBLbCifvxKXzdTIMHY4VETKWRGI3+yz17IUwcquZ5e5982GhY9m04JpafHJJnVxT8vS9k4CflxN63btbaCC3pgbjaXtgiA1N0r+QKjBCzr9KXwt0YQW7ZcPXdAq95XRx82Ttt8GD6rni9gGiW8R/kBsMvF1+wji0kFzoisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGCFTrD9VLeN6GsbvP0n3GbYpQkRJ4GyQ4ocuHuXWEk=;
 b=do/zD3vAx6lghI38N/9zxFgVL7tPFzosJFpjR3eY40KN9icVHdm5SnxI87wA2139gImP5zziSEiGLQAsQJKUd82ak0x+D/6nol/SdCc/A0og/96ELB8tfFVk7SJSAJFLYnoLU1e8+PGXxQgUfYzo3SVGHKT2+IVHZ4rnhGE1awCCLdussqzyOikJA+K/t/HVldv5ZOt79VLiaSoAc1uAt8eSUT7Mrd4vbw+AJw2qJe5nh3jYE+xpS63TD6qi6XFjS+HldgkKPmWppxNf6QMcDvssLGuc8Y+vrGzo9kxD3k7709zTUSGy7pV/MkmY76d4eJDc69RHbuwn9d2NWYXqfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 10:59:31 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 10:59:30 +0000
Message-ID: <a1f5976d-a297-4421-be3c-f5611d1b60dd@suse.com>
Date:   Tue, 29 Aug 2023 18:59:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
 GFP_ATOMIC usage
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
 <ZO3MmTSkdN1kq2va@debian0.Home>
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
In-Reply-To: <ZO3MmTSkdN1kq2va@debian0.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VE1PR04MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8e606b-213c-471e-f71f-08dba87f053c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhJrWnEcr2n49Q2+QwEyEMYuof/X5GsQ2bWxYgQRRu7FbJR7n4uaWVtUk2LWG0Z3QbpjrcdK4gh2eT9hYjAvLfU3kZV2Bd5NpgIrQSmf8zjFVXKGRjRtJNH43N16F27ldHBjR6AX/pX45ONPmOS7PEfczgt8xsgxmrDGDdoaSZiSf9yaMJ3HJ3nTEktXwW4aLkgmhNf8VUFHt1Hp2+iJgl0lXwig/13q+VVNyfwx7M+TdkzoIZumMhDqiw2sQncWcrHli4SC2NIQfUbzTtqEmN4g6Z1B/dkhYIoY4I9v3O2HzW9bs9un44ntPoxpS+tJUW+Q75rAx37/mzaea3LohpU9saVVanXXqqXI5eui5hkY96BZXnOxdGguSJRVZQbANNXklHM6+yeVuoqFEUujnxYsTMYURxabqvSIsh58bgaQHVLnoIj6Ev3MdqX/T8iEysPYQrejSpnUKQkX1hoYGXyWURwGaWLS1T/6Uj80G8x0mKLR4OnBrgyPobi26REyknQ+43e68sjFienzb5r6eKnD5si2lGfU5bILfIxToAAqjTRM+0TYLEYCV0bt+whZFEfb4GblXtW5UTlVBc37lc0jkzhObSG8a9Y8M36PiuWuzJBBrQAf6HvBbsOeMnZ1t4Ylt6LM+wnx3TfZX/9/TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(366004)(396003)(136003)(451199024)(186009)(1800799009)(53546011)(5660300002)(316002)(6916009)(38100700002)(66476007)(41300700001)(66946007)(66556008)(83380400001)(6512007)(478600001)(2906002)(8676002)(4326008)(8936002)(31686004)(86362001)(6666004)(6506007)(6486002)(2616005)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpTTUFTdWpKcW10ckNTWFA5NGJrMGZIemsza0lPL1J6aCtBRENmSDFLY3dp?=
 =?utf-8?B?ejZLTkQrYXZ3Lyt3RVlhZXJPT0s4eFNiN1JIdmpTOG9lL2ZiY2tCb2RnaW9R?=
 =?utf-8?B?b2hUR0xsWmFXQk1MV3R2ZW5tRXpLeWhTV0J2aFdvNDZmT0FYU2ZHTXJyZWZF?=
 =?utf-8?B?d25Kd1BNNEVLakwyYjc1UE50SVBqckpmSEpCWHdDMDRRQ091Z0JuZXl3RGM0?=
 =?utf-8?B?U1JHRDdmNkxkcXViMStPM3dLZVVUcWkzUWcrWXVOTHl5eVhSZ09SR3RzQk02?=
 =?utf-8?B?TlJoZjVILzJvS3ZYdWpReWNNaUMyZ1RsNEh5SUFjVmxmaTczNXBQQ05UdTUv?=
 =?utf-8?B?c2poQzNldUNKckJVcHpDUVlnN2lSSXdhMTl1MlZSMkV6ZldSN0V6UU9ZaG51?=
 =?utf-8?B?aU1COUZyNUVVek5ZbHRlSm9KNUVWVkJMTUk1enZqVFFlbjdteENJbWhtWC84?=
 =?utf-8?B?bjR6aTcwRHpyWDlkRVRXd1NQa3duNjNQemxHcjdTTkJ0dDZna1R2NE05TFl6?=
 =?utf-8?B?eW9DaFVaUXhranlLbHQ5Mjh2NVcrOFlSdnZZd3J5cThtUzhzUUdwRUp0RmRm?=
 =?utf-8?B?T2FVYklXV3Uzb3ZBQ2thKzg4S1VKZUszV0xGdGM5cVBXQklxOWxkRWNScTRX?=
 =?utf-8?B?KzA5b3JvVVVsdlBlUEZ1MmNTSDRSY1lRMWRmU0U2aldFSWpFUE90aDQxUmNw?=
 =?utf-8?B?dzJDQjlWYThSLzRjSE9jaysrTlppS3R0aWhTbDJUM1EvU3R4aEdZVHNTUHQ1?=
 =?utf-8?B?NDJnMXdrbi9PaTNpWHVBTzVjNVQ4S3Ywa2x2K0J1WkVaMSswdnpSUmNqVVV0?=
 =?utf-8?B?RFdxM2ZvbFZDRnpidm02ejV0ZW5HajNXTmRac1BqaS9yN1YrT0hhRmNQcThW?=
 =?utf-8?B?TlVEcWJBc3NKVmQwUGVsOS8xeEp1b3VHc0RIUFRnY3VxMGY2Mmg3aHdkaUto?=
 =?utf-8?B?cEMvbjVSMkVqOFQxSzNxVnAxOEdOK3NXazhQZ3R6VWZHUXBDQzVwSmRSWFlq?=
 =?utf-8?B?MEkvdUd5K2RBdXlmMytRbk9PUlFENndHcCtJdzRSSGRIT09HYUtvYjk1RjBs?=
 =?utf-8?B?Vi9uUjlmaG5uMzVKTUxwcmZWQVA3QVdnVThoYlorYkdudFJ2dTRubHY2bVdT?=
 =?utf-8?B?T2U5ZjBieWRTV2NYeVZGd09kcmRlTEkyL0xBWWFYd1ozK1NPM0kvekV6UkJL?=
 =?utf-8?B?YllzVFZPMEI5d3NobXBDeWEreFZZV0ovVys4ZnhqVUdSUzNuNnl3UmZiMlMw?=
 =?utf-8?B?cDErNytTK3BhaXA4WVRQR0JaVU9QS0xkM05PZllzYVlxV2VwM21SMVZsTnVo?=
 =?utf-8?B?cmg1MElFaVV2aTFycnJGWHlJOEhnNnZOTnFhaEx5djRubVBTaFE3bExzeS9w?=
 =?utf-8?B?THRGUU95RHBEejUyZXZqRDAwNVhVNkZnV21qcmZ0Szc0T29jMHRXaTgwZXgv?=
 =?utf-8?B?bnJJVnRKYzg3UkFMMlNKY2dBM1hCZDJrdG9ib3l4MGlKd1FNREQ3TktraFdP?=
 =?utf-8?B?NXhCVG5CZnRUODJyUWhMcklUam04Wk9QUEtDcmpVZnpLK211bS9ZeWd5TFVk?=
 =?utf-8?B?bUJKOE1hOU44MkpSU2RSQmFGTkJmdENRdEFWaVJpd0o3R0Mxd255L2thZFB6?=
 =?utf-8?B?OWdSYVp3djN4djYwTHo3bFJqT3laZ281cURYZytJZjNjN1VtOHVtYWFyUGJF?=
 =?utf-8?B?VlkzS0dLTmZJV3BJR1BwbXVwZ3gvVFQyT09zYlYrYkQzci9Sa1JxNFo4UTVK?=
 =?utf-8?B?bDVvdG1zUnhnSGNaczc3THRnaWkrL0dPOHRIMkU3OGVGcGN0SWp1cm9HUFpC?=
 =?utf-8?B?aU11YjF6MkFoTUVrK2lLYXhRWEhBbnFOWjA1aVA2VnluN1ZITC9XSmhpa3Jo?=
 =?utf-8?B?U0cvNHNRbnNzdUU1aTI5RDFScUdqYjBKMzd0S05rdExTSWpmSzZhWWttUU9a?=
 =?utf-8?B?aHBvUmp6K1B1V09PSituejVlL3dld3lENWN4N1RMODB1VkxlOE5YU3BFN090?=
 =?utf-8?B?M0xnZEpJTHIrVkgvVFUvRGxQdFIvM1cyTUpOR3FldWZieThROTkyYWQxbjZ5?=
 =?utf-8?B?ZXlMajMwQXlHSktJMkxsTUd2Q01KSVZFQWgwNHJnOWU4SU5EbkthMlgxeWVH?=
 =?utf-8?Q?dvkPGacFs1GSMp0rKayHL1H5N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8e606b-213c-471e-f71f-08dba87f053c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 10:59:30.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Owp7SPQU95M02//sdXNFWoHNIO7Ff20L2veFXbwPxtCcGtnLBcIM4vir5KfUNnFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/29 18:46, Filipe Manana wrote:
> On Tue, Aug 29, 2023 at 09:08:08AM +0800, Qu Wenruo wrote:
>> Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
>> really need GFP_ATOMIC, that is add_qgroup_rb().
>>
>> That function only search the rb tree to find if we already have such
>> tree.
>> If there is no such tree, then it would try to allocate memory for it.
>>
>> This means we can afford to pre-allocate such structure unconditionally,
>> then free the memory if it's not needed.
>>
>> Considering this function is not a hot path, only utilized by the
>> following functions:
>>
>> - btrfs_qgroup_inherit()
>>    For "btrfs subvolume snapshot -i" option.
>>
>> - btrfs_read_qgroup_config()
>>    At mount time, and we're ensured there would be no existing rb tree
>>    entry for each qgroup.
>>
>> - btrfs_create_qgroup()
>>
>> Thus we're completely safe to pre-allocate the extra memory for btrfs_qgroup
>> structure, and reduce unnecessary GFP_ATOMIC usage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Loose the GFP flag for btrfs_read_qgroup_config()
>>    At that stage we can go GFP_KERNEL instead of GFP_NOFS.
>>
>> - Do not mark qgroup inconsistent if memory allocation failed at
>>    btrfs_qgroup_inherit()
>>    At the very beginning, if we hit -ENOMEM, we haven't done anything,
>>    thus qgroup is still consistent.
>> ---
>>   fs/btrfs/qgroup.c | 79 ++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 54 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index b99230db3c82..2a3da93fd266 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -182,28 +182,31 @@ static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
>>   
>>   /* must be called with qgroup_lock held */
>>   static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
>> +					  struct btrfs_qgroup *prealloc,
>>   					  u64 qgroupid)
>>   {
>>   	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
>>   	struct rb_node *parent = NULL;
>>   	struct btrfs_qgroup *qgroup;
>>   
>> +	/* Caller must have pre-allocated @prealloc. */
>> +	ASSERT(prealloc);
>> +
>>   	while (*p) {
>>   		parent = *p;
>>   		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
>>   
>> -		if (qgroup->qgroupid < qgroupid)
>> +		if (qgroup->qgroupid < qgroupid) {
>>   			p = &(*p)->rb_left;
>> -		else if (qgroup->qgroupid > qgroupid)
>> +		} else if (qgroup->qgroupid > qgroupid) {
>>   			p = &(*p)->rb_right;
>> -		else
>> +		} else {
>> +			kfree(prealloc);
>>   			return qgroup;
>> +		}
>>   	}
>>   
>> -	qgroup = kzalloc(sizeof(*qgroup), GFP_ATOMIC);
>> -	if (!qgroup)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> +	qgroup = prealloc;
>>   	qgroup->qgroupid = qgroupid;
>>   	INIT_LIST_HEAD(&qgroup->groups);
>>   	INIT_LIST_HEAD(&qgroup->members);
>> @@ -434,11 +437,15 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>>   			qgroup_mark_inconsistent(fs_info);
>>   		}
>>   		if (!qgroup) {
>> -			qgroup = add_qgroup_rb(fs_info, found_key.offset);
>> -			if (IS_ERR(qgroup)) {
>> -				ret = PTR_ERR(qgroup);
>> +			struct btrfs_qgroup *prealloc = NULL;
>> +
>> +			prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
>> +			if (!prealloc) {
>> +				ret = -ENOMEM;
>>   				goto out;
>>   			}
>> +			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
>> +			prealloc = NULL;
>>   		}
>>   		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>   		if (ret < 0)
>> @@ -959,6 +966,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   	struct btrfs_key key;
>>   	struct btrfs_key found_key;
>>   	struct btrfs_qgroup *qgroup = NULL;
>> +	struct btrfs_qgroup *prealloc = NULL;
>>   	struct btrfs_trans_handle *trans = NULL;
>>   	struct ulist *ulist = NULL;
>>   	int ret = 0;
>> @@ -1094,6 +1102,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   			/* Release locks on tree_root before we access quota_root */
>>   			btrfs_release_path(path);
>>   
>> +			/* We should not have a stray @prealloc pointer. */
>> +			ASSERT(prealloc == NULL);
>> +			prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
>> +			if (!prealloc) {
>> +				ret = -ENOMEM;
>> +				btrfs_abort_transaction(trans, ret);
>> +				goto out_free_path;
>> +			}
>> +
>>   			ret = add_qgroup_item(trans, quota_root,
>>   					      found_key.offset);
>>   			if (ret) {
>> @@ -1101,7 +1118,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   				goto out_free_path;
>>   			}
>>   
>> -			qgroup = add_qgroup_rb(fs_info, found_key.offset);
>> +			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
>> +			prealloc = NULL;
>>   			if (IS_ERR(qgroup)) {
>>   				ret = PTR_ERR(qgroup);
>>   				btrfs_abort_transaction(trans, ret);
>> @@ -1144,12 +1162,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   		goto out_free_path;
>>   	}
>>   
>> -	qgroup = add_qgroup_rb(fs_info, BTRFS_FS_TREE_OBJECTID);
>> -	if (IS_ERR(qgroup)) {
>> -		ret = PTR_ERR(qgroup);
>> -		btrfs_abort_transaction(trans, ret);
>> +	ASSERT(prealloc == NULL);
>> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
>> +	if (!prealloc) {
>> +		ret = -ENOMEM;
>>   		goto out_free_path;
>>   	}
>> +	qgroup = add_qgroup_rb(fs_info, prealloc, BTRFS_FS_TREE_OBJECTID);
>> +	prealloc = NULL;
>>   	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>   	if (ret < 0) {
>>   		btrfs_abort_transaction(trans, ret);
>> @@ -1222,6 +1242,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>   	else if (trans)
>>   		ret = btrfs_end_transaction(trans);
>>   	ulist_free(ulist);
>> +	kfree(prealloc);
>>   	return ret;
>>   }
>>   
>> @@ -1608,6 +1629,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>>   	struct btrfs_root *quota_root;
>>   	struct btrfs_qgroup *qgroup;
>> +	struct btrfs_qgroup *prealloc = NULL;
>>   	int ret = 0;
>>   
>>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
>> @@ -1622,21 +1644,25 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>>   		goto out;
>>   	}
>>   
>> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
>> +	if (!prealloc) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>>   	ret = add_qgroup_item(trans, quota_root, qgroupid);
>>   	if (ret)
>>   		goto out;
>>   
>>   	spin_lock(&fs_info->qgroup_lock);
>> -	qgroup = add_qgroup_rb(fs_info, qgroupid);
>> +	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
>>   	spin_unlock(&fs_info->qgroup_lock);
>> +	prealloc = NULL;
>>   
>> -	if (IS_ERR(qgroup)) {
>> -		ret = PTR_ERR(qgroup);
>> -		goto out;
>> -	}
>>   	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>>   out:
>>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>> +	kfree(prealloc);
>>   	return ret;
>>   }
>>   
>> @@ -2906,10 +2932,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>   	struct btrfs_root *quota_root;
>>   	struct btrfs_qgroup *srcgroup;
>>   	struct btrfs_qgroup *dstgroup;
>> +	struct btrfs_qgroup *prealloc = NULL;
> 
> This initialization is not needed, since we never read prealloc before
> the allocation below.

This is mostly for consistency and static checkers.

I'm pretty sure compiler is able to optimize it out.

Thanks,
Qu
> 
> With that fixed:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>>   	bool need_rescan = false;
>>   	u32 level_size = 0;
>>   	u64 nums;
>>   
>> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
>> +	if (!prealloc)
>> +		return -ENOMEM;
>> +
>>   	/*
>>   	 * There are only two callers of this function.
>>   	 *
>> @@ -2987,11 +3018,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>   
>>   	spin_lock(&fs_info->qgroup_lock);
>>   
>> -	dstgroup = add_qgroup_rb(fs_info, objectid);
>> -	if (IS_ERR(dstgroup)) {
>> -		ret = PTR_ERR(dstgroup);
>> -		goto unlock;
>> -	}
>> +	dstgroup = add_qgroup_rb(fs_info, prealloc, objectid);
>> +	prealloc = NULL;
>>   
>>   	if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
>>   		dstgroup->lim_flags = inherit->lim.flags;
>> @@ -3102,6 +3130,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>>   		mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>   	if (need_rescan)
>>   		qgroup_mark_inconsistent(fs_info);
>> +	kfree(prealloc);
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.41.0
>>
