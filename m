Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED923F6D5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 04:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhHYCPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 22:15:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39042 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236930AbhHYCPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 22:15:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OLbBBi015031;
        Wed, 25 Aug 2021 02:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xmulUNMWhAbTX7/a5Jf/pULK4zS5SiqY5dMwh8j7lrU=;
 b=h6Be8inLUh+Q/v18VtmU5asQnfPjt1yVu6lRPrufbah9k1bS3n77GhAHlK03ietpGynS
 3fhWpirW83bZZycDqWN554TMPk3NXxdqe/UmBhnqGzYPQX6TRQoS4SmPyQnvnTeCtYo1
 x8T53PUvwEkpI2JM7BzuW09Q1iwu6Ciu/EXGLG91Rm/VGi1VZog6U+CfRsMgicc82lLt
 mQGUXhK83cd5NWKaxAQPhO2lQ8lrt0VYp2ES71rP6B5kffB5ErY8mgg943zt5mnvvQTB
 r9SH7nPCBCJpry9bTAlf/HjF1JA3N12E6nd+dPtJUgFsxu+C08Ehf1Mpsvj2LyabJ21Q gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xmulUNMWhAbTX7/a5Jf/pULK4zS5SiqY5dMwh8j7lrU=;
 b=j8JdR9p3jB5H2wmExeO6aPO1Nb3/GL9z1tjEDHGTwlrqV6h8Meg/3v40B2jO9xANgG1k
 jCNnaSHisglDW07FNZVI7KPBfrDCIDc9h85BB+3E5xRv7LgVs3Bpvha2sn8+qae+7oTW
 XKATEbyJ7gvEWlfJv4QwLJhc0doy9kXV0bZxB1K9boJZl0Qpnm9+cYo7t6OAv+9SJw1F
 GR2ebhqR/MAnGDaGI47XX2r4jYTNVM+KZSJjKcfLAYJq4v1jQeAQRrCiphQKzbyZq+uY
 MvbA5btst4oHBjlHNLoqB1F3vr3ulmU6RRlz5By56GItcL5c6uM4rKdvXTkS0CR0eYV2 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwh6j6kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 02:14:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P25SoZ021892;
        Wed, 25 Aug 2021 02:14:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3akb8vws22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 02:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6ZP+7J54DPwAZApztsEkGd8GWf0AVSKW8pQkifRbDULHuexeCr1PMup15Y+NItIe18H3OqJ8VwrjGbo5E85NAP2ImOX2Xg4wC2uawwIO9xFaLpp8a7/Ads0RD0DOSvwVxF9u4MuhjyQ5rwOAsPGBNcaeHxIgykPRwDilzkrstyCTFcz1Y+Mf44y1Ey+LM49jM57Tw2HaY62qP3x2+9q08fhL/cnZSjZQSq0Q7g3c/1KQnc9s97IKom6vlCF8Gi5X/T1rSr4Kr7fEDswa+dlXmEJUgcR/jq8UYZRSL1IeDfjdZRP1owS+TvvFUFGs9pSP9TR9/Ce92m2NTdSlhnNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmulUNMWhAbTX7/a5Jf/pULK4zS5SiqY5dMwh8j7lrU=;
 b=DFEj5K6j0aH9X/cNoX6lXynpG2bxv2YcH5BTOJE8lcPT+53QQn36UMJ2YdsrcNbtInrBv1Y5TeSt9dvWRWw6smPwQkC4jIaG5hqHpcCk30r6a53MOFBXSuQ8Hn14Dul28oplRYEbLcQkOOFBCj3Sy/aOBUvGebtJ5erKFnD213i08KFK86j3cJrOmvz6RPzEWiEhn8bEApUsJlM6gQqzea3lITRXHVgjQO+Fn62xGP+jPKpx0VE9pxJT1vSOqDFALA1Qxpm7e0qLo0GN4EcIhalidi0ti6krYLQYWnxgm+sO1HiFy3PlKnY03c+LOtjo0xWs430JkzJAzAMPBRtc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmulUNMWhAbTX7/a5Jf/pULK4zS5SiqY5dMwh8j7lrU=;
 b=XgmZkqogXJF/xwBogvsktaOvmlcR6YG4r1+vXVTJG61seqsr1V7LA4oHSHX4RzMjMMx8Pws8siLXNyz4Yo+lVHaLdVOpaPW3HD6RIquopF8Xhq0RVXCUigQ3dhhrjiVyvMFqaD/VQrwG2+tRi3S9rc0gc4ejGXBnWNsXoNC8DK8=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5313.namprd10.prod.outlook.com (2603:10b6:208:331::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 02:14:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 02:14:15 +0000
Subject: Re: [PATCH v4 0/4] btrf_show_devname related fixes
To:     dsterba@suse.cz, dsterba@suse.com
References: <cover.1629458519.git.anand.jain@oracle.com>
 <20210823194618.GT5047@twin.jikos.cz>
 <b0792837-0227-0404-315e-d4a5d7ca4a2c@oracle.com>
 <20210824161106.GD3379@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su
Message-ID: <a3af668b-a91a-548f-4ec5-1104bd831a78@oracle.com>
Date:   Wed, 25 Aug 2021 10:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210824161106.GD3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0131.apcprd03.prod.outlook.com (2603:1096:4:91::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Wed, 25 Aug 2021 02:14:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29b8886-752f-448b-1960-08d9676e0967
X-MS-TrafficTypeDiagnostic: BLAPR10MB5313:
X-Microsoft-Antispam-PRVS: <BLAPR10MB53137CC87C3EF3775AC47E50E5C69@BLAPR10MB5313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbxdLKNrJITTTDwm8AgyK8AtqK+XY5KVG+o2X6Dxv736b7pGyLcJl0pOO1FlBiSfbeMhhbyYaTDSgHpHeiYBch0Sf/cmMlF1aO1bZUXSjiekAbBIzzw4ggNbCV6HK3FGq05yu66M3C8iVJPM5Y5nQKfNyhrIOJvJUywyKuB78T9JckiyfUZxqWlz71z37B1qo2y25tEsioZdLcTfpt9bL7qMbKlNaOFLCUl6YOb4YuUA8mCHllWcu0MdwJnsSNh5eB6+jMWOgnt6CFmQv6YSdRP4wi54rICeoWRMDHcZ1UPHTKXMAAOGwbxFKB3InSVnoA+uRzXZyA0M/sQu03ECWxrVNmRRvbWKoNpCRZNKkeHSCruT3cqfbi0AA+Xvfecs/4S4PxsX+oWUUGC12JAk9mAbIBxu0PyYZkaS1WS1RQAg4OK1b8X9qp+aNUerOKOpE2rCwoJG+nlRJidH79ZF+x7ylKR+fmwOm0VMNvojD5JAoyt4oGU9L1Y/pEl/zO8uNpY7U1zfxoB0HYGlQvX7gBMqme7dk/lQw3AQ5RBEilKxqAyGSEoshb0NOppnGj3g74nxsQAWVC51qwxYmWtubwZ6gOOI/0DuKeXxTyW9dtpFDqBnyJIxv4lxYoLVgoJvDuwgp5QiyrRHR3l5e20Hklc6zjZxWVfayI++XJBjhjS95Lz4kH1fJA7twXWS6ytszuF7C9eaBx/BnSKk5+9tgX5B3IBSkHaAi2CV2Ts8XkDgniMthpfDGSY7iRDd91vkBw9FX60F6WvrK6wMdzIoicomdIqNgpcIyiXlSnh1J89EzwvOgnNz5j4djUFA90ZMgp7Qy2r5nl0+6O+RYhzJfA8iJOX02ZnAwS6S+qKs6Zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(31696002)(66556008)(31686004)(36756003)(8936002)(66946007)(316002)(6666004)(6486002)(66476007)(5660300002)(8676002)(53546011)(966005)(478600001)(16576012)(38100700002)(26005)(186003)(44832011)(2906002)(956004)(2616005)(4326008)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEh3MTZjLzhmZTlEMFZkTW41NmprY1lsQmVybGNDZytmQ0VIOEorNnMrQ1hj?=
 =?utf-8?B?U08xN0hKWXZCWGZmMC91bmFhV0w2N2tvTnpuWG5GcjQ4M0RGMGR2UHVud0VH?=
 =?utf-8?B?NjZHNkRLWUJ3R2FHVGRmWTVsV0RpM3ZVcEJ5WmNSb25VSlNoTGs0Rnk3eUtE?=
 =?utf-8?B?SGZVcjR5SytueVd5TFR3aytkcStEWDB0RmhaV3J4anRNNzR4T2NFUk0yWFps?=
 =?utf-8?B?aWd0cDBaMTBrRThmTkFyeWNlbGRZMGR6L0JNYkV2RHZlVlRPRHRZZy9QVmdm?=
 =?utf-8?B?QWlpUi82R21EYUZXejcyd1UveWxGZ2YwcWp4dzJYZXpUcWRGdDBPRkd1TzlW?=
 =?utf-8?B?a2pUUGo4ZGxaTHF4d09JTm0zSHNrMW9lVW1iNXZEVW9tK3Q0d1pZbVpXOTJT?=
 =?utf-8?B?SWdWODhWZ2M2WnEzSXlvT1VKeG93UEhucDZMdWRPR2RNaFhYS1RMTzBUbGlS?=
 =?utf-8?B?YU1vTnRLQk51S2c4R1JJZkFkYUtxTUtDcjJrS3ozVFBjU2dNWkRlWVpobDBj?=
 =?utf-8?B?cUxmWCtNYnVxeEpBVlUxdkRGc0trRVlhK0U4a2hOSTFwdWFpUFg1MzQrVkRZ?=
 =?utf-8?B?UnRHOEk5T1pVWHJiOVdmbkl2NU1HM1dzMVNMNW5teTAzQWkrMFFpQjlYOGJI?=
 =?utf-8?B?bVRaanV3eStaQzhoQW5tSlh5WDRweXFjVFhnUHQySVljcjAyMjZrUVRJVkRk?=
 =?utf-8?B?Y1dnTmFCVkQvRk1qc1Nrc1RBYkx3UVNUSWhBTThtamdZYVhnT0lVZlhxM2N5?=
 =?utf-8?B?VUprWitqZkpQUnNIWVVDcjRKcExjWUtMcjhTMDFNSk1nR0FHUHFmTlZHMWVV?=
 =?utf-8?B?bGNYN1ZzeUhmWFpnNFk4bUFlNlVGYnBiVzJxOFB4RnFBYlhzRFl6U3FJdkxs?=
 =?utf-8?B?d3orNHQvQmlqV051S1hXeWs2UTB1U2NKU0k1YzdibjJzMzd1VGQ1c3ZMR3lF?=
 =?utf-8?B?SjlPaHVLcWYwS1grZ0MyRjE2WG1HMDJEWlRJdlNlQ1NXNEsvTXZmbGFzdmt0?=
 =?utf-8?B?dzZ2MWM4b3lLa3V4NzF2MytWRVJwUGtsMExRNmwzWVB2N09sZ3NuMXNwcmhj?=
 =?utf-8?B?ZmN2ZEg4aFd3K0VCUitXL2tjdEFGa2V4RTVZb0RmcXZadnhoNDJQSFd2YkpJ?=
 =?utf-8?B?bkVnZk4rb1poRC9HYllHaTU2QkczTGZSU2NRMVJwTEZvZllmMERLMHJ3Y2Y4?=
 =?utf-8?B?TFlzcmhFeFBEbm8zak1aeG1lZVpGVUptcExhNFQwNUxKYTR6RExvb0Q5eW5w?=
 =?utf-8?B?U1QvUWcvR3Q2L3hQNjJrK2wrZ2RUVDZKWjZvT1RYaGxxcStSeTltd0tPWHBK?=
 =?utf-8?B?WENUQ3B2cHBBRm1BcTY0WTV6eXUyR2JvTERpWEJPUnpyMThTS29qZ29KWU5x?=
 =?utf-8?B?QkFDa2ZvYVA2YWlDN2pSdGZCMHhYdk1WV2hQbDFIN0xydjExcnNyRlBRM0pz?=
 =?utf-8?B?cVlSc2gwSnc4QkZUeWVGZllZaHBhOWI1Wi91R3J3WjFUdFk5QkwyZkgrS2Y1?=
 =?utf-8?B?TXRoT2ZDT0hvbE1OQ21pYzk2K0pTVDl3S3ZtUHlRbGRGRHo4Uy9QWk1sL1h6?=
 =?utf-8?B?T1A3Q2M5ZzRJVHM5blMzVWpCVkdMbER4b0FZNUZyVVJRUTBLYW5JV0FZVFdK?=
 =?utf-8?B?VTdSZERDSW5RblgzS3pOWlRkcEVaYXlXU2I3d1l4MHJsVjREVURwb0xkRnA3?=
 =?utf-8?B?d3JvSDI3VERFMEJpbHhValRNaUdCTnNvQW4vZHVYQ2hUWFJmQlZzRitRTFdP?=
 =?utf-8?Q?xYNkS0hc7G+vJ3NozAdgNkj2rQ++9OVTxCn83h2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29b8886-752f-448b-1960-08d9676e0967
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 02:14:15.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmdc1QIBOmH5ePEDfINc1WICE4oj/XE2FGqMjobVDbHOfQAmzXH10+QNAvLRtAoHLlbO1SBu6MianBMwPTYQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5313
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250011
X-Proofpoint-ORIG-GUID: RjL1B2gF1fTYqawEj6lfhgcZaZUJwxg0
X-Proofpoint-GUID: RjL1B2gF1fTYqawEj6lfhgcZaZUJwxg0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/08/2021 00:11, David Sterba wrote:
> On Tue, Aug 24, 2021 at 08:28:09AM +0800, Anand Jain wrote:
>>
>>
>> On 24/08/2021 03:46, David Sterba wrote:
>>> On Mon, Aug 23, 2021 at 07:31:38PM +0800, Anand Jain wrote:
>>>> These fixes are inspired by the bug report and its discussions in the
>>>> mailing list subject
>>>>    btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
>>>>
>>>> And depends on the patch
>>>>    [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
>>>> in the ML
>>>>
>>>> v4:
>>>>    Fix unrelated changes in 2/4
>>>> v3:
>>>>    Fix rcu_lock in the patch 3/4
>>>>
>>>> Anand Jain (4):
>>>>     btrfs: consolidate device_list_mutex in prepare_sprout to its parent
>>>>     btrfs: save latest btrfs_device instead of its block_device in
>>>>       fs_devices
>>>>     btrfs: use latest_dev in btrfs_show_devname
>>>>     btrfs: update latest_dev when we sprout
>>>
>>> Patchset survived one round of fstests and I haven't seen the lockdep
>>> warning in btrfs/020 that's caused by some unrelated work in loop device
>>> driver.
>>
>>
>>> There's a series from Josef to fix it by shuffling locking,
>>
>>    Hm. Is it a recent patch? I can't find.
> 
> https://lore.kernel.org/linux-btrfs/cover.1627419595.git.josef@toxicpanda.com/

Thx.
It is the same fix I sent ~3months before in the ML[1].
If you want, I can refresh [1] and include 1/4 (in this patchset)
into a separate patchset.

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com/

> 
>>    Is it about device_list_mutex (as in cleanup patch 1 above) or
>> btrfs_show_devname() (which patches 2-4 fixes)?
> 
> Relatd to device locking, so device list mutex and also uuid mutex IIRC.
> 


