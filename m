Return-Path: <linux-btrfs+bounces-4756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4D8BC60B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 05:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCAC1C20CB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC49358A7;
	Mon,  6 May 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WTphUCxR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tnJp9CxA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EE41741
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964729; cv=fail; b=ZzcojBP8W35M0rQhh/1PFsNptD2NVbd1v0K2v2PjzUUL0SFVhdyX0dvM4F1H3VRGwOPUaHedkCykRR/uh0qXqRuZBOcBJS8pfDZSwoGNcADMmjWCfXsiIS/asZOBhX3hMeJFnZtT/bc0ehKkwqoPmFH5BWCoU6WtssT2r85Flpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964729; c=relaxed/simple;
	bh=jSt6QxkEGSfVN6nId6eeMAlQud3YirwlktEvUWtI8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mkCYDbPRh4P0JhtWxx/n3jVFNWJHEiJvf2xmtfFScwjlssdGyLQZxq5WulKvSONSNucg+a871g3G9o8zPhr94baotK3nb3L3yxNCwWBLG4v3x+p2J9NkJQleTSvrv3bp9NpYEgXZyk3qzBmhoJ8fd4PDU7pU9XIJHuVuC7fwexA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WTphUCxR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tnJp9CxA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445KgJfd008164;
	Mon, 6 May 2024 03:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=WYPwJNZdDX17FlBIXYKZfKFS8Psj3NtUk/+fZ7d8EQI=;
 b=WTphUCxRtp1Mix6spiYXwQEoLVml1XWyurPSmCzasXJtAunXZQhukIlOytg82wNr7/Ux
 Gk7BdgXW9jqj5arRDJYGQq01kux8Fi20m4uJAhbRLLt08bOwFmHkPXDaO8JY5DDTJED6
 GSE/D6E95TxCHyPPhs/rZa+d5CdoYTVfGZ+y66GTgmoLK7U9StdIEgUmp+TaOCnFV1/d
 G4f6jpiryPdOmY7+Fs4AuHcApdjvna8A8r9rh3S7sbwiSio13Veur1dib+aeQQkE3Q86
 LCN/4UEpYUu89nviPn2VCpVHcFLNnCkorqJW6wNrTh2GO2YHzSu6WyvL8eLesmFr5fxa AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt51pap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445NsNZk014158;
	Mon, 6 May 2024 03:05:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5bp46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 03:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRkN62vOxlst2/kFXha4FSej62NNd8VGLhAdA6bX+XMs57xgK/9IwyzopPwHyTilqjiiyl9Qsdb6YKtw54OJCs27yy3aFtR+CJ5angeFKlVbZadc4BQBrQde0fWtQJ0n9Z6pQGc9LXyDasuxxQ+Y2RTxt0bctS+zwliODU6dxE2OVV3DgYtqVDveLmFzAdr/5OWvBWfHaVELHgIdHWQp/TvAO4Zaum0cX85+vqfNqVLCMraKdpWkaqZsGwKl56ZhwdNjV9FcwxiRSy9YJJ9taWrQpu4xHxeQ3nrRvmFlpEUEJ8tvZHIPBpXojiM0VDBRMxvmBkUY7aS4Tp1LWeGJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYPwJNZdDX17FlBIXYKZfKFS8Psj3NtUk/+fZ7d8EQI=;
 b=V2rXXGn60HzXdxAM/aOgvo9vkwpBAzbpT6BFQcc8mNdBIhgXeSgwg8/OAd1AgNrfZPP4/QZgH/w+4npzrlS5aZRQwbjmnVjN/1+w6bbtfPrbPOG3OBeEwCmTFw1wyryiNsJa6XidmMbv8gHuDZm/vvQvu+HS2RKiAAYpxDarVIHyf7kACTAgJNIl2NblS8TU6IwFVAVcWEd0oDqFv59792JtaakmXZg6X8bXZvd63AxDjJfHyELcw7VPIF8DpCeI5ReRLMK8eRqsHzoUIe8c2gHVkqOSRG3HqKI9spr6Goigz2s45iyKcnjxO9Ju2WbFhwoJ9ItRQ0unyA5EFu+XFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYPwJNZdDX17FlBIXYKZfKFS8Psj3NtUk/+fZ7d8EQI=;
 b=tnJp9CxA3B6wjGso8ITrRs1uBrm7Cjaqf/RCtOxUC9vVtZEU5UOJrD5dfEhhBtlqafbamExQKS1SIwE4SB1pWechztX+uvR1CwQHfTOdbMB5Tx0vUrN7PiZ22cayEPDscDyI6onFwCDctR9jhDMXjSX7TDZznRpg+oRUhL6MxAU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5975.namprd10.prod.outlook.com (2603:10b6:8:9d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 03:05:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 03:05:20 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com, dsterba@suse.com, y16267966@gmail.com
Subject: [PATCH v2 0/4] btrfs-progs: add support ext4 unwritten file extent
Date: Mon,  6 May 2024 11:04:54 +0800
Message-ID: <cover.1714963428.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 5833435d-f412-4a94-5004-08dc6d795d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SSyi7SiitvPEAUI0ziDhEeiSylG6Sfw/ZJ7Q4UNhMIHlvkr6CZsdylZ5gbAf?=
 =?us-ascii?Q?gLiWKUJL6TlechH1MTFjZNEVZ0pv1vVSuMu7mEPisM1Ozt2HHodBsmDmT+tq?=
 =?us-ascii?Q?XQMV8GWcOBSlFEffqbSK6SMY/mSunRdX8Zbn03IvfGkofN3DlI0JxFqLFj7o?=
 =?us-ascii?Q?zS8lX7K8klTJmnccHmPUfhofd6Nfz2FnjKM1QlDYs5VJ2T9srxu9Y5y9tqFI?=
 =?us-ascii?Q?TAje9PMfKdF4BiYzN7JpnvFzPfPMLpDximUnsKwHicge8zGv+QlKJey67Ted?=
 =?us-ascii?Q?iVKmDVA1EL5Feg2W0SGkEVvqtn8gBp5Mx5pRBQ8yCt9rZVjnsfPoIZQme8w8?=
 =?us-ascii?Q?+Ha1vdr87gOLlWwGdZGWB+Zsm8pdiJDBqe1gmA3+CFN/io17ib0Y6q7YfdQ0?=
 =?us-ascii?Q?Ok2CZgIlmZjZ4MEya5XY8441KYbNtmBUOLZfbUOGXKHEUmofVu8bKygLSD7B?=
 =?us-ascii?Q?47x4r9RiVKrzGv0VpNX/Yw92LSa4G+ymfTPVp9NMyIykZANDyQ/JuAkGnX68?=
 =?us-ascii?Q?VkFiKtcEZgUaWrFSY3OXFQFoDpbJwl7Gw7qsZgCBL13scP7JhGvs+FYrNjH+?=
 =?us-ascii?Q?7ag7OV+4cpfWesDBWmg7rG1ZJQ/mvcav/AV/hKHT5Q++WslftcCUKzDTqTg2?=
 =?us-ascii?Q?oBjaMA9TfsznHLyLpzZd8KAHa7lZXqpFhtQ2qFYKsjkXGhjljLw3KGX9Jqa4?=
 =?us-ascii?Q?K3DnkKLwn3hy7QJO4ECF+cP/HIDbSt2ZOOzvL16yGb7BUqEYvSh0ZdEqmpW+?=
 =?us-ascii?Q?Z8kexU4F1+QHBVKnPWyuIJ3MInPRbpucpZ3+RxFGpv+dvGxk8bp+UYznhRhl?=
 =?us-ascii?Q?y41qSinV7BH444DzrkC6UW8ChTAFmPG8nuwICdsWN/9iGaZLWWz8u9pakTHD?=
 =?us-ascii?Q?NVkb8HKELgpfZmLoq2j5XJrT09/np4w3bHWsvUDiAwkK+YByW1vzkksuAKPI?=
 =?us-ascii?Q?zk8h3WMfng2YLXtc/cTvc5cJsPYwUUATEEd4QK0hcTfNqyecHvx6wxAwWlW/?=
 =?us-ascii?Q?e2ffdB6XJI3hcdqSQIfgGiujFqrejftX910R8X56o2cydQ+YI4PVEYA8GZSL?=
 =?us-ascii?Q?x3up0gOWR9Xij4zVCSRBh8DeaGe1oDWn+GnEyGtA8InR7ic03eB3q90KGfR1?=
 =?us-ascii?Q?ucuf9++hCsKGSLJjTrwrNdmmmDaQumQ3iagKI6KeqZNtPJmm0uFl+7MxztUj?=
 =?us-ascii?Q?2/IBKIT2eIkY8Bo/la9HPZXskqj2QvL0G6u0SDmpamcVcfhIJHr9CyqP15u4?=
 =?us-ascii?Q?xaC40rsieTSI5kCcrDMDYT+tkLCTSg9yupysMzHsCg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i1b0sTk99akNAmu+eBTUIVnEH6q9ZniIkLz4ISWHmJxr/k297PpsEBBI2DOC?=
 =?us-ascii?Q?ZZ1G7qDi1dnXJ4nZ+KGbsex44jDTowllySRX1mjbEGlrt1FL8eS5jSzx0O9Z?=
 =?us-ascii?Q?qEbVkSxUenuVWV9J3FiOy7yJas6FbbVmHMAImpaejAv52VGH2VXGbbcYL4fV?=
 =?us-ascii?Q?tlrx4wUQxP9//MTASbAghWnCmOzIwqDkwBTc6ZQFRTFU2RoImaANO+TAn6rE?=
 =?us-ascii?Q?lR5VUHioBf3FyG40l3skTbtQT1W5EDr//Mc7plcxWpIsDy+DhtHL3Z9cHAle?=
 =?us-ascii?Q?6/b+NWuewry/h8i67404H/xDRpGC5+sI7P93HaNPY34NgPb/JTjf0Hs/AbKh?=
 =?us-ascii?Q?j5ZOJcaTZaAlbLsEsoLch5guRhq9ToZVnIQAnDjZkomMnRcs5My/s/6nHVRP?=
 =?us-ascii?Q?k1gzR+XRwLnM9ehlfGSLXYx53Rt4ulzfEjg1rjNbz0dq0IX67MfSkQglQXgO?=
 =?us-ascii?Q?uE8DcJ1Jci8wLRRnAUe2fGqdn0lLpgmKv99arysrN9dyNn2KpCBnarmsHIj+?=
 =?us-ascii?Q?i23zIfi4aj4uibajOwLfNhssYuS19xxQ+taga5vc9Ie1WnAkjS9UgZeNKrgy?=
 =?us-ascii?Q?73zqQu3McwASxWaCylBorFEQ32LZbLw24wFOQvs6IdNCKkfm41GTFBoXvv6T?=
 =?us-ascii?Q?SVlTGv71j575nszRnxc1T+BK3098/8f6+4AqnJdkc0FBX0Rtdi5JlmZC+pVC?=
 =?us-ascii?Q?eiwRQjaLdyAR35TBRGdcL3iMxxNMrbV+fQyh6lNdhxoq7ddcGqIJnZbaXeTZ?=
 =?us-ascii?Q?KGqFsGuZQ6knou5d/5mrPrakO8UnnNu7ugRKZkiCX+8zAyoI9hxDWixuXSTd?=
 =?us-ascii?Q?SERABnOBuB+ezVO4eaGJJGYGnqs4atbO8YvQ0GHU7wFZBzQnDhJDKmREHcox?=
 =?us-ascii?Q?QHD74JKKNEH2L1EO0QnvnvKw8SXG41m9TZprKPzsQfOep5BmEjkxbJr0GAZB?=
 =?us-ascii?Q?uujHlbHjNL5rdIGHLrPCLz8GzWwvtp5FVJmOhxl3nIOPsM/R3zdMWik29MUP?=
 =?us-ascii?Q?YBaMtIY1Jtk4D4Lkh3We5e1rk4yVnxPwzBf3PYfXQmp33NEWsH1n5bK/KIOC?=
 =?us-ascii?Q?rY9aulrkW3ywcWMz7Kg9v3ZhfohJE3lrxcOgnSU1n5C3ovy/I4P4t+zPArLX?=
 =?us-ascii?Q?2R5piMA8j1Vu+0lt9tOazvzXrBwlMw+bH3k/N8r2DU65b5hLD7a9+UhmNKZ/?=
 =?us-ascii?Q?k/SrgzrW5p7lK8mVZ2fglz9gshofHwKqiJY68TXI/HrsK+mq0xZxeXnMD6H/?=
 =?us-ascii?Q?9xneDS5GzwjZxHhkZcQcpw3ytUNY/cN8EDjsHmqnZ6Kl+JfspxCzemSC9GNW?=
 =?us-ascii?Q?tT62yfW++s2c9rgwCBsw54VJxiiSnUVNf4SJhBcDnm3AgsTYJNF9HlOEXFQk?=
 =?us-ascii?Q?KbLAkbYuolXZLSIzMRUBSEUNOKplLW4UOdoN+LMdnj4qk95OkSs5mT2vThdB?=
 =?us-ascii?Q?f5awpk9aclpPXVovURB7vE6kQvu0YBoMbBAVHiVOEbV2kAE0DyRy+V7/J12g?=
 =?us-ascii?Q?w20a45jqc1VDB9hiQ5JExWAUp6Z99HFAUsDXhZnfCgprloC+/NJDN0cuyw+P?=
 =?us-ascii?Q?k5dpEV3KdeSzYn0aFbRTZGt/qLGSBovQyLfg6RIB3Sjm8F6RB+SxZEkN7Ikv?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	u1eH+kBym4T/VGxWsdy5rIxXc6qnuAmGyUD5ln1dDKEiQs2Kb+BqQcnVBCRSJgxvPE6D6b5vK38beH3RoSyoGuvPgs57vCgBm8q6vtHimHeGqVhcJnVwkaSIEYJ7hgE29TQPq4Cu7Yr7YTaeF3U2ybGi9Ty46coYMtQK6c09wJE/oVb8sm+WmvXGzZhNKpYjJYxQfbTY/NMxwTnL+FW3XazMqe/wqkJJtfahW+10DLtNUMzPu+lbRMf36H65V68dXH5E+wmpxJfYSIaJU0d+Q/qUcfjQUbW+QU37sg/A86S7EkG1y/Nfpyl8AqOpPDzCUzd4ORMCRtRFLM/QMUvflNoGYRtnfIG58iOzac5i3cmvFUkXchQIjLQWyPeuuFOR04NBjTjqEESrl8WMKUo3WRPSO67reASNrFgUjp8xltyOsiFqqHdwtw2vJzQn+wDE931t4PwDZ72CC3tWMUOBS92JhA8+VPEj53GdtEtIeDsUOptqFFqRpTDpexNZ23PQl03N1rpEv9NS/8OKokyum8GMoDRbBsTiHcLrya7QwWfdMiM0KCjue4dabGf0kA0g2xOS0lkRprJJG8R0pPL53p553nLtSPp8PCRmmkjxVsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5833435d-f412-4a94-5004-08dc6d795d62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:05:20.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBnaukqwKoPqv6Sj0+AexF7NUJ0hu9ptWXCq5J7EAUCykuW2eh+wwebu6BsY7cN1ytlHJca6Viti+iqe7x3JlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060014
X-Proofpoint-GUID: SFEQ64gwg3JdYPc7YMT8E3bPvPnRv2oy
X-Proofpoint-ORIG-GUID: SFEQ64gwg3JdYPc7YMT8E3bPvPnRv2oy

v2:
 Fix per review comments.
 Identify and fail safe prealloc merged with regular blocks.

These patches add support for the ext4 file data unwritten/preallocated
extents. Patches 1-3 are preparatory patches, and patch 4 adds the
missing feature.

Patch 4 is marked as RFC because this patch is tested with limited
variants of the file extents with unwritten flag.


Anand Jain (4):
  btrfs-progs: convert: refactor ext2_create_file_extents add argument
    ext2_inode
  btrfs-progs: convert: struct blk_iterate_data, add ext2-specific file
    inode pointers
  btrfs-progs: convert: refactor __btrfs_record_file_extent to add a
    prealloc flag
  btrfs-progs: convert: support ext2 unwritten file data extents

 common/extent-tree-utils.c |  8 +++---
 common/extent-tree-utils.h |  2 +-
 convert/main.c             | 10 ++++---
 convert/source-ext2.c      | 59 +++++++++++++++++++++++++++++++++++++-
 convert/source-ext2.h      |  9 ++++++
 convert/source-fs.c        | 26 +++++++++++++++--
 convert/source-fs.h        |  3 ++
 convert/source-reiserfs.c  |  2 +-
 mkfs/rootdir.c             |  3 +-
 9 files changed, 108 insertions(+), 14 deletions(-)

-- 
2.39.3


