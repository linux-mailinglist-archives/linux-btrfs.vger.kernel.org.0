Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC119B9A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 02:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgDBAwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 20:52:41 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:45701 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727642AbgDBAwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 20:52:41 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu,  2 Apr 2020 00:51:18 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 2 Apr 2020 00:52:21 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 2 Apr 2020 00:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTABqGmVb1pkGTyQwBCHxgUxmAE3r2lqPRiihE+UPpyiLEyijKBE1Cmu2IBTp5+Wjkb8sc7pJfyokdcvKrKzTBCJE4RFghdvampfFEr3A/G1t9BUq75FfeNL5Q+7+iZmwJzDWahnDeNKc1x3SeVrNpmgJPwnGUpUkxPul7R63IgSB0MQq4RSDs5LRdt9ImF+g0xGo1p0VnmmbzHHKL6AXaT4Urr1hYgHQtaN0HGdJKs9gdXrNPZeU7Q9CRuHnzoR9uA8+HzA3MqVOEeLq77kaeaPB9r1kbnCgNxrwNXp4JMnalPsSSQdjiYP4SWefAIWvWeZbvSAyWPRv2bUq6+k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58fuCKyNcwpFI63muK2fx1ioXJf/awOhr3pmv4FywXM=;
 b=lMBB1a1O14njk+md8kQqQ7Q+DBDylBfvyjqILl9FW8/y8nqwFZXJwFvtBgifI5DKWIUUIG+vFdAPR0GGU0g44k6YbiF7l0WH0d82aQg+pZChepMHhyLGaKZnBYxXt+YHMsgIM5UZMb/Gklm0XsI7n5fXwj6nWJ5nmhMJmdcPjWO+IK6dlVZ78n6EPAHDJQuU1C3dLPoFNu6/q3sdH94D17OzI8smZLWG+CHoIrvKDgjh9LFCZ6jXXtp4NiHlS95F6DwibCdzgnHYzbvCIcVFwTnRUNnwUt/kJcnWNdD1TeKPi+e8RIgktVjxaSYyigUokbIGDQsIdtIKwycjkwS1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32)
 by BY5PR18MB3427.namprd18.prod.outlook.com (2603:10b6:a03:195::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 00:52:18 +0000
Received: from BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9]) by BY5PR18MB3427.namprd18.prod.outlook.com
 ([fe80::2870:1e96:c53e:b1f9%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 00:52:18 +0000
Subject: Re: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and
 export it
From:   Qu Wenruo <wqu@suse.com>
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-18-wqu@suse.com> <20200401154820.GT5920@twin.jikos.cz>
 <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
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
Message-ID: <a7185154-0ee6-0a75-53d7-c2fcee74373b@suse.com>
Date:   Thu, 2 Apr 2020 08:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <dfb63614-e246-8b96-e02b-2d333f5ffd82@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="f0AM8xBPSNdbyfs81fgGsy0RRaH3UUs3m"
X-ClientProxiedBy: BYAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:74::17) To BY5PR18MB3427.namprd18.prod.outlook.com
 (2603:10b6:a03:195::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.6 via Frontend Transport; Thu, 2 Apr 2020 00:52:17 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb81ab83-b165-41c5-7f06-08d7d6a017e7
X-MS-TrafficTypeDiagnostic: BY5PR18MB3427:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3427A05453B4EDF5F59237F3D6C60@BY5PR18MB3427.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR18MB3427.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(81156014)(86362001)(36756003)(6706004)(66476007)(26005)(235185007)(8676002)(31696002)(478600001)(16526019)(66556008)(2906002)(33964004)(52116002)(66946007)(956004)(6486002)(6666004)(21480400003)(81166006)(186003)(5660300002)(16576012)(8936002)(31686004)(2616005)(316002)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZAw+vcumnLz3JjLNwu+8i7kXBLR1cqGV5iRvjIP0L5yA2YEAsWScvWNIQFLKnaWE+NGoaTXH5KCNmzj/QT4ZJ4JfFRLfe1QEX++kYRs3oLi1wlq59rxG1TBU6zeMEwZJDyWkrTx6X0Y0vNAwfzovewHhspEXJmw2XfgvspreWOV1PkRG12YOtI1pntbS4FCN2eWI1DfkZBvqLAdyta63j+SxyVLWcvpH20oMUHx7hfJqrRunJLj/oLF1rPoiGqrCaHGb+3WiG4cpOaLOgjg5YbE1BEt6WAUsjdGZYueHv4oL+5Io/d9fh+ssYNG12ir5qWA9DjkyosoOoaQRJeJ/pKn53EibQ0AFJinmeMNiwa/JNrm/HFzAprHVqHBvPOeBa925Vc5Snz/cdTEFGLqvhKJpSMmPf5R3L6sg5SfMUy5cgku98yKcVwAL3Oa5/SAgtn+th1f5ey+a/fl7UImUfvrkV9RoMvCI60+D/57po1bbMRDfFLNDyILYu9KYqdcf8JYBFVJ71fRA9SXbTUnTgpcoM3pXKNRqOvr4N3RCjo=
X-MS-Exchange-AntiSpam-MessageData: Y8YH2AoMYOmekcJdKwMTk4geAAYco1PTJ21pRKZUUJlN+pqIqsCAo7HV8Hrx5dQQTTY7JmbLBFeeAIICziG98baSwa1dMgVR/VpGCZ5L8oeuVCw+t6K+BDGYjBCq8mYu+nMMF6t1BFsFDHq4EJj0uQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb81ab83-b165-41c5-7f06-08d7d6a017e7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 00:52:18.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN7Kqvy4wO/m9k2V9Mv8+wcviOwMTM5T+GyhLO8eoP53SNfvlWsn7QtU+ueNPBqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3427
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--f0AM8xBPSNdbyfs81fgGsy0RRaH3UUs3m
Content-Type: multipart/mixed; boundary="X0C2rZoGHcoGUzDZ6kMpGEq5r5cw7Tj0r"

--X0C2rZoGHcoGUzDZ6kMpGEq5r5cw7Tj0r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/2 =E4=B8=8A=E5=8D=887:40, Qu Wenruo wrote:
>=20
>=20
> On 2020/4/1 =E4=B8=8B=E5=8D=8811:48, David Sterba wrote:
>> On Thu, Mar 26, 2020 at 04:32:54PM +0800, Qu Wenruo wrote:
>>> Structure tree_entry provides a very simple rb_tree which only uses
>>> bytenr as search index.
>>>
>>> That tree_entry is used in 3 structures: backref_node, mapping_node a=
nd
>>> tree_block.
>>>
>>> Since we're going to make backref_node independnt from relocation, it=
's
>>> a good time to extract the tree_entry into simple_node, and export it=

>>> into misc.h.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  fs/btrfs/backref.h    |   6 ++-
>>>  fs/btrfs/misc.h       |  54 +++++++++++++++++++++
>>>  fs/btrfs/relocation.c | 109 +++++++++++++---------------------------=
--
>>>  3 files changed, 90 insertions(+), 79 deletions(-)
>>>
>>> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
>>> index 76858ec099d9..f3eae9e9f84b 100644
>>> --- a/fs/btrfs/backref.h
>>> +++ b/fs/btrfs/backref.h
>>> @@ -162,8 +162,10 @@ btrfs_backref_iter_release(struct btrfs_backref_=
iter *iter)
>>>   * present a tree block in the backref cache
>>>   */
>>>  struct btrfs_backref_node {
>>> -	struct rb_node rb_node;
>>> -	u64 bytenr;
>>> +	struct {
>>> +		struct rb_node rb_node;
>>> +		u64 bytenr;
>>> +	}; /* Use simple_node for search/insert */
>>
>> Why is this anonymous struct? This should be the simple_node as I see
>> below. For some simple rb search API.
>=20
> If using simple_node, we need a ton of extra wrapper to wrap things lik=
e
> rb_entry(), rb_postorder_()
>=20
> Thus here we still want byte/rb_node directly embeded into the structur=
e.
>=20
> The ideal method would be anonymous but typed structure.
> Unfortunately no such C standard supports this.
>=20
>>
>>> =20
>>>  	u64 new_bytenr;
>>>  	/* objectid of tree block owner, can be not uptodate */
>>> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
>>> index 72bab64ecf60..d199bfdb210e 100644
>>> --- a/fs/btrfs/misc.h
>>> +++ b/fs/btrfs/misc.h
>>> @@ -6,6 +6,7 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/wait.h>
>>>  #include <asm/div64.h>
>>> +#include <linux/rbtree.h>
>>> =20
>>>  #define in_range(b, first, len) ((b) >=3D (first) && (b) < (first) +=
 (len))
>>> =20
>>> @@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
>>>  	return is_power_of_two_u64(n);
>>>  }
>>> =20
>>> +/*
>>> + * Simple bytenr based rb_tree relate structures
>>> + *
>>> + * Any structure wants to use bytenr as single search index should h=
ave their
>>> + * structure start with these members.
>>
>> This is not very clean coding style, relying on particular placement a=
nd
>> order in another struct.
>=20
> Order is not a problem, since we call container_of(), thus there is no
> need for any order or placement.
> User can easily put rb_node at the end of the structure, and bytenr at
> the beginning of the structure, and everything still goes well.

My bad, the order is still a pretty important thing...

Thus we still need to keep everything in their correct order to make the
code work...

>=20
> The anonymous structure is mostly here to inform callers that we're
> using simple_node structure.
>=20
>>
>>> + */
>>> +struct simple_node {
>>> +	struct rb_node rb_node;
>>> +	u64 bytenr;
>>> +};
>>> +
>>> +static inline struct rb_node *simple_search(struct rb_root *root, u6=
4 bytenr)
>>
>> simple_search is IMHO too vague, it's related to a rb-tree so this cou=
ld
>> be reflected in the name somehow.
>>
>> I think it's ok if you do this as a middle step before making it a
>> proper struct hook and API but I don't like the end result as it's not=

>> really an improvement.
>>
> That's the what I mean for "simple", it's really just a simple, not eve=
n
> a full wrapper, for bytenr based rb tree search.
>=20
> Adding too many wrappers may simply kill the "simple" part.
>=20
> Although I have to admit, that most of the simple_node part is only to
> reuse code across relocation.c and backref.c. Since no other users
> utilize such simple facility.
>=20
> Any idea to improve such situation? Or we really need to go full wrappe=
rs?
>=20
> Thanks,
> Qu
>=20


--X0C2rZoGHcoGUzDZ6kMpGEq5r5cw7Tj0r--

--f0AM8xBPSNdbyfs81fgGsy0RRaH3UUs3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6FNz4ACgkQwj2R86El
/qjOVQf/VSezo8WSPBVhU/WhJIsaLq0NyIxF+rGmVReyMQHqW8Bv+gELQS5ocq/m
MaSy1Nt0jsXkGG+Xua/PcHlAXUslQdBj3eQGzPxxTqUBXP6nFikZ1O5Dldi9JGBd
KXfmZO/H3IIOskIP9n+XFibTjIJv6ysVDfjwmu46NYdkqipvUfafKHxYGDUZEMOP
ZIPgCDYk0R74J84PN588Gf0KXrQ47g1gLw5IpeSTA34hj66ft6rOIzJpvANbopc/
6OoFwTUyWRYTelZIBArBIOTnvrG1GwImesHqmEHRlnmxmM0FX8RNCzOWDCDYn2z+
MWuCPXb1oeUi8/OjIYdeHny8pcP1DQ==
=lohx
-----END PGP SIGNATURE-----

--f0AM8xBPSNdbyfs81fgGsy0RRaH3UUs3m--
