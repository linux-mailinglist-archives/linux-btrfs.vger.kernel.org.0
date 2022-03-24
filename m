Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14434E623C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbiCXLSJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349784AbiCXLSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 07:18:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A88A66D0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 04:16:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O8oGvA001944;
        Thu, 24 Mar 2022 11:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rQuGFA9AZ0Yj40K0ukaInwXaWDFmYm4rljI2HkxuR80=;
 b=A9fk5AX6QpIgmVpYTs87MIjX2D6SX3IS08oi9nGG4uhuQh6G56xZdO9EbL2X7zoyhn6P
 +MYJMmUc9UG0SiA/oOpefbMc+3e2n98I2YzHBmJMtJ/3/fHVkyhHlZ+UMpbecI6TvlEg
 S7qhCddYMk4Xu59F713cDP/61/j431rjpuQKwRoUEpHQjIEusYHe594Z0aPPorNfGWIJ
 joGHGF3us2FNtJUbachAU0IBJBtCXf2NgIEeDO0tovh9JvhiyQG4sVcaceJshNM9d56A
 dzKsJsf4iayaTyTVnVMc4FgmlfjW7vH2UoRrBuB8DatcHft0WtnF6l1q7A2PHpJxav7u uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcuueg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 11:16:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OBGSkh030523;
        Thu, 24 Mar 2022 11:16:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3ew701r7n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 11:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4SSqA9cZiIQMvWbY3XxQR+yMab8wqmDrSMyP6rFTRaRlKRGb2SEZRlVgtaYtvMQHjMW08iuO6Cq+3XwubO+Vq60XGN9M2jpfBEQVAjI2kZwnLqPLD1IlgcW8UKW2pJXOuGCihp82xqoL+dvVkIZziJn9XPzUnc5mhSbtqFLwWfTAjstBElRWiap9HVBKmlgpXZWJxw5D27X/wHQS3iSA039zUrjTjxdC6sSvh6k2yNXjYDJioX+yTMLXQjUZWJUNTVwQlqkz+uUwExrAxbNKEioVbAf9nXQrbL3vNiu/ynrTjSi/K0ftvCblbbdJUg9zKBZWb6YdlD5uZPlOunmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQuGFA9AZ0Yj40K0ukaInwXaWDFmYm4rljI2HkxuR80=;
 b=R0RZDxSINWHXVSDbt5BkPVW7YlWTiROVWzM305Ueu1MfZavXnaYPgZZFMdGdRl30BeVBL1Y9fuCzvPY/WIsXtoBD+mUEkf3vCbC3kjmPvGviKOkGMiowJDC9DnZw5uw2RZHfUmtcAoAicMe0GfzjrTOMJTatWm0Yalv4k/mTcxoTEyl/9fNaxV5vfJKtcuWAtiwEn+CvwXzJDPWMEJ4uBzbTLYfZOOoi1ExWo4xwaYzOEEQrE6YJJvHrSvZ561pMiaCAT1xg37EZ0EWs6FOXJNfS6+xA8trIOQMjWH9ExztDSWN1kfm0dMB010xHT4sbSVhi/fSqzUu+N883sLgCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQuGFA9AZ0Yj40K0ukaInwXaWDFmYm4rljI2HkxuR80=;
 b=oC/EwFPbi+fX2t7FdESn9ohxRJlyBb+OlCaxI3pnxUDZhrAb+MVXAxCnQ+mKFZ8OAqW3F6903U5PxRJAYftyviCUb6KBhrHCfR9ukwjftKnHLmVwnd12LeHmbATeES1vuL64xBmGvX9CUClqEissZuPa3sXm5ezKbXC4fd1wjVc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB2997.namprd10.prod.outlook.com (2603:10b6:a03:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 11:16:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867%5]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 11:16:22 +0000
Message-ID: <795bf289-6520-cb90-51c5-7809d0683fa4@oracle.com>
Date:   Thu, 24 Mar 2022 19:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com> <YjtmLqBGlqaQXf2u@zen>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YjtmLqBGlqaQXf2u@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:3:2::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a09fcf-d302-4ea6-9d95-08da0d87b9e4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2997:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB299793C7290CB933D021220FE5199@BYAPR10MB2997.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kc74DnDWhieC+dGEFIvXcktRkiH0ZaiWNAEUrg9dQyTul17MrLMqj8zTVRnEeOBYB+jI6QvR9jeGbOE8qgDezljSWbdZtHPl02iKD21pgoZNl67nADorRKE/PhtRYP0VlMZ90tcniJ57tTPgmIM5fIGD2Tyhz9Li9hGnpXKL/Zn6C01cum2GA0SIWeLaLtbQunXP4Op8XURgERGVH4cHQDjlQS15GCpOx88GrCfoZazM5RDBwutM+LQejW/JY+p+6u3wb6P+bslr0omsAd0FQFgnaOCX9UI6l6ZdV9x9WixKPXaLvsdn+Of9Z9MwN8wbxdRtDHHPYn26LX348e2io1BsS/Mt5nq+cFGUjRGgjMISg7s6WrQ+w+zn5oenWbSvvlgJERV98Wi6vtkFXzC8TmY6yvJIJtA2v+u2yp2cbK+CRtwyMzSqAYUqlMId4BEr01ExSGfnqQBYmOBlZFVq4Ny3Of13IGGswALWaLoc7g+pNCRK20IF7EcivjcD94iIKfWuBwuUMfP6WcgpfDS1Ede+VRMYrTmfXtPvipp+BcrLmnleqc1WF9U+PbUG4uphOXHaxx5yjkvB9z6b22oRZ4MC3JwyowXwRvk0hJP91HGktJeTON5DwIVyhrkNgbegGvhsDNYZWFOwr7pTSyv/9pVwRSnyNksNcG/ZmIGOf2qMtZZg4mljHJDmdAI2JZLBXazkiOlJsL4SxQ7I3GvWWN+ispfbJ5L30eEOBAjyv0zXHAoGmlmsouC027T++XUBoyn94WI+n6Ne48CgfCvyBypbQQURMcwwBuzrszhe3N1wSTcExVJeF1gdMqvusgJe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(508600001)(31696002)(38100700002)(316002)(6486002)(966005)(36756003)(6666004)(5660300002)(2906002)(2616005)(8936002)(186003)(26005)(66946007)(66556008)(66476007)(4326008)(6512007)(8676002)(6916009)(86362001)(44832011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzYvUFp1Y2JVSUpEMDJBRjVvYkdJbHhJb1ZrTG5SU2pyd1hpV2FsNlE0WWh5?=
 =?utf-8?B?QzhUMzMvUVYrajBFQ0dYYnRmb1VTQ2tjZHBsT3ZJeHA1S3NSWlA3c0dkdktl?=
 =?utf-8?B?RkdzcXdockRPdzZScWxoQzRMYjAzSDFhTERpOC9nL0FZaWNScXdiSGVyV3h1?=
 =?utf-8?B?STZFZTZTU292Qk1mZEhheFI5NWVhZGpCQmMwVVBpcnF4Z0lrc2pXQVlBOWFH?=
 =?utf-8?B?Z2VOQVVacUtaMS9uQ1FrT3pwMlNDU3ErbDZQZUN6L2FSeHMrazg0blFXY0Fq?=
 =?utf-8?B?WnJ2TmxOZ3RKNU9MODlzMHNMY1E0MDZWU2l2ZjByOFBQUHVVT0NOSFFoY3lO?=
 =?utf-8?B?RmJBczBsaWtza0xtcG10bGFlckQvbStyK2lZc3VYcDc2d05TOUxvMFV6TW02?=
 =?utf-8?B?UzR4Qm5TTXMyWjhnQXNPQ1VPek9hSlJTaVBYa0R1eGYyMnlLZ0VCWURzOXE5?=
 =?utf-8?B?b3hKMDBGSXdlN05pOFRqVXVzbi85S2xDb2RRN0lTeVV6WlVpUEJLcVBwVnRp?=
 =?utf-8?B?dWNubko4SHhEc0lIbzZ2bS9WcnNFQ3FZdnhtOUp6NkhmdDNUUk1WeHpkclhR?=
 =?utf-8?B?RWZMS2txQS84SERVYmc0d3U1Y3RLZzJvenlTRDJLZlF0NEd1TG9Vd0IzWldX?=
 =?utf-8?B?SFdJd2FmOFNJaCtFV055Nk5aTUNVWDdOZ2hCVE5SMFg5cWJzbTZjV29JYXNp?=
 =?utf-8?B?WlI0cW9zckpVOXVBakR2TWZoR3E2dTVPelBleDJMK3RzZyt0WHNrWVFVbVpz?=
 =?utf-8?B?aDNDcXFrTmlLaVAwVmMwZGkzQnpTSzF6eGl1NDlDR0VsaWVYSXFYZVJmZ2oy?=
 =?utf-8?B?T2xSWlZKcTFuemF5YWFLeWlSTHhSWjA1QXIrVng4VWFvVUY5cUFUZ1Q1Umpl?=
 =?utf-8?B?Zk83UVpZdHQ3eWM5QVpLREp2ZGNVZDRuZkFNenh3TDdyTTFzcTZyK3RtaVNM?=
 =?utf-8?B?RlpjTUVMR1BBZFdYcU5HU2EzWXZJeTIwS1MvZ0FvMWRNVjRWbk56VjRuYkw0?=
 =?utf-8?B?cExwcDFWd3lXSUE2dkEwcWtwT3V6RFc5Z3I5OXdmM29MMW9lRkhWYnZkcGpZ?=
 =?utf-8?B?N3BSZ28rbFhEY1VHS0MwVm5ydlZ6RE9zb2RiQ3oreFhMTlNNNGFOaG9HSHV2?=
 =?utf-8?B?S1VKYlVpMlphUXF6alJJcHlnTGtOdVM1RFZLVllqTXhUZndNeW5CTlgzRWU5?=
 =?utf-8?B?WDhzS2RyTjRvdGRUdTRyWXJ5bTJtQ3ZKelkycUZpY1F2c3krcWFzcEdPcUxZ?=
 =?utf-8?B?VTIxbzBGTmNHcjdPREpPc2VlQ2tDTHRndE5WMjV2Z3ZRbVNHWnlnMWZscE1j?=
 =?utf-8?B?R3kwYmtqZWxNeG1OdDc4eURkRmhaOVZLa1g4TWdCaTkxRllCeGRGZ0pPWnlv?=
 =?utf-8?B?czI1dWFWc29XWVpqemRiYUkvK3A3QXZVTWN2TEZsVzlJam9Gc3FNVGhaUm15?=
 =?utf-8?B?Mk92Z1BFaVJjU0NpcVNrZDVpQlFvQWdvRHVyTy9paGVmOTIzVml1SkpDVkxU?=
 =?utf-8?B?ZGJjV3N6dTFQYWhEUUh3bG5tWnVMQ2l6MlhGUDRRa3o5VVE2c2hsUjFXYXZr?=
 =?utf-8?B?VmVld1RBeXdiNHdidmFxRHlCZ3F6c1ZGZ0RyZjBoTTRaazVCa3NBMUN4Q2dX?=
 =?utf-8?B?ZUdhK0tpRXd3Vk1zNURabGpXckhPTjhwb3FDMWE0dXF5UnBTRXg2TXVMQzcv?=
 =?utf-8?B?VUhpWnRwaDV1YWdVWU1QS3gwOHpCN2JldFBnUGxlRFF5U1lZYnlSU20rZG5E?=
 =?utf-8?B?bmh4WjVPai9TSW1lZXZ5dDZlOGsrclFGemhqT1Mwa0kyQUhiVi9iRVdCRVNC?=
 =?utf-8?B?UVdjZ0hzUTVTQlR1UTRReTVTZnNFTUg3dEJmc09yMW8rbHJLcXNpSHJrc2tM?=
 =?utf-8?B?ZTdjTlNGWmFWZmZzL0JwU2dTQlRuTTBuc0Jkc1pENHcrZVhhQURLQW5ZRFhC?=
 =?utf-8?B?KzJPVGFwQXBOVXNLSnNCSkNRaHRFZmh2eTlKa3YrcTJBL01zTUNhQ1RBNzkx?=
 =?utf-8?B?UkZNZmpQMFNzVUVJTjFPVVBUV2xjSC9tN0d6b0x5WFdzRUY1bmIxUlRVbnh4?=
 =?utf-8?B?Z1orZG92RnR5UGtBKysyTUdqanJjUS9rVWtuVTYwVWpjd2o2d21XUklIUEdI?=
 =?utf-8?B?OERhdzcwejZNcEYwaC9FSkNWcUNOUnh6QW9zU016SUVxMXRTSmJwdXZQUkl6?=
 =?utf-8?B?UTh0QzFqUThnbVdsSGdMUkwreURjdk0yOWlWYTYxeFlhM0hJTStPSUh5WUxz?=
 =?utf-8?B?UGthc2Rqa0s2UEtBM013NFZwVmZqTFVsNUJJWkQ1ODRYckhPTFVEUlB2V1lp?=
 =?utf-8?B?RDhCUGNoKzlibDJNOVVXUmFHeGNQYk9lSTY5b2ZNbUhVNHF5RmUrZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a09fcf-d302-4ea6-9d95-08da0d87b9e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 11:16:21.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA4Q5So9qC/Az8eu3oqjCHVSc8hS78nG3hodS82qpklZFN28wtZUSPPLmyq+q5o1H806d2TI3ULBLj/pVyU6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2997
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240067
X-Proofpoint-GUID: JR631B_jUbS0PyRqoq5ZHB9XcEoeVmgV
X-Proofpoint-ORIG-GUID: JR631B_jUbS0PyRqoq5ZHB9XcEoeVmgV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/03/2022 02:25, Boris Burkov wrote:
> On Wed, Mar 23, 2022 at 06:44:42PM +0800, Anand Jain wrote:
>> On 22/03/2022 07:56, Boris Burkov wrote:
>>> If you follow the seed/sprout wiki, it suggests the following workflow:
>>>
>>> btrfstune -S 1 seed_dev
>>> mount seed_dev mnt
>>> btrfs device add sprout_dev
>>
>>> mount -o remount,rw mnt
>> or
>>   umount mnt
>>   mount sprout mnt
> 
> Agreed. FWIW, I tested that umount/mount is not vulnerable to the bug.
> However, a user might be using one of the documented workflows anyway,
> and would need it for an fs they add a sprout to while it is in use.

Yep.

>>
>>> The first mount mounts the FS readonly, which results in not setting
>>> BTRFS_FS_OPEN, and setting the readonly bit on the sb.
>>
>>   Why not set the BTRFS_FS_OPEN?
>>
> 
> One reason is that there is other logic that runs when transitioning
> from ro->rw in remount besides just setting BTRFS_FS_OPEN. By not
> improperly clearing ro, we let that logic do its thing naturally.
> 

>> @@ -3904,8 +3904,11 @@ int __cold open_ctree(struct super_block *sb, struct
>> btrfs_fs_devices *fs_device
>>                  goto fail_qgroup;
>>          }
>>
>> -       if (sb_rdonly(sb))
>> +       if (sb_rdonly(sb)) {
>> +               btrfs_set_sb_rdonly(sb);
>> +               set_bit(BTRFS_FS_OPEN, &fs_info->flags);

  Looked more deep. No. I misunderstood BTRFS_FS_OPEN, it implies
  open_ctree() is complete and read-writeable. So this won't work.

>>                  goto clear_oneshot;
>> +       }
>>
>>          ret = btrfs_start_pre_rw_mount(fs_info);
>>          if (ret) {
>>
>>> The device add
>>> somewhat surprisingly clears the readonly bit on the sb (though the
>>> mount is still practically readonly, from the users perspective...).
>>> Finally, the remount checks the readonly bit on the sb against the flag
>>> and sees no change, so it does not run the code intended to run on
>>> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>>
>>   Originally, the step 'btrfs device add sprout_dev' provided seed
>>   fs writeable without a remount.
> 
> That is very interesting. Do you remember why we changed this behavior
> to the current behavior of leaving the seed readonly until the
> remount/mount cycle?

  So far, I couldn't find the commit that changed it.
  Perhaps Josef may have an idea?

  More below.

>>   I think the btrfs_clear_sb_rdonly(sb) in btrfs_init_new_device()
>>   was part of it.
>>
>>   Removing it doesn't seem to affect the seed-sprout functionality
>>   (did I miss anything?) either the -o remount,rw
>>   or mount recycle will get it writeable.
> 
> My current understanding (probably flawed..):
> before this patch: we clear the rdonly bit, but the fs is still readonly
> until remount (should figure out exactly how)
> after this patch: behavior is the same, except the rdonly bit gets
> cleared along with the mounting, not the device add.
> 
>>
>>> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
>>> does no work. This results in leaking deleted snapshots until we run out
>>> of space.
>>
>>
>>> I propose fixing it at the first departure from what feels reasonable:
>>> when we clear the readonly bit on the sb during device add. I have a
>>> reproducer of the issue here:
>>> https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
>>> and confirm that this patch fixes it, and seems to work OK, otherwise. I
>>> will admit that I couldn't dig up the original rationale for clearing
>>> the bit here (it dates back to the original seed/sprout commit without
>>> explicit explanation) so it's hard to imagine all the ramifications of
>>> the change.
>>
>>   We got fstests -g seed to test the seed-sprout stuff. Your test case
>>   here fits in it. IMO.
> 
> Thanks for the tip, I'll add it there, regardless of how we fix it.
> 
>>
>> Thanks, Anand
>>
>>


>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/volumes.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 3fd17e87815a..75d7eeb26fe6 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>    	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>>    	if (seeding_dev) {
>>> -		btrfs_clear_sb_rdonly(sb);
>>> -
>>>    		/* GFP_KERNEL allocation must not be under device_list_mutex */
>>>    		seed_devices = btrfs_init_sprout(fs_info);
>>>    		if (IS_ERR(seed_devices)) {
>>> @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>    	mutex_unlock(&fs_info->chunk_mutex);
>>>    	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>>    error_trans:
>>> -	if (seeding_dev)
>>> -		btrfs_set_sb_rdonly(sb);
>>>    	if (trans)
>>>    		btrfs_end_transaction(trans);
>>>    error_free_zone:
>>

This looks good to me. You may add.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
