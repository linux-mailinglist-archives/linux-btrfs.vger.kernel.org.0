Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2425474D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiFKNhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 09:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiFKNhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 09:37:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E613EAA
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 06:37:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B2rQjR017081;
        Sat, 11 Jun 2022 13:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OALRCs2Dk58la7/xJcZZUg2G9wB3v2xQ6ToIYCkqGcM=;
 b=tBj6aFh5I4yjqOy9dDlieDie2ujO/i0327G9EKN5XkBHyFAWIm8iB9veueBVSZs44Vgs
 vjFeCQE3hGqnwTDMpebCYbJ5rxHUPTAfVN0kp4YHxm/YF6nKVQRn0Fnoqn7PM6bkcOI6
 5izgaX3xRz0kY1kSb+VzggBq6OKpwsMyqeHPeTWhm4aSg/OaYRr3M96y1AjkhQgB9h9w
 c3kw6Z0N4DSwozHml0CL+nQosd10++gC7AYsasC3/fCL1QqGAPSVHl05oUojsD3C728E
 TyiY3nf09zaphNhBGU7oBt/j5TcxTmD/c+MlVIDuJBn6x3nCoI5pn9E4Bvbvq9XcHdsX dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns0fpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 13:36:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25BDavMh021821;
        Sat, 11 Jun 2022 13:36:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg0u4x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 13:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtQ9Ba3AvMesuVpg7KdeS7zQSRsjk+NU0nukRsjewYgYS3czXk/SB01PcAc/jxBK5wvDMcsSf5LTaWh3hJEnO4SGWyxKAEzvllxO0yZA97ua4DX6cWKidlNEmQYAvdGvhCmdx57q0oRac39WMKGlIyvzNxELhg342f9b+lQpLuTlVdSDeQuMtjjYYHqi5cZVIJwJRNUWzCalq/b6JYNmhk6AGrFTo6bhk2cC5ESY9bapZx8wLFgjyPsI5ygj2YDjy9i+wGHEL/wrkybHwIVShkkslF+xnTj8GtV9m8zVhRmiHmDaQjNvki0M0JSCl1rLIEtJwrSLZG8qeQ+G9ivphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OALRCs2Dk58la7/xJcZZUg2G9wB3v2xQ6ToIYCkqGcM=;
 b=l01Q7jVvSyjPxV55gSvprit+CYXTeJOMZFaa32cjmlaiPYsEM0+jdsK9+N6BSvyThGhyp1jHM5TY5v3L2ytPntv9qMVHoPZFYXZiCRJM+5jkGmu5VQG1Iflj9m9AUSdBqSzd4uSKYO9Fq3r6SAJVgAwwuje+DjQ+Ho2CYe0JpdVRQvTsudekeyC2an56WOlX8z5XyuN66S3d2jQV+7YfTKws2joYijiPLIht6vz1pkRkGdjypck6crBQTa2gn8WuUvBmk9HoPjGBr5Oh6JkFecj4guK3XpB7mqGKC8WlE70Qhbsw/GtNXjYE6aW4EA6iSljbTFaCu++oQjDXdh0ZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OALRCs2Dk58la7/xJcZZUg2G9wB3v2xQ6ToIYCkqGcM=;
 b=aJo/wG3yNUMIwr3x9aXMaf/v8T0FJroLRhAtxCgt6rTW7hgi7+lHwIUInkgJMi2h9lxQWRysZi5Nl2ewmeFEFqGZbC9w4Xb6WxdXVrsIuMwYVW2PG5PJyll9MhuKfzvLcdgcDqf1WwGNGkxalZF5IiBm+KzlETrRBECGW9r5T4s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 13:36:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Sat, 11 Jun 2022
 13:36:41 +0000
Message-ID: <fe41d0bf-d5d0-9910-3286-a9f0e057611e@oracle.com>
Date:   Sat, 11 Jun 2022 19:06:30 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: add tracepoints for ordered extents
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4ff1729-d012-4f45-52f2-08da4baf6aa8
X-MS-TrafficTypeDiagnostic: SN6PR10MB2688:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB268865C2BF77B58E2B110E8EE5A99@SN6PR10MB2688.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yaNeBJl8+I6D8dLXQSiWI243YvF2zQzCnbxofDqol8GQJHKSDf9sYowr2PPO6F5EuVjecY8JyaOZ5qTx8CAW8yY1D96n18Q7DDsCID0CsRruFXSkA9hs6bP1wAuY5VbPnFUoKhi/6G5O0bXV5bl+1OdmxIPYAuA7OwIsO8v/ucj3RZjp3M58w8FbMlCIUQqxxk7AYq4mboyIxVxK4ROXPOwdbYcFeEa9M7iNHt9ADb7B+LMyRPhrplzdxWYw4o6co5XXgX/tQh+YV6+bLsLDuz0O1FOY0s68bODrrZRT1mABnHYuD8W3m+SfQDvz1KiuZ4K71o9Rpj5gJY5SHgxEf7gCn3L7GVC/TiG1aCmlcBf4mwSwEe6/hkuibr1vzVyj/0MRfa4lH9beu3unIbNCv4xq5evddfqhqBOgdxgSKftpIROe/gp5kc1vBbu5OQTgqFPI21g9I3qkK0b8DoYk+mOfWmtI36YYzwUbH2HggPfstKepvMCu8DpaZ4gzFfcCq8GkhL0KTUqMEf9rHp+9kMFXpq3q/2g1jLW56G27G5hYsQqdyPQqzl+FaozBU+YGyhg326TXNPkhnaBDqfZWGb2mxMQruNZaRc33YpWXdNDNvlE7U6G3bK2iXbO3mfz9zkbs+Pz6RU2wy53UFd0i6hOJPTmZi3OlUWnFhhCRms9dP6els+yyLay+7DXVS3hrd0uuQdfV0sXP03Rp+JHmd6hjQ3Nr86trnF2S0mrVjVO5CJH5TKazZ2kHDXxAR/O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(38100700002)(4326008)(66476007)(66946007)(66556008)(53546011)(6666004)(2616005)(6512007)(31696002)(86362001)(44832011)(8936002)(2906002)(5660300002)(508600001)(110136005)(6486002)(186003)(83380400001)(316002)(6506007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NNak5aSUFMblRNQW5tbmxxeDB6UUZuMGZlRE0yNFo4NUtaZ2NBZnpoNkRH?=
 =?utf-8?B?MWRsdlRPNGo2Z2pVMXRmWkNjbUhpUkNkWlhQVU5LVU5SNExRU2hVMlE2YVZY?=
 =?utf-8?B?OG41YXcvV0JqU2FHZGRjS2Nud0xBcmh3ZWUrNmlPVURmR2doTThlODNkK2Ev?=
 =?utf-8?B?d2E4K3QzVkdSeDhCazJlekY1Tm5VbmovSDZJZWtMVFU1UWVsQmtscGZjWVNV?=
 =?utf-8?B?bXJDWDNFV2JweXQvWkJHWmZpNFRjZGJqdDVUL2w0clBhY2Zxb1lRU05ab3VN?=
 =?utf-8?B?VkhpUm05RDhyVmJBY1lKcDFRaGkzbm80c1hRRUp3UmpIcGwzL1VIWkQ0L0xB?=
 =?utf-8?B?Sk03MkhGQWx0THk5MmNwMExGT3lIOS9ubFlDdFRiMUJKcWxPM29EMkllVWdK?=
 =?utf-8?B?ZnFUY0xPdnZiUHljajVKdVJtWDVYWWZ0Yjl1aVo4TzhHeFl4RUoxcFNWeFdR?=
 =?utf-8?B?TnR2c3BNeUhwTjRsTUYxOWdxT2NIb3RBdGI2dEhLbVcwWXFlbkpoc0tMUTJs?=
 =?utf-8?B?SHBTSVduQ3F3dmc3SEhJMmdRME5jTkhHakdvU1lFY3lHeStDUGFEdEZvcEFv?=
 =?utf-8?B?MVh1OExleUs2TEEwcEtDU1VnVVh3MGZ1bWZrL2xZN1FxVmZES3pXcFBnVzhB?=
 =?utf-8?B?eU82ZFFpVVJIK2xsdE1pZWtiWVFJd0RWL1NVVnNYMktVR1IxaTBuZSt3eG1t?=
 =?utf-8?B?Rytvem5VTUt3d3ptOFpsTG5DOUgzeGtpQXJIY0dpQnRHSEp3Mm9Qa0w3RFNG?=
 =?utf-8?B?THNKS2FqeFdOby9BcmJnT21FWWpnQ2QvdkZrYmZaTEV2RHFDNUFWQkg3aHRh?=
 =?utf-8?B?M2YvSDBQbTFoY2tZeVRScDRCc0hYQ0xvSlgza3BVQ21ZVWc2Qjc5T3NOTUFC?=
 =?utf-8?B?ZmpFbXFIMlFkZDlMN1Ezemp5T25ha21oMzhiL0ZvT2cvRThVKzBkQTdhY1F1?=
 =?utf-8?B?MXZiUm03ZGVQS1UzQVFvWW14ck0veUxwcjVPbjFlMjNkQXV0WVFsYTQrTUN6?=
 =?utf-8?B?WnVPc3BOUG5QajVNSGhVZ3FDOXkzcWl5VlAyTDJmK0FZdFdJckRocWJIVHEx?=
 =?utf-8?B?emFwZzM2K29pRGRVVnBEcEpPUjZ5Q1lRRFk1Q2hTT3hNN1BBaWVHRGVqY3pG?=
 =?utf-8?B?YW9vaUNST1pmZDgxc0thODA0OTZxYUd0S001SmRXcThIcWhSUlRKQUVKMmti?=
 =?utf-8?B?Y1MyaTlOMVllY3BBbnR1SEtvVTVydVp5aC8ybWwvcE1KMjYzYjJaSHJyU3Ev?=
 =?utf-8?B?MlIwRitINzZmTmJFbjlXYUI5VUlCYmcyaThjbTdoY3E1Qk8rbElveUprVkFS?=
 =?utf-8?B?aWJUQ1d3cWFZSVlvRVB2Zk4zZDRLL2pzWXVJMFY5RzFnN09COGw0OFhqOXI1?=
 =?utf-8?B?UE9oam9GRytVNkt3MisyMDhSYU9QRGF1eEZEdmF1SXYyU0hyTU0xVDRUWWZJ?=
 =?utf-8?B?Z1NGdnJWRHNBUk1DVzJnL1VITEhiS3I5MHRUQ295KzlBS1hvTklYaU1QaG5h?=
 =?utf-8?B?Vm51SFpwRUVhaDB6ME1Da3ZGc0JtYXR6Z3MydGc0enhDbXd5SnpmS2tlMUJi?=
 =?utf-8?B?SGlUUW5MaWJWQUVTSnRSczFzL1lyazFxL1Nac1dtalVHZHhIN2h1RUh6OGEw?=
 =?utf-8?B?S2lXSlNPNVZTdTBpbkEzM0dHbmk0eVM5bnRXRHdpMmpHZTJDdlpDalJKZ05z?=
 =?utf-8?B?ZmVMVVE3NWpKQkppSXV0NkNTcTN1ZDU1RWNyRHNKbDVMQUxOUFNnMVRJZ1FK?=
 =?utf-8?B?QzhQMmJrQ2FyeG82a281NldwT1MrVVN3R2tQOWF1d25FZ01rZmhjMEZvS3hF?=
 =?utf-8?B?YVZna3d1WWd4V3Vxajk0blBDWE9FU1BaTTc2UGFuNjFOWFdTMjkrNkFMTFpS?=
 =?utf-8?B?aXNldHVPa2hnSDRHd1JjM2tXSXYvRmV2eWdzUHVvTTdUcmJxODVPeDFqSUdy?=
 =?utf-8?B?R01XOENiVHNCd0c5OUVHVmszNHhTZnphd1NsNUpKMjc3ZEF2QTlhUnExUG5K?=
 =?utf-8?B?OWFRWkZjNk1jODgrOVhHQVRHVU1JbC8rdjZqUGNyN3gzSVhtV0ZycVNpYW84?=
 =?utf-8?B?MUluLzJhRU5wWGt3d2sreHdqU3N6VUVMTTB0aW0rTTAyVnhoOUNEdDJRTndh?=
 =?utf-8?B?cTZvcEdaRm5XNEJ6cUh6Z1FtVnRqVjVXbTZkNTl4NzUrbVBxOVVGYnltSlZw?=
 =?utf-8?B?SXd6Y0pxNzA1Z2NsMEpyWXVLd2pzUnZlY3JZd3dCQm4yemRrL0Y2eFZwUTZT?=
 =?utf-8?B?azBEd20zem9DTTBsdVhkL3QzOEw5ZEYxajdiMGg5ejFBcmsyOXRSWGNZVlJE?=
 =?utf-8?B?d3IyQnN6U09Tbm5IbW50Z01jMlVMdmRVMHp0L3NvellxdkpURndFcjBsZHNI?=
 =?utf-8?Q?lBapqKV1tAFuCxYcLTZcfxNrgrysO4EOpYo6C8ngkhzVV?=
X-MS-Exchange-AntiSpam-MessageData-1: NE2jD8iEPoP4FkAYsWtAQ25BdvLIMJvMsFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ff1729-d012-4f45-52f2-08da4baf6aa8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 13:36:41.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1isPag5B+Kn0XQoBGho2VabnuT77GOiaCibpGtMi+Op0pmh+6YhXzOG5bLuAEkruQolAryHT4sqlyV13WefEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_05:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206110057
X-Proofpoint-GUID: kYBWjA8lKIN19xybdZNVwbLL7PXdrdh1
X-Proofpoint-ORIG-GUID: kYBWjA8lKIN19xybdZNVwbLL7PXdrdh1
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/22 21:58, Johannes Thumshirn wrote:
> When debugging a reference counting issue with ordered extents, I've found
> we're lacking a lot of tracepoint coverage in the ordered-extent code.
> 
> Close these gaps by adding tracepoints after every refcount_inc() in the
> ordered-extent code.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   fs/btrfs/ordered-data.c      | 19 +++++++++--
>   include/trace/events/btrfs.h | 64 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index dc88d2b3721f..41b3bc44c92b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -401,6 +401,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>   			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
>   			cond_wake_up(&entry->wait);
>   			refcount_inc(&entry->refs);
> +			trace_btrfs_ordered_extent_mark_finished(inode, entry);
>   			spin_unlock_irqrestore(&tree->lock, flags);
>   			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
>   			btrfs_queue_work(wq, &entry->work);
> @@ -473,6 +474,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>   	if (finished && cached && entry) {
>   		*cached = entry;
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
>   	}
>   	spin_unlock_irqrestore(&tree->lock, flags);
>   	return finished;
> @@ -807,8 +809,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
>   	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
>   	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
>   		entry = NULL;
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup(inode, entry);
> +	}
>   out:
>   	spin_unlock_irqrestore(&tree->lock, flags);
>   	return entry;
> @@ -848,8 +852,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>   			break;
>   	}
>   out:
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_range(inode, entry);
> +	}
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
>   }
> @@ -878,6 +884,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
>   		ASSERT(list_empty(&ordered->log_list));
>   		list_add_tail(&ordered->log_list, list);
>   		refcount_inc(&ordered->refs);
> +		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
>   	}
>   	spin_unlock_irq(&tree->lock);
>   }
> @@ -901,6 +908,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
>   
>   	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
>   	refcount_inc(&entry->refs);
> +	trace_btrfs_ordered_extent_lookup_first(inode, entry);
>   out:
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
> @@ -975,8 +983,11 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
>   	/* No ordered extent in the range */
>   	entry = NULL;
>   out:
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
> +	}
> +
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
>   }
> @@ -1055,6 +1066,8 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	int ret = 0;
>   
> +	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
> +
>   	spin_lock_irq(&tree->lock);
>   	/* Remove from tree once */
>   	node = &ordered->rb_node;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 29fa8ea2cc0f..73df80d462dc 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -598,6 +598,70 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_put,
>   	TP_ARGS(inode, ordered)
>   );
>   
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_range,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first_range,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_for_logging,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_split,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_dec_test_pending,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_mark_finished,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
>   DECLARE_EVENT_CLASS(btrfs__writepage,
>   
>   	TP_PROTO(const struct page *page, const struct inode *inode,

