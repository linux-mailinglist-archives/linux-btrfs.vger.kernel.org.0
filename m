Return-Path: <linux-btrfs+bounces-11290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5CDA288E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B67316347F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBF1519AC;
	Wed,  5 Feb 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="asZzUwMZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TWDkXeHR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2922CBC1;
	Wed,  5 Feb 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753639; cv=fail; b=g6IkMvVg1xVLkd0dqqYtKRfAznO9kEJhNW2TRlRwvCiupPgSOTwMO29kJDZUWNsHzBKyhtHxH0JmvnaXr8I+dIvrxC5ifaN44coiq48Bu8IREV1z4fdAhRgAPy3dwnrZuHqTlq18cJ7jed/TrPZksJ1gT3rdDlUEefia6MaproM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753639; c=relaxed/simple;
	bh=RWRDqLZ0RmcQX0EqTil1YoEMqamO3iFzJ4FyCYDod0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNusBmqto1lwa6fcwYu3TVQta1Z4A+yiYXEeFsbRN2mQFjmsRCShbNM0+j2bGLjtWikbZWgmgY7r5AAxhHJsCNYa9VNCBBFlpwqiOPO0joDcDRH4V2UbOQXUJbDUBwyUmU0FpODFnGZ0mcwUbghegxZaUr2ndJdJo5EL/0jFs/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=asZzUwMZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TWDkXeHR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5158Mo8U019816;
	Wed, 5 Feb 2025 11:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jECdBTZ4ZJzsBuwcgJAICyUsh4NrXMzBeqJlIRbkGwc=; b=
	asZzUwMZ2X1UOWFDYgCktZ0rS0ov439yvWefIRv2IzeVtv5UnzpE6bGr2v/ODS+V
	nQIzaGH4Ir1MwUWvzkLCJ5df3aIozOwsHbjJPPGckmvEwdhqJZ66EvfqdyVby5OW
	mPz/snR9+SUFpO2V8e9fSu4y/vvglkQr3tZjxQZ39NaATFRMiPS3CHG8qzMvKSwC
	XUj2w7HqeyoKIBT9ZV3xqjWHRXuVYN7sPOms/A5J5peiE2oNaZqARE/dcD72YIH6
	Nr4CwmGeTz/YM1ZU5DRfT3U+OC84IKJ60q6ZZG61SL4fQlnRKUwO9lYAdAUDovtl
	h2xwCUbWRA4TEaDJYO8Tkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4t3tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5159jYDp004837;
	Wed, 5 Feb 2025 11:07:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fq9cvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZG7BWS3iHSbedHpj22/3BYrEZdV0sGPbOGPPgSw11AEY0cQ0IeVoL4dyQzz08ixLjFHUgyPcyly3VoXTmqotSw5/vqZ+ZN8xt5uPpFbXsXwKa8N159OQP+OWJiLldJnLxKS/Z22PdH/i42tD7cbK36sgR+5YOaqFGcfP+XrYcxUxFdGquwcmPG/ZlGqV/eqPVO+foYZ2QhSTrMb+kd/rc/lYV6nsUNwtIRpHkS245ohMMkN+LuY8ygRvYr+YsHpZX35CQeCe1Tlo1GBUru6TitPQ0gyMCNrcm4KthPqx2jPaKti+D7WjBZsqhIOV6KbodT/Q/Uzx2jKkGmn+qE3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jECdBTZ4ZJzsBuwcgJAICyUsh4NrXMzBeqJlIRbkGwc=;
 b=lEDKxze/ADZ1vrpAXoLX1Z0atH79vPUndcm3cBQdi/DfJ82gKVNY00uIiYL91Z1FNPIfZ+q0TMGpZ48DE29f/s4/hk7+KUBFHKNa08VuhQyjx6TCovT5SWHZfq/1uzmfZ0csTBT5HUhDtQKhmwjSwJ9DLYr6OeF7ckdemar7Q8tYnpJ26Tk+YdL0ZTd+8Phkepi5YO/HQMkgW6QLoHNDrwtQqqRqsaXSnyjwfOABPUZnpCm3BtS10clB3sh3tKxZVP+Rh+T0JZDGexMCENi4uSuSgGXOPMVN8YAYye45ME2me9nsxBrHpZSAspqcwLvcHLQ8yk/wvi2+14qumcGy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jECdBTZ4ZJzsBuwcgJAICyUsh4NrXMzBeqJlIRbkGwc=;
 b=TWDkXeHRe1o+KLOOGmPoOPQm/CLkXYuzxSP203oHeuXr41aMWVYwRiUDuh8LPScchFA/mrdsi0FdohLS09JxwIo5rSXXPKwZN/km4ZaHhrWeG+AkVKV3JJjuoH35G5q4ii+3365jpLm3ldZQlJqZNlvQfv9MpYx1Z0GteBwajjA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6476.namprd10.prod.outlook.com (2603:10b6:806:2a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 11:07:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:07:13 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 5/5] fstests: btrfs: testcase for sysfs chunk_size attribute validation
Date: Wed,  5 Feb 2025 19:06:40 +0800
Message-ID: <bf009ad46d26727eccd2b6518ffeae982fa0386e.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>
References: <cover.1738752716.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 04560336-c778-497e-0ff8-08dd45d53e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?loV32CvoYUFlWP0XIeMzCZlufh77PCgvk8chrzHUKzgB5FGEEBqyUuBGFhno?=
 =?us-ascii?Q?laiO8rA/5nZGM4Jg2LjvWJNsmmsePGt16ApAND+UexkViRUMdcM9CNh5iknJ?=
 =?us-ascii?Q?rKN9IOXkvq3hVKOd3/KJ4OW2u/AYThIJOUUEMRaQ1wHGH4phBOs41mkWF16P?=
 =?us-ascii?Q?g9L+Rh0YKAQ/p6UTtWys0tnGKROBYwdWy9B4Q7n0RX5nil0F/ztp9QedpKCC?=
 =?us-ascii?Q?srQhwXHQcSmzzDTY2XxoNxZFWN0uGrXy9rQG8MJi7kLvj1RwVSsgWMqxx/jn?=
 =?us-ascii?Q?5dId423Uzw6vaTm3KU4/4MyGjnFQF+pPv/6cv1AzS+PIROo93FMDPi3bH515?=
 =?us-ascii?Q?wefaCV7MJpSWZGSnzZ2SwkLLY1qkPvYryyH3BlWzf1Gwl8KRmr0ikrkcToj8?=
 =?us-ascii?Q?DHwqyHIhuQAP71zZZqH5KYU2MgOXcuAgXIKeF013pWx/D3MGhX8zBHMw0qFy?=
 =?us-ascii?Q?LhmyvCk99qr4DsCpnU/0exsiA+jqBxMovLaOrL/+Uy4BO9othRu7sFvVuGjz?=
 =?us-ascii?Q?2PQOTe1AwUJhnppSPwV6o7XoyuaCnp7ErJZfH68kAqzBz6CsraFGugVdb+sf?=
 =?us-ascii?Q?zGzkxgHvLbolqpJn65d5v4X6gRybXXQM6/Z9HohX0198xyMbNBSemb2bvj5w?=
 =?us-ascii?Q?Pvz6ezi7B2kbEkntc48SoENG48/VFilZST6bSQSOoESR3dOdXGkL4yh/IAqC?=
 =?us-ascii?Q?nbQuYU+k6n1/TFKSTA3XOl+TFROV5i2bMKIHx6vrVDjOM2TVpuWRKeArQcfG?=
 =?us-ascii?Q?TNl+m2vIY6ycyZLISVOtSxf9x0kuvoLnTJuis/tvKpHLALfPnBga3Y6C0qhl?=
 =?us-ascii?Q?D9TTd29SpbHS3dG+azFb3e6E+ywVYmo0r4dH/mBvX2lxl6COoQdzwnUIhCc5?=
 =?us-ascii?Q?qc9kW5BI6pmZgBG0YyIrMRXfCjUfnv73eC9Vq7N2UaQNvySGKTDTjYrwaORL?=
 =?us-ascii?Q?XSGgZvt4Waau5TGt3/ZDNUjSKcvk+T+6M8IZxE9Gu6GIh03OcIyksOvDD092?=
 =?us-ascii?Q?RkvAJ8GgS8iy+ICUuHobxKlGANPGbSSE6/IVk9fZMZkJosObNxN1lPwEflwH?=
 =?us-ascii?Q?529+gTwRv+OPArTwnZUTsD91saN/3ooFWiHO1jE36H5MpAM7+2Wv7AAYyUA2?=
 =?us-ascii?Q?19J8A57bxxUKZ0aygoE+8+xvdatmzwCxmzQoCrgewjR1UezpUR3+tiQMgicJ?=
 =?us-ascii?Q?k18OTywWH2rh3JzrpC5EQN/1WUDUWtUo2lI71R01HvRvq4/HNQASGqbYFW7S?=
 =?us-ascii?Q?9pBww45V2Qai+NjN8QUgdvfUFqU4vIWcyjbebHDOgIUxsNOC/9zWrnZrABZ7?=
 =?us-ascii?Q?r2nML2Z28MJgSg8KeFomz1deCi0v0YjDmg9VWNh3ixhF6pj7IS3cHtnSmiEz?=
 =?us-ascii?Q?f983ETxI7PDghXlaMIagKhy/tq4L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WrAcJlwUcQ+OGOem+Wje8gIIb+v7V9X7uEoKEY6z2T1+yP9NLre3Wa3zAp+W?=
 =?us-ascii?Q?BAVcHbx+sVrgAkzMa7Qx/oPrHoHDnt4E8plrtTZn/VtboAwg90KhrFu4j7Wp?=
 =?us-ascii?Q?c8210aCOvgA5YqL3Aw0DcUs0YfC3HUcj7PhjqjbePxqedEk1kmX3wonbdFxE?=
 =?us-ascii?Q?/kmf/L4DpNFsqfProG/nW22mJaSw4r4PAR5WRYLnz9ziE+LooZkiLGpjz/08?=
 =?us-ascii?Q?Y4KnJe0pyBea2+iR7a2vqFwmO3FE+aAhD5LromUgtMPyQ0Zl57Ky65vhR/pQ?=
 =?us-ascii?Q?lY0GbLxQDXFXcuJDZ9yUFa31fdtoRwFGZTiqU66SOk4h854PulJHzjGIeV7h?=
 =?us-ascii?Q?DmrWw96wZxUPdtci7/0F8sAKpyVofz2evmhPT8C86mf93sJjK1HM0+chLnxu?=
 =?us-ascii?Q?qMOudEipt8QpLCGO8r0NvkftV11mNYEPMldscK7RPdXd+RZtNJsyLEhMdsL7?=
 =?us-ascii?Q?AqM4S5OOv5FwBV5gFFEnjV58d0dQOJG2qRWwqhcWtJVq6Y1ZwXr00Q9t5WvG?=
 =?us-ascii?Q?+4dVtrc/RcIes1mjBc17FVl/keFhTm329vkbL1PbyX3m2/CoWoY+xDibcUPI?=
 =?us-ascii?Q?17SwWK78U2UMcZpJGh6hmOzx8F0DTJxd0+9QzvYndZO5EsNKuo9GPZHJKpE0?=
 =?us-ascii?Q?t8c7Yd4nCK5b5lUyVQQSrcGgOPtEb6idsmecvyH+oVGtY4J7lbsQs2DZcZMv?=
 =?us-ascii?Q?6BwX2NVJYO5I4qF3UPeakiEy3IYGnYMvb6AA9h+Db98jmWesw2lC3lheg3X0?=
 =?us-ascii?Q?0/95x+ft89kZ1Gmaqj+TBP9rtOZ2lKdsUzMnDQxRbgAFOht807J+H+ktn4I0?=
 =?us-ascii?Q?pFq0mtg6gd3RDZK4AQMT/Lz6pJA6u+eVXArpdko2QFjZi7GLSPjvkjT2rkBX?=
 =?us-ascii?Q?ci2ClolRILD30ZwPa4Df9denzQU/EbB0pXRn7N91WvKXx9JfMpICKZitDczO?=
 =?us-ascii?Q?uM71MPu5Kxc3G/g1HfSsD7bJr873Ag6nW18ZrJteoMElG2U0rozsqRr/llcc?=
 =?us-ascii?Q?H9iS25HPsVTKcvsb/w3Osdnrg52sVLqtrBOpUJij0l4SECz5KOkzvTh1FyhQ?=
 =?us-ascii?Q?PmSX+3XZVferP9uVV+T0bYUjrY/LIJr96cBqxjt/Eh9R9bRnOPrueI9/iRsP?=
 =?us-ascii?Q?ix7p9RJ1EhBectvL/w4/z1XhCDJrshriyE/cRah7kL+FZCUopwI21U07+zuL?=
 =?us-ascii?Q?RA9PmX/9LCNQpxKteZ/+ZH2sbqvWcLcpnyg9ulQhjIfEOmXazHrebbwM2L5p?=
 =?us-ascii?Q?DGNZONPHziDRJ/4JN4MsRm1HhUKIM97Zn9Aj6lQfYerfQotYWa55duj6q26y?=
 =?us-ascii?Q?ZTwESpImKDOCq/y7kkeQAhz/qSx9xWG+i2eL4cq2MvEHKFe26kp+0bZ7gTh8?=
 =?us-ascii?Q?wlcsCUKtHGPkK1v/6uDFmShJ50kAySd3mMwdLNYi38IHt9k3N22KPuZbeN1D?=
 =?us-ascii?Q?zzTfAxUBYbF7GWeMzr0cp7Prwmr767sXcSwIKHqVw0GAe6Yq1S12ZquKnS3j?=
 =?us-ascii?Q?wCt6fLlmzRBvLlVj/8R6nFt7NVj0lLBKXEmWiFlvkJ3bNaoFlcb3NJy8tnac?=
 =?us-ascii?Q?Od3gyBQSdsTHdTsi90YFXpNfcuZ4J8mLyOZT+MiO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9H9KGv0g/9iJP1z3MzEsNluF1JaOIOamfXzR/h35OTvQMqocHO+3v6k1BaklvVaXojiuE8PRMock0o9f2g5rb+/t9giC22eRIwoBpdlpRMWp5ZUZlaA5rIIl3jSmdiqg1MyvqW4MdxHNtLAihpdsnZYb966M8vNOSMrp78KwUasoh9ChjPCQyVtoTAW8kucwiAYX/vqDc9wwY9g7jDAPVwJWgq14yCjsm6CbCJYOSvRePb7gTuG5e674ERExvyrwHRQJ70TAT7qOT7mRMK+D9Yv9QlJqpb9+AgWmLycOPoFrSpC+8umlZRM+5JvywTeatI9106i3H/uJXrQpwFfhAdhuAC+U8nwD+4g9YjGa3hT7cRq+/OwVpvrRtB8ABktSStfPrhyMyiUpPcWa2fE7BMIOHn5ikd5C+YM8EhZjNrSK+K/xW7C34a+ny8B7kRE0l62zgfNvRktbWYSRomV0KNEdJmT9h4cy5meXYt19tdea0S2kO/5MSZg5E4rnDwLHNs2l6FuTKgTmAimLQFPNSdvBKtO4ze5oiG/madRRevgXfaimhDrqtUCgVR2eCiK9qeAzffs6OBnJ2p1UcX95HO16Ahb2GbZbdK+3954Iefg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04560336-c778-497e-0ff8-08dd45d53e55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:07:13.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLUWvKn5AzZLooyAHb7S3NSU6zQQkcs6G3rRaSHy0zE57tzwIRDgQSArErVf+bJzU0yw76Yr3mMwle+Msarzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6476
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: cj7QcX1w5aLQVtk7DZnd7m7qx4Hb2AZs
X-Proofpoint-ORIG-GUID: cj7QcX1w5aLQVtk7DZnd7m7qx4Hb2AZs

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax allocation/data/chunk_size.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/334     | 18 ++++++++++++++++++
 tests/btrfs/334.out | 14 ++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

diff --git a/tests/btrfs/334 b/tests/btrfs/334
new file mode 100755
index 000000000000..b662fe2aca63
--- /dev/null
+++ b/tests/btrfs/334
@@ -0,0 +1,18 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 334
+#
+# Verify sysfs knob input syntax for allocation/data/chunk_size
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
+verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
+
+status=0
+exit
diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
new file mode 100644
index 000000000000..f64f9ac09499
--- /dev/null
+++ b/tests/btrfs/334.out
@@ -0,0 +1,14 @@
+QA output created by 334
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.47.0


