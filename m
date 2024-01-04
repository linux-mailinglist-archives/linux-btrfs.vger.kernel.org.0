Return-Path: <linux-btrfs+bounces-1222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A0B823BEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 06:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C33288403
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C018EBD;
	Thu,  4 Jan 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lANGXFdP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XioG9qVQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBA18C31;
	Thu,  4 Jan 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLk8I002443;
	Thu, 4 Jan 2024 05:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=/e0rs9iQF6QCE7o5m1A0BaCD0xn0nrn1DRJGKu435kM=;
 b=lANGXFdP6i45JR57kQsjZOgqvu+okLnTtaxnPx9dIdnlXRHWbdIESrBJsuj5sUjjG3zo
 xBkXlI48+sx0iqdkFiTKHqaXnNPXRmEMxuWKEKRimwcDlvFxOk35XES660PJ5mVqPOp7
 fD7pu71XN2BOZnoboA0ZUBcILL1Mvcu4h+izc+zm8pwMaJLXOdXC+l4ce3+jp9VF2gZ3
 mJG6qk2nswmHL1BB5ZqC52DEPVgTMEoOEAXryQvfbTON3ljI3OESTZPkkzGZRNFyQKyG
 tgffXPBG008aasfYouinExyF6sSJzPPEImNv87CC7k9fVn4MnIFBGZCz/mShdSxTqcgX 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu6br4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4045XxQq013100;
	Thu, 4 Jan 2024 05:49:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdpmy14jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 05:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/Az/I8FxRyR2inyeebJKS+BoYtsOn0WTsgvQiEGMB8rL2gYlgZaIg22oiYTg+lh+NLjAa6h4T0K1EKLIlIrN/0Y3A7D4raZSwToUTzNWvwGtBo/UmrEqbSQeO4/OdUCvPX91U4BbXtXgiSf076a/j2uqPzO3y7G7nstFdj4uxWWnF1x8EzIks3b5MHZIm95KGsr6o1AXdeHPxvn5wWu5Ffi0Xk45QS/yBgLKYbYQKfEMbA41bE5hFrqAIJLPvajMZ7mDLU9VP86bBPRuuBUHe0rukIn6o0fp959f03abw6wOcX5FOwL+nChtuO8hVjlzJh1w0NVJUguoOYfF1WTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e0rs9iQF6QCE7o5m1A0BaCD0xn0nrn1DRJGKu435kM=;
 b=bT9yHAFfZIDpWBxG9D3UlIBAyNxw6Yh3RRYnwjsZLH/OE+N/HaTs/G+3k+QAsRX3+BQmAFCOBU6+ONGrHyQjtakSZBFHZu8/NAyHptxJAe8jXKQRjJl+wBb94kQIJsDEtP6XrMudk/4+z/Hi0Mv5GvAFV9Rbc0ARO47VhHVF+/XrjIZVdbrDSirlcplyzxjD8xOUVzQ+XP6n8I4yK44Wipp9CQVEXhRI65gR039zL92XAES3DRmCiMA30WEA4leJ+wFcy8Kk2gmULw/Ih4c3eK5DX2f86jquwUaCxKsvfH95oBWQFLz/3Db01HXUalITBQfPPIY9WIyg0rc+nBwDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e0rs9iQF6QCE7o5m1A0BaCD0xn0nrn1DRJGKu435kM=;
 b=XioG9qVQ0mrB1Byer65fk58KkTJZPuwRjri2dO20aymwQy2cBt0+698uVhvXXn1/PpRC9gNDfzv0pPFR1aQg7xNT8dv7WNcVRawFgmJbZjp2+Y11/EzKd2jUzkco/JqnnBOcMN3EVAf/QQcQ0li8mF6JxHZfsJtGCHLb4Mq74yw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:48:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 05:48:41 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        fdmanana@kernel.org
Subject: [PATCH v8 03/10] common: add _require_btrfs_free_space_tree
Date: Thu,  4 Jan 2024 11:18:09 +0530
Message-Id: <36293c4b5396ac2bdb4bb30c86749c50c6071cff.1704344811.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704344811.git.anand.jain@oracle.com>
References: <cover.1704344811.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 546be64d-dfbd-48cd-ba04-08dc0ce8ce20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	60K08A3JOF5vWlTZcHOdOJ1QmvnOubQ1tqs0Jr4JO1sd61lkJNuOcM6+Q8GMQpMWJTaQvwxAOYKcfN3uolYiYV9neSJDOwC3EJScpcKpzjRFSt96jCkclbZ0JCE25540Cj5wM+0qBYBplWWAbxKC0VgzIaKfsQVTj6oCHPu4QHf/y4OAnfyHv7HbxKKfLxnr654Sa7B36SP46gKaoB8m+1wV+mTn0cgSY0aqH0NsUiIaajYH7tyPW4Lb3l7xsW0jifoQwMkCL/rnM4oiAEIbHSfZ7+SrwNFGl769G0zm59S4cPEiYZAJC4Tkatm3r3rIw6BHFFFmB7po84dRKJnbkqKkHfYNDmneoZ36ItjYUuW6pWT+ktK1cJPIgJwybNLIyCgRxY30oip57wAY9djuqGsOv+6GBy+4Xoz8Ki1H3H34i/goKsKSxw0azZmxtQFg4zy+39fyJnfvqOPESZjo8+fFkb6azUi8/YqQ0hn/PsQTkJbUl4cjMZ9//ISwvKfe7E8etiEcMhNxm7ApG6g8bnQUkE5MWgPp1LTNcKezGAuxn/4KEwwwFHfPUQKmB8G0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(4744005)(2906002)(4326008)(316002)(8936002)(8676002)(66556008)(66476007)(6916009)(66946007)(44832011)(2616005)(26005)(6512007)(41300700001)(38100700002)(36756003)(86362001)(6506007)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vDO1Y3Bu5kuEaJsDSNVQktjBK5u6yQUokwWd+TyT96Tjt4KEBMO26S5DR/WY?=
 =?us-ascii?Q?a0Sys9zihMyqy/Sv4oCom/7q3Ae3Js2SALYgeGngC9CvnMseHQWyG6S0TFPE?=
 =?us-ascii?Q?o8DqWZCCw/WHh556Rqi4+Sl8HZskQ72FQtPoJbS/J/DVEAsr88VAGf4WMsM5?=
 =?us-ascii?Q?361nozUFMq+Ko91FwjQoihZDwoz6YlKEqwpkBf3mSGhPA2bboeFXZIEzc4VV?=
 =?us-ascii?Q?R0KJGtMBuHxkXTEFpADylSFBRFFIhQ0dFQfRFshpwVtu5xYLiZ/o+kOAs4Ut?=
 =?us-ascii?Q?Kq9dLk2e8sRXSXXfOr00znUonb9HdcUTHEDVHT1d3J7fubax51t5ro0Hrbda?=
 =?us-ascii?Q?XicSIwDC8ZE9R0Q9Bneo4gGyUQRd5/ZqZetSMQolcoxekrAS9M3XqkHAE3M7?=
 =?us-ascii?Q?yffqsAA9iR1w5sNGaPqRAoxA3+/qIDtBds8sFKcBt83RK3G8LsdOIzYzwjux?=
 =?us-ascii?Q?NNBsWAuwqHujkTAURTsN8LytusSLbBds/wNZB6DCELB3q8QuyoJJ6y+LrCPC?=
 =?us-ascii?Q?jaBsvlG5D+rTbzjp4ykc2GOFu5+aufrMH8ex10V4RC5zfygwT85zkNAHSOFP?=
 =?us-ascii?Q?4zaatXCY+WEDP6ToMQ2+h53z95pZ67Ib0tB1JgPZcmwbHsRtBx5s5bsFktwH?=
 =?us-ascii?Q?pNwRAY5HhWrvw08o2l3Cl1WWs5++CGOAZKQn20U2lBjoj54BJt4FgmGE8Od0?=
 =?us-ascii?Q?AytCwfKEwFZDDDyFkir5ROx5SuHbe3PpGXKdooMSoZqw61cz8LK7DjwLbA+m?=
 =?us-ascii?Q?KTQTt+fJJ7fr5pGZpRnnMHWRYQfPuasi2FEgYH+UJC0cHlqWh/HOoL5YiEwA?=
 =?us-ascii?Q?6FwJaafGnk4ju/fHC+996G/htsvIJ4gTmBw9sHffOmG+ebI+xbbjyPSEdheL?=
 =?us-ascii?Q?9nZAnxEUT+LFWDcKknbmF/ja1yfpr/kJcDLqmFmvzGndQnFjHxf7nd7uIFN6?=
 =?us-ascii?Q?h0xGBnlgRJ49RR1sy8krZdjW56xx4FWlNShr8+zt/65KW0FXQhRI0dmUROhI?=
 =?us-ascii?Q?f3IQoMswjZy006dZssD+83H7YUs1sJcm8coSZ3YVjOc0wogKAHRGgBTnsp6s?=
 =?us-ascii?Q?Z36sOvx5LjUshwjruMLZnXJV/4xt8XiU8EbLgh1f0PXtrLRnvTmk6r9EJDoN?=
 =?us-ascii?Q?//mL5RjO1QXoOecVCchC3qPsY6SM/o7NLS2by1orD3dCeSJOjuV8ctGRVl1N?=
 =?us-ascii?Q?UPNZXkruDG8Xu915LePIQVr+fWtkfffpKZQDtBUfWGPEW2np3jMQCKvCN1we?=
 =?us-ascii?Q?uP1cwIrMN9QFktnl5Xn6C/X87k4K1gw8HBQ0b8hYZPUG7ISCDFmygM2MX0ow?=
 =?us-ascii?Q?7+PjvBpi985LeDfe0chRQ4m5kKL43lTqILEsU4nyjxiuwlcE6zP442CMiow0?=
 =?us-ascii?Q?6tDMOOHYUitaL0pFotmx3o2vyNgI0m7u7CnGC/RK9Zbt/Fieq3OLFr2l6Ct2?=
 =?us-ascii?Q?HG4wV/7wJLrmP8ArlF50E5qWFfU91efTQ/too4VOZ8rnrnMWM+w0v6H2Y7qV?=
 =?us-ascii?Q?afBIdxGAXAdx7WhFoXMC8/LyNAD6Gl/60HdDr9C3eOQSjRZ/42IYXoKq9aR/?=
 =?us-ascii?Q?k27bd8gSpOKBTxSKtGtMORYdhlgsqud9JYRmpb6H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YSSQJEwK3NB9/L7kWo3HS1UjK3o3sCAETQBEDskjQp2BcYr0X4yqWYS+C7eCJoD+va9878KKnvqQY65YA2Kcv90cdksHQ2etBaLqQAtEJmNoQmMOBkd8xWgzWTGrx3r0JbJ5r9GeHLEdoh5qEdFzNSf5seXIxT0hcN+ReUpqa2Ipad2A5R3jkZqs22Z4DVKT5bWpUOOSiDhCa8EdRVBckWW2ZQygFl/WmoxvLXlv+cG0Lts9hXKnHFvSsKxiuOXQvOlyIH+wman4eV+OnJZpO0egVtnubNmww5dXqCT+ICF2ZeziAtaaY1+c4Reyqb3aWNUliDQ0Sdu/BvjGtVMpnnE+9c+XOQp6CJN2+tlt+arf4R5AALgp7epAOgx7gAdu3rahmhGKRLethZ2qTD9uuOGjT9LW8GnNNd9mUPsQ+fyHfJsmOK/visFVpZ42UCoC+IGEja/FUVyMiALt0iU3H9nwQWyCiRmr0SCZHU9J9dh55Sdoa2CGjcieKUZigEX90GL8sMTwdFo9+GNxZybx/eIdb9nUjcMzZkRR4VcUrZdL/wYa5d0t9mSWonMNmXp0GxwMerUjXLf5JjwjX7Tgvr5LN0ZLE9OTagW35OyMG0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546be64d-dfbd-48cd-ba04-08dc0ce8ce20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:48:41.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIzGQtGoOGDQ34+7cbVmayQPkXBAXfHLryiaY5niKwKQViSphjHEoz/KiBbo546sGig+uIzerB6c9FUKll1Iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_02,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040039
X-Proofpoint-GUID: 2YA3l75AI7V4A4kYFYNWMuUltPSW37nQ
X-Proofpoint-ORIG-GUID: 2YA3l75AI7V4A4kYFYNWMuUltPSW37nQ

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 9dd2a7f49e16..e1b29c613767 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -127,6 +127,16 @@ _require_btrfs_no_nodatacow()
 	fi
 }
 
+_require_btrfs_free_space_tree()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	if ! $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
+		grep -q "FREE_SPACE_TREE"
+	then
+		_notrun "This test requires a free-space-tree"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
-- 
2.38.1


