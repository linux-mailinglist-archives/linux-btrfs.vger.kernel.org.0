Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6FE7BC5EE
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbjJGICa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbjJGIC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 04:02:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE9CA
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Oct 2023 01:02:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39745b0t027230;
        Sat, 7 Oct 2023 08:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qilKGYUIQWYg+6M03r31XSjT0lVtZD0HW5VqnxuJpxE=;
 b=hW4vI7eIzgZp/oJ5SY0SEp4h6wy/BxM9tsz1yhXyaHOVrOS2kX6I2ABcQ1PVkV2KTIbd
 8bsqYypYe5yeoHE+y6hPtr52E8gnn7qF+eDTqRiLJ3r/ioRb0YxLHK+v30C74zXYLL7o
 8gfGMY5aoX4uUTyZcWZ4f63MFCu2BgYNLzmZOLYmAVqNoURJMZUuH1g2719i1bL/zEMf
 odO8LhjRc0Y2mhyqk6IBzEehlwJq9n3iEjjPQSWNj3QdGZLtUnLFrD1zFq/VpJ1N7MCR
 X/X2QeTN2Yk5rLErtLhaiIHJ1wuWkp9WucPD31YNw0WuGBpmabxBb7BS4lJxgvfWFsUC zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx209sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 08:02:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3976KVFI014929;
        Sat, 7 Oct 2023 08:02:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws30c0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 08:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBUNTk6gzBnSWnxyk5kdGXZNv3MRIwFuYH5N+fVrHUdWXrdVKdpGSzEutKWeIgcl76ofyFbG5F1bFT8nVT3NYFhiFPXkuz4MYqobWdu2bv2YE+mn/PE3JQSYtidsrn9byMMZa7EmpgBJ1UsPEowBpmqqVWp+AD9FPEsVezq/Dc4wRinzN5JK61XwR+/vZT+uVend09XP9GFLsHJusrnabwSNaX81ONEwOPxs4Bjg5GcowJkq5pSv/2L4pXAGMrhStTB2KXLXjUfW+XP32zYOD+lLAphZzAM3dYkt5HCl0L3hNEtF7FGmoLon6bnMeNuyoEgh6zKG1g0Atx3A02GdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qilKGYUIQWYg+6M03r31XSjT0lVtZD0HW5VqnxuJpxE=;
 b=GLxsc4WU9RwpAmYIfwFNvlg+CXhne/yMgSTH3Gp+pfSWg+YKU1sfIG1XbbXSxDSNVJ9jB7+tqaf4l+kYSWuJVOUVVhf64rjYm2UADuQ8tEuQFlyGvukwePWsbzh+QYbEBTn6eGYS7HYW2YjVe2W3Dvc3oL5MOfbUuBRI6v+qRdcAIoylbt30h6hyqskyGxd5lmnxJvsmfBPZsNxYi6je5IiMraSbnnMaPBqP6Vx8clPSye0eiQGRQpXF27k1MH0QdM/BPCrosr1t2VKxfNoWM6yRAEsxUPs5RJRz4Y296tih3ECiyX2vuNbxBcZKrd2i/HRhafyCB1yje4GF5MTYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qilKGYUIQWYg+6M03r31XSjT0lVtZD0HW5VqnxuJpxE=;
 b=q5z0cKUmIp3aUVq1FTpfvCx1s0PxzmOQP86m10ylTqyyKz5n/g2US6tv8tQ8jgu2eXDevn8H5uVA/czZFLrBF+lv61DhSa7ODaqBCDHeMVC2Kse8scmzWDJh/N6ArUGj0M9vIHwk9+IZ2SEFybgwuRANavdKU5p9+2mvCjW9LtQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4751.namprd10.prod.outlook.com (2603:10b6:a03:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Sat, 7 Oct
 2023 08:02:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 08:02:09 +0000
Message-ID: <dfc68882-ac04-4b11-9ac6-505341e0517c@oracle.com>
Date:   Sat, 7 Oct 2023 13:31:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: support cloned-device mount capability
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695826320.git.anand.jain@oracle.com>
 <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <55f1b487-af24-8f67-8e72-37d493c5025c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e4b11a-f2b1-4e42-e3cc-08dbc70bb4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4ciZrnwkbizfc7AbpJNE3TpXbl3vsB0m1rm+u9IGfgdrrVTDDjvsMbTBi4PEMvjUr0QrfHrycR2fhxhYB8XOuA2TEld3ysZudOTb8m17q66MDbDaXz22vomcLBYkmtWgWX7fbnLCInlavlD68POnqRzGxst1Up0T9FidLsR2gZMubCF4VF+IOoWjr+69yLg0tRvSfJx5HjYbI5FGzUDfK4gB7vu6hS9vX9IoWQXgOtrUWeyuTOlzyxVqtgMudnG3lS6SrjPB3z2vRl3z1HOGugST7ggHtZSx0Lwzs0J89A9N8DrFWcp5vOiQH0qemsG0lns9spexl0fvaBuwr2pKPQ+4kSi3dE69UfSeOTtXDwJC9yhp2sbaILe1n3SfKaZ9u5R5NXNdm9VEpALAG07N/mu3/YUwLAahn4gtd21ecerWuA3QGmopHLbEmBMk1a6/sUep8yNvmudEZwZ4oaB7Ey4hgyRWOQXxBnUM6dFrdAtVG6feeaoDbEoby4hZU4RbcFFz/PuPk++ETm1UcoWzON99O0L736GR7uSr953udXEfo7HZIs9tgS6gZ1Q70Ev9Tu1K2Q4pizhi9xCG3ZvyTGqdZf1NzHKSKItEk1nhdgPzX33H8yMAhKab1MDsR5lr2TgU1aQqiI7nycW+Vex1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6666004)(6506007)(6486002)(478600001)(53546011)(6512007)(38100700002)(86362001)(31696002)(316002)(83380400001)(2906002)(41300700001)(2616005)(66946007)(36756003)(66556008)(5660300002)(66476007)(110136005)(4326008)(8676002)(44832011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1rK3lHKzY3WTFBdkNRMDdESDQ0bWtaZm5DdWJpNUMwZDV4ekQ0Z0JBVGVv?=
 =?utf-8?B?NFRrblVCbUlmaktiMFZpQnBJUkMwMVdWTXFZL3gwWjlrRFltcUw4Njh0aDBl?=
 =?utf-8?B?L0JCSTZVOXByNTRWV3lQWTh3WnV4Z0ZnQzVUNkVBSXBzSDZVc1ludVE2Mmdr?=
 =?utf-8?B?YlBSOGhVZmVvdzNmOFh4a3R3UC9ZcGo3Nm5CVXRYdGZaeTJlMEp6cy82LytM?=
 =?utf-8?B?dFJhTG9RWnZqZndaYldHb2FoY1R3TUpIem1Ma24reElUT3Zzd0JOb09laDk5?=
 =?utf-8?B?WXdxeGs3dFUrV1VjbjZwL1ZCbDMyWktwKzV1RGRKRTRGUmdmUHpsSk1PSitk?=
 =?utf-8?B?Q2Y0K3F0SFRRQ2JPdHpLVTFucWRzK29kVU1jSUxycDBqcXFoMUl4LzhIT0ZZ?=
 =?utf-8?B?TTY4K2wwYmk4UHNhbXZBR2dhMGp3dWlPWisrUU02L25VdkorenJOZk5vbnZ4?=
 =?utf-8?B?OUkyN1czUjFSTGVPQStBakdDb1pPWXhHS3NSUDJWdG1wUGlBM2JuOTJLRHMz?=
 =?utf-8?B?ZFlET1QwdXJ5cW54UVhXeXZ5VURsaXlISTZaSmhpTGJaR0grbmFibUpVdXRw?=
 =?utf-8?B?R2VNOC9xeGh6T3llZDZVZm1VTVhud2xuT3NFY1MwTTFjOTkvdkhyc2c4SC9G?=
 =?utf-8?B?Q01TcitiOExjVlp3R2p3V3U0YklHcjBhQUdjSjlEZTVGcWFuaE1FTmRkcGFz?=
 =?utf-8?B?NWlDUFlTU2R5SGhsUlNaZnBER3RBaXRaUXhRRTBIZVB0dGhwd0lGWDNCaW5o?=
 =?utf-8?B?elMzSXltZG1EdkF2dW16QnJNNlRQeER0cU56OUk1cGNaQk1yVzU4c2lwZ045?=
 =?utf-8?B?SHY0WFRZaytCTGlCaS9CZHh5QXpVcEU3eC9zS1J1SllPMHU4UUFmcEV4dVhG?=
 =?utf-8?B?bFoyRzVNcW1XSTEwdmpSQXZLMjBEZnhqSXFUdmFOSzlnbkZMR05GcjY2dk5S?=
 =?utf-8?B?R2djZGNkY3JPQnVOcDlHWk9hSG9jakZIc0ZPSmNrUEV3WmJqMkRwcDN2WStq?=
 =?utf-8?B?cGEyU0kzTzNiVDZLdzVYeFdvZ2tNQUVhY0UzOUtqNXJVcHIvTEVHeUdrYkpF?=
 =?utf-8?B?STVsSG96STBVOVZJSlRPV0luMGkzdFNmT21ZcXFZdG4zY2xkaU5Cbjg1MnZn?=
 =?utf-8?B?TGJ1citxaVQvNm1FOVRNMzNBTzZacVZ6YnVVcTlQTFc0WjVVRGppZGxoRkx2?=
 =?utf-8?B?UFJHWDVvUVBWNEo5WlgvVm1NVFRCNndHMkJSRXh5dlZNcE9aMmZ1MUVpaVBD?=
 =?utf-8?B?b09XY3Awd1ZKeWhNVmVWbDFZUnVVUEh6Rzc3a2wxNERaYjlxQ2hjMjJvQm8y?=
 =?utf-8?B?K1hua2xVeXNrV2ZaQUMyWnBsK1ptQkRiVHdBS1c4aWp3YWtHbG82dEVTUnlR?=
 =?utf-8?B?djltRUUwTS9kUU02UDZRTEV4V3RJZ2s4OGZrbk5nUVhLd0doTGd4SUVxS2Zn?=
 =?utf-8?B?S003Nk96a3pUMjlRaXZ4c3ExVUhSTng2VEZzQ3p3S3AvbHhVeU1pNm1nY3gx?=
 =?utf-8?B?V1VnQ1o5S1dWeXcrRlpRK3hnY2lra2xJSms3VkxneDFwMGRzMDNBNXdQM0lC?=
 =?utf-8?B?TndqS1RSVks0SmE3MGgxSkFJUnp3ZHBNSWszMmFVRFdJYjgrRVZMbHdBbjdS?=
 =?utf-8?B?bHBnRVdMTEZiZ0VCK0QrQWFEczh2cTNyRWhtTi9HWDNTUHA1cW9nVkp6QmlY?=
 =?utf-8?B?ZFFpTHZvT2o5aCs3dG4wOWJYRThZQy9QK1gxS1F1b29KeFIwOGdnaWVac3FP?=
 =?utf-8?B?cHBWTkd0WGJlbHlyc2RRbWhCYkRZdFpRSXBYWW5UTWdxR1VSMkxyaWlFQ0pG?=
 =?utf-8?B?dUVKdjFlYnVxY0piTXZUSlAvYVZ3TlVVdWlIR0d5T2ZzZXZPS0tpdHFacEx3?=
 =?utf-8?B?M3JyWHNhWDJlLy8rR3cwQ1NPM0hrWXBtTTRYcHVHZVRJRWgySGp5cEhyK3dW?=
 =?utf-8?B?OHJNUlc3Mm92L21CbUtuU2JOZlpHUUxOKy9VZTl5aWtacWNzK1c1RFovZCsy?=
 =?utf-8?B?YzNqU2loSW1PUEdEeXBLSGdFSXNoUGt3NWlYQkpQTGdsWHB6SzJ2THJHbHYx?=
 =?utf-8?B?MlY0RkFLKzhyWEdpd3JOcU9aMjkxTGc1dUpuYXpZeTBza3gvV2prd3RPODVv?=
 =?utf-8?B?c1pZbHVldXVaQjVvdVEwZnRoT3N3ZzZQMHh3bHRrWHVjd1hmVmFBQUJlSjd2?=
 =?utf-8?Q?t8jLHfTUSrLpnotcUWAp1tEs5lx+8Ykqa2mj2btMCaX+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UG7dGQnCITl1Db2sb4YO1RUZ0CFJlxKPiaNjuiyXa/0sBT2AM45DTX2vQeEW/BK74etg9ZY3X62bx/lxHzy5GGxRZ4bIkYf6hscfkdmPASc+KaTf9bpgRnv0WhAOiKRvRTPZDqe3VWy/SSnRSLD7J6xGgWQKrcePIKTAZxzimquw0h2y0erEG5UwxWH84WuAFKo7WV3cTSXHYQ5l1qNCav6TgWgVxyN9slFRhyTtRefFkWXgHy0HvHVynGsnhtkz5ssFDraADhn+lg7NB0Le1+kxhvjX698VtDVY5Qof5O26syPYKKEJfjClI18yIYygfhtM7jZBYRwz7xH1xoH1/HGt0ZRYpgLNkPI8KilE+Upfm6/AwkC9WxHcjMBNJnxfnLwaMVyiyMxBXHpw9r6y3D2qrJj24lheF1QLOhqO7bKerSrxvhmpsurZsncNrd31PGoZlyle8xVQZVWk6F99/ka2qrmyjRkw0Q+vkLqkMf9TaprAyw4iEG4ma2reZHKFLn8gzBzmjv0dcHmVu93ZqiTFPDF8KLNCDEnSdoLCjzIbKx39/8OclpOORwYpMMGb9MDXoufVK76yossExHirLxhMOc7krrbqtfoUXanJLjRVrElgUZpNVFHyM6WgKf1wd643BcC+557HAjAKeKy/PVjITmSAhUccU4p5N+Tl5jrLf/jczdlTRtPA2BKQzj2D0FCnZ6eklwiJ2f2ZtnIcMyy7ay9kHK+9vYS3wOTyoTX2gqmbKQjkrWjqZ287ghBXhzCE40ouG6x81gmHdz2XkeABPR44yM0C5jGdjOabDsa4tKU4SyKnkgZe5lEnpsEb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e4b11a-f2b1-4e42-e3cc-08dbc70bb4d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:02:09.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOBDhsFw1yigTtBD+jcfPXVMw2OYqbDt1UqDIq4Q4nRDjZErkAYHRSPVZ3qwl2xNQ6suq2Jp+hVZLyD1zqPb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_05,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310070069
X-Proofpoint-GUID: gcVaSf9MFsU97ZDkNyLQQssFXZtdyqx7
X-Proofpoint-ORIG-GUID: gcVaSf9MFsU97ZDkNyLQQssFXZtdyqx7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/6/23 15:42, Guilherme G. Piccoli wrote:
> Hi Anand / David, I was out at a conference and some holidays, so missed
> this patch. Is this a replacement of the temp-fsid approach?
> 
> So, to clarify a bit the inner workings of this patch: we don't have the
> temp-fsid superblock flag anymore? 

While btrfs doesn't need this superblock flag internally, we may
consider adding it for improved usability with other Btrfs features.

> Also, we can mount multiple
> partitions holding the same filesystem at the same time, given the
> nature of the patch (that generates the random fsid based on devt as per
> my superficial understanding) - right?

Indeed, devt remains unique to the partition we've utilized for a
similar purpose prior to this patch. Are there any devices lacking
a distinct devt value?


> And we don't use the
> metadata_uuid field here anymore,

Btrfs has always assigned fs_devices::metadata_uuid to either fsid
or metadata_uuid.


> i.e., we kinda "lose" the original fsid?

How? Have you tested to confirm?


> If that approaches is considered better than mine and works fine for the
> Steam Deck use case, 
> I'm glad in having that! 

As you have a use case to verify, can you indeed confirm whether
it works?

> But I would like at least
> to understand why it was preferred over the temp-fsid one, and what are
> the differences we can expect (need a flag to mkfs or can use btrfstune
> for that, for example).

The in-memory disk-super hack in the original patch is essentially a
workaround. This led to the necessity of restricting devices using
metadata_uuid from being used as temp-fsid device. A more appropriate
approach is to enhance device_list_add() to intelligently manage
duplicate disk-super entries by checking devt and permitting them
to mount if unique. This solution deviates from the original patch
and simultaneously addresses the subvol-mount corruption issue
observed in the original implementation.

The additional adjustments [1], such as sysfs interface, the constraints
on device additions, and the limitations on seed devices, are
supplementary patches essential to the comprehensive solution.

   [1] [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for 
clones

However, the superblock temp-fsid flag isn't inherently necessary
within btrfs internals. Nevertheless, it can be considered for addition
if it makes the usability of other btrfs features with temp-fsid more 
seamless.

Thanks, Anand
