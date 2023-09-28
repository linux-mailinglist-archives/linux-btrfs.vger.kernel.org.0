Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835D97B1D5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjI1NHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjI1NHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F2CDA;
        Thu, 28 Sep 2023 06:07:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8qLQ9003927;
        Thu, 28 Sep 2023 13:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8QOosNlZOri7WaOwF8xymhos9TlDg4Il37mh7zV46Ik=;
 b=r6K3j/s/9KIgjcEgm7SdpxcexVOwyexjcC6iQ3kuKwPID+rjsIUthIkXqKpKVj5rGd59
 mt0ymdKzn/EKDbTGx09T9C4ZHA67wAWHt94tWBdzYlDBPI4wCveqJsqkh+598c2E4m+Z
 6XO/c0pabWpE4ceqXJ7MZkJH/NDInlNA8EcGcHq9FMBCmhHYlvC92cwmqT2Ke6SwfO6v
 d5XpxA7j7A3nQuO5Tis9cPGIH0XPyM+CYZsQxbn27cNwcs9OBgpq2yA8cdjMf2OntE5N
 RgYEMp7y8f3OISxeYK1L3XsOJWRpLz5C7qmg8tx7pmjBQnMnZkuiMDdiijLv8ELFSY8S rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbmb4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:07:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCNmli013315;
        Thu, 28 Sep 2023 13:07:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pffm9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 13:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm/3KYq1FG2dRMLC7fIckQw8sZ6rRI/Ju10rBYxhQDFVMzyR9zyDYUWfPavQVt3cDaOvHzGe0/zxLb9KEntVEOqmrpxP1xTf7GGZ5lZ+FnUMgT4GBzIWEVQEktqPuqzC7KpA7fEEsNT8poPPTZ234B/uvCDTH53P/WODxhCQYte+KrVqEBCB0jLkn4XvDpSeOFZ/tq/tuvXhgdCcgUEErmKb33oCt6X1CiAmjalzSWq2idu5TyinR06mETr3keOiaq1thCd9e1III4IyZ7ANkJyxFVdBuJdlp7+8ddn5OhJ97Sc3HlmsgaaUtHfYkDADOKPfvaknl25um/AcBpR2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QOosNlZOri7WaOwF8xymhos9TlDg4Il37mh7zV46Ik=;
 b=FvXc4M3AzFKQC3gVpl1odXxuU89MQkMRptMo2inyr1E5M60ntbURREyI17AXLBxmSxzDRRlmXGi/4omomePx4OXm6IrAzaPQVBK2FSl+a614CC2/uQ9GT4Gf5i+U4zbVzs7JkWf85OOCnhCvyyZH0UyRZc9L9E3CWqFFGbEQtVewzmMx/blRWytvI9IPZagZ23v4SZSa2Q4tSpPvP7qkJKSvR8FD1W/uswFmAkV/euOZp4hwsEZk3DUqiStn1CdbX4Bz7ThD0uGnvGcxZrwUEOCvjZZOHxr0eJNsYSXvy/yZBHD44PENYOP0ZDWCLd9OLYHTf1vpwzr05hSjJojcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QOosNlZOri7WaOwF8xymhos9TlDg4Il37mh7zV46Ik=;
 b=ijkF5eevsbuBZq3TlX6aivOylEPOeKmJ6EqsrrmJHYJKRT+7A2yHMfgRFc2GtfnCVLNF4s4XPCkoJzpAh0XfH+8XmM2cDvxwISA9YO9dXrXvTjP673DR+wcUconNsDTYiJJSywFTo+b7T7UMrwpx+R1NXck8SF0i283ZhFm1NKI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 13:07:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 13:07:29 +0000
Message-ID: <f508bbbc-41d0-5505-89f7-51665f884dc9@oracle.com>
Date:   Thu, 28 Sep 2023 21:07:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/6] btrfs: quota mode helpers
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695856385.git.boris@bur.io>
 <3c6f4cd053ccd2deb8ee459f5b0e5eb6fd877487.1695856385.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3c6f4cd053ccd2deb8ee459f5b0e5eb6fd877487.1695856385.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fb7745-5b1e-491d-26e2-08dbc023de32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqtK8gV3iDC3NrWwSIynf50kqyNWpq7/coEaaZ6AwL7M2tmEXsr1ik64F9507p0EqLJ33XPfv1o/nunO0gpj3l6dhtEREmFnj4TiYHZPnrf8o5LkawPHkTfhk6e6aRZBhOu+9AMOOkjWuBUeiA74TIL3GVivfMXKjILgU2R9T+uGJMR8dGPlsnDFghllVFw7ee4IVc+2zQ4xgYnKgYX2guoIzLcP8TJcjFUvrzdGMyHECO3xcDV0D+jxtEGxdo5+LhL+yWd02HCKi8+SVYYtIJm+E1ywEMy/qJEmkbsmCcC8gDawZehabVWHLc+1WK/4465jmSMYvq7AoOrCVSyvhTByC1PD7SZL4Rj/lLI6INO3cZ23gPut56Ui8r0r3ZvEshbCHkjKN6yNjSJgMbY9XTs16vydtP4LV/iwd7KyONSuS79BD/4YOQ/TL1I0nzORi8FPXZPwOAz/BwxEaZXloQPaz64W7OA7wAC2hskoe8+lXMCTtdwymu23ymJ7tzuPKkEjm28Wzce5rZ0VxcD2VDzECuTMA+znFMzbSFFv+AOLDTTq8LLKVM4tzBq5g5wQYWvMQEObfXQMiwpdsLcbO1yywsYu25QuOQO6XvYRgb20qDltcDYz7aIBmAmREs9xs0d7MH9lLAFiwRmJVH5AGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(6506007)(6486002)(53546011)(26005)(2616005)(44832011)(5660300002)(8676002)(8936002)(86362001)(31696002)(15650500001)(2906002)(36756003)(316002)(41300700001)(66476007)(66556008)(66946007)(38100700002)(6666004)(478600001)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkx0WkNOYXBJaGZtR1FmZ1ArNXk5SEs5QWxCeHNKb1AvWnoyNTkwSmdPYmYz?=
 =?utf-8?B?M2lZaUdHQ3VHT2ROd244NlJLc1hBRFZEa1V3Y1h5bmk1M2YraXU5TFduSlFO?=
 =?utf-8?B?T2owSXFVTkNNUWwxSjNyUCt6RGhQUFJjNFc3cm5qeGhhb20xOEtSaWhTRmEv?=
 =?utf-8?B?MTV2YlB2WFRxbTBpOWJNZDhxdmRqR0o4L2RldENoNGxKV2tSR21VQkY5bWpu?=
 =?utf-8?B?RGlaSzJJZ0RuekNTenRZWXB2emJmQU5ybmhXQVpFNUdWeGNrUkZUcUhJM2xF?=
 =?utf-8?B?YUVRQUN3OGs1enJ4M1cwSVQxT0o4VFM3b2RhV2VSa0kwOEwwNlViak5PNkcy?=
 =?utf-8?B?M3BnaURLdzI5bm5JUkkyc2NaQ3UrdGRLdkpzN3ZUbFUyYm9FaU1KbXh3RGJr?=
 =?utf-8?B?Tlk4QlpjQ0FkU29CUzh2R252VlhFTWFpd3ZGcThxNk5NNlh1VmVCc3Zib0g0?=
 =?utf-8?B?NzJHV3F5TlZFazFWVnVuWmZjS0JVcVBjaG5ub3FTZCtYV1FpaVJyc2c1VFpQ?=
 =?utf-8?B?T2gvT2VUVUlEQzl5RUVrZEJqUXZQNWhFTFR0S2RhR1JDUU9LSmUybkMrOEI1?=
 =?utf-8?B?RTh2TXc5VzdXM1BJc2diK1BzTUtJT1hOYjRTV1lnWnV6UDhmV1J3UGlad1Zk?=
 =?utf-8?B?MXpDNk5zcGJDNEV4V3FLTXd1eEI4WGZ1SVlTbXVUdi9tdXZ4QjBRQy9yNzAr?=
 =?utf-8?B?UUcrRmhxbFp1aXN6L21QUXJjemlCRjNhaWduakRLTFdiT2lOVkc1d0xVdWhT?=
 =?utf-8?B?VGk5SVZReUcxSEpUaUlWY3oya0ZGNHJUV0hZQ1ZzTmF6TFFpdkJtY1BvaDlN?=
 =?utf-8?B?cm5xZm5KczFidWpPd0hQSnMwOEhrblZDTk80SjUvcXptVWI3SW44aXVwR29N?=
 =?utf-8?B?WEh1RlU1Nng1cUJXUk1SVUlvbW9IZ1NSdElrZWZZaEt4S2pMeDlvMURxTVBT?=
 =?utf-8?B?bXZYQWp5RWJYeWZxYjh1WXJKQzNiN0xnOGpmRyt6NElrRy9qaHZPS2F1VEt5?=
 =?utf-8?B?aXBiM2ZZcUNyMm1DZ1dnZTNkUUU2V21sa1cvVERmbGt0ejFLNGNWd0EwWmsr?=
 =?utf-8?B?SGpaOHczV1dROUJlRjMycVlZUFNKTnEzM1UwUjJHdGJlblgrd2Y2U2pLVEVI?=
 =?utf-8?B?N2UyVlFSMEZMdngzMVhMdW9jNEx4ZGRhcGdDS1B5R3JYR3p4WllEbFRVRmkw?=
 =?utf-8?B?NXA4Q1YveElTakdqU09OOGVDZEw3NnJPSnJPK0JQSjg1QndXb0xXNmJjRlM3?=
 =?utf-8?B?aXRmNVBmTXl1bTM0elN2eGVpSVBEcVdweTR1eStld2ZYVXN4ZWFCQ1VzZnBB?=
 =?utf-8?B?YUlxcnVlU1Q3QlQwOTRSU2orZ3hCZlM1R2xDZ2sxNUltNWJIcFZPc2ZoVkJl?=
 =?utf-8?B?c2pXaStzTkpwUjJRZUtoSmRlV1FkeEhYZzJlT2s4Q1RtR2NDcEUvTU1WdWRP?=
 =?utf-8?B?WlJpOWFGOXRzTWVLdUtNUFN0UEkwc3BlSTdZdHZqWmx6d2tNc1hMWVJUR0Ux?=
 =?utf-8?B?R0RZRkY1RU5WeU51L2ROS0l2dWdvZlV5bFhXUG1UVzdmWjNVd1BRV1N1clpa?=
 =?utf-8?B?RHJDYjBpZm1PVng2bEVMWEkyV0xPSmwxR21aNlN6UWdOWW5lKzdDZ0kxMkdK?=
 =?utf-8?B?NEhlUmppM2lSYU05L21DWEt3V1BzaTdaOXVKSy9iYlN5MTRwWUVpRXArc0Zx?=
 =?utf-8?B?MXBoL2U3Yi9iaWdMbzhVaE9pcTQwZjRVY1FTR3ZFaTJoMWkwTmhnbUsray82?=
 =?utf-8?B?enJ3Nlpndk5jRitnSW5lYlpQUnJSV1U1aW5xZ043RFpTNWVaekZSV1VkMElp?=
 =?utf-8?B?ekNycjBwOHpQZ1pUWjhsSFRpc0hpbnErckZITjZjTGVKTFVFR1VXcitTNnRk?=
 =?utf-8?B?U0QwZWZUbjhJbXRUcG5hejNDVy9LK1R5d0ZDSzBLbVVBU0xoK1FkNXVWSHg2?=
 =?utf-8?B?SFNyNVpjTnhiRjc3VnJjWjBOeERqT0xMUVRHMWNuY3hmYnpZUTdrZ2ZSMWpK?=
 =?utf-8?B?Z1Q4UE1HK3hMUHgvVXZDSHFDZEJqemcwaVdJSEpFd24vSklBakZVZkU1V09Q?=
 =?utf-8?B?Q2MvaUFyUS8rY1l1ampCYTI4TnhpODJndW1hdmZpa3RZUEtwYlpQM2ZzUTZm?=
 =?utf-8?B?R09SYnFtZ1NzME13c1VLYUU1UkdQSDhneFkyVS81VFRYZkNhMFJwcWxzb3M1?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1XRn5KkZcJz7noVRP/gJ9UsBadIGTOfRW0lzVSZfo1jpVw9LrEqF5aDo7WngFmlWKeL/s5xw3hCbDZmQQTKdLqHdhcdrv4UuEzdepi01triibZvkIYmMVjkeI1KLh1oYlY2/KmMqLwiCKGML8qnN5d04OM8UJSSbjQNhBYB30YkZ2s4YW9u6roCbOzYPfE6WMGlSYRTDzbAFKJFgE2ZzzMi09nqFjmguDxrZA6mxHFPXAS/ilyQJ+6Y7XjUrOMuEa/nbwxkP9oZJLX0Z3FphosDQdIR5Pj0SoS9IeBbGXYa/YcUZW8OEVqquYmVIvQQoxAoOye8xDITlNR7av4coUvPmokEnZtie9RZnmhJk0K48mNkh7NY+dXaP3mlf+U+Nfld9z9rmnyZB1TwIbs5/j9wKIXjaefQUtWQzE8P0TthKFacFrePItl2HwCCNFBXmj3TyUIYaLa50+Htq+8c6bVANVGF3Q74DiqHDqTs+0dfZoaGbOk6nEGuTt9ZrfCUPKlC0+J7vvjRCIZhU4Ux3hc1hqX13BzXCdl8LqTQG5s7r84JD90L36ZdcYp+4yVubbODVrb9ZzqphJfppDW9jMpr50one2Zpi4NsgRHsRy488wGK8W65L6zYdMFk+KjPqb/Q6RzWx+YFJiNCnl4llzSvYhZwOzLDF4w8rjhUpa7OoEvz+6crqc94V6gNvU2s8k2ghDwrneCEXBsBBiByMqnMKx+jwreDNBr9F6Hf172h4RUHT0WObQHpXkj0KkAs9qJT60wvD3NpU7u4+I6kiz/kmhiV1GaopHQVnyaFoE+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb7745-5b1e-491d-26e2-08dbc023de32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:07:29.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c7/7qztDFKd3glU90d6ZBISEln3x8d6QdL2fMs0zIHjqsNMARDfOdMA9CclXSqbC2Mo/1eSgsDxJ+5RveR3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_12,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280112
X-Proofpoint-GUID: dCLlhguBBOWc4AV-_xspSIif6mf32ZZy
X-Proofpoint-ORIG-GUID: dCLlhguBBOWc4AV-_xspSIif6mf32ZZy
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2023 07:14, Boris Burkov wrote:
> To facilitate skipping tests depending on the qgroup mode after mkfs,
> add support for figuring out the mode. This cannot just rely on the new
> sysfs file, since it might not be present on older kernels.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   common/btrfs | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index c9903a413..37796cc6e 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -689,3 +689,41 @@ _require_btrfs_scratch_logical_resolve_v2()
>   	fi
>   	_scratch_unmount
>   }
> +
> +_qgroup_mode()
> +{
> +	local dev=$1
> +
> +	if [ ! -b "$dev" ]; then
> +		_fail "Usage: _qgroup_mode <mounted_device>"
> +	fi
> +
> +	if _has_fs_sysfs_attr $dev /qgroups/mode; then
> +		_get_fs_sysfs_attr $dev qgroups/mode
> +	else
> +		echo "disabled"
> +	fi
> +}
> +
> +_check_regular_qgroup()
> +{
> +	_qgroup_mode "$@" | grep -q 'qgroup'
> +}
> +
> +_require_scratch_qgroup()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	_check_regular_qgroup $SCRATCH_DEV || _notrun "not running normal qgroups"
> +	_scratch_unmount
> +}
> +


> +_require_scratch_enable_simple_quota()
> +{
> +    _scratch_mkfs >>$seqres.full 2>&1
> +    _scratch_mount
> +	_qgroup_mode $SCRATCH_DEV | grep 'squota' && _notrun "cannot enable simple quota; on by default"
> +    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT || _notrun "simple quotas not available"
> +	_scratch_unmount
> +}

The rest of the patches look good so far. However, the indentation is 
mixed above; lines have a combination of spaces and tabs. Please help 
fix it if you are resending the whole series, or else I will fix it 
while merging.

Thanks, Anand

