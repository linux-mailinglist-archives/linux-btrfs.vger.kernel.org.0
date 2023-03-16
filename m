Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE76BDA88
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCPVD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPVD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 17:03:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280331E15
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 14:03:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GIibF2009214;
        Thu, 16 Mar 2023 21:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NV14R7swsxrqIc/c0JfeV3x8+pABkT4UpKnU3AVIH1g=;
 b=MgDSD2Nz4+y3RD0mCA9jXvnTeCJ7b2KnvTORFOpulPZnznE+0w7tiwwjd/uXQjAMSvrg
 vv6e/4P4Sc91NwsqqrHS+shzKi14FpzkOLKnnFDFvzPn479aV4p0wODNBRrUAxdA9bLj
 lyUYexQf/uJiBdcDOQLLKQZndqZChVZJO/McNsKWa/RsKcC9nTV/+S34eXn1TzS5BFwo
 KsJDdqQH+in6oxk2PeaZvoia1uXLpsv1VkHD8fozFJZYLH9d7Ne/w1vlSdtt1/mhJtyV
 OwdqteYgUnO1G48oadHhKkdDmmR7zf0im7L40SUKHvLznXATiuvoK/n8owK57z9Snzxt Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs28j9nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 21:03:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GJqtRP036908;
        Thu, 16 Mar 2023 21:03:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9j4p7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 21:03:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltuVQPHBvMBLzc/KkpH9Gm9Esm2VngGtxC4OPQzchvMcaDwSKQksmwGrB3FWQGh9nnlQGe+a4QQjVuQ0Q9ZgIqG/jtLLTjScwiNjXUuyacwW5LsbF0EQnJRHDH0rEmohJYZDEWKG075Thxf5XANKQTo19/Sol/DVCIw7CXFHoLmJbaMWpJyVEroi0CHfanY+EQHJBpml4ezhSplrQBYnFAALUfcI8gvqGJR+DJ8BgxGckuUNW8DLxm9gJf9H8eSLbkEsIp380napieDabzFmOocR9Ff1HfEfxHcRnv3fXJaoDz5l4GnKM2jEThGMAhEkZkvLX9QDIFuhXnwm9s8eSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV14R7swsxrqIc/c0JfeV3x8+pABkT4UpKnU3AVIH1g=;
 b=glPau+0g1mtapzWVLy0MplGit2KHWO93hDxGNH5cQmK94RuD+i22Ivc1C1nHJ/JEsU2cRgpnZjWDxXv44KUFR0mlsjsy/rduxmJ7sAF9rrHeL0s+ZdVlLiQP6fpk7KpfK60QWfv4ghtk+H6oMcbqyYM4w0QHYl65VZ8aefzw01qjPaST3Oe2W7Mp/uVT2ThJcTSRFdMPp0heJKjyp4NV0cCpu0QH8ay14iThJAsJ+U7yQR7LImTuYYRonMpYntwvDTKrey/C9dVbVpLy7Z2dy6MNurbu4GO6p4CANQHHMpu9moeUPmWxWumGL5hSp241qAwcsZwHeqzXn5W614R6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV14R7swsxrqIc/c0JfeV3x8+pABkT4UpKnU3AVIH1g=;
 b=enDxWkLwES89o4os2ljff5lX5T3chebLGrOKqjwzBLpHY9vf2igkZfsKMDYNTs1J2fg/xAbk/oZFUeODLYYfFTQbB2GGjK8s3JKKEDwDFD6eATFS45JNvQ4ga10/nO3LV0A5kR7zNNggLcxbaPlb6egYpeNkBm0XrZPanNdjtFA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7375.namprd10.prod.outlook.com (2603:10b6:8:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30; Thu, 16 Mar
 2023 21:03:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 21:03:51 +0000
Message-ID: <0ee99e6d-2eb7-a43a-3c9a-4023f7aeb5ef@oracle.com>
Date:   Fri, 17 Mar 2023 05:03:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs-progs: documentation for discard tunables and
 metrics in sysfs
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4800c5464b3fb4ace327180ffe32c378d6356e13.1678709623.git.anand.jain@oracle.com>
 <20230316144806.GX10580@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230316144806.GX10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: f56bc107-d54d-4a3a-1c6e-08db2661f14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Wydh7tH+0BASL3Ix2EO63fWFFY5SqHKWzyKNgCvgS9Lo6AX9rYheFMseH5HLfefC40sYXvVIP0wV7VY+POuyo+lgzZKdseH7ODqh8UuwqgjkkBhkqC4qnvZ8TpymmHKEWDyjYNBz9QH7IojvIVdajJSEnoTJ9CXuZYkajQn5DUUrnHE/pjK/l9cVqjawlIXs7d5ucAoh/RE56OOYPy92+9rcB4SE0pPGYG8iXk0SHg5cJatOig+Y7w/3S0vLZrdzN61gTEybRMhyPSpyvfaRSU/H2IZBslbeKm/4tV4RV/dgssJ+fSTBRviMt5D4VcVQBWsj9Tr7dWnICpwkhu0t6R+2lR9dWJKIYAV7/DPeTfaX1xIOaSdVJYyPC3oRVC9h5bcXOl28sD0Qd8Me6I+nLO+9MGIhWnMl98e/sRRLl5u/U8C7QlirbgwHRbeFYg0WE/FQAq+GVcPDEb1dKXtu33t1Fv6YUzWQGGFO+qkW/Di8jVYvjfOkKrtpXit5OrYE09LvmdCD88jCV2eVe/zNvbQyUXrG+RpeU1edSlwj7zLFWd9ukWiNY7fRwpj6/NhO046rehV8skwuxdBJOorr7KVYV0uGagdkbY4aMbchUBFzRDqiehl2B7FaUm4rlG/I/hcgrO8KD7QDFTnLhFAkTFmcxjxzCWtFNVlJcf6THO1Zcmufmm55j4GwwcU3y1KoRQoMTOzFbUCZYuIUw+bEedFGL+navxlWCkNMGGJcxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(31686004)(8676002)(2906002)(36756003)(6200100001)(44832011)(5660300002)(8936002)(6862004)(86362001)(41300700001)(31696002)(66946007)(66556008)(38100700002)(316002)(66476007)(37006003)(4326008)(478600001)(186003)(53546011)(26005)(6506007)(6486002)(6512007)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmp1SHlMc0E1eDkzY29hOXhyNklNWS9zLzQ1ay9hUTk3MGY1OHhKR2dmb2wr?=
 =?utf-8?B?NkV5Si9ubTAxTFViNWQvaXc2UWRBSFliN09jSHdVQ2ptN21CaFpLOUFOdkJE?=
 =?utf-8?B?Ni9RU0RIN0dwUUkvWncvR3gzSURZQWcxd3dNM2NKS3pVVitIeEMyK0llYkY3?=
 =?utf-8?B?dS8rK01XUkl6SDVZQkxVV3VZRXRDN1RzcVFrRWg2UlprdVlSanVDU2tKSHdO?=
 =?utf-8?B?Z3pvaVorWFhYeVN6Ynd5T2d2VFNxY0lZVFZJSU8yVGpIWDZJZWpMNWFndVBy?=
 =?utf-8?B?L3Q3eVNDWmw1aXdiOWlmM2p0b2g1WXQ5MTdxamJGRTV4MW5Qa0M1R2k5UlAx?=
 =?utf-8?B?RWN2Z3VoU1lMcTBlOWpSeHlDbUg1VEIzc1lTaXNtTE40aXdaTVkzL2o4V2g4?=
 =?utf-8?B?OC9ZY3ltNEVLM0Ficzg4VmFGckpaL2UzbldOaVZYYjh5bVFwN3VJS0FweTBO?=
 =?utf-8?B?eHdBY1Z4T2NPTy9TWjB5aWt3SlUvUExjWlB3RFZQaUg1aDBTYTRTSXdreFhm?=
 =?utf-8?B?UWFlcWg5NHZWb0hESThaeTFBcFJIc2RxVGxNT1JRWkdJOVp5WFBBWHJlNjJ5?=
 =?utf-8?B?ZmJob1VWckNSRXhnMUVnM0VTb2NXT0REUDlZbVZxVlA4Nk1xUnVMdkxNajVU?=
 =?utf-8?B?OG1iaUMvWHpMaVRqclJ3U3ZUQzVXSzU1bnRnRVltZGRGVUdKNzNBVzREM25Y?=
 =?utf-8?B?ellkRllGdDM3OHJ6eGhJQ0pJSkJJcGg3cmRnMUx1czVPOUNSUkFtMEU2L0pH?=
 =?utf-8?B?bGxXZ0pBM3VONDgyeGVjZEpIRWVTeEhzeTlnaUhZNFJYc3JNZzMzcGltNktj?=
 =?utf-8?B?bjZWalBHcDVzOGswd01pa24rc1RmaHJyM3hoM0tkNjVBSzh3OEFlM3NMREhZ?=
 =?utf-8?B?NHN4cXRtOWRGTWFDV3lCUXVhT3hQelBiSDdFRE1OcWNHcGw5VHJEY1NYU0JG?=
 =?utf-8?B?cVRQc28yZGtpcWNGSUVtVlJ4WXZkRWRGVVYwa2FBVVA2MERreDBLUEJxQUVx?=
 =?utf-8?B?ZDNOdkx6UnYrOWV0TEdGSTF5QXp6U1AxK1oyazkwbTFwRlBmSitOM2srazVz?=
 =?utf-8?B?dUFGQ3Z2aFdmZ3NSWlpoYUd1MXRJampsakZQdG45MGczc1d6a0RRRllvWGhN?=
 =?utf-8?B?NUVndVVoVWJPaTNtNkNjd2p3aHk2ejFmcm9EZEJ4dWxFM2swcDA5M2hDdGl6?=
 =?utf-8?B?Wld3WTM2NzgvZ1VyOFhsdVJIbXZNV3NJY2FmdVVXRmRMRHBFZ05Pc2xBQnlL?=
 =?utf-8?B?eU5JSTR0eUJ5MXlxWm5kbmt4YUJaMnhzWUk5elVXL1BEK2VMRzlJOXNZbTFG?=
 =?utf-8?B?a2Y4TG1ndy9SRUJ1UVluMVJGbFdxa1o4OU9CY1JrZ29tbkhSalN3QU5DUlBR?=
 =?utf-8?B?NG50clpsRVZqV1lHa3hkZ3J2YWhJTlFBNUMwVS9LMHpUVGllaU1hTVNTcXI0?=
 =?utf-8?B?MGcyVU4wM2VRcWhWaWI4ckJnUVJVOHRPVjN4bE1BNnBlcWVJUFd4TGoxZzdk?=
 =?utf-8?B?VFZqa0pXcHkrNmwzamVyeDhleDkyb1dLbzhsSWI5MFViemxRT1ExTDZZRjU0?=
 =?utf-8?B?NUN6cDBuMTRoMTRhN1pNakV1bTVUdWpWTHRXUzBZSnRVZmdDV1JiNXBFR1hP?=
 =?utf-8?B?My9iaE5tNVg4THZkaUk1c3hoSWRIMVJ3cHh2WXRmVXZzNFZYOEFoL012a0N3?=
 =?utf-8?B?Mm1XWmx5enF2NTBDalkrWnhVWTVlZm9LZU5iZ1Z4bjFxNFlPdk5UeXFoSzY1?=
 =?utf-8?B?WE5oRklMd2tGWkdhVndKdUY1ZXFoTHloNUtWc291bnBSenVpdE5GU1hucDYy?=
 =?utf-8?B?SytSRE4wbGpkWjVVN0FHQ1I4dEZZakFxdU1QSmczUzVkUGNlekhkRWJkWkEw?=
 =?utf-8?B?cjF0MGtmbHpyWm9DZXl5WW15L3Q5UXJnc2plUmR3SnlFUXozellGc1FTVzA4?=
 =?utf-8?B?dk0rQldtSTRxM29vdklMQzM0R3hpSlQ0cXlNYXFhaWk0YlltUHd3eUU0SDBO?=
 =?utf-8?B?amJHWXVFSWpncDNCWDRVb2lEUmovQWVldDlpRjlmb1ZjRndxQU5jL0xZUENy?=
 =?utf-8?B?QkRHS1JYb3BaTFlBdE12ajRJNk1vWGNHM2tqK0ZTZ2pKckdhTlJqaXR1K3do?=
 =?utf-8?Q?d5AP8/KVVGsnqTCVZFGQtobEz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bQU+/QmZHy6Gy4ytPSUbl+kWsuAm4RYCHM8ENZjW+JlTL1Ayms8335ZPl3MEm8nJOoW/C0rgRK3jQ6F2KAwccOohPNiAHT5SRC1IzM127NC/OIsDUwjfxAFhDBTNYxS8WRHgahdVsdTF3/4cVbBi5xJS+ZW9RTc18we0EuusPAs2gyo9dKrCWc3rj/ohoqEmHVUkVTqh9FGBtIFoYC9lbdDkuep92fSgMfXq/kUpcDDaSAB+vzFXDwr16OVI7I0at35lYi9wRQNh7yi4sGgQUklHwehk+eWYaLZIeHmbqIdPF62wxssCItziSFVALP19jEsUAUav6GImzK0+DMQEhZPRXGej820Tz5tnK96lT1r7Q6pxAcMS76o6jsYvj1FOmd1WieqQlOkoN05xYiIluOik8vVPCxcpgLcwFnb5+N9WqqhY6VNLT73n7wR7y/bWynTRJEuHBzKbTamUCRYnTZ0UtCc8h0v7gmQj3o/1/tkvfQCaSnzfVeYqffIlt8RA9UXChu2vQ3Ta4zl2Ot1HTEhRXPGpIxjfNERjTVObz4KCI02y8mjr6k7h7w0QL2Trstda7xJhGsnldsP32vKWFWJrucJnFBfEp10l2vh2LFee7k2GSMPPwEH4vVA1sru/knhFnii2Z5/q0ISL/7C1wNGOCtZNe1as9/ipC/C916YBS+V3q8RGMuS/e4P5QGTQLwYzOPW3iWXa7Oy6WgtkVyfa7H3cazJ+6oT4llGt8FV/KBiErXuIbNTFq/lsDnatMyC8emq+q/5QjrvWIySow9UlIJkuVR6+wIs7XjynLeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56bc107-d54d-4a3a-1c6e-08db2661f14e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 21:03:50.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLor3G/BMRNSWWA0KW/rJBKb4hDVzbtYnyaPfzIaIMkEzgEbY4B7v46K82SiOdbrCqndfY2RQXXOKOIO0Ztw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160158
X-Proofpoint-GUID: hSmAWZORUrhfyx84FJ2vBX0Ddj7tZRs6
X-Proofpoint-ORIG-GUID: hSmAWZORUrhfyx84FJ2vBX0Ddj7tZRs6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/16/23 22:48, David Sterba wrote:
> On Tue, Mar 14, 2023 at 01:00:50PM +0800, Anand Jain wrote:
>> Since kernel v6.1, we have had discard tunables and metrics under sysfs.
>> This patch adds documentation for them.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Added to devel, thanks.
> 
>> ---
>>   Documentation/ch-sysfs.rst | 39 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
>> index b3cd8eec4c5a..055ebd457d0b 100644
>> --- a/Documentation/ch-sysfs.rst
>> +++ b/Documentation/ch-sysfs.rst
>> @@ -13,6 +13,7 @@ features/                      All supported features               3.14+
>>   <UUID>/devinfo/<DEVID>/        Btrfs specific info for each device  5.6+
>>   <UUID>/qgroups/                Global qgroup info                   5.9+
>>   <UUID>/qgroups/<LEVEL>_<ID>/   Info for each qgroup                 5.9+
>> +<UUID>/discard/                Discard stats and tunables           6.1+
>>   =============================  ===================================  ========
>>   
>>   For `/sys/fs/btrfs/features/` directory, each file means a supported feature
>> @@ -247,3 +248,41 @@ rsv_meta_prealloc
>>           (RO, since: 5.9)
>>   
>>           Shows the reserved bytes for preallocated metadata.
>> +
>> +Files in `/sys/fs/btrfs/<UUID>/discard/` directory are:
>> +
>> +discardable_bytes
>> +        (RO, since: 6.1)
> 
> Note that there needs to be a newline between the version info and
> descrtipion, so it's rendered on separate lines.

$ man ./btrfs.5
   looks good in the devel branch.

Thank you for fixing it.
  Anand

