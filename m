Return-Path: <linux-btrfs+bounces-22227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C5oHT1NqGmvsgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22227-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:18:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90220275C
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDD630AD958
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138EE32694E;
	Wed,  4 Mar 2026 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FZNErBDp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0E340283;
	Wed,  4 Mar 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637005; cv=none; b=KRgHFaQiD/hqmLHCaLWBeAw3V5P8uddtlRKSrrKR9Is0pkiqQw/tRpYtbhsdCuQym/RNYasSUKSo017YwvzauTgjFLOM2WV1wSWOa6dFVVp+nfzssy6LxH5ZbMBWWd+JGrqkwKXaAbMm/zY+v43+IcWJi9Cem11o83ZgfRAh2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637005; c=relaxed/simple;
	bh=+4hetkNJESFKOb+ZGioBZ4R1vR7Z5XaHnWsz9WOYEKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpCZlD7CD9twTpTODGagMp10/NKxzfwPgKFvl25UuaBwh940uYtNIMs3iVLX+p5aPVK7PvDks3K4Ww6ay0J45n786XU0SE3D/Iy5E1GfB69OIKPhedWVFjpUcIl0uvO6EWcRrX4+Uh7U566PCf6DVfD0xkAv3AG/bBuMGbG9Wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FZNErBDp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6247KJ691508241;
	Wed, 4 Mar 2026 15:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UnYxYUy+8zrFTWbwR9LeZFJwwqG9YY
	aU/e//3QPYJZ4=; b=FZNErBDp6qjhxSEbMiU9l04mc298SEH8tvnPLaJ9ean4A7
	7K2xPOV8CgfxJ0imtFEqEnzLpkzNC4c/bEg2Hvea3i/uSbisjwgNBmjI3cUiAuyX
	XPPgoEI4BzihZrjSOdrN8yM7PcU2sVQb++QWYxMPVUMr/lisSRi9AuVwiLitXCAm
	1X+EB0luNAC+JaoFK3v3/WvLJxDgTwYOKiaqsfcSrhQqUEaV60drcDSUJi+1u8+4
	hT5jkYKrixvnhvlk5C829/WjbjQwNdjiyQUwSpLNw3r00Hlu0Mex784CEb0aa58m
	fVEriNiAX4lHjUycOThSzI4JSS9skGA9/I1ieitw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3yfpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 15:08:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624EU8Rs016408;
	Wed, 4 Mar 2026 15:08:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpn74yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 15:08:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624F8ahj25100704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 15:08:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B983C20040;
	Wed,  4 Mar 2026 15:08:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D11C420043;
	Wed,  4 Mar 2026 15:08:33 +0000 (GMT)
Received: from osiris (unknown [9.111.25.254])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Mar 2026 15:08:33 +0000 (GMT)
Date: Wed, 4 Mar 2026 16:08:32 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304150832.10892B56-hca@linux.ibm.com>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-2-hch@lst.de>
 <20260227142455.GG1282955@noisy.programming.kicks-ass.net>
 <20260303160050.GB7021@lst.de>
 <20260303195517.GC2846@sol>
 <20260304150142.10892A0b-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304150142.10892A0b-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 04z9E13OM3Sfpetrjwu_knlQ4Pm57vSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyMyBTYWx0ZWRfX1qKC5vwiiVti
 imQl88p4f5EEaUs36Cqd8CD0grmVfOVhch8H/6EkUdKTFPntYFZhNzfiLwzeEcRPVdfmfw/csJd
 5XjBomCKez2kWT0xu+TyUO5m86iaOsxE8uVSmI3WWQj0EIwj+0zha8PMo4rZS7UmHkn2EA23gC3
 fCKaD2O5LTbrNnhcy/sqDaVZg5VdeGyPlf7sKjPqlGMWdy7lKR+Sx4YT9Ue13j1krenv+apDdTG
 9u7pc7ax3/s4b9EW0qdkkSS/EsWcFCshcemu3qKx2gHNe1V0XILuw8E8ekEbHaLm1XHrSGLXtR7
 0VblM3ek7WLeLeq24Eb3kVOGtogA+y9AGwS9Ox7ga75U7hxD6x81KJm+aga4X4uPi6MKdrTmsXu
 Fw4NYf7Aga7uVW+KCzrlr3ubI8K6ypZGyMfLvJiVX97w/NtWfeIQ5EAiC+Bq+Ht/ezhYzKmvaFi
 hJyU1cpGtH/CwXFvztA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a84afb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Lex053stx4sflTLgQTUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EsSB8XvTAoZu7uY0i22CxoZDWK6YvNNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040123
X-Rspamd-Queue-Id: 0F90220275C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,infradead.org,linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22227-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:01:46PM +0100, Heiko Carstens wrote:
> On Tue, Mar 03, 2026 at 11:55:17AM -0800, Eric Biggers wrote:
> > On Tue, Mar 03, 2026 at 05:00:50PM +0100, Christoph Hellwig wrote:
> > > On Fri, Feb 27, 2026 at 03:24:55PM +0100, Peter Zijlstra wrote:
> > Because of that CPU feature check, I don't think
> > "WARN_ON_ONCE(!may_use_simd())" would actually be correct here.
> > 
> > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > of the context restrictions correctly.  (Compared to in_task(), it
> > handles the cases where hardirqs or softirqs are disabled.)
> 
> I guess, this is not true, since there is at least one architecture which
> allows to run simd code in interrupt context (but which missed to implement
> may_use_simd()).

Oh, just to avoid confusion, which I may have caused: I made only
general comments about s390 simd usage. Our xor() implementation does
not make use of simd, since our normal xc instruction allows to xor up
to 256 bytes. A simd implementation wouldn't be faster.
Also here it would be possible to run it in any context.

