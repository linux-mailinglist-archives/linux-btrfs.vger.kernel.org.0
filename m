Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AEE7A2AF7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Sep 2023 01:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjIOX0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 19:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjIOXZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 19:25:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA11FE0;
        Fri, 15 Sep 2023 16:25:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLuCgw028215;
        Fri, 15 Sep 2023 23:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uCjh3TaLiVL7z3WQBpl/oQDs8BUGZuy2JkaaDYlL80U=;
 b=xm0EABXsfrwzeVrKryThvKPY4WTFkbFF+Cz2RsAsS97z/4nMu8bU/BdTnGGypFvLX0/l
 dJNtV8BGFQwvxRmEf93wFC1OMAiJy5XtiP+BAtlHwAt7focM/T11BgYp4lju7OlOhw+3
 Gy3Xmo004bKy2YXIvVaJQctw6qvRb8VsvVSJ+qPXDR6x/Alw9yKy2WbOAg9f94vMd3pI
 eYGCngP5vcPdpKUlpDkgaHqAvFqBpPxmn+B8yA+iGUxFHCKeHXSYu1ojkJASL6uNRuI9
 QzaKBa6vD/9XWAT/QlkDYmL/VWuIKPsRTkoXuuiNnMidOKAT+H9B/KmZ0Lu3d8C28S35 +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9m0qu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 23:25:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLAOXm003067;
        Fri, 15 Sep 2023 23:25:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5aq1j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 23:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6LLW4r9GnZ1uxoBxuyQ3g6dciOyHa4kJKyAD2xZOTDvza5mhJXhxf1XmWEos2bPGXx6nOzaNrB5ZkNF3hhAsw1cUkXOlyFqhXy0N0uswywyzGI4BxePXljQiCD/l/n9YM+gbz8ttOgl7FNzmDM79duoc8zIXXJXL4bLppmBRPabW0p/QZ2djBMUg+XhjdPDlyvwgf6M4GiW6Ni04pVmbRLiduHchm0G16AAFd0uqfP61bri+7z2Izx3TtbOsDrsSKG68mfMZWB+a9Q+aIG4eiZYisD2kOw07CaWlrspW+fjXleKkrbMjCygQYk1m37JQOBEKnrhkTFIcK2/aBE3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCjh3TaLiVL7z3WQBpl/oQDs8BUGZuy2JkaaDYlL80U=;
 b=U7ZMYl1DwSYjmbIXhy64rlK483hXffjgbcMKoQKzbFsfYrT1R1LZWfnXice9HiZhEQ+TUoeurdgYE177MfDWOwqrnY2Lb/mImMPYFmTdEGUZa5YRtbUzCEL4705jMNw9kdLI1elT9WJ+C5cw8QVyw7ygYUWsZLeloucUafi8ATdFJX//f1V5e8AKLp+lYZGobY/bKXp6DnwB/lcL3oOZj9gl1ec3LXxGUdR8a8i5g7UWTZSQvbn3cypY4HhBSQKHzYTRjpCNI4T6Mp+FQDMZiBu4ZkPu4hwTQVxIpE9yRNLA3GlpLpeYSQ55qP33fEHK4qaQNmDaYmY5YpK5Cf0eMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCjh3TaLiVL7z3WQBpl/oQDs8BUGZuy2JkaaDYlL80U=;
 b=mS2QfDE9bEfbjWoX5p3fDm6rhkqvEoUor9AgQyM5K9C5i11+pUvgMajiDzpkrbtXz1VG5RjUOh3QrGCZtG8ZXK9/3uj+Tv+PX8jpd+H3orTdZc/bO7P0yf8JBvFqKOKMjLtYwKXlolKwV/HbyWRHdo74gAqmcpQ04Ru83ABgNG8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 23:25:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 23:25:14 +0000
Message-ID: <0ab7fabb-a59e-df61-7a16-44457df2992a@oracle.com>
Date:   Sat, 16 Sep 2023 07:25:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] btrfs: Add test for the temp-fsid feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, dsterba@suse.cz, kernel@gpiccoli.net,
        kernel-dev@igalia.com
References: <20230913224545.3940971-1-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230913224545.3940971-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a047291-2019-41e6-0e0f-08dbb6430374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVGb4miI73bWQjV1eC6aD3CwtvxRunssOH2tRRWx7QRiyZgubFJ4p/u5jms1CqGctOgu4IwGu/B+WoN7K0zZpR0B+9KF0Zv18FIgvPf/hDeKhR1YDvwOMkcVS0tn/2eBNwSxqcFzyjNkjXaThrCR4g4uk8Bzgif7MMKwzidigeJyGApPoXOK6oHCO9fJeKZGsUi4SMYYNTkJEoZAJc8bqIBdd8JmetCPw/SoSUrYMcmKGzhoo9aSRCNxqio/z56En22b+OeQFNyD4PnnoolJxSVqsXqN0ZAYi4qRj6rS5VREO1qlOvkg7/ScTHUNIR7yxHvY0bDLgYwe6YE1OvTZYJeg9+f80nGWcpg+vn6XB2U2Hkk+zQA4P3aHJ7xgLmK76jYf+dr33X4lT8JF6oHXIYoeOH6oHO4Sn8OWn2TRohiDwBejfB3qd1DxN+rFef7G5cv1PdLP4nmZX7/KghWMwUgQM4KHntBJYu1btmOgNMC2shbvvrAIXWSmit3rPkrhjHkRvjgS80Qibo1xnTEbG/ZfEr6Pz4zgAFbNEfEm3e/NkAmEY8u1hRS4kirH3dhqIT2vb/w4/tSAGG6k1RR2fEDsUZ6MTcTq59FNL7w4VVXzDVyPGf5mqNj7yIWP2QsYfyXzDK6TezwvZfRKFwiUrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(478600001)(2616005)(31686004)(6512007)(53546011)(6506007)(6486002)(6666004)(38100700002)(41300700001)(316002)(2906002)(4744005)(8936002)(4326008)(8676002)(66946007)(66556008)(66476007)(86362001)(31696002)(44832011)(26005)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnA1eUpwbjRqamxockVIUmxIcCs3VDZlQXFGK2o0Y2xiSmRjQ1NhT01jRC9y?=
 =?utf-8?B?OGZybThBK2xVNEU1SWFlTlJ5N1EzWjB5QlNXNUZub2JpVEtON1BlbksvcDd5?=
 =?utf-8?B?UFpNRThOdkc2UWtLTVNNcXdVR21VNnc0QVN6b1dOa1ZBclZ6WjMzOXVKdzd1?=
 =?utf-8?B?c1o3dlhFZkRIVjR2dkV3aUNhS1dacjRZMVR6TU90ZmlVdEEyR3p2T20vZGt2?=
 =?utf-8?B?cks4NFZaKzNqeDNmM1FRMnYzSmxaMUVXd2IvMVlydUYzVXNpWE5hMzdtS3A4?=
 =?utf-8?B?QS85THFwK3Y3Zk9LQzRFUmNxYS85TEpja3V5Z3hyR2hiMHByQlh3NFJkNG8z?=
 =?utf-8?B?SFpJaEZ6eVBNUE13OUpRNHRKN0Y1dTNqM3ZzV0I5dXNaMDl3Mm0xdmZoaDR0?=
 =?utf-8?B?MkpFaHg3VS9NOWllZUxNRndqcUNzYUlJS0hBRmg0Q3U3M3FUT2NRc1NMbkhZ?=
 =?utf-8?B?aFBpZjRJQmlpT3NvdnhORmJnQU0ybEJ5SUJneDZic21hQWhDak5UdG5pS1BC?=
 =?utf-8?B?OXhsL2dBRUc5blFZd2pIbWIrbE0xOWtGd0U4SkJoWEVZbDk2d1RTckEyMGUv?=
 =?utf-8?B?b1gyRFgvT0tRZ2pacmhRZXNyS1FHcTcySjVRM2EwMzZpaEJENmlVd0xpYy9T?=
 =?utf-8?B?WEdxOFNGemJLTmJEdHE5T2ZVMS93Tk4xbllpUTRSb0xwRXRYeU9vdm5FU0xF?=
 =?utf-8?B?MHo5Y1VSYjFOSE5nMEwzdFNXRll6SGlKUTl3Rmt5dTI0Q2tqM21qUjlSQ0J2?=
 =?utf-8?B?KzFSbU5vM09UeUIrQnBQV2VQTFIzWm1wY25RQVF2VkZBS3o0SjNwKzluODdQ?=
 =?utf-8?B?WXVMZGNqL3QyL2ZOSVgvSUsvcFZXQjBaNVcxVnlUN2FFSXk2Q3o4aXRNUVBa?=
 =?utf-8?B?YW9YR3hXaWp6dnpvZXRWV2NMVk9QNnZEOFkvRVlxYXZZYnZkZHZvRllVZEx0?=
 =?utf-8?B?dW11bVJmMWtSclQvWU5Wc1c5TXpCL3dDRW1rSVp6L3pmNmkraVNURFRwWVB4?=
 =?utf-8?B?b3VHRGltU1ZESkNWd0FrZ1pNbzhtV29GSDYwckVNazdBK3BtNGtvUytuZmI1?=
 =?utf-8?B?Tk1mSmluQStDQVlUMUdYYzhvL0VQSnQ4RUJ1akxISkc1UXFtWHkwV09PQ2hX?=
 =?utf-8?B?YXNaTWF4b0o4bWNGcENlSHFDSWw2TUI3dVdnVndJOTQ3a0E0a0pXUXErQUkw?=
 =?utf-8?B?M21neVd6L1BNN3QvNHB4Z3kwcVlYYnF4dzRZWTIrV3FVOWs5OWhNZm9ETW51?=
 =?utf-8?B?OXlBL01BZXVIMXV3dDEvL1c3bkQwb2FYY1ZuUEh5VEVLWEZnMUp3K1hGS0pz?=
 =?utf-8?B?eVFRWnZhRkg2Zm9IYUNpUlBxUWFWeUIzQ0hWUndWUGhReER1RFdiZ1cyTXpZ?=
 =?utf-8?B?ME9zM2lLY2RSVTluZEh3ay92dWQwdUwzS2NzOHJOM2lUQXNLOGQzT2ZpNG5w?=
 =?utf-8?B?WXBURFFGajVOSVBhczk0OWg5aStzWC9xdkxLSTF5dGFtbE1zMnVsN0p5R3ln?=
 =?utf-8?B?OEdiODFFVEZXaFlJT3pBQlBacnQwY2RrT2xTeHlKVkZpZzdDRHQ5Sk8ra1ZM?=
 =?utf-8?B?V1pkeGJyYVh2Q3F2MVNZTkVnSm5EWnNIamRtcU9menVPQllRR3VFU2NpRWU3?=
 =?utf-8?B?UHVBZWlMcktBY3JZczJhSGZoWWpobEgwV3RZRDd0anp2UWZ4MVlRQ3dHQ2xG?=
 =?utf-8?B?ZVFEZ1R5MmdXSzcwUDNjaWhZdGd5QUI5dUdGUXAxbi9uM3pQZUROWWhIQTB3?=
 =?utf-8?B?UTM2am1OTjBwcFd4dndhbFhCRjFYWG1iUnhJUXA3UlZ1U1RkeG1KbUM5VjVG?=
 =?utf-8?B?SktpdGNWcW85UDJQWnZlc3lrQ2Q1SjBQZEVyMWgxRWp6NnVMTFgrZHl0Vzcv?=
 =?utf-8?B?dm1iVC9wQ2NTR3Y5SnE2aE9oLzU1NHJLcTZRVGZFbWJ3TlNuRnNVSDM0dTdK?=
 =?utf-8?B?aFpFd29VR3NwZ2QrbXd0YjNnNHp5ZHJLR3FEWlVVYXIrQWtyalA1VnBqRmdt?=
 =?utf-8?B?czgxTGN1TE1Od2tNdjJ1ZjlzV0FaOHBIY3NIZmhOMjVVTVpUVTQ3MW1TU1Vu?=
 =?utf-8?B?WkRmR1pydWZ4VG9PbFhTeEJEd3NtUWtNQU1HV3lJWXRHcGlsVGFaUVQwclBU?=
 =?utf-8?Q?toL1SW8G4vHOOELciaYPPYr5z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lU6/MwzKDbimLJIoZ60EpeeMaea8KopbH62CLGE3e5/at7aEt7ADME8wnSBFD5S1bq/aAz2nNI1absLYegJdWVKHeWo7cxRRUUew09MV0SWYPPVS9d0JpJEiluW37qPQr1pJ5KqnwPYXaiEyB2QGNmQNh6FFw8BUwiUBjL+DGFwISJxNh5gFwdITTYAgLi7a8PK/eXObES4Ih1n02oh/FHJK6VP2FgNrPK3mfO0ewDshn86uwnIzRZ+MT2P2MU/gkg/6PmLniZOvBpWsj7s3gaajBt7CpVNsszWo52NmCO1mJ+fIY/5K08TQnIbhi2HgyNUYJU1fm/ssQIbPGzMUyAg5UWbktl9g1/awrOQUHrxikR1U8//xhRrw+EZlGIERDECnl2bGjsGjUu1TQV5D1LFu3eqK6SRve9FfEk9TpWR1wazui2DIQeSkU2xCqHdGA/gFjHq/4FK3c5OqiK62oSNfU2251mhJ7TZvctt/eOA/Gp2zusUYUOOYhgNOFHUKUP7MRg7LNF8uCvV4SctjS3Oyio7SJzT5dkELfVi8kssrrNUOXXmU3cvJlTmISuwZH5pe7Ao9Lf9Wx18A3BRn7vnE4oPIcGu+CDfk131iRdtkUiXnOv6UNMg865pcKLAo3/KCqs21ODivK6jwMVKxYj/zrtkXavVof2vTpF/oP3yuHsqBxbHTVoD/XooFoK1su4SdmUDSYfdz6/Ss6AFUhUJC9pYTnuxQjy9PNxyq/MSK0OLopNbrOBL+bWjsvsm8VAFtN74o0k2mBu2SGD+r8cLF7L8IdMnL/hMTLuBO9wbMWa01ZT1jSZ9V4z5nmlJXp9+5JCCMnaxsKosK0ddeJTbSuDwLP40AEaewCYvbryXEvy2tgAlzW0ULdhCQmavZz+yBFb1IVfFUi9eETT+6q5e+DwId4q9ud7WPDPappDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a047291-2019-41e6-0e0f-08dbb6430374
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 23:25:14.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0nOxkMn7TY5vCLzfEV1Hulbtne7McoGlMIYHIrZwrwdj45jaQGq6LRmyO+InF+nqwR9CqS0TOkvYNGLpihHyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150210
X-Proofpoint-GUID: 9-E57LWzgjwQgbYvhnB5LfiRdfqM1Ewp
X-Proofpoint-ORIG-GUID: 9-E57LWzgjwQgbYvhnB5LfiRdfqM1Ewp
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2023 06:44, Guilherme G. Piccoli wrote:
> The TEMP_FSID btrfs feature allows to mount the same filesystem
> multiple times, at the same time. This is the fstests counter-part,
> which checks both mkfs/btrfstune (by mounting the FS twice), and
> also unsupported scenarios, like device replace / remove.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

This test case's integration will be timed alongside the kernel.

Running this test case on older kernel/progs without the feature under
test must terminate the test case with _notrun(). I find that part is
missing here.

> +_scratch_dev_pool_put 1

_scratch_dev_pool_put

takes no argument.

Thanks, Anand
