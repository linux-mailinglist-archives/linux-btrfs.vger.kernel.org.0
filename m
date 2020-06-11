Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B01F5FC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFKB4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 21:56:18 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:38475
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgFKB4S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 21:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIQthoILRm3XyuK+9T4rZhIFHhQnvGCnXLxb7CLeyUG5QbbzdnMgeJZC5oicUC98nhHCo0VlYqMlqjiQeDvlPw6MsLM4kSxcBoLd/xuMtyZ+imA97tHZU0nCdg98XadfUakcL6FHfAoFRav8LCRzLYREv1aHe1uBMFuK48jdbFLj20cZIW4Bt7oezFXXdttkieyotxHjXHuiMs6/Z3+yBh3C8EMBNwjS2NmTGSScTSxbeP7HE8O2+G6iFf0oXIK0QXYSCqpFloinzJxzXUiJrVprEC2PEnBuxUQ0Pin6bH5tcxXjX/ahca0Gugt6SXo/uLVRkHwjfOrLudhr8bsvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwsaxyKR0ZvkH4sS+v/SZIuMlv5oi8gc4JSBDfpXBZ4=;
 b=EqJVOvtcuDPSiRQy+O54wvjOK2QFdE8xIS7AyTq/pP0/txZeRx9ZLFYniipNnj9CkHskGCxWjGoqTVOS1KxgMvEyaRhVeDFH9+cekWlmeNtY5aSYR4tzt+RqcsxB56jstTlN/gmZBfSFkwanHCc5dDJVOtftcNVL3JN3fy3EGHPSUtLDBdNia3kdkBKaqSpuOoM3Kn8cXckdqI+4sVuwufgHubCTrxPCjuvZ0sSMogVunRl9/CJm3Cr/+ALD0YiRSa1alYPqLmVLucP6a7nkuIax/xORs7wIExT5IrkagooCcxEzDfE6+YdlxvzSb5+w7zMb+TiLkTtfQT+3UqtBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwsaxyKR0ZvkH4sS+v/SZIuMlv5oi8gc4JSBDfpXBZ4=;
 b=UjnWiKaCAW8YXaGjFpj8Yg2m6NmIgYB6XYU7kqVhhKMV1QQu4GktGwjFGQQwFrUzo6Z7gnDbICs//u/ffISbzJDIo5O6euqRdAVUwdfvMAKssfHj3pP/8pbqpAlqXzuw6IRlT+KuhbKZOSdMKMV+AR5tO7ATHJwJj31Eh30ynsk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5302.namprd08.prod.outlook.com (2603:10b6:a03:49::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 01:56:14 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609%5]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 01:56:14 +0000
Subject: Re: BTRFS File Delete Speed Scales With File Size?
To:     Hans van Kranenburg <hans@knorrie.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <11bf6ebc-27e9-cc89-30f1-529f4caf11a5@panasas.com>
Date:   Wed, 10 Jun 2020 21:56:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
In-Reply-To: <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.20] (96.236.219.216) by BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 01:56:13 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cea4fe5a-2379-43ca-557a-08d80daa9f0b
X-MS-TrafficTypeDiagnostic: BYAPR08MB5302:
X-Microsoft-Antispam-PRVS: <BYAPR08MB53027619A0AF98C5254C0A4DC2800@BYAPR08MB5302.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQPLxe+7D2G17XohTE5UwQ5SRykKyAkwqx5evixLxOIb1O2Oz2sCE60nsySMTrAhh5TCKu2/oFfzKgfM1LhZ5M07hMognEAMQH6yU0pm8acLwAd3jAAwIo9lmDNQbaD0YV9xSyz5CTU9BOJjrt/D37Fh7hYXZF7JD53OW/Vvq0EgjP4yYchLhsGx5Sao3Fjk0BON9NkwFSPbCCybG9tatp7FYgm20pa2vJlLTaqK0oEH9+TnCmuW5m2QLFQnFBf10WauFRKq8TCA3ICORnsjZSzhuTqvmSMA+p7SNqB0sPMkcIEYlFKtWenux9wOED6IoRV0naTOw7t2BGXbqBjSjLgflOyDwnE1cOcN4LqjnjTqu55GMYCyr4sQnQeSxK7hFBO2p7ch4I1Iz5AClGjM9kJfnacykt0vKv9SGQBtDmsrgjZOpp42mOJZGiLMJtymaYVbfVuNQeCmRD/rK8hB3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39840400004)(396003)(366004)(5660300002)(66556008)(36756003)(53546011)(66476007)(26005)(83380400001)(66946007)(86362001)(31696002)(186003)(956004)(316002)(52116002)(31686004)(8676002)(2616005)(966005)(6486002)(8936002)(110136005)(16576012)(478600001)(2906002)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1UXESomD/Q0nC8KIoXN2D0XPnRnd5620Z3LPrPUH5PjYPqZRMlpQUqQb55HKOrLAISJ5/ePcUiltOfJ4FtXKamihHxi3sgfdazrZ1o31HOFnq+h/Z52TZmC/khULkIuB7LNQZWE1EcUYpFMgj0U6ppf98OkmC2B7ey4yAKnM591RUAtOy1PMaMff//wCr3ak+/+x1gfSIvdKag99j6mqRHda/raT6Z+Yy+vabuYzYuk71ONKP7RSROB+bI4+2OwlTZU78wkrz87/ff9k/49EHx0iepsYDG7ZEr/vI0VmHixDj1pbLirNTzntiiL4GgsHGG3tsQbsNkGbD4ugE2jtz7R4et+WroHekS0I9XzUUof9QfsWJMEt38SOsz5FQr41+JM92Dj4f8Xk7VPKC1+iuE7vdbDb8oo9P2vJwYFhj57G8gQX0q8xy9okDolQXiWxBnJ8kivNLGwVAoYcNZhkXSlwnM3skY4kvqzS0m92H+iNv4oALKcpCNLmrcZujCBS
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea4fe5a-2379-43ca-557a-08d80daa9f0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 01:56:13.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX5aXhzTVwocH4RY0dqSFRPvh9VEOJGBuOg/ikSCZBw8NRx/T5ZQTAiH0eXGD8hU3AU+RSsVgyXAwJm4Kdugkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5302
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 7:09 PM, Hans van Kranenburg wrote:
> * (not recommended) If your mount options do not show 'ssd' in them and
> your kernel does not have this patch:
> https://www.spinics.net/lists/linux-btrfs/msg64203.html  then you can try
> the mount -o ssd_spread,nossd (read the story in the link above).
> Anyway, you're better off moving to something recent instead of trying
> all these obsolete workarounds...

I forgot to respond to this in my last email.  The version of BTRFS 
running in my openSuSE 15.0 kernel does indeed have that patch.

Nevertheless, I tried with just ssd_spread for kicks, and it showed no 
major improvement, and had the same growth pathology as past runs had:

0f70583cd12cac:/pandata/0 # time (for i in {1..10}; do time (rm test$i; 
sync); done)
real    0m0.636s
real    0m0.649s
real    0m0.417s
real    0m0.562s
real    0m0.381s
real    0m0.949s
real    0m2.014s
real    0m2.129s
real    0m2.074s
real    0m5.114s

Total:
real    0m14.939s

Even more curiously, when I repeat this experiment using ext4 (lazy init 
was disabled) on the exact same disks, I see a nearly identical slowdown 
pathology:

real    0m0.122s
real    0m0.048s
real    0m0.075s
real    0m0.076s
real    0m0.100s
real    0m0.499s
real    0m1.658s
real    0m1.709s
real    0m1.716s
real    0m6.599s

Total:
real    0m12.614s

Very wonky.  Maybe this has something to do with the mdraid we use 
underneath both, or maybe it's something architectural I'm not 
immediately grasping that impacts all extent-based filesystems.  Will 
report back when I have blktraces.

Best,

ellis
