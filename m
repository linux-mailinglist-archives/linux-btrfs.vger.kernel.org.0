Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6F056AEA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiGGWje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiGGWjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 18:39:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E360686
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 15:39:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267KCRiC003652;
        Thu, 7 Jul 2022 22:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gIww9XxSnPXkDd66J+TB+tCSZMDIIIq1eeYvy0OmR8c=;
 b=FQr6aQ8iEd4H0+vI26N6ynS9WpquzjR+68vG9Rx0+jS28ZpcB848Djaz20Th8qBmS2b3
 OBwzsb7tCSr/4KkUJoN5cqug76jGpV6I+494mw5T//tqNJ35KTYwbFgEgtTltnYn1EHr
 /pXEdI3JIKXPScMfdyjgyMWABDyxcs1AskJpxSn4kVUju2YNIA4o7sqXOywBx7/uHxP6
 tSfHupqNq2Cu81JW0uBOQggOaRhZr2UDvVSJe7+QRgOC9L6w/JP98ByYjPxNaZMRejuz
 ko3fddR72o8tgqI5RvRXZpvz5bU+L539GGGq+hdAWaqnWvbRUSdAI50npEsaqDepOG/R mQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubye9a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 22:39:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267MLMpw025674;
        Thu, 7 Jul 2022 22:39:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud7dacs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 22:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCXnnZrwi7tODqqiT4h0Y672NtEOpIKrDJ9+Z4GyvsFJmoOuZTOQhIRsRn2ziMlYB/icoL9WV9hdeWY1pENU63sBB3G96AYiH3aH88AEGWz+1lNgHacxnR4USdn6N9HJMeKK8hccx47RAgCYOODG3Lzjj0thXlDN8IkJhMejOmgytbBwEPcZlsM3Fe+IlrypzJ/K7Em+gMGjvHG3/97VNZrGUUgzFK9pTb79/3oJU3iipVD5jrzol3mMbPrSC3RMOJVapb82l7HjI5Eo7Z9YgBIyfmOOiuXo5EYVuFgEsUpZn/UJCblK+OIW6U1AAIUjns3lmvNhCn6Uw08rgZLgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIww9XxSnPXkDd66J+TB+tCSZMDIIIq1eeYvy0OmR8c=;
 b=Ew99ujhZmejuz3swsGio9t6fkb6zyHpKQ/7CQwsJdXMVejnxXLbF+7gmFwWs13fbM4WCQYF4pfuY0xlHK9lXX8NbPZ+I5VrLhiIuJghSV/TUYfiwezrh1XgBOLHtFLZOcJzLCimES+1+chAuaLSp6wLgBxT5TQ7cmHrc3zn3jhcQBoxNWMwmmawjZGdQra9a1YymlcW0BR8+zLCd23tG9kBAIFrLoVfnu5Edi0/ddoTuFvlZOmKKUKCJqcI/tFascep3LC9FdAfkZ3DaRQ2L6q98IrgqCwF526vOxO22deWhwceWQOjhsSjAxChFuam4gqTqB1JtxTdfuCMm6b9FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIww9XxSnPXkDd66J+TB+tCSZMDIIIq1eeYvy0OmR8c=;
 b=nAqkByduRxSMuu083r7TzoUtIZKGIrBmc9jW8bj3j2jpBEgP8gi3sOJAH3FWx0P7Ce3J0kgvY5zlHgDuoKGK8DTUR3eOGK0ijF0wXgMq3Emt1Dn1TuuW3OpIBGJSTTVfDWjTmPvcvSSUEqCj44l5PDYA93bg0ennoWu7Io/Gpkk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN6PR10MB2864.namprd10.prod.outlook.com (2603:10b6:805:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 22:39:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044%7]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 22:39:18 +0000
Message-ID: <5bac8a23-0f53-c671-81bb-376557eff2ae@oracle.com>
Date:   Fri, 8 Jul 2022 06:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220704081022.27512-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220704081022.27512-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a13ae98-85d7-4692-5e82-08da606986d3
X-MS-TrafficTypeDiagnostic: SN6PR10MB2864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvrqwcBE6jJ1k7JbZVNBb8Y+fYYLTbqJ5obkYijpyAX/aEeiI+ddmJF3sbKuGi+lIuBQtfQwLj7NoN63d43xbE7FYAKBPXw+BaM3q0qREDWxYyjk4CGo6a3lS1jw8H7NGziJ7rr2rq/KXAOa+epBWDGEAoXCG6BTG6oJXNx0ug3lyASZK9TybwCQuERdmK30Umf3mmD2rOHuyA+dzgwyBQOxzqYmk7lQJmhfCAuT2J5I/uADovGleLUWybAoiTV3QDjXt1Eiu04x2MQ8SEJ89nsiZH0QBWQrVePxUwwzWeezfIvyNTa06fZx5M0XmqyQO9iXoH8ft2WMw+nE2eCSO7aCFvM51FPjkJSUy0BfC5ECtFsquXPtKTyd6Piap1AKEBzkNYGJNgPAJcEtBcNCgl8qu4uiD89Oh0ImDDiLU0+qg2U8ycNzdp/HPb7tNdwwyIIxcfY7L7jfGh30VasmKJ8C+z27hFT+ZVM55amXtBSiKi2ela+YHWCKGEGOUpBBewpWc8pb/WPMqEtjnvCoaQ6hJSmTtSu8+NbkK2j38wyN/dMSQbF1b48ErZueDAQEtJyswr9fmbVMdp25E6Zjk5GT1zR+KuzaY+ZrAQUKsSDrMygwM0tlPOoh6JUh1bxrGvXuDujdp9azUbn1hxrfNslUgp2Od5ypXLO9f1raLCkQ+FGkctQvGQRJ7dMaTaxbA1cvtiyA7LQULTrIN+1doEtgVv9pNZ7iaGk3pbV9dtHvs89yNbRzLi0xs+Qv73Jo/2p7Z6bWU8o43q9EinF9XyeH4QOarcEHYTdSUrhkhnqVUa2MlrfSZHBViLbtUYZmQ0xVl7yg7mjlI/F+WDbsYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(86362001)(5660300002)(8676002)(8936002)(66946007)(6666004)(66476007)(4326008)(31696002)(66556008)(41300700001)(316002)(2906002)(6486002)(36756003)(26005)(6506007)(2616005)(44832011)(6512007)(38100700002)(31686004)(83380400001)(186003)(53546011)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0h3dk1yMzhadGF2Mm90TUhlcFJWdk1UTFZRRzZqQkt5S3Q3SkU2U3luQUhv?=
 =?utf-8?B?M1YwSjhqNzI2TnlySmFSTDdpWFF6eFJDMGpESkFKaHA0NzM4L0IvQk44SWpU?=
 =?utf-8?B?dWdrdVJWaEQ4TUlDRG1Mc21LS3NlcjhCRVk3UFhnaVZuc2c1WUg4SDRZN1dE?=
 =?utf-8?B?Y08yTTUrbTJ2V1NVa2NiNXNTNjRYb2dNeUJxS3FJdGZFRm5zN2JBSEpoai8w?=
 =?utf-8?B?dXRlWjV0VUZlaXdDa1F0dXB1TmFrMVBmNnd5eDJmcWNyOGFnYkxXWDJkU1FV?=
 =?utf-8?B?c2JtY2xEN3MvVDhKa3RjZTBoTG0wNnJjTUVudmpvS0kyOEVoVlB4TmJqTU11?=
 =?utf-8?B?VDdXRmIzaVFnRGNMd05OS3U0a3hKbURMaFNpaDhtQUxBMWlGRjFuS3VtRTY0?=
 =?utf-8?B?bGhUTjhtSW5yd3l5YVVzTkorb0toZlBpR1dQVHFKVkE2Qit3QXd6a2RYRksy?=
 =?utf-8?B?aUlxTkRpWFhZbjU4N1puaUNjYkkyS1plVkNrN05rdnByNzYxY0lHM0FPcWRC?=
 =?utf-8?B?VDZLeHFPQ3JhbWZ3OUFsb0JuSjlvVm9UN3VQejRacnd2WE16VURVZWxWbUhm?=
 =?utf-8?B?NElzUHpjamtOUVU0ZE1Zd1FnWUhjaER2eFBPaXQrQ04yRk5PZEVlRFNOdFFi?=
 =?utf-8?B?RlB4N3llTlo0UW5tQTM1c2pXRys3YXMwOFVrd0dnczdhMGZwNG9yS0JCSmZ0?=
 =?utf-8?B?a3huaEZRV0ROZHNhSmRJcm4wODFXd3V4R3RyWkpBZkhhbXptcEpyWmU4OGlT?=
 =?utf-8?B?aWFPT0M4ZlR1MU9zaWt5MGFtYlNVSStKMWd1NGlVUVdSSzA1T1VOWG1XYjRn?=
 =?utf-8?B?dCtrTmk2eTNaa1pLMkdOK1E0RTZxRFg1aXFRRTJ5M2drRXRxanNRWjVpNHls?=
 =?utf-8?B?ZnJnT0U3UFRLOTZtMmd2MzJSU0dYb2YvVmtCVGNHUzZ2dmo4NEdUN3BQcE5P?=
 =?utf-8?B?cDVpZFhwVHEzemp3V1FoZHJldFZhQmZFUGFjdk9aVTNrZUZYWHhCZ0t6a2gz?=
 =?utf-8?B?YXNiNU1peFpIazRTZ2hmaFJWS2pUbDFOM1gvS1VscjZoaGRlcUhrbVVxYjg0?=
 =?utf-8?B?TUpYQkVRSFJJcVRBMFFtWS9BWGRkblhCOUYwaXRzN0ZlNlVZUGNRNHVhRDM5?=
 =?utf-8?B?NzZoaUxMNm5vVUF5c253OHNpdHAvd0J0QkhFb1VkcGRBTTdBUXdWRFVJR0VR?=
 =?utf-8?B?b1dMWGtuVlBhYVpXZHJ3emJ6akh6UTBESFNycEw0R2RNYm1hTkU4RThFQVJp?=
 =?utf-8?B?Sm92UkNNMVNqenFxRmZqOFBjNk1zZDRzczk3QVcrWk1kWFhiTkpOR0ErZjJ4?=
 =?utf-8?B?MGlva1dzR2loVFZuT1g4Zk9zT3NVU3dBc2o1eXVzclR4bHYyTUVhalk2SUJz?=
 =?utf-8?B?OCs0NE92bllLd1F3QnhPY3NWWjlueFlXVWI5cGhQcGVya0tqMnZjMG5TaStx?=
 =?utf-8?B?RWNKQWsrU0lCNlUwNTBIWlo3WFZCNURIbHZnZGJzdkZPbEV3Rys3TnJSNU1t?=
 =?utf-8?B?WDVudFRzalQwZ1pGQ0tEY0hsejA4YUtxWHNQK3FzeEJ2WnN0YUl4OHY2NEU1?=
 =?utf-8?B?Zy9oY3Y4OWxXdVdIeklHWG4vRnlraXlWVDZaZ3BIMUZkVzZETWw5a0RLSE5t?=
 =?utf-8?B?Mmd5VjZrRnBiZjgxbjh0bWZ2UTIzaTFYdkRZY0ZHd3IvK1QzVU0zMXJvcHRI?=
 =?utf-8?B?eUt6MEhrQUROZUlsRThPVnVRRnhETHNRWGU1ODVjS2k5eEZhS3hlWnEzcWFy?=
 =?utf-8?B?RDhNSkczcjdpR0pCRzlpMjlacTNuMXNaRXhxR1R2a0lGL3VqMXk0ZU9uQjRY?=
 =?utf-8?B?T0t2aVRJcXlwb280VXA4NGtYdmdISTJUNnF5THpvWk1NWHJGQkkzVE56MmU4?=
 =?utf-8?B?QVFjdUlGVURwMGRyNHpYUllpSHdhS251UDYzaU1CNHluRlVlaDBtNHV4cEhN?=
 =?utf-8?B?WjdzZTdOZnY4MXZQbDd4UE9TL0xJZDV4M0JWVi9yU3Z6LzB1c0YyWitzSUZ4?=
 =?utf-8?B?bkQ1ai9lWGFxWkdmLzlBdkNIK2VDZWUrUzkzMFl1TzZ3cWhVMlJTekFvTUZY?=
 =?utf-8?B?aDc5T3lpbDRLL2tJOUdnbEZjUTVtT1JJVU0xTmVrZVNmZVV2QUxzSVpTQ3Iv?=
 =?utf-8?Q?lENmFcS4PxOFnIeckoUWLfovp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a13ae98-85d7-4692-5e82-08da606986d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 22:39:17.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0MN1+IDqPw++oXCD7mKeUlRr4tnYESkwGYR3wBi50fOm/CDIs5/W4XUofwcef5J6QypcWQtG/N1083Z/m55Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2864
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_17:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070088
X-Proofpoint-GUID: Pgg6vVuuVMvFt8yxh9l0fSGQAtZgcdqo
X-Proofpoint-ORIG-GUID: Pgg6vVuuVMvFt8yxh9l0fSGQAtZgcdqo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/07/2022 16:10, Christoph Hellwig wrote:
> Don't leak the bioc on normal completion or when finding a parity
> raid extent.
> 
> Fixes: 7db1c5d14dcd ("btrfs: zoned: support dev-replace in zoned filesystems")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/zoned.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7a0f8fa448006..46e6c70217e08 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1735,12 +1735,14 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
>   	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
>   			       &mapped_length, &bioc);
>   	if (ret || !bioc || mapped_length < PAGE_SIZE) {
> -		btrfs_put_bioc(bioc);
> -		return -EIO;
> +		ret = -EIO;
> +		goto out_put_bioc;
>   	}
>   
> -	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> -		return -EINVAL;
> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		ret = -EINVAL;
> +		goto out_put_bioc;
> +	}
>   
>   	nofs_flag = memalloc_nofs_save();
>   	nmirrors = (int)bioc->num_stripes;
> @@ -1760,6 +1762,8 @@ static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
>   	}
>   	memalloc_nofs_restore(nofs_flag);
>   
> +out_put_bioc:
> +	btrfs_put_bioc(bioc);
>   	return ret;
>   }
>   

