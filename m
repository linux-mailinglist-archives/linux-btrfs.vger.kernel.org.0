Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2B3EA122
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 10:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhHLI7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 04:59:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10510 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234600AbhHLI7K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 04:59:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C8v5CI029083;
        Thu, 12 Aug 2021 08:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KD8CiAAVwm2Ju5owb3JrjRGSsL23Ta7HTSTeGVEJRMU=;
 b=wG4wCvX1X1911a5+SpfZt9NFtRbFxFQDZIqrpMxASkY7npAVA/cngROhbmsdjqwj+7ue
 yp4UnP4ovLlj2XlAAfsYTmqQ3dHVxVpARWgnmiApmhaKOs2wEu89/WOUDiNYDZQBpo0i
 7uQ9D9JBkXNs/OYIRVfqE5DfKDPRzSKJeyJK8KRPOkA91+VZ500sDlfm7mpYe4xEI/NX
 gMyzNevXtleG43u7lw2oaUCTgZQsUfiVuOeAtp52lOLY9bVom05/bhX8xrMPBzj+cRS+
 gHtJMV0czIN03YFYF4hOu2PhTCeEDuB6O/F44awNqdpxdgYYEN9xv2wXaUlVSbD3075q UQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KD8CiAAVwm2Ju5owb3JrjRGSsL23Ta7HTSTeGVEJRMU=;
 b=uEg6cM5VLw4rrhfjuXowO+Zm52E2aMHpNgmK5ShMST2KtOSDk6U5AImDzxVCR4xdTztf
 grlj88wquEqi60N6H02T0fHIRR1yJ5FmQOqQtjFnK6SkIf9GF7vO9uHz/VqRu3YzvG4e
 qO4m20M3KLPgQcp1qt4xIef1uUXS3jB4OJ8n197S55AunRdWTL6mj55FFZ7jnLQRl6dr
 lQNdfUY5y+DV3PKj0pVO8qqubQ4XLb8OVCzQQ5GWMywqutKIMawUBb2ld7D92f7D0FqE
 ivgrb8Dkd32NCkh33rZT1VznGWVmd8n/QphmrCV5EUdJRDOQiCl0UW+zaqTf0ylULtHk hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd64agcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 08:58:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C8uaDl140410;
        Thu, 12 Aug 2021 08:58:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3abx3xfhy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 08:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GExYx0GYO7+6NI/RwybFfj9EE7cS2UuI6yem8UwThu3/CGG5PcL4E8d/Vh3GxzRrXeylRnzYZ1sE7N/jrCXCnmE0GxtBFNfx7PW0P8YMVKUheCtniMwgjLdcPbKNtyHY8msJFTR0D22vWTlabUgbilJxV6NNJfQ+qmnHobWg+Ksu20XRuJV6Ine4ajjyvf10yzbpt8kW7Rc8tO3cKdjtr37mXRf3aqB9YcArcg4k+YNsTOG0veO3qOUXrReLPANqVFPCYBJIJb1FKFuhHos4bCMF/w1wrIBybQTuHWNXeXIk7LvViL4g4irUPhce8hFv9I/N/xf7ttgw7kBHn4/WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD8CiAAVwm2Ju5owb3JrjRGSsL23Ta7HTSTeGVEJRMU=;
 b=Qtk80fA54ZRdsms96Ev4wq9Wqj7ZoiEzhtbq4UVXmVngaPPQxNj2VtVCvjQr1DgHI5o8YsDRm6r/Q88l2SOcOiTvPbUUil/uqE+Bw46hDfUPZdUR1wOn6gQEdNS07ixG5SbI0oR2qY1KJODYoJQ/FDw3v6annjFxLjuxrv6xguVdB3s+B8mtlU5cXvzBgyV8wmlw+nJh6WxtTHpcNF1mtzhGTkeV8XjokztBgzZCO9U5EtdNyGEyuKG50pPTIeL+I1tqegK4B60vOVqn39mikKlSZKICpkbXhgBsgmT+qZhwE+g5aHFgkYbQW1FE8F6u9wIZROV0Qn0gjYrfiwvHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD8CiAAVwm2Ju5owb3JrjRGSsL23Ta7HTSTeGVEJRMU=;
 b=nLRofVqUV1EyEnT7B0oUHWwi66HGSQUmJ71eCZDW+oY+ALVa1AP0toetOrjJAA8nUrCTz/N2mRRUmcxcIUv2mC7FNIYoV6sux4i3tykKHsd1/Y041vKuD77DGBqNJyfCFz81Rr17pRPqLTcXuRacnYpQvjoJ9hUxlJhC2uwbtKo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5281.namprd10.prod.outlook.com (2603:10b6:208:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 08:58:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Thu, 12 Aug 2021
 08:58:39 +0000
Subject: Re: [PATCH] btrfs: reduce return argument of btrfs_chunk_readonly
To:     Nikolay Borisov <nborisov@suse.com>
References: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
 <da5074a6-c0bb-a844-bbfe-c57f38bba876@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <249bb6d8-4be1-90b6-1893-c7d0adef1a0b@oracle.com>
Date:   Thu, 12 Aug 2021 16:58:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <da5074a6-c0bb-a844-bbfe-c57f38bba876@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0131.apcprd06.prod.outlook.com
 (2603:1096:1:1d::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0131.apcprd06.prod.outlook.com (2603:1096:1:1d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 08:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d6c0b4-787c-43aa-8740-08d95d6f606d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5281:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5281FE2BF28B79C979118D2FE5F99@BLAPR10MB5281.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+3dxVDARBrkoVGHxtrXfPluxETGvRCxON4/HFyeKeZvg8dz/0qubLgjW8C8o7yRdFuZ81AAT9PS/tVZrsPaPNtl05q6vBY/xArkVKin63vIrie0tNZlGpknsaGQafLahLyAw35CPiEZEawDDhw2w7XhvUQBRG6fIR4E4mB6B8Dzh1pv6jMJhYAc+Vs0Mjh957mqfdFk3vRDiqPfRHcBkDZVVEvmAxCitSFo7CWkI6NiA3DYe0VbpnOPpsZOHVlbAVDW61T6//pb+LCecfkLmgSE0uWqpLD5OZhVFQmfDOpmYfx8PECy4TAn7oVFTWaZQets9e3hlwKI0cOdmJ3XJc0gT8Pxn39zWwe7WmBuJZq5MH9WzDUCQWJv1NpjWf2PDJfNrB7+XWkZ8x5LM/F+HXTBuOcIkqhOro+PO0JitWtpGcLRDuJPYFdty4GwIyxeFws6FuuYK0T7xphiOqiqhALHPzY2PQAYpOlCcVQ9hOqEtyfimzTnOXfd6ZqqQTvTgM9fx/4Nuf0xrcDU6SF28O+MdMr2d+Dw+5/9QA8ydReLdgZelTezurm+1t59XCSoZjbChVhvDegpxkRoBafqrUgN7OSFyMDYWu3q/IwQX3wIy4DVacP1kMMYd5DBpL1fH9YZVFKSbqU088FNx7AXTM2FQFuM57WY6aw9ZsD2mj3uMwuiBfPXjRZZMaS/gwaEk6HOHhu9gkmn6SzcZqOxs6xmNyfNsDZOHI7EZTFuDiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(36756003)(186003)(31686004)(6486002)(4326008)(31696002)(66476007)(66556008)(66946007)(86362001)(2906002)(38100700002)(2616005)(6916009)(956004)(478600001)(16576012)(8936002)(316002)(6666004)(8676002)(26005)(5660300002)(44832011)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alAxaWR5aVNnbU9vUDFLelJ1MVU1eHZWanRuZWNTSzlQN2VlOTZkdkx3TU9z?=
 =?utf-8?B?Z1F6dUowRUU4dTZkdzF4K1ozeEg2UEhwNVlHMDN3djRiZkVmY2hoSy95L1Bu?=
 =?utf-8?B?aDdNTnBncVBPNmxYYmthTGZySVo1TUI3YUZlVVFpbVRpcHNtdVBZVHAxdTkv?=
 =?utf-8?B?b3JFYy9sS1g4aktiY2JsK2NQN0g4KzdBbGJXWUNkMUtJQVNHV2UyNnUxUUtL?=
 =?utf-8?B?cHh1N29pNEZWNkMvekhtTldZVUtCaWNJeUQ4cDVQdFVKL0VVMDNVMkx1ZFAr?=
 =?utf-8?B?c2p0WlIwY2h5SFhybEJiZlhhSm5WcFFwUUxFWTNLQnltejNGZXBEL3Jlb2tw?=
 =?utf-8?B?bnNKY010bk0rZk1mMmNuNW4vSTBkS0UvMmUvQ1hqanBMelU2V3NOOFlyRG13?=
 =?utf-8?B?MjlSQ0JjckdKdncxRUZGSDBseURvK3ZZNzB2bVlaRTVDTEd4RmlpejB3UFd1?=
 =?utf-8?B?NVk5RVdHMjF4VjAyVkRaZ1kxam1IbmV0anNqQzlUTmJqcWdhQ01sMDA1eEdy?=
 =?utf-8?B?ZitZZVdSWDhSNEtONzIwcXMvOE8vTVJHZnV4elRLY0w5MkxiUExiQmFLNWZH?=
 =?utf-8?B?aHk1ZFE5Y2d1blNYVlErSFErUkphL3pvekR4bzBoc3lBUVFTTmFHeUJocnZq?=
 =?utf-8?B?QUFZWnVBOUF4eXdZVk5VV1l0enJ4cVVHaUkxVWo0TTNBd0w4ZFhRdllzVmFB?=
 =?utf-8?B?cWNMamdnME5TanlQMGxxOHBuQ1VoWTdZd1FmNTU5OHBxWlZlbGYwY2RFUExV?=
 =?utf-8?B?L1NFeDJBejlHQjlIY0pVam9UTnBERE0rSW9ibGFKNXdUOFpYVFdYUGVjSzhY?=
 =?utf-8?B?UEVaV3ZUNUVtbUZoelRqTWJDWDRodTFtVFV6WDlhK2t6YVYzM3ZvZ0RmM0Ft?=
 =?utf-8?B?V1A3ZFgyVzB0WXJBSGNLNzNXU3BVa0QvZWk2ZG5VaU9INmNDNFNRVFhhMXJv?=
 =?utf-8?B?enBGaEtVUzNNYW5LYzJ1MENqaStjUkdSV2NYVjdyOFNnR2ZjamNxREVVT0l6?=
 =?utf-8?B?LzRSclJtVEwzLzhjMXdCZlJOVTE0cklHMkJoQURXSHZqa2wzbE1NdjZkcmVK?=
 =?utf-8?B?V2pJeUQ5VTZUdUpYUUdCQ0pwU3Rycll3S09tci96eEdWRmpzTmlOVnU2MUNG?=
 =?utf-8?B?ZVRCazNKc1J4NWdMemZVaHF5OGQvQ2x0dnhmR0xqTzd4dlNJbUcxNHd1RnhJ?=
 =?utf-8?B?YTB3M2pNSEFXMHBNeVhudElubXZ2RUJ5dXkxWVBXRE1xZjdKM2E4U3lOTVdO?=
 =?utf-8?B?aXNhaWZLWnhBNm9ENC9YbWJETWM3UUtTNXJlWTRiUmEvNmZrTDljUUxlR3Yw?=
 =?utf-8?B?cWR4Q1RHVzltYTN2VytQZGhycEVyeTNnOHE5RzJqUGhmd0p3OUVxdTFFZWxw?=
 =?utf-8?B?QVZ6Ynh2VGhOcktXekdFcFBmN0tyWEhNUklycTJkK25HK1ZqQ2RxRU5oMlk2?=
 =?utf-8?B?QU5IZ0lLNC9JajFJM2ErN0RldWZZa1kzWXVwZlcwMHJrdjFuVW80d3hZZmZ5?=
 =?utf-8?B?ZVFzTU9HVSt3K0RXc01mZEp4eE5rb2ZoeDBpdzZYNzJvcE1DTjBJNjhiZVJI?=
 =?utf-8?B?YzFSVE1mMGZHbGd6Zk5FUVdxVDN5KzdyVnl1U2dKZzlrS05XRnFjWEpJMXdQ?=
 =?utf-8?B?bVB1eFg1UFZzT3Q2OXVEbW0wSk9OKzhzV2pRWTJqYlZ0ZDlyRjJvUnZuV1py?=
 =?utf-8?B?QVQvR1lmRkpReVlTbSs1RlNOK2NMb211RE1UR0RpQWhGa09CRXJaNVVGYS9v?=
 =?utf-8?Q?54TM0XKHBjDFX0628m4sa9fbmV+rYhDUpyJY64O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d6c0b4-787c-43aa-8740-08d95d6f606d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 08:58:39.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RCeiOJlFj1632TuMGl+CPkEQ/2wAre9sjnZbbfIxQMPNb0XqZ+NGwL9TqkY6KH2Sk4ROS9dRz+3SaxH18n2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5281
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120058
X-Proofpoint-GUID: nmuEA3cviBC5r9o4ue_KuRVnUbL7Sa9I
X-Proofpoint-ORIG-GUID: nmuEA3cviBC5r9o4ue_KuRVnUbL7Sa9I
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/08/2021 15:15, Nikolay Borisov wrote:
> 
> 
> On 10.08.21 г. 18:48, Anand Jain wrote:
>> btrfs_chunk_readonly() checks if the given chunk is writeable. It returns
>> 1 for readonly, and 0 for writeable. So the return argument type bool
>> shall suffice instead of the current type int.
>>
>> Also, rename btrfs_chunk_readonly() to btrfs_chunk_writeable() as we check
>> if the bg is writeable, and helps to keep the logic at the parent function
>> simpler.


> I don't see how the logic is kept simpler, given that you just invert
> it.

  IMO it is simpler to read. No? In btrfs_chunk_readonly(), we consider a
  chunk is readonly when the device it is on has _no_ DEV_STATE_WRITEABLE
  flag set.  So rename to btrfs_chunk_writeable() is correct. We also use
  readonly to the filesystem.

  I will wait to see if David also has the same opinion. I am ok to drop
  this part.

> IMO changing the argument to bool without renaming the function is a
> sufficient change and it will result in a lot smaller diff.

  OK.

Thx, Anand
