Return-Path: <linux-btrfs+bounces-10423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CED9F38A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D01672A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC78207A06;
	Mon, 16 Dec 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jK4dHEjn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z1eu/cy3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79220767A
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372847; cv=fail; b=bnyG79YusMHHykvBvQQ5ZA9MPlEvhVkNQpmXDEKh1SokA+6YyRaaU4GmY/t9NntxoceqQpEVjZBdaxVjIEXFJEOvFMWaGbRhkWhjHyzK5tqkXwSZeGJ3lhh9VMxXqfIxapqpgtf1dzWS/de+uT0MoBjLORj0Hq4rvLdzkJDceUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372847; c=relaxed/simple;
	bh=6NT2QHRnfPJt27gRj3F2dY37/u1mclj7JuylMQy4/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIuNqj0X3uW0lUVLfoK7AGNJ/M8kopsHEgDtZXI+hc5rzw7MYGCNq5vsU0b7d3CfLfgr1m0ovBo2gjO2BfasFe//krxRmmsWQJzCXOQ55MHG7GFxJgUN8AO6AICNHqt9G8zA48csSX0Zi1DFz0spJ8wlg/nNGR37n0f1myY7Qis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jK4dHEjn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z1eu/cy3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQh7t024115;
	Mon, 16 Dec 2024 18:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2KxBn49JUOG5nsjBFXTjqA2e8itFVgNEkch0ty41lEM=; b=
	jK4dHEjnavJ6TGNNzwVEmDNqUnXgPJXILaigNDKjaNQVPdkhaEicgE+1iOuEDF6l
	S7yNf6vJCpKkLMMQYzDVt/lTCM2K4hSmYdERzgJTXXSHKH3yScQlQP9P5pWcjxjl
	CIorJ69jux2dXXm8ymd2NzFa00xCSfL9uQA31u5SyhdpGWe/LG1UuEEaUOCyK01l
	jPR6i95Le16Ig4WFotSH4jtOo1jAejG+4KdNMF+lePizNkmM2QBqqFTys0aQtkF4
	UGMfpmk8DiiV5kEqIVWwPtTx99AoTsKTAeiKbCASLgUDn2xvX5QVdQePhMYy8J28
	hLhXCaEq0kUMrsT5IO7JNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2byvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:13:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGH6pM9032708;
	Mon, 16 Dec 2024 18:13:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdmw3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdSpFldkSMrI7cdrnsv/ycXTk6fRbprubwy5GJ+VWZOAyyQ0SptTZwAnZHHjb93h2vGDLAr8guj1ROFwLYETBsYQw+NlT3w/onXdVcctyngNhs73l1Ho0az8CaAu9NdEarlnXu8ooff406qbg6qToMp7SoKRyzTso1jbQvQeOWJ44SU5fY0Wn8QsN/3/lgp9pEVD/cZPRoKyRSYOIb73+w/65q+8ZNumhbodvNOcKWxCjC74EsdTpjzzsxHcjkiJAdJrSvIuGeuXP3p6MvhbzNnoAeLQIOM7QsDgfxcAiBApU/B9Hd+YUJdiaIqMgy9qJG6VXO6R2pztbP2l3rtL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KxBn49JUOG5nsjBFXTjqA2e8itFVgNEkch0ty41lEM=;
 b=pLFMCzXGEVh2TVNf4znpamKxLxeiVxXB0V1j4+VgXlXi/qdY1xsBJmpo7DLd7Ne7BjGotewB/SYHIdMS+JxKaJAAg8D7CRMZ6iSGeo/Mu5rCLm811kLRINXP7jgP11WsAgtXJpc0UhmVyyYJ516xC6bcv84OubNhUFOHGKAxrg9XnC+MtA+zM5Ot8LIjaV0MjfYVyFkKGD0z9emxeSjA+1RfPs38kGgLZykad5/+rDK3jCxIt/vwFHEJaxO3ew8xoHAuA+LlF3vELBv0LhPjnw6h1PKLZ2b4sVlS7aYy+d8h28362w0SQHvpl/T8xISKIbUBRGf/fH1PCMDfNlLVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KxBn49JUOG5nsjBFXTjqA2e8itFVgNEkch0ty41lEM=;
 b=z1eu/cy33EDH5fOFO1VPMFvk1VGGCBr3AIrk6fT05lwvpRzWJn7AS//3oevcn8gb7sIpqXkKtUDqq6IP3p8cUAvsJSvB+79rEps/9r4zwx4PDk7st/o3Iyq595a1NHucw9j/3FqKXuGBXvsFsoWcsW6yquRCJzEuTyTUBPfx158=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6653.namprd10.prod.outlook.com (2603:10b6:303:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 16 Dec
 2024 18:13:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:13:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 1/9] btrfs: initialize fs_devices->fs_info earlier
Date: Tue, 17 Dec 2024 02:13:09 +0800
Message-ID: <767bd0e42792760d77b7e8225111d9c8a6f4039b.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c8a02a-ba64-4868-6487-08dd1dfd65b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGKkLnm1zFpmRBJeeWq4OfXfR8+MEKX9fpMYcuynIk23BT+tzeRbDfSJ4I2S?=
 =?us-ascii?Q?zqXU5zFHyYJ+EiBtxZOHs1bJgC/VGY6XEZ4qmTCZXcIdf6MWuNpHVNzIL1eW?=
 =?us-ascii?Q?gGGgsnwRap7uM209uJ+foD4jezH4iqctjkudtM5Qh/4JH5zjv9cKhZSCc+hn?=
 =?us-ascii?Q?HQrZdokea+IxaZOD9eNKT3z7kYNQrhaNyTy7bEHut65ky2ph/kf2JegauAF4?=
 =?us-ascii?Q?3PFhWIeUvDOq+WGI39fpWZLcWEQMuVDfbfruopxrzPN4bVTuOpF2yIVvMR7P?=
 =?us-ascii?Q?hnd+zmIRODk4IMFHzxJHF/nWLrwHgmssc3ULwafzRU4fWbphoc3MQa/2diRZ?=
 =?us-ascii?Q?0Tobl6OZchaqvfQfNumkWvauwaNmGi6vfH16uebL61Hakb37ny/iQFxCoerU?=
 =?us-ascii?Q?foWCIZgzhi3CrKGAk5QYqrU0eIXh9URjErOzuUe8XiKQrExRG5GH1FaQbeHH?=
 =?us-ascii?Q?o84qKbTyAoM6vlFbZMedhVrPYpsoggljiMDipPF8gd618Hvoip7Ulp+QuLRL?=
 =?us-ascii?Q?d9lwsL3sjTAzEwtX1tVqZpmGpivT4yuT6OrMmfdHKB8wiGytKNahK4JIGR7a?=
 =?us-ascii?Q?f2WQHWudN+1Sd4zxe5zLgSsS4HV2qkk6N9PcGcrSVMHNnvCYBNn6b1cNSzxB?=
 =?us-ascii?Q?u/6XdPX/2LxxOmP/JdBuPSDIn9g6rf2vUcFyAA7/BlR0m2OgXjIhZdyfdfYN?=
 =?us-ascii?Q?DJGeUQyOUdayZSqnbX2Pr+l6HxWowcpt1MCpgIdf3FQLqwNSOv2SE/cHueL+?=
 =?us-ascii?Q?rXAWT+wMiWgloI62wVR0fRodooFk9HFWzXyKirmJEnVg/Zu4csZNRt8a/P7Q?=
 =?us-ascii?Q?Cv7XoDyvrTD44BTLUSqZYxT8SpOfxfwGIGHTnQgDSKNtuqkr/eVeJq5+Vxjj?=
 =?us-ascii?Q?SP/W9+N1j2jcE2Z9aYJZxemVYEedggRAAli4T1U76oktNCw/Mrb2QPQ9iBuw?=
 =?us-ascii?Q?KqX43HtKc3N+EGOuqiPd2suvNsXTF0g17QKdJbbFqAwyKE+hvuaPK1LengKb?=
 =?us-ascii?Q?lBsjRdE85EkgjKpnwyHKuIjeaeTqB7AE3q0/i3LV2CZWK6OVJ963M8aJ4rDT?=
 =?us-ascii?Q?jOadJWWA2rvr0B5ZqB2/ttVXTrkKwgpsIZOYGooEJfsbPGEWR5J3NVjRAmEG?=
 =?us-ascii?Q?DZ9ynGr3VPJyZXhLpvVg1mQ3/lV6CF8uDdrQ/ibNld0VR3Sa69K5TltpbSIL?=
 =?us-ascii?Q?GhGUzK0GYq5jQ15rG7y47YSN9+zS49syulViZyW/nq+UfkubfrTaMzou8bYs?=
 =?us-ascii?Q?IqSAsx40CnloW0oanA+VEBtuxSoPt8eRQQmQeKLNvi9JicUgKlEOiyid33OX?=
 =?us-ascii?Q?gfyPuRjWep+jdyWsR698evkRxXlR3ulnI1XRCMU4XfCIW5hmOqcuzk3mDzCJ?=
 =?us-ascii?Q?YZunh5lbCf4YNPT7u1z/2n36AsOs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDFCztBzRltCBVUm3C/KGYoJB8p1Q6wgq6Cvxe5MZV9QdS1X6b30l82a7QZV?=
 =?us-ascii?Q?9qhto47viJxukuCtro6p0rNrOQ41iIb/3+KYkwf85CLdXdVZW51Qc5BTonbj?=
 =?us-ascii?Q?/KoJkhzWdz33G5O3UtW/GWtDi1snyuzW9qoMOZEdyNjWl4nWBO4SkBB2N8m4?=
 =?us-ascii?Q?IjCXBRURoPLWw5+pP/cPoX7EUY7f6CFw+dJB4P9FufYhitJFcG/CUb+dkulk?=
 =?us-ascii?Q?2WJCMcocgSeYXJlv3oYkI0nbqy+IrKvDvgcgenxG1b/3afsYn2paD9FRWDM3?=
 =?us-ascii?Q?3Kvi/vDXrdHU2voLiJkPz4weIkMfj65ZxEPahexpoeuJFca5VHmcBHRfiS41?=
 =?us-ascii?Q?2/0NrCmfkctvLIYfSvT5wrvrdNii80tNg48tLo5HJopo25ensApoRGomZhsm?=
 =?us-ascii?Q?jhQfK8DcmukOgGZn4d1kcwLEgq+/+iTbZ0UwIQc++4co5UY6PPkov/cjieaU?=
 =?us-ascii?Q?xpC8YMXh2jtHRgYALi+t4bW2AJ+wIz6ylJcZObytUKonOfwTaJwjk9iFXNFZ?=
 =?us-ascii?Q?Wi5hmVKyEKEKxuQHQJ+d14jSSqcMYigmoIitsY40uc/MgxauJs+PLhDnBnlm?=
 =?us-ascii?Q?xs2hkP73c9owyPwdd3gsR7Nj0rJhPBuV8L4Cw/ekWZroIOFtymfF0LarJ4bO?=
 =?us-ascii?Q?KQ0DBsIsMduqAY/fPMattea0NlYm6iTRTeAMPlFDzQdETauHQ/EKRhaqLNQE?=
 =?us-ascii?Q?6RkWwZd2boNkLi05AaPxbUhQTblvN0FmeTOJ3KIxKOf06WIN+ghUAehwuzJ/?=
 =?us-ascii?Q?vtduvkyLwEc7AXQ5sQ1EvP/ekZsDldrWsPqPwV3kbuiDOTSMbfGoONMJvno2?=
 =?us-ascii?Q?Dlac+KRHSp7lAvopMJqA2H968NQk2U/DPqIzFhEyzzQMDMeWP/O+xMAO5SQ8?=
 =?us-ascii?Q?Non5EI2DKFBQ97keDXAn1nYs7Xx2ZLK+PTa568FHt02+PSklvfT7Itp/NbjF?=
 =?us-ascii?Q?UF1h4RPD0ARKROFafqz0Uc3art7033JBZVBH6Y1BDT/Ng057yThmZYfoYTQS?=
 =?us-ascii?Q?BtbxnNDgj00ihBeGxReYc1Gx/386NkX8LA0wmWiLlVMB6K3RdAMAWAvXH2CS?=
 =?us-ascii?Q?CEsYIjrnxGzcKwDSsC3/+x8waHe6m5mekwSGKKFGUHJdT+E+TwSY9q35E42O?=
 =?us-ascii?Q?6fwE3blr4FNci5ylp6kCWnE1qAyhHUed2uZdicocBfnIGB3Tcvxg5pl0VXlo?=
 =?us-ascii?Q?LuMY8dwnMzND09vp6Rpgp2k7Zf192MzhykUsiyFxl8wwjVbsIM0QgHIlguIx?=
 =?us-ascii?Q?3UOy87z3YRtBzHdEeJUB60hvUVeSyRJpkogDuuzOQ0nY1rKZpAvNqAgO4PZo?=
 =?us-ascii?Q?HRHcBnrXh0fmNwdv7bE6JJtUgZGVlcgosA/oDC5vTA9RNNH4u2vuDnKLwRmr?=
 =?us-ascii?Q?zDY1dkQJRFPBJYMqHIllR/eqFGRM3UglOIN46HtqKDvKhWCTS9QNxIBqqwmQ?=
 =?us-ascii?Q?9YVL59fS1x5/dZTkT+YDI11zgjA81rCOQkFjNREQytaVrzJ1L1vnNp0m4juY?=
 =?us-ascii?Q?K43JWKTXpVXNN5aFQT2vtvDi4OWXwFsbfy1ZlUlcO70ppIpZDJS00AhblVAy?=
 =?us-ascii?Q?Ij5wOQ8phNOXvCOrQWgU1EQjyfRCYXvAC3yZC9+x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9kJ1UqLZ7CYs3wAK4KuomYZc8FkFgNq99mzv/1eRozb61+FxO7Hy50yWDYlr5r/RehFtq+IlhycaKjTVTqHRSwBPHcXJHAGRvCrQaGOuB3JG8kD1W4xdrBvWtMJwvJeg3n0LO1h0N2QHbyv3L+CFe59WOOCCSTehyHPvn+jnKzjvtzw+ZPZd+Ks/pwoK3SHhJSYfwGgatfYZUWNxhMQ1pT34jFKZCNKtsynjl6YF2F5ro8ByJuFhucPDlb/guR8YyWuO0BKQwJg/c78fr5Hc6soBrWAFZYpuIub4wzbrkVNgd7ca6GgDYnuEsYsI+jcpGRGFdSIEkn/ifUd1pDzgocAiyJU4q8HgU7rEK8j7vj4o8biKX2sRFwLK31oL/tEpVa995ygcgn5xQl1g9FkFMSznSUAHwtSUz9Ja33a1LAz4z97bpTbOR8RmP8wO5tjKFj5LyBhDHZj776aNtljdxPhcv2hJXZ75WP8R371m/5/FDUwwlrklhQ1yO++CMNqGEha972rNIGLYh3oWFoNoD+H+xJ/0mX70tgCAfXOfabZ3+dDMNUGtUU8oMIH1+V+mqgnCAowVeaOOBz1bdwGByI0fxtr5V/slQVTs26hLVSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c8a02a-ba64-4868-6487-08dd1dfd65b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:13:52.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfzwmQm/nM6HS9ZnNaEjEKrQfa9JmHnhCoSftJEKjBVTvZS7oo2IvQwtCZeQ67Ldq9zL7zSMeV1s//DAlFKbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-ORIG-GUID: entRtgaQ_h9RTRDoR32SVALcCW_u2nBd
X-Proofpoint-GUID: entRtgaQ_h9RTRDoR32SVALcCW_u2nBd

Currently, fs_devices->fs_info is initialized in btrfs_init_devices_late(),
but this occurs too late for find_live_mirror(), which is invoked by
load_super_root() much earlier than btrfs_init_devices_late().

Fix this by moving the initialization to open_ctree(), before load_super_root().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/volumes.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 814320948645..ab45b02df957 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3321,6 +3321,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
+	fs_info->fs_devices->fs_info = fs_info;
 
 	/*
 	 * Handle the space caching options appropriately now that we have the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..fe5ceea2ba0b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7568,8 +7568,6 @@ int btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	struct btrfs_device *device;
 	int ret = 0;
 
-	fs_devices->fs_info = fs_info;
-
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		device->fs_info = fs_info;
-- 
2.47.0


