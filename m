Return-Path: <linux-btrfs+bounces-13926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0281FAB4367
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BACB7BAC46
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8F298CC6;
	Mon, 12 May 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSBTc335";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z14MwTC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC0298CBD
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073320; cv=fail; b=lZQxp63ucL/VBZwiJlF7F1qkosTLuDhjsNUrJn6wDKNrMnRZX7ikguwP0VLwTT/5Yv/OjauUo0h5PUEMdUwj+J7JatqY3W7YeNjhGyPKThCViDLEzjH/u/oY8vZiNzK/4iWjRkLCZcUawouw4xcZqm7AhbXDUysdLhhHmjQL+SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073320; c=relaxed/simple;
	bh=erlqxx1XdLPpO/TbLxzh4jtHwo9YTk5lOwEowjU8vLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sB7GhbVHyAwHHVFXf9wsOo6GKT26HuJ7eR01VLbPA2sHrQCUHWgDrj0UbNioSUioSe3iFn5aFzUaQ6rzmIp6jzmKGDdfoeOMYBuqMuAyGf8IJGVfEbcqxHtGbA/mAqOKaHmEGG8e2s75yepGtzRbOKSL489L2EpmC8aNocRwr/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSBTc335; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z14MwTC0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH188p028422
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oeGRa/ee+weJWKGgEkBYqczLjMjsCCal/NE7+OF1vOk=; b=
	dSBTc335tJYCMBaeEf9m1Ov5kAl2OZaiBAYnHIFVDigLXHdbCv3bGBQGS0mZ6HcS
	UqXjEH3lfNK9HvCcLYDbXQ2GPFiNypAhR9yv+PWxpltybdnQgm8AeYESMSniew5q
	8kVYixt+FbD/eXEDur62nBCGeRO+27FkrSCQ03tiYjn7qJEvkmsFj3gk9j0yDbCp
	tEo0QHOEVO+Yk4TdGB3vYf422tTg9OOZjlZFKlOAO9ktVigU1BMZOmM9VdLuhOkS
	3Bc6gKwjYNFAZR9uWuz4TGG03FW7QgNKYRfxJ0v9Jb87phiz3cBJjlNffuDlSTN5
	hBM7giKob7eDaCk+o85bLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHOKdJ015429
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:36 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013059.outbound.protection.outlook.com [40.93.20.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87pyxg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpdh4M90zDcerkH0tXfbMSPwheGpUrG5cfjLYMEAyWXBRWJ5qFIWc6sVZk8QXvCdOXj9ucIQclVl8LvhBlvOp/yZpyP1kfFMg41+mtssYTtPxk2yhZSK/bOYNs5HtliD+6x+/i4ZBDuaszbuLPJmLlVz/oq9K5gSe9p+aKY+mPnccbO54CUflMvcVP4CklfkhhZf83DuhXjJ8+1YuhAofumGNjZPn5TAJjvm/hmt/+K6iKQjkzsTlYWPiIPZOj1hU95cbD16GJeCeZrRr3j2gfTjXE5SYPrAH9AXy1PrTPf7u0kPj1AiWxMytrXzUAA6AkOg22mmXJfMKxMOxKG14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeGRa/ee+weJWKGgEkBYqczLjMjsCCal/NE7+OF1vOk=;
 b=Cz644Os7/Q0o0uDdJ6BScMINfyPS7rxuQchtdV5prn/tRZh1xdMwPwar+05Ad8Jec6XWCER9jw33TuoNvOmogUG7/sBPHMPXti6BpfeM8aMgr9h9hUxb1iP/S4Kuy7ww94iAfn1FT2dtkE1YKsq80N61dnAlsWtdOl+MV6r313gsXjn/XHUVxk8AvT8OeP+L1XwVB38fLW0AyGKrZcDtkEW8f87n4FmpkXk0Iqs14D0x4G0ZR7EeSAitcnxsL2SFG0NaOiQ8iePWrx1CxEkSz2UpwfdbCNmpxUc3jJUhb4yU282juLlQs8VsUX1NXKOoTPKJYLOeRptQ8rrxOZZ2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeGRa/ee+weJWKGgEkBYqczLjMjsCCal/NE7+OF1vOk=;
 b=z14MwTC0MB1nKix3pmhOnhhfoPmejNxvsLDkOx2jCyRLdjTtxGYyMUvNQyQcD6kF/Q9BC88DOxxyefQg5gDEUlqV7dNI0puCByclZqRrDTv5LflW/DJXY1Jt9e9YUNmVt/BcMc/S8opexw1LrDHTyTs8RG5n4nscugnKwnzqL8g=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:08:14 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:08:14 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: pass device roles through device add ioctl
Date: Tue, 13 May 2025 02:07:16 +0800
Message-ID: <29121518d3226ce2218c8ef4be47be46b63d5667.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: a92864d9-9cc0-438f-387d-08dd917ff6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pq+R/kWQnNS6E0R05uuWcv003iLgcDrK0qYR5WL7Us8lgX6/4+2MuXXyoM9O?=
 =?us-ascii?Q?q65w51ITauC9BtahsnIV5KPlX4yhJ9lR6uWXunP4wBDMBB191akrF6Z9LhcB?=
 =?us-ascii?Q?Ifvv3utBXlVf6H66bZE4IDzy0YO48vttccxLpUsJdT+ica2G2IkeI5HBH7Yi?=
 =?us-ascii?Q?rEmMlAC2mnsN9pX0R6XncfCga+vPkC3yjQrTMgnRKW9VY5RFGiqLEPKIm+Ic?=
 =?us-ascii?Q?MaGLoS07kJ/v5kKqg1xDtn5j3HUW4YAQC++jCNC1Y8vadjKXYeNEMxOoytmA?=
 =?us-ascii?Q?CME6LxDaZ0jLZiqkh3ruZZoR2vRMLx6BlQ17UrpIMIy7gAydsJwMjA3YX1Mq?=
 =?us-ascii?Q?NaZbNzPXMsbAT7oOT9+x4OwWDK7pqmuV7Y0fJHgDFwphYREpA2JqBDKez9wS?=
 =?us-ascii?Q?ChsEK44fDZhycHmT9rtSTTxfGnEY+14lu5+ri1E3QvxXPG4FVk6POx1u6srt?=
 =?us-ascii?Q?/R/C0yIwFCtPE7dRhg1PKP8mxsyKjDkzIDpYzkBQC2FCiYNJ3Fihz8lQtalG?=
 =?us-ascii?Q?VEQwm+wxco+fQwkAe/MZJCYfjaEz594N0xUwJUe2qQSXpPz9ewdGww1DxUfB?=
 =?us-ascii?Q?lS2efizkA3QlKSwGxF6cvZU1n13mn/2cYnzRYIkO+JBtFyUZ4Q1Z4G1mrw2H?=
 =?us-ascii?Q?xAoRP/JocV4ovnXObccjUdyMbtFU7kksyuYCilLOuW15dp0qMNGixcQv1oHV?=
 =?us-ascii?Q?yMn6DOFA4BsvrpGSAHlXI3UnQhE0wNDDYPykv8wFVqEEaSaN67d1XqKwGTWC?=
 =?us-ascii?Q?O+wUUu7tlAIDjKkgydl3jcwtQQnu5TJK7DHRhEBvSmZOEsNjLzrlNJ79SHwn?=
 =?us-ascii?Q?DzLkauAg9medDb+VTKZiJ9tdDDzXBGCR6jhVH9YKTjtDLB5YxxLanwrXY2+x?=
 =?us-ascii?Q?SOMtjWhgYNvF7LG0wmtGg0wb9CC/UdV7qwaDVdlJCn8nNQhSeKhuO5qoDSqU?=
 =?us-ascii?Q?A+TxwBJQOo9dw+FzfBr4iRlkk3ObBXO0W+jXytl+tIboprb4at7ZZEs511fb?=
 =?us-ascii?Q?0QRTIEUwOxJkGxLlfzoJtn5R6eJvSRF48bRa7CL8wbAgFr/ZnVQgX4CJrA+4?=
 =?us-ascii?Q?CWIdrqbHFC9HjaZ4K6f74TNs7h+frY/xydzmitXEXzkkIqg8+NBozedXAk0M?=
 =?us-ascii?Q?aAMsM9zT5bLqKIgaUdJ2NW8OTkKBzkeZh3G0DWkTxWzteTC20wEqFsDghg16?=
 =?us-ascii?Q?P68q64AOUSLnD9oujMr2rsLTx16Nc8jzm/9sPM35vtMS7NknXDftI2UyuGMN?=
 =?us-ascii?Q?vZKy7IOeZPcNiAnEPqXA9LjZs5D45v3b7RxjGVgNzcBb4E1kNkEqB2q9GgNc?=
 =?us-ascii?Q?jUqXmmvVC6KM1x14wD9h4ujJdER5wKEV8+BSc+MQlmYOb/v1XRQHriikZPeI?=
 =?us-ascii?Q?m7SRsYCaUbKeXNu0Wilb4HGxNO/gR1faXHmvX0mCncg3n/DJvL8cPqFd+tAv?=
 =?us-ascii?Q?PkCUwLKGm8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibsJHkQvyQwsxghwEGqtMlbC4aqNre39FwetvhFhlaKmHeLC/ysmNKEub9oz?=
 =?us-ascii?Q?Hvh4Q/D0bx0g2ydLEbPpWJxTENEOfirJQjZlmPb69nf6QozkNzyyfSEulm1X?=
 =?us-ascii?Q?tgqbWsVdfnBVyJA3fdg1AumBPV72VldiFwfjUs78f59q/5Pn7t+6j4jcg6q3?=
 =?us-ascii?Q?x6gWmwDj8Y1ENqkhAcA6BllsBUfm8oyn/gKFn5GL9xn1vLy+mCSN1D5zpcTO?=
 =?us-ascii?Q?oo98fsjP5ULMiHmS4l13eUdeKhLD4Olsyej4OnhdAOQuMjqvVWVdaBveE/re?=
 =?us-ascii?Q?PFXtLKoCXKOpBkI/TJQwnB1z2wecGLFwQql287PQixsidADFwy3rtrlR6Z4h?=
 =?us-ascii?Q?xAO3oi8dB+px6eo5pXg0WwFgieePqe13i8D1o4tbc7N4AWAKEnLCDjKex08i?=
 =?us-ascii?Q?qUeUDyCWrzZYa5YOsUSocw+IKvwgXaVgKDmKeLjViKVNIEhsOzHwixOuBHG+?=
 =?us-ascii?Q?RpSDFdCqVyjuPgfDCaoofshcJ9cmLwn1X6EQSGEf2cGRr8jpmU/tj/hCcOWb?=
 =?us-ascii?Q?ZvLqFEy+V1tmDUB87q/8sJY1RTgBnWEQDNsknFLDssTzkZIiTrDtsTxmkAJx?=
 =?us-ascii?Q?voRR9fqUfsOWi0DjEEIqN3yLW4JlN/4hPBu+hXOwHjDQgigX1uCoYCDPIZ+9?=
 =?us-ascii?Q?ciPoKsZbJrAiQatxV/0jQe4A953Iq7S5vnYJs2x747jIG8+73yROjS1Tdk4J?=
 =?us-ascii?Q?94I0KFMvBnDGptnWk27PpPBvWGXsF3Qa2vzm3gAGnosSqbj+LCNwlWLlT1Gj?=
 =?us-ascii?Q?yQqDAxvF7q2vEELum3rKvnDIekncFz4tjc2oT8PJth9kSn1plGahZdRnpPwi?=
 =?us-ascii?Q?0dTf/wVGmlMtZbutZosmz5XvqjMBsUqKeMTwXUJhhw/l8WCoqG9BC3BOqJ+Y?=
 =?us-ascii?Q?YGw7bOFpLU7D4O6MltJ970kOcx4FrH1wVEf6ceVOd08cKhRzx+5UP2sdeRYf?=
 =?us-ascii?Q?I0kvTF9nFaLgsbWZ/jhwEPmCukqn2wK7QdS7zagDbjDwbeEVVKqyxy2NvTZg?=
 =?us-ascii?Q?5TdgJijdmWr64kvYA/+MsA7sGeV1Upjyi4yyndRyVvUy6LSONBATpmSCtMn0?=
 =?us-ascii?Q?VkVsGHy4kBoT0GVhtH2bglJlYGKqNGn464imq4bmpWDBGR0iCXDFvvEkJGJH?=
 =?us-ascii?Q?pTqbKu7SIkF4Y3VNFzyEkiSNkG2Hkm240DVV/7ux+0+Dih9CIti00edxkmM9?=
 =?us-ascii?Q?eBfva7CTnLIGLcBJlfeQPG2u89E9D+s6Q8UOY+XmZq4tWUzxa5oAQNLPlPBJ?=
 =?us-ascii?Q?wjmWgmLWZyh7btqAAorGrJu9UjvaaZ+WiAKlzmLQQRYd46aDX3ByDy2gE3LH?=
 =?us-ascii?Q?kvF+4oj2onkGSqQVJFOGDpFlzx9Wi6Jc6HCmEJyZ/tdwdb7NvdXVUxy6ukLo?=
 =?us-ascii?Q?+VtVvxWgmv/J+R/pKfXTtU9JUQflPQSjtprfDemZxYO9pxDIaaVf3dji3HEg?=
 =?us-ascii?Q?dOgcTGyohHhs4CEUTNZBSI9PGOnKFgUUz09No6jBPXNsyEPeV1kK78d+nc0I?=
 =?us-ascii?Q?Mk/m7w1FLXfeWPsckNYtyS5aZfV9nRfgQCyS7kyuZU46fWT6bpKdSkcfIMGx?=
 =?us-ascii?Q?v7PwsqknmZZcaNIuf96QvsbpO6+gM8sWxuGT5GWm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SRUVymUnjFnb5Ge8OWWJFoUoApZ3LhVWCqaaTho5O5U1DJ/jwQ1FiF5dwtnpg/t8hPsMvybA/Y5E5S1RaI7bIuC4Yp4Xn5F3JOSNo68fq5dW+ndFR/SEdWDMzja/MCciRGslNvzBNbih5vgofqDWwMNBfNMSxCBLqnpgVMwheb6TATQoMgQDGGDDdpFzKlzq1dnLwUV2MSDJDnhewi5QGQV4BdSNINVr3hxPuffOi91zg7lA2/LMCaXzbBfkUILWme/WQ6h258XypHNa/AaiPFNIo8i85nXlDb1bww0tdYTx+iu8EudE07FphKqwZSCMaTCaLb13DQ1YbRfrvzmucNDQjHQ2VyeUO9ndFpUf/OgMccXHuLWEBfiux0XXhD36DzRpbWk/h2tApKIeZmGI5NSa4iaWH+Q5Uj+JKqDp6ErYv+6oyyZMbPuUhOzftYFTLIzkCGPp1NJONxEPHZQnV1w1trX3glGCqxB98uWxG5kxk1tmehYnHkVc2bwyLpzCpJW7q1CdnkKByLEA9C+I//hUYhMi+o0ndgL2tvCL7t2s6JXVVkhxxb+5E8R7HbEYutR5xJYizTVdO+yyNvuVE4SveXtItdaiYUUpUtXuFvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92864d9-9cc0-438f-387d-08dd917ff6a0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:08:14.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtEtAllgLpEoLHS/1eh9tyR+4GM2FOBH8QnkTjlkGVIkTDRszi3d1Y76OJPoc+S1NnYZkF7rqncr45khfPDa0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX2AulAUiuzGMM ozNUKgweRE1MUFD6FzK9xk1SlGLWSU2b+vzj6vdaUGAYjeAbC2RI8vqKf0qsRHMXk1SjKocMj/y /0KVct1oifFYMdfigZdsTCPzEYIz6QrwCHJw9SzNwjRD9z9vR1Pl7Zsw0Ch9/RAF+TIKbK8mhXL
 xdyVMOYFBL4SgGgf9e9hF/wwuJoWjD46xf7jwiR3ilZAMO8tLIA77q6f0bqinW8wPQ3Gg6oll3p TpXmFirO+wG5NUinleGQ8IqRUaiAvZ5yJnwgEmI+dpPSLbD7iggz2y2SrxFqaKeML5pSGDL8u75 LG75pmQABvaYNkFuh+b27iOoxPoAdmwns4XmQLUUpHvoF9NqzGKCqqJc5WzN9NHA5qKEo5vIOwd
 51qkGplAev9x4pcf2uBHZXI1y8k69JCCJYZznDxHp/q4nAV3SdQJDwg6YbrnNeLa3wytP7lb
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=68223925 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CCQl0f_gzoSaXKsslUgA:9
X-Proofpoint-ORIG-GUID: HxtTOh7dR9lHmcTDUnLYUbKuzB4y93nl
X-Proofpoint-GUID: HxtTOh7dR9lHmcTDUnLYUbKuzB4y93nl

Extend the `btrfs device add` ioctl to allow specifying device roles.
Users can now use the syntax

	`btrfs device add /dev/sdX:<role> /btrfs`

where `<role>` is one of "m", "metadata", "d", "data", "monly",
"metadata-only", "donly", or "data-only".

Stores the device role in the ondisk struct

	struct btrfs_dev_item::type:4

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c   | 12 +++++++++++-
 fs/btrfs/volumes.c | 17 ++++++++++++++++-
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a498fe524c90..d61847e64733 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2588,6 +2588,8 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	struct btrfs_ioctl_vol_args *vol_args;
 	bool restore_op = false;
 	int ret;
+	char *colon;
+	enum btrfs_device_roles role = BTRFS_DEVICE_ROLE_NONE;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2627,8 +2629,16 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	if (ret < 0)
 		goto out_free;
 
-	ret = btrfs_init_new_device(fs_info, vol_args->name);
+	colon = strstr(vol_args->name, ":");
+	if (colon) {
+		vol_args->name[colon - vol_args->name] = '\0';
+		colon++;
+		ret = parse_device_role(colon, &role);
+		if (ret)
+			goto out_free;
+	}
 
+	ret = btrfs_init_new_device(fs_info, vol_args->name, role);
 	if (!ret)
 		btrfs_info(fs_info, "disk added %s", vol_args->name);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fb86d5684454..871fff21ed85 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2708,7 +2708,9 @@ int parse_device_role(char *str, enum btrfs_device_roles *role)
 	return 0;
 }
 
-int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
+int btrfs_init_new_device(struct btrfs_fs_info *fs_info,
+			  const char *device_path,
+			  enum btrfs_device_roles role)
 {
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_trans_handle *trans;
@@ -2784,6 +2786,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->io_width = fs_info->sectorsize;
 	device->io_align = fs_info->sectorsize;
 	device->sector_size = fs_info->sectorsize;
+	device->type = BTRFS_DEVICE_ROLE_MASK & role;
 	device->total_bytes =
 		round_down(bdev_nr_bytes(device->bdev), fs_info->sectorsize);
 	device->disk_total_bytes = device->total_bytes;
@@ -2841,6 +2844,18 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 */
 	btrfs_clear_space_info_full(fs_info);
 
+	/*
+	 * Assigning a role to a device via btrfs device add automatically
+	 * activates the role-then-space allocation method if it wasn't already
+	 * active. Avoid assigning device roles if you do not intend to use the
+	 * role-then-space strategy.
+	 */
+	if (((device->type & BTRFS_DEVICE_ROLE_MASK) != BTRFS_DEVICE_ROLE_NONE ||
+	    (device->type & BTRFS_DEVICE_ROLE_MASK) != 0) &&
+	    fs_devices->device_alloc_method == BTRFS_DEV_ALLOC_BY_SPACE)
+		fs_devices->device_alloc_method =
+				BTRFS_DEV_ALLOC_BY_ROLE_THEN_SPACE;
+
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	/* Add sysfs device entry */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 73e26bcb19f5..5dc2db4ed00c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -778,7 +778,8 @@ struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices
 				       const struct btrfs_dev_lookup_args *args);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int parse_device_role(char *str, enum btrfs_device_roles *role);
-int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
+int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path,
+			  enum btrfs_device_roles role);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
 		  struct btrfs_balance_control *bctl,
 		  struct btrfs_ioctl_balance_args *bargs);
-- 
2.49.0


