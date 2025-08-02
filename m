Return-Path: <linux-btrfs+bounces-15810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B680CB18E96
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C412189F838
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4B7238C1E;
	Sat,  2 Aug 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e/NjgStH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6C22B8A5;
	Sat,  2 Aug 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140037; cv=none; b=MIu5gLEYLxT3LYJVMLxwt59YNIWoLftLyEkv/5+sm+ROAE6wC4BJZbiAVZdZkUUozRDA2Ow0PCX7rDhQzArG2WypW6g4H78F0cI4eZh6zdQEQc0Vddf+8EoMlxeCdahiiKIHLMF2tBpV9vp2Cp1fnTSKD1AE6Wqm7UVyAtvGOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140037; c=relaxed/simple;
	bh=eSwVj2anjL6uavRReSp+I2T7GtFd9V6n0Ns5L3SOmB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA/aOcy9YanhG0M1OdgHXcGyBkoFIQN4y0sxF2ttArS52Fz1K2ZX6IbIYx0WBbh8vj7lo0aov26yWEb9LuF49rZYFdxzVn6+Cj6tsJ4LZEZHuzM18yczPv6a1yfVgWGVTt4pxRnoXpCK58T0N7aRp/AJIPQLbiS30uA3oAZY0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e/NjgStH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5729DdSc007522;
	Sat, 2 Aug 2025 13:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tfnkIB
	+EhAVz28BXzs+l0nfD+GV6VQ8YHQ+DGuchJ6w=; b=e/NjgStHtfvMgc/3RMykD2
	8mzOvAGxWxXxRprtIqKLN23wZ/UjxINJg0KXrjMEhQOhsfw1sN4XhLtv7BGV3WjM
	f5zEB4ZAYIs6WmxvOVuxxSMO9DNK/1tzxd1sCMSa19d2at1jjGnspK401jgU6H7Y
	/AgFvAXNA+E8P62ESnrkZB9Ymfw8XEXpLc0eg/xmp/3yH1+qVY0+Kl07kOrNOwKf
	vGEBEXCH/T1jfWpPvbiG319JirvpGqihzFCVgkMScWj80/skco16pdKR1zuh+AqY
	Lu0bRA6Fky2GoO2e2k0Lg1kXkDkVYQb/m8r98gwHgGj46FX+KIXYt4xDAULqeplw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ade1crt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 13:07:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 572D7C3x028923;
	Sat, 2 Aug 2025 13:07:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ade1crs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 13:07:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5729cFTk032546;
	Sat, 2 Aug 2025 13:07:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489b0j1c3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 13:07:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 572D79YC39387528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Aug 2025 13:07:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5954920040;
	Sat,  2 Aug 2025 13:07:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 084D620043;
	Sat,  2 Aug 2025 13:07:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.72])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  2 Aug 2025 13:07:07 +0000 (GMT)
Date: Sat, 2 Aug 2025 18:37:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/282: use timed writes to make sure scrub has
 enough run time
Message-ID: <aI4NePrCRM1ax5uy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250711084305.183675-1-wqu@suse.com>
 <aI3LmZVbl5H--QJ8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <88c659f6-b0a6-4ca3-bbc7-8064ec608c32@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88c659f6-b0a6-4ca3-bbc7-8064ec608c32@gmx.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NqLRc9dJ c=1 sm=1 tr=0 ts=688e0d81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8
 a=iox4zFpeAAAA:8 a=XGp00KZF7QKn5TESG2IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: auBCz5kiMDV0l8a-azQ1Wk0sWheywKNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwOCBTYWx0ZWRfX5mWNzAP9iX4h
 i9tcEgZPEG/j5j7BQB2BUk1rucd+hL6t6/Q1bTo4EEfetxZrgNIZDk1Mnu9ChHSwx24yOsrPgs2
 lRHZ9LlrkdcPCnR3KylSm6LRZ9WC57H0Sh9xVb8RuvASWKN2vMhvsvREcgZjFVKkR6Gvfj/S0a7
 bylWaDggVcu2T3ijlbQ6WPp9OgnN5c4C2aanzPkJoat2kdotRe01nH5k4W472Bd3DgxKzfXulwB
 8aeh7Hl8NnwIpbEjjwV+b1mePV0XzzWNRcPZgxqeUlsleIZ96pJwiOKpbuG1SUDZOSPFIAeor/k
 F+WgD95As4ZI4MvlprFWdTUL5BCn9G0f8MLlefwPkMWiOnuS6Ex4eNyKvIlnuI4k2eqkyjQCtg5
 I0ullsCLvDcmuPZFjLHiP87NZZY9Vh9CN+9VLeoEjE53jINMX4XP8hapzZos8AzKFdDUgZb8
X-Proofpoint-GUID: S7Sk4l3T2ISjC3Kd1gG_Uz26sqNBjF13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508020108

On Sat, Aug 02, 2025 at 06:20:20PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/2 18:12, Ojaswin Mujoo 写道:
> > On Fri, Jul 11, 2025 at 06:13:05PM +0930, Qu Wenruo wrote:
> > > [FAILURE]
> > > Test case btrfs/282 still fails on some setup:
> > > 
> > >      output mismatch (see /opt/xfstests/results//btrfs/282.out.bad)
> > >      --- tests/btrfs/282.out	2025-06-27 22:00:35.000000000 +0200
> > >      +++ /opt/xfstests/results//btrfs/282.out.bad	2025-07-08 20:40:50.042410321 +0200
> > >      @@ -1,3 +1,4 @@
> > >       QA output created by 282
> > >       wrote 2147483648/2147483648 bytes at offset 0
> > >       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >      +scrub speed 2152038400 Bytes/s is not properly throttled, target is 1076019200 Bytes/s
> > >      ...
> > >      (Run diff -u /opt/xfstests/tests/btrfs/282.out /opt/xfstests/results//btrfs/282.out.bad  to see the entire diff)
> > > 
> > > [CAUSE]
> > > Checking the full output, it shows the scrub is running too fast:
> > > 
> > > Starting scrub on devid 1
> > > scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> > > Scrub started:    Tue Jul  8 20:40:47 2025
> > > Status:           finished
> > > Duration:         0:00:00 <<<
> > > Total to scrub:   2.00GiB
> > > Rate:             2.00GiB/s
> > > Error summary:    no errors found
> > > Starting scrub on devid 1
> > > scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> > > Scrub started:    Tue Jul  8 20:40:48 2025
> > > Status:           finished
> > > Duration:         0:00:01
> > > Total to scrub:   2.00GiB
> > > Rate:             2.00GiB/s
> > > Error summary:    no errors found
> > > 
> > > The original run takes less than 1 seconds, making the scrub rate
> > > calculation very unreliable, no wonder the speed limit is not able to
> > > properly work.
> > > 
> > > [FIX]
> > > Instead of using fixed 2GiB file size, let the test create a filler for
> > > 4 seconds with direct IO, this would more or less ensure the scrub will
> > > take 4 seconds to run.
> > > 
> > > With 4 seconds as run time, the scrub rate can be calculated more or
> > > less reliably.
> > > 
> > > Furthermore since btrfs-progs currently only reports scrub duration in
> > > seconds, to prevent problems due to 1 second difference, enlarge the
> > > tolerance to +/- 25%, to be extra safe.
> > > 
> > > On my testing VM, the result looks like this:
> > > 
> > > Starting scrub on devid 1
> > > scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> > > Scrub started:    Fri Jul 11 09:13:31 2025
> > > Status:           finished
> > > Duration:         0:00:04
> > > Total to scrub:   2.72GiB
> > > Rate:             696.62MiB/s
> > > Error summary:    no errors found
> > > Starting scrub on devid 1
> > > scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> > > Scrub started:    Fri Jul 11 09:13:35 2025
> > > Status:           finished
> > > Duration:         0:00:08
> > > Total to scrub:   2.72GiB
> > > Rate:             348.31MiB/s
> > > Error summary:    no errors found
> > > 
> > > However this exposed a new failure mode, that if the storage is too
> > > fast, like the original report, that the initial 4 seconds write can
> > > fill the fs and exit early.
> > > 
> > > In that case we have no other solution but skipping the test case.
> > 
> > Hi Qu,
> > 
> > Thanks for tuning the test, we have also been facing intermittent failures
> > on btrfs/282.
> > 
> > I was just wondering if for faster devices, would it make sense to use
> > the io cgroup controller, eg:
> > 
> >    echo "252:0 rbps=1048576 wbps=1048576" > /sys/fs/cgroup/io_limit/io.max
> > 
> > To limit the throughput so we have >= 4s scrub runs. Or does that also have
> > some undesired effects like you mentioned for dm_delay here [1]
> 
> If cgroup works, it will be the best solution, we can fix the throughput to
> 512MiB/s, and use a 2GiB file to ensure 4s of scrub runtime.
> 
> This will get rid of the speed test part.
> 
> The only problem is I'm not familiar with the cgroup infrastructure, if you
> can enhance the test case to use cgroup, it would be awesome.
> 
> Thanks,
> Qu

Hi Qu,

So the command I pasted above did help me limit the dd throughput to 1MB/s
so it does seem to be doing what it advertises :) 

I don't know much about cgroups either but sure I can spend some time
understanding the io controller better and try to incorporate it in the
test. Will try to send a separate patch for it.

Thanks,
Ojaswin

> 
> > 
> > Regards,
> > Ojaswin
> > 
> > [1] https://lore.kernel.org/all/103e1b45-19d9-4438-b70d-892757f695fc@gmx.com/
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > 
> 

