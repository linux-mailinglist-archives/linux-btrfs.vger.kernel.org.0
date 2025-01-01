Return-Path: <linux-btrfs+bounces-10663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1779FF4B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B679E188233E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AB1E2858;
	Wed,  1 Jan 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFUoVr4O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7wy1UBt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8191E231E
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735754997; cv=fail; b=AlYur089Gzm9So9Jux/a8l4E6t3PYK70yPC56/JYgZcngvQYJZf0WjNVSqYFuvdVFhkwb4ezCMD+GHMszhZUwZOpr8SCVPBtysnNZort//DFpbW4qeba+g2pNiQ3ME0gYmSWdmEavoW43fDVCMoGPKsMB/rZOSTDBLX8LF3jk3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735754997; c=relaxed/simple;
	bh=b7uPh5whV7MewalyZ7zR0knjGEdFLsevpwEqHQtFTPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMkyszVgDh2xVLgA+Hnms/KPo48eeYp/ZTl9jx5W+7QuUzq9KxRHCn/jRcln//0Z04vWgKa6xaeKNFW8MkAzIdFcTCeDTJu+JahlZRK5cbs93mNccMj6QzIetXBB7l0jmJiF7HJ80LDjMc1dWXgAxzF2knvlWVmOkpZrBIjX2PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFUoVr4O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O7wy1UBt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Fl7tQ027199;
	Wed, 1 Jan 2025 18:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=; b=
	DFUoVr4OSxDjhUeWV9gIxV040gc6TlWutyP29Kf/0KaIIhKNc9JhmSTzmAsa0kfk
	WfGb8F1CJiSq6FFEEMtJv17OHYKhxPozd/Mj8s1kHGkiUP7l0Run3YovDFCX+Zkk
	/SwuT0uYhu4BJ5kh/oxX3Ur1+cEnvDI/vaphrKTjMgJ7A4oyVG4w2BVRDIgD4W2r
	RV1HTrBB2FyKmFBvfP7uXUqrJjZIEFIJRN1Sr1a2+E8e4lab4guoh2YCt3D/SYa7
	1Bvo4JuqnEIKTUOIhUkqLm3la9JXixn4PNOdDWIteu9/YZu+uUTY5AnyOoJmjgFj
	W1enk/fMZEdp0a6MCFrevA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9chcgfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501E07h9009126;
	Wed, 1 Jan 2025 18:09:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s861d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw60TlJGsJjiG0LLUuokGD1H3jpqIz44U3G+QexemKvNUW51eK/SisufB6D+GTKgAAO0qx3u8Bvc/GbV7k0YqbibePWbO6FAEpyxk1v1PzwNtuBxST9WrxqYGHi7C1KQhxeK3XRQrs7vLQ9oxfHfizqZf2u+Qynn1OvWb+YciHvMm4l5qhR6ulK9zPZd2a2Cn+dhEc6j7CnuJrm+GgDKl4SI0kSas4TW4HGPAtkYVCknYLajnijTrR0wCC8cIJbgagJgiHqB5UO4aSQwRXnmb0VP+nQvr+BUSn+yWBzKWRZSTuo+Xg/AXK/MnUTHRVO+toaJbfDEzVA3UJTmr3ysZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=;
 b=eej7jmWcCV+qpHH8xPn5K2C5MDwyJxIoLuzyLmyneQzz5ldsoYEJw31Jgxv6TQRMM3DTLTrwj8iED8xdqoeW8MQGPxIhO2Cd15MQgZuQQ6N2gBPL04iUJxjBgjjFcXgqMNxZwEuA/5sa5PWPeCs2wB/2UnhXK6rX5zgO7yP8gW1eBSZL2Gb3pLKa2HXGV5XK3/ycKLeuttrDKoYMuK2q4fqryw+drwwLGmeDtQ5if5xTB2Ob84E1D49DHiGkliMaliU0ALxYtgEZBGHs+ZHSjOw/7zc3Rq9hfZoKHCqFUrkosoSHTxWBHxT4pJSXEjtKQ6A6iyIhPu/OzNWOX01IsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z65in74P5MF2tELa/EF17Ce6XG3Wx7bzC8YUMcexup0=;
 b=O7wy1UBt0HgnBQ75fZmcTePqww7AIogc3MJqyQwEOJIL7Uu44GxxCz0SXIYtf5dTWwaSt/i6tSVnH5YeZAqTa+7KL+5t0ZhhI2V/yheHUknUs/mdS4GhhCv9OObnHGXQerL8y96aiVeL/kvUAc6N2Xa3ezwf5yzcmY12Kc2eUtw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:38 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 02/10] btrfs: simplify output formatting in btrfs_read_policy_show
Date: Thu,  2 Jan 2025 02:06:31 +0800
Message-ID: <eb75e74fb2dc424e47c68f8d31be8def23db1a33.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: b151a24a-bd35-448c-ee96-08dd2a8f74cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4XjATll171s2cne7XQaHkoNuUNK/+s1dz+qxDoxvDgwcg7GoIy5i10Hj1+aA?=
 =?us-ascii?Q?dMI7jCHwCqL/LsJgWhDAiiPTyRodC1PyzvToGkdTQol5ARFUe25PEFfKEov6?=
 =?us-ascii?Q?3UpT6pyu9DKdO6xhTnlQ72xe03vd7qb+vY3Zz2AnTpgc2ZNSRjkT5AzjB67F?=
 =?us-ascii?Q?zUsGVlG8kI6Eg4qK61IwV+6AXFAD4/PuTmSKsPd78g0XkpBkz6WUbAZ2/G1u?=
 =?us-ascii?Q?qxRTMP5o/wEA1j59zCLWJGIGUUch7Bu47iK/DnM4z2BISh42z8rFt7/qi6yG?=
 =?us-ascii?Q?uTk7JLhew5rkXKqQKfTPxAhc0qhGWd71DzGx99vvtohtcIn1a50ivQRbC1Vi?=
 =?us-ascii?Q?G8dX4QZXZ//YgKcs0nd5zHo5ppz4stqo+dSn+gQWETgpdU5QWxH8W3cbiesD?=
 =?us-ascii?Q?0elemD3unBrItPLdw7ec6SfNayQ2+INq+7e8M1khwHV/MtWfOn610gVXjSCJ?=
 =?us-ascii?Q?8b3absNRBE5/KZHhxVo0npyxlkj8y8dy4MNWT9NXClhjeJifUgsgYvAbX2qT?=
 =?us-ascii?Q?98Ca9pd4rpnhTRcZGxmpaNwjAWVJL2KfZU0SGjqQhtUC0iGhagGsOi4zs+gn?=
 =?us-ascii?Q?HWzAsIMP7iAf/TEwBigjiW8u7XNIXBUBncI4WUxP1RXuqRSeHQhyCxLvrTgt?=
 =?us-ascii?Q?/Br1uEeVl/OnKV5YiRfS7Mk0/ZECjmE01v0YBYbBXbH1cm6Etk+9t1VLVaKv?=
 =?us-ascii?Q?fLVEOKguyL/dlqdFvfQuA/BnmmxvqX8thl62Yi/sw5TfVVLxKOQaf8fSPrTV?=
 =?us-ascii?Q?rptOyiVpRdW8ShmGl8S8wUsFZPcWkzdNu2qveqGsNu1GrK6X/soHnUOZeztI?=
 =?us-ascii?Q?4pjb41nvqOzj/hpgpA34Magtrd4fpWfy1zG7hFCPiHlhaaoo4z/5dkjm7HCa?=
 =?us-ascii?Q?GkH8HXOKnR8nl3EhtLXnKZpPTw/7bnLXWCe4si+K+0mlCrwdVRUaZ0a5tnUY?=
 =?us-ascii?Q?cy+/n1dhNu5z9sVodNenfrJblz36MOh5NPWykpR/pshLSIHTcApIelqqQPlC?=
 =?us-ascii?Q?G70vEm50+rW+mY+RnqaU9xCY72fftsvZSxwsxzzxyzSW9D9SmFcTLCkcE1xN?=
 =?us-ascii?Q?GEKQZZeb38AQQRhRM+4xhO0CS7MpDuvje8Afb2ccydrNJejqIwnh3CIHTqIv?=
 =?us-ascii?Q?v8YQH9020IbiKwVdBYbK2WLjFc3u9zeCf75miyOwt4RKGGVR6MDjs3d2KFB7?=
 =?us-ascii?Q?Ne6ze/fK+xP1U68Gsg3kH2Ob9OpGJU0FuxaL85WPsJXP18tKnZO++m+poqbx?=
 =?us-ascii?Q?Ye72TXGfyLlUhpqznthL7bDJ0MfJ+jHBN7q6Eez9gYmbzjtV6Tp7hydIeP8M?=
 =?us-ascii?Q?fhgi4rhxPiaEhULgSnZN/jpA6JXNrSuZ8ENp5J89u+ZkiBZt8CZ6/y1/o8De?=
 =?us-ascii?Q?Arye9+RsWrp0qbdvYJjnpR1gbBRN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9L34PoGMX1V6pyURGxym7/asktsiiTQil0sJv4c2KibUChMbBGXSS1DopEk?=
 =?us-ascii?Q?CvgMLUU4j+tQzqYpaMpl/ExchoXoh585hxhpjYrj7xwjatfZuuHbMMz96rcc?=
 =?us-ascii?Q?9o0jJiR04G8c6+UOhrDClPoX9ScPvYqafiwTiU150uCAyb8+uADcAKlFhss9?=
 =?us-ascii?Q?FfpjuTQjMZBx9KgPCd9nZDZNUoRTUdQXxgxFd5LAQCfeRNQi4XMAxgw3r/Kb?=
 =?us-ascii?Q?ENQsqqD/YprlwXwNNlPrn9H3GAlTfsgTxnIaSlEt5WNon9VW8ekKYoNCgY0o?=
 =?us-ascii?Q?SwHnH5gefHmtOeLKUHFcXuG9qmRkbwWgNkWViqaEd/E25NHcFQ8HPYUbesVO?=
 =?us-ascii?Q?sEbE4u2bwNMpCtC1Oq9KPzxk+iiY0tJ/fxVBrWeG8RsvddtwCs6onAkLAU2V?=
 =?us-ascii?Q?i46bQ8ADap40VU1tAczkapEzePPhSi+KqPmqvHjn6N89keJ/gtpSqtGgONyl?=
 =?us-ascii?Q?A5rHsKdG5qTWH/TFx58DLgmMkdbFGVYkl9jGyrs/Q7WGtIiGY3nj8nNPTXMC?=
 =?us-ascii?Q?SSUdu6nuJlxEMOTpu3XfOV+3DrSfp6RMbU31Nrf7338QRug4Boz97FLBDN74?=
 =?us-ascii?Q?mzkNwWDcwDDP+s3LZlOqEd1vzJR9As7JHY4JEb5i5E69b/qrb1/6PizHmFjK?=
 =?us-ascii?Q?SewmqCZJJBQhXZpVRX1hps3025DjJ+paOf0YilIQb63et8FAmmOXGkLT8tv3?=
 =?us-ascii?Q?Rwc326rbqL+3JNpN3H6JJrYoCnvEZSFjSjbtuZzUMsKS6uLPrbtP7AU7Wq4r?=
 =?us-ascii?Q?8H13qc86Y9uX9Bn7BFVyVHOgAfk1oz50oknaOQL6peEM+EsVevr15Vi9FDRV?=
 =?us-ascii?Q?hqXlXvN2hLnrhkoVwkn2Qw5pnKfAoXXM6gvwJdQpjpv54w/SP3uY58662SSZ?=
 =?us-ascii?Q?/uOZxnChWg/XoW2t629nBEleQxwFaOYCqJGruyAao2kQViR3JLt9HGo+KAMx?=
 =?us-ascii?Q?VG6wAzIN3Sv6w2MtUujgGhwOdBtskC+zhicJPkYbzoL/QIIi9VZiFBLmVbro?=
 =?us-ascii?Q?YsUZr5s8VgoubAgnGNcHkPMw27O/6c/uc81QzWLReNR1fO743so72L2mwSTQ?=
 =?us-ascii?Q?TDtFDu5HXxS0WeB6Zs8CvdVa+WQ0fo6kVaxGdkSzz8NvDGKzafUPr3Us9x05?=
 =?us-ascii?Q?e3TTqvBMajmuda1lFJmv2MthwlScNRD2HgyIr8NM888gndlU6G7/hH+usdVl?=
 =?us-ascii?Q?JiClWDGSFyBqYz135rQa6bXXLbyn2ugkk0t4vioRyOhbeMXN5pP5Gz7QCzOS?=
 =?us-ascii?Q?y1mrRMScvphDhiYprTtlifwm8vMXi4xkKVfgDJOLqjlfp0tBPB9QC5vE4yfQ?=
 =?us-ascii?Q?B5hOrbVoHqI2qnIVZi5LVpif+57LXOK0dY3Xadwd//4N2+KaLe7/7T0MOhIB?=
 =?us-ascii?Q?71KgXYKObyRm2BG/ENOt111lIL/Pje2HaPaoEjCxJdkprEt28l6yJCOkWUoN?=
 =?us-ascii?Q?XSXsft2VvxhV1tr/CC6zv3PfjMVgMBgRh1sGAPwLbF1v10t0nMIJkEoLYT8f?=
 =?us-ascii?Q?dncZpx8x+N2pXrfpmQDokLJeMQUerw76gfWbLnseOw9A3uWGIWmC2JZuN3dG?=
 =?us-ascii?Q?uruIkdg2HoORzvBCQSL/lMDkpnRo6bq9kOq5Z+ZT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OA9Nkb6cH7e+JA23lJ8dGbx5BM0DvjSVTGV44aECtgXvsTLjLB1m64CCK0FgruvwFONrwalRG0BzAKkXkN1ohm35AMj/NcRXaaRpiQv2QjBjnHDYcQdFCmbIvaY5uZMgzINVBjuw8OHZg42GXY52tafvhzluDku99hC5aUtUkZKpicrX2mIzmtQ4J0sROiZj1XlP3a7QxsBkWW8dEnbad/LIFSvR5mAy16t7yGX1pCMFli+kcIG11WrX7gm1fYHzaPrMlPSMrh/XTRtgcYjZu2rkq8MVrxRkN0zRSQfm0+bogllTeLGOhDQuzabYxxRG0RqXx0ratYoeYo54dqzz8L1NqcVbN3nBaDuXFc6oShaZp9LSdpFh2u5zt05Oe59+lhvF5feUkCC9H7+fveL6HiZtaalPyCI3cemw4ZZJ71rNS19vpzq0S+1ZhmgdX6RLOCduauKXXhhpUskJBK0IJvRhzFVjWlnPjdqjy3+eNEr3zsqztbjtJKHo0V2k0riXg9lNZriia96d7gKkIuNLTMr3BuSol4Q53KfeZVYsGx/S3Q+z+Q1mpvNwXRRydARhGv3/fyYPIibgdIvskeCPv2/D6qZBTtK1XPef/9USpsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b151a24a-bd35-448c-ee96-08dd2a8f74cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:38.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phRftiFjGM6I6aveq7bNyR7gIHAA30IGz1v1SB/XZbp70c5amkfqV2g3ovMQ5Kv7TJOro9Rd/IIHK2/nl4cpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-GUID: 5mAZQspqRf9okQB0EeshbFEAHuf2nz4q
X-Proofpoint-ORIG-GUID: 5mAZQspqRf9okQB0EeshbFEAHuf2nz4q

Refactor the logic in btrfs_read_policy_show() to streamline the
formatting of read policies output. Streamline the space and bracket
handling around the active policy without altering the functional output.
This is in preparation to add more methods.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b843308e2bc6..fd3c49c6c3c5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1316,14 +1316,16 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (policy == i)
-			ret += sysfs_emit_at(buf, ret, "%s[%s]",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
-		else
-			ret += sysfs_emit_at(buf, ret, "%s%s",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
+		if (ret != 0)
+			ret += sysfs_emit_at(buf, ret, " ");
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "[");
+
+		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "]");
 	}
 
 	ret += sysfs_emit_at(buf, ret, "\n");
-- 
2.47.0


