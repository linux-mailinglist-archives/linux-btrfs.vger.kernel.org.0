Return-Path: <linux-btrfs+bounces-12170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B77A5B5D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 02:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DCA16FE7A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 01:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F21E0DE8;
	Tue, 11 Mar 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NJKW6AJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9CC1DFE00;
	Tue, 11 Mar 2025 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656050; cv=none; b=Ld2AeR6Fm53m5yz5acuMzB0RkdXXS9SLPxs7Uw6VJaPNFUpOxiYeko5hbP8FfkfcXLhz4vdSIU/sOZEhLOJd6xhitGhRCim1gl5oULtLV8iNq7Wx33gIFYoxuDzWMB3juvK7aNZO46SuCqegv9Noca9gBF7udXDM9xzO3hbRR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656050; c=relaxed/simple;
	bh=3tCGZ+iADYu5Oa8CKzY2Rkhztp4FvrXT9DxF88nUGVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unv5yhoGSHOVdBZG+sb9Rj+8iYYZJpjsB8vIAndV7SvDSJ188qRVzI7d2v1uJDWp5LI6QP9QElmN5tIjTINJ8EeboVUSRwx7KVluCYD2tJGx0MHkfGXiGwbxtKtgLmxujbpMK9f1d2iNuoZk8L1EGFX43BdARoHrXXhuYPOb+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NJKW6AJB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALfsCC014731;
	Tue, 11 Mar 2025 01:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vga/g3evdtXKKUPmygpssFnr7zgCG3URniCGU1ZM1xE=; b=
	NJKW6AJBCUgSa6sEAdBIf4DaXLPeUgHAKf41rBKDFGo5SjRdlrRbpN54Ty58ItXM
	oGD7nb3Q0uwkkdmnp0ycEArwam9sgXQD4YMaPgqr389Bd8TyLohkh6ZIKN4rNlT+
	Bpympy+L/hcrIhDn/kD55cVKOSw8ejQJO36KmiNlf5XfUeQJp6m8Q24vYP8Mf0v1
	oKp3AZovYIdtDEz3r1hCsceNjBHmSOkEWBsfM1GQaIvGVRKwNq/8RKyo4biJAYa9
	89xwFFS5UP2nMoHsh70+Pxwh1HmLupNHk+onNTJ3wMWxaPvJ89/dKt8k67AV9RhX
	i4SZZq8dgRCgXyDYLj3clg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacbvd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52ANxWwp015363;
	Tue, 11 Mar 2025 01:19:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbencn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52B1JfrC014960;
	Tue, 11 Mar 2025 01:19:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 458cbencm8-4;
	Tue, 11 Mar 2025 01:19:44 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Yaron Avizrat <yaron.avizrat@intel.com>,
        Oded Gabbay <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-spi@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: (subset) [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Date: Mon, 10 Mar 2025 21:19:03 -0400
Message-ID: <174165504986.528513.3575505677065987375.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110007
X-Proofpoint-ORIG-GUID: sv1nwOEp4AdaVFwdqzCD5uTWITacYh8x
X-Proofpoint-GUID: sv1nwOEp4AdaVFwdqzCD5uTWITacYh8x

On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:

> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Applied to 6.15/scsi-queue, thanks!

[02/16] scsi: lpfc: convert timeouts to secs_to_jiffies()
        https://git.kernel.org/mkp/scsi/c/a131f20804d6

-- 
Martin K. Petersen	Oracle Linux Engineering

