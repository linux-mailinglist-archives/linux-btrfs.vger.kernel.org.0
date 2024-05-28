Return-Path: <linux-btrfs+bounces-5318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9EB8D18D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 12:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A8E1C22F6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873B16B75E;
	Tue, 28 May 2024 10:44:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072416B737;
	Tue, 28 May 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893071; cv=none; b=A6NW99jLcegY8FLw1TfGyaAWGnbi2vQBGXtX79FAyton7v0KVbHzIddh0MHmS+UPKu3a6O/+jXz/21Y59EEFOonZDJ9F17viLIn8TdFFSS3th+cI/K/PqA/YBH+0ECrDOqI/n0hWhNl+DtUEODmxW6UkbvF5QdfDKIk94ofalJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893071; c=relaxed/simple;
	bh=L9sl9joEHYI7Apj1HmECq/NcptPUb7PxBXgqwlLgIhw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ksyxCV0HxQgkVZjpD8YouxlixjOWPZUFROCZgn4+yhRc/O1/tuO1y2sI7itcbFcOSAuViB4yR+kQxTA3CFA9NjZ68dqguKLuZlo1pqxmMbPIQZ/CvTiuSsgFqdgRDY7s8I+rIkQMnbXaRBWZfxaU4ViUCHjSulnas+/LOImjFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44S9rGnK019160;
	Tue, 28 May 2024 10:44:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dibm.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpp1;_bh=3D1wC?=
 =?UTF-8?Q?XWJj9AUMJhBSCRCyTg5j7hQg058gA/hYuaM5LEIs=3D;_b=3DId1m9FXSvPE6Bh?=
 =?UTF-8?Q?MA3cTYatzTIM0/1taPiGYHf8nzaE35Cf8Wo8FvxkrI5ePSJN0+oDDD_Q0CGyDVW?=
 =?UTF-8?Q?Qch95/9vhiRWo5CHxIBybw7b985ZtXuyWv8NWck4x72f/pYc8G9p2OZ9u13J_Rv?=
 =?UTF-8?Q?zTH3PnV0NymAYiKX9YkRzT6r9I+/jo5fh1UwpviyE83x1EZm7yHmkCROGfK0Z53?=
 =?UTF-8?Q?xrq_/59HHPAcmvEHyS0bQQhSJJGnrY2HJhhwf+gRObCI1uDYQbcC0IKJ1hLAIV1?=
 =?UTF-8?Q?Mfnec6u/B_v3NJ+Tf8xx2ZljmF+se+lO86C3AGWFt/HEQsQ28qlNo2fo/U24xj2?=
 =?UTF-8?Q?/YLpfa7PrhBiMKZ_rA=3D=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydd14040j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 10:44:27 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SAiQYs012963;
	Tue, 28 May 2024 10:44:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydd14040b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 10:44:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7hTKV010968;
	Tue, 28 May 2024 10:44:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybw12nwa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 10:44:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44SAiFcA48038150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:44:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3274D5805C;
	Tue, 28 May 2024 10:44:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FCE358051;
	Tue, 28 May 2024 10:44:14 +0000 (GMT)
Received: from [9.171.27.182] (unknown [9.171.27.182])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 May 2024 10:44:14 +0000 (GMT)
Message-ID: <2db8bc9a-5ff0-40ec-92ba-29c90b6976c7@linux.ibm.com>
Date: Tue, 28 May 2024 12:44:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zlib: do not do unnecessary page copying for
 compression
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
 <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
 <a24ef846-95f9-413d-abfa-54b06281047a@gmx.com>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <a24ef846-95f9-413d-abfa-54b06281047a@gmx.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: liD5LPDhxrFa_kS_hCGT88pkiFAtrLIg
X-Proofpoint-ORIG-GUID: Lvmj4tMaeNUN0D79phWz-FEumdHBX-Nt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=833 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280080

Hello Qu,

On 28.05.2024 00:09, Qu Wenruo wrote:
> 
> 
> 在 2024/5/28 01:55, Zaslonko Mikhail 写道:
>> Hello Qu,
>>
>> I remember implementing btrfs zlib changes related to s390 dfltcc compression support a while ago:
>> https://lwn.net/Articles/808809/
>>
>> The workspace buffer size was indeed enlarged for performance reasons.
>>
>> Please see my comments below.
>>
>> On 27.05.2024 11:24, Qu Wenruo wrote:
>>> [BUG]
>>> In function zlib_compress_folios(), we handle the input by:
>>>
>>> - If there are multiple pages left
>>>    We copy the page content into workspace->buf, and use workspace->buf
>>>    as input for compression.
>>>
>>>    But on x86_64 (which doesn't support dfltcc), that buffer size is just
>>>    one page, so we're wasting our CPU time copying the page for no
>>>    benefit.
>>>
>>> - If there is only one page left
>>>    We use the mapped page address as input for compression.
>>>
>>> The problem is, this means we will copy the whole input range except the
>>> last page (can be as large as 124K), without much obvious benefit.
>>>
>>> Meanwhile the cost is pretty obvious.
>>
>> Actually, the behavior for kernels w/o dfltcc support (currently available on s390
>> only) should not be affected.
>> We copy input pages to the workspace->buf only if the buffer size is larger than 1 page.
>> At least it worked this way after my original btrfs zlib patch:
>> https://lwn.net/ml/linux-kernel/20200108105103.29028-1-zaslonko@linux.ibm.com/
>>
>> Has this behavior somehow changed after your page->folio conversion performed for btrfs?
>> https://lore.kernel.org/all/cover.1706521511.git.wqu@suse.com/
> 
> My bad, I forgot that the buf_size for non-S390 systems is fixed to one
> page thus the page copy is not utilized for x86_64.
> 
> But I'm still wondering if we do not go 4 pages as buffer, how much
> performance penalty would there be?
> 
> One of the objective is to prepare for the incoming sector perfect
> subpage compression support, thus I'm re-checking the existing
> compression code, preparing to change them to be subpage compatible.
> 
> If we can simplify the behavior without too large performance penalty,
> can we consider just using one single page as buffer?

Based on my earlier estimates, bigger buffer provided up to 60% performance for inflate and up to 30% for
deflate on s390 with dfltcc support.
I don't think giving it away for simplification would be a good idea.

> 
> Thanks,
> Qu

