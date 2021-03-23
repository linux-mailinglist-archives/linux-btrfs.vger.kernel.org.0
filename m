Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEB3457BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCWGZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 02:25:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40790 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCWGZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 02:25:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N6Po65042482;
        Tue, 23 Mar 2021 06:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yNAmmGUmMuCTIAK92AHmLxCQOglfVM/WKFTsZgKySUM=;
 b=J6NUJqW0ux1L29MUOsdWxnHZnAwlh/4STMWyFLRey0bQc5HGS9ka9tE9bycusF5GONwe
 Y/GdGNY9VRdcsCBww92npI9FkQCxMWNpQoWDqk5FnqwI6Boheo5jtvV93ghiG2z1TV2B
 FiSWIiOrBPx+Q8j/shk9BvvjPzvZdNhr0rSKj34KLhc4Qu6D1LSJbjwoiFHjOjlEIilr
 xdnLmuDnhzfjuAVGv47SlM8AlMV9pcu2MVLSRVOIdWnmwiEY52BgbR4WgWEecZ5J1+mn
 aZLpT+hvGL7z1QvY6PVK6B1zTpj0zO6lMEklw0XysWsiwuj/hdktwp2MKohnUBUEZVGJ Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mdr9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 06:25:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12N6AfRh015071;
        Tue, 23 Mar 2021 06:25:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 37dtyx17kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 06:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X42SEhVQQIHd2KECN4NEOdbaLC0n3cgC7wqPISGvujEj7aDNARSJTGuRH8/9TapJfVpNw/3R0TPZZKk73EolmJW3Yiobln2gMogDRPjBctVjLs53Td9vFJlSuWRrw2PQf6D7gO3v0y7/GgSawrHYCjlpCfH5BTleMfFVeN8FQJSUwRcajpGp509C98KAmiXqhE6sG0bpEAzeXtc/HGf+CNUNKj/RCCttFU2Hq9EbdaNo8bfdcSwmxqOl0fze0GN+WeEpONTKuekJDX/1Xq9IfNNR1TMfz+vnUGgKc5GY9fPK4N7uTCgZ3fU1Kijqk8kXM1TfhgIy59mHM1BZ//7ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNAmmGUmMuCTIAK92AHmLxCQOglfVM/WKFTsZgKySUM=;
 b=Xw8QqMsi7VVyviEe3UKVCdwZDwSICwfBHXXOF383gZ0fwdYfTQPKgbOJX+fXZDrKJIvRZnM0XSSQem6iSFnX4UdthqA1wp1n6vKkccGWqMOy2/WO8+UExKmk3UogjNG0dVl2PAS8TcG9BhnXfvPPew4bOZL4m7xmtoUmxRKjmoZmJLZTlwZnLvfO6qNL4fp8vMlJ0sau/bBp9/aT6g9/LNJYb04WqyW+P8oaRAAB6c7LYOXmop/J2e9AXsO+/Es6FfaefCpesy9IbnZ7bq4FYe9UNSKjmj5yEpmexM+oJHlDBKZEqudoc6QHrR5Nks5RGvEvOmdEknwYWyAlE9ah9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNAmmGUmMuCTIAK92AHmLxCQOglfVM/WKFTsZgKySUM=;
 b=CNJDBWexWlrmB9MpaHPoGt0e9M/5/lJOSpMPtqBLrlTf9Kdb1/9ICAEr8AokgfnpQ9V4faFk2FIWehgjdMj6moqBqV1JUO1+JYn8iFzQRpBxKvBScnGqUj0wlsNJbbppvzGUfhbtVzxuHGAUMof1586SaO0wjjRamGK5QzJbppA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 06:25:47 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 06:25:47 +0000
Subject: Re: [PATCH v2 1/2] btrfs: rename delete_unused_bgs_mutex
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <e08335fd919473b3da296514c4148f9fc9461cfc.1616149060.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <352222b5-3f60-43d1-b07d-6c3cdd68919f@oracle.com>
Date:   Tue, 23 Mar 2021 14:25:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <e08335fd919473b3da296514c4148f9fc9461cfc.1616149060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:68c2:409a:60c0:e8b7]
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:68c2:409a:60c0:e8b7] (2406:3003:2006:2288:68c2:409a:60c0:e8b7) by SG2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:3:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 06:25:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a9edb6-c8e4-423f-e83a-08d8edc47e84
X-MS-TrafficTypeDiagnostic: BLAPR10MB5313:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5313E16E8D47D612E7A9B454E5649@BLAPR10MB5313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkDq+Dyy1zhUmvPpWZOcJ5z3GITMSzE3ScM20i140CvJHPWc5NuV/Ij+sJ5juGoWYo/iDUTDKtldIs0tX6hagTBMz6RKTPLNHadI+72vAMZfi8dVRGKtqvgy8ZpsIs1wQC2yKR4cDDSPN/KYmfLi4bDgeoRzEUkTNZmjYCCT6OxVZLJZUe3GEHJPxd/6OOerEICc42j8vcdVXPxzzO7FA9/ylEMiA7tyB/DiwMS486OLEPRy4LX924ookiY8lg6tsgzMB/KFWXMy2UUAgQw780GVStywxSgsPps/zEBHj/MNzD1Gvfkn3dpOHsP/CiOZ9QQqyee12m8sTpoVIeDJeNWINXi9Yys5yeQ9B/D7hiJxS4lcZJMEJILXRBXbzgVXSWWP1AZCvPsDkEjgeSTzUZYWQAL+XloHhxRmOM7EXWa48ng4a4aGxNxtQiEnCLabnBW1J3eEoXQ/cdGqc3skybzPnlcbnTp4uJhCQwbR1HA6FML/Hm8BbAqAC/56kCLlf07TuDqS7U8VX6Si9pu10GfvaWZw1Pe/0KW2InTtG+WR5gp3vf1LpbDgKRlGhZ7+dSv9GS8hc3CaqzOHQrMnqHonfzZhm5ompk3JStUS+WsAh1WKRH2+9OdJKmg0gzKolOiIOU4Mr7oSCAh4myIMWJfw63XpjKPP2i0piHMy3Lzt5T/kXBzLTH/xhFU1fZciOWjscASG1hJXLgFTTzwmWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(316002)(8676002)(558084003)(66946007)(110136005)(2616005)(54906003)(31696002)(4326008)(83380400001)(66476007)(38100700001)(31686004)(36756003)(8936002)(478600001)(186003)(16526019)(2906002)(5660300002)(6486002)(66556008)(86362001)(44832011)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wm9lUEVicEpUREQzOEp0Y2gwMFpXODJsc2Jub05YU3UwaTgxZEZzUEtaWU5z?=
 =?utf-8?B?Vk1hSnhXcDlBakFJcnlOY2JhNHhKaTNMZnpFOXZXUGNYTTFGdnRKQW1maDlI?=
 =?utf-8?B?UjhsclJvVHc3UHZBdkM0QTI2dmsrSm5KNXg5Ky95cGRzbHdtTGx1MkE2OW83?=
 =?utf-8?B?NlRwUnl5b1V2VTFGd2pTUlBoS1dNWDN2T2NQRmRLRzREL2R0aXNuWXpXSkRX?=
 =?utf-8?B?MktIclBHcXM1YUdEYnNNSi9nYllyNDJYOHJEMTJKVDdscW53VFA1b21lWFN5?=
 =?utf-8?B?bnp2YXpKbjI1QWwvZlkwd3BUUndmWVJ5NHcxR3BrY1ExRUN6eEc1L0tqdnky?=
 =?utf-8?B?djY0aUhlYkRHd1h0ZEdkenUxOUxFeWlRczVoK0VpRnhDNytycjdKVGwrNEs3?=
 =?utf-8?B?RHk0dGFzNFVRSEwyWDhEM01rdEdsYlQ3L3VCbXZqUVBQT2hwSEt6ODJGdHQ2?=
 =?utf-8?B?azJ5dFVzYWVYTzV5QU44TmxKS1JMdkZNTVl4ZzM4M3p1TDhWV2d4cmFxWHAr?=
 =?utf-8?B?c0NZSEp4Ym4xVGxvTVZiTStZZWNlWGRzdVRvc2pXdDZEVlZoSGxwTUpybWFJ?=
 =?utf-8?B?RVNrQWtOQUkyalViakJWNUtBTUZzWWZmZDF6aU8rZEF0akthZjRxYS8vcnJC?=
 =?utf-8?B?eFpGNldjbmFudlpSQ1AvTHRmTXpMbW9Ldk1xMG82T01iRkdtcnM3RWNDMDhm?=
 =?utf-8?B?aUs1d3FjL2NIM1plKzdwL2w0UjlGb0I1NGpCZFg2TVVHeHp4cE84cVk2TC9t?=
 =?utf-8?B?WC9CRFZlQ2xOS2t6aVFpb1YxWTNtLzhUcVl1RXhBU2wyQ1hBTENoL2I0WFlu?=
 =?utf-8?B?L2l6Y1dCRkgwRVpqN0FFUENVa08wSk9JSGNmVk4ralpuSWtsRnBvbXBDUDcx?=
 =?utf-8?B?VjNFdTM4Y2FVMWdBSXJDbnZOVDk0S2haUkVFS2VydTlzL2EyTm5hbnk3NDFE?=
 =?utf-8?B?Ulk3blhzcy9vUHFsWDhCTDNKbDdwZG5LTHE0cU5RT2gyMHY4eWpENEdXYTlu?=
 =?utf-8?B?REUwWWVpSE9BY1I5R0lmUVpSUmdyV1Z3cE1iSFRFcG9yM1o1UUpZdWJlcHgw?=
 =?utf-8?B?RWNlQUUrdEtBakZTRkhWdDRrKzlRNG1hWFVWUjI4UWU4bUZNMWZKemQ1LzZy?=
 =?utf-8?B?OWFkbzZ1WHZ5NXdoR21ucmdjQ01aSmdkdEVhNXhGaWxLaFpnUUVZZks2bDl0?=
 =?utf-8?B?cDVEMkpsYWJsdmoxdG05L2tsWnRIYXlyTW4zTUMvTlBkYW9BVXh6OXZ3aVJ4?=
 =?utf-8?B?dnJqaEpFdHVna2l6Snc2RDhpZWtpNEdMa2xQaHZ6eEx4UWYwbUhQU1ZDVW9S?=
 =?utf-8?B?N1pEOHVtZHFhVTRaSkF1T3JVMjUydFFlbUtsTGhLTVJ0WWxGWXNJczU1OEV1?=
 =?utf-8?B?OWhrNjhBT2RybTEwM0tQWG1CS0lKck5pQ2JhN1R0STFNbXVEcjcrU1ZrSSts?=
 =?utf-8?B?N2VSLzUzdXlqays4SUpHRHhDb0dya2hKWDJBSHdEY2srRnF1UHVKbWZXSFBT?=
 =?utf-8?B?dzFJUFFwL0hrZ3lwcFQ4YkR6WjhyRzlDaWhObFNuZk1jdXp5L29LdnF4OW05?=
 =?utf-8?B?YytYR3MwK0VBRVg4cFVmVDJ0cVdHUmN2aE5uZ3J6eTZQNFl4aVRKbmhKQTNL?=
 =?utf-8?B?TGhFZzNMd1h3cTRrUWNTcHhtVzRwNE9RRHFUTHNaaGFOLzN1ZUVTKy9OSFVh?=
 =?utf-8?B?NEZNMVYyUnFkYjR1RURGL1NhL0dUYjNIVkVSTkJPdE1BenZuRmZNSDJmYlFN?=
 =?utf-8?B?OHVaRk1SZncwNzRYR2VLSnEzUmlyN01vejBOb1IyWVA2Q1ZmdGkwVU5VYU5Q?=
 =?utf-8?B?STVJeUVBclBYN0VMVEFMWkNHU3hBSzR5cTc1N05UQVMwbFY2aUJFdUk4dmha?=
 =?utf-8?Q?2S6a5ucZUR46t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9edb6-c8e4-423f-e83a-08d8edc47e84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 06:25:46.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR02OkaW1WLDJ7P0jkNrQXzVjTpr+OfPxO5p3Eq0FdBXFTuLcij8Vo+2+hWNrMw8Vk4CzOL8lz9+3SHOnA5NvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230044
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/03/2021 18:48, Johannes Thumshirn wrote:
> As a preparation for another user, rename the unused_bgs_mutex into
> reclaim_bgs_lock.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
