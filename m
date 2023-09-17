Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E77A35CC
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Sep 2023 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjIQOQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjIQOQd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 10:16:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A7124;
        Sun, 17 Sep 2023 07:16:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HCok2B010810;
        Sun, 17 Sep 2023 14:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=LT4gByQgDOS/lsWJfL1LLBvpEt1o1QPYTCEImo5YZ5M=;
 b=L4zJPZLuw0IHdw2utXnNTm/Jde7qjfXCAluoZ9N/OcEEx74wZtrxhkDnbVDcghLEHb/w
 dA61w39/sRI6MxVeV6JjxM8iYLM8iMf70dPqjRzsNu5T5u1Y8wUvQfSrMgoT3YeGivoI
 B2jnmrWVPLu6+aCVquWiBW2dssPT8yhuioUxNAqecfwJOf3LKyORO9lsiMf2Ydt8PbYn
 /kyEQ6ChwpDTgzhtLUpZT+SW8AbY/epID61F6SUeiDp7NjfJR5z3GmsZXrn5AB6BcFkk
 hFNn+Z74lSmqWihaUoW7JkddmqoxhPRsI7qSAoBAeByB1hP1U8BhTnDaPjhPkomwgenz eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu1adp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 14:16:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38HDLAEc030850;
        Sun, 17 Sep 2023 14:16:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t3fk80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Sep 2023 14:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4Vk9PCL1M8fTgLshiIVZDQTcZY2N/ARD36KN8kqKrZJ9ScyOsmZkWugx3vQR8WvzQuqBK42/r0mTg1PiqZpcIQSXispx3ma1aTuV+HRCUIDRlhSid7TRpYPMBETwBu5tS5ewOBGdPgOL9f6zAIppq+PjJtGZQTHmS6BbbAn97HwbCWn0GS1mMBw/mTY5Quc6e1eyz5WKtbTxs5bf8YIFZ223fOd6PfacAxQBr9/y3StV/Xa6QXFCi768mV7Ot2PqI7EBiCo3EXemB8enzJjsGZUsT72rgPeVF0DiUtF7hr2/5O3UDfT5XE6Q/bz2dRP+9LbGYnvBG+slQ05ftCIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT4gByQgDOS/lsWJfL1LLBvpEt1o1QPYTCEImo5YZ5M=;
 b=Dn5ePDHPt5HBXlrfFWgt4ehVCjzWLnpW0d4gQSWjmaGKcxqMzzcPDjrruh/1ldfq+xw7Zbzudx0EsHS9wZuqUTBBuXdxaohLP8MJEFab1HN1JlU+kLNb0oFWLK2Ikcg3dFMI0U46WaFQCaBq4ZZ71rnAm5WWgJW07HD75A7lLT0G8x85P+owJf+cbSH8llvDW9nIj/xIodBbPnD0hTWmqLuLYXXX4RkYnLe+S31egkg5Op/+Qzz10EX+2j86d8ODRJceyDEE3nfeD79WYS/Lz8sFZLogqpP+20A3BJVWq2+BdXMODJyK4h25zg5WUAp7GPiPXYaA+3tpSi0MHKQ7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT4gByQgDOS/lsWJfL1LLBvpEt1o1QPYTCEImo5YZ5M=;
 b=q2IhREfh28WMRzesqTPVSlHnuPTdnJtZMkLvDtylr42rgjb3GWJppJY4qGIwcKU9TZpUY1N9V19k4cG7O3kz2pi9q28OsrgTXTi0uup2KEGgy1XRtifyPkrlMzPKyvWFXAm2zz5Blt7naAOUiAXxptouGQ7h70LAW5FtCTYge+k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Sun, 17 Sep
 2023 14:16:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 14:16:15 +0000
Message-ID: <2a2f6e34-980b-2c11-bb07-95e0222f3140@oracle.com>
Date:   Sun, 17 Sep 2023 22:16:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
Subject: [GIT PULL] fstests: btrfs changes for for-next v2023.09.03
To:     zlang@kernel.org
Cc:     fstests@vger.kernel.org,
        Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        anand.jain@oracle.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 594feea1-9d56-49d3-b9a2-08dbb788a6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gulNfa/LxCV07IcTXtHZBhMdpLXjfWSIqCMzj7zZrfvoS7Yfk6tY0tH5sCDApoE2ihkrP3/MSFnooExvEag9Pxgezi20TfhQDjBAQZ7XQWo4SsH3s/jXRcDZdU3/I6v5HVmoXCUSCzqLio7MW21n8I7psFMkIPvq+M5N53+FmZgw6Wlk6BhqsNqt8Tsgjkb84n1a9qtude4CxPbRmSbPAAhQl8WflH2iNBn/Q4eMiRs3uiYv+mJnagorYXN+LfA074xvycFAPgFNxBbAD0LdOynoG2AAcjkeKJRjGgAKHaKJVfe49MYdaNlVTWHsixqn4YmCm+u/PKPwfoj8Yk7wAMJ8ofc0a9hhxJ5cMMWEXYTFdB7NaJG1+ApAIrVBh7WakD/GgpTsYhFmwt6YkvayY5eReZUGMYRnp71ZAQHlPsJE8zoyIOGroYfTjyLuGOIJMiHB5EdBuarkzrFpOHrRV52ExV+KGWJXPOb1Y+l1YOtM4uNoz6JI8U7gwutggmpc1cKIh3CvcrrnL5uv4Pceffy4MNg9eZ0nNx984wh0NXXxsmct2aZP+vAz1uK01vsIruwLCbHhCrzaRtJa1k8tEoEN0gVX3Uwjnu2ycwqBhZLHmIL/ooMepVvtKQHhP/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199024)(1800799009)(186009)(41300700001)(66476007)(316002)(6916009)(66556008)(66946007)(966005)(478600001)(6666004)(38100700002)(2906002)(86362001)(31696002)(36756003)(44832011)(4326008)(8676002)(8936002)(5660300002)(83380400001)(2616005)(107886003)(26005)(6512007)(6506007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUU0SEdiQ2pORHp5NzZURWhhcmZOMHNpNUFTM3NOVDkxWGYwc081cWUvZHN2?=
 =?utf-8?B?VjFGa2F0Ty9BQWg0K1RPeWVLWWdmamZyaTJxMkUrOXh1d1Yvc1doWDM1Q2FS?=
 =?utf-8?B?dWpZTHZPY0l5QkJFTHJ2Q2tTMjI2WGZDV2xjMDNEcHV6N1Nyc214ZjZmWUdO?=
 =?utf-8?B?M1BNcEhtT2NRMEp1REIzcUNLcS9kcnQ0ckVVNTZrdGtiSTh5cFY3RHJ2bkY0?=
 =?utf-8?B?TjhVTzBCamRwMCtPRTdTbXlacExUd3ZKbmNpNytaM293Zm8yaVZxc1hGWFhx?=
 =?utf-8?B?b1hBb1N3U09NTVNjODloaG1EaUE1cVRWZnBQRjVPbkFnNW9sT2paZGxWVXJU?=
 =?utf-8?B?S0V4NE1FUVRKWldQNnU2amYxUWRYaE9PVEhDMm1OZnVnbGt0VWFFTUtxelp3?=
 =?utf-8?B?R0dlMnI1MktjRHAzOGNTZnBOTW5Ba0pPWTNwR09Bb210Y25haitQNGRkU2Ro?=
 =?utf-8?B?WU0weENVS0R6cXBBZTdIZkdqMUdnQllBVGE5ZUNIVjZxb3V5cU1maGN0bzZw?=
 =?utf-8?B?RFJjem5aSDZ3QU9CekcwcnlreFMvOVExbXI2OXFoT29VL0Roa2Irc3lZOHJ5?=
 =?utf-8?B?VzE1L2VXcmxvcFVkKys2azE2M3ZNWFhIc3FFb2NCWk5WQTVpQjdyRW0rS09z?=
 =?utf-8?B?bnhBQU9scVk3eWhkNEZadmYveFIvbUZTQTVOUW9uTWR4M2NFNy8ySHY3TU1W?=
 =?utf-8?B?NC8xakplRTJTT3psMU5pUlhZRmptL2VQZjNaSmJyQUZCYkcvRWt5OEhiaERN?=
 =?utf-8?B?MVhhbmpYTktmRTh2MzhaSUJSYndob2Z4SWo4dEFCS1czQ1ZnTmdRVzlHRWFD?=
 =?utf-8?B?eWl4dDBEcTlwZ1ZjamY5NnVuTTBTSFF6WFpPaGtpNUdzT2dlN3Z1SXU0L1pn?=
 =?utf-8?B?aW53WGc1TExqeXo0MWlqazV2Q1dQZmgwWjFrbWRLWTNZTWZySURJWDJsazBN?=
 =?utf-8?B?VEdnY093Ung3enNDcHJJZklaMkxBbnVUODlPTGIwNk1QZFVOU09nV1RodWU4?=
 =?utf-8?B?YXRHK1JWNExjb0EyMUppMUQzRTJua3lHbVZkYTVLbFZqd2pYZXovazlJN21n?=
 =?utf-8?B?VUxFMlFaYXFQcXVXdHJFSWVFRHpSL24wb0ZKUnM2TUJmeEQ2UlMxUWF2OUZE?=
 =?utf-8?B?QWYxblBabXlQRXgveEpyVHlLWVJFdHYxRExoQ3VZWXRmbTlYWHl5V0c3a1pM?=
 =?utf-8?B?N2NjYVNLM1VtZW84cVFyaXJzTUZKc1MwVnNRTTBnTmZrSUlDNUdLRlM5cTBT?=
 =?utf-8?B?WWUwcXduVW5JOW9HNkdrRmVpMFFiM24rU0hkdDVOWWNIajgzWjhFa2RzNjIw?=
 =?utf-8?B?aEp6UUtFL3A1MmRrWVVsSVJhK2NnK3k4TVRsYUg1Lzg5KytzTmhoWXRxMHZZ?=
 =?utf-8?B?RE5UK2xpWWtJK1VOakJ1VHdKNmRPOHVTTWVoRVJzOHpCUFZqclNGK1FJbTYy?=
 =?utf-8?B?dUt6K0RUNFVGeUQ0Z1R0Tnk2OUxHNVV0QTlFdDBvSnYzWWN3bG0zVWp5b21D?=
 =?utf-8?B?NTNXQ3BNYnFycytpTTRIYWd6RVJOUHJaYlZueXZOWjdTMEtGaGdhL3dwMmlR?=
 =?utf-8?B?WkpRWHpsRE04cktxZmxIWFZOc1lSd3c5UjlJQm9SaXhRcUdSR1JvcHNveWh0?=
 =?utf-8?B?c0pFQ1lVK0NQVUE1NWphcUFIbDMzckFBRkp1cC9iZlN5NFYwVjFqc3NKZlVO?=
 =?utf-8?B?cThrcDhFM1lodzdrVnZ0Vkg5dzA5eGdtWHZOY2tDTWJlWERQNXNBdHRDOExO?=
 =?utf-8?B?SGd6NmkzSjZQY3czYXQyOHFUamY4bWhXV0xWSkNIZlFWSUV4RWRJSUQ1amh3?=
 =?utf-8?B?L0FDQ0dVWVNXT0RZbXF0TVpkODBiM2Zaajd0NEp5eno5Vk1sMGpuL0ZpTXhw?=
 =?utf-8?B?SktZcjBwVmx4WjU3a3VqL2g0NnpyOWJBK1dKcVcwS0VSRXZ0ME1XejVQSHZM?=
 =?utf-8?B?blYwRXBGMG1VQ3dJQ3lpY05LTGNGY3RzSDNzbzc5dWRLa0dtdkRQL3prd1Uz?=
 =?utf-8?B?R3dZUkk1ci9aSTg4TUlFSWxTL0dZSVZDZGI2N3pMQko1bVR3dzZ4MTR4QXdw?=
 =?utf-8?B?UFZNaGtzTWhyZ28rL2d2eGlmTVFpY2RrTXFxUDlFUVFKeDhzNzVXVFdKTEpu?=
 =?utf-8?Q?Lqz95Tt/1x/tV/8Nyqe+UdX/o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D5QcPmd364jIFvH9NK+nCEoCO7Nv0yDwms/CT4B2PaGTsWX+psJO0J7/NtOOfweaLWrVOO/oP+BIguMLyibPTEdD19ajNzZem7TEnLolT5+fkDhwq3vPecunzBnbtP9eh5J045kWWBltA2kbsAIe+bcXvOfawaHqT9v2OppQkm69JHN8GdjNRiL1XbfTiiDUj2paBe5ynyITvk3wQSNp1N2V8/sWp/n5w/QQ04+d1mlLmZN+2EcncnEctBWS77qDJQZijxBOk8UqY0IHOs4H4YpbhacXikl7QM2Raosu951nvo4Qu74mBrsxMHjSjoHNMeASq3nknZiqE9lEopmgZnyxf0Evzs5ZJXK5uHBXRgt0/BTm/y8NH11L8kLcXMetw9uys026bCbkC9DHW7i1t+7AFfbaJ3JO+FpCAMSfBwaiU5snxXDwyDR1ZGBl66/QLBpjPOUo3vwBq+YcYTthm1sVGb49gnvAL6WjkFv8BEBliArHFuu5cqthz0qpNf3VyyvjJGSNGwiA/c4HkwWjqGjgLBORVN39hi8kNm3H3OiZrenGi5nuFP0KHCzjz/m4ZkcyOHBSCFhHCCeVASezWX6bAshTVd1EAEfRulpa6EPuCOf509cLPb6b447lId4IeEw+zaBW2JRilFN2UxROc6CKd4pazLbzMAnJiEkeMpSNoqh5z1yNqNFj8guB33pBH14bI/eiAbnffcXFD5I1vPv68DjoWYki4IpRmobrbkibWQlz/yvqCJsjJreAz2GN6hW7b6brSbodAJ0EKvSWlNsn44ubUlK5xZ40ZgBO9LI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594feea1-9d56-49d3-b9a2-08dbb788a6fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 14:16:15.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5ehL/g8q4ecJrvAgCz6J6ErG/5PNXG1zm6WdLlHpqvJIRZmqPzRp7ov9Xg6DsJC59khEY8LCekD5AlFm6WbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309170130
X-Proofpoint-GUID: lnu9ZMiWJ6b7zhLmt1cawI0NKg6XzPOw
X-Proofpoint-ORIG-GUID: lnu9ZMiWJ6b7zhLmt1cawI0NKg6XzPOw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


These four patches are ready to be included in your for-next branch. 
I've consolidated them here for your git pull.

Thanks, Anand


------------------------------------------------------------
The following changes since commit 2848174358e542de0ad18c42cd79f7208ae93711:

   xfs/559: adapt to kernels that use large folios for writes 
(2023-09-02 13:54:38 +0800)

are available in the Git repository at:

   https://github.com/asj/fstests.git for-next

for you to fetch changes up to 964d3327d3954ed589bf4a2f8c86302bbb37acf9:

   fstests: btrfs/185 update for single device pseudo device-scan 
(2023-09-17 21:20:53 +0800)

----------------------------------------------------------------
Anand Jain (4):
       fstests: btrfs/261 fix failure if /var/lib/btrfs isn't writable
       fstests: btrfs add more tests into the scrub group
       fstests: use btrfs check repair for repairing btrfs filesystems
       fstests: btrfs/185 update for single device pseudo device-scan

  common/rc       | 16 ++++++++++++++++
  tests/btrfs/011 |  2 +-
  tests/btrfs/027 |  2 +-
  tests/btrfs/060 |  2 +-
  tests/btrfs/062 |  2 +-
  tests/btrfs/063 |  2 +-
  tests/btrfs/064 |  2 +-
  tests/btrfs/065 |  2 +-
  tests/btrfs/067 |  2 +-
  tests/btrfs/068 |  2 +-
  tests/btrfs/070 |  2 +-
  tests/btrfs/071 |  2 +-
  tests/btrfs/074 |  2 +-
  tests/btrfs/148 |  2 +-
  tests/btrfs/185 |  5 +++--
  tests/btrfs/195 |  2 +-
  tests/btrfs/261 |  6 ++++--
  17 files changed, 37 insertions(+), 18 deletions(-)

