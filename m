Return-Path: <linux-btrfs+bounces-5409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA78D8037
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 12:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935CF1C23A1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7540839E5;
	Mon,  3 Jun 2024 10:42:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF219F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411368; cv=fail; b=PQz7zywI9yR8P+8OecDCZgqVW8oM0/XWWYSoz9Wu+wO/p0KjOM9g3trx+S/vAASV+p8j4di6g45hYYV0sfGh8x22D67XfT4Z7YbdoOxp7C9GCWucsco9lXhfZlZEOnqXKWxwXj1biDvjyQCltcy3HPuiT44MNkyEHG6c5b/RPWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411368; c=relaxed/simple;
	bh=xN6XTPdbhjmYXCJwqvepe6xkYmYA6Tb2afwveRbMZRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FrCegR77ARVkCfWJ3bEIxjuzc6VkW6jNRBCQPnVJwagzDP4VusLmVuEYD3enEtpjtcWul34aK6KPgWBKJKJCtdXKBkkYALyb7VLbuuag9H2hUdZyKODbHQymn5PVd+BTDxHpOqv4RpVWbqytmtCQqTZt6P1LqidQ4fdXiX3eRKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4531whLD015068;
	Mon, 3 Jun 2024 10:42:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DP+2pbjHMObGmXNwCQUnK9/GIBnOVLYhnK0BPQ2KDJBY=3D;_b?=
 =?UTF-8?Q?=3DReTDYvViTRLQwGXyRDjrDB0OuDT5UEXixuavn92CKvoK0XSHbG/z0zmaCePa?=
 =?UTF-8?Q?Qw5RxWgS_EwG5Aqo/A5S21VvIfhRbzsJjOqr4YoirBtOAohJb+whNB9Dvz56uSF?=
 =?UTF-8?Q?l0qUJLbcWp9kB5_njEGrz/4EBMUbfLQbS1IvPb/qsuJfIbwpveEsB7GKE7fh2/s?=
 =?UTF-8?Q?DC9ocMbIje46kagxUYLr_UX1hu80QaEK5i/2QfHfDXKuP88sur50a86fooq3T6I?=
 =?UTF-8?Q?Y4v7Sc9mYHjZrIz+xbYpYIlBXL_NjOx1g0HvjRePyGLLTI6megQDLaptI0Axenf?=
 =?UTF-8?Q?fDefMgGOQcsy1uzuEkwUNg8dMX3JbWYz_bQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05aj93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 10:42:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453ANqu7030920;
	Mon, 3 Jun 2024 10:42:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmc004m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 10:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib28nHVgqvV2wjjSKuCkbgn1O3idLoK/RaPaNBABJ+seLSRUyjoBVbnlKH/ndSoGFBcsjDcT/rNvA76BMTuGgzcq1QuErdSIxNojJQGp4Q7j0vIKo73xzZboQg6sD6ZmfeZ6QxAXOqDVyW8xzGo1xzobsURcqb5brwOdyNqjuSospY/xg/Lww3TddnE73XQ8hgYgUWP2t7ZWjRADLSdzUUIV9ESAOIVxVZqtYO9D9SLBr3bwcDyizxZUvwpwj3q0QY117fkeBLWFFV6du80Uzg5p8AA/U0X7G3haRYdR/PLapdA5w+iG2DlyFw5TxnYMPPRmA1iRUqayKIKaU80a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+2pbjHMObGmXNwCQUnK9/GIBnOVLYhnK0BPQ2KDJBY=;
 b=WYMYfr5cqB1biqbRBZhXakzdCGY26INRz9APg3fTC50GIV2rPY1HJd2+yDYmH7rOJWQrbFvLR2cOssUNYwYX4WeHq57HNlYkT8XBwUtQRSHlM8agzChwbzYWUnV04hQ4gDXhpMFCyExdf4a6AT5pjAd72ucrd9vhuhSlCNKAfLMYOAzGc2BmwaCshusovvyhd7Y5UTm2I7mvt9eLDHcSOPWfQogUEhJASRZRv0hb8K8sgpiM+pvM5We3pDN5an4hE3g+YvvjxuAsUuCkcx9Q9UHe2tj03wEf7OgvKF1hrW9+oSwCK09yZ+vJiChtIiZJM+SAQUdc80y5iJymrSb83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+2pbjHMObGmXNwCQUnK9/GIBnOVLYhnK0BPQ2KDJBY=;
 b=A2u4/JhS9ZWDU7iC5vx+qWlzoONiuBjgKm859P4u8FlSlhsgNuTm752AwbM8tfqJ6P7vHhC7LZcP+ZOdCDGaYVsOFldxg2GHrnnngfOxji0OwBgEKHVXuOWbLCiPnFjO5CjZIKgq8aorW/Ch88XZVKCMrGsPSZDi9GR1iVBtFXI=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by IA0PR10MB7383.namprd10.prod.outlook.com (2603:10b6:208:43e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 10:42:31 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 10:42:30 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: RE: [External] : Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Topic: [External] : Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Index: AQHasrblbLlLTky0U0i/yX28Adrz+bGxC/mAgABuTwCABGUngA==
Date: Mon, 3 Jun 2024 10:42:30 +0000
Message-ID: 
 <DM6PR10MB434704542C44AD57BC6866CBA0FF2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
 <20240530172916.GB25460@twin.jikos.cz>
 <DM6PR10MB43476059C588E8136707F28DA0FC2@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240531153316.GE25460@suse.cz>
In-Reply-To: <20240531153316.GE25460@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|IA0PR10MB7383:EE_
x-ms-office365-filtering-correlation-id: 1fb29f9d-16c4-4133-f59f-08dc83b9dea5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8EQVRhfHJ9ceTuLCdl9DwKgOcCnNQEo+LLbnc9w0pLRMeLuu/m/thyMiBvQg?=
 =?us-ascii?Q?8newMpDr2hyPVAUfFURmj+TuQXxxIfLsxf3I3AiPEQXsPiqm5kdfiVa6t3Qd?=
 =?us-ascii?Q?g7gdC7835IrACAZrzgVs+cOLYFGw5xdcqzZ/yLOjFn2GXSx1lE6baWRQOmbi?=
 =?us-ascii?Q?KCgMxLehzeHPYJ6cKvhIy3WUg7BG8GvgTukjdqtQBUOrOryWcQRwsdBRiH9B?=
 =?us-ascii?Q?DuWV9A442B55XuoJGWL+7EOv1U8+byx/R++XrFTJg7CTdbS8QO/5eD+u/qg2?=
 =?us-ascii?Q?82nTq982lv3avw/8GMAwH2UVx/Vr2GoPLguZTT89aCQYefFho8wDgz/5y+qH?=
 =?us-ascii?Q?sWUixpNwV4wImjFLlJN3vAoEHK+LwnaFSR2yGzBs7HeuobEGmKDaBylFIrkP?=
 =?us-ascii?Q?lnz8UTxQu0JdHh+YpH4We3++HUQg58zFXRskFNZQgOUoobiovjq1oN0l5AAx?=
 =?us-ascii?Q?vkGquzD60J+RCWdhAYkNoiUt6Wc2JxVRlpDQnSrOqapVO3tQI2mV6CDPT06S?=
 =?us-ascii?Q?3jtmTT8DVULemSpc4+21vR77MBhakSowINz3SoEY5ya2n1z+8Chdo88Wnl6L?=
 =?us-ascii?Q?Jw13ueE2oDEkVtZrjnApxQMXidJc6MoGyxklA0K6W/C78DWl5WDFMeD2+dG/?=
 =?us-ascii?Q?eqoY66VXXZL7qCYFPbWTkIqaCTOKO2OTUhZlg22rY+7kwM/p3KEQB9h6Q8sL?=
 =?us-ascii?Q?9XUeh/KyBmn4y7IKwIerGTfDPuPbzTOXvPHwPUPoHL184BOG5dDhwjZ/v1jJ?=
 =?us-ascii?Q?Wq3Chdcjbl+MgXk76WgXOLbsFrZIUOTH/GGSWeI4s9mDhoSg8pGFBsai5S6C?=
 =?us-ascii?Q?K3wVchkFDkEdpkU3ig0iJ9FP+vS8dhT3MUUSUsIJLMULXGWWvoNdsMXuUaGQ?=
 =?us-ascii?Q?jxb/xIA4t0yXPajybP/g4QIbmCkBzPrxtOOcA8GrMZcVyhX+0slAF7SzAd6T?=
 =?us-ascii?Q?4oYf8t3zJFInje8bcwD4R/vf/EVrOltbjPb9iY2+UVcJ9wVbrWJrytrLrgM3?=
 =?us-ascii?Q?eoRSbsbTG362fvlRbSKDY/Y0zpmGyyT2KZpjhVvEudUe996Ev/Z2ZwcKovyU?=
 =?us-ascii?Q?Dv2F3QJPsAovcsA3wwO9Fg0gLBUKoUk4ob5ykxvIJoQ4f+7FSaEhcSvizm9K?=
 =?us-ascii?Q?bWXqqvXdQzadlWHHoou2zGtrM4BlQrj9XVnmaChqGw3wo0tHeg+GMYdyswqv?=
 =?us-ascii?Q?AX+SlCZAiBAi7OOctz++wZBVsAJbHr+pj1VBa/oy47jg2lStx6GSPyh2VzCd?=
 =?us-ascii?Q?vE6DP4mViDcoZcbM+JXLzd5WYarS6cLGXs2aHeMGd+D5BqmCxqnOD0jpPris?=
 =?us-ascii?Q?f2u1zg5QOQrfPszbe9Aqnu7xOCnoakZvRKwgbLvZJlejvg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iAhfRb5PrTIzVDnfihmam4k9Mfizm5FWtxa6uhJQX/d2Gw4pASxCK2sSOyk+?=
 =?us-ascii?Q?76YmZ3z+qr/6tk7JOsjzEZ7gMPcQ3FoJbtZuIa+D+RyWBa9Rt9Z3E0Or6tbp?=
 =?us-ascii?Q?UcWR3l9r+AlCm8lupngxTbxWoIXP+A3CmsJqGxGgSyrdZAwojEjM1sIO25VS?=
 =?us-ascii?Q?Nv7PHkj1NO05mPX7PzxG1j7Xuv1qhJELFl1RIpudlw1WUvcDi7Rn0GHDXjAw?=
 =?us-ascii?Q?NujKGJ7qg8Lcg65e8rTDvqP0yQvG+DEWCl5jPllAmjfeJrwIeNUk69plS4aO?=
 =?us-ascii?Q?SRV549Fdxj+xnJsWn9IMsdmjkKfcGHROSd9t7V3uM7wNs/NWzLcx5+0/wnzj?=
 =?us-ascii?Q?wGx6Lqiz7mbMq8viQ3D0/3SG90/YgTRBsxRlqrTlCutL6DrQFPWpIHZvFXDB?=
 =?us-ascii?Q?QEPipnhI+SRNgXUrc5QrTwzW7pA3aaHCmMSwOJHZVuA1nU0ux8O3AkPSndqw?=
 =?us-ascii?Q?jgZ76DKry2j9wTor49lGjAC6Vh4tZrYbfoD1cC7Q7JVREaIN429X5IxqOWFD?=
 =?us-ascii?Q?UR98GO+k1jkLabSxIEQDmNvdVYzb1YFndT/B7aQROuBxmV4n5W7/C1QhjF3N?=
 =?us-ascii?Q?ranjCUOqAvwzNSQSnG1EgOtkvT0K8vvMWa5M+83qF+knFtHb0X56eY65ewuO?=
 =?us-ascii?Q?m0/BLYRG1Wt8cg87ojqtJIv5t5YicN2bvNZ0FMnFo9WYFJcSYfyHy96yDGpz?=
 =?us-ascii?Q?4raYTSGiGK/4DHqfS12VfnzWk2iq2la9ELKJdT3zt7R0VBqO4+5xItXCNpLZ?=
 =?us-ascii?Q?iCOguhPD7RtkHF1UzNxlKr/Zo3fy6C/AG+xeDqaWd6Nrc8sVOYx+Q+Y3749B?=
 =?us-ascii?Q?E1YGKhBK0wWBw7wVIQit6jU3wynd/Yra5hdtsFKKZ/QcrfE2ZQmoc69Hq8TH?=
 =?us-ascii?Q?o8tGy5H6rVcjSbr5LM1UtTWGKfwLyaZy3o6yQTiUK6ZkpBz+Woq2GPWXcQG+?=
 =?us-ascii?Q?4/4tkKUE67THhPqwEPM4MZ8mCpg0jTOX4HDKvFEPcUAwfXyl2hJAV/A0aHsT?=
 =?us-ascii?Q?VtJWWF06Mr7hqFqJLxXfCzUY7+VFEAWXsMtHLyNgTpUSBSeD96GAA/6Ofgvx?=
 =?us-ascii?Q?yrcUYC7yZroml0Ly2YCEXcD/0v7uSuNBN/GB3R/O499yURbRBwO212ND6/Cs?=
 =?us-ascii?Q?HcDeUsXdfCCwiYnyR4nKi/mgMQUwpjKGSjTc0F7XOdCeAraZJtPRoCwbNk5R?=
 =?us-ascii?Q?GRIqD520EdzmnpwAFGWbRjKcQcvbrS3QQTw1JtyJtgtxR20FHCkw04oGC1MP?=
 =?us-ascii?Q?7t68RyynzsH+Yrz1sdTfDGEpSC3F6SswJx2WtJvynzBvNlKxID5eiFvVFr2y?=
 =?us-ascii?Q?AwUJNwaLo3Gcms1hMfrZSeIIIzwMijXV96eI8vSuChNgLzQfuVAkYBljsvPL?=
 =?us-ascii?Q?yDKwRLOpDtOtVbCSaYqyIO9kHGMaz2mMnIlDnGVKEGwg59Qh48bj6NzIZhIi?=
 =?us-ascii?Q?yqIHSh39yqxGtSejC15QcIwWvB8F+PlaBeJFWbtDEq/FUIblT36FuqNEYg2Q?=
 =?us-ascii?Q?6mF+T7vlzT9sfXiL9W4bM6JGM9o8gkLVQw2q4P708dOpQn4P761QtRuLu6wQ?=
 =?us-ascii?Q?4N0mAb7kpCyVJCU3ltutj22EPnNgWRZNm7GgcALB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uMh6mabyMxOYKxN44y1Xwn3Cyis7V/kYX5Ar3edahBemYPjd0o0iCRvY/9oDSbva8xqHrisHJ06v8xda53xdgNg4UIlzkrcornSpuRMmpT3AEnzXuSqHkqOt45hq11IaFTdesUxaGJjXni3vsfGbzS65ifqFlPzW+7DNPJYnOwlYeNHh+2XP6iN7mGPTmekNyOe9SLW4Mo5f5tWbfE8B71kQdcaTP5U7hcOx8UH79XtNBn4PM3ZlS0J9Ty9mNejv8DczZah/vfAwrwndHO2s/8n0dS35PmhXwaamvRth4iuBl1uATfjV6cmLs07Rq+hlAW2qlun8rCHrNOUZIDgSIdfd4BhNr1Bx9YCWECEChmGoHK+4BgJGQULPxfOzXtar/zEvgMqzJYrQnN+alAU4SJ/NwLMrjHbtCU43Wwdf/sfiVwGir77eHPf+hKVWyFXPzebytJAY3FAskeUmNZlcaN62GXm1x6OghBcKyeWhYfMJ0Dbv5ieQ22HzuovxPtpOqzgCSwiKpnMNLN0pPCI0aSfUFzmMibfz/xF/jicCsaBhYat6N9jkTCKHiurxaEAOzkwlL9z7oqUhC9fuvOpKOAcVduKn5LRN0UeIDPToH6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb29f9d-16c4-4133-f59f-08dc83b9dea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 10:42:30.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjwaokhwvTitNbTBKgbaxwIgCb+zMeRmtHHAA3Fz3G04tRp/ORdSVepsYchA9RX71PPsBcCsoyx0T5ADw5kmJFdLgU80PcaSHMwA5ooHYeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_06,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030089
X-Proofpoint-GUID: hOlCnz6JhypObhpWU_T5k1O-1PXruYT5
X-Proofpoint-ORIG-GUID: hOlCnz6JhypObhpWU_T5k1O-1PXruYT5



> -----Original Message-----
> From: David Sterba <dsterba@suse.cz>=20
> Sent: Friday, May 31, 2024 9:03 PM
> To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivar=
amasubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com;=
 josef@toxicpanda.com; dsterba@suse.com
> Subject: [External] : Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit=
 block numbers support
>=20
> On Fri, May 31, 2024 at 09:04:13AM +0000, Srivathsa Dara wrote:
> > > > @@ -46,7 +46,7 @@ struct btrfs_trans_handle;  #define
> > > > ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range =20
> > > > #define
> > > > ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks  #define
> > > > ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> > > > -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> > > > +#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (=
s)->s_blocks_count
> > >=20
> > > Looks like there's missing closing )
> >=20
> > No, all parenthesis are balanced.
>=20
> Oh right but it's confusing because the expression should be enclosed in =
a pair of ( ) as it's an expression in a macro and it could change result o=
nce expanded in random locations.

Okay, I will send a V2.

