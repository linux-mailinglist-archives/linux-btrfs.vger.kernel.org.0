Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1974309E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjF2Wc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 18:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjF2Wcn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 18:32:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB63A90
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 15:31:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ4JMr031782;
        Thu, 29 Jun 2023 22:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5pBuJASGPw5JPPO6RoEFVvXAXwtibuvrWwmt2+35e6w=;
 b=2Y6AIzF6a4uF14yp3WXXmixub9mlmEwpf9hgoIdc7tQsFrgOUEMA1TFyu5x6nIs1ftvC
 gdmFW0xX/i28ndt/Iww9GZVViEUieEdczIQQNkSNxFXzHEmfjMrHQc7WoP5S8OPyXGZP
 VrAf8K4M7NkIf9TYgxI72E0ceXABKfvAlcf0ECi0aXgfCXwddg9Z83X9jpDJpQzlJvRJ
 tgKnxjOtJIC7IIqnNg120iEwTUe61Y3CN+x9rwNg46dUR5wuIuewxVBg3Pq5VRa3If9/
 FUgKuRgC95FIVz5H07jMaaWw7QDwAJQEB07NJWzgQoCg4BMoEQsEBVqPXeXFnYAamYpX 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtxdnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:31:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TMGIMp013082;
        Thu, 29 Jun 2023 22:31:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx88rfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 22:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lynKxykUmTma4S4QCSH7kaA1Eg0AQtTRfxDT4prNvB4QBcVumv3CAaPODVTBMBesWObl12nREegntM2T0Q99a3KtKf7KXZgNcDrWYWcCSGz+8wphd4WBHyXKI/PKG4rgvZjRZOIyqDefaTnUg5ENqpB0gi5D2AGlNZAURW1vUZaSfhcmysPtDAQlQZPIPcRwpfuyCq4djlYcezSssksJgXsVbbROgsH0ULCMToXe2V964wLjkiqnImumkXwMdNFsMS6dYU7j/t/f2MGkDVxxgLopnzTFjCklboi3cfRGFyAdnWYKm5gaKaNj7WLSxUzVieXwk5GIExrVDj7GIC3GRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pBuJASGPw5JPPO6RoEFVvXAXwtibuvrWwmt2+35e6w=;
 b=SzxBjsdAQmvSn4PRPF5iULNQ/1dtQVdEV6RINOd1gjh+wrwhFK2Yd5M2mk7HYuwU2fWKYE34guTyxJEB3jBwgiB97EWaNtjF9edXzGDKPRUnptOkggiGZTJ0juwA1RYEnd9SAbHj0pXUMBd2a3DqLGqMTPjPLfdY+Xhe10f7Oa81t4R4MUR5n0SiGE62v535YuFSzifCDnDjH3tqaj5vHNa24fyFVpfkmCXqHgqqekTqg29ASGex3jHW/Dd//35iCv+uHogOF50wDPxSH8s1BhkF9l2pdf8EuKKh1OP7G2Q1/FvgCigwc+pHdLGZNpdbBeeKApwgKQ1eA5wFjJqB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pBuJASGPw5JPPO6RoEFVvXAXwtibuvrWwmt2+35e6w=;
 b=UBVOL1tK+5kD2dqW4uKqPTCIjbCAno8qeZwq3j1wqS8i9/bDzDh2noIEZlr/lGDcL4CJdr/QcOrThpXH+SlI71bbbZp7HFYBzjzIfA6gYhqOTe2EfSvJzna3M9Ct5qd7bRZkGjoT/Gu9v9sS6yEj6F8X6vc4/rkeW5Y3yJCjjzo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6388.namprd10.prod.outlook.com (2603:10b6:510:1c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 22:31:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 22:31:16 +0000
Message-ID: <101cdf7f-771f-4f07-df49-2a2d2ad4bd80@oracle.com>
Date:   Fri, 30 Jun 2023 06:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: sysfs: display ACL support
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
 <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
 <20230629164123.GS16168@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230629164123.GS16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: f779807c-0b62-44d4-525b-08db78f08d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5fQI0O4I7+Ch63WHMPIUa1Ik6RUqboy/rLXKyiG/u1V+tLuiBjMrYfcbWT2GwsOGTpJ9zsdBYqfTJvnJCALTg+vA/JqCtLpdo4cCtBN6KKhQUKfQvu7HzTBBxyhiKjDVeoeFPzQUvf/chdAPu0d/qZDLs7VPkLzYo6AysFXWQ6rgXCyxOwsckH09/uJFLcLnvlw9n809QuVoCEP4OgXN0lwqh8LN02yxPAmtOPmMm6s6lswi6/ExW0OuV3G7AuC3LgHmLaVkymGE/awZ+Dl8DXAiw8LO7WdrDN/h9hGY5KpewZQzE6j7gMsPl866YZbVifDemJMRW5VW2LZ5grN/Br0fM5ie0bNNM8+t5CRVdaSCGpIM8Fb8r3XL93JyFMwetvw1AqeIZpu2xFYm8l9DG/Fmmp2vlFYmvvTAzQxxamPexm35RKy2eCNVnYxMGyL3/CpR49CXBkkd4oxKFw2B2MfE6DAJDK/ZPktQUq2whINBK17UdB11zP2tK0bEreZQ5g6AOK2JMcDYAoLwUYy9T9MafWdDUyb95sKM3ZtRpiHJzS+1/qFETl45vso20x0YZid11WAHecj7OmOslG1/oCCHqAgQhN41l65k5CE+I/LBsgmrYBfZ3+QqPXBN7gdUshiEKmzHggmzhmovK74Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(2616005)(5660300002)(8676002)(8936002)(44832011)(66476007)(6916009)(4326008)(66556008)(66946007)(41300700001)(316002)(36756003)(38100700002)(31696002)(2906002)(86362001)(83380400001)(31686004)(6666004)(53546011)(6506007)(6486002)(186003)(26005)(6512007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFWY1B6RXBjUUlpRytmNEJUZWdRMUgrVkliTEtMRmI3Y1NMMVF0Y2ljcjl1?=
 =?utf-8?B?UmY5VDE1Zkp6LzNkZTB1Mm9oNWhNQnJPd3V1UXYxS3B3Y0t5bmNmRGRENHpy?=
 =?utf-8?B?em5tMFlmWWxRM1ZnYzFpWWVDZ05LWjVFMUgvaEd3U3ZXZWl4VDNGRXhnNXA0?=
 =?utf-8?B?ZkFRdzkrWExOT2hURE44M2pGRkpnc3J3MjFORkIza0E4dVdXQytNbWFMUk91?=
 =?utf-8?B?bGlGbnhYcnJXRzBpd21rZ3g3WVZkY0lDQWFHeUQ5WloySE56dWwxYnIxR0tl?=
 =?utf-8?B?U1hZbnJ6Y3dYamtDeWttcVVCYmxhZmhqTFpzQzE3RzFPN3h4bjdBNXNoemds?=
 =?utf-8?B?VEhkTWxRUkk2aDVhL1ZjdWJCVEljQWdaQXNwQU1BUlM2ZkpYSHRxS2pXM2dB?=
 =?utf-8?B?TWJXT1JrN1crL3NLU1R1V0RmVjZvWVpPZ0JjU1RNQTZZeEZNUU5DWTdLa25q?=
 =?utf-8?B?SkJtOFh6UUdDbXBSbUVMYk8yazVVZ2dncDQ1WTlXVlN3WHIvY1k1a3JKRCt1?=
 =?utf-8?B?OTlnMG5RenJ1K3NWWXZTcDdjRWc5QmpZVDk5TDFJcExVT0lwN0JCMm0rNU0v?=
 =?utf-8?B?YStaa3VKdTQzeERudmdlUWIweStESWNsU0JMSnFFbTcwVW04cnBvTHdvRjhy?=
 =?utf-8?B?R3NFL09aR0Q1WDJqTVg2TWk4a2JTTUt0SlhmUTFjc2lRWFlpS0p4TXhzQlhW?=
 =?utf-8?B?OGt6REl0SmxNUU9waUZEeTdXalBHRWM4eGhqQ1VBY2dnTU80YzA3TTVhRDRZ?=
 =?utf-8?B?KzhRSHdsUmF0RGNibzhaeEtyN0dWTk9Rd0U5SW1UQmtyL2JIc1k2Y3lDWHZM?=
 =?utf-8?B?ZjV3WFZOV2RsQitCZE9BUXkxTStFQk0zTHcyRjk0TUlvRk5wcTRlWlViQi9j?=
 =?utf-8?B?MFhxV1FFcGIraFZuR0tyZWhmK0hPa3dLdkNGbHZMdjF6dEtwU1VsaXhjUVRU?=
 =?utf-8?B?NHBYT244Y1JJcXB6cDRQclNPaXl6SWU3VmVXdUF4U3JOZ0p3aDc5cjFiVjlz?=
 =?utf-8?B?cUNhakxpNHhWL3V1UVQxcHRvb1hBcDNHOVBKNC9GRGovSDRHSDE3Y3RsN1RJ?=
 =?utf-8?B?MGlvbGI4NElzWlJGcGUwbXFTQjlDYk1EVjM5OEV5T2NKZjhTVGpodnZMekND?=
 =?utf-8?B?MEZsdUlTbzRBK1h2TUpuenY5WDhGckpZa0xLSXJyY0IwYkxBa0xKTnlMRHFJ?=
 =?utf-8?B?MzN1bk5IeHFBb29uQU56enJvZ3VEeWF4U0RqMUZPcC9nZG5weHBibVV2Z1RU?=
 =?utf-8?B?YVVJWWJJRE81NGc4RjhqK2RGWTkrZGFPNjJiVWlSOUp3dE1mUVVNSnNham1L?=
 =?utf-8?B?bnMxaGpyYkJBRWhpWVlVQ3I5RmZacjAxdWtVSUF4TTRoc3JnenkzMm1lQk9O?=
 =?utf-8?B?QkhscTRYUDR3aWw2NFRkUEFPT1E4cEpYUFh3MDdqS2cwclRUemtDR1RYajV0?=
 =?utf-8?B?N0dTTmdEeGQyMVBicStiNFBtb3h5cGkwU1lXcDlvVWZFcmhUKzdRbDBQR2tk?=
 =?utf-8?B?T0VzcmpCOHpIN0xJcTF3SFlldE5FRVhORjNlWmI2dWdUWVlWUDQ2cDFQYk00?=
 =?utf-8?B?RXkxN012SWFtNGMxMzFRRDQ4QUZRVEFzcUQvWXQyWStMVStkNVc2S2FPT2Zv?=
 =?utf-8?B?LzFnNVNuSEVySjltODArL3lFOWhUbEZJbFpHNERrbmJNTGlaZUdMNHVaVFNv?=
 =?utf-8?B?aWN6eTR1SHpZMW1UTzhVem5OOEVhVVJlYlc5ZDRJaUxTS3VLZGhFRERoS1E4?=
 =?utf-8?B?OUlPZjQwS0xSSlFZSWZ1VHA4bFBsdFliRU5wSW9udUVxQndHS054ckdRZlE0?=
 =?utf-8?B?T1pENVFweDQvRGpGcm5pOWVtekc4TXN5TXdzbjVnQTZ0TUUzYzhNaXA5anJq?=
 =?utf-8?B?a2NaYmVSV2NvMjZJeFFpL0pvYlFHTjVpV2I0ampFV1ZCMmI1dXkxb1g0QU00?=
 =?utf-8?B?TVlMaXpHenVUSXJEdG5ydFdNV2YyeUliVHFVNUMwcUthNDBnbHo5YlhCOFI5?=
 =?utf-8?B?NHpRSDk1VVYvYVFQVzd3ZUVBWWgyWFdmOEw5dmIreUtRNVNWZnV2TVFFT3gy?=
 =?utf-8?B?TC9FMmRqdVRlMlJYUy9sMmx4Qkl0eC9oM08vTUdvVURwWEtKTzN4UFVhSXRv?=
 =?utf-8?Q?/2xU+vvc7ad1aQOc5pO+Mhx5q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pr30YRrVst1JNX9LItZy4CE3zsD+VorpIkkRhnBS6h8anGKpcpvqVO7jm1E5ZbC5TSsAvMgnF8+oBwy5MAJzJOcMeJ5Qm0pjCyALerreElMN+nllu7UxiwcoeQE+hNvhMIlVkyCF2mnuLJxg2dHg0FqbcCT04PQlrsv128GvCC8JpiqKxsoMXBvz+mO9jtKlRSGlpn4vStz6xmnlMa7HICruzi/nWFxZEuE00eMB3xx63MUwPR7W+evyuww6kSZfHpcca4111rd+EWzuwBm34XyUwWyWUn/7Tr2EJHYqEoa1kOUjpFDTMrksNE3PRqCqKY+6XmdMqMWCsHgxyjv11gGXWFvGTMpFChNaOJuBFiI8iyeD5X9clq5PJMJEh0feSDMN1HqanI9NqheIGAGMX1bduxmtXJ8BY7WLlMBInXopUqDcxoF2pXY2NuzjmstOcNyRrUMzEZP6NBDY86/64z3yXGM6401j3hZ1s4aQsjVwJsllpuadX8XmHvTH1wLB5AoRN0XskoffXUnKf0IWT1vKhNp/R3K3NHmdZJldszjl0o74h+ug7ZlPyhZ0+afF6MXY/MWxIgLL/aMzFhMFvLFJ6M8gTPgOVHo0+ILHEa2WcoJ9Xxn92UFPTmAaeVhl1+f2o5yg3uywi+A+i/EEImfRJu6/kvKBqncrqm1aLGnyGOGsqcG6fpeyONAb55z/TAKosjSFTsR1wE2BegBZ/v1YV9/vk5KaS6vWlmPNoY56JcvUY/1nTTmsjj42rkalUpc0nC51191nB8HlSr/OAXvtnA8IUneMtBTOBtqoKm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f779807c-0b62-44d4-525b-08db78f08d4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 22:31:16.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nz1rdZFEohqTxEHurGPZYKkdkgyRALrEv4mzvjiZCa/Ur479Z/yAXXdxs6kGRf2Z+4UDxpB26XDCGNvEKVrDvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290204
X-Proofpoint-GUID: 1ngJ30ccefLc7lr_uvSFRaroyijElY0R
X-Proofpoint-ORIG-GUID: 1ngJ30ccefLc7lr_uvSFRaroyijElY0R
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/06/2023 00:41, David Sterba wrote:
> On Tue, Jun 20, 2023 at 04:55:09PM +0800, Anand Jain wrote:
>> ACL support is dependent on the compile-time configuration option
>> CONFIG_BTRFS_FS_POSIX_ACL. Prior to mounting a btrfs filesystem, it is not
>> possible to determine whether ACL support has been compiled in. To address
>> this, add a sysfs interface, /sys/fs/btrfs/features/acl, and check for ACL
>> support in the system's btrfs.
>>
>>    To determine ACL support:
>>
>>    Return 0 indicates ACL is not supported:
>>      $ cat /sys/fs/btrfs/features/acl
>>      0
>>
>>    Return 1 indicates ACL is supported:
>>      $ cat /sys/fs/btrfs/features/acl
>>      1
>>
>> IMO, this is a better approach, so that we also know if kernel is older.
>>
>>    On an older kernel
>>      $ ls /sys/fs/btrfs/features/acl
>>      ls: cannot access '/sys/fs/btrfs/features/acl': No such file or directory
>>
>>      mount a btrfs filesystem
>>      $ cat /proc/self/mounts | grep btrfs | grep -q noacl
>>      $ echo $?
>>      0
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Added to misc-next, thanks.
> 
>> ---
>>   fs/btrfs/sysfs.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 25294e624851..25b311bb47ac 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -414,6 +414,21 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>>   BTRFS_ATTR(static_feature, supported_sectorsizes,
>>   	   supported_sectorsizes_show);
>>   
>> +static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a,
>> +			char *buf)
>> +{
>> +	ssize_t ret = 0;
> 
> The simple callback can return directly sysfs_emit_at without the return
> variable. Updated.
> 

Changes in mics-next look good and much cooler.


>> +
>> +#ifdef CONFIG_BTRFS_FS_POSIX_ACL
>> +	ret += sysfs_emit_at(buf, ret, "%d\n", 1);
>> +#else
>> +	ret += sysfs_emit_at(buf, ret, "%d\n", 0);
>> +#endif
>> +
>> +	return ret;
>> +}
>> +BTRFS_ATTR(static_feature, acl, acl_show);
>> +
>>   /*
>>    * Features which only depend on kernel version.
>>    *
>> @@ -426,6 +441,7 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
>>   	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>>   	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
>>   	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
>> +	BTRFS_ATTR_PTR(static_feature, acl),
> 
> Please keep the features sorted alphabetically, moved to the beginning
> of the list.

  Ah. Got it.

Thanks Anand

>>   	NULL
>>   };
