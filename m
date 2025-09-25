Return-Path: <linux-btrfs+bounces-17172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C9B9DD7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148443A452D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F92E8B76;
	Thu, 25 Sep 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDagiZYo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882322BB13
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785061; cv=fail; b=E1pWSMTrBwUcTgkEwjZkBdNSxGMp2+UhJR8PZo1nDr/54/cD/8XfQ8tII8gzulxoynnI0a8V2HUh2EDB/SQwfnPeppUHRvPatvRxj+VCzC+TSMBufW+c+dV3NXXqSsXhM/tc4JbTm2f+s5uOVJd8jFZvhyuplZfQakwjOF/Ch6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785061; c=relaxed/simple;
	bh=ABjrk4Za7cO98FYmnDxA5O0UmJX8TBzReoper7AYwP0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iTfQH6NWkPUMVxG5L8zstUT3kOnDw1woXENj3a3xRsS6QWo9Wx3bv6JFDvinlEaZy6fCsWt21S2upcwWZxVTSMKeYKXl5EY7up2XwA/77tAImeeuE0kh0jfX/PkVg4F+hL4n2/4O0PYO5Vsz7oRP3bA6XZ1k6Gk+D6TpH0Lkk/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDagiZYo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758785059; x=1790321059;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ABjrk4Za7cO98FYmnDxA5O0UmJX8TBzReoper7AYwP0=;
  b=WDagiZYo5qGVLSv+wVerxcWM4zOaUdgA90abWd7WUkB79QDQsWsq5KKB
   +OZ+0n0WeJFI7MUacFBPgJi62wB/CGRCK46nC9a9BDTKEoHkhY1IHEf1K
   +cBhfTH4AY8UeN/TnX8YiLveD6NOvab5gJ9nAHnlYpwmJap80CoFc1qlJ
   Xe8sPd5RlwfeMIxRG/YBa1ccEs21j+4rQq267C0BVeTbIAW+0azM4W0U9
   MOOwhB3oS9FQqCyNwD+dsNO3fsCqkzCEKB25/7p2YkGB2+MtnzbJ3STib
   wHShaBQrTcvgtoDDYFSUrtiObm2fuzFGNvq8GoEF8xK3Z71IFrjkROgS2
   w==;
X-CSE-ConnectionGUID: z9BUxNwdQFOstN5+ykr1Aw==
X-CSE-MsgGUID: 3wjmd8JpRxK4puZ/mPqAxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61262543"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61262543"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 00:24:18 -0700
X-CSE-ConnectionGUID: aqSo9q2NQx6z47ig7l7Wjg==
X-CSE-MsgGUID: 06DtfD6aRT275s9fIL+Deg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="208001136"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 00:24:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:24:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 00:24:16 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNnCQKzTp35x/apILdG9TrcYdsy5+HMEywxET2s9W6dxi7mPKArs19ugk24H3BM6DLt/pDhwQvnZoLYsbUm9QjodbNNpvuJuTqnsLD6bbMLuSS9XW7FZNA++yfd1dmPUD61oK3P+WZ9sLKN1nTYzqdF0kR7UPoMaMA+bBZT0BtEnNE/v90kgZLY2+tfWnmGtAnVVfefyiiKZ58llwzRPgyUXeoSn9dsdJ8pIluGvW8zHfgyjwo4l5EZSYXAkxOqfHHTcVEEY8E/xLlrCP3GXRyafqa7+kWALfvtdVY2ulXwukGX9ofquu/LdezmiDU3CofrhuD9KuXXeR7Pt5V245g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXPOChZ1f9Dng+TUR9Ksg3ZZ5/xnBJDrhjE4yAaMnwM=;
 b=Cnwy7mRgD/OY3fmNS2PT7xmi8Rwi+knhNdKKjjUcy/ciXEBwH4IPu126k5DZun/Yq0FqRQWoLOeZ7Ik775X08CFMjFU67zgZvRkzQAiyozmm5mbDmrCn0jdRnuOcLwAgX4KZep8jTAss91p4xfgy3orKmISj+oe5PYNWrrFlECiKe5wj0VzNYPxS6s6t1iIOBWYIJuy20cEcbe1ekZR9ZYPsh/E01TcnrcukBOIfFyEQi8v0LUh5lNIia9y2AuctaKn7mwDBFiDYn/2bim3IN5TwqWQ5nU2p2Xpj1d3b8nfw+33e1Xfy5et9i+EOnizZ8YcxZTo7xjmHSm9QrJmd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 07:24:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 07:24:14 +0000
Date: Thu, 25 Sep 2025 15:24:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Boris Burkov <boris@bur.io>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, "Michal
 Hocko" <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Qu Wenruo
	<wqu@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	<linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [akpm-mm:mm-stable] [btrfs]  b55102826d:  filebench.sum_operations/s
 12.4% regression
Message-ID: <202509251432.59b331b7-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3d6027-5504-492c-41b0-08ddfc0487ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FeZlZm0zv106WWabBQNMpRafAJKp6zkfol5LdCBllwaKvhCwXhm9c4ZTmx?=
 =?iso-8859-1?Q?jgAa84RcuinFSE/bsi6KZ7JgqdUgrIvjrQMAQUipui2TH0lZRuZtMLqtBu?=
 =?iso-8859-1?Q?xMbwR+BBx68DxbKtWls5rK/rpB4Vnavr/D+XBLO1Y1yJYv9U3e6DisAUEf?=
 =?iso-8859-1?Q?n20ag8PQlqALWEh8M+9+f8RZatEBhaybMkbJQYgRRZ+wteJ+bp1dsToir+?=
 =?iso-8859-1?Q?WvhsiqBrEsfeUiykXml8qzHUErVGVsZifLBEwTJ4rGrkzS73k/YhoZrsA6?=
 =?iso-8859-1?Q?tG9D1alVjh/KsxKfXl+HNmVLafJrnnclZPvrHOzPqOw/IdbCARGUigPEqO?=
 =?iso-8859-1?Q?DtA932rXPu8sqfzhKbDcv1BkQ1+Wdr/KLhHokoVYPx08OqrCygGrrz1Z6V?=
 =?iso-8859-1?Q?Zd1wrfpdNihQ8e07mFc5a6zoTPlMvZhnXChs8cbI9wS06sh05pyFQNt8Al?=
 =?iso-8859-1?Q?3k8wRHriSaDcYHIOxvhZhWDMb/Of/u0f0zJctyKUJq30dn5njcPUThXwJv?=
 =?iso-8859-1?Q?AeWNsNgkKmFGUi6sYt+6BtSpfwPdgk+FRxjJ4LjGG4J+upjcOKw3n88aYX?=
 =?iso-8859-1?Q?/JFNrc/omOxIeoNEZt7UhniBr1Hi+uod0QXPJgh47M/sB9Z9GKfS7Ap9J5?=
 =?iso-8859-1?Q?zPV6v/fVYF+yRU8GbpB4Ph3XqvMqESKuQQJzqiCJZV9H79uXLMddnIbdTP?=
 =?iso-8859-1?Q?H7XXU/B2PwOhFvORXJYNxIi76c9IXnCkym4lxA1MIjrlS+z8DSuf24Z7rP?=
 =?iso-8859-1?Q?D+fHTWz+/9me34BaO5H2tk3GHN64s5kZTMZvoEkKErUtBxQeTgetN/Yvd3?=
 =?iso-8859-1?Q?eim/Zs6RSI4dW4XVKlf6IVeR4z797eMbvKxSNpaCzbhvrPu4e1m6Y1PEmX?=
 =?iso-8859-1?Q?k7A3+0S0tOwwcoGCIfeKYk/c9VRFZHsberESeO9bsmeHbqwo6wlxGVxEkX?=
 =?iso-8859-1?Q?UEI9D2ILoJNF7hMmH2xE5Niiy8aIwFp2dWB8QiysVuFWDr0A0xABn1+qI9?=
 =?iso-8859-1?Q?sLO491fkdgyPhWP5NpZdTrQocDYocvvjqkz8ckoK1qY/qIvBG6IkY5Hx1a?=
 =?iso-8859-1?Q?tuhPp4emMUunbauZqfobeMBoBgJMTDWJQT6XaELg1mTPTGIxxXlOXsWnfZ?=
 =?iso-8859-1?Q?ePqjdkRo+W8QjfM9mdO6jp1zMoSAgxb53szY3rnxRDgCyeZKQLEqa8dvlu?=
 =?iso-8859-1?Q?BG2QPWbnIyVT8BDqO1s1oNkMgt99ZxwPegPWLmW6fkiiBPgV8w/BHYhXhP?=
 =?iso-8859-1?Q?N8tnGjVE0w1hNr1jUvT8hT9e6sWIuYyBNFgiKUFduhNktghkJD7NErcekO?=
 =?iso-8859-1?Q?tZsfHN3hfDIWjfSgNx4VL2QRBp0KpUZwg/fPXORdcgwc0El59p4uc6SeCu?=
 =?iso-8859-1?Q?tukqtxFwLDdKl2WXd4SgcRhOSP3VMgTtrEDSd143gfkoFKWXNUaq/9RIXi?=
 =?iso-8859-1?Q?g9ZwjwHGOE2HW4kk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g41EVpvNDI2Ch5gwbASNjNuF0Af6kKmAZ3lVStV6aqP41XC2P4b8ELQRyy?=
 =?iso-8859-1?Q?yM/W0cn4BqiMZKNl8XfbkbQbmZ5OtQHInzYMSXuVuhYnhkptOX6155rKCA?=
 =?iso-8859-1?Q?xL4sKGFLTf1sC4DL5LdSC38UNLLXRHjQRRj9Jgysg71t0DruRFjjAo/GHW?=
 =?iso-8859-1?Q?nHYeHDcV3ZgPMVaQoeqksf3CxgYPkE3cgtJOQnDN2s2O6/QzQHFqYyHWMq?=
 =?iso-8859-1?Q?OlhlNUjfDTDaVjbitalNnx04cH5iJajTCmBWWhI/hjshuuHcMvUK5PBdtp?=
 =?iso-8859-1?Q?puwNp1dsg6DffHmvYe1BRPoAl1jkBUfcDs6Xwj5XPBQUN778ozcGI9x8VF?=
 =?iso-8859-1?Q?f/oCkzIETSR6skw3XZcQsPg+aFwap6D+xCCVOH0iefHYtrH+9PmjYoeeRD?=
 =?iso-8859-1?Q?+3BiAG+FLdpqyoFcwMJxbEGx2RiEgFN92JBbaSU8avBIPScrW+JjhDwsH9?=
 =?iso-8859-1?Q?hyevUP5xTb1hINVat0BLUrH9uC5Bn8wcrT7YZ6P7ez8WVyqtMN9WedO/ki?=
 =?iso-8859-1?Q?wj5bnoF5AKlBAj4Ttz8WK2HWCFAMxvFMAB6gnkvHmqNjkjZUVeRId9w0dk?=
 =?iso-8859-1?Q?XpJX+St4xxVFBHV9ZqqpFlCtXvRCujv4aZrX7aY3Bd4PlaRyyq6PlXHHly?=
 =?iso-8859-1?Q?VJYdK5wsxat/ndm0x7EfwO5DE6PuphXI6Uwi0RGiSwB1k8MMoiCy88aleZ?=
 =?iso-8859-1?Q?ZBR75l41/p1Bil2zVQST67qVfk9kuOh3OUNkxhf0P+196r2JhN3whi1Bor?=
 =?iso-8859-1?Q?7vGTJVbkRQ2dI4rWbDgvr35kqPsiDps4BIY00Ad/b97crJQPPbwPQ2IliG?=
 =?iso-8859-1?Q?eZ0lqIGj0xyRu9ZH8gJIGOggKw75ohmgukc7OTvFeEoxy4mFE+FPhg414S?=
 =?iso-8859-1?Q?ZfNq53Ep4XRuRCHqIDa5RTvtD083pZMDlbRtpxD/GYkPExE5McAvJ0CqPt?=
 =?iso-8859-1?Q?StVw2QW8cRWQqDLbQg1HpC6BRmmTwfnMuvImarRQvyuwWXCfwqNYlNLekj?=
 =?iso-8859-1?Q?dbjst08QIUoikw05ikCePf45Wj8ljMPNWXM24D3UQB8hJynpB6Q9yp55Xi?=
 =?iso-8859-1?Q?bKYR7yg0k6T9uvz91g/7U1mNVRW2YymrPwvBTYvbsCv6J/Re7BSkFM8ngJ?=
 =?iso-8859-1?Q?SZ9ReHCnzKtIk8BmHUGpdpCRPgSap6wGL9rub1vt/nKBFEGrp2Sc03SfeI?=
 =?iso-8859-1?Q?z8X+DCOdI00h/WKazz+Plf7LeVR6lPNCac0NvRDN1ruRF1jX6UNvQ0WUrP?=
 =?iso-8859-1?Q?o/cnMlXlFSMwpGKXCirhBizc8IRJoWOF+hO7JNgLqVGwq5j56IdsTlPsp+?=
 =?iso-8859-1?Q?ZaROZT3jSxLXz2VM3fsydejQHeqXCe08KTmzo0TEZkNjQGp8becczOW1dL?=
 =?iso-8859-1?Q?4xAJKdzl/NKbB/wIRsIMaAlA5Gce+McySxRATMRgOJU+o764YTTSfbF+ae?=
 =?iso-8859-1?Q?enVpDPABblji1obKPCVdYVccyE+9wkNY9Bh+/yfhtFovXiAbUbitOAe5ib?=
 =?iso-8859-1?Q?+3j8gbTf+sAgRkoc4eLU2guVzyzpDMOljWoCyjmYgR6SxQuj3FpMwLGBLa?=
 =?iso-8859-1?Q?k2TPCu/P8q50yKlkUDRPkjd2zY1sGlUXnUnYA3pv0VJc0K+NGVPx/VoHX/?=
 =?iso-8859-1?Q?GCYDAgcC/IGWHS+pK76K0Dkp5gz3+pZ3GYZiMZ90X8jDoL23riS87xKw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3d6027-5504-492c-41b0-08ddfc0487ac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:24:14.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pef9xDCvAQIZPB/c06YgUiWH0pMYpLgV3afcedREWb5YH7oGgcvoUudjVbFdM6Vs/tPDQgx0j2t/RfJKG4cEEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 12.4% regression of filebench.sum_operations/s on:


commit: b55102826d7d3d41a5777931689c746207308c95 ("btrfs: set AS_KERNEL_FILE on the btree_inode")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-stable


testcase: filebench
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
parameters:

	disk: 1SSD
	fs: btrfs
	test: randomwrite.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509251432.59b331b7-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250925/202509251432.59b331b7-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-14/performance/1SSD/btrfs/x86_64-rhel-9.4/debian-13-x86_64-20250902.cgz/lkp-csl-2sp10/randomwrite.f/filebench

commit: 
  e3a9ac4e86 ("mm: add vmstat for kernel_file pages")
  b55102826d ("btrfs: set AS_KERNEL_FILE on the btree_inode")

e3a9ac4e866ea746 b55102826d7d3d41a5777931689 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.90            +2.2%       2.96        iostat.cpu.system
   1293622           -21.8%    1011948        meminfo.Dirty
    111179           +22.7%     136404 ±  2%  meminfo.Shmem
      0.02 ±  4%      -0.0        0.02 ±  6%  mpstat.cpu.all.iowait%
      0.39            +0.1        0.47        mpstat.cpu.all.sys%
      1300            +2.7%       1335        turbostat.Bzy_MHz
      0.16 ±  3%      +0.1        0.23 ±  4%  turbostat.C1%
     24580 ± 18%    +368.5%     115156 ± 97%  numa-meminfo.node0.Active
     24573 ± 18%    +368.6%     115148 ± 97%  numa-meminfo.node0.Active(anon)
     80724 ± 25%     +33.1%     107431 ±  9%  numa-meminfo.node3.Shmem
      9462 ±  4%     +48.2%      14025 ±  3%  sched_debug.cpu.nr_switches.avg
    104544 ±  9%     +42.0%     148483 ± 22%  sched_debug.cpu.nr_switches.max
     18711 ±  6%     +40.0%      26196 ±  7%  sched_debug.cpu.nr_switches.stddev
      6144 ± 18%    +368.1%      28763 ± 97%  numa-vmstat.node0.nr_active_anon
    609471 ±216%    +427.6%    3215506 ± 68%  numa-vmstat.node0.nr_dirtied
    602202 ±217%    +429.1%    3186249 ± 68%  numa-vmstat.node0.nr_written
      6144 ± 18%    +368.1%      28762 ± 97%  numa-vmstat.node0.nr_zone_active_anon
     20153 ± 26%     +33.3%      26862 ±  9%  numa-vmstat.node3.nr_shmem
    800.20           -12.4%     701.12        filebench.sum_bytes_mb/s
   6146050           -12.4%    5384959        filebench.sum_operations
    102425           -12.4%      89741        filebench.sum_operations/s
      0.01 ±  4%     +13.8%       0.01        filebench.sum_time_ms/op
    102425           -12.4%      89741        filebench.sum_writes/s
  28873566 ±  2%     +32.2%   38160857 ±  2%  filebench.time.file_system_outputs
      4.01 ± 29%   +4383.5%     180.01 ±203%  perf-sched.sch_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      4.01 ± 29%   +4383.5%     180.01 ±203%  perf-sched.total_sch_delay.max.ms
    179.61 ±  6%     -78.9%      37.91 ± 10%  perf-sched.total_wait_and_delay.average.ms
      7539 ±  6%    +412.6%      38652 ±  9%  perf-sched.total_wait_and_delay.count.ms
      4983           -25.5%       3713 ± 13%  perf-sched.total_wait_and_delay.max.ms
    179.60 ±  6%     -78.9%      37.89 ± 10%  perf-sched.total_wait_time.average.ms
      4983           -25.5%       3713 ± 13%  perf-sched.total_wait_time.max.ms
    179.61 ±  6%     -78.9%      37.91 ± 10%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      7539 ±  6%    +412.6%      38652 ±  9%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      4983           -25.5%       3713 ± 13%  perf-sched.wait_and_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    179.60 ±  6%     -78.9%      37.89 ± 10%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      4983           -25.5%       3713 ± 13%  perf-sched.wait_time.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    191802            +3.3%     198131        proc-vmstat.nr_active_anon
   3666016 ±  2%     +33.5%    4895484 ±  2%  proc-vmstat.nr_dirtied
    324179           -21.8%     253508        proc-vmstat.nr_dirty
   2228424            +1.9%    2271558        proc-vmstat.nr_file_pages
   1283451            +2.9%    1320253        proc-vmstat.nr_inactive_file
     27774           +22.7%      34080 ±  2%  proc-vmstat.nr_shmem
     35203            +1.7%      35786        proc-vmstat.nr_slab_reclaimable
     97029            +2.5%      99413        proc-vmstat.nr_slab_unreclaimable
   3628151 ±  2%     +33.4%    4838878 ±  2%  proc-vmstat.nr_written
    191802            +3.3%     198131        proc-vmstat.nr_zone_active_anon
   1283451            +2.9%    1320253        proc-vmstat.nr_zone_inactive_file
    325032           -21.8%     254299        proc-vmstat.nr_zone_write_pending
   2438711            +4.5%    2548843        proc-vmstat.numa_hit
   2140583            +5.2%    2250864        proc-vmstat.numa_local
   2587325            +5.2%    2722312        proc-vmstat.pgalloc_normal
   2441172            +1.9%    2488658        proc-vmstat.pgfree
  14693823 ±  2%     +34.6%   19777902 ±  2%  proc-vmstat.pgpgout
      5.99            -2.4%       5.84        perf-stat.i.MPKI
 7.594e+08           +12.2%  8.523e+08        perf-stat.i.branch-instructions
      7.74 ±  2%      +0.6        8.37 ±  3%  perf-stat.i.cache-miss-rate%
  12470451           +11.0%   13837828        perf-stat.i.cache-misses
 1.627e+08            +2.6%   1.67e+08        perf-stat.i.cache-references
     17709 ±  3%     +42.7%      25268 ±  3%  perf-stat.i.context-switches
 1.189e+10            +3.9%  1.236e+10        perf-stat.i.cpu-cycles
 3.777e+09           +14.4%  4.323e+09        perf-stat.i.instructions
      0.28            +7.5%       0.30        perf-stat.i.ipc
      5.53            -0.5        5.00        perf-stat.overall.branch-miss-rate%
      7.66 ±  2%      +0.6        8.28 ±  2%  perf-stat.overall.cache-miss-rate%
      3.15 ±  2%      -9.2%       2.86        perf-stat.overall.cpi
    954.54 ±  3%      -6.3%     894.29 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.32 ±  2%     +10.1%       0.35        perf-stat.overall.ipc
 7.538e+08           +12.2%  8.459e+08        perf-stat.ps.branch-instructions
  12385908           +10.9%   13741541        perf-stat.ps.cache-misses
 1.618e+08            +2.6%   1.66e+08        perf-stat.ps.cache-references
     17574 ±  3%     +42.6%      25062 ±  3%  perf-stat.ps.context-switches
 1.182e+10            +3.9%  1.228e+10        perf-stat.ps.cpu-cycles
 3.749e+09           +14.4%   4.29e+09        perf-stat.ps.instructions
 6.365e+11 ±  2%     +15.1%  7.326e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


