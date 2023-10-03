Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B77B5F80
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 05:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjJCDpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjJCDpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 23:45:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0472B7
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 20:45:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930j0Ii005851;
        Tue, 3 Oct 2023 03:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TvdBapBjrNeM7Q7/mNJ4HUwL4WX5hPMMuOnM6PQtKDc=;
 b=JO9fB7HXTyl5Nnt+qhJ6MKJGm14JrGUME9WVZzLzIKfmSNtjMXzSf5i2FkyuMfKSlXcG
 hVg3jIBuAqqIar6BlLyu4kISA+obAqfN82OaBB3GWPPfYYNbKGAuJCMSVKIUr8Z7p0Xx
 ADdfNegNNJcOGxiu3pgwCWlACcXG5JRkMM1z1Ae4K8p9b4F4xeTtt/aCsq1sGMWqHbxC
 lLn4Z2HAkLkNtYk8Ygxw3fR6/STHBcz1DLis4FrJc1MdFU5J9PAY/M39xmldcqylo2JB
 IvfpbCIa3EkqZmTmWC4oKgawJuZQ/ytaNgHblBA9sHWikcLfN8zGEVHd22kfH5CeEb06 FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqdush3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:45:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3932a1v4008651;
        Tue, 3 Oct 2023 03:45:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45w704-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 03:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6TwY2DZX8g7p6XfSoKqcCO9U8dk1Jumw+YC8ZeuAJ+nmmka2K79FotasYWzKQ5v24EIu80TVGrjiL2sKfey7mhOEfAJWbk4Vq9X6KFfbrEnA0jdm+8x4zI1R33SNAxbyGP3j5a3gqxTBGW+uf4pL0v+0b0j8LDV+4rfhzNfp8APr4oVb8BvsVaxHc2xy3UtYn4KhqCajKCmGxBzlST0OJ3kEBtZWpoMSU+6dcloGOl9qa7H+VOFA7Zf8ZI7QhorRtkTADMm7exhHEZ5xT0qJQWoiopnH3TJYvmSYiwyQM1Kfmqns1u4LkQPSUtahDrMjS9wX/bcno+s986jP/0E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvdBapBjrNeM7Q7/mNJ4HUwL4WX5hPMMuOnM6PQtKDc=;
 b=ao66TyzLYMT/u0TnKGA5DGI8WsXG2DJ9qbp0twaR0wcpv1SXNinpNQ+pGJiFqDn5sQW2qd5efUe647K80CgEwAwKuhE9Hubxau2XFzNmb3XAF8xNe0PAj0AdGf4kr3X3xuGt6+Z0jlLrnmNm6nVyDHPmuiQaGtNJ6K8NsUTwrmrvaf9N6AkKaotJkoUx82VUzTPV9uhJWPHJEk5xTSD3s9cwzo90edxS2Xpmb3/cSw+fcYp+hanrPMoMEf5yOdiOMSJZogD3+wH5Mo9JncB/EFM3gzlC5jquDOohcLMahAfISDYyAAcqrFS2/zW9yWB+9Yjq6s6HXUj6C9sduUTMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvdBapBjrNeM7Q7/mNJ4HUwL4WX5hPMMuOnM6PQtKDc=;
 b=cq1C8fKNyp/iUMouffBuYSfQtB/Ofl5BSrL5+YoiQ8HqI0fKmIeXJpL3S1Iil364QyWxLXQd5WOtWtLXg6lX8XEzwDWqVL3YTA0yLX+YVztk8NH+YeeuBA4Od1nTubYFiyzL2YeAdUPr5jZwdzUK9RXvt0WpkJFSz+YQZtY+4W0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 3 Oct
 2023 03:45:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 03:45:24 +0000
Message-ID: <8908a010-d5fd-b54a-45ac-7260b3767d7c@oracle.com>
Date:   Tue, 3 Oct 2023 11:45:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] btrfs-progs: add mkfs -P option for dev_uuid
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
References: <cover.1695861950.git.anand.jain@oracle.com>
 <e1bca34459f2f61fc2cf40a930b930b6f33d69a7.1695861950.git.anand.jain@oracle.com>
 <20231002152128.GR13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002152128.GR13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec37f79-abd4-4dc3-2463-08dbc3c32c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMmjTipGLnh6pLRF9Kg/Y9crGAjXa1wHNOCDh4bVmxf0y7pNDiuvmG0MvZgjA4peqxz6cYdc+MVo2HhCq1HfF/hjWV1WE0mSB27m3okzsCQdqZenAZlOsLYHGGzjAhWpGcCZKGNL7v2EzdlACb4/7jb9me2CxhQZdcRQfeKL6/aaM5HcctYw8EjTRCRfhoaK18fcgWMfZKjfkTKTRoDOfXfiTncYDeZPMUjXghIFLoqmsjxBgqVR3eMiPMuD506YiW70vtMk4IJXqZ5P9qrcwl8TcSGQflaMWrIw1cOwA9L3xt4ngyOoBMRUnBY0tuOG5+uN4n2/PBsSLKmkL7t7/CZermK1H0dB2DfOzDBnrcq3j+YKGGcpmqAaek3+shJRIe8gzXF5RJGjgrx6n6CpQ8/EXCs5/EBQR4cX4YHZHhp/h4h+MAL1zN33PwM6hYMXexF1VwgGm6fskiARxXtcI0vCR+5SXb5Skvrub0VmycrG22jGWV4H3buvXhhpVYMICrlHW1atec2bnPfVhuv5s6pani3gBsUZDMDg2tQfh1RlOJTg2HDepp/XqECpNd237euHafLZuVK3bfUj/LOYEYDp3RP9woglkO0398LIUErd9g5AdYmVURhJZTYHOmrdTCu6flmR43CIIw1mGYkGOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(41300700001)(6916009)(2616005)(86362001)(38100700002)(6512007)(66556008)(6666004)(26005)(6486002)(6506007)(478600001)(66476007)(5660300002)(8676002)(31696002)(558084003)(36756003)(316002)(2906002)(4326008)(44832011)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFXWEFzZmhObk5kcnNaYUVaVnhmWVVmSUhtQUFhVlBaZldFZTVzQ0R6Tkgz?=
 =?utf-8?B?R3FDM0dyenRmWTFsbzQxdzBDaTVDeEJKOTU1OFFuZm9HOHZ4bnpBR2wycVNX?=
 =?utf-8?B?VEw3SEZnQW94WitHVDA2d2FEbVViMXI4QjN0Q0I2Q3RVNHpaVVpvTTFpUXoz?=
 =?utf-8?B?aUliZmgxb2xZb1luWm9iYmt2UUpNckFUTmk2QWZXQ28wL0xZRWNHVWUvUlpO?=
 =?utf-8?B?dDVHNkJEMHZkTVc0MXpXYThEZWFhQzBpcFIzVUhya0dtZEtHWkVDaGMweW5y?=
 =?utf-8?B?QnVNSGpkWTM1TVcxQTZUOG5JN0h5aWZQa05jY0dNZjhsTDIrbVQyMkZqNmgz?=
 =?utf-8?B?bUtxV3Jwb3dIeXZWUTd0RXBaN1hPUDBOK2R2QmxVR0xHSkxPQ0k3RlNvR0hx?=
 =?utf-8?B?Z0NkdDRXbjJCOWVqZFZhS0NrWVJLaFl4MlRFTjhwdWJoNkVMM1oxVjhWemRS?=
 =?utf-8?B?NnlwSE1MOUt4bVpSZXdQQTVvVDVqM0Zia0duSlVldXE2eXFKRFdxMmpSNXZi?=
 =?utf-8?B?ajN5ZU5FVEZYNmlOMkJUWXpCVnlJQ1dJaFlkR0FwSGpLQytLV0ozcUZVZXVm?=
 =?utf-8?B?Y3RYQ3dGQWlQZjJRNm9jWDZObzZ2Y1dtR2lMTDNlSGxoN0swMlJFcWIxWTFR?=
 =?utf-8?B?dDdFbHpPKzFOb3dKZ3E5Y2l5aWgyRnlBQXJqaTNSOEh0dHh2cFVXazlidjRY?=
 =?utf-8?B?cDRGWWpRWUdnclRSQklER2pBQzZKWjJNS2RWVjc1UmJvS3RYTkZqcmQyTHdT?=
 =?utf-8?B?RGd2TnprMGlzS2VOVHdzTHJyUVIyb2hWVnh0VWFUT0RPcTM2c2tKWFZxTnpj?=
 =?utf-8?B?cDhaOGdQbHVxRzlEU3RPaGZySTVGNEx5RWlqdC9NWVRZSHltWE1qRndnMys5?=
 =?utf-8?B?SlB1Qmw4QU5yZnJ5L0RaWHRZbnBtTjUvVG0rbStoZGxmY1dTblhleDNKVEM1?=
 =?utf-8?B?MHFvT1BMVjFVTE5iMndYRU5MeHo0Z1NuK3FwTkVwellvMWpUUnorNlhkeDIy?=
 =?utf-8?B?YmhRU0l2MXhGYUQ5TWhSWS90SkN2ZHBRbzdoT3F1Z2lSK3NyM3JuQlNjbjZY?=
 =?utf-8?B?bUh0SzVDTXcxUjQ3Y1gzK1pBS1VPWTdWRWpieEVQMnY3bHROVnpSRFd2djhV?=
 =?utf-8?B?T1BkeXJnbjhHdkZpM2NyTDFURGZoSGwydjFRNVJLMXoyY1pCdk51d0NtbFpm?=
 =?utf-8?B?UkZLM1VpcmkydWJyR29Ja0tMN0FuYzNualE5ZkUrV2Zkb3FVTkxSR1EvYUds?=
 =?utf-8?B?eVJoYWVoYU1yZWgwc0YwTkxJMi9TRGxKMVAwRjFibzV0bmtkdDhmTGZtOVZs?=
 =?utf-8?B?USs1SnRvVDVhT2dBVUQrb2liVTFtd2VUL3Mvb0dwcEpHR25ZQzkraEtlMy84?=
 =?utf-8?B?M2RHdENiVlI0YW96M1RXRlVpRDhsbldLcS9rU0Q4cVNhTEhycHdSbEQ3a21t?=
 =?utf-8?B?MmNqREQrdTBtYjB5RTJvYVpYWHlia2xuMjlpemVBV3NhdXpxK1dTMnQ0K1NP?=
 =?utf-8?B?eGlFQzdjNU96YXhvdGZBZGY0YWxFNXA0eGE0ZVg5Z0xXN1A4L2hSS25VbGlP?=
 =?utf-8?B?bmZGczduelo1dUFzdU95RHAxOW9OSUV4WXpBeGgrU29FMHByY0NXeTcyNzZY?=
 =?utf-8?B?eXZDVFM2blVSUFZCOHM3L1o4Umkra24rKy9xa3VYQ2dwdCsvQWVtbHEzb2Vj?=
 =?utf-8?B?b29vYWI5ZlkvVmJpT1dRaWM5SHF1bWNiY3l5WWFVSVE4bUVoVFBaU0xiL1A3?=
 =?utf-8?B?ZGkvUk00NTdzakhiYjRyejBKY09KR2lMUGYrYndoNG5HQmRJVlBreXk5YWUx?=
 =?utf-8?B?eGhwdnJoekttb0JheXJpSG1rYkRlWHBId3d4UWRpWW13elF2Q01BUG9mN1gr?=
 =?utf-8?B?UFpXY3RnRzh2WWRMZmwxS0JIVG9Gd3pCbUpVV2hrVWRVU2l3TmZHSWNaSXln?=
 =?utf-8?B?N0p3SEJ4bE16bDJMaWJRQUdUZDBUWG15eEVIKzhZckU3RUVuN2xpY1ZVUzNI?=
 =?utf-8?B?T0Z5Ulkrbk5TVG5DRlR6T01peWRCbFFVclprdU84VnovcXo4UTRlYjVmY0Na?=
 =?utf-8?B?QzNpckhpOUpWQTYzMHFHNHphMjByV0k2QzdhbEVSWjVDVmNkcUV0bDNkdXpu?=
 =?utf-8?Q?yoqsq+1ulgtk/u6dyrIZE0dnv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YDtZXAosvGJQMrkLGUdwq+5hmV6OHB6NPYqkOUp9bCKmyKOigA+SpmrUNgOwuTbfLF2IuVLogIZsojj0kER/ty/6Eu0kh+So5Nm8gVpsHEFZi2n42qlmFj9mZfERzHpPMX2ms1elUQ7M+qhB6g4KWvagTZ2IUBaZWqG/u7BLwRHoejHFxqccuky9shYfyq5R/B4MLf5crFrJ3NmduPzn8Wi2u8UiDMovE3cQHxQ0TnpzmNMDSSwqHz+cUtfnDq9p3OGZ14i5ABrUbQapF9AVfuFb/dJ4Jzi9SSJZsIw0g4a9T4zckSyGM1m10LX3RbJcIe1kfXeNdfKY5onm/PZwc4rFAQ8HLPmdRHb9nh0GOAE10D9kFjSOkQYMtqOkT308mUDteOf6R3/BYwK1OaHzZBfhz75o6KtVSNFD4viw7rGob84bhjguAc11QFfKXN7uCH0OUtbJH33W4mhNcckfqbtZyGSAZe28Hu9Q+FhKCHMpgO0EllCcsP8qxQha+Gxb2V/aS+csufB/4hPbRy+agEEQrejWV6Aoj4ylJB5SN9dONJUu1vnfIwKm8EN0H6xJR78BgPuTVTStuQ/72Kb2zOj0al02hE4NP2mGcDuw/7e4QrIcuXl13AwR1qWELDfzZujkhEIOKd+6nMgWmdyYv5reoEtGyTPWH5jr8KEdA/aJ/PjTkvQoJ6kFh5UGmiC0jUgQ2j3GkBoB3fCz9z1mi//ZXJc8rKS9VrGLu96lNATOwdF8Ym0u6IgPJw9ErluQZPuXUm623nM6xWTBjc7P86Q/nRuIs8DxazQiIx17zfe67MYfVJIWMOEUPVg/HzJlW3dj4JyDdKrOY9aKhFT2vA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec37f79-abd4-4dc3-2463-08dbc3c32c3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:45:23.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw+nQPzHxWrd+wkgBqMj8Kxy0cUYthnDoG4NZoVz07MZ39XAKDjANxwiLtpoaA4Y4vxVBs4Uxjr+293/1GAIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=603 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030029
X-Proofpoint-GUID: psGxgzMWV7rxXBIWJUyXeuavxPA_2a1y
X-Proofpoint-ORIG-GUID: psGxgzMWV7rxXBIWJUyXeuavxPA_2a1y
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks for the comment. I have fixed them (+ more) in v2.

