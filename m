Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19559A9B4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbiHSXxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbiHSXx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 19:53:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD23101C4
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 16:53:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLwsnE003574;
        Fri, 19 Aug 2022 23:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=J5Q+86+JF4/rdGBVm2qwfZG0HZctgU78MjSSeB2IAgg=;
 b=dqm7g9I+G6imuAUxE8+5AUHZdYDfxy3QK4P/TQsSFiW9qOaUCqCFu9GFAcLK33S47RVP
 sZQsc3bnbNVsZ0nNMiXZvPfo0Id+aTVDC7uvq/W0gqsLJ8DPIGw9uDRK3uJFCMtI4Wtn
 HEVcDR/2cl73yfD1VOy/COym2A1wpKc2od/TQMXXGgbhey3TOyz7EE40z2Pkic+dQAVF
 Cv+b8TrPLWPyy5kT9fMYoM/KSlu6cDt/5OQEEWjoTWJw1bjyhmTDxiZtRaVDy91EfOrI
 5c0MvKdj8y9Ql+l1pH8owCbVEtrc0vyckTa0ZqPa+Lp0o/Bmc+v8beM6XByiHBjg+vTL qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2jayr5wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:53:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLe25Z010416;
        Fri, 19 Aug 2022 23:53:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d5x7d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 23:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEEzoJ2C8NrUw+udptgviwXa6wQqV21i0SoiIgZCD/cbMyTYSf6vlAdfTfedoNZwx52vjI8MoHv3s+EuTZe7zdbCUs/Eftzu3mCFHaGiyNpvBKKNTtWGxPmPO9j+6QAQ9KzMStvz9E4Diva4mxt9TDJhfTI3V2yji3UZA+DqISretHsatIbtzlcUJ1H156Au8h+VW6aXKRbBs74SxZmXIg8FtFveTLbQTGFZs+pZrzL2pJodJFPMEIQbuIFHGwUlgxNTl8avqwFGo7sYoIJ2/VOv0p/dK+O1+pVidH31+vKh33VSltuREbsOnHEsn5rzy5ZV+Qx5WhcEkQYfz+hWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5Q+86+JF4/rdGBVm2qwfZG0HZctgU78MjSSeB2IAgg=;
 b=bv+IZnns2JoV8ilUxCJYrOGK/apn/qvAYIzDwkkPLEwTjRBUoUeHcbA+98o86Mui6KMlP/stq7a7QDTw0tIyNRuVu8A5nFVbqjbkUQ0A37D3/y8nyfw/IzNo3844+IuRNxF1VoEBcKbJ2PaK2bNt0dWO+U9c7xvKzeukbFZTHBYAeknotrr6VnwWweQk0y/kTXb3xTNkU1JAIuLukK6lIhINmtpXJ7kR1YEcZU2NEM9/51Kv81mLzyoJ3t1oUikVEYuTEKhI9d5GxXKEA+3VFVnF+3t/BGMaqkU4o4G0c4JUEsgTo8jVoOiFjlY1E1aKQQMl7q4vaY2Ieu1Dvht0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Q+86+JF4/rdGBVm2qwfZG0HZctgU78MjSSeB2IAgg=;
 b=EFxnx22QaLtXv5T1wTn9lgCo57cptqxuyhfOAml0d5yTE2MDBf6DXoPsFFXvetqGd+DNOz9L+yIfjk0nJ1N8yHC2FLxxu/JNoH+wgl8o+ABqBZkZ9SPn48c21oSZ4GrHurQtpwtZPYPHcwAc5fggeWatT42At5upJde1dYGYtiw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 23:53:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 23:53:14 +0000
Message-ID: <11120dd8-9f8a-3a7f-91e6-90b19c958186@oracle.com>
Date:   Sat, 20 Aug 2022 07:53:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 09/11] btrfs: simplify the submit_stripe_bio calling
 convention
To:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-10-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714142c8-8122-4354-c126-08da823dfada
X-MS-TrafficTypeDiagnostic: CY5PR10MB6166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6GDBj+W8/nc9MMtWdkpR+aWlqR9uhibQ6xQ0TA6VN6twYDa0JqN8idvfBq0BQyU3D5toYRmVdWI+pY2MBZDglW3+C/fGvJnTZQ4HPpO8WdC/8CHb/AEuajYuqtSd8UhE0VL42mhRcUId5nwbv6h7t9Mqy1k2ffHtqSkpGwMKP7Ma7dQ/a1s8dEx9inX01vnzeAPf4UVdHxeHnc46RUjY+0xm1dj2qtVCgRiPZKhq6kUF6vOksBYSQaRxAGyOVr2qA9+hBv/pz/3gOv1CPnbh0xI7PiLpjCSOFe4S9rdRcRpk14cT4BoPb4E2SMXfotfDVdleV16/H5MjcohEFoJdjb1N6K9rlMQOFvpwgNuRCzQELYyZ7G3IpKcqpTpQ+TrBFsk+iYKmnrmaiEQ7e0ZUp7pdh3f+U31AGBzRFyhA3gJZeTh7PsaYoSQeXU0jPpPE+9rU6B7G8V079BTm6ip0br2b8SU5Wfi8sVU+lJD8e4zqEZGAFH7xIHmBr1VsAeR1em5IhgeUeSPToEHgIb38jjTKrYjMuwxAxJIZiVJ+evnW0a0z/PHVFEBud41MlOeUOxvpL/OONeGoqHQ8pKBnJhC4dmAuLEcyk6DtVR0nX0E0WQkoZyR3GjVOJmMitXvyPtwDwrv3cD0oDneCGbbgtK/nznDnURZwIQNWb6aempHTSJijPZuoQu1BCEG8KMbdueRjQIM758ND3mERsHzxBlMNz3GKisBuIkHhxRmLx6lskVCiBIomrcyA5DURX764wuX6mJbtapc96oU2c0ZdWspDit8dauil6i0xIqqSj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(376002)(39860400002)(8936002)(44832011)(5660300002)(4744005)(2616005)(186003)(54906003)(31696002)(26005)(2906002)(53546011)(6666004)(6512007)(6506007)(478600001)(316002)(6486002)(36756003)(86362001)(66946007)(4326008)(66556008)(8676002)(31686004)(66476007)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0h4SzgydW0wcUVHMFRWZ3E5VXlQOUxOTzVYMG1NYVgya0JGcWRwT0JFOG53?=
 =?utf-8?B?bW44bnVNejllZkpnSXZhYXZWZll6c0FZTGVJMTczNDE2NGlEbDY3Y1NpYkFi?=
 =?utf-8?B?Um50dGc0OEFsUkJIQ0pHWGYweEZvWERzUE43dDg0Vy9ITXhvRzZYcmVBRHpH?=
 =?utf-8?B?MGNZWDFtVnREZkdzNlhqTDU2Q3IrdnBtWWxRRXFDanpRRDZkZXdMdlQ3NmJS?=
 =?utf-8?B?aktUVTJUTDRJWGx0M0x2WjFCQUs5UUFjNkZCRlVaVXhaQVBxaWJRU2pwNmU3?=
 =?utf-8?B?V2YyUU03eWpUNDZHL3R4R2czTlFxdDJOQWZuZUNvWVZVeTNGQ0NVcU1Cc1hJ?=
 =?utf-8?B?enFsbU1KRExDK24xYjA0ZFhIemp5RWVJeUlDUDlHVklxUE9DUmh3UEh2ejdI?=
 =?utf-8?B?elNsaWZoRUVCL2pYQ29mQ0s2by9wSThIemFvWXBKZWFrTjBrRHFEZkRLRE9L?=
 =?utf-8?B?T0t5RnlqUk9HUjZseWhlS0wvSDlUOTMvWlBJbU0xZDBkTkVWUzY2eHh6QSt3?=
 =?utf-8?B?eitSemw4K3l3QzFnakU3OFBKTU56YnZmR1RRVVJKaExQcVpHMFJ6d0U2OHJ6?=
 =?utf-8?B?N0VaVGVSWHdyU2ZpSStMOUh4aVA0dkJWalhzQlNrOVhQRlRXQ2VnZUtLTzZz?=
 =?utf-8?B?VlFEWFJhNTJhVVBueFNMVGh3NHBlc2xUdnJnYWVNaGkraktTUTY3OGVYT0N5?=
 =?utf-8?B?ZTJzZkZjemlUQjdDMk1hbGhERjhPT0JuSGo1ek84dUxlSjgvaGREQU1LNk1Y?=
 =?utf-8?B?bHpDbmUwemVJdkNCaTBsWWdMeHU5UE9kb0VqdEVwSjRtVmZjUlhrdEZ3Wi84?=
 =?utf-8?B?YnY3aFh3Zjk4dTdHVGNkM2QxODlqVTgwMUJvSFhJRGowTmNWQmlaQzdvZVcz?=
 =?utf-8?B?TmhBYnV1cXRRcHFzM2podWFiQ25mSTlmcHViNDRua2RGU2g0Tm83Q0lteVJR?=
 =?utf-8?B?TDAyV3JDckZmbnJOSnVLNGVCS3djeTlwSXdibVd1dXVxSTJCNVo0bldiNnow?=
 =?utf-8?B?dTVsM0d2WjJrQ3dhdXVVN2ZqbDlaUXZQUUx6S0EwNTZidWRjRC80WkpodnNF?=
 =?utf-8?B?eXlCYlNLYlJ1S1ZjdGk4RkR3cXU1L29vd3Z2a3U5eE0wRkRtemZubVFJTnJH?=
 =?utf-8?B?ZjlMbGVSRTRLRmlvK05MMnRUV0xLQzRQTUxDWHkzQXhzRU05M0N1NkZRUnZy?=
 =?utf-8?B?RzJ5bHVYUytQUys3eHVQaE5hZGg4UkxGU1hTeEZwOUlFajIwNFhWeGxoUDgv?=
 =?utf-8?B?UlZSQ2Z2bjZPbXJEbWYyWS8xSFdVNW1tcnV5aldqMkRyaUxQN0xrS3VJYzdi?=
 =?utf-8?B?ait5OWE3TGJneDdYWTF2RkZ2L21nbElFN2RvRU80L1N5L256ZmR6TEJTNHRp?=
 =?utf-8?B?Qzl2MTdKRTFYWEE1YmZ1ZDFicXNsYWJIbDdKNHJCNE5TcjRGR3NodGdJM3FL?=
 =?utf-8?B?YnQzUFpNbXJ1NGZoait0SE9EQ1lFcVJidkhuS1p4bXRDUkt3c2hGWjJIcUlk?=
 =?utf-8?B?cktkOXZNM3YyLzYvVXRaVlZtV3B1OUVkT0V4TGYvVU1hYmpEMVhPTmcvU0ww?=
 =?utf-8?B?bDR3d3BaWkxwak1ab3R5QUx2emZEYjVxa24xMW1ZSmhoYWhBT0VUZldiSm5O?=
 =?utf-8?B?T3lBR2pRWGErRGUxNDVQSUxWVlFkeEJpdTFNQ2U4OWUyUEFVOGQwMmhhWitU?=
 =?utf-8?B?WmNzaHcxeExLSE9od1V1bi8xVHJzRXRMVUdlM21xQWpqN3ltank3K0toT1Qv?=
 =?utf-8?B?Q3hOZWhab0FtZkc2UWJ1R04wczliMHdmay96TW5XYVVKSGowQ2dpMmhuaUdu?=
 =?utf-8?B?MEFzeUJoT2k4RDZLTStUdGM0RVp0TVB5UGhYcVpLak9sa1E0K3NOOUo0UWZj?=
 =?utf-8?B?QithZ2FvZTc2MFdGcHJiNTY5cTdCRUtvV2JxM0QyZE91RlVrYStRMHRNNzJa?=
 =?utf-8?B?TW81VWpXMFYybi9XcnlMckpJT3hyM3BrMy9aTDR0MmxSSkxibnJVYy9SUWdo?=
 =?utf-8?B?aTg0ZWZ1VG10QncyWlB3UXhRMFVjb1lRbFBLdHFIQ0lIYVR1MExPcmtpUlE4?=
 =?utf-8?B?Y1RSWm1ZcmxLMlFOZjhydC9tRElQWDZqb0h1RTNPMWZHTnIxdWZyd2g5MmZl?=
 =?utf-8?Q?c2RRiVjhYSMwGV+dsg4T9gNRp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714142c8-8122-4354-c126-08da823dfada
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 23:53:14.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGvdecqF5AaVhEdW6DLuWEDRfY4cORBzajsqR1UgEZBU+w08GodQzrQ8Nux4//dxF7Gb/l4z2OzS88+TevYIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_13,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190089
X-Proofpoint-GUID: isAx0SfV-0UL5ZzaI7Wn6UO4g5bR1pLG
X-Proofpoint-ORIG-GUID: isAx0SfV-0UL5ZzaI7Wn6UO4g5bR1pLG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> Remove the orig_bio argument as it can be derived from the bioc, and
> the clone argument as it can be calculated from bioc and dev_nr.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

