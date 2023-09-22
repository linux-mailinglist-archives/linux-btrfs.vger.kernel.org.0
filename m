Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42D7ABBFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjIVWuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIVWuM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:50:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF94AB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 15:50:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MLYMBF002153;
        Fri, 22 Sep 2023 22:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DjM5MN5v/WLNRpMw9KpvZl4F93a5yiu+mmBu8re2PsE=;
 b=CuP/Aey8jCOtHomLM4MbQv1WlD/yQS+o1m14nQIaPMK5vBUjYfJ5euh/391mnrOfe+uV
 7XfUR3UiZ0+k/5xnBzH7018TSGut6yp4MY/nhc2NQWgy15fs5LPY9YUmLJJzwZF+SfPV
 LwWirt8vzz34knLgEuMMlLV0M26wz+4BSsRPhZ6xEtRikhIlpfoZdLazvfZ2vFqob0aF
 eOMk9K0NQd7sQKJ0aU56/lAyaSq+TVPIPrdjjJt45c/CLdoa0Uk0mPtYj7RunsAIgRk0
 TWmpzNBsgELoQw994XghGKWoarH9zLuTW+jEHYB5usfybmhpouuElZqGttu+8FdnLQcx Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt0ayq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 22:50:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MLHxrs007748;
        Fri, 22 Sep 2023 22:50:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhddnvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 22:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw0DmegpnErfehZ6fhFt1k0Up9XET51JI5D6flHbPYCnzZf7HTeiyN73IlmR8zVMy3UMdfLOumQRRZotmFN36XAEueNjL3X/YtoU4m9XBAEIwN9Cght9hadTRgrsJM50tq+fwys12PwHZk955dxyuaFNg0yYGyVmxfxPkbNH6ONslxPPcyuZ8OuOMBM7mpZD4R8q/80859/D56iEs3pIigDmp/m4Ju3bBpoQyxffPQ84blcpm/h/21xI0lyhyRgpWOQknQk6bwehKuE9TucKKqy1U6RujjrlMStq70IJdFRWwYNeNwwHq8lDsvxYB1kt7k5RluXejme+S/M3NSLzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjM5MN5v/WLNRpMw9KpvZl4F93a5yiu+mmBu8re2PsE=;
 b=Id5/9vgfsVCZqCTFuDm0X/B9STLx8FvUR8SQTLW7D/WFtWPV3TCldcLVzqfz8+QSEjvmTkt3DyE4qzY6q8gpKz8DBXeD2re6AX9nnlRqyE7/OI/Z1YBe2wN47YDeWts/w20wiwd7yzDTmF9I6/moc+itmSGKzlFnldUk4Ixc9ilH2PnnKWZossBdlmij9PX3QqaTB1mdZUO/lnFbCtbAjOan5ss30sXt9CalZ8FiHKtFrtDkJM0Km+GdbAz7/dexTho7zv6TRSvYfSSJK7xZHWgW4CPZxZsz0Hf+WUZEDIRkamQCO/ZQa66reAvZcYgjG/Bhg6kcJXC7cE5uuHepuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjM5MN5v/WLNRpMw9KpvZl4F93a5yiu+mmBu8re2PsE=;
 b=GnmBWpCMTI6DKEsO4taJYUJ0869o11V9P6WbueYArwXN3XQKCO8BpWFaBuOsK61qsEGWGYi+Uuh2s7R5bsnYVhiDmzAVpbbmEgs28G4SiCqsxDfax0aSpKkIsqCBbB7HtvUUNxtZIbo7kzLouOizvx6rdKJOsWad2/cK29tixt4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4652.namprd10.prod.outlook.com (2603:10b6:806:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 22:50:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 22:49:59 +0000
Message-ID: <1a959d3e-6182-98dc-d1f4-c12f0b0fbe75@oracle.com>
Date:   Sat, 23 Sep 2023 06:49:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/8] btrfs: make wait_extent_bit() static
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1695333278.git.fdmanana@suse.com>
 <b890f86f43d87fcac4cfa1931e97d5c15b0eb6a7.1695333278.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b890f86f43d87fcac4cfa1931e97d5c15b0eb6a7.1695333278.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf32503-a6a9-43ad-ea9c-08dbbbbe3ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cb0hBswxKPD9bCsBGLUE1Wl8UjCEha68+nJ+Nvbu2fOFRFhGpnZA8LNq2kGPk6ylb4GqwYaRCFQH6Dz5hgs8JDUhiJB6W7/yCAgMiIVx2RZn1jxWyMA61qU16xNTn1ysFAlAmiNwgAhWjejjsfAvnR0dR8MrM4T5bK7vJ4c/13bv9HS+mrbKnO4Ut8yVLzfHl7v8kwraM0Gbqn7IRbI/y85JWj5SHJ41LUFa2AYy1TlvNOXGJNwrglSgWLQtsAQTqlK4i6mGSX7ehxShWjtzSFeo5XsuWRZhEBP8aHTzcCP/28lZc/IrCB1V6hhm9JhW7oCi2KESmOwxyqkvxqL/WUP0t/2OB8IXz6H4efL5J0lQmjkxaeqpoNU+vJcPE/eJRcy11vsGYDxBm65jpGAM8ASFUvqq5NzIV1gN2MWx42U0BGjVExYYdbUlwbXo51MfICT19clYfKwIUvybEHOFpVC244alQj+G3hwI7z2DpWQ4+2gVeVX2m48uce/q385iKSQEKDVFkpWS2h6/IGy+JS46J3yHE44zeWgZAZZx+PeeKvyh7WEMZ2RoS7b3DwkXjUIkAZCpsH5CHV5cSTiNNFEIC+9K+l5LOPWW65L1Kif19y4a5ouCvG2HQkfYtiRFdnfFBvPjaNQkOgWiE2UUSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(186009)(451199024)(1800799009)(6512007)(53546011)(6486002)(6506007)(6666004)(36756003)(38100700002)(31696002)(86362001)(2616005)(26005)(4744005)(66476007)(66946007)(316002)(41300700001)(66556008)(31686004)(2906002)(44832011)(5660300002)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enA3ZmV1bGRNbnZGQTVGSDkzL2gzR0FPRUhWZkhERkhVNS9oRkcwU1VxNDFC?=
 =?utf-8?B?ODNiR3N6N2FyVGo1eFAvbmRSdFJXbkJOYXNtZWRaKzM5UDFjZ0N3RlVqWElp?=
 =?utf-8?B?YUh2ckRBbzdNRUJ1NmVBYXh3OVIrYlkvRTQ3K1I2azdMc3NlQi9vM2ZhdTlY?=
 =?utf-8?B?cWxReXZhanV0KzNEajdZK1F5NWl5NklYRmQ5UTdiMldXQXpsczZVdkQ3T0VC?=
 =?utf-8?B?ektjRUtqOFliOVB4QkNNejVMOTRzZDJFM25XVEpEalNXWEFKNS9RbEdLek1s?=
 =?utf-8?B?ZmI0S2pRRnpqR295TG1FYzNGaFowT3UreE5CWEQ1UmNYclNWeFNnY3BvSy9k?=
 =?utf-8?B?MHV6N0NydEtLdmdYdW52WWlVQ0N0dnZYMDlSdW1hSWVhcDNEblUyM0lvQk1s?=
 =?utf-8?B?VENXcFR0L1IwQ05wZFQxSUQ5UFk4b05kQ3I2emQ3RTZoS3F3VUpUZEdMUmp4?=
 =?utf-8?B?SXg2bzBXYTMwTjZ3eU9kRDlteVFEUXR5bUVIc254V01wR0E1YlljcXQ5UWhk?=
 =?utf-8?B?YSsycmNCek1rd3FLQXEzdHlMR2ZLbS9DdUtkQWkxSXJOTjlmVVNNOXFVTytx?=
 =?utf-8?B?NkIybXcxK3Z0SXE3Vll6OVV5WTMzWTB0dTd1SU4rWFQ2dU0wclZaMThWaWdM?=
 =?utf-8?B?ZHFUM1pDZThRWjhiN1VBSE9XOXVkeGNqMDNKemVFS0dlMEJtSVFtUWYzcWJF?=
 =?utf-8?B?QWdsa3pIQ3R6UTcxcHV1VDl4NXI1OFNna1luQlV3ME8rWnpiQ1BwbEphNzZI?=
 =?utf-8?B?bFBsWjI0VUpUK3BLNW9LVFZOenVuWXNOTVo4SUJQd0x4U05hR2hNcVlqZnB4?=
 =?utf-8?B?N3h2aVBNc0ZMRSthN1kwYm5VVkNxV3JQLzBvcCtZQ2xOVmJZdjlUZ2pZdk1V?=
 =?utf-8?B?Y3paWmtUNFk5VG9EV0I3REIybUpaamhIaEQyVUh6OHRpTUpmbjNaeTRWZFJC?=
 =?utf-8?B?cnQzQ3lENHRiVGFBMUpFcks0cVc4Um9jenhRanlOWVBreU9HMmhyOGFLUzg0?=
 =?utf-8?B?elIrc1p2TVhEcTZoR1RtbWE0MFg5bDJLS0RpUFIvMlNIMmQ5WXljMi9SeTgz?=
 =?utf-8?B?cXdveUdTOGhsT2Q0bENreTdnUEZzdC96VnZEYTljNGNtRStydUp1VzUrSHox?=
 =?utf-8?B?dWZXY1hoYTdCMkoweTlVUlkyQ1dEUVpSTTBEZTlSK2d1ZHZEVHdYdkdwTi9h?=
 =?utf-8?B?NC8zNzFWcC93T0wzRzlCT3A2VHJpdDI1VGx2S1NVZG1MU3Z3bStMSVcrM09Z?=
 =?utf-8?B?QVZrdUIyNklVTGhsR1FhdDhaUUtHbVVaUlU4RHJXQXhDWUNDZmVWTGZSZ0Vy?=
 =?utf-8?B?MFBMTVRxWjA2Sm9pdVBhdFJzb0VaOG5BcUVuZjJMbElFenRrTmhtUXM2OUdw?=
 =?utf-8?B?SnJKU1hqR1hQTE5XSkJCMEtGUU5kaUVyMHFoTVRTRENDcXpwc0FPNS8wSHpN?=
 =?utf-8?B?R1d6YitZRzd3M2JxNFRxOUlXRFZubll5VXpVQ25pczBpOWNQSXdwTm0wS0Ny?=
 =?utf-8?B?QnVmTEg4WmFsTG9pR090aC8vNnMwaklDSmZRZ0toTHZPMTh6LzhZZ0hqUkJK?=
 =?utf-8?B?dlo2NkpmL0t2OURCSGlqNmRqWlNrb1ZjU1NwSFlEdHNqWkRWWW93cDZ1bC9Z?=
 =?utf-8?B?ZGJHWkpPaEFOWFRsQkNCUnJvM2NNRm90Uk1ST1l1N01Pa01ZOU8vcGJ6NkIv?=
 =?utf-8?B?QTR4NWdYRkJla2sxY3lRdVNjTnR2OWJmY1hqSGptT0tqaWk1Tk5FMHY5TFBE?=
 =?utf-8?B?VTA4aE1NVitWbmUyRVZEOU0zWVlWSjAyNVBKUlF2T1ZwSXdNVHAyOTRuK3A5?=
 =?utf-8?B?NmthVXhaYTFUeG5pZmJTMWNHZldZL01PR09BVVlvWGFZUnppMEIrVm9IZVdX?=
 =?utf-8?B?MjUxYWF4Y3RaR2VOZjhKcFJiN2Qrb0RIVDdFMTl5WUh0aG5GV3F3Tmc4OGNC?=
 =?utf-8?B?QWJXNVI3K3RXQituNE93ZTFZYlk5SU1hOEloS2crNkhMMzZPRG96TjVZZG5B?=
 =?utf-8?B?enVYaXVqRmk1Z1gxL0JpZFpsZ0swQkdTVkEzV3FUaHphQlJ6OGhvZjZ2U0dZ?=
 =?utf-8?B?VkEzUXVjMTBPMVE2SnVHUzNHUlBra0JpNGtYUE5FdVJXVWdNVVB6bC9Rd2dY?=
 =?utf-8?Q?EY0ZBnHkJc7dulQVj9YYwhcsG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MU5j2lK83XJlGF7rzIHfQihhSLPfm1OHz5ZjPOsirMr6gJnVT0DZq4DgcbrPNEsdyN02m1seNzuc7gTbz6CPfDThn2O/39HS6AgHzRUiA9wtqRusGzUHWcMAXf0tBsxTF6FqbTCs8Rpp4t1d21wvP2BuAdajNubwDr3EF8iGlsTFQcJLHkBJXI4MhSlyyjhmGGwjfLcfoqY2ujCbw+kgoGEE1zIpV06oG3gY1hJhkBJQAcns7CNM6XOglGNowKyLb6TF+lzg2mZxXO0sEosVIQGMIwTF4Mn2sK4hHZOibpb873otL6ytPQZM0IwrsJXOS8YPZivi/pAaAQZmQn98VD7g+IM6zBU93Tl1tuI6KwLcloWdJr6O1zwwkKgVEEv0lNCMFIlNyhiBUVDfMaSWBMBVYAMAdf/P3WHkZ3X5mLsLQN08xyP/3q0OS4sByPOLQUFqZ8NUtHH3/Um2DPtHuSLPOM2ZFHVAktaUGmIpbScSzK7xkaWyISTlGTSy6eYuGupNw+kZndlCt3nYQSnxnYDx0Mwlvp8Fc71PThnNWXRWGgf+xQFSHOTbauT+DhQn/vTnc8qdUvz9Wcz6v3t3PXJ2Eyfojy0v0nCl8a4m1Rj/8oUAhMUQ+GXxyoixSFeWtvWbnmgmr5FKkj3lM5krGLSmztpkUNhQJ0COPC6oualTnYj7M9w5dRXFIbJnwtgsWc6Ifo9I66u0Ek+85MfvaL578UkvkTTH5paOU5zLAKfGpKSh2xXO0NLbce0NDKUs5MxNPIvdhIlMk7i6pQN8hcG79lhRJS1n0Qo44rAspc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf32503-a6a9-43ad-ea9c-08dbbbbe3ec9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 22:49:59.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxcktbExuB6152NqFXSAJSzjUqQAgRb4PvbWewa7dCACwhRaSeHocnEyvVqarRV46G96PQSGlM7+ZWilA56TCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220196
X-Proofpoint-GUID: B777Mwtma8EpHVSOiGV-ou07Df_v621X
X-Proofpoint-ORIG-GUID: B777Mwtma8EpHVSOiGV-ou07Df_v621X
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/09/2023 18:39, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function wait_extent_bit() is not used outside extent-io-tree.c so
> make it static. Furthermore the function doesn't have the 'btrfs_' prefix.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

