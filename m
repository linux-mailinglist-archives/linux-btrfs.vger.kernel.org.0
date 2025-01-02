Return-Path: <linux-btrfs+bounces-10692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D949FFC09
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562BF7A1E4A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753501E522;
	Thu,  2 Jan 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7csPXiL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="twclhQJB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1194481CD
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836126; cv=fail; b=FNr4RWOoymj4zpatwJ207d4tr11LVGJwvfJ6HPX9PuVJiSkY/0DrKNQh5SB2lt94fUCNrDlmwiRQ2EbxczacCwYatk0edgbXM6QGNztA0QhtJjFChkwnEHcjeruZdt6Uh8BCUqD2K/eiXiSAvtcFlxVB7+DdgE7G4r4N6AweISw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836126; c=relaxed/simple;
	bh=LM9PtwlZ0dgH1U/uVQnKBP6pj6NtfLAitKqGg/WK0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9To4QT4Ak8jR1irVpKjgGDNvQZISR64g2EJXO58V+z2qv6OpnSeAcD1dgVzRAq9QSuOn4KdqvPQFBkVVDn3XdOFjMq11bxv2wa3eYki6pqdnRD0MQ9Ow5QX9MT93CALoKoaAA6PAnw3c9ylltjXH+maiH/NhMWSNqHvmaXY9QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D7csPXiL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=twclhQJB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502FtvtS026700;
	Thu, 2 Jan 2025 16:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YMo/l3pyzoLe3Nf0H6w6STgNIUG0o8zHmTz5MzJVH50=; b=
	D7csPXiLet0JIi2Lesch7v4mdhhybfO1gbboWEcADCoz6bWed4PfKLBa1fmpbm/v
	qWr6iGFABYrSeCepTk1qaYlUDEC/sRuP71Vlp6T1NOKKcgCAcFUDM1sRiohN4y7z
	vS+UaCtvakiLa7oLdDke5rpSFsjCZc+vl+CGtzSfF+ncNB4mHGGGZcz76tIZyVRZ
	/+PmT9pnMYTO38DmYi51Kkq2erFhlIN/5Jw7JU6EagKuZOXAThnx7RN+0yqAgNiJ
	JVFCMRuxWBaY2GcXwSPUqDlLsL+/11HASltU1a+yTTEFdkiuk6ZrhBfl3agaYDGV
	soMqEFmu70cAKNNPGIkS5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a5stj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:41:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502G7ip6033539;
	Thu, 2 Jan 2025 16:41:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8h55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY2Ul7iKAwj9/AvO3vCBFMrfdqsA2Q+vI1BOByuXrJ3Mb1LK4vNajn3DXHfkrUeTmKuri8HOsT6fZRoXWXmSZcKlTK4YXvJWPGoGYlKvr7jXNiWx/5/2N0DiIJfg/urPq53rS9P68AR2jCLxUT88le5at6Tsf3wDYsFGLgbgsrX2Ok1fyzKt6PauLr8tzyYCRnvlXLJatnOfj9gJBc3fVKKSlIi5a55JRI85pnBuP2LEIv6kJ398hLHqJnmicr7HRgET02J7v4nM5SM9MWkr2vcl+dNmEMY1udu9+9q2pvSHfR4IwBKIwKZplavpkf/K6+zKyAsPqhMYza/GjkmsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMo/l3pyzoLe3Nf0H6w6STgNIUG0o8zHmTz5MzJVH50=;
 b=rRiSApdDfLM9y6t3Kyt3jpM61R8GSCG0du72Kyc8pSnnwRlEgg+H50iCOECCc5vuPlGEBb3mVqKI2nd7rQnllGOm0WIc1Z210jK9I8Z6vL8qHdAWEH4/IQf6JR/VMhFJ89InXPO7TKjJeYrlcTSrTYkjEfViBQtukJxca5ZsLMaGhFKxhmArhWAo5zodrVe913NUTlFljhXDCp9sRF9uRuhP53kmyzOdFXqtd7HJvhd+YTZOYraM8/1f7l4JYYxQPnorSrr9r+FGXq6h3sR/Ezkhyk+n3QnnwNcHD2YEe2KCx8jJzPVLIDlQhHa+ELIig/zUa9bR785ExU0bgjeOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMo/l3pyzoLe3Nf0H6w6STgNIUG0o8zHmTz5MzJVH50=;
 b=twclhQJB0s1iAXASfGvH97Fj5r1ghe66DVc5sD6tQaJSzL6j8Wo9HnerHm40W0L6gOXtiDKzm9jAiWw3t/n/HQUPYyuQIrZ3ahEj43xeRglYeo3hjxEjR/GyUbB6FtHlDi+eUz67AEwwgxQ3AAABcq9L68+3j+Px7dxcNPR7rNY=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 16:41:47 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 16:41:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH] fixup: btrfs: introduce RAID1 round-robin read balancing
Date: Fri,  3 Jan 2025 00:39:46 +0800
Message-ID: <b3dcf390f23f57c261fdda1ed6cc6d0bd83d7891.1735835856.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6f78674a41cfacc84a12f41d6ce8ec689a5c3382.1735748715.git.anand.jain@oracle.com>
References: <6f78674a41cfacc84a12f41d6ce8ec689a5c3382.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:820::30) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d030d36-28dc-4f08-1436-08dd2b4c5968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7WDgmIp+6h0YMTlHNHtFE1N+CZMY8xYF0XFD0GOYjYYpbsiXIRckcXBjre4?=
 =?us-ascii?Q?nenCwSXfbX6BHNrMD1j3VwyMgnrz+xIrCApgXGeySac2KfBDh3qnckYrAGtP?=
 =?us-ascii?Q?mgWDeXTngqg9oPEM4B4Ms7wf8lSWmPySHPZL8lMFj2WD3Lca++BF+PcnsuNh?=
 =?us-ascii?Q?9isnqrCi+URXUXyK8I1Bfldktbv53O93CcnEoIW/2v1RwgNjOJUp+uzioFAJ?=
 =?us-ascii?Q?HKex6zyXtMWTpIZJgvE59eWJKyONpk/Olks1M0IwAfMRI6SlEz4MLH7uSBPO?=
 =?us-ascii?Q?QGAE2aeRIAosI6nCn8paT0zLqiBT4wB0uNT8p6a0YNRfv9kuoPAWaTPRc1vq?=
 =?us-ascii?Q?4CAs37rPdaUjHYVkQHKGnjSw1j/vp6fbwM0WHfvqoDS25U13ME0tOjFJhGTk?=
 =?us-ascii?Q?Z/Em+ne4io1Fd9dA3+VjEIDwhgHwQu9mH5hSTqClT8SNDU5eBtdHhzDnOnix?=
 =?us-ascii?Q?jmsf/QEGBEf2yC3LxnrzDyRR/ZEoxS2NtZxVqs2bGlzr/3z/dW2UIkghNkvP?=
 =?us-ascii?Q?DJamXgX+abc5raIWRGhSP28BICYkXZMipH0bM8dwVbqGko6lpgJRSKGBICV8?=
 =?us-ascii?Q?djZZA5/8URNdPdhIRvg2zpAEYEfP+Ow445HS5O5etL5rZ3gUoGnWJH9nx773?=
 =?us-ascii?Q?fzmeETU5vfVVu4Cb5CRSLJYja8yij4eYoC6cwfd2pK0pF7sEtiwr5KsLkn7k?=
 =?us-ascii?Q?BbfwZu0HSoGRfjdWNB8wloCl/DzSV/7q4Fr9y7IIDqelSwmoP7HxzKcAEMev?=
 =?us-ascii?Q?phv34jtswiM6YaaCL7URSH6zS/P/1wmKRcvDb/B1jn5djxwXQQSSk6xswwiB?=
 =?us-ascii?Q?tm+1yEdpW/0Qku88PZSNT8f5LFuvdNSG0H3nmMgeMmzpwz6lORHpFuaQ47y0?=
 =?us-ascii?Q?GOkqCH/gyWPKPiWusMBLV1Xl04vtuoHWFkrn1s6KBlJRTIBQr6jtGrTo5+lU?=
 =?us-ascii?Q?NYlZUsDgwE+ZNgO68GDoJPvHV5EPqcyko7QZGDjcTc8lgv6kfpNQJkTztfA9?=
 =?us-ascii?Q?Gtv6vHQB7kbw+fwhhICHK6FvASHmbxfWfG6wQamz0VffxwtNZbFuKUHq2C8h?=
 =?us-ascii?Q?ImPmPvgbkGZYf2euUYkU39IthDBZLvtONqKrDbqJNBMUb/wdqsafzHPe3dJH?=
 =?us-ascii?Q?qAYwHL+Pamktwh3piTglMMIwc2VRNkyNDKqyqrQoSl4sbZzSUFIo6Ww/47f5?=
 =?us-ascii?Q?FFeot0xIo6FUBgdCvdTj8obqTNjestPuj2EqVV1XBEo0Aux1cWgMhayPAi5L?=
 =?us-ascii?Q?eZU5VkJDbWsWZ6yLkIYIqF10IXU2vf0ZslZoEo7JmzsAEIZnk1uJkJvuHhUL?=
 =?us-ascii?Q?xCEen0Xd0sk7H8Zx9cHJ7MFyNl50IvQXoQRCMUqxp+dCPXxE7m2/GOOTfZ30?=
 =?us-ascii?Q?KtMMBTQ6iQXiXClaocD6U56phWbR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1oT+QJ4h6dg+PtzlCn2SS4YKSdAhFK7wwUECBJ2L34y0bCbr61QQd7I0dlE?=
 =?us-ascii?Q?TQ6/yLR3to8IIj63tmPgT49EFYS8IegWAvtDXJyShDh8VpXAZTw5Weqs6Qk7?=
 =?us-ascii?Q?CENGrk+HpA2X7/DQPc9NlUZw0uAYKKZk/aC4TFWi6rqnLFInhpYVmlq6s1+M?=
 =?us-ascii?Q?9tD13Atb2opgj5aopH/GSoatNPjL9q34StLeDATuxeYIpCYikSbGyqTz2eoC?=
 =?us-ascii?Q?teHyTVSG2CgYQMEsj4WtPJYNFQP5wEol2YLaL33Ev0XmB9VmHDXB4GwRbavp?=
 =?us-ascii?Q?uIE+7rH3m26J3puxq3K5Nm7wqq89L65oBYIywxPQleSSio9XseM6Re/n3eJ8?=
 =?us-ascii?Q?uDs660MbXU775WyX4iu2p7UJ3td3AYdIoNzeX+C3xZuuuEAotmcrFsRAmLfr?=
 =?us-ascii?Q?V65YtJtla8p/+KTIDkfk6XTCocTZTxfaEicUR2mLmDoq/op3kP06/h+f2i6p?=
 =?us-ascii?Q?NLkRu00/7XKhnT0gWWuWNOZjip5KCodnO6UJN8yJsdbtD7+Nyb6Na/J9gA89?=
 =?us-ascii?Q?n4MyGSCOzwP8VR5+B/p2/83pXyrgRjL5O0bPOaPpIbLaYIfvp15F2gctR6l7?=
 =?us-ascii?Q?aha9+RsGyU3nHLUAsclCWGs/0jQMLq5D33Q321Ye2tnvwM4g9z3+JKB2Ijck?=
 =?us-ascii?Q?0Tj+I80azomcJpwX128HvezAHirq9SVISLHndjFsXVoZ60nhQgUPhXgudtFu?=
 =?us-ascii?Q?IwLgPiIq8WWWcVf3ETf0ojf4rKGvg2f51WRmH7oNpAnx1AC7ObRRXpLmGAVE?=
 =?us-ascii?Q?ehYKyUQikiYnBInnHtQ/mWkibIerXrXZ5HJXtwmBR72QGm8IitsqCM6qN5UT?=
 =?us-ascii?Q?bASEFajou6qaOQU4NIHMehqWEU/Y8xoypN2mhms7C2xcqeDgCdtbQjygad5y?=
 =?us-ascii?Q?ukkTtKlohNM66cdU+AsbC+/0jYM2Wgk+T+GexEM1wYZL7p+ghsBQD9WrasMV?=
 =?us-ascii?Q?YMUj960HR4U2QVJakzlBbpHc5qtB2RzAsOeFC/J44w1BGU+bF4HZPHQKp7i+?=
 =?us-ascii?Q?0MbbVdyVIDBzGlEwPmmpHWw8o67nPOUH7vlIv5FZruU9sJjKkBfGcMTPdMSR?=
 =?us-ascii?Q?rqupOJE/lsB5CIGlWTOibrOxjFPr0dmmHDlC5gVabKZsia/49+RyuNYjtz7h?=
 =?us-ascii?Q?k3rWqwt4lRwOz/IeW2gpyTgNRqLkLN+9+nN8TzE+1mUpgK+5/Jo4lSrC/d//?=
 =?us-ascii?Q?puzCXVAsUMhyhMvXgSSxAwaUhFKwtMAl/XB9oO3+bMKVtj55JKWtzoXjY4jh?=
 =?us-ascii?Q?4lWNwJ+6uw9OOSYgXawJ+8DF6hlwnYyqzID3mb0M3OET/emizutYzcDwrkT8?=
 =?us-ascii?Q?B0X/7HKzh07NhRBIqGR7h+I6f44OZ23ljHXuRPqLqNZ7XdVZSHeXw3/CFsug?=
 =?us-ascii?Q?zLDVe5pux/lVrXxoDNLrwXWjy/Zdw4Ca7M8w5CUkAmukWXZL6IbtIKdMDCMT?=
 =?us-ascii?Q?SeGTQqh09gxAknBhFrO3te1BEsuDo7C91mPbyxckWyKMMhxKWXj+S5OPnir/?=
 =?us-ascii?Q?2YJd42RNSHImhlpkgNm4d/OiH6cKrFbSFcSJ61u6pDXJy0rfhW0n07KJKYyI?=
 =?us-ascii?Q?XQMlSKdsra9V6Tq4XXaf9Crq9pkhg3ObLW2KnrOs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8mlHo18IfUgW3Hs7FXfkmnUgGeRJKLP776yMO7zU7vvG/LXtzyS9pClvL92XAK7U0Mhe2Wt1Z685MN4JH61z1djrEW+Of7J9B90C+vIsz33CubMotGK0lT2r2Sbal4D0MkDRwvOrTsHYCXI9lcaN7P0ZYWknQFWvfr8vM2qRA5TewONvTUu6zsLhTvtdTo+59Hlm0+LNBjm+RYuNrky71zlpBgbLT9Bi488LCVuV0sO1OmZHpx26hdCYGwsaUPmvAEpR6QIIN3qz9+old9WlCXR4DV+0B4SlHT4uT5pZeRlvs7LV3kBInjk+qxVC8w1D8CpXwYIL0DcuQI26Uynn3k/+U2SmfL5wIBArCK4JmRqpgD0Mjfu/FGbdeTkko+F7dW9OdJyFCOuBAJlL/YybCmzFT2wyt4uYSSEoYqUftcc6QSOUWjakqg5IhKRBgeBE1qCwv0em4ya2XHvti+DehN5e6d0ly5FelDMmqBqnxy3gKzKisrpvvrcPS7lPDVN2btS6pGXYeSpXWGDfkyxxzUkfLhHhS69FQnQ4Lom5052wobBgPDH85Kn4LWJqz8SQWJ15hR/q/oVWBdZgkmtLyVT7NyIdnYAyFjVvjgXqSc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d030d36-28dc-4f08-1436-08dd2b4c5968
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 16:41:47.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ut6dX5lZpo6HXnax5X6TzzBa0XtYPfJ4CP7swJXVAOZb+5F68IAZnIbrJuAtm5L8zXyo8l5aGRD9bfe2GRm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020146
X-Proofpoint-GUID: TH_qgkTW5JyE2ydyHeIIv3Nw05pUTYx3
X-Proofpoint-ORIG-GUID: TH_qgkTW5JyE2ydyHeIIv3Nw05pUTYx3

For now, let's keep the more typical storage device cache size at 256 KB,
which can be updated once we have more widespread tests.

This patch should be merged with in the ML.
   btrfs: introduce RAID1 round-robin read balancing

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 18521aebc484..48b38315672e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -296,8 +296,7 @@ enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
-/* SZ_192K = 192 * 1024 = 196608 */
-#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(196608)
+#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(SZ_256K)
 #define BTRFS_RAID1_MAX_MIRRORS			(4)
 /*
  * Read policies for mirrored block group profiles, read picks the stripe based
-- 
2.47.0


