Return-Path: <linux-btrfs+bounces-15805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A366B18B65
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083B7189D466
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D91FDE09;
	Sat,  2 Aug 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVtqsxcQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82C18D;
	Sat,  2 Aug 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124131; cv=none; b=OeinwVTZG/6TdL5pCh9DbPs/HuccGuAq8f0HYoWg0jQArg1vgr1EH+MOJY7NTO1r1FUkCLMIGsk4KXeP/YssC1I0izU+K4XqvD/67w9ZRIRagAeX2UcIobF4uyxUEfP3dQZVYGcdPbDem3Y0g6+Ooae5Km5iXRS5IJ4a5LB6kMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124131; c=relaxed/simple;
	bh=TMz0quUsjpx2TGfBE3HitDPO2acddqxnCBdW/idGeGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnKzawHDgJbwwEQbOpXMoGbCggQYoMg/BEoHckw7d1Mu69w6NH1FVMEx6VaeoWXa6yWfTI4MshjfTIx5gNY6E/2gzo5hQdeuAyOXYrnMoBkxAbmcM0MKzCBQcqnqPIo+S+P90IGOCqPL/dzDnjMiirb+Rar4BxTDpa9KJwViZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVtqsxcQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5727gPsi019339;
	Sat, 2 Aug 2025 08:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yQ7nEKPf9233UDXP0O4Y4DUBff1Q18
	vuJsHUEIIgkTk=; b=ZVtqsxcQPsZGqmzqiUQ/YIqZkhnyT9gZYQ0kqeYCYP36sv
	g6X0Z1CLBeIcIdIcO4v1gnXewDFQBIvADTRPwTS3nDyb/v7w0sQce5mrHbWmMCb2
	e35R48MQi537jzKjliiZTH3ytd9noAsEPQdUgVPyXmDXRchDgTFDTqV01L3bDpXM
	+DeoR7TfvtQlNVgLeVmalbVIZAi0TsmXu2psrs4CIuWQTZb79F61wT5SK2XDKQtr
	4QHyc7oosT17gwpgUPZTUbjOdzkqOMNlBblL6cGuKXLM3G6PG/WUWvP5QXg37K0y
	XwJIi5RrwY9J8qE6B/GQM+9i0+xUHDzW5fArT/Lw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab38ssm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 08:42:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5723lnlC009540;
	Sat, 2 Aug 2025 08:42:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489b37rq84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Aug 2025 08:42:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5728g5HI57999754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Aug 2025 08:42:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30EE520043;
	Sat,  2 Aug 2025 08:42:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191D220040;
	Sat,  2 Aug 2025 08:42:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.139])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  2 Aug 2025 08:42:03 +0000 (GMT)
Date: Sat, 2 Aug 2025 14:12:01 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/282: use timed writes to make sure scrub has
 enough run time
Message-ID: <aI3LmZVbl5H--QJ8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250711084305.183675-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711084305.183675-1-wqu@suse.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=688dcf5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8
 a=iox4zFpeAAAA:8 a=1O0Uhxkp9gwjLcKYrt8A:9 a=CjuIK1q_8ugA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: urBkfHZBE4TMPCH6MBbbtTGi2bPLjx7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA2NyBTYWx0ZWRfX2z0zn083PmB7
 5T8Z8G7xBYuIhh3V9pDs6juyRRQ/xGfPZli46SyAzVkLtg5ZLrwsrRXcsaFlUzICZkf1Q+4AaGc
 /U9opv3aNIYjR1IEhqUxKjWGa/oJA0QUsscS//r+vGaegXljvo9l5N+acMnv/PBIHBKNn2rlObn
 QH1bDFWP+ZT5NOiaCeeICAOhtZXwT2lVhyUbR9BB9B46KdQKLFzL53XxZ71d8zvPnfmzSWQQ+R3
 p4Gf5DGETeOOP1PYggAsEhR+5+PQnbLcTghUOyBJtshNN7ROOx1urhWTNJmse/5GYpLma12CICg
 miE5gvCZhgVN9Gd9THChWrnQkzzJCH5jxO/foOjYWpM7ntKMaqwms06lSgOjTyJ6GPiNTLVjTEW
 V+IEJO0/qQ5wspMJFi5KH9KvHvDDMF4FdzuEARLU+pPwTMIlL//oF2VO2RFuAqGB3knzRShg
X-Proofpoint-GUID: urBkfHZBE4TMPCH6MBbbtTGi2bPLjx7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=701 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020067

On Fri, Jul 11, 2025 at 06:13:05PM +0930, Qu Wenruo wrote:
> [FAILURE]
> Test case btrfs/282 still fails on some setup:
> 
>     output mismatch (see /opt/xfstests/results//btrfs/282.out.bad)
>     --- tests/btrfs/282.out	2025-06-27 22:00:35.000000000 +0200
>     +++ /opt/xfstests/results//btrfs/282.out.bad	2025-07-08 20:40:50.042410321 +0200
>     @@ -1,3 +1,4 @@
>      QA output created by 282
>      wrote 2147483648/2147483648 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +scrub speed 2152038400 Bytes/s is not properly throttled, target is 1076019200 Bytes/s
>     ...
>     (Run diff -u /opt/xfstests/tests/btrfs/282.out /opt/xfstests/results//btrfs/282.out.bad  to see the entire diff)
> 
> [CAUSE]
> Checking the full output, it shows the scrub is running too fast:
> 
> Starting scrub on devid 1
> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> Scrub started:    Tue Jul  8 20:40:47 2025
> Status:           finished
> Duration:         0:00:00 <<<
> Total to scrub:   2.00GiB
> Rate:             2.00GiB/s
> Error summary:    no errors found
> Starting scrub on devid 1
> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> Scrub started:    Tue Jul  8 20:40:48 2025
> Status:           finished
> Duration:         0:00:01
> Total to scrub:   2.00GiB
> Rate:             2.00GiB/s
> Error summary:    no errors found
> 
> The original run takes less than 1 seconds, making the scrub rate
> calculation very unreliable, no wonder the speed limit is not able to
> properly work.
> 
> [FIX]
> Instead of using fixed 2GiB file size, let the test create a filler for
> 4 seconds with direct IO, this would more or less ensure the scrub will
> take 4 seconds to run.
> 
> With 4 seconds as run time, the scrub rate can be calculated more or
> less reliably.
> 
> Furthermore since btrfs-progs currently only reports scrub duration in
> seconds, to prevent problems due to 1 second difference, enlarge the
> tolerance to +/- 25%, to be extra safe.
> 
> On my testing VM, the result looks like this:
> 
> Starting scrub on devid 1
> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> Scrub started:    Fri Jul 11 09:13:31 2025
> Status:           finished
> Duration:         0:00:04
> Total to scrub:   2.72GiB
> Rate:             696.62MiB/s
> Error summary:    no errors found
> Starting scrub on devid 1
> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> Scrub started:    Fri Jul 11 09:13:35 2025
> Status:           finished
> Duration:         0:00:08
> Total to scrub:   2.72GiB
> Rate:             348.31MiB/s
> Error summary:    no errors found
> 
> However this exposed a new failure mode, that if the storage is too
> fast, like the original report, that the initial 4 seconds write can
> fill the fs and exit early.
> 
> In that case we have no other solution but skipping the test case.

Hi Qu,

Thanks for tuning the test, we have also been facing intermittent failures
on btrfs/282. 

I was just wondering if for faster devices, would it make sense to use
the io cgroup controller, eg:

  echo "252:0 rbps=1048576 wbps=1048576" > /sys/fs/cgroup/io_limit/io.max

To limit the throughput so we have >= 4s scrub runs. Or does that also have
some undesired effects like you mentioned for dm_delay here [1]

Regards,
Ojaswin

[1] https://lore.kernel.org/all/103e1b45-19d9-4438-b70d-892757f695fc@gmx.com/
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

