Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1731B8431
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Apr 2020 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDYH1O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 25 Apr 2020 03:27:14 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:58576 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgDYH1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 03:27:14 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Sat, 25 Apr 2020 07:25:04 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 25 Apr 2020 07:25:33 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sat, 25 Apr 2020 07:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKPZLVnLV7mIf8R7QKaZT7IuAEKpLM91o8lBQO1gv9Qe8aSNb3gBtTYJnFPP0h9X10sUmypsXnRjXBVgfv523CXL+oh6nsW02/Db+qrllg6mXZLQL45sYN+CZ7H0elhrwLSbpO3hHfW27MRwBrYCa8bDwTcxPPnWq2/JX0LplYwRVxNdLsDDKcR4gVWHDtLR81iC7fnRVpvyuhsUYhf03OB0ikTcADT2fgSHkeBKiGwJMRavCFWH4jd6GZ99rBdQYzDOm5mnEd4mUqS6gg3oWYE4kUKhi4Qvl0CAJ4YBUVodATaauyC/qTPBoXXy8gk0gAIL4pJnH+4/5Ypm8PtJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PSPLEdVPb02a6gZ0nFDn8tu+uBVbzHtC6ZbMfr+20k=;
 b=IcjcyncQcrSBluwvRdK/giEJkixe86XcyRSDhZOYwHQocTHMS/ZbcJieSyTVbV+z5l1t6ewilA8he3iE1aXU1lMFahxxTXXMF7EiQ2T5u4rk7ydu6IOEb02gNgcXpS9d85f8Vx3pIfmlW7toJAPi5fFPFFOg9M6gmmqMo/qM3X8hW7XkiwCO8QnmZFjhKPCz5fZHxLc7nThwXnjkejwSUrODk1VdloCXN5XxEXpBt/uN7cDgN7sOmsCNTf9dYQPVo/mM8Z0u7PGEJG3K8tHBdguvSNpg6Os6fzzFpSfQUnYjAs2d3UOBzUEmSQJZAo4fc8x1S40koKQPhfX0wOgukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB2431.namprd18.prod.outlook.com (2603:10b6:208:ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 07:25:31 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 07:25:30 +0000
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
To:     Christoph Hellwig <hch@infradead.org>, <dsterba@suse.cz>,
        <linux-btrfs@vger.kernel.org>
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com> <20200421113138.GA10447@infradead.org>
 <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
 <20200424202445.GY18421@twin.jikos.cz> <20200425071416.GA30673@infradead.org>
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
Message-ID: <8be35018-933f-5af9-50a5-85f610d08c5e@suse.com>
Date:   Sat, 25 Apr 2020 15:25:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200425071416.GA30673@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 07:25:28 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c344868d-7988-4a20-1905-08d7e8e9d56d
X-MS-TrafficTypeDiagnostic: MN2PR18MB2431:
X-Microsoft-Antispam-PRVS: <MN2PR18MB243177951D0D7E3DE4FD1FE5D6D10@MN2PR18MB2431.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(86362001)(316002)(16576012)(5660300002)(6666004)(31696002)(478600001)(6706004)(8936002)(2906002)(8676002)(186003)(52116002)(66556008)(31686004)(956004)(36756003)(6486002)(16526019)(81156014)(66476007)(66946007)(2616005)(26005)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB5jNuaGCgFIlmo2+AhFeSdv8Z9zINUo5P3DHwINorM+ssGxC+nUdP3ZXvJhTl/ptcnXjztC4nw0HAzV2lon1akng2DdvNZlIsRfaEXqgAvLSaNslotjldengd1pcSZb9P+JvnyCHQthk7hXM9w6F+y0axc/FcjBsYrcPMYSDmBfxbEW8opfwG3Bwn5L+ruBIsA7DoMou01uL/A0oNFvqVtPeVcs4oQSkqTX1s6dUkQUJJGDRQPWR0ubE+CHiKP8DJnQi6en3K7nqBjQJXYN2TavJXbPWtIHyshJ5+Phvoo5oWmATBNMWC8UH+CdxuFhSOC2n1SSolBrUVjBbZflfSYkre//wThwyjHPz1v9W96gfrjYfGT7I52aVw+s+5ccy8m64gv/tC2DMwWb81ibhbI94hS/N2wj6+sfZA7MLspYWXLaXELUocGjYvlzlNelkPAkUA5I5gK1MNe2ExsfOnA3OPJ2nbJXEVRMIBbWntpnxg9iLANc9P9Tuh7IQNOnJG4Kb6RToTtzLmIGqqNJuaOHQhPwxqksi+FmoLQmcwo=
X-MS-Exchange-AntiSpam-MessageData: B8kurX9tyfr9pIQtysyaI1sKqB45qaAoDBgMZ19fYFtqIZ8bAMtw6nQI5oN7VeCnh7TlLyR+6+q7fbsRgtmAaE1uq+ukJSo3xKNnYaeZNU+TrLeZJN/Nedh6EcwP9gVPUNpR4ssyoAA8jExKGUo/F5E++OEp2bahYOy1DvFc0syWwZOAiUXDbXQUPidFPRwYGt/W3IQgjqUYcn37Uh13l5LN+tIJ8d8J1qRRi5pM34SYfEc07shEy5p2ugEh6EDnW2iMovuXL7u0RQEy5vBK/VsZ8jJxp9eSU4ISyppnxYni6o8gpADW0RYV0/9J7Ky6Z+eQgDit8+qrxlDoFJfvNPYNS9yjaBZUMXOoDCZbYlCIkswQ26swoB9/GuIseV852L51kVweO9+7iKOZUXPU0xswObufDt+pFdLrilPqns4D2kWH1rUnQwH22ixHMqRomD31btOIqAwRA/x2QwxHXlggUWPvJe4XMFQSPFOayZNnS7IKHVNF9TbiVAlFPmAObQT4F/KY+KS9Nt2djq9IISMxWgll8SV2qKxP5Iq7R2OOf0LDGeZ//bUUCdnegMt/Bfw3wQl0e76oqJpu7IrdAH+HujKd6J9soTYwV36fOMHZmA5DEPH360tsgjQpT9zxhiMBGIledMZVdNaeJb2UAkyKW6xsr1i1I82pLU4pnG0YrtaV1JvjHfEsEz7kzIGhjI2zwPbWEXADbqjx8bOQZSZ7xni6mz134VseOBNi9ZxsA+Iy7vKHp2TrU2ii1Q2LVIuKTPXJxAh4t0UchsCdb/CSuPwOgbZub+EPJ0872Fc=
X-MS-Exchange-CrossTenant-Network-Message-Id: c344868d-7988-4a20-1905-08d7e8e9d56d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 07:25:30.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwCDN/Ummd5vCFkIlh+/Z6I98chBk72anHrK4A7f81POl5e8Fsia4BaIiLsMooaY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2431
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/25 下午3:14, Christoph Hellwig wrote:
> On Fri, Apr 24, 2020 at 10:24:45PM +0200, David Sterba wrote:
>> On Tue, Apr 21, 2020 at 07:41:40PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/4/21 下午7:31, Christoph Hellwig wrote:
>>>> On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
>>>>> These structures all are on-disk format. Move them to btrfs_tree.h
>>>>>
>>>>> This allows us to sync the header to different projects, who need to
>>>>> read btrfs filesystem, like U-boot, grub.
>>>>
>>>> Please use a separate header for that.  btrfs_tree.h is a UAPI header
>>>> with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
>>>> can be copied into the projects where is needed.
>>>>
>>> Doesn't on-disk format itself need strict ABI guarantees?
>>>
>>> Thus it looks like the perfect location for on-disk format definitions.
>>
>> Right now I'm not sure if it's a good idea to put the on-disk format to
>> the UAPI path or not. The exported code is to support the ioctls,
>> there's an overlap with the on-disk format but providing all the on-disk
>> structures for general might become an unnecessry burden.
>>
>> We know that there's a small number of projects that want to sync the
>> on-disk format so I don't think it's going to be a problem for them to
>> use a private header.
> 
> And the usual way is to just ensure the format header is self-contained
> and suitably licensed that they can easily copy it and rely on the
> version they checked in.  That avoids the problems of
> 
>  a) the tools relying on installed kernel headers new enough for the
>     feature they want to support
>  b) ifdef magic for newer features in the tools
>  c) the need to keep changes to the kernel format header to be backwards
>     compatible at the compiler level (as there can be disk format
>     compatible changes that still break users, e.g. introducing a named
>     union, or splitting / merging struct definitions)
> 
One last question.

Btrfs has one ioctl, which allow users to search btrfs on-disk data.

And the ioctl returns the on-disk data directly to user space, which
means the on-disk format is also used by ioctl.

In that case, do we still need to put the on-disk format internal other
than as a uapi?

Thanks,
Qu
