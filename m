Return-Path: <linux-btrfs+bounces-4715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066248BA979
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E2F1C22668
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B814F110;
	Fri,  3 May 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e/uLt6FG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mcmQvAfS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156414B076
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727385; cv=fail; b=W6zohquXb6n10Tf9rGtPe7wBlT9Vk066+1ITyx+g/b7i4+R5lHISwjIuW0Ti0E7HF2Xf3dNCgRmSeLN8Kw62XvIl6VMjzyEYsob38TSIrfRXqHbIZmei1u+Ba6dYfFNt5fXu2YcvTmFeAPB83+VbOsbnwxumgxhyQMrRxeFdvIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727385; c=relaxed/simple;
	bh=2+A3dexfmSjHyd1g84Vmf0R5JJdoWEJ9G/w1WbWrylQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNfUfe3ZokxWy7/tGiI0lFs3aDvNNC5B6MrBIelv21XR3kD8W4ho3jeEqeYC/+u3mdTBTEci2uaUjFZKD5rKRnR75sipQGpTWEM3axJ7xkg7KNyzJYrCFJecfMh7iNYlNOZePnpkQWLCLgH8WianTjJhAFiHDzisTguMKv4IupA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e/uLt6FG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mcmQvAfS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436hxXa004322
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-11-20;
 bh=sxqfER97v2KmbyX1GAxjhcIh0TK8MMj3OkdG4TvhjFE=;
 b=e/uLt6FGS8GzumLmvMjgU+YinxZsWYgBOwD9ib05AobLdzhLmvx2aRinPuAOwAfdShy3
 2Gfbe6+c+y92x8ddZbYPuXYgjLlYS/ojzRQvLiUwsg3t28rkQJ+gPc6Ckaiut9qgW834
 LPAXw97MmGhIJ86ex+L5Ae5yilNTdNDv8GAlx4qoNwppsqL08oeu7Drpy7ZELyWsbGHm
 c4Bvbf8eW+xKzlUh5ymdwC8MzzqKNWbtNm9ZdgUn0vOd/0tldeK/EeVPb/WpvWNPnxnF
 eqB347uQIGHLRUya2FGY5NDoTdnapRmCnqIImN34iSNPrDlp+hENwaYHls4vDf+L1URO eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf7eb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438hO04008825
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c3c862-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWlxBB71MePeqxzITYu0kNPC+7KpkCSHmHQqDL5eSkCqtgBeSupf4p/wtzvosprCvz1PJokQ/cHWXPOm9JC7SxCkU8V/VrIXLQASQy0DqscYEBVZtUUAiwkIvZyAmeqAtfjqslsykUapDDHIJExClOJeLxoimYvGQWKYgUCSXo0K3SgMh3prTl+8DvdRdX0Dfy8ffjZ+Nl3mzDATzXENcK1YDrctYUkv6q9wrriSrz+DE9CGWfrj5A0JmWErRHe05YOgx+7KaH5ts27ONugMuQWJcbp2LDn09cG23Y5yY6g00BUk+VFGIzrEnRkvhTnTwWw3ZAxrKZPrnnb3BIkhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxqfER97v2KmbyX1GAxjhcIh0TK8MMj3OkdG4TvhjFE=;
 b=bEAtiSatA+HF4VyYdlXVtGpWlll99Zex0go7zlZmBLjM4yM+bVon44qEMaD2fqTts0cRdjVTiVbsDvfrtyhJKNSBIoT5FZJeYunJ3YcesXTPUsOgVYi2K6a7YD9LXRfolYvZd1ndyTG4Srt9IwJowNImi2jn0YJ2ks1XvYm69fspqEMrM/H33PAw8jsLzPETVdv2OKBbsL8BIaHJZCFRYsai9AC6BM5g58zmuWdAu1lcw+KmfDNSNH4xpsOWjEc+FGg4IdgyNHMOITeZ7IkdlW2XZz9XcpM20UPJ22PbhiT2/WDLMCPpxwFgw03bNRSTpjBiehrK9dhcv1fscN8HjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxqfER97v2KmbyX1GAxjhcIh0TK8MMj3OkdG4TvhjFE=;
 b=mcmQvAfSsJ+e6PnzU8TI2LHAISnMdikkexhkFDd2cXq2ijBV+cTuNCFOHuxfQMR+/fl2axC+lsKEIdgOYVUUbFbCTgwmPy0ss6ce1hwGow9E10veVbw9jX1oJtt4Mmntvk6OSA3oxOkNmdDcVZirzbrZBl4lcQTo2mK49+FZKy0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:09:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 09:09:40 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: convert: refactor __btrfs_record_file_extent to add a prealloc flag
Date: Fri,  3 May 2024 17:08:54 +0800
Message-ID: <c4b3a3a5192fe56f7b2e1d1ec91046ec27eb1a02.1714722726.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714722726.git.anand.jain@oracle.com>
References: <cover.1714722726.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: d989e53d-ec7e-45e2-9a37-08dc6b50c35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KXJJ6Y4WipjPqUYPtApri6/VSOzEARJ40jcpdH84+CtUYzYm8lkoAz3xZv9s?=
 =?us-ascii?Q?LUNJHxTxNubZ0QfP4hmnrxYMH69AUpn/FgrCmA3G3mgyLQM65AjsGEIhJdYD?=
 =?us-ascii?Q?bTRJeHNRweEeHV0Fb6JnIv9e6HutMPOCnUu/GaANDf/Bcj0EzSXI6FszGs3f?=
 =?us-ascii?Q?1eq80LMfPoCOupiWcOmRjWYwbZQWCNydVIxHZWsCIIqO8+WTSLXoxrcxqJu6?=
 =?us-ascii?Q?bJHX0MXu/kXT1ggCzwqWu8UF+DzkYme8ifG/rs+kdDL5DHBCGSqqVM07KHOV?=
 =?us-ascii?Q?3sbwmIlK79nw44xnU7X3R1zv5G7IoPDrQq3g/n6JNQ6EuOxCoENe1hQzKhJs?=
 =?us-ascii?Q?TMzeNCONV5c/LEK0JVossKIdK5LRYlWQF8FWUO+qrPttOenHW9Vlrv9siaOL?=
 =?us-ascii?Q?6Sukjsc+xS/7SzT47twfDfk0k3lGxGgAnRE091YcvT9wh63No6QAcxg3GFOU?=
 =?us-ascii?Q?H0rxarx7SobCRcE79Bu+F3pF5HQCoknRHMEk1h2/Y0uXPKCZ2xAop8irAWBc?=
 =?us-ascii?Q?KvguIE6ZzEBS2cE/xCQuobmpWougXvsnVpUeBRg+XJg16cETRGvNgeKwF9At?=
 =?us-ascii?Q?X+1DDst5ev7EP4l2H56LfId53oxyctgkEupE2MgBny3SwK9BN2ldHoWHjEj/?=
 =?us-ascii?Q?SsiNMNHggWpPmW89o8Bh01nIj+X0jV0bRhtvKMKeUn1WuuX+jagRLAXCPcIs?=
 =?us-ascii?Q?1rSPr653QKDElvrIC5fwfymmc6n7j4oNUSPwc07g24GEO8g8Vz2WkbU7Kc0n?=
 =?us-ascii?Q?hcdYbTaHYArmD7XDLW315bVyWVrhJcUsNUnijCBTcOtblBu3Fhs7zZD5LjF3?=
 =?us-ascii?Q?4pbXmY+JTyJEpI6U822hZpVBQ2kl0GdEnMfDGTpD1edRpRHCYX36iZlgc7WB?=
 =?us-ascii?Q?hTYz2iIUg+yGx9o1gpfwvX9Xypo1LF4pU8Gxn7bIc71uPiCGcOcGc9tbQ2HH?=
 =?us-ascii?Q?2XB51HLSWfhYXVKgxR6YgwA1N/BnBvlkqPcOcxxcW15Arkqj6sKOiYUof5M+?=
 =?us-ascii?Q?+P3ITaQ9/5sf1ewXK7uhGWXxTlciVwTl2m6wEL6g1JYQb8Ny7ZU5EpWSQcW8?=
 =?us-ascii?Q?4ySWQ1dICIE5L8IyPmxXwLZkz2llGxko3+SfgnoMjzCsHyePUt6E8LH6EgJ9?=
 =?us-ascii?Q?QmMQoGrF9tC7P83n5TNGEtqfWzm6jRpUBgYOtjIOzN0xUgx5g7SrLTL/EPhJ?=
 =?us-ascii?Q?PcuXSMeRi1HLdncVKeL5C3PKa/QLkjXFwt2bUkPVXQAFpTOfy/HHsuDwwhtD?=
 =?us-ascii?Q?TZoNP99QKg98OyVXmH1o0wUqfRppQYQagdlYCH1IKw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9aY5+xzBXLOuLiQ9io4ExeG1DgZ/nprbPcOlPl2VT8rswkn3aUBuKiBmsTZa?=
 =?us-ascii?Q?oVTezb8qi0oOybiKrFModx4ItHcoanh1E2cxC977RsRX06s2ogvoD1Kf2Aat?=
 =?us-ascii?Q?/T/lOL2P/O4jmqXHeVhu1fSPhOW+XjDtntRoBqLFcLmzfGUJDgztmRlugtIN?=
 =?us-ascii?Q?j4xZjxMmL6Fy1Rf+SDlNa8EUgfIJKuNoC9CLI/yMq5S0h0QSvYD5T1XkiJHv?=
 =?us-ascii?Q?ZMrxvMAQGmIPVkarMDaKJG7n2pP8lH8YXrbw2qfwgcTrbYz4RYFy5q1MOMgJ?=
 =?us-ascii?Q?GZyuXVQzXFw3WsR0GzyAdxiRxS+p9+2AAD+26juEHa9kvpnDUbIhJurSjEyk?=
 =?us-ascii?Q?zHn3Ca+lOUUk9CF6JIsVcsL0CgQXkP9eI+FPO7zGFfBsWc5uCOZ2MYua/JcY?=
 =?us-ascii?Q?P69SoyVvNrOm0J+rkDQqIIRbu5jy2HM1nC6HY4Fjr089BS2IGpXLvQqILcuJ?=
 =?us-ascii?Q?5OpvJK8XEQJCOZPSF2vPFXACoRjpPqlniAtczoX3mXFNGeQnOhQOCr6iIubK?=
 =?us-ascii?Q?Ai7ibgmHScKO83RD9gTNh4DaU53icRr31gAMzXeQNOBNjJc42R742tiy5ttc?=
 =?us-ascii?Q?51DoZGfzT/dL652anEsGZmaAo8jzXIJpG9ZMEHMIkGCVFOOM9bd261xaCsvJ?=
 =?us-ascii?Q?k67HbzvqcigMAdfmIVkNMtVnAybYqufYuVRmk2fdsd72quzBldV+j7Tt1+eI?=
 =?us-ascii?Q?kYOAVnf3aEMRRhS+LgGOyy2/OHL76DGeU5XUhRmB0T21QvY3cbp20CYlOUsc?=
 =?us-ascii?Q?hxzlp8wmDsmocIRjCmAxamhIN/da8nVpTIhtdx4YuKWzctT3A5LVVyDNlX33?=
 =?us-ascii?Q?SId/ds1xU2twEywgZbHcV10h7iHEaSBg/2OsF6qM/sc56Z4tGP3HGDrLT2b2?=
 =?us-ascii?Q?uVwyMlBDOfCFVwxfO1YN4OOOo07daquuJnTLc+odCWdCbcXqOd3nbxO6fPqH?=
 =?us-ascii?Q?yPqqdj8/8RafYdksiQixBvRSXSBevM0d49ajlkyDhxbwb63PlG7etGssUb3n?=
 =?us-ascii?Q?EFfprJd0thuaK67mzT2wqjGYa9YSOKGlcexlUCqMgR5gwX69A3HTj4X7qTGi?=
 =?us-ascii?Q?QPu0n4wx1+VLNsTgiUCITE8ZXZNaSisGJHOZRmgw84+xY0W3l+unZeoa9f+z?=
 =?us-ascii?Q?ieHn5ZScbLMgNdV97NfGXrsswfpH+45yi0TC+NojcgEy8pxPrePPvWOUBgTr?=
 =?us-ascii?Q?m6J5BsZowVV8x1UPg36XuP6938TWBEudDKg9oqn7p/e6ZeJfCB+OVDoiNJ62?=
 =?us-ascii?Q?1JLDxXhnoRqujO9kjz4cPbcfw0xIh4SGtzSOeQCCGDAb8e7t2D97MvelqFAG?=
 =?us-ascii?Q?HSoJjiTB14CLnQ5EQKjJDSj7E2i4JPXYGWEp2ztujxNf2l6afA/sNvCVyPQK?=
 =?us-ascii?Q?IT94C7D0J2Gf0TNbDtNCiydNJseMI0OWXekYdqSEG59Q5t1RRGhzUhysnRKM?=
 =?us-ascii?Q?67A0HMGTG4xxDM8+gR9gAMwYiXM+M2oW2WK4S8x+J6bDTmqT6SHCB8LAbjx3?=
 =?us-ascii?Q?kkAcsDxdaKCvY7nSkOBHhAJiQo2P3sHCFcmKZ4HICN5JbtCP4vOvDRlpDIA3?=
 =?us-ascii?Q?99CXUDWH8u0cGyJ6VDdHJYsOnR9bJUATJsE4OPRn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lFU6RmeedhesAH/s/7P8yH+KDR6hQ50QU2xt5t+fHlDa2IqNfED7hMOwiAQ2t2lHlnLsWIym6jJ67Y3SvtqK3GQ8msTivQaDUNaplXMoo1aZU/AqaL1inkBsmmf3PGjo2azA2ff9nlHQeEL1v4uu+4pS/DxAmJFGSbcpMoVm84X38byHm8gJSidTw5A5SmtUe7NUpi8LdDIAfefEuVWhmMtnfeyZDipinKVKfYy67IpzYL3GxaQgngjOHjqJCy4WFI6xhGQbxalZJnFiCMZ/krgvwRsNVpCKfHadaJ3MK8y4gxl7EOthqLw4C8S4RlFsIc/1niV4XY62kBB7V1iD0J56MnII1r573CeZgYEo6CwQVfXlxRnolZtDbtAzSaFBowWV7tMyRceo3ePM9i+bNa9bzKDthUhOsSIpFIZATrTh+ba9NjXCs/kanYhRnhtEj6f5oMq8QA4I355tWzMpAsLZT2FZYtDTU9Smds/tQoYtBzP/fHghLdfh6oIk+z+e0dbw2qg/XbN695AybMmMQIzGfue7YrMusj1gSvJf8HGYMVWJ+3E0263eX3R0459Y8caIu+uKcAVghgJCigIAG2fl9Fc3a/NzAdWJ94L5D1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d989e53d-ec7e-45e2-9a37-08dc6b50c35f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:09:40.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX46imnnNzLbw3nzZJdSuidXg8SQy3uB14oPZMG7u4pG0+E3puPCRznC2L0QgjPoau4hkDk2+Ul5fVla7wXC3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030065
X-Proofpoint-ORIG-GUID: b2JwpFbWZ-89KMtfLpokf4X6LFl2CCNV
X-Proofpoint-GUID: b2JwpFbWZ-89KMtfLpokf4X6LFl2CCNV

This preparatory patch adds an argument '%prealloc' to the function
__btrfs_record_file_extent(), to be used in the following patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/extent-tree-utils.c | 11 +++++++----
 common/extent-tree-utils.h |  2 +-
 convert/main.c             |  9 +++++----
 convert/source-fs.c        |  5 +++--
 convert/source-reiserfs.c  |  2 +-
 mkfs/rootdir.c             |  3 ++-
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
index 34c7e5095160..2ccac6b44cea 100644
--- a/common/extent-tree-utils.c
+++ b/common/extent-tree-utils.c
@@ -122,7 +122,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *root, u64 objectid,
 				      struct btrfs_inode_item *inode,
 				      u64 file_pos, u64 disk_bytenr,
-				      u64 *ret_num_bytes)
+				      u64 *ret_num_bytes, bool prealloc)
 {
 	int ret;
 	struct btrfs_fs_info *info = root->fs_info;
@@ -229,7 +229,10 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
+	if (prealloc)
+		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_PREALLOC);
+	else
+		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
 	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
 	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
 	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
@@ -265,7 +268,7 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid,
 			     struct btrfs_inode_item *inode,
 			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes)
+			     u64 num_bytes, bool prealloc)
 {
 	u64 cur_disk_bytenr = disk_bytenr;
 	u64 cur_file_pos = file_pos;
@@ -276,7 +279,7 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 		ret = __btrfs_record_file_extent(trans, root, objectid,
 						 inode, cur_file_pos,
 						 cur_disk_bytenr,
-						 &cur_num_bytes);
+						 &cur_num_bytes, prealloc);
 		if (ret < 0)
 			break;
 		cur_disk_bytenr += cur_num_bytes;
diff --git a/common/extent-tree-utils.h b/common/extent-tree-utils.h
index f03d9c438375..7abd0337ea0b 100644
--- a/common/extent-tree-utils.h
+++ b/common/extent-tree-utils.h
@@ -31,6 +31,6 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 objectid,
 			     struct btrfs_inode_item *inode,
 			     u64 file_pos, u64 disk_bytenr,
-			     u64 num_bytes);
+			     u64 num_bytes, bool prealloc);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index f18fab4a236c..d67c4e8eac25 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -337,7 +337,7 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 	}
 	ret = btrfs_record_file_extent(trans, root, ino, inode, bytenr,
-				       disk_bytenr, len);
+				       disk_bytenr, len, false);
 	if (ret < 0)
 		return ret;
 
@@ -426,7 +426,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 
 		/* Now handle extent item and file extent things */
 		ret = btrfs_record_file_extent(trans, root, ino, inode, cur_off,
-					       key.objectid, key.offset);
+					       key.objectid, key.offset, false);
 		if (ret < 0)
 			break;
 		/* Finally, insert csum items */
@@ -438,7 +438,7 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 		hole_len = cur_off - hole_start;
 		if (hole_len) {
 			ret = btrfs_record_file_extent(trans, root, ino, inode,
-					hole_start, 0, hole_len);
+					hole_start, 0, hole_len, false);
 			if (ret < 0)
 				break;
 		}
@@ -455,7 +455,8 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 	 */
 	if (range_end(range) - hole_start > 0)
 		ret = btrfs_record_file_extent(trans, root, ino, inode,
-				hole_start, 0, range_end(range) - hole_start);
+				hole_start, 0, range_end(range) - hole_start,
+				false);
 	return ret;
 }
 
diff --git a/convert/source-fs.c b/convert/source-fs.c
index 66561438866e..9039b0e66758 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -262,7 +262,7 @@ int record_file_blocks(struct blk_iterate_data *data,
 	if (old_disk_bytenr == 0)
 		return btrfs_record_file_extent(data->trans, root,
 				data->objectid, data->inode, file_pos, 0,
-				num_bytes);
+				num_bytes, false);
 
 	/*
 	 * Search real disk bytenr from convert root
@@ -316,7 +316,8 @@ int record_file_blocks(struct blk_iterate_data *data,
 			      old_disk_bytenr + num_bytes) - cur_off;
 		ret = btrfs_record_file_extent(data->trans, data->root,
 					data->objectid, data->inode, file_pos,
-					real_disk_bytenr, cur_len);
+					real_disk_bytenr, cur_len,
+					false);
 		if (ret < 0)
 			break;
 		cur_off += cur_len;
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3edc72ed08a5..c67ade9b4c90 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -365,7 +365,7 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 		return ret;
 
 	return btrfs_record_file_extent(trans, root, objectid, inode, offset,
-					key.objectid, sectorsize);
+					key.objectid, sectorsize, false);
 }
 
 static int reiserfs_convert_tail(struct btrfs_trans_handle *trans,
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 4ae9f435a7b7..cb6659319b7d 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -411,7 +411,8 @@ again:
 
 	if (bytes_read) {
 		ret = btrfs_record_file_extent(trans, root, objectid,
-				btrfs_inode, file_pos, first_block, cur_bytes);
+				btrfs_inode, file_pos, first_block, cur_bytes,
+				false);
 		if (ret)
 			goto end;
 
-- 
2.39.3


