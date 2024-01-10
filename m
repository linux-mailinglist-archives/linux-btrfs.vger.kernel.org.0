Return-Path: <linux-btrfs+bounces-1372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 843EC829F21
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B271C22ACE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDB4E1DA;
	Wed, 10 Jan 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNFsjcVd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ycd/Uv9U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598E4E1CA
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AF45JE023976;
	Wed, 10 Jan 2024 17:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=J9sUItlVEQD6l3YaWT5h1rDilFjgh7pwPeVhqE1sLgI=;
 b=PNFsjcVddNoOA6KDozq6gv9zW7+3dkBwHguXYju8slCC9XXyVSflEWihj1HPRVCs0zRF
 p/saWVehnP0wOGRXNGGqrtREpX4Iyb6CgoKRD6YDyhG1bPotu0PJSnncHfuWJEP06BHg
 ip4gUUG8FD8fwf+uUidxx8AVIM2iKEjJDHe6eBw7fbaTCWnA0rh8Eptj/m1GFLMlfgX9
 v1lqJugjQ1G9sKmSGenjO0O0s1TaXs5TIcKi7MYjY1/18sJxgRkl6YMk8pYlrIDmO3Wj
 8Twx8HeNXosQblg/cNPaYXzQJu2UlQO8E+UgO73rF53M+GbX6+aCOvfYJ9RGanFzxT5H 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7h95s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AGXRQ1012221;
	Wed, 10 Jan 2024 17:25:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwjqe4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6SJmFrNtuDTuQ5286hNBGtaSKE/C8HVujhQJr56gsnAqLR711HXTzrdX1TZ71qZ6TIvKaLi8krHI9LjVhfVJjBkPx4mvMdbUjbsKb/tLgmlgSrwxreJ8fZpp6uZ0fHSi1ha+uk5+zXGjUkorq81g+EPPfMIhTXxKZRLMxAn3rhVTBDZV4Y4lCAkMEgoZyIO+uoDU38gBQmwP031GlxaA0+pjdPYq1c4TwLWiUKVTRrCIwWfc049K8+MK/UtjFaUVLSqsBtOIduOOcPPM4HE8JwDLVgVUzd7mUHsqAsxMAXcrqOPwACD/x5H/2zpjzurv7RBe/tJorGUOOIonWLYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9sUItlVEQD6l3YaWT5h1rDilFjgh7pwPeVhqE1sLgI=;
 b=fyMUszJVni94vT2yRrbRmLv0xKvXiw9ShOdEX//mS002Tscsf56pkIgR0vKNr6qooH9zOZ+1+OFCpORlodukeYFnj9di8PseEkob0MAQJosEG0r9WPUTmCpDxym1ZSpW3ro3ZdNPQ+/3z5sCUpWh7CtK5UOvlhzuQ0v4aTjeuyQhQvGIoR8hmjgW7n5bskIt9BOGP7cOJWzpvrXLW5gd8oCsQW9VTCzL6v9sOvuTHgkhWktrH8uE6xXhc1wKsVuXOsbV7NkFB9d0wO2k9B+eD1ODz+LcvUObi1YgUEc8nAHuzQK27DctnuF4yEaRzR9ItquqJm3srzXiNjno7kDNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9sUItlVEQD6l3YaWT5h1rDilFjgh7pwPeVhqE1sLgI=;
 b=ycd/Uv9UKgmPqOT4nnCvGDCe7s6PdKh/7bI5T4WyYxUqFPxoNjqSbNpGVs5/05XmUHiatLCTFYZsaWLN/QCsyZfH1uLBd2L72izBX9BLhTgMF0RwoxcnPIIgF5a9NP0Fncs7sXi8WXyhWgKtiwsSn0OS9KJFXMhpQzqP4PdAOWI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:25:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:25:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com
Subject: [PATCH v2 2/2] btrfs-progs Documentation: placeholder for contents.rst file
Date: Wed, 10 Jan 2024 22:55:23 +0530
Message-Id: <5563896f320e169cbd31f13eeba7ca2efb655d6a.1704906806.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1704906806.git.anand.jain@oracle.com>
References: <cover.1704906806.git.anand.jain@oracle.com>
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
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fa9c29-4494-4ff5-a38e-08dc120129ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tMXVdeZ/U93KF6fjZ6q85kLf0SBk/vYnlDjMVn3V1nNmC4B/zN/PMy/uGaRHl9anRbD1faNaqs1p2g3rZygkVFucusFb0WRtJ+TRX9lTFImuxVS0p4PMJdJVwVtetFpZce0Irs2E9n56q5vVYI9l6Rg4jZlnccaWyGET8bBabE5AG+e8biAdiTY0LL21sCzKgHvtX6XF3y1JEVYnapaGXdKIBhNfzMiXViblHEHDNmOFaqRquyH7B1b52BI901DXqb73ZBDc5HJ5HM35St3ivUvAsWrHZ/BVN1aKMrFB1h5ImEh17+LvEnBZYCvDWVtUuqwUDfyAcnFGTQV/jCO84Saw6At5/KrkoXHKCEXUGpWgOl8M7m48S1NTK9lroRq5/GE/ZVydIetdQWvOfQMTMIGw5/YW2vKmn22ze9cp1xd86clQFc1ACNun7Q0E23f4rkcMt/tja0NNgqQtAtxFDUfbIDF8ITSLQoNEiVHHcwuXs58TrRlPAGCc+jTRjbUgbej8DDloR8Q13+yGgOJ18+6BBsF7lu3Dnsdv1j1udx3I8M9Qrh7GoWqVcD8RQkym
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(6666004)(478600001)(4326008)(44832011)(8936002)(316002)(66476007)(66946007)(66556008)(6916009)(36756003)(41300700001)(6512007)(2616005)(6486002)(8676002)(6506007)(86362001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BC9Ad4+lNh2ChRWRVIspKnZ3pNGZRc3NHkC9kcZJ2nmJNCJZXmXaUXc8Yrv4?=
 =?us-ascii?Q?/LQ957GHUeP8B3Q5IKDTDsCr5fBcQIJrotstLEUQIa8FhIduFI8M8UL0NEkb?=
 =?us-ascii?Q?CdKBH99QU0F+hMs0L1hcC9aFjrjzq0wW4MhMVm9Rh2afhweUOvqnYC0pV8g1?=
 =?us-ascii?Q?bHptqifRW0FTH/6l4EnVMvjihpCRWKnNwdX2Jys0izf62IaDJZjOhoKI6ODw?=
 =?us-ascii?Q?r62HNsP9euQGmg19uBqpkgYtcBBTLemzqMgjKEUYWDH788KwrtifDTzmpD8n?=
 =?us-ascii?Q?DKi2i5VCgPiuUYDAs3FjQHLenHcW4kaF4OgIi98x7BsCpQVhKWzF1J6HdYhX?=
 =?us-ascii?Q?0fLVlq9KYN2H7fm/7izbTJ05ghXccrcNSjSpcXcTg3o+rPLClJcbxMTDFHy9?=
 =?us-ascii?Q?Afzaa1SnXuujw71FbBWojI4KYL2R79OFCtjco7d7m9lPozNvMcQ6llV0Jvgj?=
 =?us-ascii?Q?ZM9C7ois6XvyavISjd77a7WTcNGfBQJ27wPrxYcbdIRdM+sOjdjvvmEXXf0j?=
 =?us-ascii?Q?4p3cEzsJovZFshbLkjZ3fGxXQ17P9nWJd2pzNVKah1Y90h83LaGNspW4fCxw?=
 =?us-ascii?Q?HlPAaTTwfhHjcAZvzdoaCYGMRsgiOM/g1vknZ4XoASEd9+KZcjrjaFz4KyNd?=
 =?us-ascii?Q?P8ZgqMYmKr1KAEaI27FjS13cT8b0Ab5fn9JtMBmCApTsnBJsWlBJag7pu0lI?=
 =?us-ascii?Q?Qye0x7v6xgVKCN/nYMFXyit44HylZRE5DoYVBv9/m1AAp+DEy8YnUPbEotYz?=
 =?us-ascii?Q?hs+Zyeh04fsdzfgSAjq/Ek/jzhPAlCSpeMnDlwXe3RqbXTJvS7LjvWEEa4Pv?=
 =?us-ascii?Q?qZ0a8gq7BdNLgxTnHevyCO+EkiyqzAC5BFEZnwHAJhXW/NV4xZECWeg112tm?=
 =?us-ascii?Q?Iz6wQibRjD+YmEItc3MAkgt5UjuPCSuZu8fYlgFkO3d64MJo4QVkzH6VdN2E?=
 =?us-ascii?Q?7jRop5UBZeu6m4udT64f63Ltp9Wd/nWmVDh8A4ofnBuMMM0s/HViCNUXsckG?=
 =?us-ascii?Q?CqaKkVuz6FNZxVFwgGQyHKhoQNEVvyGyUr8US8gM6NlZczQteA4rSm5MBjq/?=
 =?us-ascii?Q?zOxKanyD+TH4kznTLvAvdT+ZVCltwKnftf8rCkA0VuOvDA2wnzFbBg18sI1k?=
 =?us-ascii?Q?lbwyl8Cufa2KEutVjwE7xISpo7DGduVPT8LeNltfQ0oP9aAgvR/1wUXZMHG0?=
 =?us-ascii?Q?Xo/zV1hrkY3hDtUyRYcBFiC/m0fRURh6fBXCFOdNs/KzVAv2ra/bwLWEDVwO?=
 =?us-ascii?Q?1P8c1m2t6G43mkcdcGggQvz0AMGVLr4sEOzg4JFvdg+iAnOptkZZhjVJB6Vv?=
 =?us-ascii?Q?OXTU50tNHBTre3aD4bAjv7MTJWmVSKjv5QjbEzj4S1Q44xo2YKB4hRTL7jKN?=
 =?us-ascii?Q?5bClK/p0g1bXNHtc+k7OKwOeDAw1dfVSy55cr6tcwhlv7pXLMNt3t0Uv32vU?=
 =?us-ascii?Q?RY73WsTReWtNe6goyQRqpJBnRT1+4tTrgLMcCeWIcid8F4Vp43ZWg0USocDK?=
 =?us-ascii?Q?yg3zkNW0+9wrEDDCaz4e1TqWALErf6KcW1XOPxyWOzK9YGlyPpv7+F20OZIU?=
 =?us-ascii?Q?5o1Se+MLXqQ24tb9EoqksNGrr0ZAb2+qoT4YeAjx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y9swmTxTq23IzD0BHy07ZVJ/+FAuotU6F+4CyRmRMYcrSriaNFqkvD7BMB4dAAs080PQiuyu+ah5fpeE4bxbzElys6H0/98VjwZbRP+hqcGR/oX8/eq93uQermX7Vgtyf5e3Wm92xb/bptoRQs5M2WarmZOLeJC+IArKnnsVlMFIsAWClaiBHhG3PLD5WvhIKhHHgbjM1FXV3odcDcgkqtJOHlegpf3Ptli4GXje95d8GSBx3e5bqZXyyoQBqiMtF0wVygiqcKxRsb66v7wE/jKyRnf+TJJQSZh80cjAGoADXYvVPI+fWhBaplcgb/TW6hPCdUX+zhHm1DqG5Bms//CgPTM/qpoea/AGVxAn4qkO8Nm6k9/u3tyzDH/k4REmtagCVAhVAdp/YquzhvIDqzu0O3UDr7QEJKkoxkS7t45A4KiNhbzG10/8mbcC92JTKPV7mE+rPJ82Sn7pc62JgbHRHdNMEGjCOERBBn+f0EGomiTErj9XI/1GsBD5UMNh2i3vVG//0HXK9Rb05cumW7zz+ark9eZySLtUtWpTS1BdzGseRDJqHRrVDFyrxijZ+77E3Pv2KLs53paOu0wzGTkmQgTChG6dbVkGOx3zUJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fa9c29-4494-4ff5-a38e-08dc120129ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:25:39.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFORUpVVrrJQ5rEEV/khX6phnH4/vjZdar9aBhhMYU1P1EMKQavhm3qnHdSlQQv423uF7GGdyicy/CcsKHFC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_08,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100140
X-Proofpoint-ORIG-GUID: WY2TyDDGWisOdmr1YordmyWE1dFTCE7C
X-Proofpoint-GUID: WY2TyDDGWisOdmr1YordmyWE1dFTCE7C

Sphinx error:
master file btrfs-progs/Documentation/contents.rst not found
make[1]: *** [Makefile:37: man] Error 2
make: *** [Makefile:502: build-Documentation] Error 2

This build error is seen on version 1.7.6-3 of the sphinx-build.

For now, to circumvent the build error, create a placeholder file
named contents.rst using the Makefile also add its cleanup.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 .gitignore                | 1 +
 Documentation/Makefile.in | 8 ++++++++
 Makefile                  | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/.gitignore b/.gitignore
index 26f1940d5546..bb719b41d200 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,5 +79,6 @@
 
 /Documentation/Makefile
 /Documentation/_build
+/Documentation/contents.rst
 
 *.patch
diff --git a/Documentation/Makefile.in b/Documentation/Makefile.in
index ffc253863ba8..2c036eef00fa 100644
--- a/Documentation/Makefile.in
+++ b/Documentation/Makefile.in
@@ -28,6 +28,12 @@ man5dir = $(mandir)/man5
 man8dir = $(mandir)/man8
 
 .PHONY: all man help
+.PHONY: contents.rst
+
+contents.rst:
+	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
+		touch contents.rst; \
+	fi
 
 # Build manual pages by default
 
@@ -53,6 +59,8 @@ uninstall:
 clean:
 	$(QUIET_RM)$(RM) -rf $(BUILDDIR)/*
 	$(QUIET_RM)$(RM) -df -- $(BUILDDIR)
+	$(QUIET_RM)$(RM) -f contents.rst
+
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
diff --git a/Makefile b/Makefile
index 374f59b99150..a031b0726a9c 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,12 @@ endif
 .PHONY: $(CLEANDIRS)
 .PHONY: all install clean
 .PHONY: FORCE
+.PHONY: contents.rst
+
+contents.rst:
+	@if [ "$$(sphinx-build --version | cut -d' ' -f2)" \< "1.7.7" ]; then \
+		touch Documentation/contents.rst; \
+	fi
 
 # Create all the static targets
 static_objects = $(patsubst %.o, %.static.o, $(objects))
@@ -910,6 +916,7 @@ endif
 clean-doc:
 	@echo "Cleaning Documentation"
 	$(Q)$(MAKE) $(MAKEOPTS) -C Documentation clean
+	$(Q)$(RM) -f -- Documentation/contents.rst
 
 clean-gen:
 	@echo "Cleaning Generated Files"
-- 
2.31.1


