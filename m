Return-Path: <linux-btrfs+bounces-21833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHXELuISnGkq/gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21833-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 09:42:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12417330D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 09:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66D13028ED7
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13BF34D903;
	Mon, 23 Feb 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qugaYJYq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hnnOuDPi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B512434D4CA;
	Mon, 23 Feb 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836120; cv=fail; b=rYw0N4+4K9PrRgi1FDdD87q5oQrs8Tca3wcEPoyZKb8L+c/xdSBaoO+R+U9jfs8Y9G/eT+EJAyprG9qSxSxFxNSMaWs8CVyiiPvzW4IBw4nprks95+Qx+1SW8UhVHKvTTGon521qg1dwpDpSos6ZqV+g308yP4S/Yz7PXVmVTtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836120; c=relaxed/simple;
	bh=De3hna4MLqzaBttVrkk55+fSBwZA2zWQrOT5a6/4wzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VVgLKT4yVG8t18O84lh11iMqwNya4ldx1BrxIHuMEi3iRwLXaTuE0Yrgd8JDtFu7v5Bds9os47Y4yDbdHPUDmXVbd1n5B80wqaqF8ry0q0qRQhjNbs1nQR2NIY+pqG8Bc82NjlNbAA/3PeR3co9AgaP7hsJZ9Bn27QlmJaezeuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qugaYJYq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hnnOuDPi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4H4YJ151233;
	Mon, 23 Feb 2026 08:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t5xz1rKGfz64QBI6Ir
	rnvWnYJpk3R3CJ8e/0Dza4c24=; b=qugaYJYqjzaBGN/4I2FV2LmXyoJRhRiV4d
	dX0/xeezf0nSf6BlRjlEyU3vfDFiR//M71cJto+cpxCSPizSLgi/2FK3celXUG/3
	dMSJa/2wnBVRVZ4hTO0Cu+xpfviQ1r02QxHUGLpm30j2b4THoQfWdGc4HBmiCJZs
	G2zAe6MjlZ9gBZu9OIv7GrMWkmadZzVsUaGd83llGe5dgwkAWfJmsXGvK8ye5Gvb
	A3AsNMrkH58EeTc1AaQJXU0YdcsocxqO3zvrTyVC0FT1Er46n2MhFmffs75b51UY
	L/ookus9e2kVXdfVzbTXOdDty8Iecp1MCI4iQd0CRrxMODnsnsIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3a01qft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 08:41:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61N7593N028585;
	Mon, 23 Feb 2026 08:41:29 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35830db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 08:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3nhTHu6KLqNxQn5Jqd1n7KNUlOloVv3hg6ZOoLzjqfSF0fQZOITC+rxiCQF9P0hj5whTo4Yf0En8yQBV1Qqmu+VlUL7G1MCZs60R5SVhxD4Oxxl3O/vcxJvnb1UGmHeIVkmvYy38HrV8lzLtkZifTsbqzWym6lnjEC/K4IuONlEvteNGZIGNaaQpYuq5D/3sjBRrpr60nFEdEOnyBJ/FT1KxyPzev42WWZax8MTAnN4ZOcAnbUh9TffQFCcBPtkHk8/+pOKGyC3Vabn8hTailrJiTB383sxMPI8lvzJ/lTbWJL8RMxqMaA2wewWq9blVWXwF/oPHV8ed4sReZIj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5xz1rKGfz64QBI6IrrnvWnYJpk3R3CJ8e/0Dza4c24=;
 b=HKPK6ACZ/UaOTpXmGwMVwBD4DIHElRZsECLV3iFoBpZKh3NE80h+g3rbUS41upa8W4yeVKWNuTlnKEmatXYHK4LlsRN/9mVkjnVButxnFfIyXcmzLodXRxKVBFAfjwtL4y65XVQiJukmpbt4hRf0Pq6ifayv9yRto33ySW9ajwlGoftAyrWEWxWCucbstdDRU47KYCnY1aicH6J59SxJn2+bsMDTcFhSep69Hw9MVQZ+bD8pUuBZSY9UQZ3KP/Wb1QipFelsyRGoMUG9XsWql21AgsH0VNPSNJoX8YAdnu4+QC5B2yViaa3TJofnm53KJHbr0x4e7lysGW8aWEFgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5xz1rKGfz64QBI6IrrnvWnYJpk3R3CJ8e/0Dza4c24=;
 b=hnnOuDPiFgded0N0WtgDNDCk1vzMX55F6Ber91b16RzBOsUEptyPP1svLIlMJWfhzmYpJ3tWGZbKqMu5I442sm1yroSUyEM3lz2SHLzdznGC5aJqCm5ibv3bIFWKPcWN9jbwzevJP0RmIzKeWsquBiGGs2e8ia4N7aLsHpHBq2g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPF4F3334483.namprd10.prod.outlook.com (2603:10b6:f:fc00::d1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 23 Feb
 2026 08:41:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:41:25 +0000
Date: Mon, 23 Feb 2026 17:41:17 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: vbabka@suse.cz, surenb@google.com, hao.li@linux.dev, leitao@debian.org,
        Liam.Howlett@oracle.com, zhao1.liu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to
 "slab: add sheaves to most caches")
Message-ID: <aZwSreGj9-HHdD-j@hyeyoo>
References: <aZt2-oS9lkmwT7Ch@debian.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZt2-oS9lkmwT7Ch@debian.local>
X-ClientProxiedBy: SE2P216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPF4F3334483:EE_
X-MS-Office365-Filtering-Correlation-Id: 4611701f-bb6e-4696-2589-08de72b7547f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsZIiIo/HfV4RrKKvsXvE8HXAT+IgJ8xaeBDJvPFWoIXwfNtjqyQ8C+LPA98?=
 =?us-ascii?Q?lQguY3WT33bQJ8vWx48TfDi1jRv81F/sCMBdmhMB6b5lhhriYbtwcQL2kGST?=
 =?us-ascii?Q?/zalNgwAjQEpH+LanvpU2DS7ViTqnqCNbqdMb/Hh0bMmZj+0U2MbyAvrZbln?=
 =?us-ascii?Q?NqY2IS/a3uJ3nAiC+I9a/HAJhpM/yTenqUaadYzHGmC7QVhZFZKZlrJt1IEe?=
 =?us-ascii?Q?F6SsVk/q1rgP4H8kclW6RXcLQX7sPmRM5/Mhshx9Qszs3CXbygV7SD1+GCem?=
 =?us-ascii?Q?bgFEft5rce+7ci1AshQgPh7i5ifTOgNuyX3MpztsGFGOz511OCNjSPzre/1g?=
 =?us-ascii?Q?wrxPHrn9FVFOoHMxRHP7SLS7SA9kqnUeppKx419Q0pwGy4GZxoLqcVfRvqjF?=
 =?us-ascii?Q?UFAH2CLbWuXenMhnWH+cbToU1ZyZuKO3BMt8Ya8VqiFEPv/n25KyJNB7h/ah?=
 =?us-ascii?Q?6m3ApLsFpuXG0m2iTiy/dDJ4Yyjbx+EK573dLk5PFA39nnCl6GAcS5S5o03a?=
 =?us-ascii?Q?qMs9sddH9u/dikD01YM70HW+vYG1Rru/VdmHRHct+EQBg1bLehOT6UX7viBX?=
 =?us-ascii?Q?p8rcHRFDKU67HvXHEQy5MuomZyDlZUDv/+jghhHIVeUIyYbgojbdEtm//MrY?=
 =?us-ascii?Q?Ow44FTZnLT8B52g34+2P5EJEVP1QauWtI0GvOctrnl+VeUxXdkvAjEK4yUha?=
 =?us-ascii?Q?EwjW8sgxMEsjlXM2cnzR3TEHb+Rhbi2hdsH97aX1veaKYRva7f20CEEJE9aH?=
 =?us-ascii?Q?8Pg0DqMIUKqqICYWfmmZ574U/3tSXXU0t1ViLhlt6de4NiOJXjgxXCBZGE2K?=
 =?us-ascii?Q?1Fl8aOx6Y1wrXW3nb3fIbdWxGvjRx82Fu84ExP/utbTxz41ktAXOciyhn1oD?=
 =?us-ascii?Q?4PnUA74Vqr1uYeT1QN3zZsQ3ZfH2TL3mJbcdGlKRiyTM3RSsObbXJEVXCLpg?=
 =?us-ascii?Q?44fK3XhTNo3bus3SbMI5PMwYqgDSGkW8Gatwj15Xgw8KqyiXaUAsgScqqlJc?=
 =?us-ascii?Q?Taop5mwyQS5qQU9TT07V9QFxzj/wrimv5gVD/syH1Inx1clHe34g/26l/gWU?=
 =?us-ascii?Q?Ok5xHhdCoExU89B6Vanxdn9CHKF4B9diIMKGDILiz5QT/blUtJIYp2WEQWnY?=
 =?us-ascii?Q?GXpdX/ZaFs1JhywrXFzU3jwsGJ4sP5LC9Orx+Ff/BBZKjGHRs46FGlrHZf+q?=
 =?us-ascii?Q?wehB8Ao7afoq+BOORlKaTzbLgXIun3HaBHyfQEdSmBh0UDwsELBsyK9NX3ls?=
 =?us-ascii?Q?yRHAc1J0IrdKSej3haCrmRDnHn4qJ/8Z9LuRtCHnkC/fBPGrwmVckGslxpAb?=
 =?us-ascii?Q?gpfxT3e/6XRirCWTZbi1OKOO1uVzYGg8OkR2m6YWuWv9FumgwHaAAd9ocmeG?=
 =?us-ascii?Q?m7kpB1RIqF7qFl3uPvlsxKuIS6W/kxpR17Kz1+X1WgsU06pdvWvv0kfamF0n?=
 =?us-ascii?Q?AvhoqOdK3oWN6ZF89WN098KXfXwoJFwvItqUgIukVgKjOEyaAVrHu9miTigy?=
 =?us-ascii?Q?+A9El1GYsHU/EdSW9N5GyyYegyIIsQEEG0yZxzfXvGCNVJtNyJ/FgZAQQPql?=
 =?us-ascii?Q?bglx4p7U5m+6gvUoSt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HfeugrF0Z/ynIZDy4BWEyfE8dITE/i59z46E92S1KsI6WaeDGRzzH1yybH3E?=
 =?us-ascii?Q?eN3u/ql8xgQX11LiLzZ36MCHXJDzVoLr4zzrYf9NrHeh9QcySZ4mkGO27e7Z?=
 =?us-ascii?Q?uPB/Cv2NrJqBbHM7zXqeNcQ4IH1OWuLis83ut7BpyvsBlMs3IfwTN2UEZOKA?=
 =?us-ascii?Q?UthX86Gij5CB0ExER6Hu/mbkBrhzJjhfWqFjHkzpueguZrF9GLgPDZRwKfYu?=
 =?us-ascii?Q?qEmXyT2RU6HbPnvUt+U4doahBOilmPJDTrR0ulOv1rnYhU+ze3IVYV4lWWYL?=
 =?us-ascii?Q?20EXtNVMibh2drpKs1EZWDLn//1RzjO9LxvKhw3O3D2qXXV5fwKxuCEGAgn2?=
 =?us-ascii?Q?1WMTq/ogW6S85R0Xie3QXSDS2ZLSuQrWej+6LvdWeIV9IbGRbtLOzD0Zy+Il?=
 =?us-ascii?Q?yCsRCcyNzG5ndAYD+BzfV87OvVnx79JxoMRAqGPLcXWHWKdMvnu0V8B1u0nc?=
 =?us-ascii?Q?RKfOOigUbW4v8hJnfgMtXKs9LiiispVmIJIJLunMmCuU37y/zMqyhTu7N6Ur?=
 =?us-ascii?Q?wh4VH9NfENZgIs3QF1H/D7gZk1WS6ptUHpPSEe8/3/waTFP0p+6W3CVAGKT3?=
 =?us-ascii?Q?IUD9SSwyjCxnGiMMDMNPSHmfIl68f7CCxwWGB+I0/+cS3Xi4+CZrS5w5Q5Va?=
 =?us-ascii?Q?ExOBbo54nRQ8O2qcrwkcXvuWjSTHgq7Ic6UAIJQA79SL4wNzBkoOfpP0WPKE?=
 =?us-ascii?Q?6h1+nAtPaZxcb9l7xVum3GlnNyfS4JIatqB12JVOalbqH/B7dVxtNVyrK/GK?=
 =?us-ascii?Q?EFI42EcVHZTRqAGF0FVx78ab/Ss99uQg+uSJd+uhoJKV8gwKl7zWhBcfNCTH?=
 =?us-ascii?Q?8ckP1gUSE7jKnzTtiBW507tcundnvrZBXEJiK732KAkrEaF8YlKYsJbuzYyx?=
 =?us-ascii?Q?vADc459ZPLzkqny0M1yG8QnnsG2jOTD9knSN2+hoFAC0lr5UbcviakcaNfvn?=
 =?us-ascii?Q?Q/TYDGqeAG9VKvUK9SRZVB5PFySrQjaWQ5u4Kdmu817WcT0ntuKBpw6XjoIk?=
 =?us-ascii?Q?s0ujhVxcSpoNeiXN0Z8dpyNP5Ux6V7YoO3fz+6cwWrKditb0qF/PCPAnARMy?=
 =?us-ascii?Q?BSTAsbxYDVINjzA6ZbXwJeSTRkXBQs6vFhKoi20IsJIogUDlrDjLb6eN25n3?=
 =?us-ascii?Q?gagirEUHA/8FtPbB76Dg4yu75mhk5y5BkwgqPReqWlIvzqgEhkAbUqU+7zGA?=
 =?us-ascii?Q?pYL5GMiKqpLiA/O04/zitkooyCa17A/GddYakE1D2XITnFFp+tJfVZPEHzuK?=
 =?us-ascii?Q?xa1dVwwquBYY+Q3DIn09LiJS+gm+U5MMfPuSexHf35V3nVj1bGkP/fI54Nzk?=
 =?us-ascii?Q?EuQ3UpbruGGZmoCIYtH/DL+M0phwzmGmTE14hL1rrmVnIepVQzgwNFnHF62X?=
 =?us-ascii?Q?7SUPdTXg5GV6zuMoCTHneaM1prVKyCeXBhpI+NvxWjpZ79qM/pmJPRvdDXX8?=
 =?us-ascii?Q?TFY6vw6fn+X9FQBZ225J8wNXpgZyAu/nL5OnsQeCZugQNm4H6P4HRgbO9hLF?=
 =?us-ascii?Q?vQtUE87nZZEB2Dy28qOrN0LuOF6/rlduuSQLjA0aepiARNpjC8YBe5qyA366?=
 =?us-ascii?Q?vEDhBkufDOltUH+bLJIDg7DcdbsK06o6IW/qoUsbY59ZrZ5gKaLp+yYHvhAf?=
 =?us-ascii?Q?GTl+qeCzgLW8bpCzQy6NPQBfiV+Qqrv/u1X1ATp9UeFTplAXMtC911elpf07?=
 =?us-ascii?Q?Pu8cy10945vNH4st+mrAqSgOh2nFP9bloU0DsJbR7Y9qbbfKHs0EadDg4THF?=
 =?us-ascii?Q?FCjzorHnmA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J2yo7Nbe/K1Gnm9K0P0Qw5RBOdBhHjnUnmzevlHJP70ChWungbjMyT2kjomascxgHP9pxKxKfPWxYOWPjtHVCV/7XrKKCD0GtZhB34GYCDyxBLIN+B2gvCuMkCt3E9eL3Zw7lg6onsYnQRrzQxNsMbz2jTxF51mrOBzglDgEKZD6/mIABukoQhM3EbEhjG9lJaFfmD75cGGYBloxw8KawkqtO/tTSt9Ri0NyweL8tTiG+R8P1eBpBlzc8Oydhzb2GpcYNv1s7+ZtNiq7doQwItXhto6nvhIcef83YNx14OKfJwkLqE1Q725NYL9bpc89eQfkbxaZSze7DzizSmIUHhvyRQmMI8AY5MXl4yglMHl/ujP+wsvLfAKN/G2kFGRcI+XVgGAXFtfevWW2j5kaVMmL3txfDK6Hhn0XwJcBLPDI/hh080M62UzxvchcxykXb5TzgdzBo8wLoVPkRjrqin0pGIRr4lQq91uT6oJf8rDdrfitildMcmnLx6ZX3Ml1JP9LnZR4/ROIQDbyu2rdhfRNffHp2bbduyHDqEfmk16UT2m860+62b3d6BM+euNhnzuT55OI8JWJbIdv0dfjax7+y66abEVE2AKOJM7D5QM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4611701f-bb6e-4696-2589-08de72b7547f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 08:41:25.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnxU0DA1mHBcN84g5yfU3exm5XSEzGwAlYgTbGV7rSNF0C8jopq0voCRb9bl1+hs0XJhQMdZLiwGWq1OAJpwMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF4F3334483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230076
X-Authority-Analysis: v=2.4 cv=IskTsb/g c=1 sm=1 tr=0 ts=699c12ba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8yO-SKfoFBD8T4GZPLgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Y6EFO04NEcK8-hUQq2KGkfbVsXl4k1wy
X-Proofpoint-GUID: Y6EFO04NEcK8-hUQq2KGkfbVsXl4k1wy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX00QftiGarKfX
 CjTL2NPf+AoIt+KN4NXtZayddRjIv0Ar28ZFkqy25XC62FWqgrQcrI7K+bpo7S854pWJVBY/VtK
 JuI3ulA03nVX6Etwy628CYSXh5G+10XokKSJy9tOa0Bn3Q7OOZ5FuUIHSTRzObzupAaldrxVyQn
 yE8p2q6qHgQdglulR2bhuU1nMHDOwD2ERfKIbBsqQ4U83NEalbu1RU6ZhwI3h+Uua2e3O9vzKwn
 WWVgGC7y4xz+jGvSSrvvpoC2+UeVSFuukkYOLkaiVeQmt7sbMLJFrWmUKFRAufA5HuaZ/sjAwyq
 M/AbfDU9v6D1sxB6QI+96m0MNhUXCzYHO7edARDb3i76INuD4RNokJuepsl7T5BmhvQuHiR3hVa
 uEvt/1yr4g67ZUrS5Zqj4rlx9sTTZRB0XHJ8dXK0+Z5GhXs/TB0tOOOqj5CHTWw53XyOryK4xC3
 Z780Pfh1dFw8deBaSJQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21833-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1B12417330D
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 09:36:58PM +0000, Chris Bainbridge wrote:
> Hi,
> 
> The latest mainline kernel (v6.19-11831-ga95f71ad3e2e) has page
> allocation failures when doing things like compiling a kernel. I can
> also reproduce this with a stress test like
> `stress-ng --vm 2 --vm-bytes 110% --verify -v`

Hi, thanks for the report!

> [  104.032925] kswapd0: page allocation failure: order:0, mode:0xc0c40(GFP_NOFS|__GFP_COMP|__GFP_NOMEMALLOC), nodemask=(null),cpuset=/,mems_allowed=0
> [  104.033307] CPU: 4 UID: 0 PID: 156 Comm: kswapd0 Not tainted 6.19.0-rc5-00027-g40fd0acc45d0 #435 PREEMPT(voluntary) 
> [  104.033312] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
> [  104.033314] Call Trace:
> [  104.033316]  <TASK>
> [  104.033319]  dump_stack_lvl+0x6a/0x90
> [  104.033328]  warn_alloc.cold+0x95/0x1af
> [  104.033334]  ? zone_watermark_ok+0x80/0x80
> [  104.033350]  __alloc_frozen_pages_noprof+0xec3/0x2470
> [  104.033353]  ? __lock_acquire+0x489/0x2600
> [  104.033359]  ? stack_access_ok+0x1c0/0x1c0
> [  104.033367]  ? warn_alloc+0x1d0/0x1d0
> [  104.033371]  ? __lock_acquire+0x489/0x2600
> [  104.033375]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> [  104.033379]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> [  104.033382]  ? lockdep_hardirqs_on+0x78/0x100
> [  104.033394]  allocate_slab+0x2b7/0x510
> [  104.033399]  refill_objects+0x25d/0x380
> [  104.033407]  __pcs_replace_empty_main+0x193/0x5f0
> [  104.033412]  kmem_cache_alloc_noprof+0x5b6/0x6f0
> [  104.033415]  ? alloc_extent_state+0x1b/0x210 [btrfs]
> [  104.033479]  alloc_extent_state+0x1b/0x210 [btrfs]
> [  104.033527]  btrfs_clear_extent_bit_changeset+0x2be/0x9c0 [btrfs]

Hmm while bisect points out the first bad commit is
commit e47c897a2949 ("slab: add sheaves to most caches"),

I think the caller is supposed to specify __GFP_NOWARN if it doesn't
care about allocation failure?

btrfs_clear_extent_bit_changeset() says:
>         if (!prealloc) {
>                 /*
>                  * Don't care for allocation failure here because we might end
>                  * up not needing the pre-allocated extent state at all, which
>                  * is the case if we only have in the tree extent states that 
>                  * cover our input range and don't cover too any other range.
>                  * If we end up needing a new extent state we allocate it later.
>                  */
>                 prealloc = alloc_extent_state(mask);
>         }

Oh wait, I see what's going on. bisection pointed out the commit
because slab tries to refill sheaves with __GFP_NOMEMALLOC (and then
falls back to slowpath if it fails).

Since failing to refill sheaves doesn't mean the allocation will fail,
it should specify __GFP_NOWARN with __GFP_NOMEMALLOC as long as there's
fallback method.

But for __prefill_sheaf_pfmemalloc(), it should specify __GPF_NOWARN on
the first attempt only when gfp_pfmemalloc_allowed() returns true.

-- 
Cheers,
Harry / Hyeonggon

> [  104.033575]  btrfs_clear_record_extent_bits+0x10/0x20 [btrfs]
> [  104.033615]  btrfs_qgroup_check_reserved_leak+0xbd/0x2b0 [btrfs]
> [  104.033659]  ? lock_release+0x17b/0x2a0
> [  104.033663]  ? btrfs_qgroup_convert_reserved_meta+0xe90/0xe90 [btrfs]
> [  104.033703]  ? do_raw_spin_unlock+0x54/0x1e0
> [  104.033707]  ? _raw_spin_unlock+0x29/0x40
> [  104.033710]  ? btrfs_lookup_first_ordered_extent+0x1d4/0x370 [btrfs]
> [  104.033762]  ? preempt_count_add+0x73/0x140
> [  104.033768]  btrfs_destroy_inode+0x301/0x6a0 [btrfs]
> [  104.033820]  ? __destroy_inode+0x194/0x570
> [  104.033826]  destroy_inode+0xb9/0x190
> [  104.033830]  evict+0x4d8/0x900
> [  104.033832]  ? lock_release+0x17b/0x2a0
> [  104.033835]  ? find_held_lock+0x2b/0x80
> [  104.033839]  ? destroy_inode+0x190/0x190
> [  104.033842]  ? __list_lru_walk_one+0x30d/0x440
> [  104.033849]  ? _raw_spin_unlock+0x29/0x40
> [  104.033851]  ? __list_lru_walk_one+0x30d/0x440
> [  104.033854]  ? __wait_on_freeing_inode+0x2a0/0x2a0
> [  104.033860]  dispose_list+0xf0/0x1b0
> [  104.033866]  prune_icache_sb+0xde/0x150
> [  104.033869]  ? list_lru_count_one+0x13f/0x270
> [  104.033873]  ? dump_mapping+0x250/0x250
> [  104.033875]  ? lock_release+0x17b/0x2a0
> [  104.033882]  super_cache_scan+0x302/0x4d0
> [  104.033889]  do_shrink_slab+0x32e/0xd30
> [  104.033898]  shrink_slab+0x7b6/0xda0
> [  104.033902]  ? shrink_slab+0x4b1/0xda0
> [  104.033908]  ? reparent_shrinker_deferred+0x330/0x330
> [  104.033914]  ? trace_event_raw_event_sched_switch+0x410/0x410
> [  104.033921]  shrink_node+0xac4/0x36e0
> [  104.033933]  ? lru_gen_release_memcg+0x3c0/0x3c0
> [  104.033940]  ? pgdat_balanced+0x15f/0x4b0
> [  104.033943]  ? __cond_resched+0x23/0x30
> [  104.033950]  ? balance_pgdat+0x739/0x1530
> [  104.033952]  balance_pgdat+0x739/0x1530
> [  104.033960]  ? shrink_node+0x36e0/0x36e0
> [  104.033962]  ? __timer_delete_sync+0x177/0x240
> [  104.033966]  ? __timer_delete_sync+0x177/0x240
> [  104.033970]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> [  104.033975]  ? __lock_acquire+0x489/0x2600
> [  104.033979]  ? call_timer_fn+0x3b0/0x3b0
> [  104.033981]  ? schedule+0x2ba/0x390
> [  104.033990]  ? lock_is_held_type+0xd5/0x130
> [  104.033997]  ? kswapd+0x364/0x7f0
> [  104.034004]  kswapd+0x445/0x7f0
> [  104.034010]  ? balance_pgdat+0x1530/0x1530
> [  104.034013]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> [  104.034016]  ? finish_wait+0x280/0x280
> [  104.034022]  ? __kthread_parkme+0xb4/0x200
> [  104.034027]  ? balance_pgdat+0x1530/0x1530
> [  104.034029]  kthread+0x3ad/0x760
> [  104.034033]  ? kthread_is_per_cpu+0xb0/0xb0
> [  104.034035]  ? ret_from_fork+0x70/0x850
> [  104.034039]  ? ret_from_fork+0x70/0x850
> [  104.034042]  ? _raw_spin_unlock_irq+0x24/0x50
> [  104.034045]  ? kthread_is_per_cpu+0xb0/0xb0
> [  104.034049]  ret_from_fork+0x6dc/0x850
> [  104.034053]  ? exit_thread+0x70/0x70
> [  104.034057]  ? __switch_to+0x36f/0xd80
> [  104.034061]  ? kthread_is_per_cpu+0xb0/0xb0
> [  104.034065]  ret_from_fork_asm+0x11/0x20
> [  104.034077]  </TASK>
> [  104.034078] Mem-Info:
> [  104.034111] active_anon:511 inactive_anon:2355672 isolated_anon:0
>                 active_file:77595 inactive_file:204731 isolated_file:0
>                 unevictable:7150 dirty:925 writeback:57
>                 slab_reclaimable:20227 slab_unreclaimable:201840
>                 mapped:121227 shmem:10197 pagetables:9634
>                 sec_pagetables:733 bounce:0
>                 kernel_misc_reclaimable:0
>                 free:36223 free_pcp:529 free_cma:0
> [  104.034119] Node 0 active_anon:2044kB inactive_anon:9422688kB active_file:310380kB inactive_file:818924kB unevictable:28600kB isolated(anon):0kB isolated(file):0kB mapped:484908kB dirty:3700kB writeback:228kB shmem:40788kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:8534016kB kernel_stack:31616kB pagetables:38536kB sec_pagetables:2932kB all_unreclaimable? no Balloon:0kB
> [  104.034126] Node 0 DMA free:13316kB boost:0kB min:84kB low:104kB high:124kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15996kB managed:15364kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [  104.034135] lowmem_reserve[]: 0 2862 11990 11990 11990
> [  104.034147] Node 0 DMA32 free:52184kB boost:0kB min:15860kB low:19824kB high:23788kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:2871780kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:2997084kB managed:2931416kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [  104.034155] lowmem_reserve[]: 0 0 9127 9127 9127
> [  104.034166] Node 0 Normal free:79392kB boost:28672kB min:80308kB low:93216kB high:106124kB reserved_highatomic:2048KB free_highatomic:32KB active_anon:2044kB inactive_anon:6550896kB active_file:310380kB inactive_file:818924kB unevictable:28600kB writepending:4252kB zspages:0kB present:13077504kB managed:9346788kB mlocked:28600kB bounce:0kB free_pcp:2116kB local_pcp:0kB free_cma:0kB
> [  104.034174] lowmem_reserve[]: 0 0 0 0 0
> [  104.034185] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 2*2048kB (UM) 2*4096kB (M) = 13316kB
> [  104.034308] Node 0 DMA32: 3*4kB (U) 5*8kB (UM) 5*16kB (UM) 8*32kB (UM) 11*64kB (UM) 15*128kB (UM) 11*256kB (UM) 9*512kB (UM) 9*1024kB (UM) 0*2048kB 8*4096kB (UM) = 52420kB
> [  104.034348] Node 0 Normal: 1024*4kB (UMEH) 534*8kB (UEH) 409*16kB (UME) 1301*32kB (UME) 154*64kB (UME) 39*128kB (UME) 14*256kB (UM) 1*512kB (U) 2*1024kB (UM) 1*2048kB (U) 0*4096kB = 79584kB
> [  104.034390] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> [  104.034393] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> [  104.034396] 299766 total pagecache pages
> [  104.034398] 0 pages in swap cache
> [  104.034401] Free swap  = 8387580kB
> [  104.034403] Total swap = 8387580kB
> [  104.034405] 4022646 pages RAM
> [  104.034407] 0 pages HighMem/MovableOnly
> [  104.034410] 949254 pages reserved
> [  104.034412] 0 pages hwpoisoned
> 
> 
> The page allocation failures bisect to:
> 
> e47c897a29491ade20b27612fdd3107c39a07357 slab: add sheaves to most caches
> 
> #regzbot introduced: e47c897a29491ade20b27612fdd3107c39a07357
> #regzbot title: kswapd0: page allocation failure

