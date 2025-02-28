Return-Path: <linux-btrfs+bounces-11928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59860A49137
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32C83A9A5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622B1C548C;
	Fri, 28 Feb 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IdX4EOe1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ljOoug1v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B81C3BEB;
	Fri, 28 Feb 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722160; cv=fail; b=QOjTf9bsByR+6v5CRt42gYW2PUze57+qJXXSArA28CFSRTYBEtudNL6zdKjyggyVljXMHG9TLj3XOqpCpNwhz6qvd2Jdxmtiu4B77ZCci2w1RaG5nb273+O09AxVnuV9E6bsj2/hNN8GD1YSkPUooc4UVuwumR3zyPr1VbQ5bxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722160; c=relaxed/simple;
	bh=uhpA4/uPHQua9cp0VS1WL5LwpDjvzUzvN4KRF83/ArQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0kiUYmHJuubhzzrx3N43jIaV9k1YKsnOjK9rQm7U8SucIn7ddn5l5NjBqb8kMNQSUxc3KTtS22R1xoCBAQgvGAH5noLUk8yP50AX9LLma3/JTGi+z3Wb+Pk41zxBfQxD4mDycXhgHQRoj/lMEAwl0aw8/aR8NWB5dwUtRCMiTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IdX4EOe1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ljOoug1v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BkdG032583;
	Fri, 28 Feb 2025 05:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H9y+T4xVR3D9+Qh8ZhEYJrsZG9MSjBCa3t0gIcV3uvI=; b=
	IdX4EOe124qLlgh2FiE9q49e8O5EPx6LF3SiUYT7cWGw58eKJ6wty+4g/OXBHuQd
	UxdcMBQDfBylruWdfvkVPbcKLUi+SVJwiC0qFcvlDvMz9w0lmGMUp+SxvdMTWVcs
	mb9idhOnjPM9Ep1wO9Dw9DGESSHwbiGjJ01ZxBEqMJvK10Cd+bXfP82EN5TRwcqW
	mmd0241jQGyKHjiXyAAxQBImR9OqsWQhru4t0Im1fq52grzeVsayA11lXM/3QBZ8
	wbHN8DLSFi6c4wrHuZe1dV8oxXh6yaMcI9MwhwV9BjORicqSiRmPrQqUvlQ9kknH
	Gk05TqjV1WPXA6dlBoMOGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfvv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S3fi2t013099;
	Fri, 28 Feb 2025 05:55:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4530jwem5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpQK4R34GvMZWCWPotzhBK5SU01QCxfWereq9kksyI1ZuqlJq1+Wgl/xg6bL8jLFTGoBWKzGyt/Qp0vrkYILvgfERgSHZxEm8p2pO6LVyx7HjanDIrBPNo3MmD62Ijz6RgOlyAy19hXt6aCiqyiXPMFOGMz8N2m9LwOy5eHJ5MAuPrJ+DasfhLFCbRFU9KIIiK5HTF6b5uKLlmzZwy0j4PYpLVXkRmeOxRHZO0VQtdVkJuijLivSyG/IN+lnRHVHWn88UyE0sply761zH9/YzcTW01DQwbAVnMV5iWKIgQnQGDUzrIefVtZhjfrbOl1b8jaCed6ri8Z4eiAZn7EjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9y+T4xVR3D9+Qh8ZhEYJrsZG9MSjBCa3t0gIcV3uvI=;
 b=XCz5D+puTWUNil4Akaz0/RFazTrROanbWAdz4KLr41YMUzxkGMSiMDWfaRx+Xe+PkTldAesPuSJE78T6uwKB3vwoojT9cvS2DsXmhyeXUYF++XzjXMp6GjB1/0Z+Pybq8jXycI/d4LyBMv+Mx1+UgFLRx30+WcD4tjH5C5IppJbSkZhiFNM4A1mU70Ov/tm2C+ya7mMfbuACUEMoJSc9YQbR/Yled6CVElyOiB+yAgjhTgPDp6LUmwODVM1Ap5f/AAHSAon3JsFWnYl1aqyHJUgLzhHH+TjwNRq3dYznWTF51Rgh/3qeP7rSnm4CWlPPy8JO2xWwFfLHkwRc4fRZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9y+T4xVR3D9+Qh8ZhEYJrsZG9MSjBCa3t0gIcV3uvI=;
 b=ljOoug1vIVKaegunOxyIGpMq1RvmXC8ez6Ise95HV6DTyJoVmEoNLMfNCCu3VPjk3V6DQzB3WezwEuMljqGj6DIfTgb+raAzT9RAw6zBbs+nnPawFh5WiLosJPDgj947G4VCSvV/Jt7ehWQWsebmbz/Nu2IMtMfIWMtQzYerxp4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 4/5] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Fri, 28 Feb 2025 13:55:22 +0800
Message-ID: <8331718c0314fc373ebb2f43655ea2272759de63.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e37fc73-0d4b-483e-af85-08dd57bc8f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fg0dNJ8EO4tuCCHp2aLeledtvUHjJb9w3ZomQYa4nIyHZBvWMxfClEMXg5eJ?=
 =?us-ascii?Q?i/g8qUnBYdzFzGJArzQ0zLRDLqC46HZ7WTfC1PpMQcz+dlTfkwW7uOrb6v6e?=
 =?us-ascii?Q?plmUwBEvYgC/oWUDmcoPHzvaCBcQD6hMT1UMdl9LPMu3uHrsndbQA5duo8gH?=
 =?us-ascii?Q?UGSCNv4XG0oJ+xwnEq9/bAMPFAupBeiviEQRUOsTX/aQJ1WjtBmubpywJj54?=
 =?us-ascii?Q?nY+iFYKzDdp15KSuFJJqYyNmsNrmJ0PgLu52wMKVvxHmJHWr62peJzDo9jMi?=
 =?us-ascii?Q?m/kwuhFZBxIC9BEY1kbsOiLInp31RxdGKASyykQ1t900wHWen9bOd9HnvcTt?=
 =?us-ascii?Q?IKkLq1EYG9an4sdlaAu+BvYgpbPWYH8nUbftfvt46oFiZeaoLsuxciAes+v1?=
 =?us-ascii?Q?lLCgj8Sii2TFNLbHwgC3NpbrBQivaidok6sV+qFRPPpheRnWWztTzwuWhEEj?=
 =?us-ascii?Q?UyqA0C58B3ZMAaup0/ePKsDnOCj4AKb3BA2WIhzxWWPeA1wRyOKoTMAGzxNa?=
 =?us-ascii?Q?ORjMoqOWBF02WOBzZTxy72g6FqLYx9vTrfNzYXEhN99WN1gP/IHhhBJXoVDH?=
 =?us-ascii?Q?EYKc/gpUuZYqYc5s9rDdkpI5y+Mq1h13fANHbggsr0++R/iBoelXy8gZl5wR?=
 =?us-ascii?Q?AdLiugdQCByEqSb0DOWR58ka5o5WV88zrxtNPBe/nlc544vchwZl2cjUpkGj?=
 =?us-ascii?Q?8r5TdZbQI5gmDqR2gUeFMKApQ2fndlY+aRfegllvQA73rqj/4gv6Ur6F9E86?=
 =?us-ascii?Q?/BgdYAhmkA6LfQ4mbmx1mj6Na59tTZeUN1WqPOCWlSdHZC4aUqaIJTCfEYSr?=
 =?us-ascii?Q?uS1u2ylybKZ+jjrFcjp3gcKAsKwF+FMbH5YTSgmfrOCZWVw+sfkaNwDNpH8G?=
 =?us-ascii?Q?/CLMu3cegK4XAZk43R0byChOhqz/b/sJGUGndimk3dhNHPNSKVbir81/HGvm?=
 =?us-ascii?Q?F4WGTVbdTnQjmZYomxWSubSg364c6EvfFczs4qfiiRSV4mh9YcdJPXFXqJG2?=
 =?us-ascii?Q?wF5nfBAbi8K8jQbf80voSlENHdJAXHeZ3VcXZJqo1chfXN6ZN0MHfod3DM7Z?=
 =?us-ascii?Q?LbjyDzmiSKggPv0oW3uf7NUZjnXAUo2MOmLBm/fj2DrVEx1umnb/NFRt+BSz?=
 =?us-ascii?Q?8zpqX7ygcTA3dbE6El4XpXU9ZPggGZV8z+H6RwJYaRbfkFhXczfTux2Nk1Yz?=
 =?us-ascii?Q?vfZblDIbdTGFtIFJqFhoomR6LyDHMYL7EBNJKU9gRBRmbolRhcNkXXhV3khO?=
 =?us-ascii?Q?dvO/COPibd6tHKWXBDPTS/xmwLOmB3G2bbhI5AtAmGGO5LD8lq5HmSlaCWxH?=
 =?us-ascii?Q?LFEYJb/mck7ImFFz1wIVAAJ7c65l8SsD0DjFWiWYPXWI9feCkzmteikGbJbK?=
 =?us-ascii?Q?LpIhbXFQksIV9OWHCM8C+fm6r7OT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8egojDXY2V9TI0dJXW4pwUZLssA1gfLI/TlcTnchx0nn0Tm0rYcZ9cCdF0Eg?=
 =?us-ascii?Q?aOCZLeFxnhC9fzprK6dmM2kEUimaIu85usVaEczFEMCnKRkdBd5zGlipKPhJ?=
 =?us-ascii?Q?oGt+PwItBVkYky9AJqNx8ST8wtp+1vdBywUsPBizMSnuVqKxi2WVPxpl/UGK?=
 =?us-ascii?Q?ertLjyq4ZtUjhkzjZELxJErVWEhnqf5gnHYup7xO3STy0A6t9XG1kgK0ZwnU?=
 =?us-ascii?Q?xZ03rcXF9v+k4+3KCixgBuyTEvDdaxugZgaWKlfbU9Lm4sMsaASYBO3+37VJ?=
 =?us-ascii?Q?yr/hfxabbtIUIPYLYjYPBCDGuY2rpcq09ez0JXspe4ONv5KQxfh1eJzjoUxc?=
 =?us-ascii?Q?YCGq20E04Sfoz/QTBuDNlIznFKyojlaXvNxpU3DBOaXARO64UC+AWl287bo7?=
 =?us-ascii?Q?EGuTkl1SJc41LMoiTggdYswAPX8tH1iHdNYFrN9cwirDE/cuaMIY66lKvMDT?=
 =?us-ascii?Q?iPw9VA25TBIe4NopoDURSF0I/1EwZ/KeTxFUHS77oo/xvg7qZrpSwDrYQp9O?=
 =?us-ascii?Q?smhhN4BOwfOI9f+wWwaF5HEN5IxTLNXuQXzY2tBKylcrrCmPA6pxvMiLY3uX?=
 =?us-ascii?Q?DwalXlGQxXl9p0mv4Efrgfm98sTwyoaaELfh5to8LVFY2XptISVJ2+34wN7U?=
 =?us-ascii?Q?uBI9WcJipJWPPDD0lA550Pzd/t+663UxNFpvwDPggqUvboawYk3ZxyPDUZJn?=
 =?us-ascii?Q?09+2hEshXknf26tDZXA1YKNY5xqZdA/zrSiS7isaNXWRR2ZMVRJBizOzEGjN?=
 =?us-ascii?Q?6CcTKpk71D9he20oQjm56RAiY/LbpYT0Sd5bQ0mbhi2rQ3cJduqICpwhwDVt?=
 =?us-ascii?Q?AI6sYQ20pWsraThBdc12wdcb6QNKmo8riOPTEe0KWg4iqFdJP4Red7PL9fdA?=
 =?us-ascii?Q?sGrhB/9RypxbJJN0Cbu+lHgmHUwOQD2Be+LrptfPewZAJWTNcEbnf05BExoD?=
 =?us-ascii?Q?gTR2rdPgg/CS2kmIhyfnRLnNA/6/OcGnu0/OmDIZyAJL3uOfwcU0sRXHQGkd?=
 =?us-ascii?Q?dXVINySxbQ+WIu0mSbTVMzSBnrJLP9vzAMUDEtRFIGFbonCtq5e2n2OZFuKj?=
 =?us-ascii?Q?RIRQ1i6EMNCXNcD3m/MyjlD+4bMn/JyEkwdRa7qvw5ip5p84orqx+PLWJYfn?=
 =?us-ascii?Q?vO9xEbOkF4rZAPkEyhbf5tH0LvHnIu3LQuJY/VazvmqnVPCNhqsWPMuisPKu?=
 =?us-ascii?Q?Qvit91suc8IJrg/Vbrd6UiIQB7UNPLZfG0MmuAqrYoeyC1hWOI4ADM22BRFj?=
 =?us-ascii?Q?FMyqzhQbz6SsaIfqdhBzoCBC0PNfujgVdcskakIuqbiX4oVDiQJvPBExo1Fp?=
 =?us-ascii?Q?IDyRjXZV6LVbGEmE3uGC/i5Qn7q04B/TPJ+tSIULnMzDR9SAZaY+4fESrEot?=
 =?us-ascii?Q?b/dE65NtsGLdZ4Bc9oBN0FoBbRTd1HwfeatD54uiqzL5Ym9a9a4enZ3m+suG?=
 =?us-ascii?Q?9S/NumIoo4jIPLHmmPihBGBGL455WER1627Sp0d+0qaFCY26uSNvwWVthibx?=
 =?us-ascii?Q?Xp0FIFztpvlaVScmxLXYSHOMS4+YUH2uDqphlJbXN6nMJmtPSkU8OH5qB3VU?=
 =?us-ascii?Q?ckA3YjPdH7z4P3GGi+ANaoxUgxG/SAZB8k7Q7B3P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N05bVhLHKWkdyB+RcH0iE4It4fo6DudfKo0Ypc/QyGocEO9dOEnWKxujxFAmArgWTz3lZ8nx7pRNa6lr0NHwbrvn4/vsSF/C90CZtx4ycEyTh0gTCoDCNUujXiIWEbqw4qDOzCPRZOX6B1OZGEJq9WgJD16RHB1mGbl0rF/gg69QIDkVdimQFg6FoSSXBY+pnv0c+YoBqQMjS1xHHOXeFpSjjHanhWRGh18W+lk5FujHD8+cBebL7gnTUkKr73pyGbk2vEXO8LKctnjgBcXtVQaxQOrLpfVugWZr3dO8DatcH/Yvrfe1FuZJ0xvDIHmXJGyZH/mDSaD5NqxMPOPugRsE9dHJ05ZxPReSeBKyrnVwpypyEuXi7bVd648m3BUpRP82AZSwBiIm+LCJuaQFdwprGuaVxIRBixnkQrzpbVf5cK8Ckzf5fs+qPOM4pi+a/6Znk2fapdX2dAUo0md44dsuKQgiFo4fqPrbZynNclm3krmpjF6RDC595TleUM3v5Iw0abuDJXFcnNUCpifWGU6EtGaPldY2KXamtfHDs/DQjJ/WrplT9EooYirJQLkegodByq/8S01Jh3DOsml+GEgW3IEicTrROMlstAYWUk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e37fc73-0d4b-483e-af85-08dd57bc8f19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:52.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJ9Ic041Wrq3KgijhF44veAn8fmKGD8pVFfvEvd7IvZwGZYYKgXrd6QbcJaM2GuGkkFFKbTxkcB4aTbMyq7v5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280040
X-Proofpoint-ORIG-GUID: S6RG98gum-4VuGZv14xspdhbWwqcSJpP
X-Proofpoint-GUID: S6RG98gum-4VuGZv14xspdhbWwqcSJpP

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 19 +++++++++++++++++++
 tests/btrfs/329.out | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..48849ac82706
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,19 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Verify sysfs knob input syntax for read_policy round-robin
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/sysfs
+. ./common/filter
+
+_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
+verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..eff7573adb6a
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,19 @@
+QA output created by 329
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
+Invalid argument
-- 
2.47.0


