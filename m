Return-Path: <linux-btrfs+bounces-13761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10761AADAA3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774444E4477
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B821147F;
	Wed,  7 May 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nHYlIQkB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584314B1E76;
	Wed,  7 May 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608519; cv=none; b=bbWO/RF8EdiQMuOH1b3ZB0INi2cjP203OzKE1+i+ywBrqVf2ai4fOFwcJZd9ClbTu63IK/b4VJxpXTGTZfnP1XpIuOgvve34vybkCCr8mQYXf5IwsFqKio3vs2K5dOxJpD9CG6zIO2PWu7VCKBo4JstdrXavbhIrM3aNEvvIjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608519; c=relaxed/simple;
	bh=QzOoKArIYK0+E1M+1dvu7WEya0r6ILP80kMuNHelX7w=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=RXuWg/aThQdmJj3rjVbAN648MmC1hRLPvwxJaPEj7qEW1m97Nrgp6BTweg9yzhlwvF/+cDinz8G7JIVXfRnSDHMmc5dm9uBhmA63eANfxpCYdMpaCSzK0V8ldTK9W8vHZVaR6pPIyiah15pBoHHJYfj4f1tAXpPWIBdvqG8m3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nHYlIQkB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546NkrLR017745;
	Wed, 7 May 2025 09:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=90nZf1K0z0HPsegV6dHdrYZRjs/z
	SpuRGmmuOluwzKY=; b=nHYlIQkBNYqJQYfEiOsk0M2inSRiGpLIJUYJJw6pzuPp
	JMxTFmBFvWO/Ki8GRU62m3hNWXyZF4X0ZyGOkR/34HKRk/nDzoVd4xulcNy83ABq
	M0TQ4mxmCKCncfrBDju0qnVJrnmw/5X9hCbMiiG6pZnzbZ1T4TrciDTXK3FGkIq5
	Y/ZIjdRAIkTCeAP1yjJQ7Lx0HZF2LNiHGfk8o3u6mO1wyeRu305PRsxm6XcyQBs8
	JfkN3IX9LwEepY7uGWa5E95RF9oPhKa6QCSB7Fw7WtT9E9f0hXwLiaYp7qGHmOx3
	wse8grPDqzXdt1NVYCfmw4VdlYrS4+a9DU7IskNgOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0j216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 09:01:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54791q6G013617;
	Wed, 7 May 2025 09:01:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0j215-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 09:01:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5476Efp6014082;
	Wed, 7 May 2025 09:01:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkqn1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 09:01:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54791nBJ61669714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 09:01:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C311C5805F;
	Wed,  7 May 2025 09:01:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B2D15805B;
	Wed,  7 May 2025 09:01:47 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.204.204.179])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 May 2025 09:01:46 +0000 (GMT)
From: Venkat <venkat88@linux.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
Message-Id: <0B1A34F5-2EEB-491E-9DD0-FC128B0D9E07@linux.ibm.com>
Date: Wed, 7 May 2025 14:31:34 +0530
Cc: linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ritesh.list@gmail.com, venkat88@linux.ibm.com, disgoel@linux.ibm.com
To: quwenruo.btrfs@gmx.com
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CFlIZywmLgq2_DPEQF7X2haHWbNkvSyS
X-Proofpoint-GUID: XbFS5lvhsm3ciNdwaecYKC0kRNwjVpvp
X-Authority-Analysis: v=2.4 cv=LYc86ifi c=1 sm=1 tr=0 ts=681b2180 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=9Jos5CVRofSNjZQHATQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA3OSBTYWx0ZWRfX2rc5guWqwzDK qY+lq16tmt2jrFG0EIRb5pl5zK7rinzeLiZAFTaiqhEGw2vFrFyRtIP9+9qVamfKh28uBb8rsmU 8bM886D+GwyeHrCrtPKRNzU+fr7PcLK3v9QAQO3caURpwJIvLwKD8m40fD5RFQVPB1wpI2JMmsj
 KqV+oV7blo/mN9Dc/qk11jAPVx3Vj4WvSd3OKl172Hz50GuY+uMRyCR7eXF7tL0kyKt0ZLaaZrL vxbmNrKXL9OsdxwV79HRYLhT9FnV0DpkZML5DjvwIGMq4Yfm/Vo+2X/vFcxThuY8TFOgWGJIlrW dYuIN49/US6EgRXMJteZO5h4z9a3p3469AwHRDpWW13Wu1VM9Ky+63s7ppezgbo8xFNUUxgXUjN
 sE/xYRklwe0urCcXDbTOt1dvuA9vJPrrEM4TzjoRNc0BSrj71vvFLWhLuMEDFFWhUAaJFkLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=711 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070079

+Disha,

Hello Qu,

I still see this failure on next-20250505. 

May I know, when will this be fixed. 

Same traces are seen, while running other Tests also.

Disha,

Can you please share the details of Test and the traces.

Regards,
Venkat.

