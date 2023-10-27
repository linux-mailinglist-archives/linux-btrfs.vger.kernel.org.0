Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100BC7D9CAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJ0PMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0PMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 11:12:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E156C4;
        Fri, 27 Oct 2023 08:12:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUsHj003823;
        Fri, 27 Oct 2023 15:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+W9EEcHiION1lTVcWeO6p6Cf7C1kTOdNdVNM97ASmAc=;
 b=BZMkl4rGT8SkeLqL3MLQxESqkCnaxcUHPnYxZI9OgqZOCcon7B/OKqFcGkKXYETBq7Zm
 nISJE2y9XVcy32Za+S8Ny4+uw0NYT5sEDabEZvoRus35dcbkr47GphZE+Gfj+W3uPPUk
 xeLbIxR78TmHvb5RiqrbW1s3j6k24oAwwwFUez/yRSsOXIQXV3vCRSl058OumE0fUWQ7
 quvj9o5MyNPuyMQBrUa7msos/ZqnPYE5JSfvjDaaxJQN92ZkpDX8yYBHPn+wcdAw/oM9
 MP2v96ZrTsR3PiMJLFb08V15cwFzOC/JGQJRdZ/1if+oYIMSPZQeK9nVcIsx/eemuMak 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtb9tym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:12:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUtoi009213;
        Fri, 27 Oct 2023 15:12:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjvkef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:12:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcRrFJlOJr1msnorvwl9vmAIt+ottiESiQoOgTEUa1W5DmloLh81vMhFBFgEqI1nyLZ8iPgpG8/Hhm7cJJL1JcJ/bANhC2Ck7bsH6KLKhAbcpKsal/m8vZa7mUZ+47NTxjcVgIqKOFAWua5cbZIstDl4WTZStpHycOy74GTivCgUHejg2QScYibLLKFE2jqywN5utoeXeeBGa69oqUcsYEqB6zuovbd5JXGOlAA0HOERbT2xf1+3R7YdQNFIz5LGZNt6f+itSQ4++5uKGIFtS7voBI9FqJ/XDpNoRSlDwfCKwzb5SOXxz8mb4w1YJlIE6XXJF/IwiOsBG7uXd+uOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W9EEcHiION1lTVcWeO6p6Cf7C1kTOdNdVNM97ASmAc=;
 b=jQBx/GaM9sQiQvJFXC12XsCW2SVi7Guf9Pqdsm5Vlx0SwebQlRyj4Y6lKuoiFTwxjdDJJdXRcDLItDjrW8HQtl20EcOMSEFDLFFoo2KNXrwgYW5Qoyd2eNWkTWslvSnDQhai7xNkuCP9cT/1AOcKyj4Bx056n1upB4FA7lVhA+0VuQM0XGbUYa+26YWi9PsTtmY9jZCSh3hqfv48U93ym6VDK0hCMhbNWxZYqN3Xzr42J/4v5F7O5LJBipVbhFZCHVOzqP/yFAr6EiRfc3QWa4K8rZKjcsfj0Kt2YaKd3dM0YFIYL0/Yc8IyHLHlqT7bkXI+uGTCqhQcEENV1+2p2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W9EEcHiION1lTVcWeO6p6Cf7C1kTOdNdVNM97ASmAc=;
 b=wLsgSdoDL1Nuk7tLiu+sLv1eKSpt1fW4mVrvw3bFSXsRhQTbxQugvgziAOqJIbUoPeOWhLvoP7ZyJkURYMQ6a/nYFkmiHAzvZnKH4O2X3uZ/tkifg4Q2tGFGqAeMfMVVPWlscbdu0PLJ4W+PJE8aOJuoBLef3SVgZOL8wCXYEzE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5780.namprd10.prod.outlook.com (2603:10b6:510:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 15:12:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 15:12:13 +0000
Message-ID: <1de4f2f7-793b-5d43-11ad-7da4e35cd1e7@oracle.com>
Date:   Fri, 27 Oct 2023 23:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] fstests: btrfs/219 cloned-device mount capability update
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <39311089b30f9250ff7f7a0aabb70547616a4b3a.1698230869.git.anand.jain@oracle.com>
 <CAL3q7H6Yg6bv1pKjA6dVjgr45Z=-YkDzcr3RzaV284d8uLxAdg@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6Yg6bv1pKjA6dVjgr45Z=-YkDzcr3RzaV284d8uLxAdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: e46169a7-b638-4e51-608b-08dbd6ff190c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KW/ph6pqLTmp06U8IEC2BMxfBhx5jLTS8t2MPXcvzJrVP1QZypLtpWnEOqvBPVJ8R/BPGPg4S60frdwpzCW+1I3AinZ5yPNp5W2O3GHiTgnvRr6eAPTEKStX+xEhirQ3rwpth/mYyW3E2gY2p2CDy+TifB6WLa2V0LdIn26TpRJJPLKsR3h1wLlE4g0g4mjjRo3fI2q8j44Qcav98GcCqH+OHDGALIA25YViE22uqmf2uUXbBSTZ2iX3VoQFF3wYUfnb1GzU6NiA1tWKj36WmI/wMYgY9/MI63qCArJIHlXvf6zXMecW/Zl3B44Yr4o5KSxAYr/yZ5LupBN1RcbfcRhCqaXewpDzxJHnTzgmUehpcgTv9iwf05BaGZKty6lGxVleeyjn6kvLeufXPeb3m9veG/PJVlLIW+9a6zaAh5z9UE++U0pDAqk6eGRIHRFOoyHI+lKcSFJOQAARF3PfyylVhhpdtWOkAEsfpw5OzJ5UvAgHAew+2hV1uXmV7qVCut4Uz2smphtJfjtRF7xBOzeCEQESTcn6nb3lrPhf5HmOlovtmPhRemIubw8+nU8qq466lf2JSrmE1iWuQwWyCK8q+yRojH+knwhnr4GQx2IZ8cAKDZGeET04L+nSh/cTdIAnKE/2ah4YXSR7UxRtQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(44832011)(6506007)(478600001)(6666004)(66556008)(2616005)(66946007)(66476007)(6512007)(86362001)(31696002)(6486002)(26005)(8936002)(8676002)(38100700002)(4326008)(6916009)(316002)(5660300002)(36756003)(41300700001)(2906002)(31686004)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRERmxaNDduTEx4ZEo4Q25VQkMrQmVRWWdwdmJ2T1UzU3BKQVhGbHZLRDdw?=
 =?utf-8?B?Uy9LSE9QWlhvL3oxbEJPWnByZlAwWkxlY2hqY0tYNDZyT0wwNkhlSDFMWko0?=
 =?utf-8?B?cDcxUldSQTZmWmtsNytBNkhKRE0wZlZSTjZ3ODFpOGhMY1dLN3l4Z2k2UDJZ?=
 =?utf-8?B?V24xblZiVHZmRXNKS2lKTGFDcllZQW5pa003anRqcFBKalVFU05vSnFmR3lV?=
 =?utf-8?B?bVJETXVYREQrOWhDN0J1c1h3V1RKMHRqUDJycUkrV1Z6YWwzZ0svWGI4eDEx?=
 =?utf-8?B?eVZ4UThsREh6aUtIMUY2azMxTkl0Vkx3OWV5RlRrYXJnN3ROc2cxWmowb05T?=
 =?utf-8?B?NUlUWmN2QnpKWFZESHZvc2lUTnlkaFRZZ2UyMmxXWGhUMmQyeWFXNWtPeXhz?=
 =?utf-8?B?OEFiM1ZJeU1OMWVrMEtreWtINmNldmt4Zmpvb29JV3ZieUVwTnZxNm45SGpB?=
 =?utf-8?B?Z1BXOUdVNnJaaHBRbHp5VXRFN1FIY0d5U3hlUnRMTHpST0lSNnMwdUtQMTRi?=
 =?utf-8?B?VVlvTkhMS2N5RTlTMGNwODJmV1Mxa3JtNWgxUllLVnArK1BQYjU0b056R2tY?=
 =?utf-8?B?cVgrRVRMM01JYWlUWCtaYnBSS1BNL01oWHZvREVmZ1RaM3Q5ZVBvajl0UHdN?=
 =?utf-8?B?b3plbXFJUkRZaVpqWVYwOXJNbnJ2TU9wMVprM2ZuK3lIZXVYYy96eE9NVlZh?=
 =?utf-8?B?dndZUjE5OUF3SmNHTWVXdHZBUS9Hc0tiMUlTMDhlZGNuV3lBeVd3c1NtRnVa?=
 =?utf-8?B?UE95NDZTNzBYakVkaVlCbHg5S2l2bXRLQk9WZmNSQU5pOE8vNzh4MzVYeldn?=
 =?utf-8?B?OWR6THVIWlpjTU9XcCtGOXVlM3MvdHZ2aXBiNlFsQUFyN2tVTmw5WWQ4ZnM5?=
 =?utf-8?B?SFBXL0NmMENkakRLb3d1RmR3SnpBOFJvY1FEbGgwa3lreVNCSzh3N3cyeXlu?=
 =?utf-8?B?MHlEVWxzMEdIWmZXV1g4U3VxYnd0dmVGTkNRQTAwQndyT0o2RFZ5MVZZd1gr?=
 =?utf-8?B?cWFoYUhxSnBaMXBWa1VOaVVTQmRuK2RMZlVKM1JHTXVFWmdMNy9pTDVsWXZE?=
 =?utf-8?B?a1dFak13NXNtd0MyQzRHUkJQbnRUT1JFMm9QZHdlaDFQVUtkTGVORFZ2anln?=
 =?utf-8?B?S0lkcXc0blhjNkgzMUJqVDhTMWVSZkJOcHg0NlFYWEVzbDAwMzhrZ2hBVHVj?=
 =?utf-8?B?SzNubTlJTTU5cW5YbWdxZ3FHWXJKVzBYZnU2dVloTWpiN2d0RkR6aDZSNkl6?=
 =?utf-8?B?WFkrN1JIb1hHbG16SHNtRERaaHVDV045M0s2VW4vS1lncjNSZHJQRG9EZzFH?=
 =?utf-8?B?V3I5eXRJV3hJRWpBRkJMazhrMjlVNXRkem1ZYnV0WWljM29ML2trc0tKTXU0?=
 =?utf-8?B?aHRUSlEyMEhCVzlYN2E0amJLbDljRmMrOXh0ZWhRcCtxZERsN2tPby9JY2Yx?=
 =?utf-8?B?VFhGcGgrbjEvZEdCbG1aM0dZeFhjTGQ0dkZJdHlpZWZBSXVDTGtqR085WExV?=
 =?utf-8?B?T3hucUdtVm9vOHhoTnpXRXZHYndEYUZJNElWNEliVmJVaytYLzlMQ0lVWGI4?=
 =?utf-8?B?UEFSUFo5S2dyaFZEYkVNbm9lOVdMdCthUTFDc2FKT1lnUDZUbEkrSU9tQkxL?=
 =?utf-8?B?WDlobThzR0xWL1NpK2ZCVno4UUI3bzlOMFU0VkhiOEFFZFBaNEJEendCd3Y1?=
 =?utf-8?B?Q3pBWlZ5dVdJOHFJWWFMdGllenB3dmk3bWpwVklNdkVaT3hHMEExWm81Rjg1?=
 =?utf-8?B?Y3FsOVFjR0tpZkExbEtxVGxkME96TDJueDlXdkc3eEdORmxueE5HK21Ucnd3?=
 =?utf-8?B?dlcraEhJUzkzRlNqZWZrMTF2RTZESjhWMHBDTUlkVlU5WU9ZRTB1YkMyZWow?=
 =?utf-8?B?bG5jZUpPZEs1M2x5SDBpOVExSVErMGlzbTY3cFd1eFNoc2JnS0xKdlMyeG00?=
 =?utf-8?B?a3kvTHJ5dXhQNVVHVyt0N1RWOUIxNmRUd3crTHNzUVNQamxScXRaYW90YkZ0?=
 =?utf-8?B?Z2k0S1NqMGJXZ0dIWjJwbXEvSE9kcHc5cHZFUU9qTFk0dURlL0ZrTTBYemND?=
 =?utf-8?B?QUd2a2lrd3RZTTI3dTRrUFB6c1dxQTM0OGRGUlp2eGplREl4YVhWZGNUVjc0?=
 =?utf-8?Q?qXnf7YOMeXibRgZfwhijtqDX0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rKXiVQkPQzQ4J1wFfua2SLYKghACTGv5x7SKIbZdgPtD0jWMnTLWx1FeQXfrZGskio2uyShxNBmSwQXU64Fp/QTb5T7y/zfRjvjdbvOx9q2ZgMjzyzRgY+/jPY7NqC3EkOV1ZDpvyJzqowq5YzBCNh2tpqPmrJxoS6m7VkgvyoFJLIcQeEhF2UKILrMZYArx22bIxUdvf6gkScfaU+tdf+cDnt9y9obtQV5VXzc1qQIV1+ontViXCAiVSE+sFwE6+pmTEZTxCLuQZuBr6DM0TWQDcyHUzYOrROw4grt16puw4k9MwaCUbfEgD9yN+bRjk0KTKIvQihDETLT+k1GVLEJBTq5w0ASmH7y+5EYHEJuvKk9u2NUC2ARLvoNuUN/Riml/r/vZTqhh4T6gIP7rYUvJYyuJGXJFdw90xeag+FPE/aGX7WkSuU0kpkOsMz85+1KEe9QRSos8HR9Zf7tP/QxDII/PalwKTOmjPjC838r9y541wDBpMcu/3tlUwK4wPFugQjPyzBZ25nRZkQp1RuJAiot7rPHUDHJOPODCCGgXXhyqgVo/oM3KZaxjp/z6pSIcQ32fUgAIIlTC7tV1zOP8lOjrsFFxQF8pUYGtVUqV/J3SIb9gSAZrnF+QddUcGdoAjug+PeuG7qgXPBSYthBpBsCxHc0GYxKrxIIIhUyeEAM71IkvzmSDOXp6Wt1pXBEzpxlG6e5nqy4MI9Ijc5j+7sQEjB8yxY8iWFE0fBnV114XaNnDEde1joOdMX2MRyJ6oGRgbWCNw8z/zbKrlOW2P1KY+u7e0j+fIJR0/fM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46169a7-b638-4e51-608b-08dbd6ff190c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:12:13.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4cQIqxWzjzBlgdkbtEVwhz5d9CerQ8+Dy5tEy0SrvzphTmyHb8rkuDdiijzkAhhPN731p54e0kN3D9B5N19Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270130
X-Proofpoint-ORIG-GUID: GP2eXAmZSPTDaKMxQ7Vq5yBSb7Qp10Tf
X-Proofpoint-GUID: GP2eXAmZSPTDaKMxQ7Vq5yBSb7Qp10Tf
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> For kernels without the cloned-device feature, it's useful to still
> test this... We want to catch regressions on stable releases and
> downstream (distros).
> Rather than removing this code, I would rather run the code only if
> the kernel does not support the feature (file
> /sys/fs/btrfs/features/temp_fsid does not exist).

Good idea. Added back in v2.

Thanks, Anand

