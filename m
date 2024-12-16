Return-Path: <linux-btrfs+bounces-10426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19089F38C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B818959ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68064207DFD;
	Mon, 16 Dec 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHmsH5X6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jgclvUK8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309377111
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372872; cv=fail; b=hQ0GYgd7dWK7qyJ4Pk1QkYCXn1kjJSTyTQr92l88i8ZVeLAzYnb0GHlko8XRsPN11o17jGijYlFMaYq2JJH0A4ZqqxVJflSoHOIa7V+a54MAAlvswar1m8bQsLmPFZYjHiVKb9g8/hh+A9ST+ZicKpVtgz8BDvbvHsqGs8TrkuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372872; c=relaxed/simple;
	bh=catKPpZAKNrL55SbrKeY+XrctNzcXbVIuqBjUzgvLqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7XEFF3e7MzjLiiFbf40Upe9joX/EwHcpue88H1FEm1kxNs09dC3XZZvwlIe6fSDmMTnWnty5Q7F7Zik3nylxNAanZwVatg1ZOUkwAfQCqWw0qch8BcYGL3Ij+EGOIcMJs4dCmWvhvfMJo+DDAIJ/2iwdnSRddV2wad5NqTH1us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHmsH5X6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jgclvUK8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQilN017622;
	Mon, 16 Dec 2024 18:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mjL7mbQyMpDTrW9c4b5Nk3TFldFk9/wesL1py8gk2R4=; b=
	PHmsH5X6eqYPOEUTOV6OHWsqqLVZZjVM7IoIGFzIfIf07OwXa2lGjJE/VLe470vm
	fcvtkuXHxc1InOYvzRRbDv2FPu2V2h+nJJCUKIYZawq3+ud1sOfZlr3BVp6L+wCO
	BsvjL/eReiHp6D2qMymssncWvz5fLuV+lQzjFMrG39iLPFYRUwSu9rGdazaoUz0+
	00MrG5xs3JHKDuI46pmaAmFbtS2b8B3zQsMPapn5OY4xdSYCzc/ipx2HDNaCThCG
	iI8KQri0a0aSvqgACISS697+hkpTkBBCddDLtrxVdO11RBJJFMGHpIvajwmeU4nZ
	ageUqwQvFJzKaVruY0+eVQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ckxtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGH0QMl018267;
	Mon, 16 Dec 2024 18:14:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7mpy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkra7QP5igdlOArN9NLjyxa6IICEKz6kEP7B3uOChoxrGUXOknHQC327RxZlo2VbZ6rnHGPDs7rmGhP7qYro0TAe/4VM/9goGWrVnf3R02cvxN9QCKGxIFXs1O1ppx5Zhcqz0JdJZ3mchI0QmK8pnyYzuPsn0/nLNamIGhI8O2O1BG1mgXjWlb0Jvt92x2HhO2Vfskb39nwY//6A/QsFlyUKUjqBGEceolqmnZyEcAd2M5JblvSCXV3z4PAy9zZXp/x+e2wEwdkf2169UdweavEB3e5dn6vWbACSvsBgszHLHRafByVi+itwDESOwN5Cfs6hCFooG5Tu2GXcpPI0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjL7mbQyMpDTrW9c4b5Nk3TFldFk9/wesL1py8gk2R4=;
 b=i7HHcR/uc3OsadYxSVIQKfMMqEfsBeXEgyRGQgqs4gYItAw3IbxyHdxkdutRNt/o/gu9gzaM3kPkxXJqzpN2RcL5o9JdS3PW7I6L9DoVtqjjqYQX7lBcteEAi/NqTRZ3D+wYF6DUELmkgXPtItRjAa9qDxutANDSvv5oLfSbKeY797WGU17PDKrtUFooflB7XihZOdFyapDuIoKLOcYnQfepikDSxMA+PE2a+1bmFYlwpMjDIJw8j3rHvJHYPEqV6oUsj09kBEYzoTHUlP9CL4a2gVNX6p6H+U+bBvpUjnphU+LWkBUCcN12HcKMXb38en86UpU28nSfBJUmt/IvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjL7mbQyMpDTrW9c4b5Nk3TFldFk9/wesL1py8gk2R4=;
 b=jgclvUK835PESngkzl1bMS/F8R2CcofHxTtLvO3/k64h0EhwLc0jL0BMid9JkEbrbJLDxRWKh4xlyCEJURFDrZAFwwgfpchwToz6V2Ej0guoAuHVj26ugMDBN3SXOTJGkF/InugjeWchQT8yorvdytxJKAt/1G+5QD4/o5rVUlo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:14:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 3/9] btrfs: add btrfs_read_policy_to_enum helper and refactor read policy store
Date: Tue, 17 Dec 2024 02:13:11 +0800
Message-ID: <9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e4aac4-8409-449c-1a78-08dd1dfd6c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mS8MWbMmlOYRrnlbpTiRkhUXVC1DuIUdyNvgAqbQJkwMpmUbMPv/LkuHFSk?=
 =?us-ascii?Q?fdnf0shV0hYPj/I+mnQhKcYlWCRWfKlVoY6l8RmY2JylLXOxmgosHzdOyHtu?=
 =?us-ascii?Q?9LzLHLeIPltABHM74qnV5CtCmeuaQJ1GhBmC+VmOof8CUjlCeWvgaH3znLWt?=
 =?us-ascii?Q?SKET2p1CJYC3L0U5px5fOzC3NSA7uTYa22fMVAYmHKO0YKCf8yhRvS6LK/QP?=
 =?us-ascii?Q?5grPFteHbdbzVdxBp659QKGwfvW60VxRYQxHxjeu5Wq7uXnBeOvu35WvyeB7?=
 =?us-ascii?Q?VS2urWdkpXJ7UM7hLNSzGcNo0lYWI3/imfgsxWh1qe6ROw+rzBJv4qtb8muI?=
 =?us-ascii?Q?V+E1suTa3fq0pIkR6iQWDbQkBL3TxthAF23IWPUHQNIJ6XJlVCNXw0iqpVXY?=
 =?us-ascii?Q?NFGuLTE1HyggCei9sW5TzK8bA3qViKUANXXyKPk1d/x0yGi9aoODVbsSsvL5?=
 =?us-ascii?Q?3yK3VoU/RcZmiQzIcN3HatE1pAc1YdB1B+stV+aRWz0B+AagmCfov8tpV4i2?=
 =?us-ascii?Q?U0iYwu9+L3M5Q030E5ZPHD3aLxAiRqDSvCFqpuzDkS4CAu9bcV7LYRB8F3Lj?=
 =?us-ascii?Q?b7kTw5Yq90glo+SZr9wpaxfYPbsetA4srHO3KyqSUUdOCtSdqpzgAnciW1Qo?=
 =?us-ascii?Q?IEs+ViC+azjic7QL6dOGfSvs/Qt/ojl12C7ohefUrMOzTNgobMwfjDW60e9v?=
 =?us-ascii?Q?yfdIPuppnQJUoFy0Vb5Y25GZUuBg2Gq/KI1WWSiQ39mVyE62ZYlu1g6YG4O+?=
 =?us-ascii?Q?lPx8nEBoX/IcfPm1yBLUbVuBoNdSkpFmEZnFOhlOgE+PdWb+LS0A8sRUtEG3?=
 =?us-ascii?Q?dCEGPmbZowG5giDG/sEKTL0Df00kF28eYSzrAr5zN6VyAVhnTqcA5whKrzCU?=
 =?us-ascii?Q?V7kxgeIsmo9/717tv41PhpkpwAZGAz68/znLXwtX64hc9a/CzLlPmkqZY9ZK?=
 =?us-ascii?Q?bYE+FjyrImbPr4YvLgOVaAS/1bukumi4GTUHhvTPPHBx0bi2/40XnCYSDPh+?=
 =?us-ascii?Q?K5/X6ky9czrNUgZ4xYhssHibBl4jqY0vhR7Z0XS25j8uRGrTCN+R8qyL95Cq?=
 =?us-ascii?Q?oe6zJ6vdU+gBlibC28quWMVfqtKPglitgjBEwdLduBO8HuPBh0q/tvs1UHhl?=
 =?us-ascii?Q?x4KM6KZmMWyml+6/JHZb+T/jcMiFuCMgGtcUrB6qFvN+3tHHbGtV+7lNQf66?=
 =?us-ascii?Q?PRJysqY4td+C/eTYuVgK/Ee+ggQ9uL7fP0b8ebQ1Aez73q0X+3MUUxxWHPhB?=
 =?us-ascii?Q?Zezr7TNeQfTIILfeleLqGS2JMTE/RSqLRZdaOdsZ5aVkUCltnZ4JTSZIiDcg?=
 =?us-ascii?Q?gKhgnrlTxiU1xtuK52l1ZXrCJ7hYTs+DM/43eHJkL0o04Z1mysEmBKiocZY4?=
 =?us-ascii?Q?VSDnx37ml9Q+6XaGuBg5N3AYEh6w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7MBYiNpkoebnro9Yp3Uq/FieWpexxqGXBxb7+13C4KLtyQcg6+tEq/XY9jX?=
 =?us-ascii?Q?OUn9gCHwuVL5hhjiDdjuH/PujwrZbgikjOuKeD48aHo7sLThbSwVP/OWm6YY?=
 =?us-ascii?Q?O2uPVG/nqG3hE2NRBpMNpDaUa5M+vc686oUX0kssUFy83Mi1jTKguZ+p+V74?=
 =?us-ascii?Q?BEE04t6SDO696xUg2H/1iu46gFKU2pnUJUXvMKP0nkYL/H5hNhhwYK5xx6OH?=
 =?us-ascii?Q?oTboAndr9wliVuQGjoOqgtk/xEPsRw8yObV9cvaFGyezZlAde+yKuHQ3U+2A?=
 =?us-ascii?Q?kgEX5Rf+CNldq6kFRf/YeWzendyiN+Q/c0b76LxCXXKtHvKg/C4TyzFLsTSF?=
 =?us-ascii?Q?QIiUh+c0dEUqXxyfxmfzlBDQsNeoynzV/UG9Wzi7hmLYnJw6x/lHjJ0UwNmP?=
 =?us-ascii?Q?DCVPAKdVNNh4cIxaaXwulhDfdw5+2xIYr6Q8Kmyje1qa86K9nn4SbiWCR7NJ?=
 =?us-ascii?Q?8g8U52ouI14g/wKQ6Vho5z+2WdeNVbKRc5nKJF/lKFmzD7BIV18fpaQbhM4M?=
 =?us-ascii?Q?lW0U0NaP2/UsoL1kkf+zf8US6e7SmekdxpMy6WjvLA4ksMx+xscvdl47PMDl?=
 =?us-ascii?Q?vdNwQNrR+s0MM39g34Tmwa84leVN/DO4WttxYz+BTJoGjKiLV/2CoWh7L5Cb?=
 =?us-ascii?Q?AC++5hlpRbJOzYZWYtrlflMp2im4pFxc8ywhTwmwN82vgPOoLE5h/XLDH65h?=
 =?us-ascii?Q?HwjWRJKYPOdPkiPVE02hp5LKahKWGTCJUA3Q1ukqDNJF48GrALUBi/IrYaQ/?=
 =?us-ascii?Q?KJFTSVx7Gb8kWTcVBWDP7zhnuwVHGYkk+QFuYzopKQrcO2LwCL0fscP4HndN?=
 =?us-ascii?Q?jvYKePIA0z1wD6fJVHL/Qw5DV+57/CXBMlKd0m4zkZBRSNRzdQkpe4JPCP7q?=
 =?us-ascii?Q?PmrZ1bHn1ylOIh3HkfRwm5qSg1eXJANzwnF0fu609P6xF2qJIFqZKaczFqU+?=
 =?us-ascii?Q?dKPt/Aq5ieG+M7kaXIUMr8Es93YwgX0LRMIZ5wH7KKCORG8KOvqY06gdFlG2?=
 =?us-ascii?Q?FTdf/cq20bqzrppvpZJ7/ubOwtQFWeH7iXt9jubOKol9w2prwOn0T500TIup?=
 =?us-ascii?Q?sQLqLvJQHCzJ16ae8p5P954DHglp9SQNG9H9pqO7sZZuW6NmElPwk0PL+eK7?=
 =?us-ascii?Q?jlNNnpOtAlZ69ahgpZRK4it4cUY3Duf2wtnE9pKNVEQZsXQVTmk4M7RHd++2?=
 =?us-ascii?Q?JKcN9DGom9ROeb8OXpbIVyo/sS5InngqLn2HOcgXG5W5xiqbrQRgfSoXtZ1W?=
 =?us-ascii?Q?rVfibND37PvGJnEFcrtMjIkK0i8osTJTZPLJ/3Nh+N87SSCD14vtRruKcYCw?=
 =?us-ascii?Q?+6SOGAUZFCAx140XtwfCyavYMcvvPHBFmM78PPRzX8EdCbJ+OVHXv4FrjRvs?=
 =?us-ascii?Q?hvxyj+TdeoWjLhVfcnRoDJvbVPi1y64EOq7dZBHYHlnK0jyp9FhAXt1jbn2Z?=
 =?us-ascii?Q?vPGeGG0l2dU6j2uvRKH3ggfZfxpFq8hOa/aSSuXJup5lQ2quo675CgvDQLQE?=
 =?us-ascii?Q?zusz43LPtWZtAeQPL9+XZNE3BalxELtOKzG+AR9qr/xAjqeIRM/+XiFfrYIa?=
 =?us-ascii?Q?Xhab+Wusavb48fuWHSWn0mP3IOiARHh1m20iHtsr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C64hqTcIMQ48HPBK0aI2OTmnW3mY2XG2jRDVZnYULZPpKBCcdnwLzIJ9Z1lfLJQChtDm+vfs+oqs8Vd9aLIucTG2XP3pjJJERkSMoetb3QaqV3ayPNduuxd/uogY4jdBWHQseGVvB86UlP7t5Ts73K4KudhcUmlrwovvxTNAK9CPJuA3pKv0bSTg/nl9syWkLFzQBIkmJvWPXUgrhltUEZjtdq5R6B56Cd31OTr4W4pa0NQux9cTtAXlLHxq24re8m7hPIxhKrkyjZixIq40wjqqO3UW2HLu+18qICXn/woDO/j0WFVj2/V6F4VvyBHTj8AlKyOYZO2S6WZM3U8P7PZb6HqdaYp2Yk892I2pOWVPxKDZ7sHr774ReXuGblkLRZuzvSVCNh+yV3rjfG/36ABEnCFETXku9QllYv3w9f7i2yRJtDJT9DfiMC7o8Ujb0qguKpmSelhtoKFx7KYbdGO7IR5P7BVEeDESEbVHNdStIxML9kB0dFYzgMYkH9R93ecX8hWyfI/IR/CEYeEewW+TI87zEGypXvI+Wmh4sJFF9OXVs3UcV0hbj0kVNETsg3OURBtskOKmg84i/Rx2oI/otjc+AvhJ1tL2kQY8Vmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e4aac4-8409-449c-1a78-08dd1dfd6c4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:04.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ape7qnfgvEp4infxODEXijFbJV5afcU7Mlvz3C0Us3d4MNQKucQ72D6IEXc5xl8yE6FGjwgBfHoOHzTLmk+U8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160152
X-Proofpoint-GUID: r9tlJU4PA16fSigNfdyi6SWjzlOHDKRX
X-Proofpoint-ORIG-GUID: r9tlJU4PA16fSigNfdyi6SWjzlOHDKRX

Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
conversion of a string read policy to its corresponding enum value. This
reduces duplication and improves code clarity in `btrfs_read_policy_store`.
The `btrfs_read_policy_store` function has been refactored to use the new
helper.

The parameter is copied locally to allow modification, enabling the
separation of the method and its value. This prepares for the addition of
more functionality in subsequent patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fd3c49c6c3c5..34903e5bf8d0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,6 +1307,30 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
+static int btrfs_read_policy_to_enum(const char *str)
+{
+	char param[32] = {'\0'};
+	int index;
+	bool found = false;
+
+	if (!str || strlen(str) == 0)
+		return 0;
+
+	strcpy(param, str);
+
+	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
+		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		return index;
+
+	return -EINVAL;
+}
+
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
@@ -1338,21 +1362,19 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       const char *buf, size_t len)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
-	int i;
+	int index;
 
-	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != READ_ONCE(fs_devices->read_policy)) {
-				WRITE_ONCE(fs_devices->read_policy, i);
-				btrfs_info(fs_devices->fs_info,
-					   "read policy set to '%s'",
-					   btrfs_read_policy_name[i]);
-			}
-			return len;
-		}
+	index = btrfs_read_policy_to_enum(buf);
+	if (index == -EINVAL)
+		return -EINVAL;
+
+	if (index != READ_ONCE(fs_devices->read_policy)) {
+		WRITE_ONCE(fs_devices->read_policy, index);
+		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
+			   btrfs_read_policy_name[index]);
 	}
 
-	return -EINVAL;
+	return len;
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
-- 
2.47.0


