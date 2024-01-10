Return-Path: <linux-btrfs+bounces-1334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E182916E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360B61C2151C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF481F;
	Wed, 10 Jan 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="egU53pJD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vrm1jkYx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA980D;
	Wed, 10 Jan 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409MeoEi025472;
	Wed, 10 Jan 2024 00:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : cc : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=opLc7EckptSKI8jmH2P//rXn3w3/ZVIYp4aRo4t6vDg=;
 b=egU53pJDvPAS4Xeg/w1j7xF1Kubn7WtHHbpukE+HwoaCAa0is6XC2a0emuRFXzO9Jv1J
 cLeqFmQSWMOpiuI3j4apHaLP9yvm9cUu4hBtYNtuWs17YXFBqO7RUf4+nkVsd+IEc4Mz
 7cs6iu4BuQyPcF0ID4DiTjk2R+LZZUVE7Utui4W6pTsn+X4pljvfqO2T4mwwbA6Mh2Wk
 W/c2cHIWxEmOHJYQnxYd4GdJ9PZJCWluXrPKLPLE8ihTJcRhrNCv/3Ad+V9eiyqbV2HQ
 RQ5qU5oE2asxq1P5k0aPCCBg3nqI82fQUlbqRfItCloWojGkSh97YOL3xcZ8CCVC+AMF Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh8d115fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:29:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409NVjrv006709;
	Wed, 10 Jan 2024 00:29:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur4kgr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtTWqlQsh/NH9F2Iexuh/QEDSZA+BD1DDaToWYCzPMnoWulAX2CFZ6+RRlGA5ZN8njoCYMuS5pmGQ1UIPlNFC7GtFVsHcpuy7OKhLsa1bVpZMuZwTMphCEY4+g0HnoBCtJ5HAFnEyfjDS8YxOxTxI1TcXkN4evoPguNtc5Msi55xfTFG2YEd5OvltoTJuX9RlqaPywrGH1GZe5ItRGiiymulRuOC+q25QUe1LYb4xvn8VZ68H+xAzMGxdyub8XVx/0Jk457YbuQ9mU1x1T7JF327agfDQml4RDySILgSycLsx3eqR8itdB/CjnM6Jf+ClyDderXbCJ7TJtLMILLaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opLc7EckptSKI8jmH2P//rXn3w3/ZVIYp4aRo4t6vDg=;
 b=VrJQ9beVUCnmmt4S1IzDisR+G1avETOAIWTy7OuI/akS6jS1aidOzvXYRTJ2sCcIAXtm986899C5kaqRgoq+bAAE7yfRMUtuDOmgDdidazWtfLCjXl/YZ/WrmovXrCNPtHi3CPcj7JVJYlxyI633ZjfzKYSv2vqwTzvoTbSj4TXTS583SHJhi8SKhk/gCsW6wRyCZQVf2ILSMtdgoj5tarysv5JaIa/kwPL2vuuCHwiZoydpdXXCleFo3F9L5cF/1XTnW8rCoG0T0la8uuq9GyBVsHtPZOr3A9AjqyV8a4AjHadsBY4LQoVxjvGEZ1QW3ciIT/iHAp+bd2kPoHJvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opLc7EckptSKI8jmH2P//rXn3w3/ZVIYp4aRo4t6vDg=;
 b=Vrm1jkYxzO/DwZ2MHlBtxAqhybXly9AvsZsCwZbJd94SuQmj9XoROQKs2IyAorbazAiPtqLeWyNEqNFtZNiiIdd8uvea6GgyPhLyES5LKglcA6Dd/7ccfUWggnPWcE5AP9Z0MbeR6UzauR8gt5dkZvOC02I+w/Nkjb/2kGBP8g8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 00:29:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 00:29:47 +0000
Message-ID: <eb9b3fa6-a78e-4191-09c6-a37d344bccb1@oracle.com>
Date: Wed, 10 Jan 2024 05:59:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
        Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.01.10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7671f837-7123-4237-8fc4-08dc11734011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jf1ZdqgUra0rZq0M7MR9FC359l/xJ6UckU7z1X2bTrOWc++E5d6Ab/jC5/Qn9EdfUEbYwbQbXDiU/DP1hX3ICx+5AVAQupMSpZJ2bPGjCC6wUdl7RFQ/6KUfS4U2cRlWWG/xOL67Wts+t3FOa0yXFgfMCeLg+tcBLFzslu0Ob/vjrXA9HKR/Nv+/sWexnAs8cYbt1m80e9XTDxYhgRrzpLAMd3qX6cP06OrcivI6IGbBWEmRfXvSjtPTLrCcszqeCXqo3vyRGv6DUGKiC3uMLwd1cYPMglfnP7sHpOftILmbpsNltFpygnlHupzpGIkfq3p/yBIFBpWplXY7MtNu6+WXI8KvmZsnxTSzeui0PQnSdRhMPNdZgBKi/m6R0KqTAes+f7+9A0/VyVkNTfw7E7Mh5pCOsR6dWoz6YccOzWNxhaMFkUDYLjazXkw/jf2+S0nPvTSbylKQYuqn8GqXFASziJTRsk0tcf2bLQT2LDgHku2RcLYBBpJ63t/frMvlmtv7la5H2ERvb9YX6ax0i9XijL85ve64EQIGaqY8Ogj0wMzslmZ0cWAt4QMmmAR4darqkwpxAL0TirDfgtdQcrjp8+apNYKRc4PG0hMUUp53RMA+e87m8vtuvKpLxsu/IL+a90cfGkuCPmKAt33Zmg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(36756003)(31686004)(31696002)(86362001)(83380400001)(2616005)(26005)(6506007)(6512007)(6916009)(966005)(478600001)(8936002)(316002)(8676002)(6666004)(66556008)(66476007)(6486002)(66946007)(4001150100001)(4326008)(44832011)(41300700001)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWVncGhkWEE3L0NNQXltWFUrbGtsWHBOa2hBMTRwWEJSREp6V2srNFB3b0dE?=
 =?utf-8?B?QktwWm1CbEw5b1loamRPRFZPaTZzNXFQV2FyOHFtdGM0bkxweXNhVmhDVXo4?=
 =?utf-8?B?YnBLV3pPRUxPaTU2dGNTVW1sbVg4ZjVZdWNKbCtjRkpZSFN6ZlZueDY0dk5o?=
 =?utf-8?B?TUlyRVZnWHA0bldJa1hidEk5SVFmQUttTTIzRjRvTldrV2JreGJBcHZqanVN?=
 =?utf-8?B?cDM0Y20ybG1sZnllOFhuT2puZEJNU1I3clY3Q2hRNjlPOXhlUFlBUGh1NXlw?=
 =?utf-8?B?WW1EOVgveDU5MDczNlc0bVgxeExUNWhpc3Nzc3JxbXVzZE5hZ3Y3Sll4QTRJ?=
 =?utf-8?B?eC8yckhNc3hGamtqZ2E0UzFFQ0U5WXdOaFZjbDVoMGZ1cWxJNGFWWG1GRllI?=
 =?utf-8?B?M3duL1FxcFVsWHZvdDFzWkd4QTFIUWxFOXRqUkt3bXM5blgrcnpLd0FCaWsw?=
 =?utf-8?B?aUs1Zm9DdjEwOHc0V2NaRDZnWjVJWmhVRTQ1WWtweXR1MlhnbW5HTGlVNHRQ?=
 =?utf-8?B?UmdQazNHczdZVDlNdm4wR3doS25nUkx3VWE2M1Zsc3RxUVVVTFZ2eUg2TDlM?=
 =?utf-8?B?WS9nZXFKZ2pzNU81ejhyaVNZc1I5Q2N2NlBqdVVGck5JTGszNW9PVzZ1SGo4?=
 =?utf-8?B?VCsySnJsS0RNaitsV2w2cUlzcWdZbmdyU1pabVA0MnRxaUhNL3YrczhRZ3U3?=
 =?utf-8?B?VGZHUFFscG5jb1Z1Wk5nMDF0WUQwMjhVanByVy8yYzREemQ4N2VCc0pObUxC?=
 =?utf-8?B?YmJyZENpem9zVjdCajdHVUg4OWd3dzNQS1ZzMDBzNzFsTitWRzBOU1NRMDU3?=
 =?utf-8?B?YUZPcTdlVEh2aDdZbzdFbFpaL3lDMEpEdWFIN1Exd1pGam5YQ1I5NDExV1Jq?=
 =?utf-8?B?SEhnZmtleGh1VXh2M1k3aTVBTnFiendjd3FyMnpINU5Ec0FHbTAwcUNKcURV?=
 =?utf-8?B?eFF6aWpiWEVyd3d6QmZaQ1pHZ3ZGd3hSeWgzcUZHblNmRFVJblJkbWRmWXpj?=
 =?utf-8?B?Y3ZrLzJDaXI2bVNWS0MrbTBOM0xzUzhycDNVUU56dmFBdEZ2eENqbkN0WkxZ?=
 =?utf-8?B?WmJYa2daTURKNCszdTV2SWFVZWpXQ0JGaG5RWFF4MFFEWUFPaEliWGJCTU16?=
 =?utf-8?B?RFpYVVJZU044ckhOVXRwWXpMRENkSmtZSlZmcFNjWERGSDQ1dFJsd2dic0RN?=
 =?utf-8?B?cG9XclRXOTkyamZ0VVVEN2Y1VzFBRDdra1dpWlA3OWgwMVNQbWxEWDhETk5n?=
 =?utf-8?B?Z29nZnh0cUtTOHZxdnhIY1cwRGgxYnp1YkpzTlEwYm5OZW9ZRlBjbDFsejZI?=
 =?utf-8?B?NVNJbnpHTWlYbm9FZEN5N2N0RGVuc3NlbVZMd0lOVk5XTkU5d3J5N1NRbTBN?=
 =?utf-8?B?VkZXSjIycjhDQjI1c3JTS2FxcDcrWWFUajZJRzRrQ1V0d2lYYW0wRkIyZCtZ?=
 =?utf-8?B?b0RKQ2p5bTZrbTcyZWVLcU5IM1owSHIreDhNZU9hMEhrQWd1ZTVJa3k1SnpJ?=
 =?utf-8?B?RkVGblNyaGMzTG5Nb2xSQzlYOU1PR21sNmxkazY1c2ROaXV6T2VmSkU2ZVRB?=
 =?utf-8?B?Z2RvYlp2R3FKVXFZQjk1bHN3RWZtbWk4ZStTRWNKT0hUY3BrWTVrZFJhS1Rj?=
 =?utf-8?B?elV2N1RvbExOWktHTVBZUU1EYzBWUTRzbGlPWlRjVEtCazNJenhpS0lkM3cz?=
 =?utf-8?B?K2N0dmdFZnNlNi9rRTArVFp0UnBSbnkzbjUwOEVXSEdidmEwRHQvQ1cxcy93?=
 =?utf-8?B?ZWRpTDNEQVFBVlprZFF1SWR3aGpIdzNJYW83TnVQelhWNUt5TUhiR1ZHVlNB?=
 =?utf-8?B?c2ZHbFk3VWZWakxKZThxdTFkUVg0TEl2dmJRc2JTMVFRUllNYUNIVkNuaUhD?=
 =?utf-8?B?dWJCdVFubDF5YXRUTnYzaFduMUxyaVVCaWxxNkJsZk9LVVZGUnNHWXRrTUFQ?=
 =?utf-8?B?ZFJQYitmeWR6V01ZWElhODVyZmI1OUt1aWVGY2ljekc0T2dmUUVmaXorL1c0?=
 =?utf-8?B?YUE1VXMyWGg4eWV5RXNKdzgzNjZkenZYSHZaNkk4bzR6OGMzalJvdi8yVFc4?=
 =?utf-8?B?K1R4aE5PTmNodzdqUThQLzJCN2VhM0RVc2hXcE1rWURyYkVoaXdyc2tFN0hJ?=
 =?utf-8?Q?hiXeJMTGCiQBowncxc2KMg2Ua?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n76pFJ4fkkUDipi5bI7P/d47MOtyWP40kkfOGmHubCnTAR2BG8jzu+H2+WgM+rmILKjpqMRyjbyHKQ0NfrSaZxx0FFnJx5SViInsh5UoyMO9f0+7ESSAJIuGytmwWY98ykcP6sanyKpJ/0pWHv6zOlbzDYHmb/8lUJQnlXwiS6cfwVJxZdSSLl51zxwj/Q8D1ZWoaNoSO44h8OxG1VQ/Fn4cgWKY9xX+etRdXi2B2UcIBXf+DDPJLaqGuzQlI7+CjNRy73/YQ05LM/1t4VCzP3oKht/iPKEHWPEgxVIhppKMhwNf/y+70IM9f6ZiqGOnJ7Nu7JJjGfnz0cUd9lmcWQFTCGu//MzQf8eZej0bIMDaq3PolToiNTMfxkFGXqM0xCxQluC2hBcPU4q/BDzVRHdZ9ieoPKAlKsgKBo7G1CvvVerUwL7dhasTu58RBcbSylUWTAL4vVxWoVChYcnenJR20aJNHv09V7jMpz7L8LHMXWjnCXMYGGf4O+84KBeW02pj11jRBJ0X7VAOgvQ5KkFUBvM+t5TgP7RBJuBSYHy0ZoHT+znFemD2/NDwUmrFiERJVO6r9S/iQdnAa+BFodoBZEgID9HDcm8fOcfRGnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7671f837-7123-4237-8fc4-08dc11734011
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:29:47.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRSpyf0O5tLj7FTjp6OBLWH/oIhrDVPS0VySChFc/RSzHb8p4fnnUuynfgqh/Hz0VVf/Ymwut0ObcvoFBE+3Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_12,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100001
X-Proofpoint-GUID: RN38rfX_rE-ED_iW1wdOjyko1yBmDtHw
X-Proofpoint-ORIG-GUID: RN38rfX_rE-ED_iW1wdOjyko1yBmDtHw

Zorro,

Please pull this branch containing test cases for RST and snapshot 
delete. Thx.


The following changes since commit 17324dbc7743902aec349d12ccad91b3cb6005c5:

   fstests: btrfs: use proper filter for subvolume deletion (2023-12-24 
03:14:21 +0800)

are available in the Git repository at:

   https://github.com/asj/fstests/tree/staged-20240110

for you to fetch changes up to e50e5d97b2a217564f27bdebbe1e358eb93653d0:

   btrfs: test snapshotting a deleted subvolume (2024-01-10 04:39:02 +0530)

----------------------------------------------------------------
Anand Jain (1):
       common: add _filter_trailing_whitespace

Johannes Thumshirn (9):
       fstests: doc: add new raid-stripe-tree group
       common: add _require_btrfs_no_nodatacow helper
       common: add _require_btrfs_free_space_tree
       common: add filter for btrfs raid-stripe dump
       btrfs: add fstest for stripe-tree metadata with 4k write
       btrfs: add fstest for 8k write spanning two stripes on 
raid-stripe-tree
       btrfs: add fstest for writing to a file at an offset with RST
       btrfs: add fstests to write 128k to a RST filesystem
       btrfs: add fstest for overwriting a file partially with RST

Omar Sandoval (1):
       btrfs: test snapshotting a deleted subvolume

  .gitignore                         |   1 +
  common/btrfs                       |  17 ++++++++++++
  common/filter                      |   5 ++++
  common/filter.btrfs                |  15 ++++++++++
  doc/group-names.txt                |   1 +
  src/Makefile                       |   2 +-
  src/t_snapshot_deleted_subvolume.c | 102 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/304                    |  58 
+++++++++++++++++++++++++++++++++++++++
  tests/btrfs/304.out                |  58 
+++++++++++++++++++++++++++++++++++++++
  tests/btrfs/305                    |  63 
++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/305.out                |  82 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/306                    |  61 
+++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/306.out                |  75 
++++++++++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/307                    |  58 
+++++++++++++++++++++++++++++++++++++++
  tests/btrfs/307.out                |  65 
+++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/308                    |  62 
+++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/308.out                | 106 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/309                    |  27 ++++++++++++++++++
  tests/btrfs/309.out                |   2 ++
  19 files changed, 859 insertions(+), 1 deletion(-)
  create mode 100644 src/t_snapshot_deleted_subvolume.c
  create mode 100755 tests/btrfs/304
  create mode 100644 tests/btrfs/304.out
  create mode 100755 tests/btrfs/305
  create mode 100644 tests/btrfs/305.out
  create mode 100755 tests/btrfs/306
  create mode 100644 tests/btrfs/306.out
  create mode 100755 tests/btrfs/307
  create mode 100644 tests/btrfs/307.out
  create mode 100755 tests/btrfs/308
  create mode 100644 tests/btrfs/308.out
  create mode 100755 tests/btrfs/309
  create mode 100644 tests/btrfs/309.out



