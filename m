Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48B6A7B3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 07:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCBGMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 01:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCBGMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 01:12:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959423BDB8
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 22:12:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321NUcbe013127;
        Thu, 2 Mar 2023 06:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b0+DGESprIxMaeGHk6UcYIndD0jmknCgcMdF4+aM71Y=;
 b=GNQW+daA9BmHBF6zj8LsUZ7AHtCNwEjs6EUuuhuOaALk6nuc5tyox5MkKJQhFaaYjmp+
 RQ4ELfb6srDdOjh3RHSwn9kWhxGCsuYK+4CgwZDKZDSaO9oTe0oCBxV4maznrX/Dkabi
 cdFYxbxD3mlQe8U1IEIu/FrexLZFH6CBmQT2gx1nOpvVUG3+haLygkHlDh4umK3VnkvR
 kOPvqL+i9890NywkEtRrVOP7sfDIhE8UWDqN4uZWscPfVHzhdzAROanezv/lP0KgmvRb
 jZfIWqAfOf6V3IikF5VcL1GooHEbtHOnYb38dbvSIFFH2UKMWhUbumtCES7eXBz5fxf/ yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7jp5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:12:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32252krp032891;
        Thu, 2 Mar 2023 06:12:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s9jhmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:12:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9GAp0XlqXAz3RlHIKh6C3HvYPhn5hQYliKFClb8W+uRl8H9wUw7BC1xYxUkBbh8N3V0cSz2apy0BsRMaF5cMiDRuTD989/d3OPT7P4QPLewDW4PeH9QyusWhjYy8eu/iXtsX6XKnFXub+x5F3lZKT1GfwuY7+HydOJWKy+LUVk88bgzxZTs4h3LRaMpXuNZPaRkgDluIRoZ7iQvBfbf3Ss5lfrTjJEVxshTbSRUrtWcYYnmhmi0IEDA+VAhS7rQcvE8bQufWyDWpyb1CY5XelJZp2o91TlwyZ5AWbwf5f8hoHmFFe6viqbScXoNyGFf7ez23cZZYQ6BPMgsK3LTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0+DGESprIxMaeGHk6UcYIndD0jmknCgcMdF4+aM71Y=;
 b=VALkYzpoJBN4saRrgNAQIcPP4jpdLunLRL4kIum5PfkCx66COyQ22yWalJtxPMaVr74/s0JqjLzmRvGAXBl+Mki3OUMOWjQ7XaFZWLgG0WnJq1TmEdOWULCZMrqr0meTPJiJ53F/N3TvsWe5mx/KTQ4U2vmh9gemG8KgKLDrrlhb4tWSsqoEsK25apIDwVSTbek327GY4TB8WbOTq9/v2RUhEqhksJfrCYPhpkHGEIpqtLD7L64c8x6K5vdEsWAfwgaQ5mHvpUTEEeS6HRgTgHrXZZcdZSQ5JXpufA+bmjtigyhaKSO6vMOa04W0bRoTV3jaJAdrPixrPRnniKZSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0+DGESprIxMaeGHk6UcYIndD0jmknCgcMdF4+aM71Y=;
 b=WCF+MYv7V4f/c4sMw2SVaO59M84/H5++4x6HOT+dWQI++YtbmRvsW8h0Z7qsoBjMXTPfsjdpoh8Ota9I3N34fRtJp+3MKPwb2WiEis+izyT98CumdkWXrjTwN4zR04mbC2l8eEx3FlGTl8/xL4SmNEN4oefkNdQMk+Ghd8NMjIg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6720.namprd10.prod.outlook.com (2603:10b6:8:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:12:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 06:12:28 +0000
Message-ID: <057a597a-d4df-3b76-1d72-8b60fd683a7f@oracle.com>
Date:   Thu, 2 Mar 2023 14:12:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ce7236-d9ed-4b7f-5123-08db1ae51961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg6ub9RfPrDvOUDFtq/8SiZdkrW3PyBfYkgyEa9+VeVFyTE6FPPK8Vqtopc9zYuAvwf7batIMFSxvxmMxXY9Ev2T6vo90cCTwikwsdDlsEAlvUj155BISLY8AWBFCDiraMw9bf45Ru9oqTEYrhp5cf/NLZhciAgbCXtjFJVzxxCpQcIaqSf8PSNL+MWJhUFgqCcwx28ZVCKkTmvkwOItbxKERa7XcmLWz98mJ/WTt/lo0BgJwhED4Da2zCYVP0lXq2U/p51Tm9HTns0wOgQ1V5ViQprhUT8gcDxBvC2U+cU6MLC9RBDwq9NGsHZQGqMxjpDJN1EuC481V7kxQNdipRbDxUjuD0VN56CttMpR+knBTLz+VwAr6mT35Bd29OXHRL2pXKafbvkR9wImxhsKBEQcHWKL1KPLKxWDcmm2GMWECtt0+lKqZjqNICXAQonDoK444v86DEeJpw6RguC58H/pZ4dprUx9yOJj096Gn9PwVgF8hiwY9sNI22aELViDlnLHMo59DGlhP4xU156gPbKMPF4KXPS4+Z/DWfJFdIPiYA+yuB6pCjmkEfSMaIitgfdMI4Xe1SxX3rbYt1dcEAGDNcRNlEftez7IwvbrN62Ocsi3SQxZkV2oMGKXAYjybNs0/rZwO8NCsGrM7Jb9QkVq0eNrqp9a/KaffsNUKZ3C3HK0QvNT1MgQ+xi7X4xW2dL+dMKd10/bqgDHYBz0dN1trhlztSK9ujZeop+wFNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(5660300002)(53546011)(8936002)(31686004)(44832011)(6666004)(83380400001)(8676002)(66556008)(66946007)(66476007)(86362001)(41300700001)(31696002)(6506007)(478600001)(6486002)(38100700002)(186003)(316002)(26005)(2906002)(2616005)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBKdWN2cVZ0bmQ3SjJpZForUVAvSXJFY3hZQXVkTklaVVNJell4SkZqbGFC?=
 =?utf-8?B?UTNGQzA3NzE3Y2FKMFFmdnBEd0VXYU8vSU91cmFjcDNaSG9SNkxkK3U0d041?=
 =?utf-8?B?WjI2Lzhpb0lXZHNrY3Q5eWNtSU1JVkY3LytIbG9KNFZxZGFrWVVqcVA5WlNv?=
 =?utf-8?B?SWFwbERnU25zajRleFF4VjQxTWp1cUtmWTVjWlFqMGFMVnVRWXRJTHhFMTdi?=
 =?utf-8?B?bUt2dWJCVm9iUjJmUW1jKy9nSnhuM20yTUc1UWtuZEd3bE1RTXQwMUNzaUd5?=
 =?utf-8?B?TU9HeGFTbTZpcG1XVTBHcjRUWmUwYzk2MXBPT3I4RitrbWM1TngwTExRVmRO?=
 =?utf-8?B?QUszTnloWlNwOGlxd3NjZlFtSWtHMUhRMVl0Vi9HZ1gwUWpyUzFkNVkzemoz?=
 =?utf-8?B?ZGRvdS84TkxiaU1WNit6Nm4yb0dOWkZxeTEvb1hGVWhxY2kzNDJsUFNiUnZZ?=
 =?utf-8?B?T29VSlZpTG5RZFpvcmhSVlNYUHovbE56SDRYck1mSmR5VUVFK2NxbWg2S0ZI?=
 =?utf-8?B?Sk0wVC9yWS9hdWEwREF0TWpGbEFidCtoUDFZaTVNN2owSnRHRFRxOXJYNEcr?=
 =?utf-8?B?YmQ4WXJ4VGJQRGpkckp2TjV1UEhSVFAxUXRETmJkYzB4U1dHWnBsRlZsV0RV?=
 =?utf-8?B?NEJYbXkyVmN2VWVCZDUrMWJlcmxxUTl4WFFxMEJFZUIvQ09lRnlHS0l5NXB1?=
 =?utf-8?B?dGZ5eElmWWwzVVBUaUFDMllhM1ZFcmdiK0EzYVpET1RUTjR5UFd6OFM3Q3Ft?=
 =?utf-8?B?VjJpSUFldkJXTk9IaUxvbmE0bFFicjR3aCt0NHNlN3EzbisreFozV212aXZF?=
 =?utf-8?B?VUJDMSt2WFMxL2Z4Si9jbThhalFCNVc3MWhzZUMrVk1MV2lSeVpweE11OFFn?=
 =?utf-8?B?WFJGVjV5ZEtKampZeWEzQTRqUHM4dHg0bHEzcDNBRzVRRWdhUzV0ODhIZkFG?=
 =?utf-8?B?YlZRMkJHald3M1lycktIRklXZ2lvcGx5NHJUQlRFb0EvYWpLZDAxWHZRRzF6?=
 =?utf-8?B?NDR3UDhUc3Q0bG9rckowdVJ6OWtWclJXb3h2UUV0VWxCUFRmSGlreTFNSkJ5?=
 =?utf-8?B?TmlUaHFBNW9SMmJvbFJIWEhkRWV0RUc0SkFjeWFDV0JXdG42QU8yMmdqUVA0?=
 =?utf-8?B?Zk1LV0tBc3FuSUtOUDZKblJiQmw5UjA4V2NQY3VZWVVlZnJLYm9XdEZyYjE1?=
 =?utf-8?B?U1B1RER1czhKS08xMUZ4amFjUTBhUWdOdG1nQWEyMCtRL1creFRRQ0o0U1VT?=
 =?utf-8?B?bXVRQ2VQWDhKZE1RRVVRUmxxb1YzSlRCUXNvYnFUOHBCdHlzZURiNEx1T2Fx?=
 =?utf-8?B?UHd3WUxwcjFjMXdoU0Rsd2FSLzhHbDlMVUY5TkpxYjNGUGhrRVBEV3NLYWds?=
 =?utf-8?B?ZDZlMWFhdi9obmxoVmVXeWtINVZwQlozRnlseFdIY2ErVXhXdGYyaVkrc1dP?=
 =?utf-8?B?L2wxdzNUc0prelppZVcybVB6OVlFTFJXaitUa1VCcGJpRkcwbks3c3hoSXdS?=
 =?utf-8?B?UVhZNGI5QW5ZL0JLRjl5dWZiQnhqVnM3eG02OEdZaElBUWdRODRoNkZZeWVP?=
 =?utf-8?B?eHNTS00yVUVmaDVCUlhWTlQ1enZTQXY1bEtWZ2ZXZXJsNVMvYUhnTGtYODdQ?=
 =?utf-8?B?aHdmTWFpTVhGOHNGMGl3dk1yNjJFUzdXKy9RT1B0WGJuTEZmWVpWWlhVMWtJ?=
 =?utf-8?B?a0d2RTZoZ01kcDlSL1hVTmU1dFhlMW5ZSXZiS2QwSWxVczlZQnBnd0xUbFp5?=
 =?utf-8?B?ZnRJK3A5WkFVdTEzZnRyclBKcDFNNy9PTUFDYkdvdmJ3a0pVR0dWblc0WnlH?=
 =?utf-8?B?ZFRJTjUzUTY4RVNHamV5MzM2eUZmN0hMdjR2aGp5ZDBXM09xTGkrTjgzL2lj?=
 =?utf-8?B?YmNqVWxsSGUvOTB4ZU5XUm04L1VQbGtNYmRKc3FtTGhSRjRRakZ6SldFUFNu?=
 =?utf-8?B?cndwWVpBV0dvZUhjMjE2U0hQOGhUMGJnQnE4d0NmRWF3ajBVdE1lR2Q5eWZ5?=
 =?utf-8?B?WWZMemF4dllkSHRJZVlONDQxWkNXV0xLcSt4cEZrL3J6RGIybjdSUExWeDZK?=
 =?utf-8?B?dDFKTklkQ2xubnJmV1k2M2tWYXBQY1hub2FCaGl3T2dPTkoyUFl2c2crSUJK?=
 =?utf-8?Q?/drDmFcpZzO5JQVlDUsW3CUUZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iPVd50VAlQRrgwb46MNZLkqsQF/2ZJmpewiDe1huHgxVBIC2ZXe9aMQ62PEOwwPITbGYpI+HwnvrjU2mDH6YbSRX4PWEwHDuD0nbBfGNPknD+GaZZJXCPqbVBn35TRlyVLDqCoPTy/tkdTg25MmSDTEaG8rbnkkb/mBFEiS59l3bNRfJbKu7mPwe5gpr0E+7grcGmWamRLBpYsPPZtYtPCXehT2t+wrNFuOuVeo0n4fWqIhJao73wJCudrFx0GiQNEDJ9Fzq34DUTiVTLl9DeZZMO4hP/D53yjb3qSdR0DOX2ZGj+WeIdveWYpOD0V9Yf6SYFlf6vbIjNOMs8NBbVJE813wOUkFFZ53TY6ISUcbvHDmZhgvQFblOJLKzn1LgYG6e6XMUrQ6F3YR8EA7hB6yuDL6RPlGTnF5fOAWW0Agmn7VTm67ZpLb6O2/7CDx3hcwAlhBSUpYYrJE6AUFHc6xdH592QyrrlEMsdpPMtUnNXazVhQNYwIUe8oJvfWUsRheWpYnH9LnTgXzQu58pJ6X1D8uEpaMJqcdww00X66f/LviF0fuRVGgj2NhYKsxo7xDiDXXFOS+3OBgfS4XIw2W/D7MusF5DOF8T014WTCelGn5m88PuWgNWzoxUVY5yB5KLedgUfbIqkIhZvnanX/4VROKauRiQF3xp6JIWKjq58FlxK5ibw/GqwHLIC3nyAzvWjNXNcSJiJBKl7G8FrJOPhlfcUyT+YS5AFTD2eMDPe6nnc4cmJ3d9NUT27U87JpOVXfuvQnTQygCZvsgyTPbkAA7lBLwzTcccRF0WIuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce7236-d9ed-4b7f-5123-08db1ae51961
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:12:28.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npsEnhhgBgOTa7cy03iugPdqkQAC/phjzbX8XiWj/p+3DT0LT2hNereTc3spR0AuMQGBReIFQs8awLqrOYE/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020050
X-Proofpoint-ORIG-GUID: MTFmzEQMLVTv55NC34DbLOj4qtc7c-cv
X-Proofpoint-GUID: MTFmzEQMLVTv55NC34DbLOj4qtc7c-cv
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/23 09:54, Qu Wenruo wrote:
> [BUG]
> During my scrub rework, I did a stupid thing like this:
> 
>          bio->bi_iter.bi_sector = stripe->logical;
>          btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
> 
> Above bi_sector assignment is using logical address directly, which
> lacks ">> SECTOR_SHIFT".
> 
> This results a read on a range which has no chunk mapping.
> 
> This results the following crash:
> 
>   BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>   assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>   ------------[ cut here ]------------
> 
> Sure this is all my fault, but this shows a possible problem in real
> world, that some bitflip in file extents/tree block can point to
> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
> is not configured, cause invalid pointer.
> 
> [PROBLEMS]
> In above call chain, we just don't handle the possible error from
> btrfs_get_chunk_map() inside __btrfs_map_block().
> 
> [FIX]
> The fix is pretty straightforward, just replace the ASSERT() with proper
> error handling.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rebased to latest misc-next
>    The error path in bio.c is already fixed, thus only need to replace
>    the ASSERT() in __btrfs_map_block().
> ---
>   fs/btrfs/volumes.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4d479ac233a4..93bc45001e68 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   		return -EINVAL;
>   
>   	em = btrfs_get_chunk_map(fs_info, logical, *length);
> -	ASSERT(!IS_ERR(em));
> +	if (IS_ERR(em))
> +		return PTR_ERR(em);


Consider adding btrfs_err_rl() here.
Except for scrub_find_good_copy(), the other functions do not report
such errors.
Furthermore, scrub_find_good_copy() lack sufficient details for
effective debugging in the event of an issue.


>   
>   	map = em->map_lookup;
>   	data_stripes = nr_data_stripes(map);






