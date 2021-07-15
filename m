Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790AC3C997F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhGOHVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 03:21:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58754 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhGOHVD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 03:21:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F7FkGD031855;
        Thu, 15 Jul 2021 07:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xX4QYUade/ITxoiIwPQguCMvt3xpEDY/IUmFwMfHDc8=;
 b=lT1vCnFGRz7fwrghIFIogGxHbU9xUK8+iuMGYmUZHWpPUhzzm3YqvIN/lSh69wX/drik
 QqPcM/C2fD/SVuARFf+OMlzXANs/mRKE45J7+CMQSQtOL7N0OfENoZpjUdEdQuf4dfsz
 X8pTucxmZwG8yyKqcfaYQQ8RuZ3ZHVrl/YqP6lONurcUSgekFhb4JYfVNVldo0t9s3Tp
 J4EXGdWsUe6X8gt/rYJIcdO7+WNxnuBoAwNkbjSDa8FHuyZ3bQZc6XXtWCVBJHu2dhfA
 0QSEEQwKltwIOGJ+ZcnClaz7kH3FyqtXmPgiL3fWLnSpdAQPtIbAC2XL23SeNhZoB05D ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xX4QYUade/ITxoiIwPQguCMvt3xpEDY/IUmFwMfHDc8=;
 b=F5EDyPg1GUiq9fRzLUQhh4SIP1UnGOBRAQOCHhkmXdlmUoHRwxTrCCbGVY1xFkcaEFS7
 KqP63p4Xt1WZgTg2qW2JZh2OpNeQuohJLC1fWtFPX+MCYY3zuUJC5+qPHVrYxQJpmSUU
 PcLB43WTqIKHvcsvF7Ry1g6logAKKD4Q8JIJvxD6yfC7wQJ8yei/GR5oF4BY1k+qCfDd
 yF4/vxP7WwyzQ2KlUgYtRu+cTezwQW73KvDwiwrDSHHbGoqxaABSt3xQo7F9ZIPWZ7BJ
 fcEskiSr7e5rp7dD1ADaZMpbhfCckDO4tG2D1impaFLMXn7Fex4g7uR/RP4VsznzR2f1 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39tg5101bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 07:18:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16F7F2gG134404;
        Thu, 15 Jul 2021 07:18:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 39qyd29gb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 07:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWmJ2USH5zziBM/j70wjvAE6aXsxGI16ucyYcKQ5R60GlQvSr17ewEuTz0HfwaaWI1Namdkh9bS2LDJ7W9NRmhu98ZIdMnxd/M8+4a/oUUZ3JNElq+N82c+uP3LGtwN87S+aZ/yun0jT4byiUxMpzZu7Kjd98udoREcBHO6gz9N+H41wUUeJAmHO7bB1YUX9svkNQyRkWV0DTKXaD352GmrZe47rEFcTjP0IrsQUrVtaThIvmAUR9e8M47b+CdSZhGPvT11E+7MPHvQlUjSqd+NHIXj+IF3WmEiDnlOJGo22h5xblV9HwTwcD8KizH8c3MPnMFegMSjZAEczzPyFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX4QYUade/ITxoiIwPQguCMvt3xpEDY/IUmFwMfHDc8=;
 b=KQ3v1IQd6nYhnkKjAgdBANvxSw9gxRd+pTARo/PVn6W7ODuU2vcgdxBIhIpXckowmWEh4Xkz+N/PJVip7cV2OggeJcauIKu9TEuZgQwW71la/qhvFB01SEFnHO4anPV1nxBiGTwiC+b19l59MI7NhjSUVEeP6v6svIXCue5vImv6ywD8qAJRj9Qilmr4YYBSXL/jfkol0ARgIQ5LfIGeVL3zjBHne+vVKEVL5tcfyCaWw/wDgIC8thi/sgzehevlpPxBacs8x3KplC6zysR0+a+yhF2fYlxg8F+dSM12m9WEEXeMjCD+LspNH6/mxkyfMWlFY0Yukl4/U0ABjINPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX4QYUade/ITxoiIwPQguCMvt3xpEDY/IUmFwMfHDc8=;
 b=BTQrLDF3KBc53BuYOgiuX+aPaovx9OrLYbOOkTarirHyTUbujqY1eUyyvkp1SrB95Odxf+ufgyORLhEntuBZzHS9AwSupjp3JxvUuamDZnsojA1FUUnpcvJYQxp8an/T4v+cvtjhLZTBueSVwcO/Eyrbl9mPt9xS0Z9wignKODk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 07:18:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 07:18:03 +0000
Subject: Re: [PATCH v3] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
References: <20210715050036.30369-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0a54017f-e147-1111-6526-b068558f9c7b@oracle.com>
Date:   Thu, 15 Jul 2021 15:17:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715050036.30369-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0146.apcprd03.prod.outlook.com
 (2603:1096:4:c8::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0146.apcprd03.prod.outlook.com (2603:1096:4:c8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Thu, 15 Jul 2021 07:18:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80593364-b825-41c8-717b-08d94760af5f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4287BC198B05DD77314C9D35E5129@MN2PR10MB4287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6ql22qTwyr4dFKbm+I3FC9dMWvdfMoG0LinmviJpZuUgU844TpKzDhKPYB/8vmJtrvNpSPTbrYd+1IzUcIW98rXuK1Mtmei8PkXWYRX05lgAJioS39gs0lQN0NBgdCUIrXDkUPH+1WdDPnUpnRo1kzaCyqnSso4MXkIVLDyNROV2J+ANCzPhVYPI9irMqcijaDvhxzOfF1kAQtFUiw6S1PK0XSMY+KNZGuBopDgx6vF8G/2ajPcusUxTJhP5W5pH2/TV4huL5fDxLkq6tIVeI0Gfr+8yHziJqF0z+jbVo1KTOtHJcHWF8M6uGMBou4kLu7jrpgPEVssql2caTc/wdBrsYpHFSOZR3lzE1Lml3W1X85ofutUrgXsjfuHvDoyyYr1SWf4umyciFx6OKQqeT/ChHmq+3Ua55uceBVlF+r3QpO20q56Z/7XHnyZPCPv/R3SI0hE4X+Oc4FPYvEr352LhcVU3EUZ/IZ5gElXgg4RJKHcINMeO3LoS8wZJvWBZv5tLYr1JXISIFaeQuz/WgqzYWSBY+hfpd34mSYyuKPzz3uUaiYEpsUU++jLSREyuBit2HLRCCADu/3JI+6SqH7Gj/xrg0pezVHpBPcwztQqz+gbnVKjiRLyfYYFGUBJUZf07tZRrm3goWA8GuGPPlMvmrgpXqQ0/WgGl+rTdRMrVeRFeVI0RGFxIKQoS+RZeYB+FNOq8L9s6kF/Bb4AgZAj48xHTJIFYIQulAwr+WBP1SHPqeBgEkvwPr0EtElckY5uCnerlZ+9HhBrS6zmQfTjHSibdmvgd7Op7/WRiAUVLk8nznM1YEhJEdy1bqz+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(376002)(136003)(26005)(8936002)(31696002)(8676002)(6486002)(6666004)(186003)(83380400001)(66476007)(66556008)(66946007)(86362001)(44832011)(316002)(16576012)(2616005)(956004)(966005)(2906002)(478600001)(5660300002)(53546011)(31686004)(36756003)(4326008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUt6YTFiQk9kV2NqZUJPWlVHdUVDSk41dmhRUDhUM2lObnVHaVVjYzFoQnJP?=
 =?utf-8?B?UmdBTHJVZjZBRGxBZnZQNm9QTFdtRXRmOW0rQXVJbFNiL2s3MFlBYWZWNTc2?=
 =?utf-8?B?UnUyUnBFanZSalBiQm9CTVNWS0JMNURzWGtlaFoyVGZ2R2hMbVpBZVNpNFIy?=
 =?utf-8?B?aWovTWJaQnBHVXh5dlAvR0cwUlhlOUpFeUZvT2s4NWFlTFNoN2lZWXlYK0lH?=
 =?utf-8?B?b0pRSExWbEVCVlo5MGE1NEpGL2p3ckM2YmdQV0Z6TTcwVmtzQkRTZkxIZ1li?=
 =?utf-8?B?M1crdlZIU0ZTN01UVnZVMEwxaFc1RDVYMEQ0LzI4aER2Vlg3cnVCcFlST1hK?=
 =?utf-8?B?Znhoam5FaWZtbDlJNWpBTStCSjg5T0loOGNmTTF1eGFWQkQ0OVNUenFCU216?=
 =?utf-8?B?aGlFNWpzMXRlWDRwZVJONHBLcTBUbjFoQ0tXRzF2cEVjTFlqVmJ4VlFiU0xt?=
 =?utf-8?B?TnJtQW1vZUtrYld3RDFjUWNkUEtncXdYWXFyMktQUHVOMEhVbTJOUVJXSmI4?=
 =?utf-8?B?ejlOOVFobGtnZVpYTnhvVmx0S1YwRDFFeExxSjVjQjRBZ1lha1pDQkVsTTlI?=
 =?utf-8?B?YVNQWUV4WlVjbWQ2TXR3SFZzRHdDRXVXU2R2aFV3NUtjemVIZFlIVld0aStH?=
 =?utf-8?B?cGFhVDRRZU00NUFRdGRRdy9kTkRCMkozbTRVZkFUWEp2ZzlaOVMvc0NHWHAy?=
 =?utf-8?B?TTBxWVJBa0hZalZBUDJRNmhQanY2TitvK2svT0Q3S2ZGM1QvREpQR0RUeXVx?=
 =?utf-8?B?cndlSE54M3djaTljLzRKdjFFV2RHZFJ3QmJTSnA1Q2dJR25jL1NFSEJWb3M0?=
 =?utf-8?B?RFloMnlscXVlTTVKUVNQaEkvRjJSVlcxcE9hTXdlallObW9xYnkrVlNDUEF3?=
 =?utf-8?B?NHJrRWxJZ1FnNnZ0dlNsUlBia0x6a3J2bjA1a1pFMk5QejNLNUU3Z2tkdSsv?=
 =?utf-8?B?VkpKLzNhRU9PRUpPNkQyUE1BRGp3MDM0UEI2NEFYYlduT2RlalEvTTJnZUZE?=
 =?utf-8?B?Qis4Z1o4WjlkSnM3aFJoK0VWaVU2WmNZS1MxL05jOEp6dkgyczVIMnJjNlhD?=
 =?utf-8?B?WUxvWGJkQzNIeUt1K0psdGlKNHZWbjlOTUJSMDNHOXlNUTVqQ3ZhclZSR1FP?=
 =?utf-8?B?N1hnaWVjeUhZOWlrVlFQOHZTLzEvcWxEV1EzWEVYWXpjRWpqSkJsNHZ5VTBP?=
 =?utf-8?B?MjNLaWJhTVZMQzZyb0xpbVN4MjZUSm05VUVYM2ZWRkdlanAvMkk2ZVlCejNl?=
 =?utf-8?B?bUFMYnF5OGpQa3NDbGk1bXBOYXV3Ui9TWHRyd3gxbnBMNTNCOE9GRHA2RnM1?=
 =?utf-8?B?NTFyNVliQkRWWEloVk9qMFBkNWpLbHBCUjFWY2srQnRFMWVqL0ViaGNwUFhy?=
 =?utf-8?B?MUtzUVY5VG9HelQ5OVAxVjN4Y3UyQTBzd1N5TjI4cHBEQ1FLMzJuWkE1SjlI?=
 =?utf-8?B?Tk11R1J2RG5pSWswbWpkaVZMWWcvTjdTa1JzQjB0UXI3ZUJXLzZjdWR0Vms0?=
 =?utf-8?B?RDdleGlBWnBHKzcwVERTUkNha29LcWlFL3hVWkRzRmMvU1gwTjZvRnVib2Vn?=
 =?utf-8?B?ZzIyYWhmK2lKVXVVbUFDaGVqdGNuZ3RqNnlGWWFPSlNGUlpVcEdUdlFrQThH?=
 =?utf-8?B?RGQvaUNPeXFqQmdXZ0NITXpzbFMyVitVQnVJeEFJcVVDSUhFRDFvMnBtaDJH?=
 =?utf-8?B?MHBadmFuclhaL0QrYUx5N0w2ZmdIZXRNVVB0Qm45QzNEY2E3bDkwY2t5MkJT?=
 =?utf-8?Q?+FzyHUqzPkowcinbsww/A3wTs92MxAJsdRxP57c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80593364-b825-41c8-717b-08d94760af5f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 07:18:03.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxHqlN2bFx/rd2ONNxCdUuoViqOZ6XuMMoegeuo0w+Yn099b47BqpjvzXo4q9palQJDxcphoo5oWKuGEWxwZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150054
X-Proofpoint-GUID: VyILdEwdI3JeDZwA3ND-nmPcDzxpadj9
X-Proofpoint-ORIG-GUID: VyILdEwdI3JeDZwA3ND-nmPcDzxpadj9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2021 13:00, Qu Wenruo wrote:
> When extent tree gets corrupted, normally it's not extent tree root, but
> one toasted tree leaf/node.
> 
> In that case, rescue=ibadroots mount option won't help as it can only
> handle the extent tree root corruption.
> 
> This patch will enhance the behavior by:
> 
> - Allow fill_dummy_bgs() to ignore -EEXIST error
> 
>    This means we may have some block group items read from disk, but
>    then hit some error halfway.
> 
> - Fallback to fill_dummy_bgs() if any error gets hit in
>    btrfs_read_block_groups()
> 
>    Of course, this still needs rescue=ibadroots mount option.
> 
> With that, rescue=ibadroots can handle extent tree corruption more
> gracefully and allow a better recover chance.
> 
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
> Signed-off-by: Qu Wenruo <wqu@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
> Changelog:
> v2:
> - Don't try to fill with dummy block groups when we hit ENOMEM
> v3:
> - Remove a dead condition
>    The empty fs_info->extent_root case has already been handled.
> ---
>   fs/btrfs/block-group.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..9bc68515bc4a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>   		bg->used = em->len;
>   		bg->flags = map->type;
>   		ret = btrfs_add_block_group_cache(fs_info, bg);
> -		if (ret) {
> +		/*
> +		 * We may have some block groups filled already, thus ignore
> +		 * the -EEXIST error.
> +		 */
> +		if (ret && ret != -EEXIST) {
>   			btrfs_remove_free_space_cache(bg);
>   			btrfs_put_block_group(bg);
>   			break;
>   		}
> +		ret = 0;
>   		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
>   					0, 0, &space_info);
>   		bg->space_info = space_info;
> @@ -2212,6 +2217,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	ret = check_chunk_block_group_mappings(info);
>   error:
>   	btrfs_free_path(path);
> +	/*
> +	 * We hit some error reading the extent tree, and have rescue=ibadroots
> +	 * mount option.
> +	 * Try to fill using dummy block groups so that the user can continue
> +	 * to mount and grab their data.
> +	 */
> +	if (ret && btrfs_test_opt(info, IGNOREBADROOTS))
> +		ret = fill_dummy_bgs(info);
>   	return ret;
>   }
>   
> 

