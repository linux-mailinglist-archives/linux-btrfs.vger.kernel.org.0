Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71D7B3FB9
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Sep 2023 11:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjI3Jh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Sep 2023 05:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjI3Jh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Sep 2023 05:37:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD0DDD;
        Sat, 30 Sep 2023 02:37:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38U8QxLD008680;
        Sat, 30 Sep 2023 09:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iCQQZRkP6/E+Ujcz3VuhzJUA++1c3ciZRrmWNmndDxE=;
 b=kiFavtL7ApzpC9hjSMAEpSiddT/vakPge/HRyIYyhdwcU5z0fVkkYe5Z5NMFzLaKzq9G
 n5rdwwjM3Sk9IPLwZC3rzOUdjt8sfbiBEpoOwh3lag2aaJ/l+aeVIlIhnq9K5KKcmNOa
 Bg5R5KHEZxxl28I69CvSZ6LeTHNlgsDK2/U2y9WBox5Z0j1y8rXDWR0yaxIXiRONNMeR
 KYN6oet8oBE2IuOXoyWStfIfgtbJ3f6fFSwLjz70i3E+nd95T5q8xCz54b1LfmJbJT56
 V79jYyibVyjNyf2Rzr+u5iFnjzYDYYQuUadjK3n4njlDemBiXX9KEyhWBT7bArrQcArw qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea920b88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 09:37:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38U9NaD9000645;
        Sat, 30 Sep 2023 09:37:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea42kqcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Sep 2023 09:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyAA5PrQO3FjiMRKK4ZJLthenbbDPAd2wEj3G6xg1KJzwC9lRZeRZOTC4txyN74uVvus5n0DSK0CcAFJmwhteYVfgs4/QT3JpVOhjzx2nmhdSmc2pKHNNTxbVyEBs+zUtxYu7wDQQhgKVvwnF2o2w082IQM5lgHyAoeTUn7C8UsQq3QDaE0KbK71dPeHUlKFQgRQONHX63TGF1GrgydzsJfn0OVWGhNpxhxB6e+V1JKrU6BwtYgr3r2nUQLXT+BhwTJgRQgytACu0vMvgryx88YpE9Re6pSdtIW9oVFr5zVWKpSB9uPLceMrlDTwncVTQ625y0CN+gqCn7hun5M7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCQQZRkP6/E+Ujcz3VuhzJUA++1c3ciZRrmWNmndDxE=;
 b=hD3dvt/+l0PjN+c+eEo5jjJu0L+C2I0oWdN3hfpeMuB7wX7ZHddrnq48NFRTah33RFnAZfdQ7Rc9OYHqkkXLrvUwPSEX0APAksK4Kf/yJemJzJWcZ8JdQ/wiCsYoXquY60KvAJN01L/0AwKjxJlb1OvSFDdglUyYnuRi8Xiunlz0JatZOSulOw4bSlOk8bgCTcsXK6oVj/pO2eDYAklY4lpCaf9dsxhwoqlim7N0DZJ0aS7GVIzTi57gxOyGfk4EGOdjQJr0ZYW23J8V8QQ5A3+Hiz+vdGBEpO39vfi+6scX1T6T2cFvbIoayhPBaR6aZNqAlnuWxVjrZTSzmiz92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCQQZRkP6/E+Ujcz3VuhzJUA++1c3ciZRrmWNmndDxE=;
 b=osnV15GugT/eF4lsFC9HuaPAJQK4XILt6sdGX2PqKeRQqL54Gz9AABfGSJX58uyiErjU8D85DaLQn6E34bLIy6OIUCte99yTTNSnMzcXFJOG0lGMXtrpERZCo6vv9VLxuxQ0XLtgkW+oPp+XgMvYhgvih/z1VZbxhsRSpqUhsOU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sat, 30 Sep
 2023 09:37:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 09:37:48 +0000
Message-ID: <8b02f42f-fa63-5a73-5796-155e4db6b4a7@oracle.com>
Date:   Sat, 30 Sep 2023 17:37:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] btrfs: fix rescan helper
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <ea2c732f-68be-74b1-f05e-218ebaa2b359@oracle.com>
 <d51adc803f344fb0bb5e63243e94f94f287ac2c0.1696009118.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d51adc803f344fb0bb5e63243e94f94f287ac2c0.1696009118.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: e57e9fa3-f6ea-4caf-6f67-08dbc198dce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsUujwCcXZMd0exCGHE5FBpPnrX3X9iXCJURx9d6zVglBGA59qWzpMtGbhWCwqB3BtLqw9Cnn0tvA5Y9INSEyYrE+PzCPlo6RkuhVeQT3+Q/CHx1uZkutaxvo/Z0ZZydOaPEjJPaSdf+eHlpsd5P9VihHff9iPusesoXC3jvnwk+DgcTbhjaD5dKt0K5ldPJ4Pk0pbkxJh7RSsAomMJKms2+1BU2/IdBmJ3jK8rU4TP9GswynQgZhmHsfRtrjSV75edHbATYUEwEeLOtgayiRgTPWDbq/yCxrbs2lmgBkG/3uAtcAZGpS2jh2QwXaAux+iRw8OgCbSXcMj2n5uJkigJHEd83XUMEE5JqzToAZWOUMkfj0So/I7QGf+MaEe1TDRUCINTEkJXT/AjTEvpgk4KGZlM7ZCr0MdnwZd+usprCrD5KnBTdcvrsYcOwUIU5uEcA4rymiGQyCVYiMrYK6m5M/d7Mfqln3a1GKNl+R/DuHcf251QbwufLYjtCm5bj7z19zKWssAR+yGCLekzHMBmzuztJRVPmVnOMLAVdX2aM4q5YvPMbiZBQxgsKEYEy32tycXelQPAiVHqXkuS9qqNOuQrX0TZp5WdSN3Nou7oCp/puNrN1oT4riZg4x11vpgxV357vFrFmIOUtmrfHgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8676002)(31686004)(8936002)(26005)(44832011)(2906002)(41300700001)(478600001)(316002)(66476007)(5660300002)(66946007)(66556008)(6506007)(6666004)(6486002)(53546011)(6512007)(31696002)(2616005)(83380400001)(38100700002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEFZSXJMTG9kSEIwUUxzdUdCQzFFWWQ3MzFFQVExUWo3anB4dWk2ZjFIMVJn?=
 =?utf-8?B?di9lTVp5VVpGNmIrQld4cTgyaEJ2SlI1am5RVVp6TVhTMXpVeW1McXRlanh2?=
 =?utf-8?B?ajg3bWRMQWtNR1dRUk1UOU5PN3ZWQWR3NHk5ZGlLa3hVT3VPZWNIcUZpK3p0?=
 =?utf-8?B?dHV3UGo3U25aTDNOaENTdmVBTDhnaWw5WXZTcUlkeWhpQ01yc0VTQUVSdTVC?=
 =?utf-8?B?Z2VrZThMMHZYUUw0NEd1Kys1ZXRoZjZtbzFWVGVMOHRDRnUwOVhFZ2wveTJw?=
 =?utf-8?B?K1gzRGFLMUxONm5JSFJYcXBNaG9vVWgxdlYzN1lWOHJUazQ2c1ZmT1dYbTZT?=
 =?utf-8?B?V0dnZUQ0YkFsRmNTZHJqZzBwODYyb010blN2c3QrYThWU3pJaEhvQnlqa09s?=
 =?utf-8?B?Vnh5alcvbUVuV1EwWC9ndnp2VXlaQmFrQlF6NWpqam1uTStGaXlOenVoUTF4?=
 =?utf-8?B?Zmdvd0s4QVo2Mm1QN20ySENVdXdva29BQk1iYTBCeGdmZ1RpWktaUWZudk5Q?=
 =?utf-8?B?QTQzQy9TempFTGs4elJXZWdxYWFuY3Q0eTQwcTROamxwYUdkUHI2UzdKUHk0?=
 =?utf-8?B?S2dBOFpXZmVGdERxUVJYWjlVOHZtOGJucFpHOXJYWUxkay92RHVabTBUNXM5?=
 =?utf-8?B?YlZTbTZPeW1OWmFNNkZNVCtqMXB0VEVpWVMxMWlmTXR6cU0wNlYzYklHY1I3?=
 =?utf-8?B?WE5SV2o2WVN5RVIvREFiYmV4c285OEFuZlpoQytaeXJiNTUvZThZS1RwbGVu?=
 =?utf-8?B?UlJpOW9lN1ByQTErVlFQYVpxb0pqVm1KY2NINHFNK0JKNGZpR0VBZERqUFFK?=
 =?utf-8?B?K2RBV1BXZ0lEVVowRTZ2THNFMVhoRmdCSFFFMTRZUnNCUGd2RVdXOGR4bXB3?=
 =?utf-8?B?QXFIdFkydWo0dG9VTHczaE5EcVFpR2FGRDBKbTVzd2VJVlZJRWoyMm16anZj?=
 =?utf-8?B?bEpCdi8zajlsQVpzUkwrbTJVUnMrOGNxNHo0WW1hbTZWT3hJSElZeFZsdUpC?=
 =?utf-8?B?S0RHUmI4WnE2VXVkR2Z5SDg2cEhWbFAyKzRxeWF3VXR2THVnM3NMcjk5OGtw?=
 =?utf-8?B?SWpzNnpwVXhWd3FqNlRaYXNEdTZublNNS2oyVE53L3g1dXhNUXZpMkNzQ1Vp?=
 =?utf-8?B?eHBBRDEvakZMbGR3VVFic3g5enhBcElkUlNjOFlhRkRHZ1JCU3BNOEx2U1JY?=
 =?utf-8?B?aFZNTUR5RHN3eWQ1dzV3MGwzNkZzUkZ0VXY1YXRQSzBXcjJHQmdaYy85clo4?=
 =?utf-8?B?REZJaVN6blEyRFRJaDJYTDM1UDFZVUE2Uk9aYWsvbklETTdhUU5TeExRYmpu?=
 =?utf-8?B?YWUyMXp1Ky83MmtzYUdTc1RHSFpJYzFnVnN1eEs2aTU3QmxoMkYrTmljYzRy?=
 =?utf-8?B?SWFkODZ2NU1tdkpkZThQNTdTT3oyUnBYKzd6N3lMQzlHSFlQYjhTTWxMOWZT?=
 =?utf-8?B?MDBtbDU3NFliSERxZnY2Y2lvaDdqOE1XTGNNVkN5T3pHZzhQd1c3SmZIMy9P?=
 =?utf-8?B?OEhUSWZYMCt5M2R3amFqejF3VVpTMTgxUjdpV2F4WjNBd2ZuWFltN1hpeEtI?=
 =?utf-8?B?c2dWdHdpWTJJNk9EcWtDTzFHNUsrSUgxRUE1a3RkTUNhbHJsOHE2byszQlZ3?=
 =?utf-8?B?VWJRZUJnNkdkSU9NOEtIYW04R2VhVk5CbHgzOUVuai8yVTRRNzkwYW1ZNHJz?=
 =?utf-8?B?Y1AxK05MejlFenlFWkd0dlFJcldxVkVlS2FUWlFZQWNPMDBjbUxidVVrTUNy?=
 =?utf-8?B?V3VsOWtTR1h0MlFrY09iWjFPUXBCMHc2MENLSUlMdU5jeHVsNDJvZXFURUN1?=
 =?utf-8?B?UENZVCsvMHhkWHRxUmh4YUlPSG1zdTU1eFFFUWhyUXpQSGROaSs5YTNKc25K?=
 =?utf-8?B?RmVySXN0VHVjaHI4RkRvdnZSaGRUN0c3UEpWQk96Sm54TjRROXZuR1pXUHBW?=
 =?utf-8?B?RUtqRjVSQldEdngxZlp4ZlY1OENHdkNrSGo4K21ML2ZRYkJPWWxXU3lWZnVH?=
 =?utf-8?B?azQ5NmxDZEI5bXhrMmJ6RnRqa2dDRmxtM1BVVTI0dGhRVFgyOFR2M2IxK3N5?=
 =?utf-8?B?L1huU3ovNGYyQkZkdXBTbkZXNkdickFKSnFWUkd2ZTk1aS9VWS9LNlBpS2Nz?=
 =?utf-8?Q?WEyEb1HibDV0927FYBAnkMyBD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c1efRlioBU13+Uwoy92vEIlkmdQN4T7sx6iBx2/L77HiW2G0rN7QBv+AhVSUYGIwvNVADTKc9HTuICT5KdKQrBvWEgoMb97wTfe0ypvwG0yKstzxiciKxXb17Q4p/VtrXEjSwKg9ChZRqdtsQuKyVhTOUIKpFkDZ6NrS2b/DD9WT7+t85mxjzPtIpH6pbooj9FVNxzD3cngDsdCx3WMjr+vPqj3AFADOLYs6jRkTeOEQAzK4kDplAWCAN21942Lyc7Wl2WtpUguYMcTBgGhPEYtUtIcpnRTtTOlhxplvd8bfondOPJRUb834lJlCW0+qhZHLuhmnyikvYtc3KojZc147GibKHH7RHFOzvbaWh4iMBUO2sL3u6i0U55I5N9wnk763nkAxPbIyaGCqjjdGL7ob5C/Mm5KKTkOXUWI2TG09Z8F1uBHqZncihDmHxxmgu92iculbBeziFsR63ruimrR1+81l/XFYo85M4BrU9eCt0vGWd3RioNSZY5vBajGt3fy5vQf921WRFCbgd8RPrexYNVPhxgtDkJIE6XvlHY0Nxs12lVV5rF23/oD6UFW84PS5OXNfmfJYGdVmjs8FNGWKXVK0EBcgG5bn/5vqnzCAMDCAQWL5z48JdGQ9CVy1nF5ObT2mIuYyyfpVhJGX+bMDapWu8Kkk2EW09NR6de18MJE7ZyfYdGfVBs5AIRc+/Ystp+3Sd02rWrPLZ1ggc7fXoX12wnPRjHMITo4u6zqcdhWMbnEv7CNaCWVzbMNfcZIsCV34BYoMR6pagO6sUCk/gwsAUvBahFvMbgC1oK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e9fa3-f6ea-4caf-6f67-08dbc198dce9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 09:37:29.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZtNMS+53PItX4TqRN5dz7Nm4Ipyw+3Bzq7wUyNleMKszlr7Q6kJcrOhNWjSnQIbcHSbdPOWXGHTmrCYUxDnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_08,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309300077
X-Proofpoint-GUID: oAFsfAKVbFIBi5HYiYHQpLY-F5tq0V-D
X-Proofpoint-ORIG-GUID: oAFsfAKVbFIBi5HYiYHQpLY-F5tq0V-D
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/09/2023 01:43, Boris Burkov wrote:
> rescan -w silently handles the case where a rescan is already running.
> rescan -W works even in squota mode, so it is insufficient to implement
> the requires. Therefore, preface the rescan -w with rescan -W, which
> should reliably trigger a real rescan start.
> 
> This results in an extra log line reliably appearing in stdout, so also
> redirect the output to $seqres.full.
> 
> btrfs/022 and btrfs/057 now pass with and without mkfs -O squota.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   common/btrfs | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 34fa3a157..eff8e8386 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -724,7 +724,10 @@ _require_qgroup_rescan()
>   	_scratch_mkfs >>$seqres.full 2>&1
>   	_scratch_mount
>   	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> -	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT ||  _notrun "not able to run quota rescan"
> +	# Wait for the first rescan.
> +	$BTRFS_UTIL_PROG quota rescan -W $SCRATCH_MNT || _notrun "not able to wait on a quota rescan"
> +	# Make sure we can start a rescan.
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full || _notrun "not able to run quota rescan"
>   	_scratch_unmount
>   }
>   

Now updated.
Thanks, Anand
