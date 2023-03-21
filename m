Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457E6C32EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 14:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCUNcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUNcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:32:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8DC64F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:32:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiUpi010827;
        Tue, 21 Mar 2023 13:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=vG3wB3kxsBHbqRk1xw97iCEG1lJckoQp+zX3+am2JfYCldXpXyfFyWcdfCcQ5m2kByz6
 KzdYCeI0BBFOrU+zfE7bgxvRMJ5KFlPhkf0/Gm5lyjwdHNcr3aqWJu5nHNoG69kXMFlO
 AJ0G2jX720fp3ytt9TqIw0W6pxX/BQEpe5Nj4C26ghlzoMgXITCE5dt/gUgt7NS7ozLb
 Ya+VQXvJ7AtsbmURB9WfDyNe2/tFB+ffYD0TmowXGxeSNar0rWEpoXPMj41k8spB7RMu
 KmHrNQPGE6cbuk2MN+7jxVTW6PS+a20xxezu4sagCsaQ7xVJp3Vx2oQ5j5lm2T/gJxYI Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56ax4u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:32:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDFA30015507;
        Tue, 21 Mar 2023 13:32:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r68d6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5ighdawvSRl7ypeDTrB4Fs9flZ0dWfWKGW3diN7NnoJz2WLD/nULQIzlEjxs0buNdtkkrpYvWg1Zllc7X4yxfH2h9NdKnGpbVjLA/AjVSyFgUy26pX8ZkO+owEAkXXSOjmzch+DhHRXJN/Icu6BDAXnNv/dKF93ppxkzjQ6zAORtixefXfcB3qB/URrwg/pfBuKTjxWp1srcVsKnYBdCXAGKw0hkZeJLQsNM0NJ4huDsjcpU62j51wWhKzcQPB7W/JCxaaw50Z/ii1uXHxPWJQuSyGamCssxxWRQJ7KXjres0Xkv5b0CU3L/U9kzkR4PL0WImdolqvRuWh8V8QmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=CJYTVJZfCvPnxpJ+QBs6f4PqwqbC2T63TmLiRM88aHr3REmqtw36+UGpGPjKDTPvQb1RPf+sBXS+VdX2bjK22I08AKX+K47jx+UbxF36jR/1e2x6BrzttQg36a2goY4w9znv35/sXM9kMSxGTxE6qbptAunmRXk+MAFgcJnrYWki8HKbS8a4LlTB3n0jyaHnYtiI2UU87fEoV/dZ2ojcRVNZ1iAmV+PAQdMBKsWXKiiKjYoJO12Poc0/rQMCEfOG2HHdYG8+06pyE08Wc0ENrYlKuytrRlbBnxspffiVU7QR0Ac7LRTMs3DxIGGBxfwUP2mxJRzzwj7Sh221dYpy4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OdtmPlazHnpRHndsJ+a3x77kjLaV+MUYhJYuBppgaY=;
 b=QL25f7ib0kXpaeYJ/k2+nwxdTXW9KjJmpFgbj9IYnVdUZq09yDBJ340IMmC7fsc0p8JTBlpD/g+hxZlc5hMgy6R/8+i40pxH/VihSYPBze5lYiigab5xOnhi0MF8Z5ktuHFdRbTnh8Smr6N0aCiI2o0Y76tm57HkYCEBKZaOyg8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:32:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:32:06 +0000
Message-ID: <624389fb-2c24-2e38-f276-c166ae2f39a6@oracle.com>
Date:   Tue, 21 Mar 2023 21:31:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 11/24] btrfs: remove redundant counter check at
 btrfs_truncate_inode_items()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <0618e34a343facf5c7ee34d0021ed6476c655a55.1679326432.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0618e34a343facf5c7ee34d0021ed6476c655a55.1679326432.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 569289ad-3edd-4ab6-3aab-08db2a10aa06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvZyk5Ip05mzIQGPjvh5xF2AQmn8R7TYi+BOkxjF1E5zhM676s6rlSeLMgJHrfxGKoIsokF5rlmKVJladIYm2HH2dGUCIJeY4FUrWrMU1vXctnk7KAEU24coidX5N0jXI/sV5zKofpQsU69XnGdD7MybFvF/2UfXfdJD+r2Ab5sGW1XkM5n50Sub2CXesWSK8wZhk2PShsr4OqXoVGlA40xuZ73BJEWTeZjWbaimKkj2epiSaA/Ono0Z90w+8SM8f9t8xsVG3Hj1SliH94gY6mkMhEwmQlchT8XH8zgkEFFb8zWiVnVTRi6C8y90CtoVSK8GH0PuG7jwKLlCTZvU0wSSXxZDgk6cGoOaPSTmQCDWBDm/vbiHkfzxmgK9FntWqoYfjzk6DvaBpGkjK2KijohuFVzNTSLNnWUZtBPctF4qzSpne7Z17y+E7pRTNj6WJthcvAP+cW5jOMcIrA6BdeyqViODTpZL0qhSL+0vu27J3rQBfwStE1oWLQOl8fW3kYD3eDa2EdOLmOtBpvd7B0qUAdsE+hs9t/Uul7RQGp4kyVSWMRXplESaymedPQu9WEnbGI0OkDbP4A2exQ4UacYtVRrQbR24HllU66+YzTqTgwx/SA4Dq7qXFzrOON/kT3jMvkViaudUi4T34OJU65izY/yg99WIlKma9mMGUeBbd2+lRfQxddlfgYgYOT0wAetd4Gx2ZxvQVbZaALnCNY93kyuNeHa9BhYyN5YEB10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(8936002)(5660300002)(26005)(6512007)(6506007)(6666004)(558084003)(478600001)(66946007)(19618925003)(44832011)(66476007)(8676002)(66556008)(2906002)(86362001)(316002)(31686004)(31696002)(36756003)(41300700001)(6486002)(2616005)(38100700002)(4270600006)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JaUWlXRmUvdmFRczY1cjV0NFNIaExCdmM0aE5QaGZVQ1FwbEM4MHp4cEQ1?=
 =?utf-8?B?RWdoVWtVb0NYVmdDRTVSUS9UcFRLamdWNlZ1cHkzVDV2b3gvQnoxbXY4Mlc2?=
 =?utf-8?B?cFNKelQ4UkY3S1NENE9RL0FkWWJPUXNyQkRGRXlEcnFqeTh3L2YzVEhHZ1ll?=
 =?utf-8?B?dlR1NzdFTWtmdldFWFFySVNBZUhuaTgwNjZScDNoVG0rU3R0TTY4N2dCN1li?=
 =?utf-8?B?dk5oZjU1b2lldzl4V0EwSDBzM0dOL2pKeXV6RGZ0Z1FGSUxITzVtaXk5bDRU?=
 =?utf-8?B?d0VyN0UwdlhiQ2QwbENGQU8xWTVaZ1U3d1Q0Z3RIQnlLbk8wQU5reEFleDFp?=
 =?utf-8?B?cU0wRkJzbFBWSm01aExxTUFjZnJMaWFzdGJoNitzVm1NK2xiL0JlM2x3NXJC?=
 =?utf-8?B?RXd0K2JERkZWVVR2YmsxN1RlbmMwZ0RkSEwxSldlYUpSWFJLUm5HVDNnNHRC?=
 =?utf-8?B?QXRESkMwZFhkNWtNVVRSV2s4MEQ1QXZXeWd2OGF1MDBtRHpIMDRmdHdRV1Ix?=
 =?utf-8?B?c0VNWmY3bW5lNDFHOS8vdEh3bFp3V0FTWVphbVRNV2YzMURHbFg5Y1NjS2o1?=
 =?utf-8?B?ZkRxWUFJWTAreHJETFg5dWxlV0lNdjYzWURRM3lYMXg2TGxuUC9BQUJSTUFv?=
 =?utf-8?B?MkxiSGhUT0d5aU9qS0RzZHF0TmttTXFsd0dzV0NMSStLLy9lUEtOTWVWQ0Rw?=
 =?utf-8?B?bUtuTlNWNzEzYkpCaGFMYUdnd1hROUJiVm5vN0Z3dHZiYTVpTllUOC9XdUk4?=
 =?utf-8?B?dy9yV2dIK2FPa2dJaTFHRm5mVi9ESCtiTkVxbmZQYWR2M0J0a0xPK0NWU1M5?=
 =?utf-8?B?bkNUL3lTS002RHM2bWwzdmxjb3VpdDRyc2lzaG51bGYyWmlpdWZvc283bU1t?=
 =?utf-8?B?WTZVSGtoT2p0c1B3dmw5d2UxTEZYYm1ibGF1UzVncGFkT2orYytHL2piZWt2?=
 =?utf-8?B?ZFE2YjZHY0d5c0xib2V0MUcrRFVlTXBBNDZVczhLMG01aEkwREhJWW5RZ2xV?=
 =?utf-8?B?T3pvcGxPZm9na24yekdva0pUb29EMmkwak0yaXVpOHIxQWtiNmRSSGkvV0ts?=
 =?utf-8?B?MzY0aVFFL1VQak9IM0V5emdNQ3BzQUtNdVNZNVRTL1A4RlNhemdYVm1kdjZH?=
 =?utf-8?B?cFZkdDZvRm1SdnhoYU8yc3hobnNVU252ZnFzWHhXcTl2dFFobm53eVU1aUxZ?=
 =?utf-8?B?NnBvR3VLdEgwSG1wUkx2UDBLM3VpRVlqNWJ0NUg1ejEvV3dMUTdhRUltYkJX?=
 =?utf-8?B?dG8reGl1Tm40WU0raWJzaW0zaDBaMlpXczhBTmhCVUovcHM0YVFPdUwxMFVu?=
 =?utf-8?B?NmVnSlZrbG43czhPRlFNRGZGMm1leWRla1dCNTNzTVpxM0QyNGRJZEt5a0c0?=
 =?utf-8?B?SW5NNTJSbFoySXNtT1BwVmo5blYvKzUzMGNhejUwQktDYVpZY1BvL3ZzMFY5?=
 =?utf-8?B?TWkvZ2pXU1dLTDhiUEVqb3RPOHROS1VOQjdnd0s2bkY2d0NDQ2RvTzBOdmFE?=
 =?utf-8?B?TE5ZamJzTFJ6UTlid3cvaFlkOTJqQ2h3THVkbkduV01zbG9BUFFJYzBFc3VH?=
 =?utf-8?B?SWtuZmVVVzhLUlBndTRYY0YyNlV2L2p1VXY3KzZmRWNrZVliMlZON2thWng1?=
 =?utf-8?B?MURRck9yWW14dHdJSVVzTEZwMjM3WFppNEYvS01kK056WU5SQ3pYbkt4dGhj?=
 =?utf-8?B?WnArVGpxLzlrYUpZTkpibHpBQitlWjlUVi90NFdUKyt2TVlLMGVLaW5nOElD?=
 =?utf-8?B?R3d2eUhMbjAxUXRla0hjYy81aVYzMFNHOVZQTHJ2TVFUOGxZWVNvMis2ZWZU?=
 =?utf-8?B?YkJaTW9nMXNEN3BqWmNQbEhPVE52QWw1bW02WkhZVjJFZnlUYzFFUFhHd3BF?=
 =?utf-8?B?VCtUcGU4MUtHcTk2Qkg3MEIrMXR6OGhmMldvVDBqMXREc253UW84KzR6U0Nj?=
 =?utf-8?B?OUh2S3hsTEhSZGI4dHZjNHpGWG8yMzltb2xjaUMydlduYVVRTDgxOXBDSkgy?=
 =?utf-8?B?VUxaU3BPOEpQVG9zamtLL042cjFSb2kyVWdrSEUrdXFMTFBRWUNTbmR6SXds?=
 =?utf-8?B?dktzczlJK0ZpYTdLRW1VaHB6bW9OVm14cy85N01VY3ZuZFhKZ09vbGV3dTNC?=
 =?utf-8?B?QmR0a2J2cGF0OHFzWjc1L3phTnpzWXQyWlhLN3l0cGFTSmdqdmY3NTZ5cjF0?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7ZaoNcR8E8iuwqbq/ML1SxPahWGpx4F+6//NgzzSKpg0sHWF2wn/R18Mr9Yxz2X+f1AknOE+uxXIpHUmXD0pmMoTRNrZfKJfUVghgvCXSlJYfe/fzn8Fc/1uLkhuCpAGKePGjEtCmutaH79lODpX4pxRGABfxELglIi1dI6TctKz6LJ3DKWyCtgTWRPpTjcoIQDb8K0bOuhtM3NCczZbpjM4HMvvEwHKHDNBQ023AVnFdQuWrel48SeSh97+4h3Dr4BQbfhWWzrBJKVXVDUq5Ja8R+7nWa5UPwEpUP6DemZdmSvQiGi1XqhmZhfjKQ4A+x0QEIsC7e8lbLtEz0irfIrqCDs724+zBMfHQZz0QY5LPl5yhlBl00y6C8W6N5a76j564MvkMmTVhP0xALocL7Q9d7vpZ6gvlWmnfTtYfzdbiLG7ZmG3G8V3LAokfst7w/yZ48Wou8i+fiUDLpuPn1Ovl4+uWYRhWzMTQjbjo9CY72iDNZ5Rwkr7hd6MiP7vQ1MsQPrY4YylHOKU/AwqRh5vx0wkT/EsKT9aT6V405krsA8lV9wJooG+k9cW/Cs1D+o8GVDM9Mf/EXEENoHQYm6T1IVHJ+tEXKUoykKz+5YFwMNp8AdXOjU0ufzlFy84PhrGyHCWFoudarc7SoMj58z357BDQfNMd73t7jv7sw3CuHX9KiGWzEGKdn7qkUEQ+6IWbusP5HlG+OwaGg+PKA+Yp5sddO/3paZoqJOKhH04HB64B6X4yPFfiv0iLAmxN881GIN7ty85ecFVFQcsJcYjqpdR0JuiaHdFEbZYL2c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569289ad-3edd-4ab6-3aab-08db2a10aa06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:32:06.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OUuIP1U2Aaj96tNIZQyMYMwwyYH2NLqDp/3r7QCLBETKYVhFg5QswXNaa9xAnR7LZzyan/g0wmfSyIy9cIkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210105
X-Proofpoint-ORIG-GUID: D5wcrm7VVeaXWtbIqt971299vyIdRvbr
X-Proofpoint-GUID: D5wcrm7VVeaXWtbIqt971299vyIdRvbr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM


Reviewed-by: Anand Jain <anand.jain@oracle.com>

