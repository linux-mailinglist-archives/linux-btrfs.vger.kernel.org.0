Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A519BA06
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 03:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgDBBsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 21:48:01 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:43540 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbgDBBsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 21:48:01 -0400
X-Greylist: delayed 1097 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2020 21:48:01 EDT
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu,  2 Apr 2020 01:46:58 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 2 Apr 2020 01:32:06 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 2 Apr 2020 01:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjSc96cjf4Jmvn47xyAzUA8dKT34pa2LOnm4Odd5rd/XKNuRYJvnhXiwIVSoTa0LJpMyXR79nYsVRgYd8H4d9eSIaf0g0Q9Fo7mrLJ6aXEk2ov7nNqvl79/KQNY5fay3u4BrsRnZSTLlFkUysE5p5IfCzMmQDUnbhxnLCcCq0SZiZ05LHCFv1Sd/yAprTGQV0WTp8n+e8ONGaTHU2TR14pnyvnr6wm35ROTtTM7NKsYxljr/ZYSrBh64OadpJTk+ULpQDOwmHJqfAcGuPVAT/DSLMB4lqQhPsTlapO1YQP1YfGzSQruyO9oO1o6BoroQ3zRdNcqZikpjD41E3twK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWIkUlaAMTWuOkvK6mTaqEJnHhTF22scgoXQfkWn1l0=;
 b=hRAHhag0012j5uZWwkuXo9iHUb5bLKvikX3DTFnNhwU8vOdGIaOVVDmmO0IH0bBbn3T2HXajs30w+xT4eJQEuUVk4Pr65wFxknZMnMwrwWc87SiGsz5Pw+n0PjJFHLo75FnHBPPPe9LFNRC2EkfwjSkxJANY96zlhAsDJk7Qqkt6r1DNoWUuqXGhfcYZMrrymeu6T1uhpO8b2oAxsshoYxCd8hgDYjjFj1Jm/H8xuTXK6ikCE+eLR883A4+9AJzlQq6HXYiaoDwkRMV6nWVO5Z47KgXUhPo78WzOZ+ig8LS07AT/e5/wa1lJUFLe1y7Hsy6rfiC8E0bud3GMtvZa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3139.namprd18.prod.outlook.com (2603:10b6:a03:1a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 01:32:05 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 01:32:05 +0000
Subject: Re: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and
 export it
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-18-wqu@suse.com> <20200401154820.GT5920@twin.jikos.cz>
 <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
 <20200402010936.GC5920@twin.jikos.cz>
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
Message-ID: <efc43841-f16d-33c9-af10-c051f7fdb54a@suse.com>
Date:   Thu, 2 Apr 2020 09:32:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200402010936.GC5920@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0106.namprd11.prod.outlook.com (2603:10b6:a03:f4::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 01:32:04 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef32ca27-02bc-4b58-d5ad-08d7d6a5a6c4
X-MS-TrafficTypeDiagnostic: BY5PR18MB3139:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3139F873C9742A2082F705F4D6C60@BY5PR18MB3139.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(81156014)(36756003)(66556008)(16526019)(6706004)(86362001)(66946007)(478600001)(66476007)(26005)(8676002)(2906002)(52116002)(8936002)(186003)(31696002)(6486002)(5660300002)(956004)(81166006)(31686004)(16576012)(2616005)(316002)(6666004)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtzRfbE1Di9raBepgDHQVRCfWje5URm5K9NPKgIipJjW/487SgLDSXlMFEdYwGfN+TqXprTUjFiOkuDSRLErDWuzRetpwDEcUELMJAy/3bPH/M71+Sddop/+v+ptU4OXNt2H8nh2XKBu3nnEdj3l+ihmOyvou3CD5tICM6oCX13d/i0rc4jC/Ozc4yIJhXCryctnniqDyQuB8VmALeps+MnojPIwc4IJ2ehAzLIF2FMDd8A5rbuuLvk+iVKzocOXgAAAtKzIOdGLVhLq2xeN7mliuvvmZCknB9l2Ga5EV2tlK97jVpvfUH5Z6X9zBI8roa4A2qAZjNrIwuXSlcSCapB0vzJL/WnEH+udH7Sv2DH6qwrk5A+5UcAFnbsGRIs0VwacvVx0bnSEaFQVOqjZsoefEXwbX+rD3pSd/89gShgQ38p4AMx4/07iI1hV06UU2u4sn1lAxvRTLQBxYNDd0ZfsEeZxInq9ONIgERQJb9U7q2Kg49Qza1GujvfzPpQSJQnD8Ew4Dm9C+0tWBIf60jBwdcsJsDKuX0w4nbjUMzw=
X-MS-Exchange-AntiSpam-MessageData: dy7s7cAwdgct2+AtFErg/ipvFCJSCegPPWZdlFnlYWRLELzBq1UIFu78CEakJxraB6nhjhdU+FyznnvuJ6N4mSsjI3jp2U4j5dA3NNLqGYPidRjYmFyTdGN979smp1AOOdG3brbeZx8BpisJ1t6dqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef32ca27-02bc-4b58-d5ad-08d7d6a5a6c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 01:32:05.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p565vsZo6Or8ftED8jXPFRwGc2g47k2svdmE/eslSj7B+H0+BK6RAugFz0aI4ZHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3139
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/2 上午9:09, David Sterba wrote:
> On Thu, Apr 02, 2020 at 07:40:29AM +0800, Qu Wenruo wrote:
>>>>  struct btrfs_backref_node {
>>>> -	struct rb_node rb_node;
>>>> -	u64 bytenr;
>>>> +	struct {
>>>> +		struct rb_node rb_node;
>>>> +		u64 bytenr;
>>>> +	}; /* Use simple_node for search/insert */
>>>
>>> Why is this anonymous struct? This should be the simple_node as I see
>>> below. For some simple rb search API.
>>
>> If using simple_node, we need a ton of extra wrapper to wrap things like
>> rb_entry(), rb_postorder_()
>>
>> Thus here we still want byte/rb_node directly embeded into the structure.
>>
>> The ideal method would be anonymous but typed structure.
>> Unfortunately no such C standard supports this.
> 
> My idea was to have something like this (simplified):
> 
> 	struct tree_node {
> 		struct rb_node node;
> 		u64 bytenr;
> 	};
> 
> 	struct backref_node {
> 		...
> 		struct tree_node cache_node;
> 		...
> 	};
> 
> 	struct backref_node bnode;
> 
> when the rb_node is needed, pass &bnode.cache_node.rb_node . All the
> rb_* functions should work without adding another interface layer.

The problem is function relocate_tree_blocks().

In which we call rbtree_postorder_for_each_entry_safe().

If we use tree_node directly, we need to call container_of() again to
grab the tree_block structure, which almost kills the meaning of
rbtree_postorder_for_each_entry_safe()

This also applies to rb_first() callers like free_block_list().

> 
>>>>  	u64 new_bytenr;
>>>>  	/* objectid of tree block owner, can be not uptodate */
>>>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
>>>> index 72bab64ecf60..d199bfdb210e 100644
>>>> --- a/fs/btrfs/misc.h
>>>> +++ b/fs/btrfs/misc.h
>>>> @@ -6,6 +6,7 @@
>>>>  #include <linux/sched.h>
>>>>  #include <linux/wait.h>
>>>>  #include <asm/div64.h>
>>>> +#include <linux/rbtree.h>
>>>>  
>>>>  #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
>>>>  
>>>> @@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
>>>>  	return is_power_of_two_u64(n);
>>>>  }
>>>>  
>>>> +/*
>>>> + * Simple bytenr based rb_tree relate structures
>>>> + *
>>>> + * Any structure wants to use bytenr as single search index should have their
>>>> + * structure start with these members.
>>>
>>> This is not very clean coding style, relying on particular placement and
>>> order in another struct.
>>
>> Order is not a problem, since we call container_of(), thus there is no
>> need for any order or placement.
>> User can easily put rb_node at the end of the structure, and bytenr at
>> the beginning of the structure, and everything still goes well.
>>
>> The anonymous structure is mostly here to inform callers that we're
>> using simple_node structure.
>>
>>>
>>>> + */
>>>> +struct simple_node {
>>>> +	struct rb_node rb_node;
>>>> +	u64 bytenr;
>>>> +};
>>>> +
>>>> +static inline struct rb_node *simple_search(struct rb_root *root, u64 bytenr)
>>>
>>> simple_search is IMHO too vague, it's related to a rb-tree so this could
>>> be reflected in the name somehow.
>>>
>>> I think it's ok if you do this as a middle step before making it a
>>> proper struct hook and API but I don't like the end result as it's not
>>> really an improvement.
>>>
>> That's the what I mean for "simple", it's really just a simple, not even
>> a full wrapper, for bytenr based rb tree search.
>>
>> Adding too many wrappers may simply kill the "simple" part.
>>
>> Although I have to admit, that most of the simple_node part is only to
>> reuse code across relocation.c and backref.c. Since no other users
>> utilize such simple facility.
>>
>> Any idea to improve such situation? Or we really need to go full wrappers?
> 
> If the above works we won't need to add more wrappers. But after some
> thinking I'm ok with the way you implement it as it will certainly clean
> up some things and once it's merged we'll have another chance to look at
> the code and fix up only the structures.

Looking forward to better cleanups.

Thanks,
Qu
