Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192FD38F9AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 06:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhEYEpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 00:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhEYEpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 00:45:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P4YaRc058292;
        Tue, 25 May 2021 00:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=6VLdwdPPP1nmq5tNo9O1nTeD8X+eenyyKNyioKNcRnM=;
 b=WA3ewVByi+Vsd2PLuV/bDeuzv7BYgPZbzoB0tVLhrLFVOTzwb8kk18jeg0Mu/+DrbyNT
 OZrOz4tE+vwAfWOx2KF1iZ6WzOXpC9ucsMsBpczwZMAYdPOLHRBuKpjEPhai6/FAzXwq
 J6C1zTk3SkQpIn5QAwxnm29kBoc+ksS7M/WuwEsdAQI/HJAGsNA6rzVDNHQrBI+5QdAW
 WKfTnetFHZWZPoIvRhenfA7+3oVJIsxqR8j/0Y9lOWkfRM1IynihQqgBgSZ+Ek2swBDM
 up3bOOdkmkSn09gZ4jszWdD2rfwPxtWC84yR/cepv8YGEIJwehij9wsIM14kYOVn8kws 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rryahyac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 00:43:13 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14P4ZU2b063771;
        Tue, 25 May 2021 00:43:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rryahy9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 00:43:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14P4dS4B031685;
        Tue, 25 May 2021 04:43:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 38psk8932d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 04:43:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14P4h8do18546976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 04:43:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300E0A4053;
        Tue, 25 May 2021 04:43:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0763A4057;
        Tue, 25 May 2021 04:43:07 +0000 (GMT)
Received: from localhost (unknown [9.199.34.137])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 04:43:07 +0000 (GMT)
Date:   Tue, 25 May 2021 10:13:07 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
References: <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
 <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
 <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zUO_4BnLhB4ye7RsOPj3myvhW2HmHcoG
X-Proofpoint-ORIG-GUID: SvLBw9GGT6x5AaBbZMKxexAAmSzVcWjh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250029
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/15 06:15PM, Qu Wenruo wrote:
>
>
> On 2021/5/15 下午5:59, Ritesh Harjani wrote:
> > On 21/05/15 06:22AM, Qu Wenruo wrote:
> > >
> > >
> > > >
> > > > Hi Qu,
> > > >
> > > > Thanks for pointing this out. I could see that w/o your new fix I could
> > > > reproduce the BUG_ON() crash. But with your patch the test btrfs/195 still
> > > > fails.  I guess that is expected right, since
> > > > "RAID5/6 is not supported yet for sectorsize 4096 with page size 65536"?
> > > >
> > > > Is my understanding correct?
> > >
> > > Yep, the test is still going to fail, as we reject such convert.
> > >
> > > There are tons of other btrfs tests that fails due to the same reason.
> > >
> > > Some of them can be avoided using "BTRFS_PROFILE_CONFIGS" environment
> > > variant to avoid raid5/6, but not all.
> > >
> > > Thus I'm going to update those tests to use that variant to make it
> > > easier to rule out certain profiles.
> >
> > Hello Qu,
> >
> > Sorry to bother you again. While running your latest full patch series, I found
> > below two failures, no crashes though :)
> > Could you please take a look at it.
> >
> > 1. btrfs/141 failure.
> > xfstests.global-btrfs/4k.btrfs/141
> > Error Details
> > - output mismatch (see /results/btrfs/results-4k/btrfs/141.out.bad)
>
> Strangely, it passes locally.
>
> >
> > Standard Output
> > step 1......mkfs.btrfs
> > step 2......corrupt file extent
> > Filesystem type is: 9123683e
> > File size of /vdc/foobar is 131072 (32 blocks of 4096 bytes)
> >   ext:     logical_offset:        physical_offset: length:   expected: flags:
> >     0:        0..      31:      33632..     33663:     32:             last,eof
> > /vdc/foobar: 1 extent found
> >   corrupt stripe #1, devid 2 devpath /dev/vdi physical 116785152
> > step 3......repair the bad copy
> >
> >
> > Standard Error
> > --- tests/btrfs/141.out	2021-04-24 07:27:39.000000000 +0000
> > +++ /results/btrfs/results-4k/btrfs/141.out.bad	2021-05-14 18:46:23.720000000 +0000
> > @@ -1,37 +1,37 @@
> >   QA output created by 141
> >   wrote 131072/131072 bytes
> >   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> > +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
> >   read 512/512 bytes
> >   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>
> The output means the bad copy is not repaired, which is pretty strange.
> Since my latest work is to make the read repair work in 4K size.
>
> Mind to test the attached script? (Of coures, you need to change the $dev
> and $mnt according to your environment)
>
> It would do the same work as btrfs/141, but using scrub to make sure every
> thing is correct.
>
> Locally, I haven't yet hit a failure for btrfs/141 yet.

Hello Qu,

Sorry about the long delay on this one. I coudn't hit the issue with your test
patch on my machine. Also instead of running btrfs/141 standalone when we run it
with btrfs/140, the issue is hitting more often.

Can you try running below to see if it hits in your case?

./check -I 20 btrfs/140 btrfs/141


-ritesh

>
> >
> >
> > 2. btrfs/124 failure.
> >
> > I guess below could be due to small size of the device?
> >
> > xfstests.global-btrfs/4k.btrfs/124
> > Error Details
> > - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad)
>
> Again passes locally.
>
> But accroding to your fs, I notice several unbalanced disk usage:
>
> # /usr/local/bin/btrfs filesystem show
> Label: none  uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
> 	Total devices 2 FS bytes used 32.00KiB
> 	devid    1 size 5.00GiB used 622.38MiB path /dev/vdc
> 	devid    2 size 2.00GiB used 622.38MiB path /dev/vdi
>
> Label: none  uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
> 	Total devices 4 FS bytes used 379.12MiB
> 	devid    1 size 5.00GiB used 8.00MiB path /dev/vdb
> 	devid    3 size 20.00GiB used 264.00MiB path /dev/vde
> 	devid    4 size 20.00GiB used 1.26GiB path /dev/vdf
>
> We had reports about btrfs doing poor work when handling unbalanced disk
> sizes.
> I had a purpose to fix it, with a little better calcuation, but still not
> yet perfect.
>
> Thus would you mind to check if the test pass when all the disks in
> SCRATCH_DEV_POOL are in the same size?
>
> Of course we need to fix the problem of ENOSPC for unbalanced disks, but
> that's a common problem and not exacly related to subpage.
> I should take some time to refresh the unbalanced disk usage patches soon.
>
> Thanksm
> Qu
>
> [...]
> >
> > -ritesh
> >


