Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04655BE2EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiITKTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiITKTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 06:19:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0F6C132
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 03:19:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7KAoY011859;
        Tue, 20 Sep 2022 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I+KCt7xgXvJqDPVdJHIm6fX6vnwopFOpC/JnjPkohJo=;
 b=qUyMhkuFaxFF8ma5UxpEiNwlOtwzG6hy1t+EcWIPT+mrpLH+V7y2Nrz+fYbjtS/sGm55
 hvXoDoY4yUqssbaGYOiKHufICFX5asmSaGeMvmrfD/wHAV4j5spDnAIDPOzEvqi85uof
 VU7FA1qsV9OK8SpajMSbWGDzImZ99saPn+cINhME3PoGxrKISdQOzNPvLdALecLk4M+f
 rjvCh6GAB2IxZJ9+NN8mkgZAe0Nrg4/y2p36yqk4mBSxXRtoGpunrlUOu3gUqdc5H57Q
 vjj5vsEplzvAe3TVfQUr2Dkz/GeVAKb+0JcaJsM0rp033YtX8LHasYAXgn6setC9xTAH HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m6e6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 10:19:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K81tgl016657;
        Tue, 20 Sep 2022 10:19:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cn4gfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 10:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3CeoTM0n6LjOwQAW2zhm7G4CPwhS1zCniwLlYOoRMCkJqCxZHU87ROXZS/l0L4giiVMi+Sf3RxROMKz0KOCEAF6pl5vtMiXWDUL3IN34/tW4MscwI6s4ENiPp0Fy+TFu2guUiODojg7VPm0d7+gIf0+RYCKNe0hhjajlGv13M/qYwUfi8TR5hRHiTlVXFZjeIgEa4PUy16c2A2O7TBGNHUSM0GKK45qNaWhx4kmwjwipMQ0I0qJPNkEgX8KkS4SyM7pk12DtGM8rU0LXlQaR2yp5aGI1hlxDQF9EBk6VXrvswsstRx0Xo8wJ3LJNyX186g5MHM4NaTOTpDFZu7mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+KCt7xgXvJqDPVdJHIm6fX6vnwopFOpC/JnjPkohJo=;
 b=nT9PCjMN9ggaaTKe0nViKyYpNAlMV+KG2Zl0061kQuqSf8JWRFgi2g1T68O+2j+4oREohsZBH78rgg4jKEJyZtanJklcepBOMS50PfCnu44XCiWipl65geXvmX9SrvOY8uZdc5YRr2k90tMZAs7QAvUSKweE1Ymy/exaeqy0Cx368FykuMOpZlXHMiwl9tPWo/M9wSOSJ8EtDsrocQAFNoAWfnsvWzxfP9wiTugQrEeyddsR4nvZP5OzgKemYuo42KqR9kkUO+daahK+PXssdiJGyzb6MOwV/GgjEi2wb/VPpxKa7chRgFdD610FzZ77w+DMqq4T5QUkmtwfiDS24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+KCt7xgXvJqDPVdJHIm6fX6vnwopFOpC/JnjPkohJo=;
 b=Aq1REPkW1K2/6Y4rsNbUicUJ45CXS9ug3pxcnov1m6th8xGWcrdGn99gnytEFXeQ7+/N2Bj0+Ge7JKG32gQt7PsTROxdBz5PdO8PxGrRsr74JiYUQfJhe4vd8fq8N6VODbUep4QjwQ8PNL5w/e2ZFEWNsTZHioq/PsI9Zis8ZxU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 10:19:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 10:19:13 +0000
Message-ID: <ab13659e-6166-7de5-986a-54f98bc74e66@oracle.com>
Date:   Tue, 20 Sep 2022 18:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/13] btrfs: fix missed extent on fsync after dropping
 extent maps
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1663594828.git.fdmanana@suse.com>
 <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <25d72acc3215f74fbb885562667bf12401c214e9.1663594828.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 823f205d-5cf4-4502-305b-08da9af190cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX1VeF2vuN4w/0lUQ0uHS0s9y5Fyf666NuNm+aZzufGDCJ6HCeH1ztU2xLxC40kdvBqNYn4lJf9p/qxPMDhnHAsf/ugRlCcMaQYqpX3s06oyUxTsFEwOMFKCJw+EEL510I5omrjESDudZAHsvYiGu9zj5cM/KX68dYcQxLwMGw2EjnUSuqFs6WE0bEznydAqOk4sp1eXmdsg7eI6EueN1/LTS9lKRCi5cf944L69GAg77Rkfkv4ISntM2AvlctZyw2FBZek45frf7j9zaL0w5bvLQfuqXavzs4HnTEAfBxTPhI2aAB7Kt9N/YP20f2lPOwXZe2LqQywmJxI9ZlsIotbP3xYr7ibq+Q8DnDcJCoSc0lnVcF4t1VZMFXKALpwBb+zjJ/xGNQIbtRiMRBCpGb0NIF3cMP3+WCVX1pC5mjOkm8DBpnPBrM6DU7u8BNTmNg4BV65r3K3rPgvYDCmOshsZUNxQz3dBJRrl15W7l+tH1mH4d5CfpFJMRnOnaCcCMiumgHgEKQQz7KXNiNpIms6IEJHGC07ZDx5Ryq3lbjkKXI1RzPCAKIQbQR9ZjODIBKp7Ws1KZmfN0XU5lKKq4DoQ5a41RtiQ95+UiOlwE4StzXUb8jOIc21vUwmBHSpFRnOApLPKxQVyZAc9Qy7to0d26ts386X8nxs5oHUvJNXycdSzKW2vDOBMKzwgEoDiB4EJzno8sLzf9L2eOLY56srbeVyJW0vx5SfzAmwgrWW2BwM8avwjCWwK6vsFo5LTGbhbbzGyN5r+XihbSMC9CYIgD/HOn/GvzeEAOrEZudg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(4744005)(36756003)(31696002)(86362001)(38100700002)(44832011)(316002)(6486002)(8676002)(66476007)(2906002)(5660300002)(66946007)(66556008)(41300700001)(8936002)(186003)(83380400001)(6666004)(2616005)(478600001)(26005)(53546011)(6512007)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE54KzQrRnNIODVpMTdXellEWWdodCtzN2x4RTFwL09SNlF3ZmlWNGNtSE04?=
 =?utf-8?B?UGpTQy9PRVhLSTRjRHNiWVhmV0dxdTNORmxLZDJpM2dIdVFQNUt1VFB2eWxw?=
 =?utf-8?B?UnZ1Wm1TVU9kZm45eDk5cVdHSkU4eHR3VFpaRWxORFpvOEw3RHNGV2xVVkx4?=
 =?utf-8?B?cHd3eUxvRDREV0orUzhoem9XM2VqVk9help4VCtYVWl2ZnZ0UVB6WlNVNWxD?=
 =?utf-8?B?Ukg5Z2I1RjhhbGxCd2dwT3I2bTJlWUx0WXJzellOWmZUdm43bkp2SC9teXF4?=
 =?utf-8?B?QWx2ZXZmdmRiRHZyTjl4TGYvTUZtQnJNSUpGMUtVNFpVc0ZoTUVtNExQV09M?=
 =?utf-8?B?a2trQWYyVTQrZFFqT05Ua0pYNWFwaUgySWdwdEJBdU4vQVk4bTNFZUV2UDQ3?=
 =?utf-8?B?MHNicVQ4YkgwTlpOMkIvOXloYnVDajI0T2dKcVp5OEZJWmE4K0VTbFVxWnZ3?=
 =?utf-8?B?a3BTbHcxOTFscTBlWWJld0pIL2RzOWF5SEpmNW1oY2FHT0c4NUJIdkkzSjNE?=
 =?utf-8?B?L05DeWNjdFp1ZXpHZW1kM0dMMUxod2luZUsvczhoZUtTNnViN2pBdzQ4TnYy?=
 =?utf-8?B?enQxakpUZ0taaG5zOGdTUFFDd2NHN0tIOVdXZ0RoRWVNVjMvVHdzMjNocFJo?=
 =?utf-8?B?TTd1c0ZmRk5zSmo0dVI1dzdnS3NOcSt1STlNK2RuMy96SFExNkZnbVlPZGM0?=
 =?utf-8?B?RFBYL0UwbnBOa0FFTWxrVU1CdSs5MUxqZnNTQWZkVURSMEx3ODI5K3BrQUdN?=
 =?utf-8?B?QlV0aTlnTm9sSmFHVjduT1BIa09IUElVMElXY2NleEdYRDk4bHAydVpDNFNJ?=
 =?utf-8?B?d1pHVnQzV0xObC8rUDd3ekp5a0F5eGN0M2FjWU1vOUFZNDM1UXVFcmVVUHh0?=
 =?utf-8?B?MC9kR1IyNExDY3ZodEtUaW1oZEkyZ0JXbEQ3UmhraEppd3p5T3hPdW9IVlJF?=
 =?utf-8?B?K2tpc1lGMWgwN0RyRGtwYnB4SGNZbEZDV1pZY2t1TmVialRpUmRBQ2NtTnRz?=
 =?utf-8?B?Q0Q1NlJvRFVEL2pGL3puaTZaYVFaYW8va3UxZllBQXNMRVlHay9oTnE0dHU3?=
 =?utf-8?B?SkowaGV6YWpQRFJiSkI3anFDVnd3SHFqTGgzZWtram1Fc01HeFBXOG1wQnRO?=
 =?utf-8?B?eGlMaURpQWwrbTQzK2lzVDlKK1VoM3hIN2MxTVRmZHo0MnljRUNqNGg5WDV0?=
 =?utf-8?B?SjZKT0Ewb1FRb3c4UGtyclFTdGNPdzVhaUhIbFB2TWpJcjUyY2hzUHZLczRs?=
 =?utf-8?B?ZWRBQ29ubjJ0VUxYUExzdFlvdG9xcUFraStSL1liZFFlYjIzbmE4aUhmcnd1?=
 =?utf-8?B?QkdPYnJRTUFOU0Rmdm5NVUl0SEpYRUJPdVU4YVJTSEVzU29IMTA5aE1zUlBM?=
 =?utf-8?B?RTlqNXA3YzBseEllTUE0YUx4Nld5bHJ0VUZMMVhmV2Q1NnlXRGNET2I5ZDk5?=
 =?utf-8?B?Wm0yaXZidTZTU0xOeWVUdEZIT2xGeHU3YXg2YlpsTXhQL2l3M1MrQUdOb0xN?=
 =?utf-8?B?Y3dPT3hpVHY2UzJSNnd2a2t0ZFhicElKV09RWnlaOHphdWVSSFFrclNHb0RH?=
 =?utf-8?B?dWpGbFYrUGgyOGowUnZMc0hWRDVMZTdyUGoxNEdtR1hweWhvNU1NcHdSekxJ?=
 =?utf-8?B?SWVpM3FJZ0tya3Q5dDkxWjBWRjlBUmdsdWRNL0RZaGpMaVlzNzhtMUJJcW9j?=
 =?utf-8?B?SVRkYUpOcnhpMWxaT3RuZ3NkL1ZtNWo2RHpFQVN0ZlIyL3FxaVlmcGxtekF6?=
 =?utf-8?B?Q3gxWFVVQ1VZcDJJaVNUNm1GcG5QZU9iRWFBUk1XR1cyQk1OQmtpU3g4bHU1?=
 =?utf-8?B?dFBqeU5aWk5McTBidEVIbjZXNXkwRlA5dyttRHNMRmo5Rml3YVZmOGdtZ0lP?=
 =?utf-8?B?ZUt3clgzNUdaOWdTSnBxdEpwQjEwYSt6RXdGSUtIWGdaM0w1dmcyMmNONVIr?=
 =?utf-8?B?czJiU29nQk84Z3pVdlRtd1dGbjJnU1F5R09PY3FlTTNrWURvZU0zQW42NDFw?=
 =?utf-8?B?dWdZYituY0c1My9SUXFtaFRtV2tHV2VLcXVGSVovUWhZRndVdUxFTldjVy9P?=
 =?utf-8?B?SU9ieithcmdjNFFOc1gvTG5scnZ3NDYybUZYMHoraE51alJXUVgrNXNESDVl?=
 =?utf-8?B?ZEdJZms3eGM3TEd0dHBzeTIzVE9DQnl3L2R4Mmx1aWlNWkFVSkhtUGJ4bis3?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823f205d-5cf4-4502-305b-08da9af190cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 10:19:13.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8wGnDZle6Wz7uiQ6ZL5Kk69mIDfLocCvvT8znEwxnZS/tgjE1ChilxTLIDww3E4/xf5LF1W5q2kba7F2yChCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Proofpoint-ORIG-GUID: umuBHe-WXjYdt3Xz1Bjdsxze-7Wn7Nec
X-Proofpoint-GUID: umuBHe-WXjYdt3Xz1Bjdsxze-7Wn7Nec
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/09/2022 22:06, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When dropping extent maps for a range, through btrfs_drop_extent_cache(),
> if we find an extent map that starts before our target range and/or ends
> before the target range, and we are not able to allocate extent maps for
> splitting that extent map, then we don't fail and simply remove the entire
> extent map from the inode's extent map tree.


> +		if (testend && em->start + em->len > start + len)

  %len comes from

  	u64 len = end - start + 1;

  IMO >= was correct here; because including %start + %len is already
  after the range as in the original code. No?

> +			ends_after_range = true;
>   		flags = em->flags;
>   		gen = em->generation;
>   		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
> -			if (testend && em->start + em->len >= start + len) {
> +			if (ends_after_range) {
>   				free_extent_map(em);
>   				write_unlock(&em_tree->lock);
>   				break;
