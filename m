Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2081B3A3A3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 05:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhFKD2Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 23:28:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56692 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhFKD2P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 23:28:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B3Eunn156382;
        Fri, 11 Jun 2021 03:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/6GeNLVuaBzqgd7drH1BoBrcNEQyfi2G/EPpja5Cqo0=;
 b=TkkuYr6cgK7tGQjouumt2oDJLBFZvv/S4zbvlU6ma9nK+zvN/Jp8p41X5bQzjWfNC+Ds
 TEYnd5LJTR/epnW1buDmw8bzLetfyKBxxbwnD+QTK2/718+D4VCVyjt1s9BGbWXoxUfq
 PSkch9aOSyyeWScCpYR8tlZGWz2ho7qmOp06nlWbUyysQATyqcC76QBJ47N5/V4uvKTm
 2sKR9C7Fhhd5Umw1pv8zEg1NIYxTteT3zsRaP4dSmQpNJaHFW+pa+Zq6OYivHvuNh8Vw
 y5tQEQ1xuv5cfw3oeDgOB1cPebI4Eh2g/KaE4fCIcHv5ehppRaMxgS9zE7UhGRJvkRTP gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3914quv0kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 03:26:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B3GTCK018586;
        Fri, 11 Jun 2021 03:26:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 38yxcx5jv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 03:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz6o8OGAzv2XJB1ZXZLBn0CC8nG5yE7v1blRGQF8mNCxkJRBkU5z0XdZW+OJgh118XLCu4WiKO6L/+XKkEaCxjtlO3LMEywVZAjVjI1Dtexj9k23j+FBiBREuP6Bi8XGXWNnTHpYp44l2809dToV0XelgCBcY1G+MxiD/2P0lcgxOnxDhaSqmPiJSV7kApj2ohmP1XFHLuLLHF/bDCVEjZBPk/LCZ6MKdMqvX1f0Ymbj+tQrmb7JgSqiQAZqKm8b9aKqU4BetlyBvK2dP0w/DVo0L7tNObSLboIy/qvZHHNRBc9e6VGJXCiQVGO6mqekgkhhoDoEW03Fog4ZEMPPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6GeNLVuaBzqgd7drH1BoBrcNEQyfi2G/EPpja5Cqo0=;
 b=KR8wtr61NPaZNrNCzVlz/fxilbGcez7CsJVsbSpCppQytOd5g8SnTkZyZ3NVoD8l+Dfns6gO49crbiY4d9gG6jW7tSErhMaks2Nm7vpJ5gnO2MkkLWzc4SA7f8tnOWmecU84QXODlwCj5yMOuilgHFRDqBJpa1GVjFSpxyocKdJvT3s2YNYl9xVCblgjjyMa6UewdseqAQiUxyAdqDueny426uVGaBhdvtzsy7/B4zuYdXs3Ts6NeB1TqVNhqQUtZbiPFnK9tkz2daO2prkozflfQ09nxwEmJRCvU/YeL43osKxx7T4WjNOT5ynXItlM5/r2K6vAQDxG6T2RwgQwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6GeNLVuaBzqgd7drH1BoBrcNEQyfi2G/EPpja5Cqo0=;
 b=wFoWHhFhoDMvXPy2t5kzsPN+zzAdcAuY0Oe7MlkgQVD9TDCKdsd/vPgRmVZWvVmFmJ3TPI9SJ1S/E3N7GmM8PbpU1/OUABnCVdnKiAdT0OlzFHZx33mc7j770lq98ResHOqwwgFiX6tA6h92QPu2JzLJIz2XIFUWbvbblhKbpOY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4207.namprd10.prod.outlook.com (2603:10b6:208:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 03:26:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 03:26:12 +0000
Subject: Re: [PATCH 1/9] btrfs: remove a dead comment for
 btrfs_decompress_bio()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <76027d09-633e-2657-ae65-72497f08848a@oracle.com>
Date:   Fri, 11 Jun 2021 11:26:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210611013114.57264-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 03:26:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c80bf22-d4c8-4c5c-a345-08d92c88a94e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4207:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42075AE46FDDB41925D27783E5349@MN2PR10MB4207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRK1p1xQXEZ95e4uTlwN4kF6gyHaHpKp9zgfBfCkd6/Xvgdd+SIi9fK0M9869c5X6Q2vi2BlP8AN91OSSkvesZafsekzQpnWdHUaDOCRWeVM1ciCu65hiFiePSJjP/wLemmWi0I9Wj0CcSrqK2SwA4VLSJ1Cjx6xMc6D+7pKxqOpVgZwH6fjiExNqJn+VO8bvb/t1E6jTY8odan6RDEzy06DEdzJOCliDBYtnDV5HzOK3nXMSg0cb1k5hfYoOK2gUMLCOLYaSHiJAcnX7cMNSexaxDtl2NmI3KZ+rY2iaJBQu4fuh5Dyriy7FLZpFCSCVyXhzYhX91pctxTsjqD5vxdRBF+3SRDICPT9cnF/d/cqIoHWodIMU6gyegQcUd2ZwrUqcOKc2Sg35dPpFUbJR1EHnL8KbFg+EycsKGnj1x4z4wpK31jpP88RlkmnOfaziaOfNFaaibaxAhB4FlKIae71G0AbBXoEZ19dirzf3NFEyur4vXDSHbcOu5nxnD16yStMCdXuIItKr5RGUtJ0pcjnxZDm3r/lzKKt9cqIOVkO8veMkqGf2U2ufSLNXuT8cZBK/yUDQd9oIZFvjr4XJgLMFZUaKRi+gFRKS6X3NcQ6CErEiX6s/96bR7F3Z5Mvk24aCX0gM/DVWqk96/FJARJRpPtjIIf+UdCzr0a2MIxpMmALOo2YHhrsjuBQ23Sf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(36756003)(86362001)(8676002)(66476007)(478600001)(5660300002)(956004)(6666004)(66556008)(66946007)(8936002)(16576012)(31696002)(16526019)(186003)(316002)(2906002)(31686004)(53546011)(6486002)(38100700002)(26005)(83380400001)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRpQlNFaWMzdXVKd2VKdTRrNnhGS3lMelpDckF4clc3MndEd2dBenlkN010?=
 =?utf-8?B?ckZKQXc5d1c0dTNjb2hKWXJka05weDFXZ1Q2RHdQemQ2cHNzRUZKQVFqQmxJ?=
 =?utf-8?B?cm9qZ0hQa0tSTWpKVU5ORlpUTk1pdTlkYW5KMGRFZ3RDTXBSMFUzeGg2VVVi?=
 =?utf-8?B?OExtY2tVNi9OMVk3UmEwWENYTEt5cnljVVNDNEliY3Bua1dJK0JHMExWZ1ly?=
 =?utf-8?B?dWF3UWYrTUdKemtvbHpsZEN5SEx4ZTJuczhkS1BMYkpXNlcycmRrWGNERXo0?=
 =?utf-8?B?UlU3MDhibjhWMjVHSlFwYU5VMDhIalJEbEdlMEQ3anloYmhQRVNZMHVzdy9u?=
 =?utf-8?B?MHVZNEt6RFlyK2t2L1hWbHZqWnFpMDkrMHB4VWltTW1UbmNwUEJVeEhSKzRC?=
 =?utf-8?B?NEoycFIrdVZuSkNkUSt6VGpWTWJrd3pGRmpXK1VadlZYNHpmNDJXbVlsQ3hn?=
 =?utf-8?B?RkpKVzlGMlR4ZkEzOVgxdHorRVhyWWxMcjlLa0pCUnRDSVYwdTVPVDhhUWFx?=
 =?utf-8?B?S3lZQXk2aUdnbERIZ2ZNb2FrWmpGaDFGVFVyZGZBbTNMUVhFZEkvQnVIT0ps?=
 =?utf-8?B?YVhOSjZGMkpJVi9PS1ptelVKY1JpM3lYWCs4NncvbDA3OXd4cVNIYXl3VElj?=
 =?utf-8?B?amdtWVZscW1TSjIyTXlZZXNHbFY0KzBGOFo5MC8yNnJxT01xQjI2d1kxb2J6?=
 =?utf-8?B?QmZUUlpBZUkycjV3OCsyYXNobkhncHVLYmtVdEs1ZVhDbzMwTWdYcUpoVzh1?=
 =?utf-8?B?b0oyVHBvT2R1VmgvWTE3Y0l6dE84U2JyNUJQVENwVFV2UDBQZzY4UzlnRXdL?=
 =?utf-8?B?VUlhSlNQMWV3L0hwNzhyUVVPc3VPaGlkVEREb002algwUnk2NUhxdXJiNGlv?=
 =?utf-8?B?UG14dTdDMi9LL2RuVVdOQVBCOGxCNyt4eDF4TUdCNXlMVmRqUWpEcXJFZURD?=
 =?utf-8?B?cndMOXRBblliQU5YL1NNNXRQODdmalhiWlllQlBEZU56Zi9jK0QvQUtZam9V?=
 =?utf-8?B?NzVCcUVaQmZlRUl3WDZTV0VDSTRSaVkyRXZzLzNuUHhKVmpCT1l4YzQ4RjVI?=
 =?utf-8?B?ZUJxOWNvMTBnKy9VdDk2ZFdxSERhT0ZoaUdJdWNBUTREOTJSdUtmTGg5V2xZ?=
 =?utf-8?B?eHh4YlZRWHFtZUU5YTNNVTNzYkkyZitPS2Z6TVNyUEUwWlIxaGVGTGNZTVlo?=
 =?utf-8?B?MmNEMUFZRGh2c2RBcStrSjlEbEI4a2tpTC9PWi8weTBGWEllMktqRDM1SXls?=
 =?utf-8?B?aWJTblgrdXhOM3lPNlU4b1F5T1QzVkNOV3lVRUxFenp4UWM1TFppQ2hTcVJ4?=
 =?utf-8?B?NTdXc2E4RzVpZ1VxOVFKcmFvVEJUV1d4REJhNDFnUkRrUDRzVE4rSDFXZmxK?=
 =?utf-8?B?VjIyM0wwZ2Y3QzAreEo4Sk1SWjBYK3lPbDVLN2YzNEpxUTFqTmQyOHo0S2VZ?=
 =?utf-8?B?UnZnaE9SVXZzdFF0YnRLeFZ6Sm1zaG91WWkxMWJqaDBVZXlYOCtiV3djdkI5?=
 =?utf-8?B?TFQrbTJxQjFyVnpMYUJVTXZuZFZablRVTDZhL2pUU2xWSXU0dGZpTzM0KzYv?=
 =?utf-8?B?NnZiTXRqb1hEMkt3Nk8rSzIrK1hLdkNjemV5dFYvVFc1RkpuMFFmOUNReWoy?=
 =?utf-8?B?YkptK2pydk54WFIxRXRDZ1ZmNWh4OTM3aFQyb1RQdGJhYWJIWE03bVZCV2g0?=
 =?utf-8?B?UEYxNHFuZ1NGZUJDL3BKamJHdklxTjBqUU5tTTFXRzRmdElYWDdka0RickZ0?=
 =?utf-8?Q?8LjH+uq2srukpe/XWXWtUaZn1S28A9jnspbgBde?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c80bf22-d4c8-4c5c-a345-08d92c88a94e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 03:26:12.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfAkxqDZXNsjWuzmhNKa9zJXtFOYJKdW5guTHH8Fxwh0eS4w6DwboZnPfP0xqTQtCqBQz9gfHOYrlQORlIhefw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4207
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110019
X-Proofpoint-ORIG-GUID: epQcTtwQK6HAdQO0g8gngz-cu8EeU8j4
X-Proofpoint-GUID: epQcTtwQK6HAdQO0g8gngz-cu8EeU8j4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110019
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/6/21 9:31 am, Qu Wenruo wrote:
> Since commit 8140dc30a432 ("btrfs: btrfs_decompress_bio() could accept
> compressed_bio instead"), btrfs_decompress_bio() accepts
> "struct compressed_bio" other than open-coded parameter list.
> 
> Thus the comments for the parameter list is no longer needed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Oh.
Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/compression.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 831e6ae92940..fc4f37adb7b7 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1208,20 +1208,6 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
>   	return ret;
>   }
>   
> -/*
> - * pages_in is an array of pages with compressed data.
> - *
> - * disk_start is the starting logical offset of this array in the file
> - *
> - * orig_bio contains the pages from the file that we want to decompress into
> - *
> - * srclen is the number of bytes in pages_in
> - *
> - * The basic idea is that we have a bio that was created by readpages.
> - * The pages in the bio are for the uncompressed data, and they may not
> - * be contiguous.  They all correspond to the range of bytes covered by
> - * the compressed extent.
> - */
>   static int btrfs_decompress_bio(struct compressed_bio *cb)
>   {
>   	struct list_head *workspace;
> 

