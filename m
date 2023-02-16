Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207DE69893D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 01:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBPAYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 19:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBPAYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 19:24:33 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C66457C0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 16:24:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE6ZXTMGl5iO4U2yykDfi991LDoC9CAGUy4mU1prd2/HOTzeRNKEEP07RfAe+12OAXZh4BM49A7AP+4RKFRXJavQMOoTvJB+MvDGlS5SZVzdzoEZCk3hN206qHymadF4bGvfc/UcIyyexYk5AbLByPaVw/SdDDOspFAcx9p/Ni+UPeIa+cMyHEkp8N4ZsUQuMQQbnWxrwuG7yLn+GBwWLg+OsE2x4eFOovu15DQ7Irmyx2DLWfs+XSxwd45+Dvu0RY4If8NAbeoRrSRrd0KD345CbP+73c6j5LSeT10E2AIUty1NmkC2OiiHgcy4+x89Ps80EiuN9/ediThij6BUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxdtpN+EvtSwZU3oNaCFyVlG6RWv6INFZlSFRh+/Sc4=;
 b=UadrKyOAfEZm9t8igm5uGxOWfrvNVPDwz2UAICrY5hPlTT86IOcznQD0Ad6lbmygnXK8HWEYonlA5z0qE04No4nMZk3V+sIrGBt7oJCnxpiOCAgUgfIAbO1Qp2Xmex3tdDuOSf9vP8dpfdZ8rDim+Uw+8BKshvAEw0gq2F7H6qRlQ4BXDIS0S01ZGxoBa6HOZvY6TiLo8ThX1LJ5dtyndFH5RatgPzj6TML3tF0UUU8Aqb65TLk3V2Zzcwc7JVPpI3NEGvjoQTPDSdQB8oId8nTco2jnOI1IF9Duhvkn+rtkGOixhp6aT1KqGCy9FLj93cYfhumqJS0e85Rzq8Ca7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxdtpN+EvtSwZU3oNaCFyVlG6RWv6INFZlSFRh+/Sc4=;
 b=Lt+aIOi66a6PWY8iHQeP50caVfVJ7bYb8bVcnwyqQPAz4necClqPw1Idqaqh/sHDa/VU2M/IHfgKESlFoBp7RqNJC9GBjgy6KJWroJLBzFPkReBQoxsK9WdIwkRrmhtbOLHb30Uod6MBU3jqe6NTtWyczW4SUvSws23Rahpzdt37RMdCv1bHCuoaQi1IA/szEd12RAcL1XqnTHZnPuqUk3CaCFhLtB9oEVtQ2RblW1LntGA/SmMi+OmUt0CUiMZVYoqpPBXSon2469DoQxR2D7eG+1i+fPmRMjtUqtePEjZ+9sJ57PdFExaJwVNxmi3jrqLTgQK65gmlUCUybtk2gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8588.eurprd04.prod.outlook.com (2603:10a6:20b:43b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 00:24:08 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 00:24:07 +0000
Message-ID: <013dd429-35a1-a941-5cfd-034d4992714a@suse.com>
Date:   Thu, 16 Feb 2023 08:23:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] btrfs: replace btrfs_io_context::raid_map[] with a
 fixed u64 value
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1675743217.git.wqu@suse.com>
 <f82eed6746d19cf3bea15631a120648eadf20852.1675743217.git.wqu@suse.com>
 <20230215200703.GW28288@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230215200703.GW28288@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:404::13)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b82af38-07ee-4b0c-6f21-08db0fb41ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbDcUx3iJuKVpt52MZJoukd+7uIS8j+7qS+RWYUT/ijSbIF11TB03D4iTVE+3aAZDnDxF5zCF1s1YR9PJMRBXRIxqK/G4uqDG7Brg6t45Kked8MTHnxqTlFVB58G0UETJL16KD9SqfmwIb1EhTtQbNFT0bpDro16WzP7rxyMnp0U+jfd640+VHYVbPGFrFp9iV/UiD7c7Fx6GR9Ne6woIPUPqWyuOM8HFn7yImuE+NzoSi+WEVAD7TWgeg2M5oVWcPVU2NJkIqtlSl17JGCnnu7IE0YPQ6p0uG1aUHKIp8Frknp6miST58WNv8As2dSPqPn5lQMHBxZQAo9U/7vUEo7ojcREERZf4uqk8cix65p3Ju2E37swVsWFREOwy/NLwdiGVybLdINi1MLdgMK2lg5jMEPg+beETSzaQBXtPygBJZARYeRkbyjEz1BTSKiYhSyWY/jufr//5ZcCUFdo71Thb1VcJ3R2xCjwI3n9NdIb1pUTSIX9RGw3SSv6Qd7XcP5xN88AcHE/JI+ICmb18Z+nWfNiYQsn0f7ZPP7lfz2ZiF19vXs5Lk8+1tPnOCJ6r3MvsC08V5RVElHtP830hs/yXnQKw5r7yC2amyLLcodGLFVmGMfnZy0m/J+e4IPRTour1x9+LNmhvqopEih+tpF6pUjTKN2ODKXphgJsF95vy3027Q8ISIQ74df7GB1hG99LwnnKDSnqzHAy5Cdj8ZmyrvqAj/KTRGGWKLyDUaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199018)(36756003)(316002)(66946007)(478600001)(6512007)(966005)(6486002)(6666004)(53546011)(8936002)(66476007)(2906002)(8676002)(66556008)(4744005)(5660300002)(41300700001)(6916009)(4326008)(186003)(86362001)(38100700002)(31696002)(6506007)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29xYWxWbXpoejRzLzBuZlpRbTBZcDNPcElZZDhSTStCem1ic0VvWGY2bm9w?=
 =?utf-8?B?OEkzaGtsREQ1YnVzQ1ppSEJJTDdZWWNOejFNQUY3TlRHSmE2UzAvamRSRzlP?=
 =?utf-8?B?VjcreUdxVnE0aXRLa25MMldzSmttZXd2SmVhTUhrN1B2UU9DZWxxR29Ub1RV?=
 =?utf-8?B?S0Q1NUFRVlJ2UzJlMnNlOUVmeUxZOVFwb0tJUUxJSFRNV2xBQ080NWllSW1F?=
 =?utf-8?B?MGlvdXNtVktZZnFSS3YwbE1WM0hFV05pMFQ0MTRwN3ZhOTNVSWlYZTIwUjBj?=
 =?utf-8?B?Zml0a01WMlFhdisxS3lGci9PeGFrRzMwaHVYTnNaa0ZBMkdoZjE1SU9SeTFN?=
 =?utf-8?B?dTAvZUw5Vk9tNS84OG1GbGpNc2d3bTJDcXcwVEs2ZVdPZUIrVTZrZXprcVBK?=
 =?utf-8?B?T1BnbE9qSWdGWTNhQlB1Q3B0YzBESzhtb1daYXVNbFNEd3d4TThkWEF2Wmc5?=
 =?utf-8?B?S3NwYUR0a2tKQld0cGd4c3hNTjhRZXZ5Ni8vSlhTTkZreDB6VjJoamZQZDU2?=
 =?utf-8?B?TVFZQVNaQVVRUVMxVGY3dGdXYXhkbXF6WXA1cWVXYmU2d0NnZEdsNnVmSy83?=
 =?utf-8?B?MUhqeGRuUGpOTVlNYXN3YWliWkJkYnYvZHYxcVdyWWVYZmtQU2hVZkxoTThN?=
 =?utf-8?B?WTdKYWI3b2tsUWViZ00vZm1pQSs5ZWRjdkZrREhvNHhRNE41L2NvUlVBRFdJ?=
 =?utf-8?B?c0xpSVZZbllBRGx1dy9QWjJPRiszMUZmS21KNzZGa3JqRXk5TW8yTlU4WElw?=
 =?utf-8?B?QzEzT0NjTENKUjh0ckt3TEV6ejJldE5wQ3JNdDZlOURlbmVJeTc1bElyYnVy?=
 =?utf-8?B?MW1MNkNZMFlrVzlZT0lsYnJldllzRS9SZ2NTb3JLR0MweVk5Zm9DcUt1aFph?=
 =?utf-8?B?MW1MeGJvR0dZZXBSbnpNNU9XR05hNmtQOE1mejNKN1c2ZVlCSFVVcXVIVXVp?=
 =?utf-8?B?aDRaN1FzZUQxUTlJRnBsakprM1A2SXBJUW5aSFNEWHptNFl1aXhLcEJEemNz?=
 =?utf-8?B?WTVvdTJOTHBqSHFtVlNEZHIzcTlwcjFBOWxpMUE1emM1RmZONzZ5Wmc2aGh3?=
 =?utf-8?B?NllzNjhJOVMxNTJvb1VvUm5UcTVJNHg5bCtCNnNCcXdML1BMeHNjV04xTEc1?=
 =?utf-8?B?QzhXOC9qa3dLdEFWTlQveGZ3M1lRKy9ZdVBrSDNtcmhzczJVV1hzRFlhbG11?=
 =?utf-8?B?dVhuV0NVaEdIZXJDNUpEaHhCQVVUNGtWZnkvb1ZSdlZveUhGMGwwMmNrUC9j?=
 =?utf-8?B?RFNGMEtTbEJiOERQWFdZUktERDlEZjF5YzdUTGJodUhrejJzQUJ5VDRkdGps?=
 =?utf-8?B?M05OaXZxdTNEQVBqUmd4aW9BNXdYRjVXNzNScE9LZHR0T0NDcVIvQTh4aDdO?=
 =?utf-8?B?UEZCdXZZR251NGs3SEN5RUg0QkQxeFQrUklGWGQ4ZnNyZXVkVi9QbmRyWkRM?=
 =?utf-8?B?ZFRsYjUyTXQ0bUlINjZPc01OYy93ZTg2alJmdkZMRmlwcXBaQXRRVWI0aXhD?=
 =?utf-8?B?UEc0YWRxSXVuSy9UYmE2SFRpdFBRcjZXSkwvWWoyeEJaQ0VjV2lyMDdBanhD?=
 =?utf-8?B?RXUxR1FyWWVXL3lTZ3JBb3IrYXdrTFlBdWdtekQwS1BzTUpuSnZSVERRK1pF?=
 =?utf-8?B?VTlweklyK0hIM2dJRVJCRHdxNzJmRlk5MFIzQUFmZlhUdnltNlIyQUx3R2Vj?=
 =?utf-8?B?bUgvZGltbmwwOGVPRWN5SHl5NnJGNFVGV0g0ZjRSSWhNeWRUQzBLMFlIYmN5?=
 =?utf-8?B?RkJEWmpGRk8rV0hQYWx5SnlZaldzUG1lbGozSEs2Tk1sOGZyblllYlhFTnEw?=
 =?utf-8?B?aWhDL1pwS2tDYTZKdEltNVpKYzZqU1EzeGdEWXFUWEp4dnFYZWFXZGgzbk9F?=
 =?utf-8?B?UThERTVacjNMKzZSd3owSG1oRDdpeWVIa3RkSGh5eHpIWng1WG85SGVGYjJM?=
 =?utf-8?B?ZWw0aHJod0hEd0pUZVliVGhsckR5eDZOckVvQUUwWmtnQTRSREFEdHptbnAx?=
 =?utf-8?B?d0lQcTl0TkQyZE1iNzdML3ZxOHJMOWZ6OTkzT2Z4VlhXQ2pwcDNCamY0Y0FR?=
 =?utf-8?B?QUJLK1Y0MDRqVUNzRmtvZklxL2dROWdWK0RoRmJJaSsvc25HTi9zNDRrVkN2?=
 =?utf-8?B?VzJ1MitFN0RrMW9YWEZsOWhYZmxLc2ZvMjcrVHV0L3VqRUx1UzV6aWJVdTJJ?=
 =?utf-8?Q?U/xYJ3u6VUAAU9QBjD+pigu5Ovgf2Od2S7YM/wpAme0B?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b82af38-07ee-4b0c-6f21-08db0fb41ded
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 00:24:07.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPgqFUOILXFiBss5Ueo9GrA0eeqHhjcOYKO0NRdJFf20zFthESCzhs8klD9j554o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8588
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/16 04:07, David Sterba wrote:
> On Tue, Feb 07, 2023 at 12:26:15PM +0800, Qu Wenruo wrote:
>> +		/* RAID5/6 */
>> +		for (i = 0; i < nr_data_stripes; i++) {
>> +			const u64 data_stripe_start = full_stripe_logical +
>> +						(i << BTRFS_STRIPE_LEN_SHIFT);
> 
> BTRFS_STRIPE_LEN_SHIFT is from another patchset and there's no metion of
> that dependency in the cover letter. I've converted that back to
> (i * BTRFS_STRIPE_LEN).

Forgot to mention this series is based on the series: btrfs: reduce 
div64 calls for __btrfs_map_block() and its variants

https://patchwork.kernel.org/project/linux-btrfs/list/?series=719082

I strongly recommend to get them merged in the proper order.

If needed, I can re-send with both series merged with proper patch order.

Thanks,
Qu
