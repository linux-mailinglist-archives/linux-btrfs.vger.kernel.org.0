Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB857739910
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFVIMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVIMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:12:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7961BC5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:12:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7plXc015253;
        Thu, 22 Jun 2023 08:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VaNL96qcoFObvNP6okA0+fKoxTdglLLY6W9tgMmOLlk=;
 b=B+9dE0qbHvm+3DVyTUgsuTiy4CuaEZstGxoxujqNWkqrdgWbvgEROOFAUz0DQKBlBQ+1
 DrZW4W3QQupQjsRL14zGmqRHiVv7k32ACWK+9EWj8ICNMszUKl6On2HScEQxjNoWtbtI
 3QfrVUtju4242MDXxgJUu0BNQJP+RyjJERzFmlGAGPnhdOSXJ7ahmdj233/rTvphMwN2
 NjhfDKh5kpHlORYDWC6+Vq6I7DkbwgoBpYEsvHABj8Q+37xqlIgIL/tGKFXbv22o8w5b
 lnyrdFB0ybMo1PBbazvH8BOOuREePUcnOntiF+LCl/Nv69F+LjsvJs62Y0rQWlELxiGL lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbsa1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 08:12:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6HgFp028871;
        Thu, 22 Jun 2023 08:12:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939d6uj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 08:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVnEVwb/lEuboHySw8Byym4lJ7tIk1iPKGBEAawOssDm4Z/5ee2INDh/CBCLqUY42kkNYy6dV8SgRtuBt0Twk85im+ueW+pHbju8zub7v9GLEPt29M8TKEMlarvTx7jlj8Q/xv7pu74tPlsYMlu4ouQzL/JgkVnCLwGmVJnWCKCQsKa7VERNMeBoJPPgxtVdYI+L3UDRq2pP0oxZzfuPs34uG4hicW8l22aiomooF3uR2fqGOFY40ap+oxvNv/QpR9AiUcnPBkVlKimyWraTQF6FXYs14JZIiBNBv/MZHUXCN6yhkqT3Ip0PYE5lxyPnVbQXep8eZyGmyvi9ywqDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaNL96qcoFObvNP6okA0+fKoxTdglLLY6W9tgMmOLlk=;
 b=DWALQVz4t3FIdrvOKP83Pdea1xTh/O1MU35q6OwuNUpnFCAXguVzaciG8D7rw0VeHCkHRbV1vOHKrJMjC4WF+5Od9mMlFiSnwWt0mt5NvgvfeRdv9m+/ezcIIt0x3fTqtZrQjnPx8nSv1WBfw56pMBbAFxYv9nHnxgzoBn4Zy8kZ5DWFjxnZ6klA35S7YtPyCq8Tr/lcn1q1coKcib6cuExcHh77D1+RWp/vXz29yFvQEvhFLh/ywT5fPldsjgUitClOkceCIuQ/MKAJV1sNir+0uaCloL5ZjnvkR14/7+z5xhXIdcXfus2V9hKhprVOgR+qBbWAGfzSB9MUUEDkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaNL96qcoFObvNP6okA0+fKoxTdglLLY6W9tgMmOLlk=;
 b=PUR2oZ0wTEvota7ysoE7B285LDeGG/gNWrcOi6lGePx8ucYTYuJhf/elN33wZp7Nvnwwe4wdOKjqrf1YQcpP9pvFwxpYBzsJekLIFutbCaueGMr/mGb1IgWkJrPxwmn4kENe71tjjT0+X5Y81e4/fFNsKnUhAwiBuvMFvdqNrlc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 22 Jun
 2023 08:12:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 08:12:43 +0000
Message-ID: <59b2dacf-d014-cf48-3dbb-fc442c13cd34@oracle.com>
Date:   Thu, 22 Jun 2023 16:12:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] btrfs-progs: tests:
 misc/057-btrfstune-free-space-tree check for btrfs acl support
Content-Language: en-GB
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1687242517.git.anand.jain@oracle.com>
 <4884e218dfb91cd1290d42ec030bd8c1af54bdcb.1687242517.git.anand.jain@oracle.com>
 <20230621145806.GR16168@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230621145806.GR16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: be14676e-d1e2-4978-bac1-08db72f8748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OIVnYSUbEWfVe08WEdeG+1veF1U67WGhbJZw6KZzoNm/JZ7K0sNergrvLeVlIf4Tj372DeV0O0IoWxIFpquOA6YawsiCX4d9Lcii3YV7Z3EdDfuiqIvzGOCua7RCZyHDGGs4Han4thCiiyPjJmYaXj6vgt9tTEYXg+56q8AY0QwLFHQa/i2hg1/Vm/Aafhs18JZC7G56Fmy+GgzhF39lxqYkpeHKkCdDG7vk5DwNqbS5VRLnCVNxs4ZHSnwHhzhdqg33a4uQgBwd7wNKfCawhRywJxePhpJ9341nw4Tgulkx5+K2I/dQaBSSVTQyNs9mIZWf2sgmLp84kUs2uZzncF7UKvK4PMGCHvxhP+9HuZBL3WDhbYUruSZtHA+5rnRwgzQ+tNLTQBjnNH8fRzxjdr99QBhyojsy4crnXBokETEpRT146iE4nIy9p8YKSuWbz40Q9326iI9cUDfZ5wroh4sY8sSZEHUAKIDo49W3LaUDiSafEt1dQTnABemHX9i6joWBgA1j7k3MGaBcFvMGB/RC2/fu/PVWu3+TO/MhMuMM/dSBNW2YrV6TFYs4YwWva4ZPKSvSPX7nIW96JNSK8mUC7O+Mv9k9h4GkQpXGU/sZCjrgcsP0GCQrtdpE7p/KBC0lc/DeyqeDXJaYrVf66A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199021)(316002)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(8676002)(36756003)(38100700002)(6506007)(6512007)(186003)(6486002)(558084003)(31686004)(66476007)(6916009)(4326008)(66556008)(66946007)(478600001)(31696002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEUwK1A0d1YzTkNCQXpCV1N4NHp5VUtlUlhHYnovdmZKQ3hBRitSZDJGMkt6?=
 =?utf-8?B?Rjl6K1hISllIcU1VVm5Qbnk3Q1dpc29tbG1kK3hKSWx5YTZwR0ZqRVplOGZv?=
 =?utf-8?B?MHFtblA0OUZRbHQ1WnFMZDNMWXc5aGJpK3JsWGJyNVI5c2FzbWtrb04yNGEv?=
 =?utf-8?B?M3FObkZiYXZBdjNObThselUzMnRiNkd3WjU0V3R1VHVHNG82Q1Bhbm5aTWk4?=
 =?utf-8?B?L3hRYlBJWjRSdFhvVUZWOGVXT0x1K3k0aUxMb2ovMnFha3dtM1MwNG5yL21u?=
 =?utf-8?B?S3JaeEhDRG5jMEVnejRNUm9KcHA0L0xqM1diUGJodnY2NVRHSlFVak9IWjJP?=
 =?utf-8?B?eEJDKy9MSkYwcTZWc1FKK1Q4NFVTaFlUOVpVNXRLVlI2WngycHA2bVpQMThB?=
 =?utf-8?B?LytScTFMTEZlelMyRHRhU2VIZVB6aDVjKzBYd2VHbnNtUjhBaG85T2I5Z2tH?=
 =?utf-8?B?TWd6YTl6aHpWdEhNV3oyaEM3NmhJRDFRbFArcGdQSEFyODNsSkJPWUZ5SUVj?=
 =?utf-8?B?MzlRQTlJU1cxdkprTy8zcGNESDRiYklNNWpzRDhsd2J6UTVZWTQwK3E1M2xy?=
 =?utf-8?B?QzNoQUJnVjVWbmE5MGNlcnl1Qi9HaTRlR0ZUSllsOTFQekpwZWVZaFBvdWRR?=
 =?utf-8?B?cEhMK3BtWCtDazh4aGhFRXFuVk5QbUdLOW5ma1BUT05Ya1BVUnR5em1wRGxV?=
 =?utf-8?B?Sm9rVjBETVc1WEtIWGlWM3BkRWFxTW9KWnFHaFFsZy9lSDJiSUYwcnVJSFpl?=
 =?utf-8?B?SnoxZEVhK3cwcU1rbW8wdFlqT1J2L3NET3pudDdvdDdmUlB5TG4zWWlGSUZm?=
 =?utf-8?B?MWhOU2xHaHpYRXV0LzJHYnpuOVdpckFHNHhwa21NNDlxck9nbUJJSGpsa1Rt?=
 =?utf-8?B?YVBkUUFjNFJEVmpHWWt2NE81cXY0QklJTGtrc0h4b3FVQWdJcjVwNHhlUmVi?=
 =?utf-8?B?N2dHV2xFKzVXNHg0UjNPMUo2WklSNVZRTjZiaGJtNW04WHdNWkNSRVVSRS94?=
 =?utf-8?B?YkNRbFAyR2srcWNCak9wek8zVTY4cFdyV0pYclREMXY4YWJzOHp4RjluVUpo?=
 =?utf-8?B?RExZaFp3anJjRXNsQStGSndWS2dCa2pDTUkzc2psOWNLcEUvdjZQMXNRNTNX?=
 =?utf-8?B?Qnk5RDVsb2xrQUpFNVRxMmorQThDOTR5Q1dCVHJudHJwWkdSeWVINVUvUjdu?=
 =?utf-8?B?RWxoYmJxUFFyMWdwcmVHQ3JJUWU5Wkltb3hCaElEUXRnMHp5cmpVRzEzSVNm?=
 =?utf-8?B?TEpRdll2T1U0QzhabGgrdGRUZXFWcGFWZTJERWwwRVRwcFZ6T0pXNmlWVmtx?=
 =?utf-8?B?NkUyTkY1dk5QQm1XdytEdEZBZVhUMXhFeExPbTJHaGRVb3BWUVRRaVQwZXRl?=
 =?utf-8?B?N2laZUdCcFJML0ZXL2haZ1RVdmpuQkU4TzJJTVNoWS9oanYzM3pXYWFzeU0y?=
 =?utf-8?B?MEduTXJaam1lT1I2R0lJUTVnNE8vWFFXRW1JWk5Fa2ZWRDNrZWJVdXpQZERl?=
 =?utf-8?B?NVVxSElXU2ZwSThxWXBsYmY5eGFPc2pkTlFUcWZaT2o5N3JoTnpFYkVHbThi?=
 =?utf-8?B?MDRDNnkwQ3pVZFczRjdaRjhLeDRYbTA3OW5tQ2ZmSktIMEhYdzVkcGZGRThJ?=
 =?utf-8?B?aWF6TVJDNHFsQ3lQd1g2azZ5clRNT0FTNThBOG1FMVprVGNxNFJmVDBvZFVj?=
 =?utf-8?B?RlFINnlwVE4zd0U0d01KRlAzNzRhdmhTRHBFdWJFUUhpdUV2WitMekNDVTBt?=
 =?utf-8?B?NFJNcVBkNmcyeXI5UmNHYVEwVjg3T003eDVXU2prK0hVZ0x4bzBqRFZkMXhU?=
 =?utf-8?B?Q3lEeFJEV0F0RDRuemVDVkVUdDF5Q3JZQW9DbWRJZ3NYVThQYm03SHRaeUZY?=
 =?utf-8?B?MWI0ZzRNa096NDlUZlR4NUV3cU5yZ252N21WU3VCOG9BNkFWc0h3WExKYmZh?=
 =?utf-8?B?S0l3QkVZeGdSSjdlNjZ5VHVtaCtnc05XaGVFamhOMWVYK0p2RDBwSndLQTFB?=
 =?utf-8?B?STgwN3pPdkhwbTBPRGJuUko5ZkhwRU4xWjRIYmlxVUhyK082dkkxRzJyMVNK?=
 =?utf-8?B?dlBrQlUwWDhwWWNZUHkyd215Vm1vMkZGU1IwSmEyT0g3dkNsamNMcmEwM0RD?=
 =?utf-8?B?K1J1L3pPN0d5U3NLa1J3Q1NqZ0tNbWVUTEg1NS8ydEd1S0tSYjllT281ZmRo?=
 =?utf-8?Q?asjHtO4WiehFHSpCoWr3sHU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hIzQDsbEMLj9mtZfKRjPND+94YkdtMPVXztB9PCYzPEXVRPtnxdpmf1Lfm9nlIZsyHegWE7aXFdgyRfZCC7/DW9Kjz/a4cRMozPLlCIMOZWoq9wYEiYBxTIkejy5eoz4qoLhL90/IVjHIqDcf5qhpB4IMKBGz5xNmY+DAG28OQp0ANaY2c5tjS8kAh30FHkZ+UVL54As9K1VYamyl0Qxf0BfCGqBw4Sjt2WLwprjXPXvD7ONJYipZaPDcx6BdFGfDZG+/Pq0WqVlgx9WbTghi0rZTtW6FM2qcarW7rTu6TVUGRGecvNHogrgkPXWFo3wzzHKuFeL/S0gDO/WD6nTCGAxtWpooCg+0Q/bsTgWEJ01DoSuGzqCRA4McrPbi7SOWWqWYw3dAyzCqPEvftT5XDDgmc0Z0fqIS835u8ly2/ayxWmUsHBOHXPDxaffy5Rj+KPnBMbqsIxkrnqW97eE7k8O2mMbJXW/MXJQKQiFRiWFdzvjHxtMcnjLjYqlTmt6oO1K9S7C2Lxj/nq38cq2qheL8phoc39GQ/3meSRLm8SWg6IMe5FVfeXQx1eEuonVZSC5vps/qKpa6xSeAr4BFwiCE+k6clBeSqzyz09eF/Vjbox/L5N32/oSioJGT2E5LGbAmD7qmnFiHXZU1RLp+R97wFOx896g6zpyiWXHwKiQ6DPyWAeBRZS5TWZYQPZi3cM46H7G9LhVIcv/Nt1bqg7xLKL6hi4PezB7gjJHEd4pvEcsmLP7n9GKFhJKic578WvOnzgbKX1ZKoo/rAo7XVEBLgpHym9Yq5HnvjVEHEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be14676e-d1e2-4978-bac1-08db72f8748d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:12:43.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtuDEnbeIA5FFiP/x4KHDyQmf6OH2WFR19D4MnRh4qjhttyFWXGY6wANYHb+/uf46RrtLEhu4PERDR/Tn5hHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=814 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220067
X-Proofpoint-ORIG-GUID: ebUaR7fX0FomN3ZE4G_275C5L_1roFsM
X-Proofpoint-GUID: ebUaR7fX0FomN3ZE4G_275C5L_1roFsM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> You can do all the test case changes in one patch, the error messages
> are basically the same.

Yeah, will merge them into one patch.

Thanks, Anand
