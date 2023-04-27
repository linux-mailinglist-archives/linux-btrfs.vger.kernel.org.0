Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09346F080C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbjD0PQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 11:16:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8635A6
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 08:16:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RF4ZRH012683;
        Thu, 27 Apr 2023 15:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EQxwwstViYzeT04GJOOsTmNr+lVuCo16ncNqz0PErwU=;
 b=KY4a78IQKDn4ynYTUYQi2fu90EVWLjdilyeLEiQS8NnxHRKmeolJ40gMwPUM0c2v98hE
 oOeDgMQYFTwWobPtjYJI8j78SBPo8SICr/AHkePyZYxOgHcw6+nvfyG3dNQYOSjweoYb
 btEH7fCkEXZP4Sa1fEira+JXyu/jKJBDhAwQPuKhhsFjH7NKJ978cn+kIDUx0lEZG3oO
 0l00tJykvYp9MWxh6KcamIh6ZeKAL+8aThPxv3kuQxn9505XFMyY0g8g8r748nwhxg1H
 jcy0nyi0ilxPLzq2SnIeR1EiCM+zkTM5teU7GGVS30ZMlOVvqC9XawWLG9NWccMUUmMA 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fav4pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 15:16:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33REZfla007413;
        Thu, 27 Apr 2023 15:16:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619fuwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 15:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3QxtZzcU/AZ0oUIZQf5waCoMZpRtFItme+0XMxFG4HFO3jbquJnYhEqxlqKDLDnr5ut/gt6Q+lFX0GoEnOJ9Znwp5ntjmMrXQthUP5uDWkXPs5JB7om0scuHa2aGXq9L6z86cZq4Ly7QXvo2aDHBMZAbUYYoJ6BwNknrhqIm1F7JFzd06ggSLDPJlaa7HVnp/trC/r3pgi/l4KQP/O6hxauU0blAYP8V+SkN0KX7Y77gyCLEgUeDlsx2NBFEuQhBjFCucwc0J1hiLo9icEEi2ziv0os2gE/jHyHeznz3j6cWTc6rJ5l/OVJwtN46cfytLKBsAlnXd46qdKXniuujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQxwwstViYzeT04GJOOsTmNr+lVuCo16ncNqz0PErwU=;
 b=Ce6jvoWMd9QcWKg8miYDqUu69pXuYOH4w9/w372s5PckTTklfur1AKoM+wLy6vq12o/kTpFGCcDKy7Ljg1WfAroZTtz+8+RFI93O6vJct+ScwyyOVXhix4XRDkJP9UtCFA16ElP6YbKo3QDPRLq8eTO57JtpqA68KrItv+mDCft/q7xBqohh3pdJHujFXdosns+8QtxcHISu4ZPp/+F1Kkx+PdO0jdfl9yV4hX/irweUYCmGzs5lLvLIIfumk2j2m08dvBv0wNqrRBHRDrZvYvrMCV7DqPNezb9d9//UHgcgLu8r/iQ9xvT1YPUb5xgUnzktR3h7jrCImEcj0utnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQxwwstViYzeT04GJOOsTmNr+lVuCo16ncNqz0PErwU=;
 b=hYvB6LSDOxGmuloE9wFiCpMAqLe10lr2DwYL+i+hKCR2SbJCdgfCRza0HfTTsMrcoO5NP45YpZNAfC18pxNo7b70xyF7GNWnBGt/INWOuEntF+85guJpg1h+cQEdmEYnzG/45Kdvi6eGtg4Xxj8EklQXqxl9tRgtXM1O4ybFDI8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 15:16:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 15:16:26 +0000
Message-ID: <043226b3-3543-0430-c479-7a1824be5fa6@oracle.com>
Date:   Thu, 27 Apr 2023 23:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] btrfs: fix leak of source device allocation state
 after device replace
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5b73a5-312f-426d-f0ee-08db47325e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaATckBwP8XMPdNXLirAiq5P/pPvxJI1oGgc0V2If5xPC9uz7mtADPoFv7VJGyKYqV+tM7oWbQUT/EIsXpDwa7c+Qms3VnDjmYlEa7e6P0JYUsiZd9Mhh+qX8t+2bhXnMRHpVuRN+DuEdUlHSmLAIkwG2zUBc5/houEXFDK80fzh1q9w+6jSWD5BWJg1GBDF+L7nRLX6USxlHc/hPTZDx6DrqGmNEm05CYXbpuABNqDU/x4BEh3D7ntX4noGcROJXNSDXa2sPXh1LerGRo2a407q7hR1ruSGSSKaqhb3urItV4dArhYldCCrZo8E4TcP1yV7js+P5rHU5FQ2+dd2yQjdhta+Xho7zAUaLII11gQnrHIH17wxFm+lUKgNaj2Uz0rT2b8ixUSWBqgA6WKDtP4t9knft++B9X4nDiUOOX+LyuNbj78RorBl1Eh/Net0zZ/XTbX/v9cK3tCaD5JGHIkdFrWwxKtFqdAF8lskdtisVHKESJCm+8gfqadOYXbsyZqa4QhSA7EjguHe5f9vOdIy97j1HqDy7IfjhHoatuR3uwsMBjPUUFUrXxgMK2KZ1D9zV+sfMct8It48ey/pM7Kax2xSRgMsQfqZaKinsjN3VY80exKeLvEBdb+u2o10CIbL/rfq1nRIMH/MQIuA9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(6506007)(53546011)(186003)(26005)(6512007)(66556008)(66476007)(5660300002)(41300700001)(316002)(66946007)(6666004)(6486002)(83380400001)(31686004)(2616005)(31696002)(36756003)(2906002)(8936002)(44832011)(8676002)(86362001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2gyRXBCNlhRbUtzTm5HOGtRWkF5cEFDV3BWTjNUM0dRejVGSXRubXV5SS9r?=
 =?utf-8?B?K2NDaEt5MkJTbHRNSFdwZkxrR2RKakJUczNDNGQybktJVEo4NCtnbDQrTTBz?=
 =?utf-8?B?eEFublcxZDc4TWY3dGIwUng0WE1BTGNQRE9wNXRhU1ZUbjYzZEQ1cVN6T0F3?=
 =?utf-8?B?Y3MvWDFVSElySW1EenlJWkwyVjlYcXV5c1huc3F3SkluQllWZzBJQ3hRRXMw?=
 =?utf-8?B?T3J6b1ZWaXZRRjE2czcrTWFlWkRXZG1CYTA0TjZVM1RCRHFqRWNBTjZUTWw1?=
 =?utf-8?B?QWZHY2l6Q1I0TDFmVHhRNTgvY1NzaVpXZElTME5sc1lyQTdUZlhZbVQvTlpR?=
 =?utf-8?B?VkUzMmd5OHpsb2Y4L0pseEFZRlZ4QzhnUW1CZndUM3lmWEVCYlZ1cmVuWWRI?=
 =?utf-8?B?UWdQVkRIUWl0TWNGdVpReUpIVGZ5c3BXcFlGSFV0eGpTZURhRkZIeXRhSWwv?=
 =?utf-8?B?aWRaSmNFdEJBWGpRVGx1Q0h5Z0c2VW1jSDVWak51WmkwYWp1dmhET2VuQ0FN?=
 =?utf-8?B?aGxrWjlwQ09oU29UZ011QWNlY0hPOW9YZitVczNuL3M4cnEyeS9PNnkrQXdB?=
 =?utf-8?B?SXRwY1p4SkxDZkszWTF0ejk0RGxpZnNUQ3QwaEsrdHM3eUkwMGExMUtIL3BO?=
 =?utf-8?B?NkcwcWlYM2EzZTZ2WlZmVC9BRXArQzVTUU42YVlxVGdxYUhkOTBKdGRKWjV0?=
 =?utf-8?B?SkhsSWFEc2ExQVI2T2VkWGtIVlA0WURwejJLUkNPdXZXT3hVRnlFK3BHcUx0?=
 =?utf-8?B?cU12Ny9rZnJkdXdHSnFkdXBjN3BqczdJWk1wZVgybSsvT0g4UUlwZUJia2F0?=
 =?utf-8?B?bmRYWThWUE5Hb2o5MlpwSENzcU5PMElpNWpKTEh0UDFBbEZldHNxWnNDQjJG?=
 =?utf-8?B?M1RSY2tBVHk1QU12Z0svd1lZbkRoOTZ6ajNkdUdEbHJ4YS9NTDVHN0FHRGFS?=
 =?utf-8?B?S0VsQ0l5ZzhEQkV0Y2o0ZlIzZDJTVUcyNFJKWUcvcm1HSWhRR2dpTFdMN2o0?=
 =?utf-8?B?b0QxeU9pb2w5NmYzK0VDTGZ6V0I4M3FhbitIWVBWWjZnaFpIbWF2RWNQYnVk?=
 =?utf-8?B?bEZvSzBpMytWaHhLM3VicEhVS21YVEt0a0N2RTNVYUQrSEY2d25GcnZLU0ZQ?=
 =?utf-8?B?UEFEOHRCeDV0RXByb1ZUTW1JZ0VhWlRsaUdoemExVkxxdSswekZMcFFtYk0v?=
 =?utf-8?B?eFNRU3hrNFJjVEJrNkdNc2NlZkVBd05wRWFtcGh0MGFRY1FSdmh0azV0MC9E?=
 =?utf-8?B?UTRiekwxOVlNeFlSYjgvdHhmTkRiN0pmeW5hY0xUTGQxcnpEZThaUVByYVlY?=
 =?utf-8?B?YlpDZmsraEgzSlRXUmVxRWJZdDhzSGE4VTVwc0R3NmIvY2FBNDhkYnJmdDVt?=
 =?utf-8?B?Qml4eVIwVDF1eUFZTTFEK3FPVkh0NFNrd2pPNmh0TTUxdzFPb2NwaWc2WktQ?=
 =?utf-8?B?SGNDUXRLZk1oem9CUnVTeStGTlU1UWZRWU1oY1JUMkJHNElPemJRNXJJNENX?=
 =?utf-8?B?bjErY3ZMaDBHN0ZwMkNjb1BPMi93Rkk1NURaa3NwODlQeHg1M0p4Z3c2OVha?=
 =?utf-8?B?bzVDd1RQSVBURDB3SDRUc3pGVWxiVGN6a1ZwdElpNTlaOHlIeUZSREQyMnh4?=
 =?utf-8?B?NjNxNHFHcThQOU5rZFBzaHF6L1BxYXE5VFkwQXdiR3pPZ1BTQmo5Q0tYdzA0?=
 =?utf-8?B?U041bWFXZHJCRHFtbUJOSFcxaUZRbHRac1IrTW1oRzNvS2JVejdRMUptdkM5?=
 =?utf-8?B?dFhwaEhoakRuYXdOMnUxekJpRTdSMTBDVERhYm9oUHQzTzRRSnh1NC9BYU05?=
 =?utf-8?B?UW9pWUFvWThKS05SYnlkQnBNRjljRFBhajlrOVJ1M1dZVVpad0ExYUtlMit1?=
 =?utf-8?B?bnIyV0dldjlTYTJUS0RDWDRJZUFYUWkwTVk0U1JmYWE0UEJTbDdPOE5VNU1K?=
 =?utf-8?B?cnhkKzRLQjB3MlArOUh3RWlYMTM3eHZraDQvNm1QMU96cXlxN05oUndMalV0?=
 =?utf-8?B?VzlrVEJNZWJYZE9RN1I3QW9OQ2xiSGpqUzJlUFJBbjg5cTNXeHVSUEJPeith?=
 =?utf-8?B?MGo4VlRsOHlCUjJqSm9HZ2FjdVFZa1B6d1JOUDhnYW5BVm53b3dIem4zMVdm?=
 =?utf-8?Q?OP8M3L+ZqypHCHpiQadyap5g+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EYvFKXsTtZRD9TvyoiwK68zn0OBwYKmItyyNg/e7E+/ooHDFlYusaZzspA5ft5OImsonqlqAP2yAH1HSWCBUu4ro31pq9kELry45b8NBtctla6oCewD1rI12dRLgTf9TV4TUTKH65YXTZdVBkl0NfiAM7aK5qWw98r8k5O+jLrO4LvQwWoyhmsJWwaOOnHWM+Hl0KmzlgFuuZcWqZkvmablsggvDSAdpigJ5ishmjNLI7dROlotcfIyJ8PM+AuKg/o/sOwCo8ZsPIOxcftC8jALkK1V3bSOroak0ix7VnlYe1waXTlF+Fd+dHY1Rrfj6ZeKwkoua65Gqi1QamcXO/+6GvQ8X1Sqe2zm8NOW+PwfTui5Ns6jZlagxINLbV1lEmqNs6O+EGHQTRHkOi1oeFNgNJ6peU2BmJ8sjoMwyuLxdJcGprstdxNfqSenInIIMFWrTsKVq2JroDtM6nyIKi2AEoybj1EIv9mkWlx5LhJtSgAqPXxO04ZQk2NQv2YnWgvHxQTHGr4Ppvw7qH1YtDDe+s0nhL6/3DtPO+VN03fRj//4w74Y/+PSAd6xmZZz2OIpwAEMelXqc1Urfqxi7qXGxyu/kGeu5P7ZfbU6BodXNWOE+2rsxwuC1QAzXgYqvmnPrwIi9dA7gJdy8PJ//dsvdG2oT/xKQXn5EnzLIyW4DjY6qHsRchFfszN/hDF0BV/L2G+FxAtAoGaSpeX5NThmwUn9oXz1lT8mldgQK5PJABB/1omXokJeVisKvx/DNbvt5TvDtk+L8wkN7UGDFeiSJhPEVhc3m/nuaEjhw/RE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5b73a5-312f-426d-f0ee-08db47325e75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:16:26.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPRq4LOrmI37IHUbhhYjiOrEbO5EM3XLXku+zg5RX+izp66Xj0/mgh07NTGhIXdu7t2gG01EEDK4dJODYh0IjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270133
X-Proofpoint-ORIG-GUID: auBv4-74OX3oIEjm6DufekiKG3C24xxA
X-Proofpoint-GUID: auBv4-74OX3oIEjm6DufekiKG3C24xxA
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/04/2023 01:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a device replace finishes, the source device is freed by calling
> btrfs_free_device() at btrfs_rm_dev_replace_free_srcdev(), but the
> allocation state, tracked in the device's alloc_state io tree, is never
> freed.
> 
> This is a regression recently introduced by commit f0bb5474cff0 ("btrfs:
> remove redundant release of btrfs_device::alloc_state"), which removed a
> call to extent_io_tree_release() from btrfs_free_device(), with the
> rationale that btrfs_close_one_device() already releases the allocation
> state from a device and btrfs_close_one_device() is always called before
> a device is freed with btrfs_free_device(). However that is not true for
> the device replace case, as btrfs_free_device() is called without any
> previous call to btrfs_close_one_device().
> 
> The issue is trivial to reproduce, for example, by running test btrfs/027
> from fstests:
> 
>    $ ./check btrfs/027
>    $ rmmod btrfs

Ah, module reload is a useful way to verify. I have now enabled
it in the fstests by setting TEST_FS_MODULE_RELOAD=1, and I am
able to reproduce the issue.

>    $ dmesg
>    (...)
>    [84519.395485] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg started
>    [84519.466224] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg finished
>    [84519.552251] BTRFS info (device sdc): scrub: started on devid 1
>    [84519.552277] BTRFS info (device sdc): scrub: started on devid 2
>    [84519.552332] BTRFS info (device sdc): scrub: started on devid 3
>    [84519.552705] BTRFS info (device sdc): scrub: started on devid 4
>    [84519.604261] BTRFS info (device sdc): scrub: finished on devid 4 with status: 0
>    [84519.609374] BTRFS info (device sdc): scrub: finished on devid 3 with status: 0
>    [84519.610818] BTRFS info (device sdc): scrub: finished on devid 1 with status: 0
>    [84519.610927] BTRFS info (device sdc): scrub: finished on devid 2 with status: 0
>    [84559.503795] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
>    [84559.506764] BTRFS: state leak: start 1048576 end 1347420159 state 1 in tree 1 refs 1
>    [84559.510294] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
> 
> So fix this by adding back the call to extent_io_tree_release() at
> btrfs_free_device().
> 
> Fixes: f0bb5474cff0 ("btrfs: remove redundant release of btrfs_device::alloc_state")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 03f52e4a20aa..841e799dece5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -395,6 +395,7 @@ void btrfs_free_device(struct btrfs_device *device)
>   {
>   	WARN_ON(!list_empty(&device->post_commit_list));
>   	rcu_string_free(device->name);
> +	extent_io_tree_release(&device->alloc_state);
>   	btrfs_destroy_dev_zone_info(device);
>   	kfree(device);
>   }


Hmm. Is this fix incomplete? It does not address the concern raised in
f0bb5474cff0. Why don't we also do this...

-----
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 40ef429d10a5..e8c26856426e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1133,7 +1133,6 @@ static void btrfs_close_one_device(struct 
btrfs_device *device)

         device->fs_info = NULL;
         atomic_set(&device->dev_stats_ccnt, 0);
-       extent_io_tree_release(&device->alloc_state);

         /*
          * Reset the flush error record. We might have a transient 
flush error
-----

Thanks, Anand


