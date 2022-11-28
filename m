Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3063A0C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 06:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiK1Fd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 00:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiK1FdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 00:33:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD365DD
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 21:33:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS56xsj021332;
        Mon, 28 Nov 2022 05:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jv1LDj87WKM/Pdg2N6YIAbSPauVPThYGQHdE9n9s1oU=;
 b=XKs7TZXlcf71JMELuMQgCZ1XUjJvqLftE4+rvErLLPHWIwcYhM4HQ3quGbWUwnN8wEeq
 oHXbnnUnew0LuXLAa4MGehsllUSePBkVLPOwP5JKnJgZanGX436QoK2B3sa8km5zdG2f
 4/fTbFEx02uN/qwaOVuCH7CuJOtjRctg4Wi3ngm/ZyIMYNg/241x4euLyFZXrS78HOhu
 9R6zAtD68lTKMFmyMdHLggDeT/kTiEcNDkjsgSFFhb+AdMRyTM2vIgpnT2boh2EKywPI
 U2HbT2REasjqqUU4U+Aet2aifsFJiflVCfjB1Q9l6HF5chsgMYKqourENQPUuJg2waMg jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt2ahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 05:33:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AS2T1qf010232;
        Mon, 28 Nov 2022 05:33:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2e7hr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 05:33:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvwmrLtmDjdAE7/RT6NdPwpyfDK4pL+UmypSBG3ru5aLthsJiOTr0HrGpP7RFH1XCodGxoOko/BzdokG7vAFF+9yarpGAMKmTcZ85iMDDF0uSdBsuoI8JqVVpJA1N8EZGqO5pq9EgEFgB6uK+Q8UmnSCJjw4IdXDAtN/UkkFT1rgaX0q2tNtNSSvu3Ox/f3QYGTiEgSqrdYoP5cDMLUfB9GVpgtMHwP3FJH1FGZ4MNpincb5+MJGFwLFvO/l2cNhtKMf6G1CwkFG+Dl11CYIvm6lf0+B1fZeMYQ3CMOymqCWxnSutJGNZJhYtg4jXPnXggf0DesXGYQu6PESVaIcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv1LDj87WKM/Pdg2N6YIAbSPauVPThYGQHdE9n9s1oU=;
 b=k1RmU7ISs6oZ8IVojPQOr6ZELa+y1EQQznYaTBZ6kcxFRUkVaPX3cUXSwpGRFokl7e9+2xeYRiQgNDdBVBPvdMzEskq5/EHniiE+9RhSkoZfclKMA+8pK+3TWZbBoGk3xAwZq7lkwbX284QlGA9n0x2YN8zwnvcIFz4SMQ6sLOymHoviegVTekxrbNBVpPk55mRSiZF8Tk60xx1KRzWb2ak+kAIZFV1wYZVTkoLc86qyK35nHJaO8A6kkqRqoovkl4nHQoWiTUrCpbJnI1ffnICuCYWcQF3oR2pwwrwZQywWsoWALKWRsFbxysV4hfby1REUenfl5AsUccPPFecyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv1LDj87WKM/Pdg2N6YIAbSPauVPThYGQHdE9n9s1oU=;
 b=TeRLYGq8XErqrczndjOLoftl53iU6bznIrF8T7sl+wIpSlLbAGualvEkvw3ARjAosIpiOZn425mgkxsY39KtFdznxaezTSSXAFhooCeedEf5Ji6j2Tc8i4K90TKvgChA2671Ay3IYDagOgBkDfcBcLPwDxvp5RRnypEcG6yjA2Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6247.namprd10.prod.outlook.com (2603:10b6:8:d1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.22; Mon, 28 Nov 2022 05:33:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 05:33:08 +0000
Message-ID: <819ec0d2-34ae-4070-833e-c7c1686f7ef3@oracle.com>
Date:   Mon, 28 Nov 2022 11:02:58 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3 02/29] btrfs-progs: fix make clean to clean convert
 properly
To:     linux-btrfs@vger.kernel.org
References: <cover.1669242804.git.josef@toxicpanda.com>
 <fee273e52a96c2eaa4783573b20544901c83993e.1669242804.git.josef@toxicpanda.com>
Cc:     kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <fee273e52a96c2eaa4783573b20544901c83993e.1669242804.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 83590d65-c04c-4f81-ef37-08dad1020809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQcx3FzPWL5Eha2SZ5XdNJ6Vw0Fe32ZTIw01LW+z4X14WteJvh6Xocad9/geE5NGQv4r3G+IYPFQcRhv5zQaUppYF6TevWwlHds1nxs9CTS3KlviMjniYts7ZCe/9zQ7PnHQPfh6yJam9krjUXQxf1l6gWUmL9mniJu0gw/kiZjlEYyQ95aN8sFMbyw0bdR2Y7QSWU7RCd2hPcLSOcD9NNsUhewNwAYyGqoA7Ug7/fwPD7BmE1T64ERVaFpqqjsEw5NKR0hPKj8iYcMqeH3FKFJmJ+fs6ifbDMd0ZAIzzWsjDG/mg6g5cEf6TDxVECP2chU1fhl1DXogI4i0DmppM1eW7X92BQ7GIH/gcbgk6Is8UBRJen9hAJufO8dlIc6+YtabpkpgpDX0QT1q3rEO1q+3ewKC6RXWt3Esi2jpq7fIqy3+GbhW3g76hVowhCJh5irr1LXAwKCqt8IWJoFqYms8KVCXDgxEcuFIhq0FtPksRvEHV2Q3HM3r6XUy+kwvwOdwjwrxzbvV5IBkhfnMRodbi3FhJAFrns8JHzA/O9KxJ2zd3vCRckeBgTf3m+9hlNU0iARL+yDgfIl/4hjpjyCixPcAyQ/Vu/FXLycxbSaL6lWBV/+WgCIRAjNOKh3xomYbQ9u+PwH3BlEmAoRvCFHXe9lTMA9MqZelYWez80NJ/qe5xpANNApvfqwEaBbtGGarMRZirUbOb9ihEdLUMv09k5WXK6Uyl6i8SurM4dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(31686004)(86362001)(31696002)(6486002)(478600001)(6506007)(36756003)(2906002)(44832011)(6512007)(2616005)(38100700002)(186003)(66476007)(66946007)(66556008)(41300700001)(6666004)(4744005)(53546011)(316002)(8936002)(6916009)(8676002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdDZGd4TDFqeW84c2hjdTltUVJheTg0SlFYbE5YdmoyZFo0OTVUOG5kNnVw?=
 =?utf-8?B?d3ZjMnZkZWR3ajE0cS9BMjAwTVNLVWV1czRiMVdCbkdZa25ZdlFvL2FneGlX?=
 =?utf-8?B?L0dGS0o2RG95UGQwemJ3eEgxQlFHazQvNEo1VU1sa2ltWUc0Y3oweDBmYlJp?=
 =?utf-8?B?S1kxUUxzQkJQeTZYVUtyVVRLU3FaMWQ3QmdFcDVMQ0lHLy9sUmVQNGhQNzhZ?=
 =?utf-8?B?VDZBclQ4Qm1VS3F4Nm51UysvVWxxYXlJbjN3aHc0VTlTZGpPUTRiOXQzcWlR?=
 =?utf-8?B?YnZRSFc4anZDSUl1akNab3ZNTnpXVHdENW9kSVBTbWlSYkRzMm1LZHFFSEVz?=
 =?utf-8?B?ZS96TmloTy9tdnMzeko1b0RMSUhpZlExVzRtUFozZW41NTJHOFF6bFB6VGlt?=
 =?utf-8?B?c1NPZ1puVnFJcjU4UThYbk4zMlV6WitGZ004YlVyUTRKb3l3K3JsaHRpSC9D?=
 =?utf-8?B?QkFjcG1YYzhKYkEvU1UrWWhPZzZWaG00S1Q4WGdWak9ueDB3YkhqMUcrZ2JS?=
 =?utf-8?B?TTB5dGozUE4weGs5aTFjemx1RklsaGNFZ2NFcE82YUljVXF4R1dORGtmUWYx?=
 =?utf-8?B?L1R5K0lxLzJ1bSt4Y2EyaFJUWkYvandRWHcxVVBSdllzemV5em1XZnNyOXdj?=
 =?utf-8?B?OUxlODBUcHNJRjNFdzdTeG9XWHdpdHNuK0UvQXdNajVESnYwWm9oc1JMQVds?=
 =?utf-8?B?U0hIMlU0M0hpcTBFSnYrRW1LM2hsMSsyUGEvQkpEZ0h4bW9XQXhZdSsyRGVu?=
 =?utf-8?B?WHZMVmdSbHRVQncwUFRDU0t5T2x1ZzlXaFFzMERHM04vcjBwN1QxZmxYSm15?=
 =?utf-8?B?OHVIaHd0cmxQbW5OT1E5Z3RtcTc2bC95OElQZlh1Q09kbXlmK2cwbit6VWw3?=
 =?utf-8?B?cDhrSDFLem1BYlZsQ2h3dmcvR0tMZEZmZ3ZvWmRQUWJoNUJnd2lyNWJWSWQ2?=
 =?utf-8?B?eTZESXptTnNZejFKRzVMVExRVHErdGEvUlhXZFRtOTRRdUowTndYTVIrRU9m?=
 =?utf-8?B?MWZ3bnc0bW40NisxWXVkc2x4NnhmL3BQYkg5K0V5WVRDTWIxTEp3UThleDNu?=
 =?utf-8?B?MWZLcWNFTzA2cXhjdDE4N0oxTEpNQ2Nmc1ZGMXV1ZjY2NVEyeE81UzFGSmRC?=
 =?utf-8?B?NlppaWswQ2s3UVVUTkY2c3pvTzFnVzh3aGp4SjhXdjIvdWdsK0pvelhWVG8v?=
 =?utf-8?B?MGFNMFJ1YUcyVTRGNHAwYmpKZVBBbk9KUDVmZTdrbWllU0JiQVJ1dVdxOGxG?=
 =?utf-8?B?eWliaTRqQTRyMHRmK2owRXhqMktwb2oxREtkeStBcDdmOGdVQkh0R2JDMWY1?=
 =?utf-8?B?SFB2R3J3ZTZlR1NnazZ2OHEyWi83VmhGSkVUYTRvMURtOVhOS1J4QU5iM0hP?=
 =?utf-8?B?YXRyU2pGeFRpbzQ4anlSY3pmY3dveVR5WVFHZGdua3NIRk9kdXpuUUNKNDhx?=
 =?utf-8?B?WW5PcEJkRld1SExTTW9EMlRmSHV4M2U2cDN3ZkcranhoWUlZZ2Q2Z3BISllw?=
 =?utf-8?B?L1ZyN3dMcFFzWnFwYk9BK0hJS3VtT0VFNFVWNi9ISWFBRlVmYnpseWRJSkhy?=
 =?utf-8?B?Sk5sMVdGR0c1cHpvT1dGUXdIZ0hnL0RPd25XeUlKN1Z6K0ZjNk4yY3BGMnEv?=
 =?utf-8?B?T3V4dmJxRmI0VFJ4ZHNHcGMzbk90cUJRblAyWVZHRm9CQWtGL0RkMzhyWTk4?=
 =?utf-8?B?VmxXWEFzR2U5V1Z3RDFPamNKcjk5RHlnWmtyTUJIQitVZ0lvTVFIZUZDdGVl?=
 =?utf-8?B?UUlDOFlvVFk0elZacTJlVGcxM0xYc0cra3J2T1M5YnpzaFA1d1B0V1RtVHk5?=
 =?utf-8?B?RHV4OXppVFdGaTZ2Si96ZG9lOStoMnJVUFpqdURSRk1jTkdKVnUxbG1keVc5?=
 =?utf-8?B?QlFpMmxzK3FBTlV5OU5XZ3EzWS9Ja2tISnY1aVlKamh6ZEI4am1FV0QxUXAr?=
 =?utf-8?B?dmk5MmZwL0NZTTBPamdQY29EMTBYWk5ubmFHdGttQTRsZGlVQTQreXhTVFpo?=
 =?utf-8?B?UERoZ3l2Zm1zL3RYNThvUmlFQ1VsVE1nRVpuNGI1aDFJR2NxK0Zwd2JaTytt?=
 =?utf-8?B?SHU4dGEzcEtlcHZPVms4dnRDc0x3eGd4RzlqZDdCNUtnYXpndlFGek5wK0Nh?=
 =?utf-8?B?NkVtL0J5TFJueUhza0xJWkN6bjhVRnJjZTNCa2pNTGNKaFhTdU1tN0tNOEUx?=
 =?utf-8?Q?zGO6JUZdUsbjelTlzPB5iyFORXBGd3DnCroJZ5WVAZ2C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I0y1xsprqqv0gBRKcuG+rzzRoyRaG8hHsnuMYRc3PT4os3yMLnL3PwGPsuyCORPaE8k2vOUL3MiLE2pvlRO3lTFILBrtSc0S1joy+skus68BZ2Sy7fMl91mMxzbCxpOOR0YDortINNoo7epRIh4SeTMD5Q/c/uO5ssrmRl2chqLVy/byntifi6d0xyrH9+s1L6fyro1OdRKzpjCUjHJ1m8ct0+2RtLFwA/b1ZBis0Q5eB7CRpiOasf6PWvVHWANY7NWK2mXEH/F3DJT9+e7J+K0CruiPQR0ez67+ysWe+Mcbo509ZuIpL0H4lU9ASiw/Vo9rio3mYwanouvoy15b1tatTPQekIEzLW3Rsom/AXvVUvesxzJ2vr1SZNpeJegv37fAF29G/O8C2/a3zDq45qPjW+cd6hIEfM6eQo/BpGNBI1/4cbE4cQqGFYNh/XnLnO08LLLmveiROA8E65oERwjtOZ34gfoZ8jfq/J4/BfFH7KKsIWbx9AFxzulT4i3OzdbiANT/LBpioX4+LkTVejndlZJhBJG3cWpATnEnSXJt96RDHl79EMsP/mNTbNseliR8xEx40YxrqsXc8U84KXt9p9yhypasrWfUba+NRFndo8BzxVArhf9987YvCc8KFDgsddscTXuHU38YBBYZjcuvMsZ7oqMu6Ua0/U0IKsM+AGqRRpIVvYLrUhX2Cchipb4LCbGvIeWODTw/3LtgSEZxUqAD2c2MruUApSRDAwpP0dJrc7yCLMES26avAf1CpSgQAgBeg4R5E7zB0aBp51ZSqw6YV4Kea/ODHywr73AzyxH24DCl8SQMgkAhZScS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83590d65-c04c-4f81-ef37-08dad1020809
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:33:08.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89u+m91FChZIST1nJ474YQh7umVCvGNUvvvjYVmL+0TeOq+CZPPxs2tFr8tlDjaCeE7RDqdnSG1yICX7xYQOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_04,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280043
X-Proofpoint-ORIG-GUID: lSig24ICtyYBLZ5ZXHx7fWhXu-s3_sab
X-Proofpoint-GUID: lSig24ICtyYBLZ5ZXHx7fWhXu-s3_sab
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/22 04:07, Josef Bacik wrote:
> We were not clearing the .o files for btrfs-convert as we had the wrong
> directory, which meant I missed a compile error that happened when I was
> messing with kernel-shared.  Fix this by making sure we clear the .o
> files for convert properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

