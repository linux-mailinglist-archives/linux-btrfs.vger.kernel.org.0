Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8C6F6E65
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjEDO6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjEDO6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 10:58:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79C5BB1
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 07:57:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DgA66023343;
        Thu, 4 May 2023 14:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TyGKsSiYwuY0AOXmOXgMrN/DubA8ihDa2DasA3BixnY=;
 b=VJmLHxK78smjkC0XYZYnf4dTyH9vPG3YYv5RFm8osf6CfYhLURIx36OrhVHaCDjyaiaN
 iyTPbwwVrkGsvzOoY4VuTArz4X/o442pGfoGHQsTet3I+DLODeXdkKF+/cfdsRZywgV2
 QpVSOONOpPUKFEKufy8KlvQ2NcvYITZXA4gjtVHaE1VVT+wSspDlcYEZLEhfLVxeWUvD
 QxKVPwzO//moPizuTY5xYjZKe+cyvMWRGnCKk+0XX90Eyv2O0pdTdNBVzFk5OhtL/8tE
 Wu2sgmMhY69lJWGLVHg0v2Cw5zqWnInvKr/ljfohJDQp6Q5Y2SrG97lhHwfgHcjPERW6 lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4asx3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:56:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EHo2c024954;
        Thu, 4 May 2023 14:56:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tybn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK/agJD3joZKW16LLU9MN+ykNQtLVSFBIpABRkmKGVsPGmYQ2l2+icvGW7uYl8xwXOr5rwRPWcLppRV1dfyYFck8ZgNgi1e3Od3G/o2ldNpGyCZKBpZ3DNMMEmPwfpDWKH7aKSQ+YvdEpY80EoPDM7YngkG++Pn5njSIxediod2xUWtA2A1ZxFRXFuoOa8o6ApxfbRpmLkG23NLY/vVTatph0TwJyxsGwIm03hjLuFe7RU0c2tcEw5iGuePfr6V9yzFshKkfQY9E/acEQ/ZDOaWra4eCK1PvZiG4NpgMfeyfQFaGISxi4Xza4jU4I+0mBuLKHpsP+81CmiEg7kxe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyGKsSiYwuY0AOXmOXgMrN/DubA8ihDa2DasA3BixnY=;
 b=AucOOjukR+PGSyUMi0hz4fOlsoQYu9NiqpeH9cwc1/35AUiR/cs2tpYMQ1OCoNeKAo5wivfIKf5a5YgMMzME8vSK/PuiEP+b3dnjOICrgkaouBK8L60r0qeRYTy87FfGBsWuNr5ScvonoAmAYckdrqLlcvAlrIDzIWElMr3ybFMW8PMHB2V8FyUCpqEXLDuqWrjjJqMOFVG9kPgQbEBaRIfwBqhYdkDiTambl7AVwlruAjTqG1JQBIupBrtIjJvnrjNxROY9XEe+pw7l0iVaiTezWTX6hmokVGrUN25g2+fGYfCEb3MdshjQzm1yoLWT8t7ThABCnoLTGSjFEA6jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyGKsSiYwuY0AOXmOXgMrN/DubA8ihDa2DasA3BixnY=;
 b=Fu+MCLq2bpB7BHJG0lYfgSadXaU0FeaCMOR52ijkPSL5ZOss7HcgSSYkjyQMmUNYMV8vnqLbK4R1gdM7sCvw5TNvCW/XyLq7eFb7rLDlVR8F6jryqFz9u2Cfa+UIrw4UMKdmuqUT+NiuNJVJX0QEr2UH1jo3khx3iFNrEzrXJxU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7490.namprd10.prod.outlook.com (2603:10b6:208:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:56:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:56:25 +0000
Message-ID: <e74a3f59-0ee5-b2f4-5377-cb48d9d170fe@oracle.com>
Date:   Thu, 4 May 2023 22:56:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] btrfs: fix static_assert for older gcc
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
 <20230504143321.GF6373@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230504143321.GF6373@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b4585f-74b0-45dd-7fd9-08db4cafbbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9A9/vWIAcESeZm2jMjWLsAVtxsXQ1zilkoWP8k+5cIkRQ/2pcdv2AztqbTpx33q5lYgv8K4i7WoQ1y90BK5p0+1NgmDTX4KCz6wjaDQ82+2Zn1odg2taA4NcsWHTjXhy6mZQYlEgQCdu4d/y5QM7mkJX9z73jRRy1T5QY6hJD8WYrIGXm1hI3l8fEYizoMQEWselCEiUntpojHh3i9ioQlcOgui30lrWurLF2gAqEpCs0+Chx0oQOEnxYOELqauxieP2ugWZsEpz9c3VMQsOdp6ubsWVJMiwP9FAtSO8OgefybrXM5wJlb8yIpFbNvd2XE+HNdI9KIeJbOryd9kVZDCM+AVVT1QiSCPWrC2dG+mzdv47UmkaK+SmaB0Zh/MQvHvelzR1iOAjir75/QTJy+gyyyPUvedvjtDr63jRxpci/ltFirKt8Na+XPlD9/v+BUfk2PpmDFG/6bQQOSi9XJ10A/ZvYxkv/d+m+qqfPAxEDYsAaOFcw7BSQuC0JbpJvHGPALXYE40ozwRNDOPhOHR9LkwI9GmH7EIe/ey5WiDQVMq/nvNdTH9FrLpRxzX+ZFFRRePqZhwIVtFV+vKGmx0eBmM/Pv4OiesfJxO2ktdz9NKtAYXhbxQnuTl4Pc5XBVUaXc8llGixonPNcb9tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(5660300002)(8936002)(8676002)(44832011)(83380400001)(26005)(186003)(53546011)(6512007)(6506007)(2616005)(86362001)(31696002)(38100700002)(316002)(4326008)(6916009)(66476007)(66556008)(36756003)(41300700001)(66946007)(6486002)(6666004)(478600001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2RZTDliL2JpWVk0UUFNWlhjTFNBTExiVkpxTzJrOCtJN3ErYXFiN3FMaXRK?=
 =?utf-8?B?L3Rrem9nd2Q5NzB6NGt1cXg4UUhaMFZmRllsMFhMT2Y5V2Jab2s4RzJGenVm?=
 =?utf-8?B?VkpXUU9KVmxZMVh1c1ovQUdNeUt4YWlIQTNqVE9semp6T0Foa1ZkMzJ0Uysw?=
 =?utf-8?B?ZkFsR1JpeS9YdWRWRkZzS2ZRN3dvTGgxYit2eDgxaGpRVnl6OURVV1dBVDhu?=
 =?utf-8?B?dUlzelJudTRBMmE5cnB2N0hzRVZZNlVPWmhWem9LTDN0dTlkZjlOYmQ1cGdW?=
 =?utf-8?B?dkFkVUlSdXlrd3FsMUsrVGdrRVNvVkU1RFc4ZUVMS0xFQk9RN3lreHJVeUJF?=
 =?utf-8?B?RVJ3NUdETkFkODJoY2JPWTZxZGF1cS81N2gwODZxaDFOYktQQnQ0SkYvSmxB?=
 =?utf-8?B?VTRhWDJtRXFWbjl2S2pkZ2pkbkFhTElQMDJJcWM3cWU1dklEWW9xbk12bkVt?=
 =?utf-8?B?eG9uTFZQTEhNN2R1TG8vdXVUUFZ6WnhsVDhhK0hCWUFHNVJlRjZjS0V4SDFn?=
 =?utf-8?B?Wm5KS01QVG5qNnlxNElaS3dPc01nSFpuODZJRENIWFMwMVBYaEwxNC9sS2Fm?=
 =?utf-8?B?WTQwUkNULzZKZnhWL0pPMzhDeGp6Z3ZmRjN0ZloySExRZDV6aU1uUmFwRy9Y?=
 =?utf-8?B?a1N0R1ROcFFUdUMrWk96aWxwaU4zTTY4OUhzVFUyaDcvdWpWanI0ZEJiL3hO?=
 =?utf-8?B?bmEzd1lIbFlOVlMreTRtaDJhQXRUcVNYV1FyUHdsU2FtSmxkY0RXVk83QlJv?=
 =?utf-8?B?d0VkbUFsbFZMSmduQy85L3hCczQrUVFxWW4zbUtsYUtxRk80ZTVNZFphUW41?=
 =?utf-8?B?azdGakMxcy9aOXZMdjFtOTR5d2RwbUVPQ3JzV3I3aFJ5WGxWNkxETFFQTHBj?=
 =?utf-8?B?S291ZkpqSm1uVzV4WXBKZTN1QWY0dWxvMDBlcHRPMU1GdzdDOGZEMjhOelJL?=
 =?utf-8?B?clBFMmNmNE96d09pRXdPdHRKSVdXcEpDZGNJQXhha2VxKzM3Vyt5NGpMcnNZ?=
 =?utf-8?B?MFp1eTZ0aHQ4Z1dtRjh4OGdQZFZ0K1Z5bDl6UUV5ZjFwTlI1U2VpWmxpRHlT?=
 =?utf-8?B?UVRKa2ZMR1h3ekxCQlh5VjYzdk5wWS8rdmJFUVV6NU9XVWFZdUNOTHFBc2Ix?=
 =?utf-8?B?TnQ5bklLbEFYTXJZQy8zRUxZbzJxZ0hUYXBQNVcwU2NtUWlhTzFQS0l5czVV?=
 =?utf-8?B?WmszWWdrL0tBOXRwR2g1NnZ0ZXl0Sk5nNG5SMGlRNXRqVWZ2WVVraXZoSFk1?=
 =?utf-8?B?aHhJYXNXVnBNV3hXRW5FMkl2bC9nZjl4Q243MzJWV3hRTndwckswN0lHZkhz?=
 =?utf-8?B?TkR0R2NIeFBlR2FoQWRTdVFKcmhrQ3B4cFpZVEkwdTRkdWY0dDk2S3lnSHFV?=
 =?utf-8?B?dXFzRjhHSVM0c1VDZnRDN1BBeWJzUURmejlzTDZBUnpVVDd2UXJuK01sME5k?=
 =?utf-8?B?c2hyZDY5dEp2YTdEai9KaW53U3A1SThuMnhBQUowK0xCVm9iNG81UFM4bVBL?=
 =?utf-8?B?ZU9ONUZ6VWQxOXVMMGMrbnk2WFJwVTlSYVl4MWpvL3AxeHpOWFFvUEljQXht?=
 =?utf-8?B?dlpQbXlDa2l0dkJsN3pwK2NTT3ViT3FHalB2V0hGc1J4MW5adGZtZExidzJx?=
 =?utf-8?B?NTBSb3VqaWZiOGxNNENhTkVuOEdNZXZYWklCZy9ibEhLZmYvMlZsVERhbXpv?=
 =?utf-8?B?S1EyWFZXbDRKT2lLZGFxRlkzU2FrTVR3OEVaZzAvWTE4MkpTVGpKSVVaTEwr?=
 =?utf-8?B?cVZhTHhtQUd4dERnblF6NUJoRi9GTHI3TXM2amVlSHhpTm5VcUJRTGdWUVJE?=
 =?utf-8?B?dURXMC9GeTZqeE1BTWhlZUxuNFJBU3dmMmdEb0ZPK29FZklEQjkrOWZnancz?=
 =?utf-8?B?L3J6Nkxjd1ZKbEtQd3I2djJFZG5SdnBmamxVUFd1WGxOdlE4VzZZbFMxT1BV?=
 =?utf-8?B?SFZSVFRpKytTZkxRUkllRk5TMmhUYlA3dldidUxvRkV2c2gyVE03UlZKeDVh?=
 =?utf-8?B?c2laWWphYkRtWWJDTC9BUGVhbENaSCtYaFdhL0w2TFViVTRCWGd6c0FjR1ov?=
 =?utf-8?B?VVc0YnM5UnpWOUpUYVZzbE9QZG5NbE0ySHRvcjhFSXNqQlBpUkxoa2tEWk14?=
 =?utf-8?Q?ooeofTIXdHwbjwd7IePDEOWcJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kI7BCYkT62i2+paJdx772CNN7Ea9iZR/fcEs7gquF6KThAojuE9TO+SMyhKykpBl7iyqMRuCxthBKREfEyM4I9m4apwfItHuHGdMOVCwzxmTgHO+pLM87aMa5s9H3zndGAtQ/hYCYK/9rZsFMSRVZbDehLlCqTN9M7+rh3c3LH6OXl/Gxy7IvhoGMse/uTRwZJFCkcoLWwMbSg2jnunQxh0KYMSMZwdPj2PcrmibD6O5AdVP57tynDFzWdEuq/bNcgdGzg+KhjoK9NMG3gi49sEc3y148JuSPRQAr2GshOwKYc8gjz8v0+eDSOgXIHzTeBT8mKIooymIdziDPqXiogkuqSwDmLxmOGdoJQgUtfc+Pscbv5S6rjyw1GK4ESxP9sxdoR/CHo11yjAMJNQdx3DXlapkaknUIPdS1rlyJmkiNGhQDKKs7oV40CDK2jCow2Svud5uC3NH0u4nSPzo/FVrYDV0sKUdnm7pF7RMyWVfoBdiRiaiy9tPabCm7kTVfQl11wP0En+A9DtkSKZNwhYvz4qnr1vkHwJrRLdhtnQZkL12UDcQt0M29Xpe10IFBW6WLbc7CWGhjqOOoBrEv2vBKOIyhR+JFZYR/0e8n30xtGhhpwvIgPbgrDqm/Ir+5OeSXnkfIIY/+E78AjbpdM5PKepaQBmfzLAuNRYYUdUlKVwTVKYXYp8h78mC7oiHZ0ibJAtk8xceCMv1J/ERgxArWf0bgcqxlYleJq/GY3fKdhgYAEyS9sqnYzrxAsOIQLGBzbEWii6kFAKCluJoAQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4585f-74b0-45dd-7fd9-08db4cafbbb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:56:25.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDNs6oOOVBRMCsxCGtdIp5aQT0S5l0fd2Nezp/PJbylWV5YDH3iNyWryH7r93kUUJ4/NmB/xs8e3Gx7VTrUiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-GUID: fz2uMz-GpfhomFf0px38wg4iLHWNpNol
X-Proofpoint-ORIG-GUID: fz2uMz-GpfhomFf0px38wg4iLHWNpNol
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 04/05/2023 22:33, David Sterba wrote:
> On Thu, May 04, 2023 at 09:56:37PM +0800, Anand Jain wrote:
>> Make is failing on gcc 8.5 with definition miss match error. It looks
>> like the definition of static_assert has changed
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/accessors.h | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>> index ceadfc5d6c66..c480205afac2 100644
>> --- a/fs/btrfs/accessors.h
>> +++ b/fs/btrfs/accessors.h
>> @@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
>>   DECLARE_BTRFS_SETGET_BITS(32)
>>   DECLARE_BTRFS_SETGET_BITS(64)
>>   
>> +#define _static_assert(x)	static_assert(x, "")
> 
> So the problem is that the message is mandatory on older compilers?


I couldn't confirm the GCC version and static_assert changes, but found 
the kernel wrapper in ./tools/include/linux/build_bug.h.


/**
  * static_assert - check integer constant expression at build time
  *
  * static_assert() is a wrapper for the C11 _Static_assert, with a
  * little macro magic to make the message optional (defaulting to the
  * stringification of the tested expression).
  *
  * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
  * scope, but requires the expression to be an integer constant
  * expression (i.e., it is not enough that __builtin_constant_p() is
  * true for expr).
  *
  * Also note that BUILD_BUG_ON() fails the build if the condition is
  * true, while static_assert() fails the build if the expression is
  * false.
  */
#ifndef static_assert
#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
#endif // static_assert


