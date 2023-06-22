Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A49739436
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 03:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFVBDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVBDK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 21:03:10 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3580197
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 18:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG8EGmum7keQ/jFALXMuE+vEV4APh1xmGW4YeqtUoVZf5wsTF3gJfMjC/oetaAlS+9WgxyWW9ewV22OTEaszGehz/vUCPerzA84hgyFU5O8QZ6lBhVE/jefPNoy8M0fxeWHC1IjdyXto2LX3rwJ8jZaE812dQbj3vvumXwVbzxoMioTncIjjsg4eZhDQrpxcQ9pXqCKv8mfwDy//z06mLzpQAK+2WctUEEU80hXCP/O8Ll1r+7mleiq25JY37bP52G+NeZh/h6DEED3oKDkWNNE0jQ8a+eUM3FwSQV0Rk9Guj6mbzDkG49caQeGdCzKwutOt2Zf6ts9+H9MaEK+mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl5XZC6+R3eY92MB8n1UYpVlxmpGYjZJxAU4P0m0+/U=;
 b=aPPR5r4ExunVlF+PCx5PjN6KtUiPmM2QzvXou1y9uiN/BLtyXddAD6ufS0HcDk2fn6+acMpEW+d/bmcIxB6JutKmuBLf8ULSSukJST7beNWnXf71+rmAdr5kN4BorDjbWkYjmQSwYbKj26DE7NfPibxqwl18I/ju+mjCGme5f9X5avGq9yimp+Mz7rAzKKnbTUETpvbUjye2Bxg5YEiL6JNfaY7FOC02nucdNoLyjTxaDFmwhaXLUGeD4PML+53QCpBoNs6yZEBSivFA0SYskOpCl3qkVi19h9T0SZReIKS9EWGFMRghi/MdkRPGhHizmbPGPAqSywlkun7pOPTsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl5XZC6+R3eY92MB8n1UYpVlxmpGYjZJxAU4P0m0+/U=;
 b=WdXQr+BM3kovztJYH+Sphzwc4NEaxDIu/l7NztGZgmE3HUmsyGSOBOQDZmN/ktLmRoVNP/skVgOis1okTWcr0Qxa2zOb6mTRpr5UsrV9fACX3c5Vpp2KFSVBFyygNTJp5YYsig8XkgQCAjzgvHsEHQVJBIB/JHZnP5FvRCHHtDOvIA6QnDnqgUiNc/H5aInTFvLkcuNM5Ezl26HR803CEyvZQhavl+ZVu22q8DCkm7SXAxeG5WiR0Bup3ZIWO64uqBQpd1dIXPi6dvCGuaq60RERCm+upq0I1doK5r/CgHEqLztri+iv9jZk+KE380eMbCSiEPWwZh+J0Y3mORyJxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 01:03:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 01:03:06 +0000
Message-ID: <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
Date:   Thu, 22 Jun 2023 09:02:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc2b523-4a82-43c4-1148-08db72bc7010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjfcfBWneUIGUWb9nN4uN7e0mYj4Lhso5Cx7p1n94/iod664ZNMy7QX+Wxl3dWC4Fe0sEU3BjXl+fNEE7hFlkbSWuykLo/SJoLzYPHscUj1mVG3W0KQ/ta+7xbEyqL+1E3qrv1sLRED37aHF/Q8ozgzIbUDjwGjtknE1+s/k/jCtmkaY1uckYTKpMmJ2jSOJEjOQFZFy0TOprsBE/mVqtWsLz8qDnFuXHZzOyzRFzAdnLlWlrrWbnps2DQZrRThmkdAltheJQSgmSYB9YjAqCrCIZjaA7b8GPHXfK8cGMs/9q/ARthkSCt5MuYR1Q7xE/gxpjzgFlqBJ3EUR7THwIcXHFL94qhIwJ3PrEH7mK72jBlKRKeITnLlKkFrg3tBqOiQ+iE+biqeKSU1uTz8UK/gEjtRJRVMmyXtBzvpN1owifxHq+vhoR5xq/0kVQxE34TUE0p84QbGlXED8WsN7BCfFLKJO+4l8cuXGonnbm5Bcrx1ByVrX5incBS4vNcjAQ7zZZooa4Uh8UT9o9m5mCy2VSfyQsE28ErWQtGwDNzEDBNWNpn9YREM2MF0IDhKybVqbriPzr96law1JTIV+uo1J4J1nA/PBCe4K5qVtG2V67Hjf7TrGsTrpXSgesO0v1sf0bVaXo4XC6zBgvIxnUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(86362001)(31696002)(38100700002)(36756003)(6486002)(6666004)(53546011)(186003)(6512007)(6506007)(2616005)(41300700001)(31686004)(5660300002)(316002)(66946007)(8936002)(478600001)(8676002)(66476007)(66556008)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlBUUx4ZmFnV0tEbGNvUnc0MjZlOVNjRVk1MHRmM0lHQlVUVmdWMXRHTXhh?=
 =?utf-8?B?UHhIOCtTMXNXcFlNU3Mvck15Y0VUeFN0bWk2MVVsZzJGbTFUT1BRby9NeHVo?=
 =?utf-8?B?TFNTRzdhd0gvMHhFV21CcE1CSVY3UC9VcTV0VEd6TTZydUZpUDdRU09SQVVU?=
 =?utf-8?B?VkFpczFQNWRsemFxcXRpc0xLVWpJTkxsQXlZQzl1dGNOMmVIckMyWk5BbnlK?=
 =?utf-8?B?RW5UdUdTT0ZObmVRT2ZoOWJLK0xud1FXZXlUNktFckRNMWRsVDRmSTdLRFlv?=
 =?utf-8?B?KzB2SEtidm5aVHFMQ0xTcUZxNkJwb3VKc3hKMDM4YnhUWGtQOUV2dFVFcDFL?=
 =?utf-8?B?bVdzMzJqRytoS2lnQVBCdWZtUk5DYU1CY1F4aEllTjdhRWkwNzh5OVNCaU1Y?=
 =?utf-8?B?SERwK1FvamJhT2gwZGx2Umt0OUVuV3RpcnVNdWQ5K2w5QThkSWdVYlpiWkZ4?=
 =?utf-8?B?M2FKaTlJNTE4NFhGb2R5T3B6cDhtR3hSWjh6TmxVZDVOWno5TG14Wk9hYW1K?=
 =?utf-8?B?Tk9PWnpGS3RKVDB1Ynh1UnpBWU1GNnlyR0ZqS1hvTUFwUVZGUFo1RzBLQS9l?=
 =?utf-8?B?dHNLQTErSmJWcmdVN2ZaYWQzRTgrR01ablhmb1hXNzNwQ2F0V1F0TzFiTnhS?=
 =?utf-8?B?YmtmOVpnRVp2WlFJVXNEODlZbGVRRkpSUVNJWW1WUE10c0plRXZXV0lodHpt?=
 =?utf-8?B?dnorNlRONlhCcU1vQ1BVR3oyTUhrUktqRlVsd2hMWkM3aVhRR2g3T2thYlpP?=
 =?utf-8?B?ejBBSUsvTjdYSHArck9nenRjeWpKTXBScU51SnU3N3hwdmNlSW05VUcxMzE5?=
 =?utf-8?B?U0hXWUhNWkZSYnNYdnRnSTM1dElmT3c2RFVyczdGOFZnMnF5clhPLzNaUHVT?=
 =?utf-8?B?QmJCRXZ5TzBJTHRGRDRaN1prM0NyVHJBWiswR0R1VzFIMXZIb2lXRW1XVUVU?=
 =?utf-8?B?UFAxaTBxU2tiWWVwVHdjVTlpWmxhRWVxcUdUUTdRdE5Ra3VwRnhmblVSVVd3?=
 =?utf-8?B?c005ekVGSk5tSEVPcGpoM3VJN216cGhiSEVGWDYvRGp6RXcySXlPU1FnbkNV?=
 =?utf-8?B?UG5pV3BPVHdjNnphb3o0QWxrUlI3c3FYOU1ESXNLWkdYaU5nUHVseXNhU2RG?=
 =?utf-8?B?RDlxSnd0N1FCNEpaMUl1SnZCTkQ4OUVhdVBCbGFqeHk2aU12ZlJEdXpxQVZo?=
 =?utf-8?B?NnRGempCd1VPM1FvOUErbURRTlRFTnNOVEFaTmhOUllybG5ZVTJIcExBRTJF?=
 =?utf-8?B?b0NCdEV1SVM5NEwzQ2xjTXg1TzFXaW04WWVvVGl0dEJBR1lWcXdjdXBWWVFV?=
 =?utf-8?B?eXVzNnZxK0dMenJIUy82czJ5dXprSlpPNEdEbHdkNStwZFh1SlF4SkpQdVlj?=
 =?utf-8?B?bGNJckw3QzltZ3VEbFNtRVUxQlNZWDcvbTRHV21nWUh3QTEvWTlLUit5MlVI?=
 =?utf-8?B?OXpCSGVwOFZZSTFWYVc0bkFSZElkV2cxQmVxK3d3ZlZ4UENmWjF4dCtrK2N0?=
 =?utf-8?B?UUVyU0g5a21KMEFPZTJ6c090YnhHblBSaE9zc0FqYlBFOG9TUURzYmFDWXFn?=
 =?utf-8?B?bXVCMmcyakxjQUEram5IZUY5SjFLZ251enFVOGNQcjBpeUlZQmptRzVPdDFx?=
 =?utf-8?B?a1NkYUlKUHJDRzUvaitzSmtQbm8rdzBDT1hwOTNFSUc4TzZjZEZtbTdRQ3No?=
 =?utf-8?B?UGd3OE0vbWRQcXVwYkFrREpkZU1iUHczZmMrWWZqUllPTGY4NU1tRHRLQTlV?=
 =?utf-8?B?clRWN25WejNaeHdLTlR1SGtNWjJjMm4zQ0h1Qm9tOWtjU0toNTltdnlmVUlU?=
 =?utf-8?B?cENid0E4SnQ2UUltRTVONXgra2x2c3h2Sk1hbjA3MkZmM0FaSFpjR2VrSllv?=
 =?utf-8?B?QTZWNFM0WXhZdkZtTXZ0cVY0eXV6NXpYR245VXlUNVh5N3llMy9JcUVXdXZ0?=
 =?utf-8?B?L2I3MmNyTEloTVRtQm5iVnhRNE9IN0J5OW9OS0wwcjA0Mkh2dVRrSFRuWkpN?=
 =?utf-8?B?K1FXL1lUWWt6bGJlK1pxR1oreXBTTFowS0tua05rRmNUL0wzbmJleHhkTE9Y?=
 =?utf-8?B?eG9ZaW02eUppR2RPMEFtYnVCdkJpYjhuOTI2a0N6U2NFZFdkWGMxczVrTDdy?=
 =?utf-8?Q?qOiL72PLlwRb+Lol/rxaw5Ayx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc2b523-4a82-43c4-1148-08db72bc7010
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:03:06.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQlynjD7VBwcpX8M71o1eeR/CvRkre0hb784hxXxMaZrX5+Vvzf2BLKbE65Bhjwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/21 23:41, Anand Jain wrote:
> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
> failing because the command 'btrfs inspect dump-super -a <dev>' reports
> an error when it attempts to read beyond the disk/file-image size.
> 
>    $ btrfs inspect dump-super /dev/vdb12
>    <snap>
>    ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
>    ERROR: Error = 'No such file or directory', errno = 2
> 
> This is because `pread()` behaves differently on aarch64 and sets
> `errno = 2` instead of the usual `errno = 0`.

I don't think that's the proper way to handle certain glibc quirks.

Instead we should do extra checks before the read, and reject any read 
beyond the device size.

Thanks,
Qu
> 
> To fix include `errno = 2` as the expected error and return success.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   cmds/inspect-dump-super.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 4529b2308d7e..1121d9af93b9 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -37,8 +37,12 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
>   
>   	ret = sbread(fd, &sb, sb_bytenr);
>   	if (ret != BTRFS_SUPER_INFO_SIZE) {
> -		/* check if the disk if too short for further superblock */
> -		if (ret == 0 && errno == 0)
> +		/*
> +		 * Check if the disk if too short for further superblock.
> +		 * On aarch64 glibc 2.28, pread() would set errno = 2 if read
> +		 * beyond the disk size.
> +		 */
> +		if (ret == 0 && (errno == 0 || errno == 2))
>   			return 0;
>   
>   		error("Failed to read the superblock on %s at %llu read %llu/%d bytes",
