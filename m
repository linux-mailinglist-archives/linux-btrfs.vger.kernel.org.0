Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5F4110E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhITI1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:27:06 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31211 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhITI1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632126337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfbMc+W8UdWzeBjFv8Je/MkvENf0q2zHvtwqp8QEV0w=;
        b=DS905UThXZlQsfsR+7TsgvDeqwJ83Q6GXRVh0cFvx6OFSfBwH9x2M1FQIbCemSXBAbzP7D
        XZ3xvLNx+jRLLD3HO77p0OZVWYCcOb3VJcU1mfxwYQ3rpBuhC2VDEEqjcgRRxw/YFvbyrD
        A721+SY/ujPiJLEc4vT1F8sGFSkapao=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-5pxeNCGwNdyv4UfM3k-Kkg-1; Mon, 20 Sep 2021 10:25:36 +0200
X-MC-Unique: 5pxeNCGwNdyv4UfM3k-Kkg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWgn/wo1IiDA0DrB0UWgG1W4kmA/4UxtMpkyovrXXYOfLeWCpKIX4TobqoDZP7SBWWnqSPPwO7L3rAZGoMzNw6OpbTIDybNE4xosjAIH/fUFC9uyhneT+9G0jOzP+0SgtMB6DVd0AxSYEzmXKPUCTo93G7+a6Y4wAwZ5uLP8T5yAoZI67VZ4+01+vKcWwtRKHrRVJP48OPCIwpASnrsB+NfxIxLNRvzZEiYNM9+TW4cVT2Hdexb0wo8BsttxHApBCfohm7TCmsDh0tn10s+52X1SvbNOTcORgvs8eM8QyV9bDbBoYPydGgMX3KKJhy0xHux3VJw+GXLJTd2FvHRcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JfbMc+W8UdWzeBjFv8Je/MkvENf0q2zHvtwqp8QEV0w=;
 b=SVnkQ5lWF8jw79JOS9ZvBBRERoMIAH4a9xLUHjGO5gbAZ3mM1zWjcP8A6KD/rXpg3sKcKHyVi0+Pul1yQYTBqDtIYc1T889AJr/D3VXwntYN18vGgIfZMOkfqtgbOZvn9e6rYChHMnXGNMP8mFHwuKpus9P9A/6hf+PnAo6B1C7vaV9wVZrVmptCBSj+YcWmrkR17lrY+ohbLVwp6QzDA5AIUGesNaz7aSQrQLdx+WokbzJ0WP4nNtRfuWNf9ybrrToa6LbWnYu86U+LiffRd1ltK/HeD+E1+iL+C6RUReQWXnr3S/vMyBOrbdzpbNdn5GNiaKvhuaZTnVyrstGCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4519.eurprd04.prod.outlook.com (2603:10a6:20b:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 08:25:35 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 08:25:35 +0000
Message-ID: <7be281ea-1811-0ffe-0c78-c7491cafc3a6@suse.com>
Date:   Mon, 20 Sep 2021 16:25:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
Content-Language: en-US
To:     dsterba@suse.cz,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
 <20210920081246.GX9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20210920081246.GX9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0125.namprd13.prod.outlook.com (2603:10b6:a03:2c6::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Mon, 20 Sep 2021 08:25:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e6a446f-cc87-4c84-850d-08d97c1037d9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4519:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB451918FF0D9A07CE7BC5ECF7D6A09@AM6PR04MB4519.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppX3HavAoUOPKDztmD1zL9OON9WkfbQYeXmHvTTYDv7OQzxR3PCWmJjqND9IQ+vv4u6VIVfP0oanpTy3xmrsnl7vBo9qgOxugD1YPyy48btWj3tYkrziCH8tTIoJiBuFNhquoMdKGw9MbYmlecGCjFJco7HvhnjWU57dH/dXrKD0LclYYDXNgXQIIaTbuM6l3YKNJxaa3XnG5m1tu641jPFv20jOB1NLMXvmCF0rVHbqyNTKaeJtMFBC6UtErFPVvJ9vHodEuJRS7Ck3NFNz1v/GEbAn6QEZlTmFPuAEdVgEjFGbDGJkazWlqFAWXI9diuh0BH3Y3Ycwdwk46mbFVoVOr44F6eEtGqdrJiu3HU67oYsRv4ONM090uWbrJkTx/8xIv7ejWxObhZ5oK7aYtV8+yOfuGWxd64znr7pXldAoFzDpWj5CBeCKpbGSm1ao+vrV7Ib4kcPk0si2haGdiFCdLhhSVXfs7MKIavW7eFep2W6hZBVCCcvOyi/e+AKbI26Pn3X69Zh9PtEC+okXTL7X1ejEvaDt09aw7t2hEPCC7WTsz2hlHoMeDg2p8l5Wx6gbE0PHIaqLBuARrYIwSRbs5bjn2PKSfW5gAmIBokSf7O6FaZemmoUcavx6TtRy0PtObrqJA44zMw5Lput1EvT/3iG8dDAzIp7CVrx6J3qgt/8ryCCxd0r6ufpeMEK8Ft8di+vQL02bsEBeHrhIP39+BzE8f9RAe0IFU+EVlWw1xHC9cnAL/lOX6SZ0kaaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(2906002)(31686004)(186003)(38100700002)(66946007)(36756003)(16576012)(53546011)(508600001)(8676002)(316002)(86362001)(26005)(6486002)(6666004)(2616005)(5660300002)(956004)(8936002)(83380400001)(31696002)(110136005)(6706004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldaVElmem1CL0VSY0RtN1hMMks5TmFnS0dPVmwxY1VCUU5IWk12cDdibWZM?=
 =?utf-8?B?RTU5ZFMxVHpJZEpxMXQva05qTmlva1ZHb29qL2d2cEJKTk9FQVg2M05LazNM?=
 =?utf-8?B?RDI4UTVITXpZZms0cXdRNG5YTDhoUEZkc1V0dG0vQWY0QWJNQ1k1L0h4YVJB?=
 =?utf-8?B?NllFMitqdHVyNmxOZngvVDlaT0dOcFRMSWViWXpadjkrelYzVWR5eXVwK3Vz?=
 =?utf-8?B?N0NEU1FUZjZMRnhlN1A4ejNMRC9nRjJ6Z0poa1l0eURRclBwRG9QRlZhUE1N?=
 =?utf-8?B?ZkdhZW1TUHcxVHYzZjIvRmNIaTdDVXZvVkNreWcvQUwwRmhKSFg2QklwTTZD?=
 =?utf-8?B?WWhqZUV3RlVZZFduYVdJdmp1aEZtTUZuTGdDKzVYcFVyVWZKTWs4VTd6dTNX?=
 =?utf-8?B?d2tmVHlBYStaWHJON0hFOThOMi9QdVRaTVc5RjdjK3RQSVh2aGVBZEcrc25Q?=
 =?utf-8?B?LzdoQjlOWGUwUzF0emRUTVlKQTd4bXRQY3BrVVZWTzc0RDQ1Uit4UlFYbm1T?=
 =?utf-8?B?RVpJSit2SHZYcVk5aHFWeDY2WGxCQnE4aDAvaXRxZ2JNWnNpYzQ4c1Jpai85?=
 =?utf-8?B?QjJ1UW1OQ0gyWnBjV3k2a1ppSDRsR0VlT0RFaGFyaEw4andVRE90dkRBZDNP?=
 =?utf-8?B?WDRRQndPOVNibFBEVkhUMmdML1NSMHVxQmNPMkxmNVdJdS9pelBHckN5MHBK?=
 =?utf-8?B?RnYrK016TnZFUzFudFNxWE56K1d4UVBjZGJuUVF0eEFrRnZZV2JkRFViZ2ph?=
 =?utf-8?B?RW9ZcGtLYitCZmZoNjRNN001RTdsZElDdXNCWGw1ZWFRUmUzR2UxUGlIT1hB?=
 =?utf-8?B?ZU5TRkpsYmdxMERUdTFZL3RJbGZ4UWhoYkVQV2M0eXF4SGJKdUFodEYvekNT?=
 =?utf-8?B?cnJyZ0Uwai9rNlFod2dPL1V1bW1XSjlRZjd6aFJXQTJQcEpzSmlFeTVhZjFy?=
 =?utf-8?B?TjYwY1ZTMGhPZ0F0UkozT2NvWkx1QlpDdEFkTk9HMjNIYTArWCs1Z1pWcEph?=
 =?utf-8?B?NGNOUlFYRzlpN2lueHV4U200SnFncWtRdmtZL1laV1RpdE5mY29Pa2V1Z0dC?=
 =?utf-8?B?aFNNRmw2a2h4RUtOckxEOGZnMHZ2S1FFOFo4OWRENmlZNWxmbXhhT1d1T2RP?=
 =?utf-8?B?VjI2b3dFaWlSZ2JiWDFOSmo2VlFCZzl0cnlvZFZrTjVMZVdZanJuV2hadi9i?=
 =?utf-8?B?VStNbkFRRzlEeHNLWVhaMG90Z2x4R0hSS0JvaDF5Z0NSZXVCSzllVHNMOVhR?=
 =?utf-8?B?bkdrOC80L2lESkVWUWk5WlhVYVFKWkpNSW5jcGdSUG1jOUpBbUxTTHhRNTY0?=
 =?utf-8?B?QmpjckdLNGR2Rmtoa0RCUE90cWVneVBFd3BmUnc5WFZpOCs5SEtFdmgvZk9W?=
 =?utf-8?B?QnpTaHp5dHNsTWI1TGJHc1AwVzZMTXRKWlNGL1B5dFFuZFZ2TjQ3ZmtJZmxJ?=
 =?utf-8?B?UDd2SDV6WEZaZlYyeUpKVDg3SjJleWQwc1dxczBFVDI4THhHSlRKelZ4WXlG?=
 =?utf-8?B?MDB3cXM0VGxFdXN5b1BsNWFXeWpYdnhoeTl2d0lKc3RSdVY2WWpOYisyQTRs?=
 =?utf-8?B?a1BiZUY5dThFUmFKYmE2UTB6alplWUdhSERPbTN4STZBUDNvVlE4NVJvM2RM?=
 =?utf-8?B?NklXY3k0ZlZwbDZieHhjbkY3Q3dDOFpzWmZYWE9FUFUzM0ptUkJVZTgrNk4r?=
 =?utf-8?B?YlhMeTk1Sy81L0J3emMvR1dQWmtPdEN5QzBJMm0vYnQwb205bUFYMzdLMzFZ?=
 =?utf-8?Q?Ahlb7sddM88lP44xeIBTFI8+vvqt/MESfSE4gL9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a446f-cc87-4c84-850d-08d97c1037d9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 08:25:35.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtnqFAjUpRjumeORRE2zENKUenOelrQu+fa75vlbNlIkvcz4Z5t6G43xxbUMjG30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4519
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 16:12, David Sterba wrote:
> On Sun, Sep 19, 2021 at 11:40:39PM +0100, Russell King (Oracle) wrote:
>> Debian gcc 10.2.1 complains thusly:
>>
>> fs/btrfs/tree-checker.c:1071:9: warning: missing braces
>> around initializer [-Wmissing-braces]
>>    struct btrfs_root_item ri = { 0 };
>>           ^
>> fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]
>>
>> Fix it by removing the unnecessary '0' initialiser, leaving the
>> braces.
>>
>> Fixes: 1465af12e254 ("btrfs: tree-checker: fix false alert caused by legacy btrfs root item")
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> ---
>>   fs/btrfs/tree-checker.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index a8b2e0d2c025..1737b62756a6 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -1068,7 +1068,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
>>   			   int slot)
>>   {
>>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>> -	struct btrfs_root_item ri = { 0 };
>> +	struct btrfs_root_item ri = { };
> 
> Kees Cook does a tree wide unification to { } because there are some
> oddities with partial initialization and { 0 } so this will get fixed
> eventually.

Does this mean in the future only "= { }" is preferred?

It would looks a little weird to me as C89/C90 doesn't allow this.

And I guess checkpatch would also be updated to handle that?

Thanks,
Qu

> But again the minimum gcc version is now 5.1 so it won't
> matter for 4.9 anyway.
> 

