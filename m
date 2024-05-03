Return-Path: <linux-btrfs+bounces-4716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6658BA97B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F62B22E19
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464D14EC7B;
	Fri,  3 May 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebuSvkB7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="caPKniKY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27E1C695
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727391; cv=fail; b=L/lxNjzz7Zx+TUDWimLu10tRm6VQ+YKIwxJE95IwNI+CFSsTzOkCd6mPJgxjWkLAEwjlpvJU0imhvU4/BrDB24upO6kGtuQYCI4vFhmrSh1weU8NHxqI+ojRW9Ggo3yj4iLUNEHZthQpq5j50H1wlpfTPTVXDB+3EacAsfj+q3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727391; c=relaxed/simple;
	bh=vhYuaKojezyybnjtl5g1EjvWbyQPeZ9/iR5UpITdyEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcWRXiiDC8frPm6SaK+wlW9btEXVb0LcXj06UHBkJXfsq4uReYT8h4Q7gIEZQA4/FlLKP3QRgatyW270ayhOqxYNwFDwUIuAacBrXb82U+BayqrPPFao70TQc9EGOtJJgs1E/j8RT/bDOuZRYTKmk/S+flNwlKA+Q4dCGyOVoXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebuSvkB7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=caPKniKY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436i868010900
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-11-20;
 bh=1LvE3QX6p7L9T3uWZilrYL+WS97VcOucvcNpRE51acI=;
 b=ebuSvkB7Kk/cVxuZlYnlmN7VFk2xfMVg/PRHHq5Usheo9MAqtyvRnsuF2oaLP1UVfL06
 U+Tf6XQQrXUiWv/wxCW/z8k3tbaIvbZYVHKArvECrlNMOsZgb4UiWMNrKBnz/YmO8Q69
 L5H9irOp03agUWhIbM9l4kJxB3A4QdnxtjQ4jkLJoxNdybqSU06+FYdwRvgBVp/FKgL3
 X1OP5rVrOp3YnH06yoGmir10zoT8QUA1oVSDsHCBg0RmZ4HQhAqTI/8UqZ0JXmhit7g5
 BerrjHgW/BmGFP07gS5jcxBcD5EQYlLOxtBpcPgYmaHqsL4cmcTWlKO+k5SliyB9sH3W pQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cyc4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438YYtd006073
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc28fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPSG8ysu2E/nxb1Lw5v5nnlmE3TVC8lBpbJVEh3OgoLkRuNaoVi745Ik/RBWPTVUm3++z9Ta457NBcyrvuD1IASKiYixEG52WRBbHjmVH/fLY0r7VyQEXlSCe2H3+FcBaU33KMLbbzKknW9LoYgm1Vlrw71sU3Y9EU80A968mc/XSxRH49gFiGoMWIsAeDDbHlmZaelqm2oQqequeLyuguYIk0QqDf5TM1wIoPIioE3opZZ2yJr+VLvgYeDP+PHShkBz8OllmJYxKFJbOzvzjoWoMiqG+/XvI+bJwQtagt9Hu+1atASSt+B9z4oUc3z2gwD8KRJNcmUTDF57iCYb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LvE3QX6p7L9T3uWZilrYL+WS97VcOucvcNpRE51acI=;
 b=BT7gZT3bFrSWueMd13PzZHdUzmTNBPQ0el/swNccS0INW8uQDdYatfrqYyl+tpA+9b4sCFojuYmXP+hZKMjakZ0Wx2cJ6wP95T1HSLlRrU+mh0L5V1gs/bSLTrptmOPtnaOVFvcr1/95AI85T8qdsLwHR6nsTLCCApS8SIXxbxm7OxnAhSl7ltmDFyEvfiJNHWOnPx9KBinvTmUgTuiEhe7s323oEEIRNRZHXc/ZLFv/kD5z8006loPLjpyyvVRr2LYr/imc32L2pnyF+FWTFzHrjT73t9AKoBACWcqYw928D9l8HzCWrnHuH+Y/VdiqNNRTazQ6j8JXF6oQL/5Z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LvE3QX6p7L9T3uWZilrYL+WS97VcOucvcNpRE51acI=;
 b=caPKniKYSvzysq+ueDq7Y6XC5lBSW+/xpfv4e83ul4rIwn7nIte5yQzKHa5PbB30k9bMmdXVE+0oWLIXbjBJbvOKmC5rhjk78Ef7T7hVEMIkkQ5GoahfKpmzEyPrZESfS/abC6SuizzmKHmDHjVKLZmclbg3rDm9NDItUcVRxwQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:09:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 09:09:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/4] btrfs-progs: convert: support ext2 unwritten file data extents
Date: Fri,  3 May 2024 17:08:55 +0800
Message-ID: <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714722726.git.anand.jain@oracle.com>
References: <cover.1714722726.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdca01c-2693-420a-e73a-08dc6b50c719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5wMT0peTbzuJfv9/YVm8pao4LTG23NSVyBhiSKty9Mn7jLL7bmZa5DmuMctZ?=
 =?us-ascii?Q?7R2QjQXByF2U3lZx/eGyhKXCyWfqAiIhVoRgByOVXLlatXr3kvmKmbJ2M+5z?=
 =?us-ascii?Q?i+Z8eXyjtc/K3BGrpDKquUYiTcsu44CydIUS/r6WnqMh+2nZCYjqQ17TFnWX?=
 =?us-ascii?Q?7ZQu8iqpGHYqc/BptZsRYcd9yzInhf5DGSo/TV/RM5kr+ZyD2iZrhYq7Hk3n?=
 =?us-ascii?Q?4wNi8gTYmrbro/DAWY3P62sp/+IAHy1bB9viM7qLSJ5pWGLU+IW1U4gan96m?=
 =?us-ascii?Q?rYiLTHmwlRMjSu3EMeI2Jbg6MTkw3IwsOIA2e89LZqlCties5QpfYRXvPRR8?=
 =?us-ascii?Q?gPaZ4AM3OLjQBNV4cdr/r+wL5+ge1GxSsqJFAQ8FBQHU8E6C5/9AtzpM4ZiE?=
 =?us-ascii?Q?GANo5/dFa32nKEVRg6iBU6tMFOsC9Rdio7QUm+hXI2iH9fJ/y6cbbHXQ6R8+?=
 =?us-ascii?Q?SeBap5u9SdLBfAWcUpabXKIb0CdJfL08mZVVt/1yba/c7aMeVtMQncS6RN3Z?=
 =?us-ascii?Q?MDrtNVOsAL6URz0yGcBEWgqTplrMbE416Uuew69RPBx0qUIDU6z8gdV/HgCb?=
 =?us-ascii?Q?IbXPIAIyWOhh/asRgaAWsjrQd33mQjh249aEPrXfXywdGFtjr0deAyyMKn86?=
 =?us-ascii?Q?h1xUy/BGJ0wYztIOR23zhuqDFZGs33Rkn42EZnSyW0kVSdHm4wEoZFZRr544?=
 =?us-ascii?Q?k8aQp+foQN3BkJ+d7hQvZfXSbctBuJQZbphIse+EIzs4+Xw3Y9I9dEJ3/Shx?=
 =?us-ascii?Q?G0rlvWDg+W/21HXuOmo6ziEr/GOwGYPr8Mr2+IBT6xdg+TGbKkRecgzU0jSP?=
 =?us-ascii?Q?KneHS6S+2+o0w39HE6Are9Xxr+zo2CASTLTUTlzIpDEOGS4rbNyvmU1KsVdt?=
 =?us-ascii?Q?NVuZ73vJq7BzPp/aYKfgko71xmYiZtFyM89jNDxxo4qDGPuVbvGZ4TsCTqIB?=
 =?us-ascii?Q?3yOzKhBNyJkbFvf6rqe2g34pretIDzv52gzRDi6xQ3Jq00e8sE+PDM1kCDnr?=
 =?us-ascii?Q?jwopz4Hol1OiozpqVSlQxrcXpW6Un+gQ/+VMkzcXlqGApIjYCdKf6KoQQW+Z?=
 =?us-ascii?Q?IZuBRTQ3qpCSfkbVvck7ibSgRY9W3/sk1bE8RJ0zokHpmhF8n2ADkIjKLKKH?=
 =?us-ascii?Q?qzPumFrBEpBVxsVfyOeHjMWkSCIQd64dELHFT26lxHmmUxVnKlhaiK2Licy6?=
 =?us-ascii?Q?jGOL5ZiC9QLMOx21cHOZDXeujDAw6d9kidLhaSUjpHhcOdwHrzbjTkmrasJe?=
 =?us-ascii?Q?FBIeByxG9C56t2MWfNLXYBSbhFy11NmNhlDCGOqmsQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EN//Pocsshee1+6BO873wvLe71zS1Jcr4X6Z1IS6MielUmFa4kY9kX3/3wWp?=
 =?us-ascii?Q?3nyZEZBXeR7o6r7drnEpvS3rT9NhfuGqpDlOL7vXbaQzJ6QMBlIvoLltLPNI?=
 =?us-ascii?Q?dxXm6/ZxEnrnJaUtkOW00gC3rrqaclqNi8IfXGh3E/BpZWTfBUd9pV7anDWO?=
 =?us-ascii?Q?MPOaweoBhKai81fELAt366TDOB8HHOnl9opeGEM3tjgvIQqq8wBgxEs5NuvA?=
 =?us-ascii?Q?Cc4Jd4BuCIG+3YAWfK2o54pklTFfEeuEBpGH0fIkBWKfkJLoVXl62GMoeeWD?=
 =?us-ascii?Q?WgAn6ttSXv1Pd1bmj4WaBJRqsJE26ZiRxdP19R+auoH8JDPfwu0Ljnt/HUju?=
 =?us-ascii?Q?WS25FHts5t+NUzLylo1MS+om77WsJTtqJ58n8sOzUwbaF+/ancX6lT07iZjD?=
 =?us-ascii?Q?znFCisesL6Zvugze/6QjW9bgkjv+Hi0JtagdATdDsGv+y/AdedyCwLam+gWl?=
 =?us-ascii?Q?g5Me37rtCNOcLkUfYOFP6kIlFP1Qj0rTB4pMrlytsvoaB9NnP4qwb1X6W7Fi?=
 =?us-ascii?Q?bN6vb6MV4FYOzkgYzwz/j5p8VzuTLYWsV8y6EKsmK1sVe8R776aJOQm9xAb2?=
 =?us-ascii?Q?CB0YFlvn3DHx6LXJDG6BYj4Ivna6XpupxeckH8n9pb42bRwZ0AP1+bi9QDdf?=
 =?us-ascii?Q?W2Yaay0ladScRHPcsifvHNUq75K+vO6nAW6obWnHIGho7UosuoCZmgnZPkCJ?=
 =?us-ascii?Q?YX65Le0j/cRFyru/nOUwidF702wC+4oCpPuRL47lkzQZXM/3LkMZ+XlzizV9?=
 =?us-ascii?Q?ErRRBwKwdcYrk6gzpCcLKMuNu6tfE/lM4W4gKB0eSyjyAcf5oobsLDZMR1ML?=
 =?us-ascii?Q?N0rJduNWH3uoot1bFCzQSYVEhvKyYw0mDEBHp9GMhE7SS7cq8j2qHHAnSKAN?=
 =?us-ascii?Q?lfTTY/2ZoT331LdfuyS3L5p2fnQXaOoo+e/L2qSu2qxBkcOgHuzg/DKHpnhF?=
 =?us-ascii?Q?T+58mflMw3PwoMK1QIrld8YgxLVKAm9epIHu6+mYOGMJXWEeUG2hCkFMzacl?=
 =?us-ascii?Q?qsSg61KEIq05wJCqienqrb4h4mSSy4aNJS/ELRpoWU1p0sJTeqaOZm3WEc4W?=
 =?us-ascii?Q?kqPSAEBM/EYo7Vq1wZqIMQae7I3vr2QHOJezv0JYk3bxo1ojP18l+dBjsXBO?=
 =?us-ascii?Q?gqIBoiGayG9StoMzqss6SC0s0e9eQ1z4VIo8BpFUXz9cozzaFjduSDZAVISx?=
 =?us-ascii?Q?P5GGz3wh8loMNERad4tnIjAkF/8XySeHTOvLEGca+oYBgpJOf5Px+tky/Lq5?=
 =?us-ascii?Q?tE1sG0JGRNgsXCG8vnMy+GBycNpmGavoOUlVzWtzglV/3B9A8QCNePIKppsx?=
 =?us-ascii?Q?F2PckAGgqvUCLv8v2PVH+FfSOkikEYxVrvjtLlVJO/5VUuFe5lb1iPFXqUzo?=
 =?us-ascii?Q?oF8j/4oeDbVHfXdHclys/0Oi1BwwD752lpP+NznA334uXyZvzoiiW7sRdS9x?=
 =?us-ascii?Q?Me0ba0Dhkvw8uf1t0ZTvoOnczd94ymXvPqhbwB3/kzO1Ky1re45l07gXxrcw?=
 =?us-ascii?Q?vif7vJFpOHwaT5TXB9Rnjl4xtV5hHqqszJOFRTytfwLFdTbkcVSLDeO9QHjZ?=
 =?us-ascii?Q?c7p/mlgcN4qsCmn2plche0mqfsw9OBUd7vykj8Kw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CaVs4FxbIfeiS/deVItz55diyLEvbfOCnEEiyTbJ8/4Tamc2i1Y/iA8GA7189IS29p+xUNvtFJvab7a+TsPXSLFvZYk8ezW6q7qR19i7UMJnO5gD7o7DcXEpOeFl6MPooQ8pSMetpyBL10gvcBkTdSKyNNWb1+/mxF+s7vKqYWk5OVCJgxPMkrmnt7N6Tel+e7NffwmFROTAA/p6CY1QWnQvhN2mq1zcoEXWue/qeMLn5ZeS90pXh7ixAKktKdX99GDRXzFDZ+NqvOI8JkgLhmcjmWswUZtmVhb/HACSQPHuFRZSy8CUvIWEKJKv63qilSsFBkVr+iTUW6GFuXTaKwzYA8vksU9lB91N2s7Sk2cW5QdlFcucEN+x5N1WIt61JAMP89e3RpKznt8VyRETEE5TrQ/HHrcn4qHbu2CIbOo5IOxZiIKaLEKZMf3sWls1imXn72Wgey+RBYP6PypKlNkZ0oXnhfKv3rNyeFrvB24DDONw1ff+W8jd+JYTpEU/4XReXgLhOxAV1/CNy5lEwlZfFxqtlbUsinzFTEuLn28ghGoxmtlvjbHRY1UTB56PEpNon4poqK3jloHKr2iC2kq/9gZDpTXLsL9lBWbAiN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdca01c-2693-420a-e73a-08dc6b50c719
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:09:46.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y0kKWJxWBotI22IIy6V+bFWCEKkaXCCLxtCg/Zwoi7YhZ1gtZw5H34p6OuANKfMH4qCGHZjdcvA4pBhzAvwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030065
X-Proofpoint-GUID: VRjLNTJNv2KFSBqcqbsLnEvJ_NtQ_5CN
X-Proofpoint-ORIG-GUID: VRjLNTJNv2KFSBqcqbsLnEvJ_NtQ_5CN

This patch, along with the dependent patches below, adds support for
ext4 unwritten file extents as preallocated file extent in btrfs.

 btrfs-progs: convert: refactor ext2_create_file_extents add argument ext2_inode
 btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file inode pointers
 btrfs-progs: convert: refactor __btrfs_record_file_extent to add a prealloc flag

The patch is developed with POV of portability with the current
e2fsprogs library.

Testcase:

     $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=1 conv=fsync status=none
     $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=2 conv=fsync seek=1 status=none
     $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
     $ dd if=/dev/zero of=/mnt/test/foo bs=4K count=1 conv=fsync seek=6 status=none

     $ filefrag -v /mnt/test/foo
     Filesystem type is: ef53
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:      33280..     33280:      1:
	   1:        1..       2:      33792..     33793:      2:      33281:
	   2:        3..       5:      33281..     33283:      3:      33794: unwritten
	   3:        6..       6:      33794..     33794:      1:      33284: last,eof

     $ sha256sum /mnt/test/foo
     18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo

   Convert and compare the checksum

   Before:

     $ filefrag -v /mnt/test/foo
     Filesystem type is: 9123683e
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
      ext:     logical_offset:        physical_offset: length:   expected: flags:
      0:        0..       0:      33280..     33280:      1:             shared
      1:        1..       2:      33792..     33793:      2:      33281: shared
      2:        3..       6:      33281..     33284:      4:      33794: last,shared,eof
     /mnt/test/foo: 3 extents found

     $ sha256sum /mnt/test/foo
     6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  /mnt/test/foo

   After:

     $ filefrag -v /mnt/test/foo
     Filesystem type is: 9123683e
     File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:      33280..     33280:      1:             shared
	   1:        1..       2:      33792..     33793:      2:      33281: shared
	   2:        3..       5:      33281..     33283:      3:      33794: unwritten,shared
	   3:        6..       6:      33794..     33794:      1:      33284: last,shared,eof
     /mnt/test/foo: 4 extents found

     $ sha256sum /mnt/test/foo
     18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  /mnt/test/foo

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC: Limited tested. Is there a ready file or test case available to
exercise the feature?

 convert/source-fs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
 convert/source-fs.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/convert/source-fs.c b/convert/source-fs.c
index 9039b0e66758..647ea1f29060 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -239,6 +239,45 @@ fail:
 	return ret;
 }
 
+int find_prealloc(struct blk_iterate_data *data, int index, bool *prealloc)
+{
+	ext2_extent_handle_t handle;
+	struct ext2fs_extent extent;
+
+	if (ext2fs_extent_open2(data->ext2_fs, data->ext2_ino,
+				data->ext2_inode, &handle)) {
+		error("ext2fs_extent_open2 failed, inode %d", data->ext2_ino);
+		return -EINVAL;
+	}
+
+	if (ext2fs_extent_goto2(handle, 0, index)) {
+		error("ext2fs_extent_goto2 failed, inode %d num_blocks %llu",
+		       data->ext2_ino, data->num_blocks);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	memset(&extent, 0, sizeof(struct ext2fs_extent));
+	if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
+		error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
+		       data->ext2_ino);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	if (extent.e_pblk != data->disk_block) {
+	error("inode %d index %d found wrong extent e_pblk %llu wanted disk_block %llu",
+		       data->ext2_ino, index, extent.e_pblk, data->disk_block);
+		ext2fs_extent_free(handle);
+		return -EINVAL;
+	}
+
+	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
+		*prealloc = true;
+
+	return 0;
+}
+
 /*
  * Record a file extent in original filesystem into btrfs one.
  * The special point is, old disk_block can point to a reserved range.
@@ -257,6 +296,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 	u64 old_disk_bytenr = disk_block * sectorsize;
 	u64 num_bytes = num_blocks * sectorsize;
 	u64 cur_off = old_disk_bytenr;
+	int index = data->first_block;
 
 	/* Hole, pass it to record_file_extent directly */
 	if (old_disk_bytenr == 0)
@@ -276,6 +316,12 @@ int record_file_blocks(struct blk_iterate_data *data,
 		u64 extent_num_bytes;
 		u64 real_disk_bytenr;
 		u64 cur_len;
+		bool prealloc = false;
+
+		if (find_prealloc(data, index, &prealloc)) {
+			data->errcode = -1;
+			return -EINVAL;
+		}
 
 		key.objectid = data->convert_ino;
 		key.type = BTRFS_EXTENT_DATA_KEY;
@@ -317,11 +363,12 @@ int record_file_blocks(struct blk_iterate_data *data,
 		ret = btrfs_record_file_extent(data->trans, data->root,
 					data->objectid, data->inode, file_pos,
 					real_disk_bytenr, cur_len,
-					false);
+					prealloc);
 		if (ret < 0)
 			break;
 		cur_off += cur_len;
 		file_pos += cur_len;
+		index++;
 
 		/*
 		 * No need to care about csum
diff --git a/convert/source-fs.h b/convert/source-fs.h
index 0e71e79eddcc..3922c444de10 100644
--- a/convert/source-fs.h
+++ b/convert/source-fs.h
@@ -156,5 +156,6 @@ int read_disk_extent(struct btrfs_root *root, u64 bytenr,
 		            u32 num_bytes, char *buffer);
 int record_file_blocks(struct blk_iterate_data *data,
 			      u64 file_block, u64 disk_block, u64 num_blocks);
+int find_prealloc(struct blk_iterate_data *data, int index, bool *prealloc);
 
 #endif
-- 
2.39.3


