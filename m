Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851497BDBAD
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbjJIMYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376404AbjJIMXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 08:23:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C088E;
        Mon,  9 Oct 2023 05:23:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399Br4KZ031929;
        Mon, 9 Oct 2023 12:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ibNeYJvLMwkLoMIoaVMuXHamdKhPAT5V9EJd8HldgRM=;
 b=RJsaCLC/PHgcDpCgYNN/IMy23rvdQEj/ac8OQOdriT3QDk3v1VvZfu6COGJXAJSi8VQq
 wFDaJuoHRn583C+VuBqYA6GNP3riW3mxrwwjjHDx2fORqNwFKq/aO6oDXn7HjCrRpaR6
 eHFRnQGhYHEMP2VdIIb1AzkpoeW0jld3hcJ3oMT613GBgHQLN6nFduKFi4SCxyWkjsUw
 svg2k36j+DGWoD5HZ6oxA0n3R0F7V6iQpAKVOtKoMbiGe3+d6zubIODtUsjJf6UBTzwY
 jnGT6mtxFjGv6j46efUPkEBmP4/O1mreSuOpismiDxyATRKQqP2VHHtusq8T72qiE3Mq 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu2jp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:23:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399Au88X016404;
        Mon, 9 Oct 2023 12:23:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws4y9bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 12:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adz0A+eWdlQsYSOInJNsNiDhqRdHtK9wTzfhT5FW1JJZJBDCGSvwHAQjC8tu3HDNDyx9G03DbVmwA/dhE0CJYJJydRQvr70h1EyPaigThH52jM3nZ+CxQdNTX/AizrqJEI6B8dW9e/VPW2sXrlDIv2p/W+UI/Vsot7s6BtVMUArb81G0SbV8Zwe5Avk4SZgzQI2scctPyrxEjtfCEP+l4hoIZT8GCE4fLYTTeRQWLLy8siPQV/QacL7VThn3uFSQGP8TXLuX+dIiXVUTei50DXhv1+w/C0ONLq9MhOugSo71+yDFRfwuxTwAL6c6kgWRQaE/i42IduXQYZX3mMjG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibNeYJvLMwkLoMIoaVMuXHamdKhPAT5V9EJd8HldgRM=;
 b=CyH18buwyygnfO4QCDNTYtQKGlfZ57rvriY+fHtLFJIxG57Ir4wdN/Y3z8Gb8ENwqL82qpS890YO/V9CgYc84ZMDiLD+IbQyxp8TO+ejZL94W7V8EbCj6BzfZKPOgLuXY9RNsBMPDmZAwLOl5fCcia//ary524plP3jjEUp9IBj0AdiISFglj/yDwiiVNG+L/PDxgdfW7YT3uoY974unq3kl6VyDa5h1CLNi5LOomrDoxyrz7ooowGNeRGPPIsLEdAI9KlwyrzupLp9VAHy/eoKMy2a2cJYqiHZaiWN5DGKKlocyPLn9j1WCLgwAIl4KJoPME6VB7nkkfx/N1S33Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNeYJvLMwkLoMIoaVMuXHamdKhPAT5V9EJd8HldgRM=;
 b=nErgwIwaMcJBmvZy+Vw6K1pZLhH9EzYVVWyVPK9WP0fq5+IcS66yNYgZSHpcGvN384WC/javOu4flrPkuEO9dek1QcXlBjK8l6KvZaZ9s/oFp8vLu0FZnU9k6ydCX/8PuSRslFeZsY2OVs4rTScwPwaU1eIAUv7CBzkPiIQlxqs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 12:23:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 12:23:39 +0000
Message-ID: <0d0bd43f-22e7-4ff7-8afb-5aeb3c9a37cf@oracle.com>
Date:   Mon, 9 Oct 2023 17:53:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
 <20231006060932.GD21283@frogsfrogsfrogs>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231006060932.GD21283@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f1be14-ecc4-4d59-9bec-08dbc8c29175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttC5ftkmq2sgLm5hkuaAXsxSMYEcd6QnNJveiB7OS782m6jv2LcFyAkSMj1TU5SrOLi94DbxiWwaL0dT6Qob+RlDpwADwDpsyT01mMCxjFKwU7FV1W7bnwNIG2r/SpMj9BwqQqR/td0mK6FsLxEFtFiBcDN95uiI3tRIIODrs+2I291vwL96XZkCo1aKoMh3fMQeHOkt3xD0HLquKisGaGLTmQBRaQW4l50ZdavffniNRu4ZrVb2nCfS4fpAK+VaVajlgfa+rMT+5gKPEjnuwjXD4vwso2/1zoSCubFY+GTZythDDnjoN/UqGuIHKzn+flEEXTxfjBIQ/OgZagIe2OC/OsbjAL96of4Sh7v554nc5dMllPyr0uYpAZZxU6TVPnaVgYp6dG5tcZUXrDE/FeC7yKAkTwqt2ArzpXIFTTC6Iq4Uu7s09qb5xJB3zDEF9eUB0F7rKpbWP4aqOqaBhb7vCYvwYHZc830z9wnR2M2ONrD+flGdTfTtbR6qeiX4SzDZsg5HS4UPbwYMOzvy0FqgopUOQ66lS3VXLlKVi8S26pRB6z9rQhnOa5tZVpkqOdRMsDOpBi/upGQ149q7Q6OdCmO4mrJPGyKbVRyBMcO8eYd0e5wLoUKOXIWqzG7EK8i9y5uzcAS3y/MOI5/nDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(31686004)(2906002)(6512007)(478600001)(6486002)(44832011)(41300700001)(8936002)(5660300002)(4326008)(8676002)(6506007)(6666004)(83380400001)(2616005)(66556008)(66476007)(110136005)(66946007)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJjZTZoMW1JQzlFcXdHYWs1OGh3U2VrVGNMOHFzb08zUEZLYjlTV3FQMUtv?=
 =?utf-8?B?R25xWkJCbU9iVGpDaVlxZi9ydXVGZy82MFlVVmJPREVmWmNQQWhGenlpeWdl?=
 =?utf-8?B?YlB5MzdzTkdRdDJBYjdIOU1YU0tFVUdOMmJkM0ZiNkl1OXhFRDR3bDlVVmdi?=
 =?utf-8?B?VGRxc01ZbHBNVW9NcmZvWG5ySW9VaThMS04zQ1JaNUFReXpRZjJpaVZkdmR6?=
 =?utf-8?B?QjVYdTZyVVFybTJEb3NBdFBaTlFlY0J2VEJocEs3SUMrQ2NFUnZ3UlpxUnBm?=
 =?utf-8?B?QTlsUmV2OEVkVU1OV0tndnZXQ2xCb3RNNUQzT1NXYUlxK2c2bk5xRnJWRCtK?=
 =?utf-8?B?bFJMcVVBNTVqOVExLytFRStoK1BsdktKMHBxK2c0VlQxaXJIZmJQRUE1TllG?=
 =?utf-8?B?LzFaTndCcVBxZ1ZpWHN5RFdzNnlIZGdQSEV6dTN1VE9HY01PekJzSmRyS0V6?=
 =?utf-8?B?OWNZWjRnaFY4bGVMTlJzUXk5L2ljUG10UjJxb1VmdlorWXBFSnlJdzRab21k?=
 =?utf-8?B?OVN1eXhoUnhSbXY4RUVoRVVjWUE0aTlGR0pUeGZWOW40SDlvMDZqSUoxMHhv?=
 =?utf-8?B?VzRHMjBzRTJMakV5SU5XTDJ2VmdwOEh3cThSS05kV1AvOGFwMFN2TjJBWFUr?=
 =?utf-8?B?UjhiNFBVZU5xK2FGT2RqbTFzcHAzUllCRkxoNE9mMkZTcnpWZkpraDlBbTRn?=
 =?utf-8?B?cHRLUUhiZCsxaldia0RVQUswVHh0a1BxOXcxOUkxSDdEVlFqSjQrTEFkN0VR?=
 =?utf-8?B?ZUZvSnhlRnZoRjBhNm01VkpuN1V4WEh4cDdIRTByL1Q5KzVEVjRxaWVKdklr?=
 =?utf-8?B?eExRcStoSXI2bVhyclc5MC9ueTBTYmluS3dDZWRWM00wbWlDR2cwVXp4Vmlx?=
 =?utf-8?B?bUt4NXAraUozLzJWdVNiTzdPYWI5UWs5SzRhVW1GZXg1OE5maWFZYllFTEFE?=
 =?utf-8?B?Z0RCM2RTTEFGUTdQRkZPVnpFLzA5dTI0bjRvQnYzM1praFN0RUdEVVZwZDVI?=
 =?utf-8?B?bnlFV1o1NVBZWlhFRU5XZVArKzVhUk5FUDY4M0RDSjQ4a2JkcWIvcHFNVHBK?=
 =?utf-8?B?Q3NHVVpFWUc4SlhsUlptQ3E2VHNWeVNOL29Scy9rT1habnBaTTBNOUczVE44?=
 =?utf-8?B?anRCUnNsQjFMZ1J6MUNpeVdHWmdiR1pibi8vOHhKZkdMWG1LSzBuRU1nMFlH?=
 =?utf-8?B?aFhpSG1rdUJzT0xicVd2VXllT01sYmhXOThqcHJTK1ErUTFpRUh0dEk2bmJP?=
 =?utf-8?B?WG5Jc0NjendwRktkRkxHc0hhUGxkVlR5MjJYYytXVHRGWXFGTE5lMzVCSUI5?=
 =?utf-8?B?VE5penNkWnRSSy9iZWFrNzQ4WjI2dGRhcDlTK0tTRUdRYlBLT0xxU2V2TDlp?=
 =?utf-8?B?RmtKcld6bGRMeEc3MW1nVDJXUXFSZTNWU3dKaXppcWR3Q0dhOWhWbDhOMUo3?=
 =?utf-8?B?YllTU0o2eHdZdWliZEM3UUNMcStyWDMyQlhGclZPVjd4aE0rNktsK2U3MEdQ?=
 =?utf-8?B?Tk9DZUU1THBzaXUzZzAvVTRodkNRNkIrU0FFR3FHTVRTR0Y5RFN3KzJPMXh1?=
 =?utf-8?B?aUpZZGMzM21LN0VlWllqZ1lkd09kcTNFbnlmTGFVU3FFN3BqZGtNNGszcFZJ?=
 =?utf-8?B?K05lNTN2UzU2dEl2VHZqN1Y5bmNmSVRJV1NpWFZyamlMdEx0V2lCU3E4RXli?=
 =?utf-8?B?ZlJxZTI1MDE5c25NZzhlNExvLzhxUklnQnBUQ1FXTVFSMHlpSElzVGEycUFa?=
 =?utf-8?B?cHQrSXBMelYrUWc4Z2JzVm5HK1lYcmxUWjV3dlFqOGhzb2pMdEpQWHhLLzdi?=
 =?utf-8?B?aVZQeWVTNklrdXBRazlTZWIrMklSZjllQnBLZitLK2EwWXU5NVhJbGE4QUpP?=
 =?utf-8?B?YkNkSmJSMHNlbmk0VmZNTzkvdjE5VFBwQnRaMUFmZDlwZW1aTXV0Vit5VlZy?=
 =?utf-8?B?N2NoTjBuQ1ZrNW5pRjR6THh6OW9yc2ZhK2p0TDhITFBROUw4MXVNVGd4TURG?=
 =?utf-8?B?UnhMSXN1dzBrWU50RkZja1ZSMVN5eXZMRFBRYkJDZFpwVDhLaVR0WTJyOVlU?=
 =?utf-8?B?ZHFObkxVdnBnV3FlUDdlV0kxUGw1aTlwOGkwTkhtMTlHSzNoWWhnOUh2NzFm?=
 =?utf-8?Q?s/nEfLROtCo8+j+WrgnGjVeyI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: glMJTuBWD5vaMF374pVZZdijHXKDE+jaBnpEbp0Rksh7Wu6kfzpKB7ztmK/ibnHV8T8W015t4x5ebWHsoiMyM7/tdVAYB631QgM9tL4bmNbDC+lfbK03iAShtHJgAXpxwTZtIl8QCTKfaCeucuyrccI/mKjuv4qco7VD2bYPfA62UMUXbQ0gWGrVLOgurWh3BJcZWbRjo6P6NZiyXaiLeTDvA7ItrumXGE5DTwDeG73uegTDzrwcHm0rnlbD7+9dM4fXjCIZtpFykoLbklyEjA0bOF/rh3xi2yPWRV+RZbEljMinjklgCI709chYipBIdOUJiAfVZE/bt4yp+Oo9YCwe1/2Ajr+2f6rBsahlkqAXNpIgkJTY6dXQwsremGbnlOnsBF4DBW4ZnKtr0I9F3JWxdrtC9b80yL/OTTnt3RtzCr1qPIXnz1e6PBnk5GNRUpewoi7tUtlByBmT07TWIXuI9sl+OF+j0Tw1/yEsNzWy5riaUYKMa70PDtPd+p3OnCCYxwhjO3ZyuoEzvVlEVIkNdwlPsBoumv4oHnyJ8ngkJy1+gFjMzgTiPRc0TRocUUxNAvFhYD4d1lfrTw8m8Bip6w9akkshsXIubMm4C2LZCy9W96g1+bj0XOhG2LZMd3vreUcr1wzMMGwspuWiN9Hyb6pEjB1gQm2c1Y3T8CPIvLr1zig1GHkZkNuwo7ODO8I8nJix0/JLepRW+uiWAtYQ9+4+BN5klydnXxgy3e9Iu03hzS6+gVvq8FBnx7RXV00wExYTffZCwr/mwvSSSIIYism2DvIwMZECrj3ODXgjGoI7X9OwQU/MSRkdSGImIfhxVS3gOfLLNllnQeIS3jAd96HjyiXiefb4kLJXbAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f1be14-ecc4-4d59-9bec-08dbc8c29175
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 12:23:39.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMcSex4Mq9K6j6g48LoG3YbRxE7K4mexr97TUgV5Xv+du5GqWojvcJCU9M81NqBXn9N1uSvN/fJrr3AoxOQDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090101
X-Proofpoint-GUID: lknPnZhod8ih47CEZnSvPJkYvV3Udpie
X-Proofpoint-ORIG-GUID: lknPnZhod8ih47CEZnSvPJkYvV3Udpie
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>>>> This patch introduces new configuration file parameters,
>>>>> POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
>>>>>
>>>>> Usage example:
>>>>>
>>>>>           POST_SCRATCH_MKFS_CMD="btrfstune -m"
>>>>>           POST_SCRATCH_POOL_MKFS_CMD="btrfstune -m"
>>>>
>>>> Can't we add extra options for mkfs.btrfs to support metadata uuid at
>>>> mkfs time?
>>>>
>>>> We already support quota and all other features, I think it would be
>>>> much easier to implement metadata_uuid inside mkfs.
>>>>
>>>> If this feature is only for metadata_uuid, then I really prefer to do it
>>>> inside mkfs.btrfs.
>>>
>>> Thanks for the comments.
>>>
>>> The use of btrfstune -m is just an example; any other command,
>>> function, or script can be assigned to the variable POST_SCRATCH_xx.
>>
>> The last time I tried something like this, I got strong objection from
>> some guy in the XFS community.
>>
>> Just good luck if you can have a better chance.
> 
> As another guy in the XFS community, I also don't understand why this
> can't be accomplished with a _scratch_mkfs_btrfs helper that runs the
> real mkfs tool and then tunes the resulting fs.  Is it significant for
> bug finding to be able to run an entire separate fstests config with
> this config?  Versus writing a targeted exerciser for the -m case? >
> Is there some reason why the exact command needs to be injected via
> environment variables?  Or, why can't mkfs.btrfs do whatever "btrfstune
> -m" does?
> 
> I suppose the problem there is that mkfs.btrfs won't itself create a
> filesystem with the metadata_uuid field that doesn't match the other
> uuid?

Thanks for the feedback. mkfs.btrfs might also include an option for
btrfstune -m operations during file system creation. While this may
not be the primary use case for mkfs.btrfs, it can be useful for
running fstests. If these changes are integrated, we can use
MKFS_OPTIONS to run the entire fstests suite, potentially making
this patch unnecessary. Let's see how it unfolds.

I made POST_MKFS_CMD configurable in the config file because we
don't have to patch fstests if we need to test with a different
operation post mkfs.

Thanks, Anand
