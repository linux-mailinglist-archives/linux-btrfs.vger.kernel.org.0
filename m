Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270FB262F9A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgIIOMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 10:12:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:29609 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728709AbgIINHO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 09:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599656830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xzSIPnL7YJhCD15j+wfZDXbEk9HczDdZCz21dw8WNY=;
        b=PHzXJmLKieNWJeGN/uF2NYXp8QeG4bBHs+akKWYDOIftj2LYUiOKJhV2jTmAfXYgrNK9ha
        M06TGHXeZ+vqOUVgaK5SjCQGhATDyEMtLHr26g5870Wyy/7TeYGM0VpMQrvavNpmMZ6+v/
        1DRKIX2J5uUxCa/hCmH5bbKWbaMNRZA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-q-RSFZ5vMWOl6O9UqZvTQA-1; Wed, 09 Sep 2020 15:07:08 +0200
X-MC-Unique: q-RSFZ5vMWOl6O9UqZvTQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9OIJ16rEb2RYOIhvud+BcHJHjYNxFjHJDxtChNFhlj6TNXjQqQr6qu2sS+ZwmkQb1Af1P4FZyXet7ixvKQo07tPBZV5N2ED5Pq4nTyp8JkuFxdQY0lL8Mku/3CRc6iMM09Bs6a8kVeM+prdbbxtN8senln2BmCtjN7gfNxOPa68EBdL+1peOlH682wHkPlQu6cKu7CeOwgh2O63lbfFFY7y2WPLtdf05A/U2QpBZBthZWsyqkpgr1aP35gMztzes8glE+EkRZGl4u5E2H4a7GtuaX4tK+uxEVLKQ+ocdeVFoPqNuQisv1LFirI7Cvj+SFCwUkHwjcTVu3XDBRqHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOkdKM0oauxmlKWVFMnsrtUvpjvTdCFUE9jwwu2XvDQ=;
 b=kTgxTBLapSkfUfwJud/YBDJ1yDQNTTTkKHmbUoebn5gMGiHrfo/lfpMJtnO+Xs2U2VQ1EVhg/6DbPxx0OKvewMll5MuH+XT0XOTiOlBpyvbwpm/dK3qn5USuYaIHOKJs85uD1x7wdBcJ6peybNlw3YA/ZlUt26gy/CRc8z0pLvwXYDet2cn9XTqTQV6J5gHqp6+VwhHgidVIT4qkxhThdjqviqyF7nOYQm8imH3gy/sPNarmEpet8rxMSVIbCqsLDIXyJcn0FPzZTjxeBAr9AIcDQxqWiPCyZywtTuATXm6vOK5DI2f3o+cw1DQEAS/sJRaOHUZglWA37fTKmeAwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3844.eurprd04.prod.outlook.com (2603:10a6:208:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 13:07:05 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:07:05 +0000
Subject: Re: [PATCH 01/17] btrfs: extent-io-tests: remove invalid tests
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-2-wqu@suse.com>
 <13209d17-01eb-dd25-d435-c56746d06f96@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <a485ace8-508d-c055-d121-c9c2ae72dbb5@suse.com>
Date:   Wed, 9 Sep 2020 21:06:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <13209d17-01eb-dd25-d435-c56746d06f96@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:07:02 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a249b6d-70c1-4706-7fa6-08d854c14012
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3844:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3844256FBBF064DCB8A4706ED6260@AM0PR0402MB3844.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiPMJfckr8dr780MFl/WGbkp2mh8Lx7NMz7HmYBApTYaqSs6NqSv4dfDe4eh8rP52I/atMoIOVHEOxA/8RQkpyMZieTYS1QsvrlPglnSIXMBX9W6tGLrB0RkNSYOfmDeqyDYYwmSHRG6jyh+xDo7Ynz//xQWWBOzb32KgvjIZl++jvJ3PLetJNigyM5naCtCWPecZT4qsqKJAV6JbBTLtvw7z78Xs2E+tvqrZg5EDZZUoIwNCVllhcFm1lqkmg7qACRZumTEOzFLWxW/Yelm0blaRrRsgTAYlrPCh/LwIu8iCgyf4dAG6RFFXPghh4Gb5VqmB5r02dABdrs2lE6pHke0AwnCrK6ugG/8aat78s9LklxH99NEmVpnX4jvjruoZQ1jn1ewTUulbAR4oeN3286a6yz2ZSbOFg/0bOWp2rA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(16576012)(86362001)(5660300002)(66556008)(16526019)(66476007)(478600001)(6666004)(26005)(31686004)(36756003)(31696002)(83380400001)(2616005)(956004)(2906002)(186003)(8676002)(52116002)(6486002)(316002)(66946007)(6706004)(8936002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2tAOl9JMXmWPgYsm97CVlhmblJyNIIRRwvaI/481szrfe8JveadrKoLE+weqtFYQOfTu6VJGMr8qDEABYFT/Rn14PSlCPSrsyr06GRxAGHwtOyrX5/UkuDKSngQaskU58bUzIf9T7jpBFlTL2IGFLJUrAG/9xXYUKo8U8cfTsadLacZ6F/bJw0L2qPDdPxvV2rm3oTAGccACwlukM2vruL2FfLNjBqdAQYNF2nWUcuZFeyW+dMkyx5Y+oZxIPLjNEddmcOXspMWHjnF3ArS7xpbI5MCyMq8b0CxWup5oVteWuyjhqSXBSg0UkkkESsD/njT5G+sD/aZxzcwT3NKYZ1sGpqRNwGU4oQs9yuUxvqnWuvP8hSSuIC2CnXV+Mb/I7ipdrV70rtvhB3hcNGvMQ7t5fO7knzaIy1xkyG94MIhXUqwirjqnsUIo2PGasNZSkzZLJewfqYNTxets1YOnxy9oUDrS8IzMdt7DPs3y/zICIaX8tva05e5uK+rfk0aDid7Mgg8ZDemdcPR/FxCc3V5tDhKk36AB5FTRwNWpH8wOgh6u9A6eq8/3g5C/fd0ahgchRkT4g6L7TCpjnqj5Pvpod/c7J8vDkCJDxoZNkOA6Kkj1LbrRMFvyQ49YWxtfT1IsmV6mowSSutwv7WbUQA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a249b6d-70c1-4706-7fa6-08d854c14012
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:07:05.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwLCrrBz3uY/aVSqLjkXoj9hNf9FS2lTldLoV9b37LG/nb/iyT4YlVEOFwj97nHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3844
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=888:26, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> In extent-io-test, there are two invalid tests:
>> - Invalid nodesize for test_eb_bitmaps()
>>   Instead of the sectorsize and nodesize combination passed in, we're
>>   always using hand-crafted nodesize.
>>   Although it has some extra check for 64K page size, we can still hit
>>   a case where PAGE_SIZE =3D=3D 32K, then we got 128K nodesize which is
>>   larger than max valid node size.
>>
>>   Thankfully most machines are either 4K or 64K page size, thus we
>>   haven't yet hit such case.
>>
>> - Invalid extent buffer bytenr
>>   For 64K page size, the only combination we're going to test is
>>   sectorsize =3D nodesize =3D 64K.
>>   In that case, we'll try to create an extent buffer with 32K bytenr,
>>   which is not aligned to sectorsize thus invalid.
>>
>> This patch will fix both problems by:
>> - Honor the sectorsize/nodesize combination
>>   Now we won't bother to hand-craft a strange length and use it as
>>   nodesize.
>>
>> - Use sectorsize as the 2nd run extent buffer start
>>   This would test the case where extent buffer is aligned to sectorsize
>>   but not always aligned to nodesize.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Shouldn't you also modify btrfs_run_sanity_tests to extend
> test_sectorsize such that it contains a subpage blocksize? As it stands
> now test_eb_bitmaps will be called with sectorsize always being
> PAGE_SIZE and nodesize being a multiple of the PAGE_SIZE i.e for a 4k
> page that would be 4/8/16/32/64 k nodes

Not yet, currently since it's just RO support, I'm not confident enough
for the set_extent_bits() path.

Thanks,
Qu

>=20
>=20
> <snip>
>=20

