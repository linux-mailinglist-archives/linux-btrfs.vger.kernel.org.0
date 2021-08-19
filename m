Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB70E3F17DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 13:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbhHSLRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 07:17:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10020 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238840AbhHSLRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 07:17:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JB9lki023114;
        Thu, 19 Aug 2021 11:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AfsAxPo+pyFpxxevmPp1F4HJGSDrjTf4iyAC9D5i9oA=;
 b=qKnjO1iWjI10bvjqQ/7QseG0xjeu09UUtkzwUzzoj5E/A+UacGIrAaLtMSovs48XTzas
 wmE2QVwnvof38HpaUyh4C+3mTZRo12a4tpurBRp97Qxa0BH+uNcMcspvnhuGHqrfLmNy
 Hk4A9KD5fRfWrC/4Ut+LH8cu2CGeFCGhz5Q1fkSGoi5mD1+RfnY8FDC+bE86jxghxOjv
 EpueU+WTRugQgUdb/D5F7sHG6RqUdDu1Mf1Yhk8pWQlMQQp+Xz2PzZuWilBOjmxLsxfQ
 AupMm2JuI0wQQLHEfdWY3onZtdDFXDxBEsOvg9YoKlepGy6dDXjHJGYqp9Ofv5qIvN9x iA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AfsAxPo+pyFpxxevmPp1F4HJGSDrjTf4iyAC9D5i9oA=;
 b=fNCDirRwy0WFQx+xhTWosc3PzLiUQ/X2ZPvFla6AzmF18Mee7pX5/vt7I32LW8g7wfGw
 GRfowkKpCoMdfOwo8J5AYZxG2QsTMAWkAgNtVHg0Lc1D13HuWxOKzdJbA48R5jLo8hmW
 5lL1p+oo/fKK2EvfWDAF4lmheOeLw5wUWVMa8/Bbg9eTKYgx7HsKli3/VWYLu/CM33yN
 CI8u6DAc576XNTXj4xWHfNsZcmGverMPZSyOLFgTyKxL/ohIxJFRVTsh8EpGyOxDlGlY
 0zkuIm6t5JRZ4vfAW2+LFaYfm/m7eGZR+ZDZjtVuXLW0THiT1pmV5BvxUPU/KhO5pNIM 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmk050-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 11:16:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JBF8iP029483;
        Thu, 19 Aug 2021 11:16:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3aeqky90cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 11:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf+orJVlrsymBNZR6GOFe3Xq0KEh1zbBHTYMUBbXeV7FAVfqs/58GtsMskOfM2lkTxLDfU0x4KIjAkVyzIlRv1Sw5g62R+mJzyguWZMbXkR9S4vngNsvkxDmHtPpoa3JakgH5XK8ezUc8X6xYcz/fCODz9E3YRUedZKElI1YIH6zpZFK99sdPXLT16utYl6TLMojGZh8jgx0Ljk4+LsT/uagaP6Rx/XSVUcv1yhkmi+6pDprpADDhg4cxBLas+IGviOLCHYkQeWjRySTT6YPiMfiNJMczBlyVYPlLaTZ+ozir5VFa1YD0bfCMQk9H+J/xo4LTr9oShr/q3fEaEXxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfsAxPo+pyFpxxevmPp1F4HJGSDrjTf4iyAC9D5i9oA=;
 b=RS1QrIGP4V1w+04ocg53/WT40c0WutSryX2JMof1el4O1OiwL+HBiRp56cSqfupeQFXAF0YyIdAjjGFX2V5J0keTFxHfJsAySL/JkSPeLmX0brenXR4kLstRKfJoXXPee96YnZQukLj2dhqriuuwD39PnlHaqVoISFodDelFHvidr1IgexcshmiTLj9M5xElB/Mm8Ii8VnNqrGK9Q98JvcpvcpezmusQBnwjTmqCcHO/HnhpuAfZCB1B+q7mXKRPj3f74uv63UghR31j0njIm6K+Y1vDw0fii3q2sxhN9bXSLCP1ezUsU7VA61ZQ2ZiLBR9JtO/rCuU2GZRUpZCo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfsAxPo+pyFpxxevmPp1F4HJGSDrjTf4iyAC9D5i9oA=;
 b=nnLGFdfk8bKobhRgiCp81fwZduMlxIbu6jQwopL/bTeQMLTrwO89QQ6372y+XeW/+gP38OzZCUbrfKQIwafMMD9lok5LxzFMbPW+lirfC73/8QHyyMxruY3cAB7lQ0cezFANJhHkEJT8jmIJop/olGF0XOsDADnfR4zPTlTey3I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 11:16:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 11:16:19 +0000
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
 <20210809091916.GJ5047@suse.cz>
 <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
 <20210818234838.GB5047@twin.jikos.cz>
 <2f902c42-fc4d-05f1-7a7a-fe4e3a20e7c4@suse.com>
 <941c3ec7-73bb-e64d-dd6d-8c7725ab5f8a@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <27dc7b6a-ff20-2384-43b0-ffb67b62e37b@oracle.com>
Date:   Thu, 19 Aug 2021 19:16:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <941c3ec7-73bb-e64d-dd6d-8c7725ab5f8a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend Transport; Thu, 19 Aug 2021 11:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07ca5e2-05fa-4f95-9513-08d96302c486
X-MS-TrafficTypeDiagnostic: MN2PR10MB4127:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4127989E405220FF518EA1A2E5C09@MN2PR10MB4127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kjFdp6AHkA0OUdl6Oi1LF+NUZ8jZnmfbC9iv+r0XVNjqg0vnzt/+WknSfsSGu6CXjeofuDYFHhWrlxVEM1bc7X7sNeIPUZBp34/LrP0y5jkWxiLcI0iCkNLK/F4TR8cKHI0N8vo9/6cvEykN5lQJy77wclEW7jUIwH9cWG+O836q9Hsh5x5TG0Kw44r06T0ccK+eMX/CZK8WlVdpRL0A+gJzMJx5pjJ1oOX/LxBvTjYD//UIDpBqmmgNNvJLPgrm7MUPxA3EVgfBd5aaZdked8Dxc51I0SZrp8iEGyh6DReCE+FxeilLCsWJB6w3u//wt3kmtNE/KRq1KsHQeox4VemELfrgq5KWSuMcdzocmpLpvrF5WOk7Jg4N8U0KSap5CiGn+0eYtchU8v9YE/HtSlIYF66pr4/JVT6DqIvoOfFbxbRc1oPJF/IpyCT/ogELaRXoHWiVV0jW/78lJgYZ/IMV/U+vE37VUPGmxcYoSVsnuA6Io1ax+fKderu/0caDIxVhk0PFVHZfZjs6i44BV04D16Z6nhVxWk3mVDpD6C6tH8eXVSwDPRIpX5F80TysRxL5BUzsxfrfb8Hcg6cQXOgq4XZgIHNhgzMSE1Zc00w0vmxHqh9Mw5x4p/aOf5PPmyD7okTwhDesmkaYug/FrDrSgIuEDMWY1DlWWZ4xk31uOTIW8Ic1JKaAkysZS5YUbGHguT+YUvPLFQo87S4Pou5fVDNFEEnzA9/Gak0NEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(5660300002)(956004)(31686004)(86362001)(36756003)(16576012)(31696002)(8676002)(6666004)(83380400001)(2616005)(8936002)(2906002)(53546011)(66556008)(38100700002)(66946007)(66476007)(478600001)(44832011)(110136005)(316002)(6486002)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q28wQUtlTjFFZ0cvOElhVm5SeFl6Ui9xWGRKenRzWUFTNEoyeTdXaVNZUkdP?=
 =?utf-8?B?WU02UmQ5U05LSkE1YXI4YjZoaGc3WXRQczQ2TE9XbStMKzNlTUNHZ2RVWjl5?=
 =?utf-8?B?UUNHZjFMSklZRlpxSzJSOTJZWkNSWXlxYTZTQU9HQ0dveWFkMUs0cms3OUFz?=
 =?utf-8?B?aUgxV3ZoU3ZiSzU1Q3FnMWNjdW1WNW9ONWZnQXBZeG9TOG83NzY4WXI2Y0gw?=
 =?utf-8?B?eGhaQ0p1by9HL0YxUUR1bjNWVHFOOTMxUE5XVzdFYUNOSDkxYkFSUlFYbTBv?=
 =?utf-8?B?eUpkTU1xUzhtZlIzWmt3N2IwcFZLTm9vaVRsV0t4WVVuVjNGVkJGbUhNT2sv?=
 =?utf-8?B?MXlicytuZk00VVY3eFcrcWRVSUFBTTVyTjd2aThBWXkzR2d2bUxUVlFSbTJn?=
 =?utf-8?B?a1IwcERlc3hqeFVMbGgyWlNsR1ZqQTIrbkp6SmgycVlLSklZY2NybnRBK1U4?=
 =?utf-8?B?UlN1NHp6ZHhVYk1LMU9NTFNMNWtEdnZDNDd3cjZNakNSRk1wTmoxVE8vbW1u?=
 =?utf-8?B?R1ZVaWZ6VTFqZkNlR09pbkdoUEJ5RDJZeDlYWG9yYWZLbWZRZ3gwcWxRNW92?=
 =?utf-8?B?UkJGalNDTEdpNk1NQVNqaGU5RHJaRktmSWhpQ1BQK1Zjck1ta1c1REZIWGZQ?=
 =?utf-8?B?Z2YrM3dIbTNncitjam1RcWhvRHM4REs3bHdOTkVHOE9lSXhLUG94Y1ZrVGNp?=
 =?utf-8?B?TVlEYTBnRTBXNHVrY3haWmZJY3pZeTk1SzVoZEhNN0pwTVBKaVBGWTdiVVh3?=
 =?utf-8?B?aWlQSFlmdVFvbFBBNnZ0NitkcmJDTWhEVHVoTVJLc3NVdHFMS3FEeFEybUtr?=
 =?utf-8?B?L0lQM1R0cWV6RElVZEpQVDBUV0ZzdURIenF2WGEyNTZpdHdrQWxUZDBDZHJL?=
 =?utf-8?B?ZGdhQjBlWFFBenQ5Z0Z3K3RLbDhDYVcrUEFObUVwUkVpaFFQdHhkdXVla3lI?=
 =?utf-8?B?OG9ZU2VVRWc3QnhrQlQwT3pVQ0QrSWJqaVNFWWhIaWF1ZW84V1JOWXNVTTJM?=
 =?utf-8?B?VE5sbW5Lc0pLZGFOL3dKM2VxVXpzbFFZU3VVU3UwWVlFTXplOW1vRENtbFlZ?=
 =?utf-8?B?RU1wSjU5dVN5SXNEVVU2alVVbWxubkJzaUlQeGtmMS9jV1BOdU0vU1VDdzEy?=
 =?utf-8?B?Wlg2QnlaRnRVZGpLY3oreFJwOHJhQ3ZwQ2RKQmNiNm9QNEo3dUZUMFpVRVUx?=
 =?utf-8?B?UCttdytPemFlZ2tKMUduNnBtaUp5YS9PNGhMcmlzZ2tia3VBRGlYdXE4SGdK?=
 =?utf-8?B?Q1dDckNGYWtyT2dXSklIOUF2MjZQbTgyd2h4bW9uV3dKRHVXYWlmdTlJb2NU?=
 =?utf-8?B?TjUrdC9RR0k5VEEvMUhlU09yTEh2MXVQUlVLVDh6a3hGR1VlbWRuWHB3cWZn?=
 =?utf-8?B?NHY4dnFraVFEMjlzMHovZ0wvbEtiaGQ4TmRVdVJ0UndhVmdwQVY0Y3hUOWlP?=
 =?utf-8?B?Y2pCNEpUZmlHbjBZaCt0SnlVKzE0SDYzYTNGQ05raXlPWnRWMHBmQklyZGVv?=
 =?utf-8?B?cnU3NWwxL0VUOStSNVR3ejZvMHhFTFdQdHRpWlVwSXZXMVZWcG41Uzk2V01W?=
 =?utf-8?B?VGZPdE53NkpXdlk5VEtiRWNJaGJ5ZjFINmxncUZGVzdvK3BqbXowdFhmdDhF?=
 =?utf-8?B?SWt3czhXK0kzOFhmWXFmR2dPampYSkRlTUpPUUUzMFkzckZwRnF1d3Q0Ujhs?=
 =?utf-8?B?OWlscGF6TXVSdUJEemdEaCtnV0dFSmRFREhTdDN1R3E3aldFU2tmWHNWWTBp?=
 =?utf-8?Q?KTpIEp0JsBqPPWRn1N7g0QzU7PMm8EawzOU/Eui?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07ca5e2-05fa-4f95-9513-08d96302c486
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 11:16:19.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8Zdh92tJvQVyPNcEYEjlkrXVErXCWSg/ECJpocGTMhvme9SOfPqZUxtKPdKGuuiOseIHAfL+PchbuNPfxAjcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190065
X-Proofpoint-ORIG-GUID: VPNBvVuqP1vqjPeN01OvpK4onYF8MjXD
X-Proofpoint-GUID: VPNBvVuqP1vqjPeN01OvpK4onYF8MjXD
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/08/2021 17:14, Nikolay Borisov wrote:
> 
> 
> On 19.08.21 г. 12:08, Nikolay Borisov wrote:
>>
>>
>> On 19.08.21 г. 2:48, David Sterba wrote:
>>> On Tue, Aug 10, 2021 at 08:30:51AM +0800, Anand Jain wrote:
>>>>    As in the proposed patch which adds a table to figure out the correct
>>>> table to add the attribute, adding to the
>>>> btrfs_supported_static_feature_attrs attribute list will add only to
>>>> /sys/fs/btrfs/features, however adding the attribute to
>>>> btrfs_supported_feature_attrs adds to both /sys/fs/btrfs/features and
>>>> /sys/fs/btrfs/uuid/features.
>>>
>>> I can't see it in the code right now, but that would mean that eg. zoned
>>> would show up in static features once such filesystem is mounted. And
>>> that does not happen or I'm missing something.
>>>
>>
>> This happens because when initialising sysfs we create the
>> btrfs_feature_attr_group which contains btrfs_supported_feature_attrs
>> attributes, which have
>> #ifdef CONFIG_BLK_DEV_ZONED
>>
>>           BTRFS_FEAT_ATTR_PTR(zoned),
>>
>> #endif
>>
>> Subsequently you define the static feature via
>> BTRFS_ATTR(static_feature, zoned, zoned_show);
>>
>> and finally we call:
>>
>> ret = sysfs_merge_group(&btrfs_kset->kobj,
>> &btrfs_static_feature_attr_group);
>>
>>
>> Which merges the static feature to the feature group. That's why the
>> message about duplication. So one of the 2 definitions needs to go.
>>
> 
> Looking at the maze that btrfs' sysfs code is it seems the decision


> which of the two sets to use when defining a feature is whether it can

...be enabled per fsid.
::

> I think for zoned block device we can't
> really disable the support at runtime?

  Hmm. It is not like that. Suppose there are two btrfs filesystems on a
  system fsid1 and fsid2.  fsid1 is zoned. fsid2 is a normal conventional
  device. Then on fsid1 zoned incompatible feature/flag is enabled and,
  on fsid2 it is not enabled.

  So IMO zoned should be added to btrfs_supported_feature_attrs.

  By doing this,
  on /sys/fs/btrfs/feature zoned is shown
  on /sys/fs/btrfs/fsid1/feature zoned is shown
  on /sys/fs/btrfs/faid2/feature zoned is NOT shown

  btrfs_feature_visible() and get_features() manages to do that
  dynamically.


> If so then it needs to only be
> defined as a static feature?

  No. pls.

> Just because the kernel supports it doesn't
> necessarily mean it's going to be used if the underlying device is not
> zoned, right, it should depend on the runtime characteristics of the
> underlying device?

  Right. As in the above example. Imagine runtime == mkfs time in this
  context, so to say.

