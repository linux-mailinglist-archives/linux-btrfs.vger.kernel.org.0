Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8939B8A4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFDMEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:04:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFDMEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:04:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154C0Mm5096052;
        Fri, 4 Jun 2021 12:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H0d9VhVyVS0Rj9k1f3SjO9Dcku19BJo+eNAZ07QITfU=;
 b=i+9asNucwUo7wmNlDGAkOxTBTYgFxnrpuoh+EYIcAyEGzDZbgqzxLFrIDC6IRgOBqOjy
 M2fp4GxdL6RxX/pHsMKAcoi8ACMVqDdPWeTkaVUHE2k5lOSAI7/4t0NKOXXBD8OBGMdl
 LeiQ7USVDcgn/49VNA0OY79ByOHUfLuXpOALofaQDZhYY0xj1FSM82Dqj5etQI4nTkuT
 UccsqU8NVhyc2Q6eEvuoV5hb0J8yccr8wAwP9Y2T204PBdAoMRmFmkkPS9pvPiAS9dnk
 impt7+6MPZa+bHPiKrL+EGsSwXQbDXkxHq5baeJ/Qdq059WxgeAFTNjdZL6Y4NzCmQXw +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ud1snrs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:02:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154Btavj179508;
        Fri, 4 Jun 2021 12:02:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by aserp3020.oracle.com with ESMTP id 38xyn3chk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRjuTO7dsl8DjBjZCFlxb/lI3px1h3+r7c2VKwf96Lx9NRgp/Y8hXdSTr8HMz+bqcL27lUyjvn9Z3LU+WEgow6rnF2IbjgdjvNP9jeXUF78xm9QLENNX3RdQMN9L372jmGjxTPIHRucHzUfNuFzNPEst2BhWZsJCJtSIU058ibFuU/o/+BdNsrEODjn8ASISL2XueZPZ42iGGLTnusittBzipNclG9bW/cS7V8GYNX9alItZmGns3aFhrAa52gjwwBqRLEhAc/OrkUIWzzNU/PGt+HSKMiUKYttl1rvrD5NkfLTUWI8A8Suik2sTmjKNkskOQSqSoKK6gZ0cc7CdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0d9VhVyVS0Rj9k1f3SjO9Dcku19BJo+eNAZ07QITfU=;
 b=XbD6vesqqHru8F7P5TVbEmzUlaNW1JSkOnRdWr3OvRUS3WPyuqwq8J32R1xWLuBiX68LbvBvn11S1678Mye841z5S9Lb2fgLIkQxTW5GtykTZTSt0ilY/3nNSE5Q8tqhjwQkgDkI+byUfdQn2gSysvTda7/vf8Mf9RZkGp0h7/b6K9lHpeS5/tkxsBgUx0An/slmBl9FByzH9rbp4hJtehWIQKiCtyQw/jzuzxbq37/WqqEEEUWXZHryvQIlZ+PX/L3e99bSb0witX8F+xb2qgnq3yRsZgdluYbyyobOkf1QU26xe+Tw/5X9M10kpZKuzydUVOSu9a0w4y3VA0H5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0d9VhVyVS0Rj9k1f3SjO9Dcku19BJo+eNAZ07QITfU=;
 b=lfeV5ApNdlffkdRoA2i4BLZH9Vy2fyzwnLBbWnLl2vpLw/LasRwZzyhU1DWc8m5eCpsn+VzvFXokkgTRFZ7YGsJu7wnuS8em09fG2pTP3y+2l2QDvKRznpbbtmsaDKDcqxRnGcIwemYfOsLGi8CXwdVWg9QRURekCk7N8VdjADo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 12:02:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 12:02:25 +0000
Subject: Re: PATCH RFC] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
To:     Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <2c3054e5b93f023cabd003ab4006d5f18ef3d484.1622717162.git.anand.jain@oracle.com>
 <20049d72-e875-3f4a-1f2b-ec3f1ffde354@cobb.uk.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3da5a7b1-e56e-aeba-c588-3763797e6ce0@oracle.com>
Date:   Fri, 4 Jun 2021 20:02:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20049d72-e875-3f4a-1f2b-ec3f1ffde354@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR01CA0141.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 12:02:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a92ea028-f8a6-4a3a-a8c0-08d927509e3d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4317F3EED2BC846045CC17CAE53B9@MN2PR10MB4317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir39JuGmbZBcvwjwljCmFsgi+PUtrjjfEVf/S32qilzzHeT3rBfgKYlbNKRiJcXYtinHlEZu/CC/Fw1k8NnCf6xXGKh3s6VXk31QYTjk5N3jhj7pVsuXUej8Q5y35WC4OgL9zjdbBNPAnr+MEtEllaCMPa3JMhXR11U6OqU0KIZk/DKVcDZMqW69v3o3fuXA/FXAjisBfCN/b1WzqC4ZNxsqPRzEIXeMZ/do/YMqiCOWtAkf8OyO4GWNcGUUpi6XYpU5KQ3NcqBf+iTcZy6OBSFM3q5qPgurpgGRJv1vb5Nrw238WQF8lriYr/so1sC56Zh5+F2pFB3gEB3I0G2pc8BSvSP0JdtbNUnIuA2JUxBY/4voMUJxUnIV6t5x/RDF/A34OKCOvsb3TvaGd9Bz91KRL5s3g6TisOs+sIJgFygeXvcEuhiVtIKgPli/z+/aF2hBsLEGqHnqTTezzIXsSqGzTc6+DDKV69uSvRnzMNpqpHPmRB+dP6budw7rdsh4RgHwR925thKao+6jpjwHPmHSkBQdonzrnPAARkH+CSGKZSJuU0tIB9VObRRXgM6eJxOdFbZljGKso9allsq5pH+nts+SmjzbgNGOAeAg9wiDbV+Ku6r08LNM5Cp2shLrb2b6anZ4z7WJIugmC700Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(66946007)(16576012)(478600001)(66476007)(316002)(31696002)(38100700002)(66556008)(186003)(8676002)(83380400001)(6666004)(53546011)(956004)(2616005)(4744005)(26005)(44832011)(6486002)(8936002)(36756003)(86362001)(5660300002)(16526019)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eUdzSlFNU2MrcEVhZzljRFg2M2s0TVk5bXdObktlRW5EajRkaWxuRk0xNWdu?=
 =?utf-8?B?TVZsR1E0R0ZWY2REVytDZVlOc2dRNC9LSzQxVjFVQUZRa0xJdlplUnRqb0Rm?=
 =?utf-8?B?R21WSVg5alpaODl6NjVsSXNFZ2RobnhRaDZjWElPTUNUeHNCR3k1TEl6SUE4?=
 =?utf-8?B?dzZaNHhjV0hDUzQ1bGVqNGNBd2N6K0xaSUNqUmxSbHE0VndJcWtZQTQ5Nkln?=
 =?utf-8?B?SHd1RWhLSjlSdURNUml2RHpUbjZsWE1SamExakdsbkszb1N5c0ROcStyd0tn?=
 =?utf-8?B?b0QzVjcrQkFJYnhqRXduV0RqZ2VUQ1NhbGJNYjV6Z3hrUkxUT1krZTY1bE42?=
 =?utf-8?B?UE5reHZjWm9uL0dmSmxSZ0VBK0NDV3BneVQ1YXZnYTFDRFVZZE5lVzFMeCtB?=
 =?utf-8?B?anlDVkR5blFzazJnd3ozMStrTE1zRENrZkp5MzQxeXNxbHBqY3RzQUZDcXFU?=
 =?utf-8?B?NFc0bjZtSld6U2NnYTVReW5HTTRRazgrL1l5MFJzRWdVNnBRbW1URXZHbUtz?=
 =?utf-8?B?b2dsUWFWSlptOXlvcGVwaG0zcTZYTDlkZE5jdXluWnovenZXQ1l5UitLSjR6?=
 =?utf-8?B?ZFpIbTAwVk9xU2FpQXFxQlJiWnNmQlMyeEdFWWJLZkhvR0QxUk0zM0lLZnNL?=
 =?utf-8?B?QkdTVXhGUXh1NlgrZUNwdUxmWUczNUs3TXVtSFlpWTNnY1VhcTBUdEZyc01o?=
 =?utf-8?B?ZWdyT2YwREh2YTNXdGFtMDIvdXo2UUVzNmRpRThvWlRFb1dLUi9zN24wbWpK?=
 =?utf-8?B?M09ET0lDQlg5ZXkrYlhJTmhRWHpzdDVielliOW5OZURNWmdieVFwZnkzSjZ4?=
 =?utf-8?B?V3d3UU5kb1NyTmZzMWFqMnd0YU9xZ2I0TXZ5M01iYTE4VDJNMWU5OFdwbEUv?=
 =?utf-8?B?dllPTzVjUHR1aFB0c3NpdmxVQzZ3aUJSZDEwazc2ZWtLaTNuc2NSTzMvQVdh?=
 =?utf-8?B?UkJuaHBVTWtlZHVKckdmZXdHQ1BEeDh5dHVkcFNkNDRRbGMxVjNNSWp3alNG?=
 =?utf-8?B?YjYraGFXckw2eHRHbXIyMmdONysxNjJTMGlVWTdXUitqRnIxQ0s3MTMwOUh3?=
 =?utf-8?B?UVM2a2R2NTB6M1BFRVZxcjVYbENiWnUwY3ZjaFNNTEo0THlIa0g5ZzRhRUFm?=
 =?utf-8?B?UXU2ei9QVmYrWHdyQ1pVajRqczJSUEl5UUpsTit0ZFRKOW9keW5SK1hZZGU2?=
 =?utf-8?B?VU1yNG13SHhvOHBucEtxbjRhTTNIWmx6L0lLemlCYmRObVlkYXFMRnRxS2FD?=
 =?utf-8?B?ZWNMaFNIKzZoK21vUnNKdFVlS0FXTDdoOTl5WnNmaUxURXUvWWZ5a2xrU2dU?=
 =?utf-8?B?K3k3VGhzY29ieFJSc29kSytSblU1WVExVkVrMGRXWFF4WXhDM2tXY29zMmpu?=
 =?utf-8?B?Ylh4MUtCZ096THdPVDBKaWR6ZlpWSWdydEhvN0F0elJTTERSQS9qNHlQOXBP?=
 =?utf-8?B?b1BPQXJWWVNST0p0Skd4V2pOZExSUTVyUmx1aFlaNFhrb01aQ3NQOEcwR213?=
 =?utf-8?B?L0dSajdFYXQ1Z0ZqZ0g0WW15aWhGZm54cSt3OXNORklWblhjaEQ5VDhJaFBw?=
 =?utf-8?B?Q0RxbWJrN3RxZTZzaFRhMEZYbHBCR2c5eW5iL29LZEtKWDBBUVVYSCtWN0U4?=
 =?utf-8?B?ZURSNGpyS2pOd2djUkNYU2gxb3RMK2dLRWUvNitOeEthZjNhUUNxY05IMzNH?=
 =?utf-8?B?d1UwNDYzMFdmQXdpWTFoVFlINmdmSDNhbWVZZ2oxVmRhWlFPOHBnVzkzeFhE?=
 =?utf-8?Q?FIGiqjmY7FZ7BvT23nY1wcQshbTNOFfeZXpv3Qa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92ea028-f8a6-4a3a-a8c0-08d927509e3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:02:25.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aF2sufYi1kJztKRxbDTlRll7mZCzTk+nn0VLj6KtHXETnz2cT15i3n1jrR7b2jAcN/rSnI0k10z8bLXv0mlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040094
X-Proofpoint-ORIG-GUID: L308z_OsIvAb7-co1fYoGRUVBhVpz-2H
X-Proofpoint-GUID: L308z_OsIvAb7-co1fYoGRUVBhVpz-2H
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040094
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/6/21 6:51 pm, Graham Cobb wrote:
> On 04/06/2021 10:36, Anand Jain wrote:
>>   
>>       case $FSTYP in
>> +    btrfs)
>> +	grep -q $blocksize /sys/fs/btrfs/supported_sectorsizes
> 
> Should this be "grep -qw"? Admittedly there is unlikely to be a false
> match but the sectorsize should be matched as a whole word.
> 
> If there are any greps which do not provide -w then the search string
> could be "\\b$blocksize\\b".
> 

Agreed. Match the with whole word is better. Will add.

Thanks, Anand
