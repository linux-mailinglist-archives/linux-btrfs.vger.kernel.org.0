Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3A6C32D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCUN1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCUN1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:27:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8891325959
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:26:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiKCA009105;
        Tue, 21 Mar 2023 13:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=v2zl8bCJANyu+/YbMu9GqD7S6Go4/IOOG2iWfH/SoxLXeBJoWCbLwgxlIwYeRV9rfVG+
 M3ZRnp5am2bApNgKedWEfJi0faKcdBce7bqIe3w7iuVYYUNuSSHBNi+0zSj7J8hfilo3
 xj+LU2024LzVT/JmObSepmAJIhJHq79cF6REV/XTqQD+IYk7NSg48WP8AO8Log8oZDOU
 T/AHaIXQqOWcmEZaAOwqqiZFfA4WbwJ+BfS/QDgAdLkt9GubKVuCAM0C8SMJiiAraDYr
 wFvQsLNeyFYky0mgDd9tOBssK3dbf2STw/N/AlBiEVC7s14DNXoDuD4lRiptuVB3YC7f Vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tp8th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:26:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LC2goQ010476;
        Tue, 21 Mar 2023 13:26:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3peqjnsbdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LysBQYeonKtvzlWyqdNUZmhErHFvgsCQmNFdjnmQ+sgMN0AwCTRgTKNpYS7JTeUHLNw+mh1jYFQ4EJQO/5PP+U1DSgcWMdUkb3UxQQokxpwPQZsxjA+12UT4/XIYzxwvXAh9kdZsy2mJblWLzNtW2RxHfoyREl9w+verV36wTN/DLHweYM4JOCbRR4V1u7Ql7Gv2XgwmNYajeP1bA8Swvpery9T7Uf8SUy8yRrpqVHiFOD698oZRP6Wy1+NHNhuY2rbbLbx9YhO5qmYWmDDT/cTbkmwkFZVTJbErU3uQXQ+dxLTC8Zs+YV+YEQP5siDD4bLvwevrSssTpfIOQUJ4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=nKL0jUXa2SZ7SKWOsZJUSBmJ/re3PVkZ06+eBHAleUbRxnJdW5ZGM0op3FjHEOYNZ2yYi0wv6PiIDV5YIdl5rNEwMTgIQYSH1XBW/TsmlCuSW+cgNQbuLktrY7IR0A22U5rRcX8DroFTSX9gxaTqigvQ0lUJMnfTX7R37YVD1CsbqklsSsnjwc0s/H2f8awyex+gy4r4Ef1J4c4xTl1CtiW76z/1Ar5HGP8KlIvZlGqBo9OljGYkPowsNE4C1cRP1qh7unUrrkTOwm2k2UFCRTLI/qHktFvlrzGT/gaS284RDWBEiU+sUYBElwPrTJBZR+a2mGjpXo3JbffXXYEsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=dknOu0SJ+hmC9aj+d6Ka160lSszm7GoqEOfUBDNChzWNF35VDasp0zXwVTdxPoehX6eRAIZkx8Ryu1byT0+sTZ41O4wvTpXiaCyZR2fnWhoPBployKs+vAPCA381fnMei237+84Cx6PVIHG7KtE2bNvjf21NWhbqZpq54mQ0iO8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6402.namprd10.prod.outlook.com (2603:10b6:510:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:26:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:26:32 +0000
Message-ID: <7da3284f-0c09-7725-4cb5-220860499039@oracle.com>
Date:   Tue, 21 Mar 2023 21:26:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 10/24] btrfs: count extents before taking inode's spinlock
 when reserving metadata
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <bcdf4e4856f633dfbcc3525630063e204ae710dc.1679326432.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bcdf4e4856f633dfbcc3525630063e204ae710dc.1679326432.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 59894fae-c426-4bce-6885-08db2a0fe2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7poNFxrvTX1p4hvThk0cP49zXcTZCccabT/ymmkJOYi0wWoO40d5RHiOxE4gTNjvCss0UMxwT8VACmZbGnWN6NZO24j683NJ9wxG8YMDh1O9ICNaAyU7ZtGy6cFZ9Asdyo/qBMygKyq13jplERPhCRYf0dBv/eoZ1NGAW6dWtV32099FkJX6suO7Bgcn8CnhKtyIoYaJmAPcoWoL0PuOImHHXP/IORorXJpA/J7/xiXtd8UZ3m0LPTdmZErpQyaxBVW5jELsyUTh+m0JcDRk6CAqeBHISibsEqkW5cN9z3ps4AAGVfeaNICad077SKQyomPFAUIhfy2g7peOJSPQw/7XkRlIIfOWaJ+tt3khZ+vs3O6tiDNZaQsnGsg339Ehxsw8znWh9386gkyNiPt5uMZkT4B0tjswunOzpeIsAXvP7kuCo9D5Gw3PeITK8AWXJWUx1QE2iGCCrHJNt1czCtVlEehoirQ8yr9QM+DjhU20ssornT3mmP1AQMdhmHi1D9ARTA/tZSSouBg1wNPBbQ/i3h/rwlA24g21Ruq7kzZUmpyXp/Tf1gUyDq3c3N6PH0GQJ6wqiVdtCCcdVJSd+0OJ3AJeynWLAQ1HJSxSKHW0tne4dVhgytUZ+Bms0EjJCLi9DUm2iUnpoRWBS5Mm0kzUm9XfCQYJr9dBc51j1uQIw8oeawNssv1K4gKWGdDnUa+Ti2ThdnR70Hq52LB6fe1uBgBwWOJ1t9RMItb9iks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199018)(6506007)(186003)(6512007)(26005)(31686004)(6486002)(316002)(2616005)(6666004)(4270600006)(478600001)(8676002)(66946007)(66556008)(66476007)(8936002)(41300700001)(44832011)(36756003)(5660300002)(2906002)(38100700002)(86362001)(19618925003)(558084003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REU1dFVBajJhL3MrN3NmaC9BNndzRXVZUjhQbTV5bDhYYy8yUVhqSXowUFZP?=
 =?utf-8?B?QTNmUjBIUHQ2aVFRa2t4MXZIVG90SXZlYzc2RkI5em5HcGpMTk5yV3RLNi94?=
 =?utf-8?B?a0JzS1ZmbGVObGpBYmprRjJpazlUeHYyS3Q0eDMwd0x3OFp3dHVPZWVaN0xI?=
 =?utf-8?B?WWZMUitWdWE5NTV0VG1JL2h6MW1kVTFTUmhNdWhmS2p4THJrSDZsNjdieFpw?=
 =?utf-8?B?V0l3Q2tKYjdQMlB5dU0rLzF4SHRMaUFwbVdMNjZwTHo2eTV4aCtqSThXTEty?=
 =?utf-8?B?VHZYSW5CN1kwQk5OVWlFYlAxdCtXRG15QTl1L3h4aHR3dTZqeUVlQ0F0a3pt?=
 =?utf-8?B?UkxSRWtkOHp1YVNmTlFDNG5USmpjNVg5YmtjM1FKYjdHaUI2RThGTmwrMlFO?=
 =?utf-8?B?TVZLMFlQVEZGOWFTK3RLZGdoU2l6UVprTGJFYjJhTUx5YzBKRkdYcXNHL000?=
 =?utf-8?B?bmFoUVZ2RktvZEQ3bG81Zkh4c0ZLdENGTXBsMVd2NlcvY2VPNDZYcmhyckpJ?=
 =?utf-8?B?ZHhtRXBJYklsV1Y3OEs4aHA2Q0hVWUgwOXdJZHBFUVFvejNZclUwTDQ5Y2Fm?=
 =?utf-8?B?WXl4eTFOajJ6T3JTT3NNUk51TlJRVE94a2RiQlV0SXlKaW5sQ0xQNTVrS0NI?=
 =?utf-8?B?UHNMUEQ5bDB5TzZ4TjJ6OEJOY0VuY0N6eW83S2RzYlk4TWtnQzU4TlpwUlE0?=
 =?utf-8?B?bktaWUpZQWg2WVE1dEwya1VZcys4UjlEVExkYktvRTlxZHJhM3RtakMyT0FE?=
 =?utf-8?B?MmpvZk5lc0hoSlpVUWhXTTEzYWFmNmowMzl6WlpTRFd3TzFZZFBmTCt4b2xq?=
 =?utf-8?B?QzhjeXdNTzYzTVJOc1hkZnJHSVFjZVZOdUJaTU5YNmV6dVo5dVlNN3F4aTh5?=
 =?utf-8?B?c01KdG5ZWEZVN3JyNmdselYrRkw2NHFkU3kwc2RUbisxWHlqUzgvbDMva3B5?=
 =?utf-8?B?T21lcEduN1c1US9JVS95Wm1aTk5TWndkWG8rR0V5ZGlHUzFpcnFlbHhjbDRM?=
 =?utf-8?B?ejZXVmZlTk9pUUJPYTMvTnhSajl5Z1VqL2FiQW1iS3ByUU1sQzFuU0pURTVK?=
 =?utf-8?B?NEVCWlZaUmZTMEJDK3F0ZDBQVnBkQWcvYlloUlkxMWdQMWVMMGE1RlkzWWFV?=
 =?utf-8?B?d0NqZk80T0dxcWVVZHN4VW9vaGROT2NsbjhUN1A0TVVQckxKZjRuc3grU09D?=
 =?utf-8?B?aFQ2SUZpSG5HMG1uT3hvRzRqSkNRNFprQ3NsanZkakZNQjBUSEl0N1h5TTlC?=
 =?utf-8?B?TlpTcndFN0N0VVZXc2c4Ukh2aGdpZWlaR3UxSHpOTHQrQk9jOXBpVE4vWS9z?=
 =?utf-8?B?blVlMTJwcm1yQlczRTljN0NkT2hRUXlRL1AwRENWZHVHWHRpSU5WZmRtNHBq?=
 =?utf-8?B?eXVmRk9ZOStmNURkSVRqOGw4aCtyZXYweHhEQ092RE9naDJONFZUWFdjcW04?=
 =?utf-8?B?cDBvRFgzSGNiMkdETW1uOVF6b3FvMHYwa3pjMlNZVmZuSEVuQW4zOGlRU1k1?=
 =?utf-8?B?cHdHOC85ZGJpTU1ZQUFQVTN0cDRXUmlGQVpDSlBKdmcvbHBJS3VmenFOajNa?=
 =?utf-8?B?SXo2eXM5UWQ3NmNvOXZIQ3Z6MXFNMEpFOFFFTjhWQmh4RlNYYzY5eWZ0UU92?=
 =?utf-8?B?cTNRc1cxdDlNVHE2c05YQ0lWSzJGeEtjUXl6QUs1S3BNT0E0YUszUXF3OXVM?=
 =?utf-8?B?T1FUSkVWbkxTSUdrdDh5Z0xFdFVCeEhyYkN2OTVURUdYN3p0aCs1WDFVaW5p?=
 =?utf-8?B?aWVqY0RibkZzVEhob0k4TloxakUzS0NFZHJ4Q0hld0gvbVA0NGhMWnl1MnBZ?=
 =?utf-8?B?R1IvNWVpMStoOTd5a2JPOVhrUUVMY2N1NXhNZmFJZ1VhZ1ZCcEJzck5rL2Fh?=
 =?utf-8?B?V0F5WVRxQnUxRFNZRjU3ODR3WlJESXpLSUFNRFdxQVduTWg4TWNENW9vdVNh?=
 =?utf-8?B?dDdsd3ZZY3NwQkJBdTNMSWc0SWZHdkJWOHc0czRrNmpDNFBENnpMQU1RS0t6?=
 =?utf-8?B?TnNrTWJVL01iQ3BBM1BUdmduaE5EQTkvOWpTeGpHSnlDeEM0b2tHQnZPdzd3?=
 =?utf-8?B?MW9UQUJpOWF4OXI1endYRXBxQjkrRlVhTFdOM1l5bGQySFcrK0ZSckJIMzY2?=
 =?utf-8?B?MlNtalZxRFlNQWwzTDNqTHVCeER5c3JJendrVDFadjZuYlpyNEhaakppdktU?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FxSX0TMpG90TxKXkPDgz8/z5jb7lTSjEcE6D35A+DZzNMdPTVk65Gm4Rj9vGFSDywmhKcFc+n7WWjcbR5dZ821znBFTkUwEd1y9kkyqCP5P7LPupA55fMh80PwEwsXri18QVrlt/nlugzWbHgp9xZEmMuZwjXo0003zoxhT969Iq7ei5CSoUJ9PHVI8yheC+jKtWU86R9k120Zz/ArmkRCr1Cgf/tA8Pc0rlsT2FFAprlLRsCiU2jKDFA6WGoNbGIOZON49ZBPNQdJK7wwKupLjT1ZvGODvccGRxDFXY+t3/urDIKY9KZo2rzfhFm9EA+iZ1NfiK7EOXVwhTdU8KnirsMVyxdujoMPF7zkpzXxW4ZBFu5jmZscGaULB/82iK/ggIbQO6yfS5LgFWq1DNmN1AMNSMZ1pS1YTRUdR89UYuoZoi4RAFRL1GzO9BiJBgaHl6QivT70GwQHoeQPG22W7tcRrLPeLBpBYMCWf7i23RP5vdYf5OkFAErJAqB7AO0RlZAWLRs+s6pUSiKF4B5ZwOlWDepOP0RSXmM7mbYtBW2NS5OMwLzMSu+OsLKYPo3cThYtwPk4IDZIuMNxF4FGCjqKP9CXAnoq1gCV312yNTTyLaNjQYV5WlpUOjo31MwwNrxUTsf8QbCoCi+AkLphlHOckWoP7hb98ICxJ6MyIw6MY+p8AMyaSjCYgr3DwawKwBKOLWZSorSd6Sk8HNaghZKe9wbGKv7jIx0ExZzjB8JMJotQ50aXwH0WBAy3qFGD5uB5Pm/CQVsvCOA/8LM+gxnB0fd+CFgMbi1FIbCZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59894fae-c426-4bce-6885-08db2a0fe2b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:26:32.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MErLL5xHY7PmyYK/n/brtDFgmkPdsNJlGTsQqI31craJYegpAi+O2eaWRrkqJVsqfWIPhVDBzMS/ZB3bVHWtuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=921
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210105
X-Proofpoint-GUID: K7PW_2vZT-gS5c9zvyuXzZ_7m4sKQMBy
X-Proofpoint-ORIG-GUID: K7PW_2vZT-gS5c9zvyuXzZ_7m4sKQMBy
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
