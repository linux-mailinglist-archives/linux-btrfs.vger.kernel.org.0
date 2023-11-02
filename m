Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C27DFD26
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 00:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377548AbjKBXCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377540AbjKBXCD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 19:02:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185B184;
        Thu,  2 Nov 2023 16:01:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JLMxW008057;
        Thu, 2 Nov 2023 23:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=d9BdVW3COvSnBIqb5maEmfBos/IpOKjoVtrdbdU9v/U=;
 b=Qwxg8zX6RVOebZRnEbKl6AwmQVDb1/CGob/fcrdZ+7CFnxenkpKvo2/STDWNr80VPisV
 8RfjwJy+ERb123izBZARttmvGBzHLv8WYFzjcda9UTm69ru3x4FFHYTGbRUuWhFiYhXc
 7IpR5BWKLdxVPZJSVVkwiuqRJAbKz6XeTsBaDhvBeVVqQyd7aq9Kc/iAJpIBi4SGkK5x
 2kROVwIO6LfPA1vdhyhr5+aWvXSuqca2ufyecn/PEp6qpJp6HqxR+eWxiC+94W39C7nn
 xjlYwu2DjUiFMYGnv54qDB6RCAhKKG/eqMxXXGQp9sRIw51Axw2Vg5VtCxqU3qo+Hgx/ Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6basg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 23:01:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2MetWc020087;
        Thu, 2 Nov 2023 23:01:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrfhjy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 23:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyC6TohOOLHtL3x0RTash2apt+7OQMIn38rFFzZ9AYltEOXv5WzX8xmqrcCRTEJUwrmhMnUxJKMqk4WvOmFPPtGfZ48I5WWw7tM5aCOlVq0Jt/X9qdsMgVoPyTx9KIDpFYlEHvSF8EPJVIIXVc2CIRY39S8bqumsSLZKbyNGKHFyzg1lWmTxvXH1pKZe5TRZIhGbgP5Z8nx4yZmqj62ExbngAaVI1Vaxjyv4X99VuBKiTuE8xchoMcW5QJnArZCVXc7tRwYMX5u3ovJ6U2zDHKDQr8/I87gl2+5x4IK5szprpiUuv/HIHXmuQxoYH1G50xu5/B1p6ZXcvOdx+9UVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9BdVW3COvSnBIqb5maEmfBos/IpOKjoVtrdbdU9v/U=;
 b=KcMChwTZ3T9jLapoELPqDMJAC/KOqdLyk2mFdVe9RnkjvmaY9R+vBwc5d+4Y3KckiF15IhXxTOuVxB++QA373F91oMz0CZUPRfvu9X6ue7YX/SbBb+ysyNqosgYSiLI1r3Vi3etL+4cQH0jDKStaXs8dKMgCELnqOEvZybH/INxY0J/Ba+yZKT8FKlzhiOCO8JyIflLoUgzVyho4FFcLMFTalUt/81dmVGbRasY18jHyJzQ3iM02I9qMSi2/7P1StT9V0syJUbFkrznmiF+LAyGwtWs4fKLyHMMcnW2kXsAoZRqJCHgvAptS/SCDTDc3cE1iY7eJ6NYd0D73dVPlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9BdVW3COvSnBIqb5maEmfBos/IpOKjoVtrdbdU9v/U=;
 b=GKn02l9LIlEq70/4QbOvt7zTc0Iebsg76X/GL0YMfLJpmHqRT/21uaq+RhZN/FT9MaApmYaRFZz+UKMEdbz5nvzXd4mYirzaIBihbzjPGctj8GMvfSlr+kCKIl8bjjTVUPmJWur+7L1HbwwIzewCeCYePik3zA35Z8D3Hh6iHUc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6675.namprd10.prod.outlook.com (2603:10b6:510:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 23:01:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 23:01:42 +0000
Message-ID: <189e8ca6-450e-4908-9fec-b55cbf7d064d@oracle.com>
Date:   Fri, 3 Nov 2023 07:01:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] common/rc: _fs_sysfs_dname fetch fsid using btrfs
 tool
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     fstests@vger.kernel.org, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1698712764.git.anand.jain@oracle.com>
 <d63c4427d1dc9db3c18a07cb9098459de242fbd3.1698712764.git.anand.jain@oracle.com>
 <20231102200040.GH11264@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231102200040.GH11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1ed7fd-a824-4f6f-a7c2-08dbdbf7ae05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iy6SgkKkSkMI/OGzJMJnTZTKR6sB5fu95cJe2Z+GzRV0HS61O4WVuQIrJI5Q9Squ7rP/9vho57mf9Xs7c+d25mvSZWuDJL8Q4z1rU6+zj/RPVNRgAnVPlbU6+bXM3moJBW+qZDaOaARnacQ3phIEQzhLRWd0OQvRfWC2qfUCb7rmzhRqcWxVczW+EXwEIsDqcHP9SmeiufAOTiUcNxY67HZLGjWGAxgHRqe1PC4W2LZftSGN8Ju9uP1oP7Ruy5a/vr5FAD5xA28xPUVHK7Hp3wwy5jyLuvJA4RfUvlgBtYNtyfRZObf/+bnIe9BZ8IGJl1o36ZvJg+OoRMK/CeZaFyoZ02Un4AtCV9DFxEoGMtsFqJ/znoUlyNkRyxfuRbABkPCfx7XUVs6K0ZsC4keik2nhPND87Bcqy5FKZF/1fd3q69IOtldj1sccttb8Q19dxHMhKwhe4u+pMHTYlVBoAcgIWM+G+mGQfyKO+HuX6wdRZCoQXW06G2nbg5sOf3KQmwLK91Txd3L5s+JI9ApGKucRBk3YpLp3FixMa2L86b6ZpVC2qCJ57S5eWJUC8Xo954Txl6O0k/l8hu1Wc4ci6gq+HUeUaN/BVhhLn4mAeNbQQXYjg7QNCb9ANc/wG8euMSSG+ju6Fgl/BmfcV8jb3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(2906002)(31686004)(6486002)(8936002)(41300700001)(4326008)(44832011)(5660300002)(66556008)(6916009)(66476007)(66946007)(316002)(36756003)(86362001)(31696002)(478600001)(26005)(2616005)(6666004)(6506007)(6512007)(53546011)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlBV0JpaXVwMmxac25Rb2NMVFVYeUMxV1UrdGxlUDlkcFJxcVU2R1oxQU01?=
 =?utf-8?B?eTRVRkM1YTFkV2dLQzBJQWRFUDNFbTFpMk43LzJrVUw1b2dCZEFWeWJ0d29o?=
 =?utf-8?B?TjJmV3dnL0Fwd3BtUGdFYTdMMUVzZG9CaUdIcllBSXdESGpOL3ZjQ1dkQUNH?=
 =?utf-8?B?TWFMTVFCTHdEZXBHS292N3RUenMzZmIyS0d2QUQvVzdpUkxVZ2FScXB2ak1w?=
 =?utf-8?B?YjQ1MVBMTk9kbHhQVENRYm02SzkwRnhYZ2pjQk5mSTdPR1lZaFh3OGs1enNU?=
 =?utf-8?B?RGRwVFN0UkNVaXcrSEltQVM4bC9LOEsxOEtrNW5vTldXM1ltZkxaK2Ivczl3?=
 =?utf-8?B?TVFEV2NGU01TR0VqWXRFYlM2SGYwNTNzWlZuaWQxT0Y3MEpsLzQ4aXh4N3lm?=
 =?utf-8?B?MkUxYnowSVZqWVo3VC85K3FvejZHekZSb0VlSGhQek4wZ3dJZkFBRlROdDlL?=
 =?utf-8?B?ZDd3MUxWTnhWNHdLNjA4aXlMcnlqZHpoQXFXSXEwck1nMHdZZ0hzZVdnUTZ2?=
 =?utf-8?B?QWFZYkh6aUZKTTV6MXZsenowUVFiRXp1cXhhczU2NEN0VjYrZWlObFRLOFRD?=
 =?utf-8?B?Vkc3aW5NSitHTWt5cDNscFBMY0pGMThNNm5lYnIyMGpiZ29ZYXpXem9oNFFo?=
 =?utf-8?B?YWdKaG9pUHpnM0hYZDIwWjNDTGFGM1NZWFpUcW0yQTdDUHhiOXh1Zmp1MFQ0?=
 =?utf-8?B?QktzS3Ztb1VoOFpZQkdQR1RCM3J6eEIvUzFuOWFBMlBTT3dxK3E1R0h5UWZV?=
 =?utf-8?B?MWZjT3BRWTlMbEZkK0c2cUFCU1hZM0dnOVFmWVkvZnFNZGVoMnVoenF2N1c3?=
 =?utf-8?B?dEIwNUxBYmM4dXBoUFNrdUxVaERib2tJWFVZdGFnRThRZmxVWWlja1NCeFRG?=
 =?utf-8?B?cW53Mk1weXozMmF4N2lYdDA5SHdCNWtoZk5KNGRYTFBvcTVqSjNpcWxmKzdw?=
 =?utf-8?B?VHJZZks3eWt4QWJVWTk2S2l2MWJIelh5VXh3ZGxiWlh0K0hoNWJjeDg4N2pz?=
 =?utf-8?B?WWpzeHMxSG1IV1Z4STNDVGUvcFMwSDRLdUx0VlFyVDBKTERpbWdiVHM3UkxB?=
 =?utf-8?B?b3U2R1lmY2RQZU4vekQ1RllUbHFGZmlWWkp6eFVzNC9nVFV0RVVEUTdVcXR2?=
 =?utf-8?B?L2JZak1reElxNXdUc0ZlUkZPUGQrcWF0dGdFMzNYTXA5azRPWDBjUGp3Qm1C?=
 =?utf-8?B?SDIyeGlVVjZRdW9sa2dzZ0ViVWhHTCtsUGdlcGtCbFhaVHo0OTluTUNuL1Jp?=
 =?utf-8?B?MDg3Yk83ckhCQzZPQlU1R3M1Ty8rTC9pU0F1dDBiUzBnaThlREhvYVljS1dK?=
 =?utf-8?B?NnV4Ui9JcTVvT0pZVzhrNHNYQklxcjRkanlqakdEdmtVblZZUzB3eHd1TUJ2?=
 =?utf-8?B?dkJ4cDV1bW5TZTB0NTlHdGpXQUVrcHFRZjRZSlJ3b0hKYTVFcVQxMDZVQWR5?=
 =?utf-8?B?UXZ4K1p5UkZKTWxjWTRvNmNKNjMrT2sxanpIWnFpY0lMMUlQeHB4OTdVRmtP?=
 =?utf-8?B?WVJnbzhZdzNxNjFPSkpDWWZ3ZTlWb3R0cXMvclFVWE5zRU04SndjNk90em5o?=
 =?utf-8?B?YW9EK0h5U05Dd0UvYmRsNWx5OWtLTnZLYjZMRlBFcngzRkd3Zm91YnVLRkpa?=
 =?utf-8?B?dkV5UktuRnVNWEZkZDh0NWRLK2ZWNzNKa3h5ZDM5Q0RFNnBjdEhQVE9oMlI1?=
 =?utf-8?B?aFRYdkQvUXREMFdDK0lvZVR0ajZsVlVrOUFsTS9mNzFRemVmV3ByUWdmSDM1?=
 =?utf-8?B?ZTFjSnc3T1BqWDhXckZpaTJraWJYS0xMbVlCaG0rTUxOZ0Y5clRzdHJudTZn?=
 =?utf-8?B?Q2pYWGYxWTJTTGQrT0lucHE1bjJtT3Z4aGtUUG5xU2VoTm5TWjRHS1BMT1VQ?=
 =?utf-8?B?RUZlTDJVUzNvbzVOS09ISXhrc3N2eDVMV2JVNU1LSFVyZjUybDFJMkhmR3ZQ?=
 =?utf-8?B?LzJwbWV6Q3JzNlFBSFZzYll6bkJVZi9OdEhQSEJlVmZ5cjMxWUVzWG5Ea3RP?=
 =?utf-8?B?YWFjMGNVMk9qMEVLSXRxMXJSYXRmaU5FNmtLYUxKN3RZV28yQzUrMG52YnZo?=
 =?utf-8?B?MmhVeUNYQUxSOWFLczdhemYyV0puUHdYWVJYdllaeFovVmJDcHQ5WUpQVHJa?=
 =?utf-8?B?NXMzZ05mdkNQam0xeUtOT2hPNkdoOVZBZ0NDRmZLMC8yeW9rdnVVajFxeWFX?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O80RVngs47WD5c+elRQkTQ7j89KgXotE0NKkigPe1d2B9VRU4qXTeTjvdsZGoRXFYzYdTHotNkNjmqGrn11t3W9jugKRXswiiT0ZNOyndEtLIVxkmOTt5feDv5cxpjz66x7QvMzsqGAm04g2xXKD6YdEigd++4Yy8+C56qd/Ebuzsg6/Lqtw/FgDY3RzoLRyKwDxdul/53Ze/Z/P3hytsiLSYBpGmBkC4WCHj+MHnVfCsy9Cds013Ixlexhr5N8O0u8qXPa9mi0iNva28OVRP3Ul149GXLrxoeXsn0h6fc3oenXg1mbtOJKgEFab4bf+8W7ATAn7ie0huvt+O6f27hC7uHe8XHIlxPCduDpgoJocPaWO4QiQi2XRFHBGuZdh+880tJWqCdzT1JfSoYiPegSYrWeHdpoGqc70mv8Y+6rNxYeF5Sj6YjJpN3PPz0po6q+ql9CMYEXWVsriYpIQO+lRZ2WW9GKt88H5DulU+HCwoe+So6gDjy7/qXsXF+d8dm6ut4dZAtZ02lzSwZJc00co8A0NmPKUKYzOH0UbmEIBsEWdjDGm6ImoUh+JT/uoG/ygCsw1ZOui8XX5FqrRSRhPGpO3LmownDCOtkMRUFweRX2qXLyaIi+FB4bC7oezujJREI/wvwS870GLmhA1lS4/c7hb8dDgzyFmAe/+fFNAZTnh5Yq1P+sScR+bMhn3UJE2HOwm27na9J5ZwaoC5vCIhkVq6gicb6KaSnrge4ExJAqJtndHF54W2jT87z8SRYqld0cD4v2IuSL9ZhHLXdWUk4fuPTE/4YBBznCbGqkfGA3u+PTFAotjbRz9KnGWi+z/We6sRAE27oTvA/LAEg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1ed7fd-a824-4f6f-a7c2-08dbdbf7ae05
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 23:01:42.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e38iT6Ylf68w4u6B87SP/EaTwvs/x3rvwBX+k8v/3c0DhB60mtJCoBy9RbsXe7cpQKhsu0GrKHd/LXyCroLFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020185
X-Proofpoint-GUID: UGPCVxUpIhnewDeoX13Icwn6kgdr1jvi
X-Proofpoint-ORIG-GUID: UGPCVxUpIhnewDeoX13Icwn6kgdr1jvi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/3/23 04:00, David Sterba wrote:
> On Thu, Nov 02, 2023 at 07:28:18PM +0800, Anand Jain wrote:
>> Currently _fs_sysfs_dname gets fsid from the findmnt command however
>> this command provides the metadata_uuid if the device is mounted with
>> temp-fsid. So instead, use btrfs filesystem show command to know the fsid.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> v3: add local variable fsid
>>
>>   common/rc | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 259a1ffb09b9..7f14c19ca89e 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -4721,6 +4721,7 @@ _require_statx()
>>   _fs_sysfs_dname()
>>   {
>>   	local dev=$1
>> +	local fsid
>>   
>>   	if [ ! -b "$dev" ]; then
>>   		_fail "Usage: _fs_sysfs_dname <mounted_device>"
>> @@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
>>   
>>   	case "$FSTYP" in
>>   	btrfs)
>> -		findmnt -n -o UUID ${dev} ;;
>> +		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
>> +							$AWK_PROG '{print $NF}')
> 
> This could be also added as a subcommand to 'inspect-internal', ie. from
> a file to it's filesystem uuid, then it should be easy to get any other
> id if needed through the sysfs directory.


Thanks for the feedback. I'll create a separate patch for the
'get_btrfs_fsid' helper, making it possible to merge this series
with RB.

Thanks Anand
