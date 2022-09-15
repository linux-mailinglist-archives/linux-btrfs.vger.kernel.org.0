Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557225B96ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIOJDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIOJD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:03:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5AA98D36
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE+lhxNHssXBR8PJf6AsjWz6WibOALV7PRnrQ+xfivbSTW9dGcAYVdefJUYFbdP6r2LKBeT22f7pfmLDUeyGGCYY7P4qtOWtgluAKb7h8Y2X867wxlqY+N97/fZ4tcPKSd0OZuhfO0wzA9ovd6iVjEVP4a1KCWT1eJi2JZA4gPY1qFby2VLLy57poxy2Frb5l3jnK8tWP62Gn5ORu8rcmdWFpiBnhbNk4u77Vtqqqln+vT8gVZdXsS5gEA2x05ju9iyAp0Pw4/3GlcJSH+HsQ1EjelksEPm4kRS06xbfHrlP0b4baQt5Aq6pl7smE4kqkq9lrt4k6MKo7FqJl+Gp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZnxYJHhqW/dbM2ybG89DC06GGvq4kh0oXoyMoryu4A=;
 b=PRvXBlmYS3M0XM/qAPtyMUHPMombp8I9pbOvTXyes8Z+pE9R1OXyqadxAszINJjgd/09T8u/ZeirKGFB1baJyh4DG6+DqgviU21Z63HDtwveOmHXogdc94HmG9O31SC3IYGWMC4IrnSfeOuJuGZmuAYfmZfa1PDCPvzmRJcan+p2t+kSmXhhLoCMiX6PuiN4uWZVL+1kc/nKR2Yl/KjfecfsK9+irzvgY63xZ70vExf1pbBrLHuvlYeHQTjie81KTRTTzLfoSfHMWP97ilTQslnIS01vnkWS35G5AccSPCJrXqanqkObTUdr6Tqy4NNCxubWLsFS21vvT5MKo/az7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZnxYJHhqW/dbM2ybG89DC06GGvq4kh0oXoyMoryu4A=;
 b=dImryLDKn3wdQ2cCq3GToKEHy/ZhYNhctI244dz0V2G3I9WlahFvJ6ac5NtXroljY9fhFmMDDQtkwDN6JGzsmTsc+r/28jbygLiLVOEBz/sOMMRAEetukfDAE5cYtBD3EWuIANfIOBRRacNVm5AUWjCr39A0ZEXbVXNpMD5xWSK0W23wlMenierfYzICcgw1vi3Gb3yaekeMhcGksZQee0iKgyibM3iChR84l3sfttWCvs7jrNjDxfFiVcJ3CjN6ZWM73vBaDwnYw/n7+VzKxlHWDfYps9kiWsBNHwnLYWgddNIaQheY/ovEGah8oB+eTPJIEeQV9QJWyvR3JswSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:03:11 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:03:11 +0000
Message-ID: <e6bf00d0-bfd3-15c0-0f8c-ccec4bfd6288@suse.com>
Date:   Thu, 15 Sep 2022 17:03:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/17] btrfs: remove set/clear_pending_info helpers
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: de1d5265-379c-4b9c-4e1b-08da96f91da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKYIvvqFMSxMyPaEwJ6ftT47USptDLSkYD+5GwbO8YSqW6cGLTvJaICN1Bo70xlZzTjyvtsqYz4KEF8pON6N5AnZJk94mv8pPvi+QMqPCwtMpwWTivX2Zx6GRvAmRCZsgsxSbUve3m9YB58Yt/3S7RFzuwDPOGZeBzhnnN7WKcwHuGVcAeqSBQJdr9i0e2Y0xTbgGBy8R72JIwJuyUxqPA1HNW3J6ibzrqSN7YwkK2f9z6tpToFTATNEvvYni5qJjqJ/Swsa1hTAePxmLX2a3tFh/EfREgn//yVnQd/RhGRKnjku4FWKum2AXkAEkLu1ch7XcHpfA+JlzinHRbza8bLAwm3LmSoQejRdA8WYFCM8YXx1cMasM2XQBRTp+Fdk6QiEzMQL1wtB5ubZ5m4oINuQf4x6OzW32Qcq+RbV+ivno66TYTNgnFn+Y3/y27u+yso54tALEnYMNiIfo+/1VDAvYtmrkarKejqptdGbvhyRqtg12t7uKh7K09x+6OuwhJCnaOTI2TKvUwyocHvuXDA7fJUqHat1gUttgJqHun9P7m50fFoQQeCGScsT9i29v3MoLTXVaEjqA/NcSHSwLMOKTGKGf50PNdNXsVqWhergtJjY4U8nXCnGzR2ZrDn4sOYLu5o/3a+48ydz/QS1UELeKK2bu3H5QKGH8g6yHXnt5YkZ2iH181Z+/VcKJmdEmEdE6KZ4sddQ4rAfHKksgBgOzLfMgPU4yTff4hcg4vsNaTOs1y2XgRwOfh5g4S+JFq7x5HkeYhRyDZVtzDaSD498R8CJmLWPr9sz0quD2yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(6512007)(6666004)(6506007)(53546011)(41300700001)(31686004)(36756003)(38100700002)(8676002)(66476007)(66946007)(66556008)(86362001)(31696002)(2616005)(478600001)(83380400001)(186003)(6486002)(316002)(8936002)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akF5aDYrSzdWYUgwd0NhS1ljdmFrTlhOclp4cWpsRUp3d2xBRS9KOTFBejli?=
 =?utf-8?B?RHdGejl0cStCN0RPbFIwN3ZBYkI0MlRqemdUeXVnOHlCVVFlMVNiYVdqMGZM?=
 =?utf-8?B?TTVkOTkzaHNvMG1DR1Zpc1pQMXAvMjlRUEZ3bXBBeHRraVdocTk3QzlHeElo?=
 =?utf-8?B?Vk0va1dhcEg0ckFsSVhTRHNmbTMxa1hvZzlja2NHbjI3NzZvejZ6dm1Lei9l?=
 =?utf-8?B?bFMwTkF3bFBxeTdmUGJGc21QdjdWMmZZcURINERTeWJCZWN2aGdxREJPdkVn?=
 =?utf-8?B?RXgwM1lkZEJNaTljV3ZKbE01Y0wyZVkxTTI4eFkrKzMvb01DUEZWYUdtQ3J1?=
 =?utf-8?B?MXB2RzJ5amx6ajBpNC9BS2dtTFU1WTRrNUNaTkpiRnRwSTIxUXNIbThzY21n?=
 =?utf-8?B?ZndTdlVYU1NBdDdHMERhVkx1Y2Z2NE10bXZLMkppSy9KRWo3eXhPdFBVMGhl?=
 =?utf-8?B?dUxSQ01mM0hHTm9NTUF4Q2NmenA1RWN1eVI3aXRaZ1VSSmoyRnFvMjJKMGJQ?=
 =?utf-8?B?bDlFYzBFb2pUSCtlMk5PY2ZGRWh3WTBLQkhhTkN1WXZXVk04NWtWd3F2VWx5?=
 =?utf-8?B?aEFPVFNQVlRwZE40ZzdvQU1tY3RaZGtNKzdOemxNbmtPZmtpb3IzYllnVEM2?=
 =?utf-8?B?S1lEUllVS1dHN0ZpSk9vU1dWdS9ZenIyZWg1ZCtDb0g0dWM4djVieTArWmZ3?=
 =?utf-8?B?WjdyeTNiRzVEeTBRbjdYYWtoTWpWYlQvYnhDandDVzZrTmI5VjRrTzdiNmxx?=
 =?utf-8?B?NWdBWDNCaWxmOVh6ZWJQNktkbmNvMldMTXNaajlGL1hQNnBJUWgzU2ZkNnFC?=
 =?utf-8?B?VitzWDdvUVJ5Nm8yUjZYUmxJVnA3d0sxVDE3bDVMRFp5TENnU0Q0eS9UN2Z4?=
 =?utf-8?B?VVJQQWU2VCtZa3d1N2xUK1E2WWRxMnoxTzdFYk0yMzFvQ0RsY2lXbkpGclc4?=
 =?utf-8?B?eHNlbmFtZmFOQk41RTBkUFVkT3lmRFd0L2o5aUlZdEUwN1ZlNnZlT0RKVVdC?=
 =?utf-8?B?VkduL2NLQlBuaWhUYkx3N3FhOE1kdU9GUnVzamw1WWtoU0lLTi8yZDVETEJW?=
 =?utf-8?B?bGdlVHYva2tQMXI3NmFvcVZMdDI4SERwTHhjc2FaSm1CWEhOMy9TalgvbjBw?=
 =?utf-8?B?OFFQNlpBRktjZ0Q4cGNwTDdwMGNGdTlETnY3dHY2Nk1jQWVaSDBuL1lJTHRa?=
 =?utf-8?B?RGw4WFFWVGJJdEFxN2xiWXlwNjV1SVM5aHRiaWwxNldDRVNCR2FCM0RuSVFF?=
 =?utf-8?B?NmVGUk9CZVNQSDRucUk2VmZVanVsVWVHNE83N2l4MlYzVzhCT1p2cW04ZFgw?=
 =?utf-8?B?azl0S1NsNG1WRUVwazN4SW1vNnBKRU9DZU96OHpXc0VpNGhDZkRXUTRrTXVP?=
 =?utf-8?B?Sm5YaDYwY3I0VEFxNXl5aXVrd2VVRGNHUnpOODB3ZmZkNDRjSjlha0cyRDRy?=
 =?utf-8?B?ejJWWnAxcHBrUzRnYXVTbHdwK3VSS3RKVjBsalBaQXVYcmFWTy9PUWlxZFZl?=
 =?utf-8?B?c2JmVVg1WGdrakFqdFNVTGhFTU1NdjlMVnVIYjg1MVIxTEw4TE54Q2k3NmZy?=
 =?utf-8?B?bXQrQUJOeGk2U3hTbkZOcGNIdEx3MklTbkg2RlM3L0w4MkYydEg1TXoxU1F2?=
 =?utf-8?B?MVFwdXNsQ2xDdEE4Ynhvcm9DREJraHU5b21aeVVXWnZDRmZZYjBURDd5MjdK?=
 =?utf-8?B?NUs4dldub09HVDQ2TXUxU0JnQVVEa3lwNURrTklUNzV3ZnlzTGRHOS8yYmpV?=
 =?utf-8?B?L2YyRmV5K3BsSHFOR1JmdmFDK1BWRjdiVStIcGczTlNpVzROTi9uOElFdU5z?=
 =?utf-8?B?NEZ6Y0dOTlZ3Q01NbTlBbklwWGg2THZiSVBhUHdPeG5kNTh0RmtVRlR4WVNP?=
 =?utf-8?B?ZlVKYWZhVmVtcURsK0kwNFFlSytDQWdHbU5EQ1JwSkMyMEorQXVwTStxQ2dr?=
 =?utf-8?B?Q1hCNC9BYnAxcHNxN01mMm1vczgxcldCaXd4bXBWU3F3ODdldTBNQVM2dmUv?=
 =?utf-8?B?MHlQalR6UzlNN2xlbkFIQjNvOEk1K3RYMnpVZk84THhDWE9QdFRuYStSelFo?=
 =?utf-8?B?U2JaaDRsTTA3T2dsR3NTUDhYdEJJMm1GWHdtS252VlUxenNpeUxqMHhOdlZi?=
 =?utf-8?B?dTRBSnpFdjljb1Y1R3hoU0ZzWkl5cW1Vc1EwSzAwSzkxbys5YXk2bCszTWlo?=
 =?utf-8?Q?GpXFd8GppBgbfVCBBI4B1AY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d5265-379c-4b9c-4e1b-08da96f91da6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:03:11.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc5qZqzYFapZQlYG+gOsLJwZs0zfbJQhJySZdOla9WhUpgjBcfeBDN8zHgNl2tea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> The last users of these helpers were removed in
> 
> 5297199a8bca ("btrfs: remove inode number cache feature")
> 
> so delete these helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.h | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8b7b7a212da0..0003ba925d93 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1644,30 +1644,6 @@ do {									\
>   #define btrfs_clear_pending(info, opt)	\
>   	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
>   
> -/*
> - * Helpers for setting pending mount option changes.
> - *
> - * Expects corresponding macros
> - * BTRFS_PENDING_SET_ and CLEAR_ + short mount option name
> - */
> -#define btrfs_set_pending_and_info(info, opt, fmt, args...)            \
> -do {                                                                   \
> -       if (!btrfs_raw_test_opt((info)->mount_opt, opt)) {              \
> -               btrfs_info((info), fmt, ##args);                        \
> -               btrfs_set_pending((info), SET_##opt);                   \
> -               btrfs_clear_pending((info), CLEAR_##opt);               \
> -       }                                                               \
> -} while(0)
> -
> -#define btrfs_clear_pending_and_info(info, opt, fmt, args...)          \
> -do {                                                                   \
> -       if (btrfs_raw_test_opt((info)->mount_opt, opt)) {               \
> -               btrfs_info((info), fmt, ##args);                        \
> -               btrfs_set_pending((info), CLEAR_##opt);                 \
> -               btrfs_clear_pending((info), SET_##opt);                 \
> -       }                                                               \
> -} while(0)
> -
>   /*
>    * Inode flags
>    */
