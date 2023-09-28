Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289B37B11F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 07:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1FUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 01:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1FUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 01:20:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9272BF;
        Wed, 27 Sep 2023 22:19:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL66dh000492;
        Thu, 28 Sep 2023 05:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Hbb26xkuJargRwMMuEQJFQNNgyHsOsbRa8i141p6CIM=;
 b=bjMFvqH3bVeCark0NXgNIjacr8782UxgD7M312qMoYmcqmfuuqds+/JkFdtSQF/MGMAQ
 zuAQN1PnDS71uDCv9mEODAuzQsslacOsqbZtYc8F1wGVqZa58j+1TSrNvWfw7GoOPvy8
 2SYyf3ShZ0CikI+daeYJe4g06j7k0Fx8jTC2nD6ApfunSg6ST4H10hSPAnk+nmvBfRUq
 NLkwPUM0qH+xslNYksbQbDyrmb3XGlmtQQEknKmYZxvTyfQUqWtT6q0RJb/Wl6mHQIbK
 WchcAPOtW3PMawkNT072l6FvbHdeKl/gPkWTabvLwgHev83KVKvOMjYRTE7fSsX4VPiy jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc3amh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 05:19:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S3Uxh5017996;
        Thu, 28 Sep 2023 05:19:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pff16yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 05:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWBpD+/gkA0vDQoJZ3GlKC98RhPTigHFj5q3unoDtP4YVbd1oSGHXyY5beZ33BIprcuzmL3p1r+CntrZS4WVG78VDaf2kmIy0hbuRcYKnblOv3mrdDUlgZtL1YcBwb0W0YrlQuePjrAUu+1mUoJUEUIaRQu3DfQTIeT1rYGnxtpx9x+z/Z/1B6NDYgEWsB/f9gyBldVQvxBeTfk7TLuCGObeD3SWc57CY4tx/QSXsmJ1SIHA6hEotrzlYfFBJbXnLD2Pd3wA1yq/h3Di9JwT0gGkvAWaAb4pFk9OCPXuG/wyp4SyLVPZKCaYg6Nd9fFx4JAkPeBqtbrGhmw2Av+Yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbb26xkuJargRwMMuEQJFQNNgyHsOsbRa8i141p6CIM=;
 b=nei2OCMXgF/iCxszUexWWgSMt1iZqNWAZxReev4Y1AVxIoLPOtL6jxPHLqtm2xz8wV1vpSpZ1asCU4lwbFa8esIDHxiHy/F7OfIqFclqcXKUoBiOoMCWLj4r+hgaizqq+bvUqMbQVCO8H+KWFuiu0yg+0wImBk3zJ1y5U5Ildr/C+OwRfpH/pvCsr0AD80cWE3Z2XJl1hmZKvJqJKDb+LUlcOKP683X44ls7xZoanXcnh8GnwA11kviKyKlg1r9Ce+s0ENIVNEQRUckBYd6GD1MaqYMTereJ+SthlIPxgX+BQpnS8xakGlinnbi9PXveDbKJaItcvLtDAyv7q9hfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbb26xkuJargRwMMuEQJFQNNgyHsOsbRa8i141p6CIM=;
 b=VyQd7uxKdBIjz2ykLMQKeu6r3WCvMnI5DsnPx7G1sCpVc2RID2/tfIbLml1coa2ONBQ/l/xqBiAHpInEHKl2SBSC3JmflzFNV9rujvPcUQ0fT0vlQOwUMyahjfiKTlGiwt876Dc12GIXAQOGQEXIJ3GqKj37gaJdJX+UF3LxXzw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 05:19:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 05:19:50 +0000
Message-ID: <8bb7b134-a092-be52-63bf-d482f4b2f626@oracle.com>
Date:   Thu, 28 Sep 2023 13:19:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com
References: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
 <ZQO6lmjasMPY8wOQ@dread.disaster.area>
 <87f9bf67-f407-e0b5-c29a-825eb4712392@oracle.com>
 <ZQelaoVEWPPQ1SD/@dread.disaster.area>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ZQelaoVEWPPQ1SD/@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f957a31-d5d2-4e2d-abd1-08dbbfe289c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bBrKosh28wnHK0cNzhSmSrBynbalthaYqEfT/EpFcTdPoEnB4ARxdMxgDMrhK8C9KNRZ9jL/0gPtjpT2wfsL7k4Hv6SOWbOzBo4GRKJovyUK/O0vCByx/oUYYlpXXtXAQKnFV9WbKQBgJjSr3SMOVWhXsv+ETWbInBwdrrnLO41yZtFExVeZB1AM91h/kJup2abOPqUskYZ375SDGSSYyEXd0IzWlzJlk2FzRb0lYSuZ86bGPnSSlgcVyEZ8DF5YDwzZ/YKgIFAWwkmOxGvhafOeqm304FQqwN9rbe3fBjizXEWcsOI6grMzesYWeLXnBOZcFQ8c9QAXMYejAqAHw95KTRpjjLnp5Wp0cd/bltKMKLZixfQUy2QWz2PSqRysrNT4KBFdV41WN5fYnKedW8ltSCzM4f9H5NJsUlixGYsQHWtCTWlAwtwv+BR4Ue70IkKdAddY6Kwd9GVcHYLBxtPoUuUdd+TNIStQjK3bTWFBtwkBVR1C8cGwMcpdfhPLp6dk1dO+9r9HlHLHC1A1IcBmmJkeeziMjNx5mEEwDwRfpJHOC7HcUX+wcdt8llQp27Z/M1vLAsKGGAA+QL9W/L8ZmflRi7oCJ2xM6P2432y3wjPplprI4bYxmTUaj6CRJ5RQJb5/5/wWoZHz/lhONBgL/3X9/36eypOoQAZVQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(83380400001)(26005)(8936002)(41300700001)(44832011)(966005)(6916009)(66946007)(478600001)(66556008)(316002)(2616005)(53546011)(66476007)(2906002)(5660300002)(6486002)(6506007)(6666004)(6512007)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTJyZGVsdkhUS3hPalJHOGM4RGYrdGE1Y1YvZGludE9ZMXNmQWQ3dEs5TVVr?=
 =?utf-8?B?eEEwRzVuTXk3QjcrQytJQTZQajUrRFVhUDdXQnBiS1g5Q053UTJaZjBWLzc0?=
 =?utf-8?B?b016c1NWa1NNK05VVjNrbUlUZ2lvVjZXaHRJU2VueWNsRWVBMm1qNmRoMTV1?=
 =?utf-8?B?SGFsMmRPWmRkNWhJZGRscHJhazBUWTRuVEwybmZUYkFvZitTZ2wwUUhzWGtQ?=
 =?utf-8?B?djlaWlZieXZvWDNLelorbnVYU3o3TFJzMHhZQXlrdlRYbEE0Y2NSMGdtNlg4?=
 =?utf-8?B?TFU1OVp2SkN3NWt3ODJ0WWRVMWpPYWw4QWJUYUVpdW01TXp2T0F0aWJGUStZ?=
 =?utf-8?B?OWRXRUR1dDNnYUVXZENCSnZSS1NiV01Dc3N3N0dPN2tuMWNFbGVtcllUZUNP?=
 =?utf-8?B?SlpHTDhGUWw1cUhvM01LUkwwRHpJSmxRRDVieDVEZGgyL1dNZk9pR0gvSzgw?=
 =?utf-8?B?YVNjQzVmQkQ2RWhaeDk5Y2ZSWUpBUHFzUzduWG5sVlJxczVzTzhTZG9ncyta?=
 =?utf-8?B?amR1ZXAvcGVqWDZTOHpjT1lqSWxhRHQrdkNFcDNRRGNJOWRaOERia2JENmtX?=
 =?utf-8?B?akF0YWZIZDhqc01WTU9aMnNYZmVib1FURzdxMGw2QjdaWjcvNzFxRnROOGtC?=
 =?utf-8?B?dXN2WUNFTUZDV1VqT1JQSzRDeFUzMEpNOSt1OEVQSU5nSnhVU09LWitVMW5x?=
 =?utf-8?B?STFYR1JkNDI5bjFmdlA3eWk4Q2dqRmF2R1Y0UVVVOUNrZTJSdmpTeWxRZEF2?=
 =?utf-8?B?aDFDMWdJVXNmL1V4dGQvVG0wQk1NTDllY0hnbVFpc3pDQUdlbi9VTWIwUExp?=
 =?utf-8?B?Z1dLc0VkMTFmdDBTUk9CYU1CR2FjYlZiT2szRHEwbnY2aXkzMHVnZHNGQ2Iz?=
 =?utf-8?B?N3lWUnpnSmN3b0NmSG1LTExRT3hVdDc2QWNidEp2QlUyQVBWcmxxSFU0RVlU?=
 =?utf-8?B?a1FTdmZFT21LY2hxWGdXTU5mV3UzVnVrQmxxcGJnZEZmV1QrNmUyVEpjV2lz?=
 =?utf-8?B?TDgyS1ZvRVIrangzbXNRTmM1cEF0TVl3U1JZRE1SaHU1UWVIOGRNQlpyOVJF?=
 =?utf-8?B?Y1BKY2VmUjZ0T21PQlEvNFdmSHp3ZDlCdFphRFZoK3FFUG11K2hXQTJ4ekFa?=
 =?utf-8?B?Sk5PY3ZMdzNEbW9mNy9xM3VSWHJuelFxQ3RZZU9XQWVNdS94d2g1RjVwRGxt?=
 =?utf-8?B?anZLaGlLbjhmcUJISytMSlVtSTJ2Yjc0YnU5ZTNpMHA1Z3RHd2FqV3B1Zjlo?=
 =?utf-8?B?aDYxaEVMTFViSDZWTjl2am8wOEtjKzJaZUUvTUszTmRYZzNxUEQrUC9ycUpY?=
 =?utf-8?B?M2d2VUErZGI5cktBVnZMeWdJdUJaQjFodzZ2RGFYb3NOTFZWQVZxNDdlTWs1?=
 =?utf-8?B?R0Q3cG10UEk1ZVVLR3AyQzR4NGNpK29ERzhseTRvSGNnaklDYlNkeG9jZWpw?=
 =?utf-8?B?bUtOSVdPb2ZTQjJnN1M1WnVDVEd0OVJ0elcvcHNscEV5WVNkOHFiZzNkMUhH?=
 =?utf-8?B?Z1JMckJYb3BBclEyRXZaL0sxYWZjZDhMZHpJSk5sV1F6MzVLNnF0NmVvYms2?=
 =?utf-8?B?VmlLMVdLcWZwb1hDT3ljbTZIaWd3dGFCc2JQaDJLUWNqUTFWZU9oR29kN2Iy?=
 =?utf-8?B?eEpwOHZmcGhyczBVa0MzY3hlRzFvUXZ6Tkk5bEF1OW0rNEx2T0F1SXladE1R?=
 =?utf-8?B?NXJncm1naDFvT1F0TDMzZzhjOUs5S2hFMkcvTC9PRkVqSWZKSzI1V0RXM2x4?=
 =?utf-8?B?L3NnZGQwc09nbVI2TEZ0NXhvOW92TUhoUU1BUWdhZEpCMTE0WmkwVUx5d2tH?=
 =?utf-8?B?VWdOUDlzR0QyZUdOdVR1eDVVVlo0azJneVU0elh1NEJ4V3owanc5K3BGRFdX?=
 =?utf-8?B?bUZkWVJjMGNyT0VXKzl4ekFBaktScjNMaGZlZ0VHUk5FbythRmZ4OTBxRGRS?=
 =?utf-8?B?TU0ydFR0S0oxcWVoUWhmRlhKWFp2STJMV3owTDBqN2tUOG8wbHhiS2lzU2Fo?=
 =?utf-8?B?L09ITXRtdmVGeXkzR2pLL1NKVXE0dzBXVWtrV2M1RmtkYmIzRlBVOGUvZ2g4?=
 =?utf-8?B?c2FRczE3YlV5ZW9uSFRZUUxZL2M4ZkgzSi9sOHVrMTgvSjJwYklsRnZ3QlFL?=
 =?utf-8?B?WTNnbzhRQmYxMFArYkRKcW9RT3FoL2FteVQveGpDUFIwb0FBeHAwOHRFcXhG?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RmNAl3kM9H4lorOMrWq1XZWeaa2o4C4im4mNWJoOpc6LbcBcj6JKU3X6YDYGQVs0NY3LZjYGfrTdkGgN/O9Jozw63yCDp4ORZLOi/4xZ1sv7iJJG+oWpyVAitrL5tiaZrzYmVu3dmsdS1Js9T/gdOsqgtCWd0S95njdVf+bGrChoWWamW4fJc70ydcjllNZAoxdpyxp4MvGSwiTsHQCMCZ/5qFqxgV1IAP0I4QYHFTBH8Jiu7ROi8uu/Ebr1qteq72Pjo2kFJHxBC4Yg9GMrSOi/VPlDBrqpmIwujjPumE1ZUNk7WIFfzFuBvVg9jknPMs0ZTTDnhQ7vGkqY/RKn9GbqVzQ8Kb//ibaCWJvURupHE/aD1ZnilZcM1RUhwTuGe3GVNmSQZyQ1bzFr+1lbIpnRfvLekcm/iOVPoSHL4Ook2SIQUX8oqafklWP65gkF2rOJOA6+JCeo8SYMni/BvdaDMSVldo350YKXnH4clAWlDKpsJvtQbFjBHBKQ1a45uzStLIL2tyXZnJVpqRoLvULtKBugr/Gvw6ILlFx2quSRkC/kzG8D7NWSy/PeTmyTN+r76DgDZ8SVg76CUv4pEveSfrMxu3yEIaWZfW8dUt/kd7xvSPs4sF86fkvv4U2RiC4HSlQ9uHOP+7OXo7qLaUosBJou24ykD0zg5OSZ4lVvMYFTRuUQ4wzjFIPlm2z9LbKvY/sky/+c4yi66jW0Fh4/8Yl/mhawzdwvNBu3fdMBzDwb6Is2aU3gFbiHkVVAuM62Eb8axYBL0prAH1kvech5wxhzPEcrgH8LOtYb2vujn5CfCOWuooaN+adHR5viAXKvIpGPzXKl61LAKW2pTA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f957a31-d5d2-4e2d-abd1-08dbbfe289c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 05:19:50.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWfLqoWP7DpMcpmfeSDwAK/LIKFm028GcG/6DYG18GGRGA8IEB0OFdgni6VUqQzDXOOohwcnvpGS8mvDxXSGiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_02,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280045
X-Proofpoint-GUID: 7YkGo6m1T5qrp012VjqnEeya_jBpczVL
X-Proofpoint-ORIG-GUID: 7YkGo6m1T5qrp012VjqnEeya_jBpczVL
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18/09/2023 09:18, Dave Chinner wrote:
> On Sun, Sep 17, 2023 at 07:58:11PM +0800, Anand Jain wrote:
>>
>>> In general, we've put filesystem specific post-mkfs commands inside
>>> the filesystem specific mkfs function.
>>>
>>>
>>> See _scratch_mkfs_xfs() for example. If we want to test TB scale
>>> scratch filesystems without requiring ENOSPC tests to fill TBs of
>>> disk space, we set LARGE_SCRATCH_DEV. This causes the mkfs function
>>> to do the post-mkfs creation of a hidden file that consumes all but
>>> 50GB of space via fallocate (by calling _setup_large_xfs_fs()).
>>> Hence filesystem filling tests don't spend forever filling the
>>> filesystem, and no code outside of XFS specific functions need to
>>> care that this hidden file exists....
>>>
>>> Given that the use case here is to issue filesystem specific
>>> commands rather than generic setup commands needed for all
>>> filesystems, I think it would be better to encapsulate it inside the
>>> btrfs specific mkfs implementation....
>>>
>>
>>
>> IMO, making it configurable and generic would also benefit other
>> filesystems. For instance, the XFS filesystem could set it to
>> 'POST_MKFS_CMD="xfs_admin -p"' or something similar ?
> 
> That's basically no different to setting up the same filesystem
> config as using mkfs to do it. And a lot of the things that
> xfs_admin can change are always set on v5 format filesytsem and
> can't actually be modified. e.g. "-p" is such an option that is only
> ever added to old v4 filesystems, and even then it's been the mkfs
> default since 2013.
> 
> As it is, it can't easily be used for things like LARGE_SCRATCH_DEV,
> because that requires multiple operations to create and internal
> fstests knowledge that large devices are being used.
> 
>> The design choice here is to create an open and configurable command
>> variable. This is because we have several commands and options that
>> we need to test, and it wouldn't be practical to hardcode them.
> 
> I'm not suggesting that you hard code them. I'm just saying that for
> filesystem specific post-mkfs changes prior to mounting the
> filesytsem fo rthe first time, the code should be located in the
> filesytsem specific mkfs functions. You *must* be doing filesystem
> specific things here because the filesystem hasn't been mounted, and
> that greatly limits the generic things one can do with such a
> command....
>  > That is, you can still use environment variables to specify the
> -optional- post mkfs changes you want to test, but doing it from the
> internal _scratch_mkfs_$FSTYP() function allows the implementation
> to be specifically customised to whatever sort of complex operations
> you need to perform for that filesystem type without needing to care
> how that may impact other filesystems....
> 


These changes have been implemented in the v2 that was sent out. Please 
review and appreciate any comments you may have.

https://lore.kernel.org/linux-btrfs/dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com/T/#u

Thanks, Anand

> Cheers,
> 
> Dave.
