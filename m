Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC177B902
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHNMsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHNMse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 08:48:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C094
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 05:48:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECi9Gg017395;
        Mon, 14 Aug 2023 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dfwUJ8r0d7ie8JD3lZmtPae87MOCRdhB4g8jQM1BPi0=;
 b=mGtk1TLaTuEZG1vRnm7oaX2ffrRUd5tmI6A0Ux7faPU0bht8jsnpx7/2BZTawmg3EkDH
 cf60U5kCWUW4UeY8MS50APVuzAkyN/PXFjx7s8QjjWMr02sqlHrg/A/DmITfBNG9+3E+
 axgKQ9iNtVzopWHR9bEI8PpzX3LorPW3/H2Pc0UL5xY72i9+N9vKWI6NwwDvev4JP/Di
 8yQ6kfRTxmw+LsLtqqxJEZGc/A8cW3qiQ9Ur+tGnF0d5OiPNS19eapS332MK9RQWdt79
 O33u35pZY6C28IDha7Gz2DIm+6VzKbC/8kfhG2mg+aaEdqCOFctN/whlnZ9dl7XdI0aY 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2dpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 12:48:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBUQlb027312;
        Mon, 14 Aug 2023 12:48:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1qucry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 12:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSF7hU18olzVOSV/ZYsBJzwYZulhf+Cu+jcyZj58g9vZrGsbmIf5cMj9uxJYBt79HFSJztPBbghysg1sLj/0e2cJkXpiiuCGtk2AfS//aXuwqptTcM7jUWCB1MIdec4deJU4FZ4XjCQ60i3cRWfIXilZ3ABxmzOfsUXHqcxKNx6ytAI5l1XJr2zOWVQ3/0Zu7cLtbK3g8IT1K1EmwbKKNECkk9Gq2yDI7vtyxOvOF/c+2xAH/oDj89Dg67KFCnJ6S1RFoq8jOJcAJtfhAXkVSnAElAHeb+supf9o9gYPk5zxNbnRgwdv2S56H9HK1oGo0xi24nSspTiS21tTWF57Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfwUJ8r0d7ie8JD3lZmtPae87MOCRdhB4g8jQM1BPi0=;
 b=SI/xDJFmSXwC4msqEFseXREDXs7oAxJXlzup3F/i8Ba6XzA7yA3Bv2VNSu4QIGQq16Y0JmrcLFl6KNWRvlL23HZtVkhHjhHqurNHaWhLAHNaahnpb2S69LmfTSrdBjnItFNpRYfgia4qXAVET24dWyY4TqIHvxO0v2lvUz23YUCRZuqg2TDDl5pTk+D1g3xsoDCZt5UjeOf/PQa4Cmeb7sH3J23xYoruNi6MNlY3TSVufJsmaDw4WEajeA/G7ETNTOEtVTFWNMIylE3YDtSLMXRv8Y9leMiHdLCc7goOfJw6XfrmL+cXVDrFYbKObuS196ZR17mR1syWz8YeomEe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfwUJ8r0d7ie8JD3lZmtPae87MOCRdhB4g8jQM1BPi0=;
 b=ziQlQUHYcDYzv+uW8Xke49iHPv/aKktEzY9jqzVbOXKneFY8ZT3v8Rx9bKLu6xjIv3pjrWig41JQzXCln9Ns5QLfJ7VbXDiCFE6D5SXdgOGm7BE5mjHUc7U3TwGp/tdzJ76YHFY9OwDjECG/p2xnYowV6vnpUzLyiI10mWU5lFM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB6990.namprd10.prod.outlook.com (2603:10b6:a03:4d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 12:48:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 12:48:26 +0000
Message-ID: <455513ad-3702-2e72-afe6-978bbed55b4e@oracle.com>
Date:   Mon, 14 Aug 2023 20:48:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 10/10] btrfs-progs: tune: consolidate return goto free-out
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690985783.git.anand.jain@oracle.com>
 <27568376033263288027ccb60dbbc0d9f78c4744.1690985783.git.anand.jain@oracle.com>
 <20230811174705.GZ2420@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20230811174705.GZ2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b04720-e34a-4d10-f7aa-08db9cc4c0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh2Z/bkugCAsEXQ1DMIhYnDeLF85+VW7+E0sAL8n8agi0jItr5lXMkucQR3wZNN+sBqpXFB+H0xnCsQ791s2COVh/+LPEWLk9Pwrq7evLaHP5e93ri2p0EZkytobD/YBpB+niJvtHQAy1L7x19u89GtYvjJwErBgqqXZ088BJ1mvM9PQMuGpUgl51sU6HXEGWSqUlrdWu4OrjqaDoJug51LYaeYfhnlfXGEZmDlVjapZ2n2ohn7iEEeZe8sT5OszJlFaXYKLbRcTAdKmpLiqsZRoX4dLc2oLkkCeoohqGJnECJe+A8ydextN6ILmIs5LafMABu+mU8ynJpBFmpaiFIYmyMlE8tcLoHKEMAPrU4DIrj548k8vQHZJkUaVQa76g/0CZvaUnAoQrn3W2AvOrVOJGlTKS35pPvkrpkHyAg6tNonjy3OaXaTElC+O5YOn9X97kWaYi6MWQOYq2gleN2zYf9cNXZKZNcS8agKnPz+JoQEKORD/bOOPY42JmuQW+15f+WfUHDcxmEr/HsL4wpVx+LQ/6n+jDxdNeKF9t+dnwLWDyo5RI/vtM3D5BNfIjKu7k00kYDbKdtctcQMFErr3j+7cPMBPn031ZM3laW9rrvQji5EVnDvXWzE97nGGFLPossgfdTkw0qdVx814Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(86362001)(31696002)(38100700002)(41300700001)(478600001)(66946007)(66476007)(6512007)(66556008)(6916009)(316002)(8676002)(5660300002)(4326008)(44832011)(8936002)(2616005)(26005)(6506007)(6486002)(6666004)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJucTdsOW80eEdHOHJCSGJHdnJlaFEzTTdycUVhZ2EzODhtTEM3UTU1L1BB?=
 =?utf-8?B?bDNNUDRra0RqSUxKUnRaQWttQ01DSDk5OTlwN2EvdEpCZ0hQQXpHNVFFUElU?=
 =?utf-8?B?K3RkMWw3MmRnUjdRN3NHUVVieDIzZUJEbE1UT2NFdHhuUCsyWVROWXFkTTJq?=
 =?utf-8?B?bnNTa1M2dDk1b1dkQUFpWUJTRFM2a01XV3hKcGg1Z0xpcVFqcmlXaENLOFk0?=
 =?utf-8?B?TDI4TXNlZGJsUTd1Y2swZXdLZUYxTEt5U2ZUTk8wMUZoSFdXMDlzNnUzNmlB?=
 =?utf-8?B?azJNdzJJb2ZMZGovWTEwNGlWeC9pKzhCWmxwV1RCRVNhMUN1SGhScWNQWTFy?=
 =?utf-8?B?R2QwYjhCTm90RXJCdjFHTFpYNzd2WGZacXArWFBFMDF2Qm5nU01KMmQ1Q3Ar?=
 =?utf-8?B?Z2FFUW5pUlVoYkpPUmttTVR3T1RJM1U5ZTN5d3ZRKzVhMDdrZEZxR1F5a256?=
 =?utf-8?B?cFJpbHpDdDJSazJqVjRyTHBBblFRdFExek1ZTWFDTkoyVUM0bmIrRlovWWJC?=
 =?utf-8?B?ZjBYTGpNK1AzMWQ2cnFtWkVYOEtsTXRTcURoMCsyT2dobUlJN0EySU5vMmpK?=
 =?utf-8?B?VHBjUFptUTZ5RXlXU0ppMWZ2aWg1V2dqbmZGdWdrTVdXMXhqeFQ1ZDVzdVQx?=
 =?utf-8?B?MGNIMlVyRjFQUlNWWllJS2hPRXhTei9MZDgyVkVaQ1JKekIzbWpHa3pPOU81?=
 =?utf-8?B?Q3RxQXFyNXRPck9CM1l4aVJSYkx1T3B4WU5RR25rSVNBWldMVkxndVVvZTRN?=
 =?utf-8?B?TTIzS2dSN1NiT2Ivd2grTkkxenBVTk1lc3Q2bURkUzZydysyZHdEMVpqUWM4?=
 =?utf-8?B?WkxETWFTcmZXOWNZWjhDRHI2dzFSdG04Y2UwOVBGZ3ZVdTA3RjJURU5jaktk?=
 =?utf-8?B?M2RqcWhVYkhUU0UyWFRDSnJ2bzFabDk1aGs2eTNnUDRBN0VIbUx2K1FRMDdH?=
 =?utf-8?B?TGNzQkQwNlBVUGt6WlBkdHFjNjhleFVOS2FFbG91SmZjckhoc09PZ3UrczVQ?=
 =?utf-8?B?THFtay94R2MveHYwNjlwQ2tTbnRoeFlFRnU4aldtaE5PdlQ5eGxSTFZKS00x?=
 =?utf-8?B?SUFaZXZlcThRK1ZlN3h3WDF4UFpRWUhpNS9ja3daQWVxODBXZmNEVVpaVStT?=
 =?utf-8?B?MDNaa0doNE5QdlFhQWJqUnJZUWYzaEozRmw1MGdGN3hSa1cxa2tJdDF4MTFT?=
 =?utf-8?B?bkx6RVRvOW1VNGx3U01RREI5RGw1dERUUEZwT2hTRDBRbXIyY1ZLdDN2U2dP?=
 =?utf-8?B?VXdZUVRLOHJ0VGI5cEg4UFNkUGZKSTF4SjRpeFp1RmdMR3FHUDJCQ3dIdnY4?=
 =?utf-8?B?dnYwQm1oLzVQVnh1VkRzL1lqbUZIblA2OHVta2N2LzZyMGFWZG5MaUVlRVlS?=
 =?utf-8?B?RVBvajQyWFovNmFGditpK2J1RHNYM09veHF0UlhNL1RzZ01xVzRuUzNERTlN?=
 =?utf-8?B?Nmd2emhOc000bUxaYkpLK2syaDlQQjlnSkRoZVBWZERWZnJ5emxJLzFSL2ND?=
 =?utf-8?B?QitRNFJYUGlueWt0enFFNkpkQ1B5OXVVMDhuR3FNZ2ZCRnVMQy82QkNUSW5l?=
 =?utf-8?B?NlZMMmNOWERuajFsRGVRRDdsNDhOV3F0S0ZXaVFOWkZueHNvNWdrRWF6RWJi?=
 =?utf-8?B?TW96aDhZZUxUekI2bFhsY1F5V2hVWkVRZ21EN1RzN3lxSU9UOUJ1Z25zSGw5?=
 =?utf-8?B?L3NoSXNpOHBCcEZxR0xqM1FYSWpVVENFYjJoanFSY2czem81S0loZWQ2c3hl?=
 =?utf-8?B?T2xjVnFMMStxWWJqSEdqcHF0MmhzUFc2REkrZHhFdWg5ZnowWnN4R3U4UkZz?=
 =?utf-8?B?bWpsQkRhaXcvbDRTWmg1WmtMQ0V5MXlOb0lsM1dZZHVWK3puL2VsellsclFL?=
 =?utf-8?B?NGg0YkNCZlgwYktXTGtKbTRodGVFVDVsS044L0lVSWNEZ0k2VXZiSklHM29S?=
 =?utf-8?B?LzFKMDVLVEI5cWh3UzFld29mRzVCS2Z5ZjNCQ1VaVFhYTE94aGFUZThIbjYx?=
 =?utf-8?B?NDdoZlBUcjNFcXh5b3RHTGJweTVJS0d5Q0RTZURTVmZ0YVdxMUZlVVp3N1pF?=
 =?utf-8?B?UUhuVGFsS1ptd0NpNWd1WlJ5am9XaytneWxnSjMrSmJRVzg0djVXWWFPb05N?=
 =?utf-8?B?Z21CK1lzRVdtRjZQUlZVZEREdC9BTXNYNG5Mc3pzSHN0ODI0L1hpWlRkOVJz?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LGFcxiHJbJ1bJFYKmf/Tjnopt7IgHCMhQx0SCO5bijWmQ2ABxuDoftM2E1u4ne/Br6Ein3EXvDfKNc1mJZeA43VbV6PluV1gRNX6XzgpxKMV97j0g9aWgtK9cEAtVpy0MhI4/Ag0nPhA9AzdufFqOVSddpwZfhejhu02e8OAddnp5eL0OpIeQN9exhrSpIe0xVvNhnc3trsWIpCxgYB7HeExD+8WP3zgGyHurQ65PfHcxjAlMwZGhEevd2Lm6adVX7KGv/jpz0nQmRB218p1CGA6Hpx+sT73UHVh6kTLQsXUP9P8s2aZzPgnsRYvG8J8RshZfzjOuUhw+G95gXzMutdJ3f9PyFDTzqVcAEq+/EduVdB+CBvLRkCES88YHEcmnHktyysYWYQjD74rifTsmV900xG2bZiTjx1h1AYcCTnw4oqNeZ3pWY2c8XSIvIDvgE2GHwr18pNjjEixbOvMz7waD9oZHLt5Z3Dr6BTSzzrzLQx2mTbIwtGQOge8EfvzzQ63WjoU7U8NAm2+hO3uNjs5761q18w9DOtE4f1oLhlTwIO6YIRZLeK9htquUnphjo6rHsTUk4M1Z+euxa5ns+EsTyoXaR9eSH+uVXaYNXfH8j9oSxBBRmPDfrKZ8DQlufvikR6BXqL6DfqQUAF5Siq9BvNHkpUTiR56Hw9uf0BwR3FwgkrgPh2a/pM0ZFDo5z9TZ/0BpPMSsAqL2G5Tnwn/+ZMucsRbBU9aXaE1V2rOKQQIQl9RfR7D5TjljLIa2bV43bIVx6NGBTNsU9X+DrH8AAAJS8nqV8ZSrU763Xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b04720-e34a-4d10-f7aa-08db9cc4c0b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 12:48:26.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEIlQHmZ0fQ0G7zD79xI8jnHRAiiA+H9mbENXqTB8QH9Jip+qVOgAsVx4kalVq9UzEWDFEKB4iXH8AfoZCx8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140117
X-Proofpoint-GUID: LUsGhpleoq6nOVvgH2ieAsJKfo_UeiJm
X-Proofpoint-ORIG-GUID: LUsGhpleoq6nOVvgH2ieAsJKfo_UeiJm
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/8/23 01:47, David Sterba wrote:
> On Thu, Aug 03, 2023 at 07:29:46AM +0800, Anand Jain wrote:
>> The upcoming "--device" option requires memory to parse devices, which
>> should be freed before returning from the main() function. As a
>> preparation for adding the "--device" option to the "btrfstune" command,
>> provide a consolidated error return exit from the main function with a
>> "goto" labeled "free_out". The label "free_out" may not make sense
>> currently, but it will when the "--device" option is added.
>>
>> There are several return statements within the main function, and
>> changing all of them in the main "--device" feature patch would deviate
>> from the actual for the feature changes. Hence, it made sense to create
>> a preparatory patch.
>>
>> The return value for any failure remains the same as in the original code.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tune/main.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/tune/main.c b/tune/main.c
>> index d6c01bb75261..7951fa15b59d 100644
>> --- a/tune/main.c
>> +++ b/tune/main.c
>> @@ -145,7 +145,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>   	bool to_fst = false;
>>   	int csum_type = -1;
>>   	char *new_fsid_str = NULL;
>> -	int ret;
>> +	int ret = 1;
> 
> The pattern I'd like to use is to keep ret either uninitialized or 0 and
> let each jump to error set the value explicitly, so it's clear without
> going back to the initialization.

  Understood. However, if uninitialized, older GCC versions might give
  false positive warnings for uninitialized variable usage, though
  it's not an issue here.

> 
>>   	u64 super_flags = 0;
>>   	int fd = -1;
>>   
>> @@ -233,18 +233,18 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>   	set_argv0(argv);
>>   	device = argv[optind];
>>   	if (check_argc_exact(argc - optind, 1))
>> -		return 1;
>> +		goto free_out;
>>   
>>   	if (random_fsid && new_fsid_str) {
>>   		error("random fsid can't be used with specified fsid");
>> -		return 1;
> 
> ie. ret = 1;

   Code in the devel looks good.

Thanks.

> 
>> +		goto free_out;
>>   	}
>>   	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
>>   	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
>>   	    !to_extent_tree && !to_fst) {
>>   		error("at least one option should be specified");
>>   		usage(&tune_cmd, 1);
>> -		return 1;
>> +		goto free_out;
