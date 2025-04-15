Return-Path: <linux-btrfs+bounces-13028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C47A89654
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287D83AA54C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC227A10F;
	Tue, 15 Apr 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="f7R5GxdV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AA241CA2;
	Tue, 15 Apr 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705119; cv=fail; b=PuO8WQce3yo8Co00RAMNhdGTrAA1Z1240uLawVlaUTme9Rw/Z25Y8QfM+DFXsVzljIHbXtdOlkvTN4LzawYqOhno3vVu6XG4q8DATEZRiGxjsnozZ3eSQUDi1QpkWvXh9E3++cYkQIhm1fwf5tAsOGqtRmWV6I2dwK91VFQYn8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705119; c=relaxed/simple;
	bh=tdNFGp4MdNQE3cZ8WxZYAqytSSp8HUHt+dYQwN2G3Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZK/r2tUZrITibBp2tWxRlLzqWffE1lx8gxVa+cFBeHqk0uz2uNhS3yyFM05/qVdNDz4+HdrltWaoTcPoYEBwQOnipiRSQjNlLcngBU7M7vCfPryucj3eY3Xq98R2vYxlc7pUS1XqH0hOz688yXK+UGIxKhqwsDSw+abY4Yq+INo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=f7R5GxdV; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elFzw08q1pTHy0+s3OWVXW4470ZZirdn44Ij98hjxj5VglymZ9mPzSuY6c100IVpXQiTtTX0lAE0nCcwZWEqMOBmB98wKLIuoAT1PnXdoc3PvCDx5MDhIFCEItjQV7eipn0jGUs7Le92TrrJQgfC8W9MthN2070pm5TViQ3L+sMnzrhctkpAW//tspm/p9hTm/Qt4+Hai70MXmEDyo4qAProGuZthGzB2SD19E12XbOIUd9WulqBCZsF55afRDg0wt1BTPhkTkCJ3dESc7kIIs3giaoWY/eBgi+Jst034CLrMlLalro/U+GwCyW1UVl8Y/V5ADsd+mCOJIsDkg43zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnXvMxZy3YQsBt8iiFhZFi2C9qo8Y5vR8mTQ29fei/s=;
 b=GocpCWEdOanRQfTkCXkPaRTPeOeXQWfEzDrNCNXAn0gpUQd/w9xbfyol0kP6CQ2UhAiMcEpOKoVOKVqAfx+xr31GOMMcQ1JB0YfbfAz/rZ/+SZasEzi6lp6kgHB9fsIjR50nA34SYPLCRxF0KGr17IzBWjQYUpGL3IE1MIcGjXj6ewcFKqhEeeO2QvccB+VYHW+HWT5qt04sXv5KFsXE7fIV74hFD+FdQ+I7fPwkupc7VGFpJQnDtyzdcRU8AXsRdtztpetyKFjYBNdKxGR4T77ctKb+b5RozDbRMVYSHu8Jzjo3JDoGHoLcximwAQslwhqDasoRPuli7tvmy4B1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnXvMxZy3YQsBt8iiFhZFi2C9qo8Y5vR8mTQ29fei/s=;
 b=f7R5GxdV0DPCdjClIGMrJ0sci3oEmNAf/A/txT0Y6dgwd9cKW+nQADyFbSVS9Egu0kfTzj62ZCYqov4cj13XekzQow7uEtpvA22miVZlurEKJPUvkc9yOl0gLE/q27Aq+lClTQr34z0YQ6r/TyQ+NE+oG7domoKaUCBeMvJftQiQNvinXBB+Mpd/7QGPR5sPLupwd5Ddh6Lb/+IZGO+A9bURRqBYYlp3Ytno9qglzOkXkqU3TWB8eLQKTE2uPH0pqh0OEQABn6rmWj8wEQS+X6+p4UYJ26tsG5QHSbLUcR9HDj9N0UsGalW1oVZIqq/cqzNhix5JKlkh5j6S0nO9rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6841.apcprd06.prod.outlook.com (2603:1096:101:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 08:18:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:18:29 +0000
From: Yangtao Li <frank.li@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Date: Tue, 15 Apr 2025 02:38:07 -0600
Message-Id: <20250415083808.893050-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfd2a5d-46dd-44cb-d34b-08dd7bf61a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pw7BYwTl6WYSjlVg0fVGl4UFm0zwrhT3pM27KIguJsM/nKdVU5xtuRwn93BD?=
 =?us-ascii?Q?riG6+nRgvBzYDWwFX8umk173KHHS+0A9PdPOoW/ipnJGtKd1hbNOxqXoy8UV?=
 =?us-ascii?Q?8hs8wCHXkNikVCTsF/mo75dkAU5f2NpafLVgwfRWrakHmvhTRN2gyOSaaM8V?=
 =?us-ascii?Q?6LzH3Cjai3HGnLOuK1JosgKfy4kr5CL9oSLWOTDbifiKxFR7c5vXg7zEtaIf?=
 =?us-ascii?Q?dLCavKs5n+M9b6azGXcmogjSrW4zXcHwBDyddxJFk7TE3fp7Q/Q/yxO+L84z?=
 =?us-ascii?Q?k59Ux5rCj3yP7bobGnDe8LmG5BnP4HpzEXniiQNIDlK52LjDJhXbrI9rZtfR?=
 =?us-ascii?Q?ltQoTfrJIqV9mHRqzMnsJik/Gg9eqtqQ8yEsbcjl+h3W0MXKE0bHhfueWZ/n?=
 =?us-ascii?Q?2rkAndfEykzp5Gcz5eAwqLnLbC7+3yJkxQSbkhEqvLjZkGkhOUNi055l3XHx?=
 =?us-ascii?Q?K+zoDi5xaAPdZjxEpOdG7TXEtpV4k184o7cfRd2/N7QdYU8TlsFtJqF7oJUK?=
 =?us-ascii?Q?d1rzoE00RXYilxPNOBsdz6O2TpSh2CcrZ78GVcCflnP+r8vyEXGlVQAGam/4?=
 =?us-ascii?Q?oDkv05NlUemfOXmsrmG9GqL044uUibShmn6ckn+lOqc2FCD0nhhTBP+lJKOf?=
 =?us-ascii?Q?d0Q6dN8BtbQfjzckARA/xUhiYLR5KEThFruotEzfgbq1zfuTZXNEUxKJb/Wa?=
 =?us-ascii?Q?v8/6os+N7FGQ2WD+ecoHHXDuISMm1Pl7DnK8qk0yftXQhoiECI4c1KmEyOHT?=
 =?us-ascii?Q?cMhK0OrZsfRr9fryo1j4duPfKG+pYCsAfyHyrYGWc0foByDVeyKGMbsJfWQC?=
 =?us-ascii?Q?aqkQQ59JigL2nOPvi8DUK/AKGxll+4jpcT1VQSXKqkyZQfcLkGQss2u7iBMv?=
 =?us-ascii?Q?MIHYqqMm3CGR3/ohVnSDCCjPOYyKwc3mrTunCcDzuRCKV4oZ0AMacoL+yQhi?=
 =?us-ascii?Q?NpG4G4wUCUoE26Q4YyUaj2sCHK5GAbZSTsELkAu3fW+eFXhoH8V9gGnw4HNG?=
 =?us-ascii?Q?gP9JLfbXNTgIjp7wKdgNqCtywzmpHeKHLqR8IHk0ZQboPA8FuAbftzX/kRuZ?=
 =?us-ascii?Q?skvOMrqqojPrCkyN6rmjDiyGsNXQB6F8ekq3CWphpfebcCZdpUgMDTuzNY58?=
 =?us-ascii?Q?OP3iJhERZIyDQ2R9ulxFNiNhY5UVp+BtIMbdSilvUoPJcSlmV74KyFF4JwpS?=
 =?us-ascii?Q?NgpNNCqX7OIgFJ4/u0YOPsIlTFRk2VBRxfNdo0vfkkDAvVZqn5wE4BuJ5i5/?=
 =?us-ascii?Q?82eSjQqH0vJx5eB+qtSTPwIhgyK4jJko2Qj5QdNOAFyGJr1zhn9dQ/DcKp2X?=
 =?us-ascii?Q?q9nDKvs+xHhfcQ1YbbDh8/OTE7SrmLRMomWJi7grAOSj9Rv60tavjea1DHPc?=
 =?us-ascii?Q?VI5mxCizAL0Q8CJgXWykzEr+R0EQfNgHHPhvyKR0hKFC1mMdLh+1707ifHsp?=
 =?us-ascii?Q?WU6UJw7MXS+Fw9P+ncsZDvodmRyClwqptCAd/atS5+UT3nuUkLXLdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hS/etpII1+ZeJUM0euPbd134O4Jfdoe3s4TFuUD+kLzW6xDQkphUJ/TqD4J4?=
 =?us-ascii?Q?k52QiJna3hnFsYpxnO2hMApVBW56Z4Woo+EQ3LO5HWYWhn5cpH5h3rSfKcAA?=
 =?us-ascii?Q?wY0aFPx/9gyToyUoBQG6Vx/1lYzW5kqOPqZGT0prBn2metm/mm90yDoPkR+a?=
 =?us-ascii?Q?LLuFANqR2KETXGJQEVxFxFVP2komxfw70+GFwGDN6WTcymNOhzv9y0fs3KYT?=
 =?us-ascii?Q?QheKlPSPOJksN1xHQjRN/s6cnEpw7+XF5VnSBtIS7+Ll5FXKvtdPqCy8LLsj?=
 =?us-ascii?Q?Bl+0o6VH5A33dWvHu0mGLqEL8UEEs1/Xy31KKSslMijI1IEViYeYc/V5gWnX?=
 =?us-ascii?Q?eLT2MgsNjNGiXebQ5eF3cWeYNRUKNzR90Fv0KewG1IF/D8j5dJVVqdU9+Sqw?=
 =?us-ascii?Q?cGbXh+4xrHoJz93RDHZMXip3kg6Tp+Khqgh5rf6QVZY7/0xbV0Gks3yYNhC0?=
 =?us-ascii?Q?+kR/VrWdDOMxQW0MgNeuoUtrJTiR8LvC2L/SXt159i+PcpX8xAyPn+WiDSJ7?=
 =?us-ascii?Q?C9zFMrqOWg9eEY511w7ZvQE3FNyNoYO5GmIMdk8VZ/0U6g0g7qPq8rkTa+9u?=
 =?us-ascii?Q?O6NvcoILsnfeUFPwhG8bnVi+vTLzJdg4Hyh1lEVdDTO8STdZPvdcyNQ0Hk++?=
 =?us-ascii?Q?RgnsVYzVCLHV0p2iUvk8mtD4/9pJcc9syVAnHpvIFk/G2IZo4U5x6CYbxiFu?=
 =?us-ascii?Q?H/kW70vfTuVxqbctDZrVBJvlMVsa8QsqT7NAlJ7lZ+uNGykM+zuHHfADvqyO?=
 =?us-ascii?Q?eTKvJLz8HZtLow+xEjrIlTuSrfbbIhbLZNDEoygU7v4v2v09ISxXO6czIn0g?=
 =?us-ascii?Q?D/msMOlwijYb+sgtYV6o+66MlrWIN4jZalWyKD9lnrVAuALNb5UxrPCT+0Bi?=
 =?us-ascii?Q?LxbvTVc+8ulou0jEsbJZE8rcpNLLa0nNVsA4xB/gnHyOMAgFhjRj/ebaOU2n?=
 =?us-ascii?Q?WJ1rb6Ym2c783rwlDKw3Xs+BzegaIKlNTu07X6VMFCIBLdZm+dx8iWUpbysH?=
 =?us-ascii?Q?RmMT5UcnB10WGeWRxqgle2YKMbKM/PRIVnwhqvRjKbcXUKBklhe2aHzJV3Ds?=
 =?us-ascii?Q?wPxAVDNpnbaC2aFWMdwDCnBv/5oTCoASRiTzHq7s2RALNkMp/CwBNNW/+xKM?=
 =?us-ascii?Q?IOqL/Zv12HLEzaEnUitCfraqCMxjUiN7htdbIupZUUZeRL/4lIGJPYiy0JoI?=
 =?us-ascii?Q?A1CYcZGO5zYqwrHNIFeHPhO6woat0/zOviN6jqtIA6N84QWb+37uqV/CVdu9?=
 =?us-ascii?Q?REJ5o4FFrFWRGXb1kiNjOMj41LWmkPTsr4lRDi/Fp4rM1FVMOByJ6B9vfiXY?=
 =?us-ascii?Q?18VqIWU65RgGZ9f7G7fKKcW74AWg0MVlwJs621x/v37wskleoX95QCDsL9pP?=
 =?us-ascii?Q?t1tP6mgtzyl/zdrrAYA8Iu/uozINiAWtLolqYR8wHH/vjOnr9kiyo2yJTx3y?=
 =?us-ascii?Q?GUk18U4q0wNSSFfNjaa4tKntKq2BsrkDr0cwjul+fiBP159am0cvTz3jfwWX?=
 =?us-ascii?Q?if120QGrvBBESjQ5l/cxAGHKR9HJzGWX30qXhFTD9w1VSYtc3QtewtYJBqGf?=
 =?us-ascii?Q?I7N++PWtm7hHKtm2ZQYZnZsiZHiE2VeT+zsRJA5P?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfd2a5d-46dd-44cb-d34b-08dd7bf61a24
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:18:29.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xedo6hjCzMNYbVH3zXtjoFayzgo2mVoFQwbtNMQeJFa1FQMOKUE8yL60pMJa5VktiRqfYXSbjtJnvJ5PC0+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6841

It seems that it has never been used, so remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/btrfs/delayed-ref.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index f5ae880308d3..78cc23837610 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -262,7 +262,6 @@ enum btrfs_ref_type {
 	BTRFS_REF_NOT_SET,
 	BTRFS_REF_DATA,
 	BTRFS_REF_METADATA,
-	BTRFS_REF_LAST,
 } __packed;
 
 struct btrfs_ref {
-- 
2.39.0


