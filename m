Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2141BECE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbhI2FnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 01:43:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:34435 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244246AbhI2FnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 01:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632894080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z5prIbsHlk8hir4Fu5TmYsEobtAF36P0IaekN3Bjyns=;
        b=fS9lVKNrsbeObYA+ZPK1msVetu83oiQ6WcQ0ZNPulXmSAP+4FDQ4shv9pF2X5L7nCzTiNY
        B6M6+KhWeZy5Gn4EmY8aozlfdXOuEAoRA7TZ0r3O0VTBOTpBjsxjqRhp0sP1QtauyJFkth
        N0pA5UwbPG4EatQnakuPiBTquGjSMoc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-ClqbkptcOl6kIIuanmdUFQ-1; Wed, 29 Sep 2021 07:41:19 +0200
X-MC-Unique: ClqbkptcOl6kIIuanmdUFQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZdVnhyaIclFHPThXiHgpmHewizRyu2St2ZXMmVog+LaapX9YXPEW3C/4vkzEmT6A8IdDwcAiD2Af9TSouR6eb9FaQ17tkbZ/xesWQJw89kXHCJSNKaZva3ssNV3WSuoPGI/DqdvZmJEH7Ckrca4ZMJey4W3Es5jrZLlHeOnwuX3RrbX8xHCEXUpEQPPrAB0/k9pITBQ3sLXn21qdmPgRWK7jvxQ7b7a+Ba1YBMEwRSpU67nJqJTYlmQFiHspR+Hzqta13aWeTBxx/uzSAh75/ir7Ojtk9/8kMrUUyrHznLxtheRgJe2QSDsFH1LH0jS3LRtNJnjCF8o4kLlTIpHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Z5prIbsHlk8hir4Fu5TmYsEobtAF36P0IaekN3Bjyns=;
 b=n2OGecy4GulmMN3Jgr5QK2vxovaX1x7fx6CVqfsuT9A7jyM+ohewDJ5HPpmhEA0WMunVSfmr9/mC1cHVRyJOfcCFRvr+JhqhtIYUM1mAhQlrT59LihRuDKKj7Ux+xgEzHmBBAVCJbga+p+UW2lRZ5AmonSrVuGhJGNIgXXDc8BzeTgjInLylAZ6AoveF4vP+RzVTLXiOHtJhkqeVk654MjVbhH5g4FIQbesiHUbLMV9QX2Wr05rAIeyhzmBIIdf2K3hCbTvss8cfN12raTdQnm+MMd4cwUPs4Qv+LuLjkkC4jbOUBEABPa3wEk5LQ9tPnNLUhZUTacD0VP1DDlnpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gnu.org; dkim=none (message not signed)
 header.d=none;gnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5703.eurprd04.prod.outlook.com (2603:10a6:20b:a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 05:41:18 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 05:41:18 +0000
Message-ID: <d7af6d9d-7178-f950-1934-3179e001e291@suse.com>
Date:   Wed, 29 Sep 2021 13:41:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
To:     Grub-devel@gnu.org,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Subject: About the code style requirement
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::16) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 05:41:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe577dc-ee88-4885-ba7d-08d9830bc24a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5703:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5703648758877D211E51F74FD6A99@AM6PR04MB5703.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlVZ9P602YMCHZ+plqsDXiRvXTcKEPKtAi4oCrxCKtVj9uGqea32lvE97KRc9EfKIAP8HcvrZ3/ufcVjO3m/9yw5dO+oJal6hbOpLPv1ScbfUw5qHEJHonSKVRs0kxOav7pBGYBgukJp37zoPn0dB+YmBAQ9siJVODpdOmJhDZkPY+a+plpFRbc/BqBHNUCEP526PN2/rkkLUFRZBRK9D3UG/eJM8egdJTygjdgOZsSUNL4u7UmisHqr4+42w8VzNdBz9is+y22kH8KHG4dsTSCF12R2sJbf22DaQa1BU9cLrTCMwV4m2WvsZ1I9z6nEjoj/g9JO2dmtGB/2G9PJZrUY4w/DutRnoxpSMyWjY4vK1UdANIXYbHyBQOexGNcM3oV6+jQbeuCLTSQPGQHjfJ2kC7Euk6CV6BzjGUET+VSAg4TmecLIxC3GOKm99fwNTdERWJU1O35HLErIgWTSPRQezEJhL/m6ER1sgz2FtiLK1iOLE8s5JyRnH8YGuJpvSTzV11YnfJTqNf9sr2XbPfaVCktAPQ08FzOCQhkYGmMJ6rGYGyI9f25tAm5X1RSwOYGOw3vpdHv8jDVX+kR2Xdhg9PIqaOv3GzLgtW6xXLOCWAvIG7fwJzyLLOUhMRHRuNxnnSejf8/Ks7GufMZhPp0w1f1/+FUTenuXhidwzYYbqct7GZCVnWULLSaAvy7Fl5zzfD9TP/0b0mPaAUSC6lNTGhKjQ6nuDoP/Uqq/Z27n1YSwGvUzBN45U8PG3xfA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(6666004)(5660300002)(31696002)(8936002)(36756003)(8676002)(26005)(2906002)(83380400001)(186003)(2616005)(31686004)(508600001)(6486002)(66556008)(16576012)(66476007)(6706004)(6916009)(38100700002)(316002)(956004)(86362001)(66946007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JmcWpQYXFFRXRBMmYwL2xoR1lkcTlVMEpMYjRYUVl0WVcxTVNTa2JMNGhr?=
 =?utf-8?B?aGJyR2dLQUlRUkVLWnRhYmFZdHRYNUdXZko5WGxxYURWMEx1c1AzZXdhTjN4?=
 =?utf-8?B?Nnc1WEJFbVpkaE1TQWtzQ0dRRHhOWGdYN1NsZUxCZnVPZ0ozVkxuL2NDbFBn?=
 =?utf-8?B?NjZCYS83U2MyeTNYMWhTYXR0WUZyK1ZhNEV3N0krSzV4M3VkQ3EzTTVKUW9O?=
 =?utf-8?B?N2JSbHRzZTJtK3VYS3UvajdOZXI3SkJoSFhNS2MvUnJXQWlMNU5SWGhjUnVi?=
 =?utf-8?B?NHpHclhCeEZrRG13b1hIMWp0bnBOa2t6SXlra05ZRXVNSEVSNjVibjE1Zktl?=
 =?utf-8?B?NmxZNDM4Qm02MGFoWTVXeTQ5TC9TS0dFTmhzdXZQUUx2RDFiaWlwOE9HbFph?=
 =?utf-8?B?ait6OU9VUnBKZWtjWTF3cGtqR2Y2KzhndmJnLzE2aHZ6b2FVVzgvVU9wS3oy?=
 =?utf-8?B?T3lwWEk1V3RON2UxSzFTK2JqZURyZGhta2JCTHcrMW5jd01hNVNhS3RYZFlV?=
 =?utf-8?B?TW1TU1JWWnVkNC96MXluQjg1bnp6QlZqSFdqRnZaZkdGZUZTMnFseVB0TDI0?=
 =?utf-8?B?Z1R4MlV5VnU1K1Z5ZGx1d0JXdWFzSFJ5cHhHRTF5SEhEMnlUT0pwUGduV1Yw?=
 =?utf-8?B?UDNLR3Q1ODhUQnMzdlYrRXVoSzgwSm00cCtHVWl6SDRSb29Zd3VhS3puYXhk?=
 =?utf-8?B?aE9SMkVGdkFYRy90TUQycVpNZ0NId0ltOXROYW53d2hZRDJ0OHRWK1NEYTdS?=
 =?utf-8?B?UVA5S3BBT0NlbGk5WUtPRTE5NExLZTBTZ2dKS21RVGlpdDhtZHVvSkQ2a3l0?=
 =?utf-8?B?K2lHVlhnb3F2STYzekJOMnFmVVNKNWdtWms1MVNQeE5zN01wNnJTS29jQ0pI?=
 =?utf-8?B?MVlZMTlmZFJsL1F4aGN1WGliMDF5ejZEY2l3bjFBQnhoVWttdExBQUJxQ3Vh?=
 =?utf-8?B?dWZSWUdnYWdwTUxyc29NTWdKZ3IrVTh6UE5UeHplWTFLc0VoMmU4am1zb1Ux?=
 =?utf-8?B?ZS9Ca09VaTlXUUZNMEk1Q0FobDQwdGMvdmtaV2FxU1F1bE5CMlppU21oTVJi?=
 =?utf-8?B?T0hqUUR6dSsrVm5rMWc1RUhUY1hMaHA5T0svaS94cFA5dUMvR2t4T3dvamc2?=
 =?utf-8?B?Wmxrcmw3LzlEMlRWTTNYdTVmeUlIMDVTR29WWXlDMnRySHZzaXNnc2JwUllO?=
 =?utf-8?B?RDNQWktaRzJlSWpqODhnNnZwYitwWU5mYyt0YU91bG9IZENUZncrM2YvVFk1?=
 =?utf-8?B?dXVxZytNa0FMOCs5YVpMSXhIV3k2U1NOVXphZ0FKamRjTlVjRWZsNysrbms4?=
 =?utf-8?B?eEk3WWVxRmJzUEFCNTBjYmRlYTdlQlEzeitQRVJBVG1mNWVwTVpJYit0RzNI?=
 =?utf-8?B?ZDFvQ2ljMjdDUEc2bEdzN1VIVk9pdVM0TGFZYzNZNUM0Q1BybXNXckNYbmwr?=
 =?utf-8?B?UHZuUm1McjdRMWkxVi9lQm9GYUpHamlOVU0xYSttM2k0WGozWVpueWp0WFJl?=
 =?utf-8?B?RnlydFVjclFtTjhQRHh5K2k0d2hBU1Nwd0Y2TzhLUklCZGR6ZDFFeGp6bytk?=
 =?utf-8?B?Wk8zdjd0dnh3T2xxdXFmK2x2Wm40aVpBR1RMNlZ0YVBud2xjZWErOVVhZmgw?=
 =?utf-8?B?T0xVWDhZTEhVblFFV05EOUVZaVNrUmpoTnlVRFhPVEN1RmFjb2tweDZpMUly?=
 =?utf-8?B?QncyWHIxT3pNRHk1MnAyZ1pzOG9udGtkTWREa3dCRExvQWxISVNQK25WbUJ0?=
 =?utf-8?Q?TNz4thIhqRzWEVveYmbLfP6fcIhGwY+KzYrJgvn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe577dc-ee88-4885-ba7d-08d9830bc24a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 05:41:17.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NI6zWo0gb9DdKExLAiDilnHQ80ZtOmAZjIr8GuJmoCVYxrjf6r3hSWHwt6Q0bJ/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5703
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm recently considering to cross-port btrfs-progs/U-boot btrfs code to 
GRUB, so that we can have more unified code base, with more features 
(and of-course bug fixes)

But the first blockage I'm hitting is the code style.

It looks like GRUB is using its own code style which is not found in 
kernel/btrfs-progs/U-boot.

But I didn't find where the code style doc is, so is it a hard 
requirement to follow the existing style even we're cross-porting most 
code unmodified from other projects?

Thanks,
Qu

