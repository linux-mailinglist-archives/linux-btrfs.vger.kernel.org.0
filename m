Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F06705DFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 05:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjEQDYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 May 2023 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjEQDYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 May 2023 23:24:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BF1BF8;
        Tue, 16 May 2023 20:24:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx6PR020003;
        Wed, 17 May 2023 03:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pMng8CG5N18/BjYmtZhj9JEAGyz4GhelkZqmvo7Y7DU=;
 b=rFi+TMd6K2D9vpHLwATPLlxSO+rYkd8psbXfT1FYXsVBigk94pt31x3ohjbb1a9cYCya
 fQT9q0TUMYx2dq1JQraVLrwZo2O3JrZ+o1pQ262kHEK7JuVcdM4Y87tqdHjMq04nMLv1
 4ZOp9MGhOSQ9BUIOFU+WcvH0m51u2zkbSxowIq4dC6qHc7QC/Ut67tiB4qlAhQSCd0Y7
 UeNDKvYo6Z8FU1nEcmU835ybuEL23gBAyBb+J0+80i3UQKMSOYzXMlphc8q+AafvdD0q
 mjWnc3lGv21f5K/2G99rXKwPrpBZfepA+6FP1LVPQ0f6isYq8dkuypkMcd1zoBos9CHG 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3vvpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 03:24:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1oBYQ040136;
        Wed, 17 May 2023 03:24:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104mn96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 03:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiTG9lSuSbtehNcNKLP3+HuF3VXEvh9vXK1Z8PQT+ooBBgHG8wjWH3FH0h8n7GJ3FkSgG51llb+22iThpg3gGim0pKRZLQRd+NYVKEM2O4FSUQ/ILEzrZY6zXrcqHX+tpdJRlf3RlP6QBZJUSOiYqZWcSBIzODh2h/3vMB2F7yk13dE9mGG2GzR7p9FNG1L1S6nQv1hUjJLvmeGo5LKR+Q8DP1qBuN0h71bg6/+ckmigohikRMU3byGEQZ2H0qZWRD5c8D2GKBsH4Dgn7poWQoTJEL/mIPaGLsaDLfyqv6XfQIsCeS9ohfac4H54DheCd6fb46UT7hSiYOEl4W4vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMng8CG5N18/BjYmtZhj9JEAGyz4GhelkZqmvo7Y7DU=;
 b=a7GJYVBLaXhoPAa2/yb/efxdEjoVdv2pu08ClYw1MTrCy/rS57TbSuifmwJDJtOTvik+9LjE0grJSUMnAJQc/uc25HotRc3gvxfMaPTbJbL1elhNUhO5+YMcLV4d9P3vv6ezes+i+DWeCbxqT38SPdCxe7mRCTPzNe8ONpZnX7z4Ut4jMV6O6UomJVYCBQSHTAq7Ke6THoZ2oWlaCL98h6AFSb1U7trgZjjsD8mRgRRT1iSqx9PwdeEdBofdx7TVPx10ox5GFHBLRMz3U1NDgiLD3Ts2kFZM7mra4YHt0NxFAElJzu4TmOn7gpLBeq9rFdFv7h90oyDFN8nWmxW2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMng8CG5N18/BjYmtZhj9JEAGyz4GhelkZqmvo7Y7DU=;
 b=GeE+5e7is28zJyu+jfa0O3j7HxNQYPU7/AETswyuoTexsBf5iDHVvpiCMnp6cuz2UFUKTEHFhU9YWqLwQx4W06HjOQXuQcG4pgfBlUnScqBSvEKdUs+sqK4bmA27SwZrmIH5DmMCqVYxcKF8ttzcf/luYVEw7ZAXpguv+wdQiKQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7794.namprd10.prod.outlook.com (2603:10b6:408:1b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 03:24:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 03:24:02 +0000
Message-ID: <cc756d0c-815e-49e7-1f87-93d74eedecfc@oracle.com>
Date:   Wed, 17 May 2023 11:23:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
To:     zhangshida <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230516013430.2712449-1-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d9295c-623d-4d5e-a535-08db56862950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of5y2f7mjvbE4m7E9Jz+JMJj6k3z6odJvJschzhVFlZ5xXoGItp6eucYk1Zq81cAFbRz6Lq+EibmzQeZS1x30G6ILJeoPGAyWrwlKYPv8719l0LCysK3jfyNJHT5k5L+XTtpfAJwUDKLoz/isT/KV38+mq0ev41MQoqcdFKU66L9cLe3BG2QYBOban+1ThgyhxkixDtNdbxHI1I3g2o+AQA76TglvH0MhXvauJMrV0fgfhP/q04b7EsX2WGYUpl5Iqdd1toJNSsWf9yoMLhbZA5D5/EVWI8XJ75Inl+X+qhUDrx/r3XUcqAN72wwTJGSPOgvVwaeaoM0hskPR/SJ4/7MVYY5EtY/yzxd7RJ0AueBR5k+CYmRcNJmiUckF9pZ3l6oDOEIy8Qjq5r4xEEFTiOnsqoaT3YZSJYDW6iJ3VUc9qRJiqIH+D3B3PFvSo25atlcnxGaLmIEpyqLLuu1CTttAt0esM44WHoVF4vo2un9TyNnZfaC6wem2hKlnHZJFHBCbD0GS6+4cvL6fWyveiMBaIv+Sohpc9r2gvc/4pHMcMI4vFhaQn88nZVThwlftnA2oMS5gwer9RM4w3+3BVR3xV+PiP15Uy6DsxtgcszZhI2B7+HjNCJYQp5RrjUMzatGoKCVutB1jn41WZi4eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(41300700001)(86362001)(31696002)(31686004)(316002)(5660300002)(44832011)(38100700002)(478600001)(2906002)(4326008)(8936002)(66556008)(8676002)(66476007)(66946007)(6486002)(6666004)(36756003)(26005)(6506007)(6512007)(53546011)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JXQ3IzMi94bnVib0Q2Rm51TU4xdThnT1l2YlRNUHQyMExLd1pxYmtTTFBB?=
 =?utf-8?B?R2hwbHNsek5YdnNsdkdvMWc3djFsSEpsMGdnTThFRFFhVWFleFZ3c2htZDho?=
 =?utf-8?B?Z0pHbGkyaG9hRWZEOEJXQ0paM01ZM0g0NTViK2NMZjByaXFKVXNRemtNOGZi?=
 =?utf-8?B?STN2dzZIQzVpYWI0U1NwaDhZQ0doT0RJN0xvZk1NeEd0Uk5GaHBabHJHSGJh?=
 =?utf-8?B?cVVEQ3M0R28yeHlxam5rZ3RheWlIS3NpNEg3K1RHNVU5QVdvQkpyNWU0U1Vu?=
 =?utf-8?B?MVZ2dkZ2TzlaRkFtSXRlYmF6TlZiaFJ0MzJqVFRyd2ZkL0s2SnpETEg0dyty?=
 =?utf-8?B?L0xhSTl1RGZGM3NydGU3SDgyVUhpZkUxYnEzY3dQdERPVzFwaVpuUWw1VStU?=
 =?utf-8?B?NjQ3ZXhFeDIvcTMwb2hPSDJ0eUtjNkdMd0JWcFIrV1M1WXpERVN0R2ROajdY?=
 =?utf-8?B?YXZQMmJNbENvVFkxVldENXMvZGEraWNRdWFCSkZDV0Fid3J1RXd2T1RpNUR5?=
 =?utf-8?B?U1ZnRWpIRXVyekVnZ1ZLVlRyQnNhajZhZHFtU3BVNVlGUGU5a2h3T2RjRUhS?=
 =?utf-8?B?Zzk5ZzBoQ3VqbXdZMG5hZTB2UUtXaFg2QUVMaDBOcUdsUDBVU01LanhtQVIv?=
 =?utf-8?B?eFNBYmpBSkpTLzNXWkNlR1V1QWU5cFFCK1lMNWdIUytldmJuMHNGendFN1V0?=
 =?utf-8?B?OFMrbXlQWnFHNlhOTXJJMCs3emxBMEtiOFVyY05lYm9jeVRocFhNVG14MFM3?=
 =?utf-8?B?eFF1WnlSWVl5QWp4eW9OYVFSazc5WGErK09kZXhLNXdIV3hPWmJSVG1UdkxG?=
 =?utf-8?B?NW1PQm4xZkg3d0xKZk0yODBKd2M2a1FXRnFTeE01MEVlUmJycEtiS241bi9E?=
 =?utf-8?B?cE9sVHpQZG0wL0tQbDh4aTZOWldqUVJ6YWJiZGpoalM2NWU4ZVc2T1hQUmZh?=
 =?utf-8?B?cFl0T0FHdG9ldy9rWmNrUVpGbmM4M2pnR3g2eXZ3WllUd0NVbVk5WE5qOGtr?=
 =?utf-8?B?cXpuWXU2QVlSL2tlQytaMzkra1BkdWFrTUJIT2RHd3IzLzdPa2N3bFFYTTNH?=
 =?utf-8?B?ZHhDOC95ajBPUHVPYng4VVhWWm1oUWI2ZW1IVDh4b05wbURNYldqQXBPTXU4?=
 =?utf-8?B?UFk1VXV3K0hRaTdqN2ZLdDJCVUxoTGJFR3dEem5QOHRFWXY2NERsZGhCakdI?=
 =?utf-8?B?ejI5UGJmT3lXTDdGNWExY3J6dFR6QVpSRnF1ejZlb3VKQ282UUNZY0s4UmVp?=
 =?utf-8?B?bzI2VVdrYzN0K2tnOEt1UTVhOFMyL29YRnhCRWpQZm13dTQwQVB5eERzMUVO?=
 =?utf-8?B?V0xrWlRIWm0vQ3BQN1Ewa0RTV09qNXRFSGJXNnAvV3NLNVlMWnF2MjE2VjdX?=
 =?utf-8?B?NHNMN2hMKzJ0MGdjSTMxcUFHTGRiWTRJaFRyNFFqRkNIZlcvZ3ZvczIwbnBz?=
 =?utf-8?B?N0NZV0ZvL3Yvc2VXSEFiTU1vVEYrTzBjNDBvbWVHVDNhbFJ2enFzbzRiMjNu?=
 =?utf-8?B?ejVVelEvKzVVUVRIcUpZdkFCajZNWWhOS0lqWmlWNFVTYUFablhPSDhicUpM?=
 =?utf-8?B?dHdWSXFVeit2YmJ4VS91MFpIQWRFemZqQlVWVWQzYkp5emVKQlNiOVlwQ04x?=
 =?utf-8?B?VXBBdkJkTWkzWmlyRmt3NG1YQzBXbGR6Sit6NFZnSUZwVmMrbHJDeVhONlVL?=
 =?utf-8?B?c0E3RXJieks2YUVyeHpjbjAxNGRQbUsxZUxKMWg3YXplV0pTcGo5anVDOGF1?=
 =?utf-8?B?OEZ0b25aZjQwY3VNOGwwbVN5Ym51eHhZYm12SmMzUE5kWUd5RUZQUjcxZ1Vn?=
 =?utf-8?B?bGwzRU1ERkEraXRvVE5EaHhPUWh5eXFPYkN1OWczZkZ2MzRpVi95dk8zQWZC?=
 =?utf-8?B?VzRTcVhxVjlJRUhuSjZsdGJSZHRzd0VOTkxCV3dLcWJNQ2NRM1NrTmRUdTRC?=
 =?utf-8?B?ZEg4VDdhbjBNWmh5Ymc1VWk3WFlMTUY1RFFyNW1NOVVsbTdrRmY2VlB0d2F0?=
 =?utf-8?B?aHdQL2JySllUNXgxa2VXMG1waHRBNm56Yk9xMmdPVjFxOVVqTnlMTVNXY3dr?=
 =?utf-8?B?Rm1XQTFSdW12M3BSclFHeTVpMDBDbWsrOHgvd2t0MnVFZkk0dERUYnh4VlAx?=
 =?utf-8?Q?JLRUkqP7nakWtjsi1NFR0P/Dh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gvxkwrqWuRSaj8GyFnwlyKe7g01wnZxj5E2OxqWW45llkg6+seTQVlISAiqlGTwdRr/VwluuwThcyMA3l2o2aURDGt8BZc5hl7w+WIvim8+p5Pom3gYfsSRuyqj/4hvss0r9oKSpfrmWLpLfVKklYSNOGBGlVpphk3dag5cC4Gcif+fT6sBHRHuFt/qUeXHccLIEXrmxZyxGCsh9u/VvEYSyaW+Wjl5JxB11qiPeOWEf8iwBeUtiFAJIV/+AgYHXNrOM+35vNFmuLsYvmf7Xf2FWJKoLMsk/n6Y4jswasiyrzhGhaENRFf/7zvbSIHTV9LPDsS++K4Cht0SBHMqh7iC45dRcZArl1N0TEBJPQF3Nlw8Lww1mKp5Sv7ZMZAIx6Ybw9vg82avYTBBanIrZSg5tjaWtMHhKEVGtl0wegqQ1+tcq5FcgFh7b0el86VdvtoSMZuw0KoyNMWmEzOym0XtktAPrXw9FaM8yj4461R2Utvuz0zQBaoDbhZtGwz2/g/OZs4VRl32xJIS8HoSvdGQ2uW5EB8aJmCi6UGMMeuj9JzoVYVKytsBX2is6gtZ9eVXYwWNhWage+GyPumpzve+onz0cWiQAXFgiqrbuEp7SCTH8nJHofwwaJSwowYdmBxjLCtJM8Pm7Nchu8WoRDxMZx2CW9GpjAYw4aOmrJL7cX/5T2QKIwfii3BX8VeRnqRQ92SWQwrVYqTsMxqz4yTSNR757khk0R+X6WBT3xqToKzZpSqRmPW9145zJEwJCFYdNmpt0lWus+50ETgu7lNHNQ/Ql1fT0dxgH9w2Jdr25jUU57WHQBcpkXlorBYNLl3nXdRO7qtLf+go0KIc0vdPbyt56vOVxIaljsiljNwB6Q90tg8cyaxcu/0BujjtrkAQe6VODZL4h1/3HI+2n3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d9295c-623d-4d5e-a535-08db56862950
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 03:24:02.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4zCb7WnUND/YQQ5zJbgXeRnLlYrG9/yKmBLlbMxvwSlRKENwPx9LmekqlyAltdjRQuFnYI4g/VML8bnp21dew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170027
X-Proofpoint-GUID: fxYbMyBshnYdGBI98X3lb45Js5iwyhKN
X-Proofpoint-ORIG-GUID: fxYbMyBshnYdGBI98X3lb45Js5iwyhKN
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/5/23 09:34, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> This fixes the following warning reported by gcc 10 under x86_64:
> 
> ../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
> ../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   6212 |       first_dir_index, last_dir_index);
>        |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
>   6161 |  u64 last_range_start;
>        |      ^~~~~~~~~~~~~~~~
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>   fs/btrfs/tree-log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9b212e8c70cc..d2755d5e338b 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
>   {
>   	struct btrfs_root *log = inode->root->log_root;
>   	const struct btrfs_delayed_item *curr;
> -	u64 last_range_start;
> +	u64 last_range_start = 0;

  Reviewed-by: Anand Jain <anand.jain@oracle.com>



>   	u64 last_range_end = 0;
>   	struct btrfs_key key;
>   

