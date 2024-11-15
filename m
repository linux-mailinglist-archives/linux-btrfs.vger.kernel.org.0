Return-Path: <linux-btrfs+bounces-9693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F029CE931
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F318B2C4DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030E1D433C;
	Fri, 15 Nov 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5wGTvEd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F9dx6jbU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752881CEACD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682503; cv=fail; b=M3NPfvDL4+y73PQwMiA9vu2qk78Ek68V6IR1xkoF9gsEgUUYNQLebcRfQKctcB2Ptz5J2/DnkDgY4Ks/dOcaVfJduJawk4krDntB5vVNk/dNnfTecZc/QjQKkoPaFdqKtPfStlo+Y6Ae2uaHT5R7HpTv0RNqLJStjm0RiL/7qto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682503; c=relaxed/simple;
	bh=s9VohoOtQQ6feG/Kuy2Lrlg9a5F12+nFzMpdpKvd8eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bqfDeNY5Y/mZKp7eomhVqis64l4whvhIxa7fJOPItzXw13QYZI0LtUMS02QNL+xAtEqxFkXf7qsi2/A+9w0S3vJJAZmKA2CTYufzB/rmu0/JjN4tNhYmd2oYcnGR4YsqAzoGYfCIYYgdgaazIOf4IHK0hKQl+jOMoQT3K9+C4fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g5wGTvEd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F9dx6jbU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCTEq005665;
	Fri, 15 Nov 2024 14:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z/aNA4znFofwpOT/8JxRRYXNNDek0WXFYL//ac/abG0=; b=
	g5wGTvEd45TIdBpxjHuevAAQiVKfqZoJvnpLeuhKFMLtybfPOKUc3v26i62cnKY7
	qTtR3Dw+mLdfw4YxLZnKvUtdO3yw6VzKZar/kGQf9K2x+DQ8TqjN5RFK0Pw3EIr1
	UJ7MBD7bo1i8AKOw/4pSEqqg2cqzAFr+GLfjM1iQ/e0kHfkoZflxCOJi1+rUOj8y
	hH8ZlY62KUe3AMJmqZGWL6VxTiOjh+6RVS1LAbstjJ8k7k/3Kzi9KqccawatHL5F
	9YXV5DwZEgMyCHgBzorR9Fp63/FH5irOocWievJTW+uMyMdHNTZa4Yx+XRR9tFcG
	eivuUzyiqPQAfosBaJJTZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkmnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEbrxK001160;
	Fri, 15 Nov 2024 14:54:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cnm17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joXJndvgZGkLWsEUjgrDtZX0wheTBiwu3YTg2oOh9NU+t6W3cIg1L3hfsvop+1SCN+aKNuXbNOmz5h7AIdEU66y74+vhSEJHsWni5Ra6X+4O32lRLQxNg3ZwTfcoX1gE7D5H1+gP7euDT6pWoohrNFD331Tug1NenA9uI03pN3u4T8M7Y4fdC5p1hbPRlTEidaOkE6Vre6ZQZ0hOwUYT/qCatxpZFWidLYwzwSUGFViu83vMmSMKnFo4KVicbuOeq5nQ0mAcSDfyFmJFpDnHbkEcxi58CVfXxd5UOVYxSSTIsyTzfhir1amexjK2o2NtRBQROTLPsPUFrf4ytlmKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/aNA4znFofwpOT/8JxRRYXNNDek0WXFYL//ac/abG0=;
 b=MjaDGxkb03f+ljYUaaDR1/8lYIiPbR2WRzJ1qKkXeYc3DH3r0PzuWaRhTyXm3NnfVl7UWz98vIpY8phj9tpCzHv+bH5gb1zVKs5tiXHZNqBV8HpnCstP7/PU+WR/+VmVrYtDlQBmeqWZtqIqIAbvxDL6ZynZvtarlgp+kQz6UVtbn+PXBlBTEF7hs054joUa/HbQNtWaC9oz15XJVLx4QiDhA3K9xRIsC0OSIJOTqB9PZwhX8AFk1/N46/sB8Jw8JMR8Orsv6JZvFN//oUpdtamP+kArnCQFw4h0JTNy4MNtuuRqcMOh9XGLPmxtHkJR8Gj7XEhUE/SeZDdA89K/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/aNA4znFofwpOT/8JxRRYXNNDek0WXFYL//ac/abG0=;
 b=F9dx6jbUVTfyNt8Wf1xj3KngRvDHqFHXtoCtSObDJilx9xGrZk1pwR2Vk6C5ZcBmToAnnfo4x9+MzH42FKzJTei/w/RN5N4vfH+zCWYZqSTxPAXZgCsc2xIORKCuD34T7bzTNbh2No7iAAXeUUjRdrfBWVajFebD9qUY+Q25o74=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:54:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 02/10] btrfs: simplify output formatting in btrfs_read_policy_show
Date: Fri, 15 Nov 2024 22:54:02 +0800
Message-ID: <52368693c79f21276e1f633f446a82f10ab548d1.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f07246d-3ac5-467d-a5bb-08dd058571a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LcIdSoShZIHavypPYU+vIK4z8ZO20ZyPyk0rCLj2/jGx21kDCgtyotjIdz5x?=
 =?us-ascii?Q?2Y41W7tm58Iq6qOem58yaQQeCLwVNaDmFF6WuU+/DUERGz8vThrNeU8YSfzz?=
 =?us-ascii?Q?+E4vg3/Hfy7wLLjblGnbylXpL6cHLtH8dTKTfKxCPc+C+P7Vfs8JlC9+zDOl?=
 =?us-ascii?Q?afAsEwK/qY3cgQRlTTmDKgH6gmLIX1wqgGEsXYtw/G59z9Vo64DC+HreIHZt?=
 =?us-ascii?Q?NPk8zPa3ylKjtdRLakI6qDyYavLWtZnZJLwOU1mrHnEF8h+tmwhSCtMKk6Ry?=
 =?us-ascii?Q?FYicNxea274WfU6WE0pjf8y084bcdGuoXs6K8XlejshfSMQU172q+6J0XDyk?=
 =?us-ascii?Q?RVBmn+nWZ+ewNxsEGHFgIDEsyDvXYGu8ao3vTpiE4DlIptm83qoASR2t3coZ?=
 =?us-ascii?Q?NG5iB7LI3tuYheKoUkX+8q1937zkvAQ6VxpCB0ZDj95QtjEFlj5B90usEDqG?=
 =?us-ascii?Q?Hbit/6AdlzYTbkETSA2rPVuswr78wq3tShELV9AOoiD/FHF8RjrWWkYneiFC?=
 =?us-ascii?Q?P90PaRWwLj7bsM9mETnth9axL1nEDcbYXe7wQLmZ9rSKaMIwu6KXtkLG6Wb6?=
 =?us-ascii?Q?3+usu2VZwzqEvPj1sip/3Gs3WRGHt2YS0HBWwLd9fbpiQIatN0agozifOjR2?=
 =?us-ascii?Q?e9OfX4pZOUQkrvnrIsfXdeY/TtrbZJ66m49+0hhfwTtBYzNjs79Gto2xi46t?=
 =?us-ascii?Q?RrExir199JGIaYCxUPO2KqY96kHKIVgpjEqbq/sZq/4sGV84+HmBu+/WqC9J?=
 =?us-ascii?Q?4lhTDZj/F5jpVc921CarZfx1fQjIMR6D2htur1B0u9tVAlJProJUHmX8qWwV?=
 =?us-ascii?Q?5N8QVQ/dLezrlzwhaZCNlz9w3Ak010wL4FsrHLct2BUnl96xP89NIBvzc361?=
 =?us-ascii?Q?HbNg29jZdNqFWI84ZP5JQuUqNn/AsBAH6UWnNzo1/BmjsPmDdb90qdVkbU6e?=
 =?us-ascii?Q?T2ceVOY4MeTIpzsWlsA21vwSkg8dPuKulR+iIOdg6CVc11BPHSff2+lXrzZJ?=
 =?us-ascii?Q?GTCtR96Zu0paYZetuB4pdVg6HaS6DSfgaidyE3hVIt1ASkBJ3Emq/IX+dV9+?=
 =?us-ascii?Q?qBgbLBlYCzY6H1jrV0S/8+K4J24UlkwMaQP8JuAJTelf0znWybV0RhYIn7ZZ?=
 =?us-ascii?Q?vJtalEwkePZkxlQHKlPuHzqfT2pFaeMRYdSfmbaauylBQROvEK617WpEtrLZ?=
 =?us-ascii?Q?qagptzAruyXmzB7Zn/fa9bk6U5og0n/wFge8DWdAJHvc3bxK1rvwCaJYnibw?=
 =?us-ascii?Q?4sh6LkVhcqiAOdjbnU/TbMMnI+/y2Uwmpd7VE/oz2Qxl+f07j+lKB2MCej2s?=
 =?us-ascii?Q?B6lStRfkBm87FjcvtL72Clf+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WxkflNF00/irjHOhgRfL8P55t5OSE9QP1na2RKEx9IrU1AwGeLpnWaeTJDg2?=
 =?us-ascii?Q?VYzCXvkYws2Chu0rnbeuRdC+UYgMBedhRuPK2ZE0pxjLNRdFYL8pCjIBYFr1?=
 =?us-ascii?Q?NY7V8hus8OqaDvtKHwk+gdBpNGG/GPUXSt43NKBgjA3XEmtvB5kFnmi5HIjX?=
 =?us-ascii?Q?ZnU7lE53DyjF+raLOeohs8KgzHlBRgrT/AO+No9oefE6iPMQPb1Q1+eW+6aZ?=
 =?us-ascii?Q?MSrHz6CgV/sQJuiMGOVOx/+LS+hbSKs5GnjO87XR/CCoqRf8gvONNgBPrtTK?=
 =?us-ascii?Q?JRz94UFpSC2idUTrb7yQFln4Wy3IG2T8CEZ0Aq6NiBsU1CXQo4m5RV204Sxf?=
 =?us-ascii?Q?O/K0ZWVHBCxPbejXSwJqKwLZRv6eglKaL4zctqQLgY57/QWfKjrpskwENg3u?=
 =?us-ascii?Q?9B573bdJby48tvJ10yhNo8aJUZbReubiOmrT8WilvJm48GU8rtu+pL7mubRK?=
 =?us-ascii?Q?xuC3fYyFOUUzZOcg4a5w4xogyISqKp2nM3tIT5qltAh0WGi7kMbI9fjNwcLw?=
 =?us-ascii?Q?dvgqfV13z1yLMJ5/6TKUyoRmY/vceMMGHvnRRr98wlaAqRH3o502SB1P1w5+?=
 =?us-ascii?Q?6wFX63odTvSdPhRhdBg1mSsacopLUD0jGFPcwNrLALetw0QcR5do2xQd2yzH?=
 =?us-ascii?Q?27cy74kqzwQ0sd4IkLmy8VFBth/OTaVl/OtcQo7jcsWKFZYKe1nLefN5vGlG?=
 =?us-ascii?Q?g8O7OfzY9crS6yvyY33uAL18i4Dd85qW4z9lYs/0T2xj3QAqKCTizTFzwUvD?=
 =?us-ascii?Q?v1Xb4rk7iAx5EKiUwkolYpjYbWAvK+Z+UhjPOEdR3dXD3l+bfnpGIYWw0KM4?=
 =?us-ascii?Q?4q8zbopuWm7ckEZWld3nX2+W4mSg6ZISbyQKX9c/lGL1YoTmfxEMDUzRDUjh?=
 =?us-ascii?Q?kdo0G00gKjB2WofiTc02xuxqzVXIebg1ug8DtsR2oNGFPlFA+7qjqvg3C77B?=
 =?us-ascii?Q?hnJodxBVM7M7OdIp9ZZq3KsNempS9E3CsIQUawpyIyQmCJjOG/Onew4/ERp6?=
 =?us-ascii?Q?ZRRnLIllv/b3tmnyjo+4LkC5JkHAhtykOjklsBcZ/XxRYjpG32t7WPwIBxHq?=
 =?us-ascii?Q?BhclJeURBuisORxz+AMXiUyhqDadb/hFCfkIn6/iC9a/T5yU9e3ZgLoaqTWO?=
 =?us-ascii?Q?aP5DA7wvMRJEeX45dKai6wEEg5V15ra9sdD28wcdezE8qcQW5f6dXV7B4Hh3?=
 =?us-ascii?Q?kdVtRmgTsdPNY+YC6negriNh2+Hc5DT+zq8LpnT3XUhz3NHBivtXD+zLihKj?=
 =?us-ascii?Q?YWcl+s/cy7hP9g1dVoXw9o6qQP4AG4txT/gxEnaE299bICkzjIglayQsiQyV?=
 =?us-ascii?Q?BDbt0NILI/05SE4OxfR0TjkbSROklDOdcQHD0hLnVcoJN3PUkrRhgEvefP82?=
 =?us-ascii?Q?VT5ZHHl2NAe55oM8QZKS1bnSNHlD7LDv0li9CT/Uzykw2VzP5YD4qO6is2dh?=
 =?us-ascii?Q?3vGXs7n++X5fAEPQbJb6yb/CiwJHnRL0XsELwHA3/YQ9wXCtcmOxvtuZzAYX?=
 =?us-ascii?Q?Ub9mS8hkx3eZlII76Y+P6fxi1smAL9rYV2sk0fQxSfXZyFTJEpV6TfnK2eTF?=
 =?us-ascii?Q?EppU1rLY3jm0Tn1fPZVOmQkyXKCKeupRLZUZoDbs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ockfgJiHcAWJtaySX6DPKTRHmlQSNV0mYR6KphQB6cPdepNA/nZgR/VV2Hl2l6YHw08FaqMZxSpVtebt9+q8mplEWv7KwBeWNPG5+rX2s6B4boBLss95vb/1RosmpoCs2IvM1qTROyKPIWXa/kYwYbjCwRD0ad/y6ok5e2TsrEmw/V44fhvoCKh/zBdOMsRlZMChbLCIgAbr7v8mDqxrSPL6OV0M8Aio61sshJigk8ZJQ0sSThAJR7aZC5ekN2h4Kwg/2dYPJ1y8lELls/edHxXi2zrPnKjR4lIouPIiQT1L1JpCw7a1tTXuuzJ1Tj9KaFwC9l40O5dBGNZDXGEUiVw1yzkialdpb9kpIyH9q/VASEMfWhyVSCnDjqC8HC+K289rJuD/x9upVzLsfm/meP/Q69CkZI+KHLnT9Tfpfas1Cns36uHzFVJ6jE8RvoV0t3T23kV67SfZGdbYWbStR1bDieU5gvYk8jAwy9kRHD7dtPVrJtndVhpIUV66wN+lpYpYxg5FxmUwu+OGqTLXvTPrYG4cY1RomLFeR116deA+/nbdRi0oDGlCreZQC7z1bQ4TlBmOZqxocPVvDMAmLWdTnzJ1uGL7AFg9pwFInc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f07246d-3ac5-467d-a5bb-08dd058571a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:46.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkcuAxpqdROVnLP7pZd6t7YNjCUSFzm6OsNELaTkmuMUdVYJ5zsjBpt19XayWXh42O6EBO2n6Iui1ZiTR22htA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-GUID: c1pZNVoM-bTvIaz3IOhktuqMpewUQiYB
X-Proofpoint-ORIG-GUID: c1pZNVoM-bTvIaz3IOhktuqMpewUQiYB

Refactor the logic in btrfs_read_policy_show() to streamline the
formatting of read policies output. Streamline the space and bracket
handling around the active policy without altering the functional output.
This is in preparation to add more methods.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b843308e2bc6..fd3c49c6c3c5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1316,14 +1316,16 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (policy == i)
-			ret += sysfs_emit_at(buf, ret, "%s[%s]",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
-		else
-			ret += sysfs_emit_at(buf, ret, "%s%s",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
+		if (ret != 0)
+			ret += sysfs_emit_at(buf, ret, " ");
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "[");
+
+		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "]");
 	}
 
 	ret += sysfs_emit_at(buf, ret, "\n");
-- 
2.46.1


