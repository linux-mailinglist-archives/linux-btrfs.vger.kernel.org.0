Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7170B6AD43E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 02:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCGBrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 20:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGBru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 20:47:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7220D25;
        Mon,  6 Mar 2023 17:47:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Nwglx026359;
        Tue, 7 Mar 2023 01:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hXimgXWK3RGYEHm5g4G1ATlLEHq/MP/j4UVYtV1h6eY=;
 b=ZVWUitEDt+n0ZdMD/y6QSBF0OGRBocUqbNl54Mb/wWi8dcdH0KrPe1Omtl1LNOW2QRvz
 0BSiE22mLLD4/lQTKIRzNISlBa1YDNhg5E4Dwk+9ehQXLO/zrdn5fWB35iM1ZqBI4f5b
 6h2XRS+G0d83rae0aZxBT6qtyzmNB9ipq9jZiIHOXL+zB8ibgKGuC/E2qXfVcIEIb4RU
 hRCl9M3JFnWzvy04Y5mDc9w36MfcupVCvblgzCHA0X1AxAouY5sh91DrADpleHbLPC0C
 XEl1dld0/UGdkABEtrBIZ8opUv+LsGFMnurNNwRTVlApPvs9JnYcfT+1UonXMYD7uad1 Kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180vcu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:47:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3271k0Yx037293;
        Tue, 7 Mar 2023 01:47:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4txdtyhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjTAIfwtc7VbWU5k7bWfAAf6jjtL2RT2P0UKXdSaWrTKPDm+XEm5rPyVdwlJsnbwptX8jsnbzj3HtGqupKwCiac3ufvi4ZhuLA7E4Na9aMr/4ZQnYH5kb+FyPUnL+5B0BlxCnHna/hUTs1UBG33xdmhP61JGxLGEZrmHBcN2BLdzCRvVw0JwkgQfVOAVDSVywLFsttEX01ZRjEaBBtWOoSYtqkM0P6EAPejf1MB/ytmraxpLl/CEz64Adp6Mcv6DSN4SQA8m1dMzGTcoyp0A7ji+VMuJKO5GKc54BdtTQToOWbndtnW6HskESa7Ko3L1zD61HxqtCh5zlmFp4TiJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXimgXWK3RGYEHm5g4G1ATlLEHq/MP/j4UVYtV1h6eY=;
 b=echl8FxS8BYIPzA9wy+zcTSkCCP+3zvBZ6Y6QhE0NcpxFEI52cNH1WvDj8iaL+srVpxItn6MKzz8q6ZlP9B8qbMkyNGiWNYbTeGU/iksAzPu9e54OOCwb5/U9aEuSgi8OexoR7d80kIDBOX0IC8OnR9IecmezZ74j2M7C80s1uLWX2RImRHKgeI0H2PRQ5rCrrpiuiaNxvZcMdyTVn6q1guKGJioxQFBaR0sZgCV021o4MceCGB/gi119AQIeh1srL5STKIPKXEd/MMi6SM9363iCVuDZxcFQAbUgZzv1WUJHqg0wsP68NhDXlmuOr59kTKlHsLFUGzoCaOO+q7LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXimgXWK3RGYEHm5g4G1ATlLEHq/MP/j4UVYtV1h6eY=;
 b=W8Zy43PtiAa6bgbW3Oor0ezk1GfXbfXZL99WejAlUoEs6UuSyUOSvMDC4Y/sVUBMtLxeb/0TmZs/hcGSFz/CeYDPQsJxKzn1WAGi2wJy8GYodqR/D7cQ3a3k14t7B7ktoKPaUlgIuKtOGpxFwUJ9pCiDfZljcMKzTH3TV1gbiu8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:47:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Tue, 7 Mar 2023
 01:47:38 +0000
Message-ID: <03ad9240-584f-9c39-d9b3-fe88016c29f4@oracle.com>
Date:   Tue, 7 Mar 2023 09:47:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] common/rc: don't clear superblock for zoned scratch
 pools
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        David Disseldorp <ddiss@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20230302100321.566715-1-johannes.thumshirn@wdc.com>
 <85aaae82-4a67-f7d8-885b-d2fbeddcc8e7@oracle.com>
In-Reply-To: <85aaae82-4a67-f7d8-885b-d2fbeddcc8e7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7128a7fe-99c6-40f1-58a8-08db1eadeea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qg+8piHIWvW4K0PShmgmikX+RcAZAuTmvAjn5eBlFAYFFYFh2enomffCzYvtpBJQsWJNrvuFbSsRRIe9z7sTbCWjCVgf8xUuhh4z8Lv9t0HyLTFXQl803fINySVEjZ7IXbY5L27TGh5+K3mhTXYs2p1sE7KQSj/zJanDxMWyxibqs04NjEsulr3O/lS+mS/nGJ9EyRrZ/vQj0qhtFVvKs1aKke43LwrpoAEOqBHSE4lZHjlDqHHZNfrgs2bchTh/DUy5rg+LMOrs4KrsbOBLSbP2Eq2c+cN7VvR695ATnyjuIw5+l7uviXgIcqdiPO2AZvuODwV3Rsg4u17gs6MRrkGYG2naHmrYbjLiLu5gSCx6InVY3oN4pltzIXZLjM32N/4dHobd0VzGRut+8/zXQyEcCyIA6xXAFjYLTTzxbtY/CRSHDfi3YXlrddAwsCgNlqADJ6Kib14/aW6586G6zAe7OEbUG3LWLh8cbVcsfCDWVVbj5qtIZbVs8fE6uKyPeog4J0DqTo4nVltfvCIbHPPTPeZJyFgN2arfP11Zhpq40Z7EURTa/WLNTEINwzHUkMbvjbHyXbaMZmeCb7Qe5TFNtBYcKueA9ib4qRowuast3IW711brziSgJwCL2WvHgyS3qRWKv3WVhELXk5UHRR93Mrk+AUn6wvwkToc3Xd8iNdfahf2k8AnPEeL3f0waQT2BtsLKZ2hpjr5qQS1x2hWqi07HO9ftccxsLwMJFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(6666004)(53546011)(6506007)(31686004)(41300700001)(4326008)(2616005)(110136005)(6512007)(6486002)(186003)(26005)(66476007)(66946007)(8676002)(66556008)(478600001)(83380400001)(8936002)(38100700002)(5660300002)(44832011)(2906002)(36756003)(31696002)(316002)(86362001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpsZ2tHVEE0QUNoK253NkIvTmZtUEtsZUpYZUl1a2tFYXdJSGpudU42bTZR?=
 =?utf-8?B?eU5scFlnVWp0d1VJdHpjK2Uzd3B5RVJPOTJzNVQ2dGg2N2dzMk1rL3pkV2wx?=
 =?utf-8?B?dFZIOEZ1cytDd3VDL0t2V1h5ZklxbFJZMERpcTU3UVZBcCtUMmowTnU2d1Vi?=
 =?utf-8?B?dzRwa2I5cWQveUFKYmsvOUhXZURhWWthSkRPbjRSNUhad3VWbVh0UVI1QVJy?=
 =?utf-8?B?eXVuZzF6TjJkZWdsdGxCK25OYkRncHJpT0hQajVEN1M2YnoxMWZHU1NNcmNB?=
 =?utf-8?B?R0oyMXNUWVRaSDg3ZVF6TytuejRMQTFyZWZJaE1Hd3k5bVhTNVFscDlwR1l2?=
 =?utf-8?B?MnRWbE51S0R0dVdlSzBscnJxTUJNTkdPR3c2UFFpY1BsOWdTWXFrQzN0TCtP?=
 =?utf-8?B?NTBhOTVxWnducWlKbjZzTHptUUZUNTFlakd3YlpmTjF6Q1ZJNnVCaVJUSWZt?=
 =?utf-8?B?Y2xmcW1FSnFLQUw2bERTcityNHlGc21YSmdNVTZ5czBISERiQkh4cTZqMlBa?=
 =?utf-8?B?SWhSRFg1dXNnZy92bytYOHAySHh2a3cyNFJ0eitNTzhnd3JrTHZ6bXZ2c2dh?=
 =?utf-8?B?a1J1NHJDeFdHa3hYajlkR2hmNHI0Rmd3NHJ0QWVZUWxTZmRBMnpxMEdETnNB?=
 =?utf-8?B?S0hkV3czaEhyVENrdXJrU1gyYVRpMnZ5MjlIYVN6NDMvMFJCQlNud3pkZVk2?=
 =?utf-8?B?MHlONXYvdEZZRVFpYTJMRlloZm5RNE9ab2wreklReEtnNitvSjJxRHY1WklU?=
 =?utf-8?B?dEg2QmpUM1lJT3Z5NmlUWkwvai9sc2huVm5tK3BNTTNsZU9CdlRDU0xmQTB4?=
 =?utf-8?B?czZCLzVoWFREbTNaSkJrNVFMY1lTcjhvTW1tOVFZdnBXZkZmdGVjelBLcE1X?=
 =?utf-8?B?c05FUzNJOWN2ZkJvRWpYdUNuekVQejRNNDcvRkFBTERmbE5ubnRSM04yWGgw?=
 =?utf-8?B?YVFZNWZIeG1xZFV4d3ZzMlpvY1pXcy9NQmVSbW1JbVR3QWg1Y1B3VGFVdDFO?=
 =?utf-8?B?cC9SR2EvTVNoTkZpOWdEbnk5RE9WSUNwKzJCbjkwU3BuUEZjbXRuZ1N6Q3Bj?=
 =?utf-8?B?cDlrd2w5cTl6Q2Y1aTJ2VnNxSzBmRjRPTkNPd3AwRlh0elVyQ3ZtQ0dOQW43?=
 =?utf-8?B?M2sxRmJ5SEhZQUdnR212bEdxdWZaSEk5UFRBRHZPOGJadTUxL1hWUEVoOGl4?=
 =?utf-8?B?NHcrSmNPbDVhS2VVa3VxRm9qMi83c0Z3RXQzemQvbWF0blk3SUFkb1lWSUVi?=
 =?utf-8?B?T3IxT2R0SVcxU09WdnVpdFRCYnoxLzJ3NDB4aDE0SWQ0Wkszb2VwRzZYYnhT?=
 =?utf-8?B?T3RvQ1Z3aWp3RmZVZnN6WWkzbGZ4TjEwb0pNUFI5eEl4aXJrM1BzN2JGdTA1?=
 =?utf-8?B?T3h4akVUam9lenhpOFNiaVl5TjJsVDlQUGtVTE1ETkRwaFowU1NtWTRBU1M1?=
 =?utf-8?B?WTlxSkNFNWppTkFjczZDTjVuYmpWY3NjMmIybThxVUFob1JEbDVaa2o0Y01h?=
 =?utf-8?B?eFM3RUoxUWtUMHdPcHJ6dnRia2NaU0dvN28ySVQwYk52alFaN2lUeWsvdFZC?=
 =?utf-8?B?ZkhqcG96RXVia3UwY0x3Yk52Q2UydVo4MHZpREd6RC9tYWhma0JiVHR4QW1s?=
 =?utf-8?B?S2lvb0loVmdJT1RlU2Q5MmNoU2NiS1U0cWhEeW5UcnJlb1d2WGlFQ3B2S0pv?=
 =?utf-8?B?alR4OVVWV3JCYkhSd3NBek45TXEwL2JUbit6MEExSG94VFp2bUxhZ0ZqcllN?=
 =?utf-8?B?NW1QeW9WRDQ4bWxCV1FTRi9mYTNURG9NRWQwMms0aEZMZC9rUnJQZFNHTnUx?=
 =?utf-8?B?WlJ5REd6cnZiZVVpM21aVzhsMXhJYVRiTlEwT0VsSU84MWI0dDZ1K3RIb3FF?=
 =?utf-8?B?YmdxRWhKS01IYnljeUZkR3Y0UUFtYUltTGJFbWhFY211V3NsSWF6Q1JmckN3?=
 =?utf-8?B?OExVdDhIY0g1Y0t6ekxLN2M0ZTdUTkFXZVlyN2lOK3ZvWDNBdWdseUJ1YkF3?=
 =?utf-8?B?VElZOXh2VTRsNnUrbWxRUUthTEtDUVZhbnBWZ0l2cThhSFFIWXRHbTduZ05p?=
 =?utf-8?B?YjJuUnV3UWo3Mmgzbmd0Wk9ORExFUkpRektDYkx5U2pMUUYwQk0wejdicFZu?=
 =?utf-8?Q?Ea+IEaNePgB8tesHcukv8BZyN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9OfACD6loqVu2ydioHOxc1FEBokrmly71v+jML3/YArsSO4xgNU60wSoVOFOc2+MiYVz/N3jejsIY7UcjMv/DZHMYpBnr69LW0edc43dhPtvHVSG+dRua1/AQ6/A/pckgs5Kmt5NRfFnxUCAEAMETUy9RhgFFLWZ4E8zPqQ/LYjVpNvTqu+/wMqlwUsMj7Lre61OhIiNosKzOEO2Xbx0/sc/GvTps7mEaL9pU/UmUUFyTkpILD0cuD/4vtAk6Hhf3KTrZeUJyjaHcCRupNdY+hqSnPNnEMnsVxvGdO8q6DGNOM56YlwRMWaVAZDqNRMXrUL20IEc+9LKWJguuEoz+syxW3WzyjZFeUAeRcVgGtc+ollXZBURJwVLD4x0wR3TsO2iGWWlk1dUnFmuLXzey86qTVgmuAQKVivl/2Vn4UxUEE8Q1nwt1V4N/AiUQuDGNoJfr0SECWZtgZOk0lFNExu6dMj48gKw0G/eIvAQvDC0jzw8T9wobl5wwgp5HtPAc1mZ4Ax2rYc/JLlBW4Aom1uc3FIYUXI6XvZsWqwkZHbxSzms9jtKZXEB0Wvgb1LcWYBz6ZIKzQaHnQucf9VDwTHHj1nyrTtWzmN6p7lKJ5zE1rf6coKbdcgmACtbMBhuKvWXUeTF3sFlBKCgZKWPf6tnbK+HfGGrXR7PjhgDJ96+gGO+80rPHPXMqS7ds2IfHFjS2FgoYVlC19VAI51ThuaV2+Ecd3CYqCZSKlMt4m74/yc99cQsAu3tEFhM573Zsb+QAruKfVWKxEF4wZYZamlL80dLGsqlbFQDNyIhX/dnWviZkgB1VrcotGR/KOEcycrN+0Qjn6PTG+i1USo/qw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7128a7fe-99c6-40f1-58a8-08db1eadeea6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 01:47:38.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBGJHNFR2ieivcm7nS4fnEmEs29HylFVA+YT6IkRZ6MTO06qf9FdDW4e2oiu3zzx0lTAf9+1aTNrwJjV1v5Yvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070014
X-Proofpoint-ORIG-GUID: 602YIIxjZATfw0bNx_0kIRzFrmK_7Fz-
X-Proofpoint-GUID: 602YIIxjZATfw0bNx_0kIRzFrmK_7Fz-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2023 09:44, Anand Jain wrote:
> On 02/03/2023 18:03, Johannes Thumshirn wrote:
>> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
>> clear eventual remains of older filesystems.
>>
>> On zoned devices this won't work as a plain dd will end up creating
>> unaligned write errors failing all subsequent actions on the device.
>>
>> For zoned devices it is enough to simply reset the first two zones of the
>> device to achieve the same result.
>>
>> Reviewed-by: David Disseldorp <ddiss@suse.de>
>> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   common/rc | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 654730b21ead..dd0d17959db3 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
>>                       exit 1
>>                   fi
>>           fi
>> -        # to help better debug when something fails, we remove
>> -        # traces of previous btrfs FS on the dev.
>> -        dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
>> +        # To help better debug when something fails, we remove
>> +        # traces of previous btrfs FS on the dev. For zoned devices we
>> +        # can't use dd as it'll lead to unaligned writes so simply
>> +        # reset the first two zones.
>> +        if [ "`_zone_type "$i"`" = "none" ]; then
>> +            dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
>> +        else
>> +            $BLKZONE_PROG reset -c 2 $i
>> +        fi
>>       done
>>   }
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>


Pls Ignore.
