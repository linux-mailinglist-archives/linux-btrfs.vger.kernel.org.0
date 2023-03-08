Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328856B02AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCHJSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 04:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCHJRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 04:17:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C03B3EB;
        Wed,  8 Mar 2023 01:17:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288E81P013123;
        Wed, 8 Mar 2023 09:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fCxzAECbYdIKOXSJTb297uv2tiCpEOUfpo2POuGDNYo=;
 b=bxlceVkPZazNRY4LVh1pkbRb6TEUrw7ryBb3aEH8W4irYL4hA6PX3rn3D82WVCRDYNNP
 4FRPe+MSGNKwcp2JZ6kH9IogTbPpuwDa9QVK7hpxhHiTsXiYgxlDu7Rv16VMzu3tOfKk
 Awej2x8p8ZHpPoUi8mLrNOxcfRpUAjyXWNoV6KLVsavpenK/S5oXXGt7M5tDWO5Ag9/K
 gBqeUJ18gmwu+/RqWgTmHeuHwTp13/7oM3VfZtxGFMQ2pKMOU7ql49BSwUuTK7qpl1NS
 ytsMQ98MNxrGukufwV4ubVEguvJxbFMYPcCeVsy971lb2y7tKVEvwL4KVGSz/wWF9fhB 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn93xpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 09:17:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3287tlEF015393;
        Wed, 8 Mar 2023 09:17:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fem0280-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 09:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0FeXH7OFzm+wYqs4Ah+cqG5PIAwiuFDJOamORDKOHtgXcDm0SeHR4DFVZCst7Su230cz/TQzeyPDuTZSH8cHF7JidRoJ6DCy0AqZP83Yd91Z0//KFbFj6kV3qFsYBQWHSzvjRdUxccZQsEJYi5+uEToTv6iG01SuSdoPpHRqwUt7DzfJYwNKq0gea85oqLjcPudnLnNtCH/kuyTSnphcl8zuXGkbxQEvlzkxQYrQa0qGMtOhG7jg+M/rphOzWGgs2sXL9/VfrxVgzhX44xIwjINclZFzSad3nX6wyLHeB3tVA9P0ljOcjuuohh1q3F9DIYtQbKJpep2VrOh0SDPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCxzAECbYdIKOXSJTb297uv2tiCpEOUfpo2POuGDNYo=;
 b=FDSq34RSMJ6bhPt/itNASWH1VILzLoI4T2yQyHsvPn3/oObHVLXHVuQrQaUYe/D3bcqYpTDLltSM+h1eUZOJwwtumHuG3/baAIod1iqMF6zgjh6m+Sey720aKx8F6TpiPOudGlCsGgbXtEg+sNGAuGySsEfKNp7lSykm6+9Lk4KdlXiKCuQ0IPuur+HRsDGTnWWRrQCmdc10CFuXGc78kD4zMBpOXD0cMmzPFfJixZ/wssGkjXktpdeD5698R/FuL5g34w3H/uwsBJbUpp/uTtdqmwQdPlKFl6w4qsyJti91rnS5TvuJIla7dRqd9E92z6oSFVLfNQvuz13+A9oXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCxzAECbYdIKOXSJTb297uv2tiCpEOUfpo2POuGDNYo=;
 b=QhfjgHQH1Swh/WbY/eSfHWHVz5iGafd4jvGJHAsM8i7tewc84ocBooNScnkK1c/LFw3LiQH07h+ubAYEkGAt0KE+xQdxUSoD2/awUdOpADVbBzidAlujf/UEkJHlYeWOAMWHli4jNQ3HVZq+9h4cBmdmC1ebYyxreMIK6W9kj3Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6734.namprd10.prod.outlook.com (2603:10b6:208:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 09:17:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Wed, 8 Mar 2023
 09:17:11 +0000
Message-ID: <dfd8863c-3a18-f5f1-8391-10fdf101ee62@oracle.com>
Date:   Wed, 8 Mar 2023 17:16:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs/284: list a couple btrfs-progs git commits
To:     Zorro Lang <zlang@redhat.com>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
 <5a542a82-b47b-ced3-97d6-a38b6e926522@oracle.com>
 <20230308084756.sdeko4gm4x4teuvx@zlang-mailbox>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230308084756.sdeko4gm4x4teuvx@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd085ba-6fb4-4ed0-3edb-08db1fb5e5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aytfN6acM4jsMurRzm8OeypYqwJ4kTfitrw1s6Y1yi6BHEPTH4tPQvESWagivvknGgPwT7JTuxeY14Nv1WYP+1840W3AhfNdKIKG4GwqYnG2p4viPItNjMQsg1ip32/NM31bRKJMGFV4g3FXhTWuKWFnJiFw3xTBcwy5b8EMXSNiMEgJbioSR7L13Nt57VwiOh0i2MXjuA8RUo0TD8LgEvI3cD3w6mO8gZ/9FmFHnlIQIsTwqrd2zfET/5noleEC8VZZpBH66iTBBhAGdecn0Xb/cUymwIg0/1QrxnOBx6NlaP3KT1laWpII9FtrKja6Oxh/FVNa3miL/Jvgg2QyUBOvcbGo15MsTV0QGRnGV2WeIjzPMVcan7k0L0drLxFUUhPpvc7k43EXWbP4vvZp0dbasumIRHZfQCqL/FuBCWEaeAVyjkhtGeyRCFF9O3jAXf0kvqAjc9mApWV58zg3EUnd56HwC4YsLuE2JaUMjo1K5m4bXXMemlxuskKFbmqx3ZRcWcgvJ5WHS1zDr5uCD+ESIoI6Y//w4THKLMrO0dYUADeOwHe3jxGMS9PNQyASy6E6rueo8enUUegicjHtRokG7tcBnbb4EMQPflIuyyOhBECPI8/8KwTGbRaabDsTwM3xd1IIHrcNQT1XKDXDdXrYqLcpWXDXWx6cEV8rByB528UfqkQsFy+Bs0FWMAuriEI9wd1a4BTfjvYrGKv7sAentSwH2G6mDO9pF2cdNoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(31686004)(4326008)(36756003)(31696002)(66946007)(6916009)(41300700001)(44832011)(8936002)(2906002)(66476007)(38100700002)(8676002)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(316002)(83380400001)(6512007)(2616005)(6506007)(53546011)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGw0d2NQZEN3TEtReS9XSlJwVHlFNjFURW1OMnVndzZyVVlGcS9oZXEwcWxW?=
 =?utf-8?B?KzJhUjJFZTh1ZGo1U0V4bVp5UXJJQ2dSbER3bFA3RXA3T1doZ0s5OWwrdm01?=
 =?utf-8?B?YVhiRkMwVktTUEJwUkxIbDIybmpCVms0OTFWamV1WlR5Z2EzVkc1czhxUWFS?=
 =?utf-8?B?ZDBkUFlkRkl4UUl4amFqcUVnanArRUZmcTNNQnpydUl2dXlUa2JMS294c2tq?=
 =?utf-8?B?UEFBWDJtZHdjNHlLUmI1QUcySDRlVk9rWmFMazEzbUVXU2JzM3JnQ2dRbGtH?=
 =?utf-8?B?RGZqSUZkMXl0LzQ5Zjd6aG5UY0ErVEVQRTVnYUwwQWZLWVZwdC9IeUVvUDA0?=
 =?utf-8?B?V3J4VGRiRHBCeVd4L1lwZGlsNTlONlVkcmc5RUVlUjZlSkJ6c3IzNi9LUi9P?=
 =?utf-8?B?MDJzbWcwWmtUWU9IVkl0Sjc2cXo4Q054UEU5cktNUWVTQTJCTHN1UkZMemNC?=
 =?utf-8?B?MGlRMzN3b05RdWhzU3VPQ3hhc2k2b3VWWHlUbENIQ2ZWdWZzc2UxZmh3dTNC?=
 =?utf-8?B?MU53VDNNQnBFT2ZZZCs2WlpIdGllMldVTFBHcWltcFZRV1NnTS9LaFV0RFVW?=
 =?utf-8?B?aVB3Nm9Za25UMkptS25yWG1jSXpheWlySU1NU3lyQlBKQ29qMUJNSFJvK04x?=
 =?utf-8?B?TW90OWVwSkRWaWN1NWRzT29UMmYzaTdWUEdRWGd3TTN5V0s1ZldrenZLV29y?=
 =?utf-8?B?L2hHMU5BbWxobzhLN21YeFhBeUdQaDR3SlpuME9uZlZZc3RmalRxYUhkWitP?=
 =?utf-8?B?RktlRFZHUmh5MDlaTmVjcEJmQm82bzNRQnNqRmVyWExjaEhaUG1ibURMeGE5?=
 =?utf-8?B?QXhvY0tlUHFoMTdXMldWU1YwV2szTFQ5OHcxR2VtWVkyNFozUEg3OGZxSzNo?=
 =?utf-8?B?WVRjakt0R1hpcmk3NUtlQndtRS9mczhjbnczZStqN0cwcjRYSUdvYlpNYmZN?=
 =?utf-8?B?Qk9zOWRsNW1RQWpub2UvU2xjMm9kaWRWMTllajBSUnFYT2ZSRTVOQTJ6a1lz?=
 =?utf-8?B?elhCcVhEN3N0NSt6NGtUOEliK2Y5NDBzeUVjZDh0cEtQeTNPc1BEcGxxaWFX?=
 =?utf-8?B?NzRSTGQ4REYzKzZxWEhVWndoNXU5SXFhVkZCOEgrYm9ZazluYXVSWVZvRmJ6?=
 =?utf-8?B?d3lmVllTbXhVUm9VTCtWSFVmUURoc0tFeEQ4bjB2OGJ2RXE3bldMRzEzT3RU?=
 =?utf-8?B?T0xtYk5kdmlTRWgxV080T3VsL2dra2RMblpBa3VBZTlaQmdaK3A3TllPMmND?=
 =?utf-8?B?R3dwNGQ3a2FBQmN6SlFSNkNzbStxcTNqVkVDUiszVU1OYWhOcGlDWUhaTDJU?=
 =?utf-8?B?YUZ2WlpVMXpKRVdBZDltMjg3YkM3OU02Tm54MngrZ1RFVzk4dHBlRnN2U1du?=
 =?utf-8?B?Q25qY1NvdDlnRnEwVkpNMUJDY2docDNxbG52VW9TMUZKckQrNDRiMXFLU1JM?=
 =?utf-8?B?Z3gwVTRBT1dtV3lIM0ZqWVNNa2JqSFNueHQ0dEN0MHlFKzRaeE9NWlNycXYx?=
 =?utf-8?B?MGdKUXFHbGZPY2xUcW9pVmZIbFBXQXdKb010VHlaMURWMUxIQjd5b3NhenpU?=
 =?utf-8?B?RnNkODJjTXRNbXBWYXczNTBZUHhYYSsyQ24yV0syVW5aU08xTm9pSGFRMGJY?=
 =?utf-8?B?bFVxb3Q2cUZLZGFMWXhLTlVwbHp6bk9QQnFTK1BBSlRxd0RwdFJOK3ZqL1hO?=
 =?utf-8?B?TXorZHlxcHpTeGZob0JqNXg4REpmKzU0TDgzQWcxR1E3bUZjbWVvY0tzeDhx?=
 =?utf-8?B?K2huRkJjbnpTMEVVN1ROZVZ5Ump5QlY5em1ham41SFpWbm1IMWEyRWYyZGNu?=
 =?utf-8?B?d1Vja0RNbGprRFVCZTB1ZThmcWJuWmFDeHl6NWN3KzZlWlcvSHlXRmFWNzdq?=
 =?utf-8?B?VjkzU2xSNmsraEZQZ3BBWW43RWN5ZVY1cUUrRFR2T0lnUllXbCtjOUI2TUZj?=
 =?utf-8?B?c3ArYTZiRGVLUCtQMWtLNWl2WWFWRWY2aElDZW9VZEhxM2hZYVNyMUpKV1NL?=
 =?utf-8?B?RzlDeVR4U0xDdzc3VEJaVzV4ZzFMNTV2VTFBbmFUVldlV1lMWDJEVENDM2NO?=
 =?utf-8?B?RnVybC8zaHdVY2trR0lCTyt5MTNpMUlZemJwRW9FNDdrcVdGZDdack5XUTVX?=
 =?utf-8?Q?bc6hM5NnsaCh49qr2oHr6z+pA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kGmDPmvTVw7ONcfObnACBH1evkA/cgcov54JgG2qNJwyV9jzN38GwRVH3eAPEP9+WFXIpCZbhbjsTitssHVgPmub8XMmuz2bKqcH7EjQlteIG6vepf64xp4+6wYZFDGWX4A8k5nsJ/W0j25n/OruM71sjw0AKnnxb8JrChYTAHTO8fps06TPchBac5Bsy7INZOJ+SSPkVvHIqRTJetn10vysnRgrgKiD0Ol24pXQ9uWF4gk6ZbQYw8KSzOhK8x/9evbjNlwNf0SvmivBguadl/E9cCjshgJg00lbdsrqIgRyZaSxpgBxIL+jfja23jFKbWgKa0H1x95IV1H6+jG8FZWzPP/N6NRDVoWrHCiwHRF374rQLM10N/alBm5lW/0d+BPMf9+l5w0asNETkf4wmeeHpJ4n2rex0k4IC4FnRNhSUWm3ThOWVsWFIFxgA8GgJJ+xmZYF6060ZmAipkO8r8mlYH2d2znNiPWe83hKlV3PAttv0yQ1ijowQ3q3NXyxjf+dGwIEYbtnqCC54tmN+7l+rRADXheVNqXu7iymerk6hlyNgvjlmX9SdMsNK4NQw5E53Rg1Xpj3wwZg+Dho0x09zNZ6UqWdac8SMJOEDYsNbiWv7wkVhNh9y1XM9rTdASxpTKPXAlsL/1T5gzFn5jlrVSK2Cy49uiBybWTVD4fIbIx0hgBhShMcsX2GGwb5PDS78tafHAI1bxxe7spWUoDL8qnWKx6Q5PBQHQcD8lFqh6a8+Lo+yRzZ47oCOqwLUMzrZVd1U9E6XWKBIwZyt8V/aWHhNSbFCHmPQ/ZnyAMFcd9ACZNuUBpfLPUY/UO4Nf27eMzIxeB2UOtI342j+Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd085ba-6fb4-4ed0-3edb-08db1fb5e5dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:17:11.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqwlU5gzZRBWsvVs1rRfpLDH29iAIb34WzZ0/P2XfVuV0B2+4dq2fKncBhRt+/04zOmq3EYnSnc6BQ9z09OIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080080
X-Proofpoint-GUID: p-7KEE5-qJXgTEMG5j2MkT4g92TOfBVs
X-Proofpoint-ORIG-GUID: p-7KEE5-qJXgTEMG5j2MkT4g92TOfBVs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/8/23 16:47, Zorro Lang wrote:
> On Wed, Mar 08, 2023 at 04:03:57PM +0800, Anand Jain wrote:
>> On 07/03/2023 19:38, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> This test may often fail when running with btrfs-progs versions not very
>>> recent. The corresponding git commits in btrfs-progs that fix issues
>>> uncovered by this test are:
>>>
>>> 1) 6f4a51886b37 ("btrfs-progs: receive: fix silent data loss after fall back from encoded write")
>>>      Introduced in btrfs-progs v6.0.2;
>>>
>>> 2) e3209f8792f4 ("btrfs-progs: receive: fix a corruption when decompressing zstd extents"")
>>>      Introduced in btrfs-progs v6.2.
>>>
>>> So add the corresponding _fixed_by_git_commit calls to the test.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    tests/btrfs/284 | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/btrfs/284 b/tests/btrfs/284
>>> index 0d31e5d9..c6692668 100755
>>> --- a/tests/btrfs/284
>>> +++ b/tests/btrfs/284
>>> @@ -20,6 +20,11 @@ _require_test
>>>    _require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
>>>    _require_fssum
>>> +_fixed_by_git_commit btrfs-progs e3209f8792f4 \
>>> +	"btrfs-progs: receive: fix a corruption when decompressing zstd extents"
>>> +_fixed_by_git_commit btrfs-progs 6f4a51886b37 \
>>> +	"btrfs-progs: receive: fix silent data loss after fall back from encoded write"
>>> +
>>>    send_files_dir=$TEST_DIR/btrfs-test-$seq
>>>    rm -fr $send_files_dir
>>
>>
>> Along with this, why not check the btrfs-progs version using
>> 'btrfs --version' and call _not_run()?
> 
> Does this case expose some known bugs, right? Or the failures due to some
> features missing?
> 

It tests for a bug.

> If this case uncovers some known issues, then the failure is expected on unfixed
> version. We should let the failure exposing, not hide it by _notrun.

Makes sense.

> And the package version is not a good way to jundge if a issue is fixed or a
> feature is merged. Due to many downstream packages might merge some upstream
> patches independently.
> 

Yeah, I agree. You can guarantee that if btrfs-progs is plain vanilla.

Looks good as it is.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> Thanks,
> Zorro
> 
>>
>> Thanks, Anand
>>
> 
