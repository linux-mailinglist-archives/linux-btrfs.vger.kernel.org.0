Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0747BAF7E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 02:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjJFAIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 20:08:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774DA6;
        Thu,  5 Oct 2023 17:08:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IiMNf014783;
        Fri, 6 Oct 2023 00:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FgzsLe4EPwGj75hGhQ4hRjFZycoAXYSdIe+RFZAtmB8=;
 b=Wo4b6Wa3qONk6fX3b0lHiUhxAdo874nVNyKsIZ+IhS/7sSDsgcy5tJkHmJleQAO9XxIt
 mpSOvhQOVV03eltz25s93IKg3C+1jaLtqfRBR9Tru/2dy4r0jZLbbXoGnJZ2TedTJscc
 CG95Zs6DLvqbDEaX6QsfvFVBpsJDv17PI1OtoVyZl487nfaSUjZi3VBToORC4jubNHhx
 wXftUhjjwkueH1AI+9aAvfP6mrUpmwUPdd5coj/y7czB3K8fheTeGFDlhAeoAypow/ys
 3IQS6WbYjaF1jXtZuISJr1qj9BHrSIEPQ+9Eyo7AcjRLggQI073W/HC7to5HDXB9bpVw Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vjr8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 00:08:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395NE1um008725;
        Fri, 6 Oct 2023 00:08:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4acc8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 00:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHNeD3vQ5WPZ1YPKhYGJDnq3DIBgvhIugALjbjIrYxdTZ1xt9nQIjpfygilQF9YWPuwT8RlVmTLTBmyFrtdKZ2vbULoyaXtBUyTw0Klsy594spMRfMGu/zjVY4fVVKxJLzJyp6QxL+V2EfLLlPc3DojjOiWuUFuClctd+aZ4YzKKepapJSMh2iaHoh87WiwIPllMccDsUn+kFcz3QdvJEo1CrD3QE3UKWfnAf8T5AUWIhlf7VYOMOW1UxQwOQ/meok9XAI8q1H6HL/I5ICQhpfwOaQ+JWvCTOUxuluRownz2wWOvKMOP5FuPp3pYjWNwU7XmQruZ9kMhBodBXIa4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgzsLe4EPwGj75hGhQ4hRjFZycoAXYSdIe+RFZAtmB8=;
 b=ZJ3SQUbNvDF95GvCOSbfo08jyc90HqZrGiYDwfhw805S7JvYxR5Je5nXxjtaaPZSOH9vDbZv2IiSvg2ChWCvQWDtJsaa2ds2hj6naoovd3GUWPmXCVv+MkHRtVD8EVIHY9B0fPD8fhCPZTmuBfznT7TdEfstSZezWhJFUjOe+wqwXoSESsUO4apWr11GAGDy2fdGd/AUfVDnmvHU5he88tJS/1e2MGEIH4kjQGbySdAzmSYghRl9FAGE5t4v+QkOxSNlYyQDP5qSYRaJXtCkIA+2kwktEga/RaNyH0tcSQMkiCPv3cPMG/S0RmcIHkqtFGjSKHq/WouqnsLm2E1aJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgzsLe4EPwGj75hGhQ4hRjFZycoAXYSdIe+RFZAtmB8=;
 b=Qmi7L2MFKnoeZHIihT2ir9S9OZ4xHQi7dnce6vKgjBal5Tp09zkyCEoikxhUW603UjASbKMnoZ24IV20bDI/hIHpJmMo0A9pC8Qm1uil3RG2u2TTsBsQxzGuj+9ojLMIYQ98dlVo5fcG2bTVuEZEzZLuI3Ds+7v+hpl/arWAgs8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Fri, 6 Oct
 2023 00:08:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 00:08:42 +0000
Message-ID: <298af022-94bf-41ec-9ac5-ec560e7e9bac@oracle.com>
Date:   Fri, 6 Oct 2023 08:08:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs test scan but not register the single device fs
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
 <20231005142911.edxcwtwnvywq4dn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231005142911.edxcwtwnvywq4dn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 519a9ada-76b9-46ed-1beb-08dbc6005ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTLtWPJktr0niR5HjvqAKdO2WNA+B1ZUpqeg53k8Fly8zeu9fpfpXBNDiLxCal2OuBmuwLZLzDX6Z+8nOvOsowHJgoayzJbMzTnNUS86MALdFT33gB1zcaDaBA0yKeEJgJsSNzCnThNRsrMDURrtlXIcGbOaEpjue7D6HoLRyfTE6Z4HbJR1yOEP3Q+LcQzId8e1Zn7hmM7y96X1zdFBA7DrXiGEc33IGysalYEhfZ6D85AJNZxs5zCzNonLGfDCgTuBHdLU0ndlspeoLqHX5elcRab+NegN6qXGPrSWkWBI2gbBphgcTU0PYiXP7qQVeENyGuWRkWktvImRtgHhGc8GCXc9pFr7dGe/UmxxaPDnBtdWcmWYcV4Rz+92xKgU8tXpkW0gHjq3tPLyGrrnDbJ1EZPTHPOchs0WMcqP/iuExFovFN7AUlw/fGr0BPi/8AjQoqp7WSlt47pSgMR2f6d2t01E4LVbXNHuQ1xHfmUEwZ7kk/TwvLnCn25P4k8GeMOEPZhAxMQH82Ny9KwmP2XT5cUyKon4WPwoyJCf+yygIe6TG8BkLMc/os4fnZgraUkjD4HBpVn3vypp8ilslKaf48MOqRpzwdp0ZkEdSGJtsubRdIPhgoM3XXuw6KRFkLw20kZY7UlpsMVlirCoWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6666004)(2616005)(6512007)(478600001)(6506007)(38100700002)(86362001)(31696002)(5660300002)(4744005)(44832011)(2906002)(4326008)(26005)(8676002)(8936002)(36756003)(6486002)(66476007)(41300700001)(66556008)(316002)(6916009)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRKaCtxSnJmUGJTSkVvVjl4VXJoc1YrRnVGZzM2VkJEZnVFM2ZWOTlXeW4y?=
 =?utf-8?B?T2dZRXNNWFZOQVEvdlZkWEpJNnpoNUJqYi9CNStKNGx0UVB0dTdhaWE0Y0la?=
 =?utf-8?B?OFJGSmtTSTN2L1FEbzFSK3MxOUk0Uml2TDJOZ3hjVnYxcGY5dEVTcE05NitC?=
 =?utf-8?B?eTh0RVUrRVNTeVdobGxmTVFNaVdVSTFpaDdKK20wcTNoS3NhZ0RtcG1KcXgr?=
 =?utf-8?B?SmFONkI0citZNVVDMktXTEhJRlRUU0ZjY3NtV0xDQjkwbWtybFJLZXdqM1M5?=
 =?utf-8?B?TXlpaXBkTXk1Q3MzbHFwdGwzeDJpdHBxQVVQS2JMOUlwbGp1L0hEdElSWGZu?=
 =?utf-8?B?WDdPY1FpU1RxeW9vRUUwRnN1V2xZeEpWYi80VnkxdUQxZHlXVm5YR0tCVzUv?=
 =?utf-8?B?OWtCbmtXWG9yUVpmdHpPNGJLZ1JCY3R0VUZyaGFITkkxK2tod29nbDhyMS9i?=
 =?utf-8?B?UVNvN1drL1U2WW1rMDNtdzlXVG5JcWNxaGU1MVJzTG5WTU9vd2RhaC82SjZL?=
 =?utf-8?B?Yjhva2lPNkRoMm5oNkFlU0g1TldCMUFFd2kzR0pvNGhDRkVNRGZmbjJCb2kx?=
 =?utf-8?B?d2s4aTBaaHZvRDcxNlRqRWMyU2o5NW0wREJVUEdTeXFLdzFVSzNCY0lxbTM4?=
 =?utf-8?B?UzRMRGRUc1BGbHNsNmRhdGlsdlVZMDhmeDgzYWtPbUw5ZVhHWUd5SnpwTTJB?=
 =?utf-8?B?cGZsN0JKNlp6T1VQZnhPd0s5MlY0L0tWZEtZTlpwR0tnSVkzVWFBQUVXTjR3?=
 =?utf-8?B?blQvYWRlOVhOWW5qbGRnNkhvNkZHNlNlM01iNHZSYm9YVERyZmwrWURnTVZy?=
 =?utf-8?B?Z0N2dUZEcjE3a2QvVlppaElxaStmclNvNmRDcmNWaHRQUHZnTjNtR3BOQkdG?=
 =?utf-8?B?THh4MlVIejR5bko4UnVCTllNVDJNbVZKZE1RMHM1cUVIVWhOR1JQM0dPTm1F?=
 =?utf-8?B?M3FGMVZpKzVRMXBSQlZQR0VFTmEyUVk0dHZiU3E5WFFkWkdTcUo0eFRaeWlp?=
 =?utf-8?B?ZU9reGNJZUxWNzhOWWlQVTEwMnJnV2d0NHViV3c2SWc4bXQvSXJYV2F6SjYy?=
 =?utf-8?B?eGlZREQ4ZGxzZlkrdTVHU2N5UGRBTWhPTCt5emdjU2pVV1Nkd054eldENmtv?=
 =?utf-8?B?T1NsVGlyd3RsOVI3OEVuK2RweVAwZ0F1WXgxMmUrMTBsWmt5K296RHJzRU5z?=
 =?utf-8?B?eUluUkl3MjkzZ2ZGRlV5VHNDZUZFODE2REJnZzJlbmFsMjZqSG5sY1ZkYllz?=
 =?utf-8?B?aWVPSXJrdklMSHRBM3I0K3BjRE1kaG5XOWxxdzRxcjNsUUszdml5MmtkNy96?=
 =?utf-8?B?cE5QenkrUTRoL2daYk5CRjk2SmNIandIWFoxUHNTa0xuTTR6MXpTVFRHQjVu?=
 =?utf-8?B?dXY1MVU1N1lyelNXblV0SWNLTDZvUkJxYVVlM2ZXUnh2M1lJU3h1eG15QkFC?=
 =?utf-8?B?QXhKbnVCTno3dFlRaXF1M3ZzdmFHTmhXeW1YV1dkbU51Zk5MTDZQN1QxZmFO?=
 =?utf-8?B?c1R2aWM1T0xEaTE4Q3R0U2RydHRvSHYvV0ViS241MDdwZXp3SmlnRmYzOTlL?=
 =?utf-8?B?WHRPeU5aL0h4a1FYZk9mcTVwOE4vYjJzUGdsODdoVG9IcWY5dHMyeTVYTG5G?=
 =?utf-8?B?OXpIRDdDNHNQZkNRUnVmK1VSSVZEOVgveFE3Q2hrSi9YM1BaNWlYYnR6REIx?=
 =?utf-8?B?bE5KUEVCTmF5OUdOU0FZSmVwcTJDRGRJazlERFlkdW5ibC9mZUw5WjFyM2w0?=
 =?utf-8?B?cm9RQlhVc2JEMHBNT0ZldVpwSG02Y2REUDh3Uk51QXRYeHMzYVVvWlJjZEdv?=
 =?utf-8?B?WjlxTGxOYlNJRER3Q3EzYkRJSWtOaFhxanh1NEJaT0JVMGgxUjJYMmtEU1FK?=
 =?utf-8?B?Q1BVMmRkSmFXd21pWGVRcjZPMlQ4bUl5c2FVSERVMitIaTV5RUN6cXNyVjlh?=
 =?utf-8?B?M3h5bjlwOEJaM2NyTGlYdnhaRVBiVDQxU3lTc3FYWkxkbmtOcHZMMHZJeUh4?=
 =?utf-8?B?dVpQM3MveDROZ1lWWXlIb0pYcGYrRlZnNXFLbHB5VDhkME1mSUtaNWJhWm1N?=
 =?utf-8?B?WU00Wk1ycUNBeTdON1ZlVXdVcnBiUSt4YlhVZG5MYVB6Uy9mV3A5N2JZbUtv?=
 =?utf-8?Q?XhXzqXzCX21/kiS8YwDFgLws3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EMeGgxKsPlcVjXgawX/iFUQxCvS41xvPsIO7XCW/kOwsLgAeFBEAuEKBCaFOu4g+0Mn7hQ/cuZg5Faicapjd/8QlfRAiOvXAodM7yXejuQAYbIf4xFPNP8bq4FTfQ/HcV4vFcH8PZpp4OFqJTHZ4ZedfyLffWQRRxuZOl3RxydnBZ7G17IX1xFawH3ZcXhYCvM/OH2I33A+Z2hX5wRrsWON8Ghq/1KSUpsejUN1NhsUjuJIjHgTW2PEZEcBqSWnKbzhRjRLkh0+0OTGP2nHWSBSfIC2tqSPUrIoP6j9/OcI/CuY7FPBTO5xjsEM/5Fauf5D+5IIpaWLJ/ijysDcAK3b+0uQsayxK6U1CrYJko5MdeYRw1dusoxKIu6gla4YY24ibYDX7JpzbdM7AlqYr3q/k9EcS/i67DfCZqIr3e2LLfngNecP6xuzMVNDQQiBkQEOhoJGOtFwzMSeBln88E0guc5SgCldsNUtkUzDAaXRDQ5LsMqwytl2y7DPsHSMzvbty3vqsvAXxEUup218xcUj06ClvCCKj1LP+poj+QE9XQn+8ZMzM9zBb86Od0wbCScklVhmHnXxJQQMfFws7Ct7iGsgC4ocULUjDGRtUqF1DNun/0NUJakI40Y2Pco7wp0QQ3U8z7dnq9ywRW1hiOOMVDo2sUOYW5mDnSyP/HUMwOkhwrqfx/+fM7W/kJBp7KzRsgwFLXFittxGY86tUE7MxIrbJUReUneXPLOcIkKWGbj5lOHRpVV0Rif/BMkLAzCXJ8MPddcBKAyVzHEJ6XRcL3SrkEJq7y6aGgPx6uBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519a9ada-76b9-46ed-1beb-08dbc6005ae7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 00:08:23.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYPb7Fb6rppT1kI9VTe5QZ+ikLLN/e0HdTVyQqmyLGxb3JKWTU3HMjHi4rqiFJWw6sM1qHSug1IJXKjY29G/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050182
X-Proofpoint-ORIG-GUID: _Bgs1Nb6VSPXdrHKmt04ggwRcgRf_8Zr
X-Proofpoint-GUID: _Bgs1Nb6VSPXdrHKmt04ggwRcgRf_8Zr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> +$WIPEFS_PROG -a $SCRATCH_DEV
> 
> _require_command "$WIPEFS_PROG" wipefs
> 
>> +$WIPEFS_PROG -a $SPARE_DEV
>> +
>> +echo "#setup seed sprout device" >> $seqres.full
>> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
> 
> Better to with "|| _fail "....."", if we give specific options to _scratch_mkfs.
> 
> Others look good to me, if no more review points from others, I'll merge
> this patch with above changes, and with
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 

Agreed to both of the changes.

Thanks, Anand
