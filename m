Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA25B81D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiINHLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 03:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiINHLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 03:11:17 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10084.outbound.protection.outlook.com [40.107.1.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BE761D60
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 00:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGIzPPkuMtbI2wwMSodQKimMEH/7tHNxnH7l0scIlXDTGbqvqLWxij7CZWjRjxVPZQwKi2AmUb22T/e7jUKc7nwp9DV5gHTcsx4GFUqmnZhkobx0TiMJ5Al+n4+dQxIqic9QXWNjJoD/HL0hoyxa+P9f47rnYY7/dZeVIi+e9+Ef/DJLY8Ii5xliXZPDNuxi9r0OwvpLfELTAzHhQ7Dr2DqDzAjl01gb6E0+5nDaBmLOjO/FC8F1kpBZwnRr/I+hPEpVploBj0SCxoz0B1nbrqVckA/7LxbRtdtwVtRVj/L+9z/pIFdOpKKvNQDbCl+UN4WcM9QhRiUXonAVTK6DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdhM1HmU0glChn5f33zgrobOykElniKC1fQMnww2j2I=;
 b=E+bNgmMttCsNBr7e4mRfLwb31poh56pO7F0R812sTieQuX32cJj3/ZqKXPqaSbShX0Kldc6+lJug2UJUj/9ACQyUypBQkOW8wv+14Er9o9MVcLHxNsj0hiro4Y3vSX17Z0ODUFWDo7nWT1F1CFUuldkTYUp2Cluue/Pqaa4RL5FiMmNiRbAx6B2fO0uIqcMjK/cKzVyhkPqtCGkZb8wxUlJ5FZkm11DR56rpUZMrM+T9R4ZRXInqRgJHivPoeBoyiS55Z/uYHSlo3LeDKgK6wxPBiUVowG61XhAdDXq7wW6pms/b/MnUpRlN2xjCGDc2d4MiknrkrpbEn+r8+UX67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdhM1HmU0glChn5f33zgrobOykElniKC1fQMnww2j2I=;
 b=XVvuxTLTESl7d43iJhnigBgHpd2Y1FHNqon0BgzUHpwOfT0D9MGD/+E2M7MpnfFOkdzy3b6UWUniADznc+AXdg9FtM5VAoeiF2JWiwjMmmneveqGWkjdmSMMdIlW+nYQkMeiJVhV+wii60HljlLDcbfVx7T2YPb/xRcmbxQkV8vFY0TRWGcKndKgTMXYicWWMamHsMdJfBqjiZtBFV+v/2kEcEXAgpCuMCznUptxxYDtV4dx29vloDAyb3j7bjBl0+5knDIptDfydRvocrxt/fVDvvGZwoMl5n6ePoSzRmcpYcl7jlNQdryZJhS7J2q36lRbcnAyCQLmPCuuto7YCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 07:11:12 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::f9af:f33a:99ad:e10a%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:11:12 +0000
Message-ID: <0f631df8-321d-023a-85fd-c80817affbbb@suse.com>
Date:   Wed, 14 Sep 2022 15:11:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: balance: fix some cases wrongly parsed as
 old syntax
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220914055846.52008-1-wangyugui@e16-tech.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220914055846.52008-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 663c62de-bd82-4056-2787-08da96204dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmGRBig6ZRtWPjFJbcKrZ7LYGelAa5hGU1Evxmj/zZDWwOH6w7PX6HgDEHsl6boqyaeIPLeDH3DImgtPN+9cpNjyWfiUGLd/8CmsQS+vbeBgbMCHX2eiTuxwhzq2488uZyfqPC/xxWdhwnZApiHqN1XMHKNmQPPy/N4mkfD9VoJxMr3N07Skva/PA3KtMo1zLJfjVQLF2GnqTOntBErUBG/Tz0xschAG+8a388aZnGaCqhb1KI3hecMWLhJ+HhGWTFaKQQW9omZzo/nhSlRHllj/6atmgF4pPKjGuo290AEf761hFgZEQD5dIVQ0BaOp77wlcb14Cz4sG7EASF+xDKFcHLE7DO2IcQ3ouq2Gbum+r7r6iZyepndeBvWRFoHcCp8rtvrpwzjF7Usg0PuSifgg+HTIz8QmVpBAKDDScYy3K/XGulLWtxe7Cwru0mLn5KuaFSf9GFbZ96jKaolJ3BWjO+dU+ewmD9H0muDDIsUYMmnA1782tUhUfEjkXdpjz8DqyKWKIZEc6ZYLxHJOVlFRZOqc1WHUBp3WXXZV3xCI1/5+W70Yx1WQ70oEC5cay/GdGNIDFvPb2JZ6g0J0IiqUZ68Y8zICehP+0OLoIODjCBEA8gZFnyn1nTJWlhO6FkrLIt6m7FGs2kEh6njEqpt/fCK2nK+qNczQ4FwqpzRbV0aWHjKPfBh1ZvD3aN3LK+E7wmoxKiWg0otmP4RYopfG4cSbml/cO5cgi00+R8nnsAEormTn+ed96cmfE4NoLdtuamIhRLwFo4GNkcH3JuxOp+97kSsdC4i4ns+y5Xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(31686004)(8676002)(6506007)(66946007)(8936002)(41300700001)(6486002)(316002)(2906002)(478600001)(6666004)(6512007)(53546011)(5660300002)(66476007)(36756003)(186003)(83380400001)(66556008)(38100700002)(31696002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDE1eW90WFMwTnpJdUpXRzI5T2VmUDJTajgybE9JVXo0eVI0K280YVpzWXAz?=
 =?utf-8?B?NGFtZGRPRXFhdE9xT0IxRTF4RmdpVEZ4WnRTQTAveWY2ZC8wMDZlRm1WNlJv?=
 =?utf-8?B?S3RRRXJjMXlhUzMybndaS21wU1VXM1BibkM0bWtoRXY0TnVvMDZ3R0R0L0Jr?=
 =?utf-8?B?TDZTR0FBcXZRVE9CcWl0dkhhaGduT1Vtbjl6Q0ZoUkZRL3pqdDhQS2tIMmpx?=
 =?utf-8?B?RTB1REpEZEVoWkptMXFJNThEaytWZko2RmFJVm12NWtvYlJZdktXcXEwZHBB?=
 =?utf-8?B?ZzVpWlcvKzNGYkloNThnWVpIK3V3SzJxWXFiWVZ4cU5HRTMrM0t0ODFtUTFo?=
 =?utf-8?B?RTVNTXZleFNueHZIS1JJVFNoUDdaVnBPR00xRUtvcldUdVJycS93NzlVSXJW?=
 =?utf-8?B?NWJRVUVLYTI1cWgrTUJNYTkybFFpeHVORlkrZ3hEdDNnR0FYNkFyOHBJYTE0?=
 =?utf-8?B?ZExYQTgrbGM1MVNSN1pKd0FwVmN5K1pQMnRVWk01a3ZOVldRSWJoM2RmN2pa?=
 =?utf-8?B?TTZrTFBYQVdEM21KaVN6Zkd2QUpUaXdGME9yN0tjL0krSEtHVlR2bVBiSm0y?=
 =?utf-8?B?SFo5cDhTR0g4RjF6VUxlbU9JRnBETm4zUzZOeUhKd1lFdkljQkNWZFJFMnIr?=
 =?utf-8?B?bWE0VUtYeEdiZUt5TFRmOU01WHpJYVJ5Ylo4bm95eXIzay9zSThUUldaeGg3?=
 =?utf-8?B?RDV1cFBha0lDbjh6Kzl2WkZ5SDlzM3dsUkJvM2N4N0xyU2xESm1Nb1crNnVF?=
 =?utf-8?B?NWI3YWhiT0xhaURmSSsvOWZCMHBXRXI1dENIZHE5ZXQ1VENKa0pNVmNLbDRa?=
 =?utf-8?B?TWl4QWlOZ3IwRFFkVDlHeHIxdTBIa0tYN0NieXFOcTZ2bklCRWV1T1FNNkJs?=
 =?utf-8?B?SGFNVDI2dWQwaE1xNUhLQURPRWxxakh1VmtYVWJ1ZnhhMWpya3NrZGhZQWZ0?=
 =?utf-8?B?bnI2dUtzTEtOSU5abEJjMkJSeXZMVkh2ODJ5VTFzSm9tbGxtTzRjamhpUzFi?=
 =?utf-8?B?aitDUnFHSHdwSU5KSXJVSS9jeXg5dmZEdGNkNGx4STlBakRSYjZzVDFtVEZI?=
 =?utf-8?B?NjdTazBBY1pzYUtTM216OVJQSHRBcy8zNUR0N0JRMnpST2pYbmEwUVIwRTg4?=
 =?utf-8?B?U3VOTitUYUZzaW9Tam5IWThtY0dCOXBaWG5zTUV2anYxc2l6YVdFOXpFcDQ0?=
 =?utf-8?B?TjQxMi9VSlRnVVlFeFVtRGIyNjVib3NMNEgrelV3M2hmREhQRmY5Y3BIb0lS?=
 =?utf-8?B?RENUYXk1TlZzaUpkOVRvMGM2M0pweW5nRjJSTGE2N1ZFTCtkNVhpaGU2VHNZ?=
 =?utf-8?B?b3kwS2dJc1MzREFRaVEvcWZWVUw4dGpIUnE5OXByMXpTZWFLaCtNRXpJWUEw?=
 =?utf-8?B?c0k3OEJYZnNMNnFaRmp1ZXR5cU0xSkh6UmtaY2U2dlNjTWgwNGxhYnhiQytR?=
 =?utf-8?B?ZEM4eEJlaVpmQ0tOcUlUZk1oeXNJcmxjc0N0czVvd2JId1hGVkthYUxPenQ3?=
 =?utf-8?B?UWJSZVJpb1VMVkJZKy9ObWxIYzNOZEV5aTFCclcyNmZWRHBxa1h2QjZRdVB6?=
 =?utf-8?B?YmtLQWRnelNjUHNua3JGMG1rcFN1VVlIUXR1NkJyeW9oR1ZwUWFyMUZ5R1li?=
 =?utf-8?B?bnRFQm9KWTcxMmlnaEtBay9SR2NYTjM1MzlsZFJNK0JQbm1yYi92MHF6VDJH?=
 =?utf-8?B?c3RNZk1qeWQxNExYenlXVzhBOUNTVVE0WEJHaGRtS0RZNWNyTDFQRFE1UzI2?=
 =?utf-8?B?N2Q2bTNWcVRDdkFtWWxDZWtCUnVJb3JvcDZySnhOanNtSHRDb1NkUWJVVmRJ?=
 =?utf-8?B?TWN0eHlDUWpHUWdUQVkwOHpON05aS0pIYmNRd3RIdEl3V3VsdXQ3NlRHNjlx?=
 =?utf-8?B?aU02Uk10R3A3ekVKbjltZndONEV6TlVjS1I5aGRXUU5IY1RZNWg2ckdaR2du?=
 =?utf-8?B?UytiL2pEQTlkenVDbXVySGwwNnI1aE5QTStjNFJmekhGM3VhMjNZSURpd2pz?=
 =?utf-8?B?MUMwUFdaakVUa29qNDRxdE5aZmxTNlZtQU1xbGxNbkZYMEgwRkI3WnhzbXd3?=
 =?utf-8?B?dkdRak50dllHdWNzUCtGbzRscWNpU3h4U09KdVRjdFlPTVBraFNDcnRlZE1a?=
 =?utf-8?B?bEYrWGtMcmhzcjV6MzhzWERhMStISC8vU29sUCtxWXB4Zy84QUVvNVRRTUxF?=
 =?utf-8?Q?L4K9UN8KjuKABXzpEiMGKkI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c62de-bd82-4056-2787-08da96204dec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:11:11.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1/9OEPeL4CQQS/PpfDqQeIYBE5eoxv31zC6AgYte+8NNpFdcp0VLYc2iOCdGxIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 13:58, Wang Yugui wrote:
> Some cases of 'btrfs balance' are wrongly parsed as old syntax.
> 
> an example:
> $ btrfs balance status
> ERROR: cannot access 'status': No such file or directory
> 
> currently, only 'start' is successfully excluded in the check of old syntax.
> fix it by adding others in the check of old syntax.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

The old code is over 10 years.

Can we just remove it completely?

Thanks,
Qu
> ---
>   cmds/balance.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/balance.c b/cmds/balance.c
> index c5e10f92..bafd1714 100644
> --- a/cmds/balance.c
> +++ b/cmds/balance.c
> @@ -852,8 +852,23 @@ static const struct cmd_group balance_cmd_group = {
>   
>   static int cmd_balance(const struct cmd_struct *cmd, int argc, char **argv)
>   {
> -	if (argc == 2 && strcmp("start", argv[1]) != 0) {
> -		/* old 'btrfs filesystem balance <path>' syntax */
> +	bool old_syntax = true; /* old 'btrfs balance <path>' syntax */
> +	if (argc >= 2)
> +	{
> +		int i;
> +		for (i = 0; balance_cmd_group.commands[i] != NULL; i++)
> +		{
> +			if (strcmp(argv[1], balance_cmd_group.commands[i]->token) == 0)
> +			{
> +				old_syntax = false;
> +				break;
> +			}
> +		}
> +	} else {
> +		old_syntax = false;
> +	}
> +	if (old_syntax)
> +	{
>   		struct btrfs_ioctl_balance_args args;
>   
>   		memset(&args, 0, sizeof(args));
