Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15684785AC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjHWOfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjHWOfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:35:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFC9E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:35:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NE3g2q007608;
        Wed, 23 Aug 2023 14:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=X/rwhBoxGix714P6GpJh9dnDNLe48y9kfYzeabiUSyOe+ooLQrqwxNyodRyCViNCvj93
 p1Ly/clpC5JxXgFc3PuWYwE6sX9P2bADeb8oQKKuroBO6SAu+kr2n4qBLnVHpGO48mMK
 tS3I89V18rQAv0TGd4s1i3m5zwRwPvBEypMgsYrFIW9FfaiQN8G1kJDxBI2m+fbkB5oi
 SfDSIh9VZZScVCF99xkBiuIkT8vLpYXxpmzXJ6DL+CeXuENF2Wntm/Uu77one/ptZfAm
 jaVY9OGi2m+nloF/SqL4+HoS+OVD2Yw4lDuDQpjYnmszMiiM6H/4AZuARzSIARJg59S/ Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv1ypv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:34:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEIXuq001180;
        Wed, 23 Aug 2023 14:34:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ys5bvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfk7c0YTXyFuZvXl3/dF4eqvCVnOpJSOd2y479N4BgCbbA0EhFNE61aDBv9kEvRXItVjHHFaBOZT78osXv0U6vnEgQLlZKNtLazcbP9HIo3xC0INNUO9mYBEx+f+RKWZx7P9QfbjX223aTKo3hppHlPkaaf7zv25KjbPzUJ4c7nMIuyM/S/0u4eV3NASYo2/l/OE0SX1SM33cms738C9cWj4vDDABIdmFfK9lj/CSZqQZ14lcnB2fhkJ3yZtgvBnUUJOYx2IOGMfz3K/UOsMrtf49/v3i4j8Bx1WECc9FBjPuV4acsI1K7xSPe49yGXduhstBrgtJlNS6gq8dAM/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=dvSCiPUpNBYo4xGI012Z/DPSmrsufjOaFh9GzqNYquraiUlYAbcfgEjNLOAtf5ET/qXW5At/tPQdQ/glJul5aKZT7n8doHB4h0C/oiPGLaL6E2eEfidpdqhYPFr/wNksD6Cxu/wNfppeimsJ0Wa2BFl324x1axp8PNoC05Ig1b6e84CXLs9lA/My+i4oRfOR5wPzKC623sFiEVtPKd+A7xT7HitVV/cZcpsBXK06VFNURDfu93OleyadDoH0/kQZnxoGmkXPGYaG3/QiYdUIAPL2WLNcBEoX3c7FwUS0ybqKRuel4H0C1iRoJNtVQQjLt1Nkvvm4TZ+ct+HHn5iagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=gzQkNGLGTT//yPlXsK9liqjPlCdNQaTsR5htCT98X8cdCsdporucKr+U0VeViA9nLVkXK+4OG8EOr0VRwDoEHkG37+7M/2157O1VgxszNsNBrmlGMiHgmqmDcRakJC/EOwb8zCITqXCa8mnykS/0c1Aho3TAi+SFYwGIjmRjacI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4922.namprd10.prod.outlook.com (2603:10b6:610:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 14:34:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:34:48 +0000
Message-ID: <076d7bd5-91d1-e456-092d-d14b1d6741d8@oracle.com>
Date:   Wed, 23 Aug 2023 22:34:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] btrfs: move btrfs_name_hash to dir-item.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692798556.git.josef@toxicpanda.com>
 <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692798556.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692798556.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: a474e4d7-178f-4d7e-ca33-08dba3e61a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIzyRNL/XWeMrw3cInHNSHfIuQ3jrVVzyjYgCguliyD31B1in1o3Xcbb0Z/bmfdIvykg3pKpdRtVyVQxT9v2kgEudayUB3xSGUaqriigwgHWRQZso3vjz5VfDimMkIQGzD7nkIuayx9Y7HsITXCE65VxNJFaooWB4I9/mrQaQhxO4jKhP+5Cb3XCNofNMk14qHjjxZEuJfxRN3CxjFKuCLJRM6QJQPOLVNIZgR7FAq4oRqBicd7axpr8EiXpegU1lBiR4fi+XfskekPEF/M68DAeGb7V99/C68aXy/Ge9xitztg2PXXs9xZbbYbsEbc1JDoKgINm+BMccsAJbwttmXGZG2qKUnKYvwAQ8tm+Cwvm8reMjyMw7p6+Tu1XBmAGgYpBGFN0cE7GtP38FesjY5ZWPcH8l56Xv6qfVPSpJTFGqoJcfWCzH/IdkLGB5b7ZHFn40d8895eOK53FPxr+UJ1Lwy7/EyNJOAEfmQ9JG+Gzm5tz8Ia2B+0+FonxL7fTfZrJkPCqijeQwIkmtgyBZfgwkwjvO4Lz+eeIa45Pu9trXvDrMs4EpL6bhG8yiH9pg9g4MP0ZPxS8AWPVW7sXU5+DPdLjIBOE8t3i30CMw26seS9Cs/LnoCob0e4livgVx5YWSA/Lje5V22wngneCWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(4270600006)(2906002)(19618925003)(316002)(6486002)(6506007)(66556008)(66476007)(6666004)(66946007)(478600001)(86362001)(558084003)(36756003)(31686004)(44832011)(5660300002)(26005)(2616005)(38100700002)(41300700001)(31696002)(6512007)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzAxdU1JSUpOU3VMSGV6eU1tWHIxZkdyY3pPRXVMNGFVeW8ybks0UTNOUTdM?=
 =?utf-8?B?ZDR4L3dVSmZBTGFLems3UW5hOUpjT05jOGFNK05SdG0wSG55L3hYbXlwQ1RB?=
 =?utf-8?B?VkpDZDY1Y2QwdkdvYTRnRkJFcExmeFVrdUdBSmYrYTZsQUZOZE5UVmlqeVhK?=
 =?utf-8?B?MTMwRzdpblptNnRpVGdGQ3dDcXVJdEYxMVc0MXBFS1l1VGhoOE83WXUzZVNV?=
 =?utf-8?B?TEpwMFdWTXdHbU5JaElOMXpQa0VGSHk3Y0JnREZXSzNDMFRUdk9rN2VocDVk?=
 =?utf-8?B?N1REWWxxZVlXZFI1T0dHYzhYV1pNN2Q5RTVFWktycS92citrU1hZRk56V2pV?=
 =?utf-8?B?eGUyOExvZjUvWlRRcnBEdjMyVkFNYnpTK3NiZ3VTWkFVcWVFdlhqRXVQVUVD?=
 =?utf-8?B?TXdiejRxZHQ5MVZ6UnQ1aStmWlM3STU5K3dBMGo1TnZwYzFSN0xqSTdSNGxx?=
 =?utf-8?B?YUJmUEhRdmhkL0lEajlIZlN6SzRad2M0N1ZyTVVMYUV6Mml1MkFGSlNNOVFC?=
 =?utf-8?B?WCtXcENjNk8zbzhsUFFURHhPeGhTK3c1YS9xb2tndndHU3hjbUVvclVKZHo1?=
 =?utf-8?B?S05UY2hObXE1Z29tQ0FHR3RKWDAxSEFCUnFJVEIzMkdNY0lVWER5VWlDSUtI?=
 =?utf-8?B?Vk5hZFR6Wm1LbSt5cVJiMEU2ME9kLyt0cUZOZU5FQndHL2JhVTNNM05IUHFO?=
 =?utf-8?B?NG8xK2lKTXdpbCtVTVBsN1M2dXdSWDFDUWFWVXMwWmQ2aEo3UUZLMHl4U0NT?=
 =?utf-8?B?TGtKTXd1QmVZZ0VsaUYzMUtYN3k5Sks4eHBFUk5Zc0RBUzhTbzQvamtVSTd0?=
 =?utf-8?B?MlVLUHdFL01qVjk0V1MzR0RQYjNURStJTzdGdEZDZnRoTEhLdmlLMWVnRHpW?=
 =?utf-8?B?ZjdGRENNTnN3SXZXaDF1VkpxdnNMZUNaS0RyTXNoMUNpWmNCNWpOcnJGK3dH?=
 =?utf-8?B?SnF4amhKOS9CTmpqcUw5cHo5TjlDSHNpVkkzeGFLcmRGNnhaQXlza0FZa2ZK?=
 =?utf-8?B?Y1kvSCt4cGxRWlJjb3FzTzRDSEZQS0FOSWs0TENuRm9XUm5VaHRCNVVEVmxt?=
 =?utf-8?B?cGpWZkpub1A3ZHVRelZ1OTErZmdzNUpIenIrNHlaV25uakhHSVpZYnY3Mm9C?=
 =?utf-8?B?RUt4Q1RLQTJEdkxvbzRNenZjbUJoMVRlTkNoeFlaTjRBQmU4OW5Lb0Fzek9I?=
 =?utf-8?B?U2lkTi92Sy9GTE5sYU4vT0NoTWp4aWtmVUNhcTlOczJpOXovOGhibVVRK21B?=
 =?utf-8?B?NG9xM2pqRTA4Y1MzQnY0MktOWDdVTU85Mi92bGNxR3owdVljWTNzNlM1Umxr?=
 =?utf-8?B?UkVlYkVUQnRDa3RQQkNWTkdwaGxna2JTZHhZSDd3WGlLaWxpTEZseGJNUHJV?=
 =?utf-8?B?cC9Va0JoZGtuRmh0MzdFT2l6cDVQV0xWVTMyN1VzMnVvYkM0d1ZFUzM1YVox?=
 =?utf-8?B?aW4xMENENW9TSjZqb1phNUVGODlSc1d2VWZFcmxvRkxoOWVZbU9qTVFvbW1V?=
 =?utf-8?B?bW9NMUEvWVpUUEZ6bTJTQkR4SzNuOEVmYmV0TGo2TUtNTXZmamZHeDJkVU5m?=
 =?utf-8?B?dWNseUJGcG9CVTh4VFFqRS9kdGRLVlpISDdQemdWQi83MjZMcnZvZzVIMHdq?=
 =?utf-8?B?cHdqWUwwVWkwdmg0VCtiZlREZ05OTU1ZTGc5R1pvYkZETTRMTFcvU3VQemVs?=
 =?utf-8?B?RWNHUlN4dHBaMG1ycFdaUjdwVzVqbFl3eU1XeUVVTVRZUzFsSVNmOTdSemhL?=
 =?utf-8?B?Vk9JMGJ0c3RZWTNTcUpHa1JnZ01sZ05nVmFseGN1ZFNpdWJ6T2V3ZHJwTTdi?=
 =?utf-8?B?VWRwVWVNdEl5WWEwdmJHcjE3c3VyZEJQVytEbXlhN3dJbzJaL1F1Uk9XMUlD?=
 =?utf-8?B?ZTNRUkc1TEpnbFAzUzUzNXNueExlS21KRUpLYW8vQVBRRENGRmRIVUYxNm8y?=
 =?utf-8?B?L2NadTRCbEFnZG9hd3ByaDB5L2R3b3N0bXYxckZVTDlyVUpOdTVoZ002K1Bp?=
 =?utf-8?B?Ui9HTEpGZlQ4L2xVbWZTRFp1TEoxdUpQVVBaV0x5UnFnanpGRThoTTVabXFp?=
 =?utf-8?B?alVuOTdNNWVsaHRnUkRDVHpMMm5SMDVwaWtRbVlYakIycmd5NE54ZkxDZmNK?=
 =?utf-8?B?aWFBcG1ML1d2b3pQbkxYME0wWGo0cVJRalhNbk9PL0cwb0ZseU5xdnhlSXJL?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s9NBYiryHE3kMxQxolzCRTaRRCOmHifSE2kbadWKqVzyIRl/8WObmSFtQyZqcVqkOVIyUQc2a8qQ31PwG75iWoJ+bKSjhyz7u/gACJl6eid6EIiSfkBM8B0iHJniLN59w76AEyCwwScYkUKf65saYqkdn8lgWPogd/AZRd1H4Ol5tZBH6fTLnUh7cjU9WSt0UEsse8gkUPTSfGDJV1BCkA3u7oIfzt1FuJxEZ+vSqnZXQYsbakETL4BSv9G4P/KhmGfiTY2j9TaYHCWfCuMS7ssW+twBIsfT45dq0Tbsr9A159QKy4P240Jiqr2XocP9gJIj4rqIA8hXrYg9F3Zl2qJYBTpPYpGuQMbeqoNAEevoIvTrY4zW6Bs4wegkzsJJFq/CYkZl19LYXB7vtRa6jytG4n4RD0nw2tDiSvPgCs+s2XnmZ5IT4XABkx0TpLcIBKAkCyI0bqEwaNOpNCt4PYoA2dz4stCm8Gr7kZpqdtS5lhnQWfnEtmC4OLkpVUlDYBbwpFvKcX/WCrwexIfv2Clamplm00ESRpnv6JuIl47UIYfZuiHeiFhnVTRpn8GnJ3ubJiJyrJ22CTg1vh/SGDrA0Ycy42dm15WosBuUE+loqGvYQZL617iS2V0QWs7gMYjB6JnSVeIFrPNCKz38kx2+IzdfNjRnXBWeSS/dJd5lCyb2JZz8rJTa0dnkXc14ivH4oFFEXzYfecscKq/j/YoP+Ak45Cm11IBCSkNKtZxSLOwBCUb03FKAe0JaxppNZF5wON4/qEFhU3NFVQ5lcUbhFX7vHepMvejR9LxhKIje6RIPSf3e/uDUbvBk3Fhu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a474e4d7-178f-4d7e-ca33-08dba3e61a66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:34:48.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlFLy8ROxb7EDzxvPStnZz66CZPhlqHLKA+4vfd8VTk0P3hRv2kL0O+zKIdrNSv3Shec8MSpdsGX2RP0yPuUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230133
X-Proofpoint-GUID: 7miFfBzHdI0I-OS4Hjeiyg2IF0yIZVxs
X-Proofpoint-ORIG-GUID: 7miFfBzHdI0I-OS4Hjeiyg2IF0yIZVxs
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
