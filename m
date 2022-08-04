Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B4589A9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiHDKzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiHDKzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 06:55:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5E1116D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 03:55:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274AYEM5025561;
        Thu, 4 Aug 2022 10:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=p2AFo8gefJJAHt3z4JtuJ6V0NIuGNiak1DaOYZEjRt8=;
 b=rjM5nZU2przqeMN5LwXePhsSJKQdemV59ABew+1xOKBH/IrVyFtz+Tj42gNZgmjtjo/w
 OwsHLMihOlXV2l8GYnLWQRaIKwlQNVZGB2i6KRTzAYYqggt/QnDyR5NDoB88aEuyBvxW
 TqKH/uj/5zi516RvdSg4LzCVYH81pJ0D2O5Z+WM48ROrPRrqZbkLShzvhWzd+pnjKAHb
 B3AFY1BR7FbGOkVz+qlLfvrc3tbMw8KLC//dD8t38FbkLOkNMzAhSEr5RV8Sj+LQHhY7
 l68QWClHVGH8zU3kgmoGnb7jj9lgs5dIxuUsB92uSIZSTRj57OsFrCNBZ2Yk+BNruyfU ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tmj0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 10:55:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2749XwjU000580;
        Thu, 4 Aug 2022 10:55:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57t1ynk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 10:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crKD0Xfr3NMyTh/d3hIy7HvNGBM4D0Aoe9ywOfVfXtpNBdwhBhmITIXRHX08vyhMMjEbifDtBIQLSvwGgRcdJ+lVgm2KGsTY6PO/arQledzseHDr79RaWnGMm7zHjzPKD4jPSFdrQJarcg8CXEUJ5/H1INPK8NYNewo+D0BWU69Lb2EXRjpytCHKs8wuDvGkiC0Kj2bZFstEkmCZwUTGqyCe/l4uIb4J+4cPYHGs9N/oT218pnSMUerzc8H7Meqy6Q1417R6T5PEU2Dz3zctW+bJ7d/WFNgQ3YGRUB6BB5LrqY1qKGPrqFjoOescwepDa5OmiU5wVeDJV0xUA5BbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2AFo8gefJJAHt3z4JtuJ6V0NIuGNiak1DaOYZEjRt8=;
 b=D450RFBkQqkhspGpJ0JjnhJQn2kjHye7mBhbfJjiarb2JlVF8fR1h2+Ya9CMZZlcmtEHS5P1vexwG/vRdQxjn1QFtkAuqY+fLPmeiisQR7TVReadqiUaBMIOFW5lUpYDr7HS1V0k5G7QjJ5n2QLYk1LO/k/9s7VwqZv54xUuuES6rKtZegrtZhjRzgqo8JUN6AyW4nV6n5W8M0PLEKJxczVdq/xdMY3f0JV8x/Ttg/w3dNvnp2ookckRvJiAy1cVpsup7WyhvvUV393Npg2P98QZfF54SWFoyitqJa8MOMkRIbalIcMT7IMA5Yax+9SrVXnYi+euz8+Z2nF8sAOuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2AFo8gefJJAHt3z4JtuJ6V0NIuGNiak1DaOYZEjRt8=;
 b=ujq0AQJzAOJb49o/qXYusm9aNuoLBXgMh7EAWD1tMLHhQPH5djHSvIajgLILbe7mlS9fss9aw7U2qeTG9cBUfSbToWfvukvkALBnrCrDp9+uWz4v7tAHIQMFbLQI637oatKfpIdWzWHCuf6lG0pWtya6YOljgKBZ51QgI6lHhG8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MWHPR10MB1951.namprd10.prod.outlook.com (2603:10b6:300:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 4 Aug
 2022 10:55:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 10:55:40 +0000
Message-ID: <fbc8a68b-11ec-2b3e-305a-e3db12271008@oracle.com>
Date:   Thu, 4 Aug 2022 18:55:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] btrfs: prepare more slots for checksum shash
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <42f231d8d6f95fdc731b423fdc7c3ae2a6685318.1659443199.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <42f231d8d6f95fdc731b423fdc7c3ae2a6685318.1659443199.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6321ca8-7768-4096-e1a4-08da7607dec1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vioI3mluy5VgiHHPRfoPmJxv7WOOE/dsxkbVEPHAvpG2jn4UmXzsBCYqUsys2FLuUFzhjBNZumCZmEXSyb2i02vdgK1pl3/22LnqFlnbgzBUaylOeMFZgxluTFjWSE15H/IyLFYauri+fZ2RxFCPowLDh0Sir3aRRmek3ez2wt8o+Ha6sLtD+0Drhhc5mLB8mwDC6EFwwEdPlMYHJN2RyiMw8hdRm3aE+wugEPHbPYu9TaaT2sYOaVGtDRsnZBT0fzfcdai2udR0e36rpQW+CqpbPT23zgJ3e9HBcy/DS6LbLwxnTs4zYiI4StNloAhxCSNa71agAsh07sVfrEh7aX1tHpifnqc75zcry7DlTnieXVyDHr76Bb0Rb08KbD/GcmgTkRJndceSSdz1i7FS+iYsqdLzszjOgDefHX4Cc3ws7zpcmADHh2O7fUCIMuE3lMN4sMoQqtdW/8wGjSqm4MsG045BrA05vGaNepUAVb0jzEIhh//y2pMPQc+jBELi74xNVoiXvqg42DLlnX2m0/ZpVE0G1c4F2YlA88F3t5VgzxHEDrqMYLSyOfS2A6xxZdEfpe4P0VNL9SmHAyOHv9Taj3zOHaGy7zdnjip8V4s9V7W9o+EBmWuZF5r9JbvFdigGW+7GQjEa88nDWHBc1E16iXcW+YUpou7oQ41zZwUUBT0PJtcsZ4uBHoBHcPzws2ItdYsov2ClImnyxS183C9FxTYBqACc7U8iosony2+kxi/s+6VM2xzi/P6e6b77pNL8/N3Kjpwva64En9yNWUVJ0CiFnXfkDvl+28g/7c6mM7U45cgaanDAGa8cLha4NhSf+AjHTvRiPrW4H8Aag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(346002)(396003)(66476007)(6666004)(6506007)(86362001)(41300700001)(26005)(6512007)(478600001)(31696002)(316002)(38100700002)(6486002)(186003)(4744005)(36756003)(66946007)(2906002)(31686004)(8676002)(44832011)(8936002)(5660300002)(66556008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZPUXJhVlZqN0xCbXhhYnBNYmt2Vzd6N0VSWnVzRVZlT0NRaHlqT2VSQmRr?=
 =?utf-8?B?UllIbThIeFE1YUtvek1PMnBFaTdwR2JwRmg1Nk1BOHM0QTlnaTBLR3ZqVmwr?=
 =?utf-8?B?Ny9rWEtNQWU0aTF2R0UwTThZak1SNkFCSGh6US8rWXcvWHFuZTlSUGxWWGd5?=
 =?utf-8?B?djVpZzBuc1RMM3NrTGFUZ0pDWVVvdmVWVU52cHQ2d2Q2WENUVjVJcWVZMGM3?=
 =?utf-8?B?SSsyNERaR3B4UHQ4Z21tbkNxbVQvQkFwMEU4cXZ1ZGpQYko2L0tsbkNqWDJk?=
 =?utf-8?B?RU9jZWx4VmliSTB4U2xvOTdQSDFUYTBhZHREbGpmUGxVU3hCSm40VGl1a2Jj?=
 =?utf-8?B?SXZ0dDJuMDRTTVFZVVpEeWpVcnVyaWM4K3RWODFOTURtYVhzZ3VOQVgySDhG?=
 =?utf-8?B?NWZEQlNNZVlDRlNlb0JXTUo5Unl4alorblBMRm9lT3BXcnJENjFSMFhSTFdH?=
 =?utf-8?B?cVZFYWFiWlhNdE4waVVaN1MrNDFvaXdVY0VzOGVWM2JUSnR1VEVTVWRGQytC?=
 =?utf-8?B?NTJBaE1saFFCbXROT1NtSHEvMU5UUXM0VGV5cmlqNE5JenpQbWNvaW1RU0RH?=
 =?utf-8?B?Z1FRTmhGUmx2STJERCt4dGRwZWxhV1RjU3FQalVZZ0luZ3B1U2MvZDNJamp0?=
 =?utf-8?B?b3ZTNnVZSnhxeWs0U2NyTWdndkdZdmp0eWg0QzFWRXVPRk00ZzNCczl4Nlgr?=
 =?utf-8?B?S2t5UXdSd1lFTS9UT0Uzc1pNNENYeTBGS0VEMkMxdHRaVXB2YWppbHZ2ZXdK?=
 =?utf-8?B?L1RZaG5XbVVBeVdCUjlhRVFUYTRLckhnQ2JPUFR3NkF1MzVWRGYvUWxrRkJz?=
 =?utf-8?B?d2Y0eVlZb2luZGZaYnR4bFpTRmtVVkUyMmdZYUhYdUJtVm16YjFTYW1hdUhS?=
 =?utf-8?B?QmYrNFlhSmlRZFRadk9jWWJURFBySndKeXNHS2JETHRPcWR1QVBiTUZ2WXVW?=
 =?utf-8?B?TTd3S0JvVC9hQ1dSb2ZXR0FQSmsxMWRQUXEyZXhWZXNKb3ljeGtQZEcvRDVZ?=
 =?utf-8?B?aCtwdkI2d0NTWiszMU9IcHQwSWVDODJPblJxSG5pUUZLbkZOSnZ2N0RGRTJu?=
 =?utf-8?B?YkdoZUtQVVNWcCtSSzZhS3RIUHJEQ3lvUU5zM0RtMmMxVmgzVnN6eEpSTU1C?=
 =?utf-8?B?QW1rVFVwMGIzU3FWS2p0WGZ1bjhNTERXRU1UdjVlUmdOQkE3T2YrVWpJOE9s?=
 =?utf-8?B?ZVdabUhTaExFUkxXUHBEUXpIY0JSSWdoNUt0bnNEbGdZNFdvblNYQURpanR0?=
 =?utf-8?B?QXRGNkpuYnYwZDBsaS92VUhDUTFYbUhtSTU3Y3A2K0QvSkFJNFR2eUZ2blIv?=
 =?utf-8?B?eEVHNHJiWHpSWVJRdUN4QlNUK1AwYWwwalVUN1dtZDdMMGxUc25TZVhNOG1E?=
 =?utf-8?B?cUpPSmZJcXdjempKQTZJd3hMTjZDeFc5QnNCVXRCL1d6YTYxOFYwU3NxR0FB?=
 =?utf-8?B?QlU0ek53YjBBajg4b0ZkWnZ5YVZoQzkwSlNIYy9RNGprbktTOFFmWnhkRm1T?=
 =?utf-8?B?dEo3Qk1GZUNWNUhjSitTUHYzQ1RwWjlmREQxdmtDM3gyME5GNmRkWHpjNjVn?=
 =?utf-8?B?dVBmWExpU25VRWxBSGtNSVRQK1A2LytIY1E4VG1VSlNUellVRUNnaXpPSVJC?=
 =?utf-8?B?ZjR0Z0hOOStDbXpqVEk2N1I5MGI3S0t6azlpWXp1bEhURGN3RU9KZ3RkZVdh?=
 =?utf-8?B?aGpNVXozVHo1T3IrZytqL0NSQ1J0bHBqL1pQYXMxVVkzZnNYSVRnQXhMckFu?=
 =?utf-8?B?dHdGRjVpVTJ4OU1iT21rcC9DK3FFNXh6U015dnhMeDFOeXBFRFM2YlNCNGFi?=
 =?utf-8?B?MHMyc2RNRnFJK1YwbUpmTkZuZFNjMnRwTzB4MnQ3cTVPbm5zT0tUM0xDQXZh?=
 =?utf-8?B?enhRaVdCb3lZdGlQdkNPRmFuMzd6Z1QvNG95Ymw2MGVMOEFNRGM3bVZqM0xJ?=
 =?utf-8?B?c3ZvKzZjdk1mOGdIYWtXWm9paU9YMEFhUjhTbzdQWHpHLzZMSkI2UUI0OUlV?=
 =?utf-8?B?S3BwdS92dVhDTndRNWptd0IrRythV1IvbzV3ODRqcENtS2s5T0tFa1VCckJW?=
 =?utf-8?B?NkdGYjNPOXUwbDRqY2dub1JhZG9GT1FpejcxaWRnUktnL0hMRjhkcWhDblFu?=
 =?utf-8?Q?d/bF+nakGGxXnFCVb1ujrhLFq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6321ca8-7768-4096-e1a4-08da7607dec1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 10:55:40.3099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5fcTXkIZOt1/xLZF7EPB30jJCuVPbtewgOMXMsiXtCBXjjSWxAxwTOzLYyn7EfiWG63toJ9vF3uKt7eqiQkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040047
X-Proofpoint-GUID: O3Tbl8e9PnlpqPn59TRJOm9w92aPSEZi
X-Proofpoint-ORIG-GUID: O3Tbl8e9PnlpqPn59TRJOm9w92aPSEZi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6ac8d73d4b51..3c2251199f0c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -65,8 +65,9 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
>   
>   static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
>   {
> -	if (fs_info->csum_shash)
> -		crypto_free_shash(fs_info->csum_shash);
> +	for (int i = 0; i < CSUM_COUNT; i++)
> +		if (fs_info->csum_shash[i])
> +			crypto_free_shash(fs_info->csum_shash[i]);
>   }
>   

Right, for-loop has to start from 1, and

> @@ -2429,7 +2430,7 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
>   		return PTR_ERR(csum_shash);
>   	}
>   
> -	fs_info->csum_shash = csum_shash;
> +	fs_info->csum_shash[CSUM_DEFAULT] = csum_shash;
>   
>   	btrfs_info(fs_info, "using %s (%s) checksum algorithm",
>   			btrfs_super_csum_name(csum_type),

Merge patch 2/4 with 1/4. So csum_shash is in its respective slot.
