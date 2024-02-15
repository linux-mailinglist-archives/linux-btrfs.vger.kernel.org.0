Return-Path: <linux-btrfs+bounces-2411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113A855A82
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333E71C26C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0AEBA50;
	Thu, 15 Feb 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVz2nkqA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zF9nx0TD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42073D51D;
	Thu, 15 Feb 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978935; cv=fail; b=S0BMoGHlhgjqfSrm7D2U+BVOZAzjW9BZn2YpBT6M4Z74QViXVWkwrukOb34fcWA35OoGAZDDg9VXPOTVLarrNUxdJGu7TJ14QWIh/annn8nOUlHvzGXfGOxK6SMKrkqF9bUZXK8YkEwg/bCpRSUu+QO3vRnB4Ss5i0owtPakqm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978935; c=relaxed/simple;
	bh=GDq1v+jQMKzgcpJM3E/RTly+J/O1U1bJBYTwoB/Y7ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sg2YVEfpMxEzu73fmctD39We05IhAcWI0UKL3tgmuh3rgZgPiihTGp8nfhLoO/3BWmbrVp7ELOmBiIR76hyRZEkoFsKf0a5WtcOhNC99OwccNBq9VEZkc+8+60CDGHLTo5+WyAC071+GtUkwVbaxmzqHLL85P6Mb76PNDLKa3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVz2nkqA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zF9nx0TD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhtDg007321;
	Thu, 15 Feb 2024 06:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GXjuM1+JPMuxCvuChu8heXqdUuhXbLpkMDAOUm2onUQ=;
 b=SVz2nkqApzEOpXZKtJCFpKuVPVmtYjCNLy2emOMNiHncJoIt20eXLgAPse17jk4YSBSg
 7zFphUoOOtIwPHQNNrBvo5xeS98Mk/9CT8pcywf+TF2bdMTvTojRQ31SU5Kxj/NBJm7D
 l26RUMD49CuEaLDAPRobnJ80n+ejzw2kxepN50GPiZJoShqCkYtE5ZLE0bIvcvZ1eGVP
 OmLrvu1TrMsoahmy1C0L6AdX6LdX69BU8T50kFC7Tkm4bOTEC8yd9NzZGLxyVYKFyuHj
 lp68XW2u8CLbD6L7P76hCWCrGOsykzLc9PEKUfM+0w9kCcEaARbO4VTN31qNlbluy440 xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0h5h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F4i5UU015073;
	Thu, 15 Feb 2024 06:35:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka297c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJDgRJyaY6lEpu+GeMI2I+UyOxwYLg5lxlwkyDofnn4gd3ELxBoWOTbdWvwAP8j3GtWr5AAMhzySowbw6eM1Bd4WNRi40l486tS+OYWsk1fzSJMXhagkB7ykvQEaYGi3jXK1byFs6nHelN0i47CgzVwk42CSQnSZby6DkABAfKyPgsBC2fgYKJtF60P+j6Qkvi9m3fBAaJjSJzfgty6S8fuSyGg3+5kCqYm2zqHgVbs0E2Tygxe7RfmiYmlARmNJJPb8UNi0VXQw8jkqtTYACuQacimJGrDZBkYujsadZMQgHskyxbfxVL3MpDIvx4tu1rJFC101sRR/RjFcJQBHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXjuM1+JPMuxCvuChu8heXqdUuhXbLpkMDAOUm2onUQ=;
 b=F1oFQ3vuMgyA5I93YxjetL1WIKlkVi2DMigyVq9tvnTEQtYxlYNSV5vS84XnHER05iGH8aO/Q0DM0O4kuYTmpIx6Ej0NrScqvnjuhNNmzslAU9+kT+Pt8XqBF6HAV1ByKusV7eP3H194+Wt4om7kGzhfKhfXuJng0DFM4SLNO9P4AIrMNsJjo66XhkYhAqpBeKC+1U06DmP1Ksq7zBqEqVrv0AVpNA8sQNUB35PUNpp5q1NjjCLYrgu09Yh4TGxUewdbW2kbAO6ZkVxyy3ThatjpCGIHLWlVzEKShDaPtgIGOs0C8C/IJ/upr3/DETvRbrQFJUS5oBThcJcNyzf9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXjuM1+JPMuxCvuChu8heXqdUuhXbLpkMDAOUm2onUQ=;
 b=zF9nx0TDfX8WLxuq03IuYCVhAfLwEZI0qXAzHUj2vWPfPvTqX+S1zFwmmVAnAeY3od2qCXWB9D9NBWpCTzwdPv+iDHyj4sdB/SeEngXKLwY+KEde3efKAmkiAF3/P53TUfFnHuUdbaiR8+XWlskRvMY06da9HQgIaPn29ceM0ao=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:29 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:29 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: verify tempfsid clones using mkfs
Date: Thu, 15 Feb 2024 14:34:13 +0800
Message-Id: <d59e5946ce2bbdb5dd954e715b15b9e834b88493.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d00e32-49f9-48c4-1c12-08dc2df04d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xyOmU/OTt8cRSOegirFR/yJKxpBblyf6oyoGpMm8ecZFrpOE8uRK/E8mJ5V4GS04fizcW8YjkCVi1OtDVYW9+6mvslMqaPrrD1s+q03rwZz/jp0EdBAS5JhwY5t99Ug8xj6bxHFrZRD/nlF/aMCdljoQYg76rDQFWuhqwOoXIi6Q0LUER0Ag15gXFfI3MEwCyttU7Yfkl5PfhsXspGrXLnvhLi2nAzKWBq3S6wV4W/1537W4Zvo1JkWiZyobrKThMfav4LG4L5IyjtAg/bcrUyMy6hwTRyxFVv7u5wGfyQ8qx8Zlruz3eejCXgwylFlIYbKQlzXsZ64AAGKaRiTM9sAagP0QpLkZCQ52Tgha3iPdtuxhWhi7xZslELCq3yGySROLs9qUFx7/BXZLHKZFY6y1bNZmz0evtEgCksWONifQwI/CUt1+Hj8A9IVaB0M5PoUhHzgoNG28KefgKRN0vpp7uKkEuuV4KaTOkbtHxw/NHA9xFBX7zCUsmvJYFBfS2SIQaandbQ+Vafc/bSQjROTl3o802PceoKWJ9IknsmavxTFFVAHBuIVyg9DS7y2d
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dy8eolh/j+BfTezhnIr6XuG/j/NMWzF2QU6159IVXS3rHhhQOJDRGnwnW+FG?=
 =?us-ascii?Q?I1Alw38ECdDS5ldmYlejEIgd98fbJJTRqPTHW+sD+SzU9eIY7m3sHqgi4a4e?=
 =?us-ascii?Q?WyoBDgxodJQEBxW2r3ft1b8HlKUHH31RFija8YO4+2XQvlGnugjCCJ4hjIib?=
 =?us-ascii?Q?aVKpbbrawJaQYiCBC/jkJthpccOPkDqmgBUtQW2XU9Np0qLBDMCeIsHRX03P?=
 =?us-ascii?Q?1p8h8eEx7GabaOEfo2VhmBPkJTKUdU2tzXo5cj1HI6qJ521iYJ4WVIxF03l6?=
 =?us-ascii?Q?5XkuxYWQMBjxoT09xIQ00l51mNRAXsy/noFgj6tAWM3DwMqS/ia6vazpxtwo?=
 =?us-ascii?Q?zby+BwqA2CeSP6Y34Bx4IHL+NdGbHIhjf60a+PhuQvN8GkFB6025tcOTwDnG?=
 =?us-ascii?Q?Hymfu4xnuJCet6+FAcK3OMt1ucnB5Q/nlcSFQeN5HGpl9YM9ayNKoyvjWSn2?=
 =?us-ascii?Q?L3iZv21JxjWRQLsSC2f2ZwPD5SVzftoetUUU2miMUuQjpw8eg8z9SMZ1z35h?=
 =?us-ascii?Q?uTFYBJdGFksSQG4EUUFfuV39PIsewTjsVQUPWz6TrxvyMGuDFktmh6C2kS9h?=
 =?us-ascii?Q?CO/uAZAH3hbmRMPGHaa19jyMu650nQiSmmNCk/1/cFNN0I70TmGAK5Hos5vg?=
 =?us-ascii?Q?lX0d0AH263UJ9WQke/lIQcWxtw2BH3XM2PT7VFFlxSXi/4GoPoKZkyFbFk6B?=
 =?us-ascii?Q?uFg4HR0N6hvfWAGi/R9CDYZsDGMwOZZUWSVQe9EpJYLUe+JGxuk7LX8Fq6M4?=
 =?us-ascii?Q?Aj521gJ3+Z06GyjUfW8YGKnhSyVJa+ipWHhJPhmq+8W8VOcUcaYWxyakevn3?=
 =?us-ascii?Q?V9fMzNCNUBDw5im8sF0ju1/QpjC7QPVe0qq2m1/XquWYjwV08kkPYYbQhNn0?=
 =?us-ascii?Q?AIDJ0qD7+i70ld8DAod1ZY1BcbGsP8MUXmz/TTVFVObtqEtePnAeRC5niWsn?=
 =?us-ascii?Q?n8qd+53TBe29bPw4k2Q2WjcXVQO2NQTVTOKDT9KTujyQMhs3z4e8R1akDJm/?=
 =?us-ascii?Q?85+ExH7HQ1y6dYT/uXqkZeI3mmAghIk5gff3dVpjZXUbGYYqO37UPAXFevaQ?=
 =?us-ascii?Q?XE0o9NAEyRhAHtiOiLtdeEDWrWDaNehtFxCYYa61cNw+D+D71x5ZDwTa3qkw?=
 =?us-ascii?Q?Mwhc1MhYntdOhiQzaqcJmaMFlGWakNVdB97MXCdN535S4DH6A77MffR9OEql?=
 =?us-ascii?Q?9Jl9VzmO4WbtJ56DgmnCBlCqiZ7yt/1sFw6kqPuLTO13CH8JpRorZoR3Qw2/?=
 =?us-ascii?Q?+s5Pkju3ioc9sqnpkw3NAraZHfI33xA+H+nh4JOhGV7/oyf/uwDGQ202VfRk?=
 =?us-ascii?Q?s4PhFxaiVH75mXtPuqt7BL4+7K+y/xFC7eBKLN9hCXZEsUTNOLCACJLta65F?=
 =?us-ascii?Q?BejW4+PdDkGR1YZCBmdpFG9qGJ4YOgrc2+g4IhLya0fItCD65H1Guo7UWBfn?=
 =?us-ascii?Q?Utonun1YuvWJE8srlhY5Av31SFE8KkYk8vT6n1CPmvHpwzR30Jjz3lrQIFiS?=
 =?us-ascii?Q?jl36fyuT2ylwzGqzDRdJ+sikC3qTw8rbm5f/jksuNPWTfaUip0Knf0b4A0X/?=
 =?us-ascii?Q?w75Fcz2TcR0iiM48YhNK9NJqRrvTfsUh/giWS7dV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YbhYv2suZM8VZhY2kZnBJi39Voa858rxZqvvrhX4Zm8NQKWlxsZWdjVTwADclZtREP5KRVRV516pPxQ3LtIiGleVcmR7BMkgxruASfv2m/XlIG9MQCdoSSzbWGWcv0pAjMNE7NKJSoWBdn1RAKCLWxv001p4gMCWNEtFVw5qLUh4AO5ogVsIdW540TtaprjqiSRXbn4qv4F5gS+N/1svRRoGtc3mVVAEvs06mpRoh1nssVmtvGdx05q753TksffE+YA8Bh9Ua5Hh5kaUA9AcqT26EAyD+KiSt1zpg01snfGEKh6PCkjK+OTuySn9ufLm+BXqsguwfJc2qFr+0r27Pv7skgrLeaW7vrFNXFc7j/OvhGeMyoA6vtIEWbJA9lZsk5L9TvH4nUs8RDkSEQ5/D84PrJiMcsU1+hxwXOVnBCe9WVFrA4gUHL6tai60d+o3RDbGvv9BrdERBB1d5rVJqSSXVPC+t82TZMc9GCp/WhEsa2+VgU6lkVkrB12vKtMATTDgIyMTjBMXTjPdLmofvLn0bFcfZFiJa3yvlwEbODGDqGG4++k9guCrLqS7uYqaoY90uXGucIl0Rpxs9VWEF3ET0nnQ7ea/Vbx24h12Cas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d00e32-49f9-48c4-1c12-08dc2df04d46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:29.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DNwMczWFy6NAqP/ob+kmu2yz5B6+rnUvZlsfIqU/Ytp8+p9ydmNd9ISnyLRHj7hn+17Xx134CuWOnVNyKa8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: xkaYI3rxMjwMppIXU3qj5f-Uxy-O4A2Z
X-Proofpoint-ORIG-GUID: xkaYI3rxMjwMppIXU3qj5f-Uxy-O4A2Z

Create appearing to be a clone using the mkfs.btrfs option and test if
the tempfsid is active.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/313     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 +++++++++++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out

diff --git a/tests/btrfs/313 b/tests/btrfs/313
new file mode 100755
index 000000000000..45811320e596
--- /dev/null
+++ b/tests/btrfs/313
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 313
+#
+# Functional test for the tempfsid, clone devices created using the mkfs option.
+#
+. ./common/preamble
+_begin_fstest auto quick tempfsid
+
+_cleanup()
+{
+	cd /
+	umount $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
+
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+clone_uuids_verify_tempfsid()
+{
+	echo ---- $FUNCNAME ----
+	mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+	echo Mounting original device
+	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+	check_fsid ${SCRATCH_DEV_NAME[0]}
+
+	echo Mounting cloned device
+	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
+				_fail "mount failed, tempfsid didn't work"
+	check_fsid ${SCRATCH_DEV_NAME[1]}
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	echo cp reflink must fail
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar > $tmp.cp.out 2>&1
+	ret=$?
+	cat $tmp.cp.out | _filter_testdir_and_scratch
+	if [ $ret -ne 1 ]; then
+		_fail "reflink failed to fail"
+	fi
+}
+
+clone_uuids_verify_tempfsid
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
new file mode 100644
index 000000000000..7a089d2c29c5
--- /dev/null
+++ b/tests/btrfs/313.out
@@ -0,0 +1,16 @@
+QA output created by 313
+---- clone_uuids_verify_tempfsid ----
+Mounting original device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-- 
2.39.3


