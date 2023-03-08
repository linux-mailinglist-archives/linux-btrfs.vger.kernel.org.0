Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFF6B0074
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 09:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCHIF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 03:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHIF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 03:05:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DD9AFE5;
        Wed,  8 Mar 2023 00:05:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Jwh2A005074;
        Wed, 8 Mar 2023 08:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zP+cvvOlmpDGb3edFMREKoq5+c0iATh5rND9Uy74Zj0=;
 b=Pb0zuC4gpX4U2ymu3GoogDh1lMWbYdr8RjDFejRvOXUWw2WnFmt7jLT1F02cTvKrFuWm
 GqOV38UfU17osielDHh60p7KAlrGtdwv5cWrjCPz38By6dW3WngpSoFowYdJiQjPhumh
 b79DKk+KJXE9sUykw8kaEA9SPmiZtzGURPzn5EIl4jxDCw4qojmiwlw8K3G0GSEY7wV/
 ACIS8MLfI6Y//4/BrsxpSiKzXch4+9nOil5nafgxTfKqL0g5CUOYjTDcb5u1iPYkRH8m
 Ip0adcY4V04gKVo9WaA8mss9/eTd0vR7lIaWuNTY7gIKxoVcX4sGNRNrrUt3F0z5ReDY iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168qggu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 08:05:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3285aM6N015450;
        Wed, 8 Mar 2023 08:05:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fekx1mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 08:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dywy5fP5YHFsmF65B7Iz/zFujZla+AB3KLkK9cT0uZNYfxijbT5kQri+txrEIqiHIXU2+4+8mKMH/wTPZ1kfzTBiNlmxo/9gc0uu6BKiotR2FM0bbPCIdHzqIzoKkwULMT8iIsBTbLJZ4Gn+eyWMXvLGcHThuoP23hNse+ZkN3CpSDpjMAD11QH0n6u7d7+kV3vSXfYH+hggaSF829Yu4/JFpNWvlETFF9juqR0jwo3V6p7AEsSAHKN47r3+2k3lKVKKlYaHxzT/Umidqy9VcHlm0OZv1TzBsbh3CTreOC5N8F0Bnwu4vhgaUJp1v4dZKDAy+iwhyzKU6luU+v4KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP+cvvOlmpDGb3edFMREKoq5+c0iATh5rND9Uy74Zj0=;
 b=eqUr2a+4JrbsMTMzXYLrRZ5MUbfVL45kiHxzaqcIb6FPyVJvx7kPAMbfe8vnzydL694MeJBcfYvHLqa7sKKF8JVXItgCLH2+4iD8uzZjEVoBM5dSq9jfcQh32Fp8oSmr5Lf/jY5SN9UeHnxQnkgDduAlUDfxTmJXyGzuVece5mQhHFo93AHL7UGsLPk6sbxp46j8xWzban5dm+nd3yRKD7YJRNjJFc1uLEUoduVGIPJSmQMZHUgVmplAf3CxfoV9ym7uT1pzVzmIb9GtsKpLEWw7leE45vwBxjHOmDZdlttYJ1IScxZWZDPDFMtRfHgTQSypEnA/4FKbTUahBDNOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP+cvvOlmpDGb3edFMREKoq5+c0iATh5rND9Uy74Zj0=;
 b=Po9cD/SOHuS6CvRXsBHoA/T84i6zWHJNlGIvCOXyrkMss0/tH9LRFfRQcmn5E6w582u9CCXE5cgnwB61a1U6uW9Rr51TZfMvkNyjbxpI5aKSUt4NXvqD8bD4U8035Ez7pLRClYzSmw9cy9Q0sSiKV/gn+52V/b0HOpTaIgwWhfo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 08:05:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Wed, 8 Mar 2023
 08:05:44 +0000
Message-ID: <675dc048-d823-2c24-51b3-8a10ae1744df@oracle.com>
Date:   Wed, 8 Mar 2023 16:05:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/286: add missing calls to _scratch_dev_pool_put and
 _spare_dev_put
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <1933b829b03a6e489494706792e813b8db693577.1678189056.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1933b829b03a6e489494706792e813b8db693577.1678189056.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 495cbe8c-7df2-4f23-95eb-08db1fabea91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycfDybcIx7gwc6ZRyOv5EUJ60uQ9yazjoSgUEEUf1brk5IyIeOZoDK6zkyc+m89t+I4oTazYO3YW7i/nhcwq5Z3eks9/cEwXksK6qFOXkz0Of+D+ITr+a5D0eNYL8L3quwyiVJXvnKDiU9dXFtvGU53EdJQfkRSp2ORBsvH2FD3ubDK3/STta0CAGPu8MpHrGHsUkTpgiHE0v3zKHm3VOuJWEwSifGqQO/eGXAyYbLJxr+FeQ6FxSyghGzUywbMxpHuiYhX0upkCtCkRZRVvSUlZKZRKnnkW9tEoOywn6cmP7BJDXzkHeKWrDD56XuB6/VaCMjDd67lav0d9s/zWd3xn2Qk5TunrJmpmpXncvwFp0xmHgzD8VOK32QAo8erz2W5eLXs/oIKXyg7AyxfZ/HR/Ki4CFvKAQZp+MowefV+DIFF40sB36lfjCX+C3xFExQwKdxGolvRJ2PdaVL+tWch6uqHhu8J74feirHGADnkksq7iwhHBU0rdJjlr94KQrZCBNU3tYDwQc1J8NoRvfeGTc+JyjrjryTSV2Mq1dcg0pTxbZwacaoWGITcTfHbE72OrQyiyc/4FFWOyRLEz+Ill5anSznqUSCBq2tpSQJ2yDbYQsROZw/R/TwmUb+fj0jkd5o1yQqAiqdhz8/v5Jc9M1InK6Y+aLGFtUtFWFSLbrQP3i9WeBWppWpABZ+dEf1PqgctDAx9O0esyVqcZsALQmvOzrGseF7tP9wbWEaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(5660300002)(66946007)(44832011)(8676002)(66556008)(66476007)(4326008)(8936002)(6486002)(41300700001)(31686004)(6506007)(26005)(6666004)(6512007)(478600001)(186003)(53546011)(2616005)(2906002)(316002)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNzMkNMVmIvY2VPVjhIeW9RWDYvMGdPQk9uNWY4OGhtU29HRnZBWm5DR0F0?=
 =?utf-8?B?ODRpRGFZTUFqay82MEVqMlBoQWltaE5aLzF4TUdaRXVmZ0M1NGxsUWwxVHZP?=
 =?utf-8?B?VkIwYjZmT0R3WURpYS9hZTR4SUpwbndNY3JnWXBBSTNocDdOaWtYOVZkUis0?=
 =?utf-8?B?ckVnNytFbWdhWmxuUENHcDdmeUw5Ujg2K1pxU08vYXdaTWtMQlNjQkorbkgv?=
 =?utf-8?B?MzNSTTRYWUI3SFhFS0VQY203QWhyT3R2UlBxRnBRM2ZzSXNRaUROMTFnZU5P?=
 =?utf-8?B?aFN1RTAvZml3a051c25EQUY4M2FoYkZOTHJCU2x0a1FZb0MyRC8zbTY4K2Fr?=
 =?utf-8?B?bzRiQlovRHQ2ZjZOSkNUbjJCaEdmQ0pwS1JEaWhLSnM1YmY1dHUwaS82WkMx?=
 =?utf-8?B?YWdVTU5ac3B2MndOVEZqYlc1TmZuSWprRUJ6aTRlRWp3VnJ6VGVNT1I4VmRw?=
 =?utf-8?B?NDdsS2p3N1dmNnlPNzJPQlNPNGZ4OGkvaHVRNVFFVFlhcUVHVkduWkZkSWJx?=
 =?utf-8?B?eTdaNEJPam1nQVpYaGQ1OHZlcm9WWUUzaTV3Y3pxL3UvWTcydmgzRzVUV1R1?=
 =?utf-8?B?SG1RZlNacUFCMUlFTkttR2FkK2l0cDZUM00wNnBBcWxFeDFSVTV2azllcnVu?=
 =?utf-8?B?VldVOFUxb2JHREdTbEFFQ0NUTFFKZ0lHRElDYXJsUTNsaTViSzVBNTFFVU1t?=
 =?utf-8?B?VjUxTDJoV3VGSFpjMFhXdEduaWJ1Qm5MeXQwNU1Ra2JxS0JiN2VQZ1c4RkE5?=
 =?utf-8?B?dmV0b3hvTWNsNkJpSWhLajlKM1ROeFNQUStCdU9sSGtRc2Y1QyszNlA3aE1z?=
 =?utf-8?B?VnIvVWRuSmxzK2kwM2dtamovNzIwdzQ2cHpJS0dQVTVjaE01L0NSRE1Ka2dy?=
 =?utf-8?B?OGh5R0JoNkljWU9FTEhucEdtbFozcEJ5SkhiRUlVOFo0M2JQN05VTTBpc1N1?=
 =?utf-8?B?blo1ZklwbE1zREVQaGphTzN1YmVsOFNHSllIOG5UL3J1L1Q5bkJXK0FwQjdF?=
 =?utf-8?B?TFV1a2F3NnVuV05JMXlPdnhUa0RkaW1FeFJ1NGp4Wis3QnlYS1pBN2lqYmpL?=
 =?utf-8?B?RjFuK1hIMWtXcHI1RHBOcWZjcTFXRzFVK0hIREtnYUhOdkx2N2JSR1BZcFlT?=
 =?utf-8?B?RkxQTTBsVjl6WXN3NDFvR3V4L3JMbk4yd08vUDJQQ2RDMHNxNTFpTG1CSGhl?=
 =?utf-8?B?VDhuRmhyVnZhZVpwM09vY2VvdzJweXZjYUFUYmgvcWVMNXFFSkovQmhRcWN3?=
 =?utf-8?B?TG1JSGVPNkpuZjMwUm5INEphdUlMQ1JSeFRvVzJ6c3NSSVNXVm9tKzR1Y280?=
 =?utf-8?B?R042dzlZbldPVEViT01qVyt0S1VFaEt6d05pcEkyQTlCcnZ3ako1SzZKaS9w?=
 =?utf-8?B?c25pQnRnRVBtMFhjT1h2VklkY0lOLzVGYkUySVJsV0I3ZEMzSmYzK2x1ekdI?=
 =?utf-8?B?U2V3SkJvL2JUbVlDWGJrOWJvVDk1ZHo0a0ptUmN6R2lvb081Y1RaMnNBK2dQ?=
 =?utf-8?B?OEk4SjdOdTJlZ1o0d1cvNStJYmFxRmh5NU5VdHd0SXdjSGE3eVpSSXlsYkJT?=
 =?utf-8?B?QUZrRTNJcGhxZ3gvMzN2UXBMVTc5ZmtvMjM2SVdUMXptUjhHOFpOWDZZZ1pt?=
 =?utf-8?B?RmNxVGVBV2Q4Zmo5NmYxdjdGVm9SckZNRDdYRm5GMnYyWEc5bzNWZ1NXaGJR?=
 =?utf-8?B?d0tjTG9tUUpWOEJZSVVrMW1SeHpXS2t4enJ6R0VnVVFuaHhBM2VjWEplemNZ?=
 =?utf-8?B?RUIxaDBZRWpIRFRpdVBYU2NsM2lSUWxxQVRwTG9RSXlWZDVNOHNvQmVKdVVP?=
 =?utf-8?B?dS9GQkZiM00yVlQyTDlFOWJjOWlTeFp6djBjcDYxcWx5ZnBucmNmbHY4NVBj?=
 =?utf-8?B?SmdLODRuUVNaZ1h6K1NGUEdPNmptN1VkZnR0QkFERm56YUkrcjBPK3paeXRP?=
 =?utf-8?B?MzNVUUJrOUp3RW5QSisxcmJsNTc1eGpkcDQxOW0xbWFoYkV2U3gwMFYvbTBr?=
 =?utf-8?B?allGMDZxVjJHWkdXd1kzbnVzZTA5TVBGS1EyaVJBTFNObDQ0ZnRhQnFCUjJC?=
 =?utf-8?B?WTFvTWJTb3VWcEVOWm5WTXNVV0Q5aEx6Y3dCYnpVOENSUGFrUE1hZTRSTDBk?=
 =?utf-8?Q?wwdaZaj6R1BAcTyD7WbnMuT5/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0erf4hu1/D4nTSTXlmJIDTzQAfIK6hwr+ZXQDwfM6HgJYANxtWsPWpH690i0a6vMF5MoHfLzqEr0R0JAwAPD65B3wCjtTbqYMCjMgj9XbcBlpItNhlfnGSfiem7WjJuVvsSm748fcsVapOGEjQ/H8unfXGZm69mCDgHL1Wxe72rOYAHEmDTqLXKNWz/db22WIKNFON/deS3knK3ZfRrLZF2tOIrvlZF6e8+dCYb7f/36dlPAb6Wj6Dh88vK0T4+e4DSNKy783Yb8+zmPKznXL1ygTh1DiZSKibpVtl+PdAG3uiXqUsTL9QSerk7wj7Hz+8uaEcPLkBPcJo9RjJ+7N2dO5q1Uvp0Qs3K0VLUSlDnWBvJoIRpOMxBIwowFcBJ13ilnMPVM7wz6sBIs53oxjQMkkifQTe7+WGPuXI1LmEq69meVPsVMUYIxO0dPr7A5eluNCEoC8SEFv8gmF5ENRnWsRo+eoMu86eaEw+3t+8Z68bFTitC5WMYlC8CdI72OcJB106OtXSPdS52hh28IOKbX8ITf5mDfUzVDhH6wVkb6xRldo5+M82siISQrICwnZ7IJgsIcpwPYJmIkwYZwwQqhZYdH8orNykB6VDgEAtvdH8G9xQbA494uOAnvMFeQ2PLJwmxT0piBgqRl14gPZOHi1ux098rN2U4SJoytHK93t6L3AlfeZrg4r/a8Qut1JUowIXGKcitTwiSYgwPyIrOuz/c4ZmXlNRZxo2NewOAWpRXZl/Ut5xJEorEQ6YwhvHLMJanVCqML8PVHfHh8qZJJtBp2sN9s7zDI8laSH+N8AsAuxXpELZC67GdQEeiW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495cbe8c-7df2-4f23-95eb-08db1fabea91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 08:05:44.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUWFu5rhmAvMaQlqguJwN82H2vnusX4XAVLkzajubC1rvLPWP6uabQdC3vJijpTBp23TOrdUWC7g+feBVkEqLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080068
X-Proofpoint-GUID: rRehoL34Qtk28jICjYxSRxc4YewYLzTn
X-Proofpoint-ORIG-GUID: rRehoL34Qtk28jICjYxSRxc4YewYLzTn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2023 19:38, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is doing a _scratch_dev_pool_get, which shrinks the list of
> devices in SCRATCH_DEV_POOL, but it's not calling _scratch_dev_pool_put
> before it finishes. This will result in subsequent tests (none at the
> moment however) getting a reduced list of devices in SCRATCH_DEV_POOL.
> 
> The same goes for the spare device, the test calls _spare_dev_get but
> it never calls _spare_dev_put.
> 
> So add the missing calls.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/286 | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/btrfs/286 b/tests/btrfs/286
> index fb805256..f1ee129c 100755
> --- a/tests/btrfs/286
> +++ b/tests/btrfs/286
> @@ -71,6 +71,9 @@ for t in "${_btrfs_profile_configs[@]}"; do
>   	workload "$t"
>   done
>   
> +_spare_dev_put
> +_scratch_dev_pool_put
> +
>   echo "Silence is golden"
>   
>   # success, all done

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
