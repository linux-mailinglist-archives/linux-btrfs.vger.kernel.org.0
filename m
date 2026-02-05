Return-Path: <linux-btrfs+bounces-21396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMOED6wfhWnv8gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21396-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 23:54:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677CF83C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 23:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93C03002B69
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3EA33B6C9;
	Thu,  5 Feb 2026 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aryRxg7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55C33ADA3;
	Thu,  5 Feb 2026 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332067; cv=none; b=fq9OpLc+w4CYIpUHgud0kz5LF/NcW0zBi3QDTuovsjpbYLp0Vx+HxbtnPa5IYWJflOHSB3BpcVWuage99PXmq64dgJUdxkC8lVTTSvH/ey3CdzmbWz5bK+QsKqdhqWiy84EnRNA3478DvSSpbNb3iQqky1oJjtwzKocoY2YewUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332067; c=relaxed/simple;
	bh=S7ft3si6HKCpAVxukuwcWtXuCFBz/xMD0gq7hKmO9DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7Mg0IgHZLqTj7SaEBLi3Z9Q2WysTu/tpJdwF/k8hEmhtIG9NqGVZAAjvqpXJ7eEbpEYttikJD9Ter9282QHtxK20ly1YbxSWhaiVP2lMa45wfl0TW+G+p7MKFDYFFLBgJ9NvPZFgKK4N2cwFVSoTc4r9h+LzVhu1ZDucoGv5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aryRxg7C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615ErE3g017917;
	Thu, 5 Feb 2026 22:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BwcU6v
	aUxwhLgi4mT1m3Bp/fTxfIRXC12GVSXxYHwKc=; b=aryRxg7CgiNbfz7XuaGdu2
	FQMXCvfB8pP5riJvxhX9P9Cl/nvAqnRqbixfLUpCnqhGzxKXQgF+HS2x08+8NjTW
	JOLs19HkNJzKiYw0jEN3Ur4BzxGDgHGEcboaFblSGt7wFpfai8HblEtjLHdBwikY
	UkvtpnhMlaJRlSW9KyZPI9p7W+azOLnBCbnAi6wvP57S8/Qbb4EytH11M22UooRX
	FrUIrXGq4f+RP1s7DXsvdEAwS3bwar5wLkCul9ytTAeG4l4XnVIii1WW+PXh/Iab
	VeB044AEIWnMqkE1CV6IPhYRZZpvwnYimJJZVAZPUR4IefIXcWph0At39KSpQ1tA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cwe1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 22:54:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615M27Mk027684;
	Thu, 5 Feb 2026 22:54:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs1kggn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 22:54:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 615MsNMa24117864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 22:54:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747365805D;
	Thu,  5 Feb 2026 22:54:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B5A58043;
	Thu,  5 Feb 2026 22:54:22 +0000 (GMT)
Received: from [9.111.171.53] (unknown [9.111.171.53])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Feb 2026 22:54:22 +0000 (GMT)
Message-ID: <4055f852-0488-4ccf-abb5-bc5f8d2c9635@linux.ibm.com>
Date: Thu, 5 Feb 2026 23:54:21 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
References: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
 <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE3NSBTYWx0ZWRfX/xg6EqhvPTvq
 wQXfEqW2Uhbt/QbytWF7ndxvYZ+OBypD8iFMfZrPOKDJaHvhHkCn1pVYFv3GlpdfGQYOk8BhfZB
 wqkxYr/MKUT53ONDGLTJijNvgh+P4dlBwcZ+VX4uBT0n0pjbNXnjvXPOvThmel9V4Wn52+eUsbd
 xrdThRIt2AcXDwaSw2hKzSPVsTVZS1eD95z7Q3qGC732bQhGtsFlTZpWmiiMThY3wQKcg36AevA
 g04Fz8u9qFjtLhmkHpJc2WqwxdJfFZGA7fUKtt+jaTmZchBODzRBhq9bK1pLDZZnYnD73IJ9d1R
 5zbN7tngk9+1QGKlvJEKT4HfWkn2p9MMvB/Fvp4AOUtNxIwkE8eqN59p93ue7oWs19dn7YoaZjt
 2dEjIYcfSPr1lt07muRSrY+pjLUCjzygg+4AfcuQxbjHM8SNPMHL+N3X6DFmoyEOxBq+Egr0vwb
 hWMCD8Y3k8KXlGzR5tA==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=69851fa1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=iox4zFpeAAAA:8 a=vIqduxIiGwg5IhLgSugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: JV7asJn1KThmDX0vkNgW92WnIDNdhlPk
X-Proofpoint-GUID: JV7asJn1KThmDX0vkNgW92WnIDNdhlPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zaslonko@linux.ibm.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21396-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4677CF83C7
X-Rspamd-Action: no action

Hello Qu,

Sorry for the late response. 
I ran some test on s390 including folio-leak verification. LGTM.

Tested-by:   Mikhail Zaslonko <zaslonko@linux.ibm.com>


On 20-Jan-26 23:52, Qu Wenruo wrote:
> Adding S390 to the mailing list, I got the incorrect address in the initial patch.
> 
> Much appreciated if S390 people can give it a test.
> 
> Thanks,
> Qu
> 
> 
> 在 2026/1/19 16:24, Qu Wenruo 写道:
>> [BUG]
>> After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
>> buffer preparation"), we no longer release the folio of the page cache
>> of folio returned by btrfs_compress_filemap_get_folio() for S390
>> hardware accerlation path.
>>
>> [CAUSE]
>> Before that commit, we call kumap_local() and folio_put() after handling
>> each folio.
>>
>> Although the timing is not ideal (it release previous folio at the
>> beginning of the loop, and rely on some extra cleanup out of the loop),
>> it at least handles the folio release correctly.
>>
>> Meanwhile the refactored code is easier to read, it lacks the call to
>> release the filemap folio.
>>
>> [FIX]
>> Add the missing folio_put() for copy_data_into_buffer().
>>
>> Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
>> Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/zlib.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index 6caba8be7c84..10ed48d4a846 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
>>           data_in = kmap_local_folio(folio, offset);
>>           memcpy(workspace->buf + cur - filepos, data_in, copy_length);
>>           kunmap_local(data_in);
>> +        folio_put(folio);
>>           cur += copy_length;
>>       }
>>       return 0;
> 
> 


