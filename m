Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272E6141F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 00:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJaXuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 19:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJaXui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 19:50:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75706583
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 16:50:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNhjdb013958;
        Mon, 31 Oct 2022 23:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=60O/IVb7/mDfq10XlBEg9JdQjt8QfdOKBbY4gTH9Xnw=;
 b=OFVEVoIqE/TrgZKqIKb4zS3Tn6h5padbaQgtiTiEd5lDSGIEyykOTN9v0pvy184amKa0
 CKkeCYASEejCs7yvIGZaoKjnx9Zh29ppLwfsNxg6H04JieysttphjD3qYyoDF4jCH1MX
 d5N2qTyB0ilskSxLKpPdDF0H/2gbtZ1EhnNY3b4APKQ3fcwdrDOGPgUmT/vH5XLrkYr1
 H9vrws9rqJ3SooZkWOU/uF8DuR4F8di1wn6a/zbHIwH8ai8cxFKP3Nhp4uZ60H8M2WK9
 0f85lhlRZPVPB1g0WkCbR25hhMBDRX/GutCSmEhN1Fb7wFzdQmBTa8SRbfuVc8W+KtsU Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd561q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:50:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNBRjj033168;
        Mon, 31 Oct 2022 23:50:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3tv0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9Tx6Ip9UKiVte1ChGxL5LgYmQ71/JfbMrcwYUP4AnQVhJhGr/a/SpjeFkL55wE0jFOKTn5KDa1OvIAEW0npjJJNEIEOd5yRuq9+pOElLoHFcpqaDrR20Nh774rtmY/fgQuphdtoKW1LeJH/tAOc7nQsdXfMXGWuC6Zdx2pnn4uZUjvkZN5BMM1G5tF7M8H/jNRo7kf7/lT0xA3PUEz3MlDFKiNpjARtTZpTmgS/0EckeNDj89kDv/Ax1tc/6CMDipbJQvlIJGuNlRiMzHdSTx9A0BJCHqOshUJBsITtDxpb4uYNAz2l+B+TtssfzgDe9YURV5SWRt2YCCYCTtrE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60O/IVb7/mDfq10XlBEg9JdQjt8QfdOKBbY4gTH9Xnw=;
 b=h0roAFTqvrm/p1SoauUirE6yZwJ8WDYf5lnz360cOH7IN3OC4kFzZQq0DmpvQoGUyHPK3cvM6wPHLhWsJRIpOWy5DfUWQ2NCqk5G7ZpVQiDwtmg3gfGsZBadpQxf1Gs2rwfpbFH+AL0ZaIrlOR/EvkbzpDeCUMEkNhl6b69oqZWpmFCafdzjcSZPbYrUt5F7vVxACRdsiNLGjwESgsfJ95eRWNHByoFY/1gQZuK2/o9YBaTsS33C8X5+96A5VFDIMsEl+QepkgAGxEwgoUQDFSGp5wKOYMwtoMQGdfDM8CHXn+DYVBgrE1Gra5jRGvyB5vtF96eNl1a9VZ2M9w2t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60O/IVb7/mDfq10XlBEg9JdQjt8QfdOKBbY4gTH9Xnw=;
 b=Fw3HDA42b+VmZJtj5tGySxHGRXtP9wByFO9P3f/vpqkh/e2TwKiixoZosg2pbwSP2NSnstZUKrHKM9Oi43gLAlQZQiu2mKeadrYqH+wJGl+fZZDW66/o2/ltYDuwUw1L9eIkup/Qfs9/sd+uSs6grkO2hBnGvkOcScgo1fIfgPY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 23:50:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 23:50:31 +0000
Message-ID: <3f5debd1-90a3-0578-68ad-c6bb5a1d8c16@oracle.com>
Date:   Tue, 1 Nov 2022 07:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] btrfs: convert btrfs_block_group::seq_zone to runtime
 flag
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667244567.git.dsterba@suse.com>
 <0ad1f02fb8e431f6b4ddeef12a0748a69b65a6df.1667244568.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0ad1f02fb8e431f6b4ddeef12a0748a69b65a6df.1667244568.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c79cfbbe-76f6-46a4-7e83-08dabb9ab214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r0GxbkfENB/JIf5cc3kK5QRRhyToIwPkPRRlq9REJGFvs1SMYZAApDi39WBWPpTZc+NRqDro+o/rVtmYyRFW8vIRSJ6p1skO1m+z32V8O2rTqr79QzGSFQBH1gdaLdMZKjh+hrw/Q2QLBt6MHMqCfSSCPt1iFJZoAqvkujyxGikoFDbbqwqfWB5K2tcNBcJdAgsFIXJeIg/D+tmAOndmP06+/1BLB60dzvEIbeW0m0x4XfuVTRd61TOd4BpeCa1myzpqOgT5Xh+ughbGesre/bTaZq0DNTXrEPIzxquyGkt56V9aOCP4JbNx/yNd6bVAEkoUkl+EAzBkBUtErZAfHc1N8JowsMhxT1hCD9u+6Onm01B9X74G6Rrd8T/ep1cmMadwAnuFAD5phmc8crziwM/Lh59qAxX8wkvTsuVfs4tUFD+5Uk4DJVSHIbPiWZUTCgojBQ/XjRo1Fdkkxxk8tfhFBTjD5ap9NNtBVzF2Bc29ZUoeEcFdhoopOMjWHmBXbXhY9wQICrJBc0w3BBnS0ER8qkt4ZaAxzD7oyvlybF1YfWkho+opDe1lk6Q3QAVSLr6HcC+LnyC3fw8iSqr2ry1JI+/61YmUagZPdbFjVxcHsXsW/TyQgLgASqIMzyr8+Hl6qUDitz7t3PJ2C5AxwIqCvgDdVQQ5YDrC04ItQnbPDswVTxqZfOqKfbczISrouUrWpjpf3ACs5m2DSdor79wVsVrxOreTo+wQoW9xPVcgq9ItXlCYZaHE+OIfoe6bkmhTt/7ta0oFLFmLDs88dxRjjJZoCXpGnqoauCbpgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(83380400001)(2906002)(31686004)(86362001)(316002)(31696002)(53546011)(8676002)(6506007)(6512007)(36756003)(558084003)(26005)(41300700001)(6666004)(38100700002)(66476007)(186003)(2616005)(44832011)(66556008)(478600001)(66946007)(5660300002)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RnNUlPb1ZhaGN6L2pRSGNMWEYxY2lxNTEzVVJ3YnFMeTQvV0ltbzBuYmtK?=
 =?utf-8?B?dVRsb1prT0JOaWFZcVNxVFFLaHpRSERRU0dkL1BzZE9HMlo4ckI3blVWVFFW?=
 =?utf-8?B?OVNIbGkxS2xKZGg2K3czVVJ3OFhyelUyMk1PWE40ZHdGMktqNHQ1N2tUenI4?=
 =?utf-8?B?aHZ2SGx3U3U3TWs1VnF1dktiVmU5Q1FlbnBReUh6Rk51T3d2RkJqZURnd0VS?=
 =?utf-8?B?UEQ3WWxaVStiUzBYUFdlM1l2M1BUSmpsWU80T3N3aGwwZ2xDWXpjelNoTEhr?=
 =?utf-8?B?Zi9COUNnbnNvUnRVVld5azBYbEpsU0pYelhmRStSUk5SMGd0SGsyYkVzdkY0?=
 =?utf-8?B?NVFyVHh4RmQxbzRqWGxLZWZyVnE0bGNibHhuN2p6emxUVS9EcXZzRmR2cnM0?=
 =?utf-8?B?d21ETkszQmtKYmpaMkhOOXl5Q2QrVlM4R2dRT0JYMTJPRFRaeW5IbUNRZW5p?=
 =?utf-8?B?MkoxamwxUy9PQ0tGYi9pYUtVMUE4bWhONGg3NktLRHEzMlBvTXNKVmVhL2F1?=
 =?utf-8?B?QVdYMExIQ0VWbGpOWHNKSERrTjVpOWh4UjVCazdXZnV0ZlJXNzRGVXJaYzF5?=
 =?utf-8?B?eEw0dWxpdGRRWGZZMFVaV1lHSUd2SVJFWGJOVjcrNVZWaUQweGY4VThid1gw?=
 =?utf-8?B?Q2VBbWpVVGhLU0d5V1VTSVNVRkVoTzgzbnUvZzIzQVA2T1hOR3I1Tm95d1Zp?=
 =?utf-8?B?MkxXNEZIaUtITlFvNlNmUk03YmVsdTZXRDE2R0lFTGhtcnVVNFp5S01DaUJY?=
 =?utf-8?B?Q1QzeEVXQ0JQSVpseE5XTkVlVmhOTzAwSW85VHhOOW1YK1FxVGZmUzF2eThz?=
 =?utf-8?B?UjFYUUJsZG83RU13K1BqckRmaDBOaVRnMFR5WnBteHgrU2thbS9Vazk2K3FJ?=
 =?utf-8?B?c1h0TjMxUXdYU3pLQkxwNXpNM3I2aE5POTljY0llNmZuWTczVEJZRnhndjZi?=
 =?utf-8?B?d0NIZjNHOFFaUFFQMUFTa1JvQWRqbnlQT0tTVEtBdzJtWnFmWGQ3anNuVFBl?=
 =?utf-8?B?bzZjOC80emxRdUVtZlM3MCtrWVFZcytpaE5jUFMvNHcyVlc5MVo1dGQ2Y0ZV?=
 =?utf-8?B?cEl3NXFTK0VYZkhLanQyOTJDY1hrK01lRmZiL2FrcVhqRU9tb2w4ZDdLNkRq?=
 =?utf-8?B?ODYySzhUUUZCMWR1TFg4eSs5U0R0dHM3KzZTbkRDeDVlVU93QnN5dnk4b0FN?=
 =?utf-8?B?SXFRbzA1Y2ZGUW1kTm9QT1ZDb3NXcU1JV1lRanN1QUZvRXJQV0QvMGRSemtL?=
 =?utf-8?B?c2JMTmxVVkI0aUxMUGtwN0xjcUdncFlPTE15R21ib0pPM0dSZXJkWloyWWx2?=
 =?utf-8?B?RFJ0d1AraGNHVWFBSlltL3AwRHVwTDFoRHMzWW9DMWZkUDFZQnF3bnFXb3hZ?=
 =?utf-8?B?MnNYRXlPNVlTZWpRMy83ejFHYXRLNnVacDhmZDF3QkpNSjV6MW9rLzFDclor?=
 =?utf-8?B?RTMxT3lRKzltTlpSU3JuVEVjRGoyTVE5WjIvd2lUTjV5QWRjRXY3dXhTQzd2?=
 =?utf-8?B?NDdlSUVyZ1ZOd3hXQm9YOStGakJjOHhmOXdzNzQ0eXBlRTRtWWNJQklDZlA3?=
 =?utf-8?B?NkQzS2cxRnQzZjNPNmlRNDlhZnNTT1dBT1FzTVlBWEJNcEZlMGp4eVFzcHZz?=
 =?utf-8?B?Nm1UWnVaSThtNk1uQ0FHWG5VNVIwVkIwTnFQQVk0VlpRQjg1aHQ0RGdGZ2VO?=
 =?utf-8?B?V2JwVzhRYWVpSUFadkU3bWdPNU5OOGUzNlJwZUUvUUdhRDMwL1Q2M1JaTzNF?=
 =?utf-8?B?SVFSajRIL3dDbGJ4WTNiSkFUMkN4aEpRVkV4MVJpdTRzQzlYVXYyVzRjaEp4?=
 =?utf-8?B?RDZCK1Q4NE9XbUFhNWRZSGtUVmVYNFdSYlMxZUtXcno5VEROcko0TXhIS0Y5?=
 =?utf-8?B?UHNXb01wenZBbkZUQnVVY3ZBRWlzRjVkK05TTDBoUk1yTEdSL2pwWFBhVHJQ?=
 =?utf-8?B?UDhLdVJNU2ZyaVZsQ0Q1TWwrODhSYmF5ZmhYUVJPendkZnV5TWlQanNDdWFH?=
 =?utf-8?B?OWprL1d5QTJONkJ2L2I2bmJFU1NRQlhicGVPNUNBMDVxOEtMY1FwYkRqSnhx?=
 =?utf-8?B?QytHc1laaVpKWkxMcURhaEpkWVNZczFEM0hkUnllUFl2VXY1Vmw5L2pDd09i?=
 =?utf-8?Q?gSyDfmTdKTnGI1msPWOPc6DgT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79cfbbe-76f6-46a4-7e83-08dabb9ab214
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 23:50:31.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xVQxICVWgFm9XHDbf1sfl5HH6lYtmQPmWj6rq+OFEP5iERHY9HyLDgErhk2ss0XSbyt2hvLkk+n+SGhOelwWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310149
X-Proofpoint-ORIG-GUID: AGJCG3DvogoVXbn2_to81h501uMeNlJr
X-Proofpoint-GUID: AGJCG3DvogoVXbn2_to81h501uMeNlJr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/11/2022 03:33, David Sterba wrote:
> In zoned mode the sequential status of zone can be also tracked in the
> runtime flags of block group.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



