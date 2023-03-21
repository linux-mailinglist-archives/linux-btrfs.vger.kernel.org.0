Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362896C309B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCULoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCULoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:44:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39174AD04
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:44:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8HMYr022693;
        Tue, 21 Mar 2023 11:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=BkMFYhCJMQtfKx7oIsfzmuaGw8OphKMbYmIhrfGIcoLY+esQk4xzNPbmCXH+k83FQ1rt
 p+dQRFVbmi3HDDQXf5Jba/e5IrE4J5rsO4M9mwnNwb/Swh7zcXors3efL7KDhE3esCpx
 AXEAAXEELhIJdckdPpl/D2uTLX1A9gK5Gkw+61PSDj65ubh/kRJIr5cbphdGRyfwNlq5
 zJwD2tyP37c/SN6k3neJY3QEr+13k3UYabi2QwxTRypSWSOcq+VwOIB8CN8QDyCAtghq
 zeHei5RX24tg1MLrz4Y+eAwUhgGArigkIFrJxetWQVVtAvYrYoxddr2Qw78Lp1eU4Hq+ qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wge2a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:44:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L9k6hD038647;
        Tue, 21 Mar 2023 11:44:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rd38vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRnW12SSG0L6kp+QsVbIs7mxsMZgNn0Ov7U461TW8YcGKRSrKHdaRC7DEAl1fiX0WNgpDk07apyXvDC3IEori3/AesmXTQNrlw4p7j4xX090TEw2MgFs+zmYrOk1nJWJnPHFhchp0GFJlAAxfGidZGrm5DJPivHTJTbRF/IoA0sSxV+BK1X498/2tv38V2aqoY2AjpraT/RZ4PMIduLtniArwcz1N9PITngVFfPBcI+I4PHMNw5/4qFQFK5qaCKOviDHTi8lD4G8nWh0gYRQdICLobeC76Q2GyHOJklUZqSjX1pFrjwjKO//itgT6iWIVbj+sAEQxFr5DuaMk6qIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=UnyWTHg+Vn4qe9dOhhYrG/R/1lVrKkMgeKoiLpKN+RzLw/AlCojMqxbNGbGOlmqXxjIGBhsJ12kcAvh3C4PlWtV3t0yiRyV2XBURo47yO9hEO7p2qTnvs6L2e/mz+yYCYANQu03tZYPNXibA45319Qzn07KW28qcDOtDb1gB/tNXRj+GH2abgIGLrd5QhKZjSjXd3FmFrhzetj5+FR2BtVBVuUVoOocwa+ytw1ZXF27ujtxwZzlcqMeHn7a5ojw0cE4YMcpSlWn42/MlcQNxM9tT4EuQMPyedbx5kbIlnyYkzvki2bDjIm4evUQsUdK8sviAiqprk4mj3a+j0NeHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=MniuYHYvDo+Gk4SzgEpRl3wy0Itexc8pQ1P0bLCCq9+cseatUJeSOov+4HyCfiF+6vZXb+beWTiFWSHXLZeYzbJ9MZVHqHEMwqoewbRRaUm6so6+wnkWCAyuqMhFbBR0UD27jlm7nwXB6A6giTl1hNNIipK54DvmR5hKV3fcaDs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7171.namprd10.prod.outlook.com (2603:10b6:930:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:44:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:44:02 +0000
Message-ID: <cb3f6eff-6709-f193-3d61-46aa45282fe1@oracle.com>
Date:   Tue, 21 Mar 2023 19:43:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 02/24] btrfs: pass a bool size update argument to
 btrfs_block_rsv_add_bytes()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <4e7abf7599f8d809dbdd5f9f25f376fcd1ed83f2.1679326429.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4e7abf7599f8d809dbdd5f9f25f376fcd1ed83f2.1679326429.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 234cb0a2-8f7c-4672-30c2-08db2a0190ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zu7BfF73JF+N/j4Rc7NUSbxGOBADOAdB2xyHpwBX3LQpLNSOQLhXUxQx1MZcz8ZyDW7c6S/eRT7yz6eRYFce+er2lfnMOY9CDutp8Oz1MiXP/fbNr5zZzGya76LXtVgPhHyxpv2s7AwkiPAZ4AMNvAiVd/6drlBXzGO+YA1fSYlIdrozFgikdiQwOqJW/t030N3/8ILit+puWfY1+3sdQPFGQKXCPlLxRMv1TDYqJGT9pIItxJfNpTB7Wo5qi6tPD+W3qYT/asG8p2oJmozWJMap2b8x7E3qYLjdusfLXDpClFT+L/vwgXpXvNVO+YA3ic0sW04GSINwO5Ef0o10rdtbhK7WNu1RpiNTfQFx7ZLsJ4oHbUG76IxKhdwTgZhKUeAGzqGPpcZjrBn/r1LERBY+b3Aa9Nx2x/iaHhQkR9B1ohTpfpxbl2oz4sHM1ede8lwudcOhJwA1qmTyL4iiO4M3YVKtL1R7VysnAJsHusEcftgL9tJaFC3RAzCjui67ojrGZMD55PvktnRckxwPy0RJzTTU5EeMBmaT4tm4aXs4ajZpojVZ018QueI7zLEyPqVMI6haNG6PKFQdZd2SFaJs9YRKHmRvEKM1LZxMJ+mM+Lzxwcrqlsbhy0zRE0SKAik2k7kaiQOBwE0ZYqOP+QtDgGeX10tuErHGrqKMKC4mD/5k93Xe80SwtWq506QOLj5Q4Fdk9Aumn99Qurlb7NiRWL8cZzRlrIDO7vyetj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38100700002)(31696002)(19618925003)(86362001)(44832011)(558084003)(8676002)(478600001)(316002)(66946007)(66476007)(36756003)(66556008)(8936002)(41300700001)(5660300002)(2906002)(6666004)(4270600006)(31686004)(2616005)(6506007)(6512007)(26005)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWppL2Rzc0tyV2NwcExJSXBBZWUvZkxPQkp3dHdqQnRtTE4rcjVDVS9oZm0z?=
 =?utf-8?B?TXVCMDNaNTh2TnEyOWErclJmbmhoa3lSZlljeERNVFN2eWtSMldkWGFCUTJD?=
 =?utf-8?B?aGtHbGZQeEpRNnV4aVBwbTN6Q3I4V1RpSU0xVExtWlA2SE1YdFQ0Z1RsTENO?=
 =?utf-8?B?RG14bCt2ZnNKTlpkcUt5NEx3cHNzUEwyNSt0TVNGT2VmcXAwek5yKzFkelhZ?=
 =?utf-8?B?dFl1NFVaek42dzVwaEVHbG9ZSUhvb2ZmaktwcUZMb21Rc1g0OS81VzkvQ3cz?=
 =?utf-8?B?U0gycVMrRzFEWjVMbmVzdGlDNVVaMHY5WEVLT3N6UU05NHBDSVlvMTltb2tq?=
 =?utf-8?B?U2JPSDJ1ZXdQODdrV3Q0MDdOdTZBWmRKeHRLME5Wd2sxeUE4MEdLcXgvSDJN?=
 =?utf-8?B?N1lwWjJpV3BpZTVLSkVuQU1qSkhHRDZwcVp6MlowS1ppRktocm95VTcvTjhN?=
 =?utf-8?B?d2VpZExJNHJaNWdPaUVkKzNPWUZzSFF2SkJ2eEZRT3FvTjN0ejU0Ni9sa3hq?=
 =?utf-8?B?Zm1YY09aYWEraUthMWJXWXRyNE8zZHJZM0JleDhYSkIvQ0dVMWc0ZkEzZ2JQ?=
 =?utf-8?B?L3ZMY3VDMmE0ZktiMHQ3TWxGN2taNFd6eWtQQ2g1RGVoZUo0dzh0bWxUOTln?=
 =?utf-8?B?clFjeklKNkJuUzZSbG5MM1lNSnpnVjhqODByR0p3VitkQTNUWkxaN0Y1a1h4?=
 =?utf-8?B?eW5tQkJFcVkwRElDUENHMkZ3N1hoUjg5QVhURjBiV2RoR2p0eXk3RUFHOE5i?=
 =?utf-8?B?Unp3cGdTbXhnQkcvb0o5SVlvZDlxR2JmL0VJb2NYTk83bitxT05vejRJSjR5?=
 =?utf-8?B?MzBNUm9xSnoxTitnUmpuWjdoZ2tCamVpLzJEQzFPbXl1QXJhQWRRenJLeXZH?=
 =?utf-8?B?ZUsvZ0huWmlKbU8vVStGTExid244SFNTV3RpRXNiVWxCaUl3UCtvRlpxc0Zw?=
 =?utf-8?B?OTNyRU5MVmdjd0VOaW50M3JmRnNjZlliQzIvNlpvNVpidFlxdHFnZnhHYWMz?=
 =?utf-8?B?UEMxTDZBSDVjclVOMWk2MDMwRUVRanpQYzdIR2VCYTlBSzhIczFsVUIyK1lB?=
 =?utf-8?B?QmZOMnhaRkZxVUZ0eXcrMXBYVFZXTUpBSmV6ZWRqYnJtQkRQeUpXMWtPc2lE?=
 =?utf-8?B?T1pJcnl5OHRXMnFtb3k1WU1sbU15RWhLTFF1a1ZjakFYeVRsT2puSVNuVE1v?=
 =?utf-8?B?cHVsUTlzZWZhaVZJN0paZ2UyZXJGZXg2VCs4bS9hNzFEUXZwVXZkOVYxSnl0?=
 =?utf-8?B?YktYck1oMm8rWEc4QU04QkxMZzRFZzF6MWpmRERaRWVHLzNreU9yQW5IcDhM?=
 =?utf-8?B?VVIreUVMR2RMUnRucTNUNHJtRWpOMDhoNFF5bEZFZE01T3JVMWp0VzlXSWYy?=
 =?utf-8?B?eWpwTmhwanpTNkxvS04xbExzSG9uZm1McXpPdmpFMkNpZWFsN2pTQVVJZTdn?=
 =?utf-8?B?N3Y1RVk0VGpoYkMzcTd1NzlsdmZnZUJIbkpDbk10eVo3MDZQTGQwREQraTRa?=
 =?utf-8?B?dmVZUDdKdVBETkdjQTgydWlRSUkwdjNmNUY5V1kvVW40a2pZNzVUZlR6U2Rs?=
 =?utf-8?B?NGE3QitNTEN3Z0dTWjdjVStxeGdPU0dwb01RWUx5TWxzUHJYTDRrUlZQQUVk?=
 =?utf-8?B?RzBPVldPSXhVdWx2ZHZ0MG5NK3JRL3hEeDRYc053Rys4OXBPN1BOSHlhQWp5?=
 =?utf-8?B?QUFyOHpwR0duc2RqZVJOektpR0ZnZnNGSUFUdXNRbzhaRGlpcmRwY0RLb2Za?=
 =?utf-8?B?SFFHNFdjN2NHclFkVVdNUGhIMFNMSEdNRitJbWV5UmJyWlN2TktHb0pNYmZy?=
 =?utf-8?B?aTEzcTFnUVdwemJsdGxnaGVLc1AxdzcrSVBIT24wT3ZlNWNOOFZ1WEJZd2Zi?=
 =?utf-8?B?RlVRc0JqTWcxRTErV0IrL0hVWThYWjNFa1ZFamdvTzgvWUtrNEx0bWVFNC9F?=
 =?utf-8?B?Z3dmeERPVlg4SkNuVTdmeUV5U2F3WEhjQ3JEQ1hGRnoyTkZ5YWZFS3NycFU4?=
 =?utf-8?B?RjN2SkpNdWpYYWNUY2FwcUZQb2tOeU1JZDQ4V29CR1pJRnZkaGhMYjJzWGgw?=
 =?utf-8?B?eWhIcjN2MzVCVzNlblJ6N3FEZXdhVGVsZ09IblVDMHNrV1NTNDArNTQralh0?=
 =?utf-8?Q?SRwplW1xzQjjGEl3QND1jclzn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 44VNrZFrIi9xTcMblhYTTQ8O5tpg5jiridzr8rygEJwGbBV+Meb7OxR2pXaTaBFv2/C2J0TWDVUTLeV+Qw06zJ6/vIKGtTTmI2WcU9sOVawa19ppIHyG8NLk1T+ZCpFGdOnERdOvYbfiDp4/FT86AOOWhM7bsAVGFPOA3CamlCeB3NPZCOYYbSBHA2q+dDxa75Q3b+I5f0TZ9vH6Zz69wpUqqw7c4CmOF70O/DDtStvvpdxw53j9CVr0IZT2DxKz/0GIzj5EwkdO6Cu219dZ/VXy4/Y2YNCRjkeY0NT6fDpX8sw/AKufci3RqAsgwkkdKUFdZRtku9NqEJ93IYiTZ2O7koTxCcu7tCtinK1LWGhh7vjIB4G9iokQ+tjwS3i01IrKO7WRBowypjT8mjS+kidsXI3/HDb0xjLTNs/oQUkWLzGzdHpcn2n1UZE2WHiEZmM5O2OVDX113rIPEx2TBiY4lyD6UShCl0qX6333oNwHwRv5WE13gGvdOf8O8P4d+CbBfcfi+WSSelUwZEUZ0B1aPh/3mYP+SKFlhX3rLu71THU0ktC4zMUmaRe8cR2NNRid0drrf8vKRDXXAK2OIakcdjsNVoZCQK3ODcDT07gFIGTExI87w/cZdIJ6PlaL9n9qpSjU3VRyesZf6m1fyXgjG1xzWWiWA7vlAURuiPlR5+3QZeyYRy37fA8d0yctxG/yGzDi9YEVUvVAGomhdE7qkcE8ziqtJkpsm790QrjWN2P08qC+NI43mc1oqHaI7rNAZYxkrQcno7oq2BRaZA/lyPgSXSST738RMepUX4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234cb0a2-8f7c-4672-30c2-08db2a0190ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:44:02.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpM/h93uMujrtFVcSpWjMVlgzt8ZSUh/2YF7IQm9aypV1NvG2YoqRZ4BvSTw5GeYMHsS1CcVv+HbXl/T0tWblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210092
X-Proofpoint-ORIG-GUID: GkKb3BXfG-I64e5QxggUuzym6VhlDdmQ
X-Proofpoint-GUID: GkKb3BXfG-I64e5QxggUuzym6VhlDdmQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

