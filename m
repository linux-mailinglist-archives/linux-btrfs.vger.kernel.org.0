Return-Path: <linux-btrfs+bounces-21903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FUAMzpanmlSUwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21903-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 03:11:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB2190A9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 03:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4A453015D87
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250122701B8;
	Wed, 25 Feb 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mQSmidgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qfxkFpp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A7225A3B;
	Wed, 25 Feb 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771985456; cv=fail; b=qnz8rtAB0Z3jIJ98gmprGSEhOKdNk6nCws0b2bqPTxegY0ORXZa/fIu9Yelq4ZL9fYA89R7e4rcHNGUiyuBLGGAEQyPPcgP/djVyIY0Wh7z/lSlWgECZGTY1GuHAYuXMX0LN7ri613j+/L0z/7q6x/ilWg/ilMhOug6fwWms59g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771985456; c=relaxed/simple;
	bh=WWFluBq9Utlij8FU8iukneqDoVMjfVUonb6eFZgZ2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t3lZHr8VXoleEGpTHcUx8aVsv2sSzvXeCjzSOsmRW/MAqpEz1MbfBfNAd4ih9ZZJ55m+CUTSG55ZiBA8jY9L7AlGXJl5qvd/YFHc8QlJtLl8b6isANkTvbJoSQVjPKcr0NI9h75xtjcY7YP1u6XPuKTca+VohRcHyViA2keEuJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mQSmidgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qfxkFpp6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIuU07719679;
	Wed, 25 Feb 2026 02:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RYn7ChBUaEKLz4TMi9
	a1a2qvSgCxdNr/LH6MIqljns8=; b=mQSmidgl6N1nMyq3kI+s1YZCbDtmKDrq/e
	3FTGYzFQ+omTNmgMN1v0vWzHGh+S4eJv8s70WZBaDs9XvIDxsQ8CCdHalFJGPJ9f
	kzogN3DQYBYgjjT4idQS97LbMhdtqO+kxz2Tby1R6lnFTyV3Jmv+GTaYpSMl+Chs
	D3hcQdN6SzhJm6gy+rMb/RdveoSuPR+dU5qyQe9Ua7Nea9TvGIKEGiIBWgPYH3/a
	dGWd7feOYC3ARxe6zkaNp6RM6LuyMHryQfvNt+z253x8LIon0bItN8CLfLtkJw1i
	E3IMBhEokOb3EYjj/VbB1cVvjdnR3vsaWSCT4ljRmXwfT9LxzV0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b5d32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 02:10:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P0KfKR006286;
	Wed, 25 Feb 2026 02:10:23 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35armku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 02:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMTwhtqIafvPxY7RTfRKlhCzBEhs1H0373dE4kvDltn5XopzEHQqz31jmRiAvU9zu4w058/wwSK6hsW93stHan7XPPEDWq/cNkoUDl0VlQA8yZ0KA8POV+btiaBRQMstp4BeXp3a1iJI1bRsvMc+OlMsPg+i+LTDvf9iyn8BzWypD0Dg9lhpZD1MNm6y+3iPV86UcoYxJ3eIr5DIQN2l+0TfVTMoXTQmQKhVRGQ1qSQng+xAsqol4M4FsvCuh6Z+LUcHuSbmE3EbGLTCqTX1Jw0DEHrEQRIarrPXsx/+wzPwgzlAxFoKoPxnuBRLaAZIk4QYrziKdo4Jvzm3zKa2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYn7ChBUaEKLz4TMi9a1a2qvSgCxdNr/LH6MIqljns8=;
 b=hVHL28BsZYh1Fle2YSPeNcRN0i9ZRUMf4thimSkw/xvor1ue8GET/NbsrnWtYMwAFOkEc/x68qBsqyKzhpPICdgXkkw+H+7RZyAAIhTgVnqg0z13JzweIGe0zJwdT8XEGNIh9yCJxb+lVgcVNoSkGljujZektZ/ArYftnySgUaORaIPU4/yibeAgInB3ZwOPUqL0Y/KdvOcpZb/JikxPAQm4Ed0v6unqf/oQ2J1aey7lLMt/eu8mH7T/g4WzPNj8VYEhAxbGZgXUPaem8QLcdDBaQ3p4wLH/RGZhhbKSPrfVHjbQeSxdx0V1AQe++M6YOSkE5DYjaq8Td1P8KvO3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYn7ChBUaEKLz4TMi9a1a2qvSgCxdNr/LH6MIqljns8=;
 b=qfxkFpp6Sc9I7MT/pNn7Bt2D0t5RJ7d0Xny8oYLG3IqZRfnTlItARXDzJ1Hj4GDbls1Gq0K9JSXc/LnrJ54+9WXtk25+wrxgQZkUJCCGvRoGWC3NSyaPeuZfhgvEiOd1vknwwb+bGRTRvKDiW8K++PhIUjOryOlQQHqwgTVf+oo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFEE76E158B.namprd10.prod.outlook.com (2603:10b6:518:1::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 02:10:18 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:10:18 +0000
Date: Wed, 25 Feb 2026 11:10:10 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: chris.bainbridge@gmail.com, vbabka@suse.cz, surenb@google.com,
        dsterba@suse.cz, hao.li@linux.dev, leitao@debian.org,
        Liam.Howlett@oracle.com, zhao1.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to
 "slab: add sheaves to most caches")
Message-ID: <aZ5aAlDDpUoZxx_g@hyeyoo>
References: <aZw2LyOjxMc-c3dl@debian.local>
 <20260225015359.1495283-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225015359.1495283-1-mikhail.v.gavrilov@gmail.com>
X-ClientProxiedBy: SE2P216CA0032.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::9) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFEE76E158B:EE_
X-MS-Office365-Filtering-Correlation-Id: 39043319-28df-4dd1-8a80-08de74130513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QTBoktvmbp05ddalcPBR6ax3zJ8OlBIvJEPLZ3DNiIowo1wnB7yi5Yy582mb?=
 =?us-ascii?Q?W1kGj7/7spZyV+EvDynVEFOdhU2Y3stgiKPjpUAy+OmgCI0L+Ry8idYrnRyR?=
 =?us-ascii?Q?JOPALpFVJ04T/BoccVDap+8TUD7Fe70wslKRJj5lHac6TBNVsk53jAOIYCG/?=
 =?us-ascii?Q?82HVi9BwKOdZ6cXkHzTxZjZ3Art3JpS0MkFci1sZFFmmlgaoVWPNVPd0R1y1?=
 =?us-ascii?Q?J6vF+n+oIZMlRqO4h47P5ZIdIxQw/sQiT0BIeAMwmL+mKAWuR8Mp0Unxmlzw?=
 =?us-ascii?Q?bF7lfiWA3MK6QjXQc2dqLnuFRNwBY6T5pb0/pG20EJjqskJZRj4PfHO6x1Na?=
 =?us-ascii?Q?GCjf4vsRj+mcUwmQBICudFx+tCGtFZq1p+F49etuFPr9hLi3U3OV2UFE/uAm?=
 =?us-ascii?Q?JsVAolqPMGmHOJMhZRiSpYQjPHLCuc893HotHGOv88ddCJ0jAn6w5pCwRJZz?=
 =?us-ascii?Q?EHzLwCvLVUWhypQphZeUrvBC8J0phz2gIPK3sPbFCLO+xHBpR9fdfUmyLqpf?=
 =?us-ascii?Q?riNMp4bEgdG/5X8ZCv87IYBzntZu6SACfresLJONYcaoFJilnYlhluurYY4N?=
 =?us-ascii?Q?r7XE/FSxXi1O9B8YpoLJdq5NFuRob5rFYsiSxP7e0Fwsx55QGt/DIUXOW7Fg?=
 =?us-ascii?Q?T1IpBsE3JRUe3W4EtWJN8OH4MX8vLguyLKRHuYoCH2UnJg1TUtt4KNW74cL4?=
 =?us-ascii?Q?p/Ey+w/6vuguReWbHTthqK3sX9tm581t0pNL6DQ82v/jw+JqpkebvUl9qWJj?=
 =?us-ascii?Q?5+tRr/IfnBZ0b78ekGzayyVJOfGA2Ww/IxU6WVi10s3i3lJzJ9LlLI+zk0VF?=
 =?us-ascii?Q?d81NrKCfgfxUsZdZ5hD+mqBDzN3/3sfDzEZd1r7+XJTh9Siuj41AXAZYyS3+?=
 =?us-ascii?Q?lNmMgAJw1nAFywwY3Sc7SvnviNY2zFSU6tb0E6zQU7Vzb98Ls1nZj4W9+RRi?=
 =?us-ascii?Q?Ebe80fHPnwVufDIw8g4HRCw9q/09KVe9C4XL/iKnCe9OEzCw0a31kQgXWRNz?=
 =?us-ascii?Q?s9e/NF+curFPsY7zdONU3rt59N/320nr2jsWz2tEv+wTrsMt3OS2AvxEd4VR?=
 =?us-ascii?Q?0eNWqrFYT/SpHe8/wkR1Tfv+yqu8xv5VD85BNtcxkzJtSl47EBkRmlsKWrrE?=
 =?us-ascii?Q?vh3nPf0MtVsYI1j5709KlaUR/oAW6LRVEBMsplaZAoqVLAoVUzKYxeoejCEL?=
 =?us-ascii?Q?TH7CMOwTIPR+aIrtOT36g/ZxHObcM9blWtbRv/WtunlOMq3W460cN2hpkQgC?=
 =?us-ascii?Q?yVdoqoVgnihM56IoM3vYdvxtyBFebKplE0dI0XYCIOy8VZqwqIwClGibnqdC?=
 =?us-ascii?Q?2la7+yOIg6nuRUX+KcvnplSQnhTL/BsBi4Xf1vnt5gvCiXfmXqhHxwuMqKfF?=
 =?us-ascii?Q?ckv8m7MchdWT4DfaVD5xmnf3KfgdOJScuV/JvFOhvu0d1VPeZHbdmUx52EEY?=
 =?us-ascii?Q?0lgSviogW5vYOKKIXDwrZL59bAE/xqQYccpi5seWlhOkqu42iYp05Tt1lQH9?=
 =?us-ascii?Q?xIXEX4utiMAO6VPAW5OQyX5BHwJugzkppdq+FW5Swwxn4wlTd0jDvs7nMipq?=
 =?us-ascii?Q?Ablbq9zapF53nSoYu2I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7vh3QYR4ZzU1JRm7pPUMNXMxFZxtTvPSjEgxOCd/HYBjtYjZHGmVs/NqOOyu?=
 =?us-ascii?Q?V5/CnZg64aS5/hIB/qbReeviIxTRNSzzAPGWPaf6y/qRK/2Z5QQbmGoh6PnI?=
 =?us-ascii?Q?crhOT+RNFgXL9jPHZ4ewXGBGLVqBZA5S70uykkYoJUkjfNszNc2/EYKCROpe?=
 =?us-ascii?Q?b7J81QqyJrULx/iFoAmfB0FmkbWfpholMuw44ExgQizRXTC73GG6NiS+t+w2?=
 =?us-ascii?Q?rSe0pfsdV/cJKMZhRvdQM6eVuUcK8GQvWDtc6vrl1rF57wcOMsSbJcQUKsnM?=
 =?us-ascii?Q?2yJHZ54KFzH9DyY63k3Z9vM9fCsXb4XKGyA/PHE7o0ASjvg7Ifu+JjajuTIx?=
 =?us-ascii?Q?fYMlvQtUfVQ9ryDFOzrO2wOtdfV8gi5sEQvhZGTIFtmAS9tPx39I2yEVrHY4?=
 =?us-ascii?Q?ugNJxYfy+VNlXVNC28v4ELLDnlVuhRqD0zUesdEtStmzhDqbiC+9h9B/Ymjh?=
 =?us-ascii?Q?UzNzZElvjR/sQmSOdeu3oCXpttqf4PNjUUv6A9ZSbLUSSx/KYMsqxm6BCtxq?=
 =?us-ascii?Q?uKQud/QBirPO+tYKuhQSDIWOyPC+TlNvaaNj85J94wK6p0niiIJhL/lA/YNs?=
 =?us-ascii?Q?CcqPfUz8C2XxCqs7AmqkxbDL2vzZAR1/HaWtY2gMAHLejqYqvb+MrZvcv2/h?=
 =?us-ascii?Q?cWE2ihVIBW8H9Hr3JlDZJ0WKmfDu4tqena2yeCOwn+p3sKHbNwSCgGlPAgKp?=
 =?us-ascii?Q?eM3uCKNIXjGuB5wmR/Culd8SLuayadpRtFGvE/ieCjfQuR8lylyoAmE/cGat?=
 =?us-ascii?Q?Tbm6IHnQSf+TlVg2ck6w5Xjkb2CaPjKyxbPdwQS3yEmJL99w+Qkx7GzNCmMg?=
 =?us-ascii?Q?ycWn1H7RCHRKm+/6051dgIY7LDcUoHniLUkMVYqPwL6jvjB9BuybJRRlJqVG?=
 =?us-ascii?Q?pAY8ZJQEpwWICFLmW7WqFtEkgwOrny21DpZ602yEGavSEh0+13y+oHNNi5Hx?=
 =?us-ascii?Q?t/shGgEqvDP86d2BtZzjTXExRYJKV6WxkTSUxylmHDR1Ro1SFoLXmT4/RC0l?=
 =?us-ascii?Q?KRwdolFZgnCV3w9xuLUgItr8Qgu4k2+BFaNJOvI1jmMlcoCbkpCL+dGpfI4C?=
 =?us-ascii?Q?KAORD5koD8Df6KjYy5PTa8OefU/23fj2wOyd0LRYS0xWXzDpGaBmDaI6fFgt?=
 =?us-ascii?Q?iDAVOBgab/byiw5DLxw5K0pS9Omv2VQEThqrVHsX/xozaX5pkVXYN6GxDU9N?=
 =?us-ascii?Q?Y47VwP5l563tyhpcdTg2LpIQOruaQZnv81zXPhvq8tRRjNkxIVErMMFVTxgT?=
 =?us-ascii?Q?tt6+14zSpSByH7wpOMyx8KJvL8vR5or87TkTI6gkq0pLMuDGbAFgMDvA/K9k?=
 =?us-ascii?Q?6n5+6Jh4ZUJfdLccfVeBwohBO9fTS3atCq5tMSNIWT3ayEbS4TdMR1kVclWw?=
 =?us-ascii?Q?YtdaEoN+deijf0WlScI02wgBtZVWZ3iE0oUC/CyB8uHaGPvOF8jCLrjDt6Qe?=
 =?us-ascii?Q?rkJQJh5Z70sm/bwo7Ghpl4UnEw3a29PkWFL5ZBQ/ctCLp9kNCY68fkm4tSnK?=
 =?us-ascii?Q?XFsTFqAp5jDNHZQiLf2wWL9OlDT25r/fRNMo88XclJKEuP4+93c52MOuPvRL?=
 =?us-ascii?Q?m0ewTzeApdaRmJQ35Nc1sYvrRDQNfd+PbSnFA3SzUNCCytGoYWyvXhjfDuaw?=
 =?us-ascii?Q?zYIC3+2lrWdJz0JFS6xNU5RzGJF9u2EkwZD+sMQFmu1R66StR0ZeZlcQy5ea?=
 =?us-ascii?Q?lPMFkktFcGf+7KjJBTbvUYNQ8ywfi5eiInD/Y7/U638BFuoHEy6Stl6hunMk?=
 =?us-ascii?Q?7blQxMeXLA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ewSZEcNG+5RkNraHp2+t5xZpyhzjPuNq3sTV2clBVaZGJ+nsT0wYLnYd34Z+T9jMRPIjWFjVegl6WSivQMMJKbD8NDYTd0/hNly6nkXnc1m6z0jxg4X8l6l67vOwU9fIseZH6v2NNhoRKzdSp9kgrTk1f5/qZf4AgkEi0QY6C9y/ved8zzLtZga9/qzdW8AmRiHpfhanYY3JFQZ2yaljOzgt14scoMen7M0KVg28UGEow2IDvvZvYsWI4t1uYvYa/JdkmB9wlPD0R4yD2/GMJ9TfIjnKdK03gNxEvIH4pPQ4U2kb84f4g0d+tCxNC30/5N0i7bEY87uelS+hLEdoM7ECt/FdgvxJFLYxU9FtZKLN6E34PtXnaEsOsGjYG83Z+8w43D41KrHfyeciR0lXVIe9967KYLx8UH9AGfU7gucs4BeUeG3T21Xn1GrUbYHe/eIO6tsQX3lBfrusm0PMfVs6rtWCg9sYFYkYUKIIzzSUDAylqqQEwtdDaP2gxkDua387JhIZQi+Ki3Zh1/XbkrrdI2tJwhW3pJ5Z7Pf6zOxtt47btTcJ3UGbNi3KZtlIyMw4eCjx+huGwRLV1pcNMXoA4THEWQPJbAvhzzAmanE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39043319-28df-4dd1-8a80-08de74130513
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 02:10:17.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdiJAxgLf6JqwwcG1ZE6ESL88Y+in9+Vh5o0CrQBZUjh2sATM0goC4sXYI7Tehdhuz8FDls6Oaq+w/TTrCEWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEE76E158B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250018
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699e5a10 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=mBMjns2hus-eAT3iRvwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yK-nqujfL98bMLLZDbU86otUknM_ChSm
X-Proofpoint-GUID: yK-nqujfL98bMLLZDbU86otUknM_ChSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAxOCBTYWx0ZWRfX7DvcgswlW3G2
 IT3vf7SgJuCW13JzRABSkBcHFTPd0B+GuiMyz412fF5Wzzqcl1j5hx67hNympZ+lH+GcK6vm0Do
 atU2DPEZS9PAqsabikyfArLZeewcWlnyIqnzBUS+DhoKkl13KCUYVTVyrXQdUtnzogpkSbJgo6n
 D1CQoETGsewyk9niIBzWy/+qlFB8aQzjD1+j2OPH7y/l/sN+78lf2FDCwR2+4U0Pz7zI+uXlpUR
 f0mtRb3p82P3vcTnESqGjmN5o79AZK4Egt5aooD1fZcxQRpXhxZAdLlKH0NCJt/4TWjDwuZlOBe
 rJbI5nnWYEzU7YyYEz1WE7V/Ufiij4Wzz9gvBn5amP+8lEFkDeEdT9WORtBOdHIoZIPiDRndz59
 llQtTzI2rfnR12Fa71lRCDS9QKXXU+uyLiRmmdotxRL+UML4+Sk/A6JwZbB4jIaUsoUaGU/4I2R
 w2WcmB9Q+52fnrDK+WA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21903-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,google.com,linux.dev,debian.org,oracle.com,intel.com,vger.kernel.org,kvack.org,lists.linux.dev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 70EB2190A9D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:53:59AM +0500, Mikhail Gavrilov wrote:
> I can confirm this issue on my system:
> 
>   Hardware: ASUS ROG STRIX B650E-I (AMD Ryzen), 64GB RAM
>   Storage: btrfs with zram swap
>   Kernel: 7.0.0-rc1 (commit 6de23f81a5e0+)
> 
> I was seeing the same kswapd0 page allocation failures periodically
> under memory pressure with the identical call trace through
> alloc_from_pcs -> __pcs_replace_empty_main -> refill_objects ->
> allocate_slab.
> 
> Chris's btrfs __GFP_NOWARN patch suppresses the btrfs-originated
> warnings, but after ~10 hours I hit the same sheaf refill failure
> from a different caller -- amdgpu via kmalloc:
> 
>   chrome: page allocation failure: order:0,
>   mode:0xc0cc0(GFP_KERNEL|__GFP_COMP|__GFP_NOMEMALLOC)
> 
>   allocate_slab
>   refill_objects
>   __pcs_replace_empty_main
>   __kmalloc_cache_noprof
>   drm_suballoc_new
>   amdgpu_sa_bo_new

Hi Mikhail,

In this case __GFP_NOWARN is not specified, so indeed
we need slab side fix.

> This confirms the fix needs to be on the slab side as Harry
> suggested -- adding __GFP_NOWARN to sheaf refill when there's
> a fallback path -- rather than patching individual callers.

Thanks for testing and sharing the result!
That's very helpful.

> Happy to test any slab-side fix.

Slab fix is submitted here, please feel free to test:

https://lore.kernel.org/linux-mm/20260223133322.16705-1-harry.yoo@oracle.com

-- 
Cheers,
Harry / Hyeonggon

