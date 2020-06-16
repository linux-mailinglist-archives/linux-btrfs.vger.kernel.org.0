Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6210C1FC270
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFPXtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 19:49:55 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:50282
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725849AbgFPXty (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 19:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6aNE4IVrQHpLKtSMeqz83AaV6N0tjeeyKSP9V0AtlCvRtDwD2k2BZIt9KtWB5ZdcX45jA0K9Yowazhcc7YS74O6PK6fyOGTRkm7vpAxD8wtVtf45/rqa+Wcam7L2ETOrEdzD/aFmVhryCUITcuXPzk3utM1eiPGWeFc5sMJD5Zk2+bcVNlSm+L+Sm6jlhXsqmhjUt9GHJqC2yyG85XggpIMp1Brg1PnkwAq4o/u0shHYeiM3Z0rDV2d4HTHahLPQzSC5RiwBNhiXb8y2O8niEiMhXd2cOQT7nSn7LFfckj8MmaH85tHrM3ZvaytJTTAlX7IFlSCJt29R3BddyX8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ybSLZMWU4Eu0SL8bZHWQAJ1o5moaPePklDSJbrgxw=;
 b=mgSXW1WZ3K2qHXN4UZ0k4m3qTAZF5HTmZcsUCSTPstVSoyz27OuXJyKjRI0AKZLD+C4vX7KEwfry/3fZGCxmaPxuaDno/dnQTyCH6sSc8pcOwgSAYvSKM7kKnZ2P0E4iZi+iLp/bNc+SeXSDIhJmlYBSnLuIp6cEbWDSfWiWRVCJg68b733zWGYh+Ik8199xvf4OHc93918fUodJPdiCTE/URTLJSJWJC6gpU3F6iR26IAr+u58HQjiTFL/1E5eQl75mJsNpgxbj3hubsb4upRPnMDEHjU1bG2I92Ys8SCmM3/nUl1FiXsneR5c/D+rBMtwnlrxygThZftIGbzFlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ybSLZMWU4Eu0SL8bZHWQAJ1o5moaPePklDSJbrgxw=;
 b=kg2zQhN3uJkpsuDa0JzC/rT/bkH/OEGq2zwsYihuI8DZev54CnJgklaKRX0hnxK1TbCWtpPjZm6q3QO7AMHah9IJUq6L9qM6TK9M6J34bewsm5NAYbvd2ay4JuY+5IBO3/OqFVcwCmQDyT4bvnc/IQ7bDq5togTUPKTeH8Qz2nZs9hOfgXlw54f/QT29IuQwFQEtaNlT4OwaVEy4WqtULjjHCFOQSg2XXzMxwJeEvBAoYdvi9hdxviuenqkzs+dGw8sgmA9mttBLmDNdX1dO3mLcBCPba/sVFyxLQWyQ0OdpylsBS2cVCAlbrepiljQlDQqBXPIlrMrqj2oFhqkz1Q==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6241.eurprd04.prod.outlook.com (2603:10a6:208:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 23:49:50 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::3457:290d:6345:6961%7]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 23:49:50 +0000
Subject: Re: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for
 user visible subvolumes
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-3-wqu@suse.com>
 <d17609b5-ac29-937c-763d-fc978e3f1bad@toxicpanda.com>
 <f1f940ba-3f1d-302a-0d28-5620286bcdc0@gmx.com>
 <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <0e274dc7-ac05-078a-2a2c-348e72745d45@suse.com>
Date:   Wed, 17 Jun 2020 07:49:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <a7417666-56a0-be6a-1691-e647802e1df7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 16 Jun 2020 23:49:48 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ac32e5-9ec1-4e70-448a-08d8124ff540
X-MS-TrafficTypeDiagnostic: AM0PR04MB6241:
X-Microsoft-Antispam-PRVS: <AM0PR04MB6241079E165854FEC687BBADD69D0@AM0PR04MB6241.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm6bkSKICycWiCJ8/QdulKjAwzS5LweWglD1QScU6MlFiIf91/e3pbVckU/5cC2a8F+f5G/dLu8TG14x8d1xLdkL5GXw9i8FZ+4URVGLbXdu8k+S9Iy1TxdWgaOxdGuHajUJuSpt/2KNqEtaQYqyVxxnzTlcojw/2dbsVELFU2BKXWmQmZ8hZrVk5MuyO6gGKK4JcRNxM1o4aBTiu7cAyiZDTqFzyx3kuigXMhP9puaRLCkxXVDDRs1+flWsJFfk3ZR8dE56WX8SstbBMMWe9pHZPkmNYoxMcvYvmnoUUkCo25vVhRAcsK4Gt9gKIfTXcwEHKpMiK1ue2g8buQZxwlOaV8CLmnWBSALsWV9QxThYL1aa40EaYQiU1Jgf2syZg7lVZXl75ut6XT8ZgvRxhBquK7n8N6lhgDW8UD/Nk9/HknKcWuS915UNYpzzGyAv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(376002)(346002)(366004)(66476007)(6666004)(66946007)(5660300002)(31696002)(31686004)(66556008)(16526019)(86362001)(2616005)(956004)(52116002)(6706004)(186003)(36756003)(8676002)(6486002)(2906002)(53546011)(26005)(83380400001)(110136005)(316002)(16576012)(8936002)(508600001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YAocghedJrChM3kInvvpVnL4UElOB117LVIkVZfh+8Mps5Bxc5o2my2IPhxY/oRVonn5ulMcDvXEH0/GcGShxRDspSlMDhlsqltGpGr9KqS0s5XsC8pSnBY+ND8GTjItldcelqotA+42ZmRkqTeNOjH45VPhvXZQuJ4SgHh4JzrH11rN4eLFemNSMgkt6b047KtjdIMXOrksdIO3PCfDCLEtiPi0KqLxnp8R8Bcy1tjwjpNMr9lS3/T7hPa4COiKN1CLPS+MKZJcB1hDbl/y0VIZN9q/3F3zOw5Y3Hx868QSSvc5mccUjTcPloioY81tIof+FKmcwROXXG4bGT7AW87HSy6mY+1k9XTPv6u/k779Pxbswtvy0y9x8pOERxSNMNz9jH3Y3K7WezsLpbpLIQ0lsKpeIA1riRIbNDh/qInFqm3CNAE+2acfreLJNCs0sq8JbIP03RRufKNA2lU5h2ff64hQLUM6kk/nv3bL/Aw=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ac32e5-9ec1-4e70-448a-08d8124ff540
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 23:49:50.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHuuRLItFM+BIe9rkZelJDutrtV8t1BQFA6LvOWXp+R9cbCHEO87tAsLWEw+PsS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6241
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/17 上午7:32, Josef Bacik wrote:
> On 6/16/20 6:49 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/6/17 上午3:25, Josef Bacik wrote:
>>> On 6/15/20 10:17 PM, Qu Wenruo wrote:
>>>> btrfs_root::anon_dev is an indicator for different subvolume
>>>> namespaces.
>>>> Thus it should always be initialized to an anonymous block device.
>>>>
>>>> Add a safe net to catch such uninitialized values.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Can we handle stat->dev not having a device set?  Or will this blow up
>>> in other ways?  Thanks,
>>
>> We can handle it without any problem, just users get confused.
>>
>> As a common practice, we use different bdev as a namespace for different
>> subvolumes.
>> Without a valid bdev, some user space tools may not be able to
>> distinguish inodes in different subvolumes.
>>
> 
> Alright that's fine then.  But I feel like stat is one of those things
> that'll flood the console, can we put this somewhere else that's going
> to be hit less? Thanks,

Unfortunately, stat() is the only user of btrfs_root::anon_dev.

While fortunately, the logical is pretty simple, even without the safe
net we can understand the lifespan pretty well.

I'm fine to drop this patch if you're concerned about the possible
warning flood, as the benefit is really not that much.

Thanks,
Qu

> 
> Josef
