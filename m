Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEA50E688
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiDYRKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiDYRKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:10:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948138DB8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:07:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PFMCE1032393;
        Mon, 25 Apr 2022 17:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Svc9LIGLS/9mKhfOFEOJ9oTcW5JrBO5vsbxVl2oEA8M=;
 b=GvEoP+wgjMDeZnwHSIBVcIhpKwfO3g2KIQBJXb+JBgCDn3Jiay0ztch7MY3YC980Q3mv
 c6Cv30OVAeMDp6GuVAy7ifH762xgZx74zAQOVk8xIbM8AdFBhzW0OL7nkJst+yCsIuo9
 jAT69kSzT0jPmOVLFEdfEUn/4cvgX5pNhaGPqvcJC1Sn5JETVfji1gEfh6WmZ7K5e6r6
 t6t+s8gphY6qtjAaruYOkE0ePULwAQWFoZ1YmJW+buE8PbFhdK3QhSsd0Vdz4yXGp8jg
 9tsfL3juLgIUm68b8JBg6WA758OoNRZF7tJ1D9ADRapepQHUnow6TsDATVC9dMNXprHX DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5juwmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 17:07:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PH15sq036975;
        Mon, 25 Apr 2022 17:07:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w2j1g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 17:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCM+cZs2SCLcy/a4SVfHrCiRDzAnuDfRk7xwJ/DfeCM1+5Wa0owFN6Z3os5zZiBNIO2uJhh+pu6ifaByvD2HMpdad6R5DkkglqTWXof6eG2O2Fq2vX3A+b5I+4n2H61IzhSP5u5Q0+jxnOODCxhTxI3gYfyWyYrD0WRgzIWyzHgATOMyr8hXOMEbSurbRsuAlS2HV1tL4tgNrg0ZSnM2lzn7OxWG3niBBMXWrdbPbWbeYRAyPKthbaaXMcgneZCMu7A8dXzpTBarzh2aou4zXjBbuM5M/gRtEhKOWCcaIkHZP33rXCOPobjx2utUHudMTg0fxAdsvR6gbxGqe8YPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svc9LIGLS/9mKhfOFEOJ9oTcW5JrBO5vsbxVl2oEA8M=;
 b=Hy8Ysa4HC5Cl0T6K8uVC4LyHTEfVhbrmIMgWbCLi9o/o6X7cMSlkrRKzsQTAFfrGSFmsG75hHLm2jNsc2i0Drr6MS4T/UdbtUTDgQv3afIywbdbFTM9SiX3+74RirS17cxOoZ7/Pm56YW9ZgwIWuUnbQT3q9mc0346aKpNgkvHsGW1k8c6pfQ7iRKOt5GY4Y2T+YbXOXzv3sAdPXM9RU2t5Jsffd0gKlhX/go7v24jfZi2twgcws2oOhu2tsmNCSvjajvT0STZMocLC9W9YAZbc2tudg1wK9qKLa1kPQrCYaA6k3oD6VTdsG26mg0vH1NDmJ/3snac7sMUIgjdEl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svc9LIGLS/9mKhfOFEOJ9oTcW5JrBO5vsbxVl2oEA8M=;
 b=KsyW3VOob6yJzfl7frneigf9zFj/p7dPTwNzZH+wfGujAeptGTozI+6O/VGHuZ0XrG3a94HTAxz3n5odpvnBuSSWqR259vuindTNpqWI/TwDZgzrJMq6hK5DXm8ASx2XU72wLaHGJSsrHHro9qd8nCp3L201ptmWGLCcRdJQcPg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3805.namprd10.prod.outlook.com (2603:10b6:208:186::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 17:07:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:07:23 +0000
Message-ID: <baa8f645-8914-0827-dfe0-9e4867bcb847@oracle.com>
Date:   Mon, 25 Apr 2022 22:37:08 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>,
        =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
 <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
 <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
 <20220420154200.GG1513@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220420154200.GG1513@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7caea36-1649-46bd-70a5-08da26de1112
X-MS-TrafficTypeDiagnostic: MN2PR10MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3805D0385583D4ADA8770E49E5F89@MN2PR10MB3805.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8zTWQYZBlN15+vjpbV0roabGv7DY3Fqmwz9aXqXfp4h5mwoqXamlIhErNY+vjFcJ+IePRA0/bSIjS1vwduWInnCKg73e8RtuHtB+R6LhZ1bGEftDwIFXG1UV5rOB+OyZRGUJDeKbgfQlWs5NNSHdbws4U8QW2dnb+JYheWD/LU3+gXujqidYsqWVeovgWN0ssgVbHo/4XOnUExR7uidgEC9TIWyJ6ZvLbJ1pzDKpYhPW95YyrUYLfMH7xBBrFjVBBV/GD7scx9HQW3QcFvGHcJVgiwAT4h/xgWoWteJl596q9KXM6NJFDIIvuE1edUER1PZROwSYtVQExEQusjweeotKbp9QfhbJ4YJkHj47wmAl9mcx9VJIABxL9pSvHXEZI0lgaW/2PhMwdM6fVhYIl/ME3znrdAl2KXmYqXiKZGk6pfRIqGZxGWmvj1DqpFoHPJb3xZl8y677DiCxj0KUU1kjDYgJW2vusJGtjEKJ8RJ+I+2DjBgxwL+GwasX1Jt7pmfvjfMkhHkONvLN8iCOT3EMsT+IQX8bcqQNSuYSE0CrBrIKtKoVkHHQbzthioafrB1f/Dt2Ee+kmnt/QOwgVJ4zAtcDeRty0rRBklTGz6ujTBjgb7ZjcpK9gilOKQzh1PlxkuwSw7vReG8D5mofSq41TJnwErVyA2NuHgnL7YUznzMFj0h6iyNXIz2wd27XVuJicpditlYk1fpZXoQl7N3I4s5C7u/EdLRGr5Rafc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(6666004)(6486002)(110136005)(8676002)(66556008)(66476007)(31696002)(86362001)(66946007)(38100700002)(53546011)(5660300002)(6506007)(2906002)(36756003)(31686004)(6512007)(44832011)(83380400001)(186003)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUtISmUvWkhuS1g2RU51SW5XRVF4OW0rN1RJb2hudHhmYmh4cDZ4Rmw5Z2NP?=
 =?utf-8?B?dTdQWERLc0c4TjNrSWRZTVQ2UlBaNEJTS3ZNdGd6dkZWb2ZLV3dPQjVXbTZR?=
 =?utf-8?B?WUJhTi9DSm1VOTdJYXlzeUo5TWFVYUY3TFpmbEhPUjREb3ppNm5aa1M4dmVO?=
 =?utf-8?B?ZHBFWW81YlFWWU43QSs4Z1RKS1FHY0tCWjFzdGV3OXFFZ1doWHcwNjliRTRo?=
 =?utf-8?B?L3B2Rkt3QlNRNVlzU1FjcnUxYlN4YWxmSnp3d3B2NGg4T0hxUXc4SXNFQWVR?=
 =?utf-8?B?bVpNZ0RjeG5KbFIzVGM5MFFwWFMrNGRRNTBXdG9hMHB5UWovK0JLTDRIeFJI?=
 =?utf-8?B?VHZiZzlET1BtK0VUWWhvRXBYeXhjdWtmbXp6dENFMmU2dXNHSWdaS2NneUNL?=
 =?utf-8?B?cFNuRlhTdi9LRnpYVk9HUnlxeW5HUVVLZzh6eEt0cHl1bVBlNTJkakdwMVcx?=
 =?utf-8?B?SHozdEJENVRMaStvVkZUSWdySStEV1NPS1YwZDd3WVVZNFVUR1pkZWcyOHNy?=
 =?utf-8?B?encvWC9QNHk3M24rYW5VWlVjTERHOGpXTk5DdzFLV3hwdFJXNmpBUWVZU3pn?=
 =?utf-8?B?MFhoalo0dnJPVHQ2V1gzU1RnSnZIbjBaUzNsSEtSNk5iRlVvL1RNU1VnRzlS?=
 =?utf-8?B?UEd4WGZvdVMzQU0rTzV1bGlYVDFtWTIxTmdZeFlvL2FBNGYwYVZuYno2bDhS?=
 =?utf-8?B?QUZlK3QzamNEaElUM3hRVXJWSlExRUljMHNRMjlZTUdzcmFoYSs4UnYrUnFY?=
 =?utf-8?B?anI1dTBieGVCdFgvNStJUm5MMUJGNFg1RkowWFZUTENWcXo3azMzdXZ2K1Nu?=
 =?utf-8?B?a1lDdXNxalJmNENJTHF5YmI5Wlhtbm5SK2RYVnVjc2xkaDJjeGdEU21FYW9l?=
 =?utf-8?B?UnZ6RkJNeU1BL25iMEl3Ny8xSDNIZXAwa3lEL3pEd2Zpc0laVU9rMGNxTmlq?=
 =?utf-8?B?b2pteTVWOFNINE9mTW5KcVVmZmsyQTg2aEkvZzBqQnpCWUpNaDBXNGM0dy95?=
 =?utf-8?B?Q2F5Tzd2WmcvRmtYbHdYWXMyT3N2SFR2Nk1ZeUlubHlBR05HSmNzVFdnWkF5?=
 =?utf-8?B?UEtZRkxydzBZTSt3clh2UDI2Sldtbk5QWFgrb2NtWGc2MUV4c2FoeEF2cVls?=
 =?utf-8?B?SXJxRXUrY0NmZjUvSUFXNmZQREtNbnk1aUkvQjlnRkZmUnpqNGVnZEprUFpx?=
 =?utf-8?B?cG1RYXNXYzhnRzc1REVzSS9qRE1ocEpRWjRoTTd0MnNHTmNOd25MaTFBVHZW?=
 =?utf-8?B?cTNYUVcwdWt2QjVKNlUyclkzamVGZitlNDBHb1ZYZ2NKUWZnWTh2OThVc0dj?=
 =?utf-8?B?N0FsdGdmc3lOb2EvcEtOQXpoTlRGN1J4WnpySEttM0ZkajFEM3BtUDBnTXQ4?=
 =?utf-8?B?YXU2Q1lxOTNOMFZmQVNxV05jNGlVRC9ScVZWVW9QZGV4RU03RzZXaWYrNmEz?=
 =?utf-8?B?ZGVMZ0lMMXYzbFlwOU1zbjZQVUpQUnVrRi95M2NzcjNBMlJod2RIY0VyNVM1?=
 =?utf-8?B?eUxpbzJHRExoTTNsR0dYdVVMaWpLVWNBOUpNRnBBeExaQlNVZ29vYmRVWHhX?=
 =?utf-8?B?ZFJpaUxMbGJFQkNicHNWWCtjTEQvN1g3dHJzUFptNUdVZk04ZTJ5ODlhYmJD?=
 =?utf-8?B?WnA3Mnk1dFN1ckY2QnFTL2tGYlNjbno4TU5mYXhGUkRZOUNHVGVJVU5zdmw3?=
 =?utf-8?B?WGMrWlVyMjkyb1dQa0YwNGVlMG12QzdNRGVxYjVmczJDNFJpVWVaYk5uYlV0?=
 =?utf-8?B?ZnN5RmJiUFI3aXR2UGt5Vkc4cWFUZEVqb2swaWNOSDJCK3A0YUFiZURZYnVm?=
 =?utf-8?B?SmRTVUluMFVvaHVKNkVPZ1I5aldzMi8vMUtVbkNSUVNpeXJCL3RNaFFZU0Fx?=
 =?utf-8?B?WU5icXdaaTg4SU41NW5aY2JpaUU1K1BjSXdtcXpUTmhxaWdORUxHdFZHZzZF?=
 =?utf-8?B?M2pNSFFhZmtqbm55Q25taGJwSVZHNHl1NXVCc3VxdC9FbFF2U2h6N2s5RldE?=
 =?utf-8?B?NVZsdUpQQmNQaGk0QzhZdTcvcHllbE5kR3FnNHA0bW1FV3pDUUs3Y1YwNFRx?=
 =?utf-8?B?OXpPUFhJcnFTMnNoNlk1SEY2OGlrcFpucUNjUDhtVHFEU0xVSlo1dWpjYzlU?=
 =?utf-8?B?bHo4TTR5RUhjUEhtU0dtdnkyYVhCcTlrUjJwczJGSHcvOUZYdFVUVGduZ3Q3?=
 =?utf-8?B?Y0pHelpwL1dNUy80MEc0eFd6cUhGKzY2aVFqSTNJdXpSZjVxaEk1TXY1MUVB?=
 =?utf-8?B?L3grclVHR0NzVks2WnNqYlJQNlJhR2cwOExiRnhJMXhicU44V2dKV2tGOEJB?=
 =?utf-8?B?WDNrdFBvZ1JwdnJNK0w4RkNkakZucUkzbVYwdFE2Zlc3SG5vUExLL0w1Q2Jm?=
 =?utf-8?Q?PTeW8MTODUOvl57QQ5CXVATtgi10fcaxbpiKItm5b7C/U?=
X-MS-Exchange-AntiSpam-MessageData-1: j8iM9avvcNZG+Cdpk2F/qUi2celaMfCHhL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7caea36-1649-46bd-70a5-08da26de1112
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:07:23.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkrJbw73u2R5lMZYO8Xh14i8PiIK8ooJ20F1yASml7KB6AjpKlybeyaRIHBmOihAuOx18dHm5PsdB0TtdSUOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3805
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_07:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250076
X-Proofpoint-GUID: 6CEfZMsU5bsjSgHf17LsfDhk3rLPc51B
X-Proofpoint-ORIG-GUID: 6CEfZMsU5bsjSgHf17LsfDhk3rLPc51B
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/20/22 23:42, David Sterba wrote:
> On Mon, Feb 28, 2022 at 08:51:30PM +0800, Anand Jain wrote:
>>>>> I didn't get your point.
>>>>> What do you want to get from this patch?
>>>>>
>>>>> Isn't this already the behavior of this patch?
>>>>
>>>>    Let me clarify - we don't need this patch if we fix the actual bug as
>>>> above. IMO.
>>>
>>> Big NO NO.
>>>
>>> The damage is already done, we must be responsible for whatever damage
>>> we caused, especially the damage has already reached disk.
>>>
>>> Just fixing the cause and call it a day is definitely not a responsible
>>> way.
>>>
>>> Especially when the damage is done, you have no way to mount it, just
>>> like the reporter.
>>>
>>> You dare to say the same thing to the end user?
>>
>> You have a btrfs-progs patch to recover from that situation. Right?
>> Plus, I suppose you are sending a kernel patch for the actual bug
>> which is causing this corruption. No?
> 
> Normally we'd have just the repair code in check, but this is sometimes
> difficult to run eg. on a root filesystem, or if the boot fails because
> some mount fails and ends up in the rescue environment with limited
> options.
> 

  I agree. The following patch has fixed the actual bug in this case:

    [PATCH] btrfs: make device item removal and super block num devices 
update happen in the same transac

>> This patch is the reporter side fix. I don't encourage fixing the
>> reporter because a similar corruption might happen for reasons unknown
>> yet. For example, raid1 split-brain? Which is not yet completely
>> analyzed and test-cased yet.
> 
> So that's a valid question if the auto-repair should be done or not in
> kernel. But an offline repair would do the same thing, read number of
> device items and set the num_devices. The decision on kernel side at
> mount or by user when running btrfs check has the same amount of
> information, so forcing user to do offline repair is a bit less
> convenient.
> 
> The num_devices is basically a cached value of the number of device
> items, used in many places as a shortcut so we don't have to count them
> each time. Once we make sure that the numbers are in sync, it's the
> correct stat. We know about one scenario where it would get out of sync,
> now fixed, so the simple auto repair is IMHO safe.
> 
> For the raid1 split brain, I can't tell and if you say it's not analyzed
> properly we'd have to rely on other mechanisms to catch the
> inconsistency. Eg. a missing physical device would be recognized and
> would require degraded mount, but it's unrelated to the value of
> num_devices.


Consider the following situation:

  RAID1 on d1 d2 d3 mounted on /btrfs

  Run
     $ btrfs dev del d2 /btrfs <==== but encounters a power failure

  At the next mount, let's say the d1 generation is lower than d3.
  We read the root tree from d3 (higher generation).

  Per d3 dev_item count = 2 but, d1 says dev_item count = 3.

  We pick d3's side and fix d1's super_block num_devices _only_, but
  the dev_items count is still 3 in d1.

  reboot; now the d1 generation == d3 generation.
  Let's say mount picks d1, and finds dev_items count = 3 and
  super_block num_device = 2.
  The logic in this patch thinks that the d1 dev_item count is correct
  and reverts the num_device in the super-block back to 3.

So the problem statement here is:
   During mount, a lower generation on a device indicates missing writes.
   But any write to the device fixes the generation number; subsequent
   reboots has no idea about the missing writes.

Thanks, Anand
