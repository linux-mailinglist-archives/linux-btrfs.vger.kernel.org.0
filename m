Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF031F41E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 04:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBSDH3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 22:07:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhBSDH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 22:07:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J35BpA185428;
        Fri, 19 Feb 2021 03:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vpQTp6nO7CkExjluwiVtEtutSlplJFMdS3kjjvu79Jg=;
 b=gRKrJOueISJm084ULKiuPZpCvvoS2iL4sTVzDn+SvVt2R4T1aRaOnawx16yQyLJ/uMqX
 PXBExzM0c/kIgKpcIV9mlyyd86Pch84sn5jhsXUIOIikk2TPdRnaxhUeq0gFfgp3dKdC
 GUK7nF6WS7Xfhd2QBnONtLE4Lu9Tzn5P2wJgo+BTuMwcNAJ3Airh0vlkf8dD1G491qcv
 w4vPwyBpt/XJAzGAneFDJw2rPiLuDqSX3rjhIRhllN+o12PbJNJMwd9wWy6Ofq3WJlfo
 Jn8ZZaKwzddiJo8kUCzL1ACZnesH2YNbQm53MkNmttdSuxxyOKRlKbLPqnj5VQ9uKaD9 nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36p66r82f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 03:06:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J35jMu017729;
        Fri, 19 Feb 2021 03:06:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 36prhv3qf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 03:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nefjJPbudvJmgszIwcHCOmUPr391kNXNJ15COwq1cKP2DrO6N4yWlLZyraoDBlcy6AZSYXi7cBl56+02piPJrWiIDT6t/evJzo+rOOB2ckfiB2QNaD9dSmnm3g2ZsIpXA8y1zLQPf4ShrDujUKDiISSiI7wXVj9XcEH4KyPZydK4TU5lKZ9g8Ec3tHN5w1LtFvKbumNbJD1/ag34RicsVIkKH65p0QSateaJg1IkK/kYcSPTuT6qcb01KdbDMyVcWnqcQFDMUG5BDGdr+7SIkE/haufnWLYyNBmOe8aTpdDttTyEAMN2zVPWP+YFxOqnh4Iz9JWlyZ8/WoGZVpi1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpQTp6nO7CkExjluwiVtEtutSlplJFMdS3kjjvu79Jg=;
 b=fwOW+Zalqnc37gYmlEUFPhTd6vGyt7idqP2WVa4fB/uAtvUjetXEZcj92ZfYxvHoEMoJ49Gdlx2LdIsC/gObnY3S5/5LXa71PMg7w+jNAtNeoymSElofmyMQHUNP30T5ysHI8CRhSIFe3PFleWSLi0fKnTpbLJ9W9Cp6/rIwGbUUYgCMvk+EMCZOmHlb9l+xeK7orw0Oe05fNcfF0QRjC6fgA4NhGGpt33iLny/JOxqTvkYYz5yMbS1ouPNdKJMWgD0r+clD2yJckIGZprVxuL2YnQ0cV+HfuvjzpRE4K76G8IwMWmBy9NwQhJ4tN6bka22tQDmBnSrZmLyR+/dW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpQTp6nO7CkExjluwiVtEtutSlplJFMdS3kjjvu79Jg=;
 b=YdVdKT5OwYwUnC8TxRNp7yoGDVPStER04IQlfGqVWtaKbmDC5yPAC9DkLEpFFdk1ZALj9CiBGjhO0KYZhuR7Gfakhfhwq+EUjHZAw6MOhzmc+rKpe3PzmV9QQfKNyxMUg/pqzmtpHuOmqaRWyBTLVNo+jm1dCR4CDJw5wzecKxw=
Authentication-Results: umail.furryterror.org; dkim=none (message not signed)
 header.d=none;umail.furryterror.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 19 Feb
 2021 03:06:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b0ec:416d:fad7:c199]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b0ec:416d:fad7:c199%4]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 03:06:33 +0000
Subject: Re: [RFC][PATCH] btrfs: sysfs for chunk layout hint
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com>
 <dade948e-7e66-4081-6ea1-f84a4dd6a11a@libero.it>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <793269fa-32f2-5631-8557-f1961bcf06df@oracle.com>
Date:   Fri, 19 Feb 2021 11:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <dade948e-7e66-4081-6ea1-f84a4dd6a11a@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:59ae:5ccf:64c:f735]
X-ClientProxiedBy: SG2PR06CA0134.apcprd06.prod.outlook.com
 (2603:1096:1:1f::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:59ae:5ccf:64c:f735] (2406:3003:2006:2288:59ae:5ccf:64c:f735) by SG2PR06CA0134.apcprd06.prod.outlook.com (2603:1096:1:1f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 03:06:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a69d006-0ed1-406d-7455-08d8d4835c3e
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB492973DC77DC51D36B7FE4FDE5849@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdLTCCoLV1/6yfdJzefYpeLMvKoHNfmN8hCNSCvXD7AkXXq07rm5HP0tqRJD5N/B6fvLwIYq6mZz8/j45fUeiBC17PP/Cns+jev2+1Kz266MaIv2FRETavjOSYLT+f0xfsNKRmZ3I0R/jZRX2RWtrFXduqSO0pXkQFVHY6XfUfcyPhXdENARR+SIKUKvWgK5dbr6fPZOKkDGwvk/ftqgRCweBJGbaSv4BaNy6xre74Hi2oyBCLeIaksGO0oPlkM+3NHOwKiAOC0+d2Vq0kZZ9g4vYNmI5vN8XoQ4g7gCZI5lKd1WEVGvL9u0uOmcBhW0VelceuH8vElttHJ5TFg6qA9BFLB3c9/mJ0Rmg/nuzX/69nvGzlgaD+m5NNwUvcREzb6BI91+ErI77bBUzhv3UO1p03812+bdDWVqtKVqupcSD01Nfz0kjWwOBRiBfCzgfjyBkmdk+xhJlhur6T7hfFU3M+SebnehueTlOwVWdtYOIYK6D0RrZDHsbNzXClHXIkjU09ahDhsaMfwzeZ6l2353ibM62bfcyUweOzcE8lX3uuP3HhEY6sRBmfTiuEXmGliC6UvxhpUB4IgpKN+Rzc2664+GP61YzEhqJ5hCA/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(44832011)(66476007)(66946007)(478600001)(8676002)(6486002)(186003)(5660300002)(316002)(86362001)(2616005)(6666004)(83380400001)(4326008)(16526019)(2906002)(36756003)(31696002)(8936002)(53546011)(31686004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q05JMmVybWJ6RE5jT3hsWDM4dUFhMkx4UituV3RRcDZ5dEpvbXZrcFdWbnhS?=
 =?utf-8?B?ZHlTUEVQYXdtMDNjRndqcFhKMU1VNVhUUGZWZks2Qk11OHVXMTd4bHpnMmN0?=
 =?utf-8?B?dHF5eWk5elU2QUxIQ2xkQkFEc3FFN2tRdXhFemdCU0dGNWdOS1JkRWpaTEhr?=
 =?utf-8?B?a0poQVhPTkRyOHpsRWdWZHBSZVQ4U0pvR2hTbHRiR0xyMTROS2VGd1ZLVkpu?=
 =?utf-8?B?bnBXNXdpVDY4SENMVUh1UUhFd2tOWDFlcWxhc1JwYVNRUUZPZzlra1RpWHRF?=
 =?utf-8?B?ZCtqYk0vZnJoU0FzNjNWb3dhakpRdUNBckxmdGE4bGk3bzJTTkNKcnZMc1gv?=
 =?utf-8?B?b2VuMWIvTnNPK0p3VGllUDBxb2V0WWlMMWlhSUs3eVlwV2dnUlhzSzVqdjRF?=
 =?utf-8?B?bEl5bUx2SVVpWHNsbU5iK0lWVzlKcExJWWM5d3pkejAwU282M1Q1akhQMHhV?=
 =?utf-8?B?WnRGSHpkcGJxOUhPZGtLVWZpcWd1UGl4MEdaZ0EyWW04RjJocDRPRFpSQTlV?=
 =?utf-8?B?NjkyeWt6ak1lUnV4UmxxWVVBSkF3TndrWVNPSnpEdC9mYXlzMXgxTy8vNGdQ?=
 =?utf-8?B?YlpmTUNoQnR6UTJQczNpcTh5bUZVbE5xSkVOUC9WaFUrdUEyUEFUSStoTjU2?=
 =?utf-8?B?dEVaUEE0ZXprQ0RFZ0Y2ZkNrcDJGWm9zaTRBZU12aGYxVUhWV0JzcU9NWVlw?=
 =?utf-8?B?cEJKT2NBUDJOTmFnaHVOMjFVL1hEVWdBMnBhT1NMZDRlRGFMeXowYm8zMWdq?=
 =?utf-8?B?U3R5akpnR1kvREw5YXVpK2xFWlU5K3dlWE5qclZVVmlrdjdzSXY0ZHZEejRm?=
 =?utf-8?B?Nm5OUFlOZFVtVXJrVkFrbVZUSkdYMWJmT1A3R2VzcDU3bUFLVHJHWDhHNlY0?=
 =?utf-8?B?dlRGc1RXamVqZ2N6MlNobFR2Y29tSk5aYXlNZ3hKMjgySEJmNHJ6MmcyZlZZ?=
 =?utf-8?B?eEVkNmQ4dHBhS1JFQ0wrdHY0bndXWXplVURxRWJ3OWZRUlVWTWZybUx0V1d4?=
 =?utf-8?B?cHZCMEtHcVBVeDZMclJKUlFZQXdublczQW4zdVE3ZHBtVzVLS1dnWi9VOU9r?=
 =?utf-8?B?WlJnbVNkdUFFWEFJN0o4c2Nhd1FkV1VqejNObnY5TDFCNGtkaWdNczhxZm5V?=
 =?utf-8?B?ajhmVDVRTnV4MnNyRmlLM1FBTGloT2daNWtvZEphRVdxOCtrdFNMb3JuUWFs?=
 =?utf-8?B?WTJaYVRVUHBPMjlVcFZaWG8xRisrVi9abnRtK1hKbjFhb3lpQkJ3Qi9sTHkv?=
 =?utf-8?B?WGpjR3N3RkpmSmNQbmZFd3hxQXlWMkpUc1h0aFVlZndzNVJ4YTc3UkREQUNZ?=
 =?utf-8?B?bWRVZVozSjJLbWw3K1R0eDA4anlzVFRIa25KM2RnLy8yV0NEVHJtZjR4NEY2?=
 =?utf-8?B?N1FNcit2aVZuRHNaYis1SVQ1SU5JMWVtNFEwS2M3M056Z3hORkpoREM4cUk3?=
 =?utf-8?B?NGFtUTlrRUVZaktRN3VYMGFOV3h6aVNiSUVtMWllNHVpZ3kvRHg3YzNxZXBM?=
 =?utf-8?B?L2lJMkw5dDBxdHhEekVZVStlT2dIWWdXSDFXUHZtSlhxK3lJWnd3NXMxQnZh?=
 =?utf-8?B?cEk4ZERUTkNCS05KbTFsVHg2UjFKcHloenpMTGFhb3k2MG5XTkpEdTg2YXNK?=
 =?utf-8?B?djFuNGc0VERPeHNZR0Nlb1lQVXIyVkt3YW5SczROUFhtMWorZ2dMeU1YcTFR?=
 =?utf-8?B?dmJ3NVFnb3dNVVZzUG5rZXg3UWk1Tms2dHhOaDhyOTcrNUx5VS9zOW5zZjhM?=
 =?utf-8?B?NERFY1ZxY3BES3dBcHBEcW4xNmQ0bmluTzdRUnZnRW9qN2VVTzVxZ1RzTDFz?=
 =?utf-8?B?ZmlWWG90UmEzNVdsc00zeDJoT3FaRVFIM2R2Uk0rMkJxd1lhQVM2aTh2dFor?=
 =?utf-8?Q?hD+awPxDHjn0P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a69d006-0ed1-406d-7455-08d8d4835c3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 03:06:33.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkUJlpZAZmqVgbYCNhh4VxzSTXp4AWA0kWO0DafB3dSUX0H07ITeTQd6mh1lz68X5TyXqZERPw4rXqxKtttwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190022
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190022
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/02/2021 03:11, Goffredo Baroncelli wrote:
> On 2/18/21 6:20 PM, Anand Jain wrote:
>> btrfs_chunk_alloc() uses dev_alloc_list to allocate new chunks. The
>> function's stack leading to btrfs_cmp_device_info() sorts the
>> dev_alloc_list in the descending order of unallocated space. This
>> sorting helps to maximize the filesystem space.
>>
>> But, there might be other types of preferences when allocating the
>> chunks. For example, allocation by device latency, with which the
>> metadata could go to the device with the least latency.
>>
>> This patch is a preparatory patch and makes the existing allocation
>> layout a configurable parameter using sysfs, as shown below.
>>
>> cd /sys/fs/btrfs/863c787e-fdbd-49ca-a0ea-22f36934ff1f
>> cat chunk_layout_data
>> [size]
>> cat chunk_layout_metadata
>> [size]
>>
>> We could add more chunk allocation types by adding to the list in
>> enum btrfs_chunk_layout{ }.
> 
> 
> Hi Anand,
> 
> I like the idea. My patches set (allocation hint), provides a similar 
> functionality.
> However I used a "static" priority (each disks has an user-defined tag 
> which give a priority for the allocation).
> 

Hi Goffredo,

This patch is a framework to add more types of allocation hints as
needed, and does not introduce any new allocation hints. The current
default allocation hint is called 'size' and retained here.

Not to confuse.  Add more allocations hints on top of this framework.
The latency above was just an example.

The allocation hint I mainly wanted was sequential (by devid). And this
framework helped to add it. As I mentioned below, I needed sequential
allocation hint for read_policy testing. If it helps, I can send that
patch too. But I don't know if there can be any practical use of it.

Thanks, Anand


> In any case the logic is always the same: until now 
> btrfs_cmp_device_info() sorts the
> devices on the basis of two criterion:
> - the max_avail
> - the total_vail
 >> I added another criterion, that I called "alloc_hint" that decides the
> sorting.
> 
> I go even further, because Zygo asked me to add a flag which may exclude 
> some disks.[*]
> 
> If we don't want to consider the idea to combine different criteria 
> (like order by
> speed AND latency AND space AND ... ) which increase the management 
> complexity, the
> main differences is that I used an "arbitrary user defined criterion", 
> instead you may
> suggest to use some specific performance index of the disks (like speed, 
> latency...).
> 

  Yes. Idea looks good to me.

> But in the end, because the latency or the speed are a "static" 
> attribute (they should not change
> during the life of the disks, or these change quite slowly) the results 
> don't change.

> So my concern is that my approach (which basically stores in the disk 
> the priority) and your one (allow
> to change the priority criterion) are quite overlapped but not 
> completely and difficult
> to combine.

  Umm. Yes that's the drawback of the dynamic latency determination,
  static latency as in your patches should be ok and straight forward.

Thanks, Anand


> 
> BR
> G.Baroncelli
> 
> 
> [*] Zygo has an user case for this, however I fear the complexity that 
> it adds from
> a "free space report" point of view...
> 
>>
>> This is only a preparatory patch. The parameter is only an in-memory
>> as of now. A persistent disk structure can be added on top of this
>> when we have a consensus.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> This + sequential chunk layout hint (experimental) (patch not yet sent)
>> helped me get consistent performance numbers for read_policy pid.
>> As chunk layout hint is not set at mkfs, a balance after setting the
>> desired chunk layout hint is needed.
>>
>>   fs/btrfs/ctree.h   |  3 ++
>>   fs/btrfs/disk-io.c |  3 ++
>>   fs/btrfs/sysfs.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.c |  4 +-
>>   fs/btrfs/volumes.h | 10 +++++
>>   5 files changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 3bc00aed13b2..c37bd2d7f5d4 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -993,6 +993,9 @@ struct btrfs_fs_info {
>>       spinlock_t eb_leak_lock;
>>       struct list_head allocated_ebs;
>>   #endif
>> +
>> +    int chunk_layout_data;
>> +    int chunk_layout_metadata;
>>   };
>>   static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index c2576c5fe62e..c81f95339a35 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2890,6 +2890,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info 
>> *fs_info)
>>       fs_info->swapfile_pins = RB_ROOT;
>>       fs_info->send_in_progress = 0;
>> +
>> +    fs_info->chunk_layout_data = BTRFS_CHUNK_LAYOUT_SIZE;
>> +    fs_info->chunk_layout_metadata = BTRFS_CHUNK_LAYOUT_SIZE;
>>   }
>>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct 
>> super_block *sb)
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 30e1cfcaa925..788784b1ed44 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -967,6 +967,102 @@ static ssize_t btrfs_read_policy_store(struct 
>> kobject *kobj,
>>   }
>>   BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, 
>> btrfs_read_policy_store);
>> +static const char * const btrfs_chunk_layout_name[] = { "size" };
>> +
>> +static ssize_t btrfs_chunk_layout_data_show(struct kobject *kobj,
>> +                        struct kobj_attribute *a, char *buf)
>> +{
>> +    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>> +    ssize_t ret = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
>> +        if (fs_info->chunk_layout_data == i)
>> +            ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
>> +                     (ret == 0 ? "" : " "),
>> +                     btrfs_chunk_layout_name[i]);
>> +        else
>> +            ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
>> +                     (ret == 0 ? "" : " "),
>> +                     btrfs_chunk_layout_name[i]);
>> +    }
>> +
>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t btrfs_chunk_layout_data_store(struct kobject *kobj,
>> +                         struct kobj_attribute *a,
>> +                         const char *buf, size_t len)
>> +{
>> +    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>> +    int i;
>> +
>> +    for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
>> +        if (strmatch(buf, btrfs_chunk_layout_name[i])) {
>> +            if (i != fs_info->chunk_layout_data) {
>> +                fs_info->chunk_layout_data = i;
>> +                btrfs_info(fs_info, "chunk_layout_data set to '%s'",
>> +                       btrfs_chunk_layout_name[i]);
>> +            }
>> +            return len;
>> +        }
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +BTRFS_ATTR_RW(, chunk_layout_data, btrfs_chunk_layout_data_show,
>> +          btrfs_chunk_layout_data_store);
>> +
>> +static ssize_t btrfs_chunk_layout_metadata_show(struct kobject *kobj,
>> +                        struct kobj_attribute *a,
>> +                        char *buf)
>> +{
>> +    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>> +    ssize_t ret = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
>> +        if (fs_info->chunk_layout_metadata == i)
>> +            ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
>> +                     (ret == 0 ? "" : " "),
>> +                     btrfs_chunk_layout_name[i]);
>> +        else
>> +            ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
>> +                     (ret == 0 ? "" : " "),
>> +                     btrfs_chunk_layout_name[i]);
>> +    }
>> +
>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t btrfs_chunk_layout_metadata_store(struct kobject *kobj,
>> +                         struct kobj_attribute *a,
>> +                         const char *buf, size_t len)
>> +{
>> +    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>> +    int i;
>> +
>> +    for (i = 0; i < BTRFS_NR_CHUNK_LAYOUT; i++) {
>> +        if (strmatch(buf, btrfs_chunk_layout_name[i])) {
>> +            if (i != fs_info->chunk_layout_metadata) {
>> +                fs_info->chunk_layout_metadata = i;
>> +                btrfs_info(fs_info,
>> +                       "chunk_layout_metadata set to '%s'",
>> +                       btrfs_chunk_layout_name[i]);
>> +            }
>> +            return len;
>> +        }
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +BTRFS_ATTR_RW(, chunk_layout_metadata, btrfs_chunk_layout_metadata_show,
>> +          btrfs_chunk_layout_metadata_store);
>> +
>>   static const struct attribute *btrfs_attrs[] = {
>>       BTRFS_ATTR_PTR(, label),
>>       BTRFS_ATTR_PTR(, nodesize),
>> @@ -978,6 +1074,8 @@ static const struct attribute *btrfs_attrs[] = {
>>       BTRFS_ATTR_PTR(, exclusive_operation),
>>       BTRFS_ATTR_PTR(, generation),
>>       BTRFS_ATTR_PTR(, read_policy),
>> +    BTRFS_ATTR_PTR(, chunk_layout_data),
>> +    BTRFS_ATTR_PTR(, chunk_layout_metadata),
>>       NULL,
>>   };
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d1ba160ef73b..2223c4263d4a 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5097,7 +5097,9 @@ static int gather_device_info(struct 
>> btrfs_fs_devices *fs_devices,
>>       ctl->ndevs = ndevs;
>>       /*
>> -     * now sort the devices by hole size / available space
>> +     * Now sort the devices by hole size / available space.
>> +     * This sort helps to pick device(s) with larger space.
>> +     * That is BTRFS_CHUNK_LAYOUT_SIZE.
>>        */
>>       sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>            btrfs_cmp_device_info, NULL);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index d0a90dc7fc03..b514d09f4ba8 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -218,6 +218,16 @@ enum btrfs_chunk_allocation_policy {
>>       BTRFS_CHUNK_ALLOC_ZONED,
>>   };
>> +/*
>> + * If we have more than the required number of the devices for striping,
>> + * chunk_layout let us know which device to use.
>> + */
>> +enum btrfs_chunk_layout {
>> +    /* Use in the order of the size of the unallocated space on the 
>> device */
>> +    BTRFS_CHUNK_LAYOUT_SIZE,
>> +    BTRFS_NR_CHUNK_LAYOUT,
>> +};
>> +
>>   /*
>>    * Read policies for mirrored block group profiles, read picks the 
>> stripe based
>>    * on these policies.
>>
> 
> 

