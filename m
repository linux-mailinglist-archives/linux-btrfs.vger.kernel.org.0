Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7576668B7B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBFIvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 03:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFIvL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 03:51:11 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8716301
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 00:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqrPy6B20a1+wMtFq8TECS+SoLSsiZvJQ62ZNu5ZGquuUFpNHrenFWGQ+wlEli5TPtymD2Zk0OoA685iYM8QvKq1EvWerAE0H8p3DkWly5ZIDt6drwVFDYvzcalWBFqddzVwJXhKxUwdp98PM8/bVAsVKKRVudmYgVohbAnvvZLmeWvw3QEwjVFRG0IySJCvRCKV6qjjB4P7SGTc2y8AM0gxNtaoUT2vwlonfYLSXT0voGHudKdf/mOIJLe/K5SYH6v1ruGKO3JbnIcN9+vHXITTUaD2meHW7a50Thpvdzghpwan4WVzPgmwbCsiZpDCBu0YRs2c5pGn/h8+n25X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8X8eKA3aVsv4WNIynSKBsEYmQiePpmq30k11HelZrw=;
 b=JvgF1IOLNkoV5QewtrOCIiURE811e5D2jtDKpPWF1vdf6rcrFxx9+hkzZIB/lkDCJ0YmV5npFPmlFyyhBZJtSX6HiRO4HIP0LCcOwmqrvwbkZydW/t1WFrfdcn8UYIngqW2e/MzlSufUA8wVMx2xcsdSdAIxX55hO2CBoTEriTrxV/9NlWFaJKA1m9z2bbaqmlPho4IoEzmOS3rm2sPPyGC6/I/XhzB2PYVxMBGm4XJlY2acll+QMtZRRbz/AYzHU9taNB1Z7SFlhzLYsly8UWNoj6IRTsQ6y1gl0U7bwQbBshhVxZpwnYhvTx/FK+cPA0G5W5dwDkj/1rmyU/5YKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8X8eKA3aVsv4WNIynSKBsEYmQiePpmq30k11HelZrw=;
 b=J62Kw8LEJgkUeq2xw4xhxoulnad23DUg0ZMwYNEE7v2kb1Qo2+PDkKb7BujAxZOORGT3YKCQeE3oGXXlBOQR0szmTlkiVcCor2lMbWasGVa3LaCSiB9dV6PKFKgW3Jnw2ZEXrRmR2TSL0jGoniNOU5nPV+BM8O6/0UlQ9Lmeqa2PZygft0slaGbwJvVWZ5atkbAkhRKUhGW6j5PTQ6b5b+2iMZ5WCLAh+APMDgTRQGhQHOICd3A7oBdU7Opf4BdnyyjoW8o2uk6nttrg+DenZISTdWYRkUMtQWdHd+62jeT0vc/FjwIqe66DlR1os0aalWcxKX8y1obJwgIIsaq7Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7816.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:51:06 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 08:51:06 +0000
Message-ID: <742b0199-c27a-80e3-7f89-3165ba7ba362@suse.com>
Date:   Mon, 6 Feb 2023 16:50:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1675586554.git.wqu@suse.com>
 <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
 <a08c7ae8-b31a-55aa-fbd4-9db441c0c416@wdc.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
In-Reply-To: <a08c7ae8-b31a-55aa-fbd4-9db441c0c416@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0564b5-ed58-4b68-b9ea-08db081f47c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rp+JhNM8AcWqvA9SpdtLoQwqkqvdHsg5Q5j4oBOHjMNbxI9YpHnLbN1IrPa2gsBvhuESJ/L7Qi4uPD/eLEygk+d0nFfwsdJG1qiormvHXnzz7fAk5Wots1VcrPGAO2r/r+ISQ10S/7nLpBtQh0jxEx18QdyviWQs+zFkoMsxUY7e7hYejkp4mcIxwqTxgbGX/bPXDgOaY67zghu2HDFSScqG5vEfrVQMN0xCGs2vUEHpCmj8INNmb7UdYh+JxJMbk3TVtkzADhNZHPMvhgzzehQJrbqA7jXhsppsRFLAM5bB06sPbqZ+F+yIHTGVVWyMf/IiLB7KIiDRXsPwSaqSJW/xwAn9RIKbIAKEJ25yjl746/znbnQO7HExbLW4A9uqkWra+o8/dahKLk+hQU9qkgXgSe8Qv6JsUJWwQfyvPx/k4iTuLtAigr0Jhv+u0rNTrgG1RBGwtRfJZf1LQJ5J6NUShGdTjyaGVb4i6my0Ah6IVhoIfPqlUibpPDJLvn1WjwvzeU11sUvjiEYJDfuaFPrhBi3fuuYEL139jkdJuNr64ZAQLQnZqH3p8F3CV+mwDdI1YeoyCOblErpJDTqzZpx3pL/XMaPfmH3WUqxrlfzwlGg/ZVU3VfrwxDcCaTmm1eCBHqZFiSKklnx0EZeTt4SPdnyXtsk+9kv9vdd3BF9Z0VMLhOU96Je5nOS7H/ryHCqFOhdDK6Wso4mJA40T36pTvJZVAWFa73WbbzhIHiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(6666004)(110136005)(6506007)(53546011)(6512007)(6486002)(478600001)(186003)(41300700001)(2906002)(5660300002)(8936002)(316002)(66946007)(8676002)(66556008)(66476007)(38100700002)(31696002)(86362001)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blB1WEtITHhEM2FZbmZ1MjFaL0xVZmJYcnJqbGRYWHo3ci8rcXJtRWcwK05Y?=
 =?utf-8?B?b2ZGRHByZFIwanNTVHVEbE9tMjVyZE00TC9wUExEeGJtcTJuVUtIcmsyWUlW?=
 =?utf-8?B?Yld6ZTBNbmJJRkQzTndtK3dTQTlVYW5tcDJkcy92QnBBMm5yRy8zeTVEZ3F3?=
 =?utf-8?B?WUpMWGZicS9tdXg1SWI3WXlPVE80SlRWZzBpNS9sRFhmMnY5cmxJd1k4MFNS?=
 =?utf-8?B?SkNzVnlSSmdxbkRWdmhMT1dWNVV1U2pQTWRoZzl0WTRNZjIxMWFrQzZCZ3I0?=
 =?utf-8?B?eUVKQklseHh5b0wzQmxhQmVsVUlCVnNMZnMwb2VkdEJNNldRaDNzUW90Si8w?=
 =?utf-8?B?SlVUVUo5NnY2QWtrd0taSzliZUFrODFuVU9vemtOUUI0ZldnR2RZTHI1QXVm?=
 =?utf-8?B?L1E2L2VycWl5cnVseXlaWEhBVEoxSkVEYTZ3T1V0T1h2T3lHWUZCbmVpOW9t?=
 =?utf-8?B?SzRjQUgzM1AwbVFKWGxmWkg1NUdRRmY1WkQ4czlIQnlvQWlPM21UdGk0NWpp?=
 =?utf-8?B?K2EwWkpVYzNaNmpJdXJPakZ6R0IrM1BxenF3TENONG4wbk5qMUJwT2ZSM2tH?=
 =?utf-8?B?bG41ek5BUlJJb1VTTll1TTZwbEFzWlFBa3VsSjJHbGxZeXo2aWpYU2pGWGV3?=
 =?utf-8?B?N3NiL3dlK3JKRkxYVUVlcmRHakdub3QrUU0yZE5veGJMclgwdVFEMWpUL3E0?=
 =?utf-8?B?T1dhcHBmOGdST21LL0FlNFRLTys3ell6YU0xYmFldHJaZ3ZacUVSZHFKT2Q5?=
 =?utf-8?B?c3RuUit4OHRqcE9DeC82c0tIOHZEK0pUWGNmSkpWTVA1NHB1cGRrcXlHd045?=
 =?utf-8?B?c0lyVEtWN2pxb3hrUjNIYURkY1FZYXUraExSM09TMjJTcSthbEFwTnRLd2pz?=
 =?utf-8?B?R3NXdlpoY29Hc04vMFhtU3diTFY4WThWdHF3ZTAra1NCZ1VsZ0xNUENobE5y?=
 =?utf-8?B?eDlENlRlWXl6aUtaQVJkc3BOWkwwZTlRSzVGTTVwNGMvaU42UW9GWVBaU1Az?=
 =?utf-8?B?S01lZ3I0UU1SQ1BTNHh4ZDdzTm9nMFg0dUR2Q3lwMEo3ZTFFWm52TmtQeG5I?=
 =?utf-8?B?TGhtSXEwck1sRUZrZkRiNmFKWXlNNGhQTXJLendsK0NjMmIxdDFEQnlSRjdW?=
 =?utf-8?B?V0hRNGttdUUwZ1dMSzVFdnFpZlFMUmV2Y1VyVzVyTWhvYnQwNEw2V0tUTzRK?=
 =?utf-8?B?bXBqNjNkQW45M1hRK2piVXJnVkRmZGo0TjU0YVV0ejhJNzRxZitXZzhMTnVi?=
 =?utf-8?B?L0tBQ3BQb3NibC9pWnlWS0hyQjhpNTVCR1hvSS9kbjUyWlc3ZzMwbHVoaGVh?=
 =?utf-8?B?ZXI4b212ZXBZQk56M3lTYUUrRzRsNGkzQ3o2MThuK0pOcHhaWVdWclRsQnhM?=
 =?utf-8?B?d0syU3NxUVhocWN1MWpKZUJZM0ozWlRLejA3VzRJQ2txWmRxK21odEUzTTV0?=
 =?utf-8?B?Wmd1VTFNTkE4ZnNSMlc1USs0SG04WTVITzVFYXRyVjVKS0NhMjZ6cjFjb1RS?=
 =?utf-8?B?cUNRZCtXT1RRVmNkaVVPODNoN0hhQzVOOUk4TndMd3RsV2o2b1N5ZnhIaVlC?=
 =?utf-8?B?eHFjdjJMQzJWd01KTHhMUmk4YVBFVFJueVRVZmoxblVpN3prdDVaTFpxZHdG?=
 =?utf-8?B?aGVIZ3R1REZvejFUVHVNMXd4TE5ocFlPRWNwRTJQZGdSeUJyN3RaSEQ2Q1JM?=
 =?utf-8?B?MlF4VnJOU0VxM2EyTHpjdVB1NHFqMkY0K0FlMGM5bW1JbGZWcHBQRDk5a1cz?=
 =?utf-8?B?NEpIMXRMVVhneFZhTVdxVzl4N3cyZWs3ZWxlTEtqZmJrL2J2TDN1L0owR3Jt?=
 =?utf-8?B?ZGhvMCtSNTRoNU9FTmNxdTFuTlp5MGlTOXVBenhqeFA2Qyt1Mkc3b1NIUVgz?=
 =?utf-8?B?Znd6eHdSZDlCUi96Z2ZUTzQ3cWJnVCtsVEQyS2FqYUR5YmpzSGNCZE03Ukt6?=
 =?utf-8?B?eHJVbThQMXppU0k5TmhGNEs0bW04aDBSZTFtMyt1eS9DRStFNTJac0hzWnVR?=
 =?utf-8?B?dWhnbVQveFZYVVE0R21GNTZUQUthZlVKc0tPeE55clhnbTdiT01qc05ZN3RU?=
 =?utf-8?B?NUVlWU1rWGhDTTFpNkZlU3lQVDdWVmc1Z1N3cWNjbDB6amVWdEQrNVJ5UmxD?=
 =?utf-8?B?Tjh1MjlKYmQxZUtpd2gvK1krVHBEaUFla2dvdlgyZnlXajFkZ3dYMzlwYXNa?=
 =?utf-8?Q?T7psOi294fsex7KV06SUYaQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0564b5-ed58-4b68-b9ea-08db081f47c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:51:06.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl3do2rujY7/wyYVs8QUdPXwFEpwK2dQALpGToT12s3V/EI+LJ6Bt++hA6sYj+6A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7816
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/6 16:28, Johannes Thumshirn wrote:
> On 05.02.23 09:54, Qu Wenruo wrote:
>> Currently btrfs doesn't support stripe lengths other than 64KiB.
>> This is already in the tree-checker.
> 
> Do we actually ever want to do variable length stripes? I'm just asking
> for e.g. parity RAID.

And even if we go support different stripe length, would it be a global 
one (every chunk still go the same stripe len, just not 64K), or really 
every chunk can have its own stripe len?

Personally speaking, I prefer the latter one, but that means, we have to 
add a new member into the super block, thus needs a new incompat flag then.

I'm also curious, for the parity RAID (is that the old raid stripe 
tree?) is there anything penalty using the old 64K stripe length?

Thanks,
Qu
> 
> [...]
> 
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 6b7a05f6cf82..7d0d9f25864c 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -19,6 +19,10 @@ extern struct mutex uuid_mutex;
>>   
>>   #define BTRFS_STRIPE_LEN	SZ_64K
>>   
>> +#define BTRFS_STRIPE_LEN_SHIFT	(16)
> 
> Maybe:
> #define BTRFS_STRIPE_LEN_SHIFT (const_ilog2(BTRFS_STRIPE_LEN))
> 
> But even without:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
