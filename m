Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290A61F696E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFKNyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 09:54:25 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:50702
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgFKNyZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 09:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lstzHAl8LVhhU2Xb8pr9ingZMJ85r1S7OG6817YjaISPtDPvpFeMugHrIauEiBrasSQPMSAkLwqWytOI6nQq6EXQuOGtXbxTjDJps/KnIw3idHMta27ezFXZrVjvbc7yDn3DMRpZCTgOhwK2pQRTIRjhgsMxLI3qWBL92l5EsC9ZVWcIFTLPSwaSZ5PSfAIye+mHvWePHmMOPM4EgSK17SB0nwk6tri5rjsj9ARnZlvjplYotpfDylQITKMURP/l5qjKo1utayZa3aiZyErWyJ1rA+S9K8LlHatnPpV9zQXxeuvr7n+pjJ260vziA8LHBA+O+tZec/kl6o0TRjtQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZrFZ+eAovOhcylrZTqtpvIbLSuMAdXDzGfRckG1qzM=;
 b=UKo8dfnUPkn/4rse0RBUub6c3i18xJOcN8y0Dbuy7s/pGP10SKcO0WfBYkdOagzypbNadQ4nz+iMI5XVW5NZGnhrQf1mcd/S8XfPIr/v2dsFJGdf40pXZ0XW9AuvWd/heiGCVw6aZf1EXWdnUt04rtDJgj2dElgm6jPFCaanzR40kuhPySWx+dp9kctXMLNM+fWOa9xlf1KvtWM8NBYeXyIZnVrhj7PZFBFlTwIiezr9MCrxNIYOHHu0vEQcvVZmilZtRImhto1J3cYysnLCYpK5RPNU5JFeBcHchDF689GKfWmqxi+0iKb6lUOPcBQs8/Gyx7bPkRJ7jJBw31vWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZrFZ+eAovOhcylrZTqtpvIbLSuMAdXDzGfRckG1qzM=;
 b=Wr2bDB5FHmjHIgsST1y5i9u61wAa6UZOp2T9vMe0i/Lg+xzOxu8Jr+W+ZPzOCTKz7eOvBiNMVff/9EjG3mzOqNJWCQ0fJW8t89ejDs3EOYELkbsUWvkHh006tcsfb5emYFxv72MzXenKFTjRgCFjGa3RI//piQ2AmOk1pZQFaxA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:61::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 13:54:19 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609%5]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 13:54:18 +0000
Subject: Re: BTRFS File Delete Speed Scales With File Size?
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
Message-ID: <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
Date:   Thu, 11 Jun 2020 09:54:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
In-Reply-To: <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.20] (96.236.219.216) by BL0PR0102CA0026.prod.exchangelabs.com (2603:10b6:207:18::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 13:54:18 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a09cc18-6971-49b1-42b6-08d80e0eef7b
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Antispam-PRVS: <BYAPR08MB4935B525CDE1606D42BB53F3C2800@BYAPR08MB4935.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ew8NjCP8dK8CWsPzNX9Y81nZzRPfkUMu918hKdzRc6JmPkYz9CLh95R7Jln9uB+ye6IBLQ/bZWev1jHd2qt9RmUSocZQVpyfVxkXkJ6olZfG5vD0uVmxVHpDAYzPnNsxb8dGgL7T9t9wBuE/b+MdQa66UnJFIbAffHGnZgt8MvZeLUmhWVlYBYDxv0f91J/tn0EVcqAPiwZMqbsivEF315gkkKNShslQ92EipYLNL1AXLEjvscIKph0cDRFDGeTNSzNGURUTO88kmVfXVDWzpCimtjjmSSohqcMY62jcYQW0Bdad5oq7eJ5E8H8a2QUv+7Ds1Q1E6Y26xeJGZbk83FlJteZPc+zI36qpDZm6oYXeoxf7vTi1L9U12l26XaFtHI0oUJu+39UKgBCdu4KnGfSorSFPTITZVQapRE8EgTVtQLvO6L9uB7MMykc5dVCjVb7CmeivSPtZxpIyI+mE8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39840400004)(396003)(366004)(136003)(376002)(8936002)(16526019)(53546011)(36756003)(478600001)(5660300002)(2906002)(16576012)(30864003)(26005)(86362001)(8676002)(31686004)(83380400001)(186003)(6486002)(956004)(66946007)(2616005)(66556008)(966005)(6666004)(66476007)(6916009)(316002)(31696002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LHYKIBrjiKjulDGy3DIMikgLdL2LjJON0810M64yhMJymHbxWwcow6i0dQgUtTcO0n9oeXfxhF3FiVibeFDNQ0pDzb252A4de3xVQociZGdm856DTqPbQXvQfkUHn/qHok5DRhWxW7isCFIZg0MgQzi3LrAcHud+IhUJ9jpa4oL5nwBFo8lC3fZ4gfg0/TMAO6a94l3YV42iDp4eP47+STIvZISvfJk5z8nsuXllg6pPhRDhF5T6vPFU+AX0v39J9BL2uDBlxgj2+rpJ5fAKhWP11bJt9rePvHzQ55aZwzd40SqjOPPtchNubNWK67gsitjXwc5y5SQ9vKLmuPBzq/QqJu99XIRTWth/KeYJB8avNrYSdGj6x/iQL4i4GwJgrK/DbimF41hscUBvXOyWut72LPXPhz2bYvLQSu43AkxYL7dNl6Igt6+XDxTs8iFZEInRK84W/lM6HCCLfmJA2FxLFNwSVFboiiYo04ivzoA3Bn1BlMBIcQLKpa8BtRwN
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a09cc18-6971-49b1-42b6-08d80e0eef7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 13:54:18.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NKxdPAo2CCanYo8nCVcwWWFR2vpGpFobXIWfFDRZGqSUzBVnGX9WM6j82/MukDnqbaaORVwd+vLD7yW+K2yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It seems my first email from last night didn't go through.  Resending, 
but without the .txt attachment (all of it is described below in enough 
detail that I don't think it's needed).

On 6/10/20 9:23 PM, Ellis H. Wilson III wrote:
> Responses to each person below (sorry I thought it useful to collapse a 
> few emails into a single response due to the similar nature of the 
> comments):
> 
> 
> Adam:
> 
> Request for show_file.py output (extent_map.txt) for a basic 64GiB file 
> is attached.  It appears the segments are roughly 128MB in size, so 
> there are (and it reports) 512 of them, and they are all roughly 
> sequential on disk.  Obviously if I delete things in parallel (as our 
> end-users are extremely liable to do, us being a parallel file system 
> and all) one might expect seek time to dominate and some 10ms per 
> segment (~5s) to occur if you have to hit every segment before you 
> return to the caller.  Serial deletion testing shows an average time of 
> 1.66s across 10 data points, with decent variability, but the overall 
> average is at the upper-end of what we saw for parallel deletes 
> (30-40GB/s).
> 
> Is extent size adjustable (I couldn't find this trivially via search)? 
> Our drives are raided (raid0 via mdadm) together into ~72TB or (soon) 
> ~96TB BTRFS filesystems, and we manage small files on separate SSD 
> pools, so optimizing for very large data is highly viable if the options 
> exist to do so and we expect the seek from extent to extent is the 
> dominating time for deletion.  Side-effect information is welcome, or 
> you can point me to go read a specific architectural document and I'll 
> happily oblige.
> 
> 
> Martin:
> 
> Remounted with nodatasum:
> [478141.959269] BTRFS info (device md0): setting nodatasum
> 
> Created another 10x64GB files.  Average deletion speed for serial, 
> in-order deletion is 1.12s per file. This is faster than before, but 
> still slower than expected.  Oddly, I notice that for the first 5 
> deletions, the speed is /much/ faster: between 0.04s and 0.07s, which is 
> in the far more reasonable ~TB deleted per second range.  However, the 
> next 4 are around 1.7s per delete, and the 10th one takes 5s for some 
> reason.  Again, these were deleted in the order they were created and 
> one at a time rather than in parallel like my previous experiment.
> 
> 
> Hans:
> 
> Your script reports what I'd gathered from Adams suggestion to use your 
> other script:
> 
> Referencing data from 512 regular extents with total size 64.00GiB 
> average size 128.00MiB
> 
> No dedupe or compression enabled on our BTRFS filesystems at present.
> 
> Regarding the I/O pattern, I'd not taken block traces, but we notice 
> lots of low-bandwidth but high-activity reading (suggesting high 
> seeking) followed by shorter phases of the same kind of writes.
> 
> Regarding BTRFS metadata on SSDs -- I've mentioned it before on this 
> list but that would be an incredible feature add for us, and for more 
> than just deletion speed.  Do you know if that is being developed actively?
> 
> I did the same test (10x64GiB files, created in-order/serially, deleted 
> in-order/serially) on our SATA SSD that manages small files for us.  The 
> result was surprising:
> 
> time (for i in {1..10}; do time (rm test$i; sync); done)
> #snipped just the reals out:
> real    0m0.309s
> real    0m0.286s
> real    0m0.272s
> real    0m0.298s
> real    0m0.286s
> real    0m0.870s
> real    0m1.861s
> real    0m1.877s
> real    0m1.905s
> real    0m5.002s
> 
> Total:
> real    0m12.978s
> 
> So this shouldn't be a seek-dominated issue (though SATA this is an 
> enterprise-grade SSD), and I see the same pathology I saw when I tried 
> the nodatacow option for Martin.  Fast deletions up-front (though slower 
> than on the HDDs, which is weird), then a series of medium-slow 
> deletions, and then one long and slow deletion at the end.  I definitely 
> need to do a blocktrace on this.
> 
> /sys/fs/btrfs/<UUID>/features/free_space_tree *does* exist for the UUID 
> of the md0 HDD array and the single SATA SSD referred to above.
> 
> "* Organize incoming data in btrfs subvolumes in a way that enables you
> to remove the subvol instead of rm'ing the files."
> 
> A similar approach was explored already.  We find that if you remove the 
> subvolume, BTRFS does a better job of throttling itself in the kernel 
> while doing deletions and the disks are generally not as busy, but 
> subsequent reflinks across volumes stall horribly.  Frequently in the 
> tens of seconds range.  So our idea of "create a series of recycle bins 
> and delete them when they reach some threshold" didn't quite work 
> because moving new stuff being deleted in the foreground to one of the 
> other recycle bins would come to a screeching halt when another recycle 
> bin was being deleted.
> 
> "* Remove stuff in the same order as it got added."
> 
> We use temporal ordering of data into buckets for our parallel file 
> system (PFS) components to make things easier on the dirents, 
> nevertheless, we're at the mercy of the user's workload ultimately. 
> Nobody is removing anything like rm * as our PFS components are randomly 
> assigned IDs.
> 
> We realize the need to move to something newer, however, we've noticed 
> serious creation-rate degradation in recent revisions (that's for a 
> different thread) and don't presently have all of the upgrade hooks 
> in-place to do full OS upgrade yet anyhow.
> 
> Thanks again for everyone's comments, and if you have any additional 
> suggestions I'm all ears.
> 
> Best,  I respond when I get block graphs back.
> 
> ellis
> 
> 
> 
> On 6/9/20 7:09 PM, Hans van Kranenburg wrote:
>> Hi!
>>
>> On 6/9/20 5:31 PM, Ellis H. Wilson III wrote:
>>> Hi folks,
>>>
>>> We have a few engineers looking through BTRFS code presently for answers
>>> to this, but I was interested to get input from the experts in parallel
>>> to hopefully understand this issue quickly.
>>>
>>> We find that removes of large amounts of data can take a significant
>>> amount of time in BTRFS on HDDs -- in fact it appears to scale linearly
>>> with the size of the file.  I'd like to better understand the mechanics
>>> underpinning that behavior.
>>
>> Like Adam already mentioned, the amount and size of the individual
>> extent metadata items that need to be removed is one variable in the big
>> equation.
>>
>> The code in show_file.py example in python-btrfs is a bit outdated, and
>> it prints info about all extents that are referenced and a bit more.
>>
>> Alternatively, we can only look at the file extent items and calculate
>> the amount and average and total size (on disk):
>>
>> ---- >8 ----
>> #!/usr/bin/python3
>>
>> import btrfs
>> import os
>> import sys
>>
>> with btrfs.FileSystem(sys.argv[1]) as fs:
>>      inum = os.fstat(fs.fd).st_ino
>>      min_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, 0)
>>      max_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, -1)
>>      amount = 0
>>      total_size = 0
>>      for header, data in btrfs.ioctl.search_v2(fs.fd, 0, min_key, 
>> max_key):
>>          item = btrfs.ctree.FileExtentItem(header, data)
>>          if item.type != btrfs.ctree.FILE_EXTENT_REG:
>>              continue
>>          amount += 1
>>          total_size += item.disk_num_bytes
>>      print("Referencing data from {} regular extents with total size {} "
>>            "average size {}".format(
>>                amount, btrfs.utils.pretty_size(total_size),
>>                btrfs.utils.pretty_size(int(total_size/amount))))
>> ---- >8 ----
>>
>> If I e.g. point this at /bin/bash (compressed), I get:
>>
>> Referencing data from 9 regular extents with total size 600.00KiB
>> average size 66.67KiB
>>
>> The above code assumes that the real data extents are only referenced
>> once (no dedupe within the same file etc), otherwise you'll have to
>> filter them (and keep more stuff in memory). And, it ignores inlined
>> small extents for simplicity. Anyway, you can hack away on it to e.g.
>> make it look up more interesting things.
>>
>> https://python-btrfs.readthedocs.io/en/latest/btrfs.html#btrfs.ctree.FileExtentItem 
>>
>>
>>> See the attached graph for a quick experiment that demonstrates this
>>> behavior.  In this experiment I use 40 threads to perform deletions of
>>> previous written data in parallel.  10,000 files in every case and I
>>> scale files by powers of two from 16MB to 16GB.  Thus, the raw amount of
>>> data deleted also expands by 2x every step.  Frankly I expected deletion
>>> of a file to be predominantly a metadata operation and not scale with
>>> the size of the file, but perhaps I'm misunderstanding that.  While the
>>> overall speed of deletion is relatively fast (hovering between 30GB/s
>>> and 50GB/s) compared with raw ingest of data to the disk array we're
>>> using (in our case ~1.5GB/s) it can still take a very long time to
>>> delete data from the drives and removes hang completely until that data
>>> is deleted, unlike in some other filesystems.  They also compete
>>> aggressively with foreground I/O due to the intense seeking on the HDDs.
>>
>> What is interesting in this case is to see what kind of IO pattern the
>> deletes are causing (so, obviously, test without adding data). Like, how
>> much throughput for read and write, and how many iops read and write per
>> second (so that we can easily calculate average iop size).
>>
>> If most time is spent doing random read IO, then hope for a bright
>> future in which you can store btrfs metadata on solid state and the data
>> itself on cheaper spinning rust.
>>
>> If most time is spent doing writes, then what you're seeing is probably
>> what I call rumination, which is caused by making changes in metadata,
>> which leads to writing modified parts of metadata in free space again.
>>
>> The extent tree (which has info about the actual data extents on disk
>> that the file_extent_item ones seen above point to) is once of those,
>> and there's only one of that kind, which is even tracking its own space
>> allocation, which can lead to the effect of a cat or dog chasing it's
>> own tail. There have definitely been performance improvements in that
>> area, I don't know exactly where, but when I moved from 4.9 to 4.19
>> kernel, things improved a bit.
>>
>> There is a very long story at
>> https://www.spinics.net/lists/linux-btrfs/msg70624.html about these
>> kinds of things.
>>
>> There are unfortunately no easy accessible tools present yet that can
>> give live insight in what exactly is happening when it's writing
>> metadata like crazy.
>>
>>> This is with an older version of BTRFS (4.12.14-lp150.12.73-default) so
>>> if algorithms have changed substantially such that deletion rate is no
>>> longer tied to file size in newer versions please just say so and I'll
>>> be glad to take a look at that change and try with a newer version.
>>
>> That seems to be a suse kernel. I have no idea what kind of btrfs is in
>> there.
>>
>>> FWIW, we are using the v2 free space cache.
>>
>> Just to be sure, there are edge cases in which the filesystem says it's
>> using space cache v2, but actually isn't.
>>
>> Does /sys/fs/btrfs/<UUID>/features/free_space_tree exist?
>>
>> Or, of course a fun little program to just do a bogus search in it,
>> which explodes if it's not there:
>>
>> ---- >8 ----
>> #!/usr/bin/python3
>>
>> import btrfs
>>
>> with btrfs.FileSystem('/') as fs:
>>      try:
>>          list(fs.free_space_extents(0, 0))
>>          print("Yay!")
>>      except FileNotFoundError:
>>          print("No FST :(")
>> ---- >8 ----
>>
>> Space cache v1 will cause filesystem stalls combined with a burst of
>> writes on every 'transaction commit', and space cache v2 will cause more
>> random reads and writes, but they don't block the whole thing.
>>
>>> If any other information is
>>> relevant to this just let me know and I'll be glad to share.
>>
>> Suggestions for things to try, and see what difference it makes:
>>
>> * Organize incoming data in btrfs subvolumes in a way that enables you
>> to remove the subvol instead of rm'ing the files. If there are a lot of
>> files and stuff, this can be more efficient, since btrfs knows about
>> what parts to 'cut away' with a chainsaw when removing, instead of
>> telling it to do everything file by file in small steps. It also keeps
>> the size of the individual subvolume metadata trees down, reducing
>> rumination done by the cow. If you don't have them, your default fs tree
>> with all file info is relatively seen as large as the extent tree.
>>
>> * Remove stuff in the same order as it got added. Remember, rm * removes
>> files in alphabetical order, not in the order in which metadata was
>> added to disk (the inode number sequence). It might cause less jumping
>> around in metadata. Using subvolumes instead is still better, because in
>> that case the whole issue does not exist.
>>
>> * (not recommended) If your mount options do not show 'ssd' in them and
>> your kernel does not have this patch:
>> https://www.spinics.net/lists/linux-btrfs/msg64203.html then you can try
>> the mount -o ssd_spread,nossd (read the story in the link above).
>> Anyway, you're better off moving to something recent instead of trying
>> all these obsolete workarounds...
>>
>> If you have a kernel >= 4.14 then you're better off mounting with -o ssd
>> for rotational disks because the metadata writes are put more together
>> in bigger parts of free space, leading to less rumination. There is
>> still a lot of research and improvements to be done in this area (again,
>> see long post referenced above).
>>
>> If you have kernel < 4.14, then definitely do not mount with -o ssd, but
>> even mount ssds with -o nossd explicitly. (yes, that's also a long 
>> story)...
>>
>> Fun! :) /o\
>>
>>> Thank you for any time people can spare to help us understand this 
>>> better!
>>
>> Don't hesitate to ask more questions,
>> Have fun,
>> Hans
>>
> 

