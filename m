Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0536C5BCBC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISM10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISM1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:27:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB59DEB0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:27:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBxDo9032757;
        Mon, 19 Sep 2022 12:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3NagzKkTmOXtLkEi/7xXbPFIrIO8oX6fitl4PtQVnr4=;
 b=gF/6M7Xba8TBG1klGke1gfW+71MahmMiMbNxVktYXuJQNqGYUa7GWCGYpFaipbKM/cnF
 5C6Dx//zHjaCedH4K8K0XXgjBdOUYd5XnNnOEh53/sBXLbHjYlak0BeRBFcoey6GeMw/
 mZxvwanTPzoenq51Ha93NL0JZE0JbHs4hsMitzZ3Izz62GP8w3X29ILIl9ZQgoiVIRyd
 43MdqbwGcL/5qGX1RPUZiEpKCKvM45Ntu6z1q4j/+YKrsIqEc06jCkdrpret1aji6ZwA
 YV67FzQrnU+usBe2AYO04smByNH67nLng0kbzhE4DmIM2Brzzqltvq1ZvoJPUtWFkRjr XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0bkc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:27:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JA9EGW019172;
        Mon, 19 Sep 2022 12:27:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d0u8yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2JxJFZYpz6VOTyD7Xz0BwI+IsxLH1TT0L87BeCl82cH1WtQSpmcAVrNutU5r7h4n23G6hg2JG0DHNqh7LaZl1OsTbCgbp+GEgKNWy5HIj97gn+b44+QNOvptDL7PlhfJFRaK3k0YmiWv+d+ijBfrLyhhVjl8XVZ3xRbV2eE4yO6Kg2+ustR0YF5osAljsS+mFsgNW2bpYj07a1EmzD06PX6YkVwP7iI/IzkyXYVv6dV4Si/+mvMFTlzPn9B8dW3UIKnH5K47udFp7soBpSF2mgeXLmaNznt4Iejo1cvp13h5nyTCXG2OdOPNPbaK6LlJ4Jegi45prYY+Y3z8v71Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NagzKkTmOXtLkEi/7xXbPFIrIO8oX6fitl4PtQVnr4=;
 b=W4fX79tmE3SXzBHiWCpPXFnpUQREk6YZ/nOQiEuS5KLVNcRuonDV1O9j+1hAKK+mW1c+HWfUzSgGv985sMv32m3tFk8OiFyvGtn+A4rCeecnMLQ2/HQ4fYPDPOT2p5osQT3LQccuD7gEwovbk3yBmDOgrBuBhuUI7gqoo0Z7I+4v3Z67zXGb5xvYbEKWEfqeQcNZXW5lSjAxlzoVKub9zIneuniW1V/dp3uVVE6ppJLuuO55zKD+bBywW8VBOLcfl1TY5jHT1GLMnmNPV37gReK3KhIIU2QeIr+0NvR2Y+GXudkW9TzYloio9+Kg9p3jAechWzryteCyRC04uaqclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NagzKkTmOXtLkEi/7xXbPFIrIO8oX6fitl4PtQVnr4=;
 b=YAWInv21gBtpmAcbKp7i9z7SwTdav8x0fJRHgJpIUP3I2mPdqAU133bgaaPfPvIaac7mEoqpDO5g5BwWRkUvd5ywFbt6EHK32RNYLKD0+9S3fD8DhQr9Khvs37+y4YP6xEOGm0yMQusQrDn/pfZ1vtCFwvf7ZgjkU2gyaMpBVl8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6283.namprd10.prod.outlook.com (2603:10b6:510:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 12:27:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:27:18 +0000
Message-ID: <9b160f2d-e07e-3108-d691-ca5e5b775808@oracle.com>
Date:   Mon, 19 Sep 2022 20:27:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 10/16] btrfs: move fs_info->flags enum to fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <eab7da9a54588b8ad9641a148f54824bed1c1fcd.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <eab7da9a54588b8ad9641a148f54824bed1c1fcd.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: c51051c4-77e1-454d-76ca-08da9a3a4aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znQudiaGPIpwGrGvR8BfZ9WLD0xpnl1El8k9a0JKJ/KAHmf+hX9hQaa+jm9pa1R894sg1yJ54u2upzHB87sr9lWwudIKQra+xEWPgmvSAClhzdTfobwN5dGGdgWjkQsHkftqs9UNStykpwdjt1IHOLG3QXQzOCUiWN/W7Fo4AEO7p/5EoT/rAYJYqR+vs8UQ9FRFEfCTvewIOdgs4FSDLeLb2sjsifmV0YrVIT9fWG7yrD7xkeLxiVekL6aVQ86TUO23nNbH1ZolF2+Rt+Envl/AG0Ql+Vae4aMciDMNunIm0RaI/KDX59ZW2TY88fhWsURbheiVK/0TrmnHtWTfd+d1y6jKSaDioSV+xAZJNgWjiVLcs2P8xd82FD3O2gmqKaCVDr0vTQs0aZY6cQQ2eMJlwLLCjLwwAzo5MsU+GoVv9QSeKDZe7fVTpd1f2Noid93O8w6myfgQ+Uh2OO0mFNWgoFDdAITjUdBcQgLT2lrthHqhQ0jOo5ghjvwPpyB3Dd/y6x4MH1Z1Vd6EaPNQahFgq18uABw0Eff73jZNmv8ARvoSHV0KyLK3+2kWXdMx9pckqzx5/yKEgC57c/yVW1WlOzbE27glmklYjf0UdiUD0scCSKYOfs2vDPcU8J03H1h3Y6AXYl7dC9K6BPI+7Pm20q6twR0/X9+65LaZ315+iRL+kSR4xDjB5x2oDiNc3ZmCYdxO+i5FqTNFEGpJ/JsA17DxEUhmi0L61P/Jj/TAFO3pZ3vvU6Vo+CxZ81laXkQzR9wveb8frhzYTRRCZaCxdsgeLxTvY6s3sehoo00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(558084003)(36756003)(316002)(38100700002)(8676002)(2906002)(53546011)(66556008)(66476007)(66946007)(186003)(31696002)(2616005)(86362001)(6486002)(478600001)(6666004)(6512007)(26005)(6506007)(5660300002)(41300700001)(31686004)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFIzT2FMS0h1VkZ0MUJvYUxqMmwxRStqbThOcHRINHJ5bENLYzU3YmNYcUk0?=
 =?utf-8?B?T3lFU0dYOGNTWmZUYkQzdWRzcHJ4cngxR3RwZHgvQWlLeUlaUEx2NXFodVZq?=
 =?utf-8?B?VGZnMjJtcnlxNWRTQVE3aUNTcWVYN2tSbmpjZlM4MDk1S1p0Q3VDd01Vb0Qx?=
 =?utf-8?B?eW1Ya0pGOUxRYk1zYjBQbndCQzEvOURBWnNKekhWd3FUU29wSThuUVVHQ0d4?=
 =?utf-8?B?dzR4NFhEK1d4Ky85L3RZTVdNb0o3bW9NVVJxYng4L2pydGNXZ0JLb21iTW9P?=
 =?utf-8?B?Q0RoS3JFWklJeUhQck1odHl6dTV3d0VBaEw2UEVNUSszYUgyUExCWStzZVUw?=
 =?utf-8?B?ellkR1U5VnVuSXVtSGU2K3BMUEJUaTkxQ2xqVlk0bDNwTWZsemEvbDArUGRV?=
 =?utf-8?B?YS9QcWFkRzNRSnRJN0lzNVhyNmNmcXZmRGxxVHZaYlEybnNiMHMvZjBWSktV?=
 =?utf-8?B?WGpPYTh1b2d4bnFzVFNRakFkWlZBbW1kK3p3L1ZYaFg5VmJNUU1NZkFxNFl4?=
 =?utf-8?B?TmlGM2QxZ0oxMyt0NVlvMHgxTlkyM0JlYzJvaEsyS2FVaFZUaGtNcHg2bHZa?=
 =?utf-8?B?VUpNcEdoQVh4cFB2L3ljUVVUOVV3dTZ4dURLaFQ2YjNLQm91bmZlZ0s5UkF6?=
 =?utf-8?B?VTdaOWVNTVpxZHpkcjVrUHJKeWZiV1ZWZk16dENldGRYV3dZdnhxd1FTYzVT?=
 =?utf-8?B?SW95WHQ4amdyWjkyeDI0ejk2YjQxblUzd01xVjFxNTIvNC9ReU1xbHplV2Z5?=
 =?utf-8?B?WElvT29namhHcTNtZGQxRlFGUlVlWlN0STRXMUsrN0t2eVJQZ0hrTmdLbmRZ?=
 =?utf-8?B?UWxKWkY3dWh4Qyt0aG5JVFE3NkdnNU80ZWNvUVlMQkRSa2w5VGZ1OWlPV2FC?=
 =?utf-8?B?dnZVaDZFL3ROUGJTdzU1SVNzYzFJcHNSVlNxUGQ4K0RLOXllUnp3Wkg5eFll?=
 =?utf-8?B?T1RUS0RWWkI5QXYrRm84N3lqbGRsUHpHVGdJUkthSW5keUVWR0dUZW9wdC9G?=
 =?utf-8?B?UTN4UlNCUENIdGF4OHR6UHhYQ0c5eFRmdmpVelp0M2pHRUx4SEZldWl3SmZ5?=
 =?utf-8?B?MkVsVE0zOVVKYitQdkl4bUs1Z2FOcXNqTnlKUzFLTHFNanMvREFNNWtQK3ox?=
 =?utf-8?B?bFVBdzZBY3lTMm1TWFYxem16M3Jnb0pQQjNRV2IxQVVGVkVxRngyY2tPRTJw?=
 =?utf-8?B?WmdzcFRtb3djTEp2Uk83dW9BODhEWWphTHdudlk5RnJCK3Flc3JrT3RnRW8y?=
 =?utf-8?B?YjRQb1dqaUNmUk1FRGhCMkdpZ0lMbG9pSjJKQlFKT1NpOC9SQkM0MVJGMUp4?=
 =?utf-8?B?alR3cU1OcmRNTTlwRW5FNVQ3ay9GU2ZKRXJHZGJPYy8zNmZHODY3OWhUdXE1?=
 =?utf-8?B?c1NteU9lRmRMTE5MN1MrYkVMak9oUnhDZnA2ZHNhbC9hMGpoS3ZRRnYwUkI1?=
 =?utf-8?B?WVJaOGpvazE2TnUvQmhUL1ZFMG8wSFYzRUVXV3d4bWpmTGZIOGhoTHJERURC?=
 =?utf-8?B?WGZkTCt2NWN6RXQyMTVKRFA0aHJua092S1hsWXRKMjcwb2t6Q085ZlVzNDNo?=
 =?utf-8?B?dzJQL3d0Z0V5SC96NmF2T1ZPR0hWbkY1K2dpVWZhalM5bGh4SGVrSlRTcEdo?=
 =?utf-8?B?cmxlamtDVnkxQ2RxWDZvQXdKYnR5eFgrTWVKR2tINnNnMEVPRUR1THhwNk5q?=
 =?utf-8?B?aDh5d1kydzF3SjczRXJ0R1pjWFVKcHdRSEJneXd1VnVoSnEyKzkzRCtrdjRj?=
 =?utf-8?B?QzJLWVpUYnBoNngzNkRNWTJycGRuRFlRU3B2a0dzNHBUbHFuOTVBSEtYM2sz?=
 =?utf-8?B?bEZIU1UrS1QvUmJVQUxwaVJrZE9xdnpRQ1dpM1dwc2haZFRNdlRPcFhHYmoy?=
 =?utf-8?B?MUxRNVJFcmVWU2dDT05za3FvNGlUbVRTWWpORDFzRnZ6b3I1UXhFWVF1TjZO?=
 =?utf-8?B?OFdkcXlvY3hsNkthWk5CWVQvR3dnZ1pBMzV5S3FMSDllRE12RDVBNkJ6aWVX?=
 =?utf-8?B?VDBHam4vWXkrRGZvTko5azRyMS9pU1ZMU01hSHYzSkNpckVPUDVidXpKUlg1?=
 =?utf-8?B?TmVVM2JhSndKUHRzMk1GV1kxQzE1bjhuTXQ3ZXJpc09jQU5VYTJsaEloUy8v?=
 =?utf-8?Q?/jM6DiXmuSFdlZDkQs5zBhq+R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51051c4-77e1-454d-76ca-08da9a3a4aa1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:27:18.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxaWJH2dv7+Aqe1/n2Rt3DdY6O9ufBbS/n3Cvyf7v77zJMD72qS/mFDiCXpcb2oEEPuYoGv/7lVPvDCFuMPyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190083
X-Proofpoint-GUID: -2RtW0xVJj6jFj8aM7zsecE0siCcs0nP
X-Proofpoint-ORIG-GUID: -2RtW0xVJj6jFj8aM7zsecE0siCcs0nP
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
> These definitions are fs wide, take them out of ctree.h and put them in
> fs.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



