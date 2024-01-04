Return-Path: <linux-btrfs+bounces-1209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9739823B21
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F58FB24C38
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289135C89;
	Thu,  4 Jan 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="idbExoxK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMwgRG2s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C3523B
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MMCO7002667;
	Thu, 4 Jan 2024 03:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=idbExoxKzYYhkeSQ1tNBv63LdLSArgfMYGGXlTEM8tnGlOro4lnrstmAmMbpK0xRxd1m
 O1Jifv0rARIkylKRHRW5OX4/6ZHiC/P50m2Dxmlg7LOP/jQ/6MRESGcU1KgouFC6bvZH
 WWCKBES5yjTo+/AJ6o6+X6cF4Xe+WEETdmtgnlMNws4JBKmekLGn3lBxzaJGmS9PVRom
 XIXDCDCSbdWDDiALJZikSQ3RPDLblH4P2S3511fAcNvjqgSQscrPEjtJ/qfFyhlA0FNB
 4TV3xRyfuqqfWiWCUwRPWMQ/K/+a/Oy9sjECFPKTkPmRHF35DiVbMReOJKy+YP9BjU33 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu685v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 03:30:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4043SjdO004108;
	Thu, 4 Jan 2024 03:30:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdmt703as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 03:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU/OakthD0tqBu1v4vuGxO40qC7Z2J8M+hVIb22oNqDRMj1GCEyJVPUJerCNzUgqJucJcxE8ete8OGr4E18W9j6zS0nkGFm/ikcv2QBkLZUPG1KxJXhDMMQuJW5FPPP+whhlHbYbIqwAyeuzVNwFKtjoooP5JdlWpMwrbaUEJMqiJVZNpzVHG79nh8g/WJaDzT//AxnXwSy6lVcm7Jr7QGz01yElANLhnJCHrMSeZ7aaufZDU7X0gJPlRUSHzNi7O6kVEnMXNbc72bZbisCpvwx6EVJOPNEm51UjZ6YX2tCwxNoyQ0wTZBxtrXOhnHxlI7/40HJ6y/GRvP2bheawHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=DEVOISy/7hnyzucJMwacMuWwM5EKOeS6TavsFNoBKEYAlLDgyW2wDKt+N2KbvTPwpmnf/oNf4yiFRpnbuKXRnK771JUBQwA767L+XC290c8eAcfNZG9+GfurwGKeTyDCBBfoxdzadMK5Nv0U/6T1AkECfi/fQZ5TFCk/mxtqxW3GrsIizMOGvCNkkQQajD7bYifl8bF6QaBq4C2sET2bTPGs2PRVzpsS+MXntCDoYsAGeCDkKhEAayHOUQj+9YtYl56wEPnWcLRAShRPXu+KiEwkd41J2ZVPPglvPARVL0WfObkpWuDWOX0Wz3Appue1nQ7qc9uMYaTTMqsUawk5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx7z3Z3C0v3P/rgolaVtkr8iChLUONEo1xoS1UPdOyY=;
 b=XMwgRG2sIyRO/kO7e0qRdrUxUgMnz8NYlsCdMO2TDYoqhEbHNhuWt188Zikvu0D7l7COIAT7DjZmgd5FjUqZ1fC3ay0Xw4O+Z7I85UNrYDanXEF6S5uvbttrlwbPlZxYAXjI+5y/qm02ei7DIpcafO8Lhqf9sLKElOZLNNKePiI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7667.namprd10.prod.outlook.com (2603:10b6:208:48a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 03:30:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 03:30:18 +0000
Message-ID: <3124317e-80dd-2ea1-0258-85e209808cee@oracle.com>
Date: Thu, 4 Jan 2024 11:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] btrfs: WARN_ON_ONCE() in our leak detection code
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 707631a0-480e-4c78-08e7-08dc0cd57952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AsjqFsr/uYtCZ8E3paNMa72IZqFQVh1Ukb8k8lw8VvsCYQ1EGWIwKuPW9GWUJ26nUKPiBd9k+inNQ31BrCTMuc+06GO/IdB4kqALO1k3qj7PV9SInxOUzYnRa8n2AwacUNFd2kPc9gXdoikEKK9mmYfyYsfq8eKqSdpM3oY4dTVZdkktlVdTW3OiAqNhbFx+VYIko5+JIlX9O/xhmxxbTT2C/HTGv7wJf6TRfFJsBgt1roj9Si7r+Vp0pdxe2xVrRR7y+g1aCoJCBYdslrpD0SnX9aSkMJ3cQSfJAjZmllNnkRhbx61RBRLvNZejmGLDegh0m3E+hi25IMPKoS8OI45ztQDxt9msM7jxUChs3jnbtaxuSOZw8pX5fr0x2HfFEGv6YhJH+cJGqzGYIfoeWG6tm+jsKY+FEk05xtKiLSPsLpz1y9h0VwyyCFeXbP2MiNPDso0eQkoYqix85seH2hv2OpML8nX/cwmM6f+FGLWwpYgUxITLJs5AQMzxwvWfg5Z0ikJ/olWUyAG0/SxvKydAgGThYFWZpSfNc6lgcQN7jK9E6v8oOE7koaQD29eNYUGA0ZqG6iDqPSYhIjXqseWB1oyl70rAewcMt7GX4vrwurn+zn8dVPHIPEB2Q/eedX0P+zM9gBuoGnJzz9/45A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(26005)(66556008)(66946007)(38100700002)(36756003)(316002)(6486002)(66476007)(31696002)(478600001)(86362001)(5660300002)(2906002)(19618925003)(558084003)(31686004)(44832011)(8936002)(8676002)(4270600006)(6512007)(6506007)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWJyN1Vaa1JNc29UNm1mMzB4MnJuM3BMdVNwSy9lRWlGUnhoM2IvaFgyN3pj?=
 =?utf-8?B?NlN0em5vRktpSDhWcDREdEpoZlc4bWlkTWNIaXVtQk9CRlRqMjVpeGw2b0xp?=
 =?utf-8?B?R0VaWU5vLzlrQWNrelVQc2N3ZTlwSDE4UHNLczl1TkRoamxPWG53blZvR3dn?=
 =?utf-8?B?WHdnYjlnZ2ZObzdOR01JQ3g5L0xJVWNlQWpwS1VaMitDME14WFNYVXJwSlo4?=
 =?utf-8?B?ZGZ2WE9PaC95MUQ0WTFtTmJRd3BaTXN2cE1KS1dHaVBsa2drK2RmU2NmTDdw?=
 =?utf-8?B?dzFKVXVpNjhpM0NWRmRJV0JQallUTFNzNEswWUwxdFF0emNUWmxNcDRDVC9u?=
 =?utf-8?B?eEFmTXZFaXZJTys0SkJjbW80anhZNUNkNGlzaXZraFc4aTZhdDFhZG8vbHlD?=
 =?utf-8?B?ekhrUE9CUDB4MjdRM1JXbU96bm5uNW1IdHlCbGhVL2dodlVMUVgrNEI2MUo0?=
 =?utf-8?B?Sk9aelgrbzVJRnZLdlpUcGNwczB2UGZ1b0U4MGROV2V5MDdjcnl6Ky9Ma0k2?=
 =?utf-8?B?bW1LM3RKNEJNcnFiaTlXSU9hQXdERTdueVdzZmpqVFlRNThHNTB5WVlyaGU4?=
 =?utf-8?B?ZmZpN0FHNjMycEZlLzhBWElRMFhhWFVVOUNkSVJINzJaeGljSkV5ZSs0T0xE?=
 =?utf-8?B?d1pjWmNpeTdzMjkrTVk4SzdCZENSdEdhYzR5eUNJcHBncWpsa1l2Sm5tVzVE?=
 =?utf-8?B?VWJtVWFBMWcvSVdueC9OSlRQUCs5N002eG5xRVJTeEx0SVJMSml0Q3Z0YlFi?=
 =?utf-8?B?eE1NaE9JUmI2eWdyWGtpSURFUmIvZm5HMkViM0drYUJPeURncE9la2tZdEpr?=
 =?utf-8?B?NmJEL1UwTVhQaVNWYy9zRmZ1Skc3VlF2cE9xSDBVdlhUS3YrZURlbnc5Unpk?=
 =?utf-8?B?ZmdFTStSU3MrazJZSTcxbjdvSEY2bUFPNTlqQ2xTTW1OajVhc3NUZzlXNkN1?=
 =?utf-8?B?bGNKSTlOWmwyUDNvNkRjRUtiN2RnRmpnRGVyYmhHTHVvZzNWQm95QVJDd0ZJ?=
 =?utf-8?B?MG9JaDUrTGJpaEpaMDBHYzVrd1I2aW9EbXptd2E1QnR2dERrekd4MVNWdHBW?=
 =?utf-8?B?SWp3N3Y0dWZVekk1MTF5R21IZ0NmVTdwNkhWTjYxK0dBTy8xRStQWGVMZzFy?=
 =?utf-8?B?b2FFRWtxSVg4d1FQc0dmOW81M1VYWmxzUm9ySnBybU9iSGdSeDlTajZyZlBW?=
 =?utf-8?B?Q2t4STVmRW4rOFk2K0ZaV2tvV2JBWm92RDUvZEN0NFZTMlNBTVBZbmhIUXFm?=
 =?utf-8?B?ZURuSVAyNmVGamdPandzOUFCQTVHL1BEWVBCbXF2U1FxU05nRktmSnUvK3kr?=
 =?utf-8?B?RU5wYm42RzM1a1NrNWkyNTUwSjcvS2UyamNLYjVsaWlSUkRwTFFvdDg2cllY?=
 =?utf-8?B?SS9wNytGNUZ0UnMwZEYwY1k3eFpVZ2tSMmlRaWdNS1NFSElQLzdIdHI5aU00?=
 =?utf-8?B?UXVwSTBjWTBJRjRldk5HTzE5V3dML3cwWnp6V2kzT2RTV2sza2x0TE5rSFFy?=
 =?utf-8?B?VUpXNGVMVFd5TmJNeEJROWUyclJnM1hQNUlFanJHb0hSUmk3MGIycWQ1amRn?=
 =?utf-8?B?d3VhTjYxKzVsQjI4YndzMm5OKzV2dGxiNEU1ZVhDN3NqRk92N2FCT3o2bisx?=
 =?utf-8?B?cEg1Lzc1NU5Jc0MvZDJDS0tiL3NSalRHWVlQZHAzdlhEOU40N3Z3UkdVSXRV?=
 =?utf-8?B?dENNVjdjeVRnWmhJOGxtcnNycmI3Yyt6ejA2M1ZqYTB5TGVYbGRhTjh2MUhN?=
 =?utf-8?B?WGtweVBvT1FCc1JYbWIva1lHTllDV20rZkkzRmR6WHRtdjNSWkZKdURNcmov?=
 =?utf-8?B?MENrZ0lKNm5YRFZBT2ZMNGlvNzllQ21UV0E1SmJibGhqVVdoaDk2WGFydTB0?=
 =?utf-8?B?cktpQ01FTUdtOUhpTnVieFVManB4c0QzOUZDamgxMlNQWlRtNWk0cXFjd3Z6?=
 =?utf-8?B?ODBXNEdiMEl2V0xERHVLeHp2b2F6SzFHUE5RRGhCZDhpZXk5VFdRTk5FYXZy?=
 =?utf-8?B?OUFoQkpvajJuOWlHUWVuRURocVo2SDhVVWxOdk9kc2M4SGhaY1hMYTN2Rmgw?=
 =?utf-8?B?Y3VBcGZjNjgzeEJwOTE5bWhDaEN5RXRQeFBhVnRNUmQ2RHA2UFFYa3Q4STBC?=
 =?utf-8?Q?l67rdguOldlJRmjCDwpCZCZgo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RQSG/mQ84LHYufyV26F/uVX/2aAQqNQuggwhdJakiybY4Cw7msAkeV/lAG0X73GrOkWYDn8NL3QRx6bzuIbO/pZqwPKuWI5/avawVAYII3fk5NrIGSxUCwwiEeJ1ij43DPW1A/xVMiSa4Ifkbe69WVo7LnAXwNO1nutd/OvnKI/9Pg15NVG8P7cT4ZzdCg3386LbHVgNghZoZHh1j0O1W/v/TmlSvR9YRjQ0ixsKo8hm6sh2qhn2VMgZZucmm7NFYA/NcFA8asH5uEH4XpWu22wpHnqjLogedPDkGJMdu0Ec1H5LzFFK7hIZliwFTr/V1gwWpH3H1d4P9/PEA4XjeferxqTIEY9ZxaWF48sbJPdrpbg2NuzF+t5i/ApyoV61gS99sor7zIDf4zp8QPUubVX1cu5yAW2Cp/vK/z7EM5PjFGmib2yB4Ju/sHE8o5YmWmfaalp3ZbQDHAqHwy3OYBkQClpQ7GN+MdVW0LgQYqVHM7XnE3jFQanGD6aNXJ4frU7wRk0wv1jxLqAwpT7D/pLwKfM5Yj9gC4qEHibk0/yyU8hZLFQgI6YzH/TuuIADRIwiAj1SvF/kY40emMY/LH51cw6kBMfR6jLhkCzNW08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707631a0-480e-4c78-08e7-08dc0cd57952
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 03:30:18.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GfAs3BT9P0eB+RcWvuTlu0kBEFxKhLN/S2c4lu6oj2qeK+fdwuTIoKCesE9JQWZJunRG3y7mgUuW95Al+pSmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040020
X-Proofpoint-GUID: mPNXyxRthefp7mCDzxP0HGtBLwH8kKW0
X-Proofpoint-ORIG-GUID: mPNXyxRthefp7mCDzxP0HGtBLwH8kKW0


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand

