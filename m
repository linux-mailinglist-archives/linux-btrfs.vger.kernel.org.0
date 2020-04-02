Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4919BA01
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgDBBov convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 21:44:51 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:36077 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbgDBBou (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 21:44:50 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu,  2 Apr 2020 01:43:21 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 2 Apr 2020 01:27:19 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 2 Apr 2020 01:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1G3qCvnWQitLlK4GaRLf9ApPRpdF+zZbHUmNDcUL9ivxug7Eb51ZLosQoq8FHDHew/FCoHAbuJ8ExNztvBvifJan1NPpCQCqbeuRzeEoKdok/dtgVxlnBnwna+/YN1heDsMUwHRpIG+P/a8II81Py0NasksA2sI6KrFz5bA55seQdXtZ5re+RGpwdH8dhrs0pEgLjTdzdy79I6bacJhwgxzjOVkG04DWVVidnizylgCDxkr4v8QekBqwKSyQAp236AzxSRngf6h+dMkg/7xY6vZ7OlgdCyeLADM8kou4oq2zRkoj4bcqaILFq4R6kHZ2I/G6to1ngpbTTsgwrnI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nx7CeggdBlwXakJJ8TVEhTrExBTA97F+PLGAO/Pi7E=;
 b=Z5MvMYl6aD4FBVPBQMGWC0H0TeTjO8FcC2c791H0b4QBLfMFsQ2cPPVwMRFjLwZQvPiWSUex171IcLBNbhgv6hWxF9QwivB+Hd1q8IHvRbIDJivaPfZMxI3xTyQpp9wwZFQtiTJTmfrnPNRi7258Q1C5kIkPEYoXElqbE7/YOt8tFyxtFwDvnhmkN9YZUsYBRXPIRbVLmwKdBzBQ2u0zAWctDhFmG5bQpX8HgRhSSqXGys0J6kqyUMQ3YEO4Kjxi/zu2XFby7azUxLhNTVORtpZxyTBCVBnF5Iu2nxJdPlc3q1Q6K6UtqFyEgnEL0lVC3Lwf8EbOvhpiaNaU1fGQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3139.namprd18.prod.outlook.com (2603:10b6:a03:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 01:27:17 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 01:27:17 +0000
Subject: Re: [PATCH v2 01/39] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-2-wqu@suse.com> <20200401153720.GS5920@twin.jikos.cz>
 <43d55416-0ef7-89ba-109c-72c91a62d40d@suse.com>
 <20200402010136.GB5920@twin.jikos.cz>
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
Message-ID: <8b2a4f09-07f9-9493-fb70-a42d42b73250@suse.com>
Date:   Thu, 2 Apr 2020 09:27:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200402010136.GB5920@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR02CA0046.namprd02.prod.outlook.com (2603:10b6:a03:54::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 01:27:16 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0600c7e4-4edd-41d9-e203-08d7d6a4fb1b
X-MS-TrafficTypeDiagnostic: BY5PR18MB3139:
X-Microsoft-Antispam-PRVS: <BY5PR18MB31392B3C8EABB7DDFA630F9BD6C60@BY5PR18MB3139.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(81156014)(36756003)(66556008)(16526019)(110136005)(6706004)(86362001)(66946007)(478600001)(66476007)(26005)(8676002)(2906002)(52116002)(8936002)(186003)(31696002)(6486002)(5660300002)(956004)(81166006)(31686004)(16576012)(2616005)(316002)(6666004)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr5eyoZufnFyRNTdfQe+rhMiGoOgtMRq/qmeb7Te++8n8qBG44pFfrs+o3Lyeao7K1gEsGpcDwBY5+5mM/RU6jlK4QmJ5fGaOns93YVQ6JmkR4qPaKM8tqyOmj5rPZckfUEt9sXXa5wAhKZDyc+HL1p4ENj3feBqqzsN/29KJV0+ud7NkDwuZafQ1tZPACKw09XpounNYu8fJXLKxki5TRrxG4uAkixkenF9YxG5lWymXYjJf0KB/P5zEeHvhAofbUASrD1k5qYEsuGKTT4/p6gemdl3NZPvOYjl/Dyl/jxu37oNhZIFskkpfiQTBfVvCsyk8d9Zgz+EnP10uhCoyAm41ylt5c+Mg+fn6ibIIE9rOfhZY+5pBm47fCXN/BcQV00Hq6ce5N8IxZn8YmXUlHdIzrNakCoGiFthHjp6nzYcpaBf4kokdjc9wBx4glwNtgE8U70XKZILG+/0JsnCJdnsCmxWrVQ+iZvv2rAaewlLasPM8hp0S5C4f2kWSbUJZyaSvbOuox9siv8aaWDx8YumUcYK19wJECQvlu8r9Zo=
X-MS-Exchange-AntiSpam-MessageData: NdjpBQzx7dH/cMKPlvnvJg3LA9f14BAOGqbUOML8XSqeOcwokniuywB60MBKespyCCKjhK5x7ydDJWJc7LCmnh/vs8yO9Lyg5vg3vz0qCNoWx/NhYZRoEBUPsYcNLwLJRgeHlyZD/mvokNtAxiVLqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0600c7e4-4edd-41d9-e203-08d7d6a4fb1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 01:27:17.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N23qRKmJrr6NQJRQAbEGSenaE2DnPBciCIEMs/PmPVnIdsLje6yELG8vJ7qFSTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3139
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/2 上午9:01, David Sterba wrote:
> On Thu, Apr 02, 2020 at 07:31:28AM +0800, Qu Wenruo wrote:
>> On 2020/4/1 下午11:37, David Sterba wrote:
>>> On Thu, Mar 26, 2020 at 04:32:38PM +0800, Qu Wenruo wrote:
>>>> --- a/fs/btrfs/backref.h
>>>> +++ b/fs/btrfs/backref.h
>>>> @@ -78,4 +78,43 @@ struct prelim_ref {
>>>>  	u64 wanted_disk_byte;
>>>>  };
>>>>  
>>>> +/*
>>>> + * Helper structure to help iterate backrefs of one extent.
>>>> + *
>>>> + * Now it only supports iteration for tree block in commit root.
>>>> + */
>>>> +struct btrfs_backref_iter {
>>>> +	u64 bytenr;
>>>> +	struct btrfs_path *path;
>>>> +	struct btrfs_fs_info *fs_info;
>>>> +	struct btrfs_key cur_key;
>>>> +	u32 item_ptr;
>>>> +	u32 cur_ptr;
>>>> +	u32 end_ptr;
>>>> +};
>>>> +
>>>> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(
>>>> +		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
>>>> +
>>>> +static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
>>>> +{
>>>> +	if (!iter)
>>>> +		return;
>>>> +	btrfs_free_path(iter->path);
>>>> +	kfree(iter);
>>>> +}
>>>
>>> Why do you make so many functions static inline? It makes sense for some
>>> of them but in the following patches there are functions that are either
>>> too big (so when they're inlined it bloats the asm) or called
>>> infrequently so the inlining does not bring much. Code in header files
>>> should be kept to minimum.
>>
>> As most of them meet the requirement for either too small, or too
>> infrequently called.
> 
> So the rules or recommendations I use to decide if a function should be
> static inline:
> 
> * it's like macro with type checking
> * results into a few instructions (where few is like 3-6)
> * the function is good for code readability, like for a helper that does
>   some checks and returns a result, or derefernces a few pointers, and
>   the function name is self explaining

After re-checking the backref.h, I still find most (if not all) of these
inlined functions meet these conditions.

They are short, mostly just doing basic check then free up some pointers.

> * there should be some performance reason where the function call would
>   be too costly, eg. if the function is on a hot path or in a loop

This is my main concern.

Compiler can easily "uninline" functions if they are only static inline
inside the same C file.
But if we define some function in headers, then it will always be a
function call, and can't be "uninlined"

That's my major concern, any exported functions is a barrier where
compiler can't do their best to optimize.

Thus to me, I agree condition 1~3, but no the 4th if we're handling
exported functions, as it's a single directional optimization.

If there is some proof (I don't believe though) that, compiler can
uninline/inline such exported functions, then I'm completely happy to
make them regular functions.

> 
> And all of that can be irrelevant if the compiler does some fancy
> optimization, like function cloning where it keeps one copy intact
> that's for the public interface and then inline other copies, possibly
> applying more optimizations eg. based on parameters or some analysis
> that splits function to hot and cold parts.
> 
> Unless we find some suboptimal result of compilation that could be fixed
> by static inlines, I tend to not use them besides the trivial cases that
> help code readability.

But these functions are small, self explaining, thus rarely get read
that much.

> 
>>> There are also functions not used anywhere else than in backref.c so
>>> they don't need to be exported for now. For example
>>> btrfs_backref_iter_is_inline_ref.
>>
>> But it's used in later patches, thus I exported them to avoid re-export
>> them later.
> 
> I grepped the whole branch with the backref cache and assumed that if
> you introduce a function in the cleanup part, it would be used in the
> other one. But btrfs_backref_iter_is_inline_ref wasn't.

Oh, you're right. That function is only temporary used.
It's introduced in patch 02, then utilized in patch 03, where the major
backref cache handling is still in relocation.c.

Then in patch 29, the backref cache code got moved to backref.c, then no
one utilize that function outside of backref.c, thus it no longer needs
to be exported.

Would you mind to unexport it in patch 29 too?

Thanks,
Qu

> 
>>>> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
>>>> +
>>>> +static inline void
>>>> +btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
>>>
>>> Please keep the function type and name on the same line, arguments can
>>> go to the next line.
>>
>> Forgot this one...
>>
>> Do I need to resend?
> 
> I fix such things when applying the patches so for that only reason it's
> not necessary to resend.
> 
