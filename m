Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B144B5E94
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 01:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiBOADC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 19:03:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiBOADB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 19:03:01 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFAFDE88
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 16:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644883370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k72Ut7l9qC1I47OI/lDAXoGOj52rmFOH1/A4OheVX48=;
        b=l/eWE+AFl0ecHiW/mqoiQU2guOr2C32syI91vFGU88MKAS4Hx2/uQQqiuKUWCi9xsKayeU
        hq6zJnF0dKUq7xhE1StP4JpXogSttpVqm581DTQ94U6UqI5FlUp+cxMXD4xh8hX4ft7H5p
        nq/bC28B45SZzg71KKTTAl2B1p/OHmQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-c0ZLXlULO_yIna453_KObg-2; Tue, 15 Feb 2022 01:02:49 +0100
X-MC-Unique: c0ZLXlULO_yIna453_KObg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeWLcuZj1ZhhtmhPPywgQ6HRVQxToC8/gYp5v0wHm/yIbbcH/lptNnkwBPl+3wW4G7LAh0P3MhIh1DX/O8xxh2q5rH7zJUY0PFMExX3JYjFWIFJZ1e7M3SfG3SPk33CIk79jOKqx4HMPFZM5uhhRIjkIOaqawzjcmUl83VGEgpwyBwq+cyXPnm3SV2bHODewL/y1JZ6A0rl1Emg5ep14HQzIaAg2aDJMGyjso4aKEsOSuaFotcJYlHWDWnynSp+vh7SzPAgE5cS8W6yMGqRwH2IXyrNC33kQgZz/o+kOTyCntjBV1NmFB3v0iTf8tF2KGii8KCZRQwLDI6t/iCW2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k72Ut7l9qC1I47OI/lDAXoGOj52rmFOH1/A4OheVX48=;
 b=bYAoy7NTcYSix05AjuirCYvjOcMIj3D+7Lx9borNeGahTYYpUnHebGeu1SwoBpRc8Aavyfa8Vc/iiPnKoqYUJv9BkuyEulh3GGDjIjRq76IUE0pEu8hOdP7th33LLOleTZJEazHVqJpGCl2b53XiKRDZ4wJgMZFkxxORkPLliJvOO3Mo0GV1Q39SaRTO72MPxSD7os233vk5ZmfE0V8VZE0ajA6OuaFb48jqnrN8SQREmFzmqzrQLUOIEK5JRjJBIHPa3fpKc3Dyptr/vmDPSAwbVxvre4mkqkkpRoygMYPl0zA1stePSlFftzFvuFjS6EtbBlV4MG+fydQbX3BRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR0402MB3506.eurprd04.prod.outlook.com (2603:10a6:208:17::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 00:02:46 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 00:02:46 +0000
Message-ID: <c372f57e-2ffc-6d6d-b656-5331464b53f0@suse.com>
Date:   Tue, 15 Feb 2022 08:02:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/2] btrfs: defrag: bring back the old file extent
 search behavior
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1644561774.git.wqu@suse.com>
 <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
 <20220214161506.GD12643@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220214161506.GD12643@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d76349-c0b4-44da-4b6e-08d9f0167ee4
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3506:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0PR0402MB350684FF85A1DBEB62E1D7BED6349@AM0PR0402MB3506.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHpVkXkuVhomoIgzkW9VmFxXgRDAJEp/Nn7bf+N2TG2cZDZHy2/ULRoeE4nDRR+O0WgnvebbSYW/UylbL3uQk+iHtaXjwFYbVKhdmrC8Xl9jvOzKpsyKWOUDOJdRRSg7fwpV7hCKFq2/lmVEMnFbjWLvRozhzeKBTwgCvMLndZhQ8NBYz4Fj9+tAfGGTkl8o5xCTQ63CRaeH4M+Sh4GENj2bses2y5lcEYhuRL7xkiaHOMP5eJE4Gu4gtgpgrdtf8nZtf54pypskQ+QF2ufaI4pogYc04I0HEoFXR/4EJvCXKDNcAbQTqoHqxY8WOPm/b95uLR1c+iXKTSGUl2Wh/ggZ74PJBaP8vYGf7n1DwWNRsPFTtjvsC+/QrsqNMBxDFu7ivdrLj+Hj9Jpfwni3pWEQTLYJn800Uu+Nq/3Ei/IYUEIHpRcYuA2eafkDM/PxlNdy+hXk+YyopSF5k753TfiMZvbRmqwK0t13JlA33VgQZKC2+4R3IuIjHFQagBA13cABUmuDNlX1KH7GNcNyiqFocjWSjIAUN00cUDJn1iFbWOS4sgDIeSmOjdcKYTFu64DRERLQYcTJrtXs9lrIj1cRyxyp8rQTxjbg0fdm64Z1eaVRGSJP45014az519YDwYAD6epoiZsUB2qX0jO7lgD1JbdXGCFGKqXBjZiLXbIxRF7XDrKCYS/WPGOYmnbEU4ujBoe9tUiYZFT+SPLXDluY0IRNm+w9n4yM1noIwqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(26005)(2616005)(186003)(6666004)(6506007)(6512007)(83380400001)(53546011)(66946007)(8936002)(38100700002)(4744005)(6862004)(8676002)(316002)(6636002)(31686004)(36756003)(66556008)(66476007)(5660300002)(37006003)(508600001)(31696002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9oRmJOb2RBVFE5M0U0bVhOYVFwa3VBRGQrMlR5WU5LMW1NTEZqSksvWTl3?=
 =?utf-8?B?eFQwNTJTRG1zZ3hIR1RpS1NCQU92anFpQTBhaGoydzRKM0ZIRCtSOHdNb25N?=
 =?utf-8?B?Z1pqOXI5WjI1YjVzY1Y4Uy8xRjM1VmtDeHJ3UHF5NExSQWVrY29iRHZSZWF6?=
 =?utf-8?B?enY2UHhmQ3RmbXE0UVBaSTRwM0grVVZRcEF4bzdXTUU4R3lYVEJ0NDZFUVYv?=
 =?utf-8?B?MVUvUkxPUFRoZHlzakgyRHZ6SThUejZFUVp6M3ZzNXdTQWRNbnB2WEpvSFZt?=
 =?utf-8?B?bVJ0dzdXWG9qMkVnRlBSQXNhZS82TCtlQW5pdnhhbXZmRjJnTUNqNkM5MDV6?=
 =?utf-8?B?dnVET2drS3pxT3dDYlNCckhjaCtneFBZSkJsQjBLQU0rMEVGNjFGenFkNERh?=
 =?utf-8?B?ZWdRSVVZcitNZ3RkTW9pRWR3UjZkTzUyTnkwSGJLWmw4Z2xLbVlnMDRnTG16?=
 =?utf-8?B?ZEhETUg4eFpNZ3ZVdHZWYzBockhxd095NEZ3U3VRVG1EaHE0enAwMU9mT3hP?=
 =?utf-8?B?Y2ZUd1BBRDBMZzRHRmEyWm9PYUVIa2FQeHk4U3lqc3dqai9JaU1xejErcnNO?=
 =?utf-8?B?bmV3aThGeFhKZUs5Qk5rQUduUmtGa0JFWnQ2SGdFNlRIU2dNS1NvdExwSm1P?=
 =?utf-8?B?Sm9NbXFHa3pHSmY5dmxIc3NQTmNUdkxuVEx2ZWlqK2JCSHZjSm5FSG5MeFA2?=
 =?utf-8?B?WDFSRThZMVR3UFN5MmVxNGRIdmZqZC80SXRJRlFETVdYYXg4aERQelk1WVdq?=
 =?utf-8?B?VG5RemNicXQreGJUdUJYbXVxZ0FidXNrNGMwL3VkSGhZQUVJUXFhVVBZK1dt?=
 =?utf-8?B?THlZNTkrSkRNTlJTTkdqMHFYUzlncUtwZ0pIcitUSktZbSsxOUFSMEhNWHd3?=
 =?utf-8?B?UGpMUEdSODVqWmdYMzRIODJXQk5KQlZjQmdZcWtKR2E5M2d2M01EZHE1cXU2?=
 =?utf-8?B?NzlYU0xsK0I5SjRIcTFyYWtGTk1FUVRPdUtmOGtQUEVRWWhOckJtOXZZUlRE?=
 =?utf-8?B?dHVRaHFaYldFSWNwb2UrcDBZVXhzUlhkRkJ3cDdvSk9xd0RRTE9zRWtFaUUy?=
 =?utf-8?B?RURqWnN1REVYcGtoZzR0Znk5SXEzOG9EOENkTEwvL3pwRngvcktBaFZlY3dP?=
 =?utf-8?B?bFlaOEppc1FlYjNVQ0I0WnVxMExTdUlrNCsvSGVWeGh4dndwaXR3c3pnRVZw?=
 =?utf-8?B?Slg5VUdZUlJtZzlvbXkzZS9zUUV5ZFk2TlVzeGlkaXg0TVZuTERNT1RBVVBX?=
 =?utf-8?B?c0xtRVhOOVZkSXpjcGRab2ZLVG9BQzNveDJWaHlBclI2U0o2N3FEN2pWS3Yx?=
 =?utf-8?B?T1RvNjFTTnNUR251a2h4Z0svYXJxWkRuTGNOaDhSa3ZETmMyTUYzM2prMkZ0?=
 =?utf-8?B?L3poWkNVNVhlUVc2S0NTekJ5ZUgwd0JMTmtUSE8yUTA3a3BTb3A0WFlXYmxy?=
 =?utf-8?B?a1diVThIb054RUxYUTZKYVJPRXJyc1pVRTd2Z1lidUhkampyUlFGcGJEZnho?=
 =?utf-8?B?MjlyNko0M3hUS20zRUFoT3EyK202bzMvRlZsYnhvWEhxWC9FTmFZbVJCUitq?=
 =?utf-8?B?Wi92Mm80dk0rZVNDNUx0VW9iMVAzT2ZITlcxZWVENTB6NVJwR3NabUNKbDhQ?=
 =?utf-8?B?R1pVNlFzNWhkOHF5ajFraXArcExVOGdraXZEcHR5TS82RjlPYjc2cFIySmlv?=
 =?utf-8?B?V01oQVphS0RLa3RmQ0N3eTJqYTVvSnFUWlpHQ2JwUHZQYkRhZ2d3N2gvV3Qw?=
 =?utf-8?B?bWU2ZHJIc2lnYUZlNlJDWkFBTVNNZFk5K2sraW56eFptUjJYZXNoUkdmUG5B?=
 =?utf-8?B?ZTZBUDkyRDEwU1FKcWNoVytQU25KMkNaOStWdGFzc25TV25EQXN3UUp1OE1P?=
 =?utf-8?B?QkxzQnl2bnRySlBiRklkeXFLc3dtTEZXdTB4bUU1Snhka0VsK1V0L0RUdldw?=
 =?utf-8?B?djJsQlBoTnAwak53azZhOVhQU3JvQXhFRURSYmhhQ0srU2cwS3FzbnFoRmI0?=
 =?utf-8?B?UTZvRzROME1meFpNUGkwbm5CRDd5YnJlalIwOXptVld1ek9seXBLcG1adGlT?=
 =?utf-8?B?c2VWZUFudnJ1STZhbGJrZG9IeFVheTVweGFVdEwza1VkL0Q1b3Z1ZlV4OFNv?=
 =?utf-8?Q?iAtM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d76349-c0b4-44da-4b6e-08d9f0167ee4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:02:46.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvYnSHig/FV+pWsQow7sYhxzwjepaT2SQG2DHF7E8lj6S8dfEye9KNQgJJSdpf5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3506
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/15 00:15, David Sterba wrote:
> On Fri, Feb 11, 2022 at 02:46:12PM +0800, Qu Wenruo wrote:
>> @@ -1216,7 +1367,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>>   		u64 range_len;
>>   
>>   		last_is_target = false;
>> -		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>> +		em = defrag_lookup_extent(&inode->vfs_inode, cur,
>> +					  ctrl->newer_than, locked);
> 
> This uses the ctrl structure, if this is also supposed to go to 5.16
> please provide a version that applies, thanks.
> 

The conflicts are already smaller enough for this patchset and later 
autodefrag work.

I can easily do a manual backport for v5.16.

Thanks,
Qu

