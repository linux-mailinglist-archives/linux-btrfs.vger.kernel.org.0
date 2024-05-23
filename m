Return-Path: <linux-btrfs+bounces-5244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 817128CCF78
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC369B21E53
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B513D293;
	Thu, 23 May 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqfTaT/A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PVW0xqtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD304685
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457248; cv=fail; b=Y9QK8zvzPRM1WvvViyP25du1gIrLYsBbgOQKAgSftEGSuSTqKJb+NQWSojBZwzpbp9mPPkixaCV4qeR0qijhohqSCnFX2fdzYXsiZ3Wws0aCBl8ZsjeceWQAnI4G7K+VQj8vPpw8NIht57XkvnfvEquzcIFTzjPkDox19X3EOQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457248; c=relaxed/simple;
	bh=fSxqed5UWDPtMAbq3Cljr4NYb5RrBPmrn7Yx1Q3FdEw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qbaT1Rw9y1pOerW7c0U6uahpLbp+H1anf1Sc5cWsjvAGjwFE3rEtD4hfDzhI/YElOL6M+C4g7drHsJ4XTFFLwgDL2KpRxzjSGp7KP7B4vCakYzGiSr+yUXquuFR3XCEzEgpNjw1MziuAXLmLc/UVNc+VTS4z+mDvVENtZIHoRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqfTaT/A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PVW0xqtv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N0nVB1015459
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=BFyixSNkK8MVqyrqH/A8mfKuhHb8vM8hQ8cb5GQ+io0=;
 b=IqfTaT/AMnTU6rrnW6cPbTVCKWBYqFaWlzmci6S0bbyilo4uilGdzi6ODgjJteG5TMua
 gVs1PIBmDxR17hpnDobCzY4grAUvEff4auGADfSpIdA78hh8hgVbKRuCwj3kNk4k/BPx
 ADXFBfxiLHgggNd9zY+wpBoBPhkYQPOeH3/HmIS1dgAbpSMoNEXNM7LvWXXKnhw0T8iu
 CwwRcyK4rO8hnU+40cd5qNkJ+tqZjbG7hbCYzs7D38+1l+Z90nGRnHkAneMAUM4jVN61
 AMPtD77uBHH0ZA1qcYkP2S8yIlBT1VqkzqoW7jGmmB2lb3CQNOVj4FU2AWhLgbjx4BpB iA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv9npx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:40:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44N8adqA005006
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:40:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsap01r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 09:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUbtf+ojABmyy4I0ePccNbDUrh1se5F2HhNvFjbMDGLNm/wphjT7Iy5F+v4sbiSsAB59SrSESc7BEQlHcBSfgDzgxNtaoB367zCHAjDyibJrVabPrP6r6IPVAI74Ggl8N2eGG8j/MXklnDunXqUsrjJggKIUeYDMzcbGx2zfyb1Xu0590p+SUHF3ABjjFv+MaPqt/5m8WAjcLJ/nrvcbmMYI8pdA7RRDqYUTFMI5/yrn89Ie5hfcWz8JRateojcdlP0D1YDl4HawQGLD2uoJzwxz/9we8JrQAYJXtukvep8AA/jxS/OLRJglBbSBrwSltzgXUOcQVH8KG2iIH6Py4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFyixSNkK8MVqyrqH/A8mfKuhHb8vM8hQ8cb5GQ+io0=;
 b=haQyEjZbxdjiKJniy6mMjxP9CNjV7Q32ubrM6D4c6r9a0zQ3/J20sIGYR0NRMzYWpmrM993LY5CqdgNfJsIUMBceXpSKArgqKTqWjc/7FuQk2oTN10dMj7HrPCrnJizJ3CdXgGo/xX4rUvnQXkq3qdIWA8Exzl3EUVmNJkNDsXx+u73kYIiwAhEX8ZME0QOXHmInHuHBuzduislLj6xuOb2+8/FmNitqeZdRgKWBom+9BYcpnpebeq2dAMW/EHv0vZyeqWXka4sSdzlp5xF863gZsYo2wHOx2PdTnxrDVH8XHVqn+nXvd4QsPTHtztV1Jp/IbYE1I6g2anPXHSgg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFyixSNkK8MVqyrqH/A8mfKuhHb8vM8hQ8cb5GQ+io0=;
 b=PVW0xqtvfOP/9acQPbDgUANBpQdKyW+yUgwiw8rrN6iRfbaDZrpanJxZRy/dEX2qBEEvC3utjMTJ8X+PIkyldPN0FLGb7oURKBSp3QJTO7PnnAorbbNOkTUCORUD6fYDW1cM7bnJDgpWGNVU5EZkUA9lADrCPRNhRwdn9SvI8e8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:40:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:40:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: doc: btrfs device assembly and verification
Date: Thu, 23 May 2024 15:10:32 +0530
Message-Id: <792a9315d9f68d4222aad02a3f245a0f4b63c96b.1716446880.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9ab6c7-567a-47f8-9807-08dc7b0c6745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+tPtevcxp7R68SysL1mbStzcm+pp3+p+nLKUkfmPTzcav40Dof2yKvCZwS1L?=
 =?us-ascii?Q?H2c2k1ZtU6hGVqiu7Pv8tTk795bjWPJNc1LrhMDj2+FIwuS4Z2Q0Sc74Jfpz?=
 =?us-ascii?Q?Xh4HKw1JtD4C/mrZh5vVWO1vlgfGzG9C6UKaRFkG9vL0bI72LpxG6UlSj1SK?=
 =?us-ascii?Q?WjQxgrD0Z7SIxjx4juJdb1wym0wWXMgZiL8uvRx/dfjM6BVCbXceTgOEHgcq?=
 =?us-ascii?Q?c1AU4yX1uUvIeJoc028Coivg5fIx2tvvcFXbfcfk33YUkb2p6aoLoYLpF0FX?=
 =?us-ascii?Q?PhlwekbeXFHh8ui5pPaU4jWlXa/++uzyxjC+9yfrY9wzyY2JYE6sAJgDcSih?=
 =?us-ascii?Q?4VTx0n2LNg5wczpBqmn9atJAzS+wmikYIE+mvjlWTO6gSFinEofQr2CmOJj2?=
 =?us-ascii?Q?ZZ6gvr3ygmNriMO6aYuJC3kJlOOgw7NzhEeoeUxX0EUu5FY//odrRs3Sipp4?=
 =?us-ascii?Q?nAYoh4QG0mpMHVouKlMfWZ9Sw3VOLv6x0+OlGFr9zOJk7Z8Fv9tsEiWDhl+3?=
 =?us-ascii?Q?AzNS4Zd4xpowjWZSfKeEYr3l0aMO9plftiRM4Jy9dhFQVEiPJwwyvYb8PK2W?=
 =?us-ascii?Q?zI38I9zTKgpUk2V3LxXtb99a8vFkF3bdBYe+xMzAqaradTPGzVvH6wMaEV+i?=
 =?us-ascii?Q?OrzJl+i8cDP4QlOVge/U4oMXBXKtDO5Vwg2BgF8dITuwJx5QAoFTSC3qimYL?=
 =?us-ascii?Q?oiPSfwJ32PvMny6sd6xiCiFOCc+Od6TtN4IMOZbqenqCgpofxJVe8s/Q0rm5?=
 =?us-ascii?Q?1qch7NhPeWXg49G03hFlvrf7sjT/xOqnB8CwDUoTBke2b/NH49db3RzvTXC+?=
 =?us-ascii?Q?00h0eROVP8BhPDBXEO+G7F5wjlTmf/8vKkEdSHV+Dzb7oMCGWrGdof/k6E/D?=
 =?us-ascii?Q?y4ed2pSwLKEgCf6kYjBoyX6mojnPhroD8B/rfnnzygOZZzkx7ZENIdfvtTNs?=
 =?us-ascii?Q?BvgAjep2CkAzDUAaIaX/lTfWwS9jaxUZzUPAuQPhqAm14rhTkqxhxNWUCs5+?=
 =?us-ascii?Q?AQL3eENfgSaAWp9ddGE3OmOLBqFiROn/r8U6KhiBpAm4ChlU9vngJmPl+NbH?=
 =?us-ascii?Q?+OMPS2eBb/Ctofqy+lTDjPrY70hW/LP6w5Bk4TbK0cPvV/LdbpBULflsLJ8O?=
 =?us-ascii?Q?F9j9uQxUFulN++l0W40XFHhQXLvi75p/Ddz1YIYcJQg5PrvVZkd5OLG/EbyY?=
 =?us-ascii?Q?CEw0kJo0v+cMvvkrLz597kZei9Qaoota0lK0viPOZ11WIVC9nKBYHgtVf6iO?=
 =?us-ascii?Q?njGwUWgJ8gmNwmfTWqWYSRW3BojGUdmfisw+O0tPdA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y0lxLmJWHIuq53mKtaHqmnP3t/RlQ1N/s6SbhCcFr4QGUEWxU58xxwbxJdoy?=
 =?us-ascii?Q?6oeyZSH/ZaE4lFA/ztcEYJViV+F4HW/5yQ+jAmML88MqrLergBiINQ+yNSqc?=
 =?us-ascii?Q?rqpogd2t5i1p/7P1acQQ3qFDCmCeclAPRQezVP4Y71WKhmyzNj74x0HjOVLd?=
 =?us-ascii?Q?OAmG63ccQ7Jmq+A09/6NwUSXdmeF+GyeXCYkEk5h2UvfGhchNNknYO7FF+ui?=
 =?us-ascii?Q?QX1MQ80DyCH2OhAK/JTMUxlrVi8RV66QrNpqCeD7xoURgIn7/of3z1xl2vyc?=
 =?us-ascii?Q?cYy5DNSRIwAPXlTlk9R0iVMNLdXEbLO8/JiZp/DIaqAmm0I9EMa4SXzjY3+r?=
 =?us-ascii?Q?zeceT9NnnAiGXKjUKHMdhODgp7YkPBqgIMbN2AQlRAV2MpFEFeMzXKX3a34b?=
 =?us-ascii?Q?9YNJ2Njj7ZQsaAggg3SVbcyV3C9PE47uWtx5bJrrXpCai05rIMPnftsLEgaa?=
 =?us-ascii?Q?NdeJvtZyLycmPX6UkVBJbldY0dfReQnk6UsAMjq2gDiqFPTorj3QUCJ5OiyA?=
 =?us-ascii?Q?FYN2KF+e91UC12oSaDOFq1WUKi/u0ebCgY4cPf/Yoml8LL+K7pXSLlKNQNc/?=
 =?us-ascii?Q?snPHe4bFWBxoiDq5mx70NBA5DPc+ahdBrRH6YwbU6o81X2XS4vMIpavwqYWc?=
 =?us-ascii?Q?6Mc4Zo+ksDlmk2YHWIuVDnjazM8xq+zoV3pR3uTBgWTOb7RLCvrLbipSwUtw?=
 =?us-ascii?Q?LSFklioOzG+cUh2RtoLCJ0EYKfs0YWY3zq2GD7i9w6vcx3ApRJZjEAKgqwxY?=
 =?us-ascii?Q?Y1qvv9TSiWmZUIlJ/7JGRAqkXfChGHZ0FgJ6Lz9JmdMUnogy3ZCxhHx4IlVG?=
 =?us-ascii?Q?ky11xmV0rFpS9SVLDyYXLJtYyDtceWzmejKbGTTH5SbPYssEYI9/xysanVLB?=
 =?us-ascii?Q?o1ruy3oll0IyLgywT7N3ddT1IEwsUcVa2hVEZ/MkKPRp8o2Z7xc1WdLxsPwV?=
 =?us-ascii?Q?h9ofR/m0UIWRwUKfzuoxFVnnTbqGVhHiAc3+Y+tjHkO0CAhY+LQG9rL9xQNy?=
 =?us-ascii?Q?RhKH6/ZQW4hibLtRzUm75qvD4+WkIPk7yC9BWFZDhF8u5NT+Tmxooji2FFkU?=
 =?us-ascii?Q?7umZgLbIBxLOP4qxQM/Edcp42p7Fju2Idfu4e1fAZqiB2KG2WZyUGp0i8Xxi?=
 =?us-ascii?Q?/synvTtyVYQfLDgNlnyYxX+IEPcXzyejLQpp6S37645VQDPkbKWB3wmrAy5o?=
 =?us-ascii?Q?+NpytpGUUTfBjfECSt4q+VNlTRnpvpfb3VuwFc9qHMJASDB+VmOXcUr7DEmm?=
 =?us-ascii?Q?3BId56C2Wb0hWGr37IQWGbEAGe2WM5b1tO6IlYBVs26VwthwkdbPd9LOngAb?=
 =?us-ascii?Q?MoPBEaOnKKIsU/LOGF4c0ew9xurvQpZCFY4/V0h9UzQ+cBCpjdeJEdyADzhj?=
 =?us-ascii?Q?zEfZnNNNj9cCAPW9ztlyocBKObtUGolugxlsFu/CzzqyeyByFxmMDmIZmx1v?=
 =?us-ascii?Q?SVoorT8+VLLs/s7MPcu5pEmMjYTlJj4AZLPV+xYV+OLrUpsvz8vK4BFDrnU9?=
 =?us-ascii?Q?BBiBotSJSn/qrChmSBwaC4CM+azRovMsUhD6OQySffzrfE4QI+do0qHKDVM3?=
 =?us-ascii?Q?LeH/fohyK/b7COWBCvo08amo179Fi5UbJFSZLhaSq/9dhWNGZUOjmnij/CDM?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NPMlMgK2mKhkWQQvDQ13YUmeNM7483MCr7jwg5N65OGGXacgaOlGz3tNXGzz45UEIMGhNpWvKPGZnzzJ/1NCa0QU5ZCcx2hyOU3bIoeT83Rq/PYzdgsq0HY2LC9pkqcutVJNbTMSoo2n3+9r9ot+Q7h41RQfEhDjq25ygmJ7UmVXLczi1yuRkknqaiFb8daJeehtRWHlKrxfOJcpKhuv13eZYxF175OImI4ZzOln7GN1Wp6EdsYYsz7WsCzVo7egGpN30SLSD2Mc5pksFzXn35bKCUBAbuuVAuDlyJjmlFtVmWi1p9hP0S9vQprzWkDYS7gSUFWamagFYNgvok1RZxMbrNT9OE55WRNYZrVa+QeKUze2wvoZGVsCkDP45WH9ujOlLHOAgIkO9DnCsjrDuThve6P/J5ek58rurSxgaeVDgyVyGFFVucvSX5EZIKdulR0rHVggbKMdPOu6A0u/DRw/XfH9EZrIleAdRdFJeLfsT81InZIpnGxgMMiONs/X2lAgtSyz87g8THzUA+pC7XFRXCQHczOI8WIC7FYN2bnHaFoSqYoUhoiYDvzIG2XiaBdKRIMsRRG8hVLw9Jh2NL1+ZEpnKF1fa0lKJE8zDJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9ab6c7-567a-47f8-9807-08dc7b0c6745
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:40:38.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+pH2+n6/9eYsWIEV42RxR8v2HmoZ/ZFB7mynRyjz+9BgRxLV6ZJBKsLd6j9DSvtQt88MONYIA4tSTkVmHut1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_04,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230064
X-Proofpoint-ORIG-GUID: Oinn8NGAXnbRamI9iz3nHFdU44gvPLB7
X-Proofpoint-GUID: Oinn8NGAXnbRamI9iz3nHFdU44gvPLB7

Create a document on how devices are assembled and their verification
steps.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .../Device-assembly-and-verification.rst      |  4 +
 .../ch-device-assembly-and-verification.rst   | 83 +++++++++++++++++++
 Documentation/index.rst                       |  1 +
 3 files changed, 88 insertions(+)
 create mode 100644 Documentation/Device-assembly-and-verification.rst
 create mode 100644 Documentation/ch-device-assembly-and-verification.rst

diff --git a/Documentation/Device-assembly-and-verification.rst b/Documentation/Device-assembly-and-verification.rst
new file mode 100644
index 000000000000..411db54a70ce
--- /dev/null
+++ b/Documentation/Device-assembly-and-verification.rst
@@ -0,0 +1,4 @@
+Btrfs Device Assembly and Verification
+======================================
+
+.. include:: ch-device-assembly-and-verification.rst
diff --git a/Documentation/ch-device-assembly-and-verification.rst b/Documentation/ch-device-assembly-and-verification.rst
new file mode 100644
index 000000000000..65ab9352d59e
--- /dev/null
+++ b/Documentation/ch-device-assembly-and-verification.rst
@@ -0,0 +1,83 @@
+.. _Btrfs Device Assembly and Verification:
+
+Btrfs supports volume management without any external configuration file. Let's look at the on-disk parameters that help bring independent devices together and how we handle the various ways in which it can confuse the dynamic assembling of devices and how to handle them.
+
+To begin, `mkfs.btrfs` creates on-disk super-blocks `struct btrfs_super_block` and some basic root trees, which help the kernel validate the assembled devices at the time of mount. At this stage, these devices are read into the kernel using the `BTRFS_IOC_SCAN_DEV` ioctl at `/dev/btrfs/control`. Additionally, the command `btrfs device scan` can help to read all the Btrfs filesystem devices into the Btrfs kernel as well. The actual identification of the devices and their assembly as a volume happens inside the kernel.
+
+The `list_head fs_uuids` in the kernel points to the list of all Btrfs fsids/filesystems in the kernel, with each one pointing to an fsid declared as `struct btrfs_fs_devices` (typically known as `fs_devices`). Furthermore, when all the devices are registered, the volume is formed at the `list btrfs_fs_devices::devlist`, which holds a linked list of `struct btrfs_device` to maintain the information for each device belonging to that filesystem.
+
+Each of the devices in a Btrfs filesystem is distinguished using `btrfs_device::uuid` and `btrfs_device::devid`. The `btrfs_device::uuid` was unique in the kernel until kernel v6.7. The `temp_fsid` feature for single-device filesystems knows how to handle identical single devices.
+
+So, when all the devices are registered, during the mount process, we need just one of the devices to mount the whole volume. However, if you prefer to specify the devices manually instead of using the kernel's automatic assembly, you can do so using the command `btrfs device scan --forget` to clear the kernel's known assembly, and then specify the devices in the mount option, `mount -o device=/dev/<dev1>,device=/dev/<dev2> <mnt>`.
+
+Generation Number
+-----------------
+
+With the `struct btrfs_device::generation` number, we select the device that has the most recent transaction commit. Generally, in a healthy volume, all the devices will have the same generation number.
+
+If there are multiple devices with the same matching fsid uuid and devid, the device with the larger generation number is always picked up. This is to avoid older or reappeared devices from being joined as part of the volume.
+
+Once the devices are assembled, a device with the largest generation is picked by the mount thread to read the metadata at the root tree.
+
+So far, we have identified the devices based on what each device declared through its super-block.
+
+Now, let us look at how we verify each of these devices through the mount thread.
+
+sys_chunk_array
+---------------
+
+As part of the struct btrfs_super_block, we also have an array of metadata chunks information defined as below:
+
+.. code-block:: c
+
+    #define BTRFS_SYSTEM_CHUNK_ARRAY_SIZE 2048
+    btrfs_super_block::sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
+
+Each element of this array is of type CHUNK_ITEM and contains information about the metadata block group profile and the identification of those devices.
+
+.. code-block:: bash
+
+    sys_chunk_array[2048]:
+      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
+        length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
+        io_align 65536 io_width 65536 sector_size 4096
+        num_stripes 2 sub_stripes 1
+            stripe 0 devid 1 offset 22020096
+            dev_uuid e9d99243-2b93-4917-9f5f-ed22507ec806
+            stripe 1 devid 1 offset 30408704
+            dev_uuid e9d99243-2b93-4917-9f5f-ed22507ec806
+
+Additional devices that are required to join with other devices are listed in the system chunk array. The UUID and devid are taken from here and matched with the devices in the btrfs_fs_devices::devlist. Now, the device shall have the state BTRFS_DEV_STATE_IN_FS_METADATA. Only those devices where the metadata is placed are found here.
+
+btrfs_read_chunk_tree
+---------------------
+
+The chunk-tree root is loaded from the btrfs_super_block::chunk_root and finds all the device items. The device items are of type struct btrfs_dev_item, from which the devices in the fs_devices::devlist are checked against devid, uuid, and fsid/metadata_uuid. The devices which fail to match are removed from the list. At this point, we also determine if there is any missing device and if there is a -o degraded option to override and continue with the degraded mount. If there is a missing device, a missing device added entry as a device with the expected devid and uuid as per the dev_item is added, and the rest of the devices get the BTRFS_DEV_STATE_IN_FS_METADATA state.
+
+btrfs_verify_dev_extents
+------------------------
+
+Various device verifications, such as physical sizes, are done at this stage, including verification of dev extent to its chunk mapping.
+
+btrfs_read_block_groups
+-----------------------
+
+To find out the block-group profiles being used, all the block groups are searched in the extent-tree or in a separate block-group-tree (since kernel v6.1). This provides us with a list of block groups that are already created. It can be visualized at:
+
+    /sys/fs/btrfs/<fsid>/allocation/<type>/<bg>
+
+For this reason, the mount time and the size of the extent tree were proportional, and it wasn't scalable on larger filesystems before v6.1. This issue was resolved by using a separate block-group-tree.
+
+Missing device
+--------------
+
+Missing device identification happens at multiple levels. First, in the read_sys_array, where all the metadata-required devices are identified, and then in the chunk tree read, where all the device items are read, providing a complete list of all the devices. However, we don't yet know if we need all these devices to mount the volume in a degraded mode, which means to activate the RAID fault tolerance. This is determined when we read all the chunks in the filesystem chunk tree because these chunks can have different block-group profiles, and the number of devices required to reconstruct the data or to read from the mirror copy varies.
+
+The missing device might reappear later, lacking the latest generation number. The filesystem will continue to work in a degraded state if the redundancy level allows. If it reappears, it shall be scanned; however, it won't join the allocation as of now. A mount recycle will be necessary following the balance so that the missing blocks on the missing device are copied.
+
+Device paths
+------------
+
+During boot, we also allow the user to update the device path without going through the device open and close cycle because systems without the initrd shall use a temporary device path (/dev/root) for the initial bootstrap, which must be updated to the final device path when the system block layer is ready.
+
+Also, at some point, we might mount a subvolume, in which case the device path is scanned again. So, it is essential to let the matched device path scan again and return success.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index d65be265a178..723f4a55ce93 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -48,6 +48,7 @@ is in the :doc:`manual pages<man-index>`.
    Convert
    Deduplication
    Defragmentation
+   Device-assembly-and-verification
    Inline-files
    Qgroups
    Reflink
-- 
2.43.0


