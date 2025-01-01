Return-Path: <linux-btrfs+bounces-10670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C19FF4BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87273A2C19
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC981E25EF;
	Wed,  1 Jan 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HY4LMQUA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEqDmR65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558833EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755026; cv=fail; b=qh67yeuOWXgmFtNoQqzs/jMzU//+6MJG6RwyvFStokGv8o6gGZ0J5o6c2Z43o8ehULj0aQYI1gdWQGywPho0Lg/AgdkwZpkAnfz1a3YwNVGIxsU37Mm4qgtVcMrYjVxDFxTzVVkf7/wXALNiS1Gv/1MCnk3Kn467+tGoY7QUmbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755026; c=relaxed/simple;
	bh=8vgfFShkER6knPnhAas0XZX9pVV+P7Rar21OrcpqY1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m23GJeaW0OQiEorykDeDQPvqKmV6LGQ7L+QCU7maC24CMAxhgMyQOhFxUL+4mINZEjCEAwR3Hy2A37wacVKWWdgm76Y50ymo9err+5vYhDAl545Ldxt7JgE12nsT8V0gngNA3VNukNO9DiDWVBGocCY0v0WIkaRAWMo0byARQLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HY4LMQUA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kEqDmR65; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Fl60m025784;
	Wed, 1 Jan 2025 18:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=; b=
	HY4LMQUARBjT/HefmZTlR4tCvT6BqsvdB4Cn56YlgmqUzTXUrQwzzwR3tFFGoPup
	NN0ES5RGRTBwm6cpFhdpyi/vhJrVe7ttyMhY2lG+z4oxt1WKREEzPLHFeILLkdNL
	xzeFYDd8GbsMHthv7H9O+jVvcB/QLvWNiYHtG2HZj3FixO4Qyj6A873Zr1FPvbyC
	82KjOeUkOx9Y+JxIRQjmGGdOVVl+s5G4vuhRsqoXT5aTAkgCUSrSkWoKhO1D5aK/
	Km1TieCVtFxm10iRtOBHQzi5E9Ej23xw5GDCRLPEtCwYt9hmyX0MT8HRKwDzRzOv
	hIvoUDlrPcO/RvUo2fJY6g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7x04f5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501EUQPa009123;
	Wed, 1 Jan 2025 18:10:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s861qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7AdQflVUUUe7T0W1aMn7j3Zs1h3qWOWVVI/NipNJe2ql4dZTvDX6vMBu7jiPFQvXamxtS1MLsVUf1viWvGWQCHtK3uKc10f6tgMirQSjJXuRPz4YqZhIEbbr6+uDgiqBhQ92kjyGsUNyGPHzL1MyHhLJD62znr8MVJ/dn0vrP4xnJg1crY2c0ZtxsCKQHKZFNM+G8bNO0rvXr/PTSCQSEi5sKmjjvDwsZMMwMKyggQxsYo6Bxlh1/udnTOn5thK92/Dl0BaP9wH6ZMWZ8RpU3iEQmZoWvPq5g59J5Ms3W5hd91W70FX2l+g7H5vWsyA27gwapLJpQnrX4zaKdk+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=;
 b=aHqh/F6o9c4V8KJ27PZmlgF0GtrZzNTKttkVhmP1x8HfOreaUFJ4KCKwpO0lR3isusLXUa9BX1b0/6IntM2ZEBV9r6rcCLarsyKDyGtheeErkKimQFjdDDdGLniAAKlskSprSevI2a8gyEFcp+W+T9NbElLT8uuiXYvR9g4L3eS/U7C3KwJ0sfP/5wTaq2niEY8rb94EoSAVpOiXjpNrZrT2uckEzkzeq5Yi6iy5Gypk5tCuhjIKwRfsnwGKK06/0jEyfUizUrOAS4WPbtEZNGaeNritYaJt1wtW/dvpcSwcW2pf1FTxAIxk2A2OqWp4c51saLDfWVvzqWF4K6uxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=;
 b=kEqDmR65KTLcS6FY4eEISB/VnKOboaRpnlHUnBcQcjm3nExQX25rLYSmK0dL1vV96bD1EqRhPYHFxsRmkU1aBn4QO/7wj8RCyvnRLw3HIRGWquKHBtRa/tOQlALcUo19FgItQfBIIrVKkb8YMH+5NwaY6XaBgr87W/CorSeclfo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:10:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:10:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 08/10] btrfs: expose experimental mode in module information
Date: Thu,  2 Jan 2025 02:06:37 +0800
Message-ID: <0bd2f5b015ccbcd68dd1713ac3e4b598f0880cd8.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b3148e-dd6a-4270-6c6b-08dd2a8f8694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VS27kxHCta+j3IUFcfuumyQXcRiafmk+03RKVbXatSfbqbx0pxV/e65pagrB?=
 =?us-ascii?Q?4qTBsYjCU+ooVJ9hBYYMqCWcl/WGOOrOxUzMyPuh40YOqLrOXv/UwuY/wKUR?=
 =?us-ascii?Q?GN/LfHk6WBSXmdPkTDizL5GwmThsR8r50KN6f58jov/218kMd2pMxa+HyelU?=
 =?us-ascii?Q?FreJXYhvd3ZNI31l5rowzRrr+SKK0+zcSyjGIQUrcL6NyZXVUA7S+7oIbJnM?=
 =?us-ascii?Q?USdu5T+WftnTX9U5UXbpRZg1y2C+tZIKpJSbhZxJ1YBbO6B/VVHr+ZJ2G/cU?=
 =?us-ascii?Q?FkOQyPzK6zIZWe7cxqg3GgJCM9rk4E8f+VeisjzhfojetUHkcsIBJrfjUo23?=
 =?us-ascii?Q?/AUhHsK0ffAgr+9TPlNhrDoeAlK9MwbJwpGkPCYiUygLMVsu5khoiz3ljwI5?=
 =?us-ascii?Q?nyPcUGAs1N52Bl2/c3uhCbOXUkPENIcG+S5evnOfAWIc09HnirfTYJ2n4eS0?=
 =?us-ascii?Q?DwbLadTIk62I9wG5gcSfHTfGzYEIR/iXeC/+ks9Mh7dCTPBSRvLCSwWcZBFc?=
 =?us-ascii?Q?oKWLSzR3vjW+IyitoS70vOPFReNTGTsS0wcRCg0/8Zc/sA082GsN2gsm1Ds3?=
 =?us-ascii?Q?jAR2kq/11ixpp/9dD38uc4jxRHPRSE8F1XQq2RON1eacy3IADolTWNdfjBzB?=
 =?us-ascii?Q?9i3fVERY6uoY/dA+mdippAxgT874GgyQqZRAUzQF7lnDIisifU0dio+PA2tk?=
 =?us-ascii?Q?XSj/1+zrIJfUEL9rIRT4e2fwq8LE7s4RuGz9HL4hm2KtoNoKGcDAaEcyjpUk?=
 =?us-ascii?Q?ypN0Ljnk/MnEkAAT6Qjep5g5biwMLn45WzVYBkdgolFWj/qahFyo2sMMap2h?=
 =?us-ascii?Q?3X5Yum3+xOK+F2o0t4bQAB9dmZrpMpK3A2GMItuGXVX1svgGlewxAENTGtWV?=
 =?us-ascii?Q?XnHd2f54o+xnaEJZYulniKo10zVuopggXt9IJXHuYDtg6mDtY+gmFUp9tvs4?=
 =?us-ascii?Q?u3dGT5wwXg68JioqCGlJRraqfIEWzajXJnZJQWjb03rj+FW/L/pgtZPrKoVI?=
 =?us-ascii?Q?FC5Oxcu85GBzPV8g05YEEWg7jeODBpH/o1akrm3vPhhnBLb/64HQiUfccIdz?=
 =?us-ascii?Q?C4fFjJoI3/6ncTPMTXzJ29kKz7VTJcor+hd4m0QifUEh9YNge/ukP2lNQkqb?=
 =?us-ascii?Q?7RRTjPuaHESJrUd5PUn0Ne5OLvFx1OmFLYKpdgDH2yqadYe2mf+Unzn/eBby?=
 =?us-ascii?Q?voY2kvRBsWfH3UVRRJlKSojqoETkUAXm2fhwWeFFIrHYDqGKVX8lOOCtvrtp?=
 =?us-ascii?Q?p749oB1t1uh5IHxsP7X5Dy0jglNuEG5WrefJlE2AFTyYunWyunucGvL8CTqC?=
 =?us-ascii?Q?1rVsUF19SyT0u2qZmD3yPPI5Zz1J/2qN6bvPtUzkOpBBCAoLTMgzhFnkYYkj?=
 =?us-ascii?Q?fq3c0GWOxhCbDER0RVQr0iQfnzYV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBPpTXcbGROcLqVgeFzi/L6jnS6JZhG+RDHkmwIJTPJfzK8bHd4fgLkiMewC?=
 =?us-ascii?Q?VX/xzMG3YE0QI+fWeCHkT+/bDqmFIKjezRAg0DCX1Yr+UhBNTwL0WS2to7QL?=
 =?us-ascii?Q?PE7PMkVwEKUdbfjTtCgqxddHkqWxZbyCCOC9zEpOoAnrTx0/BikDHebITx7k?=
 =?us-ascii?Q?qCCSbJFZybnnzJqlJVNw73btbocr78Q8sm45pOCdOCrg4B/MS0QFdDiZJYH0?=
 =?us-ascii?Q?MVoCwYZwaoNiImiQMLrwk2OSi9RcFk1pKh3KGDglpgP33upRx4Ed0ts/FnaB?=
 =?us-ascii?Q?g446qz1NH110r2jQ4x1hKn998CM8nqJ5fGzxSh8/pHg6j7evGBbjoln2SYNI?=
 =?us-ascii?Q?MI0xmiP7IQ92eMDcAvoU92YepK/3eJ0rbXOYLUQLAd3cmDzOfGH0aClTS3Kc?=
 =?us-ascii?Q?O24cTU5YGI/8c/FxzaDteBMqK+3U6kcasrK90M3Z2iWBVZqAKaOcO3XvMzhx?=
 =?us-ascii?Q?x5xp9CzRa+yLaGYDwotBAI2SIWhmkUb+z1LkhSvAwrwDrRdpCC0jLkuCNnym?=
 =?us-ascii?Q?80Rv4NzWZ6jXMrUofX2dgBo8AaL1odOWsSpd8IXEmzIJJPWXXSHjA0YGUzTx?=
 =?us-ascii?Q?EHQ/SIRGQv75mCxgTsa2EwB5BA2MdtDu2Qg0JLcJsVGOc/Sox/9PZ9Vfr5tg?=
 =?us-ascii?Q?6gghn5Yzc9dSF6w+m9t/WI/pJBn/FvHHBmvvuWZsOUL5hn63QObjs8UjdUss?=
 =?us-ascii?Q?qiQczpRua48nbjtMhf9llODwvG0qLJ6rclj0hXO4MOL8wQ0jGzHwdMw5Xhx0?=
 =?us-ascii?Q?CIhYvuWUweJgb+q8DbT0CnGDKFYGICYDVT5QkJVjOMtNY/tVfWv92oFW83HG?=
 =?us-ascii?Q?cv+swEfr68xpIsvxBBGITPppY78Zc700eQvmRivcTnJaeMs/W893aiSB4RBl?=
 =?us-ascii?Q?8UvKbYvRxD1lLZcwI7e9Z2ts7QvHEj6L7oMmUOfvSisSbhvsUMm/GkYq5Iii?=
 =?us-ascii?Q?WCPeX6kRi2YBDMrzDcyhdiUwBgDsqBiTO/BSR4U1uSXyE1F1p55GEWuNGHHJ?=
 =?us-ascii?Q?f5RzFVvI/mrTt5JsbOTjd71ZFP66fmQYU0Bnseb16tBI34BFl+tpy/2k9qvw?=
 =?us-ascii?Q?zH6XWwmEzG0+oFbIPG5KSvoOA1/LBQQFyDmyEK/vADiNd3t+eGvyldkKTJWG?=
 =?us-ascii?Q?vnvAI0YqVA98u7x3Bb9p/A+3jfPLQTdswQ1e5+hr2Qfx0tbNXuQ9PGx0QxE5?=
 =?us-ascii?Q?f5qwU+YkyjoM8GhAPCqXP+jxd0HMv0pQ3cWO6jzkwzDotUd7z9Sk6FlrdaXs?=
 =?us-ascii?Q?wc2Kf5SYH+qRnuGjo3PRJTNISxJ5VrDu7l6oLBZ1uMe1fnncVvwDkD2A3gvf?=
 =?us-ascii?Q?L7/gjxJ2r4W8uni6qYdlXDxUIJYiT7cBoFnFkq4E1QxusTFPg7Za7FoG4Y8X?=
 =?us-ascii?Q?LGdneXEpxwEc4ouaFk8RT7gIerb8nZ6kUtjCOWyozluRYCMJ6yQwT5s7kVfA?=
 =?us-ascii?Q?vHqI8agPdLePdTR00FOfjJ4FvpwGcikYIoY68o4++WHZutsog90gZNazoUTf?=
 =?us-ascii?Q?SZRJ6FId/5cm3l0XlxhrHEnUll0VT70BoqdIbOInV/LvJV5uIVkNu/M20kvV?=
 =?us-ascii?Q?1+vbR4EXhTqgRrR3qRNKU2j/89PFVYHrxGA2iJvs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cvYVEs7tjzS35xfe/DZw8cHkDzrgI2S1V80xPsibPQ7XAU8SnWFiI2qo9/6Xn/kDO6Z2HuDa0viNaDkYFCMg9riB+QCyroNdn5QI1PuKK8undnWRiqqzd+bQwXX6PMs8lkwJiCi7KDkBrOE2ZrBNhjf5rbW786ckUe9nwCNPF3efECx20Qi9w7RKJcDZk4cDnf1jkGZTUIo+7enpMO4ldm6ys2uHQCTLwsn7n1x+iwumMaAmjDqcv5pb5TmCX//agvXvgZlsbEywDmrVlebPIy/EJf+NUrxDYL/ITIRUZTFbdf/ijhYslnR4dRnldfbA8m0bn02KD0s4MIN/MH3ZJooHL/0oCkAGHkfRdCDHe7Xt4fEqTdACddD5i4A51N9HjYKTHBUt/BWHacBnQIr7v1q98JmDH8jqSf/nfpOUPmPFXHD8O7//lgbZFLS08aBeC3XulkJBD/fn15L3qdi8uIPJBrRcjLsXtnpqrAjGdSXG848UaKpV+RcFBdKIJUatKBvj+FHd1HrQAcnvNpyPGnlcY/p9AE4ZCuN2oyAf6Z4xLAmUZUTuPIGkVu9P+8GQGTxtcexCn5cnmVV6KG1Cg3K/RtRy2KHbJ7eXILWDchs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b3148e-dd6a-4270-6c6b-08dd2a8f8694
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:10:08.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4+B+FQToWp0gbRFzzLA+X7gMU05iQEJOc+0CwqZUw8esvzfOrkq/8DwMsIMY35G4wU5HPAJd2Tlli8Yyd38zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: YtpEMqJ9Vp357rNq90YJE7_XRjs7Qmsc
X-Proofpoint-GUID: YtpEMqJ9Vp357rNq90YJE7_XRjs7Qmsc

Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
features, print its status during module load, like so:

   Btrfs loaded, experimental=on, debug=on, assert=on, zoned=yes, fsverity=yes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3381389ab93a..fb6a009c72ae 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2457,6 +2457,9 @@ static __cold void btrfs_interface_exit(void)
 static int __init btrfs_print_mod_info(void)
 {
 	static const char options[] = ""
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+			", experimental=on"
+#endif
 #ifdef CONFIG_BTRFS_DEBUG
 			", debug=on"
 #endif
-- 
2.47.0


