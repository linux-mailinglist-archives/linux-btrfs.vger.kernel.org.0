Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8D7B2EEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjI2JLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjI2JLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:11:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B0F11F;
        Fri, 29 Sep 2023 02:11:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK982H018469;
        Fri, 29 Sep 2023 09:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0RlWoWAiGhIxy5uMDLvbCt76muVtIyTTdTOuASTTBn0=;
 b=N1cikrm4hFYPTiwcWcgaVkQ/44dgr9OsCZTwXFl/NrTLIyueuQdJ2vU2yDxfwRSPBq/h
 HLLSWNqx5XbGO3jvdXplKC5qeKxu5ibAT9K8hgrg12Op+wp7/CkCNrN2tpZxbW3f7ycc
 cv3cZg/eJUQ11zin2ozD/JjD+H3BWVJcz8+VLy0JT4KyAUbWv2LCcqYbM9ENrN1ZVWsB
 ywkYmaoTEasodUZQTXemdwuMod2Cv6SFGeks0yF24SQQpARKhsQ2AV1WU2FuKtRkdeK3
 XDdFULuRxHSxdLuupiZvFXMAD0G0k9G4m3BiOIE1AjXcls64G2NGevZF1SaphHjIox3k cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xay2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:11:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T84x4Z015916;
        Fri, 29 Sep 2023 09:11:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh2c61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtgpGaxTV/vXaRyVUDaOsV67xbelbfTJQccHdMtrloQ21eq080QZU11OEu/hCdr8yhI7CP6uTZo0lZwf22xKb1ZCNGzYI8ms19ULehGUov+sO8cD3StI4Utk+t6EAiK1s1HdJwQ52z9mHU7H4DnLg5AVTd5JxWNcDEfuu80uAv+YjgEExnVV7H4NYcRFf1QB3o/vjsHMg4/E78TT79YGcW65KsO5bnpg1NL1VE+pkdx4cFnBflcgm9AnODEKKWx6epVqsSsDSsNKyNf2ikSRqha+kIxVCc5TtbG4ZAAymG8VzjAFqHxrILStn1ris1xTo52IG7b4mffncIEiDzKC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RlWoWAiGhIxy5uMDLvbCt76muVtIyTTdTOuASTTBn0=;
 b=T5PT7ziNgbkKzj15qaLze8nbAC2ML9DRpfmlFNVAgHCZW4JokM2tM4x17v9I6dWXkN77h8/LKnJDojChY/B9Wjdhf6NGnWl8sPHT/GUX2sHkj3LsUx8Z/5/GNS/yNiAkJxLxDMPcGb/3mFrz2nahGgQCJcAQfxL3E+PvwjD01xvynA3iCZzokiZt5NLmTY6Ty7GoxvZDeYxjaABQ4IPfykhBlNN7oepH/lKco30/2MNOgRHiPHrrPPv424vCPrfGYtXwjZ6kYpBPYyAzF4VSAAScI6CvuLLNilqWccgWnyItBNPUSvzcrWyJJZlwuPE1wVaOA8B/LXs67Va5V7HxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RlWoWAiGhIxy5uMDLvbCt76muVtIyTTdTOuASTTBn0=;
 b=tSOHUdeMtBIAg8YpTSkcTLJe0ITOHmMO1JcWD5oZrTSu0Vk9eHn7q6KPoB4b4fT+BRtbzuKZ4djrTdkGuwepn+nUNTw9VZARxoWQ6hEkduf5SvrE2nStRyjeCudotVVvJ2vGtKxNOwtlj9p0c/opEDfGbama9iIUFIIzpJMQhMQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Fri, 29 Sep
 2023 09:11:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 09:11:09 +0000
Message-ID: <8e038cf1-bd07-bab3-c3f8-0d77f4a5323f@oracle.com>
Date:   Fri, 29 Sep 2023 17:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/6] btrfs: quota mode helpers
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <fd723f002c3019b79c515d3408f951f0897f414f.1695942727.git.boris@bur.io>
 <2884e54c-9542-fdf7-9746-cfd7d56f5e19@oracle.com>
In-Reply-To: <2884e54c-9542-fdf7-9746-cfd7d56f5e19@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b2cde4-18ab-4c22-5dd3-08dbc0cc041f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJiz3iZi5XuGpd+inMAAxoMElONq1hzKDTgFoRRHSdTkjdlF5GjcEUCq+g5Wsb179H/xpm0nIXI+SAUPglN9MaGqAB7PHjs2BevWflP+3ZZPGRSzOE8X2qDbTJuGVbZE5hDQJ3dSwAC0h/3L4yTwFiPOyRyE035AmblvpfOHFmQi4JHukMnZoHwX2y8gQMyTXtxjR+YfE1+8eW5JtUBQvm+OTVKgvlKRZrZFvatTr0kzD7ZgsajWa6eWH58WTIpoiOfgZ6aY/Ua2Tkh97pxpJBGsDw0k9tIrLzaY5R+vDijmE/YyLMp4OcZzR44G4PzDqTtsR4OV2OS7LLJJ12wHKvHbL4P/GHfDPYYmNIZkpUC3Vr9puXO/1icylpEF0sH4vI0Oj9uI/xZ/kd56tFyQbUbQIylgDOrXV2b91rT98g7qafEWQ4meBbljL7p9CWeQHuReAKI06DtK2XPDdl27qhHwrZP/TU7N0jyJ2TyTNRPajHHmIPVaAW0RURzvLxvl26E1xpbEdZsjDOLRClniA/tx7ALGZ7ZXwpleinX+dUqTeoIMKAV+f7rFUF28sscmf1ggVTcKqD9NO2sG9acXZVYJ7sfv8Zndbkz4e1Qp2YQXmlBZVhifDV/Q5EzKjkG5asVX1QsDGfUed7pZHzf2kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(38100700002)(31696002)(86362001)(6512007)(316002)(53546011)(66556008)(66476007)(44832011)(8676002)(8936002)(31686004)(2906002)(15650500001)(66946007)(478600001)(6666004)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sks0MHZwWlBLZjdmSEJKT29VTDRUMlRpc3E5L1dQaGhUb1R0OCtXZ2F6eFBD?=
 =?utf-8?B?eWZ2VDNPM0FDRW5FYTgxS0k0dFZyTlFFMFl5NlJ3Z3E0VFdBM2t6cnhvL3h3?=
 =?utf-8?B?QzdHT21kREhVTXRnaXB6bFVxU2l6eXlVdFlISGo2bWNlbDl3SnFiTWN3MEJH?=
 =?utf-8?B?dnlZcC9QbjVDRGtwUSt4ZFZ4aHA1ZTFqYU1CRGJxdFhXSmF0ditDWTdWMEdJ?=
 =?utf-8?B?WFlvcFJhSGQreWYwa0ZUb2xRai9jOWdnY085TFZsUm9yVVBLbmhKcUV1d1lC?=
 =?utf-8?B?NlhhcFVLRzV5RE1KQ05HRGtRTFBwWnNXM2ltZDJyMDZzSlV6dkZ2SERrM1lz?=
 =?utf-8?B?TG9yb2R0NG9CVk5ncmtXL1JFVzFCRksvVGJsMGluYzkxM0dPQnhSL2VYWENW?=
 =?utf-8?B?MmVDOTg4cHZoVjhsU2FsYWJ1c0paT3pXLzF2NmxGYUxDdVJFUThPWW5oakR5?=
 =?utf-8?B?anZWazBOWlRkQTJoRzJpSXZRTWJIdFRKVXlweldKTlpPY2VCTDJ6ME81aVMz?=
 =?utf-8?B?d0ZsODlCSzIwSG9jVldRQ2s4NW9BOUhCcVJNYWFwTWdET0RBYnZqRW55NnFG?=
 =?utf-8?B?dEpGNi80K2xLY0JSeFFKSEJXTnEvMnkzOG0zaVQvbUdUUnFPRXpGa0hYaUt2?=
 =?utf-8?B?a1dRWUg4VHFuQ2xlSUw2aUdLaFl0NDJUMlRJYzFRT1d1RUZVMjQ2b3QrYWc2?=
 =?utf-8?B?dkd5V0lOODUvOHpuMkhIT3NHUTNJNDF2eDBBdjNvR2o3VTRFbDFIVEtTZnhx?=
 =?utf-8?B?cC84R284d3g0bERDTjJGSFU3VDRYMXhSZTJyYm9KUzNjc2lBM01lQmROWVgz?=
 =?utf-8?B?YWVtdzF4TnFpVVA3cmtsdHBQME54THlhWEdaWkQ1YnR3RTNodVRGQVlQT1Ft?=
 =?utf-8?B?cFIrRTBFRnU1aWFMQXZZMnRjT1lqUVFBVGY1UmJFM1ZVVEJ0aXFFUTFGdGd5?=
 =?utf-8?B?S1VlNmIzcUs3WG9INmtxS29BaHlqdzdqcHRMWmFxSlNWWkUrQk5kNnF1V0xu?=
 =?utf-8?B?dUk0cGlsMXVDSkMzdUd1SmdBQXVxRW9jdVJTYTQyNGduWStBeTIvcGFCY1o2?=
 =?utf-8?B?bitMMG92N0tpRzA1Z0hMOWlxUXo2SEV1Yi8yVWFnMnZtZVczbXRTOHh2Y05B?=
 =?utf-8?B?aE9uY2hISDdZMWdzQ09mOWxjK2dham14VkdtOGhwc1hmOVFGNnNMcDZ6aExQ?=
 =?utf-8?B?K1ZpM2VsM3FHK0s2S2JvTUwxN3l3aW5jR2dnWjdwUmtxZ3pUcHFZL2szK2Ra?=
 =?utf-8?B?aXVFcXRUSEpiSDQxaHVuTndhSmhUWmlqK01XY0ZERjhqT0dzNFhWbGQvaTBW?=
 =?utf-8?B?QXZhT21laEFXNlB3ZVNwc2tMZDAya2ZJZDhkNzNkREJEWkJaeUprR1JBRnhU?=
 =?utf-8?B?MWcrYjhPd1p5UENCMTBKUmxPL0VYTEFTdXR2RFlXVFdKaEVxVHBKTThjaU9Z?=
 =?utf-8?B?WE5yZ0RMTWZXZ1dJeW9FdjdqTEtFUFFJZ2s4WWZiMCtFMkdFQ0NtSHhBZVVi?=
 =?utf-8?B?Z0VPZHVzbG1lY094RHdCTnJrVklzaFlQS01jRDlvWCt0enNoeXpXenBNaUlV?=
 =?utf-8?B?S25LWHpCaXdvamVFRGk3M3NrU05ucHVHTVJwSE1FSElXWXRITFpRUXdhVjhU?=
 =?utf-8?B?Z3VoczQ5RGZkQW1RVUh2dTE1b1BUaTFoWUMyWUJpekJuRUp0S0ViM04rR0ps?=
 =?utf-8?B?Z0o3ZUpTQlY3aVdLb2pJTWx2K05pK3VpaUsvczRETlhJQVByaU9ka1Zma2RB?=
 =?utf-8?B?WGhRTG95YWJVZ3hFQnJ2RkRsUlRXaER1Um9Xd2xBTm41UGVRd0lWSWhOSE5p?=
 =?utf-8?B?cmM2MktvcUhpU0hPQ3hzZGdUUUxlN3Z3OWdvYmFtcUJIY2tZZjRDWUYyemVO?=
 =?utf-8?B?a2hpNzB6OHVsRUpXd1RJS1RVcEFnS1RHYWovVlJ4SFJSWWs2OTZkN0MzS2hw?=
 =?utf-8?B?QVh1Z2dDem9HL1lxMmIxQllFbGdMb0xEMlZjd2RjRWVOQTc3S2F3eENZMy9G?=
 =?utf-8?B?bFZQUnVISjdhTEFrUHNadWh2OGdoKzhwMmkvbWlvZmlRZWFKeHpHR0lod0pa?=
 =?utf-8?B?THRTbzVVU1JPd0RqSXpHeExUUFRYZm5iS2dFY0N5djkxbjVuRUVJazF6WGl1?=
 =?utf-8?Q?YBP4aHWKPKee7lSvc+xF9RWeC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ClmsHfzTyyUtUBW+pS/AeMB1PjV3GRCoGUZldtjf4mZKg5dw0XyoxLyVqKCvFNp/8NvviLyTKhFA4UtqX+eXkYTj5Sa8J5OB/gshOzdR6zmxXuZ0z1yk+g10Muc7yOQA7HmwY6BPbjSPpOc/m/wj+RybMbiyNw/bSU88vjZsL4stmXzoCzUq9cFXIrvoO9+rlFaZb2/5ZKyhXjMCPb7v05rfdD6S6Hs/vYx4/9I46un0v0YmM4D+VQU4EfMregS59h0qEa3w0REk+M3c4h0J1sWL8HFwjVVWQUUKRp9Vwsx+S8087gYy4/kH0qWX4yOGzblJPB3IbYPORWlolYfF7liiXc6stQyvrHxzwpsPxMKDbfbgGKrqZf5JukeBlWPHgjIuwBKN6th328ttIN57iG/9ub+akGOrsydG865Tm0Yl/IgR7vb8pf8IvLAsaRFbysERYs73KohTPPCoGxsBALgj8g6gTb2FrgJtwZ9E0Q877/agJhvXAxdo/GB9sFuhwdqsUW3m5bIYKIeXgJLJi9Hb1Dck9VG/CLMntVn4S3TgvkjgydxKd7NlSLDpBeyZmGfHTt6rkbkRc8cj1twhdfsZ8X5/l2x6bphMYrSO3DKhzRPbIreE4ZhXTXvAMC4vl4Y7ECC1kW2G/S9VuOrDl7R8LgXZdrKKFt9tv4iWsvxruKfj8J8JBWU0qxyA/rqCIYsKltKXcX3CLQDtMolapy/ffhwrMOLDpRq3Rrpehsl27rRsS9hhN0Tq2xRfJxBwIAnZ24Lir/5Y7fnfVO3vnCmsUvMzPJCwCiDj7CyEd+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b2cde4-18ab-4c22-5dd3-08dbc0cc041f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:11:08.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgEtOjPi+V6/UuTuaRxeDf7wAkzDFzFXp6AVZYKOjZyw06kMx/AnX3YgKxCWhr3YMPRlgGDKTpzJY+McHLSrhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290078
X-Proofpoint-ORIG-GUID: 048iw2MqT9t_8ckczze_jNZtW6PG2Go9
X-Proofpoint-GUID: 048iw2MqT9t_8ckczze_jNZtW6PG2Go9
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 16:57, Anand Jain wrote:
> On 29/09/2023 07:16, Boris Burkov wrote:
>> To facilitate skipping tests depending on the qgroup mode after mkfs,
>> add support for figuring out the mode. This cannot just rely on the new
>> sysfs file, since it might not be present on older kernels.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> Nits Applied locally.
> 
>> +_require_scratch_qgroup()
>> +{
>> +    _scratch_mkfs >>$seqres.full 2>&1
>> +    _scratch_mount
>> +    _run_btrfs_util_prog quota enable $SCRATCH_MNT
> 
> Some time ago, we stopped using _run_btrfs_util_prog() in favor of > $BTRFS_UTIL_PROG. The idea is that any errors are printed to stdout,
> which is good. However, $BTRFS_UTIL_PROG has a drawback: it doesn't
> print the command used, as run_check() does.

I'm correcting myself: We still use _run_btrfs_util_prog() in less
critical scenarios for quick status checks.

Thx, Anand

> 
> 
> 
>> +    _check_regular_qgroup $SCRATCH_DEV || _notrun "not running normal 
>> qgroups"
>> +    _scratch_unmount
>> +}
>> +
>> +_require_scratch_enable_simple_quota()
>> +{
>> +    _scratch_mkfs >>$seqres.full 2>&1
>> +    _scratch_mount
>> +    _qgroup_mode $SCRATCH_DEV | grep 'squota' && _notrun "cannot 
>> enable simple quota; on by default"
>> +    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT || _notrun 
>> "simple quotas not available"
>> +    _scratch_unmount
>> +}
> 
> Fixed lines above 80 chars long.
> 
> Thanks, Anand

