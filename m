Return-Path: <linux-btrfs+bounces-13130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2BA91C35
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF819E5126
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCADB248887;
	Thu, 17 Apr 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/b5Wp3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x14oJHly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E672441B8;
	Thu, 17 Apr 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892911; cv=fail; b=n2iO1e7wHMaMLjlqsrx8lVS5GFHMgQMyAnB1RWB4HY/BbR7ZAX6oUXdKpEvcdsBmqHoGxO6GkUwQyqwfPdUN2utZI+tHrcT0cy5PzVVeNKp6vasT7+JVFXOgg58ffHe1t6Lv+VrwBY8/hxdZdeByNuVujzV/C7iieA0Hr4IOVx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892911; c=relaxed/simple;
	bh=VIK6pajQhXFRXIJ+TvMgN37MUYuvmWPHtq5jpdYOKCs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rurdL6/Y0CG3wis6pTbFSNVhT9n53ZzanE2AZIg56J9tM65DKpGI7nNAJVhSTVE/K+ybJZZ/FN+EkYo9Fh6o0XBSDkuT/rQM3qh3N3JoQ9JW7Ecj3ejCvTKcbyllvEI1xNoagom9kpIXEggntIVqGNymZ2hl5yV91i4Sb28Bcec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/b5Wp3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x14oJHly; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpdfj002448;
	Thu, 17 Apr 2025 12:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=FXXP63Vzh+YD1HUa
	uZAopYqz1zhyUcfu+BOv12xitUs=; b=G/b5Wp3ArWNY0c56WvhispCTkE+VpNoS
	m7rCFVbzTuknT2EGU/U4YtBejvHbefKOUr7eMenQH0zXuC0Go8YgfqA7lc9mY/s9
	zKLvoY4lb3frSSu0ea06AEsE6sgpiRc3nJA6gxUNrDRReZl9d25wmcjX0Kepqbhq
	6UKwGB0c/FwGkI+c3c5AVckYcS4vVB0Qbt/RFisMPD4hVvXg+x7F9FpRPhnl+PFu
	N9sIX+VBYgULnHQYZWh6xjS9VqRhSoH/Zeh7iWjrzs1tLRfecMX0Qoh6HJsojkjt
	OC26Ze5kBqUkD6RbfXdjYoCtiZcca6G3iaOrQNOB5lG7T/c859DXcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mx692-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 12:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBFT8u005662;
	Thu, 17 Apr 2025 12:28:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5ydms3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 12:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7BhCgQs7j2cMg9jqi1lHzWcSpidH6n5HaozOlRSd1h5g1+sQOAPP6TfJuzEq5viPfye8V1KkLCEhCqLW3HOP8nlJyzZlvrs0gkWnMxR9lDQ7zTqFtvHArebzoZlqtTYFVmFA4H7Ent/SzmfJMJBMeBkLlXnNtFw2dJpIijdxzElhcwadh5u69r3JTLYxlG1TLtD473pbxJIoUfHRQSnWxp3Hsp8giOkmlusNcRBcymjvDr0q/+4vZs0YCZmHVEos9q2EqZkqHfuOtO23ABKFUSMipZSvHTSMTAaAHZlcSuWiy84LZjbLoKnAKwl+epg+U/97GwYz9x8020tabUjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXXP63Vzh+YD1HUauZAopYqz1zhyUcfu+BOv12xitUs=;
 b=G0yrQaTn4wSRNZAhqRfBtrmLo9rlWxunhVw4Lb5qg8fbVz8ufrn7aItBKkbVdHUmVHdLeocuxSnJU0CYnofBL0QXdvRIunGO3Lma4LSYb73yAhyOXMdKcMCIRiRQnH4HKOcj9X9sWR10biJlx7eIFwZUZkQEZNIq0nd2j4+J45grrlWM+cuc5vLNLCCigBSwjTsmYJgu8CtUH0wBiiZtovYBBS3FQp7Gjgl5Kf2QDcLZrYpKuy44VUkgnX3Z9v+VfXTRlN5ph0l9Pgvw9qzzJgZOzkUzos/r7digcH50VW9LbMjgh+Ka1aFom5hZ+GkptHkexnizmsQV8WIl1tOlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXXP63Vzh+YD1HUauZAopYqz1zhyUcfu+BOv12xitUs=;
 b=x14oJHlyMmW/nBjnrq5VGkxiUoEzOq23dTo9gzC8hAEsB1ZFcQa28w3NJFANNKbqC5EySw/ipUK97O3z8TLzbbWZ384rjWOkNjcL3QQK327wHzq8ybc/Z6YUJ6tGP/voaalcf3Teplk8eTJoHaUuLqLvdlkUbuLGpUIPUjeJE2E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Thu, 17 Apr
 2025 12:28:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 12:28:22 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: common/btrfs: add _ prefix to temp fsid helper functions
Date: Thu, 17 Apr 2025 20:27:22 +0800
Message-ID: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbe32ef-0cbe-4cd2-8072-08dd7dab577e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFjmbZkPvQ1WMKHIIUqsskfaiGS46fpw/Ppbe3pQcNmAeBMZUzt+8wr0rCDr?=
 =?us-ascii?Q?NbBxtJDjBhuxbyBRFy8fzB/FrHlPJ0QELkEgR2mCGtK4DYR6HhD4eldt+SOh?=
 =?us-ascii?Q?XQ/2W12hKhemHnoxBX3KBjTyI9myckKeySFocyUcAhWs6fg2k1TJZtL4kIck?=
 =?us-ascii?Q?4TGISxqYFnx39f9Ac//8Hy+G9VfI22lSwZ2sGXQTIPKCz5LB6C+BIMi5vCQx?=
 =?us-ascii?Q?QREdKgB3cDXp3J2TVt5FH+e8c2gxVtx95o/wCGA7005lD0hFsyf9UIRJVdpa?=
 =?us-ascii?Q?WKIvMJLsQC2atOQMc+MrBM/3Sx+y9P3HYgdU0tEzJsEPZvETBgzR7dH0VseA?=
 =?us-ascii?Q?i4Ah/SjR5GZyBdUSNaxmWJ/4qvgPGGdQ9j9oHXn57QaS59wwQkb6Y7frmZ4q?=
 =?us-ascii?Q?vCk92ZcuuZXrLmJ6UtfAAPFSxPGjmFcw57Ay6ndCJuJWCPiVS3X7ETNeqAM1?=
 =?us-ascii?Q?aVbZ3PwFMW6X6kpsGeqroNBm5zqqI3Kpil+cjkr9KLvrSVE7P91L4J9gMP5N?=
 =?us-ascii?Q?Epu9CedEhjjaG4WQVEDvC3Vtdpqn0xnRVYxOTL1RJEBgzpUAFlc60k+HpzGr?=
 =?us-ascii?Q?IYSg08zSFCetxLYBfy4Cy16WNvRmiaBXwT40CH6L5rJHkb9yY9Zmc/kJlL/3?=
 =?us-ascii?Q?046gTeVz6EpJPNW2nvuyN8B5ligZHq/yhmNJXCOt1yQmcrwloJa/UyrLlVBE?=
 =?us-ascii?Q?i25U3SnRdBpBYmdpAkFw7/McGgd4FwSOPHw+AggoDK5QlogCJSWEfVOI6ZqH?=
 =?us-ascii?Q?W/9gTOMR6whMx+Mmoj+R02qObNjCojPjiUXSVbTbU3/k4Tt0ZUskAEQGdYE9?=
 =?us-ascii?Q?pmRDI7mOtvFiEerBYNp/128k3tyhHqE9NPCacSvV8gUUEOWA8tWTiKR2BjZJ?=
 =?us-ascii?Q?2FACsxrcD+fhTAydACksR2DOuEkqHZUm9vwsGPdZv444xM7rSm1pPynoUday?=
 =?us-ascii?Q?kLVYyE6ZqHxhbWO6YzsIxDWXZ7yRENrX0WVWan4UOSEL6G9Vscy/w6v8GnlY?=
 =?us-ascii?Q?/BmfgF8iUKzPOtVYaLqzjujx6H4uvq+qNCoHsa0hgKfS15w04jIytKaZBTrM?=
 =?us-ascii?Q?/0Zl8edBrqi5lsFh2ZKxrNyMLMt+DPbwNLWymwGvC6ifUbWVgRLMCTeo0hr3?=
 =?us-ascii?Q?2Jy6DGYtuHDp70VM2M6Crdu30O27oJv+yHFKrCf45+uuqColJ64LpCVW7yFO?=
 =?us-ascii?Q?DxDsBfOduSyAR3XKu/lJ+CUDYSw1fgRZPVKtzaHMoJGx12vKydUsnRxjH1Ae?=
 =?us-ascii?Q?Zbqgw2+TVUzlPPecIsuFyb7Igi1gunDTWZOgB8AbaQhw0+tIB2ALQ03u8pkn?=
 =?us-ascii?Q?Ha3wO8Ut4wlmb6JLBhou44koKepLhtMB5oq2Vv6bZjJNrZtUEQPrpY9jCdKD?=
 =?us-ascii?Q?dWRTARvwkxHIuCgA7LKnwZ79o371CyQfvpESPCo4E8W7LEPf5mhrCNKh7QRj?=
 =?us-ascii?Q?dNml/LOeDII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5FDXhpxIMHVX/ljPm2AnniEZ+HStsFUqhbQH4CI2CRI5Uy6CTKkK512F6WE?=
 =?us-ascii?Q?GZvMiAmP2XOthD8+NGqVPdtPKZ+iVT25V4qNeT2KB3xBT5NipXwPRV08qX5O?=
 =?us-ascii?Q?tDI0djHqzKS8UjRzzKsKPnKitdiXoX7IRJX0uWsbT1E7yC/Jfa6OOVTTZk0U?=
 =?us-ascii?Q?zc0ciMcszlVVfxJpWRAbXzJwBnZoPDCZ8S6x+OKSjfmehhAA4kUNwkPGY0+6?=
 =?us-ascii?Q?xyrAJo436D/zoQqoSXXG7bnIBji5Q3MUrvScPYJOhksIIENv5g3twRnb4nqe?=
 =?us-ascii?Q?NGTGPDjHaTsm9V/sLMP+Fjmu/mUngjQTBQ9EpOzACfkOW3L5bRXTdt8WrKtX?=
 =?us-ascii?Q?dPAW4lme0fyhv9FV0+SCGaONQQ1tEgO6V/yGj88zSzozv0q/DSWDrUo+rMq3?=
 =?us-ascii?Q?AFSp4LRi6ZR/5FEHrIci4FZYxz1JkAEjw7A3GlCdBEGq2lmHTh88aZy003Ff?=
 =?us-ascii?Q?Pz9GrHEFmMtLBS0+YN7ur4Kvdlks5tk/S2QbrVyQIdXpxlEtsKLgvVqgDdig?=
 =?us-ascii?Q?gx5RINw6b7agaJsiafJvkiRwDVBJVj09vaytUUCytZ9FMSewX7UIaGWeHZsM?=
 =?us-ascii?Q?Vwu9hyjIcUOuModFSV+duc4J0786g6nNn14qogdyzKO773tPJS6w5YuyO/Pr?=
 =?us-ascii?Q?H0NuIiM+8lf5wIZ5nux6V8DotDo7HQ9UddPsC7qsVh5U3D/DfT/jDEAI6a/j?=
 =?us-ascii?Q?P0CehyXLFaKZURaEy1p1SZy7WGvPGmaQ2LHf+CV60w0D9/XBbGfJcehwRsbt?=
 =?us-ascii?Q?+Dq+kBtxufrtCd/WfBWglb9GlhXBDBHBza/dZZrBm1ndWtNoP1NxI1grNe2C?=
 =?us-ascii?Q?o38npnh0LfzkxAqFcjqesX4rfsMjxBu4cS59rg9WT0U9gp/QgVFbRAEqwoMv?=
 =?us-ascii?Q?yJGDmcacvMoUkXFy5f6rkWOLTA3s+1ySwQJxnvsUf9XBJTc0yUjfbwgY6f2K?=
 =?us-ascii?Q?b8FBwqBoIRoD2JZ9OQbwVUXWj97KoiAEvZRml/g6i1C6qutkwopbr52lBaQl?=
 =?us-ascii?Q?sYQw0GKbJnlitcbBs2WWtsK+bi+Y/cEE3G9CqHNZWCQxZYFq0eBvtBjuyx1f?=
 =?us-ascii?Q?3t/PZjOXSdoqL5P2Cx+iY36Hs7RYYX1ltgnWtL7hYDLMaJJW0UxLyW2nx5KP?=
 =?us-ascii?Q?EVvlR88kitLW0S1ElMymwu/0uPGQZ4eSPTjvtkaxbaxL7/lu/dRBZ0M6Z9fY?=
 =?us-ascii?Q?QwV2/A5dNSw3s0FBZMMmKzcOxIXsIork1y2d5Ykgjgwll+RYC4aMU7/GGORg?=
 =?us-ascii?Q?iM7yVz/V5ZOQWJXf6DgbFvoHpdWgu00MiNlvmPl6TS8dLdioycssbdw5jpJ4?=
 =?us-ascii?Q?TwnbzYPTNAyWAG54mbSYVjkJen9ZaQ5KwWVb4Fa5L1n6B6b4A/jJewmJiXcd?=
 =?us-ascii?Q?o8uU9ZTf8zvnSAfB/MNe6dlwF2ecAlFMfS6jBemQ09yU5DNgLoNH07/e+k6N?=
 =?us-ascii?Q?NRfqSWOv7/rUS7+rsZKecH4cUTG/PTiwnyhXVCqsTta6SWlo1vzTNYqHnvJo?=
 =?us-ascii?Q?CO+NOy/3IQs6PYm2wBgaW64tuHSYZTbjgsGO0R9KmdWQ89dYFt+f7u6VEbJD?=
 =?us-ascii?Q?GPPArm5AslO9b/z9F+mJG7GBzwbetxQa46iHkm3y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nu+hLGUNLYIbVVYfZB/fwJ9CMDQJUrESQEYe0mlgRqWKn5dJ4/2SAWqQuknEeO/bmWabQ6ZA7MEoAv6tB/4d12RWGXrRzL6rZf90eAV6QZmeao2Mxl1dvPnowZv6ZVJ41hlhdPa3o8DhD4b0CIoWVecYsdoLY7cUpwHcn01PjgDbaTHC0jv98EKYAwIkvPr+LdhOuekm6t5QoIGr5yxneS/knEoCLaIYriRvEYOcmmpdBMI+YDaL8U/nQEe0Ams2wicQPbVJ7JIcQaarXwtW5DNPkeWulXkisFWLoGd6UsKmAJ6gQb/ElK0tb4JXWNN2J4nQqMVogGEUJZnehp0/7mQgx5YHGcmRyHXC3a6jMc84RHCjkQX4x1LwzuUb+oW7XF7hLITSqh06rkMQaIHvC9YDvN/M+9ICLr4bgxaTYiuCFpxBkY208gBu2rdhvAdBtCtRKSldva37M1hW0Y6BV0gDCqJAr7MBPjV0/3Mi0YiLrKdczGeb4rwXmun7IE2Lpyx5uEH/aZh6DlLjqpl76+hmYZLaMTWjvFM+PORgfXH5RwlP1WaFlV96iRwDuCQbqXoREiNOYD0VZ2XoIByKA4diMryjEehPwd2d41Wiw5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbe32ef-0cbe-4cd2-8072-08dd7dab577e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:28:22.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm+xPgvcQSrjIRm/DIimK3iG89kaEnsVljIwbxi+tPbs/wy748IpBTxBlvM4AYQ2e5k0jQZcFxab2jQRmDElYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170093
X-Proofpoint-ORIG-GUID: urkcen7tcJJVT9bdDyUz4ExojG-iyyIX
X-Proofpoint-GUID: urkcen7tcJJVT9bdDyUz4ExojG-iyyIX

Just adding a _ prefix to the two temp fsid helper functions and
a rename in common/btrfs to keep the coding style consistent.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs    | 6 +++---
 tests/btrfs/311 | 4 ++--
 tests/btrfs/313 | 6 +++---
 tests/btrfs/314 | 2 +-
 tests/btrfs/315 | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 3725632cc420..44c9d6a6777d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -942,7 +942,7 @@ _has_btrfs_sysfs_feature_attr()
 # Print the fsid and metadata uuid replaced with constant strings FSID and
 # METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
 # it matches to or TEMP_FSID. This helps in comparing with the golden output.
-check_fsid()
+_check_temp_fsid()
 {
 	local dev1=$1
 	local fsid
@@ -979,7 +979,7 @@ check_fsid()
 	cat /sys/fs/btrfs/$tempfsid/temp_fsid
 }
 
-mkfs_clone()
+_mkfs_clone()
 {
 	local fsid
 	local uuid
@@ -990,7 +990,7 @@ mkfs_clone()
 	_require_btrfs_mkfs_uuid_option
 
 	[[ -z $dev1 || -z $dev2 ]] && \
-		_fail "mkfs_clone requires two devices as arguments"
+		_fail "_mkfs_clone requires two devices as arguments"
 
 	_mkfs_dev -fq $dev1
 
diff --git a/tests/btrfs/311 b/tests/btrfs/311
index 51147c59f49b..9ac997dbba61 100755
--- a/tests/btrfs/311
+++ b/tests/btrfs/311
@@ -47,7 +47,7 @@ same_dev_mount()
 	md5sum $SCRATCH_MNT/foo | _filter_scratch
 	md5sum $mnt1/bar | _filter_test_dir
 
-	check_fsid $SCRATCH_DEV
+	_check_temp_fsid $SCRATCH_DEV
 }
 
 same_dev_subvol_mount()
@@ -69,7 +69,7 @@ same_dev_subvol_mount()
 	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
 	md5sum $mnt1/bar | _filter_test_dir
 
-	check_fsid $SCRATCH_DEV
+	_check_temp_fsid $SCRATCH_DEV
 }
 
 same_dev_mount
diff --git a/tests/btrfs/313 b/tests/btrfs/313
index 5a9e98dea1bb..d55667f733ee 100755
--- a/tests/btrfs/313
+++ b/tests/btrfs/313
@@ -30,15 +30,15 @@ mnt1=$TEST_DIR/$seq/mnt1
 mkdir -p $mnt1
 
 echo ---- clone_uuids_verify_tempfsid ----
-mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+_mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
 
 echo Mounting original device
 _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
-check_fsid ${SCRATCH_DEV_NAME[0]}
+_check_temp_fsid ${SCRATCH_DEV_NAME[0]}
 
 echo Mounting cloned device
 _mount ${SCRATCH_DEV_NAME[1]} $mnt1
-check_fsid ${SCRATCH_DEV_NAME[1]}
+_check_temp_fsid ${SCRATCH_DEV_NAME[1]}
 
 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
 echo cp reflink must fail
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index d931da8f0293..659a85d39886 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -36,7 +36,7 @@ send_receive_tempfsid()
 	local dst=$2
 
 	# Use first 2 devices from the SCRATCH_DEV_POOL
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
 	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
diff --git a/tests/btrfs/315 b/tests/btrfs/315
index e6589abec08c..90f77413bedb 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -51,7 +51,7 @@ seed_device_must_fail()
 {
 	echo ---- $FUNCNAME ----
 
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 
 	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
 	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
@@ -64,7 +64,7 @@ device_add_must_fail()
 {
 	echo ---- $FUNCNAME ----
 
-	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
 	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
-- 
2.47.0


