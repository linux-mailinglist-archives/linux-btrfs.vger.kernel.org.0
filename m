Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832DB403B74
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351897AbhIHO1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 10:27:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhIHO1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 10:27:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188Dskue032515;
        Wed, 8 Sep 2021 14:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sGtUAmWrS2lhpRFxTMvMoArCkMZxzusyAShXfdzwMb0=;
 b=j7xRoWS7ydZ3XtzNt6U8u6rBxqrNO+0MlHQYR9/HV9GVbfKY6IOCDuqTv0SbWET687qj
 n+ll6pjY2lDYUFIHnXV2+obCsbOpu3ZUy864mfyyVHcJ2GMcRqmvzOp+WdTOKqRv+N9S
 BRNR3TdBkHyhPfXaZebFuCHwcCiBmsuPf4aU++eklDgSlqD5xKi9sNetwZxGJ7xIH7wB
 K30/75R6jrX+TdKztSVcXcnlPkMrOy9ZxeuRmHtt4uGdR19Q035KCtLQh51jZHRjuXKz
 9lVRawplodUL/BdU3sVwlzZhxzruJzVjXKGxZCLNar8yLrBlecTnmY9gmxDLgrIRccZE cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sGtUAmWrS2lhpRFxTMvMoArCkMZxzusyAShXfdzwMb0=;
 b=0g9p8Q9xaz9axSu2lt/cxYaXc4Zlyq3XaoSBF/65Kd9yNzFZDkwPvaDXFjZo22tQYNZH
 dhSvcUXPhRCRlFdm6+3eiAfFD+tPShCTv4y0kqyijh5EjWqN/4HGLM0V8wV3etlVYeoy
 9Hgfcq9RXZYCak/aKXTLucvJUaykQd5bu825OLm3K64wywwqb+0lXoIBo40ZfDpLY/aW
 T3Ja1SLbC+POg8uO1o+UiebkRb3h6ay22fmMvQrxlxhKnSVnAMVTk0Kqis3A2Ym0NXqL
 bRQ1Sm3aV1dN0cnqdNLiUdXnGNU3EEl+lirYMeFsndig1DJWA/eHE5ZZ70leI+cAIpP9 OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqau6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 14:26:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188EKFK3157006;
        Wed, 8 Sep 2021 14:26:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3axcpntq1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 14:26:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUMwGjbhMKqNmSYatrLaQ6Op4X0bToYPWLAX0Z8m8Xg8d28XbkXidaVuJ1P8EoyJEA/bs1fFJaLt+3ZAbC7eHd8AyFvIkNik8/oN/N5Y0Ir//SUUbJ190O5Do/Ajs8Acb9jxGxeFAvaJHONx8EkvorIjCQzuJ76xP1hWPzk6fTN1fWtMDUPQ0WBVbMQLgZClldJlYwtkHT9pUxADo8EKW4pdJRNdqY0YQjjHgPBZXMeEVAatK/9bN/83sUPneNpRSQ65jhzSffp9gq0x5y6wwwx5uCWokSkYQetqVZtcqPCQBVmk219bbuERzas7MQ1Xjg0Pnf0uTJUIndtoTu0iEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sGtUAmWrS2lhpRFxTMvMoArCkMZxzusyAShXfdzwMb0=;
 b=kXWK2gBh0Dv6FLE5fIe128LAl2+u92arM2a6Hb40aTGb7bDOVMb8DRQJ/Q3l+2lydjCt9oDuwCVhyZyQMBnGud32yqYTRsWC3aIBO8snUGUjejzIJ71zXBEDSz12Cg1INTw0pd39LpdpWv2irJepGNN+AdDo5rFHvAzQLj7j5Yz0LtXfCLOd1DWRrXvj5F66iEMQFeyPyQjA8dcWQ++VcTFLKhCtpwnTWBIO25u11b/v6ltCmBSexyodZdnbI7DKKOqxDOB/4FVs/9qU0TLoqAc5Hx7PfelSLnySQCs+Ds0VUmhX/kM5I00UzhGjbLr0O/9KtXw4+/PG+3pZnOUdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGtUAmWrS2lhpRFxTMvMoArCkMZxzusyAShXfdzwMb0=;
 b=w+GCtpi4cpaqab0UqcOkycBhp/h2ps12O2ipqtvcWhzzaGJEoZdw7dB6NPfhrWDuzguCTLQTOdNdCDCrEw+dGUW3k/1BdqnmPpOn+05dSvPodU51yztw6YwNe3A+Wpb7OiIq2bfJIypFP2bD+iB0Hti/prTgFGjP6WYUF9iAlJw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 14:26:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 14:26:00 +0000
Subject: Re: [PATCH 2/2] btrfs: remove the failing device argument from
 btrfs_check_rw_degradable()
To:     dsterba@suse.cz
References: <cover.1631026981.git.fdmanana@suse.com>
 <6979a21084ce679d34896cf8092349e845e1843e.1631026981.git.fdmanana@suse.com>
 <20210907160506.GQ3379@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <b590dde5-05be-7957-636e-29c8253da147@oracle.com>
Date:   Wed, 8 Sep 2021 22:25:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907160506.GQ3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.1 via Frontend Transport; Wed, 8 Sep 2021 14:25:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e20ec82-ddb6-4354-46bd-08d972d49461
X-MS-TrafficTypeDiagnostic: MN2PR10MB4350:
X-Microsoft-Antispam-PRVS: <MN2PR10MB43508AC7E3C22D0B720F9A74E5D49@MN2PR10MB4350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ubbc/1UgmOctxKJapMNnxo7bkRzDGsWwGnmP/P9cP3n9t8CDw5Hm9XGEmN5zUD27KXJGytLv/yHwh3yOueVZBf+qBWu5IB3dHowh1e3w0aFenbCmP9FJzUgNqi8MgWI62TOpQ4zc5pH5nouWBXknBqgN1oVSaSQu2BRjfS2ZOTavOi3NiV0P49/tbuE5cBbJofHzVm5rhVxf03d333DduRsNpHLaVG+c5wMhznwRq1GBNRgd01AiMG9MFWRDLzBF4FzBhpQ4Lti8kYOavp4+bzndODOo/LPmk6+G9XNgmkKMbr+wuFWYC8deuQFZ4Mb/rLxtqomDUfUm4kzE7X+6Yt9S5C7qFc/tq+6D0sdcNmBF/PiW94TTCkqjYjOQp/9I0lFrxkFaygz7fdAvvca2e2Zq5fAPsUj72EhtfsyFoOAPGfa0O1uwcx3+a8z6bxIZ2hruKifo9GY8+Vs67JWe57TeI7FMpcMvCeS0rN93zvj62PZyvSlOpvGH7S5nXWH1SLKAODQiG5i5LCkkcQQEFsIyL9r9ev4mnfRS/WI1/HdoT+g/iD6xkesQHYBERX/dMFGa2DHll+6c+lUwE/NIqpxAWa155/GeMMhfG/VqX5dD9yILz7OtSQNzEv/AlF87NdrOPSOWn3wBHGv09pPIHW+ehEclD4GpCQSiUAZmZGwBHfZByGGDt1FyuLjbjEP4LxFYYR1+qEIqyZ92qzqB7GlFgBIKHlqodTot26HKrWEjq5EDDYbF9EAghbwHecMHOoP0kwMyNCfn0X7K3LnO4nqC4VBluQrrpF6m3d0d8tvVoPqV8Soep7uJq+fM6KwnysDQSdPEg7cp4xSnzBWiBEr0VQsfSdWzz0a8FnstqdZ89V7QaTHwe3TLTT15wvFfbw6MPTrsban/yi4kzCaAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(2906002)(53546011)(83380400001)(956004)(36756003)(26005)(186003)(8676002)(2616005)(5660300002)(31696002)(44832011)(966005)(6666004)(478600001)(316002)(16576012)(6486002)(86362001)(31686004)(66556008)(66476007)(38100700002)(66946007)(8936002)(4326008)(6916009)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBnNjNOQ1VmRFBFYis5bnVreFduNFJBdVU5bkdmOUhDTUxuV2IxM0RraVFS?=
 =?utf-8?B?VHZxc3dlaWxuck11aGprWWkxcWJ3VjU5Q0dIaTJRank4RjExNXdXTlpjRnBy?=
 =?utf-8?B?Sjdja3dBUnFaL3dEOFdLeFY1OWJDbzJ1Ujg3UytOWjlsK3VQbDJDc2Z4Z2tO?=
 =?utf-8?B?YWVGcU9FY3hIT0RpaVJJRENYRy9OUFdDeDZaTmtMY1FUdE8xbFFRaHM1QjRY?=
 =?utf-8?B?MXZwLytOb0xHVzNMSVdiT1htMlVscVZuZzMxV1huSFJnelZSWkhuRG10UjdY?=
 =?utf-8?B?alM5MXdaZ081dVlmUndlU2ZmenllWU1qU28rSm1UN2xmcVArcjY2c3Yvd1Nr?=
 =?utf-8?B?MlJHOEJJT1pwL1Q3S0xMclVYUU15WmVnSG9FcU95Wm1ZQjd3Wi81ZGpVQ3dk?=
 =?utf-8?B?MHhURFBaZ2ZDajhLaEpWdXVsaEVjcVFOSVJWVUFoQ1NlUUdLODluaTVoMFIv?=
 =?utf-8?B?Q2doclRBb09GQ0ZXcGhUd05IenYxQlM3MmZtNDE2V1B2TkhUbUxYVnBYRmo5?=
 =?utf-8?B?dnpYZUsxZXNYdXY5QUMxNkMxdUREZXR1TzBNM2tiYVdBcUpFbDlEQm9KRGli?=
 =?utf-8?B?Y3lQOGZ5UUdGOFpocWlQdXZicG93T3dwMjQ1c3pnaFplaDArcmwrV091VGtm?=
 =?utf-8?B?ZzNJSGprZjdSbDdXL1JBaWZyQW9MbWtOQjB0M2tDK25aM2svem4rWS9CenIv?=
 =?utf-8?B?cTlpZGtDQmhGbDZmeVByMEpONzMvUk9FdGorVSsvZ29lT0RMMFZ0VHhsSFpr?=
 =?utf-8?B?Qkh6cGhOdWtDTW1CSUdrTFgxMVgwQ3NMbm9pTHRmdi9KbUdkZHAzM1VuNmxo?=
 =?utf-8?B?MVZLZ0NsQXREY0c1NGxzbUc2TGhFNlFyU1M4ajlxYWlmM2Q4dGlrTDJXeEpq?=
 =?utf-8?B?dnBLKzhwZDdtWS9ubmFGYlF6Q05talQxb3NSZkV6blNFSTFxWVJLd1lNTEF2?=
 =?utf-8?B?bkRhdVV6U2RGM3RHQU54cVBYZGRaVTVFOC9JY3l2dkRYYlRGRHpnQjR0VU83?=
 =?utf-8?B?QnZ6alVqb1gzcHNOUkpoQ3JScmJ1dW5PMTB5cTd1UFN1UDl5OERjbks3YUxN?=
 =?utf-8?B?RVV0WFZJSUw2NldLdlRPVGhXSzdpSEpvYUQ1anV4NnBGek1scG5pTU5Qai9w?=
 =?utf-8?B?RlpZRUI1UWF0YTNJWVVxL0gvYjZWZSt0dm9MWTFuTmZQdmk1eWRvZElCMW9Z?=
 =?utf-8?B?Sk5MeTlzdVd2OVZzRGJEVVF2bERPckpleXRQTndXb3lBTUsxT0t1WDJNZk1P?=
 =?utf-8?B?V0ZQaTZJK1lSRnNFQ0Q4V1JTSjFJMzF3SUxrMWczZFpnUkhzQnlBVVU1bjhE?=
 =?utf-8?B?QWRZaDhRNkhPbjRhOGNwTjRtSlhURm1iNWxkTk1uejFsYVZlQlpHcy84Tkti?=
 =?utf-8?B?YmtmTFY0c3BlaEl5YXV4d0trYVlJNVdNbE5BMUdNSWVYM2lpTmR3K2tNVlFt?=
 =?utf-8?B?SHp4dEwxSlJDblVxd2QyUHBtVTBSOFZpT0ZnNGlqRmc4aWxHc3R5K2FjSlM3?=
 =?utf-8?B?QUFxN0hxSnMrQjlqU2FxYU9FalpmNXNyOTZtTnlhUDNPYmJvZ3VqUHJxSExG?=
 =?utf-8?B?QllpeXpQMDVSSExVYVlGOGxZSHp2VmpQTDVMSUtlb2ZBcURYbUltd01GZDk1?=
 =?utf-8?B?aFZkbm5pM2R1eUNrdUgwZmxLRnQxTnBwalJvMlF2TzJqWDVuYzRpYkpYbE5C?=
 =?utf-8?B?L3oxMkVGRnhqanZnTVo0QS92LzJNa0RvTUp1aXQrcXd6SWJhb2c1dkNDLzhC?=
 =?utf-8?Q?huafVJQ/4JIJeFvHdVzxs5dbRNi3vWiGqaNklzQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e20ec82-ddb6-4354-46bd-08d972d49461
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:25:59.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dV9wRnysrfZLgr19ZmiMlq92bByFqC26LV5pQNPeUfHRtXJSuo9NrDtGmiI2Qr4Xzg2Anq2g1WMDH/thIUyvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080092
X-Proofpoint-ORIG-GUID: 0wMieXWbu59FReg4Ae1Kz74RShu2wQ1-
X-Proofpoint-GUID: 0wMieXWbu59FReg4Ae1Kz74RShu2wQ1-
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 08/09/2021 00:05, David Sterba wrote:
> On Tue, Sep 07, 2021 at 04:15:50PM +0100, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> Currently all callers of btrfs_check_rw_degradable() pass a NULL value for
>> its 'failing_dev' argument, therefore making it useless. So just remove
>> that argument.
> 
> Anand, did you have plans with using the argument? It's been NULL since
> the initial patch
> 
> https://lore.kernel.org/linux-btrfs/00433e34-a56e-3898-80b9-32a304fe32e2@gmx.com/t/#u
> 
> as commit 6528b99d3d20 ("btrfs: factor btrfs_check_rw_degradable() to
> check given device") and it was not part of a series.

David,

I have a local patch which is V9 of this [1] using the 2nd argument of 
btrfs_check_rw_degradable(). Essentially to check if the mounted fs 
should fail or can continue to write when a disk fails.

[1]
btrfs: introduce device dynamic state transition to failed

https://patchwork.kernel.org/project/linux-btrfs/patch/20171003155920.24925-2-anand.jain@oracle.com/

We need further discussions on this design. I think.

Thanks, Anand
