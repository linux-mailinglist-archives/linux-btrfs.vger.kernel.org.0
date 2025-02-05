Return-Path: <linux-btrfs+bounces-11286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF6A288F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8843F3AD191
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE02D22B8C4;
	Wed,  5 Feb 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxQCrHZD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="STuFM+jm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442411519BA;
	Wed,  5 Feb 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753625; cv=fail; b=ic8Zw0NWTOVhTHdp1G4RazEXZ6f2VpnIpznj2v2ruyjFK06hd+kdZYq/Al4xoVe9eCKP7DUWrKrGn/aEtRfrUyrzSjpwhibuHOdzB0AGnwssACTJ5AagXFSEhNTNEWU5GL5Q3hiUFmOTT4rCS4IzcKrNC4vNIlTxM8gbEQ8d/NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753625; c=relaxed/simple;
	bh=GL8FM1tzslrpMaQzvQiEOMHAWqTqW/Z0gz4yEN/eXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8jQ/Y8kyc/vdNm47H54oegdwHfydYgZnRt3bTGlEyaE4wkmudMRRTHEO8NqZJ+OV3lDtKoZBblL92JQXKEWfHuER9RPEiT3v1lwC/KNMYiR6sPsXOYV6DIIEkoMw3BPesHhJwr6yJvFjSffdjSKyX0caE2qOnaBvlxA9YHRO7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FxQCrHZD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=STuFM+jm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5158Msew003361;
	Wed, 5 Feb 2025 11:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p/pJbo3RvqUc0PWEESPR3dwlmuAQFjf0JUeikCc41mU=; b=
	FxQCrHZD9bAxXnRDxdVxEwuWuFk/zi9AudLxJOgl3LKyZ6dU9SrgBcPaH60u5IYe
	DberSJKuwc/1bCR25mKcM7AbUVk3vEA7hPrAyZ48CC5/q+H5AO2qkuTpiQbS+EGx
	D4ZOObDxYBujgSkA6KK8mQDbISwZHOiG97QED99dYbGfntatqpHKP4A9QV3OHoob
	nnjN2Z6nu69TUsCPcoMVc0yC87dhYQ2MR7K8tJmfOzi6HTkehCWNpPoSGEGeriFN
	7gvG/s8oPSg9KraC6K4VrHw1TnxYG37YP9ZDJHlH6pPAWeFlrhxJl2dn/TIXiMbK
	njwnRPSB8pCunUZ+3VnJ6g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgy1q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515AEV2s004846;
	Wed, 5 Feb 2025 11:07:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fq9cme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnelLrbahE6PXyDfdnp1WfTsGwFsM59GjFGCalY8tsZWOWQ5wJK5pqcEX6+HVRreeav3TKlyZ7XgxQHE6bYkg8bljTQf/r3UfKdJRt010kpouaUMPVV0j5O4ZznMI3jMd08ZPvfNXXicZdvGKErlxHhejr5NJWjrOtTEAOmNi58iS8BjH9tA+TdPX1smgpEVKaGuNYT+wXOT8QDfQs3EYqILm5LHfmzUCcmeXHUsIVA8/ehaUsfLBxm5PCKZlsb41xzTqLWJWUSTSG97MLtajW74c1kOGfv1g+/F/o175j+lePZyZfx2OQL/thQzVk3N+OofFsjP6qyqyczGUIeJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/pJbo3RvqUc0PWEESPR3dwlmuAQFjf0JUeikCc41mU=;
 b=xthne0QjYJetOlZSTUg3r9Q2qlC621Gvh1BqFbr2IzZzlGX43IdhnUy3JJpGNpTQQdL97LOCFbT1y6lMoe75v2lCnlF2QeDUEgo/HUg4/6u1OtKhwElr4QvODxfl6SlJ60t34snu6hfubTECPmBy7/A/KX/lFfGae85YYqVklzoUFUG51jdGbDA13bOM43tjj5S027J3uwcoE2G9jSbCH4rHcxVwMAoIBTjRSwQt/rkegLwIKi1EypHTzidHyOPheT6+ildlN+WKccsfuRnmhS8FvK9tb185lI2uU2xbvDH4trFBwlENlEowuspONcKqG109IzpeZr4Vo8NK++gC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/pJbo3RvqUc0PWEESPR3dwlmuAQFjf0JUeikCc41mU=;
 b=STuFM+jmSqc5FdcFQHczdKMq28pREkXs9IVnmWBsuZ4vBpN3Ps/P4hUUaTclieH5i/5dObObAEtUF+zRMhMEvMZdvTnAqKwWwvv+qqvrCvKNHqDoSeAu81d/SLT17OLj8OG3hs8ByIefq+lCfnx+gcoIjKtkCzWlqZ1SOT5LvXE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:06:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:06:59 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Wed,  5 Feb 2025 19:06:36 +0800
Message-ID: <2dd242553243aa30547f0a11fb22c692a7a82427.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>
References: <cover.1738752716.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be4e37d-bfdf-4227-63c2-08dd45d535d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZQkl4WFDn1fqny/sj7yGBnYumFVW3WnrQ95d7pOkiEYIkiaxI7KFKkJ//Qe?=
 =?us-ascii?Q?jmoNVm7W2oaFZl8dQ5gcDW0ekJB1l3FGLhPX38+aYY4nAyJVavUQr0PQnse0?=
 =?us-ascii?Q?DrLFc5FgR4V7orkCqEIw44yIGYrqnSZacwhEufj9y64Wi4Xg9jEVDJeNZybf?=
 =?us-ascii?Q?jL7tIkNNpj9SJJvN8nj9c5GTap4g52KhAh8MQificQt9hdV1cflJmL7OgH/6?=
 =?us-ascii?Q?mQG7+quVjZ+HkHNurJjBb1mh7VuF+mNqR0CQCIdSHlFpnnQOWJoNfLFIA7/A?=
 =?us-ascii?Q?JOb8AErg83JVEyKZzUXDs7gfdnTiE+JInD5qI2uAg7StnBSjBd61GgjaMTZE?=
 =?us-ascii?Q?8EymKxnIVV6WWjtl1UQnf1/umEEActOKPSaqLd9TQIJtvJ+utEi6tKOJ1mJi?=
 =?us-ascii?Q?p5BKHZg1uHLRSsnP8iRKEOAhKDgeXV/oOHTzjh23vcC4C0ZdfrHDujxQQlMI?=
 =?us-ascii?Q?1lPp51MmbLUPhzV8lyjiKIMv/4p0Y3K6GGxz2p0vcqTI/nghvXAchvMkzUNi?=
 =?us-ascii?Q?xlvGwj1m2cdyZpj2kujGtSuVIeXJIt4t3rgxeN1rVbuF4aJM6Sw+VEpKADwq?=
 =?us-ascii?Q?L/ZEL+ov/4a0vjHWTB30hIXmeWHSeamhgmXOsnUaZI0qSQq8FfGYbxXpfz91?=
 =?us-ascii?Q?VOr+9KcdK9wHaU+2sPvFN5J9/l6flXeXkPIay3dz1qH6iKEotDQHr94TdUti?=
 =?us-ascii?Q?bmiUiz82f7rSrX2qNnhlxalQsJETsMnqV06ZavCq+zIlQ4Tfik0DTPG3632n?=
 =?us-ascii?Q?s+xz4iUZJT0Wi8JF+SqEg0CvApaxdd/ASrf+r/zX1VUM3yIEeedgbClNFzfX?=
 =?us-ascii?Q?zgDH+ongb9irkB8feENzPBYOtUOPVqZ6UB42S/zlnjb2Y4h0LMKsbbqNOhKG?=
 =?us-ascii?Q?D1Gm5Dp1UVj4pPh7HkqtJyU8FGhhY6K/UGbnpKqOcNLL2cEhHrU0gFHXelKq?=
 =?us-ascii?Q?4JhcqAueNAPT7kVHIeIklF3gtLkedWVRRryTcMhqURWaMqqkX4PYkRVOhksE?=
 =?us-ascii?Q?zuVPsNPNYMamn3w14czb1XLmZKwKE2JMFrXvwPdl8VZatA8UN1vBtVxYW7xI?=
 =?us-ascii?Q?gjyzSF4HrwpO8nWJMThZG0niOGqDnkuYBzkyJLFZnIO0tZU8DaAq4PvxZ314?=
 =?us-ascii?Q?2duCMeipzwBHmueMakMETVzutO4ECUmFkoSYTqq6ak6CjlFpi5ylsEKmSoSs?=
 =?us-ascii?Q?+HknYodilegfx99vnVskvMCyVVY3kT1D42MAhcljwR+OE7hb2J+C70e9g2dl?=
 =?us-ascii?Q?lKXGW58ngH7bh+dtluVm3PQpeOxR47XsQlfJoo8lNogjEW7qkRIXVnpKzse7?=
 =?us-ascii?Q?4s/qoqGyq/E+uERf6yXJ9LWiRVj9TBZbQOY9fvANO3XAri3SHsGiWw8x9YVw?=
 =?us-ascii?Q?bczK8HCFQdLkWjKZI23AoXa+SoUV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smROfvWb0hH8HJ22kaDxv/cs3rYLdEmEyLUa1nRqFQknCStaiS8kN9oGyemx?=
 =?us-ascii?Q?E4FPCjTv+7xmo6bE8kYlodeqCqQYve4NEi3rmoLlkrZr1UmIVMAAHBUfxleS?=
 =?us-ascii?Q?j/ulc6hi/BoSm96TpDR34qF2crJ4MaHbxSVH/7J5NvdzXXghykkkxG0OBvN8?=
 =?us-ascii?Q?nLEu09rX9yuf38muKPjBkGN3ri7N9otGtAxUJeT9HsfUFjAp13qIKtg094Ld?=
 =?us-ascii?Q?3nUtwo99JMFBAyPOTx+sv8l+ZLbSUR7oCaYXx1FuzRIMEGnkPbafev/GIoz4?=
 =?us-ascii?Q?UebW3w8Wow1sTIG1/ERoAV4smFZCZiNRJF6ZBDfP0NMd6/t2BO8+PG/gqUjb?=
 =?us-ascii?Q?iZljwT3bnWyx5xvCBueJAO824JOI2QVknHWFtJzO/Zcib3MNbRGKHV2oe4DS?=
 =?us-ascii?Q?aw6tyW3CfDjUnyctGprrXu3ceMSWzzA4mzTqK7WLZ/H0vDDKhndgoUSeq//s?=
 =?us-ascii?Q?fSmW0cuj4TBkoEX2FBGLKKY+dBoaAYW01bv5d7znocAevhswArbKkT54kOvf?=
 =?us-ascii?Q?6CVPs4XfRdyqPo/eCAuoPoD5wO5f2doKLtbEf9l8NWefWB+FPeQBweOgmVox?=
 =?us-ascii?Q?i0VCbqomqHyRd3BfuGMULMhtGW4Z0cpdjDz9wYlb0M/mWSAWG3rCGXnLDhWj?=
 =?us-ascii?Q?oKNk9WGpz1+rt3C6OoXvZEB+BoqonAZeRE34r2txGvC6dn9Tev1nA3MSUp7a?=
 =?us-ascii?Q?5AFvteAK4S4ic6awN1WOCTpxSszH4fxF25yKob9YCfNNd1jOLYsLB3MY7KfS?=
 =?us-ascii?Q?actOFw4WLvlkzIuePLgtmYCXZWpFXdPanCOoCfY7OtaqY3GdsTzQ5QavazQF?=
 =?us-ascii?Q?ML9XiVckHB4xI3W/eGy5hEa56GA6Eb3+yPd3dFB2dw6K/oC7e766LQhC0Sjk?=
 =?us-ascii?Q?SpigOuVFZDAlS/RDQTOjlabV+jydGauWBK0yRzt6VCBkXwRvCdf7mPn6gbxc?=
 =?us-ascii?Q?HbG1920HxtRTO+dK4mG4VHu8wW4k5znQQUn0gRqydC0O2hELX2BoInLXkvBI?=
 =?us-ascii?Q?JeaogeH8sdUmpM5hUXT65FUrMejFdl5gPO0LrT7AvoE2AbLvqHOON28vJSye?=
 =?us-ascii?Q?DXLUpws02lePCu+jCgoQfwMZEpF/SeMWhqq59CKEN05VA3zd3XHLOIFedsDJ?=
 =?us-ascii?Q?UHlYVkJ5HbGWxyGam1MMTvcHayyqUROdLwN2VP0F5u+zBCIu389It5ZVrbgu?=
 =?us-ascii?Q?6B5K8gkO/5z8W7nAVGWiKqZKIgtbs14mF4mX4khQewJ0HMa9v9V3yfs+QMEY?=
 =?us-ascii?Q?5L+ePyJfqTE2RCTD8ggc/qTZw2hKuJSC7sv2QZXPYAv0BFQ3f8woXpeKGtHC?=
 =?us-ascii?Q?xfZ7lAX3WA3NZqwAMjoGMD4EZCBK4FxlO513jib5rvLsYbL5dJpAS5HKoJ4f?=
 =?us-ascii?Q?UZcogoYBsSNVyd1NZ6bFiQvd5XZXwadG4Bpy+v6mDOIzx+wSy610pSzNH+f+?=
 =?us-ascii?Q?inlpWfwjXMf/gHPKunk+Gpy61gnYxU/IKZAMY5z/e7Tdji8bI+6/5mfNqpuu?=
 =?us-ascii?Q?T2To0oZ7Onzchx+35Y7K5mTWNXl0Fw/s6iwuTAojI/c77snu80x4R8GGxy1i?=
 =?us-ascii?Q?jcc9cIZ/XvWPBgIXBH+X3P191WPz5UwefnMGo6Dp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cyLQphaCVUrbCEpFQVA41EcD7ALDENaMB7JmdnciyXLOIrTb+VfgzpI/Qardo649+xp/LUcXyvrxEi6X2Zwu63xQibsAPpzbExRNKaTNpUtmYRzukJT0MOrsQFGJOxhJLlD7gtwcCBgs39tb0B8mGfjy+PiRcIQRcpjVRpyBOehM66FBsyG6O68BYO+PLVCXnMIqQfFyYBkoWfWZopPrllJQ04I+ixV475++U9eGmElWqe+P5zUFed2Q3Vmgnp5bMMpfEwRxS1klbYcqkC5pO9ylGMY3fO7nh4ekwK6s+54xlav508NAuLjv63EF59S9aOMzMigb+8fdAez7rmTnKR+OwwqNriqsbsKkuksAapcjvuI48BnQR0ENBL6pm3p+UzR2vTW9yDHlxfi3IhcpYCq6ZzGDkW8Tcm3mN33NV+XWvu68ohoppTaUPR1GxGDZ+DSHrtXWAeyeADjdEkpm+pqYxGAHPQydoRwS/GEIeiwxZZHVdDRnPRR2olgpp5qz1cDHwZpLXML1VPsKzjCdYms7DixssCbqwFz52JJWMVcG8nLyy7nPuK/Sd62AxQNsITIYbSECNc8T79jSQ+wcp0D4MZXc1CAE4rOCvMJK0zk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be4e37d-bfdf-4227-63c2-08dd45d535d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:06:59.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tGelzQGK1wSjmPo1LLX8t1xOoWc1pgMX1AzMSsyGxInlSu6kG6h7UPG81ufDZNqNQ94a1Se+lRE/8ADk2IKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: xyuiiJTO_G9U5F0tddooQvdOVMoRasws
X-Proofpoint-ORIG-GUID: xyuiiJTO_G9U5F0tddooQvdOVMoRasws

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c73007fef762..def55ac68771 100644
--- a/common/rc
+++ b/common/rc
@@ -5081,7 +5081,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0


