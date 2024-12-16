Return-Path: <linux-btrfs+bounces-10425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B29F38BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F0C18831F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC9206297;
	Mon, 16 Dec 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnQQm8Gr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3Ul3Wy3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEBB77111
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372869; cv=fail; b=nn1+B1vLNsyu+0FkXQf/EH+m1vjyd7dSDvAT/yogT8dPJoIatUCyTAiITgMxxbvJEpCuZfpnh3zBwL86OTaDXvqR1aX0n91FimzLP8RQaGJCBDKBoBOwvAegZQl7tayF/ocY+QvgHisuVHGaLAAkajJtFnbP7eXfQzpNA5oWHXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372869; c=relaxed/simple;
	bh=3KLemDsLPlF5iRlc2OmMQXdf1mgTMREERAuHu76nM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfiGHgNi4dJD3EsJ+5PUoS4V3IQSULiRgAodVRWryl+1zeaNv3n2a86gCz5vEFbnqxVTPkGT/ypIijk5sQlU1pzSo0QPs8bpfRqHEvf1KgqeZXuaDyH76v0wqW/lq8RHfh3v7biY6dvuE3AaUGatbxdcBf0jYwRfq8TWFw9UIoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dnQQm8Gr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3Ul3Wy3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQkaS015201;
	Mon, 16 Dec 2024 18:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2jYes4eMXhRr92kjdVgccx+y9tEC7xLjTFAqJmxrZF8=; b=
	dnQQm8GraWHfekW7oKxr1ZV4pNWuUkwvQnRVZQ7RVE6GfCcofjhqktc1aiE2cFq3
	LB4tAd8qf5bllQUQhVbtUXP5kPyB96uTS6//PhCmUvxr5JApzP7ydZygOeQz1Z77
	jI7F0rtB9GJ5tNA41VNfG+/YEj+QfAgRCQsUbJY4X3JqR6uCCxHyML/4/ff9wmVh
	F9F6nEsqa4WgYvwU0B8i+8IP3K5bQFSJGYjA2ZtAXCxL+1kDVfI2qG8lbaHLZ9v3
	8387DQ950q1CDh98kdFNCEQHR9Lnf0z17X8thA4GuQ8saZ8YTz56B+hDicrD7de5
	Id3xZKWJAGzH1wCpK4azkg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9bxc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGI6AxV000562;
	Mon, 16 Dec 2024 18:14:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7m3gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUozlItNESZGP5kxtUfvKnlGiNNA4234IewTxQM3sv8Tz+0mAPU0fPYHmYbzwzviXlnVR9vFIdLdDaiUML1ljSQ0X/PMvl7K+GC6W1qWxZZTeN6UyKLmoNbCOmslK8+27r5kf7OZKB1wjsxBKzWuEKPIWnOG4AoNLJEmfiCwDoUmHQb4bOUK+Gc7tJ6v+2lt/umPvBKcww1u48OTRn0lY5Y5E9ok8EAIH80j/M0ZDotYQulZmGf7m5tdEA1XvcbTxttVD0u+XDqJZJmlCYFmiab6V3Ad18VOpf0C2Dy9M/l6hw+WcShatWqJpE7JnJSNI4e0SkWOCMS/fLaHxsQuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jYes4eMXhRr92kjdVgccx+y9tEC7xLjTFAqJmxrZF8=;
 b=k9XQ1CPnN9sc4SGaJXfQedbt6GZIbmpJC3pVfjNm2rEvEDC1af5qm9+z41Gq3XGs19tKkuOXHaYXhfCU5ODvOCUZvXYyArul0QG/pL5ztj4jCwNlsTxT3bC2mQ90fBpkkAZ8qU+M44IinbdNpQKoEItopPZwZy2ZwnkjOFSp3z0FSbfAD2Sui2teb1Bivk/1/sPg9eSj7jkDWhp16hEDornNNm/2ibqCD8v013F4GCvExdqbBy+akPjle7tW5iq7w2SIn204vsADGnNiMVKGkeoCPnCFcQClv9xfdfYoFiuBnLmNck3wauODHVq5TejRP/pAowi6bn9ajoGE4TBLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jYes4eMXhRr92kjdVgccx+y9tEC7xLjTFAqJmxrZF8=;
 b=v3Ul3Wy3j+sfIQWfHmAolloXLsrOC5qyRATPAXQwRcnheu83eVeyK2EOIAdzFSrgR1YkifEqku3Mlzc/IiRccZ2Vu14wNPM/bkVOhzOF/OsN1jqnbYJqndgtBkmu3axjSgixC+q8Ryxx1FUMZXuZELsXefT8Oi46kYzCIi7lXt4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 16 Dec
 2024 18:14:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:13 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 4/9] btrfs: handle value associated with raid1 balancing parameter
Date: Tue, 17 Dec 2024 02:13:12 +0800
Message-ID: <693ce8f83742af1fe22cf6adfc819379bdd275b8.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c0e674-f43e-4471-2717-08dd1dfd71d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AQqSnLdLPTFpPnAHGAwiNCCTZHiMl+MAlwyCSTxNmggSvzdheTFWya+3V59?=
 =?us-ascii?Q?QjXcu949n3YdWKO9sqxdK00GL3ONuRw6hCcYOwJCOaUp3iGozNrBdOwkEw6H?=
 =?us-ascii?Q?13a84Js6EqUJqy5W3yak49sNZ8qrtVj1Y52zMqRGOs03U7KtQK3f9ZRQvYvS?=
 =?us-ascii?Q?XU4xUEaiFglKk/CQcQTsisny4fDwrXdtHEsnUUNqZg30RdI27jw2wToOWyPi?=
 =?us-ascii?Q?jTSY5Vc3yZn+0W6/RBi5X11RVsh7xpXLNmgG60BgRA1Oda9e1vY+l+rqYKJs?=
 =?us-ascii?Q?mO153N7MYEvTERY78vDXzcVgY8EelkSl2Xl9VGbB4vKB0bUabiADix0BVYhQ?=
 =?us-ascii?Q?D1dedVlhicXx8CfWzlRnSP5/McxYEZMWVWSCjZlPiGP1jfx4XZhccsMUP4vI?=
 =?us-ascii?Q?aT8gzitSb5xl8AyfSguKXw3MvokZc3qx2390jvwMYtqbWJmNV3GU/TRXLh5Z?=
 =?us-ascii?Q?4qAgpsaeGYLT58AAwMYeFymza08uMea30cUqktvwMe0Sy5QxxxD7Y8ZdCv+/?=
 =?us-ascii?Q?qWBsrU0mc+pC1g0WFyNqqe7+Cy5OLkwUmFfm42H4lx+L+i6lHo/UEwrMIuY1?=
 =?us-ascii?Q?aHkEmyjI64C8z7Xk1H+erd/wJzRBsg0FHgnpAnllJ0lNX5WYH67Owt0QbmRk?=
 =?us-ascii?Q?ZFRtUYbhX8MGeR0MaUGBt10nYCnr8JDLjSHCvL4CvRKOs54weRZTkuiZOdx+?=
 =?us-ascii?Q?Bv2rtOIkgMhD3XvpuihLijfe8HB9XPT369WH62mS7dBZxH/TvblZzOPlz2vQ?=
 =?us-ascii?Q?yAAbZsX/0tTtUgDhAVVUugWuRgBRAVjioNi+gAswZ58+3tjWrL/ePOM/pfHz?=
 =?us-ascii?Q?MYDOdn7iuQo2NAZxhtQBUoiFCaBt3jLZw8aUxjCkB1f83/cK2Nvq5g+PUStb?=
 =?us-ascii?Q?PvQZIxz+dcAmdZEw7dbiwgSQPcg/jjF7Ag3oOSScvVVYkRpypPSBBB7gPKsM?=
 =?us-ascii?Q?kPpjL8yIKpyDvW8zvWWsXUcnMEIQZIIPH0Wf9uyVJ3svrWsAQg1YeaueCC6l?=
 =?us-ascii?Q?P+ja1vhfgvDPLxm7Q33TpnYNdJZw3bgmMRqOaSreq4xvm0+fySvNr2tvSNxN?=
 =?us-ascii?Q?yJhyZ36PGaFkKyUNsPwI9AoJyU0H/mHUNxQe2X7Sy8U0Abl0qmCN6uTxfRla?=
 =?us-ascii?Q?y8cTEP/05xlnxSekm5GNFK98/yc4s7dmEdDnLR6LaC8O4lP2JMGlvevQccJE?=
 =?us-ascii?Q?cdrYAgUmZ6/+x9khnS+9g0/zDVGfGl7kqv3qxptEEGjLHvTTx61HqBgazQvg?=
 =?us-ascii?Q?iHgC5CLz/hh7HrZI309h0W8zrQIzRhbsqAuBXxsrohIb1B3i9DwgjRchLZV0?=
 =?us-ascii?Q?YRNGrT7hCDpCfCHM8Xin1WbuiX8Ei2+4eMfy7jCYoKD/qfiqvlagrF248ruj?=
 =?us-ascii?Q?4lCBy9OIyHYO26VgkLYv7dOtWXac?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wd/nHTVUkS8naiZrxUYqmA24ej3+9aAkrLsloYZN43gAPXxKmTpvWyEvK5bO?=
 =?us-ascii?Q?Of51LDv24VPI5U2/GgIiLeY3r8OCLM4K4kntceOmQc/Nc2Wm/8IeXxu44LxA?=
 =?us-ascii?Q?fh+TxGG7X/0TdLhxPaKPOV0lK/m6goDoC88WE/Z5/tpfU6cjaxc6VpS/McTf?=
 =?us-ascii?Q?PRJHy6rP/C2h5iWjcw/Ut6fLHXhFlux1ERC4Y4E4K25ax73Zm5O8if1JAdXw?=
 =?us-ascii?Q?q7Kxrf3cBhrbjtcqessYyghHwZCMYLzKDQ9Qw0eL0vA21D7ZPPhpxC33ppek?=
 =?us-ascii?Q?x1Rj9+/Gzf+OKTFhAkeJCceTZKlPL2IIl7kkz+NZwPJRDmk11PHM2zW1eSVZ?=
 =?us-ascii?Q?/nLVaxvUM8U0ZSRdTnmTNhBRQJN6ifZhGwjKhbQmnb14fJlH3pRsa26izJke?=
 =?us-ascii?Q?Yk20LbJcOfHtlqlpUdAujaH4u9y40j8H+EWBOOGv/9DyqdILf/B4C7s/Ia8h?=
 =?us-ascii?Q?TYDSGmwMzIoy7LGMSUIMynVn/vAExeBfcOiEy7GarhIg+f9Y8gjSvV/cR2S8?=
 =?us-ascii?Q?jnDtqIqGtM7WBVe9bPUL30DvKSkeT7ErtU+y1OVCLvcJm9TOMN81rXRrqZUt?=
 =?us-ascii?Q?Cxan+FlIJpRsO3W8m9wdsDDx1zVGTPxzbrSc2Smi972Gv8gns+QvmwXI5kDB?=
 =?us-ascii?Q?bvdw5J0qys0kuj4zX8iiLtUG36D62oYhHOmOShDeGNkZhC1AG+XGBrLGXaFh?=
 =?us-ascii?Q?bHJyauBB8VmdVobkEb1AZ9kzwZ1zJwLC/QiggsqPjGqjZ39FhsrRLAH22InJ?=
 =?us-ascii?Q?0ncizBWR37zSm3UXQykDap9IWHnC18qBx0YWyL+wY5WNXDU1qmGNZ/BAGGFQ?=
 =?us-ascii?Q?1Vb7NCwW3JyrloCjyRF9j9+HgpeAomY+BfAVS71HeQpRZKf8iw/ukWa4oEOo?=
 =?us-ascii?Q?G32YyQPdXrd5TPCEETJDFu5vTiu/iw/9ndDO2cZTNMKvOybkMsTww6GCeCWG?=
 =?us-ascii?Q?Ov7UNlPZYg5wTpAWB+DdAOaPA9oR8ZTQ4saNAPXWZBkvDOPwb1KVtxQPTYcp?=
 =?us-ascii?Q?rTut6LtVrXh1O2fpHhLodwCGbSBBJceRiQXYW+/1VEF8in1l7gqzOlCljc3e?=
 =?us-ascii?Q?lRS/I8I7DWNXkTi60fjq2BtgoAjWvQfKesWZn4+KKy/o7fW8RtLCEXuFEmgd?=
 =?us-ascii?Q?ksKT+RnUKomPnCSFYkxP2fXg2NknnumBm73oN07ZK3KKLYuOnDRdiaHNgjoI?=
 =?us-ascii?Q?fzB2J4ZC9d8Jy7pKvN4sH4tBXl/WzWHl2Y5JsYTwMhxJyTr7dNrntQxhw/8x?=
 =?us-ascii?Q?C3HYpEyH47YxrmBe9HXnKYV+/+6H3ztUTGVtB3VMvbrMaW5920+2ZfRWRyC4?=
 =?us-ascii?Q?A86dXwzX0I3lWRPxxd+xMmi0JWS4lqb7eRPMuPa2RGW14rU1KBqeQUVKT0A+?=
 =?us-ascii?Q?AC7ufwOJ5PEG4Qg18eDXayt4DW1icc8PQB207oNVGhzxVEEwUwkytZOpommR?=
 =?us-ascii?Q?5wWlN2yNWkNsAtcgn305mTF/QO/t3H217mePr1VccLESldXvnPt1Im/5bvg8?=
 =?us-ascii?Q?1hPnRUJ+awRIYe7ZHb0N7Akl/5UYSIiPUkFA0p+Q8EGf8u1/DgMOpzqc43ic?=
 =?us-ascii?Q?/YJjNzd5RYGsxqqNGT6olHqQDwjmFxXJY34M06I4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tFN/TUSPIejAQv4qcxVjx7ExFpUcbG8eEnL+EdQRrhm5/Xldt2NmDixgfP6gGm49FQ7wp4sO86VYz9gpJm/2hMgnF5MjF7aBazf1bqCl8weQILTK4X2UOyQzNY8Ra11UY4pJc3U9sCAhQD03+WKtMa+lHwvJmtR+HNUlAYlDv827ROzc1zeOwL1WVThWsrAnWXif1peHaOClTm6Xnf6X9xZlWa8nJNEgQEHcoBQn1iA5i6teYkBFLwWZ4z6O2bWaw1Kk5M643qdMhzib5xux+PPsrNjAKyN4LvTU8eAP5QuNmqfapi5B3sV1jWTFWuvNkeB7ZkX5qLJ9sntw07qjYmjUn+nghuvWcd7MQu5QEDDz/1S7h9KWIk6+jphMnWKKrhUyqRSLhvroCQJC8hCXHUnrqxYMubNCdfnj5ZjiwbvJZNbtby5/Tqslk4+Vh4gtWf2ZZMarDfujRv0IqyAYwK55ptjmPON/C2fMW9Uau1uauTDTgK0i3klZIBTvNq4+P2i/c7SDXPLVMk1tpyCBW79ouB/yajjVYTCzv55iGwS9wCnPyEggQmtIBHzErJ3xwZwI9/2TnfaUTMHZaywYX1gyq3yUBx4eTiIpNRvpZMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c0e674-f43e-4471-2717-08dd1dfd71d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:13.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ey3/3uGv4GFcMMf2+RxFXjzmCmSDeknyuvMeRyZ3KYy7M0rT+Pho5limAHR4ftr42dGZNsFByZp0RMJIpZA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: v6MndPaJOlZMdiSCtEigtUecbkKv_NNz
X-Proofpoint-ORIG-GUID: v6MndPaJOlZMdiSCtEigtUecbkKv_NNz

This change enables specifying additional configuration values alongside
the raid1 balancing / read policy in a single input string.

Updated btrfs_read_policy_to_enum() to parse and handle a value associated
with the policy in the format `policy:value`, the value part if present is
converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
the new parameter.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 34903e5bf8d0..9c7bedf974d2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,9 +1307,10 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
-static int btrfs_read_policy_to_enum(const char *str)
+static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
 	char param[32] = {'\0'};
+	char *__maybe_unused value_str;
 	int index;
 	bool found = false;
 
@@ -1318,6 +1319,16 @@ static int btrfs_read_policy_to_enum(const char *str)
 
 	strcpy(param, str);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Separate value from input in policy:value format. */
+	if ((value_str = strchr(param, ':'))) {
+		*value_str = '\0';
+		value_str++;
+		if (value && kstrtou64(value_str, 10, value) != 0)
+			return -EINVAL;
+	}
+#endif
+
 	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
 		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
 			found = true;
@@ -1363,8 +1374,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
 	int index;
+	s64 value = -1;
 
-	index = btrfs_read_policy_to_enum(buf);
+	index = btrfs_read_policy_to_enum(buf, &value);
 	if (index == -EINVAL)
 		return -EINVAL;
 
-- 
2.47.0


