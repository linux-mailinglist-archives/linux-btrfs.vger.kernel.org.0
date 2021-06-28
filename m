Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51533B5D47
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhF1LpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:45:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28958 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhF1LpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:45:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SBgSNt017390;
        Mon, 28 Jun 2021 11:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HXTNZh1F4tG69QD5rja9qIUia21cyMtkEC7zkmVTV1s=;
 b=o7DeQl+NosU8oKRrcp4EEcqTqIJvgWy6f5jfybsv4HR9+Ydr/WfoYspC/EA8TTyyM4Zz
 NPwvhlSUIlAuPucGe9261c+89KkgfS0yZYZQIU3Y6a8PzyxbIiw7RW+gLioGVVpEjg9V
 6Wgexqzds868UTnlx9dR4CdvlOcRZEQHQAepz9I8DQYVRtCupO+l6PQjthEfmxXT/Sos
 wrijFQ8nFw2V2jyxj06/Par3MCSN6ENBikYOA2qelMyOShCIuqwMvfxr/59rhRObjtVO
 w9nfidsp/k+DQPV40IfNux8rEMIADRLHYiTlBYew2HI8e7ODcPxJjYlx5G+WYjIjZP1z jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174h2rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:42:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SBdwTD107461;
        Mon, 28 Jun 2021 11:42:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 39dt9cmkmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXqBL444UIRuXHZlHtszglwOPejskAHMAvkW4z9qdv4V1kPrDa8st/3D1+ik9zETz1mamwsoZe1eTceyqPEsLOwegX3eHDDD9A16yMVZHwsiTrBFhO1LcJz+ya9eSg70a+07YRP1/E/3aMgv8Hcb9zlvldHoeX8NsxqxUf4KVaGnJSayz4o1tqTEjjHw65/Ho8moIdbhlul9zhBOvooukZoCrKJTyDcFgvZwUS3tQrirRIwmywjqSfXDmRjZvi7edbIeWpaXyO6yiJQpk6ueDePWPzUcCaVa0pRPJbBsUCRiUjkq0leRi4TBKzRBdhb+6jSU0gI19esvf9FIzFRdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXTNZh1F4tG69QD5rja9qIUia21cyMtkEC7zkmVTV1s=;
 b=RWdoXyPns90AQogOlu+JgVs5AbtfOnx+tlz4isp0wNoi/gL8on51lrRYrEMlLS+UmSZzGC7Bic188PKWn0Wr/QeoSq1M6aV95JCw3DsYbKL702Vp3bU4TlDDghJbYsYBMyiGClO87MhHfkY1MuA82yNEi2tPuZ0v6uPZThLnoGC0RLNIIb7UsvBA7iE8ClhTZfVfzyMSRPyn1EZ+Pra8yeH8OL2MD6bcJBcfg3HeVSQpkmlFbFrR8MtqxgCVnfFe1XNOijbIJOe3at8qgC4cFTQkhbSWzEFFva9FAruKLkvl+p2HUdfvpIq+3dpESIm+Kbi/jJ4qFSjtrmo2o1d/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXTNZh1F4tG69QD5rja9qIUia21cyMtkEC7zkmVTV1s=;
 b=WVtMN0KhEa/ppevioBNw/lW2NMX1e2gGS0JfZaP4fsX0+95k6eqPmjGky6mOnYQBGbzPIp6FzyPz2cOjIRa3nbCt2cijT9BUBtUc25AN5bXvuRL4/FrWG1wDTwH5JdGZwE+HotI5FEnFKubvtnL3Bpwe26ft+RkEHqGNk+nlo3E=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3775.namprd10.prod.outlook.com (2603:10b6:208:186::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 11:42:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 11:42:49 +0000
Subject: Re: [PATCH] btrfs: zoned: remove fs_info->max_zone_append_size
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
 <c6e645b1-ceb1-bbd6-a58a-e6b696f6be8e@oracle.com>
 <PH0PR04MB7416A143777E98CBB3A0B5689B039@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7e130a3b-bb26-66cf-944d-88a618e7e3d6@oracle.com>
Date:   Mon, 28 Jun 2021 19:42:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <PH0PR04MB7416A143777E98CBB3A0B5689B039@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR01CA0106.apcprd01.prod.exchangelabs.com (2603:1096:3:15::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 11:42:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fffe93d-6dea-46a9-b644-08d93a29db28
X-MS-TrafficTypeDiagnostic: MN2PR10MB3775:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3775BAD572F074465F16D1A3E5039@MN2PR10MB3775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLocKMTaEmP992dpaheYa+eLrdUmR4quhCpUYjjJkZnzCT23N44RclXC5+W/IFPLKhclvLX4WFNznh90i+qzYZnEZt7cJRHoWsuj5hE86hjsNmq09G1ycPjeHEpEB5dzzmaGSLFMRDbKenvkYtYPbbuNWENIM+AOMBYCup46QF63J5rzW9pXmwJ8Eb/6znVX9VDXXaxTdvO0So+ca1UM1YrE4OkHrzbvGUwRBSmasTfLUpmm1Uw3pv3nSylJSRNdZYlD2WsBfuIgOqMjUquACkA+v2y0p8BWWqVOHLiQTAPHA0h8hK+Vxf+uI1Sx/DnYihc59RuKOQ33j94XnvQb+aq07Y5CYJzUrqC4vIBC4COyFcewGjItfULSmtzqso4kxKxzozZr5HKhrqYuFeogsejmdQmbqUO52VWGwiq/FE9DDjhLQ9u5AV/mxziqL6Hl5F+gPQpqdC6FwPai9waXQJVCe4q5oWhc9xWxM5gOH+PiObxOB3YyhHIe7FuNzHWz9vGiYekXeJlLoGALF+a/3+j11f3I6kcXK89h+p2xxWUhJ99otQL05bjQXV0Z2Gjw70TqgaPpbhUn+UAirM7J7eYPjTDsnhNnLDl5o3NxN9t/sypH2E1ljnAu7XJMejkFWkVAbm3EiC+NiAyWIBv/yargdfTDq//OkXvnSO6vewQ/PF19iI88F42FG6Szom1F4V5DOOz0eX9LNa0dLjI0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(39860400002)(396003)(16526019)(54906003)(16576012)(186003)(86362001)(478600001)(4326008)(31696002)(316002)(83380400001)(53546011)(110136005)(26005)(36756003)(8936002)(2616005)(44832011)(2906002)(956004)(38100700002)(6666004)(8676002)(66556008)(66476007)(66946007)(31686004)(4744005)(6486002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBJdG4zVm5JejcvM3J6REFDclRqeGo3ZHVZUHFsWlA0Um5xOVgxUVVvK1hU?=
 =?utf-8?B?VnVwWlVVTnVDallHazNESlN4R1pqNjZrdkgrMXRJWnR6eDVKaFB0OHpuMjd2?=
 =?utf-8?B?OGQ3SGxFRTU4YW8zQk5iUXlVdEtsUjBVdGNzdG5PNWcxazlXbnJJN1ovNi9T?=
 =?utf-8?B?UWE3ODdSSXdweFRGZ3FxK2dXUmpZWnJFTkdVN3BUSWlsSEJqOHpOQ3U2aVBi?=
 =?utf-8?B?T3VWOG93Z0pTQ2ZOdktMWjZuNWRFeXI4OTc3ZkZpRkEwWXUzTlA5TFdUV3M5?=
 =?utf-8?B?UG5ZeG8xRDNKb1Y2V2JGNzdTaTFXRGlRRXMwdlR5MncyaFhOb2lyYXhKTjR5?=
 =?utf-8?B?TXZXKzI2SytrVE4xUW1QMCtMOXBZTmhRTFdKdUdvdzFuZlh0djZyTlViTVQy?=
 =?utf-8?B?N0hVZWE1WGZ6amJta1FOb3hTYkNkTVhtL25hcFRQNGhLN3NDRzl1YkU4VG1G?=
 =?utf-8?B?VkJGRFdjOEUzR2Z3cG1yQndQL3Rob3B0RjdGRThoU05NendXSHVDeEdYY2JZ?=
 =?utf-8?B?VW41NXVhcW5VSDJxRkl3V1RJV3NpVVJiZW9vUzRFc0NScUk3QkpJRnBQdHcy?=
 =?utf-8?B?MThGVlhPSEtRNEtGZWhFY1NmOTZuZENiY1hEQ3UwSklMOWk4TWdLeWNhNGFH?=
 =?utf-8?B?ZXdLM01VNDdiU3p4cTBvRitScDBOOUVqaEhiMUkwK3BuYVVWQWFGRmhGVGxQ?=
 =?utf-8?B?cFpQRXNkRXBQTE55ZlcwMmJnSmlkZzRGOGtHMCtuRVVpVGJrUEVSVmlhWkhh?=
 =?utf-8?B?SFpSeDRRbmh6MjcyVGplWXRTQWhzYUN5emVJbmtFNDh0U091MUxFT3J5OTV2?=
 =?utf-8?B?a2JHMTZsNTF1RFFaRXovUjc1RkhYMTA2VGU0a3lEdHM3RDJjdE13L1R5TW5I?=
 =?utf-8?B?MHRrYnlsKzFNVGRjcm56bjJNNDVyMGlzMHFhWlhlc1QzSEJ2OFQybVpBaWZR?=
 =?utf-8?B?d3RNRVhvbEthOXJlQzNFdGhtUzhCZ2ZPTW12Z2RZRm9Jdkd5MXVwMUxzVWhR?=
 =?utf-8?B?UldYdkxvbUdnMEFkQXR6bUFkK1NlWWl5azVkWkJOUHkrb2NERlo0T1Z4NFFU?=
 =?utf-8?B?cHgrTGk1RVJKV3lMZUxmNWIxcnpGTzROVml5UStTZWtXYW9MajgyY01pS2My?=
 =?utf-8?B?ajMzbndMSENUUHc2aVl4cG1taFRBTDIyQm1oMkMwQ0R0SkxvWHduNDNJNGNM?=
 =?utf-8?B?NUw3cTMxWnFJaTNoQjhIRE1ZOHp3NnVlTENuZzNQbXNPWmRpai9RZUJmQ3BV?=
 =?utf-8?B?UHJjVm1IQWdLL29tcndjdyt5SlZONTlRV3lTdE00ZFdkaDY5Qi9RZ3hXQVpM?=
 =?utf-8?B?RU55VmNqbzBSWlI2KzVZbEF3b1lQRUlWN3FKNUlycXFPL2RIem5JdmorbjNQ?=
 =?utf-8?B?K0hJRjcvK09GbUs0YnJFZmN6OWt4YWNGcmg5QWJOVEp3YXVVNG16Q3IrT1Fk?=
 =?utf-8?B?K0VVeThTVGNsNUwxN2FBUWdMZ3BETEhEMitvVnZXdFBJSDc5MFFOT2ZrT05x?=
 =?utf-8?B?NTU1eDIzL2tqTjZNL3B0dzFTOGFUeWxKRGpLZ29LUFdpWmRSVWl4bUVweFF0?=
 =?utf-8?B?SENkczZ0OFlqV1Z6UGJMSG1oOFRBR2MyQ09CeXZPWVpZMGZTK1pXL0dud2M0?=
 =?utf-8?B?ckZNSkdkM3RWQUxjQUZqMGplNHN1OHc1RkNrL2w1WDMyemFsMmZJdVpPaTFY?=
 =?utf-8?B?SXE4S0RBRGQ4eTBvcVRwVUJIKzcvblExUXpmYUtESnVKa2tsTjN0L1RsRTFF?=
 =?utf-8?Q?c/SxsT9+W+oYcmd2Yr+BwieKh3T69d3arBgmvbu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fffe93d-6dea-46a9-b644-08d93a29db28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 11:42:49.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EepnxGAA0Y3u7Nn8bDF/LKaOEYisJHNaXfhVFZjtEyiBJMljG6miiUMEvBSKVKcs/yIRLNPdKcWzzuGUfQ0bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3775
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280082
X-Proofpoint-GUID: lNdqWl5pNhoQWzns67iEMKVmVV6SW9P8
X-Proofpoint-ORIG-GUID: lNdqWl5pNhoQWzns67iEMKVmVV6SW9P8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/6/21 7:12 pm, Johannes Thumshirn wrote:
> On 28/06/2021 12:39, Anand Jain wrote:
>> On 28/6/21 5:13 pm, Johannes Thumshirn wrote:
>>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.
>>>
>>
>>
>> Commit 862931c76327 (btrfs: introduce max_zone_append_size) add it.
>> The purpose of it is to limit all IO append size. So now, we shall
>> only track the max_zone_append_size in
>> device->zone_info->max_zone_append_size, which is per device.
>>
>> btrfs_check_zoned_mode() found the lowest of these per device
>> max_zone_append_size but it didn't do much about it.
> 
> Exactly. We don't do anything with it, so it's completely unneeded. Also
> as the max_zone_append_size is per device it doesn't make much sense to
> track it globally. It is basically set but never read.
> 

Oh. Ok. Looks good from this POV.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
