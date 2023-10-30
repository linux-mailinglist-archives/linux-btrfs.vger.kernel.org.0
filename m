Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22177DB2E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 06:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJ3FoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 01:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJ3FoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 01:44:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059690
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Oct 2023 22:44:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3e1gl013438;
        Mon, 30 Oct 2023 05:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vyPOTefn680EUjac4M4cVvA3cAT7b3Xv32C/weW3lJ8=;
 b=GDWRwPSVd2A15GQyDajrE6G7dt1v6J9Dwj3m+wzoisYRASNbqpdGhdRLrYkbVbity5i+
 mtG37uGnnGjuu8w/uWTIiy/XP1/mvLOcTpJQyCxARJMIfQ2+HgIg6kNm6vHuqFJfAgRS
 4VyqgQji/UXqgx2Ku/MXG056gAhcneYI6Lew9qo22mZA/BQX7MSFDTlaLQhgya0jmS5x
 XHq5TBKWPsIdkKfK5iuh1b1lJWhcU0XUXnaGOkrvymqCftOfq9XmBt26I6pDbMTzS8s3
 SfFMkThzxo8QhAk6I9lRk8UPsHrEwIME/j65N/E8XhpUwG574A+qPy/VpEZAFxUf4OO2 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdhwn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 05:44:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39U48wP6029307;
        Mon, 30 Oct 2023 05:44:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr45we2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 05:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWUs6zwuYOxKbqG+gAE/KgW96UNeP9Tzpy0mG7kE++PxsQYFP0gAjPnaFbCnE7AnrpYSWHK3VzNxcMJIp1ZDT8UJKfDeArKRqvRe1eon/zB/seFkXBMytlmwOQIUXFmq/mCO3rhn50WA5LmWq8Pnj9XDQr3zS8Z2ZaTeJzKShynWy8VWAsypTDfHMGKGvAUnB4IztYm+Ec/K16RXljQIoROqAfO0aRCRyYULiSCDNN96gRMceE1DWtN9x1ycXCXMOTw6iGME1OHoPJR0Sx9fJuHXnSPSB+jcJ3PtoRT76Gs1zGG4zxIFFCpG3pjZHViMCVEmj740kjgiCie/qoj8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyPOTefn680EUjac4M4cVvA3cAT7b3Xv32C/weW3lJ8=;
 b=Nmr8RUuyf8R5dpQ6i5WOY9sRPgtgUlKRSEFnIo9eGxNv0OnD1dkWCOPHsGVGrXC7cpOyW00VYQGCqn+Ikk+rH/hUsfAQ+K4jM75MoxPUyh1/7kssVFz53K73uYwkbKkd8/DOC0yryXAPUEhXRZvl0Zxq9ZEzZAn5NOxKAY+JFxG+bRH9jlfPsU+g4Z0lGpF5gOKRLm2R/a/ezKJ/Tr0H9IFXrCEX2h6TFZifjS7Mu+mbn7uUWce0S8vnNXSTswv0wlcqS1LB0KfPhpbVnVtltq49x572XiNaejerFgY/RSLYnAyVgwzSptDeAVAf1xAN7s8n3SeT3vNL/xKWAsUWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyPOTefn680EUjac4M4cVvA3cAT7b3Xv32C/weW3lJ8=;
 b=lb3BegUGxVBjvlifGdVq/wwfCB1XXPNN741fnw6VNOWynyNTy4OYkEOAFKxD+4OA/ps/w2nmbebAXLZcXyXZIDW+ecfs5P8rST3cJoIMNulFDr9O5aP6EYtiNd4hUVOyqNaJjYg/GgkVMZQNKl6tGbwnlrCyfe1t0La0Iv8s01g=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by CY8PR10MB6466.namprd10.prod.outlook.com (2603:10b6:930:62::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 05:44:02 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 05:44:02 +0000
Message-ID: <695323e0-400c-4d3e-8931-9b13b6a7124a@oracle.com>
Date:   Mon, 30 Oct 2023 13:43:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make found_logical_ret parameter mandatory for
 function queue_scrub_stripe()
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4da50284fed071fea6d629f09d318f70a4e42c47.1698461922.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4da50284fed071fea6d629f09d318f70a4e42c47.1698461922.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|CY8PR10MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bfc06f-5aca-4bf9-8e1a-08dbd90b3851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOYfKBPxhAAIhkia/JPysz66aiC8MpnEOkvXs48ZzmjeCGbm1m0Qd8kqPXwWPU12Qnnd6tycztHbsIMALnxDoNwHuoQwKCi0t1X3VZb1hWTtk9kPG2/RjI6imL8Nbjm5GOQVeVg2GzrNvYqOb9iEO6rcADFZeQz1fy2dFXSAcZ56KMiWkrmX+zIgJbi7efBW1tYFGiW7LKb3FW22Ca6VmPezKjSAZRGRbRgchwE3oLXzja6Q7pWLEvWwFhusHzkcOeTjp9sZSCqWjWVufajW+wSFT4MgJPjr14K8jon5glDYOKqx2wOBIPCf7G99MS64UVfKIOI6NEfGvK572CYFo5lTPdAIip7D5lr58AhVy6pw5C3tOn20SYviL3hBDbYZo8EildsZZOpmOjEGYWRLd4IW+VLQQVk5UTwmv3Z6cvuQgTnzVlDzW8Sh/gy6a7zlU7GKlJDTaxmJhACyqwvbNYkkQgDTM0qY2PdlyA5pvm38AhN+is2ZN7xOwtjq78J0MOBzu3vMu11MYzM6XoRV04ciBJY1qM5i5/mPKn8HtuMx9vqlmLYENv50OSqyBl5pQzKGoMi5NpIzVJytwC/WaNiumxdVBhpDOx/TVjmU+XY/2JOGbuLTHw/AksQYS5ucIlo8wElf+nZfW9WzWUXGbN31N4lYB0fUSwdw0zjZDONDZEBV+vFY+cg906lBkS5ZmwQ7C9fN9Lofxwq9N+lawdkKjY/Hy4zdWhF3OIsVDVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(2906002)(5660300002)(41300700001)(44832011)(26005)(83380400001)(8676002)(38100700002)(8936002)(66556008)(6512007)(31696002)(66476007)(966005)(66946007)(6666004)(36756003)(2616005)(53546011)(6506007)(478600001)(316002)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpDdlZxRDVMcUxHRU9rZWYvRDAvNGp1YmpvMVd5THFjTHRPOE03eG93V1Mw?=
 =?utf-8?B?Y0hKYzdoQ05peEY1VlMxTDQyRHRzZGYyN2dod2J1WkxTZWo5NkY2NDNHaEJD?=
 =?utf-8?B?UGovMWNPRGJZWkF0bjd0cno0bVd1ekV0dCtlSUFpR2pFbFlkTzE0aUd1YlBH?=
 =?utf-8?B?c1ZqdkFxemRhMlFWRXltRFBFK2t6RjJKeUE3N1NPR1dIM3N6T3F6aldBSGI4?=
 =?utf-8?B?VW95cytvdG9BMFFhNUJDT0YwbjNRTjM3UUx4SjJaRW1SVEdvTk1EeWJwdjl5?=
 =?utf-8?B?RjlSUUlMS2gvd0ZIZk1GQ09KNUw1V1kvZWE5MmVEekdhcHZwbSs1c3BHVDNX?=
 =?utf-8?B?QjhrMWgzMTZOcVlBZzhtUTY3cTRwNGc4ZlBhRkF3dDNWQXF3M0hTNWtCWDJV?=
 =?utf-8?B?K1d4Z2JLc3orTFo3UjhvWHlxT01UUWlTRFFHWFhmTjhKYjZtVjNHblpQbWxz?=
 =?utf-8?B?bGtlSDVJRHI4VGt4TTNFM1BZNUNDaytjMU9udHpuTjd1QWFvcUtPQTZlT2dZ?=
 =?utf-8?B?QTViejVwakYxQUpSYmFYWjVNYkttWERyU0ZnM1FrZFZCUm5oRkhpenE3bms1?=
 =?utf-8?B?OHl2aEk2aWNWT1Z3WW53Y1RoYUVjNjhzQzlWWmY0WFBDTFNYSjRuNEE5NG9T?=
 =?utf-8?B?ZlJUQmxLK3RNeW05ajdhVTBPODdzSWlVVlRScEhvUE43RjIrd1ByYUxuSXph?=
 =?utf-8?B?M1VUR0dpWGRaZkRiYjNvTlBNbEpPUzhnZ004bDhhZnpLNmNZa2Z6bUJIZExj?=
 =?utf-8?B?dzUvajdtZjN0UmZyR0V4b1Mwa2ZTRjRxenVBOFJWMTJnNkp2alZXUGhITVVH?=
 =?utf-8?B?MGlyTnZyb1pEeDNhazQ1eFBTS0FIV21RbDZGdGxrTkx5cTJJTG1vOG11b2Fl?=
 =?utf-8?B?b0xSTzBmTmZWdUFQQWcvQTd0a1JVOE9FUk16cHZsTDVvZ3ZLNGZzRU1aNkdZ?=
 =?utf-8?B?TE44a0ljdnMwc1Z2SjNIQjZGZk1wMlJOOEk0d0pud2RSbXhJUHlaWGovM3pU?=
 =?utf-8?B?elE3WlUxSFRHZFJGKzZmMjlCVmRDRllFbmRQRkd1OTdXV2JZWUdhalVrbEpB?=
 =?utf-8?B?WlNtaTMxQWVHZitFRm1XN1R5ZVdaZ2RVeWE4cWpabnoxNy9Ib3UrRUZxcUVh?=
 =?utf-8?B?SS9lYUxmOXZpVUp1WDZRQWlpSGtOOTVPVWEvZFpOSDVLL2phd1lXUnQ3KzBJ?=
 =?utf-8?B?Nm5ocjZLWTlwUnBtY0gxSUE1eUx4UXBnbzFDM2RqeDR6YmlZZXRxOW1FQkYw?=
 =?utf-8?B?eVpORHgxcW82Unl0Rm1FWkJBN05Pc2pDNno3cXVvZW9QWUlFNlpUZzRhMUNF?=
 =?utf-8?B?OFh6RWJiZlM4aXlQZlFoUG1sdHBwdENKS2pWdkJTMnFiK21aTXJkcng5dkh3?=
 =?utf-8?B?Y3N6NWt1L1ZpckFBa3hDT0hCaUJqYlF6ekduUDYrZzNab0psYjUzSmMyOUIx?=
 =?utf-8?B?QjJQckJzWEVGTDVDck9zYTh2TGhPTFF0MU9KVFVZMStzQ1BBOTZ0dWNiSkJu?=
 =?utf-8?B?RC9qVWtGUHRUNENLYTJ4allLaU5oU2t5c3pXWVEyRmc0RGNsaTUxTXJmRHRh?=
 =?utf-8?B?Vmw2dzdlajRtNEhlaW9uZUQ1SjF2eVBkTEUzaS9GZzhpNkFscksrby9IU2V5?=
 =?utf-8?B?ZEZCaTJHUDlqOVFiSGVCZTZyMk5FQ01QbkFtT3ppclJ1WDNqUWtJTHpkT1Nv?=
 =?utf-8?B?NlNKS0JWd3h1T0NySWJYNEtTSSttczQ2a0IyWU82YU1QQzBSQUppbDRlTWlV?=
 =?utf-8?B?Q2hEZmFUbDIvd01odXJTUnRTVmxJcDkydVZId1lHU09DUTlYQ0FCZmM5Ynp4?=
 =?utf-8?B?ZWh6QUx6dGRaeEV3ZmxpcS9OOXNJbXBBaWlPa1VFcm5DSzgzd25rVGVuMWNN?=
 =?utf-8?B?TXZaL3J5TkNoNlExR0d2aks2L1oxWGhQTXFhWkNzcjJlOVpWa0dMMW9YOGF6?=
 =?utf-8?B?S0Y2aVV1RFNDNHZ3SUJIMlp5SFpFZ3EzNlpYYmNNRFA0d2dwbytoTlVGeW5T?=
 =?utf-8?B?WS9uRzZld0YxemNscU44dndtVG5CcDRvRUNidFFHdkVxN0lhQkl4SnJaa2hX?=
 =?utf-8?B?OHJXS2NobU9XZm9DZzhyRWpIbHNBTm1ibWUxVHJCL0c3YXlqRm5QdVdEaWht?=
 =?utf-8?Q?VEtsFNavDq1cxnfFkXlNtH5s2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xd1m0GCivUD222US/LlDQSwKK2BMbP2IwtCzMUVSFhR8zvH1UaEb5BLhXWDqw6w/JBu0ZfMNlXMd4hDBo0wMUW0KBs8MMvmJ8y0A46o38aOtATUoftxPF5sb5+NevOdzctXRlmY80/lorKuGpZvXXmZYsqZ42azaIALhD68zK3Tu21rRmjdr1OC+2SRD8ftc0WCB1FyH+pYmNyP6sg08M3LjFUdopEvfgjB6LhkO14poPnPb6hpKaUYBcuvSGTjlXy3VqOW2JaMnEQjuRxcsXVsOk6/2FmlG3pu4MVZKBsW7z9UFubw56a1tXGJ/kUX+bStXcqQm5dkfotu1AsAiMJA+O4K1mVWRQxLTeP7dl/MH9ykMmbyfDB1pEsWHuohk1LEES1HgyWHHGhdsu3mvdyNwE+oNkYKP9e1fVJSNNqBcKJRrgf9n6Cttf/zr8cdmcuMMNOe/9qAgysXzttKCOeBdSVbofW9kRnEGq1xBIOCKhvPJquWSAbsCxQ9q+U1o4egLZu344evHbNMwZ37eC7Voiwjq1719XrZ+oid1KdkcewP5zTN+FCFkaQ5A3+yf2YBvuIGW0YVb6tQPnTTVQxok8fS9Brr6/i+Z3DepItbtMAcu93odAcVgzy2FSwdINtOwA31orJT7G6qwHPt0ANea9rxxPgY5eoDny8GYtIzdfZSXbf9siXmj9Qsp4XdJkht1p221AuwLwhju/0rvGsWHd2iiyrXrVokL6THQdbTvVCpSDkPgAJImelKPUi5p0JA+MMLj0avPk+Dtkc0feSpNmDyVm44IEtv7xAGyHgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bfc06f-5aca-4bf9-8e1a-08dbd90b3851
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 05:44:02.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzda0TGCF/dqLhfbCbbL48Al1mU+NqIwFRU8v2MoeU/kVGQLwrIVRG2/XScU7t/d7owlwa4JUmnmbkJzO4QCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_04,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300042
X-Proofpoint-GUID: AWglrQ7AI8hDFDjd_iRMe7toxNUepMtb
X-Proofpoint-ORIG-GUID: AWglrQ7AI8hDFDjd_iRMe7toxNUepMtb
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/23 10:58, Qu Wenruo wrote:
> [BUG]
> There is a compiling warning reported on commit ae76d8e3e135 ("btrfs:
> scrub: fix grouping of read IO"), where gcc (14.0.0 20231022 experimental)
> is reporting the following uninitialized variable:
> 
>    fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>    fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>     2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
>    fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>     2040 |                 u64 found_logical;
>          |                     ^~~~~~~~~~~~~
> 
> [CAUSE]
> This is a false alert, as @found_logical is passed as parameter
> @found_logical_ret of function queue_scrub_stripe().
> 
> As long as queue_scrub_stripe() returned 0, we would update
> @found_logical_ret.
> And if queue_scrub_stripe() returned >0 or <0, the caller would not
> utilized @found_logical, thus there should be nothing wrong.
> 
> Although the triggering gcc is still experimental, it looks like the
> extra check on "if (found_logical_ret)" can sometimes confuse the
> compiler.
> 
> Meanwhile the only caller of queue_scrub_stripe() is always passing a
> valid pointer, there is no need for such check at all.
> 
> [FIX]
> Although the report itself is a false alert, we can still make it more
> explicit by:
> 
> - Replace the check for @found_logical_ret with ASSERT()
> 
> - Initialize @found_logical to U64_MAX
> 
> - Add one extra ASSERT() to make sure @found_logical got updated
> 
> Link: https://lore.kernel.org/linux-btrfs/87fs1x1p93.fsf@gentoo.org/
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Nit: Pls add.

  Fixes: ae76d8e3e135 ...


Changes looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>


