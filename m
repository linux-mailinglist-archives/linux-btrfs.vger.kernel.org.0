Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0547DB248
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 04:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjJ3DaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Oct 2023 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3DaK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Oct 2023 23:30:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE07DC0;
        Sun, 29 Oct 2023 20:30:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U2XtRl018906;
        Mon, 30 Oct 2023 03:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=T8J9tcq+2IKU2ImofsofnoxOqN1kNlv4IFCgj742NLM=;
 b=HwUd+c6rUFV2bsnHNu9AvC0YAy9L9xEVnFqapRAhzGucKOjMwJG7xSMB+lEMmr8oktUS
 /prQkmngW4ECImIxNxYbTltLwl2c8sxSrvHOnjEteMyXpTn45Jv3r10zr2Nx8nu/J+or
 ub6lVh5Vu1STEEk5r8BAfcPMQceynSJbNNzqM0mZkmtaOapehbXjBfFEX/fBOojzTPRe
 zlMPaG7SgwLhWmkI9vRpQHSmk31bxe74NMF7oe4lshSorxt8bhOwMDyev0qziS++1kzT
 1QvKk//8kk5zYH2PpQ+C6r60U+aR1EvJjJNQ8N6yEAk+xu8PUilIXauXsVYELsH303W/ 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdhs38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 03:30:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39U2FBSB024838;
        Mon, 30 Oct 2023 03:29:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x3jdh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 03:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2vg3oQ1wkdHDJ27Sgooyq/q3SywCbG8qomWosh8WbrMMiHEf8uBCV2oTlI6ae/Turyx/qlKVs50DC8Z43BkhVXnBffr3Y3rloXcVR3yB42o2BDbRXOwvIgX1sejNppNvmJxv/Z+e3BKW8/arGe90KbTSzmdSTPB+Xa29XF/U8lbcQL4ACliX2kqAjhUkgVBkwlAScmBNegDflbscyS6uLPHg48eRj9C9lrMQ1bpqQrZ72lbcQQ1ws7w/0i/AvXKi7BCjZOvLzcMcrcF2UmH38wWpZrd7Zwh7bJ2us51f5LdBV0B4ktoplgH6fv2mupDAF3gNmZE+bD3g5qtNs3+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8J9tcq+2IKU2ImofsofnoxOqN1kNlv4IFCgj742NLM=;
 b=G4tfurQhD21zq+EOfKjvRiTW5xeW9/3e8fNPuiLt3pHQOnMUsbkZe3GWEWDde3QpchPNAkCWpFAbgVB+4h8XUwQtscQf8MhHiFFsfxOIdPgwy/wdbt1IePjFVvO4KbSPehTApBepE/KkadtkwxoIrTGQEKFoclujSQUJvfqb2QxkhpW5/tkhaRkB/29OMDdFVBhzyYpOJpyrw7RAq934FfFX/R1UxQKBN5oiKk9kmmYo/8qxYjj+ER+FrwyZYYtwLBEhzaThU26tsyb3n+x/etla1CDodckT5tevqcb8aD2El9vBXdr/Sbm4LFCuF1rIes+fizp4GI6O811MSjHoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8J9tcq+2IKU2ImofsofnoxOqN1kNlv4IFCgj742NLM=;
 b=GCqs021bpInqLow/LRhHPn98x2YB1CSTa8u+wgL8275K110qnhtL1ECipsd+2Ls8AIGM0bvpij5jrCyEKsFb98NE3JdK7OV2nTLfIIGI4/eoAu10eseq7QLob8rg/bQITd6DX9zEO2R4CNItijFop8j/N9xX0lgvWhVpNVzyggc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB7904.namprd10.prod.outlook.com (2603:10b6:8:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 03:29:48 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 03:29:47 +0000
Message-ID: <fd14e267-1355-4c35-a529-8a34c9a9d861@oracle.com>
Date:   Mon, 30 Oct 2023 11:29:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] common/rc: _fs_sysfs_dname fetch fsid using btrfs
 tool
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698418886.git.anand.jain@oracle.com>
 <678808b10d005e976f5e299816b63c8e6fa44c4a.1698418886.git.anand.jain@oracle.com>
 <CAL3q7H7O2U-Gc7t9EHv0aJSBA5MDouK02b=6RNtgyfg3_crhqA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7O2U-Gc7t9EHv0aJSBA5MDouK02b=6RNtgyfg3_crhqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 72288316-b434-4027-b261-08dbd8f877c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1AM1OJ8G4vm8vhrcFDY1iSmEMJrgJ0wuMYusCZ3XdW7cFHhGD7z81ndUqha7+8jj+TCKrKvARx4NM84rlFgJOH2FTuGcLydxP05jdKyQujZMG/5JYc1IsuEMWt2tFohty4OnfWrLv/HJza1u7c9QeA1nEcY0SBpfilArCtV+kHFsPlPEB1cisRNm7i1/vFAdRxqlZhVVXTWo64mkahZE+ZZTpOSBdV1I+p0xr7AlegcuC1SfnI/PvjZWO87pkT1KQVivcCIn6DYFhE1sTg9zV6qGh8uBILkntMMM88Ej61zGGfFwe6d9tXQ3vHvQYb2PivzHruhRkVNvH9loeJBIy1xd04xd0okRfyt9URwhq6sfIGR9NqKLG4EsJUv5lmMP8DWScckZAdtGIOKRzVc8yK0fbdxWfdBdLStvXXkbe8fLo3bI3bAVqmGW0Xi3gCobGrS/O2fSzISzyO7ufufslkQJKKj0X9x5C60O2ZBycbG4yrA59VGqqJygoNUrB4HN5wgN5LGG3vQ6MHX2ELGNTugH0MH6WFoeuG247osAWG36g8ciTyY5Pd4BmRpY7rSkm5fDrqSoLxW5zSw5rXeY0ILf3fPQHkrvc/VQKnqM2VPmXDvsepHbz/RZhcNj3bzhSXmCMjjdxClWASNl61FcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(66946007)(44832011)(66476007)(66556008)(478600001)(6916009)(5660300002)(6512007)(6486002)(4326008)(8676002)(8936002)(31686004)(41300700001)(6506007)(2906002)(558084003)(38100700002)(26005)(2616005)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3k5TEZ0ZzBxeTlOaEdtZjM2aGFZRUhoT1F4TzkxZG0vQzJoOE1tU0EweTB3?=
 =?utf-8?B?OHVaMDJ5c3ZKUEo4U2JSaEF4NkRaT3NxQjVhTGtVRFdMSGJVMVZ3bzlLTWxR?=
 =?utf-8?B?d0R2ejJUbDZrNFlOVm0xRWtRb3ZpRUtTTGlONHBBOXBDTGg3N3k3M1V2Y0Ri?=
 =?utf-8?B?VVpQK2VXd09GSEU4b3JiTUF3eHZ5RnJ2a3FBanZPbityUVZHdjd5MjBlbzlC?=
 =?utf-8?B?ZythUm4vK1BWUXc1b0p5K2o0aysvRm1CZU1XR0JoM3VxSVlxdklDcFpKaHFY?=
 =?utf-8?B?anBDUEZKQUpFNFlRVDZLUmlWQ2ZQVDNTUWFRUGcrQW1TSWRheEhCZWI3eksz?=
 =?utf-8?B?VW0yM1VrelFWSEtZTjdLMG9UYXl1ZjZscjhtUEtKR1VRTmR2V3gvdDZkZEhs?=
 =?utf-8?B?YVN5TllPTmNJODhldGwzbVlERDhwOCtuUFprY01PeG9BTU5BWmkwSFViMS85?=
 =?utf-8?B?QlZNMklLVk80Ky9qVU9YNHZrekR0Um1vcEJMbWFFRW5KNnBrOVI4eDhlNDhp?=
 =?utf-8?B?aXVxTUxqZVYvUk9KemtJZU1QOVNZSDNTVmQ3L2tpQ01uNy9QNnBpekNLSkw0?=
 =?utf-8?B?NXZhQWVqdkswd2lqMHlFMkluZXh5OXpGejZkWlZTcXQzTHowZ1NlZXJ3aGdK?=
 =?utf-8?B?ZjNhMmZiSmZubnE3dTY1N2ZXbXA1dGxYeUt6MmVpTVRRd1lFYTRydHVTWW00?=
 =?utf-8?B?M01sT3pPRm5ER1NYbk5WTTVqRlZwS0RIQkxWL2c0b3BKRUVwb3VqMUxId1Fj?=
 =?utf-8?B?dHpSN01vMjRJOFhwTi9STVQ1MllTTVlBYnl1Y0xPMVVtY1kxSEtrQzdMcmUr?=
 =?utf-8?B?WWt1L2JZL1VRL1drUU9IcGZPZXBJd242eElicGwzWVQvTkZNR0hmcVhvMWk4?=
 =?utf-8?B?dGZLZzV6cENRZ0NCZi8wcXBSWlpTZ1RMaVBDNXpxSmp3WFVHYWJtYk5Jemh0?=
 =?utf-8?B?WmZkeWR4YWw5eEYxb3YvNW0zR1dNWCtXNlREK2VCV09qUk1YYzgwMXNFWW9O?=
 =?utf-8?B?ZURKQlBiWVhTZWhLOWNRd3dQWHpqWjJ3dVdiTGFaTHV6c0JiMi9FQm5UbThI?=
 =?utf-8?B?WnhwWncvcUhFb1FLUWlyNkNGN3pTdk1TVEJTZlZvQmtyM3lpdzRGNlJLR3BD?=
 =?utf-8?B?V3VIZW5jcDFWS2k2ZzNtcnBubU9oc1VMY3lKM1hmOE1TZWJzN2VvYngrZWpm?=
 =?utf-8?B?L3lmUE5WSENmd1Vield1dGppQXFZVVB2TFZpbDhjOGtTc3dNTFFzUTFUNzdP?=
 =?utf-8?B?RmQ2ckdPTzFMa2p0RjgybFJUd29za3ArU0VwSk1lbk9XMnFGcVBNOEw3TUFk?=
 =?utf-8?B?eGxwcVhiNG8wVG0vamQxVVF6YjkxOFdNZ2hmclhONi9wYkEzYWdHUHlJMWR2?=
 =?utf-8?B?V25pMVBQRWwzdVZNZ3lsWDNDUS9YeXpiRFlmWWhRUFFpcDNFTEVCZ3MyM3RH?=
 =?utf-8?B?aUdNVm5oOUhDYVJXN1d2T25HNlBOT3VTZHZ3Zi9hSkhaWUlydjN3aWF3THNJ?=
 =?utf-8?B?U0VqVDI3WDE0azljTHVSRmVzaC9YdWZQUjVlVWs2TS9zVVQ4ZDlpamMvc1Jr?=
 =?utf-8?B?T2NmMkppNUtWR1J2SlcyaGhick1qcFdBRUYwSWNlZWtTODJJTjlJOTZHRVdR?=
 =?utf-8?B?Uzl2YlpXQWd0a2QwaFAyRXpyYzB4Y0hySDBOU1ppZ2tsd2l0a3VVcktDb1Zj?=
 =?utf-8?B?QW0yMkhQVVNVNUZaZ08za0doTTVrbWk4V3VtTXdlQ1RlTDdzSFo0aHdKODc3?=
 =?utf-8?B?WVNVVWQwNUtmN290bHgrMFVpeTFSUytETzZuRW5lK3A2Zm1WaFVDTzJJK0F5?=
 =?utf-8?B?ODVOZnpjUVYxY1huT1VmM3N2enVweE0vaG1COXBla2w2NkZVYkFBZE1nWDBo?=
 =?utf-8?B?ZEpoS1RZcU1nYlJncjM0U2RrbTB5a0l6cnQwUWhaVWUycEdadEVZOUlSQms3?=
 =?utf-8?B?b2ZCS3hKVHFzWExYbWNOdzhWYWNPZTRKYjJ4NXhtTUNBMHE3b09GZWdNWWZI?=
 =?utf-8?B?Z29SSU42UVdhTVp2VEZ0cWtNU0YzTmgxUmNvemhJWmFxNDg5RCtZaGNmTi85?=
 =?utf-8?B?c1NlWTBTekJsak0ySmhoODU4K0dKRm1NTXFmOUtGZWplNFRQb0RUbWM4em96?=
 =?utf-8?Q?i1Es1yf6CUsUscjtBH0Zbx+I8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wj1oqwAWfTqJwInU34hqEBOxzIVDMHqa/7JXX4gYaOh8kGhE4agW78WPkjnBoIpAPRh001zZq4VAccTx0QeMuBP4tzccEjlg0cANm25ggzX2yKOA5/hIZT+LGkfy7aKgERTuYFm/SKXtM8eSww7vgGWsevPS3WuxMt4AKmIhxtoHcelp6WgcayGvhwzVJLP45uV7HCf/99uQDHlXW2J+VjXNPhjbY3ooHhN/aHXzhfweb7c0ZPacOkj2jWgWW0dpyTRg4Zy7Z+ku6iFL6SndsbyCggMyX8QgWV+vmA6Z+HEj6KV73prF5g0yxgsIvuXR19/aKCPeUQmCFWUKnJ9pbSmL6ufdKtBtT/6uC6xtR4NALgTp5H9un2mOtyIrDcHBfIFZXPjR88UdpRLQry/XlHBcr8JfK60u/fBNKU+72D1T+YvLVDk9VxceIVLpFDa1CF1FmwwIKt8BAl/ErcfigJuWj7arIEHjVZLJ5nG0EFxfjSQD5WZQACH+zsVUOuLy7h00oUH0t93uSX+S5MSyRgUxzB47GTYDDujW+hF0zwLwTQLOINyiNljSPyO1DHyuiaJ1w7YMTTf71OupWP/jPSVirGaV4DXyXefJbXxLuv9DxJqGtJGcx4IZSQM+rdoRst2s4XyjAj4qtf/LQr4d1zy4EWGlMtIwrdkN8wI4iWRcFVtpf+izjhzWH2QZjD4gg/K040h3ZF6UIziJoryM3BsKRo7tykDqmgOKR11SgmFKfSwCsufkaecpuU8Ah6kpeSCLDlOk4plMxY61YMPK0hjcV/VqgeRUxZg9BaWnOLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72288316-b434-4027-b261-08dbd8f877c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 03:29:47.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSLeWQwyN3UnVnaXlpC3dXvfMOH+OhOqe4nbVvGUiEYDNuGp+viDrP2RRt6Bu1RkKJ3n3/mXYCXCt2VZlEmtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_01,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300025
X-Proofpoint-GUID: PZI2clXLglYsrbKmHWRlUsZRzD_r8861
X-Proofpoint-ORIG-GUID: PZI2clXLglYsrbKmHWRlUsZRzD_r8861
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>> @@ -4728,7 +4728,9 @@ _fs_sysfs_dname()
>>
>>          case "$FSTYP" in
>>          btrfs)
>> -               findmnt -n -o UUID ${dev} ;;
>> +               fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
>> +                                                       awk '{print $NF}')
> 
> Please make the variable local.

Added in v3. Thx, Anand

