Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921F3E0B18
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhHEAHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 20:07:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9316 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHEAHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 20:07:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174NvfKb001872;
        Thu, 5 Aug 2021 00:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ydTjiE0nqSRoBxZhVj+hHFJTmlHbah7aAsNaByA6jxY=;
 b=CWjPyJwmjU48QcT80YU9j8idTOzvOGs490upEqOaEpRz2WkYlqkPzMV0RW9ylbgpq7vc
 y+WcBPqH+Qb55/dc4uUU5zEUnyeVGriPWzXAtd/VozATnkzClMtfVVdK1zffT1mVysHn
 ZNbMoFVW7IrHotp3pr6d21DDOpxpkMJHExMKOvFob+NYVjkyVUo18wajdF2+kqdibNXx
 C675dkmyT5k+7lF+u4N6E8D6/uImCWYAxdNNqh7AAsKd7cz09qvxhxmJxqGm6hch8lw1
 IknuJ0di5eqNsTY1Gd6YlGxSE3mVepn9BppwBUBIVJ7m4Ba/q+1btQ+lEJwZ+FZ4idcT YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ydTjiE0nqSRoBxZhVj+hHFJTmlHbah7aAsNaByA6jxY=;
 b=O7H75HK5aFSMIrmCWK5nqTcl13zy1p7k6G38DKkwYb/bqV64Z0W8xzGMYdN6yvYwCxYL
 DeNEXMXSExHEiPXEKRWrtKA7110QeVKNn9h3Upp1LWpRGlbfYVoWA8fQ2OIP6uPh5Awv
 LKc4PlP4gIcQOnxZRGRybtq2xpR0Pp8IrwrtWvNn/RNjmQesqfKS6hHDZTzuRHDwuRMi
 muiU/dQJzmXrGyPXF0iY1wX0020+ei14/k1Zh6zbKAfvkavR51SZXevMCbkqjhDgoCzC
 y4aiMBwjcmiDQxH9mEcvrzc9qX6frxHLm44gCEQiTdUdmoVsOatIUyJJHVQej7avm8uE aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0bc7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 00:07:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17505QXL177393;
        Thu, 5 Aug 2021 00:07:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3a5g9y4v2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 00:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPpNi5t91VhEJ7jhkoGKjZ06DNvBwbwK+1kPwgHFbk0pD2Q9A9E3q8WV5UfQHLP5+C5EqmL5g2heC0YSH+jj0imQ4IfhNllVts2EvAODAiPHkPEjWHaSsNYncufJDeNvlJf60+VoHp6C9lXUNcIc122jx5OXvKqbn1FMQ27t3HYvE/lvLtWwswBIxiVWzPcKJ6EYW3Wekj2/b74SOfJ7CynN1i8k8t63A6eWPUjG2tGRQw8wZKPzuuKDSwRafbWjCBda7pv+w9530WYIgmWH+/Ga9tCYOaq4YtDKm7hHkqg1qHs4BSRfNTAux5mHSewAva0sNqhjaVwJPK7D0so0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydTjiE0nqSRoBxZhVj+hHFJTmlHbah7aAsNaByA6jxY=;
 b=EqMK/bR3V3xUJFeuxiQ1DBY10OVwt4q/PO2v33caI1KEoMPvNKM0Pqx26u8fWAATraXEjbT8uwTRKuaKHLoRJaw+1FsWCabt731P7EdrnqFuMwDaNZS8xL9r9O/NKTpYd5mBievcvKZMGt3t0RFxSgXgz0+d+eAgHV0cMgDqiWuugLwmkxWadLH4EJTE0bHFqwPTCTd3aDho0RitLAYGOt/Z3XHBxmZqJVbnBFCzchtuKFBv5a4I0XB7Xj8UBBUI6zk2HV9eegXtco9ww/9Xcwn8Sa8ZobnWNw0dElAv90gMzoYRs4D3mj8HW8sR5uNJJItg007Ojr9vB9jPHEfZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydTjiE0nqSRoBxZhVj+hHFJTmlHbah7aAsNaByA6jxY=;
 b=U4Kmxm48dODrXa2gqvd8QXXVmPbHd7XJfE8B38OndCbDk5whSlcS4XBoZG+mHUvAXKEPcrrqCIz8jaBfzaIRyiiSWW7NI/ZpxKd3maIG7EL9gOEU6gWUugV6lbjqNwAvOipamcFfiqhOJXjYclJ/fBNOco5Fgdvm2HBtswJxrt4=
Authentication-Results: bur.io; dkim=none (message not signed)
 header.d=none;bur.io; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5043.namprd10.prod.outlook.com (2603:10b6:208:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 00:07:08 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 00:07:08 +0000
Subject: Re: [PATCH] btrfs: print if fsverity support is built in when loading
 module
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>
References: <20210728162209.29019-1-dsterba@suse.com>
 <12540898-56d3-53e5-df01-21189acb40e5@oracle.com>
 <20210729155656.GW5047@twin.jikos.cz>
Cc:     linux-btrfs@vger.kernel.org, boris@bur.io
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1655477b-0a38-e840-625c-f70fe93a4749@oracle.com>
Date:   Thu, 5 Aug 2021 08:07:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210729155656.GW5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1 via Frontend Transport; Thu, 5 Aug 2021 00:07:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b823b7a0-5154-453b-8126-08d957a4f6ef
X-MS-TrafficTypeDiagnostic: BLAPR10MB5043:
X-Microsoft-Antispam-PRVS: <BLAPR10MB50432C91DF8AF8387BB70751E5F29@BLAPR10MB5043.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVZhTgBPSuWw3OcN1Fme9r3Sj5ib7FHynyYK+e4mpvCHP4MISQ54ELx50VmnzWZtIPP6+rNZWx3rKCzH2iAK9DgGG7QB15TluN9sbbwWm0icezWjPGHnN9sz+qfQrnJ449FyZw7QidfjDEoVtyVF++GroR/C4jnu0zlQtzoDbjwFbc4buq8s3OJQ997jRTf93Nm1v3pkZSw5GsmjxIGL1Y5Z2c6n+BUxCzHG4cKXGmwM9b1qcwmiADNGYrNJ+ugbXsw7gXfPtES+WuVSdVqL02Rr16K8VNaB5DQ+6zAPSFjMW/wz4Wp0Aj1BKdyuh7CUaQq7E4/Gsme8BKsvMciJdSD9R2aK+Tt02S2oqmXJLsPxMfJmc4K9QYbMJeTb9eYKIy10STtDwcJwXyk68xEcZq30m9YcJvvxSpbXOZelWroqFiY+7yoU9hzpqTmunGX+wEIKxkiqSw23JU7Jw83Q5z9Oeibw2/Sdi8hd0IiLRTe0oLKbTHCX2meBuOoO2VcMernpMSK3tznJMwm8HDw+6dDpAFRBW+xnkx7EZhS8A2eDJqXQK0c2r5E8LeGBTXKd0B0Rc/OFwgyNKNjFmGu7GNzudlsY5zmXMakX5OSSbb37VTLFfYN7oqLtydr5Q7DbWWwTEIWTu8QfWs9lluSYE32xCX8692JflqKDSs55FxH3ZcA/q+iXV96jq8JPj7UGkdzyImb9vSB5FwxF4gILBoypjdWUGZu3rkbOPENtjVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(16576012)(53546011)(36756003)(44832011)(956004)(5660300002)(66476007)(66946007)(4744005)(316002)(66556008)(31686004)(2616005)(478600001)(86362001)(6666004)(4326008)(8676002)(6486002)(8936002)(38100700002)(186003)(6916009)(26005)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVlVUM0WDNVL1p1NXlXQmQvM2R4bUUzR3FBUU5sTGg2cW00RHZIUUdIY21x?=
 =?utf-8?B?bzYrZ0FZYTRZaUpvZTRvckdMclZSM05ZTC9LbWk5aGdGZlZCWmtiOUVxSmxG?=
 =?utf-8?B?QjJ4eHNRaUtrRFNabFVNQ1pKek5rck84MVZhMW05bVk3NGxvWk1EWVI0dTY5?=
 =?utf-8?B?TkI2NWNRZWFad1VYQXdVNHhLcjRSWlZFdlBReGFDQ0pUQnp3WEdUSktuTU90?=
 =?utf-8?B?NjJWN3pqNDhkWHBXUFFZYkFQK3VoODNLZDVqc2RHN2lDTHJVcU5JUzNvTCtW?=
 =?utf-8?B?MXF4QUZjOHJrNnUrQnFHamdlNmc2SG5WY0dMNXJiTnBzWGJ6eWJBS3p6NGVj?=
 =?utf-8?B?Mm5SUGVVV0NWNWZpTnhtSm56N3hDYjFsc3hUbkd0bzFGUnIvVFBmdmIvZGZH?=
 =?utf-8?B?YTdpWHFKNE9ScFRuRjhDTkd5VzBsRytPa2VYNXdzYmZnemUxVEMyTzl4eStV?=
 =?utf-8?B?VDlHNG5QZ0NwTW5ZYmlpeEY2VUQyallycnhCMTc1TEF4MmE0WlFPbFdFL2hO?=
 =?utf-8?B?eXk1NzIzS0JKSnczK2pKQVgzQWhlTzNDaTNYTExkYW5JYjVNNm54RlVKZ1VO?=
 =?utf-8?B?NkQ5K1JMcUp3Zk5FMjc0NkJuUTZTbytxZ0tUbmJIT2h4RzZFL1BHaUovYjZx?=
 =?utf-8?B?ai9wNjNkZFJEOEFJSGdEa2JvaDdIM1F4UnVjQUtScW91ZDlwMmRCdUtyZHdi?=
 =?utf-8?B?SHpITFRMQmlTQVBrY3NNcHdjbWlFYktxSVptSjNjMG5NNjgxTzh0SzMwTzNZ?=
 =?utf-8?B?UW1jRzVwcmErUi9RTy95YWdTSDQrZWc0d2N2bG1iVm1WV055M3JVSVpGU1BZ?=
 =?utf-8?B?dlV0dWZISFFCMllqK1lBemU2Z1kxSXRTMkMrSmxMd3ZJK25Zd0gzQU80M2dN?=
 =?utf-8?B?WDh3TnBYY3RyWVFPR0taY2djTm52NEdrTE5MNFhLVGJhWitvOEhrcC85QlNW?=
 =?utf-8?B?eE93YnpTWUJ1c2F0MUlXWmVUK0JvSjQ5QkZiYXBYOG5SZjBVb2NsVVN2ZDd0?=
 =?utf-8?B?TGJtWExlMWVMVU13SWNCS3ZPWGlwTHVNNFpmZnNpdlpQMUpUWHpTdjZtK21x?=
 =?utf-8?B?c2h3ZHBwOGMxU1hwWlQ2cjlGOXY2NFdiZEF5OGl2VUc0eFBGRHpxeDZ4b1d3?=
 =?utf-8?B?OW1wMHNHajFSSTlPcmROenBjTUplWGRpQ3R5MUJNUnc5OTRCVkpBSFFVVkRO?=
 =?utf-8?B?QjMyY3pnQWxnVlV1UitwU3ZQN0xNdXp3dXhFcThjQ0x0dWVtQUFFK0JaaUFE?=
 =?utf-8?B?YWJJS1JuYzZSS1lCOXNUNlhra0hrYzRMY0NSb0wva1JLUmZLTkVKQUZXQ2ZL?=
 =?utf-8?B?VzI2bld6QjhWUHV2YUtpSFc4UlhweVB2WUVMRFpKWDZZWW1QRUhaYmFuamtU?=
 =?utf-8?B?K2JRQk5BbUNLdjJwS2tMWUVvYjR1Zmo2KzZNcHd3eVZScDhMZ255aS9RVzR4?=
 =?utf-8?B?ZXpkYXVLeEs3SmJCdnFrc01Zei9BUndRcVFKci94TldwTEdNaDlEY29NTXlk?=
 =?utf-8?B?QWFib3l4dDdGS1FHRjF3ZkhkdlNnazY4clJ0RGpvNHhyOUl1NVV1bkdFWll4?=
 =?utf-8?B?V0ZLTGRWV2YwblFuV0VDVW1JVzUybXJYeXRZU1l1Y1VjZDFRbTQ5MVdibkpH?=
 =?utf-8?B?SjFJbENHeHFqL0ZyejVQUkM3dWpQQWhjMVJ1SllUVGhmZjFLRENIdE1tMVNX?=
 =?utf-8?B?cFo0V3dONlFraGhndERRanp6NDZ1WWJFRE5vK3UrOVEyWVY0bmthMTAxUGov?=
 =?utf-8?Q?zGkQO+t0Arr6TZQhvzRigikjyk5aeUcXbWLeW9y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b823b7a0-5154-453b-8126-08d957a4f6ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 00:07:08.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ry+mkqSfF5npTr7e9A22UkeHBB+JcmbkERoJND13m4neZkVf3AGri33oUbuLyaaoWg49s6MWVukIGVFZ5Vi9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040151
X-Proofpoint-ORIG-GUID: _PqJ-ssFW2CH3InaHj7JoNTYA3KOO2Cv
X-Proofpoint-GUID: _PqJ-ssFW2CH3InaHj7JoNTYA3KOO2Cv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/07/2021 23:56, David Sterba wrote:
> On Thu, Jul 29, 2021 at 10:29:32PM +0800, Anand Jain wrote:
>> On 29/07/2021 00:22, David Sterba wrote:
>>> As fsverity support depends on a config option, print that at module
>>> load time like we do for similar features.
>>
>>    So similarly /sys/fs/btrfs/features/fsverity may be required too?
> 
> Yes, feel free to send a patch.

  Oops. It's already there. Commit 6875cbd232c7 (btrfs: initial fsverity 
support) added it.

Thanks, Anand

