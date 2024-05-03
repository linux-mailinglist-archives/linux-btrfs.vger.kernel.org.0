Return-Path: <linux-btrfs+bounces-4714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625BB8BA978
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6953B1C22577
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0E14EC7A;
	Fri,  3 May 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGVB4MEy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gOORCO4L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092461C695
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727383; cv=fail; b=Etz/DeW9NUs6WzVhMJ/Mj5FSHo80furrGJ3y7dZqMtwlouUkDv2JJfwF84GeqnX5zAVbjfvDwnbWeSKKAvbrIZi5TOk2RQ2+PsxeD+dweeo3mArdIljL+FkH2pGBbpEITk01Xj7Ha9QJOHFYrbogQI7gR9l1POpHiNJu+X6aKbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727383; c=relaxed/simple;
	bh=yRdFkBFBg9qmVXSAXJbJ0/YudlQTVlV+RLFXEb6EOuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGZTMuqhuYGwzS0sYFJGMzmYP+MzBzevvVgSjkUrwmIuRY9dKoozha9X/h7dUHAscOhKB77nIv3P215IVtSYS3wf3LNvF0yLk8GiRK2jas46nbR+wjjx5tcBve2O8q1wnh/d6f2c5tALUSK/C7I+J4WS8HCM0NvmG+orktHYIwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eGVB4MEy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gOORCO4L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436i9Tn002060
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-11-20;
 bh=np/fUnX940jZt346gPctc6PaSkbIuO/tp69i6QaOCvk=;
 b=eGVB4MEy2rkJ4SbtzuOoC3d4j8wZx3/Ahm2hgX7Vee+MPfXQvLCbdWrR/lvxOe8RBZVj
 qmgLZR/dsfnrisKhxrlib6w3dboTAcWJ0xBZFZAaZSDKbEuy0sv1dOTjmLpV7YWc9rss
 irxEze1hqAof//eTMXfqlZHIGaniyoy49yq/UOChiRur4wsk2EN6357Z2OlYFAsTZdqa
 BQdSZSEhaZi6szgcNjmrkzxg1EvHEtJpYjb/sXKc4VQ3T19CnylM59Djs8FA9GI+jdf5
 dZMk04duDuGs+xIGpLd1jX3twaNF8rknm3ODKRDJpZyU1FSiFzuMlkfaY5T52I1olOx8 ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy382bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438H4FU034735
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbuum2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l13gIQDyOyLlNwkpzBAupItabwC82EdsZU2hsyDDrm+gMdN8hlKcmguN32Q1DhBIxx7SnO8zXI0VMS6xAh86XIbmA5Ow5XXO9dbqxPH45uzAWUNSaflNk3oSXX8T3ZQJdvmIgEb5BO9DAX8NGab8amikGzH2BhfDEEv9OLpODhBKl9S/vSZQWduTZsBelYmGwRGntYf9yhzp78IIy6gWQpLe07CirxtrKfZTftyimHE/4XwgVC1ZLElJO+ju7F5P2dddmJ2Ur1pjhtDPS/zqxJJ8ih0XMeoHQTjtnpT/R762RU3qhyZH/QqnTR8l3jcMbdlh95l68u2BK/dVBZm8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np/fUnX940jZt346gPctc6PaSkbIuO/tp69i6QaOCvk=;
 b=dIcvHkubu7+xe/Fj1wuIxXjS8scHnudoXum+l16uc5yYqgPaj1cxcC9FSeagvRYaGyRdatzIKH8mqrhd6jLed3nJf/K74QWwAmloFYTUyQWXHwF/C8rHuXVRqrPlJ5fJXfSWpl/9afjtzAygoELcMtJUUqbYSUXpiQAq3WDaaadTTDJjc5rubeyELzcZh4bdY6g80GPA/vK/qI7J9AUPazgT7Yo+DC/093RVeYmdxjCZmFS0OkAZ0vYLI+PMLfj70TTJruSCGrbAHLOBYORXrefSgMNdEAu5RNRSLY3cyIMh+dtsocHRn3d7T8aZd8ZGxUfgO7xsGaBYr79nrnmahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np/fUnX940jZt346gPctc6PaSkbIuO/tp69i6QaOCvk=;
 b=gOORCO4LufoW9lagWcg66UZnVRGHxmjVSY+eH4O9hM2oAOK9jQIK2gH1m6U387jZRV/T+K0akTJx6HyRuoKrN5yTuIlx5lvWWbNjCLtpXw54c1A45w3FCZYoC08j3eZ3gVCxgsfqxRzcuXeUxlNNvreZ7GHFDfrWHBlFuylsbQI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:09:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 09:09:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file inode pointers
Date: Fri,  3 May 2024 17:08:53 +0800
Message-ID: <df071a4eaaf83d9474449f281ba8b1f905922744.1714722726.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714722726.git.anand.jain@oracle.com>
References: <cover.1714722726.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 933d0b4a-1317-410f-f4a8-08dc6b50bfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?A+6KwqHNwMekRAV7lPyVTX14EWX40XyYESUdnsCAKIoUtRzF+5+N1o4RWjF1?=
 =?us-ascii?Q?JtpQote5wOvNoyOIYZUz44XTb89Dw+k7Pq65gDAHi9QViDOdrsNSV+9RYZgw?=
 =?us-ascii?Q?Vdj9NBkV/yMi+/JQuU80zEqRXOR0lgYqUDmU0lU3m84PUASb6D7qknvFS/eO?=
 =?us-ascii?Q?vNCpP9CaQ3Gx6eQ7zkZPgOgiMbOSD2xgVxezGr/l4+XJx9XOj56B5NTu01em?=
 =?us-ascii?Q?Cvqvj94Yyx91jsguacVA83TK+UGjr19Sx3WCEj69kjedx/05cIJWq8n/Cwgm?=
 =?us-ascii?Q?WzzP2CzMJgPzouxh3azY7Jj6asvl5YaWenWXGVgOM36giRbWlOAEeIB34aMa?=
 =?us-ascii?Q?74xVm35ETfaDQcWJvUntqkSpqJNeJrlh3mdC+KkJniEiFfU9A0CtrhKdiTsy?=
 =?us-ascii?Q?9Xl7Q+1LbLsbYQWLwDkZ6gPKU0sTQDSdkrKJREdnzmJ8/ORRK+apuc2k3PG0?=
 =?us-ascii?Q?zlbCcOaEkwXqSkCrTBWO5uecjvRwSlqUy9BQdp4PUB2VZNLzc8iSth//VQiv?=
 =?us-ascii?Q?BVvCHMEsirTq7RFOUhLHecCKrBYP1PDd5eZGC1khKL2UGfKwaI/lKpiEEBZL?=
 =?us-ascii?Q?gFzdgyQpZNx4vJFhSD609g85wHmhubL25EgPaCiw/mWP6yC2n7yR9RQytxt4?=
 =?us-ascii?Q?2Ehczg7Q9mWhgMiJsrgYzoBRmt1x4rJUQ64vv40O1nmrXI0q8XK8NXdcUZIo?=
 =?us-ascii?Q?s+Z+SA9EcSnz8ordFyMFdxfSkGmWTg1or6dEA/NTgFJFi5BpFtonarlx3aXr?=
 =?us-ascii?Q?kbPdQymhvvOVK7K6PmJNoVcNl/3FHoFwDXSKzodKGx9l6ky5t907r3PR14o7?=
 =?us-ascii?Q?5D4E/KG2uLS5Y8d8e1BNBtrwMs9C6qJm602aN6LbVrEnMC2gwQWGJyzkscTz?=
 =?us-ascii?Q?9zmBwNyKOo2FVVp3SvcBa35nZgXsABGvzE7dIfsNZ1nu3l5COrxu+txjzgQj?=
 =?us-ascii?Q?QeEEmBPYaPTXQWRTymKRjufJCWT6Q5aMbxptf3wBjDygc5FIzeImXijnvTgy?=
 =?us-ascii?Q?uFV0miPazoF5VJgcmiATenCG+nm6PcLcgkabtHtDUCNKpcyveBA0uaVm+Q0N?=
 =?us-ascii?Q?OnaOsMS86fACqYXAEtS9AxC/sEd6iWAObAmYlJyqHibH6pUq6opyWpfX8Mrj?=
 =?us-ascii?Q?tyTLkNtE744ZV8PyPI0h0qJ0mNpVgHhoYEP0AHPG/r8pQrpmHlUIp0Gu1/Ah?=
 =?us-ascii?Q?8nIkqxIldhW8gWajlDe7iQuD1GuajDKSXOZhZM8r1LQ9Vkn6HtsDwjUTiU9n?=
 =?us-ascii?Q?PMYzZFJjtD8LeepAoQkuZpHsGoG3epMjqeYHTdVLEQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ak6+ROLFLPppCnLtoxeDBKZvYdZGfErIalGg5WtlxzcWdSaE9t3rhgeP1kjV?=
 =?us-ascii?Q?AVqzQ7qkUL/k8mE26T0UkOtgbfjxtiBr+sKoe3KV7umjNL+nFN/lo4xSgcQZ?=
 =?us-ascii?Q?6+hf90hf5SANOmiVh8gWzFyQzTyBrhuoTyv2+UL2B4PR9fFZInSP0lWoOYCU?=
 =?us-ascii?Q?JIDoiLWsPwiXE4eIMov/4vNx+aGHA4mMKb7N+3RRqMiPDXEtrvH/r4houGfH?=
 =?us-ascii?Q?VV1OpSdl8lbbYdvxzBbZ3IfkaTY58KaVIcEhfnawR5q2mP2yHKqKWlHhO6iZ?=
 =?us-ascii?Q?0/hySTZsGkmObXI1QdiJdxQxkAedP6At+SGugWJSRoNdgwojCJiGFgIkxCoB?=
 =?us-ascii?Q?rn0Zi+FEAYIBu5w1Kef1UKiEQtQa22HAXWvpGJ6DV/KBxVcmpSXvw4/+XJxq?=
 =?us-ascii?Q?jiqG7Wk0dwg9itmDqhf+tec/9sigzBNlkTb6/sS0H4+DMagM5nvq1OdUgUoe?=
 =?us-ascii?Q?uel2W89edtRQuNHqMueLp2OfHiZc7VNE6AiQAX+7H+Ud3VW2kubDy2uv+lo7?=
 =?us-ascii?Q?j+HGvcgA1QLkLOsKWG1SIb5viBdBZfbalWGczz8krd9XUUrIppUPYjlyLPlp?=
 =?us-ascii?Q?3xO7MiHJis7FtCIAN4w6V/XTcOMEXe7Ocej/DPF2TFgNmupqps8XNNZJUOrf?=
 =?us-ascii?Q?qOObfgMSaDe0UFujmwAIzBbiG8a+kOkzu2qxSki8RigeJY7Th5oDW6vYveGi?=
 =?us-ascii?Q?1HKbOWi3yZiv6bbY5CHxFNMKLFOUZt/V15JEvHdBYkC+ZAxI78h+8L/BOBcX?=
 =?us-ascii?Q?S6akpLTjhzD7TGJ/A81vbeTC3wgeEa+lJJjSqOiZVEHYiVy+dlk4s+VF5ido?=
 =?us-ascii?Q?asesKeeNT2J1OWQJicMuR9/CFJlkNDqtpy5MDnJKaAXzC6W7lo5ZeEFQtKcV?=
 =?us-ascii?Q?gvesjd1q+ClLaw+OEh1rU1roTKyaw5AFhelu9XDM6mZyKG9EYIJE7bgCxpjz?=
 =?us-ascii?Q?J7JsqoUh1SK60BfpkpgDkEjZMboMg1ezLcv3agn41M0ujaGGctyX9BtNdnk/?=
 =?us-ascii?Q?+pAe5UqczRrkDYfGwiXfUt8i4iu9aGJlGgB5oTQnDPPGRwQ+soOkTPVS+hdP?=
 =?us-ascii?Q?xxP/MZG/PPVyLm+qfcYuJ22QjbYUwNz1qF3eev360790J/0xd92WKBOunbbE?=
 =?us-ascii?Q?um9OzNs1D2ubW2Bcp2ddWTEt/hrO9ICW9RA86YQ3yeyunDDGclHrzpdl/j7q?=
 =?us-ascii?Q?E7etw9Pye+BbX3ut8sFTOaKlVeGlynwSQwiEUxZjbSfzqFJEofYl16kb9p97?=
 =?us-ascii?Q?5dbGDBi6w4JMo+LNK1uSNW0+rwi78/qeyVq0x8nzQU6iDKXZ2S0Om+vlkD5X?=
 =?us-ascii?Q?hYzwF2sKMBPAtNtQKZ/aT1JGw9kKhA7Dww91RTP1oS1Zp0iCITpHB6kLE3CH?=
 =?us-ascii?Q?fAJlQKW4/HSKZapxHnx/Ff44ydtdg39lHW/2Mw9LpVg/il+8ysf8E5O0f4JP?=
 =?us-ascii?Q?YhWCwdLzvEaXIRhHxtoQ5iInVlu1UAiKZLJ9tAshRERtSxOq87FMyZMX4Pbt?=
 =?us-ascii?Q?LYy7QUisAfZr0fkfxWGOuhbqyRYuAjivnv9hDy7uKvIpg0o6l4zSUdShIsZE?=
 =?us-ascii?Q?RwkX6+hAE83I21kM165awtCGMYLDA+6Xui+Rtp6pwZYqwm9l4RCzXiJj32TW?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mH9us7dQ+JWs4z6q9ui1bPRbJTaNbqzjVxhdt4uykPAuxDomtzP99M1GFuvb2B2by12kQD691QVrEqcwK4CxIAvYMtmdXhM0A7xwGXi4ahlKFhf1QQ78u/oNaCEDv8iIXYiJ/UclNRXOJOQiLBLjvHGCGg0mtElk8q7Qu04vLPDkfntckXMNxIqoUNEYPYIEktX+fkmAuXWikjJfIRdXbwxUgLLmYpAo9MJgQoySpJKjag9qeJxrwrpX090HX1tkdESAUltImgt2XbNFxUJHHiVOOHBFajHJuMjvg7ZLQfvXrCrgs37QlqUCzOg7uT9Z+X1WW9ehn2EmCh0H2yq7cabPg2F/5hX4Nerd5996yJEs88oaUw8l3N6jL0N51VYnAsyxRiOCZfYj5vQh2ZGy6FEVUhRBagWjZX6gF/LEh3BhOXOEkYXtNb59PHfAoIUYpO+BVujAaPX/XrDstcYacsT0bb7UVKeXjgxmBhBwu1dYpgXpBpF5RHUX4V3E1Tep9Jye3Y2NiRASfGNVtEErdi8oy0vJ5E9JEmtG3FV7nvhLer42X57B1nDmcjeDP3RjIMOgEQvkBFVBrBFWs6JLPQUqb+Xbu32zRaW2oDzneEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933d0b4a-1317-410f-f4a8-08dc6b50bfd2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:09:34.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT50aoF9IEVNYelxmZRUi0o3GB2NedJL1weg40aoTKTFlD5miDjGEXR4RK3Xr+L2xJW3oNbaVPQNYkUK8MEKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030065
X-Proofpoint-ORIG-GUID: GpLTf4y8ToAgyw4Rpxkq2JHz_ddWTliK
X-Proofpoint-GUID: GpLTf4y8ToAgyw4Rpxkq2JHz_ddWTliK

To obtain the file data extent flags, we require the use of ext2 helper
functions, pass these pointer in the 'struct blk_iterate_data'. However,
this struct is a common function across both 'reiserfs' and 'ext4'
filesystems. Since there is no further development on 'convert-reiserfs',
this patch avoids creating a mess which won't be used.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 convert/source-ext2.c | 4 ++++
 convert/source-fs.h   | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index a3f61bb01171..625387e95857 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -324,6 +324,10 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
 			convert_flags & CONVERT_FLAG_DATACSUM);
 
+	data.ext2_fs = ext2_fs;
+	data.ext2_ino = ext2_ino;
+	data.ext2_inode = ext2_inode;
+
 	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
 				    NULL, ext2_block_iterate_proc, &data);
 	if (err)
diff --git a/convert/source-fs.h b/convert/source-fs.h
index b26e1842941d..0e71e79eddcc 100644
--- a/convert/source-fs.h
+++ b/convert/source-fs.h
@@ -20,6 +20,7 @@
 #include "kerncompat.h"
 #include <sys/types.h>
 #include <pthread.h>
+#include <ext2fs/ext2fs.h>
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "convert/common.h"
 
@@ -118,6 +119,10 @@ struct btrfs_convert_operations {
 };
 
 struct blk_iterate_data {
+	ext2_filsys ext2_fs;
+	struct ext2_inode *ext2_inode;
+	ext2_ino_t ext2_ino;
+
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
 	struct btrfs_root *convert_root;
-- 
2.39.3


