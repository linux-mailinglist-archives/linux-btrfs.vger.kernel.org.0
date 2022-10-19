Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD42604D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJSQ2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiJSQ2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 12:28:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0841C5E18
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 09:28:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFNhNU022999;
        Wed, 19 Oct 2022 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lxtRxc7azRbdbOWG4zWqSdz3SRm/CALvLmKlg0Q7sy8=;
 b=Qg5PYTq3bhICD8ovv35HGpVaCSxBqeJ7U9X91mKl4yJNKQgKKxD8MeuWt5x2NEQ0miZW
 B3fOo47+JHgi1H8Wq+7Cp8HEoxHq6g4n9OG96vbmUzUd2+sTu6hSPHUyyu9QS1JnTJ8d
 6yVOiIbMMDHDANtzke7hzaEo0YA09NqCvNwUDtLOFCJEBNWUxN4IX6EGZKDYxhgnBSDp
 PaIrOSAGrEzmJa+GTUjZPae7kBEKsPMpmCcsbg8YZNNaHJm9uasE/Zei8pJOBENLtdic
 M5fGDEyz5sqXEn4pEws8U8JgwFhGFWv+CIhxQzKR1rGs22gh/EHE1hOaq6nJv62Ixplt Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3jfp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 16:27:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JGM5Ja028994;
        Wed, 19 Oct 2022 16:27:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu8xnef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 16:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd7PJnhUm8v5Ng+goGcSJspaxpZ4oHs9hiP/AWDBXLVf2QGox60bRkf+3o1QvW9mznBtQiY+FLa1PuRtWpfGq0ZDTAL8G5NyEPg+qmurPAN80wvxlO7vbudr3axY/SmQZcJuORhI80r6g6w/DKU66lS+Gi27+T0B51ljOc6WqYFmz5fFXWQso0tLsRkr0wONR18G4XBHDGyet8nizWdLvdcMGoOzE2jEAycZe3lvq3dC8SNwFFFo+wkz2nzKRuACU57hTYfJRA7i1QvOUChndfNVbH+t/sFeR2pih5UNuqMV7DNXtf4IpLAZeSZuqJm83LFFdzOpnglH//rb67ovGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxtRxc7azRbdbOWG4zWqSdz3SRm/CALvLmKlg0Q7sy8=;
 b=d5lzRhZJw9QifVmKgXZ3tJJh15DvOIAc2W5FAXnMGNc/fBsWXD1YZIvyrjmGw8zvIyMC6/NbvDpjssLDZ4AVNk6UogkWB0IS1OGIrTSMfm/jBOOfh7L59/ebqtqCn3zw9tDPhqTWBtBmU0Zea9Oy1fLA5gfe5QyAAc5+p6ivF8leh5lxZTcIWb432r5KcgZvOM4uMIH7eSWyeJo9UMmHK1u+B7Mx2A2PesGUrdvOLO1O5HT45Ef3JkGORiR1JGoa4l5Yvtf83eo0rcaiww4YUJjLWnLCYGtfTxmOn9ZvcWLtnsuJ/P/3nl7DxwW1vTI1BPPnueCI4JNG6qvKWxwVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxtRxc7azRbdbOWG4zWqSdz3SRm/CALvLmKlg0Q7sy8=;
 b=ENIsAm2YduEJ1QjaG22ag2STOJmdqNdIaImgMT9vTgqBxTuvLrqKYgn8bn+QrQZXWqPjghRGCH/iVvCfK+kpfJPZc7iT5rcjRu8GQY5RG4iLU0+GZSO4X48D9U62QpSfJ+ocE236FaUntpqScsmjn7cFjRa/lmXastyzNT3A+mM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4853.namprd10.prod.outlook.com (2603:10b6:408:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 16:27:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 16:27:56 +0000
Message-ID: <d0ca7f6c-50e6-559f-7ee8-348d896567c5@oracle.com>
Date:   Thu, 20 Oct 2022 00:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] btrfs: add helper to exit_btrfs_fs
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <a1e9999846422fc971c5bb5f79d517de6530a55a.1665745675.git.anand.jain@oracle.com>
 <20221017175950.GR13389@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221017175950.GR13389@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f495a4e-548a-4f16-d207-08dab1eee0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCZL6BrZrzO2hmJ7btvHBDqjPYksC1qwO/v5UwnhcpaQOSBgU63HFeHOcGEHNbezPGHeKuL4tO1f1RvRmalKsKhbqW/pcONeqp7FjtsD9Am5ci83RfwFH26nUd3axhuSLU8hlr/9s+JICkkuI6V/EN+xOGpJVSGAi2yTcvJiuw3/cUeR1KVgs8eMjcHUhIkBQAYTx1n74H0RLpxqquqpnwIJJPaEH7gpboRsKPspjViMEbhveJ54CCBtrANozcyr+72tBoLQoMIompu3bUhF3PRBRDsGZgiWcCLPAFYMQJpQHU3oUstpmQyGcnGUC+kZGGyrdK1ulhhP+FsUTdWc5enFGp23BPMRAyoh1kE/s578iZRa/oWmxeZ3zGD/I8DEv7nKR7JAhbQ0pKrvJM/OuEYGLM2Jsab+Qb+GTICmVJHdAePA7wjWOGDwNsVNJrkV+axnkkltkHAJAjNgohnd4x+IM2ItUrruh5Ic6C7q+plGGkIzkL9wc7GA0SNn/nl3ImagkP/wfmEhMCU0xjjx7Q6jG0k+svnF8RxScHODNuWTDOGH/7fGpnUQ2Fq+ERlUyY8ALz8lOsQSzT+0Eb93sdRcz51dJr/0chayfExAld4lYp0kGJK05bLsw1YJpfZDd9n+ZuJqCwbXM5DDaN0npZeZapSjc3qrpW5BiVOoOySKjI+WTZILqt5ctGi4XrIdMON4s5tez/yJM20RyukizazqmyoIbMP8sHZS+a4Mcc8HOZ6xzF0OoIeeCYLFka2YminhP8dTJo/3DnhjUul24ychb699fzcLR0+4nVJ2KfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(38100700002)(6666004)(86362001)(31696002)(6512007)(5660300002)(8936002)(41300700001)(53546011)(6506007)(66476007)(66946007)(66556008)(26005)(4326008)(8676002)(44832011)(2906002)(186003)(6916009)(2616005)(316002)(36756003)(31686004)(66899015)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujl5bGtnM2RXalg4cFpEZnFFaUgwMWJGUUtJZ2ZLNXVRVnl0TEVIeXRkb0dk?=
 =?utf-8?B?U0pHK3Y5d3d3QmtjRUt2cStMaUlwcFNva29TVGt2RnFmMDlSZFdUeCs5NVN2?=
 =?utf-8?B?aTQrY2wvdnNXdU9Ca1lCYWJhbmx1bUE1QmJBSUdvZFNodVJUYU9UL3V3RWIz?=
 =?utf-8?B?OWpIQnpac0x4bDBwRWM1c2NMN0hlWVdtcWluODdrbTU5djJ5YnB3cGZ1RXYr?=
 =?utf-8?B?MDBGNjhzeHlPcnpVQnVLR2pvaUcyWXNYbjRuWVp3UkFDV08yb21ZYTRrU0NW?=
 =?utf-8?B?UU5vS1duaUlUamZYN2xSOG5LVWc4U3IxbjBsZ3Q2TUQyLzBuMFRnY1pFbG1B?=
 =?utf-8?B?Z1dDbmU5WVVMZkJXNHJkcXlQSURtYzdyaDZzbVFTaXFYRHRQakVDVDcwR0VP?=
 =?utf-8?B?OThnUng1c1pSWGFEdHQzYzNLaFVIeXFvOGJseDFoT3cxYUtRa2srVkdQOWhR?=
 =?utf-8?B?bUdkWDhyZ1FCTkNFQm1QRmNhVlNSbHdncW1RZkhXM2svRkgyMVQzU2p3MWg1?=
 =?utf-8?B?K2pTa1A5eTFZaEZaZzRkVVRENG1RT051TkNSTkxZdkdIM3dsT0hFL203K0E5?=
 =?utf-8?B?bnpscDZVR29pbGp3bVZpR09CWUtERTlXYXQwSjlTaHhVeE9rejdDdTVLK1p1?=
 =?utf-8?B?eWtUb0NvLytESzZseVB0L2p2QVEreU1ESVNWaSszQ2dJcWZwdHp3bHVyTGNC?=
 =?utf-8?B?NFJRb3M1Mms2eDJpMjZ3c0ljUWF6bzZZTjdNMFNIdU8vQ1kvdFFmaEo2YnRi?=
 =?utf-8?B?bzhZb3lnNnJoamR6WlB5ellOU1dIazV4aFBucFNlV2RyYkg3eDcySCtJSDlZ?=
 =?utf-8?B?WER6d3NtY3BIMUxUWjlEZlJadmNiWXhKSzZ2d1Zma2hXN2MwRUdXNlg2cEZC?=
 =?utf-8?B?ZnVWVmZZa2hNR0F2NWl4UytUV2JpSmN4RUlDN2tSbkxtdUp5dUFxRStPdzlP?=
 =?utf-8?B?bXFRRFBPNk9XcE04cUhyaFNSTlBrcFZocEU2aFFaazRBSHF3NFhGOTFJS1hV?=
 =?utf-8?B?VnB3YllaZkFYU2dIWDJ6bDJWZkFOZHQ3bnc1QVlneExiVENycDZtNVZ0M0xM?=
 =?utf-8?B?VUxJUHJsNTJxQUFkSDgzUHl3aG1icjAyUnV1Uk9xMlF6NWlNK3E1eDBaeGRm?=
 =?utf-8?B?QkVlbWxwOURDS2U2TmxaTEVPYmw0OXduMmVlTDR1L0U1RURHWUFzd21XRi85?=
 =?utf-8?B?U3k4MDZKN3Nqczg5TkFOVExkaEo5aWd5aTdLUmdMZzRjdXVRU0NWaGVoSXRL?=
 =?utf-8?B?VGJrbXU3cU1OT2VtZkFMQWJFSmtFQk5haS9HeVpTM1prcXVPeXlQMG0vakRK?=
 =?utf-8?B?M3hPU05iUnVCY2tsZnBSZWsvb3QwZi8wWVdwdEt5YTB2djBnNkw4QVpVZ2Z1?=
 =?utf-8?B?Mit6aFNGMmJYbEhxVE9CUHQ1dkw1Y1dqbjdHa3JVZHBraWt6NUFnMUF6OTRs?=
 =?utf-8?B?SGVTeGNsL0ZTeDljRElvcmtMU25hR2c2TjNMcU9McDVJemozN1ZrelFyZjdl?=
 =?utf-8?B?V3M2cjRDUExHZnhmSWF3UytadkhUTlE4VytLV1hDRUdiZ3dxdGg2enA3UTAw?=
 =?utf-8?B?SjdvbmFkM0pHK2xxUTVUREpXUWxEaFZoL1JzWmVjVFFzdWFZeXZvWFdSVWdG?=
 =?utf-8?B?cTVhOU9OVVFQN1dCV0hGSWVVTitLaGxMUEk4Wm5zc1Q2T2NEeWVlMGZ2aUkv?=
 =?utf-8?B?SkRyOU0vTzBhZHhSSCs3UW5kSk5zeDZLMG9lUFhSMGdFeGU1bWRueWQ1eTJ1?=
 =?utf-8?B?MEJxcjJSem52U05sY1lEcWo4aGZmYUhHUnVaeEN6dVNjZEptUkxVK1pCSDJG?=
 =?utf-8?B?eGxmcFZEYlNvbStzZ0Z0bnpjaXVxelhlQTNQMThma3BaMzdPU1ozMktvTU9w?=
 =?utf-8?B?Vm9QeEZuTkFnWHBneXBUalZuSlJORkQ5WTMzV2tjcHM4Wmt2ZGdwVis3UklF?=
 =?utf-8?B?VnBramxJaS9ERmx0aDVXbExJVUdBcjNyUnV1Y2YzUzJRbllRN293RXFIQU0v?=
 =?utf-8?B?YkYvdVZiVFBUTEpNNm9VWW5XZGk3UEhRYlJHUnFHeEVsMjRrbjlDb1NoMk80?=
 =?utf-8?B?UEVCVjhxMGdVVnNXS1VSOXN0eE13RHk2VGVRS0RCenpCWVJsdGY4L05TWXVt?=
 =?utf-8?Q?E7jbyHwdOMSHDN/C3ExAn43Zy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f495a4e-548a-4f16-d207-08dab1eee0c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:27:56.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JJCGIzxUJRd76xdesTOHocyQw1FIHRjch70uFwEVAt57BOhCyhYQyg3sIKJHTbwkh7G/hwIlipxL/YCjLu3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190093
X-Proofpoint-ORIG-GUID: zxHtZyj2nPuE8BVlRDIik-PyE9XjJ2uS
X-Proofpoint-GUID: zxHtZyj2nPuE8BVlRDIik-PyE9XjJ2uS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/10/2022 01:59, David Sterba wrote:
> On Fri, Oct 14, 2022 at 08:17:26PM +0800, Anand Jain wrote:
>> The module exit function exit_btrfs_fs() is duplicating a section of code
>> in init_btrfs_fs(). So add a helper function to remove the duplicate code.
>> Also, remove the comment about the function's .text section, which
>> doesn't make sense.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> David,
>>   This patch is on top of Qu's patch on the mailing list.
>>     btrfs: make btrfs module init/exit match their sequence
>>
>>   This patch passed, make mrproper, compile with defconfig and Oracle Linux config.
>>   and, Module load/unload.
>>   I suggested this change in the review comment, but it wasn't going anywhere.
>>   Instead, I found sending a patch is more productive. Please, keep my SOB.
> 
> So there's the for() { } duplication but we need to be careful about the
> sections. Can we rather use some inlining tricks to force the common
> code to be inlined and avoid dealing with the sections explicitly? Eg.
> using __always_inline.

Yeah, must avoid section mismatch, explicitly making
it inline is better. Sent v2. (sorry for the delay in response).

Thanks, Anand

