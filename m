Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257575BD7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 06:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGUEtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUEtx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 00:49:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1514A1BEF
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 21:49:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMigt016193;
        Fri, 21 Jul 2023 04:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b5+7mxkqNtldiiD2Ls/XvJAJFTNqGIsmnwZ/Kl5hIng=;
 b=FDDchkRDN6eWwtwGVBWTL8Mg26xdgKlQJZYA6ttSZtdwbswa1GCSBzGoTWYAYiNuPr8G
 dsQ2Q1btMUBNGWXLDe5hwXBleUk01377pL31bG9I6V6wuVNJJcfD3RgKVP+5/95jsGr4
 UnY3Vd8DtIlow/YdmoOBL3AsWBOJpoDGf6zua/ZcY/VGkCd0hEjtPzqFr9l5VORlIBkw
 qa3JrUzaV1vNVU+ED/gRQu5T48U4svDtt2yby+J7OuNlSxylMhdRcDmeHttKT4RRBEwa
 +yCHawS8F0MT5aMqxOdfgRrlKJ0DJn9E2E80D0DHhJ+nuXdlqxQ4eLPWNeSh1LG7RgI6 UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7834ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 04:49:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36L1uqw8023837;
        Fri, 21 Jul 2023 04:49:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9sqjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 04:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ8vswm471iCFYl5MU/QgzcO+XtsmPtQ5B9FVX6g9bM7aLDTKmcg6tcH1ZqBFyM2yidyCnrMk0cFm1u8o3LK+4sKsJnbU1ZBRv+0PaoagAN/mPo21w26w+FnrA4B79xjD08xYwwRWpaLphpx5X1GUVcdMLLCzazDSN5uwPD7hVe5lCED/iHXNbBRvtOEz38BmayUlzrPJf2SQAyy/X3G7sO8TksydMj1obibXuXHW9YpjFITimnq983Oyjw1DLwlQ3iN+BcjissnTz57iBz+g3KM0WCJ1Q0y9evYbJnXEqcoulkTRVtUbwsqrXSmbqOvVU6dIvxyjw++kNrUExp+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5+7mxkqNtldiiD2Ls/XvJAJFTNqGIsmnwZ/Kl5hIng=;
 b=DA/NT/CIX8kgQ1deTXgDOCT8E64pDlDI7rF6TlLVV4gCv0O6Yw3OT7R4dwCfTYohhA1mrXOSJgRaLF3uH1OL+BPZsIxmnLxgGQ3cd1pYDDtVhzWF5gV5ghK4QuRA0OMbvaNaTBiOK6axG52m8P2mpBwUEabMFLgixVzgn/CUWFh+cPX4u+sDxuJ7FYx9GTkNhgZiL3mK9p28NrooxGcKxAMEKEHZde90os5wYvML/hL2RvcrWXJQsnMUuRs8egrgN1eer2K+EnjPYtfW15026PB0zDtay1fsvSIeGa3tJz/fpylYOCjG3FqDLJKsIMMLC0rzCtGVrNrJ869GJ9Mj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5+7mxkqNtldiiD2Ls/XvJAJFTNqGIsmnwZ/Kl5hIng=;
 b=EWEzfPaOaUmPqG15PZiV2AUFTVgRv5Su+DqaIU0nRzbtO1VMsFun4JfCtVy9X6+modVeiSnHs2snFzQIc3pu8JHRfZeOBjpYdZV2y2snjocsfn8MIRCYYs4TOAwfP2468uYFVqcLYMIO7KJXCHstV6wnFJZy6nEvGk5xwUNz2fI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6498.namprd10.prod.outlook.com (2603:10b6:806:2a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 04:49:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 04:49:23 +0000
Message-ID: <fe7fc452-8356-85c8-9685-f40e68db8a2a@oracle.com>
Date:   Fri, 21 Jul 2023 12:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs@vger.kernel.org
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
 <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
 <OKQ2YR.1O44EDSAXJ853@ericlevy.name>
 <5b436e82-cdd4-0f84-71af-014c41c3e12d@oracle.com>
 <QO24YR.0OIFSCSV1LXX2@ericlevy.name>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <QO24YR.0OIFSCSV1LXX2@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bade514-8915-468d-654b-08db89a5da43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8uXM2JFx39qhH+wU6KHHSwbE6PMg4uSOR3cI6SgeF7Pek28Cktz4yHH0qwCcVFyq8VSCCWq+tc/a1s+D6p/v6BzSjNtmkUqvnMAT+cn7eDftdAZuWa/KR5b0Yh8Q1d2Pu7uuGHHMuE7W0hT19HT9XI9pRrk85yZxDpcJfx1s1f3cQt62moHUfMAHOGIUbCsZ/5sVhieFJ4S/cCk7DXz3/gYYWSE06vCqeT/IAv0SRWnAJ/1U1b3UPftSxxxmWh86CEKXpLQbVGGgW32uOS3Cc+vCOe3GN8IgUWqvCV9aNZyD8MTHdOPeR54JIpyD5jiLhiiL9I3Hbv/VXEGHkF3KkQCDR6awwxUHDrIcmPdsXha7ERm1UBHIe5bAq8bGcJqpcTQBvMAnVx+dt8T1gOK404m7gzZWI1SfHFKmvRwVESUy9kjzRWQ75yEfYN2JzKfnbdnPl1MwJEiR9C89nqKKexsGP/YyuSsm1DEdQu/yYJR+lpD/Xh7Zu1nwGB3GjW4O+9vJY5dOvyD6XcaxLUC81Rq85fL2D4nWotJ2UnDV9iIfyK4tB2ZcndpY7jM5e7tCQ7YM9KBHE/frnxPKdbSg7PkDODxk2Rkkuf/pvYRfKwKx98EOwXcWZ7ibh07Sz3gZRk7JNqiwVavV6X1VkWjHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(31686004)(4326008)(6916009)(53546011)(6486002)(6666004)(6506007)(26005)(66946007)(31696002)(86362001)(478600001)(66476007)(66556008)(36756003)(186003)(83380400001)(2616005)(316002)(41300700001)(5660300002)(44832011)(8676002)(6512007)(8936002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0wxZ1p3ekU5RXY1elFYeC9HaU9VTklEbnVJaTRYUFRZTTloWEMzdFA3R3NW?=
 =?utf-8?B?ZlFyOXVwZXozQTQxVU50WElIdk9HbEk4QzVUVmMxMnJtUWdvaVpNWCtkMXBG?=
 =?utf-8?B?bFFzVDFQUUNnYXp4dGlWL2RqbTA1TFdPYzVrNmNiSlpYZ3p2ZW1saVc1R3pa?=
 =?utf-8?B?bEQzTE9iUEdhNmRGRmpMdUk5N2ZiRVovSXp1cVBiZmpaekx2dkQ4Y3EwZDlO?=
 =?utf-8?B?Z3MyMWhJelR4b08yNHpYZFRINTdrbndkN2hNdWNiZUhuUytNRG5CN3JvcUZv?=
 =?utf-8?B?aFZGSWdkUXNJREF3OHU0MzNGYytka0dPcUk5SG9Oek1Iam11NEdUMktTQTk2?=
 =?utf-8?B?TmpSMGYxSDVBOU0yTlNwdU5QZEV1VHI2YW9NSEtpUHpEQWxTRTlodXI3RW1Q?=
 =?utf-8?B?Mld3bzBsZUhCQUtBNGVuWDJsQ3BNODY2NEErV0JYZXh4aTk1TDk4R2pWMVFG?=
 =?utf-8?B?MjNtL3VwZlNlY1RCRWdJZCs5TXVoaWc4MFlOWU10aGY5Ulo4KzFvenhGTUNh?=
 =?utf-8?B?OC84RXdvcHlScjhZS29wdGs5dFZVUExsZ0ZjOGh5UUw0QjdyOWJwRmM0aFFz?=
 =?utf-8?B?cHNEY0pqUlZSUFFEbGxYQlNPUEtQcGozZjZtQW0rUWJuRFlZOFAwNzFQeVZB?=
 =?utf-8?B?TzJlbUNtdklkbDMyMnZmY2pCVUR3STVGWHlKM0NINi8rN3JnTk9OUGJwWkZH?=
 =?utf-8?B?Q0hFYUQ1QXdxeldXNUo5eUxmdDhYL1cyNWt3Mk9Pbzcra2NyQ0YyS3RXSUtY?=
 =?utf-8?B?YWRMWXZzSHprY1lQU0F6MUdlUGpLVlJDTEZhZUdMZ0ZoZFJVWGdiNnN3TXdV?=
 =?utf-8?B?ZFFYdlZIZmExd0NDNjErUHQ4UWt6blc5Y05Sc0xHck1qd0xZa2hZYlJFeGt5?=
 =?utf-8?B?T0hGditwWVdHU0FnTTFzUGV6REh2YzZ4NFJkNEdudmNEUG5CdHMzaHZHN3FI?=
 =?utf-8?B?UkZDakdDNGk1QjIrcTJkRjV2dzBNTjhpWlJtT1JFTWpPNnR4bEZHSFgzQTNR?=
 =?utf-8?B?R0lpRW1CUnFNTEM2UnBMZUJPTHYzNHpsbXozbjRCYlEwS3A5elhQVSt5b1hK?=
 =?utf-8?B?MW44Y1YzMnpjdVpNYllzOW5QREd3Z0Z2Q21sbzdNUGxMcVNQWlA4OUdJUG5H?=
 =?utf-8?B?SWptUjNmSkEybmszY2p0WlpHWlpuaVg2OVNBZDdDWnpNY2RBeE13QTJwZDQ2?=
 =?utf-8?B?KzdHR3AwR2MwYUZ2TlpiMUpnaUlIdVFQUGltWXdvZG9abkdKOEc2MGlrYzF5?=
 =?utf-8?B?Qkt6emZRd1QweXdmeEQvYXpmZHVtSzFwenhIalVzL2RWamdWKzRsNU0yK1BC?=
 =?utf-8?B?Z1hMRStXb1g0b1FWS1dFM1hORjVTREMxWjZRS1hnYXpvaU11eGhRSXAzLzB2?=
 =?utf-8?B?dGJHSUtYSDNWUkgyNWhBbVZkcGtpTlRXNzdJeHk3eTRkSStWdlFZTmlGakZ6?=
 =?utf-8?B?TEFQOUlLTXhWb0FpZ2VPRzVQOVVDRlZxekFZM3pYMCtvUlFycVFtYTNMUjZE?=
 =?utf-8?B?VnlNMWNtQjZvdGc0RGZuRW5xOEhnQ3pWZUZJallWYjJaMXEzYjhid1lIaUNr?=
 =?utf-8?B?WlhCblVoTFBGcWNOU3A5QS9wYzJ4NFc3Vmp4VlNRNzFaM2RGWmhkSVZITE4v?=
 =?utf-8?B?R0drUkRseHM3bXNMbzdxT2Z2M25vQUllbWl0b0t2aS9xemFwQVBlQ2tOYStz?=
 =?utf-8?B?VUo3NDNUbXpHc0l0cUt2ZFBQdFpZaXNhU0lYb2kwbndoaHRBcVBOcDJpWWlO?=
 =?utf-8?B?eHNpZ3AwblRJTmhpR201eFFJaFNBa0ZSVFRldTRadFEwbWJDWEg4UGtYTVlt?=
 =?utf-8?B?MkFLMlJHVmNJMytwMmNDN0NNd1EzVHN0Rk9MRENiYUc4TnloM1RaQVZXM3Zm?=
 =?utf-8?B?UHBhK2ZmNW9kcm8vbTYrTER6eERvVXNsMEFOdERlRU5oRjZWbXNnNXR5MHdZ?=
 =?utf-8?B?RUdnR2VhR2tFMHRiSy83UmNib2pCcXM4M0o2a0NCRWtBZHRMV3B5bGQ4NjVo?=
 =?utf-8?B?REgzSFUwZGtBTGtTM1p5K2t2Z3A4c2RoV3h2dGM4N08rWUNtL3dNQ2FhY1NP?=
 =?utf-8?B?U0lidTJDRFRieG5RNThIMUk5M0JwcTJkTG9NVFZJMlZnZ3pYenpKTnhuQkF2?=
 =?utf-8?Q?+sFq0TMG2r17yu8k89QNOmP/t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qUkqVx8hZuAT/eEWWwKFMWNtO8xXPyMW6Viu75mxNA3e4RjRgHPvHwgKQ57++SC3edt4VjSe6rbiG7Ym+C9gr8GQeMpaMRlCtLeRftrN2O8/Sp0t5DRI8XDc8pPOkeGqTjf1hRfIn0wQiOYQ+tXH0b+Pvy6ZurhZ2A3LMFFVkHRe35iLySAwJWsTlpZblyIb5AoSkiEMLGexxkQzeRRdtiCXwz6Lq1xPduETMFIrA16uSTGyeuHNYirwwuF+YO42nTNrTrI/gg7/vU2SY5pzApSRjRO/lrF8EXYCjdNmq+31cy11k+OWsyd1Bs9caaisTPTpW4ZTiH1r2Yb7b53BxhCnQvpIIDs7G0oFO99NQ8Lchf3A/tZjyxn21JKc4x1xg/AMWfITqlMdyujBjHwv+JRTj+nXgdt1uJrFDm+ebIGbwKFmuhasqcwzep8FVDkMoTQMgRYAErvxZzK+U2G0OOLDVSOK/e9DYi7BhsQtH3Q0x+JDknFHf2nU+5wDTuCi19wW4yTvokScAKWhFZoph2CoPWxFuGP8OZTwulNNePY9ghsLU2h12sfyU/nKgabKlVgb7fd4zLRa5iCb83U5RDHd/BRpy7dhUc1DhZNOzbXDfGHFkeOPEbbH76MewUxX3YkDkDM5w/6Kf5OY6xwbopb9TkUqvL8DPAqWQIS+BXxIonuc5i7aMzab92yeOB2tR1WfjQFQieRV5oiET2UUeDe8Hs5Tu02R2P2LJgjaVZ6myHnm1Ir2qSMCdyI+0/sxrrUDBcbzjnegUYmJXwJ4pLvkcH0bPtJvhZQtUqxax9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bade514-8915-468d-654b-08db89a5da43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 04:49:23.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pdCJaqAhq7OH0BgWm0P19CYh1fAu7/TaiQO1nDr6NY4dpESJwQDXEO9mKjrN/Vbj+xQ9boyfgFZMhJXPk1VPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210044
X-Proofpoint-GUID: w4vYVqjIypg69Q96REkzQOI5E_-5ZNz-
X-Proofpoint-ORIG-GUID: w4vYVqjIypg69Q96REkzQOI5E_-5ZNz-
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/7/23 04:10, Eric Levy wrote:
> 
> 
> On Thu, Jul 20 2023 at 01:48:24 PM +0800, Anand Jain 
> <anand.jain@oracle.com> wrote:
>>
>>
>> On 20/07/2023 10:50, Eric Levy wrote:
>>>
>>>
>>> On Thu, Jul 20 2023 at 10:26:57 AM +0800, Anand Jain 
>>> <anand.jain@oracle.com> wrote:
>>>> On 20/07/2023 09:13, Eric Levy wrote:
>>>>> I recently performed a routine update on a Linux Mint system, 
>>>>> version 21.2 (Victoria). The update moved the kernel from 
>>>>> 5.19.0 to 6.2.0. The system includes a non-root mount that is 
>>>>> Btrfs with RAID, which no longer mounts. Error reporting is 
>>>>> rather limited and opaque.
>>>>>
>>>>> I am assuming the file system is healthy from the standpoint of the 
>>>>> old kernel, but I may need help understanding how to make it 
>>>>> viable for the new one.
>>>>>
>>>>> Mounting from the command line prints the following:
>>>>>
>>>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdg, 
>>>>> missing codepage or helper program, or other error.
>>>>>
>>>>> The following is extracted from the boot sequence recorded in the 
>>>>> kernel ring:
>>>>>
>>>>> kernel: BTRFS error: device /dev/sdd belongs to fsid 
>>>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already 
>>>>> mounted
>>>>> kernel: BTRFS error: device /dev/sdf belongs to fsid 
>>>>> c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already 
>>>>> mounted
>>>>> kernel: BTRFS info (device sde): using crc32c (crc32c-intel) 
>>>>> checksum algorithm
>>>>> kernel: BTRFS info (device sde): turning on async discard
>>>>> kernel: BTRFS info (device sde): disk space caching is enabled
>>>>> kernel: BTRFS error (device sde): devid 7 uuid 
>>>>> 2f62547b-067f-433c-bec1-b90e0c8cb75e is missing
>>>>> kernel: BTRFS error (device sde): failed to read the system array: -2
>>>>> kernel: BTRFS error (device sde): open_ctree failed
>>>>> mount[969]: mount: /mnt: wrong fs type, bad option, bad superblock 
>>>>> on /dev/sde, missing codepage or helper program, or other error.
>>>>> systemd[1]: mnt.mount: Mount process exited, code=exited, 
>>>>> status=32/n/a
>>>>
>>>>
>>>> Looks like the fsid is already mounted. Could you please help check?
>>>>
>>>>     cat /proc/self/mounts | grep btrfs
>>>>
>>>> You could try a fresh scan and mount.
>>>>
>>>>     umount  ..
>>>>     btrfs device scan
>>>>     mount ...
>>>>
>>>> If this doesn't help. Can you share the output of:
>>>>
>>>>     btrfs filesystem dump-super /dev/sd[a-g]  <-- basically all devices
>>>>
>>>> Thanks.
>>>
>>>
>>> The unmount command followed by rescan does enable a successful 
>>> mount, but the suggestion that the volume was mounted already had 
>>> not been validated by the dump of the mount table. Based on the 
>>> mount table, the volume appeared as unmounted even before the command.
>>>
>>> Do you have any suggestions for how to resolve why the volume would 
>>> be registered as having been mounted?
>>
>>  As mentioned, dump-super might help.
> 
> 
> After further investigation, I believe the issue is not particularly 
> related to the kernel or the filesystem.
> 
> I believe that systemd is attempting to mount a volume before all of the 
> devices are attached through the iSCSI login process.
> 
> The issue may be outside the scope of Btrfs, but I certainly would 
> appreciate any suggestions.
> 
> How can systemd be forced to wait, before attempting to mount, until all 
> units in the volume, identified by an UUID, have been successfully 
> attached?

  Thanks for narrowing it down. Please check if you have the btrfs 
kernel commit:

    50d281fc434c btrfs: scan device in non-exclusive mode

This commit addresses a bug that was caused by interference from
systemd during the device scan/mount process.
