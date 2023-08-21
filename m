Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D27825BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjHUIpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHUIpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 04:45:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F822A6;
        Mon, 21 Aug 2023 01:45:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KLqb4I032449;
        Mon, 21 Aug 2023 08:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oHL7yEarvK0qMtcCpxvmvjJHSdRIEcssRao8fl3PpcI=;
 b=X8urEKYHjWAOmVWTnd9nN1Ro8hSDftSVCrkRyfLgFbrKIq/+WEOwVh7kwWyL7VgwtDub
 2Cy1lK3k4pqU3a4TYmLGIOK9hOSSyhZELV6cRZFOb0oVFs+YiwV1bbwtGIvoq3Wb56hZ
 77HP1OwNHGjO4/zYt+hYVjcSDJTX7gy2Mq3a2o2LcKr4Qx6arqjmldODInOix8yHCtOu
 PzilUJN9pNpg85MTE0lyOIwEZb9QqDPMwd/XFD97nQKCT37x3A+F/TSYj+wcG7qzteVE
 bwBzgbcJuO1Oo7iRMj3ZRqEdJAIOsy3Z9VeJmEoi56CrldnLQAf/sxVWNc1aXgsS5yRh 2Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscac3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 08:45:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8NYrf007649;
        Mon, 21 Aug 2023 08:45:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm636nrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 08:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu1ZZOGc3NVlz+nRxmtb1VocQiz822hUeuTQ4/4ecLBk4SwxFG4l5slibmYESS6wZEHicefgF6gWyN1OrvcdsfphNKzRVWSdHohzJINmZxTNnSyLibZQT/Uv1XfqiXvo4jXoQwCqfk7WfTrzVRcRuyfjOM+R2ttQbZBdCrtq6Qz/wN3UcxbbhqhFdJjVsuK59Gb6e/x3qXsC+yBhbjjCA6QvMxBF/PN8fFYNwfstXPMeNmx3UxqrBOQaE5Af0V8w5vwf0BmxrJrQFMl9PbqTbUGxw4aZFz4XnAL9mlkKnoxoGQsGljrkuw82Ra4YJw9d/4TYZtXHATlaK0zFvMefAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHL7yEarvK0qMtcCpxvmvjJHSdRIEcssRao8fl3PpcI=;
 b=LtY8/uNOeoR4OzPryi5u0eQmf1TIGGnA6MpfQZ3F1gkEm9b8dSMjok1lfzQ8V9AJfPts/qoOKnToemwpQ3I2DsQlE2DmP0sbzsiOMk1q7I4uexKqwTfcf2J6HEi+Ee04fOfqdbf0V1PWy+VszZFuAe+Yj1rFvOzfUkqCK+KpvpyMpVqtB0I+7oCgOmxzOo2KqX5TRIZ8susohgTVKaA8Q9MV7MU/pWbftJRw8bi78cC/Vwz206FrCKRhXkZZCx1M8A0886TaZxVQb7vqUiTPvEUzSRs+w0oXNepDo/mvOkF3ykrRBHsazOjE+b09i/QbMMQhvg2GfJIP2vG4kfRK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHL7yEarvK0qMtcCpxvmvjJHSdRIEcssRao8fl3PpcI=;
 b=NHUrzCO+LOM0dIOdby7qHQL72Jcmwwd3Re43nzamoE5ze8ayI8kP88VG/dhYl+OpD2wWdnrv76RtBjGzTXYEUwnEnlljC2YWmkoo9DW4u9RnPS5yx4fV/4AANQUc47WTE8UYsbix9EAnksJNorpH1dXpTjuXxAWS7DEbHD41M8s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 08:45:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 08:45:35 +0000
Message-ID: <61c927bd-3c13-9591-da31-f4a486902d7e@oracle.com>
Date:   Mon, 21 Aug 2023 16:45:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fstests: fsstress: wait interrupted aio to finish
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230820010219.12907-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230820010219.12907-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d69a68e-f9f5-4fae-ecd1-08dba222fc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNtcf/8YuiY2V3UPwm+Z71EU8o05BWO4zbTaWYYF/JREymzTA+9G0T5SR7AewpwH0+HZwB+/e39RhDyvvPYKbhBWoO8BGgQHeBlMaSFyzj3QrZ49Bkjbsq+vpS46PyqpE3NwlLsJZ4kSya3tc26P+22XeLjx/lz9M0f//A0b+QeMRwrGIRSHmv0EzwmYyAwVWI4pjvehW+8R9DoOGHYuHfEAofzh532BLo/LbROZ2o6zrJrN6Xj3j4GABRlzD81FjpICa86UHqOorUgPleebATpaAs8MWrEhWAk1bdShh0NSCBcMa8Bk9amBzWbc3Kj5Rmk3OC93SatB+S9daKoLHuC/RyLoL+5ZzjQoZ0IBo1X1u19DuRsULT/5ioxSArKL4hGi3Bip7o06PldOlIR3cFqTvBps4t92Fukn8cBZ9MqWmjc8NGiTAux+FRjAvqMfr6tCG4qcD0qNfunmscZB7nA9AO+nZnDrSMPyvKWTVdeawz7RVNbuievvd8YJAmz50efHHzbQN67av+/a8/uqftaTiclb9imy9fmVgYm/CrYSvs5CB6XtEWup2LC3eGde9AhM9TnLddakvo8tK/1dgZ55NK7WEouihcms452yliwsi6C6Y3FZLTsuqmaGA7qIZZ6443ON7QaqLjejXwElOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(83380400001)(53546011)(38100700002)(6506007)(6486002)(5660300002)(44832011)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpJZGQrenN4VFJmZmpKcml1M3VqckR2SkdBd1BMeWdpQ3R0VUhtRjZwMmV5?=
 =?utf-8?B?bG5aWVlpWXI5Z1FWb0s4VUFRUml1WGo3UmtER0Uzd0ZRcyt3UXhkYzhUVnR4?=
 =?utf-8?B?MmNsODAyMWpjakhBNmNuSzJDNG5mcjZUY0VPd25ueDM1aFR4TGJ4dG9DS0dM?=
 =?utf-8?B?OHRpN1NzRkhnT2lNcjdsT2swK1hWb2FjakpxWmx0SFVwbVR0Q3dPZmd5NytO?=
 =?utf-8?B?Q3BIWEhhMm9uR2dGd281QThZVzFKZEJMaUY4eHE3b3A1d2VQVURQOHNVZUxZ?=
 =?utf-8?B?VDZJVjFoekhNZ2k5QlhWZitHMUFHV1o2eWxCcTh1WHpNNXdDTzBkWnA2M0Yv?=
 =?utf-8?B?NXBIQ25ZZ2lCYUhOSDZ6S1BQT2F3TEtmWVJyc0kzTk04NGJRUFJmdWozdkRS?=
 =?utf-8?B?MzFCNmJ5NjJYVUc2aWs0aHFPUUVha2NKNnBZbms4KzFrcjkvRFRQMzZJZ1FJ?=
 =?utf-8?B?K3pyTUY4ZTI0bk9NV2tWUnRrUStSN1VRbHpVaFJJRnBEbVBaVGhRc3llcko4?=
 =?utf-8?B?RXhkSWpCYVF1VFRVVlpLcDg4NFhWLzhITCtIbVJlR3RNQWJFb0ZSMURmMW9z?=
 =?utf-8?B?UWR0MEVMemlHT0k4U0NGQnVPUG1oT3puVVVjdmRFa0lzbENXT0JJWkh5d3lS?=
 =?utf-8?B?ZkpDdFpWVWo5akc4d1hha2J1M1A0QzhuUHJKd0duK2pYRU0xaVlRTm9QMzRq?=
 =?utf-8?B?ZHRVNlVOQzFLWGRWQlpnK2VpT29DY3dQQUVrSXowZitzbUFmRnc0QVJJOWRR?=
 =?utf-8?B?aDVoWDV2U0FSQlNOSW5qOXdHN3NQN3o2Z0NIZDVmUzN4RUlRa3huNHh5ZzI4?=
 =?utf-8?B?dzJXUG9ldkl2ejZFUFgydUtpS1hCaUZGQktGbGJreVBOcE1hN3VYVDZSNE9P?=
 =?utf-8?B?NThTc1d5MVZaRExMRktMekdlWVAwZ2Z1S2FnQ3gwVVVvaEtsQjhObnlBQ2Js?=
 =?utf-8?B?UHptays3L2Z3dG8rUXV3dkdLcnN4SjVpdzhnSmxheHdwZCtIRUFpMnorZENy?=
 =?utf-8?B?czNFSGtRSUpqU2pTNzMwYkVYbWNYbldNVkFxOUJ0N2tMQzJlOVJGTDRFaVQ1?=
 =?utf-8?B?RkhiSFNaVHVFa29jWTQyVE8wQ21aRWIwcUhVZG1MSTUwUkVzbXAyZTNzSWQ1?=
 =?utf-8?B?Smp3TlZVd293bTArdVhEc0J6Wm04dTVueW1lcHhCR1lhQitFSDVZcjJDckZa?=
 =?utf-8?B?blE1OFF2eEVrUnl6WnQ0V1J6V1VXZklBNTZYaVdjL24zWVJ5WVJVR3JpY0s2?=
 =?utf-8?B?SXkvZzNwaWpkMFpYY3l3Umg0RmI4WWgrZkp4R3pKMXhaenZoanJUd2tSTE1L?=
 =?utf-8?B?dm1yUEc5cFZLQS9PY3NKQS9EYjlHWit2c3NPcDFpR0p3TXJTdGc2VHhZNGxH?=
 =?utf-8?B?Ykc3czUyUDNBSzhjVmZOZGkwdGhxbVJoQUZaSUkybHlDU0RaRU41KzUzSi8v?=
 =?utf-8?B?QWZuMFV4Q1c4Z0xVeUtYQ3p6T1dyakxXNENCVXRTL2swRUVDRGZRZnpjcEFk?=
 =?utf-8?B?QTB1NDdYM2QwV1RObHQ3TUk3K3N5ekpuNFg2R2JyUXM2dmN6cDMvUm9SOEhN?=
 =?utf-8?B?SklDa0VnTDRiYkN0ZVAxM3k4dnNIQXhOWk9EdDF0eUtFbWtwSWdEMzZTRE9z?=
 =?utf-8?B?bTZMZk9VSUhRYXowdEw3TXFLWHZDWHZZRTIxWVhuMHRFNHdEQ0IvV1FHME50?=
 =?utf-8?B?azJLYTRTc1VCamgxYVJpQytia2dteE5iMVIwazM4cm4rYy9FK3BEcVlDc3ly?=
 =?utf-8?B?bXNFaGlMM28xaUJiQjZyekY2azB2TEZHblhTLy9sVkRUblhIUE1nTXVBTXd2?=
 =?utf-8?B?WEE1TFhTSXdrNDJYZ1VQYndDckFhME11L25FRkpQTkZVNXpqV1ZMeldVc3Nm?=
 =?utf-8?B?UmNmVjl1cjFuYTZsV05WelNyeGhJdmp1VENoaW1jU1pkSGZTRDdwOTQ2dWJP?=
 =?utf-8?B?NEFCYjEwd3lhTWtwT3FGbWJ0TE9qUDZVUkZRQURaNGM3cU9LdnV2Nys4Vm1p?=
 =?utf-8?B?NU8rNlI3Mm1rV3lRNStRM1h0MFVyOVNsTUZpdFZxcGtuSUgwQ0U1dG9Ydyta?=
 =?utf-8?B?eUhhR1U2Vm1VbTRTY0JXRWJUSXRoMXo0dksvNXdNODY0dStkUUt6S1U3UTJJ?=
 =?utf-8?B?a2M2Wko5bmxra05tNFZFRndkeW9NNEluTXM1YVJCY092cXE3T0RPMW1yUlpJ?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pc49Zj6Rr3o9B6AyVC/T7zPGpvGRK730+h10VLgKjmCdx7OaBbiveEAqi74dtqrrFPPpZYI88GifaKd6WBVLbfzvQ4n9Kkyglxpycp0yZdgzu95FMOP4n0w9RFjvokL2Hz83oCaIAX9ndeO2hGAbc28DqtGJ0DL+Iqm4kohLoItvT5PM0g80YQ1hn63acfpHZdOusfFvBACq9uH96WtBlvY/AZLtCMRO1KLrmp44D7s80aCoBMXoU9NwGToDe1iNbNyV/8G5WRYAiVe8RqUOdAvcZycAPfyKkUvFo8kubCLWWqJmMEdXQ4q6QrzKJCCk02syYkqSntBJOZSg7F5xD13k1bYvE7DF4A0FUv9JCFd0nqQr5sQMhRS9Ccj4K/dZw6j2G11u1hbLJL0HhlvSUzwXsWQjfFyAlNQhX0g0S2seiQNJi/7r1dHylcRFpqt7Dz2AraNVxhTNcf86z79N7GnKvDf8RkgOZv3Ug2fKyu+T48Mrab0zBSamQbkzexSxwAJrLjzzm8tMrOg7UHlLZFnOxgq3HBv2ys/gNz7YweBuuv3B0Pd6GCMaY4vv4OmTFKrAz1rHA9rwO6+epdvh5G9H0n+nBJWBZBlDmJoFyi3eeT9sVIazC30ry+qQRJqkFLS9/CGP8+2g/IdaxHv+fFK2Sp0pd+1KNHWE6PjsrXlouLh+xedfaZOi4318OUMTohNbizl8h4EvNT39hHwOT43SADWh6cA0LcUkr5awW8ie3SD1cQejoEMN0wzYBk48odkMsMUEAi1Uy4QEJTWGiNtmptkuc3xX13PLjE/t0EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69a68e-f9f5-4fae-ecd1-08dba222fc6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 08:45:35.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVk7clFdSI4u25VMv5wSXbt5kGsAg675C1lxstiVHZNQOgg9bHATro75u0scdxPxg3CAG7SF5j1qxXu8EZ/HHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210080
X-Proofpoint-GUID: VQuSrjkpEflOdMnATnoBe5xsixa1DIAO
X-Proofpoint-ORIG-GUID: VQuSrjkpEflOdMnATnoBe5xsixa1DIAO
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/08/2023 09:02, Qu Wenruo wrote:
> [BUG]
> There is a very low chance to hit data csum mismatch (caught by scrub)
> during test case btrfs/06[234567].
> 
> After some extra digging, it turns out that plain fsstress itself is
> enough to cause the problem:
> 
> ```
> workload()
> {
> 	mkfs.btrfs -f -m single -d single --csum sha256 $dev1 > /dev/null
> 	mount $dev1 $mnt
> 
> 	#$fsstress -p 10 -n 1000 -w -d $mnt
> 	umount $mnt
> 	btrfs check --check-data-csum $dev1 || fail
> }
> 
> runtime=1024
> for (( i = 0; i < $runtime; i++ )); do
> 	echo "=== $i / $runtime ==="
> 	workload
> done
> ```
> 
> Inside a VM which has only 6 cores, above script can trigger with 1/20
> possibility.
> 
> [CAUSE]
> Locally I got a much smaller workload to reproduce:
> 
> 	$fsstress -p 7 -n 50 -s 1691396493 -w -d $mnt -v > /tmp/fsstress
> 
> With extra kernel trace_prinkt() on the buffered/direct writes.
> 
> It turns out that the following direct write is always the cause:
> 
>    btrfs_do_write_iter: r/i=5/283 buffered fileoff=708608(709121) len=12288(7712)
> 
>    btrfs_do_write_iter: r/i=5/283 direct fileoff=8192(8192) len=73728(73728) <<<<<
> 
>    btrfs_do_write_iter: r/i=5/283 direct fileoff=589824(589824) len=16384(16384)
> 
> With the involved byte number, it's easy to pin down the fsstress
> opeartion:
> 
>   0/31: writev d0/f3[285 2 0 0 296 1457078] [709121,8,964] 0
>   0/32: chown d0/f2 308134/1763236 0
> 
>   0/33: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) d0/f2[285 2 308134 1763236 320 1457078] return 25, fallback to stat()
>   0/33: awrite - io_getevents failed -4 <<<<
> 
>   0/34: dwrite - xfsctl(XFS_IOC_DIOINFO) d0/f3[285 2 308134 1763236 320 1457078] return 25, fallback to stat()
> 
> Note the 0/33, when the data csum mismatch triggered, it always fail
> with -4 (-EINTR).
> 
> It looks like with lucky enough concurrency, we can get to the following
> situation inside fsstress:
> 
>            Process A                 |               Process B
>   -----------------------------------+---------------------------------------
>   do_aio_rw()                        |
>   |- io_sumit();                     |

     nit: typo: io_submit()

>   |- io_get_events();                |

     io_getevents();

>   |  Returned -EINTR, but IO hasn't  |
>   |  finished.                       |
>   `- free(buf);                      | malloc();
>                                      |  Got the same memory of @buf from
>                                      |  thread A.
>                                      | Modify the memory
>                                      | Now the buffer is changed while
>                                      | still under IO
> 
> This is the typical buffer modification during direct IO, which is going
> to cause csum mismatch for btrfs, and btrfs properly detects it.
> 
> This is the direct cause of the problem.
> 
> However I'm still not 100% sure on why we got -EINTR for io_getevents().
> My previous tests shows that if I disable uring_write, then no more such
> data corruption, thus I guess io_uring has something affecting aio?
> 
> [FIX]
> To fix the problem, we can just retry io_getevents() so that we can
> properly wait for the IO.
> 
> This prevents us to modify the IO buffer before writeback really
> finishes.
> 
> With this fixes, I can no longer reproduce the data corruption.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   ltp/fsstress.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 6641a525..f9f132bf 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2223,7 +2223,15 @@ do_aio_rw(opnum_t opno, long r, int flags)
>   			       procid, opno, iswrite ? "awrite" : "aread", e);
>   		goto aio_out;
>   	}
> -	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
> +	do {
> +		e = io_getevents(io_ctx, 1, 1, &event, NULL);
> +		if (e == -EINTR) {
> +			if (v)
> +				printf("%d/%lld: %s - io_getevents interruped %d, retrying\n",
> +				       procid, opno, iswrite ? "awrite" : "aread", e);
> +		} > +	} while (e == -EINTR);

I hope that after a few retries, the event status changes?; otherwise, 
we won't come out of this loop. Why not retry with a counter?

Thanks, Anand


> +	if (e != 1) {
>   		if (v)
>   			printf("%d/%lld: %s - io_getevents failed %d\n",
>   			       procid, opno, iswrite ? "awrite" : "aread", e);

