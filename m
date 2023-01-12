Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C32666B18
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 07:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjALGJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 01:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjALGJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 01:09:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B63AB06
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 22:09:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C410pc004958;
        Thu, 12 Jan 2023 06:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UrC2S7HYfj8F2MJ+RqyYF2/vrNKd/GKfbBBJ9xZD58M=;
 b=fieYqMgoz3d9VPmb4JSFbP1hA+eh1LpjLMoplk6c6P+yxHTQIxqoVZy4+Y7qxNpHBbr4
 12AjTvnMhGTSt2dumog9Nvd/Wuvs/HDnP/KGLm3zXwn9gOf1qAuks+5jxQg26SHoW/pJ
 V5sl97gB47r0KWoKXCkxb23W8K7JCi6LnfhEc0RKsNBvyspCyEKhz2+z/fJ1C4b9VTLX
 uAt93zAMM0OO96ixHu+CitJHUd/i3WJt9Go9Vs2gLZZY/cJi+dLJO1XjMEBDRSAtDFM4
 LZUvIbr8bPX+IY1zaKv/70Tf1jJXTzUKcTlCQpFl/aL6kqYmtHLQJT25z2ki3bMaKW66 Nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nhq81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 06:09:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C4UC1r034170;
        Thu, 12 Jan 2023 06:09:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4g068s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 06:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1ebUpX/3FMHLC3Si8aN+vBF2nQYevchWfawKLJMC3BNRn5esEOaRVL1g3D7ctzbhHtVelg8nHKu6R6Bss0vf3iihkYJH89UmjlnwRqhOtjoiDgXTg5Vl8D48cVX7MyovKiX9zVlezFZMwJUsNwaHJ75JHquAXklAcMWNQ4DcsS3lX0w1oyJGfyVTfeDI2p6CCwsa2vOuNkCFcU5RU2wB/1fe5wXVT0Pv9fd5oMHb/9oTXKFqjeRZrQHt3pBoX57Fs4wOYKir51mpacYzbP7mftWtDboSErXRR8RRxfpzjrGkA0+A351nFvv8uuhx+IdxNUOiBHJ7zwszzQB2EMq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrC2S7HYfj8F2MJ+RqyYF2/vrNKd/GKfbBBJ9xZD58M=;
 b=VPuTnGCI1htVR/WmDIiXDkUPAJ4ibMokd5ak5dDLhYJWaKYur257GA3jWUv3E2BvLYtdcPMGiXidzO8ALD/w/jMooKQTYB63jXOLuMJMsQAUvC5RzYSNEoxIastGok7EWrnuq5kdFUzxMAiN3/hrKV1epFBTo/ipBxjWbsatBgri6uqWq1i1Y2koFZBVmgN9/o7QCXHVwNd9grucNSne63DcIdr1w8HgArnykA9Puj0YIy9w9zQxRFQgBJEUuPO9/m8JOJsmr8UsZMZVdK4ejr+89EJ9PY5VHehGiTbf6dKv9/hD9GxphaA2cYM+fzFreqAWc28vbfmbY7J5nGWbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrC2S7HYfj8F2MJ+RqyYF2/vrNKd/GKfbBBJ9xZD58M=;
 b=D/CoFJaK+ONPW39zq9C6SJGltli8J1Dab63C5N/RlpGqBwGJ9Qo4PRruQzcs5YdFTCOJd5Q4RuPlzjblxKC4ClHkamGeyTR/bLbAve3r+ivkFB/4ub7rMDoVU1Slq82yt9Xkyn4L4TepZ5izTVQwtmQ6p7m1a+vcB/Ht5nMKiVQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6014.namprd10.prod.outlook.com (2603:10b6:8:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 06:09:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Thu, 12 Jan 2023
 06:09:37 +0000
Message-ID: <09594c06-c1e5-4d11-7b6b-48abd51dc225@oracle.com>
Date:   Thu, 12 Jan 2023 14:08:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs: keep sysfs features in tandem with runtime
 features change
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <ef0efdacd9bd53a55a02c6419b9ff0d51edf5408.1673412612.git.anand.jain@oracle.com>
 <98540b70-c7b8-5340-7a4d-ee6f43f6babf@gmx.com>
 <067d3b1c-8510-81ee-4c90-02c6cbd74f7c@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <067d3b1c-8510-81ee-4c90-02c6cbd74f7c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: acb755a0-6372-4981-88c7-08daf4639528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tf0w/9QUBQdGVjUM7I6u/KMlLnnqBClu5TYhCjHcI0jSuoEDYGH6whUkJp6epI8uKUIyCO79OsdXk83lKAjQWqaehQe/fVlWTqqoYZq5DH0R8zBBv3Fyn2uaS5oBiTbFda7MBQElC25ySd0LN2lKGyANNdoSKAFMY1sYwGL18oURNsNKAr4Xiv5ZELfFqynLtZSNWy7ac/vEFrzXSVGriOMyOEiSwr67SDcrbT+4jfIJGxDR5FdMsCQdfWs6j8CvF/j1Tffv+bmfKFtNkNLyYCh9F6H3Gi1qc92Lw5DIEX6cxm6yq6XOGpmdxikydX5qJQlc4APlSTp3ChAHwMQW3ziZ1cFhZ+JCzhLRqRH47qJR63wFnN+FE6neQHwpiwBPuQI0vNzLCap+65YMzfShxFd/4mNswki3WZDw1mZw3hWA4gHPr9caDWrx8bD5KWTy1wuDRo+iitswS+fORSgzHLrNpkGIx1KY7lGE3R/4dBRgQSmLjHoLtE8QgkKMkLEeguGzv7n9KaRG2i7jBCFzZCGNtQYpevf4ezPHTzwyhUaPklPOzNhscPeSMjkV8Y7i6nJ1H31V7+AUE7bKT24BuKwNJxRSCG2/3h5I5uTSY5F92oNl2y9NsrYfwtpO+UnHwLnW2toO06AAv2B6+CcNcbFYv1WYQTOUzwXR3UUSKE2hUStl0unpRWpgj/gvHeWaIedM+AIHvVAuVCgSJo/ESLmfNat5eGnxEmK4olnu/Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(5660300002)(6486002)(38100700002)(31686004)(8936002)(26005)(31696002)(6666004)(2616005)(44832011)(478600001)(66946007)(41300700001)(316002)(6512007)(4326008)(2906002)(86362001)(83380400001)(6506007)(186003)(53546011)(66556008)(66476007)(8676002)(6916009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJmNnRKTmhCd0dOUitSRnpqMW9IWTNSbmxjcGJjMHg2Lzk5R3lWTC8vZ1FV?=
 =?utf-8?B?VjFRUndjaU5jdzFROXlyUERsMXdodUdDQ1FZTFpIdjE2dHRpUDBaR25teHVp?=
 =?utf-8?B?RWtjQjhRUkVEZ2VmdGpSU1JnbzdHM0QwL1I5Z1EzVE9NbVgxWXZ5dmVUNWNV?=
 =?utf-8?B?a2NJQjl0WWpDUE8rdG16RlU5bERiNG1TSVdzcTM5aGQ2NURoZmFnOWdsSElI?=
 =?utf-8?B?eUpwbkg5cmdDTmFrM2tlWTFEYlB5eFlTcHpBR2Z1RFM2UHlKbnZFOSt6clI5?=
 =?utf-8?B?WUFXTWpWK0xMV3lsbFozdWt0dFBDTVZVaER3Q2VOL1hkYm15Uk9Gd3ZaSHJB?=
 =?utf-8?B?WkI0NGt1TUE5OE5aZ2NuS21Qa2QwYTBrcTVScEtYOExyRm9aM1hvQXo0V1pX?=
 =?utf-8?B?M2s3WVZzSDQ4bittUWNML1JnSkdsQnVmQTQ2NkRmcFVBb01aY1kxQmpLS1BE?=
 =?utf-8?B?TGNuTm9zSVk4NDZISkFOM1FueTVIMTdBdzE0cEtFUHJBanhKQzNqZ0FFVXhK?=
 =?utf-8?B?Ym9jUG1BMmZkNGZBWnljNURXSHdrd0Vyd01ZMWhmcFM3WFJsY25RTnJrV1k2?=
 =?utf-8?B?Y2NzWllZZU1qY1VCUmZPLzFwT0FKUytiSUN2aXRrZVd3cXNqbDRkcjBOZWd0?=
 =?utf-8?B?RGU4a0pIeDJHbUpQdEdFZVZvaC8rM1lHcFlPY3hickdYdFZEWHNZOFc1U1k2?=
 =?utf-8?B?WTNKdm9FdFVEVlBrK1BFakMyNUk0b3IzelBzN2dQOWJsVTdFVFZEUzZUY01E?=
 =?utf-8?B?ZU5kcGY3azAvWlZEQzJ4c2NDdGNIY2w3VHpGbmtrKzNUZDF0WWw2V1ljcUtz?=
 =?utf-8?B?QW9IWDlxU1RTMnMyMjViVmFvWS8xd0ErSkkveG90NGVEMnNJMGxjSkkxR1dh?=
 =?utf-8?B?allBaXNPVjhYNWpaM3U1WUNkbVROV0FUODBQNXpyUDNUREo4Nk53cWFCaHNu?=
 =?utf-8?B?bXBheDhpRDB3b21ZQzVGbVM2VytQVzByTFJQaFRHS3lpQlhKZTdLSXJBZjdz?=
 =?utf-8?B?bU9Ib3ZQQ3VHU0wxNXVjRFk2V0I2c1VJY28wdGJXN1hZcUFlTmJlWU9rRFlK?=
 =?utf-8?B?Ylg4bjB5aDJvczBJSHlEYWNVbnliZzNYNkpTUXlJWlI5OTF1a3pRUWxEa2po?=
 =?utf-8?B?Rjd0V1p4YmNobE5RRWwwS1JZRDUvbGVvOTRBYk5tK2FSSkVoT1EwbmorRkFw?=
 =?utf-8?B?YytKWXVFdlhTOFplakJ4VDZyWURkTEpoVTZMZFFLd0tNVEgxZGZDbnM1SCtq?=
 =?utf-8?B?Ry8vZ3RXbmxyMFZMTnJlRjRFTDR1MkJjL2JDTDZEOXlQeEY3RDJxdmNsWlNs?=
 =?utf-8?B?YjlzdHkva20zcWM2Wkpsa1hrUnBLZzdVOUQvTnU0ZUpWem1xa29OVlJUbWtI?=
 =?utf-8?B?OGZiYk1LMTB6eXRCOG1LRys3cTByaitUMUlJOStHeTFhUkZZR3BUWVk1MUl1?=
 =?utf-8?B?VnlCaWI5VlFXTW5oS0sveWZ6S0toR0Iwa3Izd2ZHclVJMFN2eE9zK0E4dnFB?=
 =?utf-8?B?T21JZitabnY3dVFnWEVVQmZhcnNqVEtyV040eXMrYVNKeXVtMnNDeW5RWElt?=
 =?utf-8?B?RDBjcjVodDNNTlNXcHAweG9oZVlDTldhVjE3N3BGazhlSzduSDVKY0RFM3VX?=
 =?utf-8?B?TzZrRklYeWtVbU4wNGlNdlRjUzdwc1I5YWk2MWYvSFZ2Q3dOK3pyNUY5MkVJ?=
 =?utf-8?B?My9iNEw0TXhvVmVzUEdlSnp0S1lqK2FxSVVHSTdONDB5QkpEZWxnL25TbFhX?=
 =?utf-8?B?Y2t6aEtpS09pQlM3TzNySWRrb0tvNGJ5Y3djUnhLcmNxUlpFYTJydVBDU3Ri?=
 =?utf-8?B?bDNqMEdFbERhSDFwWHVUSW4zOTZST3VXR1JhRzRmZE1lRDlvRDNyQXVqNklY?=
 =?utf-8?B?TjA3NnFpclNSWTFXbUN0cExMVzJMRTgzV3grUFJLem5MSTBLNExyeEpkMFNa?=
 =?utf-8?B?Y25aN2pMZFJNWlV2cWc0aDZNVGJPZkp0WW0vaytXYkpWcDhrdDRRSUgrc25k?=
 =?utf-8?B?bzZDdVRiRHd0UVBDZURhM2k2bkEvQVBFeUdia2tlc2ZZbTZPS09EQjQ3dlpz?=
 =?utf-8?B?T2dTb3NuSTBNdE04bzQzVlVZWXZkQjA3cDlmUW8rZVJLbHhKMXR2enFoNTZk?=
 =?utf-8?B?b1Erc29WeDlNVEJZT21BRFNlcU9qN2kvZUFkZkY2Q292dzdXVzhVV0FlNk4y?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OScKFgmWwgowQyk0w1oRaPT0YV63h3Kkn7zD1savqb9mO+Qv9b4ojP5Syg8F9b4SbNU3Qm87ePhwaupNsn/bb+iJfIeieUGH8BTANTzp/9b++QoKhUd5YEimtjsa/Hn3fGfYFwH3GJfOIL/lWqvjZx4CaSDgb9yjj1El8ZySTlGEJOGh8JIvgPLwgt1E7PrXaHFCcvan64MCf/vgtjAQCRwsuqJ0/QvnSw1eYbRgli6au8F699sguIgFgyXciNbJhXR63OHRrxcpw+u8TWYq963cUnZRg2dvCu6qFz1wBIJHPWLGrtthfYSjGKU8aS82vtaNrCKvqPHhSSWP8MwpeuWWS9WIDkgHo+5YS1380LsiF1Ovjb2dsTolpCWexWgDWtDrYH1OGpgWPeqd4VEt2wQvCtJkcf5wUz/rWKknUq4F2Yi88jark49hD49EGCntVcWgTOCuUQJC8CvdsNENLb0M4oGZkMZfuq0nEE9NN576e2JhngGHrXjXVotKFL4GFK8ZMk/3VmyHO3QltE7yG6DLhmR6OSFzuotqSLAhBFJhJ8iuLX7Xhm4VHDudnU2A0jywh0WzmBSlItDwSR4t+oP0pAoklsZFCeO0JXtcNZ6cQfy61IZhR5Ql7Wks1fu18LBEHA3aXZeR5tcvBWFyw4f6L11yZnWTgWocs2B6YTksQgHKdDVb0elPoC4zvD/nsp7peTqr6AKhdM/O70ze1dod2gOiAUc4jtnaI4aj1uJorr1LiVWUMFBzb1k/bizBANzJHilYRoHhwLsx5AKSo+2hcWUBEyoEGU255u3LxGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb755a0-6372-4981-88c7-08daf4639528
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 06:09:37.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6pJIq/SjbIVH9knVhBxorU2pSATz2DdKOSm/JEpOFMdTEItTFsk45xHuksVe/xkLRaeO+FI9n802we3tLB9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_03,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120041
X-Proofpoint-GUID: X2NWvOBbYBzFVzGwb5e0_eOB50GgjEtt
X-Proofpoint-ORIG-GUID: X2NWvOBbYBzFVzGwb5e0_eOB50GgjEtt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/01/2023 10:35, Qu Wenruo wrote:
> 
> 
> On 2023/1/11 15:05, Qu Wenruo wrote:
>>
>>
>> On 2023/1/11 13:40, Anand Jain wrote:
>>> When we change runtime features, the sysfs under
>>>     /sys/fs/btrfs/<uuid>/features
>>> render stale.
>>>
>>> For example: (before)
>>>
>>>   $ btrfs filesystem df /btrfs
>>>   Data, single: total=8.00MiB, used=0.00B
>>>   System, DUP: total=8.00MiB, used=16.00KiB
>>>   Metadata, DUP: total=51.19MiB, used=128.00KiB
>>>   global reserve, single: total=3.50MiB, used=0.00B
>>>
>>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>>   extended_iref free_space_tree no_holes skinny_metadata
>>>
>>> Use balance to convert from single/dup to RAID5 profile.
>>>
>>>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
>>>
>>> Still, sysfs is unaware of raid5.
>>>
>>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>>   extended_iref free_space_tree no_holes skinny_metadata
>>>
>>> Which doesn't match superblock
>>>
>>>   $ btrfs in dump-super /dev/loop0
>>>
>>>   incompat_flags 0x3e1
>>>   ( MIXED_BACKREF |
>>>   BIG_METADATA |
>>>   EXTENDED_IREF |
>>>   RAID56 |
>>>   SKINNY_METADATA |
>>>   NO_HOLES )
>>>
>>> Require mount-recycle as a workaround.
>>>
>>> Fix this by laying out all attributes on the sysfs at mount time. 
>>> However,
>>> return 0 or 1 when read, for used or unused, respectively.
>>>
>>> For example: (after)
>>>
>>>   $ ls /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/
>>>   block_group_tree compress_zstd extended_iref free_space_tree 
>>> mixed_groups raid1c34 skinny_metadata zoned
>>> compress_lzo default_subvol extent_tree_v2 metadata_uuid no_holes 
>>> raid56 verity
>>>
>>>   $ cat 
>>> /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>>>   0
>>>
>>>   $ btrfs balance start -f -dconvert=raid5 -mconvert=raid5 /btrfs
>>>
>>>   $ cat 
>>> /sys/fs/btrfs/d5ccbf34-bb40-4b4c-af62-8c6c8226f1b7/features/raid56
>>>   1
>>
>> Oh, I found this very confusing.
>>
>> Previously features/ directory just shows what we have (either in 
>> kernel support or the specified fs), which is very straightforward.
>>
>> Changing it to 0/1 is way less easy to understand, and can be 
>> considered as big behavior change.
>>
>> Is it really no way to change the fs' features?

  Sysfs files (attributes) design doesn't support dynamically altering
  their presence though it is intuitive.

  Another option could be to deprecate the /sys/fs/btrfs/uuid/features
  directory (kobject) and create /sys/fs/btrfs/uuid/running_features
  as a file (attribute) to show all features in plain text.

> Furthermore, we have something left already in the sysfs.c, 
> btrfs_sysfs_feature_update() to do the work.
> 
> I'm working on a patch to revive the behavior, which is working fine so 
> far in my environment.
> 
> I'll address all the concerns (mostly related to the context) to make it 
> work as expected.
> 

  Hmm. It should be ok, but I am afraid it would be too pervasive, as we
  have many dynamic features. I am happy to review your patch when ready.

  Otherwise, I have a patch to clean the unused
  btrfs_sysfs_feature_update() function ;-). I will hold it for now.
