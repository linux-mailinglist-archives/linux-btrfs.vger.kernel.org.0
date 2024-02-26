Return-Path: <linux-btrfs+bounces-2807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D08867E0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0217F1C2C5B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD40B12E1FB;
	Mon, 26 Feb 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MbvrA4li"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21211127B4D;
	Mon, 26 Feb 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967674; cv=none; b=pikF5n6CNQf8LuMNpsNFkfdMtheVr3P0WBcgSGUQqJLugplUKcYSm8pEoq+5VhKC6kwJJcroHeBG52DsrzonW3jm1ezlIzSKEnaBnFY7BsRykMbbt2nVoV6kXC9TkAuHKX/PLk4OmdyDJ8yUI0TYgbMPw/Li19kP0cTQdZGveW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967674; c=relaxed/simple;
	bh=ZatBfX3GImAl/bUCZ9kxeO02BxuKFeBHkwxbI7272vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7ab12j+zzNhrJw5zmGP707D99HRlm0+hDpH+ENBqTuZP2qBP+xkFTNHCAXew+pzDJ2BihzhcfKN/2okKHpj2dBKWcHr/MS0DzXD8Som9QKWN2yCPj0TnODIrXm/Zb0PKo5ynVgmiC1LajidxvgmBL8pmrkSMEYDXs9l7Do9jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MbvrA4li; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGwR0e032270;
	Mon, 26 Feb 2024 17:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7EiwRdm/V3a7kLEUdExazAqNGWLSc4lYEtu/GG4qUJ0=;
 b=MbvrA4liD26UBVHzakTuYr0t60g3p3lFTN8BkLwRvT6ziymLUJgzI6fpxn7PD76+wLYs
 42zVAplEkClN8YKbxIWO9I2ImjJjU4TN7EXFs0W8o9bFwHYEjAsXqrRnK56xb2nTGaOA
 KN3ipTfcuAl3/MK4gfpgW5P2zURHSb7LIcZTsQ7kHewvZt3jUZIh+vONFX0QylQg+Sal
 kcJrpGJPFncGuJ9dvdCzwds4jJzgBqbVCbgHsGcZ5M/rWOJ3S+GLU4SKAk+bJbLuiYrd
 AzmfWdwoYduR6JzUZNwRCfPZE9ijUt5hd4bPVU5Q3QrWcl3TazbX+OlvqHPIuAmdpgZH aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxmm8fmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:14:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QGx2Rw001319;
	Mon, 26 Feb 2024 17:14:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxmm8fkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:14:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGTLLA021808;
	Mon, 26 Feb 2024 17:14:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5ytquv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 17:14:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QHEDNQ9372320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:14:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CBAF2004D;
	Mon, 26 Feb 2024 17:14:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E6520049;
	Mon, 26 Feb 2024 17:14:11 +0000 (GMT)
Received: from [9.171.4.124] (unknown [9.171.4.124])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 17:14:11 +0000 (GMT)
Message-ID: <3aae1410-e30f-4cd5-8c6c-3f1c6362ffee@linux.ibm.com>
Date: Mon, 26 Feb 2024 18:13:41 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 08/21] s390/cio: rename bitmap_size() ->
 idset_bitmap_size()
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Marcin Szycik <marcin.szycik@linux.intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>, Jiri Pirko <jiri@resnulli.us>,
        Ido Schimmel <idosch@nvidia.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev, linux-s390@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-9-aleksander.lobakin@intel.com>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20240201122216.2634007-9-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kJ2xFVSXDENYmSmRhicxbmrwDujXC5lV
X-Proofpoint-GUID: yP0KC4JJEtYmY4bzsPQdnvQdAB2lXb3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxlogscore=961 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260131

On 01.02.2024 13:22, Alexander Lobakin wrote:
> bitmap_size() is a pretty generic name and one may want to use it for
> a generic bitmap API function. At the same time, its logic is not
> "generic", i.e. it's not just `nbits -> size of bitmap in bytes`
> converter as it would be expected from its name.
> Add the prefix 'idset_' used throughout the file where the function
> resides.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Apologies for the delay.

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D


