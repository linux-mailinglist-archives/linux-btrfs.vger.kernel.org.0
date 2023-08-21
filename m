Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480D782666
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHUJhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjHUJhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:37:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7B91;
        Mon, 21 Aug 2023 02:37:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KLU89K001274;
        Mon, 21 Aug 2023 09:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=iVgHPN63uK97JSAQfToXR9S9VImuHfm4PMRe6m57DD8ykPLery7hITh3e4EZ3K7B8Z9Y
 NEHThFPv9rq7TfURa8wpwFiQlqkL6gBxK7byvmv8KpEi5+jyBS28VYWdQi2fGIOxiJ0i
 ICTQb+vgxiraNY3ySievDXge8dR1zobciLXBsoe8q3gip40Nj4MeVgguKb+/+DptrGG8
 BOsrbXBqFnXHyTWWjpxgih59mhrbTibxI1gkNvjWWtNKDieDBVmS2vckTd15Qyyf5i0n
 82q8VRidelikjmzSQUbErkS1y9buO0EBIYSSUDuNTS32rWztNNg0DEWfGlOQzlNKlLWN 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3afyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:37:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L93uCb029776;
        Mon, 21 Aug 2023 09:37:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69qj7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4vi6nQ2idEqkeNBJEY9j12EcdHQE0sLYYFQN1IB0GXLQWpGeqD7F80EPgG0IIKSnFArQcMLVFgTZ2Dfbj/+o6LAZ7cDYeyTkAXAC9Ry/VV7O0jN/69l2kbjWyYtC1P0f1y7OqMJzHuYF5f5Q+gmqLkdlTZsTvN1dCYWzJcJgbY2FbOh/BWXAez9FZ/oDdCt/M944XwTK8mcJBK66K7bXB4XBzjmDdrQU1YK2PEt3/IHYj9oFDgH9aZ8TGoWg/slCh0pfNDTv5vtJhOByW7vXJ0phSexq5Hqrx9ddJIH+3hfMfHegKfDfHNLw9RVt2wVVlkyOPsynx29irZsAU344A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=Hcm+EaD2dMgCFB7wYU+ntjIegASN+MSQPLbWfuoVBTg2+tq3KfXVqUuJpiErUEhi34lFKz+pw0tmHzYirYhrdy1TVS3JqL9oyU9Uo1lYZ+JlpY31R3zedKtozTv9b1syYeO2EUkNFxhnV2IY6CN3ZMlC5nUC6rVZ19Qo6l5efCI2cNs4e9mS0fnAUbAgpyHIbhcldUaEQH/s8FE5lfNTn7xJfkYTc0tZfU3AjjxzKgLwTLIbQA0RA5EbPzArZYmfqH4ZdIw0amZFRc5MS4GMQKXr/h0u+B3VMv9RLj6MdOtwpX4GdorNHQ+/2ixhP7MS/0GTmTgiQOTZrhAGG8nxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=CS5hlgCDUVacMgEiiQQ78ppu0dkCWXRGYBXlOcw6YyqL7R6KvoyljnMKDZNoR4I4y4W3XJGnXsEXMime7WspUoaEgMaLB5QJPo1OHzH3pXSsZ0Jm0wvhVuii6j1GO7nrnSPYxhJJewxV/yDtG5qyFIBy7EtnXgUiHvVvlXUPTKU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:37:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:37:42 +0000
Message-ID: <1cf902b5-6186-d90d-b1a6-9afd4f4d622b@oracle.com>
Date:   Mon, 21 Aug 2023 17:37:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fstests: fsstress: wait interrupted aio to finish
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230820010219.12907-1-wqu@suse.com>
 <61c927bd-3c13-9591-da31-f4a486902d7e@oracle.com>
 <4ce9cb80-1a4b-4e54-b1ca-bbc6f8c82183@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4ce9cb80-1a4b-4e54-b1ca-bbc6f8c82183@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 019622ea-3e93-45e5-8f11-08dba22a443b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYcgdFB/jxEm1SZgWB4Yl++ZPTy3RZopa7KQCgFIYSMZg4haWNtqViy1RHQY0GfDAvdZa8xd7S07+2y/LYR8r2Iyex+KN7lVn1xR2KKs578EjG+Qvg7y/pefFwy/0pnlRUYTUxsXTcZ0Z/7fr27xqLQCqT3ok+Gt6zQqvscxgQhnuf0dqtDehui3YEVAAYZwul3hOE7MKuUvnl2g2NKIhgC1G7gRF1b2ZiH1KidXMW6FDRban0xnCaaxzIxqn9ttUnB9cpScz6enobvpDmvK9G6Q8xBU8l+L8oLH3R1kwMpwWiVGnKhYEKxobRE7ktpuyHFEovgpcS8aMUCpaWeLbp4Z4OICBg5IKvXTFf7H6vGBhBo495vGbMJt8oeSL9BEl/wN9MrGTFrEKNTuKv/IesjWkFpc757WyT6vq7g3cWpXTybGwH4jUMuR8mVr1UqT1M2kNqOrUCmS7747ndNOylunYlATn41sMm6+eWeb7TeyfXJGoBo2J1HZEvqKsVvWco/5w30J5wE6PI6Ay/CUbaDWYeO8mSqZ4vayKVXF2SVgW8mHZiDe96K5Vn89CK9FqXcDPedFgSEBWqnMer1TcokhPVok7fjFkCe2M4B5bciLvP3AN3ldAZN1B20ORJmpF1AA88hAy2lhquJkuHSlug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(558084003)(5660300002)(44832011)(4270600006)(26005)(86362001)(31686004)(31696002)(19618925003)(8676002)(2616005)(8936002)(316002)(66946007)(6512007)(66556008)(66476007)(110136005)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djd0OU9saXFtU3lDTzZjNEpadnEzektFdWlzR29OMm1idDhMYjFZeU1LY0dw?=
 =?utf-8?B?d2RwbGFxNDZ5S3hVWmlwcEQ2THFneFlKbllmZWdhMXRtTGVoRGo3V2NhY1A1?=
 =?utf-8?B?Zmh1TUpZdms4bWNoTmZuV3VhOXhRN2hwWWNJSm9qRW9nd1BFT0ZBb043eXJV?=
 =?utf-8?B?cWZNcmVSeUtmVE8rVGZLaGJIY2p0MThxUVhhK3dTeDdYaUkzd24rRUN4K2hQ?=
 =?utf-8?B?QlZDekhOS1lCNHdkYW9oQit0YlQ1cy9PamhFdHZXdGNwN254d0lTY0FSc3ha?=
 =?utf-8?B?M251MW5kYlRSYVdXRU9KNzFRYWp6U0pzRnp1WkxWL0lmMXNnWXoxL2dxUjgy?=
 =?utf-8?B?c0UrYmNGaVAzOCs0THBGa1lLREVHc0FVeEFaa0RHY2Q3UzY1RW10YVFNMkhL?=
 =?utf-8?B?UEtXYkNjQm45R3pjMU8vWUpNZW1ZSFlRSkJlM3h0R053dGtrUVg2QXlXbFZZ?=
 =?utf-8?B?OFgzTnA1UEEyZi9COGtJbis1dWd4bythdHY3NHo3TlEzem9CNnlvZ0JycDI3?=
 =?utf-8?B?NWpwN2hGNmxEemEvUlY5VDB0OEE3ZzBqcCtoNUVBZk9oY3hldlhsZmhQUGJ2?=
 =?utf-8?B?Q2pYZmVwcFphd2VBOG51WXVNNXRXc2oxWXFQK0thdXlBZHk0cjZxMDNrSmtW?=
 =?utf-8?B?aGxtay9seWM5a0g1RUV6cEpqZDVWV2Q1dHlnVVhwQzNpRm1udHExMkI5Z1Jz?=
 =?utf-8?B?dlYvcGoxQTZqRlJVT1FsckM3T3RUcERwWG12Mm5pSHN4aUkvT3JqbmgyY0cx?=
 =?utf-8?B?NmowWGdLQ1JoRS9hYVRqWFpYdThuS0FUQzdiWm0reTZpODVEekwrQktlcGV0?=
 =?utf-8?B?ODhGNjhmQXJWSlNWSnV4NTNJOUU0alpzeFFjNXpGYkZ3OUs1WDNuRG5Bbm81?=
 =?utf-8?B?Mmp2Ty9HbTd6UWdXNkR4OWZZazBLL0hxUXcrM25id0FseHJtenhpdjRPQkdJ?=
 =?utf-8?B?SzZ2S3RoNFZHQUI4aHVKdEhGSXFOTXdILzdXTHFuN0FucVErTDJsNjU2TmdO?=
 =?utf-8?B?dlYzSlNseUFtQlh4TkRDbEJqb1Jsc2FYa0dDMXFTcmg5cTRrZWUycXlsK1dC?=
 =?utf-8?B?TzNxS2k0YU80S0hNREFpMS94L2hRUnk1NHdWeklMU1NLa1NyYUlDQVlZK2E5?=
 =?utf-8?B?bStGamhzbHRZRFhCNStSaE03YzVNZUhvMjZOREozVi9zTENMTmdHU3JGNnpN?=
 =?utf-8?B?ZkxlQXNtMFRDZncvREVFam03QWtlMHd4Z01ZdERva1FBNkJOb3JGRlZxbzJz?=
 =?utf-8?B?TEZOV1c2aG9BZnkwbkJDMG1wR0trSDQ1eFZXcWMwaVZ3OVJKNTlDMUVGQkFY?=
 =?utf-8?B?SVltckhDejZ5QXVWUTVlYTIrSEZHSGlzMmp1M2E2UGkzOVNKSG5TVVZDcUFQ?=
 =?utf-8?B?L29sRm5ESjZvc3hjdzVwUTArblRuRTJhRjhwMGg2REZHb0tWdXB5Z1h0VFBG?=
 =?utf-8?B?VC9la2x4SkdzQXRQSDFQaGlyOEpvQ2I3dWZXZ1k1MDdrSW1CMnB4b3lab3ds?=
 =?utf-8?B?T25teDNqNHVNRmNqUGhheGFCbmtFL3d4TmNMY29uRGZqZGg4YW9vMzk4OWhM?=
 =?utf-8?B?SDg3LzBVUjkzRlhiUjhZMmVsMkNjNmRYVVdXRnh2QzFsRk5Ucm9abXFkcGJw?=
 =?utf-8?B?OUh6QlVDeEVWVjBidVBwOEVWN2hnZkVJSEdmdVJON0tHYXQySjZwQmpLQ21G?=
 =?utf-8?B?eDNpM3dKeDYxaDNXSGF5RDhqb0JNREJwOE5NSFJjNGZ0b0JFMTVBSHJPM01O?=
 =?utf-8?B?eHh1Q0o3cktaRS9kaVhZY0pUcUVoTVpGUjRHSSs1dURHSVRlMzM2R2VtcDI5?=
 =?utf-8?B?SXRON0x1RWtjcktNbHlPYkI2bGlHTlhoWGJVanA2UFFJcVcvOFZhTFRad2Jr?=
 =?utf-8?B?YUk2V1VDSjM1aG9pSk5IQytSV1ZaYTBKVTVCUi9mSEhLaU5kOHNyZ0tlZVM0?=
 =?utf-8?B?akdEQUhwZnR1OG9Rd292L0c0SGNkVHMrQVVjaUorZDM4UFZYQnVjYTVBS2l4?=
 =?utf-8?B?T1NPajEzQnBUdnk4U0dqd1I4K25mVUQ4UUx1WDFpV3ZsUTY3ci9iTitDOEFX?=
 =?utf-8?B?Z1pDMWNWbUpocDJFYklRNmVGcUw4Y0JtK3BJeXV3VmQzNEF2YS9Wc2NvOWtX?=
 =?utf-8?Q?AgyngYBOswCkMJ/G49Nv9n+m5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NQMtU4SWqvvFbrS5egMErLgYgYHHqNY9NNh0m63JfqPQ/S8itnAwWT6BpGamCyd4uR7FMxaecbOSG6Df2iHxuF9ZP2Olxk5XZJ0DRcm4pR/BJrgxjUKWLpDtjRm963C96YImtgynEeZDY8bvc35vjJza8NPJmlviRnWgFKDQuFobepy1UOhM5h5OdxtoNKXYNAmgMDLZYKhQZZ5mHdgRetLW0rjzj//Vt7ONET373upRHlbxrZK3S+Rptw8/7TImjWx7LuamCoVOesxe+uDAQauYIHiquHBUdCcOHJmTdqn9ITg31nPyirf87aRP6I76U8rKLqv5M0GLfOdr41OZgW3qfdPDIbVhOBLfCW8k6n9i/45YuXbeCvM4iBH5WY62NecO6l7NcMR9H5Pevrvm/yjj+iPrM+9pM01qgAVPOZZNIME2PpwjpSXqS/tl1w2ttZXY2byXNsMk2wcjAw17xsGGf/tJlVPXzru7O49Zq8Km/l7g1okFVYWjXaMbhh/TDCqZqhe6hC+qaO6erFGcmC7tySDq9Ui9EFey7lZzeuBDH6RMFfpg2z6D/dt6K9sEQLbBsxEnHshVYeiTCwU8QEUWMhe8qjaqzJZFFKlo1ThdLI1iQXrp/cxEFw0IFYKE3qdJaoDDRhP41ae/KUp2V/8+KbkGEwQtJynB56gYzCT0c3HfLkjpPNiCRN+fjceAry/ZzFpo0hWPIi9cZRr3K2MVsDbGxZkII3hzYhEpatqbXUBpb4QslUFWoD5I0b0HtAzQXH2gh4v7fjNnN1pDMK9PEhILyXNo3f3mXK2pnAXR6w5amGOr9DlHO4WqlLDo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019622ea-3e93-45e5-8f11-08dba22a443b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:37:42.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFm5w5ldumuzhvM22M5RMuZOWfKouFx/QwUAZ9wkogY2WUj++mW9xkcXRhVn3T4iXctnk1FY2IKgTAZ+Ye3igg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210087
X-Proofpoint-ORIG-GUID: pBCYLZLtpwm24QHwGf4T68PvXGFzhiDs
X-Proofpoint-GUID: pBCYLZLtpwm24QHwGf4T68PvXGFzhiDs
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

