Return-Path: <linux-btrfs+bounces-11924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D9A49132
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3833A7376
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746E1C2432;
	Fri, 28 Feb 2025 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJjhSN0f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zER1YMn4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC810E5;
	Fri, 28 Feb 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722145; cv=fail; b=X18W/cqVbPjArEfET/3D8gpetKul7A6iZA41SG4QgUw0HxtgRJ0t2BMf0Buya6hhmPHfyCZH6CNfjaRgm2FuGYzkiyg5aMNM8oAv1ShC8c48N4EbaPyqP38zoxcycZlAfGSuogn3KBGzO+JwJa9GYp/gZeuXevRt7otpvfH+dzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722145; c=relaxed/simple;
	bh=edWBQo2jY2XvqcZM/6TFm+PwUVpaGnXfTkaTJpEW9F0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=byHMJiDjoznq7l/CW7Yleic2A8v94/7PDEZFP2pT5SzoROLCvf84NLfjgH0TGBHIlSCQwxtIOzSLquvGnwuC3vfGjjz4SHLDkcL9l5FM5N/zOQErzv+VqhjK9ixTwdFjv00uVpDQm0Y4fw0nsjpnyVA4iUA7D7wBFVapOfHv1o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJjhSN0f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zER1YMn4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1Bk1N032629;
	Fri, 28 Feb 2025 05:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=LBsi9W8XVrRUHwqN
	ebHRkH3CWw0fardPARcM6b/ZdQg=; b=AJjhSN0fFfAnJ53QawaN0yG8yzPpBZ8M
	1fbzBUqXRzXlheVr51ND0baLirS1tPspZioFyepydPYreZfowZI90aQ13szMIFbg
	6nze2g62VVFY8O+NwUimhc3owp/DIdYqEdIG2FmG/H+Zt24rDkTVsrZY7drvbcHZ
	n+2RrPhrT/GokVaFgERFFLOouSJim+dG8W07CIrpzYvqtWLUMrjZxXYxF3MVUpDY
	XDCkQTcoQiys3EyaxlOJhHFHcnSVMtfBrPfHyklZuKMI4zTEcTdrBYJnm1mOKciu
	GKT4zjN9E3cEUVEFcKIvfPFGQdJnF2YsN6FWsf7orgEdlocm/EeHzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4x7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S3GdE6012594;
	Fri, 28 Feb 2025 05:55:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51eech6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ6B8i1lCNN2AjAo4uhszbjcvrK5rtCorQkZO4YryxOADsekhtOeNRgaLWg9wc+XWj7l30xc8mEoGqubAA8gPVZhY/iPb4XSizGRyFR/wJIsE2edu2chcFGo3YcwUO3HBVE1uWtdmqPglnuZ/zrbWMNhT00lf34Vc3ZA2SvDS6DdVxe0zRh5mfk1KShpNHfKZuLfpGfn5IMhS5mCoj63XzBDXVgejiFVXS10zz634oX1x/0J7r7Vf017rWS9wxZlj59TMwlBPOm+DbSw+QlT7oWr+l2/k4AS21SKYnW4yDQepXmunNT0Y/gWhJ/DlD9iGWydLZ75s/BdeaiTlcv0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBsi9W8XVrRUHwqNebHRkH3CWw0fardPARcM6b/ZdQg=;
 b=Rqptnsx3tR1hvmR6fI+sewV15PAC64FkDPQaawHLFjL8/dCcZMrVGc3bdCsgAZRUYcUgU5MCXoUbCDozPl0k/rJDgpEBKVYJEajHFhLnZOazinNW5Dm4R8sHZaIduZy+5xUhwSueZSLZWRDUo9pnSKIsQvqVg+hBPFCgGxslqbPjoQ1WxcmHyZLJtiy5q6bIOAi/sBB1cpCZQzT3cHjWF0qMA9HnmClmqQxfM0q6vyV5ENYs7/HrU9ag4CFj11+RaRnKpKCJuyUkolLf+5PXVTtQ/CbUV09aEmb6za6OteVPhhrTog+lRn6ehln0R6eWVxwBKIVO001cww7lLaVCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBsi9W8XVrRUHwqNebHRkH3CWw0fardPARcM6b/ZdQg=;
 b=zER1YMn4T3H8Mgu4PXcjflzd4HgUrsReC2PVRwMGtnfKl72ztBJLj+GJuG9snNMvFHTBlFjaY3YBOnUYgmtwR3wbBMMA0YhHhs6i2bcArgpefFb/KvDTmX1yL+D5N++CNhdCgUKtjKvX/dlxcLJw9uS00wfI/CurqTssNdvRqco=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 0/5] fstests: btrfs: add test case to validate sysfs input arguments
Date: Fri, 28 Feb 2025 13:55:18 +0800
Message-ID: <cover.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: cabf57a2-0900-499d-e55c-08dd57bc8621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zKPTMTJnYgfePK93KorZqBkoIhR7yUiq/+W6W66vCjhPDWeBZWhyp3vrfUK?=
 =?us-ascii?Q?M2AhELAVv6ofxUcMUGITylHPt5i/2LSLpBtJQBbIWBlNHAU1N/jMG6zW5MuL?=
 =?us-ascii?Q?FBDj9oNJeo2aTFD6rxlo2oHe3HUr3OPwHCBCHEyWh7Y9SoNZwOushU5AYAPQ?=
 =?us-ascii?Q?LHm7TPpC9bwR6rDGd2FZW6kFWU/shCYOUJDOiFZxgYOcvqnUJLSo8x+9HSK2?=
 =?us-ascii?Q?4g2OgzWiosK2VrxysW6flcYPeS6etBM0pLxAzubXSENF27w9zeiwjmOutnFJ?=
 =?us-ascii?Q?/XN7uFf+0ycRW2mXkHULgp37VMU4MGQhTIJA4iFbxaktz06sVp2p5wjClK4V?=
 =?us-ascii?Q?xlsWTi5HjCBcAqd+Ec0mcvqSCDSv3kA+ldFCEOiG3ogqfPPUn/xRPzwUVEop?=
 =?us-ascii?Q?XekZVixZgz4jCalU2ViLnPqYFwujhq7WG9nefMcgLkY0645rEveiOJfudlIw?=
 =?us-ascii?Q?hMxBttVNdVX+SVCHSMWZAR8EgQFYESIkcU1bhZ6fQFThy3+EDv1T0sy4Vtkr?=
 =?us-ascii?Q?od4ZxBEche1wk+wOJa3WrpFyTRPxQ5Sdr0rtbcpEyUpuXGko1SdpKV//stxX?=
 =?us-ascii?Q?OW/CtVVpE4ogVyDV+/nvNYE99gkx7R+MZIkAn6HoB8ASPWcDXHdMUhCEEtBD?=
 =?us-ascii?Q?PF2sIhpEIhvhDIke5akNXvMINt5W8YBsr5qPAmfUJxEfxauDbcGPWquO2uRD?=
 =?us-ascii?Q?XvSV36g1x2eJXdQX1SLkzCFJlM/mwslfK6osbtr2aH8P/+WaKr46whaRIWiT?=
 =?us-ascii?Q?7/Pt6MFZLtspzXaZ8bDU1mmiVc3WWYuRMB25Nvh8SdFN8G2ezHdX0bh8k9Kp?=
 =?us-ascii?Q?OJpAEuvAW2m/e+cMSOXbnNUfRlhjDnG9ed2BrQOhP9jhRb9b+3YPWWO0QSqa?=
 =?us-ascii?Q?htY2njtnZBHGhyWjmG/PXanWUYoO6phw7Bx6EEGINoywkriEeHP5UnBJDrTY?=
 =?us-ascii?Q?CzwsIvGydFEWk8pHe89LuUrZahjil6gn6w22RKKstx8GRNVC2H3h1dLoi+zv?=
 =?us-ascii?Q?VfoO+jI749gcaM7/6RMAfozHfTb/hY8kx5SfPqgT+6EXrjvzR1cRl8+G1lF+?=
 =?us-ascii?Q?ZDpYO1GPl8qYKASc1bt3otpKaiT+48Xdu9sGG3BBlI+5wUg0et0haMITdNOJ?=
 =?us-ascii?Q?l3gcQU43sp5T0CRp8ChCjQLzezoKL8un281qTAciWcDibQA7DbjMZC7NDq0C?=
 =?us-ascii?Q?UqmQGYouUuailFVdQ99Z1He1gGIWirOPPO+X9arBYENcCDf5ynR8P8QnV4SM?=
 =?us-ascii?Q?g/h2fOJfFVI/3qs2U7pWc7nbezKm/3mgkF4z2rS2m+UbykGnLZRdJ34MCdqh?=
 =?us-ascii?Q?TUokVC3p+lzd/+w5W4qvfOaJjULGkUxMo9kEHRSshwPWIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uv7YLBdaTVPFtrQGYv1IuPcHJSgN8VMRPvh8D30jDWp7JRGt446bgcdKM0fe?=
 =?us-ascii?Q?nZCjac3BLugPAtm0prgg1eVRwFf9lNWE5UhruHTBsOyDhwM7UHbIwwKNw1ru?=
 =?us-ascii?Q?hTUBCy/tYjAzMF4nNjzZxHzaCVaknJvj62gPRw+n3v43IT4394gaDfaXUZS+?=
 =?us-ascii?Q?nz2GYX02OKgZu+mYt87BKHP3bPan3HIwmIhU43jEv22SyQP4yl3eh/tvggFC?=
 =?us-ascii?Q?agThMVVgeafHOq7viu4/E1QA7eBp5onBoLW+ICKtp6ja8hK2RxC3Bw+DaJKK?=
 =?us-ascii?Q?2LQvkMYaU/Crt1sYpuhFH9Z8mMvT9ANgQ8Jbjc6OkbplLaGUBt5F2vHZQwPH?=
 =?us-ascii?Q?LhCFYvGltG4AFWo8bOreodLKfkNr3quRnkbqSIjCgAOXqJpQayGhUhLc3RmM?=
 =?us-ascii?Q?S8mtWuvBottyh348vCID6sn77h0DNrnnFki4bpQ5zB6r/YSrtCp0dWGQiqp0?=
 =?us-ascii?Q?38MWwP3WNJD3NF9c4rpkOmC/YgJ/9UsDgaS54xzX9eytar78pN/GiSc7lt+q?=
 =?us-ascii?Q?v/BVu19aibfURjxB9amakSkmIg0L0mGR30sxza4Ez+UK4Lnf0jw8ihcTUKbB?=
 =?us-ascii?Q?WOO76FI+e+sxtLhIPm2CLMAObnkBFwzriK1IXw/T311uNFh+mOnJdBXoD4Uo?=
 =?us-ascii?Q?RnjZXwi+Hc47rjkRH+0Wq45+efUWLZlLrnTPRWzN81P4o5daEYpdnel1uWJx?=
 =?us-ascii?Q?svY5ORAj3nV2RWgqLSK7CFKxXvbmi1qvFJsG4pWmC68ileordL/fKD5sUB2l?=
 =?us-ascii?Q?OZskxx5JLN7EmN20+Q/DuQVSCIq7ZczrMa1v22lGTsVpDN56EG1Uu17umU+S?=
 =?us-ascii?Q?ShjvyF0m2/mcOd4Ek2hN6XkD2uTJmnYXe+kK/I7T+Zc0Dmc/5M94YmrX+AGM?=
 =?us-ascii?Q?QZray6302qCszOzGto+XMnEIeXK/vHYuAPkqAdNIKlsH9/y7CIWY0Zz0/vLL?=
 =?us-ascii?Q?w9sTpq4yyX0j0x/J7GlyUKt02aLZo/DcOAc+5z2TiIxPSZlkIoJXp2RFmBLC?=
 =?us-ascii?Q?kWMsob+zI5AW+g3NdCZ20WMWaCPAqtaj4I327qxp9ilxvlc1gG8zmAJBxluL?=
 =?us-ascii?Q?ojFUyB442zrKp0GyarkSGSq1a6bHJDNQh696Kd64MBS3t9VgvKFru8UrR2hV?=
 =?us-ascii?Q?D6m2tBBkfGJDUzD9baU6JDIJbQ2v7iTMZUbUnV401zvsl7MZjmP1c1DH2urX?=
 =?us-ascii?Q?sbNEPS7jLkRh1GEtDEJTh798jn0zhyJxVrQPRq3JSzGx3YQH5CNC55eL2h8j?=
 =?us-ascii?Q?SvDLZKi/nEEiASsxadbqqaKP22tyhttLuKMLati8znvQfaugjLoshZogOXcr?=
 =?us-ascii?Q?H5NZjCXLGhvh5d+T3JalseYg97TiD5AOmf4ukCK3EtynbYyfwi93Gnia/aLd?=
 =?us-ascii?Q?Jjsh5FvnotYdtT+pvK75FJ8YNu3BwMVT4NGOoKqGMuLYL3MrvGxcvKy3jt4S?=
 =?us-ascii?Q?PmYhCUc3C65L72hvulrtiYyZzEA0JenIrdFpfBXtespkFbNVzlV6E989OPWy?=
 =?us-ascii?Q?b3MJMFsTMneST0QdDmj+X91xResp2s2LaFUXO1guu5LL0HVTRDxdQagQg6x5?=
 =?us-ascii?Q?CXh5fitkgiSO9J0jVzATIav75ZXLP+SNho4TCGh6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rKb7BD/qsibij6aTooYmHAcKuFfjVPgg4COyFu3IpERbMHMxQ7Ssa6vqHCBxyxSo8VIBdHaLwM3CDGxH5wYjXiHeDRGyGB2MCLf7Dxd8Xu7SOZj4viS4kE++5hq5Y9GxSf8HPsAnc408fSfOdX2F7cBB1BMYbxajMaeM7VtltjIgy+llXWXEiebxpURnjC6Mdeh2oqqRHZuw75CwV4K35BzT9HtDt780tWxdIS5eaGcLzSY3IVwZhl3jNRbIhRme1T1gOQ7A8/8XT0BBzp4dsWxoN3hGgURv3WTCHCqI6MsPBlDpdi7dKCeUwRCXRnPMI2TdCHbAa2KitC+KGjpFQZ6yZJvqGdxjt7VelbkYkKv5lkpVGyMQdXjKMY/dK637IUW4f+LAdcjsfn1Z366cuzPeWSTQLQ1U79qJuYC0W3L5dFyDJvOpoyYKyUsCzR7PgPX+zIP1ERmcSf/t7fqskKDLw/wy5EFTN39UtNyN9uZwYB60a8XNoeXKp8F8fu8RmhH9bLFh3/1ZuV2dD0qoGpir3iAs8pLrk4EuI/x0nAPaRxenE9nzKQqkhBzIAynuH2OUWGfuJ7P0dzS2D0L98aMv5U7AwUokaGkrJa/XhBw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabf57a2-0900-499d-e55c-08dd57bc8621
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:37.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxHUB0tToQA1cnw/T3w/ULnRLbHfxFv88QrSaq/wsAmaw7k4oadjaZjO8td37gisbFHY8EdCwPi0GCYigJmy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280040
X-Proofpoint-ORIG-GUID: jyq4jZrxUxvENjeB67mDcUnO2SM-UPSg
X-Proofpoint-GUID: jyq4jZrxUxvENjeB67mDcUnO2SM-UPSg

v4:
Fixed the double quotes in 1/5.
(Thanks for the review! If no other comments, I'll push this set on the
weekend.)

v3:
https://lore.kernel.org/fstests/b297a34f-4c09-48bb-86a3-fea50c364ba8@oracle.com/

v2:
https://lore.kernel.org/fstests/cover.1738752716.git.anand.jain@oracle.com/

v1:
https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/

Anand Jain (5):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: filter: helper for sysfs error filtering
  fstests: common/rc: add sysfs argument verification helpers
  fstests: btrfs: testcase for sysfs policy syntax verification
  fstests: btrfs: testcase for sysfs chunk_size attribute validation

 common/filter       |   9 +++
 common/rc           |   3 +-
 common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329     |  19 ++++++
 tests/btrfs/329.out |  19 ++++++
 tests/btrfs/334     |  19 ++++++
 tests/btrfs/334.out |  14 +++++
 7 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

-- 
2.47.0


