Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08AE68760A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 07:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBBGrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 01:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBGra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 01:47:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486379C9B
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 22:47:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap/iFOTfjJI1har/GtkaaTRi+//F7KC+Tu+DJyJDLMfSFEul5UOmWU/dkCU4pUwFzW43s0CQrC8HJGjPEoI3N8sibIjov4vVtMTCpVnbsr2mA0cT/p0pxBPdfV8LNNcCd9Wcyrt85bAK3meS6hH5Jh1JEaZXJcIWg1H4HoDH3hR6awcsgRDAyNseZ9EyCGr1uQhJgMGOGC+2Hk0fhNJMuFK+saL7a/fnklhFhiYypFGNeJ4TWESN3nw0IfAmCTj5JGRo9Na/9llFGNzpKNC5wdV9pyGE1nxbUAYr0N+lhxUjG6r3DyKMo3g/2e2gRrgR+t9fITl70eIKLSgPftFw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6gIgel8GGD26aQMiDDVPW3cemmVt8frkwsB9te7bN4=;
 b=fSrzMhPsCnHCHvIJNYmGXkmdotgdVdEaXpI2VOOFmpn+ehu67rGpxgSrm32PmeAqXRWYXWY9S0UAIsHi3GcDAulzQZJpqSEEBXlVyeGs4mG5h47JLj1Uac+MX401dMlTxuzznOGmApsDk/XW4XsZTkopQnVPQ3SwzvJTpseg4GBQ2RIAU2z1yVxbJsM4iQ7OgovntGmkF0lzbVra9rqRZcDZKN7qR5zQwDK7ofO/3sq3MRUbNpx5w8N9/dHlG/HlkGL6alzSSGa488r3DIJgW44OOIPUYG5PYvwF8ozMXsPKePLhJyr/fLzlIpf5LXP2c9sMNNr707PDlgIUH8dISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6gIgel8GGD26aQMiDDVPW3cemmVt8frkwsB9te7bN4=;
 b=t2H8VwTVn1P95zKkDKex4VdbJ0FjOW0ENw0YOQXKvYIJTBmGHHlpWMTDZHZH7YTjJ3sk4mCL8TaYSwwuNxtxklAMKmeyqr4bVKLLYo77dH8vhJgUZ7iud2W70nCILGKBSdNSKqvP7hlxOZC7fAJ0fwuZ88FiczO9TKyTkDvejmwkuR0qZUL0YQ308DLwu/Sd5/XMMZkLPMbXJ0LiRMBUmesxENRlvfRPzA64qJTRO602Pkybukhc6pec5saGfRmv0YTAkWKeZDgO+wRkj+9IpZgIq13q5aBvMT3xG60u9m/1YwwoWgwY7LJpdswtjZG5xV4Bkp5k0ZNanuYSj6X2mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 06:47:25 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%9]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 06:47:25 +0000
Message-ID: <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
Date:   Thu, 2 Feb 2023 14:47:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2b3ef2-2b12-4765-ca84-08db04e957c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyibv8qk9G3USmqnVQUoSYjQtvA5JoG7s/5/aA+pH6PL2GhgTSbrxwwoLSPEDhKDRNEEZwqpITB6+TyBW4gxXQDzaBuhjNVLLVO9FcwGz7XVxMK2xcaV3deTEgqGor8etfB+ygFSj297jxkFo/irtdB59BSnnpQKmbImafgtXSARUnCvclkhlmoAVS/hcVAr0FSMfq+hHHjbsUgvQO5pf7ES4CbLIV5Arlfci/cHCzab8ZvFh2XEAT2B/Y8pYM1SG8vZmaFRaDpdTK/oeq9TFZLFfrUlAFHIBnNqEUpD4z/oNcd9zNuIYf0bmde9pKSbgy9ENNRtSNxFX1qab7mBhogIU1tVGejJ1qOwluHs8YH7Kikawr1EKTa3etmASDGYmFuHzheEhkj+Agkn07fpWxyruJBVr1CbJxz3LQCNW35tAdJ9/MO16nNt26be3B1NWiewYeA2U9UWQN1vV9+ErutGAnovsdEMRdrxlPD/rbbVb0y8kDdl/uVi0CO8WnQ1wwHVmMnVVmCkVA7qxSntJjrap6xmkMZvDORH/z5vbAwKXiTXzmtpYRRMgbN2DWi55WFE45s0k+kstS7qw/DIZKUtB/5epz5n+3FNLP6TnSTkxmsH2TA2SBRoYvSWg2elF86Px96Oepbz9NRibxw4dI7eaR9kRKsrF6uajSA3GhHRm/MMd/BqVkXPxJQpKhd0GLbr2tK5DMK3dBjrkqH/vkZRf9w+zNUzQ6hDFwpoBo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(4744005)(31686004)(53546011)(5660300002)(2616005)(2906002)(8936002)(36756003)(6512007)(41300700001)(186003)(83380400001)(66946007)(66556008)(66476007)(6506007)(31696002)(8676002)(6666004)(316002)(86362001)(38100700002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFh3NTdtUkdOYndLVmkzakZNNjYyWlpUTjBHam4rMGRvdnBxbzZybzlZY09E?=
 =?utf-8?B?UkxUYngvV0doNVFjT2tjQXNnTnU1dm0zbmJLSEgvWktwSzZIdEFCT2taYXpH?=
 =?utf-8?B?RjNLRmNyanNJN1hSK1luMzluSUlJbDlSdjFhZ0lscE5WZWVjQkFLTXRTT1Z3?=
 =?utf-8?B?WWVrSTZOaC81L04xdWw1NkY2M2xJKzM0RjlFMi9pSHBncEdhc2J1YzJPeEFp?=
 =?utf-8?B?blhGWTdzUjczRmh2dUxRQjlIdzFZUUhEMFFpTUR4ciswRVpmWXhrMnYvRFA4?=
 =?utf-8?B?RmoxOHpzNzMycG5ZaGZTK0hDKzJMeHFJMzY3ZmxDcUR5SDBoR1VUalUxVHE4?=
 =?utf-8?B?Q0ljTWpsYnFSRzhoQXI5YnBET1lVWGRVRzBFRHNrc2RndVNyV2I5aTc1dVZk?=
 =?utf-8?B?T0RNTlk3OXEyNlg3L3U5a3RWUUdLdDJxWWtvZWVPQjd1Qkgrb1YrQzE0amVa?=
 =?utf-8?B?OWwvSXV5Y3VkdURNZVlHYTIxQnNoMnQwMzdoeFlzdlY0bHhNN2dOTVVKeXdQ?=
 =?utf-8?B?RWtiVUQrNlB2Ui9PNFlzd0gxV3M0MFl1L2lKQSt1RWxyVWFQcDJuUWlvcnNu?=
 =?utf-8?B?UjNLa1NVSGFlWWpBdzg2aTdMZE4wbEp0Q1krVVFvaDA2ZDk1RVZiMGRaSURJ?=
 =?utf-8?B?eGp4dDZERVFoREpVTnMxL0V6UmorS3QraDFjaTVOeW1qWFgzSFJDLzF2b2RL?=
 =?utf-8?B?cjhZdE0rYjZZdUNiOExLYW9wYUVrVStjQm5ZYjZMQW1ha0tjNWJxQVlHdGRR?=
 =?utf-8?B?YVJEdDNMRGtTVFJPMHhTdGc5TVNuMHpZWWxnUlFxdVVmak9DZWtGT1RmbXh3?=
 =?utf-8?B?MDZ0Y0FOMGRRWEgzYlZNcHkzRmk0alVGaSswaEVHWmJhWnJldkQxVEVuc3Ni?=
 =?utf-8?B?TkhPQ1ZKcVNMTGV1Ly9vaFFpdGw2SmFXMTJrRlR4Sld0NTg5cFJjQkQ2dkxP?=
 =?utf-8?B?TERtamdveDFjVFB5UzRPbzQ1SDRDNWxNdlc0UDVpek5HTUZBQTRwWGNWRHhJ?=
 =?utf-8?B?eFVnUlhMd0tRamJtUW9kTWtVd3pWMW9NT1hKUE9INnhZRTdaZ3Aya3hGNEVY?=
 =?utf-8?B?SW4rOVZaSWJQck4va0swZWtVNkRuUkMwcDYwUGhtdEUySUhVVVlxRnFiTHg4?=
 =?utf-8?B?Uk00ZTFRUWFFMytqNStmQWFlamVWSk5QNXFVWVl6ODBBK1VpRUlOUHk0M2Yv?=
 =?utf-8?B?a2kvTVJTNEtrNld2TzFWYlBEQjhWUzB4Y2tVVTd2TFYvSFg5eHBWY1lqUjJO?=
 =?utf-8?B?YXdKZU83RGpwOG5lbWlNOWZvUkVJZkVqd2p6SDhOVEllVGI3RTZzVGVHWE41?=
 =?utf-8?B?c0paZCtSaUxYMnJ1all2Y0tjOHlpOTlvZDg1dlQ3RmNIU1Q3TG5sOEJnM0g4?=
 =?utf-8?B?WlZZSHlLYnlJRlUxS2hsc3ZxNm5XMU5lcWJML2pxczd6SFN3aDhLWWlvczdo?=
 =?utf-8?B?L0ovd3NMdnIvdVMvZzRoYkVIcEpEWHJhV0JQazlvaURXNG9sQ0hGOWJFVDlo?=
 =?utf-8?B?R0d1VVZacFN5WmZYUFE3cG5jMy9BbVNacy9EVVdTTjBaZ3JIakJLSmMyNlpG?=
 =?utf-8?B?OVF4RzNpYkdiSEVKRlNrS2RFU3FPOUo2endVcHh5N1FGQUR5Rm52SnRIVkYw?=
 =?utf-8?B?R0tKZ3RmL1RpcjFmZk9rL2phZW1Scm5WcEpqakhiR2tjd0l3N3k2WEVXVGlO?=
 =?utf-8?B?dUwrR0tSdkpKZHRQaERNR0tnYUVnZmhzQWRwWGlDcjc1MWJzaS9PaW5TT2ZO?=
 =?utf-8?B?REFoSytOVUdTSmZPd3o5cVdIRktDQ05PSTNDb2J4VDlkaGJ1WEl2ZkVzVUl4?=
 =?utf-8?B?cC9MOGo0N0U4Yk1LTzVyaEorQjV6cUhjWXRWaEJWc0JVRVVRZFNNbi9yNE54?=
 =?utf-8?B?STByNnZRMlFROEtrZTJlanN3clZiVTNNdUNWekdqUFFxZk5TbzJ4aHRIUEh5?=
 =?utf-8?B?cVcxZ2s3ajIrcUlsaUxTRFVpZ09TN1JpZDdmZVFJcDhpU3FnakltU25CMDFB?=
 =?utf-8?B?V3B5Q3RoRU0vNlUvMkliTEFyMEs5QytPa2pESU9JU2Jxd0gzWHQ4b3R0Rm8w?=
 =?utf-8?B?KytvSExhVTZWK3lRSmR1cldoMURkbm1SS0JFeGVnbnVvbG5jZTFHTTJZbmMy?=
 =?utf-8?B?MU9Xcng2dHVZdCsyWmh2d3Q4eUFtWGQzNnBBai83QXlHNXNNWGJEZWJMSTdO?=
 =?utf-8?Q?OpGwNOM7AnjSxJt1yg11W38=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2b3ef2-2b12-4765-ca84-08db04e957c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 06:47:25.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgIuEWjJjGg8J5SroedlVCBIiXUqbr2yc6UN+rnvmoXKsphsJa8Dy/wqcFahzpa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/2 14:28, Anand Jain wrote:
> 
> 
>> +    bioc = kzalloc(
>>            /* The size of btrfs_io_context */
>>           sizeof(struct btrfs_io_context) +
>>           /* Plus the variable array for the stripes */
>>           sizeof(struct btrfs_io_stripe) * (total_stripes) +
>>           /* Plus the variable array for the tgt dev */
>> -        sizeof(int) * (real_stripes) +
>> +        sizeof(u16) * (real_stripes) +
>>           /*
>>            * Plus the raid_map, which includes both the tgt dev
>>            * and the stripes.
> 
> Why not order the various sizeof() in the same manner as in the struct 
> btrfs_io_context?

Because the tgtdev_map would soon get completely removed in the next patch.

Just to mention, I don't like the current way to allocate memory at all.

If there is more feedback, I can convert the allocation to the same way 
as alloc_rbio() of raid56.c, AKA, use dedicated kcalloc() calls for 
those arrays.

Thanks,
Qu

> 
> Thx.
