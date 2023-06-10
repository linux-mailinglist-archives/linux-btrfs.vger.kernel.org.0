Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90B972AA0D
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jun 2023 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFJH4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jun 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFJH4b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jun 2023 03:56:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E96C9F;
        Sat, 10 Jun 2023 00:56:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A697qj012118;
        Sat, 10 Jun 2023 07:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iKG3xD4QeHEv8cfQk1yUx1pskZAcbLqopDipY1mVD1o=;
 b=aCr8RlRb+30/b5QAMl9695mgBKWCSBpR+f1RqWYE2hztsg+YTG//kHLQfICCmX5Hhweg
 ZQEyiz/oY2Sv2Dmz8f3hbSpCLDu/mjKyX9pHz9SLgRLyaDISG5LQC0WNWefVh5ArUrmf
 fAk3boNPx2GpdzM0Bw7frI7m+aoU2KkLdp1WLhEkLKVLXHZTZtd16qtuhxrY7yygGBMm
 NSqdEXAggolHAFAR2mqwqS1zW43tpUNay3uWB0DjFRYONJWvalf1/OGQQ6SpVDWHbPJk
 Rug9fnpR7/AGIbCLWNmngNhwmqlguyR9zuSuUfKxWJVmKh7QSuGCsJRbMytj1QM+QCxE 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy389mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 07:56:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35A6DSJL008366;
        Sat, 10 Jun 2023 07:56:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm7drwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 07:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvSSWLKcaZGeRf/T+HvigdV8zDqL82Tmwpo27PDBpyZmZPfykV9JScndM15BkMQCFsI40mqviHbW2O7+l/z2wLYguPTkuB4alxBXl1tOtBcQyzJVbkIW6kZBFJAXOp39zPHulfG8mql12wLn7xLxUOeH40Eh4qBdA2GxwjC/9MwzCXLVDWF+FnUDxkqskd3HYtYnRXF1Y7Q9qvXIgxHR/gDrHJi+3XG3t+h3P7ynt0GcTDudmA85cIrrSKL7UnzotFgHijZGM1+hUKXxAdDfNBvHi7vNghPpKgu6P+As17Qum6nbX84PjLWcBiN65kQHnpisR3tsPwnjhnzFC/olmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKG3xD4QeHEv8cfQk1yUx1pskZAcbLqopDipY1mVD1o=;
 b=ng8UzChUzfxTN/tFuI/9gykidK6vaAWgbItkX8e2+a1RQ3rxgpjEwhTdHrSsHwAhCVWxlm62lzNJ7vGcFjPEQItoU2Iwe3eqyaE/dPMV49Y1xUF4ONDep7Om1uk+BTCw6F2InuvJS+EjLSjb61mvlFQOobl3+jQC/oMbA9Op8bAZpVuGcrQMxaepNtMjJ8qB/Eax2tYVSxZPYfLfIWoj2bKud8X8TqsPUy8rrGblj+AG4gbzJHhqYgsT03ZbB2SKRSdz0t4Z/Bl4Ox9V2mH6F/0TLV2v2CPv2pDtFkvWq1B7llQcTPtJ29Q5uYqXcvWKWYR8YVlIVKS5U1ag3s9+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKG3xD4QeHEv8cfQk1yUx1pskZAcbLqopDipY1mVD1o=;
 b=zjdUdvj4hAVpmFlL0ErpFp2e0LCTNd3B7T6WWSYL73hFlYz8xJwglvtmngzenL9i3pBwxEQMpbhRR672gj9H87JNrcXgqlQcZokHRKVxWdNic0FsgpeldSsKky6QOMO4URmRuQeKWXgYwfD6kLs7jxIJgRSLNtE10PpBQZf84P4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sat, 10 Jun
 2023 07:56:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 07:56:24 +0000
Message-ID: <d68c00c2-09f2-6ff4-8553-0487d8a1a951@oracle.com>
Date:   Sat, 10 Jun 2023 15:56:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] btrfs/122: fix nodesize option in mfks.btrfs
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
 <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
 <20230610070309.kslef76hvdxi56xd@zlang-mailbox>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230610070309.kslef76hvdxi56xd@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: f014e194-cc41-4caa-4e3a-08db69882f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0S8ov6N06mY0qpMVw8MJ6fBLSHBNDOtwIWJAhCp+gUxrWcxKJAbflSecQmkZrHPwEOU5p0dtts0lPd9zkgiab+KthWi2rPPXEv+ViRhzFwGB7sCqKSIUTEW1hZqHT8JdT3zKg8jUI5zqji6xpE+R4X+UBs3Stri+jkRBSYqH+2xbRH+cKOq/KxPO7GqEV1S2xjohLFowdCF9rd46ulq2ASSAcrxb6XuGJuGwH1qT1Um1NSCsEnzX04AeEJFX01YoFO7fvb5UEXri7foIrLtBWIQxMjWi5bCIzVg8rekevbFRJlaAxRMHK6Wv2m7yUX45GztmuAtj5Tld1LRvkuMX8iY7AMp/fOxCMKd90f1nAJexp1TcsyK5xVA6fLAwMbyLsMrVZezCThbUDO5CC+GgbHQxXgHcOa50Sz6k3gfTH15LOWjMal1scwja//zJzlnWlIPg7Fa4uPraPkbnPM3fHdwz+SXPzvCdZgJOzRTcZCbCJaCuXkUokxAjV/oVYCiF+iYNGE8fX9aqvN6DeGbnRtkSsmnPGLiAirOSPyiSBaBPmj3+p8oeCjR92VNe4uR1TexyzuEHkPTLh0KdZvIf2pVJB+6rS8oH/p/nA+ki2/LTwLTSzRBM08bvAIh90tVhsnGKDx5IJbuKvc6Qb847Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(478600001)(6666004)(66556008)(66946007)(4326008)(6916009)(36756003)(31696002)(66476007)(38100700002)(86362001)(316002)(6486002)(2906002)(41300700001)(8936002)(186003)(31686004)(2616005)(8676002)(53546011)(6506007)(6512007)(44832011)(83380400001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NjcnhyRnE1aFh4MXlCNUlhVnQ1OGs3cXd1RnZjSXUwaGY5Tjl2VlhUaDRr?=
 =?utf-8?B?QjJxWE5NNXNhVnVaQW9WTlVrMkhwaUdkb1NrRGxxM0RwMmV6NVZkTUlYU0o1?=
 =?utf-8?B?SmtMWXBrRjdSYnhwNVJ3eTFoU253ZUhNS1dOekhrV2xXTDQrWVo2b0h3NXZa?=
 =?utf-8?B?Y2NLUWJYSkppSmNHeEZOOWtOY2pMMVcxVE9iS3h4YU82L2Y0clB6QklzYXNB?=
 =?utf-8?B?ZUdPZGszMkhVMUxwbGVXeHp5aFpmcHZ3MTZsV3pmV0dVNnlMdG55aXN6SHBi?=
 =?utf-8?B?MndxQml5c2FZeC9KbERLTWNwek0zdXUzSWhmQk90bkx0dVRCaHVaQXpRTW5U?=
 =?utf-8?B?eUtaZk9RbUZQem1TdnBvYmk2WDlESk1lQ0dZZ1U4TVY0YmFwa0kwWlZhNUN3?=
 =?utf-8?B?d2NUdmNJVXdNZlY0emFQOXB3SEV4ZHhkTUp6MWVBTlFCNW1xdlU5ZmtuN3RG?=
 =?utf-8?B?alZFbVVuWHR0ektDaS9pUzgyeWVFdXU0U1pnL1pWVTNjc3I2WDVmVVhTc01s?=
 =?utf-8?B?U21zbE1OTUNNK2x1b0VKY2p6YUNQLzgxa0FIeFZmWE1zdFFJRnJuOU5oUloz?=
 =?utf-8?B?TWhHKzJRbm10amRuN281NFFlUWlZeTRzN1BoOUhnM3UzWEw5TXFkVi91VHo1?=
 =?utf-8?B?V2R3T1VTSXFuc0FhdkE4T3ZEWDVyd3BhVGJTZERNSmJFYnAwUEVveFUvei9h?=
 =?utf-8?B?bkZDTWg5eU1WMnhNUXRUTHNTWHRHVkFXQ1RRdUlKZ25oN3gyU2ZpdEMzWEFx?=
 =?utf-8?B?MXd3TmdGb2ZPdUF1VnBtVVJneDJNcldKRmNSeTlpVEFyck93Kyt3cFVETE1s?=
 =?utf-8?B?WWwyOXNPM0xJZ3A5YnRtN0VqY0hYT1RKNC9zR0VXWDhOZWk5WTQzb0dQdlN5?=
 =?utf-8?B?Skh4eEw3K3JJNjVoK2Y0TnZ5UzhwL0dSYnYvc3p3SC83QU42MzJlekplZzlK?=
 =?utf-8?B?RTdmL3FLdlpjamdCelRTL1dBS0dWWm5kQVF6YVl2TkdKU0FnVHM4b3k4QUhr?=
 =?utf-8?B?UkFzYnJLN0pwY0VEMEREb1NLa2NlUWRkVDhTTkNnZk15cEgza0gwUS9kaWlo?=
 =?utf-8?B?T2FkamlId0Q4c2xJa0Y4dldodERRWTV4MjM4K0V1b3hQUG8xemV6T0hYQ1NI?=
 =?utf-8?B?Q1ErajJ5YW05Y0V2Ym9GZ2hVTkJTd2ZUM0tTZ2p2Rmd3S2RnTGoyaG5jRFcr?=
 =?utf-8?B?eHdhbGFGQURSUE1VNFYyOGNITnFIQW4vWFphL0NrM2ZIRGlaUFg2RmNhanpZ?=
 =?utf-8?B?Sjh0Ly9oZmdEZ1pLL1RjV2xxa1BwdkVBbDNTb0RWaXdaTHVZL1kvL3dUYU8y?=
 =?utf-8?B?S0JxU1g0emdZa095MlNZNGtHVHlVR3QrS1hXN0hwWDFydGltOGtleDNJU2dR?=
 =?utf-8?B?aDNMQkpzU216Y2tLeE5DcDZRck5jbmhEalN2ZFRwbXpCZnlnK0hzQ243dnRY?=
 =?utf-8?B?TkIwUU53cU9mcGp5YjFSbGtkWEY4dXpaV2ZManhKQklhYmFVL1dKanZBRGJT?=
 =?utf-8?B?WjUvVFJDV3ExV3lIYW8zWVF3Q25WQ0tQVmlxUmdQNk0zUGZINXVkOEdhT3Bz?=
 =?utf-8?B?ZW1rZ2NMbjdnTGlpTWVCcFB1QnJvV1Fab0dQR3pyYzdIR0JUNm8rcmhQQXFK?=
 =?utf-8?B?Z3FmYk1jSVhFdG1Zam9aZnhHT0xkVUF5Qi83NDJTWnV5MkhZZnMyV2xWVlNF?=
 =?utf-8?B?dkRjMFVQYnh5NG9HSmxtYTAwamNUalk4QitNNy9pOXRGVGVFNml4d2wwYk1P?=
 =?utf-8?B?YWM3WStmbXdjem1KVEFjMDVHLzJGNFpaSG9wVWdSQzVGSzJGK1h3YmhKbkdN?=
 =?utf-8?B?MDJaMEh5TExCZC80OWVybmZRdzhuaVdzZ0R5T3FleGJTREc1bzFMUjVSd1B0?=
 =?utf-8?B?eDJ6YlRDM3orRU9wVXdha2w1RmttU3JKYXJsUGluUGZqaEt5d2JvS1h6MTFo?=
 =?utf-8?B?U3UzeWQwSXUxMUZwUExBdm1vT0d4UnBmWjVnV2o3Z0E0N3FhUWJKM0tIMVBB?=
 =?utf-8?B?ZTB5MExxa24zaEtpRDZMUmluL2ZneTlkQzZnL0VucHJ0MnhqSEMwOTQzemVo?=
 =?utf-8?B?d0ZlYVJpcHNqZkVqa3UwRWV6OWJQTFNzMFpkN3VoWG1obG45WTF4QzA3SE9o?=
 =?utf-8?Q?RXuJV/x/3F/5VMK264bvf/xoN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xe/CzGHlZRDahlqoZuwlQmKq+Y3TbphHmRPklPUHUISD5D6z0CIEV7Xk7qfBu2yAECGIrlgYk/GZIJgr+CLC4K2KJ0RM1+ASPD8B9iqx7JYB32YDHXjjAVJkmYJEGJBlvXutZ+WOMroA4aIjcSPrI7idqRcYg5H9+ZhnbmBfhqccR0ARb/sYW/9d7cmkwcl8docejbs12bSk0nsyul92pLFrNFMNv7e5WomYpVr/JoLKQNn10FSOXHjEBRjkoeaE15+ZP4wO11iDmy1Gf1/KyW6GRKBaXrJZ40NQE/L4eUJIkOwX6cfnm3dVqNcwpQ1QqMMIgECXFGO0z2xxED2Xp6GrabO+mR5a7UvhPNOdRLvyqwVgqOXIulK4y8jzMdaCiNlbYTChlA9J+9pEy64XI5n//s5oWclJzZ9rHUjzYzNPrsuHmv5r+ki5fY+gBbFyGQI8ZJvqD3puqc66oNZRCTDdLLZSbR7+aa5B8BIQmzgQAIp1Oqf3RGm0FhsC8TFLK010ZMQsJ0TtOhFLz0GVAvDPk32zLLplqjm6jQznt00vZUviTjgods5PB9L5aeZXMJKtpXyLcQX/tSCjNCEbjkFjUfTQVg4IwnHJJ4GZm7dcjYl33d69Ygtk6b5Akz/hgWf2P4oV2X/ttW6XJw7w+wpmFCIZWhgtLkXLgWB2JNBK010iX+zZTr5BEVs8hLVn/4Ua/uKmVbJQsDPx1K2nrw5yHkc06sxcHuubXYv+sLbzv7rWu21tTLMyCZbAzyNu1Jz7WXX2U4YC4ptq/a3uULH6WcKtjxn2zYxFdwpMa2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f014e194-cc41-4caa-4e3a-08db69882f43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 07:56:23.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCODP5XklKA8attD/MO07idqGdjzkg5r5/Q2csTpqx+Kh4++2TtyY4TcKQPU2ub5tgmojjBdUBfY8KXfRRvPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306100065
X-Proofpoint-GUID: zBKcOOFo_ZDDB0YXL1HjyNGUebL31ANX
X-Proofpoint-ORIG-GUID: zBKcOOFo_ZDDB0YXL1HjyNGUebL31ANX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/06/2023 15:03, Zorro Lang wrote:
> On Fri, Jun 02, 2023 at 07:38:54PM +0800, Anand Jain wrote:
>> btrf/122 is failing on a system with 64k page size:
>>
>>       QA output created by 122
>>      +ERROR: illegal nodesize 16384 (smaller than 65536)
>>      +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>>      +mount /dev/vdb2 /mnt/scratch failed
>>      +(see /xfstests-dev/results//btrfs/122.full for details)
>>
>> Mkfs.btrfs sets the default node size to 16K when the sector size is less
>> than 16K, and it matches the sector size when it's greater than 16K.
>> So, there's no need to explicitly set it.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Remove the redundant explicit nodesize option from mkfs.btrfs.
>>      Changed: Title from "btrfs/122: adjust nodesize to match pagesize"
>>      
>>
>>   tests/btrfs/122 | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tests/btrfs/122 b/tests/btrfs/122
>> index 345317536f40..9d5e9efccec7 100755
>> --- a/tests/btrfs/122
>> +++ b/tests/btrfs/122
>> @@ -18,9 +18,7 @@ _supported_fs btrfs
>>   _require_scratch
>>   _require_btrfs_qgroup_report
>>   
>> -# Force a small leaf size to make it easier to blow out our root
>> -# subvolume tree
>> -_scratch_mkfs "--nodesize 16384" >/dev/null
>> +_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
> 
> Oh, generally we don't check the return status of default _scratch_mkfs, except
> there're specific arguments for _scratch_mkfs. Or we need to add "_fail" to each
> mkfs lines. So I'd like to remove that "_fail" when I merge it.

  Ah. Ok that should be fine.

Thanks, Anand

> 
> Thanks,
> Zorro
> 
>>   _scratch_mount
>>   _run_btrfs_util_prog quota enable $SCRATCH_MNT
>>   
>> -- 
>> 2.38.1
>>
> 
