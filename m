Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092F73B233
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 10:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFWIAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFWIAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 04:00:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC771BCC
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 01:00:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N54qMm023473
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 08:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Bai0KHhQ97mJQxiEGPagMGnXGlfltVPH1wtBWmEm5Ak=;
 b=enqOvq2vzi4VMJxA/fw/1zCsGxT0brZCBjZ/zefj9SR//zPDExDhEGA2ENN0nnXDxlUE
 3z0nFmTrttl4eEGev6N3Ly7WtW4rZx8wLaTW8uryIfN9QWegP3891G50aQ4eiKiFccfC
 y2HaSFZSahHeifMo/L+/kIT5889JAvyT4R/0vQ4f/m7PfH1K4XgjIlffsinWXtOYSnnF
 fWOTYnaCVWuXOZVNls+yn1/Xu5Q1kp4rxqn4HiAPabqz1qZMrXNQ/zYzV2L91xrbpljs
 HHjLfd4AsrY5zPVBZaHQ1ZkVhvNNwkifkPltt3fhEaiPSH0IhY3LfFS+4RHLUgashudH WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etujvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 08:00:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6APqQ007913
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 08:00:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w191jdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 08:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flcry9vlbcxs6Zl8gemucrF9ChFkdvbMWk6Qgtzr+SwY/fC0jTjYsHYTCkn6AN9oS2hqUHH63ZTFQ3QxI79WBH3zHKqOiXHaB1Tl+MW/xEt2aLBi/QdN3tTT6y5FHT4wV1wqlbPCFls7+G5LHEXaqHJuaHUlSsCMqAMaMTWgsFD5JKggqRFKMOZzFqTSo1w0j7UobgQMTEOFL/Mn3mZFOpBHDQvSOs33v83UYPcAY4qmj3LjfuwyE0vdtXIQFr5lF30mubMs2T7n79uxcUu28bophIY9vsZjr16+5AZ+qh0ZK55gtlsIR5Hv2FQ6sYBOM2fL66HfD3qEIuRjBM8muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bai0KHhQ97mJQxiEGPagMGnXGlfltVPH1wtBWmEm5Ak=;
 b=Ik3btKvy7BI1rYywQXogTocJE4RdfQuJp7Fa6yKURa1ddA8lFa85bpnUTi7M+3iqFRbe8HVW0qxsDQg8vHcPgrv5qnHdhbtbjoSVxSkxwi+gGh0KdSI/q5sZ7bkvck4enRD37I3aw1zm+ddcYTqECF/VL0avfalwIf9fFzmQ85MIJmXfDvg3MIpx3+zGNyhZv5U6FsdYvgiLvOVZbPbePKjkdJWEJjXif74h3V8a+TFNdmBVatPZxlQl61juNZWhqFOlOIFF1wDmveYXQGRHI+kTJhnwn6+RWpwAe3o6J3nnUaz5QHwKYXb3lhPe+ygdbfUL+xP7ZEth4fIc/DZVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bai0KHhQ97mJQxiEGPagMGnXGlfltVPH1wtBWmEm5Ak=;
 b=vsR0PsswiNJLXmGtSywPW0rWN//Xh7Iw1UXybx2yeiFl+PxyHkEIulTAHOyRKQO/K19wDg0NY3jbQ/CyNWvke92xfhOtciTQL30vaLTvRPv7YIAgsZzph6r5Ji762cUyTmBEHyWJfoTNSQb8OGl8YP/P5DaTSq4wUnQhLScPy9g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 07:59:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:59:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: tests/fsstress.c: move delete_subvol_children under HAVE_BTRFSUTIL_H
Date:   Fri, 23 Jun 2023 15:59:02 +0800
Message-Id: <03ed9298c3cf19854db54332d276d179fa666de8.1687485959.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687485959.git.anand.jain@oracle.com>
References: <cover.1687485959.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f739254-bf18-45ee-12d2-08db73bfd712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT3jdeEpoyr/eTpZ059ryrfFDEL6ev0InJZBUhEo+UUsP/NoJeBUiKDATRHUCwbqVUn3trNjmJCmdAM4IE/XpmglGvwV2KSZbIiFhuGKMjHaIZ0uWm6WIQY7NRyzFiqlfDVvhOxldInS9BT0sANe++mULztF6Eg/F7/c9GhVb+W1LtquecRMlSRHnSeeOXXqnZ7X+Wn/jdkcFi/zyzCBPbMe+zgLJnZF18tjF2zlIGCDivxLsSuUCwh8+juwmdCrTnZUo4tjxsbbH81VnUc2Oiq2VkrzSt2NvTS9XBVlG7o+RcNxU+OCRvlaTS9pVXS//2ybHWAk+1F9ktjrQYd5XK3eL6b2avgSK9gymU/0NQR+BkbFY9FKNqG90tDI1CccCOAdPIRWk8pyWrIIDL3DCrq4dE+FRSXP447wODcmi3GcijYA/DE/V8E3L/MFrDyv4RFqpR5hrLpqgohlMfwOkEZJI/vq0T0iaaj3Z7tWIiSkh7fie4DqwcrYt1MMtl2qTSMomivz13xYBmm5YeBHikSq6aai/t+zasnWRAZJnJ5EYgAXxz9cgREm4DEK77Qo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4744005)(2906002)(44832011)(8676002)(5660300002)(8936002)(36756003)(41300700001)(86362001)(6666004)(6486002)(478600001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNmbzk2RUZjQzI3a3g3RVZ1dmdBRmF0NEc4UTlQaG1qTXRvckY2TnlVWW55?=
 =?utf-8?B?SnhnREp0MHAvb1AxVWpRY1dRZzFPQzNvbEQ2L0xSeElmWmhIMlFVMXNxK202?=
 =?utf-8?B?Rk9mdkZVbU9lcDNoa1podmdIWEoxUmQ1WkxwQ3pDa2REWkxPVW5mMFl1S1ZR?=
 =?utf-8?B?TkxjcGZyQlNCMGZwK1RXQnlhdnFoYUp5RFluVVBySGVTVEpCZitOSm1MMmZk?=
 =?utf-8?B?dDJQVk9Qa3BkaXRjTFFRd1JzajR2aFJoYlFZNmxUUzk0ZjYrTUdDSDM3OWZQ?=
 =?utf-8?B?eTdFNzFZVS9wM2JxQWFVd3RRNDBnV0tyaUNaRDBERjkrendwd1BaYnhNOFVu?=
 =?utf-8?B?K05OS1g3b2huR29nc2Nvb3Q5KzNqaHVESWtIYkFqd0l6bjVpamxLdnI2ZGVN?=
 =?utf-8?B?Q1VQZ1ZGSzFCL2pacjhHeDU4SjhhbFdEV08rb0hwRzBseTlwKzErN2s3TE9Z?=
 =?utf-8?B?OVJZMmNpSTJELzhPWFJwU2ZNMGVuZzQ0eWVwcjZPMjhzMFZjd1ZzeSt1NzAx?=
 =?utf-8?B?MWpEU0FnRDZYdFA1N0V5NHpLei9lVnpJWXRwM3BqU1BmQVAwaEVoY0FWUFU4?=
 =?utf-8?B?V1ZEWVdySlc3dDYyd2hLZVluZVNYblYvTHJrZXNSaWpCUXMyRDhSSkE5ZjNF?=
 =?utf-8?B?YUc4SGxRWEJCSEFLTktQWFpMbGQvbnhNRFBuc1lraU44RFRITk1JNytJRkdP?=
 =?utf-8?B?eUpCcEptK3VCVVJxdTJJM1VCbnRWTUdIME43YWtUZ3I1ZEZtTnRXYVJlMkFk?=
 =?utf-8?B?Ty8rMk9QdHVNWVAvQzRnZCtmaUVnVHoxYXlBK3NnZGpoeExKVC9BaG14bnM1?=
 =?utf-8?B?NzJNTkJsQmx3NVZqU3h3UWJHRVRaa0VGM3pZVVEwbHBJc3Erc2JhOFR2YlM5?=
 =?utf-8?B?NzQxYXlFa0phVGhwWTJBRUVVaDZxZ3BmNUVReGl2MGJycnJrSFhGZHZrempR?=
 =?utf-8?B?bEdtZ3RjTlNwUURMRG1TSHdKcW51d0JuQk90NEhoMlpCcmQ1N0FXcjJTVHhh?=
 =?utf-8?B?SU9nYjAxQlYyZ1NTODJyRWJPN2hpZi9mZmc2WHpQSWtwdkd6ZEFmc1o2RmEx?=
 =?utf-8?B?N0IvckpXTzRkUjd2RG82RFg0WmtZazM5YUd0UkJwNFM1NW1BTjlEWEJTemNi?=
 =?utf-8?B?eDhlQlJ2ZXh4NWVOaTE1MDhTSzBydjI1YkFEdVdvRU5EcDFIZS9iWTc1THBE?=
 =?utf-8?B?U3JmUHpQbXh3NHZMTlcyZUpqR1B6UjBIelBkV1E1WXZ4Nm0yVmNtazhmaFRL?=
 =?utf-8?B?RDF1YUlFT1lhRFFzSWQ0cWRkaFJSL2Vvb1Joc3Era3hHTjNDUlNjOTdTUVpz?=
 =?utf-8?B?NjkwZXNWR1NnZ0E3RFYzblA3bFJFUHRHTitER1Z4aUkzbklMQ28yWG1Pc0NQ?=
 =?utf-8?B?RDduV2pRSTA3dHZ6OWlpNDVmVkx6WFFPM282b0ZXZ2I2Nk5uRHBjalZWdmg4?=
 =?utf-8?B?WHFURmtWZHhwVjFtcUtMWXlEZjkyZ2NkTVRTWkZJOERPMmhnVmFidnNSWEVz?=
 =?utf-8?B?dktvaWMwcjMzazl2SmJ4ODJ5anZLT0Jsalh2NWNxZUcwaCt4K1lsTHdhZHBq?=
 =?utf-8?B?Wm1OV2pybGpHY05pUEF4R3FtLzNpMWRjNzJ4VEszV0JMYmthT2VIclpMNHBW?=
 =?utf-8?B?YTBNYS83amRneUE2ZEdxd2tXOHNaUjdiaHFPMGJoYnRCZG1BbDRvRHVERm1m?=
 =?utf-8?B?eXQ1d1RuLyt1WlFMV3N5Y0YrUVdZTHRTVXU3bWM4VWRJaUF6NXZpSjRnY1Zi?=
 =?utf-8?B?TkVtTHhtWnVzYUdLOWc1Y012Sm1EVjBSZG85aWs0RUxPTWMzSEs2RlErYUdn?=
 =?utf-8?B?QnA5OWlaYjN4UG9mWlMzV2hDdUNQZXg5ZVN4MElwRHAzMTNiZ2hITWNscnFQ?=
 =?utf-8?B?dHl0VTk3K2JROGdNa2lUOHhabHlGU3E4T0IyQW55WVcyUFRKbkVNS1pLVW8x?=
 =?utf-8?B?aG9hMllublFFd0xPSkZ1eEhFUEhneTNMbk1QS1JyYVovVXFTMHUvYXpmYVVE?=
 =?utf-8?B?cVVsQ3BtQk1LK2VGNGZhZ1JuaVAxTGtMZmEwV0V3dTMwMXc2N3JZMHorSWtu?=
 =?utf-8?B?VWNpRGUyTmRmUFFqK0dRMzF4c2ZiM2ZiVUdkWG5pcVNVa3loQUtCVElwZFFh?=
 =?utf-8?Q?2FXvR53L+CiPeOIKxvN214LcB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MW/1sKeeHZOMCrf0qnAC+kvM2M9Ux2qeuo4mBJ8jzrkDqu/2ausd3BEWWXX5ojSdj7rAx8Yfvel/9qW62IKp8+k7OxC2W30HJod/xDy5kWAEzZ0J1fdBfxJQfC8AqXwhmGxHxf739Age5GgkKMhnE2GGccOkb9m/e39urGiernPec4QElNohQCyZZ8xmfMoWpU4373qPfj7I/SCGAGfp0NXd9bNw3ZH9MViawOEWPYkTEsJcO5DxXILXuuoYCYyzc2d7trZgY2lghcpQkF/KqVG1gAiMPxGZiU10ZjIVmZg5YoPO+ONCC9IMh17bT/4/P3xLgUVnZvFpPv1N13xRFlT+ni5NvhZ28CZZERCXIxlk1M1i3m2u/YVP30XoCJJTj7rA8vuCe2BsRDaLywUIz7tCEfZc4u5P15S8OCuanMo6XT0UXiw1t6Pt2ndye/L0nn884kXESRTRdOeKEpWqPR6z9ZvXGgTd4OnzTuFAbfpl/gnxcLf/Ou25Ldgfc8eeww8QlcJf2PjIkFG94idi7cYFuSN67uPXYcD2OiYd+mYRsZ1AFDLwYdUcwx9DuWzx1Dum2C7OQ1shAmOlIgN5RUZvVGslp94LEOvgo176F73c2DRk7mak041c6rrb/QmCU+iIdrmyCtlK4X+AY+y1kpWeSE3H/cueFOpRsEomm41g8Be3MD7RWmPika9jGYNnBHU/RkoI7WPulW4quQUGJvXgo2r/y/AiSOFkuznxk0m2CYZPTZuHKTez+fbNJBaDWKP22T2MMG3M0U48G5trqQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f739254-bf18-45ee-12d2-08db73bfd712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:59:58.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1w/6vDP2CJ5RWOiiNnI5wyfMUWuolJXY/goAnBPCi/IWARhrHjfjuh9RpRS6+Mf3wWSBcy4PWLOk4nLaEsDEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230071
X-Proofpoint-GUID: 17uIME8kULcj853WHiTQGk5-19nprqry
X-Proofpoint-ORIG-GUID: 17uIME8kULcj853WHiTQGk5-19nprqry
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Bring the  'delete_subvol_children' function under the HAVE_BTRFSUTIL_H
define and fix the following warnings. This function is called only when
'HAVE_BTRFSUTILS_H' is defined.

tests/fsstress.c:1183:1: warning: ‘delete_subvol_children’ defined but not used [-Wunused-function]
 1183 | delete_subvol_children(int parid

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/fsstress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/fsstress.c b/tests/fsstress.c
index 5fd347ccf1d4..3b8cde847aa1 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -1179,6 +1179,7 @@ del_from_flist(int ft, int slot)
 		ftp->nfiles--;
 }
 
+#ifdef HAVE_BTRFSUTIL_H
 static void
 delete_subvol_children(int parid)
 {
@@ -1198,6 +1199,7 @@ again:
 		}
 	}
 }
+#endif
 
 static fent_t *
 dirid_to_fent(int dirid)
-- 
2.39.2

