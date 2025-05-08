Return-Path: <linux-btrfs+bounces-13828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF85AAF84B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E9F4A23F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60D222595;
	Thu,  8 May 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BAN4lPKD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA96221703;
	Thu,  8 May 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701116; cv=none; b=gbX64r24J28nUYT/v6yu7oekrzTkSSS8FOAu7y8WHtSmokVZ+KiP0hn6myL8HTFRurL3Q2q2M4MrdgEylDKNT5ZNmx7UH69+KhpKxhbVyKqqvCpgDeACCTUeFKX/HtfAn0aHRGgdQ6I23d7+VxLOQ6RsmZUOcdJqHVcu4XTe2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701116; c=relaxed/simple;
	bh=lk0sPxS4gacLL86cVRDct6/Ku6vptvmSrgGVVGw/c0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFCkVsvmOivKT7T6+fQ2v0VG2GHoKQVHKBVVBwg42LQnSFvmrXqlTx7c+3ICbimaEpvTNRGHnLZ2KZ2aR6KyhwDBb8IUfqHZc2ZRHho5fN6mr5eMePUgQmM1P+H/0daeO/Uo21CDfs3FU75VE9heeMiQ+tzR6jhTv6/4P9jfgAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BAN4lPKD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548A45F8025931;
	Thu, 8 May 2025 10:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nJT2gg
	n7bwVZKUtfsOL3vHC4YrRX+weBD8PdIk3jUbE=; b=BAN4lPKDfzNrtN7N1qreHq
	oj+zW4LR5LNwEbZOQ/sjDe9iJlH0iAtEh6VjpZ5fYTO+yRwQKai2Y8VOXfnTZFhH
	hytj1oqqY+pwDM9+vhPPNqs7XUGHAoJONp8nRXyHK2cSTqXj4IVLMYWJBhIwvgKS
	V97Rb69yRLtIQd/T40D4rnCIjvkJhQ9wV9QUkdnitF8st/mTu4dU5Kgk/5Xm31oj
	/VamKRaZihxaGmDoMIn0cR+aqKw1bXdtjWWFWFSXHWDB5xJXOCwq6XWG952iCVIk
	D+e3RMVTo//Dmw76/ZmnyILisTPftHmDuvwyNi6HPyydeHEO+C26FfVelU8YfQKg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk85b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:45:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 548AbfG0003017;
	Thu, 8 May 2025 10:45:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthk85b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:45:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5488uGZD025807;
	Thu, 8 May 2025 10:45:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv05h3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 10:45:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548Aj14227591198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 10:45:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0523E58055;
	Thu,  8 May 2025 10:45:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C73B458043;
	Thu,  8 May 2025 10:44:57 +0000 (GMT)
Received: from [9.61.251.83] (unknown [9.61.251.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 10:44:57 +0000 (GMT)
Message-ID: <3096704a-84ec-4709-89ed-43ab1ed2b7c1@linux.ibm.com>
Date: Thu, 8 May 2025 16:14:56 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
Content-Language: en-GB
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, ritesh.list@gmail.com, disgoel@linux.ibm.com,
        David Sterba <dsterba@suse.com>
References: <0B1A34F5-2EEB-491E-9DD0-FC128B0D9E07@linux.ibm.com>
 <CAL3q7H7PqVRnDuooSr6OhvUQ3G5V2gq6VEDpqTqNX9jHmq97aw@mail.gmail.com>
 <20250507141409.GG9140@suse.cz>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250507141409.GG9140@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5MiBTYWx0ZWRfXxZhfHbnLKTGo MXT51QjgtpNO+loqTo6x0GPLrojfW+GV6YRxUeASgKgpyMpyrYTdBPy7Gc5phmLQyjMTl0lMBcn 4StsZ4S7V8zdihm3gHi5QMYhmArsuzKtpbJiyhRvFqBrE1osufXcinPahgeN3B0o1KFvramrLoL
 3QdgFJJeUuGTX1Ss1HvnrxP5rlqswzPah9CdXkUygT5AvZiS3JiIZGBZyEt1arWgSYP6F3JhyIQ Zpsblq1uM/QzDOZCOwx83YQmH+q70iIs83/pdQqypoSeUm1V80+tP7ak4LmVKIed6Rq4VZpWyx/ ZSTlgUvXJyzPJ4RfutbGZqZvD+Qg3uCR6BnpdeYquzrSMRxeDGF/plKFoJHYxp4A9t1Azdd66pb
 S9NLrRMymYupF1TbvKLnxM4GNlmmRbw/cpku1HLNainoQeODh1t3ufOVrcurgjSTrEBgOqrq
X-Proofpoint-ORIG-GUID: EJxHnfxn_acDMBKrqGIdfu36KiRKjQW0
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681c8b2f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=VnNF1IyMAAAA:8 a=Zg4ZsEA-DVCyg4mgyWsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
X-Proofpoint-GUID: 4jh3IAg_uquEpSCTg-CSJYtPhnNB950_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080092


On 07/05/25 7:44 pm, David Sterba wrote:
> On Wed, May 07, 2025 at 02:04:47PM +0100, Filipe Manana wrote:
>> On Wed, May 7, 2025 at 10:02 AM Venkat <venkat88@linux.ibm.com> wrote:
>>> +Disha,
>>>
>>> Hello Qu,
>>>
>>> I still see this failure on next-20250505.
>>>
>>> May I know, when will this be fixed.
>> The two patches pointed out before by Qu are still being added to linux-next.
>> Qu reported this on the thread for the patches:
>>
>> https://lore.kernel.org/linux-btrfs/0146825e-a1b1-4789-b4f5-a0894347babe@gmx.com/
>>
>> There was no reply from the author and David added them again to
>> for-next/linux-next.
Added again, was this removed? Can you please point me to patch or 
commit id. I was under impression, it never got removed.
>>
>> David, can you drop them out from for-next? Why are they being added
>> again when there were no changes since last time?
> The patches have been there for like 4 -rc kernels without reported
> problems. I will remove them again.


David,


While reverting those patches, please add below tags. And really 
appriciate, if you can keep me in CC.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Reported-by: Disha Goel <disgoel@linux.ibm.com>

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Closes: 
https://lore.kernel.org/all/e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com/



Regards,

Venkat.


