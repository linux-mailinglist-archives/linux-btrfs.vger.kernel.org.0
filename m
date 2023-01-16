Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591FE66B6CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 06:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjAPFRx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 00:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjAPFRv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 00:17:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050983D6;
        Sun, 15 Jan 2023 21:17:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G4OcOk013610;
        Mon, 16 Jan 2023 05:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=u5cXEOKJIa7v+yhn0fKUpk3dfW7cKLrBci0J+k1lURw=;
 b=2fNFvo2Crshnvrl0fbnZl9u7snqu3albIntWj/MmVQLFZGWrNR3t3XWMf3xU96uHzbt0
 L6mV2JhJpHYaUYOgEHxYL2a0VUfQRn8fVui/tzom3VSdWSZmF4yWPNbxjIJqJs2lm1tt
 37ymWwFFAJsHRHIHMSa+OXDlX9yHXFN5E8wvhSaA+YacZZag6M3mx7yXyhQdU5ho4v2j
 XmCWnp5IUsFzhbTAAhnHvM2ncH3Bk/3VE3zraIbVNy36HdQbqI2OvauTvcJQMiJqcdGR
 xuze231aDughZfT4xlPYdfSnS6BO1v2FtD3Rt3R+woSOyQVJQW7nVTydvOFkeWdxC/Iz NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40md9dcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 05:17:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30G5GQcF036144;
        Mon, 16 Jan 2023 05:17:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rxbfn34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 05:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXszvWaTWljzMoCJrz9BfB17/5ni6usnYb8pGFqDEv4mPC15mpPZ7jHCrI3Dugdaw6xKu/34Y5kjlk57wKkm56+jMiX2gMeLBMvJ5i96fuaKJnyqrLQUuK1tXDtzstP+gd8wMHbeNeIS09DtqUL8Pkhfj2G8WO4j8KduooYX2Fsj3jTSTP4hTCp5tEqCuwuH6pkr08kLr1WuQVMBTMAGm2DGQs7xOTWDLlCA7LV1XXBH3GYG+zSD6G43Fxd/njbL9LzCPU/sJMb2YmMHI8TvJnGlzG/lcl6ASrenKfE2OYU30DWLAcAkg7IXmWhV1i0RRPXiRi45HeXCKdnE2mDgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5cXEOKJIa7v+yhn0fKUpk3dfW7cKLrBci0J+k1lURw=;
 b=nVgtYNmZN1lbuTFoe8StA2p+WJ66tAzLTH18H5cLwlm4rIOf2qYzMpwbEMI1mcjDBTKMocV7SySu2ILEj4LZretHYlQSBbch1mbWtrOH7/NaRLsN0/0CXD+PxEhfzMGhbSgkOAEXwqC+FqDVRmJbwTN2ndfRwJagFisSNuFNySzTbxmLM0QJ1itE17cKzruVv0iE/+59tdY9uJnK2Qu9b40WiuSsCHbImzwhjWcXyKc8gQPFTjHIytn8KM6DOGpqv6zdeusg5N3vR7Y5STQbPZ6/boPjTQl49+a4D4DrzQcG6RvTiXdpnsKJSiwsDozJm78bS/268J+snCjIcne4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5cXEOKJIa7v+yhn0fKUpk3dfW7cKLrBci0J+k1lURw=;
 b=ZDUhUyg8h1pVoOjfK8DwXLu/wqLjZTZA1+avXYkPzqNrJcN84VdBryw9+7+BSenpfGp86yN2j7ydbz81YuK16fq/sVl+MDlWkQJsfyQvao25NIgbpHJRMmuYNIHavZYls5S7vO8J/Nl9+566KgbmvSX90+PzLSoHFUpr6N3IyxA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 16 Jan
 2023 05:17:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Mon, 16 Jan 2023
 05:17:41 +0000
Message-ID: <e9e809fb-492e-607e-9585-fc055041d1c9@oracle.com>
Date:   Mon, 16 Jan 2023 13:17:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: add a test case to verify that per-fs features
 directory gets updated
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230113070653.44512-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230113070653.44512-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0a1ee2-66b5-4665-5745-08daf780fd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzBnrICKeQznoxfT1AajwqZFaNdkWowWS/ZyEXB3tIZ/2iRs6G8HiE5zDYWKwdcInKL95zjko24BekRvHE9nbxqWlxhzz0aVRsf8+3WBBuNADC3tLY+zY1sWRGKwEIFxDHXlGTL0wCwQcI6gAFfeo68aGHHU8Q1Pva1ZXMj1jVv8cY9PWPRRAJ4/Z/Z02UKpSJ3tSHcRRm/JhB4MwWDeHxHIJ8+1VPwfaayL1Mb3MRuYd1364LZTmXyJLjSVzp05hWwpYhCDynNPDXrXp8zMxDnqzUWg7k4Ocsj3PXA4Pcuiw+SA7JYZ/Q9n8KJBzrrCIWwzXv1kpHSFVLlJKxLSowv5yqzA937PgOXAUZQ1xnD3YTxAIsd5cFqHsWZNiaoirD7uNk1QQoKglrk5iAgmL1H3FVusnWgb0pC+LCT9JuS6pdw8aeHPxI1uGkokbcGo4DK6wY18gCQjFECz0Zyab1pGsJEWTs3UqUu+yaLH4E34XXz6WCaD7VICpPQdzMVr87eZ+AT/tA+vTqU3idWTGCkbBpyBlS5ta9GXNqQqLPlBKoyyTCQ36xHH0qvY9C+vIIN0SibIpcd0sTYky9EWuYZhLTJOtLcFC6S54ckPHK7LeAtHGcHOzS3ZlsNzXabOMFJvjtDwPWrMhTrWQ6bEph/DOtpAn+DjrUED5iJbPaxA3KRT8X3qzb+1NDr1if68TtR5MsY8qa9F9WPA5eHPNsfkCo/eGt2jkEZp1QHWM9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(31686004)(36756003)(86362001)(44832011)(2906002)(5660300002)(8936002)(38100700002)(41300700001)(15650500001)(83380400001)(31696002)(478600001)(6506007)(53546011)(8676002)(316002)(6666004)(2616005)(66556008)(66946007)(66476007)(6512007)(6486002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2djKzZscUNJU2FZQnMyUVI1SlVwQmlQYUdXRi92TVlkWFF3MEw5dmxaSTAz?=
 =?utf-8?B?Vi9xU0d4VnlxWUlSeEk1N0t1dWlmTUptNGg0QTVXOE5qWXJsT0NJTE55VWI3?=
 =?utf-8?B?TkVSNFFhSDNITWJnNnI0MDk1ZWpDV2c5dkRFY1Zrc3NsSnVvRU1PSEVOaG4v?=
 =?utf-8?B?Uis2NU82N001TGNWMGM1ell4cG9lQzhQcEhWN1A5OGZmVFVuYzJKY055WkVP?=
 =?utf-8?B?NmExMjEwZWdSb2xpcHNqMjJ4WEdDQkZrVndMQVY5SmwyNkJrNmlWeHJkTmt6?=
 =?utf-8?B?NDloYlRiOGFSelp1S0gvZWhOYmtHMzBNYkZ4UnZ5NWJXb1ZhSzFEMHhCOTFS?=
 =?utf-8?B?SHlPbFlOY3ptRitpN2JmRWhOTzhpc0FrOXlYdStJb1Bva3FhSElKWnh5UFp3?=
 =?utf-8?B?QVU1Y2ROK1k2L1B1Mm9DMTlKY3Q5dUxySUdtQU03a3I1WnRFU1N1SXR6cUNw?=
 =?utf-8?B?Y1lzWHFzSzBlU3ZjODNOTklaT2xkZC9lRXpYWC9BbGl1UjQ0SmRZa3NZa0tK?=
 =?utf-8?B?UGxvVUlvK25mQTNTUExXaWtiMnZiNWRFWUh2aUsxNFIwYXB6bURyTzNCVDBW?=
 =?utf-8?B?TUVRRFVFd284VGJVMFRvTVliZVdSa1ptYnJub3dhZitmamM3RVMxbmtiVUtt?=
 =?utf-8?B?MjRNc2o1V3Q3RVpQc3RRdVZTUjl6SytzYnBLVHNDTnU0ekxhRFQvMHpTSkhC?=
 =?utf-8?B?OWJUR21VU3VKdkRBOSt6dDlHZE5GRU5mdldLY0FVQng3MUQxMmtZNmpHQmFP?=
 =?utf-8?B?Yy8zeVJrQm44T29iQ1BlbUxHMDZ1a3p5T1hVU0FKeFZxbTB3Rk9TMEVxMFpm?=
 =?utf-8?B?enFxaVBBZ3RMbmRkbVBRRXFCbFlndG15Nmp3a0hEVnhmWm9JaVM1aDZ5aUJZ?=
 =?utf-8?B?UkEvTVlDdDV5TG1hellJamhkN1dtVXM0OFlQSnRRUTJsTUN6U1h0bjVXYmJC?=
 =?utf-8?B?cEQvZ3pDQVNJTDdwUHdpQytaMkRHc1l6QUdnenc2YWVRMHBDTGJZNDVieTBS?=
 =?utf-8?B?MDFwUllCN0JndTFuR0lTVmNpRUphNGFnOHZ4MDh1Q0dvNDJRaS9tRDd4SVht?=
 =?utf-8?B?QlcvWEVLa1l1Y2JnaEtLQ1o2eDM5QlYxYlZMLy9HUFJUQW92UlNMRFVuVHRO?=
 =?utf-8?B?bTBIZkpTR3NHaDlrWnZsdHFsY0RVNEZXRW9pVSt4emhSMlZEOGhXZXMxZVJ2?=
 =?utf-8?B?ZHI4L3NxLzRrRmYwbXZyQXd6YUpRcDJyNnJwLzZsVnZPb2xmMFE2MFpXYmZx?=
 =?utf-8?B?REdJaUZJZHNPdWk3RUNvaFpDQzhYTS93Ny9CZnlIU0NnY0dNYXBiVExqck95?=
 =?utf-8?B?cWZVNEY2elF6TEk5czh0QmdGWU11SWJWaWFzZUdhTlpKalR0akF4d1dyRkhW?=
 =?utf-8?B?VE9rcEVUQWUycXJxeXdjK05FdlhvbEF6THZhY005QWUwUGlZcGhXZHkzTDNX?=
 =?utf-8?B?eVIxUzlqZWxOazJGVmJVcUh4N3JTejh4N3lwa1Fvd0VOYzNCVEtkaWtqRUZW?=
 =?utf-8?B?WGhmeGp0TmhoNWhZNHZ3eHpEcGNNU2IveDRTcTkyMU5WKzBRWGhLV3BsalQw?=
 =?utf-8?B?TEdaWm4wNmY2Rnk0cUdsMVFqV202R0ozeThndkVMeDJvejdSYkUrZVJkUi9X?=
 =?utf-8?B?MGpCR1Q3RmZybzkvZXJkUzhRUk9iKzV5T2Q2bkVzQWt3UTNnZFRDMmRPM2M1?=
 =?utf-8?B?bGI5QU1JekRVRjFLdEduUlBFK0tEV2phSHNHN3JyaEFydTlTdlFFbmhuMU90?=
 =?utf-8?B?YjFqUExncklZV2FtRldtSW5pNERwZlh2cE12MmxDVkRuVk1SalBGa2FYMU5X?=
 =?utf-8?B?eXVOMVF5TmdTK3B2dS91SXFJVm83eFJ2NzJPSjdrSHVtUGpEVE5BNStEeCsy?=
 =?utf-8?B?V1NmbmxTQ2dGLzVvL3l4NVg3MG1qeUVKYUVDdDRSOU1GRHQ0NFg3U2ZNeEkz?=
 =?utf-8?B?aUFZdXByaHBTclJSRFNEaTlsQ1FNTGVxTDF5YnlNNHNNUjZ3Ly9zV3FqUWp3?=
 =?utf-8?B?QklMSnQ2dStrYUV6NHEwUzUwWGNEcjNmSXMrcXNuek1kTjlRcENDYkFacGF2?=
 =?utf-8?B?M09Vb3hpRWtDOHdXNlY2OTJ1VGVZZCs5QnpnWjhkY0dFMUd4YzZnclM4dFJL?=
 =?utf-8?Q?EVxKCuHaIHElpKyVvd7kJq8g4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j6O/Haq8YMlLYz5oVPvDWcrDMmfYvgAm+ir2xp0CdZujJGwL1f5T2lOiNWQMkCH/hyxq1ZiCBOsckRAc29Yx0UYi4tZtf55Pax40gljSi6eTA/6YuSDCbkYRg7x4c4vfTbPecaJ6E8gbE1e+fsaBWNoakvONvKXmrevQqtRcZ4QjP1RAbANZoOxICFM9OCI85WCM8kQIeaTfs//FPqFEDIad7zt3KHIBAH9hpWCu5vEK3wT9+BDXPyLUyV1a/cM3ykxC6DZr7YrDSoJ/z7VQVvuIM8NOeVC9pAVzzDKBmwK5O4ql33seg3mgg7mQYKEJpKvnTQskOP8084gpGpy/CpP5nDatpQWKA8reaXgVn0OjKdKnYyDr0sfsh2g+lDuxrmUGZt9+R1uwyICgNuov/hy31jUWVliNXkTF6kOy8jk8LzteeP6KZX8bnyEgJpLwYHzssMhinlT2T6dsKATUGKd61+7yzM85aM94RS+kdh/ml4vBezU94j9mrwZAGImt1Id1dmBmVP6Cr71iZ07zyy9cDK8P7fEXlkaEwOTmbqPjN498Rg0j8I2Ln6Lk6yzryWaGgotpR/HP+JzS0/5bHfe7YaOSE+AtUHjDK++LCCV2kSFug9AoxU9JBU0MWrTU7IwO3Px3W1/TVKcU2rICmMTW/dR2sAvflLau4Pp6O7p9Pw1Ja+6Ig/ABPQb1Rx7LYoP9lRHs+h0WwAQwJTG6ierShEF0SkcLVRLLLTy8aEQiYqi2yJWdlZkJGmmfXQYHqGpzAQIxwhPIn8ihFKcVrF7oEfts4a/6wOHkf0NMgJ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0a1ee2-66b5-4665-5745-08daf780fd46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 05:17:40.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTDOTEzIJsFaMyJrc8gVzG5g85eNEtmfwy1WZ7jROhhCLCRFEUWgeE+xV/7P1Ub6wQXI9s2LxBT0k/S4aR0HTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_02,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160038
X-Proofpoint-ORIG-GUID: cPaiuwdTeizoMjs2mzba5kOQeIfCG3Cj
X-Proofpoint-GUID: cPaiuwdTeizoMjs2mzba5kOQeIfCG3Cj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/13/23 15:06, Qu Wenruo wrote:
> Although btrfs has a per-fs feature directory, it's not properly
> refreshed after new features are enabled.
> 
> We had some attempts to do that properly, like commit 14e46e04958d
> ("btrfs: synchronize incompat feature bits with sysfs files").
> But unfortunately that commit get later reverted as some call sites is
> not safe to update sysfs files.
> 
> Now we have a new patch to properly refresh that per-fs features
> directory, titled "btrfs: update fs features sysfs directory asynchronously".
> 
> So it's time to add a test case for it. The test case itself is pretty
> straightforward:
> 
> - Make a very basic 3 disks btrfs
>    Only using the very basic profiles (DUP/SINGLE) so that even older
>    mkfs.btrfs can support.
> 
> - Make sure per-fs features directory doesn't contain "raid1c34" file
> 
> - Balance the metadata to RAID1C3 profile
> 
> - Verify the per-fs features directory contains "raid1c34" feature file
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/283     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/283.out |  2 ++
>   2 files changed, 75 insertions(+)
>   create mode 100755 tests/btrfs/283
>   create mode 100644 tests/btrfs/283.out
> 
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..6c431273
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Make sure that per-fs features sysfs interface get properly updated
> +# when a new feature is added.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick balance
> +


> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +

   Please remove the template code.


> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +# We need the global features support
> +_require_btrfs_fs_sysfs
> +
> +global_features="/sys/fs/btrfs/features"
> +# Make sure we have support RAID1C34 first
> +if [ ! -f "${global_features}/raid1c34" ]; then
> +	_notrun "no RAID1C34 support"
> +fi
> +
> +_scratch_dev_pool_get 3
> +
> +# Go the very basic profile first, so that even older progs can support it.
> +_scratch_pool_mkfs -m dup -d single >>$seqres.full 2>&1
> +
> +_scratch_mount
> +uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +per_fs_features="/sys/fs/btrfs/${uuid}/features"
> +
> +# First we need per-fs features directory
> +if [ ! -d "${per_fs_features}" ]; then
> +	_notrun "no per-fs features sysfs directory"
> +fi
> +
> +# Make sure the per-fs features doesn't include raid1c34
> +if [ -f "${per_fs_features}/raid1c34" ]; then
> +	_fail "raid1c34 feature found unexpectedly"
> +fi
> +
> +# Balance to RAID1C3
> +$BTRFS_UTIL_PROG balance start -mconvert=raid1c3 "$SCRATCH_MNT" >> $seqres.full
> +

IMO, it is a good idea to call sync to ensure that the transaction is 
committed.

The rest looks good.

Thanks, Anand

> +# Check if the per-fs features directory contains raid1c34 now
> +# Make sure the per-fs features doesn't include raid1c34
> +if [ ! -f "${per_fs_features}/raid1c34" ]; then
> +	_fail "raid1c34 feature not found"
> +fi
> +
> +echo "Silence is golden"
> +
> +_scratch_unmount
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> new file mode 100644
> index 00000000..efb2c583
> --- /dev/null
> +++ b/tests/btrfs/283.out
> @@ -0,0 +1,2 @@
> +QA output created by 283
> +Silence is golden

