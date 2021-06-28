Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4E3B5CE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhF1LEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:04:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2386 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232617AbhF1LEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:04:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SB0rEb008695;
        Mon, 28 Jun 2021 11:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/FosC2kMmp/1hSTgDgwxvtvsP+EXn77RFOD7t/0KClg=;
 b=YGELxgu7hh3r4GVJIZEheErRzq0PKKrcrAjd0BzfPRTSY+/0FZm+HwGHgRFt19wXj/2C
 yzyKfKSPXLIBu5qJUHUnqy6WYWvzXndiek15JNJG4HgvnPn5dSuoEZfr8uNKjwm/AlT+
 cntI8dGJKBae69+7K00LM80Rp9u+t4GsspgYtQ2XBcE6EuZfBkVRY86+i1zTtGVEWoP1
 tURPw4/8Vcpu2TTk+a7MVK+1A3/YkutyhXXUytpE/Zp8FPUK4TEnz/ais4t/aUvmUOAE
 9OsPaGF53GXK/PkLsFq2lRG+L3e77x8xB3e5BlC+6fgl5CxRJcxv7b/ZYfbQ6C3aYuXD nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3grfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:01:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SAxwcP196455;
        Mon, 28 Jun 2021 11:01:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 39dt9ck0q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHz0XTbZAbGWQHBZ8AiUMX/eAUQRjOm0ld/BT5kVYP2X0sBnlrb406RQRZGw/LJq9xc6bybF7n7Cq1YCLAnOEbLDSs20X6TUe0pQAtxcQ289BiU+p3TvdGCZLdtcVvP5O+1BC9TcDTAFPxctAHli3i1b0qrC0NyqJfJn/2ogtF7KFMWjm2h2Ud4w4r7RtSxbJ0P0y0TK/bdlOCyFGDxats8rGPfjJGmcMyzVfkschWZqVKN/PbC/msLAXAYLdsdkecSeGWOHteiUIzaembmGaKnYXlHqLPljrQ/5A6CHo9oGd3v4t5ALyuN3fbw62LJ2CRcRZt8jEV7dkw2aXTEjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FosC2kMmp/1hSTgDgwxvtvsP+EXn77RFOD7t/0KClg=;
 b=Aq6CFdhsL8KRfxSquitYJI6zw5h9wl7YEXUQ0wlzIYGoSV3Oq03o0X9NWAOcEbbMUWr8ODFmvefH4rn8K8ONWBu5TJVQ776o4pKZdAjnNQUsqSWZ4cO/yxaU5oXJnU5h1ihbV1x2Zc7M0Sau/9FvWjtk7itYDQgioGQkZQkJzcw/EFVRMyn26/dydTS0Cf7KHUVFI6JNAJ8aqHhWm/5KOvAK7IQMqKn255e2Zn7lul4NX5YiHgwCnqsC6IVGRHmObmSrFx6Wms3KAz+tVp+j0M9oflkMmdesFLX0r5NhxOLYhxcgHDnxt0HVx3Ic6eHqsqbrRFWb7RY0oDTnpqaxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FosC2kMmp/1hSTgDgwxvtvsP+EXn77RFOD7t/0KClg=;
 b=V8TdtGW1HUcp4bNwFwiBB6LpznmqsW/PLIMmEdM/GlQZbzia6hugU2xPpc7sa2cfj+Y7avwoGrKZqf5gY38uVmEMa58gimUL+wgWdJO/YZ2uPF9+MiTL+JnBY2dD0WMsEWpLAphh7w3d2cWqG3Bxnzh7GriLsT8wL6PZppTNSSQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 11:01:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 11:01:38 +0000
Subject: Re: [PATCH 2/3] btrfs: remove dead comment on btrfs_add_dead_root()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-3-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5199f20f-9ee9-897f-20c0-3d20e7da36a3@oracle.com>
Date:   Mon, 28 Jun 2021 19:01:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210628101637.349718-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 11:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe5f7687-52b0-4bbf-f6ff-08d93a241a1f
X-MS-TrafficTypeDiagnostic: BLAPR10MB4865:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4865A58AA867539ADC1E5FB6E5039@BLAPR10MB4865.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tq56NWrIl/vtHWLLz/MgKs/pW1AJqnH0MViaza1PS36A6OJV0W3FSFsBnkG8kBRlABMrZ8APKgyHQRIxKq9Ct0k23T0MfxdK2cIGwff5AY/eeY/CtMtjU6JMeFYeBv4voKB/Bx7tI57ui65cMnAVnP/j9pQyfFh6Cc0b9I2SKWsZu1jhOUILfBWlqDeAnvKiXWXu86EF0HMbgPFuFNTksaM9GrUZTmXGwemzKfEGAbMk12LP+kSjQBKCprjD4bFr3W5WapWhi537p0vyQov7veh058PwW6kHSb89yH4S7paO/83eSWMdB7U5xyHcDnorA9jJDTrCr6GgUjTdftSru3O0f4228DA/zbJs2GEriTqIXKeIU2TCDztMFjozLKOAdVWxmgIFSpgDDPGqpsfKaK2Hfj8t6eYLLzQ4s5q1mmR/25D4Jh30kqSR4eKEteLkrvGQ3z9/YgeC3y5eUSo9M0qOb0p5EBBcuGjssWEYy5i7hUh3GKLKvL+3CJ+yd9Ok1bXNXdMRpeZ7ZoPNoISP2jBBCI0xrNA+X8iVNMcJYnC1tKh+NdCgzxcnmROcannSx8epJRq28x+B+CBi5O3/AJmO427vLND8KCjM7w3AUjUarEU79m3gv5j2i9bKe8mG41HiGmaQ5yxul+iwOizM2CSeU+ScWfb3uqmZhRwYpLb9YbFheWTEXDTTKetUSAYPQZwusArGB8Rnyo2FV15aWNA8W0v9asNCnVXtuTXJAl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(31696002)(8936002)(6666004)(956004)(186003)(16526019)(86362001)(8676002)(44832011)(31686004)(316002)(2616005)(16576012)(26005)(83380400001)(478600001)(53546011)(36756003)(66556008)(66476007)(5660300002)(66946007)(38100700002)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NxWk1wMkZKWjZFMFdFUTdTRDJlT0daYkt5d0NqbFN6SlUrN2RSeHdwT2Rk?=
 =?utf-8?B?VW52V2VobU9jUVFHa1B3TlR4Wk80VXhIdm1mUUJTU3o5UExxZ3hZLysrbFJ2?=
 =?utf-8?B?cmhKYXEzZjJESHhzNzdBYWVqcjhLcHVPblZ3WkE5ZGErZzgzdnEya3BHTC91?=
 =?utf-8?B?MWlaaXptMi8xNEFqWmwxazRRazMrcnpMWURobVdEbEM5TGVVaXAzbm9iVDUx?=
 =?utf-8?B?TzRBeVNSNmdPUllsU1J1TXh5cHIzRzlpeG9FK1NMWVBFV1NwWldJK2IvQVRY?=
 =?utf-8?B?V1d6Zms3U2xGZktMQ1BSdnlObmhsMndyWHJmU28yMUhWQjBQRHhJZkEvd2l0?=
 =?utf-8?B?cURFelRhYkd4K0FRNG5NR3Y0UTlqbUZwaUh3MlhEOHBYVFdEZVFHV0VSK0pn?=
 =?utf-8?B?S1hUREFvakJzVm9hNW5KRmgyQ2FvSmNRN3cwTm93aXJJUkk5SWIydU4vajRq?=
 =?utf-8?B?VXRzR1hVbWt4SW4yWTFNaXhRcnlyWG9BM1owL1QvWWdneVpYQU05ajluRHVk?=
 =?utf-8?B?VHRqMytNWC9QNnFDL1h6T2FQdUl4aWROdFBlS0pEL3hjK293L3VURmR3c3J6?=
 =?utf-8?B?OEtKVlVab3djVTIxQzZWMVV3S3BzVGozRVNnUFlmWEx4Wk5peFdvcUVHUjBr?=
 =?utf-8?B?TG9Wc3MvcFVFSHhGYzdLdFZkYlkxcG9WZW1jSUk0NmE2bExoTVlJSXFrQUVN?=
 =?utf-8?B?UG5CNnBEenIxTDZNZEJaYWs1Q0MveTczMXpXaFJseWNmR2w4NkFEN2M3WFRn?=
 =?utf-8?B?MkM0RUlGam9lUGVVYitHNlBydzFydXY5KzZjSjIwSUxXbEdLZ211UTl0b3pG?=
 =?utf-8?B?anRlWlIvL3ZuTXYraFE0c25HamNlYkFLTCtFanpYOGhReEJnR1RSN0xOWk9t?=
 =?utf-8?B?NnVMcFVTcURmTE1jVlNWc2I1WTh0bUdBcFh2UjNzeS9HeGRQa1ZaeS8zb1dy?=
 =?utf-8?B?WS9mQ2Z1ZkNLWDd4TUN3SFhoQW5yeGlNanpKZjdCTzZmcWxpSnpkdWV4T1Fr?=
 =?utf-8?B?aEJjTDJ5eGowK3QwanNVZldsalppb2lOR3kzUS9Zb2plS012cWxLMHROYVc2?=
 =?utf-8?B?UWkyZ1h2ZWkvSnBBUjVWOUg0MVJlK0tLT3k1ZDVRQWxvSWNIclZad1lPaHFE?=
 =?utf-8?B?ZjJndkxIUjhONEl4bVF2Mi92ci9YdFVqSTE3aHpWcngzQ0wzcGlZWGFWamJM?=
 =?utf-8?B?ZWpmSjM1WTV0Y0s3blZNaGpYbEN4M25uSGlvUnlkcFNRZDVwa0dGaGFKZFMy?=
 =?utf-8?B?Uzg3ZmttUHJXTjBTWXJXeTlLeFR6cUNwY3JaNlpMeDFaY2pWZ1FVK1VJN2N4?=
 =?utf-8?B?bXY2ZEs0UnQwWC81M2NrSlFUUkgrVEovUDU3MTVEaFlPd0x5dlJHSHhjU0Fk?=
 =?utf-8?B?NmRXa0ZRR1JYQlFsLzFiNzR5ZHVoU1J1MFVFTlFoS1NnbkcvalNoU2d0UTJV?=
 =?utf-8?B?VXNnQkJwR2ZCaXMrdklHK3gwYnZNdXN6b2U4MnNaM1dBbHpVdmdWbGttRk9K?=
 =?utf-8?B?SUdUbXBBQ3NvT3EzRmpxSnY3YXZmd2duSXQrSFF1ZFVuVlpNaytnc3BFekhw?=
 =?utf-8?B?ei9SMHRtNlUydDBTYXVLNlBiYjQvYU1XNlllejM1OHFnQVNUdE1reE9nRTND?=
 =?utf-8?B?SitadWk4VzJhV0x6OXBVWllVb2tyQXBNYlAwMDNOYkR0ZDNKT2ZaZFNCTEFi?=
 =?utf-8?B?SW9pRVlOVXpYTjNvUHVrM0dJQnhpNkVabWs2U0JCUmx2eHJhbE03bHcrRVVN?=
 =?utf-8?Q?olzqi1Z7UF3B43AE683Vv2Ivni6KHq999QiEDWl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5f7687-52b0-4bbf-f6ff-08d93a241a1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 11:01:38.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkoU9ZhBA++sqzwv2PUJXcDg0mR/4z6SQSe8ZMeLOcPUpyBFzLOyHG+F6uUturGW7Z3PLBmQqwab8NhVjRY/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280077
X-Proofpoint-GUID: LrP3bk3aICzBN7G98MV-Y1vTnerajmc_
X-Proofpoint-ORIG-GUID: LrP3bk3aICzBN7G98MV-Y1vTnerajmc_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/6/21 6:16 pm, Qu Wenruo wrote:
> The old comment is from the initial merge of btrfs, but since commit
> 5d4f98a28c7d ("Btrfs: Mixed back reference  (FORWARD ROLLING FORMAT
> CHANGE)") changed the behavior to not to allocate any extra memory,
> the comment on the memory allocation part is out-of-date.
> 
> Fix it by removing the dead part and change it to modern behavior.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/transaction.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 73df8b81496e..29316c062237 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1319,9 +1319,10 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
>   }
>   
>   /*
> - * dead roots are old snapshots that need to be deleted.  This allocates
> - * a dirty root struct and adds it into the list of dead roots that need to
> - * be deleted
> + * Dead roots are old snapshots that need to be deleted.
> + *
> + * This helper will queue them to the dead_roots list to be deleted by
> + * cleaner thread.
>    */
>   void btrfs_add_dead_root(struct btrfs_root *root)
>   {
> 

