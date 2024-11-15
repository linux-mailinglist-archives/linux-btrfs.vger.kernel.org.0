Return-Path: <linux-btrfs+bounces-9705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D69CEE95
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852F21F25273
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A61D5168;
	Fri, 15 Nov 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAu8el4e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dDuc6v8A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D416F282;
	Fri, 15 Nov 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684073; cv=fail; b=t3OpqJKrkBY6vwcfCgSjOLSvUnbM23mvlr2ruaZLYzP6ViKtbY0xkRIXyGAvgb0tfQUXqEh/iPs4RBV0ctbABzngCk4wclu6B81pT9wyMRUFCqy/6XQqtiRMZ3w/K0mFb2Rq2EBJAvJcA6TVRksgzFd5d3P4W0g5GB+lSg+E7gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684073; c=relaxed/simple;
	bh=ZlDzPChmxakbnLPjmR2s+ZtMWzA5H+4BE3ShnQYj4wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASqWaaDZJW+pQCB1DTaH33WyqL14n40TJebI7IpdaVpe6LhDSctPCMFdfoFyrIjZ2LRh/0Bus/Gbn1+qXm48WpPqEpUVneys+AzTocrX7Jsc5/cAVRN6wQ5P7PP7869Akra9qKyw6g34GSTOEeA+7Z00Lgy/2kZjR1atnm/4jQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAu8el4e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dDuc6v8A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCStq020915;
	Fri, 15 Nov 2024 15:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ce+xIE5LSVTicZqNAbVtAJULzkfJ9phOkgT/ogyacXQ=; b=
	HAu8el4ellR3+6y72A73/H9qFbc0R3kxr840RGrrv6Y3kVT5mHCQCw2+6lIOqddW
	TJYIvJvm4JBucRyUwywRSvpTlhZOYfhvxo45YuqiQ8X/+XE6qqcm/bUJfyxyLWxf
	lRxSicNeC96zsFSXX1msRltkcM2eES1JaU1lhp79gut35CFHJT2bmvklQd5ho4yn
	bKmLaAqo1tvYYd99j845XJO41eU/Fg38BpkmXWRVXNyJBulrVzLpQpOpbEY/Xs9W
	PNKYP0Y5NLAs8j/F/sgP696AGH3IbRx2RB7yhUpMY41RvodJdMxa828O5BUBQ8OZ
	s/taY+dnLTSm+kRTPLU3Cw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3pqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEhTHo025867;
	Fri, 15 Nov 2024 15:21:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6cb620-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 15:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1O0ba8K2Bjg1MA6jwubV6TpsmcfHWJofG4EWA0pZe5xkltPERX2ezKPPXZ4WrJ3+hFYRxidxgTYqPHBXCjJKnT//mXvqVhUEwjOLjUI2de20F6KUvnf8aU5b+JZ9IkEjuLUpRKyOF/XbUwx3B5ZdaBvDFz5twC6kitw/zbzIbnGuHWonvzJoy0oZ3r+YY3MCx37YkvNYQY3oievT0ZLKU3m2EhKPna1Xh64rZFC5Qkuy1iZNIL4/DwEQw+B2BUMyOei0XWnQ2Nrd0SfD/lstPHVhBGIpmUoR6sKBwoUhDjHu02elEqU8Um2ILBkXo7tuHMltdMD6KQq+SjtdWm4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce+xIE5LSVTicZqNAbVtAJULzkfJ9phOkgT/ogyacXQ=;
 b=Ww+TXQnbxR/BUgpq+u9FL9ZlLWnIWymrOT/rQ2wKdt0rc1/fz8QBv93OV3LW9lsr0JE2KAqVJlkbpMeA9AIjGOjWdDu1UZ/N0dTTrpAlYS7SK8E2HzqcdBiFjAA6EiusLv98LgMKFofZYAaNOYsc5r2e9mQ/QM+MNTkZlPNJTNVHfTYqs3B4f6p8qECcVt/wab4FyJnlQheawWKdJ7txT/hzHIGQVf2kQWNYLXzHGoF65OYUpCSNUfI0QMIcC80M9SiXAFBaGAjlSCC+WjeOHIg7xwdOsmuQiDbijBNzSxjVJoy6bvj9GdbP+LnUMTYR/ULeQja2MWAGvU00zPIpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce+xIE5LSVTicZqNAbVtAJULzkfJ9phOkgT/ogyacXQ=;
 b=dDuc6v8AOj+VrVT6jhrbbHCDEwkSJ4s267Hid3HiejkX+3xBUGyZ6rHJYfSBMpl/I/9EvtR0RFggCVO7z9ZljYXklHkENYBKB2frG8/y0k3U0hApqLArpRGUIUvRblgqEmsxGiYU+TU9Zc+HKBobniiMOXzl5LOhuZ8OFHX3vHQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH4PR10MB8100.namprd10.prod.outlook.com (2603:10b6:610:23b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 15:21:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:21:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: move fs-module reload to earlier in the run_section function
Date: Fri, 15 Nov 2024 23:20:51 +0800
Message-ID: <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731683116.git.anand.jain@oracle.com>
References: <cover.1731683116.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH4PR10MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 40eb6881-1199-466c-cdc3-08dd058920f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Z/spDBZOSGuU11K6YR0oEpHZKWq1aGtGKMk4MVIH6qjQHbo+lGAmSzhHD/k?=
 =?us-ascii?Q?RJvFkv7FwPNILPxpjHrdDge4CTVgbsmRk0gxqhO48sTnOUTt5c6/IICduYDT?=
 =?us-ascii?Q?jjym2XQXpvaEMYtZ5bZt3O0wwCNLPlStlnOrNKcpiPBF6lQrvPMgIoh1PMMm?=
 =?us-ascii?Q?JnTYXnhSodGKnr30HGpjgxbye+9O3LtGukYAC3fycr9UXzeq9pWqAbXxFi0m?=
 =?us-ascii?Q?116KqWkpwSwBRdMRAfYLXCKYEF7rr7rKfBbljARjYLd395TtQ2mr/k1gjCvg?=
 =?us-ascii?Q?8hdw9+K596MSe/PaaJ7rgEe9tgrpN6KzsrWn9t5lPnHArwHgcTH4bCh4fAuX?=
 =?us-ascii?Q?i5oE942yDjhLxg/COauu+XIkSbyr2AivxJiypl2cTwqTlGRpSXbGld0TbpJw?=
 =?us-ascii?Q?XDXNvCa2Fxd8BR/BuhMf7TbdJ5UAruhOewKYs2jc5Vd69oZgQx+HFcaksx3K?=
 =?us-ascii?Q?kY7SrN9E1xTdj/rnjcJo2ZS8UZ7Qry0VoVHP9i9NRA/F9ksshQ11oIHsZ3SC?=
 =?us-ascii?Q?2+aYhcVU46KhJrhzk8EINLZOnA6JxAiE5tLFTOL4W40WjV+i6GQoWvfeNo/y?=
 =?us-ascii?Q?Qhnhwo1ptF+aAaBiQi2mAPP36Ye6nIsrWNaECpc7jGFjIjkuqbPEkQogWkxW?=
 =?us-ascii?Q?ScuXLjJIZbxZ9kQ+it53J9kheZPXgvEIObPLiACCGH1dh2l2Bm1r3teunnc8?=
 =?us-ascii?Q?BVaXOM0UJ6+REpPgD/uUIhjT9OGwdaxqaVgIz5cR7FasERWsi8WUcZlPEQJ1?=
 =?us-ascii?Q?YG9wCADXsgvsgMlRI2y5ewwfGIwYgFnmT3e5kTQQ3tTxQyxhi36Y0No6xB5/?=
 =?us-ascii?Q?DcQWRUkZg++YuXgkKmUiveEnjVU65/F+Bgl247cHldimphBDCSDgsMZXogNm?=
 =?us-ascii?Q?9kg8dt6KKWC2myF5xiJ1Iu7t2YWQaKwCQLTFfLffHgSh660v+QY9azdJ61Fg?=
 =?us-ascii?Q?eztRlCnNVM03gPqcooivS+2dMmjtehr5Q6BXR84SQo/bFpUt0A0C3he2ODi/?=
 =?us-ascii?Q?FHLaqlwX52q3eeT177g96jmn80afLUy1KbdOGrrIz2cvNlPo+ylb3OGj+L5h?=
 =?us-ascii?Q?6NAE9j0vfULW8rPviQ820Lktq2X57QCPQHk7aCwUEVCOaa6/0o7KGNG2arn1?=
 =?us-ascii?Q?kMhhsxHEJOyTsJ36NvBGNWJedOceK595heymPRqznEDFf2XBAFp+A+yuiDV0?=
 =?us-ascii?Q?GhKc+5ahnANbmYiM4O5sM7dVK2t1EBUr6n42gLrIlQNyVmv5gj1LQIqeoMRg?=
 =?us-ascii?Q?nftJoZDXGh0fXJFrNA5H8Uj6SqmMog9VzHQQ1B4S2r0hsUj1mx17tVDiyQtU?=
 =?us-ascii?Q?TEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMsLx06UJzZV7eRKHon17Mjz9S4UPsSD45XniCLFYdpUyYDyNE0QYEis/JC6?=
 =?us-ascii?Q?EZiFh1et1tLNZZcnCzyHm2fPigzxnSRVCWMjbiBw+UdYtlRMnsy9oq8vjfTF?=
 =?us-ascii?Q?CPNpumhaTuqD9wyRTKcG2a2j2hAmTW6soKVPe7IxHhBNuN/8beSGfAYni6bn?=
 =?us-ascii?Q?+YlperI/7aFGr3nPtD09OH1kAe90/R+x6Fkj82WsBsicIc9Tf/o1oq7fFIrD?=
 =?us-ascii?Q?MseFalU6HP6o3aUkvCdpG+phteeYBAoFoL3ZZfRCndktqodAxwTbIyB15ub2?=
 =?us-ascii?Q?WVlUchnJqblFjUl8SNprvFVN7CkaA0X/81iaZXX/MoyFJ+jXeSIBtBCb07Oa?=
 =?us-ascii?Q?KLrxxzI7ZVdaFiQkRZ+/YGdVjhasniu75ETybk8xOJZPmTtL7oabrWWli6/K?=
 =?us-ascii?Q?ikRfrJg0u2tQyB9r3LN6GRN4XzMgQ7fvT1spNeLUgZeFKC74z4/YIXqQm1Y+?=
 =?us-ascii?Q?wI4irEt0Y5fF85nG8daG4jaSIkjmQGdjcC510oygbkjWSC/Zcu3nv8Nfzl4T?=
 =?us-ascii?Q?QZMZRYNL5IH/caa7lEsVHU6y2DuWZJdVkaehrGmphpuEVGSX9jbT0+UnQM6i?=
 =?us-ascii?Q?xIvIdX471UtG7IQKcJrKR/zM4cMoobwzb5ByHa30JyaTxj1+A0CZG96Wb+HL?=
 =?us-ascii?Q?VSbSyivXIkLhnQsFHKbqzoJATUFMbeSStOd+ywEypVxVdI/CjuJyO+drWUs6?=
 =?us-ascii?Q?yTdSp1ChYe5wjC1zpqEhKAyqzkPLk2DRYwQb9Q8yUmLylbNyu/WzKUjJ6YYb?=
 =?us-ascii?Q?MOVUo4JzzFnU1gqRg23G5M+gPdLgVApJEdDUa7uC3o9uDltxIy4VUm+xsrTO?=
 =?us-ascii?Q?rqubsqmk9RKw7VMtBLrt0XxZiHjTWYphlitoeD1uWGtSG6z4DBKYySeSX/o7?=
 =?us-ascii?Q?+iVBqn7b0FmEKnQnkVHwX598XJP2IDlVgceBvwjpidJmf3O2Oj7hG0ZqgMe2?=
 =?us-ascii?Q?Axk75cOfldMbLxQB6q4DcAVHWAZwHNK1HfoBvm254RROWdEJ1r5uoH5Qfnhn?=
 =?us-ascii?Q?+HFty505jb1SwuSDQg+ZrO0eKkDZuIR6a+zhZYzktNI7lMEDvL6nRHuCC53Y?=
 =?us-ascii?Q?RhZP7UY6Qi3V7HfrWgVhS0N4QznRhI05IK5XIDFumpbh0y2alq+oJ/O80Sko?=
 =?us-ascii?Q?PsE7ELXlIujf8Ot/yFCQDv9iKX3/ruiCybL8Lez5JwVoIjfVUlAU4X2iuPnn?=
 =?us-ascii?Q?Xz5q8n/ZACCZ7suqo6gZjdqnh52foLhoaNks6UbX+mX2yu55qrPEcvhFUa0w?=
 =?us-ascii?Q?j4Xk/gakxfy8hWe5OISEZUGyCadvS6xmc5giiXRGGJwJEPJ8L1VIx1R+q7yH?=
 =?us-ascii?Q?ZR0mMUflS4BBTJM1TnGbua33kJO6mWlm+5TMOTQ3aMULq39urDFQgMltdrYE?=
 =?us-ascii?Q?eldGSwU8rvsnU26nM0TqZspXt05rI/RJsvw+ZufHUkeNwhIt6nUOUE1YIhcm?=
 =?us-ascii?Q?CyUU4UJeGKbzxQvatFbbTG6dM1eF1kemTIAASLAZ0ph5BKAgLeS2FTtrJm3i?=
 =?us-ascii?Q?9Bc9vxlD+hyOhCXuGG1yKgQyS7ZTKqiQwmvW3W01F5GNTXbwbqBO7h0l8C1x?=
 =?us-ascii?Q?reLi5709Lh5v58buwWdUbxodpLo22DLtheo4upHt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	plEwcxc7KO+amZ5aTyJwZI4werGbb/lVLOKRRIl+vMwQ0hJQ24mL8G69VhXzWtwsL3w7LU1k72UIxrsFzEsxe+mv0LAZAVeiukj4iqJlQwwQEA0VESbymkfhxiLTP2GLnEpM8Y5EeKsCLxu4wpRoLGVCydnDHbMAM26hKtetl1yfDCXLdqINiAaRh6n9/DBeKjg/kZo/EbY3zm6SyXIXQ0RCdFtJ248VTOrDBzPaHTFCkvzvcxv1rl/yXsDfDxqhdeJihW5PMskP79oNvCJQasq2CM0FCPJkF4Sl050UIO4/S/sa1sAXYSv9yHdqhknjX+6j+osOliOg9/Z9CW1dgW9rBTTwuaTvXTPMlI3QE9ImcTKWCmoMEzVmIDR5TsTS+N8mWnmRio0t93/rWVLqGN519H70vuUiN+YDgdPWKs45Mli3nDIntbFOhpbBwGhcQqJw/cbv95jkVGTuovC6tzFjeeB0zvNvQI0bYrTsku+wbsK+Fn2UNlN7tDNP2ML4noxawTxVPpXdNQbcjv53QL+QJrREb3gufhv6ri8+wDGjgWgVwpm/Kd/CyvK+jSXXhYWBPqU3EAmWA+TTMoPH7dihXThNPoaIqrAdeR8o030=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eb6881-1199-466c-cdc3-08dd058920f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:21:08.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDVpvjxVeNY++dv4nc+vUjcp7jvlMoKqO2CgLLCbgR9vBoEmyEc3+vBeUKeUlEVRbDbOuFe0NJadedixz3chhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150130
X-Proofpoint-GUID: mU-agI-2NbLR-JBCjxF-AFTMjaXBmZmz
X-Proofpoint-ORIG-GUID: mU-agI-2NbLR-JBCjxF-AFTMjaXBmZmz

Reload the module before each test, instead of later in run_section.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 check | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/check b/check
index 9222cd7e4f81..d8ee73f48c77 100755
--- a/check
+++ b/check
@@ -935,6 +935,15 @@ function run_section()
 			continue
 		fi
 
+		# Reload the module after each test to check for leaks or
+		# other problems.
+		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
+			_test_unmount 2> /dev/null
+			_scratch_unmount 2> /dev/null
+			modprobe -r fs-$FSTYP
+			modprobe fs-$FSTYP
+		fi
+
 		# record that we really tried to run this test.
 		if ((!${#loop_status[*]})); then
 			try+=("$seqnum")
@@ -1033,15 +1042,6 @@ function run_section()
 			done
 		fi
 
-		# Reload the module after each test to check for leaks or
-		# other problems.
-		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
-			_test_unmount 2> /dev/null
-			_scratch_unmount 2> /dev/null
-			modprobe -r fs-$FSTYP
-			modprobe fs-$FSTYP
-		fi
-
 		# Scan for memory leaks after every test so that associating
 		# a leak to a particular test will be as accurate as possible.
 		_check_kmemleak || tc_status="fail"
-- 
2.46.1


