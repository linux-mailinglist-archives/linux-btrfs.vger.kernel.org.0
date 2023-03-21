Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168B6C368E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCUQF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCUQF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:05:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9814482
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:05:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE4Cfc005488;
        Tue, 21 Mar 2023 14:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=1YKdsTp0WGieAArasMzlgCtw5wJTH0tjgxofl6z3NdLXUBgMosFbWVcITRbZjFUvPSsU
 jJZAndwCzGT4xwLV0z3HfqPvpYpiqCWzQMeow8R0HtK1cR5ICZkEvHOZUhT7NXO0XK6t
 G2UzkdSHLHf1siyfIQXTQewSV1LMvdrC1aGUdMAQlaowXGbwH1kaXp08Gl1tqqeuTgID
 SfvEBO8mMoaITeRHskhhP2tP9noGrt1qGYHCgFE0+oW2LYTT25MXujLGnxK30UJv2cQn
 G3DQ8L/e4AAFwuZyAe7iWIfnm+vzgZruxcD1y8m71EP7LbCFzdn6gaUYdCQPYInTA5EK QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433peq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:25:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDUWq2006331;
        Tue, 21 Mar 2023 14:25:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5t07e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZosUUvDfM8D/+zcoZ/M2Y8kL54EnNtxJy2I0rrdRHoPqoGPiANIiXvv7GkoSJPTkSSvC0PxCTXWRZ8qW4svSOi6lVcsnqh/DOlIC2ZSbG/TRNf85yr1Tt/n6E4It/IXJKEdoJZG/qBwipvVypeBDnnHJbQ3zfoKuXz/I3Qv77VRv7TwbhyAJ6BEErIVxoa8Mr1MMljyxFEfQoMnkTo9PoyQ4iA7ueevs4366wz8sSM1WPXmkqDB2homQGNgPp14NRc+X5HyvZOCRZSkizxzfo0vDdy9N3/E16cZhrxjY69mN/LxfeVXkJypIf9gITV0oY5lQWU8n0ky26INvwuWogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=U6b8Gpk/AA7r/Sw0Yt+XU/dwpUGdWb4bYCDpxpvCuN3318pZeWrn4btRgSrRxBfCa5SWqWTI/8vRKI4MJMQmpC2wDFI9kGyFOD6djZztkdorE0Plt+xNUOXtLSfQ5nfq6N2eJ2t5dqLMtnYVRGwGvJnB3sZ5m3ot7wGAHfkBzqW3oYB20newtvC3SwTGAvUu/5t/g5lyofTZA8ux6feFAHPrUwAGcEsiW6uRDnA1MI36NL+N+nkvwJ0f0zLixKSlEb8lXsHFGgR1m5+gVp8mqzbesJC5n1Ns4rmWwPwWHO+YZAqmjot/ZvMEHIkXxs4mq+MSjqjLluDr0TXyVNlPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=Olc/MLwPjGkEz+gpc4qnv7DizyaMXc8RbQlRkPQ9tzc/WgaqWErwcuirEP1Tf5eIKC43YkTADCMOiDotMEEHgnvmN9rbVIbm+NndqsA6kTl78rP3FCvNDYpahEg62azd4Lu5mCD2hl3x6hzAHlwv6mUvL4FJQEIW1wDVVdD5Pkg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:24:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:24:58 +0000
Message-ID: <4e440847-893d-2cad-a453-4f21e5b8bb67@oracle.com>
Date:   Tue, 21 Mar 2023 22:24:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 18/24] btrfs: constify fs_info argument for the reclaim
 items calculation helpers
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <70dff2b84bb04e277e8e62ae0709d08f44eeee60.1679326434.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <70dff2b84bb04e277e8e62ae0709d08f44eeee60.1679326434.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ebf668-940a-4df0-075b-08db2a180c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCWVCiObPH7IgCI0jUBAiLNwQcOEY7o5s3rySU2wd1N06+VcVfqH8aLdlz+N86giFNQtf99TOPpwjraZkFvXmb5hqdCVreorraJ/qCyF9D7XMdL+oy4ThBXlvrxyKHHbYFgJJlRGtCATVoViBMED5WnIm4TI5al5i+ePkFVlUPd4QJj+M2tMmRCNBnPuLqzTJ1CDXTrphMadJOFGAbghaVuGNpfEArCLtjEJM/S8EqOQc8g61DpqtGmm3Vc0a/7BvpWBd+H9QoJ0iJTDiphzQkzjBJoOgoit2nmU2C6rZAR2dnGBZI7P3Pn0HlfB2OPs52DS4HD60PLc7/LiSZOpzZF81JjhRQhGlaizz3BntWSNEXel/MKVL052ntZFZan8PLcbEMMfSyV6K6jHWSrKIkBwqGiRxBh6W1XFMAaTmYcWCPXFjRlAPXvVY5FW4OEc0lzRgYoGUVzMTlQSsxMwx4icXS86Dk5BNj3dzR1JME8azd/0vU/+Zm8UtbcG3PQh23MW9O6swJ1XdoXfxPst5PmKI0t23QRlIXY101hH3Me/3N95vB5yXRC1rUJHjZBk0kCfS1ZTRcglQt833o7WaPVDkv+FA+FzR2szTa81RDA1mrmcTtjemWA9JVXze9Uf6+6ZeQC2nOIdnAtAxxwp5aIPQfWcT11V4Jseb6GDT2fVPZNegPZ1d+YoWFmrK3GQzqD15w/c2IEaHzgr1P6kzY1wJy7rZoaHgOH8HAidM14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(31696002)(38100700002)(19618925003)(316002)(44832011)(8676002)(558084003)(66946007)(66476007)(36756003)(5660300002)(66556008)(41300700001)(8936002)(478600001)(2906002)(6666004)(4270600006)(86362001)(2616005)(31686004)(186003)(6512007)(26005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThMdXVTbS82ektNK2VQRzE3TVAzMmxOczdvRWV2Z2cyRFYxUmN0SWNGbGJH?=
 =?utf-8?B?REpwVDRQc3hTSDhGenc4Zml6TkFNTnRlQkJ5UDczQlUwNEZuTnVQOWozZ1pZ?=
 =?utf-8?B?bG5tR1ZNYU4rTU9qYW5rMU0zbnFORlYrQzB6UzViQlh6amxKQWIxT0drRUJu?=
 =?utf-8?B?TGVLYk8xOWZHbDdseTFvSytJZzdTOTNMWDdqa0pjbFJMa2tMZjNrL2ZJYkY2?=
 =?utf-8?B?bm12Mi9FUmg2VXFXMUpMeGJQK0p1dmVCUnJTWnljLzlRZDhaazd5Sm9BU0hG?=
 =?utf-8?B?SmkxL0d2eGxkc2ZPUmp4R3JqZEZmY2ZLc0hTMGtrRDFlZzNGTDdsb3dwZjcz?=
 =?utf-8?B?RzlSbjRUNDR1ZnZybmNEN3N3MUxWcFI0bmFYNlJ6SWlaV1hjdWVYMENlN1dT?=
 =?utf-8?B?aWtMSHhHS09Wc0JrYnc5Y0t6UVNxaVFMYSt3dHBydGIwc01ySkVOTEpYZDhh?=
 =?utf-8?B?YXcrbkRsUEhVV2pIeDFsT3lSZnhzQXNaL1JYVWM2ZFQrMjg2bjhNOTY5bVU2?=
 =?utf-8?B?RjNqM1lkb0xTMnRjS1hqTnEraFVIUEZTcjVONFJpUVFTd080WFZWbVZaWlVa?=
 =?utf-8?B?cU5idEtUbFRIb3l2cFdmNWJTaHdoeFIzZE96Mmd0aXVzeE5yTmw1anBwR3Q0?=
 =?utf-8?B?Ym01MmpkSnRpcmkxbjVnOFJ0dFFGeUt5V3hoK1dXa3F4cm9BN25GcVRJM3cw?=
 =?utf-8?B?VmVzcUFuWnJON0oyT1Z0VWt1NFYvc2E0VTRKQWVGRXpYZHp5V3hHblAwNnhs?=
 =?utf-8?B?NEE1ZFRRTW4zdXhvVFBwU3p5S1E1ODhYREk2cVJHN3VNRktQVWRFdnM1by9k?=
 =?utf-8?B?TWlwMWZ6ZUVibVNhbTBMM0ZQRHpydm5Gb2d1bDg0TTRXak52ZGtUR29KZmlJ?=
 =?utf-8?B?UW9vbjRWL3Nwd2dPanFGempDeW95UHc2cllyVWZNNnpxaEsyZTlUQmh1clJY?=
 =?utf-8?B?ZjRXQVJtY0xDRGs5ZlVyRitqRXgxQktnVHlGMWVLNjJPNEUyeFBtaGRyM25k?=
 =?utf-8?B?M08xNzd2L3RjM3ZSakNFb0R2QVlRRDFSMnFyYzBhQWJLYXF5WHM2b0xtRnhP?=
 =?utf-8?B?MUNmL1hmRGFwM3NBZnRxSGh0cUFWdk0ycEphTGplUEo2c1JmRm9XSlMxZ1lM?=
 =?utf-8?B?aUd0RHdRVjQyUGpOSm13aHZqM2R0dGJZdlB5L3FLZGNXNXlsa3RDNitpS3B1?=
 =?utf-8?B?UzVQbHVmb0NINzNveHkyNi82UDlJQ3ZCWEorVnczWXRpMy9mNUlKN3VHaDhx?=
 =?utf-8?B?MlJTS3NzcWFvdjlqa1RLMUNuUWdhWHFaOGx0YzhTUU0yRTQ4N1FBajE0eWlh?=
 =?utf-8?B?bnRLU2h5WExMT2ptd1NOTjBraFdpRnZudHVSZVVENnhsUkRld3R5L2F0azE3?=
 =?utf-8?B?OGJvR3QyVzBrOVdIVi9HaFRkd1RITVNuQzZqUkF2NCt4SjBoMmZWR050eVM3?=
 =?utf-8?B?RlJ2Mjc5U0c0Qm5lQXh6eE5PdDdPZzI4emN6WHlPUHNFWTFDQmF1V1laK1dU?=
 =?utf-8?B?Y2lnaEJZK1ExVWo0bWh2UGtwM1J5OWJ3RHA3UXgxVlV0TldtYkhzeTVHd0pm?=
 =?utf-8?B?Tk93S2J2YmtucmRXRU80QWMxQlcwZ2V0dVNRMWFEZXZqcFlTQnZycXplTDQ0?=
 =?utf-8?B?NDRKZlY5K3c1QnBudERWeUtXUVBWeVZkZnVzVE1DcTVsMlRkZFJtYlpDcVVY?=
 =?utf-8?B?aWY3TkZQSTkwRnJVZHlVUEVaVHEySHZubXRGdWRDc0dqdGEwNXg3ZittOHpF?=
 =?utf-8?B?T2E2Sm5FdDVON0trZTd4eWxVeFRMYXB1b2tURHAxQ091disrYmZ5UnlHTU1p?=
 =?utf-8?B?MWhIZXRpcUMvTit1L3RiQjZwSWY1VVJGcmxMcEZ4YjFPVjBvVXorays0N1Aw?=
 =?utf-8?B?WEd1bTdKQUE3SUF2SUkwbExUc1BVeForNmovNk5oaUFwblNNVmpYVmdYMXB4?=
 =?utf-8?B?RjFvenNrbGZwZENFZW9zTHdPWGo3aXgwclZLOGZ0cWNrbTNXZkFsY0Z0QVZ4?=
 =?utf-8?B?ek1XNDBRQmFiWm1OMXhkRmxDc2VxaEp5RnRZcXVXN3lVZ09xUmI3NmxsM2ln?=
 =?utf-8?B?Mi82WWdVSVNSRG9mdmhVWmpzZ3NJQU0zK05hTmt4MTJrZnpCajVNUERIOFJH?=
 =?utf-8?B?dEdvVWttQ09GckF2Q1puS0g1eTl5U3FFUWxUWGlnZHVsZFVIOEU1clQ3SHNa?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6JriMQ/c+ErRhfc3fe2U3iRTIeCvqwE8WTIAeC7DW98i5HDk1VTTlnIFq1P+/DOA7DZJ4oX5za/vGMANfeKdXKSu8wwohVRcgAVnKsEMxz6749M10T83NTW4+0nW2awZPkACEDrv+MPppvOkXN8d2vpKA+wcDM+KMOBVhvLubR9AkacxCc9NH5O3S4sg6NMqdA3K/E0GOPJwLJJZv498NjKpQVC3+rGErSAFJkBxPaVJzUQHyf80Pa77sKWn+6qqkqXE0RPhsgTvtl8lOq1f6d/RZAlfwm20l7lZF2K2cru1VjTL+T34gjvObM85enw9uH/CncGkPAQglQ4jcF1ih5jaQUdq1ghkJEmfF1rWS7xs3JlXGjtWb27apvK1Gq0OhVK4A+4XoEHWhixsvcDvBrU22eYA9rkmT1nCXquIBGGN5O8UkS73Xtn2L7Jd6At3jsCdWdgA6G2RUxpFrek0hngO8M2htzqqg7gLv0DijAtv1CsFzkY5Gyw/Pws2qRMy51I+KFMzcJbvuuZ3Jlj6zTQF/DWhOZAUcnACz5mlQqOLKObAjmqWbUXlgiMeoza/AfdWTu8Ix+8fXjgCSPLxszsK5Cdt5wSo7yJ3PDj91LBUJqE06dCH8h4DBkwkUQf7rinyYK/cyTbVW7lcz2w0cv6Hs7SLKtJw72kG596f36/X32oTn4Y5QVlYY3xP+6wL8JtoVNDCes33oFVO4naGBjJ8uiY+aMmSzeezRVkVhNpZagAdKWewb7yNC0y4mIsG3PcK3NDTLyNTZAh1cBpC1o5vVjKGk+x8aGjb928wYTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ebf668-940a-4df0-075b-08db2a180c66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 14:24:58.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2g1vPhxIj7Lp2w6sYG+lDy/qXWX5+NdUAhyYhBygoITCUDWxzYDv4SV5SHIlD6rW93/MUC9Boom5PltBo08AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210113
X-Proofpoint-ORIG-GUID: Ak_nw6LHWHyB-hj1pdZMz2Git90jPWkK
X-Proofpoint-GUID: Ak_nw6LHWHyB-hj1pdZMz2Git90jPWkK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>
