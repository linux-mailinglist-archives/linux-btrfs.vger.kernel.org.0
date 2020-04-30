Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0421BF198
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgD3HeK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 Apr 2020 03:34:10 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:45170 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgD3HeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 03:34:09 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Thu, 30 Apr 2020 07:33:19 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 30 Apr 2020 07:30:00 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 30 Apr 2020 07:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5Wkxpw/nG6I9rqoitXtRpdbO68j5HZ07y7Y07LS915ybU9PNje0rQQVN5XQueB1FYWM1/oUuZs+MOUge/0wswdLP7zoBYcaicbXYj+EaS3a9NHeHCk0ZtvPt+3+0sWD4zbLy23xTGJJNVP14lsNJx9ot6Da0rOf8Aw6mxwCDAQBg9/FMOz6bVLbGC8307TglKFKWpxVmC4iYrUj3FxWOv0emUDAstxbUDHqw4PxGZApjrsaTI6MxicnldBzuFR+FeHNJqZYL10jckXwIfhos1HW3f3RPa1YDUF979/65KIQRySjwQtbSatwRYYHwztRMQihzCMHB3zUZ9aYwmWj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMp4xuoFB96UMNnRUGXQiXL+gRlmel7/VlTfBBanuYE=;
 b=OS93eyGmR8u786Zq3NYfZPm+2mQoxQ8EAetz0k9Hccc6nRBGVUB2RHhuWg8xSQ1XQT4Qucy1lDbSWfRqzfQIBDhW5BuHdML9FTqwonUQ7ReetMYaXfWa5ygrL3jWf9mYjhvyhYJAp1k2RSd0LruT+SJMXervrJ1sy4kArYIIEpwEmPBwNxlRqvLCe5IP/VFPT8YDzrsAosJyjqGAORypIga4TJVFw6+vlqf1FJfzcasUAfmEGXBq+W8yvwOhlrqRr4Urf5rYVg4OwndXFls/s6nRmoi6gvQtWiFdLYY+b/Nop+zLFddMvT+nImam18PRmcDKzkU2rg3Bw5MhOP4jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB2861.namprd18.prod.outlook.com (2603:10b6:208:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 07:29:59 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 07:29:58 +0000
Subject: Re: [PATCH v4 1/2] btrfs: Move on-disk structure definition to
 btrfs_tree.h
From:   Qu Wenruo <wqu@suse.com>
To:     Christoph Hellwig <hch@infradead.org>, <dsterba@suse.cz>,
        <linux-btrfs@vger.kernel.org>
References: <20200415084113.64378-1-wqu@suse.com>
 <20200415084113.64378-2-wqu@suse.com> <20200421113138.GA10447@infradead.org>
 <18832f69-073f-ef74-5ec7-3de06df466df@suse.com>
 <20200424202445.GY18421@twin.jikos.cz> <20200425071416.GA30673@infradead.org>
 <8be35018-933f-5af9-50a5-85f610d08c5e@suse.com>
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
Message-ID: <13573de2-acea-33db-202a-c06221bd2cfd@suse.com>
Date:   Thu, 30 Apr 2020 15:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <8be35018-933f-5af9-50a5-85f610d08c5e@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 07:29:56 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76704ada-2c8e-4ed5-ea9b-08d7ecd848e2
X-MS-TrafficTypeDiagnostic: MN2PR18MB2861:
X-Microsoft-Antispam-PRVS: <MN2PR18MB2861FF81C8A954D0B3847438D6AA0@MN2PR18MB2861.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(66556008)(31686004)(66476007)(186003)(6666004)(66946007)(5660300002)(16526019)(2616005)(956004)(8936002)(2906002)(86362001)(6706004)(8676002)(31696002)(316002)(52116002)(36756003)(478600001)(6486002)(16576012)(26005)(78286006);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDPWmrHxLEFFz7ScVxOqM6oHOHcBstRdwQ7ATChpnDkPn2PYJ6d3coSDmtkGXHQmc5BuCVrp1+rGhMq6yrDDvchyd+8WXPrfnRo+VW7X1kYGglivFIuxUWafjZyydpeUPhDZM201cgOsBj29ClWZjfJzozhHVCuDxLHNdUs1riTkSznxJy2hcaH2PMOk84oNwPRxuSWLRXnR4Y9tvLl+Yhg6CCshE5vr2v3xGlqqqIo3Gla8zuQ45DEUxu0YCr03gbkWLvsUmVZke1dM+OQrb93ha++54eTh/gJwQ6GqdFl38iEv3DhGyiir7kzyeAZwiIMIEXTajWm/J7zOyie1FVLipfCXYFkjViYnuCIq26/i65ZvRDGdTc5g5rneh9HeVyhyEg9x/sesMxsTDyv4heqvLY/5p7/81kr7hRD1w9nteOHHswGd6MVnHPhziZOWU+6QxQQFmPa5Qv6wGiWjIRi2AkXEGLzB7ylxdSJxJQOwHZFH0FJAP4xRrYofPSQ9USJTdmGDTlyNB9IV0yBtisPQJTcdKXb7Z3ppgFq34+0=
X-MS-Exchange-AntiSpam-MessageData: 6BpPSNQLIxVpAbTRAphHAdCKP0RaYF55Mx6FBSKjgpFqhcgukm5KSE9mc2j9WecHSLMgu9R1w6OtcYyeMaxX17khNf3orZC948Rw8E/7ac2SmzSt+TdEi5QBBbpNX+8pCjuYcr7xW3Dv5C3V0vhM6AHYkMZN8hXZtQ1Upq1DvO+sBGw8RlkVn+pQKGMCBrzIDQ3biQMaJuA14hzvSMZXZSnDkmn6Wwtmo7GALKBUECI2lFLvgiy6hAbLwLV6qo0EbOI0NmwSNdVX+QxNdzpPutsHdWxj7s64z6OH9l0R/VaBdv65vD4HccoCg3lbBRnxcDIbeQ/DaNomvH55ckJW4wepaV9l0/1ehkyv5Nl5fGBCTBtw4ACT9bojzEFmvFjJ+MAzElYwNag7gdbP002uAy6yTJZemPaS8y1baHrmACfMK7PX0/nPSJSa76KKwchG2WtjZ/DveERs8V0kTHAuje9VQLwEdCrzFEo1alikJjj1XLaNUC3Aql0QFaZkcpEZq34X2eOBxT1VBa1K1SvJp4Lsln0wFmqeuwtp+WkpJoXFjBES3/9q/75STHRiMMI5lShhED8Rp6IG/r7UrBMbGUsYwG0he0at8NtkxsRD8H6tVkkJsPzSJNvOu7mrDizTzUAj+3hFXbe9bLgoZS/fFTRbPXZubrgBdgwDe6g8BFvnqyqJOz1YRDE2ktPUat2kuXk3mnV3h57egfBde2KzaMKq2qv/YjXQtxSWVs2QKgVlSRsnVLr0KnFDznixrnIv7IOH0GL+Dua1I30xC6mxB658CC239KWV7pgOVRnJ33Q=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76704ada-2c8e-4ed5-ea9b-08d7ecd848e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 07:29:57.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHbeIqBgBzbnUI3YjVuri/8jhWGKH4mEQ2roS6JEzl+QgiqGg9YoTd7Qm/HhW9qL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2861
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/25 下午3:25, Qu Wenruo wrote:
> 
> 
> On 2020/4/25 下午3:14, Christoph Hellwig wrote:
>> On Fri, Apr 24, 2020 at 10:24:45PM +0200, David Sterba wrote:
>>> On Tue, Apr 21, 2020 at 07:41:40PM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/4/21 下午7:31, Christoph Hellwig wrote:
>>>>> On Wed, Apr 15, 2020 at 04:41:12PM +0800, Qu Wenruo wrote:
>>>>>> These structures all are on-disk format. Move them to btrfs_tree.h
>>>>>>
>>>>>> This allows us to sync the header to different projects, who need to
>>>>>> read btrfs filesystem, like U-boot, grub.
>>>>>
>>>>> Please use a separate header for that.  btrfs_tree.h is a UAPI header
>>>>> with strict ABI guarantees.  Just add a fs/btrfs/btrfs_format.h that
>>>>> can be copied into the projects where is needed.
>>>>>
>>>> Doesn't on-disk format itself need strict ABI guarantees?
>>>>
>>>> Thus it looks like the perfect location for on-disk format definitions.
>>>
>>> Right now I'm not sure if it's a good idea to put the on-disk format to
>>> the UAPI path or not. The exported code is to support the ioctls,
>>> there's an overlap with the on-disk format but providing all the on-disk
>>> structures for general might become an unnecessry burden.
>>>
>>> We know that there's a small number of projects that want to sync the
>>> on-disk format so I don't think it's going to be a problem for them to
>>> use a private header.
>>
>> And the usual way is to just ensure the format header is self-contained
>> and suitably licensed that they can easily copy it and rely on the
>> version they checked in.  That avoids the problems of
>>
>>  a) the tools relying on installed kernel headers new enough for the
>>     feature they want to support
>>  b) ifdef magic for newer features in the tools
>>  c) the need to keep changes to the kernel format header to be backwards
>>     compatible at the compiler level (as there can be disk format
>>     compatible changes that still break users, e.g. introducing a named
>>     union, or splitting / merging struct definitions)
>>
> One last question.
> 
> Btrfs has one ioctl, which allow users to search btrfs on-disk data.
> 
> And the ioctl returns the on-disk data directly to user space, which
> means the on-disk format is also used by ioctl.
> 
> In that case, do we still need to put the on-disk format internal other
> than as a uapi?

After some tries, there are still problems especially for some flags
shared by ioctl and on-disk data.

E.g. We have a qgroup related ioctl, which uses some flag like
BTRFS_QGROUP_LIMIT_MAX_RFER.

But we also use that flag on-disk (obviously, we don't want spend try
time/code to do mapping of these flags).

Putting such flags to ioctl header, then we need to sync two headers to
other projects, while we care nothing about the ioctl part.

Putting such flags to on-disk format header, and put that header inside
fs/btrfs other than uapi, then ioctl doesn't have the definition of such
flags, and break user space programms.

So it looks like we'd better keep a on-disk format uapi header, and put
such flags to on-disk format uapi header, and ioctl header just includes
on-disk format header.

For user space, all needed flags are still kept as is.
For bootloader projects, they only need the on-disk format header.

Any extra ideas/feedback on this?

Thanks,
Qu
