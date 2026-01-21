Return-Path: <linux-btrfs+bounces-20800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NADLgWhcGlyYgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20800-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 10:48:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4476C54AA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 242AF886337
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A347B424;
	Wed, 21 Jan 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EappCBZK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9F47A0D4;
	Wed, 21 Jan 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987746; cv=none; b=aQ9q5vjEknVmyh4JZWnAm09P8p4pulFGBAU9706wo7Bc4iWkhMpDbvdLLpKQIE4OKguCvwpZ5UWdcFYpsZo/YeVcOrBvrf48huNTN1kmWV5X+4nRts0Q+9aoSrZMVed7ptXEDiHrbPdMXqjMcpOzwm8exgfrLZkV81mxZhM/jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987746; c=relaxed/simple;
	bh=KXRDFrhifchE6Z4/dNEi0wZRpEZee/z/YcyAhBs6tX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6AvunYaqMjHt7xAVlfF1wsZDrDxh23lXTbfZxphvxaLAVWvj3Bh7COTn0RF2ZIl7iWSjQFYH7K6c2QXX8pwHg4DCmb8kt8nQvzairgkPUHPQyFCAlR3Hc0Hqts2lgSet5P754E9ptLehH9WLol083y0ogV58Sg/B1VNCpCNBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EappCBZK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KNc5Ec006591;
	Wed, 21 Jan 2026 09:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iL45H+
	LgO5PNbSzILUwyu5iQO7gomKom1P1XNGuf3Bo=; b=EappCBZKt6KzbMrxNFylJe
	eNEC6c2Qg7vdpxyCqkdzHhGWVYcQbOiz9kvat6p0nL2waZtIY8IVZvdErD/zqkWa
	9YIuj3A8NTtRekv0p4ecHKyDxk+oqMGKDMdPZHYvldb/hFSzXvl5R7kbrnqbr9k7
	Uj5y5CQpXrzWCOUzRtA28K7Or/WxUffMvuQh2Ai5qfrKhHwSPvKABK5jBhfFoiO6
	UGpDKTK9F+Xth+HO6gvExE7xREyIACgWBHFx+jInSmyJxdl/B2MeefpARPAt6JS7
	RALn0/RW/88hwaKpLWYsxmVDTIpg2AEmPcj08xTLsFdU6EsV6xjemeQq0/CY3aIQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s3cwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 09:29:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L7YqRF009253;
	Wed, 21 Jan 2026 09:29:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kax84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 09:29:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60L9SxRP16318882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 09:28:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF54020043;
	Wed, 21 Jan 2026 09:28:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A729820040;
	Wed, 21 Jan 2026 09:28:59 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Jan 2026 09:28:59 +0000 (GMT)
Date: Wed, 21 Jan 2026 10:28:57 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Qu Wenruo <wqu@suse.com>, Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-btrfs@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
Message-ID: <20260121092857.9719A1f-hca@linux.ibm.com>
References: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
 <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zhTrp4GCD4KtV-i2yJ6dTUictxC5ibhs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3MyBTYWx0ZWRfXxU6EtkDJkJUU
 ChuFYnL6sBzHpXQRbiL4EweXDj6UaGfQ/bozg6lWGhg8G0JMLhtmmaA+k/92+PZC6j4VYOOAgwc
 LHPdy4SswKcBjidg0bkPCtzoZaLSevDMizkv+iZt1IkrcCwlrJXNqDPcFvdZMd8iLULQmC4fl/v
 lQqB0lDE9oXnm4PN74MC05I04UDB4rlN3EO2ARJCKcGbn3NBYeajdGW27Xid8aXLplg6CJHptrQ
 JHkn4jf0m2JvZipkum7xUhu/zs7VrVHxz6+VECN0wauxxP6bVk5dG18FXMx3ygn9inDgZmv1tBs
 fscacmc2Kb2J2OJmmBIQuJ27U73gppFwLrROU7WRF0QNOo5pgVPsXwq2+U6mWyAevwcBN2c5XhM
 M5L42n1xX51TIATzkjvp+xQ+vC3Y+muMGd5i32C1zKDf5XXZz+Yh2TLAFs125zHrzF3vPXxt/k0
 lXLEEC4YdIvfvCVfvFQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69709c5f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iox4zFpeAAAA:8 a=6iE85x-LiswBhNdmk-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: zhTrp4GCD4KtV-i2yJ6dTUictxC5ibhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210073
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20800-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.ibm.com:mid,suse.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4476C54AA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:22:47AM +1030, Qu Wenruo wrote:
> Adding S390 to the mailing list, I got the incorrect address in the initial
> patch.
> 
> Much appreciated if S390 people can give it a test.
> 
> Thanks,
> Qu
> 
> 在 2026/1/19 16:24, Qu Wenruo 写道:
> > [BUG]
> > After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
> > buffer preparation"), we no longer release the folio of the page cache
> > of folio returned by btrfs_compress_filemap_get_folio() for S390
> > hardware accerlation path.
> > 
> > [CAUSE]
> > Before that commit, we call kumap_local() and folio_put() after handling
> > each folio.
> > 
> > Although the timing is not ideal (it release previous folio at the
> > beginning of the loop, and rely on some extra cleanup out of the loop),
> > it at least handles the folio release correctly.
> > 
> > Meanwhile the refactored code is easier to read, it lacks the call to
> > release the filemap folio.
> > 
> > [FIX]
> > Add the missing folio_put() for copy_data_into_buffer().
> > 
> > Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
> > Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   fs/btrfs/zlib.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index 6caba8be7c84..10ed48d4a846 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
> >   		data_in = kmap_local_folio(folio, offset);
> >   		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
> >   		kunmap_local(data_in);
> > +		folio_put(folio);
> >   		cur += copy_length;
> >   	}
> >   	return 0;

Mikhail, can you have a look at this, please?

