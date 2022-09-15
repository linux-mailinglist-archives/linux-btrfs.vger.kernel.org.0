Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647275B96F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIOJD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIOJDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:03:46 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37A94ED9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbajQHUpNYuDmJfpcB6Z1w3Z/B+Gvip+XrL3b7Q9Cii/ofk0bh14hEP818D/yNd57V0JgStKbMRbVdQJUDnuAFyj6RZsNkh3dl9z5ES46Wu6+Bu7x+WGuk079OajSC5uTzHqWRjtLYFas4ifYGQuqS0MFTtF22FWAqjOqYQaqS5ptvLO4sihzVxEq+pzFKOjMNYYdPT1siRRr30nVoAHwihuKHNAQMvuPVdo2b2GtS5BqBmAdNtqDwor+tiql5GGIup7a4s4G0/irv4G/Zk2zdx4mFpEgXSIpDjRXxRtWYPSVJsn2UeBXM2laDSKQ7kqawTAEMqLCYG5pLsDU/RxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBJ2MkuLXqom6ExN3T/LljVZ47qV76U9TAnfNwkbWdw=;
 b=O20ajibjWxp8cNSp7IWH+ZLgA3iDeWY1NmeD0ysXYlly1lZHaI77fLBAwFc1mPw18yd6s16tgeuikRTueg5x9X0wraJeUpyVXaiDPWx0et5yR6I1+zu7erctoVhp9YVkmD5jN2KbxZSZG4qATuW7/t2Z3ATe/wVicNQe7xBwWZNEAIMJaGuIvDOJRzODN7jggY7HfrQqkIoGBHgogAvTjep3uJ/4wQqaQwnRCR97aCQjx5AAgKCjfO6vHCr1MZmkGrTLMo3QRG3taGiHS66G/jJM0Ay/L6CQTQe1IedUa4tm8SCw161PbhTIw4vJAK0fXEB+ViaA9pmpB1Bm8mpm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBJ2MkuLXqom6ExN3T/LljVZ47qV76U9TAnfNwkbWdw=;
 b=dEGuvJEWFmPH4t/B72MwM+qcsyXnt2q2kfhOEzUrVd1eqYUG/+j86cPMAHFqsnWScdrPuBRwfcVzM1SmwZ64qbWTombt2u33t+h/pE3G6XrsvlHrUclR70ipLLn0j/JmrtZaBYCXoIvsaz0WzXFTPGJCfBEATyUpjD0qDjQ7Me9xI+FhZTS6Nsn82QLhMxp+i7ku0kLZEuqxkCXuFzgfvv4ThTZ7bWFPOfaPJhDGrDssNLIViqV736915xDc6rE3IJ5pPU6AMU/r8Sft1Ueaj7rmPHt4qvtI1NW64y7NcEHqsFNyyRicZvPbTiCVh6MggP8Wz1a+7oDls8RHA0nPBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:03:43 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:03:41 +0000
Message-ID: <e57bf0c2-5398-bf36-7b53-509eb7e738dc@suse.com>
Date:   Thu, 15 Sep 2022 17:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 03/17] btrfs: remove BTRFS_IOPRIO_READA
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <2ffc1a38bf1e342d2b1a44105b00bf3c8b57686c.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <2ffc1a38bf1e342d2b1a44105b00bf3c8b57686c.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dd5a66-dc05-4303-430d-08da96f92f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DthzY8y27rj5lXO4C2F1sOS9ox2v9CGNknmG9YGQqe4nzpAcHXsxCFXueomBNllINU7AUa72FcrpxfbKA/91qGnu0gY6Z+9RgtHS1Hfkrds4jKv4pvvadd2eSnzvgbWvF0gbfTSl3Kmyioh/JAt/P6lQV6Ry65vDMUntBhLQmGACbFbBgquMRiKpSFgBIswRE2N7NpGcW09h7C8dq0KPRv+QoMJr09lPr1jUVxDv3ChlJKiYE8SF7Z3sqCG8OuYX03ozWFLuf7/3yX3shLuE1tKpxP5VQ5YgHbuQ1QWA33JJWtlLE0P02NMSSNxWHcz55VIxTP7EoslxgccuiP/j8A9+TYCAxz4CXpGYFARl29WGDVo4gZPc3n7HalPxuY1LmgIAeFWuTXY3dWmvcFYDTX38Itn13pzK7RgtKPXR7KeMv/tE7R7wEicw4MUs1j7SS1GqPcbdkRpiYCC6dyEUOt2Ykp53dzyw9jXbhraInGIVQk/EhqeK1ZDb9EOUqxwrlzqbMD6cFirSI1sC3fLgOAEm8m5Kd7G5qaHBRVtSkUWdCpVsAnQkFW7Wz8ErbsbVdyrRVnXp9G2svcHC3ai6U0QY68FgY/hZEkjtasmxFztjod/G9y7JlTAKSsGgFenZPTCTF3nEdzlt8asCC0jmwxSKu9kZj/DOzElA8QiMkTvZyzuJ+DwJJ5HGQSDNfWHo1rZFgWdgdmoeyUEYlLfGh5aMJqc5ya340XgksRmwqUmbpgA8DiKkPJgyYClis3Vo9iAnui1LwpWDpx+0gFlKHXEf0k3ws3HmR6MoAm4CX6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(6512007)(6666004)(6506007)(53546011)(41300700001)(31686004)(36756003)(38100700002)(8676002)(66476007)(66946007)(66556008)(86362001)(31696002)(2616005)(478600001)(83380400001)(186003)(6486002)(316002)(8936002)(5660300002)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzZ0MDZtNHFKQkNNdHlGbnBMb1BvOXRwQktCcjVWV3hGZHdkYXlqWWFRTEZP?=
 =?utf-8?B?cDVJYnMxVTkyUTBmRWRlRldFUHhOZENzZUhDWG1zZEJ0NEZTd21xYzZFNUZR?=
 =?utf-8?B?VzlhK042bzV6UUV3SEE2Y2taWm5pdjFkSG4xaWt4M2pOOC9lWmZwc1VPZ0hV?=
 =?utf-8?B?TVlvK2JPczZvNGxrTklqN2RndVgzODlLZS9CeTlwQVM2TmRrN3ZTTUJJeWE1?=
 =?utf-8?B?Q01iY3Q0WU9MMFBIbnViaHJSUU9SN3VtYVRpc0UzdkJJaTRIUDM1NXlTNlYr?=
 =?utf-8?B?T255NDBwaFdzcWtTWjN5VDhwWWFrZy9LUDNSRW4zdGRBMDB5MU1seWtmTDlT?=
 =?utf-8?B?ZHZ6bE1DSEFENTA1WGtnTkxpem1POTdZaitzaDErS1F2TnBwSHNnTGlWSlE5?=
 =?utf-8?B?ZEtVZE0va3pteFFReERXaFFwaUd5NytnQUx2K0JIQnhxUmJ1T25OK2dDV3lS?=
 =?utf-8?B?WVNsUGZCUHcvUGJiQ3BRdTZFbisxUHBLUW1RcVp2NE5wYWprL3dxbUV3M1FW?=
 =?utf-8?B?SjBjYUhubjhxOU42a2xlVS9VditvQktzNVViVWVkeHM3L3A4QlMvSGdERUJR?=
 =?utf-8?B?VHpDTmd6RWZSdkVpTkV3TEcrSG9oaVZ2L3d2R0wybkloWUlHZS9oUE5mWlha?=
 =?utf-8?B?ZG5aWU96SkwvZ3E3ZmtlVVJINlptdUt6MDB4NytrYjY0TXNpT3FKVmxtUndJ?=
 =?utf-8?B?RndVOG1LTUU2OVZOVExvL0pDMGhqRFUrdFVKS0V2OVl2QUZrbEJKNmt2cnE0?=
 =?utf-8?B?VmJuSDN2alNnanBrVHdCT1RnUmYxTVppekhKTldjYzdLM0V4NGZKNGJMaWxm?=
 =?utf-8?B?RVBGdHJDUm1WZGppS3gxTG5ZdXRSajFwd0RNOTBaMkwzdnpNRDRmbjdDS2Jm?=
 =?utf-8?B?NTc0QTdTR2hmRU1YcUlPUEJnKzJod3hpOVdLZldwT0xHdTBwRTAyTnIxb3M0?=
 =?utf-8?B?c2hnMThsbEkxcU5JUGduUTJDYUp1Qnc2d2dmWEVGS25uUU4wYUZDMXJnWExU?=
 =?utf-8?B?MmtsaVBMb2hoSTZ2ZWk1TU5Uc3hkVThYZ0JVWjVobEVTbFRmSnVwRlQ3ZVZM?=
 =?utf-8?B?aGVNeVhGOGxlRnhmZ2UwVVFCYlNMY3dwQkdKdmd5aUdVNjFtakszdHk0NzZa?=
 =?utf-8?B?bEZodWFzU0x2TDAvc29QTmZ6SmJrdFNITDF5TDI5ZWc2cXBXc1dyMENSdE1E?=
 =?utf-8?B?bUduTzZydW1tZm9hSkxwK2pDVFowMmtDM1dOelcxZnMrVVhmRk0xTTRuaEZ2?=
 =?utf-8?B?SFFJelk3V3FYaVRoU3g5bzgxKzBjSlZqUGdxREk3MlR6M3UvaWR5UkJ6OFd4?=
 =?utf-8?B?clcyaHE0bU0vZHUxRHhlc0VneWE1cVZGd1BaZzBzN2kxcXM4dHl1Q3dDbjhX?=
 =?utf-8?B?S2lwYm9sY0JtSERvdmpGUU1wZ1RNMlhVREJXOTA2bVhpWEZMMUdWRnd2bTF3?=
 =?utf-8?B?bStRRnc1Yjhzd055Y2NZRExMdHdsLyszTFdudGpBTlR6ZFJILzJFS3BWWEtj?=
 =?utf-8?B?SGl5Mm1JK1UyellFcXc1U1pEU2NuSjlHbTZtKzZQeEpZU0poRmZnNXI0aTNw?=
 =?utf-8?B?cXFTS25XNHNDTm0zQjJ1T1pJdWRYbkYrSVFBbkI2M1hZNHB6UVR0bUdpN3I3?=
 =?utf-8?B?YjBFOEtvNGc3MElIZEh0WTU5NFlqZjJuWUNjNTRxUEFiWUx3ZFNZOExDSEM3?=
 =?utf-8?B?Nml6RWthTjc2Q0tQMFVuMTZYWURtbzJ6a0l5cHcvUjZmaGg1SXBFMlBwSlNM?=
 =?utf-8?B?c3p3ZGhHVVlGcDRWYWRkcXcxdDNEWFArZmJGckhnQWk5bnJlSzlaWC9sbFNO?=
 =?utf-8?B?RTdhT1JVeTdhWCswZlpSbVphK3pWRE05a1E2ZERJeUhDOWpTK1ErMnZ4bFE1?=
 =?utf-8?B?cG1rSXVraEZ2elJRT251VHlIU2FFdGFVWmlzMWxLMTJ4ek5uamkyNHRjQlZh?=
 =?utf-8?B?Ym0wMzNxQjBRRUtTdlU0cU56V21oY0FaTXZzeHlpeUJzaUVYdTlIMWlaQmJR?=
 =?utf-8?B?UFdnYS9xKytPc2pwbzRWRy9qSWtWZEJJN1hsT0ZRNkJFWUNObGZwK2RCR2Iz?=
 =?utf-8?B?cHZiVFBxRHQ5Y1VySUkvc2pZMERnZDd4UkRLbVBVRmhYN3ZOdEQwa1poVlZH?=
 =?utf-8?B?NmR4UWdPNGhvZEFyZzVjNVlHajVkWGg2dVpBUml5aU1LWGtnWWpNd1V4Q3JH?=
 =?utf-8?Q?q507+AzFikDh1vJAHmjejNc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dd5a66-dc05-4303-430d-08da96f92f83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:03:41.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP6U4a1vDEolOm5RfbDaFeQFC5WccoDgT2F9Kb3aP4QcMPTv7ppRsnyI4Lw0fbbJ
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
> The last user of this definition was removed in patch
> 
> f26c92386028 ("btrfs: remove reada infrastructure")
> 
> so we can remove this definition.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 3936bb95331d..5cf18a120dff 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -82,9 +82,6 @@ struct btrfs_ioctl_encoded_io_args;
>   
>   #define BTRFS_EMPTY_DIR_SIZE 0
>   
> -/* ioprio of readahead is set to idle */
> -#define BTRFS_IOPRIO_READA (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0))
> -
>   #define BTRFS_DIRTY_METADATA_THRESH	SZ_32M
>   
>   #define BTRFS_MAX_EXTENT_SIZE SZ_128M
