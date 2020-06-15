Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF01FA323
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFOWA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 18:00:59 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:6111
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgFOWA5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 18:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/Phy8x5CWeMfxat5DjgiYWF+8QuAISnpob2tmYrFLpJ6BTur3G19y1IaBuiBQSUXhe76lnmFmeMrP/9QwrYRkU5PwCbuZ3KC0cuOpvfxhyY8zEapeonQ95hKMChhjBaFSI84cphgSjk8rbbfqsNlQlvy4MBBrrNQcol/Ac8IRK8kT6MOn2C7F2+GA9ZoyOc+yj6yvH1M7LJWypBa6zml2nyKeK+ZoWZTpSKCXdxuNR6jyy1j4dMGYrhjjG+9kj/5/BuCy9s3TCFrrfTp5Bob17lU2QW4EI0us2DmntjOmm3snhVMq/UXe4Vv3QYM0KAE1kKvAqkhN2/g/wbmygUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7RaAoK23m0eOKBEHAZETeqDUnzqcqRAxmVIO+ku8t0=;
 b=IR/Vq6+FiQlExJXl6hR0/GhKY8VeLIUNFcv/nhkUXSz7W5Y0qp2x5w3CjDVQU7OERWMnDtTuBNxcoBtNPkxgSR5wnWx/IH2I4kszC2/TeddYpgq2gZ3TtV9ERrv2x3z1biy3BFtWegC9sQh1s1VHErugrto1si1tVWprwGzkP+nIdcsWxVvg7pZnCO7W00n6dN9DSLKWjnpV7xE7/Hil3H+/ND4POYQsgACNDjjGfAZBEV1AbKsq+dkyUToAsnaxJSLm/M4u9qwdZkJ3K3/YE3PzfVhNm5j0KBEBkNd7mAeHQrIu0OMFBhS8x8A84/bmvKgw7LDXBeYgSkpoLhesSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7RaAoK23m0eOKBEHAZETeqDUnzqcqRAxmVIO+ku8t0=;
 b=QhNLtLzDobvN5wIencWS4j+AkSruOzAC9ZSws5xRedx908M86kqcS8oIhjozQeSMeqtmIvBqg3VFskC86Wm9MjWZkIx+UA+WZ5anpNBnm7K3CLgez7tqmeVO4RcQEdrYT3MScjD9zv1JyoeGqFdRwQLMLEbiU45hcfphf/YMvlc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5991.namprd08.prod.outlook.com (2603:10b6:a03:124::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.26; Mon, 15 Jun
 2020 22:00:50 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609%5]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 22:00:50 +0000
Subject: Re: BTRFS File Delete Speed Scales With File Size?
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
 <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
Message-ID: <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
Date:   Mon, 15 Jun 2020 18:00:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
In-Reply-To: <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.20] (96.236.219.216) by MN2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:208:e8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 22:00:49 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54919363-39db-4bf8-b3ff-08d8117790c5
X-MS-TrafficTypeDiagnostic: BYAPR08MB5991:
X-Microsoft-Antispam-PRVS: <BYAPR08MB59914096FE5059CF51BEB1BDC29C0@BYAPR08MB5991.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0XDokSE2hUu8p4NI5k0Qffb1Yma2hPysDw+0DbhqSJIMiTGUWWNMCLic7JvaalcxGYbDBhZriCa8DVTyn4PxIyEKsWU4ai3P0J53UDQ1oYkyL+FGaxTRTzWmDzROGxXwnwwRGESci+BZZ8/hO0dT5/jwsKR8NSx5ApJGu9uKTTwnnpr4algL6DT0ZUuTd9ruB4aOCVUi1EVVeatDE9MIOPOWeDuoLxFOdeq2VfBqG6wSe34NXkBkLk0y7yTu8x7EmPEF8zRzDxnK3otJObum5qh1Ch1VisQPo0wvsEgeiwNGKtKjeYddpTluK80T3a9f7UUJ9sHK6yWm7bzTVJUVzf/s8nzEJGp0Fd4hACj9Q5CGxMdxbcGA3g/Bb48H+FTGUq5zbVZMr9JXDc7wQHXmaaSSjjWuZ70H73tHNODB23Hj5GjOf0SZbb2gaafgwhXa6t3XFIWWPgbL1qR8GNZkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(396003)(366004)(136003)(376002)(346002)(31696002)(8936002)(16576012)(31686004)(52116002)(83380400001)(53546011)(6486002)(2616005)(316002)(956004)(86362001)(8676002)(16526019)(186003)(66476007)(66556008)(36756003)(66946007)(6916009)(966005)(478600001)(2906002)(30864003)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vcRLm/GoyljadMLJGrSXIHGZG8/I5vC5quqwhiup027wjYLlwg5FHrzp5ODVhOeBWqNqSWbCeG/jKPd+D8sPqLW/y6wWtkJWCukc5oYZXNHIGp/i8YLXw0OF2ycIIO42kkQRcs4PV6uLgSSjALjc4hwta6f76zO64QReDoHo6XiZ4CDBI+kLKFndEM5wNL6Gb6ZhcfksZ2Du6OescydqfEhTQ5dM7tglTsP7/RY1gqYRttAz7dhxv6015iM96mnUHM3DxCE+1MlHHInFReL3urSIjcDtI2mCCvs3oaBVFRiWeIad69C3u90eYdFIwEMUrvSgAzRmSjfFynwUfrRY3yDLv6TjEvSoHzW5V4fUDIcwkd85CFDa2cFDWrvNfOq/qTNOum98nEkTs2qg+ZGq84KwKZfsGXRhLNRIKq5Da6YfvXeJ6xpYyXeX7vELGtT3yYj5w07k2ZK+3oxpmxDVJNiSuYuGFsICP3EFPqmIVVXUZGM0J72ddw/UQhiw3L6c
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54919363-39db-4bf8-b3ff-08d8117790c5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 22:00:50.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVW2GwscyR/zz4VHpjtEetiV1R5kRfGARanHdb8NcnIjdgwmQiqvS2bi2G3AjZ8CNTGevg72Ky1vRqTXhDTpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5991
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some follow-ups:

1. We've discovered that background dirty sync will cause the deletion 
slow-downs I witnessed before.  If we sync and drop all vm caches before 
starting, the deletion speed for a 64GiB file averages around 2.5s.

2. We find that speed to delete and fsync the directory on 4.12 is 
equivalent to delete and then sync the entire filesystem.

3. We tested on 5.7.1-1-default, the vanilla release available in 
tumbleweed openSuSE.  We find that removes are greatly improved 
(20x64GiB files removed, serially, in the order they were created, an 
fsync of the directory holding them done after each remove, and all 
caches dropped before beginning):

  real    0m0.112s
  real    0m0.024s
  real    0m0.038s
  real    0m0.039s
  real    0m0.017s
  real    0m0.032s
  real    0m0.073s
  real    0m0.019s
  real    0m0.041s
  real    0m0.029s
  real    0m0.034s
  real    0m0.030s
  real    0m0.023s
  real    0m0.012s
  real    0m0.020s
  real    0m0.035s
  real    0m0.013s
  real    0m0.066s
  real    0m0.014s
  real    0m0.007s

We further note background busy-ness by btrfs transaction many seconds 
later, suggestion a new approach to unlink better mirrors how BTRFS 
manages subvolume deletion.

4. We also note that deletion speed goes back to the slow speeds 
reported before if you add a full sync after every remove rather than a 
targeted fsync.  This is relatively unsurprising given the different 
expectations, though an interesting finding given that merely fsync'ing 
didn't help in the case of 4.12.

Any comments on when major change(s) came in that would impact these 
behaviors would be greatly appreciated.

Thanks,

ellis


On 6/11/20 9:54 AM, Ellis H. Wilson III wrote:
> It seems my first email from last night didn't go through.  Resending, 
> but without the .txt attachment (all of it is described below in enough 
> detail that I don't think it's needed).
> 
> On 6/10/20 9:23 PM, Ellis H. Wilson III wrote:
>> Responses to each person below (sorry I thought it useful to collapse 
>> a few emails into a single response due to the similar nature of the 
>> comments):
>>
>>
>> Adam:
>>
>> Request for show_file.py output (extent_map.txt) for a basic 64GiB 
>> file is attached.  It appears the segments are roughly 128MB in size, 
>> so there are (and it reports) 512 of them, and they are all roughly 
>> sequential on disk.  Obviously if I delete things in parallel (as our 
>> end-users are extremely liable to do, us being a parallel file system 
>> and all) one might expect seek time to dominate and some 10ms per 
>> segment (~5s) to occur if you have to hit every segment before you 
>> return to the caller.  Serial deletion testing shows an average time 
>> of 1.66s across 10 data points, with decent variability, but the 
>> overall average is at the upper-end of what we saw for parallel 
>> deletes (30-40GB/s).
>>
>> Is extent size adjustable (I couldn't find this trivially via search)? 
>> Our drives are raided (raid0 via mdadm) together into ~72TB or (soon) 
>> ~96TB BTRFS filesystems, and we manage small files on separate SSD 
>> pools, so optimizing for very large data is highly viable if the 
>> options exist to do so and we expect the seek from extent to extent is 
>> the dominating time for deletion.  Side-effect information is welcome, 
>> or you can point me to go read a specific architectural document and 
>> I'll happily oblige.
>>
>>
>> Martin:
>>
>> Remounted with nodatasum:
>> [478141.959269] BTRFS info (device md0): setting nodatasum
>>
>> Created another 10x64GB files.  Average deletion speed for serial, 
>> in-order deletion is 1.12s per file. This is faster than before, but 
>> still slower than expected.  Oddly, I notice that for the first 5 
>> deletions, the speed is /much/ faster: between 0.04s and 0.07s, which 
>> is in the far more reasonable ~TB deleted per second range.  However, 
>> the next 4 are around 1.7s per delete, and the 10th one takes 5s for 
>> some reason.  Again, these were deleted in the order they were created 
>> and one at a time rather than in parallel like my previous experiment.
>>
>>
>> Hans:
>>
>> Your script reports what I'd gathered from Adams suggestion to use 
>> your other script:
>>
>> Referencing data from 512 regular extents with total size 64.00GiB 
>> average size 128.00MiB
>>
>> No dedupe or compression enabled on our BTRFS filesystems at present.
>>
>> Regarding the I/O pattern, I'd not taken block traces, but we notice 
>> lots of low-bandwidth but high-activity reading (suggesting high 
>> seeking) followed by shorter phases of the same kind of writes.
>>
>> Regarding BTRFS metadata on SSDs -- I've mentioned it before on this 
>> list but that would be an incredible feature add for us, and for more 
>> than just deletion speed.  Do you know if that is being developed 
>> actively?
>>
>> I did the same test (10x64GiB files, created in-order/serially, 
>> deleted in-order/serially) on our SATA SSD that manages small files 
>> for us.  The result was surprising:
>>
>> time (for i in {1..10}; do time (rm test$i; sync); done)
>> #snipped just the reals out:
>> real    0m0.309s
>> real    0m0.286s
>> real    0m0.272s
>> real    0m0.298s
>> real    0m0.286s
>> real    0m0.870s
>> real    0m1.861s
>> real    0m1.877s
>> real    0m1.905s
>> real    0m5.002s
>>
>> Total:
>> real    0m12.978s
>>
>> So this shouldn't be a seek-dominated issue (though SATA this is an 
>> enterprise-grade SSD), and I see the same pathology I saw when I tried 
>> the nodatacow option for Martin.  Fast deletions up-front (though 
>> slower than on the HDDs, which is weird), then a series of medium-slow 
>> deletions, and then one long and slow deletion at the end.  I 
>> definitely need to do a blocktrace on this.
>>
>> /sys/fs/btrfs/<UUID>/features/free_space_tree *does* exist for the 
>> UUID of the md0 HDD array and the single SATA SSD referred to above.
>>
>> "* Organize incoming data in btrfs subvolumes in a way that enables you
>> to remove the subvol instead of rm'ing the files."
>>
>> A similar approach was explored already.  We find that if you remove 
>> the subvolume, BTRFS does a better job of throttling itself in the 
>> kernel while doing deletions and the disks are generally not as busy, 
>> but subsequent reflinks across volumes stall horribly.  Frequently in 
>> the tens of seconds range.  So our idea of "create a series of recycle 
>> bins and delete them when they reach some threshold" didn't quite work 
>> because moving new stuff being deleted in the foreground to one of the 
>> other recycle bins would come to a screeching halt when another 
>> recycle bin was being deleted.
>>
>> "* Remove stuff in the same order as it got added."
>>
>> We use temporal ordering of data into buckets for our parallel file 
>> system (PFS) components to make things easier on the dirents, 
>> nevertheless, we're at the mercy of the user's workload ultimately. 
>> Nobody is removing anything like rm * as our PFS components are 
>> randomly assigned IDs.
>>
>> We realize the need to move to something newer, however, we've noticed 
>> serious creation-rate degradation in recent revisions (that's for a 
>> different thread) and don't presently have all of the upgrade hooks 
>> in-place to do full OS upgrade yet anyhow.
>>
>> Thanks again for everyone's comments, and if you have any additional 
>> suggestions I'm all ears.
>>
>> Best,  I respond when I get block graphs back.
>>
>> ellis
>>
>>
>>
>> On 6/9/20 7:09 PM, Hans van Kranenburg wrote:
>>> Hi!
>>>
>>> On 6/9/20 5:31 PM, Ellis H. Wilson III wrote:
>>>> Hi folks,
>>>>
>>>> We have a few engineers looking through BTRFS code presently for 
>>>> answers
>>>> to this, but I was interested to get input from the experts in parallel
>>>> to hopefully understand this issue quickly.
>>>>
>>>> We find that removes of large amounts of data can take a significant
>>>> amount of time in BTRFS on HDDs -- in fact it appears to scale linearly
>>>> with the size of the file.  I'd like to better understand the mechanics
>>>> underpinning that behavior.
>>>
>>> Like Adam already mentioned, the amount and size of the individual
>>> extent metadata items that need to be removed is one variable in the big
>>> equation.
>>>
>>> The code in show_file.py example in python-btrfs is a bit outdated, and
>>> it prints info about all extents that are referenced and a bit more.
>>>
>>> Alternatively, we can only look at the file extent items and calculate
>>> the amount and average and total size (on disk):
>>>
>>> ---- >8 ----
>>> #!/usr/bin/python3
>>>
>>> import btrfs
>>> import os
>>> import sys
>>>
>>> with btrfs.FileSystem(sys.argv[1]) as fs:
>>>      inum = os.fstat(fs.fd).st_ino
>>>      min_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, 0)
>>>      max_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, -1)
>>>      amount = 0
>>>      total_size = 0
>>>      for header, data in btrfs.ioctl.search_v2(fs.fd, 0, min_key, 
>>> max_key):
>>>          item = btrfs.ctree.FileExtentItem(header, data)
>>>          if item.type != btrfs.ctree.FILE_EXTENT_REG:
>>>              continue
>>>          amount += 1
>>>          total_size += item.disk_num_bytes
>>>      print("Referencing data from {} regular extents with total size 
>>> {} "
>>>            "average size {}".format(
>>>                amount, btrfs.utils.pretty_size(total_size),
>>>                btrfs.utils.pretty_size(int(total_size/amount))))
>>> ---- >8 ----
>>>
>>> If I e.g. point this at /bin/bash (compressed), I get:
>>>
>>> Referencing data from 9 regular extents with total size 600.00KiB
>>> average size 66.67KiB
>>>
>>> The above code assumes that the real data extents are only referenced
>>> once (no dedupe within the same file etc), otherwise you'll have to
>>> filter them (and keep more stuff in memory). And, it ignores inlined
>>> small extents for simplicity. Anyway, you can hack away on it to e.g.
>>> make it look up more interesting things.
>>>
>>> https://python-btrfs.readthedocs.io/en/latest/btrfs.html#btrfs.ctree.FileExtentItem 
>>>
>>>
>>>> See the attached graph for a quick experiment that demonstrates this
>>>> behavior.  In this experiment I use 40 threads to perform deletions of
>>>> previous written data in parallel.  10,000 files in every case and I
>>>> scale files by powers of two from 16MB to 16GB.  Thus, the raw 
>>>> amount of
>>>> data deleted also expands by 2x every step.  Frankly I expected 
>>>> deletion
>>>> of a file to be predominantly a metadata operation and not scale with
>>>> the size of the file, but perhaps I'm misunderstanding that.  While the
>>>> overall speed of deletion is relatively fast (hovering between 30GB/s
>>>> and 50GB/s) compared with raw ingest of data to the disk array we're
>>>> using (in our case ~1.5GB/s) it can still take a very long time to
>>>> delete data from the drives and removes hang completely until that data
>>>> is deleted, unlike in some other filesystems.  They also compete
>>>> aggressively with foreground I/O due to the intense seeking on the 
>>>> HDDs.
>>>
>>> What is interesting in this case is to see what kind of IO pattern the
>>> deletes are causing (so, obviously, test without adding data). Like, how
>>> much throughput for read and write, and how many iops read and write per
>>> second (so that we can easily calculate average iop size).
>>>
>>> If most time is spent doing random read IO, then hope for a bright
>>> future in which you can store btrfs metadata on solid state and the data
>>> itself on cheaper spinning rust.
>>>
>>> If most time is spent doing writes, then what you're seeing is probably
>>> what I call rumination, which is caused by making changes in metadata,
>>> which leads to writing modified parts of metadata in free space again.
>>>
>>> The extent tree (which has info about the actual data extents on disk
>>> that the file_extent_item ones seen above point to) is once of those,
>>> and there's only one of that kind, which is even tracking its own space
>>> allocation, which can lead to the effect of a cat or dog chasing it's
>>> own tail. There have definitely been performance improvements in that
>>> area, I don't know exactly where, but when I moved from 4.9 to 4.19
>>> kernel, things improved a bit.
>>>
>>> There is a very long story at
>>> https://www.spinics.net/lists/linux-btrfs/msg70624.html about these
>>> kinds of things.
>>>
>>> There are unfortunately no easy accessible tools present yet that can
>>> give live insight in what exactly is happening when it's writing
>>> metadata like crazy.
>>>
>>>> This is with an older version of BTRFS (4.12.14-lp150.12.73-default) so
>>>> if algorithms have changed substantially such that deletion rate is no
>>>> longer tied to file size in newer versions please just say so and I'll
>>>> be glad to take a look at that change and try with a newer version.
>>>
>>> That seems to be a suse kernel. I have no idea what kind of btrfs is in
>>> there.
>>>
>>>> FWIW, we are using the v2 free space cache.
>>>
>>> Just to be sure, there are edge cases in which the filesystem says it's
>>> using space cache v2, but actually isn't.
>>>
>>> Does /sys/fs/btrfs/<UUID>/features/free_space_tree exist?
>>>
>>> Or, of course a fun little program to just do a bogus search in it,
>>> which explodes if it's not there:
>>>
>>> ---- >8 ----
>>> #!/usr/bin/python3
>>>
>>> import btrfs
>>>
>>> with btrfs.FileSystem('/') as fs:
>>>      try:
>>>          list(fs.free_space_extents(0, 0))
>>>          print("Yay!")
>>>      except FileNotFoundError:
>>>          print("No FST :(")
>>> ---- >8 ----
>>>
>>> Space cache v1 will cause filesystem stalls combined with a burst of
>>> writes on every 'transaction commit', and space cache v2 will cause more
>>> random reads and writes, but they don't block the whole thing.
>>>
>>>> If any other information is
>>>> relevant to this just let me know and I'll be glad to share.
>>>
>>> Suggestions for things to try, and see what difference it makes:
>>>
>>> * Organize incoming data in btrfs subvolumes in a way that enables you
>>> to remove the subvol instead of rm'ing the files. If there are a lot of
>>> files and stuff, this can be more efficient, since btrfs knows about
>>> what parts to 'cut away' with a chainsaw when removing, instead of
>>> telling it to do everything file by file in small steps. It also keeps
>>> the size of the individual subvolume metadata trees down, reducing
>>> rumination done by the cow. If you don't have them, your default fs tree
>>> with all file info is relatively seen as large as the extent tree.
>>>
>>> * Remove stuff in the same order as it got added. Remember, rm * removes
>>> files in alphabetical order, not in the order in which metadata was
>>> added to disk (the inode number sequence). It might cause less jumping
>>> around in metadata. Using subvolumes instead is still better, because in
>>> that case the whole issue does not exist.
>>>
>>> * (not recommended) If your mount options do not show 'ssd' in them and
>>> your kernel does not have this patch:
>>> https://www.spinics.net/lists/linux-btrfs/msg64203.html then you can try
>>> the mount -o ssd_spread,nossd (read the story in the link above).
>>> Anyway, you're better off moving to something recent instead of trying
>>> all these obsolete workarounds...
>>>
>>> If you have a kernel >= 4.14 then you're better off mounting with -o ssd
>>> for rotational disks because the metadata writes are put more together
>>> in bigger parts of free space, leading to less rumination. There is
>>> still a lot of research and improvements to be done in this area (again,
>>> see long post referenced above).
>>>
>>> If you have kernel < 4.14, then definitely do not mount with -o ssd, but
>>> even mount ssds with -o nossd explicitly. (yes, that's also a long 
>>> story)...
>>>
>>> Fun! :) /o\
>>>
>>>> Thank you for any time people can spare to help us understand this 
>>>> better!
>>>
>>> Don't hesitate to ask more questions,
>>> Have fun,
>>> Hans
>>>
>>
> 

