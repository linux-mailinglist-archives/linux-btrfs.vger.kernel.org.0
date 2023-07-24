Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B975EA9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGXEmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXEml (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:42:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005A122
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:42:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNnXbJ018552;
        Mon, 24 Jul 2023 04:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AHqsbaflGtM5FZaLFjFgzkY0YqtSDD59sFhKhnipRWo=;
 b=0JqUrggmeawNltIeAQkFN45yr4FGwgxe9Xt7vuq6qeJom1mTVfu+H927EGVl2BRGOrqe
 Zo/am7W+YsGcRmzHXxXn0YfAb86pDaJe2uHkqHBMCyNu3takUi8mNzlylc3ft2r5nzhc
 eVnl6adUNExtMVt8X1v7A26QV/ouZ7Wp4RKgh3uBRATQm2EwwnV1mRpSkG4YhDue+Zz3
 oLakfgLqc+QaBuSTC1Ulo/2lnVJkvNZ8hkTzJDYgNsNIsQZPO7eIu7e+CNu9MKQakIzU
 pGu0TJ/Tmw+gVzh4jsLuJ0bom1ttxNErcqFfHvwx1xqju7BwSjFRP60ok1vxI9GLK6gT kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d1u60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 04:42:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36O4GdHJ040883;
        Mon, 24 Jul 2023 04:42:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3edb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 04:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEnrBvQgkBU3abOQK7VWS0nr++4NRdXkX5PdI0DDlbfWeFWqswKPDupupMc0WwOl4zQ9sNsPVO/jRDImi3Kq4uWdktyBGZk+/YXv0+uMARFGg5LA6AdEQEhXfUIL1oIbNMX6/TxEZjb7T4L13hC88qS8ttSuKsXcHtvMwpkPwHmwtOkLIX2HlzLqqZQ0tpSUzFHz9R3cHK0UckArbQeyctcEk1VgrtfoNmBzivohmXH1G1Bz1OK1zBrpFSps/SgYILg4h8ELUurwai8YnQvs1UJk0+9qAS2iSXAKr7cQ63JOgHuJR6GKVCNe72qmsqvHuh3HcxQRoEfWfNnazJQZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHqsbaflGtM5FZaLFjFgzkY0YqtSDD59sFhKhnipRWo=;
 b=VSnrKFliElMU69PfBKceAogE0EAdGYtRiOBh4eFiYNqGk/cdIK3sQPnWqeyqghUEmn2OmB6qmu8AB2jXWblKYCQjF8RZDYu16mCNM0mIRGOxwJ972xlO4w4aGFPxSGm7glmqE+Gn1XDGgIaIQmB45B8SuMfzbnngB1dmq93/mcmbkpGIIXV8JfDl528ANcb7V7HGeV4bNhj5vozzFdgQ3EElAUNYMZE2a76EVlkxeXqiKjmvb0N4LX2PnbsgKi5aKk/6+TYYIxJvEgmVlQttSexCZHM+pikVeswsE4WatzzHlQ8SDbaibPg3pWR0ucQL2lzYkjHCuRceRNJ5kRt0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHqsbaflGtM5FZaLFjFgzkY0YqtSDD59sFhKhnipRWo=;
 b=FVvVQhHTiYeLsEU32jOmq8kSkdqXGDSBLithfU+s1ItVxvXtWul4RSq2F6nGP0vTSncOQU+/aKqthnPwFyTxfIfCeFF8gO0pdu3rR0t0WrI0ro+BXBxOluerFhldJFFbg5nTsxYBuxFN/2UEreQ1LOGCFsKud02F9o2BgL5MEkM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4489.namprd10.prod.outlook.com (2603:10b6:806:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 04:42:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 04:42:25 +0000
Message-ID: <bb08a306-d253-493b-7539-59388814cc7e@oracle.com>
Date:   Mon, 24 Jul 2023 12:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
 <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
 <54P7YR.LGLFEH7DB1TH2@ericlevy.name>
 <86568e50-7dac-2c1f-c678-4b63ffa5b1e0@gmail.com>
 <303f4dab-1143-0ef8-444c-ba57e13b209e@oracle.com>
 <RU8AYR.9BP7K2RWK3SZ1@ericlevy.name>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <RU8AYR.9BP7K2RWK3SZ1@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 708ec0f3-8f8d-4a9b-94a4-08db8c006055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jADKh4mrmgA4WiD8sCQCrbD+vFx/VVE8Fc9XOerRC6yb4cq1sXpsvzUWW0Xf1evInK8YHIaqkBPDRCfTfujGT/m8bRfGX8szrFzg5TuH1OtuZrWoHKkzz+q+XJMZuE3+oqBfdajQA2v50GMabl68iGq6ql+AJ8Gzmzv8H+Fdgshxfp9HhKiMqitjnO8BZQD5EKPQfyQfafEOjqHYHfo3FFUt6JVtj7Kqmox9hJ0bjwTA2nwGlkxMntQjxS17CI+BhPY4meGJOSr2h+Tx1UPBBptXurZHFIGBFgWRAP7YgYuHZob6xzDIEJXAnFMhqZ24ZkRPx8b4iwd0nrb1TS5SbIxQMvpBJLfBxjMZ89cUzRhs3Cj1OkDSPabXcHLDcAlYx8AaphUlVckmkxo0YtY2XcLcMg0na4J2LzaK9kGEMFDBnIjAQJ4WH9Ym+jGCF0scxz0MXibUdy8HEN21jBb+kAjYrnTV61OZnVY6hch4arrm06E7tajPFyz0oEabD2Wja3YCBwQgCAnE19nUBG15s4EY2Y5iltJ64YJ6+PtexgeSElPgWb7uOaMtrPtGsdGHm55dY2LZHaehzCPzKQQGkdPqYWLvkZiCyUhWnGj90UUzOlxPHDl6iKRGLWmpy+XQL53MEFLMOv+sC1+d8+Drqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(38100700002)(36756003)(53546011)(2616005)(83380400001)(8676002)(8936002)(44832011)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(6916009)(66946007)(41300700001)(26005)(186003)(6506007)(6486002)(6666004)(6512007)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNVelp5dkJreG1VZ1ZscjQ3U2RXK0FXZmhyQzZKT2tnZkpjSXc5TlVtczB2?=
 =?utf-8?B?aDZqTFhUVGdHMkp0TjdBZDArckVucG1uZWQyQ3JlN1RLcTR1Ni9wM2RqS0dq?=
 =?utf-8?B?YlB0UmFhZTd4S1Y3a1pTYXB6VTU1OVczblJaM2ZkVlRKcHRCQm1qWURWZ2pO?=
 =?utf-8?B?S0I3Y1RLaEZTWmhtdVcxdXBFd2MrbmU2YWRDbW9BT0hpbmpQZXpuVEtGUXFm?=
 =?utf-8?B?aEE4TjZqM3BYeFBJaTJBZ3VRMDB0U2FkMGU0bnNmMU8zWEFGK1d2akEwemhD?=
 =?utf-8?B?bXMrUGI3RUxCNkFFNWgzMTY4SUhGVktuUHgyRDk0UkorWXRxQ0FuYnlBYzA3?=
 =?utf-8?B?L0k3U3N4cDRmR01QeUtxQkRtcGdyRTdsd3IrNkdhRjkwVjdsdnFLd3g0RCtl?=
 =?utf-8?B?T25ISTJqNkxZb1ZKUDl6d1ZPKzh3Z1VhK1IvaGN2WXZuU2hlazk1YU9tZGtM?=
 =?utf-8?B?TFF5ejdKcjN4WFZseXRDUmVPY1RoTUszZWVwaURjTXdhbGdoQjV5UXpFdnQr?=
 =?utf-8?B?YVRWZlZyY2ZxUE1EQTZkZ2tOVUcyT1ZFOENkNGNraGFFbVNpZWw4QmtmOWFX?=
 =?utf-8?B?eDJiR3RMb3UzYk9lZ1gwTjU2LzBEK3pzdTFEcDJIcmlrWFllV25zeHRhK0lC?=
 =?utf-8?B?SDFlYzN6czlrZnhyTDRwVTc2eCsrVXZLdUMzbGZrMVpSZTZ2RzV0Tk1RTmxz?=
 =?utf-8?B?eHFHNm1XU2JNdzJxbGxnQ1dhTXI5ZFlrL2o0L0k0aHFTYVUwZkQzbVcyVHN0?=
 =?utf-8?B?MG1CRjFiVUxWeEZqcHpVbm5naWQwazlMS0ZYLytlM28wNjR2ZHk3bGpoc2U4?=
 =?utf-8?B?b3dKQjBMdTlQRGFROWZSNXVKSFZSWHh6U0NoTWllTVh4QmRVNnFzQ2tZbnl0?=
 =?utf-8?B?V3VLWTBPUElFdGhVN0kvMTBJZnNGeGtUaW04K1h3WVRXdnN1WXFDUUdTYVBL?=
 =?utf-8?B?TVhJa0cyZU5ka0RpN0hmNFl0alVneXpqOUtXMkdTVFUwdGxwV0dPaVhXci9w?=
 =?utf-8?B?bDZKVWFpZDVpN2p5UnZablRNS09ZSlpCYXR6SmJpVkROOVQzNmxnTkNXTzZQ?=
 =?utf-8?B?YkZ0ZForbnMrZTBwSTJtL0w0QUVkN2tEN0dNcWpIaHQ4WFNaWkhNSGY0aWJs?=
 =?utf-8?B?TnlHS2JiNGVUY0JCVWNGcXZWT25Md1hpOXBYQ3ZNL2x0OXprOUxDU2pNY29Z?=
 =?utf-8?B?QTlCbjdUc1FyeVNWS1FpTmI1emFxeWw0MnpWN210UGEwYSs1aW9DdFlBR2lC?=
 =?utf-8?B?ajFoWk8zMjFzbjEwWnJHeWVtVGUrc2tzak9tdWEvTHp1RVk5SDlpYVNzZ3cr?=
 =?utf-8?B?ek02OVA5ZnprZXZMT2htdVZ3STZEZG5iTk9WM0dVOEhXSlViWHBCQStleUk0?=
 =?utf-8?B?cGRCOG14b2RibXU1T0lqUlRhemg5OWVsRnFpZnErb0x6bm1pTVNQZTVhcVNk?=
 =?utf-8?B?T2JIQllBSjc0bk02T3U3YmlNeU93eEZxMktseVBmVW9uaDJPTCtOcnVnYkJF?=
 =?utf-8?B?eElIaWpLalNUUVhpVHFRRm1RMmFRd3JZL2ZoREZrSU5BWW5GVWVzR05GUUZH?=
 =?utf-8?B?Qm9xT3ltdzJHMSt3cmZmN0srWmd1WWRnbGF0R0lweGpBczIxMkkvUnlpb1dI?=
 =?utf-8?B?TGNKRHFDZWhzS0xSYzFMbTZHR1N0eXZIV2VKbUhuZmZOdTE4b08rNlE3M3hM?=
 =?utf-8?B?WDRXaHc5dWVWZWJ5U2d6bEZGWXU2KzFvWmhEODN4UjVsR28rQlVJOWJnaS83?=
 =?utf-8?B?OU5JakNBRWxnVVlQb2VJQkl5K05Ra2dpNG13cG00eTc4bnIyYmgvNDRhR3pQ?=
 =?utf-8?B?R3R4UjRwYkpTMndWSXJnUy83OEY5bG8zUjYvdlkxaUx2TnVITnpZcHlIZzNZ?=
 =?utf-8?B?ekpqbVlrOW9wLzYvVGN1T3hoTkFRSzRIMlhKeFlWYVNBa1RKMFcwcnk4R0dk?=
 =?utf-8?B?ZkRrNy9YRFp4bmVTaHBoU2wybTJweGh0c056a1g0b3FBVWplc3NaeWk4U1R4?=
 =?utf-8?B?eWJESXZ2eWRadGJUUm1JbVAwWEZ2TXkrWVphZ1UxdnRpUmczQ3k1dURQOS93?=
 =?utf-8?B?TnNuRDMwVVdIeXREbUdWUzNVWEsvMzkxbGNLTm03dy9PSm9JY2pXZitjMXNY?=
 =?utf-8?Q?0UUN36KfOgMuxHIno0bQGipNY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qrGArP5HIuMVcpLa5KDlJj//mheXZpvIQZ9H5kt7ZIRRVIaI397I1LLpvRKFUuogLbOEp/IChahA2brQRgZrJrlz+jfpnZQErxydC5h6Y5YB7t3aY7rI/KGNJscZ+4hfBwhLFluWhRevyHgT/VXqUOdrsSj+ax0vOg94vaAwBaqEgNQyx26Oi1aaYXdCkYcdnGC7ZXT2OkixlR0kuuBQnw21pzlRVeQE5KBIyxg3xkB5NbEsxHuZ8a4BCmdhrQJ3TSyjea5NpJhX6egA/gHkNlvzyyfUFRrXN6qKVOm6f8H8aKBs8+eTbUTJM9v9N9ixQn6Pmp1Lqdd9EAVGlSd0WsTk6xQ/OEKDX0o5HGl2SEwjh8yaWGRF5c6KEcHPWBR+s3+9Tz8gdwdJ9B4Ek9DFmPTp5Ny/kqThMjL3SqRlZvhobg3hS2SRiJJKtIeWkrkPkyDVGPBNLbMB4eCuWMibb5ZjbIY8wCab6adunLxYbsb1tHCN9jX4qlXk+IFnoGQspOE0ssuNoXc+j+Nt/ydTMP66aj6eRHJfS/j6uaMup9eqmfpgQhIohFU9BgnkhVV+P/Cs2L6ndUfePL9ZO9ZifJ6bI/tKV9t8IAcysI49ukD3T+0pdFCQNDwvrYKAjMKjTv5qblVzSzLJJO7a4mcyzXl6TnnkrE5dtTCPPEdyugGtTW6YPfO+LG5wRodxc86oWwAyjjQ+R3WwRIGhWcSZ240DACProN7Ao13pNwQbHRQoi/34Z5nvk4ffi866hxch5B3c2Dyo5dQ0eTcHjP1C/qwNRWp3QfogBxzwkHekipooH3oi7iYPq8JnsRXJyOetTdsDBVJ/E/9xjePtlcBADg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708ec0f3-8f8d-4a9b-94a4-08db8c006055
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 04:42:25.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +e9wFucO054YHGL+l5UT1drhPqZ5scn+sPM0CRz16CkSaws8Axj/rxUQ9zknzdhz8TyWIk30RMcyPoa+uH5i3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_03,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240042
X-Proofpoint-ORIG-GUID: jqtRd0JLG--IwhSsJqMRaiK2GxrP7D0m
X-Proofpoint-GUID: jqtRd0JLG--IwhSsJqMRaiK2GxrP7D0m
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/7/23 12:08, Eric Levy wrote:
> 
> 
> On Mon, Jul 24 2023 at 11:27:25 AM +0800, Anand Jain 
> <anand.jain@oracle.com> wrote:
>>
>> Yep, systemd or whatever should call 'btrfs device scan' before 
>> mounting. According to the logs, it seems that this didn't happen. As 
>> the device scan occurs later, after the failed mount attempt, manually 
>> mounting from the terminal is successful.
>>
>> Furthermore, to understand how it worked before the upgrade, you can 
>> share with us the boot logs from the older kernel.
>>
>> Thanks.
> 
> I no longer believe that the upgrade introduced any new problem. Broader 
> testing with various kernel versions between 5.19.0 and 6.5.0-rc2 
> reveals no general differences among them.
> 
> My earlier complaint about the upgrade leading to degraded behavior, I 
> believe was premature, based simply on the bad luck of encountering the 
> race condition on particular instances immediately after the upgrade, 
> despite its having always been a problem.
> 

> The race condition itself remains an issue.
  I don't believe you will see error the "already mounted" if there is a 
successful 'btrfs device scan'. So it shouldn't be an issue.

> 
> I have found a workaround, of moving the mount from a systemd unit to a 
> fstab line, and adding the _netdev fake mount option.
> 
> However, I think systemd should complete the device scan before clearing 
> the units remote-fs-pre.target and iscsi.service.
> 
> 
