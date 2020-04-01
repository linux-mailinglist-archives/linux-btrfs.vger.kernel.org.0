Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D813419B90E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 01:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbgDAXlw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 19:41:52 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:56226 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733173AbgDAXlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 19:41:51 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed,  1 Apr 2020 23:39:45 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 1 Apr 2020 23:40:35 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 1 Apr 2020 23:40:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw17lf35Qi8xQJgUbVridzyvanns63BfX1q1+vztTA+D7XT0AnzR0WZFGljdkGHbG8thpCqupgaIObN4XyqjyuIJkLO1bYtQYD8z2IP8u19vlkCWAf23YP2nkGqDVHQSi8Z8jqrOrnNxfLe/XPUvU6ZvsVRYEdEKI+pa7gO53Yh6ev6uEZ+ly0Is32r4HGLZxbJR7Z0nhHoz8S8xFyTMNb8aJD9weEM0m4dEDPPtEOvT0Hu9gJ8lXZvMn+uGJzuYmouyKJUK0XgT8SNJJiJh5FlTknlvADZ18L1E1pLpLRPI4B8XpfunBJw8ZVbxzdoaSkVykszXfnePO6HZvXWWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7qwy6eFSv9ewWrlBgg8wHNH9q1vxgC//QBtUCuw4G4=;
 b=lf69FI+Gmlg9yHOjwlhCa5rZfCNTJZOu+LRv2SwMRmyHJ+a7EFjdnpnR4aEM5cmbRPNp+OBul8N1lXcIdlqSku0LPcdDrm9iGjcYh6YAXmGBUli2Y6zNP1lluSv6JokJV1zkckys0QeOoiGVMhg8TnIVqOj6gnIxyvJh0nLqQcQuBfoPhWN+G9iLj239HKY4lAlP155CuDz1lRMM4BYcfbQbNKA6X1C8BYD6Gwnobx859ZTkeHgGlfq93N6NPDUhi7vKH/c3jD+S93g4elZK+u2C22BkEun8NqXjev/94dvp2xlBvCE9Pkd+/X+F4VukfiMXUfQZOK5vAtWzbcUAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3314.namprd18.prod.outlook.com (2603:10b6:a03:1ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 23:40:33 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 23:40:33 +0000
Subject: Re: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and
 export it
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-18-wqu@suse.com> <20200401154820.GT5920@twin.jikos.cz>
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
Message-ID: <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
Date:   Thu, 2 Apr 2020 07:40:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200401154820.GT5920@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0064.namprd06.prod.outlook.com (2603:10b6:a03:14b::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 23:40:32 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a84b75e-669c-4a9a-afb3-08d7d69611e3
X-MS-TrafficTypeDiagnostic: BY5PR18MB3314:
X-Microsoft-Antispam-PRVS: <BY5PR18MB33149F83B64BA3AC4D7FCC0BD6C90@BY5PR18MB3314.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(956004)(26005)(66476007)(66556008)(81166006)(66946007)(5660300002)(81156014)(31696002)(86362001)(31686004)(8936002)(36756003)(186003)(16526019)(498600001)(16576012)(8676002)(6486002)(6706004)(2906002)(52116002)(2616005)(6666004)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ5tECE9tL7woBycYc7e7dXCNA+maWuOfI7KqtVUVAkTSHLPRQHu7kG8YeUQyCrJLJ2aHCREMp6HNIEmUWV3Qtc1z0U5tay+qOV1ZgsFs+KMf7ypwLdivETOwKmKuWLuKo0dK5pcSXnCHQKfVF/CnPMIHXlzfGXhcSzcW16vVEoZbXzqSFvK5LINutHv3XvDPjwzGWuZ5XWBwbXkB8NNvVA1qcVo1EBNmFGcCaeCWN4SiO1Ep02NxwE7M8C0vLp8Hr3DdfgYHH93cGbjNQdS/c1agwaYRnPM1TuakR+0NL/Ni0Z9h50K3LOgvCElK73vBIP2VxGOwUZg1HzsPqE+Wmk8BZyQ8UggsrIV2qIIb9Xtpr3aaPx9fDLgPleSDapU+ULH0Wnenfs522eNeM8l7/Nv+sakQPkDxDmQnuFeA7UgX/w4YOQq0m5uXFkfLwyndIOUt5k8c9fN0VGz7RIS6/Sge6jyTD7663UNF7vZqWlHRWMeMv2iy1wJH2XraDA04fYCzNa63cMyo6FxUEEpGykqL8euKpx9diIhB6Szzvo=
X-MS-Exchange-AntiSpam-MessageData: luqyCwuE+2n3JLPdOu8ppqvBlDO9LxwDTZofT/i8igWcVTweXozmkdJe79G8271OHBo8JUqi+pD4AD0rbt8vfMcbHbovgHsexrctDFwdXp9b8HNmWDUeZbIjnrLq1NOnl+S0wOl2i7vdhRK7/1rj9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a84b75e-669c-4a9a-afb3-08d7d69611e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 23:40:33.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HXKnCJvdhq+7s2FcycZt6zheRJb2r8Ax5ZjywVKGEjV05E7w9eLTPXt7mUYONE9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3314
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/1 下午11:48, David Sterba wrote:
> On Thu, Mar 26, 2020 at 04:32:54PM +0800, Qu Wenruo wrote:
>> Structure tree_entry provides a very simple rb_tree which only uses
>> bytenr as search index.
>>
>> That tree_entry is used in 3 structures: backref_node, mapping_node and
>> tree_block.
>>
>> Since we're going to make backref_node independnt from relocation, it's
>> a good time to extract the tree_entry into simple_node, and export it
>> into misc.h.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/backref.h    |   6 ++-
>>  fs/btrfs/misc.h       |  54 +++++++++++++++++++++
>>  fs/btrfs/relocation.c | 109 +++++++++++++-----------------------------
>>  3 files changed, 90 insertions(+), 79 deletions(-)
>>
>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>> index 76858ec099d9..f3eae9e9f84b 100644
>> --- a/fs/btrfs/backref.h
>> +++ b/fs/btrfs/backref.h
>> @@ -162,8 +162,10 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
>>   * present a tree block in the backref cache
>>   */
>>  struct btrfs_backref_node {
>> -	struct rb_node rb_node;
>> -	u64 bytenr;
>> +	struct {
>> +		struct rb_node rb_node;
>> +		u64 bytenr;
>> +	}; /* Use simple_node for search/insert */
> 
> Why is this anonymous struct? This should be the simple_node as I see
> below. For some simple rb search API.

If using simple_node, we need a ton of extra wrapper to wrap things like
rb_entry(), rb_postorder_()

Thus here we still want byte/rb_node directly embeded into the structure.

The ideal method would be anonymous but typed structure.
Unfortunately no such C standard supports this.

> 
>>  
>>  	u64 new_bytenr;
>>  	/* objectid of tree block owner, can be not uptodate */
>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
>> index 72bab64ecf60..d199bfdb210e 100644
>> --- a/fs/btrfs/misc.h
>> +++ b/fs/btrfs/misc.h
>> @@ -6,6 +6,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/wait.h>
>>  #include <asm/div64.h>
>> +#include <linux/rbtree.h>
>>  
>>  #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
>>  
>> @@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
>>  	return is_power_of_two_u64(n);
>>  }
>>  
>> +/*
>> + * Simple bytenr based rb_tree relate structures
>> + *
>> + * Any structure wants to use bytenr as single search index should have their
>> + * structure start with these members.
> 
> This is not very clean coding style, relying on particular placement and
> order in another struct.

Order is not a problem, since we call container_of(), thus there is no
need for any order or placement.
User can easily put rb_node at the end of the structure, and bytenr at
the beginning of the structure, and everything still goes well.

The anonymous structure is mostly here to inform callers that we're
using simple_node structure.

> 
>> + */
>> +struct simple_node {
>> +	struct rb_node rb_node;
>> +	u64 bytenr;
>> +};
>> +
>> +static inline struct rb_node *simple_search(struct rb_root *root, u64 bytenr)
> 
> simple_search is IMHO too vague, it's related to a rb-tree so this could
> be reflected in the name somehow.
> 
> I think it's ok if you do this as a middle step before making it a
> proper struct hook and API but I don't like the end result as it's not
> really an improvement.
> 
That's the what I mean for "simple", it's really just a simple, not even
a full wrapper, for bytenr based rb tree search.

Adding too many wrappers may simply kill the "simple" part.

Although I have to admit, that most of the simple_node part is only to
reuse code across relocation.c and backref.c. Since no other users
utilize such simple facility.

Any idea to improve such situation? Or we really need to go full wrappers?

Thanks,
Qu
