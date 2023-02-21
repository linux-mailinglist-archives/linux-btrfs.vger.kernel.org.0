Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5294E69E267
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjBUOfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUOfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:35:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330AD2005F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:35:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDgLrK016257;
        Tue, 21 Feb 2023 14:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yD6rTTIBJNlW1TOSJZzIibdOe+/5pliMb3CZo2SzSp4=;
 b=KV997q4oHePmXxes01di+VVZqCziQCwmouQ9oxxChQL4u5Z2mK6qQSg0SN3c9WeEM93D
 QdL9C36/oR67RU0fWLQsJF55T0KBfuYG7zE4BFfDXcU88pPrEh2Lxg6sO0rvXxZ/cafe
 ttYn+v6zVus8vIqt20EcyHCrpxVrvg1IgfPjfY/F6x6lgycNsC59X7bTdVMJA4TY1liM
 uGbmNfPcJWVviY/0eZMuiNJYS0zlQPLx653giyIN03BeyUUzQX+GCatzdtZ39nYHji06
 NZHO8CpGWxrCz1ReCJINzLItjwpJn5I29OaWGfRDlQWWdJCdRW0VJHGs70R3R4AId1AE 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dnaw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 14:35:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LDsmWL040879;
        Tue, 21 Feb 2023 14:34:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn455s9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 14:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5Tw60EyYA1dHNnDulUY4IfarObMJe8hTLAo15LZ8V4hftCBlOYfGYe2qWNIJsQs4eTNTRSQyr950P80363Tc/p9w+mYhLdnJilkARteqdJ2yhoOZle/IRZEEmgaLWVuMyA/VyYgwt/7c3yTEhNJdHo7+DzvJ5WLg9HXMSMuCao8jxi4YsAUcevRMZMoxBWTbe3t5D23m9swvIav1VrOkgBHmGf6/yCqaLkoqelvq22FDizdOHBX2AFpPHzJW4sYtQ3nHtdxDO6WkAcD4BJL3oedukXxDThPxkB2dcjY1RJcqDsj8eoBDk0Hxza7qzc6InEEGfLprB7dIJCKTzMhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD6rTTIBJNlW1TOSJZzIibdOe+/5pliMb3CZo2SzSp4=;
 b=lxswm7W8TPcCc14SvTRS46bj5lV9TwCV4hApmsBnuGA6Q2w4wNl+upSa9Eoy7q3PYt06QLgXtkgBQzIQxwI+XJN75mrK3RcfOyTVHOsMB6x/q9IMEkNqvhJe3a6kjrFmFtZgNibVI9+z7wezOTvw8PLbl42KLC+Wyl2+urWLzQiG1XmUfm6WiD5lXMerYwnFg0APzC6XQxAqhKeJnN9W/rFN9WbXggqQErjgqlXZGsmARjz+mesAzRtq5B+aWGNq508gZf/8RFOtL/gxQwwYWY1Q0rfC1kJQhHZb0E54Kd64i6SXq0ReboSRNLdRjZkRz6wXJ6YYiz9zZ2aOSucY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD6rTTIBJNlW1TOSJZzIibdOe+/5pliMb3CZo2SzSp4=;
 b=TjrKaKArnsh0/x18OmpGGrTPCFQo9i8DWocWmgOeoV4RpCYj1L//I+mmiYMTivbmcJYO7ID9+mPdtMXmLqCCTtE/0xbbLywHn9MGHipvuUZcqvxeV459SHICsCk1QxOFiJpV9PP2ozvg0JVlMk95wGsu2RO56fGAzMoOxNriT+w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Tue, 21 Feb
 2023 14:34:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Tue, 21 Feb 2023
 14:34:57 +0000
Message-ID: <097c4154-a6b4-d5b6-0476-d8bc3a68913b@oracle.com>
Date:   Tue, 21 Feb 2023 22:34:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
 <b92f9adf-111e-0640-849a-8d85b2a171c8@oracle.com>
 <91a459fc-ce07-8f89-8121-b7d18906a3e9@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <91a459fc-ce07-8f89-8121-b7d18906a3e9@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: af47249b-f987-4e36-a786-08db1418cdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyCcaBPZCNYhAsxkxBkMRj0Yunp2mNVjwkLRsWjHhVh3q4GHZqgBalB+iUb9oSwrjSkVTMEzrHRTAaVbl6tnwL4AdmVpfdafzcUk3AQhixaWTY8Cb1gS+IZV+Rpnm1icyPi6x/wEOIj3ZkiJqhzRU6dV2tSAKAbQ3cAT6/XnuRVesuivndbW8zWDrjapYVFzflZ0HFaPTY7Ku9OzahvRHsgvmPDd2VWvAeOTIaa+BRbo7Mn9VMi4tJoRtIMlrlr24DmPSaswoyz0scOl7IHJihzKK8b4iZgiWj6HPMmHF/elnq4zCt66rxVjXI5lAk0fz/kbx/ch+wXcgb9cBR0GTeDE4jRVvKwvl6lxKjqeiAKDMYic2i1DQUCcQGdzgcBjrUO204eLfO2jvMGN0JvjNG1xVzxbXCHYjc7J8jvVtIwrxAc9GxHhlxyKZEfN3IIvkaEhCVtnq3sskGDyB4Wg3hbNpgAIGkSecG9tRLYNW30iIaJJxr3UexHFL/Z90d7LS8WZun97dRSg7sA2b6K9k93RVZWXpylgPM3/PWvylweJouRNTWQb2+ikHyBGk05XMnJQiUalhbMKUSXXbFApw++BCBThNjT0QfwuInFPnO3BJ/YZtS+56hv7d18fsLlCoH1pYUirFMlNHp9/X5HHaDPMnZveEbozmtAHjbIHVi02nXPU/2mnkHRkF9JbzZAHQuUJk3gdsVjVZQHaoE5kzZ2MVovbcKR13Ab+K1EgQ70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199018)(44832011)(316002)(2906002)(31686004)(66946007)(5660300002)(83380400001)(186003)(26005)(86362001)(31696002)(110136005)(53546011)(6512007)(41300700001)(6506007)(6666004)(6486002)(966005)(66476007)(66556008)(2616005)(38100700002)(8676002)(8936002)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ovQkplM0VlSDdKeXlqLzMwaERtaStCZEpMc3hucmxWdDFvR1RtSmZTbU1j?=
 =?utf-8?B?Y2czWGtWVDZVOXBIVHBUKy9abkxrdlAySmZMcmhGZHFodVBTbEVXS0Z2WWhS?=
 =?utf-8?B?Z1hvYkpDbFpKYkJzbjVpalgrNVRMMzhGRndFeHVLQ3hKei81by9RSVROT1ZM?=
 =?utf-8?B?dHNjcHMwcDFOaUNURkZLa2pkSFRiVjBDTWhOeHB0bG5NR2hxL1djTUZpT2s4?=
 =?utf-8?B?ZjNhdkZ4Q240NENncEhVa2dvRVByZ0hKT01aMEJxbGNQTTVYcjRNWTZWSUNh?=
 =?utf-8?B?Situa2xFSUJWenFSdU04R0tDR0ExRWIyRjhYNUpNczZPL2pZSmhNUzNad2Ri?=
 =?utf-8?B?dllqeWUzOTBiRVNlMUVSa1FMdTA5SnZROGpsRDRiK2tZTysxKzBva2ZlSEFO?=
 =?utf-8?B?RE1HRzRDNmxXV1JETzJIWVQ1YTlCL25samhWb0kwMit6YzRIdmpoNStEa2xq?=
 =?utf-8?B?aVBRMi9IQ0NFOWhoWUV1K2EvcVZzQW4rOG16SUF1N3hvTlhtOU04cm9YOW91?=
 =?utf-8?B?b2lCeUpuS2d2MDNzdEZQZ3BubzZxbE1FZkF4Ny9KQWp5eUN0MVVxR3ZLR0FK?=
 =?utf-8?B?dUU5bHQvNDhhTWx0V1VLYTZHa3Z5OFMxOWtDLzhjZDR5dzNzRW55NDAyVDlt?=
 =?utf-8?B?aExmTndGcVJTdUNNTHlHdDF0RldXL2E5aFd5K3djWG1hUHhsdExNL0J6YW1y?=
 =?utf-8?B?bDRSbWN0TURlY3hab1owenVLeFhDbHJCbUhBZW10NW41OU5lYWFJWnZrUWVX?=
 =?utf-8?B?OVJmU0dEenZIMVY2NTE0cy82V0dqRzUwUjg4RHl6bHhHRmd0aFFTVFR1RmpF?=
 =?utf-8?B?WUIyS1NaT1dLZ2VQTEwzSFNZNC84ZjN1SE5EL3NuRURSVmhJMHpKRXc0dDlv?=
 =?utf-8?B?aW9vSHNSNkRWWGRicGdGRUxid0h2RGkzUFdYQjBMOGpSL3FxY0U4TExGUE44?=
 =?utf-8?B?NWlYYkxMYXJjTzViYWtEa0tMSmc3THBXS1gvT01RSXFjaUUvWHg3dUJBa2hy?=
 =?utf-8?B?Sm9FQ05rUW5XSW13SElZaHRENnJYMEdoa3VMd3gvdEpoUWlYejVqZTlIc25C?=
 =?utf-8?B?Q2wxTXhxMTlvVnhlS3NLOFBRTEVaYVFIVjFsRmhHS2JIN1R1eS9zVndYQSsy?=
 =?utf-8?B?ckwrVU1lbHF5bTBTZUg2OHdMdDVoZHhFM3VwU0FxQTNlN1hibGRmdGljS0VI?=
 =?utf-8?B?cGpUQjN4clpOTmQwOElLa1d0RkFjQkZ5bVRhZUg4SWs2Q0lMNm9IM1Q3OTYx?=
 =?utf-8?B?c1RnKytEN1lVOTU1cW5paWNDODZIK2lOOHhtNGZqUjQrbjR3OWZsOHRpWXNS?=
 =?utf-8?B?MExOQWhpbytFQ2wxbXg1OU9TZStvUEtybjVVcWxURi9FaWpUem9IbnJUTTdo?=
 =?utf-8?B?UThUVzlXM0VxMEFTZnRnY0l3QU5zRWhuazBneENRejJiTlVzdzRlRXV0NUFa?=
 =?utf-8?B?ZlV2QkZzSmJVN1RVZ3Y0UGdrbTVNYWZ2T2xWZFh6WTFGOFdCT2ZpWWplNC9j?=
 =?utf-8?B?M1pFdVplaTl5OXVlb0t6ZFF0a09uU1lwWmtnUDUrZStJRVRTdGFqZmRRTjdY?=
 =?utf-8?B?SSs0MDd0VGZiSFVoVDl4Nmc4dE9sZTlpZ0RJMDRyRGJUNVJRczY1ekZ5Nlh3?=
 =?utf-8?B?d2pCeWR4NmVmWXNZYXBvUWNYRWFCZUk5SG1TOTBzd2Q2cElXek91NXd3RkxE?=
 =?utf-8?B?WDVPYlp5RnNyVjZmSUc4bnJSVkVGeEdlQUFWNjBBZkRwdDBZY1hPRGIva1lr?=
 =?utf-8?B?dGZiTDB4Ly8wd1R5UXUvNGhkb0kxK0lFazZmcWtWMWtLdHNaZE1DZ3ZSOTFk?=
 =?utf-8?B?dGR4K1FzREFkdDFtVjk3NlhQTW12U0c1YWVQQTZpeTRkUENmeTd4WFlLMmxT?=
 =?utf-8?B?UkFrdVY0aW5mQ01ncXBnc0dSdlRlbW9wYXJ1TXZSNXNaRDcxQ2dyaUIza0Jr?=
 =?utf-8?B?WXVJOUhCMFRaMlBPamRVNlBTTm82emdLazJ4bVFsQ3podWxBVDErMHo4ZEdQ?=
 =?utf-8?B?ZmJ4djB5eEdLbGllWmxJUUNwcDY2Z1Y3SnpaZEh2bWN3YVJNWnF0WEgzMjZu?=
 =?utf-8?B?RllqRDBSQkI4c25HbWN4UzQ4TVVDSGhNVitsNXlKNklSeWlJOTdHbmRHMXlV?=
 =?utf-8?Q?gqACBxHLAUTRMNSF9ajDhz/FA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mGEHR0yHVAOiOj9XB3dCgZVT+J2nBvOkmSc74J95OcLgvX1z1cW2PK2oX3lxrAqyM/DpegcwM7RFdgIKoxl/yRtbmUr4A5WqfH6P41xHZjJn114UdqISjSKC2Hps7QPturkszy1wrqGDfboaFWYIXOIxbYCto98CnzMPBZ/yYbNJkxp9JOZsrwBlM4zx6O6e8frHscDButY6AwTTBM2lka/+RrwWQoy539ee369O9ukrYex1S+yM8BMCtPCLFo0l+ltlMuH2XGlgBP0mdPvtML/NC3AyUkBzRuPUF5veXXT1A03cb45bagwK9BUU9Ol/JJlxRqy6f6JWH1b0hFv7+xyhYN0eXn7Eau2qCQ1aWJ3HoIbJjUvOqowUoodvFDFnX1uxTA8U1Wc3bGPKED+IdkSeI3/asTQU27Z6nXO/MdDiYzpKBf9Mk2FqceAGsSDVON7p1bshIG5+S9n6KDfSYXbN6Vfu2CUyauq73vjHClmxMMdrdju/kMkxB4jMRmEJksZl51FkBgJwxB9aM/ntLQuEViSSgXFaN6AorvtGbyX5GhlXwv85oGOilRs/gq1PnW1Br0ARBZU8p7cUOl1b/EOCnnjMwPR+/knGRbbNdq1BoMlrwu8VJd+Uo6hGb/fBi1DQ/tFidDHgZoX32E0lGsPSC0Zh8kLoUmafVCTIJ7JddYEcZsKYRXlJsa0H4qCLRpEl5WJ+jFjeG4MaBBtRHqepMHNleK7a2ov+SLcPVyogfazhnoi/QTs9pZdgmrdsTBMBEYa4YmV9o0uTfCQl++XIDtcFDWdCfI5w8p3LBsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af47249b-f987-4e36-a786-08db1418cdcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:34:57.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CofZmEV8qiF/kcCIn+cu1edExiYKZTTjTrm+mE+/KHYUlLv1FTD3d4RK4+teknZhT16PrPShlkY9XFXT7Mpjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210122
X-Proofpoint-GUID: kZlLrrx6sJ2M_r8UD9PCk3_Crw_wSHQ1
X-Proofpoint-ORIG-GUID: kZlLrrx6sJ2M_r8UD9PCk3_Crw_wSHQ1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/23 22:09, Johannes Thumshirn wrote:
> On 21.02.23 14:57, Anand Jain wrote:
> 
>>> -	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
>>> -	    btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio))) {
>>> -		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
>>> -		if (ordered) {
>>> -			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
>>
>>> +	bio_ctrl->len_to_oe_boundary = U32_MAX;
>>
>> Should bio_ctrl->len_to_oe_boundary be set here?
>> It appears to be unused until its value is overwritten a
>> few lines later.
>>
>>> +
>>> +	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>>> +		return;
>>> +
>>> +	if (!btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio)))
>>> +		return;
>>> +
>>> +	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
>>> +	if (!ordered)
>>> +		return;
>>> +
>>
>>> +	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
>>>    					ordered->file_offset +
>>>    					ordered->disk_num_bytes - file_offset);
>>
>>
>> Here.
>>
> 
> If you have a look at the original code, the setting was at the end
> of the function [1].
> 
> So yes it will get overwritten in case we have a Zone Append bio but
> I think the impact of that is neglectable compared to the better readability
> of the re-flowed version.
> 
> [1] https://github.com/kdave/btrfs-devel/blob/misc-next/fs/btrfs/extent_io.c#L971
> 

Yeah.

btrfs_bio_add_page()
::
         ASSERT(bio_ctrl->len_to_oe_boundary);

Changes looks good.
