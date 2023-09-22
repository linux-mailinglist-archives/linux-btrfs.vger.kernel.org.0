Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B207AB53C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjIVPvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIVPvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 11:51:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C8196;
        Fri, 22 Sep 2023 08:51:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEESHY022660;
        Fri, 22 Sep 2023 15:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gG/J14pSp+cVxbRvtu0ZpaJRJMA4DG3U5wIOlmPpQy4=;
 b=daJR2tF+sb/3EM1jZOW3eDpLcXXyjfvcky/ps/iSZm3LXDqWMh2HLd+pu3cs/LRcRGXL
 7LF5n62W/7hoSYHkkIfezqXHN4SEkl1TBhbEOPjCs81dyFlhze885ibE//9ep72FKn0z
 5Ti7VTnGOtTnKX6+gUqV1hD4Q2+d+Q1TphfmCkvKbfsXzWuySp/HXOdWN4bSMuy17M79
 rjg/Gbs7BQXWREW3PAc7sXoTF/FGJwl5FcL6srglEtstEoBT+J51Doe592KKXTp4Y7PM
 kMGbD5Yehv4UMFr7Vvg+wjOv4qzwrN3v6f1IwMGpqblUQsCN2QDtyHRi555JJ/SwlLEP 9Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt025n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:51:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFPjNZ035180;
        Fri, 22 Sep 2023 15:51:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8ty2r7su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNZzgs+9qs5yfuQkad2qKOIMVyhA5GU6j3WXIFfroOH6wF1f4X7jAgK+ozI68cyd+dha5Q8+75f+PefHTpMiA2RDUhtm8E0i0U/ZZjK8yjwt56uupjgfjV+FwTPL5rQRtcjz4LSv+dAnJSc3xKWI5lCnf1j4egiJMI93kt/yySPh5JU0n3khDV6EZBqW9o9TRrYHmzefrpfYgbbWNmmwb9HVGREv9Ffi+FZCGqXLlmJioaZivHEbHuGMo7alx1pGZr35OjvIVZYaj+0dH3gIdvlGcu2u5k8ANbHFRHBnAEPwTYhq8+eRnes9410lro6YPAvnqTjY8mkpEv49MHibgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG/J14pSp+cVxbRvtu0ZpaJRJMA4DG3U5wIOlmPpQy4=;
 b=hB3PogvBNsPTgANENIp3fSZHCoPx86vnHOOzPs47MR04+XLRecCUGgLDgiJpx4QxfdPUZwJQ1b18NmKZwjCk3yiDJQq06R3NMMcuRc0IWLwS/g5cAnHoLgipPakv0xRKu4k73JwvMCYeao2rMf1IZqAisaokkXNSpTnTNUR4/ImWSkQr7kv0/hGBM2UukInataWOqKX+UlgqbfW4zP1vFJ9A6wOQX0Wz3QTlsnxf4h8pGWVnbabtojwfxseBMPxd8fqjXj+UCsIo7eDc4zJlM29KtVRUkmuYD2Wut9drH7nPzLBerMN+oEknde4vsn+w2L4ZdePxdPuIfe5Mx++atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG/J14pSp+cVxbRvtu0ZpaJRJMA4DG3U5wIOlmPpQy4=;
 b=bXf1VB7ewUYSrRaYaRBfLfnklqdeJuu3eC1IAqILxamuyomwzAJgXvcOcjyvN2XCEOIBhO974Hk43T1/uqWPLTdLJs5Ox4Gp9dtRjxy2RjPl64JSG+XopGkuyVElUIqf0boYoipEDZvMRhnTczmyIwhTTPVQwV4fCgpUlkoTFPc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 15:50:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:50:58 +0000
Message-ID: <a7f4e4db-37a5-3685-4621-99b05343a864@oracle.com>
Date:   Fri, 22 Sep 2023 23:50:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] btrfs/400: new test for simple quotas
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1688600422.git.boris@bur.io>
 <9df2554d5e427e47290a10cbfccf20305472c958.1688600422.git.boris@bur.io>
 <9d0abdf8-35cb-ace1-117d-dc45e7f13964@oracle.com>
In-Reply-To: <9d0abdf8-35cb-ace1-117d-dc45e7f13964@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 46971eda-3475-449b-6ed0-08dbbb83b6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVdfs5cMM69GgtIllBf5g0piHMUZRYtDiRf2/8TxtPJ/fixyXYM5XyWMFioU2paEBjhCYyXnJlFUqFU8Oseo7XSA9LOZSsKMavm5Aho/C6ZrbwYoeSVaJPYn/es4IePYzqa/THJzlyG37SW0v3Fi216Dt0ZGAzML0tpXx1fRMXsLVLemS5etxWXHqKPzDtLDNTpmefAk/GgvWQLDcMYHowmHl1mheX6JFbi9ZUUJ3nm2G8g52I80jarjQ0MfwgorNsHnHzbM5Bs6VgrX6w05HNp0/nPo3yv/QCRrYGfa/JKUloN0Ft79LoQARTzKTIaf1pjhjkPwisakGqpevi7zS1IpyHfFIKrXHkIPaJFOzlXswWPkuojaPJZ2Vblot3w+njfkL12FgbKPiiQeO2apbaP1h4z6KAQ/8St54X2wi9coyw8MUF7IAhks4jIUfArMCeQK04TijedGMXTBXJ+gOCLczrbbjGOPwSVs/kBCzqEnTjGDe5tbStp28g3hz4WlfY7XWkwpDwD9Bi9i3uVidMirR+bCa5yUfXHL7DDm3qz0hHdn74+/Dpq2apvMs2Ud2yDV8TKXsoKgSsD40KLDBsl3AlShfE4OyF6TN5ZlJd6B+UQ4hyaVvJKj7/E86MvY/dwkXYnhvnd1JnyRe93FAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(8676002)(6486002)(44832011)(53546011)(38100700002)(478600001)(2906002)(66556008)(316002)(6506007)(66476007)(66946007)(2616005)(41300700001)(31696002)(5660300002)(26005)(83380400001)(6512007)(8936002)(86362001)(6666004)(15650500001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZoYUNtZmlFeXBqSDdKS0sxUW1yQ2Fselc3dVVENUt3OS9QNmU5amZYa3V0?=
 =?utf-8?B?czdmaXhUNkN1SkpRTFhXdDVESkJLZmZIdlNRZE5OdUFvZXlzUWJYdmJuMVNC?=
 =?utf-8?B?c090TkJwK1pIWG5zWlFqcGxiUTJucmJpd3pSNTJVLy9RbU1ERk1ZSWEwOU5F?=
 =?utf-8?B?YkkwYndjMGM5VnlJYXZqc2tvTHA2dXNoaVpxOS92cjZ1bUhXSnZuZnRxRllW?=
 =?utf-8?B?VjZKTXdKTWdxM1RsVFJuK1cyTnNJN0U2U2RpKzdYSStxcG5rcTd4TnB5eFY2?=
 =?utf-8?B?RDlzaTl4eTNUbjRoNXhmbU03aGMrUHF5dm9uZHh1Q0E2SDhicFJkY3NkRjNx?=
 =?utf-8?B?N3RkZSthNnVlSWZKZEU5d1dEdmgxNitBNzVFRWtQQ2RqSFF4ZFZNRE90Zko3?=
 =?utf-8?B?WWhJeFhPS0piN3ZZNy9QaS9YSFFoQWxJQngxSTVtczRSb2NGb0hoVWtMaEh3?=
 =?utf-8?B?MmtjYzNvMEhmd0hzbGRtNjdpTHFWLzRBa3JlWTNGMHZzUWpRZjZlNDE0b2h6?=
 =?utf-8?B?Q2dabFcybWQ0VWNZb2pMeStST3dVa1lndllnSVRjUUh6TnVPbXNTVldXVUtk?=
 =?utf-8?B?OUhMakFETHpNamdSbTFIOHIzTDdHZzl2WXZ2L2R3ODdWRStlUW9naEFDdHpG?=
 =?utf-8?B?TW1Fd2p1RHJqb3BLbVErSmowKzQ1aE5aVU5BL0RBVXg4WnhQaDlrSytSMjU2?=
 =?utf-8?B?cGhJN1VEWjQ4Y3pzTlBiWm1nQlNLUnpYSHIxMWNGYkRVeEprK04xbHJqamwr?=
 =?utf-8?B?TWpTUVg3NGlRWUFBRW5WcUNOUHgzWTREQ0JKYWdhRmlWT1Z3WmF5T09oZ3Rx?=
 =?utf-8?B?Rk9nYXNud2dNeXpsM1dVTmlLWFA2cjkvZE1xZWdlaXpwbjROMlhxZW1YODdr?=
 =?utf-8?B?UUFoMGFscjZhOXRWSzVlNm43eGo5aHMrM1FkU2tRZDk3UnNUQWIwRFVuMStD?=
 =?utf-8?B?enV2QzZRMEd5VFYySjd1ZGlsaFFWVUNka1FqU2N2VG1wTGVBUW96WlhhT1cw?=
 =?utf-8?B?ckFnSmEwaFZXb3RIN2VWaWIydHc1Nk4rVHhaS24xVzBlRXZqSlhIci9neWJ5?=
 =?utf-8?B?U2w1ZWZrQUQxUXNKcTFzaHRDTWNHdWRhM0VRYzVPMFhzUWdsT2xmb0VlMGpr?=
 =?utf-8?B?ejFIMXdPVjlWRVNFYmlhTy8zYVJmU1RrZzY4Zkt0K1VSUGlvK3VXUXhEM0RH?=
 =?utf-8?B?dlVOZUdCcXpxV09GS3M5TFVUaXpoNUdpUDJvNjV6R0xkUEQzYk5Zbm9Mc3oz?=
 =?utf-8?B?ajBVSEFHNUdja1V6dDhWM2xwQUFjb1VPSWdoZnZYRWRqYTgyTnRZamRvMzlZ?=
 =?utf-8?B?UW9aOFdqSTNZQi9ZeEg5akVhd3pCOHBibzZsNXo4VXNsZFdPSGlXYXRYdktj?=
 =?utf-8?B?KzB2NUpQVXFNTkc5NHVJRDRCbnVjMGVkcEZ0aWFJb3RNZDJheW1rM1hsYW1S?=
 =?utf-8?B?dzJKOUEzbmVyRmIrYkVPWkFxZHFDdzVvdGpaSjBmVlVrUEFjMHFxTXVMODZi?=
 =?utf-8?B?WXQ4SVRrdEJRdjRtVGFZSTBpWGdRMFZQajRIRVM3KzFKTjVuME10QXVxNHla?=
 =?utf-8?B?OXFTUFc0ZnpCY0VZbUxhajlzcG9GdTFLQnB6MS9BYkQzeTFwMWFhZmtFMDRk?=
 =?utf-8?B?eVpaR2hLdVZNTmtQcTd0Vno5RmZ3STRjZFgwVTljd3Btbi91KzFMMFhjbkZL?=
 =?utf-8?B?Tll2U3RDSUdsT3VwYSt3KzZic1NRQytRM0d6K0M2eGVaUlZmSERGNE1CbWdr?=
 =?utf-8?B?Sit5NDFxTFRTU3dndWwrQ3FtUFlVMVZ5UkhwdExPMTFDVkwxS3pRbHBERW1y?=
 =?utf-8?B?Y1BTUEdFbE1sYWN1YUtJYkgxTDhjZHM2d3hjVVU3bXRCejEyZWFtckJveU9H?=
 =?utf-8?B?cldUdG1seFN4cGRtdncyYmNZODVBelRJbHVOUHpBZ1MrMUtGY3c3TVRyT1Jo?=
 =?utf-8?B?SFZvOXlqQjc5bkIrTURDY2VNMmw2YkRsRGlNMHlsRTBidlRJbTB5V2dMYmxZ?=
 =?utf-8?B?SHpOeDRLVjJoZk1ZQkdHLzQ0NUxIeTdYTEhta3lvZ2tCZ2w1aWNCaSt4NFBX?=
 =?utf-8?B?TS9LV0pvcTJZQVU1aXpLelBFQis0Ti9mVXFITmQrZHpIaHhadzdUMndUYW5t?=
 =?utf-8?B?NVNFR29OOCt3K3o4WFRDeHRqOHQxR2F3K0lLV1dTRmx4emN0aGJ2M25YWjRO?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LRP3m7XicW3J/Z5COSJCIdDW9uzh7uDgd9cp5vg+6nMyYkJTmoSGYtdq4TQRo7GIuFPZtyVVwNV4YhpW+9t1ot10eK+B5tSdpz/CuhX1ErKe0IJYgI/e2CVSk1dXySQTIJUKhHOew7QtwS1ltsWqKCP6VDNBZJXVgAVsQmpCubJIzB7oCGirxypr186sDv0UmwhQxmvpfzO2lkyV5bQcjPlOggnhOaHe47X2Ffu0S6QxJR6yUDhC2pU4aQdCvhVoSWMIlFoSC5dDSQZEovC+6YNeYVy68tED6dI0VstezcC3D4vK0eB+AbBtGqU2V3i7E83lJuOTg7zmNrnKDiSrC+Pizl33v3cNXgjbkgpbpneiT3aoxA/hlNUUENqsMJUw8GYA7a6WmDGyjuSK5YvG90y3ce9Ca13ubnyFkiPAXxQCLURFaD5HxF0ML87iVXpca0bFdNlXqWVG6m3t/rzYTHApHG8A5PxFGDUQfD2QS8ZuyU9dX1LjOcZqOrSgdunq31+wL4JG6GKbUViiPKHIt5ad/GYAR7U1V4VrXBNyhD8/hdSyMEkWaNQegWP6K63KqioKhFoPq5g9hofm/MW2aFOB98KWATy94D6LlBOAaNpF/csok7Hzp/9Mj8FpjvslM5oPhE3bcNImW+GjvdbSX8xJ6b+IGvQ06GJvx6THuOeGCkZWqV62+KuHmqdwoM/Stbh/5uPC/wyTRei3T6ymsq90DlFOo79YBzTGSXMlBBcsQXz7XHisIYyDpfNPCzGFYb4xpw32aONPl25mejRRFyWhS5d8emBiUa/LRekAZd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46971eda-3475-449b-6ed0-08dbbb83b6b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:50:58.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uurPFl1m2UYNHgi2ex1GZ24Xuu3VItwy9ghJN+DRgMBS9msuIf4KindqHsUePqEHZZDmdUyQnYnLd29KTDQEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220136
X-Proofpoint-GUID: 7MWZQP0MELJSvS3ud5uhASJnArY_DwaG
X-Proofpoint-ORIG-GUID: 7MWZQP0MELJSvS3ud5uhASJnArY_DwaG
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/09/2023 23:40, Anand Jain wrote:
> 
> 
> 
> 
> 
> On 06/07/2023 07:42, Boris Burkov wrote:
>> Test some interesting basic and edge cases of simple quotas.
>>
>> To some extent, this is redundant with the alternate testing strategy of
>> using MKFS_OPTIONS to enable simple quotas, running the full suite and
>> relying on kernel warnings and fsck to surface issues.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>>   tests/btrfs/400     | 439 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/400.out |   2 +
>>   2 files changed, 441 insertions(+)
>>   create mode 100755 tests/btrfs/400
>>   create mode 100644 tests/btrfs/400.out
>>
>> diff --git a/tests/btrfs/400 b/tests/btrfs/400
>> new file mode 100755
>> index 000000000..c3548d42e
>> --- /dev/null
>> +++ b/tests/btrfs/400
>> @@ -0,0 +1,439 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test 400
>> +#
>> +# Test common btrfs simple quotas scenarios involving sharing extents 
>> and
>> +# removing them in various orders.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick qgroup copy_range snapshot
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
> 
> 
> I don't see any prerequisite checking and call of notrun() on the
> systems without the kernel or progs simple-quota support. Is it not
> required?
> 

_require_scratch_qgroup() in patch 2/5 does that; So at this patch,
we are expecting the testcase to run fine on both with and without
kernel and progs simple quota patches.

Thanks, Anand


> 
>> +
>> +SUBV=$SCRATCH_MNT/subv
>> +NESTED=$SCRATCH_MNT/subv/nested
>> +SNAP=$SCRATCH_MNT/snap
>> +K=1024
>> +M=$(($K * $K))
>> +NR_FILL=1024
>> +FILL_SZ=$((8 * $K))
>> +TOTAL_FILL=$(($NR_FILL * $FILL_SZ))
>> +EB_SZ=$((16 * $K))
>> +EXT_SZ=$((128 * M))
>> +LIMIT_NR=8
>> +LIMIT=$(($EXT_SZ * $LIMIT_NR))
> 
> Style consistency requires the use of lowercase for test local
> variables.
> 
> 
>> +
>> +prepare()
>> +{
>> +    echo "preparing" > /dev/kmsg
> 
> 
>   Please use $seqres.full or stdout for debugging purpose.
> 
> 
>> +    _scratch_mkfs >> $seqres.full
>> +    _scratch_mount
>> +    enable_quota "s"
>> +    $BTRFS_UTIL_PROG subvolume create $SUBV >> $seqres.full
>> +    set_subvol_limit 256 $LIMIT
>> +    check_subvol_usage 256 0
>> +
>> +    echo "filling" > /dev/kmsg
>> +    # Create a bunch of little filler files to generate several 
>> levels in
>> +    # the btree, to make snapshotting sharing scenarios complex enough.
>> +    $FIO_PROG --name=filler --directory=$SUBV --rw=randwrite 
>> --nrfiles=$NR_FILL --filesize=$FILL_SZ >/dev/null 2>&1
>> +    echo "filled" > /dev/kmsg
>> +    check_subvol_usage 256 $TOTAL_FILL
>> +
>> +    # Create a single file whose extents we will explicitly 
>> share/unshare.
>> +    do_write $SUBV/f $EXT_SZ
>> +    check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
>> +    echo "prepared" > /dev/kmsg
>> +}
>> +
> 
> 
> 
>> +
>> +echo "Silence is golden"
> 
> We can have the echo part, like (echo 'prepared' > /dev/kmsg), directed
> to stdout; this will be useful for verification and debugging as well.
> 
> 
> Thanks, Anand
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/400.out b/tests/btrfs/400.out
>> new file mode 100644
>> index 000000000..c940c6206
>> --- /dev/null
>> +++ b/tests/btrfs/400.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 400
>> +Silence is golden
> 

