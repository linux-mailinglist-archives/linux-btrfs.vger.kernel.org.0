Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFA5BCC06
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISMlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiISMle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:41:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E927392
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:41:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx5IF006724;
        Mon, 19 Sep 2022 12:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C+lTtS6gEeT1TMCGhXQAgvrOQ68aXI3xVCZGlypeq14=;
 b=QOmOFseAr7xI6/EV6dSO76jWwJqaNLkG8bqQXv7iA7zere+MAfnESkrP1VFNyVBkowK6
 HIBU8lfl8D1m70aQNF1LkbXePVXhWo0yToiYqUEL7U1Mh7ZZEzARAY3CMBgWvUO052DH
 bxMy5N6csMIq20pe0YtbySVfLFQeMv+KNcFsFA/dgYIVojg5W2Me6jh1LUzQuD8LJVIh
 +L/1SbggypoWw2ZhXVgKANv+vrrg8psapCO/aube8HG4UvRGc8gA7LLr0541dVsk7x4a
 g2YeIsSONdzD9lgb58z1YPZOGB290NPQCE1AW9p0X1S+AdsNG6ThBDLAz/XJh4rq/T6F 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m3n5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:41:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JAvR7r036361;
        Mon, 19 Sep 2022 12:41:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39cbpmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg54z2gKsX/NaOs33EZx44xcmJcE7I2jcyPb/db2l1K4P2SSHJ+EsHIzyZJ6iGmUZo1eASBGxoKjJaiKQ13TB5gM6AJskamP56Wpzx+2Y/JLhYnrSX/9dOK3L1RNoYjcwFz6I97zZd4sP+gDAdRKEu+E+10kezbD/fqL//71usClRIacghCIyaC9yB9DBjPHnqHK1K2/GMKdFjUnkLU8jFbThMYdHBQvU3oufax281vKgVsWAXOBxilfODKZ/7ZzvSHlCAkUJMDubjEgMT3uM8WmuA1GYQ24daXJRMhQqCAjeZ+cMvMTnOHuwUypdtUOt0G6SL0vN9+HDUziYKziMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+lTtS6gEeT1TMCGhXQAgvrOQ68aXI3xVCZGlypeq14=;
 b=KClpSndw1p8jrd1yfjFj8mtnWrwSWjVOIzPwh0QXaQ7fJA3T8oIGrV1m7o2LVjEPUUxjFLHFsPxEIaomTD2MTwfIBaV+ZUqM5H2E0Cw6j1F/TqSVD4yyUM8RAOcvIzYIn6tXwvKqPgoF0ESZ+9uAEjc2DivMo1NSYrV4Faaos0ieoWjh9jgl30NpogU66UbhQ1bgPp/fdpLJmGLyc3gZY6n6WALPvHm9DjH5EXeFiuuHIgD9/z43b2l8kbqZaDAIkL2hEp/7qaCXlfc1reEKKbezyKjSvvfIhGXf7u+T+kdd5+JgUhjF8tuws6DXuFVQDWazCRN6dPX7/oZ/SOUq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+lTtS6gEeT1TMCGhXQAgvrOQ68aXI3xVCZGlypeq14=;
 b=KYoqfWqOfPpHixUyG4B1adCn2duUG4OqXxDtt2Cvx5mZZHAEK/Gh/MUcLSpDZ0UV16kHQKb4v13JgzWH10aViSUMXB2yFAMIdFVhv1X4k/Z2e0e/1Fl39Kdw/xjvRR22QIldGLSYtkEEgSCPqRKY9i+ApksgDzeCemWhIN8MYnE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 12:41:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:41:28 +0000
Message-ID: <d8335d02-8326-510c-6d91-1a397f21e887@oracle.com>
Date:   Mon, 19 Sep 2022 20:41:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 12/16] btrfs: remove fs_info::pending_changes and related
 code
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <8bffbf3b43fb56ce03776e779f4d166e42d9b297.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8bffbf3b43fb56ce03776e779f4d166e42d9b297.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a77d53e-e15a-4698-4421-08da9a3c453f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: us6PaJxTtG+S1o3a5oxXck06yctQORbaFi0ofTc/IUACAQbkc5hxGMHWCzrlVYS74dKK0K78obssf1bv7x9bjDa2mJoxlNyN8w+rIqpgfpBO9rTdM8YlfwtLe3ly//4N0X4VvGltBU3qDoPP/6V9RJvHwkdt2XxzWNGcYMERq5hRuBISvDCoivGDEjQQH5OCEilcNIWHxK18/b5TqS73+M2Ca9BQ70G0hHMTM2ny/KdYbg0a16YijrOY562MduHA4SgpTb39VdVdRUiG+jXKFReTnyyDWIa/0BmunxtTTT18rIyyJxlkMT04LVW0XWksxOq0hNdBeLZHJmCChaiPBmE8KbbWz3OFxNosnVJUu9y7kgPH/tJhrMGRnb8r3OVV/RYv3+i7Y/Hiwbj6qCL7TZHTRr7QtZQJ3OBC/2nuLa15QkT46AQnr0mk1FzPr9ceZ2IgNUy5i+8Xdr896FmqZ/iBTqSGGhYDVwMep/L8TyD4Rmn4QVveQ0yYHdbosx6WIUUWo/asy7X7o//a+1zm+UqqincO09aFvuyiU9SB5P8I1GKNus4XVwuxWnC2WIKuHNlzRGeE6fWcGfBPoPp4t3QYDrYumDKSarkHQNrWFVtQ+u4b1iHr5L2KPjmmGv7nHItBNQY+j7Tsar6GlpFMCbLgpQFvoADCDykZ5pmYYHBbGPhGGc614JV7EXmj5lx5ZHs/uMzoXhxaY5yfbIf/fJ0j5j3upUelQjIJjBYh/zFYYIuyTCPCYKPUT4xe528eMCmUKySwWodSptuan6E6lUFhCgMISTUjB+0ng9uJPXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(38100700002)(41300700001)(2616005)(8936002)(186003)(6512007)(2906002)(26005)(478600001)(558084003)(6486002)(316002)(36756003)(66476007)(66946007)(66556008)(6666004)(6506007)(53546011)(8676002)(31696002)(86362001)(44832011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmFOeUhER0k1KzFGamw1L1VON1l3KzYyRkhPZklucU1XSmhRTTVqS25VaHQ1?=
 =?utf-8?B?NjRXWllzaFlxL3BNQTZhSk9QanVlK0lKNkJxb1RWZ0xUZ2lwa04xVjF2bkxJ?=
 =?utf-8?B?dzJoRzVwYSs0VkpPYjBSUTRoRlp0Q2ZwcEdwZHhnTHFiUzVMUExGVnVUWE9C?=
 =?utf-8?B?M0IxQTZHUlZkRDEwRU5zOTFEM3F6Yy8yM0tEQnI3YkxVUm91U3IxVTR5QWhQ?=
 =?utf-8?B?bnNvYldSR1hBVlVReUZjd09hUUFDTFp4V1M5V3E5UWxvMWtXNmJraC9GMlcy?=
 =?utf-8?B?QXpERzk5d0JraVh5Q3ZsRUxyNzNLQVJySlRkOU1YMnJJMnh5TGlJRjRqaDZC?=
 =?utf-8?B?YVJMaU92WjNiZkFvUUxQaXFkZjREUDZacm9udGV2S3FuRVhZdktEUGNwNkhr?=
 =?utf-8?B?aEg2bUQrcktjdzNqa1N2NWFSd215dkNQTWJnQktIaXlPenc1SWx3bGVWaVB6?=
 =?utf-8?B?ZXBuclNkcVpwVkd6ZE92NzNnRjVBakFmZThhdDVNSjRLYVdXMlZBVW1rdzFU?=
 =?utf-8?B?WXZoUXhHZWJaeWx3eFZnYUlEaXZ2T0xFWEFiSXJYQzJ0b013akhzRnNiY3Vq?=
 =?utf-8?B?Zmp4ZVpxaGFTYktMYUNqVy9hZWVBUGh3VzBpNXNDVkJJSmw2NDNaQmxHcVRW?=
 =?utf-8?B?SStYR3VHTEZrWkh0WHhiWi82NmVSSjVLVHlTOHRJSk5TTERuZVl4ZlR5T0g1?=
 =?utf-8?B?YktQVHRZRzdMR1gyNWUwUnV1UlJIOHdDb2hqNGxDZHRJcWlxVk4yZlQ5Lzlr?=
 =?utf-8?B?VHgyUStGMmdmZjN4VXBGQ1hILzQrOFFRSU16MmViQ2VoM2NDLzVNdmEySUdK?=
 =?utf-8?B?ZGFDOHR3VkExcG5LNXVwallGOUNkWm5RNFRmam1QdDJGdTZNQzJ3UnJzR0cv?=
 =?utf-8?B?VjJ4U0gvODdqUDE2alVuWllURm1nOXBBcTlESU00eUpOSjFSaGc3dUloem5t?=
 =?utf-8?B?eWV0NHRsY3JBanVjYm1RaWNnYmlrK1ZTVms5cmxEQ3RYeXQyWHVwOU5JR0lq?=
 =?utf-8?B?djliQ2hCeXNxakZjV205bUNNVFc1VnhIZE14OW9ZWFk4RGpDdEVsU3dNZi9F?=
 =?utf-8?B?MER5MTI5SlVpSy9GaDZhZlV0R1FpUXVHR0M1SCtqRC83NDRNVkk2cVgvTlhV?=
 =?utf-8?B?enM1Z3JlcEF4cUoyY3RlZERJcHFDTlhXQXpNTmpxZGZkV2J6TDQ1Y2txYSsw?=
 =?utf-8?B?SGJueGVRck0vcUZxbEp4WlMxUGROY3hJS291dStWaDhQRjZYTER6aGlxUUdM?=
 =?utf-8?B?Q0F6MzhTaWNzUTluZmMzQ0lRVXBYaG9zTXlGdGNxNkNZRVp4WGw0TDJ0Vzl5?=
 =?utf-8?B?WmhmcDVXbnpoYlpub3dYZDFBcDNjVktaMHFiN05ITUFjcVBCclpVWkNKL3RQ?=
 =?utf-8?B?bHFFYk5UU1FSN3ozeERWK2Ryb3MzMDBMSGx1MGw2YndDcHFDV0FzM05oelk4?=
 =?utf-8?B?NzZEalBNL3d4T3Y3UlN1TExEM3NFRDhLd2ROL0p2K2FGZXp2OWUxMEdjeXdU?=
 =?utf-8?B?MGdLSFFNVXB5Z0tueVZpdUx6NWwyZFVaZ2FhOFI1eEZndVNaSEVGZE1jR1d1?=
 =?utf-8?B?NFlaaTJQb1ZVUzd4cGRna3pNUjVBWnVaVElSL3pBQk9SclRsOWdzcHk4V1k3?=
 =?utf-8?B?RFBuWUozS3NyTzBpd0MvM2RTTEdRbzY5a0VXbzZwcWZzd3ZlWU11K0YvTlZQ?=
 =?utf-8?B?ZjdScVFhZjJ4REFtWFpkemsrTWlLUW90NVNaUnNtSFJsbkN6QVFSd1hJMmRj?=
 =?utf-8?B?VHBFTnRlTWFqM1pnaU1pWU4wKzB2OFdTUUc4eGNvK2g4YkpuRmZrUWdQcXJ6?=
 =?utf-8?B?Mk9GVTVGVnF2cVErOGJzT1lKL3FZby9IU1lLa3pNWkRjaVJmc0dxNmU1NHBs?=
 =?utf-8?B?Y0o5R3BnV0g2S1BoNTJ2bDdOSzl4UWZlVlN2YzM3cTJPcGpkRWUxUnpuUmM2?=
 =?utf-8?B?ZERXc0JKNG50Y0s2b0I1MWx5QU83VG1qaUxtZGN3eTNmZitSNmNDRWJIRklU?=
 =?utf-8?B?TkxTWTFnL3BFdDNCRFB3d2NPdm9TUUlXNFRIZmZwM1BZbk40blpoNTRudlFr?=
 =?utf-8?B?bmhkcHlsUEoxaXdLTGkvaEtPZVQ1Qkh0ZGNSaURLdzFsV0EydVlEbVRZUm42?=
 =?utf-8?Q?5XsdHJi721NkB2nQsiGlhOEgq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a77d53e-e15a-4698-4421-08da9a3c453f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:41:28.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrQ7zaT/sOA2QdgJznOVMl4QBL4Ku3U9+ogF8zV1gZjIRPy7jLSAzWhAvCpmixC9RFwq6AimOV9BHG6M78yx2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190085
X-Proofpoint-ORIG-GUID: qSA4yQy4EooYz960aVwA_Dd8d5XcgrHf
X-Proofpoint-GUID: qSA4yQy4EooYz960aVwA_Dd8d5XcgrHf
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> Now that we're not using this code anywhere we can remove it as well as
> the member from fs_info.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
