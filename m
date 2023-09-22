Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189587AB611
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 18:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjIVQep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIVQen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 12:34:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3954122;
        Fri, 22 Sep 2023 09:34:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGNktj002171;
        Fri, 22 Sep 2023 16:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=V9KZ4VQnFFBmnD6U/PN3/Kmdka57p0YbazBiQ9snINk=;
 b=EaanL9pT/uprntLJ4qwZQ8Jim5ffavV6iebHJ+sucP8A5lOpfNpPVdE5IX9cQjaQjK26
 KFenvuRxFF24BsDde8g9PpaJcEjjkXQrYmmfHwUw/7fpnWMLW5/4zl4m1+7dAd0wE+3w
 aaH4uLUjrLthnDyYjtwB/ttFaMkwKdoz602kYd+v98spNjqQjWzIwC9s7vchx4H40MoQ
 FsEhvC5cdLX15zexbZCKquaDhgu+khAiz6PPGAOXZFtMY+7bLFh7baZJCC7rbX14ut9a
 aHVa1ozQO2ZLk39ujyRbqt5Y+a3tIJmOW85JkkfSG4lD9xfGEOyqCP4HZg1+5o/P4PpI Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt028jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:34:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFCW38021318;
        Fri, 22 Sep 2023 16:34:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t92vxksmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh70qJyTBC001zM46tXouAtmmoG9kvpOIyWZrm3pqmXdT2r+J7V1s9PEvHvH9U/IKb6fhXB2R8vriJiGXTJxXtVEO2f/jxUd6mVWe6/hNUq5A0fbbiQxoO7udxMFF95gIQQhznkxPh82QMxIBMDfFyfYF2R3/PjVSxBtWFHZaN3Y4shhZJmhs43BIJ9shkf8d9JM51HXc/VD1nWxrhXaaDL2pxvhCMsezX5OkKzgayxYpMeXGd2UPe1QgjwGeyTjcljs7pIjNdQ8nhXZgpX/hBFWkNnSIQgpLQuvYw0OBECSGLfHBZipezrjgjsmlz83DE2Lwi/xPlt3KJqH/ZQQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9KZ4VQnFFBmnD6U/PN3/Kmdka57p0YbazBiQ9snINk=;
 b=nnYVn1IC2O2Yz4rRGcGBoWzFB083VOGhtXwpaJZRkx9uc/UxbGl10U4PmLj7VWzEec4gNXNdUWZfwJkbvHyXmAeLadImiwoahGF6EPF8ybDp9l+wFmh7OAxZpQoX5iHdWgoZF7YPF9lGWg7msmnqq1jyBzRedzi/9XgEXRf1JIqMQjHx13Bcmyg+RVQFX4rjWfu7/khBMhdAzDf1EsBfaAOxOwsHy1HADEikDyCG5l+fGaLyJVDO8hgd4dNsYpKgmIMx7WAuJSmNBXl+E/s2d9JJHreKYtZJMP3TqgzDf3DMISGlS+SavRcKy8LEcHtUsYupUin5bYdKbNq+2M0eaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9KZ4VQnFFBmnD6U/PN3/Kmdka57p0YbazBiQ9snINk=;
 b=jTbWPLUGFU86YECIxXF36uod5CwzX6kyx62eE4f4F9mRiG5H8kLr14x+xfhTlivjT+yxBlpCbLSlCIL+uSu7OajhX9Q5tC6icw0VI3FIS7ftnfnr9wHF3SmvykHlJ+czH1WAkb/UuvTQE8iBMXaiKPjcMJmCBoPAFuZebW3b4ck=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Fri, 22 Sep
 2023 16:34:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 16:34:26 +0000
Message-ID: <eb234015-a589-9b1c-b310-7cc64e9f7631@oracle.com>
Date:   Sat, 23 Sep 2023 00:34:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/5] common/btrfs: quota mode helpers
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1688600422.git.boris@bur.io>
 <e4ea95fc4d1eaef56aabe417c33fa3af350c860f.1688600422.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e4ea95fc4d1eaef56aabe417c33fa3af350c860f.1688600422.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e279d1-af4e-493c-3db9-08dbbb89c956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzZuWdhpRmu+NhiJFDwTOZCyPuZv97982/SL+f0YrXzBcNNJtGDwS/3edTM4nhbtIRbzQJOGaMy8k7pRFfOdAlNhq6AeD4S6iPvUBCMoQRzNnMSsuaraOSM63hEsvnks6C5dgc9gagoc2KIRHdDoxh2ZmDa2rrfeuxmzq5uP663vDJqSifBHvuUVy2s0Z1R2A8604h2OUIrFMzmkQFkqVXtnpBiLV7rt7K2Q7qZC4C2IMHL6LfiovWJeUkIbDW9julwSJkWh10A4fpInPg8eBKZfsw/PGeNLyDw36o73sD05MYFp2WfZLns2G79vY5gon74PEpDVZJ9AdbZ4ZtcmGw5PbvpCiPMgnagKn78uHg09/OMiVHmJEs0b6ky3JFaRhaxtf2LASLV4FKTD1zTgvYAimy13BIPvX7Mht6EdvFDF1Rxc7WBzbXXIUP6OEm7TdI+FNpVxfO6s5cAk0DcrAia8iYUy77Zrk1qyD3c8TbX4YaK9Vg+twMdcKcY8Lr9/wI66m4zl8mgvQSpkyJZTPvs8HNO6xRVtuQvmat0Nyd5uoVblJtdizzmuiDUkP5aH5W9Ir94bSWWzcC4AIhWTcloBNF2xXT2xx5wlrEX9zn+6GUo+VCO3XQ9KPcc0TSx3ePZ+XkjGe91ae5IusbjndA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(66946007)(66476007)(6512007)(316002)(26005)(38100700002)(66556008)(2616005)(41300700001)(478600001)(36756003)(6506007)(53546011)(6486002)(15650500001)(6666004)(2906002)(83380400001)(86362001)(31696002)(31686004)(8676002)(8936002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldWakpiV3VISTNHSWYxbU5BMUswbGNwdk9yckNKZkxiWG5ybUtsdVI5Tzlz?=
 =?utf-8?B?SUJzSjk1QUdSMkJQeUdGZDM4Z2RsaFc2bXNCREJtd1dZYWZ1L1pTc1grelJE?=
 =?utf-8?B?Q0Z2WStIL0RWT29lc014RzlWSmNpa2Z1SkZPQjJ3Uyt1NnNEQ0hwQ3dsMlpS?=
 =?utf-8?B?SWhydExRU2szL3U0bDFtdGJseHMvVXZBY1J3aElvUGtTa3lHUUxMZjM1Nm9l?=
 =?utf-8?B?WEJDNm5iS2s5UWxrTnRoc0xPcEx5UDV2Mk5nSE9FNjJYUUZZU0FkbU5oaTI4?=
 =?utf-8?B?QThIQzQ0bmkyUWd0ZG5yNUtQejB6aC9zYkxZSllFbHlDdTAzUzFLeXlhSGVW?=
 =?utf-8?B?RVVKc0s4Q0Q4dWRsaWw0SzBqS1B2eGlqTTlJNzVTME9ZUUZydmovNUZhdHNK?=
 =?utf-8?B?eUpjanJ4bjJWUEo4dEtwMkdVRkFzVmpUUUpOWkJFdmo5cW1IY2VqN0dNZGtj?=
 =?utf-8?B?NVNMZHRMYi90NVpPWXh0VmlCVUNsUWdPQzl4V2p6K0hRZFpZQWFsYTA4K0lI?=
 =?utf-8?B?WlBZVkpGeXJieitDcGRGWlc3WWZaRHhUY3VyWm5Xck92YmFkWEFMNDJuSll3?=
 =?utf-8?B?U0FDQkRIcGpsbmxUQzNwZmpFUXZvTzZaOVgwWk42MUNNcGVTRjBKOFVhUEZs?=
 =?utf-8?B?VncvU3FYNmwrSlBDdHJtelZSWlB3TXhLM0x1aEtkY0FvS2c2c2VsY0ZRUGtD?=
 =?utf-8?B?Mmw5SUt3ZE9NMWo2TTBDV0l3ZEh2eUZDbHhSbWJBOENueXBHdEJ1bTFTQkV6?=
 =?utf-8?B?c3RhbXZncElZeGZhN2tvV3cvZCs5YkVLcUhzM0RsZTFKR2IvMklxYzVuMDZH?=
 =?utf-8?B?akJSUXdueVZ3ZENtM2pCNnhESEx5Z3lCYUNwRzUySDY0ajBqWmpMaEI1OW1W?=
 =?utf-8?B?amFDaW5DdHVPWTY2eDVFQmw4cExqOXNlSmRnMFpGQXA5OWFwMzcrUXB2ZndY?=
 =?utf-8?B?TzlGUHVLaWl5TnN0Y0RYSWhxMS92b1ZjdEJwY0hKeDIzUldYRXJUaE42bDN5?=
 =?utf-8?B?dVdrTG1qamJwY3B4NWFLc3I5a244WDNhOUdpa1VnQ1ArQ0F6cG93Y0pxUURJ?=
 =?utf-8?B?Q0thc013aWc0Nk5VL0kyREtXTW5tQmxSUFpHVlVJVGFJVXdMS2xlK2k0SGZM?=
 =?utf-8?B?ekVHZWNGNkhDd05SdzUxY0FFeUdiQXplWk5SZU9pa0dJTU1peXVqRUllYity?=
 =?utf-8?B?WGo0NXZrTGthbkg1enpFNkhCQTBXL0wxSVNaR2ZqellJZFhGRmxhZng5UmFm?=
 =?utf-8?B?WWxnZ2lnank2bmRJNW03dktyT1Uzc202WW5LeTNnNjF4aVVJNnBHMk9KQ1pR?=
 =?utf-8?B?Z2lYSU1qQURYMk9PTXBlWk1XbWtsTGpXN3kxeDNYdnJLNVFXTDQ2bWpaaE9T?=
 =?utf-8?B?aUhKdVdLaDBqUlI0NHpWZW81bEV3WGNRb0Y4Njk0UGRzMG9OdE1tNGRQZ3J4?=
 =?utf-8?B?N0FsR2ZVT2lvd210MnVpZTZSZ0tNaWtYa2s5clJTL2NiSjdqQWJvVE9ZTlhT?=
 =?utf-8?B?ZUhZOHljTkVqdGtseHNjNSt0UG51UkVhWTB1QUlIdTRPSmJZaEVnaktoZTUy?=
 =?utf-8?B?L2U4MUthWEJjeWVoa0NUTkFxUnc0bzQvRlVpd0dMYkpUeUJGWjEzV0NzS1p5?=
 =?utf-8?B?bHhIdkxvRFhtVlM3UnVibDJDaHFWTGRMRUEwQjdQN1FGUFpRN3BsYU8ySVB6?=
 =?utf-8?B?RC82ZkZYRW5hdUZIbDVkcm02NDFqdlZUVzlmRnpRYVZ5bUVsckxMV3pyNXEx?=
 =?utf-8?B?SFpYVWdSTDR0djluODVtdmZLbjA0azNNN1hVaUJYS0JLSWVFc1UwZE5HTFRR?=
 =?utf-8?B?ZHZvZnpnWWZHL2FoSTBOYVErVExnbStrTm00WmF2bDdZUjBiS3VOT0YwSkM0?=
 =?utf-8?B?Ung4UDgyYUZnTzFvVmd1dGwyQTRreXR0aTZmTUJ5ajBZaG84ajZKZ0VpRE5a?=
 =?utf-8?B?Y1dSdjZtTTU4OHFRK1ZXSWZ5Q1N0Y0U2ZVpFeUdsYWJHTUxvb1pPcnFwSVJC?=
 =?utf-8?B?OUNyVjR1WVBiWG9CbjZnTjROUkJKQUdHWWV3aW9JcTVyZWxJUk1jWHh6NzlW?=
 =?utf-8?B?UXkyazNWY2xDS284V2d5aElFcE1TTmJLdXJIM2FBWjNEd1FJMG1hNzZYSVBi?=
 =?utf-8?B?QTVpa3locm1LZUNmVXZZd1hBVnI1b1BBaitKQzhkeXd4dzE2V2ZMMEtqNHVl?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j2gC8rX5+sGgQfNxGnoSwFN+yJxYm5QDVmGNQR8faG2NYTUwqEJD06Fn93cZELz8d4fDJ4o7YP2Nl5O9lJzhhZ1LV5Ezzm0OrXicdEu4v8O2uFNFMqEUatj2o+ChSDlEAVYxKwbXdP+wHIiutQRXzxQay8w8NZim6M5CXDLLpt7RR/5WAX9+i8/eaaEOwPIgltxk23U3BHaKs7VgQS70gCo197lG0Mfroi1O+NtwNYAbnFBeWldn7ILXGfJl/KH9PuE0DDG5L/5U4M5qgYPCtsphkl5vQFM6RQAOy6hm39GYmSiNKeagFs1VbB8RdCxdaBSsPhZAFQ9g4c4kRO2TVCY/8h7bpdGfUT6mQv4+f3nZbhADn+c+NJp3mClMIQWck08Fiky5QWxKmoSNorXHnmv5RSNsf2TvCQ/vFy8tbZMWJl0UrEOn3Dm8ZYWb2OkhhIHLYrkbP+Y7zxerIhtnbNBqmJ6HwrKGPk07YEQ6ma01l1d2eVDM4tOBDXo44uj5PlpWTvEm29Nph6iEpZ3I4hmMOEFmn7TgU+w7O0A/+NXdsLKQ4KVCLpvTsdyYUtkLZa2ZaV3blrjlLhVpnzkCTW3/pAt040fGX/fHVl4F6CBeddEyyhmhhiRVrMhrpKFgYlQDfv3+Cy9C26xNga+MSBT1jjUJwCaA9L7EBeBXY49yUFV6CSK+qr/jYh+pVeg01SwR0KZ0dJBS7pgVXHIW46Mn3WdhWMRHJElsSJAE0a6WYpQTKJrlGKsQ+MS1eVsZ5lblhslgxHO0pUKVdraAdzP0D0/TSVZTjxRgBCgA7Wk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e279d1-af4e-493c-3db9-08dbbb89c956
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 16:34:26.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWKxTD6fxTD/gWZBEqRlTZAZOIMJ/K9TmfRJUv6jqp+IWPx233hiRgaC9l30nOjXZoH4C/X+uyD9sG10fKwu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220144
X-Proofpoint-GUID: Zqe6-8WgVe_ynUjCeBvDABF90LGvZR80
X-Proofpoint-ORIG-GUID: Zqe6-8WgVe_ynUjCeBvDABF90LGvZR80
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/07/2023 07:42, Boris Burkov wrote:
> To facilitate skipping tests depending on the qgroup mode after mkfs,
> add support for figuring out the mode. This cannot just rely on the new
> sysfs file, since it might not be present on older kernels.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   common/btrfs | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 175b33aee..66c065a10 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -680,3 +680,46 @@ _require_btrfs_scratch_logical_resolve_v2()
>   	fi
>   	_scratch_unmount
>   }
> +
> +_qgroup_mode_file()
> +{
> +	local mnt=$1
> +
> +	uuid=$(findmnt -n -o UUID $mnt)
> +	echo /sys/fs/btrfs/${uuid}/qgroups/mode
> +}


> +
> +_qgroup_enabled_file()
> +{
> +	local mnt=$1
> +
> +	uuid=$(findmnt -n -o UUID $mnt)


> +	echo /sys/fs/btrfs/${uuid}/qgroups/enabled
> +}
> +


> +_qgroup_mode()
> +{
> +	local mnt=$1
> +
> +	if [ ! -f "$(_qgroup_enabled_file $mnt)" ]; then
> +		echo "disabled"
> +		return
> +	fi
> +
> +	if [ -f "$(_qgroup_mode_file $mnt)" ]; then
> +		cat $(_qgroup_mode_file $mnt)
> +	elif [ $(cat $(_qgroup_enabled_file $mnt)) -eq "1" ]; then
/> +		echo "qgroup"
> +	else
> +		echo "disabled" # should not be reachable, the enabled file won't exist.
> +	fi
> +}
> +
> +_require_scratch_qgroup()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	_check_regular_qgroup $SCRATCH_MNT || _notrun "not running normal qgroups"
> +	_scratch_unmount
> +}


Can you add _has_scratch_fs_sysfs() helper for scratch?  See for example 
_has_fs_sysfs().

So that you can do something like..

if [ _has_scratch_fs_sysfs qgroups/mode ]; then
	if [ $(_get_fs_sysfs_attr $mnt qgroups/mode) == 1 ]; then
		echo qgroup
	else
		echo something
else
	_notrun "qgroup unsupported"
fi


Thanks, Anand
