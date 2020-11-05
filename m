Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C52A7B78
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgKEKQU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 05:16:20 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:47747 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgKEKQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604571372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Wscg4VZlAnS2bVP2dwhyci3l364QZNRUWA/hpDJyLq0=;
        b=MPK0fHoX49Eb1RLmj6s4+JT+ecsgCbPdGqK2voHmnXV6jPSWp+z8/w9GOgZujoCuujVsfK
        QNBEXresUO4Wp4rreUzsT7ckmo56jFYEaHtwLYeI9pa20IqKA6Q+/YdibuiLHucZN0P+65
        AkfxIzaNzjidZpo17JsjllpYfk+Tu0w=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-d5bYqtN4PNqkFghubrg-wg-1; Thu, 05 Nov 2020 11:16:09 +0100
X-MC-Unique: d5bYqtN4PNqkFghubrg-wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHvZPrJ0oSTLxG6lWs3IMbD541unf0Rzwv7iz5ofvjNyyuUORSY/e6qfAE8+DUQD5afvzTNKY6CkL8JMBKtPah190ak7XaOTVEldWetbuqBd1O4/SdGWeSJPxskvNNmfa+QXuiU20OBVR9L5pYQQK6MxHwqPsLfamFiZnymlhUd6BEy7bokVTtTUr1Y9g1oiFOzAjQV0S7soSEPGi2qZWlSQc0oDgMm1EOX5XjNk1/4jC3iYT4N21REV1dRyr8U1P17uOh0mI87eJnQzUC2bZyvk9KCTbrsex4bDU5gMPZhsvYehqX1hqgtXiJ21JwXC/L5JtgfnYngMUdKFgTocig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69YnAxhTirRL7EYJIOI2LzLErVQ3h1uO8v2o0N7N7UA=;
 b=J+AV/KGr4oBmxP6P9bo38PwQQroLx//SdFdyXfUH7VNW1JFOZUK+FVoHC9nBjIKtRQElR4TUpDq3s9JebAdhmxSMEMGYcYWwF8bhubPYvGaLSfC3ZSJC5lJ+cMDjqiuZut6dPMhIgr7lUsxu/QlBnU1HfBkAY2r+oQHOa8DcTjli3fgxzAJcPOuSxA5O9HC7pYU+F0EDOyy15kdLHIRKLb7/oWAcc0IxTQzZdwvT7uCnyMD0LWkem5SMMZ21oZriVn01j0Xl+PpgLfRQP+7HL0C4WurzjFETouUZPTSy2Z/zXRSdYXpYiH0avaocZfLQ40QZsE4/RbyzN26Q0d+arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 10:16:05 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.021; Thu, 5 Nov 2020
 10:16:05 +0000
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
CC:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
 <831ff919-f4f4-7f1b-1e60-ce8df4697651@suse.com>
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
Message-ID: <1e7bf8d5-30d0-a944-c400-b5fe870f1cb5@suse.com>
Date:   Thu, 5 Nov 2020 18:15:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <831ff919-f4f4-7f1b-1e60-ce8df4697651@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0038.namprd17.prod.outlook.com (2603:10b6:a03:167::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 10:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d09b698-6b43-4ec6-2af5-08d88173ce2a
X-MS-TrafficTypeDiagnostic: PA4PR04MB8048:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR04MB804874E518E6F94B56787B50D6EE0@PA4PR04MB8048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQWusKdJ4clIzwYxJRySJyw15rtQ+SArMxIPAPt7kToP4CudZ3vlNYdQFmx6HCxmGRzxOhQqfwROpU48NW1PhxMjpUa3SyabQevUKUShzLsQHa1aqpTE/zznM+eLmOzolyYtqFkPjCI3l19vhY/ML7m0mP8uFYglS9IE2NnI400vtafK/b9xhFIrqiLQqOYwZSnpSKDdlEYE4mUy+H+lZQ4ceNnVcIQGSbpkMeTNJrLvyOD8tkMEhxBJ/sHcODk1+2zOp263c8tn5INKXAAes8UVYc+s8TqoGirO3Q7RWGsHyL9GGTqiny2RmfXGQ6tv0HAEX+hodSdwkekWyhzsKqJx1z9vQi8pU+Ym8l0afOtk0+RCgrzGREQS/1S+2G5q5DjLFleityAY59g8zOOAUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(83380400001)(16576012)(186003)(6706004)(316002)(31696002)(16526019)(2616005)(8676002)(956004)(107886003)(26005)(6486002)(8936002)(52116002)(31686004)(5660300002)(4326008)(6666004)(66946007)(66476007)(36756003)(478600001)(2906002)(66556008)(86362001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5QqH/qpQVZGEl2Ut5c0730IhCaopGfC+UCegB5Z9fHpMb3fDftjqh1twb3SEcaMavzPNx8u7YsoqM0ntrf9iuHy7Drg4GvhzTm4bxUf4lamHeXIvN9Qvz0p7vYTBWpPO/OIHtzxvzHSZLWzorVPzm97498w1DGoM5jaO9Ktg4h6Tn9X3TAqK0HPeAsZauWAZgv7cw0vSbOnjHbwWrarrSUymHj0s3f6y2qCahn7nwHBGCvnjPHm2eAgCxNMSj3ffR1+KW4LV43B3NPRexe1XYjLXn2r+CTG6NbZ2K7tOLDL01WAQ/zrb1g09mm2HYLilRoTRVuFA+zDTH6TllfFjMl+oXuk3rpmEUNog0oXb93JquVRFjWwIY4fmFzCbh+oLjlBcDoAWAF45qTLYutLGzwKIQ/D3cSsaNatvRnwZUj9q7ttoIA4cziJB7AyZ/sJJWSi/kffCFf6WqKaDgRh0/N/yZbEYOSOFbzJDQhhTb0ZeUN1NmOw89isJY0NRjtYkumD1rpv8/rV3liRPC37CvlPsuEqO7YT9Yio7Lo+tv8qtBWLqh3nuQ2nuIE+RkNx5E+pwL/TpvajZQtmIUDWZMTYk0iEdm0z0IzvYU0P/lm+Q1NWE0tvJTpiyCdDhVgCpe4/Ywgc0K08uZww9v/AghQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d09b698-6b43-4ec6-2af5-08d88173ce2a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 10:16:05.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBECfIZYCUL/XKNBmij2ay10Wd6ys0GeFTXr+/0/yTRJ2DHo5YBvgu7meQB9hTqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=885:46, Nikolay Borisov wrote:
>=20
>=20
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> In end_bio_extent_readpage() we had a strange dance around
>> extent_start/extent_len.
>>
>> Hides behind the strange dance is, it's just calling
>> endio_readpage_release_extent() on each bvec range.
>>
>> Here is an example to explain the original work flow:
>>   Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)
>>
>>   end_bio_extent_extent_readpage() entered
>>   |- extent_start =3D 0;
>>   |- extent_end =3D 0;
>>   |- bio_for_each_segment_all() {
>>   |  |- /* Got the 1st bvec */
>>   |  |- start =3D SZ_1M;
>>   |  |- end =3D SZ_1M + SZ_4K - 1;
>>   |  |- update =3D 1;
>>   |  |- if (extent_len =3D=3D 0) {
>>   |  |  |- extent_start =3D start; /* SZ_1M */
>>   |  |  |- extent_len =3D end + 1 - start; /* SZ_1M */
>>   |  |  }
>>   |  |
>>   |  |- /* Got the 2nd bvec */
>>   |  |- start =3D SZ_1M + 4K;
>>   |  |- end =3D SZ_1M + 4K - 1;
>>   |  |- update =3D 1;
>>   |  |- if (extent_start + extent_len =3D=3D start) {
>>   |  |  |- extent_len +=3D end + 1 - start; /* SZ_8K */
>>   |  |  }
>>   |  } /* All bio vec iterated */
>>   |
>>   |- if (extent_len) {
>>      |- endio_readpage_release_extent(tree, extent_start, extent_len,
>> 				      update);
>> 	/* extent_start =3D=3D SZ_1M, extent_len =3D=3D SZ_8K, uptodate =3D 1 *=
/
>>
>> As the above flow shows, the existing code in end_bio_extent_readpage()
>> is just accumulate extent_start/extent_len, and when the contiguous rang=
e
>> breaks, call endio_readpage_release_extent() for the range.
>>
>> The contiguous range breaks at two locations:
>> - The total else {} branch
>>   This means we had a page in a bio where it's not contiguous.
>>   Currently this branch will never be triggered. As all our bio is
>>   submitted as contiguous pages.
>>
>=20
> The endio routine cares about logical file contiguity as evidenced by
> the fact it uses page_offset() to calculate 'start', however our recent
> discussion on irc with the contiguity in csums bios clearly showed that
> we can have bios which contains pages that are contiguous in their disk
> byte nr but not in their logical offset, in fact Josef even mentioned on
> slack that a single bio can contain pages for different inodes so long
> as their logical disk byte nr are contiguous. I think this is not an
> issue in this case because you are doing the unlock on a bvec
> granularity but just the above statement is somewhat misleading.

Right, forgot the recent discovered bvec contig problem.

But still, the contig check condition is still correct, just the commit
message needs some update.

Another off-topic question is, should we allow such on-disk bytenr only
merge (to improve the IO output), or don't allow them to provide a
simpler endio function?

>=20
>> - After the bio_for_each_segment_all() loop ends
>>   This is the normal call sites where we iterated all bvecs of a bio,
>>   and all pages should be contiguous, thus we can call
>>   endio_readpage_release_extent() on the full range.
>>
>> The original code has also considered cases like (!uptodate), so it will
>> mark the uptodate range with EXTENT_UPTODATE.
>>
>> So this patch will remove the extent_start/extent_len dancing, replace
>> it with regular endio_readpage_release_extent() call on each bvec.
>>
>> This brings one behavior change:
>> - Temporary memory usage increase
>>   Unlike the old call which only modify the extent tree once, now we
>>   update the extent tree for each bvec.
>=20
> I suspect for large bios with a lot of bvecs this would likely increase
> latency because we will now invoke endio_readpage_release_extent
> proportionally to the number of bvecs.

I believe the same situation.

Now we need to do extent_io tree operations for each bvec.
We can slightly reduce the overhead if we have something like globally
cached extent_state.

Your comment indeed implies we should do better extent contig cache,
other than completely relying on extent io tree.

Maybe I could find some good way to improve the situation, while still
avoid doing the existing dancing.

>=20
>>
>>   Although the end result is the same, since we may need more extent
>>   state split/allocation, we need more temporary memory during that
>>   bvec iteration.
>=20
> Also bear in mind that this happens in a critical endio context, which
> uses GFP_ATOMIC allocations so if we get ENOSPC it would be rather bad.

I know you mean -ENOMEM.

But the true is, except the leading/tailing sector of the extent, we
shouldn't really cause extra split/allocation.

Each remaining extent should only enlarge previously modified extent_state.
Thus the end result for the extent io tree operation should not change much=
.

>=20
>>
>> But considering how streamline the new code is, the temporary memory
>> usage increase should be acceptable.
>=20
> I definitely like the new code however without quantifying what's the
> increase of number of calls of endio_readpage_release_extent I'd rather
> not merge it.

Your point stands.

I could add a new wrapper to do the same thing, but with a small help
from some new structure to really record the
inode/extent_start/extent_len internally.

The end result should be the same in the endio function, but much easier
to read. (The complex part would definite have more comment)

What about this solution?

Thanks,
Qu
>=20
> On a different note, one minor cleanup that could be done is replace all
> those "end + 1 - start" expressions with simply "len" as this is
> effectively the length of the current bvec.
>=20
> <snip>
>=20

