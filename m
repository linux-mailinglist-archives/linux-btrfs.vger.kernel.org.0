Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52B6AA596
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 00:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCCX1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 18:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCCX1g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 18:27:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE96424B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 15:27:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323LXp3b014275;
        Fri, 3 Mar 2023 23:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uNFlBh4VKhdN0VaambsTC6SEvmVhtleV+tRQgfdBemI=;
 b=CbAQJLDmzFomTkY36XmG/DLdOiRf/hNcLSZ1E+7HcxKbYS5NXcP/rv4qccxCE5gT4byg
 q44uML4aB0gzXjITAgNy+2+m+KbytDtg+0T3zOZQqO0RR5+IUCUoLbDIoo0yUTnC/N31
 AsWx/RBGNTgtFJdPTTNaHawhN63EAeeGirTzTu8kc9I4Ox91wbm/eqm1cUkx7j3rs25l
 2GY3XEPVWgJ0B6c6PMsX3pV2vR67bEECqVL+5e8OVMyhH/oL9m25ABzMCVYFqx82rCO+
 HDRmWBtvTIs/cpxkvuHeBia0jJUF3FfJQ7/D/LjHXi2M7QfW53Dy1EYgikn6SJ6dASbu NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6erm0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 23:27:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323Md7qR002188;
        Fri, 3 Mar 2023 23:27:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbvmbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 23:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCkdKz9zcB9uxxSfI4wBLTt2ylBxUhmrjARogRgOa2KkeC8he8QYecOpQTsDKyovmAsgZT1vpxLplGs2TAKcNUC1lGbnNGKUMXJcmuslg7KJvJm2Obdf2XOQySvp5gc0DdlaGfiPNhj7naoQYRM+Bu8UmSeV6JdAS2FuetmUsrpbjtOiFrtfPv6x0nhJ5U8idzUijV8rXPgSbRsBZZRabPnen7AAP9cBrr2rY+ulPUXXmuDB8rgaNsLfVNxWlTOl9Iy5VrXkbA0EUvGv7ytNy2yyos4sAJH8Mm6i6t/zYUB5GtuPWiRCeX6HhEghJg4sgLYq4BfTXqt35svHkvRBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNFlBh4VKhdN0VaambsTC6SEvmVhtleV+tRQgfdBemI=;
 b=FG564xVVxot8JEi3x9dKM3V0nlczSqqHD13QBhdsiWlMWDODaKlL6fKx48bQMciQ9ZJN8cVH+gL6kG5CuZUysXdRvqJWDjpzdn0lH7g8H3CIXOU0e8YZXJSAVtWIDRxih91JGFbUC/kzO0RCvOD3xjeYtbCXATGpeA3KOCR06AksdcIFRi1XL7S1qV4c9pH+joJ76RwvC+hrJiTDc/VLtKIf/QnxsoVjdUOFhPDdXjPBifwGooi9c0z+iXg3V46GZ1CJmwKJEGS0ZcM2n8azGybT/Panu2gtWOyCk4zJOyqmzpxmoYTzYsgIZ+eNSygvBiCiVt5V+XuCCBtWkcrdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNFlBh4VKhdN0VaambsTC6SEvmVhtleV+tRQgfdBemI=;
 b=gGPIwMzWd5ah6TgXZI/vXMK8pVqg77RvA+IYXbR65gAexEMho2YIw+xdVOE1odauhY2MXO5WGfZzMTJCj5qoY8qoZpVdqIQDXR/dq/f/hFBzTmz7SY+8e9G6tchboILxYgzuD7oyUpXqMDtQpXsROfGKgqIwmvGcLdHiE3Ut5ik=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.14; Fri, 3 Mar
 2023 23:27:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 23:27:27 +0000
Message-ID: <0976a9e7-64bb-e3d8-8841-9f1bb924c6e1@oracle.com>
Date:   Sat, 4 Mar 2023 07:27:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 13/13] btrfs: add raid-stripe-tree to features enabled
 with debug
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <98922293ba48f88d3a71241ccc8341f5b3f7ca33.1677750131.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <98922293ba48f88d3a71241ccc8341f5b3f7ca33.1677750131.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 135a24d4-4c39-45c1-5dd5-08db1c3ed9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGNGJndDs5s86sNtCJy+9+OhzmlnMi9rlq2ywwY09v5XWemNkKt4Rb5r0PfDpfoNyLbzouF/sPWfSz6f6TpOFQMp/KpU0ZNxxeBPAFabsHg6g5Rif/Skp/PJPcU7vO24SimmBtYwH+95VZhyz4Na40WjeZOb95/ylhGsLt+9YlQQKKqkEmlBhc3ILlZZ9OsJZ+ybGBh8cVgAu4SCzBRKrxHIQWsP25jhJwFyZTMFUUyT6n2NpHliknzDW76VFYOJglsoF2jfifR471SDZxGGJY3lzWjZrDZlJTZ0uDUb9m0FNcjVOnH2Yow7euSP8lmv+YdrX+ueWqoyWx2ssLuKAJ2riWoYBnOVRfXO/JEgheprE50M9gZ0aoH0nnxw90RJt2xhSLa0sXGwg2JhsNYV2xgGQaCQ+eZvgCnRk6oRgAqWvy6W8YdK+t6EqqamOVatXY2MK8HRqolrcmHQBT8QJBK1kciBpJLEFDbhKJdEun+KF3XAS06UI2KzrqKOgAvGdDl/h274bDTHuCPt87TaqWpIuLg/KNryBCYxHIaFJaP1gJnKQoBcr77JzzLG4NjDz+38HPFUDFYOe+77PSLtODxognClK4uhmHo59+smc7SIRxOKleF4ilB9CoV47rhrwRwLRWTLTVTXhEIE+HA9CrU0xhhX9EeVcq0vDVUhns2beH9Mwa/P87OakWpsExoIZu3egJqDO8r9ZKX5Ji42VNx5FDcsYr9Yqbpq2uRguRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(31696002)(86362001)(36756003)(54906003)(38100700002)(6916009)(8676002)(66946007)(66476007)(316002)(66556008)(4326008)(6506007)(53546011)(6666004)(31686004)(6486002)(186003)(478600001)(6512007)(26005)(44832011)(2906002)(4744005)(5660300002)(41300700001)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWx3RllDVjdtUXFDcm9MOTB2OGZOVXdlcUc5NHNBcnU3bGxtQ2hyN2JFRVBV?=
 =?utf-8?B?bjVCcGpIREpkRTJtN3BjYVhwaDB0QnRQSlQ4WURhSm91ZEtCbmxjM0JHS29v?=
 =?utf-8?B?SHZldW9VK0gxazFDN1hXOVBhUTdDQUJyUnRuaXJSWjR3ZUh2YnpMRTRkcDM1?=
 =?utf-8?B?QlRxQkhzWFhHbDlvMVBNaDZSait3UmpUOGR5d3B1d1ZaemRnc1ZvSCtjYWE3?=
 =?utf-8?B?RzhxTlZWTXIrWkcza0t2SmQ5ektGcEt4dlhWb05GcnJLMWQwV3NMNGR4eDlQ?=
 =?utf-8?B?cjVGVCtFeU9XTFp6ZGdoaWwvKzFmazlHbHppclVwYURBc3dxNUhyejQraHpX?=
 =?utf-8?B?eUdCemJQSEhpQ3pUSnNVUEc3QkVTSnhuOWNVeUxTNCtJV3YvY1E5ZXZwMWRZ?=
 =?utf-8?B?ZlNxSkEwZFViVU83bm53dHZEVHV0WHA4b0FoRGttZWhwMmZHY3kzUmw2NTJ2?=
 =?utf-8?B?TnBySFhVNjJsK3pjN0NmclZubENjNHF1M3V2RittRURydHVUbEt0SXl5bVhJ?=
 =?utf-8?B?aW5NbStVazhCbzlGR3JEWkVtUmVjTDUxOTJlSmhtS2RwU09sZjFKRzlQdlZD?=
 =?utf-8?B?RU1YSkI4Vi9vL2xEMUxhRllyY3JDQVlBQ0xhRmRybnRzQ2VRWTlMODYrWW5k?=
 =?utf-8?B?OThKeW93MkRneWVpVmdacGJvS29YczViY2dYVW11TXBSamt1QnNSOFpqYTRx?=
 =?utf-8?B?UjN2YXpJZTJmTHcyeVp4dzhkaUtEaTZxeURkMldYdXY2RUJGaklsYWNDTjNQ?=
 =?utf-8?B?TDQ1clhTZllyU3RDcGFVQUdmbTRtYXVkR2RnYWRHanZkaFJWZHBabFV0bk1v?=
 =?utf-8?B?a21ZR2NqTUNTamU2WFhmSkZvWnc2b0NIOEhuNFVxNDlnOVBBc3lyd0gzU1Rw?=
 =?utf-8?B?TDhiSHYzdU9XLzMyeUp5dlIwMXZLS0VxWmpBaGpUOTRkMXpwM09YMjZaMHJT?=
 =?utf-8?B?MU1JL0JHR2FnaFB6YXFvdzk5U3VPVUtJQ1BoSk1vR3NRbE91d0Faa0RRK0tV?=
 =?utf-8?B?OVViMlhxMUVpbG0wdWM3aFZTRnZFa3RTcUpROGV1MkRxQ08waTBHWVRxMk1y?=
 =?utf-8?B?TCtaRmVRNlNtSCtka1Z2Y25mSnl5MG1JZzBJMlJMUHFOSVhROWJQVDBuRlJ6?=
 =?utf-8?B?WDErTjJpOXJEci9DcUltRnk1aFo1YzVzQ2dzTW0wUzJVYzlxVWVjOEsrcVJE?=
 =?utf-8?B?eWhOZkZFODZ5ZlhPNVVjcnE4Y2E2VHlZVkNlTTVMKzVJdW5sWWlocHFDZ3Vu?=
 =?utf-8?B?K3AyMndjSzdGSUtjRjNEWDMxamJYWUJRb2tpVVIxV3drMVpraisvUThodVJh?=
 =?utf-8?B?SmZyUCt2NVRzdUw1cThhcTk2bUVBN1ZQOVE3VzNmZzlFT1hTNXIvNXNDUHZD?=
 =?utf-8?B?Z0t6dkRkYjV3R2JjSXVIME9tMWtmN3RjSzN0MXEvTkdIbU1Va3l5b2dRRkpS?=
 =?utf-8?B?Uy9haDdoaVhSczkrS2tseStxWWlseVhveDAvVDlXZDlQQ3Rlam55b0JzcHBJ?=
 =?utf-8?B?RUEzRmV6SFZPSkRML0p4TStuQ2ZRNENKU2ZmTjVXMnBsZC9PRDFjek13VE5z?=
 =?utf-8?B?MmxaSUtUanAxcGlIQzBQSzVqSiticTFTdnZhQTBaK1RvSnI4dklPR20ySGNM?=
 =?utf-8?B?OS94ZklaajBCTkpoZU8wMTNaQ3FNNTJ0aUZTTDhpYlVuNnZFekhOaENKeVI0?=
 =?utf-8?B?MldSMi9VcVlHUHBXMDBIVEM2YkhDaE9kTzlNellYNFMrUG02YzJHcUZWTzRK?=
 =?utf-8?B?ZWlPS3BFRUswMDZwKzRjRjc0QzFQdkJ4ZVBxejRrcjBzV3BJN2Fac21XWmFw?=
 =?utf-8?B?cHFPQWU4ZG9kenJ4S1pQWHh4N0RFeEhnc1pOSm94bW1Gdm5NbnNNR3BrNlpV?=
 =?utf-8?B?eURBR2I5N01QajlBWFlEVENwOFNxeGM2VUtsNUNBWmIxWGlKTVdEQldjOEc0?=
 =?utf-8?B?bE0yNHJta0k4VXRROWViRUYzQVNsckpHRDZ4cC9CRFkwTndvREllcFNETmJE?=
 =?utf-8?B?ekI5eVowVk5CTzdjanlnN0NBalo2eUx3ck1zUm1RMkdtY05sTDJkK0hGSVdx?=
 =?utf-8?B?bWJaaGVBdUxKeS92VktqcHZlc2tyMUxHR3Z3KzIwV0VoU3BqZkRlRk5KcENY?=
 =?utf-8?B?dWIwaWkwcUt4dHlEMCtBQTExM3FkcTkxUTJBakJLbzdkSklSTlZhcGF0YmJS?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q3Hr+ay432muH2Ugvh+pvrRzVrHuU3smxtWhnt7nzX26xYNdF8743ADQ52QcXz5Fu7XyZ7tJuXHmcd1T7CjbaROI8sWO1GtGAlOxGsondvidJ7ewGQ7sE8I3NooGta5Rnm8pQeP03ybWtmM0O4FA659CB4CgkG92gpShCbByHHvwxeLxjefjExNd4p0RYFPkGeJdXTdWz9s0rhH07xRotBsrxbq7B6O8V+hEKQ2NDbxTeoaf/K8f1vLU9M7gMh0UlELUGPd45sR9790jnuUd/qwIPBtDOvWl4d737KjYJGE+mEG7OVdyHPKJ5ic+rLFxzLpspsSC/3KNsOI3eAAXWrTvVTd02va4oJNLWHPWLDsmB58rLoOllODi6L4zp9JbmGVLWP8y0aBlEsfXvM5iro0fBZOAZ5cz55akooLyTN6HN3CQkZ88FHnArycFtVg7bPfIljxHYiSME2VotjVBeGSO2r+wTrR4Z+ecEFegNIVzQOhlakFoxsTtViuBQ1mE8SpDMR9BHi9eLON8bva0izJ08qjdpkaGCeKhVkKLIzS7pOEiWEkKaV4kVrNnHAlL4+Vyc7LNEhs/e+Bl8WbBWlS4nxzArfraF2AFtUIRfHJ4G0VQCyH0hzADvbMUAP7oLWFAtEAzeSyhrHKoUywUlSMWT1Icq9p7lx114MibPnAQVRkCXR16ZMb2kPxzJKMRXrMPW86JiEk4pdSMy5Ah75ZpWvplSIADHH4oP4OY/w5kwW1yiCR2bNBy41XX4l8twjy93kRwUI1YI4eh0aJyTg0uqA66yR3HO28boCsw/sgyfRU/otdAHWJdE4ohKpWIEugNtFqttHxHeAFNPvx09VBRTaC/A3psDXu7CgeWe8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135a24d4-4c39-45c1-5dd5-08db1c3ed9c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 23:27:27.3934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCAeSGPT8ml/tP81RjcUEuK0QNaj2aojEnxgSdsLzKC+dqhsm1aoqYmBbxyVh2UxaiMx1GU7qKkDTfpOPY6hZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_05,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030198
X-Proofpoint-ORIG-GUID: d32ZkeAWc15Okyvff5ovpzvbJEO2sylQ
X-Proofpoint-GUID: d32ZkeAWc15Okyvff5ovpzvbJEO2sylQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/03/2023 17:45, Johannes Thumshirn wrote:
> Until the RAID stripe tree code is well enough tested and feature
> complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
> want to use it are actually using it.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

