Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CB6A7B7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCBGpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 01:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCBGpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 01:45:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7924C87
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 22:45:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321NB5hp010761;
        Thu, 2 Mar 2023 06:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+Bbixh3ffcI+aUCXkxTAiLOwZuwLwb63Y0d0wP947PQ=;
 b=d8PJeLvnZBITCF/0y0dMgHKrMemo22kiwm4EAZuUqV1YHUHXfxEHgAEaXhFqibFCu49L
 sqg5TuEb778vimgp7MtEXXlGaLL2HXsLMTQ6113JTS3JIKeej0GSBkqnIm4wJkFphUaV
 PNk2mJZ5ZWNYjvB53Az0Do+wkJ3dZnQiwjoz5hJx5Z0cmnAGL8W6EaokFtnbCbjs0bxH
 QhvM/mcu7mO97DFsPZlmYwolv3DoI8RrWORCm6YesbRDCrAVnEsB5pZIKimnlRoC4Vfa
 MZcTXy5rmHvcCQDPf1w65fan7dg2L6Pk2P5Cq5ES2GhW8PdeBev/YNx9I0d0h4Srrv9g 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2jupg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:45:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32240hRk015895;
        Thu, 2 Mar 2023 06:45:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s9wt5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEmVLCW3Ialdu+veWZpQ9XXsIwd/nGbz/wohuy3KxGGx+fpDNhtK6fxo6DZuNrTLnyJv1Bp+nNMvBDwh7V4wMLJjnSk65ic5fnal8gP+e7d0mNMcmKNS1lwZKymIIM08+ZJcQz20+u4pnPyEB/cA/pfmHIy+6KvsIpXoTdH5Noxca2YaJbg8M2sTL4q4uDbkz2cLHw5Yc5EgC28qjc/8tnaehGjSskny2bi6uPGp9Ef+VgNXChwJXDF5lGIaRd+PS1dtXbwWshY4YalkfFLaDimIZ3RMF2rnJlXU61c3clwJ+/nCFY+wWRqdE2H4MzQSRSps0FGEp+3jEHvjprjqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bbixh3ffcI+aUCXkxTAiLOwZuwLwb63Y0d0wP947PQ=;
 b=DkiLtXgQiRL27xTguIBGSX+hQIUryatmAeCWLHUFJJCzyQ2qmjMxA35DHqUx6lbvwjeJQ/Q+ivdgat3yr1kIAbpR8EiihGFHpR8nCeXZDlBqq0JRmkNndVB51nB1lNpmWfLixJUAfPZnzaBY9i54vitibZY13V9Ewmf7k3fQjFX9y0tbFQGGadOqyqwtG1VAjLeGs0e2QTQH0rGv8x1blBK4voD0OriVpGRp+CnXWyj2IQLf/grDlCSJ+ofAesPJH7SazY5VSaaUTuMdj5eJnmw784hQgbOyBDi4hDWQBWP/vq53WKaX1zJeUJ27vVt2gbkHQKdnHVAXvku5BfcN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bbixh3ffcI+aUCXkxTAiLOwZuwLwb63Y0d0wP947PQ=;
 b=izMSYmTBKY56lHWFHZm7qhWBNaAa74j2X2KrVxirzG9kuqghsLcijLU6HilSL6ywrQqUlo4hZbwr0I/5wO0DI6E8AiVps1MsXnHvrMNkIGx2L9WEJ1n2C4YsmYpo991cJcQxOvMKILUgApNHzqzp3rs3n6cCwIcAOdxoeSEAG5E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:45:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 06:45:39 +0000
Message-ID: <7262990f-7707-8f09-148a-9c1b6d2884f5@oracle.com>
Date:   Thu, 2 Mar 2023 14:45:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/3] btrfs: rename BTRFS_FS_NO_OVERCOMMIT ->
 BTRFS_FS_ACTIVE_ZONE_TRACKING
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1677705092.git.josef@toxicpanda.com>
 <5cb6fa87af8959b0ee9b33591968812fc6b4ab87.1677705092.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5cb6fa87af8959b0ee9b33591968812fc6b4ab87.1677705092.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 104baec9-ee3d-4e35-345e-08db1ae9bc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxxJ5VA7EnAcsZ1KNOBFfPgUhgqxZ6s9jZXwg33aEPMnaZCwLIztSK6QjwF1OqXtbhOiAipTV/ymabfg+2pA8uDaFkfcVjn3jGVrLOjUE+6ZPyI1zJ733fEuCmaShJCZQk/Tlie5lWmalcl+zsy9VrfNIIPqsrItwA8O0wIU8kN95mHqyMmWfBwfW0RDt4ZNOdcC0rbR0rAaYyPhLQaT0dkfrZCkgB0gpV/BuP+LLl/gcT9VKGLRHyXVdGSODAQif8FTU4Guhwse/fPbSOaDts3Wj7R0sFU00s3e8AboQ2Abe2aYFC7IMrPSR/G9lC5mUOEyE5akjiqN9p8bErNMgsRfN89/gIXG/tDmVKdOztRkzQ7AIGq8dzQWrJH1ecHsli9c9bJWq2eExWAHBmcb5bewV9kEiNEsIkydUN1w0iAOnycDQcyYlMIm+vzZkEaieqzk7AQrhkLKMmeXmTWZmtZow1qTQqDWYpOVIjsyCFEW69sfq6r9b9lCywAwyCIKNKj45wHGrHMdeRlKtwof729iNjSrFnSXbwvpzKzm065OXBzX8Ub15qpS/SrJUVdH76RJu/huLaAvaLweel6lQwB9xwokfbkDoPTA9Vw71GaX/dJBZf/Vp0sIKpwLNvyY2AZT3F/SV0/XszrCtg2Sg5tKkMVO7XUsIJk+AOnxq5ayFe9AayIvr6IAwVUjamqMixF35mHuWrS6NzwnwvhT/XwjecT+bsBBfcnajMxuHN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(86362001)(6666004)(26005)(186003)(6506007)(6512007)(478600001)(6486002)(31696002)(2616005)(53546011)(316002)(38100700002)(36756003)(2906002)(83380400001)(41300700001)(5660300002)(44832011)(31686004)(8936002)(66946007)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVBQY21BUjh4RmFFNzZUeUsra0xxY2o2bFFTekE2U0dBVWdFL0JJcXc1VEpT?=
 =?utf-8?B?akI3Tkc4ZHc2ekdvbkNMdGpabnNDcjZhMUQ1UERUWWx2YWJyQVR4TzJaWmRC?=
 =?utf-8?B?TEdHeTFHbmt5ak4wdXFCQ1RPNC9rRVFGRTdzVkIwZVEyMW9BbHkwVmpSR0dE?=
 =?utf-8?B?aVk3eW9HUjNTRHNtTk9TV3VJZEdIbHVZSUxKcXFFRlJ6MDBQTEZBWFFZbmJJ?=
 =?utf-8?B?MW8rMWZKWjRHTWl0M3VtVzF6MjFEMnFyc1lZNmg2TVRTNE9wRWlvbGpCdFYw?=
 =?utf-8?B?a1RUY3VIaEFWNEtJSld2OUxGMzVLWEM2dDR1emI1NmhKSFBqbkJMZVVKN1E0?=
 =?utf-8?B?NjdYR1N3Y1B6Rm1abmRpL2djLzczdVd3OUgzZ1BwT1hpVk5wTmxxeFNXbjVS?=
 =?utf-8?B?Y1kzdUZkQjl4QUhJWXBEbDR3Njlyb3hsS0E3OFFCNndQaUVERXREazV6Uy96?=
 =?utf-8?B?VzdsNFl1UGw0L3lSMjM1YVQrdEJtR09RaFg3N2xGUEtEZjJPK3VsUmVWQzZh?=
 =?utf-8?B?K0diTmxKS0o5TGVzT0t0M1ptSmdjbnZraEdIcVMwaXN0eGlIVEtpMmQ4YU9s?=
 =?utf-8?B?MHpVN01VZzNIVlpLNWMrMElVRlhHeFRXbHZZTjJmbVA3SVFvYVJwQmplM0FT?=
 =?utf-8?B?cXJDbXlNeTBieU1tZGt0bW5lRzZHbUt4ejlGa0RlSnJBN0FQMGJYZFJVMUZD?=
 =?utf-8?B?dk1lUEsvMWdERmw3OEFhTHlnM3MzcTBXUGxZRXhkZHkzQ3NLNDFpeFJwWVF6?=
 =?utf-8?B?V05TcGVGWUxMRUt4d0l3TVUrcjJWWWEzNGVKaGx5L3NZU2JaVGpseXRBRjVL?=
 =?utf-8?B?dmpkY21XS3lSMFRER3lsaEd6aFlweHhoS3RwM2hwUnozZVBkWllJRk9ZM1lu?=
 =?utf-8?B?Z0Z3amxvOFREbGl0bDdhTlRKdzZUcXc5VVFKMDVzL0xTYUdMbFFBRmN3STdk?=
 =?utf-8?B?REI3MmMxNmpHNmVwZTZ3YTZPTysvK0dCR2UwUExpdlZRUlgvVm4yZVJmWXI4?=
 =?utf-8?B?cjVyVmkwREkrK1p1NWd2SzArYUNnc2dNTGUvbUdkQ0FNN3huM0lPYksvRjh5?=
 =?utf-8?B?YWkvbjFNaWt5TlNBK0N5UFFCM2hyNjEwN1dNUndUMWdwcndaUHpWZ0RmSzR6?=
 =?utf-8?B?M3lzZGQwQ1ROaDVwbTE1UVgrdXZWQVFmbVR4dkcyb3dHbk9JUVBuNDlzbHov?=
 =?utf-8?B?WTc3d3llaDU3M3BKN3hCSXlxTjA3OUhXcFJRRWpBUjFnMU81TWFGMExPRXN2?=
 =?utf-8?B?Mlg2TmpRUmJ5YlRMQm5EL2c1bURyNmlPU2JaZVNKOUVEb3R0L29lTjBJNDhG?=
 =?utf-8?B?RUNYNU8zeEdYR1grd0F1MjZTdS80NEE1aXczVDFHNVFIMUdXcmJCa2t1dTRO?=
 =?utf-8?B?NTZhaVlrcHRsVDNsRVhyYmNNbWIyQlNZT3ZSZXQxR1B4VVkvWDZkWENTRmps?=
 =?utf-8?B?OFdsc2N4SEpFOHQ0R0F6VDNBVTYrSXlNTHNUOHNuVkxOdFFtMURXa2xVMXZw?=
 =?utf-8?B?Q090NmNDK2h0VG9BaXhMb3Z1aTZlaUNiL3RTcUlaV01hbkFJU3JpMUo3NkV3?=
 =?utf-8?B?VnUzeVlnSUprQTExZkI1YWtlRFFhd1R3ZXQ3UHVhdFlDY0hMMXQ4Znh0Vmtp?=
 =?utf-8?B?SWVUUDRFaE1OV3FMYys3ZWZFRzFnTU50OFVGNGlOZStoRHFVZDdsVERHNUQz?=
 =?utf-8?B?L20yaXRyZGdZTmpFYjhPbG9WMXBCSkJ2MXFrMk40SXhONUlEc2w0WldDMDhS?=
 =?utf-8?B?dkNyNjFlajF5VitydVdnK2dDU0d2UzNkYXFpY3JLT3BTaVh1R3BwNGlWVHAz?=
 =?utf-8?B?TngzRGE0Y1R3cVh3MzlEUzFtN3kvSXBTcityeml5RlpLUFUrZjhRVDRzZTdM?=
 =?utf-8?B?VEYyd1BjMVJrbCsxZWNQY2oyaWdiRC9pcDdOblB1eUhPU2Y3M0cwU1ROOUJP?=
 =?utf-8?B?Q21pZUZ4MUJ4QkpyVXU2eE5qR2NxTSt4TW5VMmhVajVWTnhCdWZ0a3F5d1Av?=
 =?utf-8?B?bDJoUFZVdTV4VFB1NjRpSmJPbzB0aGQzVEhhYjd6UHE1TmlidzA0NXRBYkxH?=
 =?utf-8?B?clk1YXhoMHdRVFNzN3pzSDBBTWVzdHdIa3NhQTJiSzB1Tm5QaVZTZTFsNFBL?=
 =?utf-8?Q?xbw1uhhlY0pjmPodsyupH8z27?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kjZQouuXYGdlwnMskbI5Nzbzm1VQPWDpBP1T6zg4SfHMxIhpL9rzltzvNkV/Oj0am/Uz2EWLJe5V9YlwOmK/T74w2flJKE56LMT/d3LC5PaO488J/2RNkKvluaRO6V+XnV5FzRIL9SKfpSHUELJGqSCMuG6kjY9b5qs6+rcEMye1FwpAszwDtHMzHQjAUD2TdLl+MlXTKJgbhYDsNoOE1oOL6na472nGw9FFgbJzVKJe/rkukzlUAuC1yS627FTNZu2db1mLgzfVelBZj6cL0nni1R5wSeRxmjX/8lVAByxac7jGEcLK6kA7KRtqE5YH0iz/BYyC/VxNpQRlea8eppJwDoR8xZITI4vnHWlKz6tzR4ZRL84np3YbWlKyLyGsmgkYPX2Qv7RwRpdxUQUYo3EPNLnca/9k+jyL0JabeCW+iJOA9/vgnoFnfTcDzw9XQcNgQ6X56wyX8Duy900KSk5/86C6/ZEYcrTx/tBGh5IK47gP5sbfF2fnIfS1bMooCP5g5pZQ1JEFIUx8zf3mG2rxszhvgmXFHbFf8NXfTEpDvWdElE+Y30DJfarquqiMa2xAnSOWTomPIMSbgi6BxasJ+CoR5N/Bp8uT+/WI7FeqYMl3kN3BHPkW6ZzHtiLs3Vh+t/9rLc9tNInTjHvHMszZDVqVconmGl3pLeIiGKBoT/AnHqWjhieTcvYn1mC1O9tdSpp1mj4dEpn/lGzaTBmX1vTcGdonEmG0a0mO9O1urTpHbQbBtzM8UtC0Z5mma4LYHQqL0HsY+jhYhlqT+gtct1aU3b765CDYazrMdhuWBjvlVuD4p2XfuaDpFTlU
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104baec9-ee3d-4e35-345e-08db1ae9bc26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:45:39.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByIFDR9Vdhj+XWQawxhWTwXbFdFIXgg505YSeeGkyjQcN8yOkaZT9/VBwNDoiwXnSA+b5ZFkLRGL37xG2MVv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020056
X-Proofpoint-GUID: WZiZF0WqrdiMSXddD3o_fYIzJ2c9LxVj
X-Proofpoint-ORIG-GUID: WZiZF0WqrdiMSXddD3o_fYIzJ2c9LxVj
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/23 05:14, Josef Bacik wrote:
> This flag only gets set when we're doing active zone tracking, and I'm
> going to need to use this flag for things related to this behavior.
> Rename the flag to represent what it actually means for the file system
> so it can be used in other ways and still make sense.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 69c09508afb5..2237685d1ed0 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -407,7 +407,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
>   		return 0;
>   
>   	used = btrfs_space_info_used(space_info, true);
> -	if (test_bit(BTRFS_FS_NO_OVERCOMMIT, &fs_info->flags) &&
> +	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
>   	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
>   		avail = 0;
>   	else
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f95b2c94d619..808cfa3091c5 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -524,8 +524,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>   		}
>   		atomic_set(&zone_info->active_zones_left,
>   			   max_active_zones - nactive);

> -		/* Overcommit does not work well with active zone tacking. */

  Nit:
  Consider moving this comment to the btrfs_can_overcommit() function,
  possibly during the apply.
