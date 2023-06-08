Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2204C7273A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFHAUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 20:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFHAUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 20:20:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3602213B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 17:20:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mtejw001947;
        Thu, 8 Jun 2023 00:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=f7GFfruD2l9bll8MAEu0w19omhfzOD2koAeUWFXeBcU=;
 b=mYZjqrzRbGCzqer5waI8LLNjqh4kDy12Z5wN3VV2xsaZECm24FjEDqS//mUpl0sPevBz
 zWzFskZNJF7NAlt0sxx8QbruqV0CVzTe2N7wVIo7uxisl/I5PmekUFctHHUyGnBlpDCM
 XuwfpFEZjNTb6HV/hoi8bfBcwOdYIzzmybMT9PD1nUukFdvnWMTh3yF9BuQB2DRpJSAj
 qC9fT1iTTxwm4vyO8jzSvy8zDaVkzvkwd+aBNWO6UscARsMRhqPvtSv4ZUqR/o562oDF
 5wzgeiJ8by8CE1IflrNZFiA3077/sYDYqCQ00lSwFiek9PlK6PweTKiK0xs4HgObi/JK QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u3109-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 00:20:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NPsPD035950;
        Thu, 8 Jun 2023 00:20:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6s6tm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 00:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBa+AmR3AIWdS5pvivKc5strIdROjAB/WUXN6gA84HaR6aMkT9GBer+vt3bnOs04jwxwfsyPhi9AlaCqv39XxbpRRr4xwtuqIvyrnU+ooMDxaDr6jQ6HEmh+32wVH3ySyRW/dvehr83qo3z4mjEBiJ3c+DFwnUv3ZXwFKET/6Qi7tE4aCQy9aGLhrcQ+GcX0qYW7dnNIrfGj1gZgpOrrfpSu/9obUnifJIr9xNOYxwoG2U/+UxBeer0QuZrwnzRv6OOfKQUsIxi5VhYab+4xbvovdbx6fZ6tJqthQkJWsJlbFUnNveG0ltQtjSJkJoiSP+fWZ8ZCIkqRj6tYmbHWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7GFfruD2l9bll8MAEu0w19omhfzOD2koAeUWFXeBcU=;
 b=WXVMqr0gijAZsesXfg9fhjvTOB7u8V3UtKhV3ysMtM+vPKmXpJfZgfRSpxuaZlWu2Pnzts+MqlDsx5oAqVRmRxt1LgSg9bIAMiYG+AtUM4MJiKfXPZ0ZjLHxchfwzt/UskJteJ+IGca/7ZKf/0HSVzswwno3p5u4saEePM3oPS8wiYO6fOgLimKbHWIPU9I7y2XYeQRBWCtET4mrevWvLX4q7pBh4tHrVnYThkkf6rHJS+UhjW+5lHnjZ/KZp7oXbXmat4U0Vsrq6yid29yAbs6/UDuwFPf7QlljlK4smyGYgKAWSRInWQGVZaN9vWJ1rFy7QsOLDheIaM3ZxIrT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7GFfruD2l9bll8MAEu0w19omhfzOD2koAeUWFXeBcU=;
 b=spfK7JSes+E8Td+GKDjHQL4CVOoMiGfmtrtlP2LPDtzlsBymqj1psVvXdJExCNMMT5ldrRCqcbHzUKSIN1ql0WKerPLI0TdTytYG/kJJyJ6iBxzsB5lN64TfNNPDVP5dwxXicsc6MkKpurKi7cjRvHPk2UAnxDU8ei1dijRpCIE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 00:20:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 00:20:24 +0000
Message-ID: <689772ce-010f-9017-4767-2d5770ac51df@oracle.com>
Date:   Thu, 8 Jun 2023 08:20:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and
 cleanup
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1686131669.git.anand.jain@oracle.com>
 <89e1a74a-e8e0-ea44-974c-ac8877caf549@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <89e1a74a-e8e0-ea44-974c-ac8877caf549@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a540e9-2bc0-4cd0-b215-08db67b626e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/zbpaYljPFDGTgPT/G11kju4BIxK+4k7+LormvRcQB/JPTbZHSnRjkbyayqrJF+VfhaJLjcp8Xj6r5LpUKHUGUpPOsqWogdWHOUosOeodlgmTfMki8bikTzNbQmbXoXYIv1lbMf7evEnDsYKHVA0nX1RUx1jL9WREhoyxfMNqIB8ppi0IW2+z/PZHO8Xq8ayI2NtdCIhpSsuIPNs34h08Cy8gTnrI1rbOFDet92i/8/qmUtYShWafnHWFhnN/+t238nQqwcMmWh1M9Pvmz+XSzq2GpW082t/j2vHuyV+sDhQwVVg2dWlr5w3odw9B8H1n3IgkFbdiYNCTZOrxjuv3jy9NumEGi1qb8satJwPTpmdg/6lJ964u1UF/nziFMnoFFk0IAvJ0H8gsROBwQRqnIzoMzqq43GusaEcjWuAGgDjCMPs8drx1gwpwzSwTrtNmqYHnMbjp5LD0hYAutsFQGGuOLdd325BPNPTrO8LenOGSVAP4/z1nHgRynaWa00iVlrCLs61y0h2sNm93Go+0PPBxe50fCWBn0XkjxKylCO8a8D/+y9OEA8cu//dgNJ5jD/Qxt0Hj4tZgoHAFFUwErN5MOkF3EgKBb7XI1OIs79IwiTLyVPcdFulaJpDN/M2npJnSKTtEuZBQqDXpVf7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(8676002)(31686004)(66946007)(8936002)(66556008)(66476007)(36756003)(6486002)(31696002)(6666004)(86362001)(478600001)(316002)(41300700001)(44832011)(83380400001)(5660300002)(2906002)(186003)(53546011)(38100700002)(2616005)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mng2Zzh4VmdGRmNCNkN4M0ZTWXhaT0xGTWdQaXZkTUp5aHowdWRxbmtTTnBJ?=
 =?utf-8?B?TkJkY2Z0Y0JRczZUUk8ra3AwdFBRQXpleTRpMy94L25mbXVidXdTaXhqYUg2?=
 =?utf-8?B?VXA0c05nU3RndXFxYlkrTzJINkd3bzNOd2pZS2xBcm0wcUV3em9iZVMwbk1m?=
 =?utf-8?B?MHRCQldGTk9KbElWOXlDK084Qk15cldCVGpvR2NYZEg2Q0dXWE9JcXAyV28y?=
 =?utf-8?B?aVlKMS9BTjl5QUY3ZVNjU1NSb2xjMHNlQ2ZoWnhubFM2dnFMQkNhYXQ3SE5E?=
 =?utf-8?B?cWJkMjdVeDEzMm9ULzgyREhJNWxjRkthcDltaFZ0djVTRlYwalZHRWdtRFVz?=
 =?utf-8?B?d2FRTlJJbUZ6YzM3NVd3TFBVSmtVak5lKzJiU1g5YllRbU5rQUtnZnpMRHVa?=
 =?utf-8?B?S3RrUUcrYVkybHNJS0xmWThrUmhXYWo3V1ZQTmVTb2d3REZndk14RnQyck1a?=
 =?utf-8?B?S09tRFFNeGNVbDVDRkJNc2FBbjZoZkRyYTNLd3ZFNVN2VHhFdlZrTnR5QnBk?=
 =?utf-8?B?RVErYzBxVXpVRkhSTWxNZmxHb3QrZ0FWREFkYWV5UHowUFNOWGZzVGRXa0JD?=
 =?utf-8?B?T3pOU3NBbWlzZWpVcThQSHBkOFMxL2tKOW5GSFZqTzU5Y0ZaZmU3NlBSZlJm?=
 =?utf-8?B?dWVjbXNWUE1KalJrR21nSzBxVUhIL2xXTW05cmx0MUZaYXBROVVmdnkxQmky?=
 =?utf-8?B?bFJCRkpaREpvTWhLN3ozOEwrWmtRaTErajlIaWVWOFVKU1h5MjdOWnVLbDB6?=
 =?utf-8?B?YVZjdHdJaWJHLzlOTWtQSHdMellJb3JBdHFkYlZRcGM1Qml6TWUyc2pnTlA2?=
 =?utf-8?B?emMvamRxQWZ3ZTU1WnNheU5idW1hWVhLRzlEWmJhenZzNVRLOFM0RG02Q0Jz?=
 =?utf-8?B?UzllaHNNMmdHalp3Z3NGc3dnRDhaSW4rcjdLdElTWUsraVJIaHZLMnNZZ21r?=
 =?utf-8?B?eTFwU0pPRjUwU3gydGdLc2g5UVZjNVhQQkxIekxPNjdNSzdidW1EZGw3Qjhq?=
 =?utf-8?B?YzlmbjB3S2JoM3AwUXVEQkE2NG1UbGNRWDZ0WkUwcDlsYXhPcTlleFVNOTVC?=
 =?utf-8?B?UjhVeFExczVKUWdZaXpNL0dJeEtlTmpYSUpEY3pucXZkV1ZON0RZbDJTL2dE?=
 =?utf-8?B?K242ZDY3STc2YzBuSTAyK2FqNzdaTll3Uk93TGEzaVpnUmhQejVFeTVndmpN?=
 =?utf-8?B?TEIyNWxUa21hLzFkcHJraXliN1N4OXVsaWVKRlpqWEF4OHFDRGNaOHFkQ0ZL?=
 =?utf-8?B?NnNGbFFMdE5CRmFBYlJPaDhrQWZnbXZ1K3JjbncxamFvblgzRlo4L05iL1FJ?=
 =?utf-8?B?TDNXdlhBclkwMGNqb3h5WkFTTHJLY1lhWm1TdXV0Wm5WSDZpY2gveUpvMmlv?=
 =?utf-8?B?TE5nWElrY2syNnpxUHNKNkhpbEtteVBJRnFRVnMzN0R2QkpWVDJZbEIzQms4?=
 =?utf-8?B?dUNpMDdNaDVXQ2htY3A4bUd4OXZ1OTVtTC9MY1NXWWs1dklNQU10YVd3TzJO?=
 =?utf-8?B?NG9yVFhtSkxTbmRvMFBUQXg2b2ZPTjBmQVZ5UFNmRjZ5MlFKUEYvWTNxU3Fw?=
 =?utf-8?B?Y09DN01jZ1c1bFEwUDB5aWthNmVxWldJMFVGZkREczh1dElTTTkwbGtkU3J0?=
 =?utf-8?B?bDFTc3d0YngzYnZCQjdrUjBHaXg0ZWc5b0NHZXJoZVBuYjJUVFd3OWFDeUNZ?=
 =?utf-8?B?VVBNOFRtRXpTcExWbC9ZeCtmM0ZlSllodnNoSC9EblFWSWQ5RlpXUGhTWEEw?=
 =?utf-8?B?QkV5di9iQ1hQNEE3dWp1SUYrU2JkYjdnR0gwYnFkanU4a28vMU9CbTJQM1ZS?=
 =?utf-8?B?WHluQlAyUmJHNGpubmRDYVNlaTVUelJWTlNtZ2RFcFJZR1QydWRpTWRBYm9U?=
 =?utf-8?B?V0hJaktuN2NZR2dQV0NOZFB0ZlpkclMxNllCWUl3WUlJUGJ3RGg0djhTNHBr?=
 =?utf-8?B?Zk1OWTVWL0dQMEUzYzQxRytkN3lOMStoN1JkQm9BVklzNGV5ajRVaW1MOFF0?=
 =?utf-8?B?WHQ4T1NPc0I5OWpIUTZrbmJ3elpCeUNLSnAycTlJUXVJTHBUVlp3ZGk3ekZ4?=
 =?utf-8?B?ZXNkN1BpZU1VTWhQcTIxUlZ2YlBOd3p5OWZUY094RFhVWjdNTk9DdnJCMnVM?=
 =?utf-8?B?ajBOMXE1T1JVcmxVYWgzVlkwZ1hwL1AwQS92UlBCbXh6YlV1RE9SVS9BOTVz?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x6wa6536frEhKUYv9HW0/W31R6Qtty6rrxy1px1I0EkRLaIL7ord0H2iodQUQG8hQeUP9a7QmEXH1Scxej7zp5zxozzrOtWdzdE3qy5f1U3HWy7fxC5GfDhGYN3eaSe1HeLLVwI+p91Np7n4ahgNSoICZo8qbT6Su9erO901BSXf/ohOYFC0G252hfjBOysurFHgTx651aJQhkv0Jv6NccMg2qoH20yD9wIwn7qhnVwXZuVtGcWL/wmsxqx4mV7ENFIaQIBWYO9ClrSRFQZNuEs4VL0eC7MwoNMBO98XD7nlpFVAi3yOHn/5ECGbrBoGR2EuKaWuMlZIVilQXLXHqgMxC4TJdWjuYJrqft5KImYyISDJwp3tmP0gF2af5OpPEwiOJMTAayMbY5VurRj9jZeBJbj5b5toq6hknkXoBumczyPok9gbHUxJsoxu6LczXdDChOrGHk90tvb5dpnwF7PIso/Fku0jwdVq06/ixGzaSBHWe4qAoroVWvKDzoecunmrQ1IVp+DmrTqIlRLi+Gg9nhyMTBaXg5fv2ydeNIWGqql4WM4QfhxoOTlEfO3FfvleOd26U5rHBKkc0KqPE6+P8AuyL4VooUtWZ6wyndTRARj1EOZfTOMMDOy1VuLtztDtMeqbiBqGHv6wKW5J+dGcApIePqtMJTIBLFX6DsH1VHSriH5MUEu1p6tGTI1wZES5COAoCgurRj2cI1nNUYap05RBrmp9bX/0AsamsZ24cGT4uxVEdJUrdHagf+6I2ySzOTE4+DF5Fc1/NTancE92TMK67mIb75llyQofhNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a540e9-2bc0-4cd0-b215-08db67b626e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 00:20:23.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVEjblatc5c19mopyw/ZR2aLdTBJHtAkgmy+or2oUhcqigyLumIhCEhASzOEn4ak3TkyTGUEmiGn08S9zh2slg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080001
X-Proofpoint-GUID: GsofGNAFdrodJlNaEsiWkMR45poYwTqX
X-Proofpoint-ORIG-GUID: GsofGNAFdrodJlNaEsiWkMR45poYwTqX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/06/2023 19:06, Qu Wenruo wrote:
> 
> 
> On 2023/6/7 17:59, Anand Jain wrote:
>> In an attempt to enable btrfstune to accept multiple devices from the
>> command line, this patch includes some cleanup around the related code
>> and functions.
> 
> Mind to share the use case of the new ability?
> 

  As of now btrfstune works with only one regular file. Not possible
  to use multiple regular files. Unless loop device is used. This
  set fixes this limitation.


> My concern related to multi-device parameters are:
> 
> - What if the provided devices are belonging to different filesystems?
>    Should we still do the tune operation on all of them or just the
>    first/last device?
> 

  Hmm, the scan part remains same with/without this patchset.
  The device_list_add() function organizes the devices based on the fsid.
  Any tool within the btrfs-progs uses this list to obtain the partner5
  device list. This patch set still relies the same thing.

  btrfstune gets the fsid to work on from the first deivce in the list.

  Here is an example:

$ btrfs in dump-super ./td1 ./td2 ./td3 | egrep 
'device=|^fsid|^metadata_uuid'
superblock: bytenr=65536, device=./td1
fsid			c931379a-a119-4eda-a338-badb0a197512
metadata_uuid		f761b688-2642-4c94-be90-22f58e2a66d7
superblock: bytenr=65536, device=./td2
fsid			f9643d74-1d3d-4b0d-b56b-b05ada340f57
metadata_uuid		f761b688-2642-4c94-be90-22f58e2a66d7
superblock: bytenr=65536, device=./td3
fsid			c931379a-a119-4eda-a338-badb0a197512
metadata_uuid		f761b688-2642-4c94-be90-22f58e2a66d7


$ btrfstune -m --noscan ./td2 ./td1 ./td3
warning, device 1 is missing
ERROR: cannot read chunk root
ERROR: open ctree failed

$ btrfstune -m --noscan ./td1 ./td2 ./td3
$ echo $?
0

  If you are concerned about the lack of explicit device's fsid to work
  on. How about,

  (proposal only, these options does not exists yet)

  btrfstune -m --noscan --devices=./td2,./td3  ./td1


> - What's the proper error handling if operation on one of the parameter
>    failed if we choose to do the tune for all involved devices?
>    Should we revert the operation on the succeeded ones?
>    Should we continue on the remaining ones?

  Hm. That's a possible scenario even without this patch.!
  However, we use the CHANGING_FSID flag to handle split-brain scenarios
  with incomplete metadata_uuid changes. Currently, the kernel
  fixes this situation based on the flag and generation number.
  However, kernel should fail these split-brain scenarios and
  instead address them in the btrfs-progs, which is wip.

> I understand it's better to add the ability to do manual scan, but it
> looks like the multi-device arguments can be a little more complex than
> what we thought.

  Hmm How? The device list enumeration logic which handles the automatic
  scan also handle the command line provided device list. So both are
  same.

> At least I think we should add a dedicate --scan/--device option, and
> allow multiple --scan/--device to be provided for device list assembly,
> then still keep the single argument to avoid possible confusion.

  btrfs-progs scans all the block devices in the system, by default.
  so IMO,
  "--noscan" is reasonable, similar to 'btrfs in dump-tree --noscan'.

  I am ok with with --device/--devices option.
  So we could scan only commnd line provided devices
  with --noscan:

    btrfstune -m --noscan --devices=./td1,/dev/sda1 ./td3

  And to scan both command line and the block devices
  without --noscan:

    btrfstune -m --devices=./td1 ./td3


Thanks, Anand

> 
> This also solves the problem I mentioned above. If multiple filesystems
> are provided, they are just assembled into device list, won't have an
> impact on the tune target.
> 
> And since we still have a single device to tune, there is no extra error
> handling, nor confusion.
> 
> Thanks,
> Qu
> 
>>
>> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
>> preparatory changes. Patch 7 enables btrfstune to accept multiple
>> devices. Patch 9 ensures that btrfstune no longer automatically uses the
>> system block devices when --noscan option is specified.
>> Patches 10 and 11 are help and documentation part.
>>
>> Anand Jain (11):
>>    btrfs-progs: check_mounted_where declare is_btrfs as bool
>>    btrfs-progs: check_mounted_where pack varibles type by size
>>    btrfs-progs: rename struct open_ctree_flags to open_ctree_args
>>    btrfs-progs: optimize device_list_add
>>    btrfs-progs: simplify btrfs_scan_one_device()
>>    btrfs-progs: factor out btrfs_scan_stdin_devices
>>    btrfs-progs: tune: add stdin device list
>>    btrfs-progs: refactor check_where_mounted with noscan option
>>    btrfs-progs: tune: add noscan option
>>    btrfs-progs: tune: add help for multiple devices and noscan option
>>    btrfs-progs: Documentation: update btrfstune --noscan option
>>
>>   Documentation/btrfstune.rst |  4 ++++
>>   btrfs-find-root.c           |  2 +-
>>   check/main.c                |  2 +-
>>   cmds/filesystem.c           |  2 +-
>>   cmds/inspect-dump-tree.c    | 39 ++++---------------------------------
>>   cmds/rescue.c               |  4 ++--
>>   cmds/restore.c              |  2 +-
>>   common/device-scan.c        | 39 +++++++++++++++++++++++++++++++++++++
>>   common/device-scan.h        |  1 +
>>   common/open-utils.c         | 21 +++++++++++---------
>>   common/open-utils.h         |  3 ++-
>>   common/utils.c              |  3 ++-
>>   image/main.c                |  4 ++--
>>   kernel-shared/disk-io.c     |  8 ++++----
>>   kernel-shared/disk-io.h     |  4 ++--
>>   kernel-shared/volumes.c     | 14 +++++--------
>>   mkfs/main.c                 |  2 +-
>>   tune/main.c                 | 25 +++++++++++++++++++-----
>>   18 files changed, 104 insertions(+), 75 deletions(-)
>>

