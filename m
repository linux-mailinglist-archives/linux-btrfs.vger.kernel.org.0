Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206E78C4DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjH2NHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjH2NGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 09:06:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C94CCF
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 06:06:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCChLQ002289;
        Tue, 29 Aug 2023 13:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=suLTs4TEpS4rneOhS/F5VItJ5bmKtyvI7LjwQhUatopkYYqo1tBn/b7AgkCOM4al0O51
 q91KtVWg8pXvFCRTezohe5AJrTL3NJPt7PrPaGZ0qpk3+pM5k9xWfZsZoSm3q3sItopj
 FGIfxdVvcTQqGG0xFHm3MK/DeVSy+8w7XyV9hEEcPHhjXc/aU6zUDuyAP4L2mIEr3YZM
 vnrFRxvjPLKlpIYyjOPsDAHGItCWJklc37hrLxwxdBvdpqkQtJCTrtDDYj9aOeDQo6iD
 lMeVAHoElUqm3IFJTHAkefowS6jTlmsEF4ufhNH0bmcIA7vXhXwct6st0GGhffyj48ND kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcmw44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 13:06:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TBAARF020114;
        Tue, 29 Aug 2023 13:06:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dn22ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 13:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+glJRbJSO2jCvoO4aVT9ovPTo2FKioWxWKwkWN23523vlGyu2it+9Tqytau4hPxhDXBHC9SCSSmHyrwE5u4Qq+7/KkEBngfSkDfABebGuV9XuQSDqjI+Bi1Vq7V+feJ89/4L8q0AusfdIJaIiXncp+mF6hAPbqpXQmGTmWQ9fR66wxpXMSFkrm5E0FVm8N7PbCDVaPlEhzBSFb6Cxq1Rg3ZSd8PvKLyf/wkcUf8VntC70ofSdjIoyzVVg5mA4Qg6cbBE5YDhigVL9DQRkosoU6E7qrlSui1b5IbrTY8js+SFeW5PFRKqwltAOD/NIlTObxPp37fScrRZQKvmGF9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Tew3wfVA8XoFD+9Snt8dx2v30fQlN07+jf+rzzLEykiU3jGLPoncWzWGMh/i1LpI0WMnKEXYPvIec0aviJCQLomIqtjlG+H/aTPmKCas2L5c70YL9+e7Lw5UtuboDEwvt4KCi0HrEjqNsbxfqUChuIWZUqIkEMbFKuPvZNT6dca0ilHCjsDdUz7utdDWs14CsscdQj2qJ6gCKaGRROaMtHSbcEOGfcsuM8dgNeLg26DjSeUp+v17XupOyPemDTC71FCcQ2NUz8gL/EVjyjuBUz28FB0P1Zifw/EvFS7HOPYfVNx6j6KD7z+63UNoxQwN0arSO47BFHWTX/ujMjx2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=bA+YaKvyQdf7jgXekOvXVd4fSdGNFbvdcLRscFT6htLXPIdYDCrzgosR9nfoPz1YOq2kJ454g3eQu0uuhkLVIe0IVputuKowS7EWGxAzqp1lWTUmN+08F/8TLbypv4n648pCzd7wx6ii8cj2jSgZQ8jGu0flxaeo9uUriDsOWsE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:06:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 13:06:23 +0000
Message-ID: <c31dad15-06ef-24f6-cf99-9c0952791a89@oracle.com>
Date:   Tue, 29 Aug 2023 20:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: add a free_root_extent_buffers helper
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9dde35bf7b2817ae22d60510ec8f4fc6e0614221.1692969459.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 21de6106-41ee-4eae-8087-08dba890be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkrFpShneTLDpqiHI2DZevO6qTV0ca4DHYGg3uaY1t4F8ZC9TdL3wPoWk8HDcCTbgZZRZrHhQ/dA2cQRQ45fU7dNX9O1tQ2ir1dE0rBjXXfa5kdWdsLfZIlURCWryXRo1fwdlBVgguAOrx9sAvwuWrKOpaF1fj11aqo0TMxyzJjcAO84w7puWPcrjInbjdgokPQHN79mabaO19v1yOvB5qoIj1jCuBKOH2oIBTgOLd1DVSwtGxPTKXpwn4qtTvLYl0D88tdH1FyhDT3b6HIuJRUa9/oZbat3UfXGzGc2h5S6mVQAaC0kKeSRzKrhaMZE5C6Vx7VUtUFCMoTA+3ROJKralJ0qHRCAB9zgzzPtHnRGoE7a5DoUGQp/HjnpkHEpl3G2uZKEM+lFEr0yOD7I0Uvm+15xzKJcBJp0LlFF1zXzqzEmVuGG9fS07Zr0IETMa62DBYlLLuc5mzaHcgpPrJy42XF2FAOxkbdhLmHFJu85U7Byuwp/+3tkoUc6W8pdM/WKMuC/uutNmOemceY6ROWIcbt3qipJ2LCGaIvKvvUKt2ewZ0tXK5AX8+Nqcsm55gJpTVuP9Q6VXfv6h2qCgFJqqoUs1OUvifBiL+5KWIsxiU5ZnOUEJOcY3Z1w4D5R/nHQX0+iittcMo1MdbCR3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(8936002)(6666004)(66946007)(31686004)(478600001)(6506007)(66476007)(66556008)(6486002)(316002)(38100700002)(41300700001)(6512007)(19618925003)(36756003)(26005)(8676002)(44832011)(5660300002)(31696002)(558084003)(2906002)(86362001)(2616005)(4270600006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LysxY09VZXlZOGQvUjdOb01IM20rZWEwbU9kWGR0NjMxRUtHQktxUm03TVcr?=
 =?utf-8?B?b2dsdWg5c1puRkc3ekZYNHFtU0N0RzRUbjNoREk3MmwycmpFckgzUjFSR0dJ?=
 =?utf-8?B?Ujk1ZU91ZEphY3ZTWlMxYWtEWWNORkl2dUFPNFY5c2VFQzBjaVIreG11bjhQ?=
 =?utf-8?B?SlR4Qnh5ZzRrdWRUWUJLcWt4amZmVTdnTzFGeUFHU1ViUi9VSTBCaXExMnJ0?=
 =?utf-8?B?REFKR0Jnb0lXWU9Jb2x0UmxGTko1d0tFMmdIYVUxMUZ3QWNnSkdiUkEvVi9J?=
 =?utf-8?B?WExZYUlJaU9kYTZGWHZ4cFNsSUVXSHlOczVxRTk5bnZxQzA1VkwxaGMrd252?=
 =?utf-8?B?VGhPZ1VsTFZPMVQ3Y2MwZDV1emthQTc3ZjZ6QjVVZEpNNncwNWlCSzRseGJH?=
 =?utf-8?B?aWEyZWUrSms2RW5JMGlQc1E1NmdlWkVLSUFZTzlKZFlPSy9XTFk0LzVjUHly?=
 =?utf-8?B?Q0RxZnM5QVJVZDdSVGtXTWFOWEhLMVdaenZoZFMxOFBEWXdmUW5KMXQ0WUhC?=
 =?utf-8?B?LzR1c3JYQTRhc0R3Nk9hcVBMUkR4dUtSK3VQN1ZnMzZzeVUzTkh6UVF3VWM3?=
 =?utf-8?B?VFRkdjZiaFJ2MnJwYXo5cEsrc3NKdFNRY0N6eE9Hck5FTzJDcHRoUzAvcUVk?=
 =?utf-8?B?Q1pEeSs0SnBuQzNjNzdlNndHL0xYc0xNdVdtWU9PUWNMakRsVXBMYlJIYWtZ?=
 =?utf-8?B?VWk4dWo2cWhqNHZ4MU1ObWIyTXBFNHdzcDFHc0dmaVdnUm5DRTZyQmM4L1lU?=
 =?utf-8?B?d0RSeDV0WW12KzZHUGw4TjZyQVpLMUt3RFFYWE8rL3RrbXR1dnR5MVREWUN4?=
 =?utf-8?B?Y21OUGtpczF5YmpyOVROVFFNMWlEMlkxdTUxSmFJMkpDOUx3S1NiS1p5RE04?=
 =?utf-8?B?dk40TkYrYnpQQXdDaDI3aXVzaitwcDMzR2xja1B2OHM0Sm1qcm56cVlyZFdO?=
 =?utf-8?B?TFBDMW9zZExhS3FFN21JUWdyQW9TUUoyRjVrUXBaNWhibUdjQm5ISytJSVp4?=
 =?utf-8?B?VUxZV3VTWUcrUks0YXh5QnpyWmRueFl5VGNyM0lEMmZXcmhPT2xaN0xheTZv?=
 =?utf-8?B?WHhMbU5kaE93TTcrK2ZVV0hZa3J4ODUvVHZQaU1OTXFrNkwvNXFDcGt1K0lM?=
 =?utf-8?B?TURXcHZUZFRZSnhVcnc5TU5WbDYxWEFLL0lvazYxWGNGeWEyYXkyQmIzNEpD?=
 =?utf-8?B?ZWZxclcvTVFEeW1GNTZ0NXVsMFh5L1NTQ3NweGdBcFptL2RYTUFISGF6WHJv?=
 =?utf-8?B?VWhHM2ZMZzhvRUtVcnpteFJDaHdVTGl1NlFwNFEwSUlFRGZjU2pwTXVMOHlF?=
 =?utf-8?B?VUJWMEdmUU5lMVZ6NU5HVTFuMDEzcTRSVFprWXZET3RURnhvOE5sc21rbFln?=
 =?utf-8?B?dGRiQ05CelJFVCt2VDJ1c1lRM04vOTNPZERQOFFRRll4ZkNieUZXeUZPRTVj?=
 =?utf-8?B?RGNvNEwvU3lrSW1qMnB3Q2doMnJXSEV5TGFBUnA5WFVOMUxZeXN2cW1VTVVT?=
 =?utf-8?B?MCtPNFg2aC9rMWdGenFpR3prKys4SmFkdmJpR3cwT0htMm9ERTk2Q0xxL2My?=
 =?utf-8?B?dG1DbXU2OGppN3VOdDJCSTZqZXBPaGZqNkNneEt1Zm01UEcydk55M3ZRZGQ2?=
 =?utf-8?B?ZHhVbWt3dFl2V2daVzFWaDVPMC9zU1d3bytNd2NDZ2ZIRitPelVtd1pGSFRl?=
 =?utf-8?B?TjlOT3hYZGNOVGpwVUNYNTNKcHY5eHJObEVGUGw0RnRhNmVLS2s4QVZtbkVl?=
 =?utf-8?B?UUR4ZXBnQmlPWm5TTjYxc3Jid3ZIb0M2UTB1QzVHYzBDRStkMzl6dmhpcFdH?=
 =?utf-8?B?V2Z4Nk1oWGxvYjd6MXhaT2VMN3l2V1pERXBpTXoyMHh0ZGthL1RvMlZQdnRJ?=
 =?utf-8?B?d2I2MUNhbXFyc28zUTZnOWg5S2RhUHZhODUvaUhZamx0S1BuUGVLQ0hJWjVM?=
 =?utf-8?B?Q2lNUmlnTGc2djkzUjl5Y3BhWml4dXNJcjcyU1N5eGszZ0o3WE5PMjAzUnJL?=
 =?utf-8?B?bTNrbjVVY3JVN0hpb2dVazlYc1pLemUvYmVjdzNsWm5abUM0cktkMEpjRzJ3?=
 =?utf-8?B?R3k3L3oySjZmMWtIYkJLMWJOT2VMQzhtcitsNitja0JEVklDNDcwNGZ0Y3ov?=
 =?utf-8?B?OXZuSXFMNzduK2dEYmVoOXJYMDd4QVBocm1GTXEyMUlLVEhadVpIWG8waFRu?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qUGSa/tOFiAZLoyKRzHPeiZZZ9NGdPxMu7aNUKo07wlo1UVuab3JoojxzHKpvcMdcWGly2nz/CkEdTBcNw2lFhyfBr5fRxGwOBIxPWtwlDsCIk+CO5aSSKcVtgY/Gb612Zc3407VTWOdqlElg1OT3YI80FzMafBMH37BF1lThiCWyHLbSsp4jMsEHKbMllVMIAIDNGhGfMQ9eXgikhVOVQ3gaZ+Y8ywX1xPt5xIeSwzDUqv1veWwRMFa9ofQow0ebfMSskC0djTHY0+bDavm74Hu0KqXXUDhb5ild6awW99846VXvgmIthb9bsh5tCm220EXIT2fAFnKNLEhFLrovXApLRHCU8S/W35lD6GMTz2YRYPQ+AFE6RrALiZPmnYmONU0IOQfYsum5cfBj3NiZUZ67KIl8IVS+pyHwgHRc3CvNXm//QHnoRfWlZ1aJOcGaWN4HqNgxIcRh449zabrJ8xdlCkarqgWbXltd2n9kKzt9Jd2pJy6i6rQF9/bPK6Dazz+S0sL17zr/XjtL4R/bXKDXTqghfbtuexzUO5XMUIPpjpvyQk3pfaVc02DwdxcAhKRi1kKWB3FHiAoCadu/tv1RlWyfYleT03Om9y4fOB3FEYsNoiQsW6nYsbKUh6r509M+1Pp+UNw3Xh+PF9YdyyC30tmUNdIkC1Mudbd71nNrDnX1E6rv0WPtySRdl3NqwxnITpLC/D6oFW160WGSGEcwYlTQ/s0k8Zer+mw/anib5ebSYSlJ5EFTTJnYubNtgShgW6ECuyekQHX2bRo32W5WHxMP59eKvDHZhzeA869JZYhayUR+/6R2qnOHPMB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21de6106-41ee-4eae-8087-08dba890be65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:06:23.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7pGXzkrSd36QKegV0TY4KPFnoNuGrOeQ7Id80k2AAg1N3H8OYHfpfPhy8M25MNJnhlj+Nc4oWc+GOBVQTrMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290113
X-Proofpoint-ORIG-GUID: N3UZ-xaaDi4-_O8xVSZa4bM8uyGaz_NO
X-Proofpoint-GUID: N3UZ-xaaDi4-_O8xVSZa4bM8uyGaz_NO
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

