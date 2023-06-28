Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5074090B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 05:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjF1Dx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjF1DxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 23:53:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167762D7B
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 20:53:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RIeJuw016381;
        Wed, 28 Jun 2023 03:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JhrX1JUrag+maYfEB6QLWJjOI2+XcIeHQs4Vfrt4DJ0=;
 b=oLkp7Di1oe5bPHhqrl17IaND3snsI72OHARkpDHnwEgjFDaol1zht0YxKmml94ymzPjj
 plL5YOtDu7MscfhjsweMln1ISmVhux7L4yomZpl2xKKUj/QB9dJ91XyvfwLBty9H0o0w
 7vKqzoSiwpUkJn2KbAWOvtFHjX1ZccFd+GXrOQB9HQzeBYxtJruRcjHHYPVNhKPfpoq7
 sf64y/F8YGXhB3JQ9SPvR3bacvMV+UqVvxtOXRDjIeb8WdNpWpfgOHyMwwynkfKZE6AU
 y+v6sqXa3ehy+R/aVH2pZJWzFHsHAuV1t0Eiwtp6McS3iAx5hP48KzjTv67Uzr8dEVOl wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq936hfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 03:53:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S0qATA038244;
        Wed, 28 Jun 2023 03:53:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxby0qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 03:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+1MoeGmWIbLdMcnjW8efdApUgBd8NoXOzZw/o3W1XR7FLS7/mP8083izavneuipsrI0V/tbO0YY5LwHn9FDt2Nnx62pBRZH5oTbQ0iaQnC/S7NgOOlabXsGbvApA8X8IWLCSZkHfAJ53uGxgMflQ1eBBlfmjQ6UHhLGN7c1XWx0/qRiR7strGhzB7fdqjDnuo7Uk2pMOgZ+KOZIDX8+nKN4UrT3umC8iBiW6IpPcibkdFxcbhOlcVslmnGGlBgXvpd0LtYjoizjxkn8gctkzOYUU4uChMY7i8AGhx0pEJUhUyMWyay0d0jt0cSBwo9iq5UYyaQvf/QaChANdCr2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhrX1JUrag+maYfEB6QLWJjOI2+XcIeHQs4Vfrt4DJ0=;
 b=NfUSUaIZeGW+gTz93yazO2BSBIYWdU8JG4QcX5xaK1BKtppTj/u4TQByxad4aKjwvcpxCyrWTdaP78kYPMDoN1EUM1dCUkq3Djb9ONHcfcGb1znK+v/0LRuUJERBhmg+S8xlA4TzHJCRCrL07rFtfkvsDbtxceMdWPm4EpOz3Fv4riwwek/k04+Qe38z8+LErllbZhtUQyLSWFZkBrft9XNOVCf4McAOO3pzb+j9oGnXLNlxG7DI6IrI3qzlplHT/kdEv+Ami/gJBsopmtmPf7mmBwKYW2n4q/lpHlZxPncqnavCnp5HClmBOlbB8YmkIgp0gCzsBWs3DoXCNeZAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhrX1JUrag+maYfEB6QLWJjOI2+XcIeHQs4Vfrt4DJ0=;
 b=o/+k7F6DaeSGgQo+s38ZokMksXXcnWqaGs3Di1QeMKQ92vK4e0AWKpdKFBRFZgl3Qz8w8uJxZYYOfNRAdrLbap0UD4MNOAkcklS2LSgaA0BzRu7bnLYwrfK7bqukI6ucYo4gY9wF/GJEGhHqWFuAPi0cB+LEsIfl+mbpo6bN0uo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6920.namprd10.prod.outlook.com (2603:10b6:8:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 03:53:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 03:53:07 +0000
Message-ID: <1a806c3f-4ddb-5f2a-becc-5ee1988c6d3f@oracle.com>
Date:   Wed, 28 Jun 2023 11:52:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/9] btrfs: metadata_uuid refactors part1
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org
References: <91368428-6950-3236-6bb2-13673527aaa9@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <91368428-6950-3236-6bb2-13673527aaa9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: db11f158-33b9-411b-8bad-08db778b2eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqvHAy1hArOCPIOBP8vMT6zANx3SsjcWsmIHE13rqcDyynhGSL2sKL8PaiISeWnWcD707O/tLF7OmG9vgJ/Hg+fjep3y3afz2t5yQkBaogUaeAJ/rKRgenDKujovp77rC6zBSfKrR3ACfgFtSfv/dPXoUL/G2TmSu1z4Hi3mwDfewr1wbLzuo8NhB/glQH2GGPegSdFFMN/3yO0tENUZI/YdBa1JtO+x3LHi9lMQLMBB9R0ztWXvWjP/lTjd2NqCFXTX8gE53fhPqU6cB67YJvE8Lo/SIKSYJJijNtVXcXFL/UlPWVK5SAHNAoCeqcjeevOK7OUHxuSN/osznx+95Ky5gehVvbI+61aRLE9La//6/LJBYuu8I1VQ7ktICfXqDuVasj3nNOdlDMvWnjzbP86GhlaeKYdcgQvvmZbsFKLDy0i46ulxn/9as06pFq29KBlbSrhs5Sdm43wvBe3MqR1GdBAsxkpSKhp8IeiHvbQwMdbKkhEHH0qT9m2QZyRiJ2h7Z+4UP1Y5a6OyhYjRI5b18xCVuVjbExGz8mvLfH/2zRITU0Ms82rQVbztjbU7WCuJ2KMh+8DkC4qtBGaX/Yv1Brs7/igXmoiwtsrtInlFMlAm1W8iF6mmzHbnu/10npW1dv0lUVJxppAq4APqKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(44832011)(5660300002)(31686004)(66946007)(4326008)(66556008)(6916009)(66476007)(478600001)(36756003)(316002)(8936002)(8676002)(4744005)(2906002)(966005)(31696002)(41300700001)(6486002)(186003)(86362001)(26005)(6506007)(6512007)(53546011)(6666004)(38100700002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdYaVI5Y1FhZU1WUHlZTWJidFBNR2MxUXlsblUwOEVyV3BRWDZwbGNDT29Y?=
 =?utf-8?B?dVVGM1dJdS92bVdRcGdzRUF4SDk4b3psT1lHVTZpMWovejFhRWwxZGxKRWJz?=
 =?utf-8?B?aXEyRW9YY1JiTmtjK2pzdnhlb2xSSEVjWlZjQVcvQ3R4TWV1TEwxNjZKMEx5?=
 =?utf-8?B?WlhEdllCdm95MVcwYzZOS1FweWFFcTQ2RllhbjRYOWdkcHkxU1FXbEF6NExr?=
 =?utf-8?B?eVRLUTBTcFVodXJDcE1UUVpwWWUwNlAxdXRkYVVRK3o4TGNBaC9KTTJMeERt?=
 =?utf-8?B?L3dKcmNUYzVpeHJhZDlTem9rU3I3dGVvUjA0MUp1Z3J5WlFBUnY2RCtqUCtK?=
 =?utf-8?B?R0tEUjhqcjdhUHJCTUNrWWZZVWpXMHgxSHc5MWhjeXZlQUVEWXA5V0NqN1Fp?=
 =?utf-8?B?MkFPeVNJck5HZmZnRGNKVlN3b2M3SFh1V2RWbWJSQ0xWSWtuVXJsOGc3Zzds?=
 =?utf-8?B?RXpGZFVHV3NwUDlySTEzbVNGY0w3YWpNa1pyWllMU2U0NnR5M0tJeFZrMjhT?=
 =?utf-8?B?TGdJWUhWSFJFYURjR3hNa2hWSk5uYlhtc3J4cG1aQm1tQUZucHJZSk0rczNU?=
 =?utf-8?B?TGZ0RVp6aTlOTml6a1k3aFJvMlltYnkxOVpmdDhRdmxRcHBqK2U0T054TGpK?=
 =?utf-8?B?aWw0dkIzVFJKZkZQRkpneTR4UXZjZ3pCRXBDbVdzWUdwMWgzTGJDZG5lYVZt?=
 =?utf-8?B?d3NUVE82aWcwd1phTWVHRDhmZGV0V3J3MGhsa1Yxa2lZUWQ0Uzl6bGd6dHhQ?=
 =?utf-8?B?NXYrc0I2QVUxSjAvNEZxN2srTnM4Z2JiTDVIaTRNSzRoY3BpTjZBL2hYUmxC?=
 =?utf-8?B?L25KRHFVUWx1dVlnY281alV1Vy9MRmlTYnV6V3NMOXlsblZaMTV6Q1JjVEJm?=
 =?utf-8?B?b1djb21lQXJrYnhsK3UzOTVaOFlzbS83bGc3cmRDZHRBY0NSSEw4WmZXdkM2?=
 =?utf-8?B?L1d6b3l1ZXh1bmRmTHpiRmpqRVdQeE9BNWFDdFZsYkd4d0l4VDdOSXdPemlB?=
 =?utf-8?B?RUVIS293Rk55UG9sTFM2aHBobUxPWW9WWVVNVlJ3NklHM0tXMldzOTVrU0pl?=
 =?utf-8?B?clcra1JNblV0OUIvaVhGMUNnUmV2Ny9SMG13VFdyQWRWb0dCdUFxSUQ5Z1J1?=
 =?utf-8?B?TVplOFpmM0VjQ20xNlFWbTFzUHVaZGwxYWoxRDVsUjNEQ1pEMGc3QUg4U1B4?=
 =?utf-8?B?OENZcjM4aU10YklPaWJSQXNPc29qcVlYTEVjQ1cwY0o5aDl3SUNHZUxTUUFQ?=
 =?utf-8?B?L0tWSHNOWFZqb3kvNTVhcXNvTUFWUlhCd1NsQnV5cmZLUDlFOHVBWS9kcjFm?=
 =?utf-8?B?UG5PdG5tME10Q0dhZ1djM05TQUdud3d6SjBZd01BRXBwc0o5cjdwR2xMSE9x?=
 =?utf-8?B?RFBES2hLQUZ6cGxxZ0x0Y0xid3pLNWRqYzhUVnU1Y3RTQXJKRVhkSzBuYWtO?=
 =?utf-8?B?Q3RHbzlYN0J5UUwyclRaeS9iYThiK2Z4cVNQaElCeE9CZ1Y0TnBuZlh3MmE1?=
 =?utf-8?B?RGhBMFdjRjZSSllWZHpkMEIvc2dZV05QWVlCa3hZczBpZjRoU3dKS1lwaGxY?=
 =?utf-8?B?UThWQ0pMQy9Ua2JWdmFVR25TK3p2YzBLQUdHMWhUbkZzcm80NFhObFh0cWla?=
 =?utf-8?B?bjQycjlDRzlKZk9HaEM5WVRvQzBHSGErVkt3TUI0U1MxM2RkTUZBMVJyNDVF?=
 =?utf-8?B?RGw1bDc2Mzl1QUFkdHZveUYyMWgwWmdWU1RVcUxoYjdSNVcwcmRmM3E1a3FV?=
 =?utf-8?B?YmxlRHIzaXRHUzV0UG5xbS96Mk9YYmpsRVB4dFdJeDdMRmFmdU8xcjhEK2ZM?=
 =?utf-8?B?Y3RYM0RSSUhEbEVodjB5V1JPeHVobmx1OXFQV1N5b2J5Nk9JTnIycGRrSjNZ?=
 =?utf-8?B?NXdNdTNXTkx6VDU2QTNHRTRzaCt0a3dEQTVCdE5tNklhVEFNU1RrVVdJd3pt?=
 =?utf-8?B?M0I4bmc5K04zZk5OcHRQWmVlcHVPdVl4cVhzQXd5eTlxWlBTemV5REc3OUxQ?=
 =?utf-8?B?VjdjOGlMTGsyd21LeFkvcmtlQ3RFbzNWYVc4Z0t2UTVCcElnMGxuWWVSczJr?=
 =?utf-8?B?djNBWXJRYnhjeGIvS1FZa3FYanpkNjFYRUZEWXJ4MTlGOWxhTERrWG1HRnRr?=
 =?utf-8?Q?SaJJfPurQAXxa2gXbiJPoCJMQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +44pjxUs+DDkDyBoZ9j89X0MZ1iilfN7bgjRjYjQxiIesz3AXkdIYQRqRHSihfR50X8Avx/AXDk5X37amY/I7BHbBDfDJHaPTbnb2TI4oOOJHQqy+cKCkSAEEoUYsOukW7NhMF9dQyngb2xDWBkBcE4GMxcXbKU4UKQgxSeplMINkpLFmGBgEK+CRyTEhViayBj3JrcBDT++I4+zINoj1oWb6vgqz2ffjQ+PlPIxAFyoz0SIxmgDenKgsLNffi/6GpL2obc+67Q/y7Swv432tznarkuMuSiuft20ZmaPl+mECv+gTluIvThis1505G5rGVBQBqbqmF4SBu6Ofct2mGly8yaF6Gsky1gresJxWGJ2A7U7OVhYtZbbUZJCF5Mma8TXUgfJEQ+W23f03pI42elBgbE9/ct6RhCEl8uOI2vUUVWEdRZ7cFjk2vWtSgHXqI9y2hfEw7rwwdDE5c8EM3xBX5escGPVzLXCO+EAnc8h3jIUqGBK07ZLtyoM9f2zQK7cB3aWlrhHwovmkPDWAlhDUdfrRy0tDfWozCENFbMfkOQDM5EUdaIuqhKfcYtLWy5QjDIC6Y1Az2B836W+XvJnB4hYdn5nnRqXbk7wqDyafdFgYcZ932aJ7zyd5ZZj59ShGU2p4hV6XuI1VucqXdXR5H8G1KoweiUQDNiyXrNeeg+tTuU9YcVdvsjHq6m3ToeVVq84JZcALiXyzxITYJkq5KyDTk6YRLbjIBJ/Odzp6+TgrwQvPjHfsTPGE1uYCDPVQpGzl/Q8aV1Vd1RlegaoUmPU7w/QiuAIeZj0LgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db11f158-33b9-411b-8bad-08db778b2eaa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 03:53:07.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YegXYQg4BrzxnvP0RVGCVG2pI7syGDvnVuIGo5WTk+LQls4oEoH50Lx7Vwh7yLy8/Sr6trja05T/RJs6aTScpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_01,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280034
X-Proofpoint-ORIG-GUID: kNj1eXSsruulIaxKY0CXwF6ntz-LW7py
X-Proofpoint-GUID: kNj1eXSsruulIaxKY0CXwF6ntz-LW7py
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



I have a few items still in progress, and I should be sending
them out this week. The main focus is on cleaning up the usage
of the CHANGING_FSID flag. However, it also requires changes
in the btrfs-progs and testing, which is taking longer than
I anticipated. Thank you for your patience.

Thanks, - Anand


On 27/06/2023 22:55, Guilherme G. Piccoli wrote:
> Hi Anand, thanks for the patches, nice clean-ups / improvements!
> 
> I'm working in the same-fsid mounting [0] (guess you even commented
> there already) and that touches a lot the metadata_uuid/fsid related code.
> 
> So I'd like to ask if you maybe have a "part 2" ready or almost ready,
> in order I can merge it and work on top of that, avoiding too much
> conflicts later.
> 
> Thanks in advance!
> 
> 
> Guilherme
> 
> 
> [0]
> https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/
