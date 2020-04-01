Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2019B8F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 01:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgDAXbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 19:31:53 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:59705 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732503AbgDAXbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 19:31:53 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Wed,  1 Apr 2020 23:30:29 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 1 Apr 2020 23:31:36 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 1 Apr 2020 23:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeoMk6kXq8lh4qin6rEsIBtsyqVk3ytt469Cbp+BTqehpa9kjwrpnUgy/b+jnuZJoKhcJp6h/dldkT7kyoOLMp79hQaZiJ6UszLeZp+qc0cdRGceD6Y7KJqTKTqB0Mfi1sgCuIvOL8ZQ60pke5Br5OQPnuq8wbZOj0oXqan7DNBiy/nMpxq3U7+G2D5iAskRBOpjavoQuQuuIEp1JoRN4Dcm2rJ/075Y2Psc2sX6RjJ9KVdvn1N0MXKz/c5AegmschcV3C95WwRhkmTamiu+76Ges+dnhAJY80GKXGPncxHlFzOM/I30kQnKXvR9O7HLFDHjEouXyJ1mZhS6jC+vtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gksCtZ29D7/Q7gBrIYv3CO298HdVQG1+ZeAtcO7idk=;
 b=huFOxrnNx7fL6FaughuECDmUvRcfkTEBaLj7CY1U78hGEJ2zEuQGjMDYF5dl5l4DRJ/iNHGoqVnr/6FviYX76t4hC8kmkh2mFyTgr8p0u7h8QS6V8xzBnXYS3mLWMHFmN+TYntMArWKSPdaHmXXYK9sUTo+6gtg8ol4FJRjZD87mGYVlCUNCJ4pKAW3kYNy4DEV6EYJ8gpt9ALMZW0vs0ZBoeqThzlnbn5uW5lwCxYIZPwps1nkqTuGERDGGWvf9WiI/x327KQyxk5PeULbAGW8Snx3pZ7Ex6hF9EvAA+B03Zt/KRAWqp6iTGTvYCTgwghHV8Jia7gFHw5rGndDZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3314.namprd18.prod.outlook.com (2603:10b6:a03:1ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 23:31:33 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 23:31:32 +0000
Subject: Re: [PATCH v2 01/39] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-2-wqu@suse.com> <20200401153720.GS5920@twin.jikos.cz>
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
Message-ID: <43d55416-0ef7-89ba-109c-72c91a62d40d@suse.com>
Date:   Thu, 2 Apr 2020 07:31:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200401153720.GS5920@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0044.namprd06.prod.outlook.com (2603:10b6:a03:14b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 23:31:31 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ff26c1-fd83-45b2-3298-08d7d694cf9b
X-MS-TrafficTypeDiagnostic: BY5PR18MB3314:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3314251DF071E3DCB10E8343D6C90@BY5PR18MB3314.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(956004)(26005)(66476007)(66556008)(81166006)(66946007)(5660300002)(81156014)(31696002)(86362001)(31686004)(8936002)(36756003)(186003)(16526019)(498600001)(16576012)(8676002)(110136005)(6486002)(6706004)(2906002)(52116002)(2616005)(6666004)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LISEFl+NTMxcyU3Dg2GQ74uhMAwIkpG3VdrWqZEodn103Ez2PBr1KVwXa+ruCe8sNznpmIKFdKimajwnghowhpT89HEgqmfxqg5AyupJuJm0ub7/3SYcTZz+LgshqW3Nk6HDOTiUsdvXuYBn/pN1Ybq+IHCpBGP67a55LBtyC4cJFK3G37zdKFLVo/zDw7tJa6qAONUtRlH1ckBPGVr6//qS7WhyOj2O2E8c/IGVl16ItT61aipFEc+AsYqAaOESbMJ/sU8D8j8b4jCrtRCBkpT15WRbCepYaMdPu9R4Nr/BdnP94Q74E8jbBt8hoqxmGNRHtoywHoAbf8qygxLZQ9AnjDIQWYMHlgUMljiqOSMzLrIThdaRnlaBHVM09AW5mRKWLEMH+r0TUZtxvjArjkpAQdPh7PYDhymYNIKztpPV/Kn+AdO+yKIGBSyFV8ctSpLzBe1lO/gaHVtK7ywTtrBOKwmWRtnlHnzPkjq6vrAr1KWZXVty5bLq7UFkOUrvIn5qTNK0hIWB7J8zsJWldD9Yf3nWDLLMbMcMegdlryI=
X-MS-Exchange-AntiSpam-MessageData: fTp76hGrbfEeRvhse3cyHIa3lH/xfEpyCcN0nf+e/87MOcrDkS7tLrldfbuIIdLWw55CHgASmUCxzZDRb40eG/gi5Tn9/J0lggmf5E+q6cANqrTSRy194JZhx9h3sNUvmJ++M/YTan7//BwsABCdxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ff26c1-fd83-45b2-3298-08d7d694cf9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 23:31:32.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1Oq3SycVE6ZPqD3+82QuzIvkxj2RV5ROW87lcrqgBafNEscRsHq+4Y8mtFBLTfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3314
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/1 下午11:37, David Sterba wrote:
> On Thu, Mar 26, 2020 at 04:32:38PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -78,4 +78,43 @@ struct prelim_ref {
>>  	u64 wanted_disk_byte;
>>  };
>>  
>> +/*
>> + * Helper structure to help iterate backrefs of one extent.
>> + *
>> + * Now it only supports iteration for tree block in commit root.
>> + */
>> +struct btrfs_backref_iter {
>> +	u64 bytenr;
>> +	struct btrfs_path *path;
>> +	struct btrfs_fs_info *fs_info;
>> +	struct btrfs_key cur_key;
>> +	u32 item_ptr;
>> +	u32 cur_ptr;
>> +	u32 end_ptr;
>> +};
>> +
>> +struct btrfs_backref_iter *btrfs_backref_iter_alloc(
>> +		struct btrfs_fs_info *fs_info, gfp_t gfp_flag);
>> +
>> +static inline void btrfs_backref_iter_free(struct btrfs_backref_iter *iter)
>> +{
>> +	if (!iter)
>> +		return;
>> +	btrfs_free_path(iter->path);
>> +	kfree(iter);
>> +}
> 
> Why do you make so many functions static inline? It makes sense for some
> of them but in the following patches there are functions that are either
> too big (so when they're inlined it bloats the asm) or called
> infrequently so the inlining does not bring much. Code in header files
> should be kept to minimum.

As most of them meet the requirement for either too small, or too
infrequently called.

> 
> There are also functions not used anywhere else than in backref.c so
> they don't need to be exported for now. For example
> btrfs_backref_iter_is_inline_ref.

But it's used in later patches, thus I exported them to avoid re-export
them later.

> 
>> +
>> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr);
>> +
>> +static inline void
>> +btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
> 
> Please keep the function type and name on the same line, arguments can
> go to the next line.

Forgot this one...

Do I need to resend?

Thanks,
Qu

> 
>> +{
>> +	iter->bytenr = 0;
>> +	iter->item_ptr = 0;
>> +	iter->cur_ptr = 0;
>> +	iter->end_ptr = 0;
>> +	btrfs_release_path(iter->path);
>> +	memset(&iter->cur_key, 0, sizeof(iter->cur_key));
>> +}
>> +
>>  #endif
>> -- 
>> 2.26.0
