Return-Path: <linux-btrfs+bounces-16015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81949B220BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A741AA35B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366692E2665;
	Tue, 12 Aug 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xt84UPNo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012036.outbound.protection.outlook.com [40.107.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824242E1C50;
	Tue, 12 Aug 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987170; cv=fail; b=etpBeK6l0KpGzc+Gkh/PMi7gNeJ2eMC+VGMSxocC1L41IGrq5KFaaykZL4KRQS/54V5XFlufPsm+S3XRdcgmdE1m/K/li1TREG8erNkRpI9gozpWv76OhDMPY4VutmDYGBwz1vje5bdwbAiD6SmrRusgZTA/qJfDwuN9WGy8yWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987170; c=relaxed/simple;
	bh=AM64M+oaIjYNpDXqZSqkjGZTC/qWn2xl8V6Alba2/pY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PriZuFEe7x49Xizjp8w0R5P+YEFX4gGiDUrKsNNawm7f5dJlCP9JrQnvcrbEn1KNyltqQJWGWNtq5nLzeOfptxISbrjs7zudFktqJ0/sW6dMg1NPfg1piz7A7KA1N5o33YmzMYqTM6SC6MU6toWdMqH8DkaWCl2D1BDDmWaBGZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xt84UPNo; arc=fail smtp.client-ip=40.107.75.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfhTIEtZ+i3JTDLpffOdC/sFl5ms1ovMfkaVsQda01bCdlSuhJ3tblHaGrMKgAS86prTRTvldHA2QuszD/ZU3lkLU3666oVu83Di4rM7C3OSqle28ljNIfHFQJN4cg7wzh4jt8CajrnPV0t4fglx7RO89L8tcXeh9xlyu2AxVRNjOXBRG0iU80OhnfneocDwgff77MUOta8ptYHlBtp/WPLPVmqfTKx1lXnm7rSBnYOYMBvByD/yd0yVd4dB8cBo4d36OI343f97LQf9pkXglUVcjSCt28ExEkCP5Vj3qtADzA5ibDYdDn3FY4zVBq4tCEWnD8kJ5/TbkU5B4Clxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZRgCw+vnRoUtQmCwUtTHOK3SLALcFs/cafKtqtyid4=;
 b=yf/iZmsY7xs6VdPEeDkYLOTNbAoXx9qTp83xMOp4dGVJm5a+2i1NNqZ8f2j9rBnSiI/w9dWRZTAeeAs7LaoAxDDXF8rpELRAsMjvyvMuM6DzxQV26VkB4Lsf3GXk7Cf1EC7WR3edknSPN/dZ/Eu37gnvzCPmPBRu37TlddQ7jSXPGOg4SbrsY15N6AE+6l6hy7gwoF2TzHW4RJIAYf9Rgo0ubKq6n7EkAALNHtX5OupP5B/hh7xnwRuuoE9UvvZGENlT/7Ni+hudGOJRjfNZ3zZCiCEkS1VnkqJ4+ODNFAH11cgMjQYELjVZjXnO/sGBd3l1kuPbC9Ad+6/iLmOUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZRgCw+vnRoUtQmCwUtTHOK3SLALcFs/cafKtqtyid4=;
 b=Xt84UPNoSk08N4f7GGKbWXPrN+sMZySdF2+E5Z9FXyHvcHQZeIshQGNnqgGGcwTpzwxZyLAAS7Y6rPRoDMV+xabDQhidfucT6reLYFiqBWEDFHzqQTHFYR0+g+0gLASlZ5y3/lGBdPUxKoqbkpbsTAoH8iYP+WvIa/dH4Oiasn7a4dTWpwqK+ygFzv1RwkNjuGwTlUnPRkxJC4C/XBGrmN9YY6X9EPmLcHI9XnjqnNr0RMSRnvB2lZDuiibe0tZj7J5y6x/F4ikY524ENaC7wLLG0U0OMTT2QEMaQ66D8FOw/kEc81DzE52aTRZLZTwcJBx2a7qEKRrAiY+XnXSO4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by KUXPR06MB8029.apcprd06.prod.outlook.com (2603:1096:d10:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 08:26:04 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:26:04 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] btrfs: use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 12 Aug 2025 16:25:54 +0800
Message-Id: <20250812082554.48576-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|KUXPR06MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 021aa3b6-095a-4361-ec4e-08ddd979e0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1D1eMDj1IAZr8BSz6o5sL/sugDWKDMpEg2/N5xROMKf4R3vggME62MZEUIyD?=
 =?us-ascii?Q?HtCcoZV4vEfWoFth6uSznNw3bH18o8iJtjrO9uixGXn8Mg4JWVn5QwU7AO3Z?=
 =?us-ascii?Q?mHC+OdPT8KJZq64GzPN1fnKOmgYTYZcLtBtralkjxZwBdH1n5sespu38bCxB?=
 =?us-ascii?Q?PeP8OCflvnWNYkqKQ4szPl+vMXnOO5oWhzusDAHzVVnCMx2v0nuGp6JVIYRu?=
 =?us-ascii?Q?abhixqiiOxhTBVjs8tPzuAk4sbSildBFDJnlkfkofxBjB2iI2jW/NOkI4Vvw?=
 =?us-ascii?Q?4C4KVKYyGGJNc8f4BqKudPFry+z81G8QtORVCiqyUMZt0UGJtSbISW7ExAee?=
 =?us-ascii?Q?miPavTqmtXV9DTwVy3qIkMm25HnWaxOBkuxZ7RtnNgL40eSoAdaDBLTVynSQ?=
 =?us-ascii?Q?VZQSrhAQe3WnZu+2rilC1CZKoBvrq62ntMX6kEhh1IndCvokhpAeEL9r/6Lh?=
 =?us-ascii?Q?xQNh8iHzzcvi522ZmlkvCS1SCdWBrZMdx8M1NVMERC5lvio8G6WtbjG4FSWN?=
 =?us-ascii?Q?a6gMW/yecjWC2hX87HzgJZRWe64hjkPivCQB399jzftrS6BTm07KtAnvAsO0?=
 =?us-ascii?Q?yRysGF6OSnYgCOCuTj1OXSj9vHubiwoB8DFX4vECsr/7N8m6I3HwxRgwN7Zd?=
 =?us-ascii?Q?sLjosfHCcEmd/GTLLkbU/dlanOsjnVhDzvJbmqb8xSIEGDurRQyyyO5XwGJN?=
 =?us-ascii?Q?/67OxAqCK6M7gQYWEGEoxm13wV6mZRoY1H7Wp/GUX1DVr6uUopQW3Oc9AME+?=
 =?us-ascii?Q?UkrlYR/0WOJgp41dc6l50c1Sjyf7YUK57wvNtlheVky+B+DzdCpahM8kcgGF?=
 =?us-ascii?Q?JHrxA6NxiyV50MM3n2BYwmbhOWt2WWISl04LsSlq0A4ASyhcs8P13XulCYo3?=
 =?us-ascii?Q?39cMZtRCXKNLTJLkkih4NWOhawjgl9fNSjGhdNA6ck0pntE3pHqhVZwpmV3o?=
 =?us-ascii?Q?ti7pbZ3gbVh6PLVhlgVruRupPWL7JlQ3Dio4J+StoiMP0t1e7EWBKJOos24+?=
 =?us-ascii?Q?HK5GYKN5VvUki5kR9M7badYgGIVFfF0iShEYBhG4nM8bZU68Fskuwl5FPwSF?=
 =?us-ascii?Q?/3vAosvzylRabQzj03Jbslb+czQDAHRaKWSEh0W0KF3D/HVQtmLA6YQ+xOlO?=
 =?us-ascii?Q?dX/TSY0RPcTH+QKX5iDizJZxewUIVlkbl0LwMl8LPEnKePDgs/EEVBcGcyva?=
 =?us-ascii?Q?oFbgmwBkP/EsvBqEFeH//4B2jRH5VQzk6eu4w8n2DLXU3vieuljGkjuBpcfV?=
 =?us-ascii?Q?QP/y1eqmE6C9Qk63zhv8cWVf+1i4E3Fek1MZDVJGJcOM6rsxaWxs32BOTwev?=
 =?us-ascii?Q?6aUaesTs31Uq6WLKCts6M8RNe1yjEtTkniBunVZHvj0OTCs2W1XIEPtB4ZPC?=
 =?us-ascii?Q?UDyVGYJKqlJ6Mjwkm2pvClQn2eMgfOcmhEzMLLdeQOsYjszL+1r3GpSKiuf+?=
 =?us-ascii?Q?+7fIjW4blwYudWLJqSVYQrMPTLEXlZbFp/Kb0+RjnWLjEUCJLKtlKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlBEGovLUpwa41+gX9eMP3MPRlVviFTm6RQfaLpWPNCMGOu0t9dx60Zvjwv7?=
 =?us-ascii?Q?oeX1QIXFHOmAulteKy09o7AQLpkwWeRYhSg5xXB3Cd2gd7R9SHMhtPUjHJkS?=
 =?us-ascii?Q?BaxyEA3SGGGip6i8YsGjrurmGUxo+CHhDG0aNDwSGJpq70ekmg7xP/30fKqS?=
 =?us-ascii?Q?JR+qycFJyDwvDKlDL+rLMl1/LdhqUJVs7TO/uuVpUS8PUXZGt3dqTYThljiS?=
 =?us-ascii?Q?woZhXHZso50Wd4LViaFReLrgv9hGnY5dJROzn69pIjgyTA61iZi/7sqiLD18?=
 =?us-ascii?Q?JRNS1hjcBiVgX1YY58ZIz2XPYVi3kysUtIKT7SigCs9jCLDFIeBqWDOMr/Lz?=
 =?us-ascii?Q?GA/Ux4yNh+KXHOPBar118PRcxlv62aqCtzgv+kmrM8idyXOK/2HkMtIVADin?=
 =?us-ascii?Q?8gxUL8JAqWYaBZNtcgGax7DrOEhOlgq5Oufd+8IpdtbB7hJW0ZOGrCB4Uta8?=
 =?us-ascii?Q?hu63irzkG0pfGUilgSQuQycwSv23xvJDCqfJpqjGx3f6m++QCKnEURRaA6np?=
 =?us-ascii?Q?Hn+OWQe+6JpEam/alKFxgGOzapxEvwuWpmTCNC361mNLzt7qXlXCK0YCfntJ?=
 =?us-ascii?Q?jusJrFbjcmj0bkLwGa3X3v4GQEQ4b1Ub+oxTW7UPvYULaDYa9vZLxWvEeEUT?=
 =?us-ascii?Q?ewvTiCXnmeW2v7LYrK0Rb+cY46QFAGV1racc6AQtEY0qg7KoWoFBY0bVuUEn?=
 =?us-ascii?Q?zJsUcAuXduodg5Pvrs/LIjGD8f/aoHJt5/zFKFwUTS0uVGuI8Rpa6F/C0w2h?=
 =?us-ascii?Q?+98Po7ud+e59XXSKyA6Oy7qAYSBUaTEODfRUEZ/f0lQQ0iecuZ412CPqbIMJ?=
 =?us-ascii?Q?Z47N3x6c+VfAMptrvFAF+94o8wDXGJ8D2UrxxrVH+kQORGOw9xFBEvy3gcL3?=
 =?us-ascii?Q?Z/ankTZV7gp6Zp3wfPFhpGC3UBKxHlqDBtoUFbJhvhVGugrg1b1STGASsE6u?=
 =?us-ascii?Q?nT2JUjS6kFud51cVsauvLNCUJFbSI0q+MQutNcaSW8Nzw+fXQ1MKzTh5PcFe?=
 =?us-ascii?Q?skF88We1ydKBZ/soAafeVsgdhArYIhjkGc3UB5avssNj8r7O4rjZvVsowgWa?=
 =?us-ascii?Q?M3Zz9CIOiMlGYl97/B6WvQDUpTn0NLWqXZh0OUVj7M8svOn2osTtj7hicXYC?=
 =?us-ascii?Q?iTYMXPAOkJKGJ/lLEDBYSrElQURY8w3CUs9PXa0gtwDJwSfv3Y66bi73veLk?=
 =?us-ascii?Q?xAIqSK+NL8eeCmOTQvGZXMcKGgyFtsCeROyvekdB908IODQDW5YgIFC5UOLT?=
 =?us-ascii?Q?a+WhbVz7/8rkTaTrBGLD2AWHdQydPlfhjOKRigxnsB67dCHszHDd5vhwZhVG?=
 =?us-ascii?Q?UfU2peBFEPBVBU1YjYa6eqzunmlA13ZsP6NvhDw0DXs551fABOVIPKK0g9KD?=
 =?us-ascii?Q?zbWTpUA3UE2VxrvQSsuUt32+GW+vb0cPAlHAeSzKrHk3mrjrrEkEyZh0NZg5?=
 =?us-ascii?Q?63UFkmkC5q1pKRdJoDCNAG+hO2gUE+wi/DCu5TBkFcvB0JKrjC9nz2UEIt7m?=
 =?us-ascii?Q?8pQ7Y7ZxsQKs47pea12qpwRAXsr7FrvD5BhUPyzrdlv7XxPHZgFuJuHP7OfH?=
 =?us-ascii?Q?iJ7G6dl4tI+Gk1X9SM9Gf1xnbK19z46FNea5GuhB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021aa3b6-095a-4361-ec4e-08ddd979e0dd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:26:04.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aR1/dzvaRu0in1Dca3dM6H03psbg0j0ZiJ0PJM/A2wHix3IXkmSqmcll8lGtufS2IRtTj+by56KUdicJetNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8029

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/btrfs/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 68e35a3700ff..57dd58fd8b9c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2257,10 +2257,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		device = btrfs_scan_one_device(vol->name, false);
 		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
-			if (IS_ERR(device))
-				ret = PTR_ERR(device);
-			else
-				ret = 0;
+			ret = PTR_ERR_OR_ZERO(device);
 			break;
 		}
 		ret = !(device->fs_devices->num_devices ==
-- 
2.34.1


