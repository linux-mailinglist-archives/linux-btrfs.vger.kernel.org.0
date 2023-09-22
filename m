Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C777AB247
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjIVMkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVMky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:40:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5903A8F
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:40:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MA76Fp010985;
        Fri, 22 Sep 2023 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WJCWOE+X4ErJYVT6FdNEbCUOTUzaMcJ9zdlRJUBw0Jk=;
 b=Ywrm6cLvwBY2nWbtNW6s4UAoqA1KZnkPY8u8ly4fhlGalZP/JFARqlPJ16mBCCqNQKZx
 tebcgoXSHMT2Xl+ih6QJqqk6UbBw5UOYrGyPSgyRC+10CDhCKXRkXGyMhPJ8gyMKM0dn
 v6omK0RjC2iDc3Pjw9vvy6bb3EyS2HIqVMNz6WGEDf7UqQq210AplApx8Rhb5zOs1aDx
 Vsb7psRbi4+JMiHRjUnBCt/pW2S1O+30oBT2jNL6jJiXlklIEdRUMcJK2U8/Pscd2SD4
 03YQF6JPzr2EDJbbKBj5hTh/HVSm4rJL4+E1KxCV9y8D5KsUaTI+5Vp6YAHwV+MV2nyG 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv1prh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 12:40:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBRTIx007626;
        Fri, 22 Sep 2023 12:40:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhcqak0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 12:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4eMtxvxEJvVBSDBFBOHQB5nNCJPJttTOftGMXUvEwkMvoQ3itUtiuCmaem75bItZlgOiPppdtwqp0OnmzEHT8SGT9DAWpms7p3ArT5mWWVjQI2C79JvecWdNa/on8J6ioNSuZRoTTVW8Hh9tMOuzK4bGcHFWZVrP2+6DVwggZ9gZU1UycKYM2jDb6TJI7ABBL0VUbk7ZIpB6/w0nWSvT4wFLiwaRGw6SL9IacfL9ijxjKW1abioVrsVNkrTTmZkJMCnUKsKlGTQf4F32cH9awfUdlIaNAGdqRC5SJtZVj2YLkB5g8tlNtcHQBWsQJk49ZlRRP7NeUxHabBiJSDx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJCWOE+X4ErJYVT6FdNEbCUOTUzaMcJ9zdlRJUBw0Jk=;
 b=P7gOC8Z83Df2zKAKp6GBiRp/d0go3JNfVDAoVMa0ySyldPolIBrUAlqhbiCQ6nK2UU02GVexIWGZh7Ris4ssllsJUCNjTTQM0OxWRQ7wyWs4ANCWcn0kvsf4LKdTEj+oZ0wWd7Bz/TMWe2p+TDJ6jy/pZrjQzfmuYFyBp6IddMGUEG6nMm4pv1VOFGfZt0UD8tScU1IDhAzLFr/gmk6BtObSbwncp/LJfh6bad9zhb6Q4MeV3F3e+VcGREl9lJPF/jKBG8gLYmt5AsIAxrR4FlZvNLmXQ/14W8qYt5kqpnUYE3U1I3+KNZ2tEcAJjQ9GSlYgKYCq1ogaqO1pXVShDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJCWOE+X4ErJYVT6FdNEbCUOTUzaMcJ9zdlRJUBw0Jk=;
 b=uJcwgB4UABokc3M09JRZKro+c02TsFOhtO5/DiA/+BxsfydNSEOEdLMA7v4yU9oiy6CzbTfZxE+Xyp9+u/ARlunlDVUnKfQLyIcmQMkNtuBHqBLGgFH2QygOn8qVu7KsCy1+ChhC7urJgFMFDVzhC0bdZ37i28b4oMQXONbWHyc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5661.namprd10.prod.outlook.com (2603:10b6:a03:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 12:40:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:40:42 +0000
Message-ID: <2be9c158-400d-41b3-69ff-839064074817@oracle.com>
Date:   Fri, 22 Sep 2023 20:40:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] btrfs: reject device with CHANGING_FSID_V2
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695244296.git.anand.jain@oracle.com>
 <83e6a50ea2040a27e0dc05a09a9213b79e8938c8.1695244296.git.anand.jain@oracle.com>
 <20230922112344.GC13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230922112344.GC13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 72842ab8-d334-4726-e705-08dbbb6921eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDSjwbXTzme7o2CrF8DD00cTX+rd0NfL3I0wDSS9rEfhtCzxzu5Jv8GGb4P1LQc+Z7PsbW8BPJZA3rrTW7aS6p9mdkLKfD34punMcAK8FG7yGukl0/5kL5IuUsXNzX+pTAD8ReMNA6YPzEtihigHtpn0ZlcE1mlQ0DHUC/TVFZWvS4EUBQm/JrRPGCvZzFLkxhWD572e9a17vijUpUZH1Ixyl1tdHBfg+FT9ay7HZgP6LWfSTCiqcOBuKNl4adxnI7ExUIFfq+AJRqdCBa6ggfkcTqANFa0vb3uLqd6X75EpCF0wdF9V/ZLrLhUFjcY+Qsan6U4x3NVcHOqhjhAkeATrvdDDXSWuJVrg4TtRDXc+xNLzwN8zzmL59e+21NrUC1nsybqiFAKMvGaM6VgjYmup+mCpr/46cKnE4GqLrnmugzU7I9Wk7WzICPx6NmGaTYkZxPbY68f4AkxcbOZCWiGUpuQkWZNEuj1UVwCt6zRJWnhmS2gugh8a0Qkhz85t0tDwBxw7dX5XJJ21m22r8X0VAJHMpsT8L8VBL/lg82Ek8KA6tBRBDftFyHCEhu450sTAflWIOiB6jT7HRneRX75qAxOdQWVFodTIJBRCz/a0Ys/ObBB74bZGdpURtP6FbYzc3MhRzNZwkFT+3i47GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(31686004)(44832011)(31696002)(4326008)(8676002)(36756003)(86362001)(8936002)(38100700002)(5660300002)(66556008)(316002)(41300700001)(6916009)(66946007)(83380400001)(26005)(66476007)(2616005)(6512007)(2906002)(6666004)(6506007)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFCclliS0g5OW9BMkwvQnh2ZGlNNUVFU0ViUkF5VHR3c243SHJKMU82ZlJm?=
 =?utf-8?B?OHNya0sxc0haVXdMU29sWE16N29BTWZOdnZKejdRTUEyNXhzdE5ISkpBelh5?=
 =?utf-8?B?NzhlQkdsaW51R2J4VlNJMHpNZHVIb29JaUtrdjJGT1A1b0Q4dE5hTExLRmJV?=
 =?utf-8?B?N0YwR1R0OFhXWUtjUWMvTVErYUdROFliWVpjSjZrTU1FZUUrNXJHTTFPVTdq?=
 =?utf-8?B?Y1A4c2FoQ2h0M2plNUFRcjBNTFNVM3JlU21xVEZqRW9KTCtMeS9oblBUbGFT?=
 =?utf-8?B?Z1gyYzFUWEw2bDk5dzRtcVJnbmpxT3pMZ3NITlRCY010Z3Q3YlorT0pzdCtC?=
 =?utf-8?B?WDIvWmYraGZacU9qSGoxekRLQlZWUnZtYVJ4VjFhazJwSGpYRmlUYVZEeDZr?=
 =?utf-8?B?VUg5L1VJT3NxZWxMemg4WEpiWnRpKzg2SElrNUtGSzZ5WG9LKzRJOWk4aTRK?=
 =?utf-8?B?eU9tb01KQ3RNMFJvM3BXbzEvdVlFTVFWQVpJZWJFUnQ2ekhmSjdZUG1HVDdl?=
 =?utf-8?B?UGhLUGNOT0MyWWJEVXpuSSsvMnYyUkhYbXhYSTlQem1ja2I1dExnYjZtajhy?=
 =?utf-8?B?WFVzVmJGZnNRTWlkVjhGcG9acDdjVE5UTHFPbkF3MTJXNDN4N1pLUmFvTGRp?=
 =?utf-8?B?MTlnWWo4L0ZOeE5LNDZjVW5lbk1QYi84VGs4RlVyYnRqZVhRUUt4U0JFaHdF?=
 =?utf-8?B?eW54RUVCWFJNd1ZzMytncXFYRWU5NE5WVlRGaWVodXR2Ym1QakZCN3lFaUJ6?=
 =?utf-8?B?WUQ5UVhORzM5Vmc2bTlTZER3WW42d2pORThQblVwa0IrbDZMeGp4MXZudmpU?=
 =?utf-8?B?Q1prd2hKajlCZXhQV1dNZFVPS0VrdTBkZk1uTldRSzV6bVdHNk14b3Z6NDBz?=
 =?utf-8?B?UnZhdXBSOU5rOTVVcmszUTdlcTNlditvZXQyd1U0WlE0M2NocGRSMHJrK25U?=
 =?utf-8?B?NmFwa3h2U3dFNkdyRDc2dXI5QWpjUDBvU0JlWHd2TkxmeFo1cFZQcmtRRllw?=
 =?utf-8?B?NnJMdHdWUjdkWkZraGpwODZGUGdkaVY1V00yWVlXcyt0KzNGa2Vxcm9LRklZ?=
 =?utf-8?B?OElYRGs2NTFtM3BTZ0NaeDFqWkNoUFk2OFFHZ3dVTEpmSmJ3blZWNEtQZXpq?=
 =?utf-8?B?MjRFbmFZYklveHAzYzUxbUxzSTB2MTl5Nk9DTk45YkRuVUNCUnUvZEtDMGlB?=
 =?utf-8?B?dTRldGVpTFEvK1RsRW1BUDdmRnowVk4yYlVESE9ueXA4eFF3VXhHUm1nNkxp?=
 =?utf-8?B?ZmkxQWp5NVBTcXZkczhOUkcrWFNKNWNjdXhNRXBFUzJNMDdyeFFSM0xBNWJT?=
 =?utf-8?B?cTdTZVJDd3lldnpocFRpbkxjU2lXR3ovQnBsSUxWM0RCRWVoU3dYeEZkNE5z?=
 =?utf-8?B?UXBpYVU3Q3o4S1Y3Z0hIM3E4bEkwNFRNVjdWWXVJbkU2eHJnSWpFS0ZwZGZy?=
 =?utf-8?B?aHlBeW1peFV4cVYydVJCUDg1V1R1TzA2UDlHVWV2d21tdEg0Z216TUhIZzd3?=
 =?utf-8?B?enlJTGdma1F2Tng5SjZ1Z3NNZklUKzZRVC8wU1d1Um9NbHlMWU03bjJHSTVp?=
 =?utf-8?B?M0I1ZC9GRGxCU1hOUDRycHhtVklBS2VvS1lTTlpJb283dUFNcmFUSHNxaVRL?=
 =?utf-8?B?bENZazJpYWgxSGpab1ZKY2NWTlNoNW04d3NQOU1zTkQ1bWtPeHZtbUN5NFcv?=
 =?utf-8?B?YnNSWTRla2VoMlorOGJwOXh5RGY4SmFNVk11aGtlWnJOdnRuV3JhNUFyVWhE?=
 =?utf-8?B?czBFWmhER0RKczZPa1NYOWRNU0QzOVg5UWVHbFJ0UnU4WVgrRU1BWUZRNnY5?=
 =?utf-8?B?amorQXliQ0xuRThiallhY2Z5dVFSeG5nYWtjZUszOE9WcG9Oem5ORDkwQXJv?=
 =?utf-8?B?ZkV1OEhxZ3VIb1JLTnNFWnVIYS9GaG9VYkVnOGlFZksvSGNwTE1QdkJEQ0pM?=
 =?utf-8?B?c2hjRUFsZDZpNWkwM0ZvdGZNK0pzTmNoeUthRTg3eVc5WFNOODJxaWdTNkRM?=
 =?utf-8?B?OEpDM0VSTGhFWW9PS01maVZOYno0RXQxbHlRVmJaNkhUdVFNWXhBZzFrK3JY?=
 =?utf-8?B?TUplbFltbE1tTE1mQmhCekIranU3WFRTWEZqejRyTEUwL2ZieEM0WnZnV2wr?=
 =?utf-8?Q?XoF8Go0A3a//YPdLhkKyAY5ls?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1bLXIg88+hAcninXIAnczSMAzZPSx/VhgRU8/MgcYakp69O29T5e9g74umRGkxbQ7fT2mtDFkpr+DZS6wGf60H5ZyxpOf2VBkP9RQ8ryQD5TnzRnPYw1trpfmShW1Dta8h40wjJGTMfDQozKWRQeXP56BhzD2wmls5n2as2anU/YfgORHQweSgRQMsgGaEAcIQU5IxEf7VEvf/3QkZdfq+4J764VMiT+rA4NlY6ewEzjJ+ceFEjBw+0lO3ZRTQjzZjeR5UfTEjbQWq0ejL7GnjDB9L0zOZQra/qAF+Tw1kTo8HEynQibpynfUg9SmyDSXKlT7qk0od+o/k6vRxlXK3B+GgU3VW5wJ5rcHqyXVkF6PQJUuIaASlh2QWivWeiXaKqjSPgsljEGice7uPMpMxLuXnT/ezsUSP7wpGJDg8+skJrlq8AwXs0f1xnbzjuGx+Kz6TAbUuHW1mZTE8Q4+jZUpEWq9Hja3VWfHAJz89JnmFVDvWhsNGiDCuDAgS2BMLj5kgpXqB+bJ+3XvmVE9BEtEzDyEweXg56yNeJz6KVJoVqSpYzUTH00t3/STx/+kRUW+XgwG2gaw9rhpM5OvesJ3zJabTFiXfwhki4AUCv2/+yCDJGD2I5rV1MidTQCpTLE3Tnwx8TRYViEFohPAXHmMF1dUa4TIC4G7/8xe3FHpqqwNKxMgucHEJM+6SBiysKunpU2Khxo4Zjs+uPvdxw0UFNZcejDaiFcHEbiC0reEryB68L4LYdLJxXj32gXEPb0fD3M7c/E9FQJzOYZimCTEBnX9d2b5K5zN5WQMjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72842ab8-d334-4726-e705-08dbbb6921eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:40:42.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgXIhLFpKBX2ILcomCwlHvylHOl1IwmMtkIpb0OpCgT1UvuhgMc35oDRMhP2sdGFEP789fGETahWyoD+dEi/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_10,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220108
X-Proofpoint-ORIG-GUID: tw5uYC1vCmj_ECZslm5En-AKFqt9Eh5z
X-Proofpoint-GUID: tw5uYC1vCmj_ECZslm5En-AKFqt9Eh5z
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index dc577b3c53f6..95746ddf7dc3 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3173,7 +3173,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	u32 nodesize;
>>   	u32 stripesize;
>>   	u64 generation;
>> -	u64 features;
>>   	u16 csum_type;
>>   	struct btrfs_super_block *disk_super;
>>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>> @@ -3255,15 +3254,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   
>>   	disk_super = fs_info->super_copy;
>>   
>> -
>> -	features = btrfs_super_flags(disk_super);
>> -	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
>> -		features &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
>> -		btrfs_set_super_flags(disk_super, features);
>> -		btrfs_info(fs_info,
>> -			"found metadata UUID change in progress flag, clearing");
>> -	}
> 
> This is removed from the mount path but it's still rejected because at
> some point the device scanning will be called and will return -EINVAL.
> 

Correct. This mount thread calls btrfs_scan_one_device() with the 
mounting device as the path and verifies its superblock until it reaches 
device_list_add(), where we return -EINVAL.


>> -
>>   	memcpy(fs_info->super_for_commit, fs_info->super_copy,
>>   	       sizeof(*fs_info->super_for_commit));
>>   
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index bc8d46cbc7c5..c845c60ec207 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -791,6 +791,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>>   					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>>   
>> +	if (fsid_change_in_progress) {
>> +		btrfs_err(NULL,
>> +"device %s has incomplete FSID changes please use btrfstune to complete",
> 
> This could say it's specifically metadata_uuid.
> 
>> +			  path);
>> +		return ERR_PTR(-EINVAL);

Here.

> 
> We could probably return -EAGAIN as it's not a hard error.
> 

-EAGAIN is fine.

> Please let me know if you agree with the changes, I'll fix it in the
> commit.

Thanks!
Anand
