Return-Path: <linux-btrfs+bounces-10978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A4A1332E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 07:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC5F168006
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1C193077;
	Thu, 16 Jan 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfrIOx1N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023E18A6C1;
	Thu, 16 Jan 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737009454; cv=fail; b=qUtXHxfeuwsdhaEw+rwSvTas96Fqq6T4xH7xGrJxCKdRRuKZHuHyEXMjl123+BrE2LME+idYIQzWz6qvULkehxZmT2q/xXvmRl0xnXDk7BPAWYLECWSmuQnyT5Rq+01Ykl6/dtuanOt9uV4toffVgZF8lVovyqfJK6VcryWrPzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737009454; c=relaxed/simple;
	bh=Om0RKCqJgHmzO+qYPkP4x8huI1vKdGElMegVQDVsGIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drsrh4VndaZNMhvpguq5GniYO2agajkHpDEhVYeKAgZlY1VVh6OvwNo5pJr141QH214bvawYDn1RGNAoEEkkW8vytZQKvIrIYKYSIR5JPEfGfhU0ZX0HgpoKyHPlcn7a3F6Z20v70rr5KUd+mY5XeT4m2A3UMz0W0zn5On07OI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfrIOx1N; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737009454; x=1768545454;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Om0RKCqJgHmzO+qYPkP4x8huI1vKdGElMegVQDVsGIk=;
  b=GfrIOx1NfmIjUoq5cwyxm8N037hs21rxlP3ShIsQAwXmNgFhL0LDXZC2
   UYz9Kwqv38jU80cCV+J76rwuMBXphu7UROqtR3vV+zV6o2eVP903E5Cnw
   ZZAx68NKfQfncO2CDcA4hb1GqiBayid3Zf+R0hPZvbczGnZzCddXc8unR
   OIf0tZ9ExCs4YU9ub/7UxAipEHF0pgfE9UUcT8VNlilm1yE5mlxDxUA8M
   v2QMArEjXZgoNbM7SybqPaFUnMpUgaw0kgDADhXZ9HHk2qwn8yviA+1vJ
   oo4IRiJltneEVDoXORVLiheY2TwS3uqNFypYBL07HCc2TGvbUJryDxPN8
   Q==;
X-CSE-ConnectionGUID: UfV51xO2TH+Ilvw8+uY8XA==
X-CSE-MsgGUID: P+b1TwdGR6Wh+Q2vAgyKxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48772424"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48772424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 22:37:29 -0800
X-CSE-ConnectionGUID: bT9LD+MtTKe6ggmot7NTBg==
X-CSE-MsgGUID: MQeWb2qOTMiwxwNHI43aYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="110362323"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 22:37:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 22:37:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 22:37:26 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 22:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcQkOLBZooXWU76iWvRcjrKl1BeVTpXfAa3CchXdvT12xPt/nDegsAAizZITOtTxXA6p96N+ZE7E0rd5WRzC+kh30cf/45jyz3KqiWnFdNoSGEi7Z749ghhKKFakSfo0AsSR2cx/LthMKpFq5RrGHJPE9ZFNxzfddQyjQZhQDLtFKybRGwlj0oiwbBaoOOhrW2nDEZA3qpDtMMZBZeUOfc7VVbW2wcYbXtjHYKCcCUCPRBTIGIv0jLkYOH1XfTlD1LlSUSuHReQFOtea6Gty1hl1mIv/0DrrNVOoLNxNwhzgi3E4kBmBmBusgOTAvoAL8K56E4wLFZMvp22qPYa7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLS5ucN48rCZdU+GoJadb0EnmYMv6N8oBwTQPkpM86E=;
 b=JZehtzuCWVglrjSPE+LiBHuxCmyDRxKOZqcZivnHeFlk9Sfu803xtjAAGXshPyZYqn3FCeRpZLvxyLd4MLBUojyIyPOc54bXjDq5kM0Ykod23CLsvxTi2EuopDA4ztWeBg0y9oBW6pCvF6CMJPKcGOnpwd4Dc7DM7SRE5wnD+bJsQ7GuHf/lUwGNYXW86PP2Q7MCHBxgyKsQIC2yBC5ESa1j21sz5L/u4/BQx9pGlfKrjRFcOrwfFyiCT6UapaVg1Cg4SxR7ZgGJ4WXRYg0PtzsHLaHef0b4uGQMeAdA2TDkZXWdfElmxtvXi88BW70oQBitOF6wBim/+mHiiCPCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Thu, 16 Jan
 2025 06:37:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:37:22 +0000
Date: Thu, 16 Jan 2025 14:37:08 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-aio@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4ipFFdAppraxrmA@xsang-OptiPlex-9020>
References: <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
 <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
 <Z4efKYwbf2QYBx40@ryzen>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4efKYwbf2QYBx40@ryzen>
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 87db3d83-aa28-4d32-0e21-08dd35f83bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?18a3K2MokQoh10BAYL5X1dvCPHSyggB18Dq4J1TEiwoLGhEx5feKu06D5E?=
 =?iso-8859-1?Q?OxQ0R+PFUqhJ53bj/9he91z2y5A9MNLIhAKvWHRZf4Nu9k4en7TwInrjd9?=
 =?iso-8859-1?Q?7VvtqjcRnXcaeCU6R4PBfhgDLseAJuLGefDIotNvlFVSjRgiKT1re1Ezi8?=
 =?iso-8859-1?Q?FoFp9VSg3PdLY29sJY92cuoLXdMq7VXqWAKrReBuWXcNnnFs8Orvzpi46s?=
 =?iso-8859-1?Q?OKzwYTuKZIemoxOh89y72+2IU+ZqpHI9dwygEh+hawJ8CzZBNyd2BtXWMS?=
 =?iso-8859-1?Q?0Plut6qg7wl18IoONvoSoKH1pknytsvQahfmcNEDki2EmJN+CL4Er+fUaM?=
 =?iso-8859-1?Q?Vxk4Mz7bTGIhISck05dN3gY6MPTTg6V2+Y8NWw0U1jhUcv8BHPoJHEVFkS?=
 =?iso-8859-1?Q?0LgrtLDvyh4eVYyLg1h4C106IXD9TTWeJoDv/ZnKyWlVhV7K4BTZ0/8spn?=
 =?iso-8859-1?Q?xYcLrZG6OB1Mh/HVIqSDJn0fckTl4qUJresL85wdVo6pguaA7ilAVGforl?=
 =?iso-8859-1?Q?FsMcfjTbJU5Sona2xDMNz7PyE2YieS8p4C0xYRbqzLtYiRkrTC9IAmCMn/?=
 =?iso-8859-1?Q?r0RpP2pruWNyzrjOazEt0u59ob24X9YXxvUR8ZwFMGOiTmBqwNfqeHe/Kp?=
 =?iso-8859-1?Q?YoLx1T96x9dgz5LW7MTf4okwQtMd6CwG+06AbFeNI0yO6VRJXv2WwNk8fg?=
 =?iso-8859-1?Q?O0eKE2naf3J+5M/ZsR7wc7D3+nFV9vKeOHpDMrMO0JCuokgezRl0BPr4jr?=
 =?iso-8859-1?Q?AOPyAUrZokOa3kRjxL8pYoI1VhA7eEpM53I2pbpkhyROwGnE2z4WO6P5Bf?=
 =?iso-8859-1?Q?FUBH65sw3F5+QAt8F5/wGQeIl11nSj445hAuGgId3hWyKv0pnHxGPRRrZF?=
 =?iso-8859-1?Q?HWq2eVNBHPJgLMlCnU1zIMdhpIb+iHMrm4c0+iuOI3C2QViHEY6ggDiLn/?=
 =?iso-8859-1?Q?Zm0za7dZzEAx44ExTesI0Sp9Npb2vBo9OVV4nhmNZv/aQRrCCH12BMnI19?=
 =?iso-8859-1?Q?16Ai6qobp8pUs/0UJ+Jh2vK03XdiWYekweC79E6z+7h6fHdT/qoKuts3Cs?=
 =?iso-8859-1?Q?SxTYPWV5NiPhPMwCsf59iMIFHrzaBImxHTvRMA9EZ89oBYIzo4B7m863jk?=
 =?iso-8859-1?Q?jzv6WL/0Z8DA5s/FFw8LaX8t4i5ec1fRYH9n8mu4WVgL1pFullH71jJ5Ze?=
 =?iso-8859-1?Q?5cjpO9nHW7l78SzUQWZeL6VWdqvCp+AD87DC2H5TDRLXnIsBuTsJndk+Dp?=
 =?iso-8859-1?Q?frHmud49+O5uXubhe2DmqMKbY9BLkjzYqiE9TJ06y5FenyGql1WG8Seq5Y?=
 =?iso-8859-1?Q?A8/EhxUdR95cB7Zmy2BrbmH7R3ohK6+W5nj240rhKH2/zxdtJgOlwrU/ot?=
 =?iso-8859-1?Q?4YlBkhoBuSjgk1Fbzs9YKg2LlDecpvaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SH83aM9Wlcs07b2kolhjmCT4wxPIMrfMyCZqcOWD4A1KeccErFcARBwWZl?=
 =?iso-8859-1?Q?4lijeMhVmc/gxFf3lnWkcZMG9eXz1TYffWBtnUJXKdg2kOSIQ6fCZTpnoB?=
 =?iso-8859-1?Q?uy5tmQvH6TLGVDQqHiFEFdYkCRZE8LLrHhd3PIGo1Okss+8u4ktzfkK4rM?=
 =?iso-8859-1?Q?UdaCvVpiJfHR7JdBuwaVe0aIciVcKQvsApGb5+IOYHrROI/neXUjPHGJey?=
 =?iso-8859-1?Q?Zn5HbFart1/TJ5DptnKiRefhO1GfGxe6uj79xfG2Epd46dO/ozyid4cWGa?=
 =?iso-8859-1?Q?KlREOsHd12niSQHh8CSeHfDVBk1yKajPRpxR6nadSBuam9VUgWn/hNPqVW?=
 =?iso-8859-1?Q?yisurW32Pen3aSa972Xneu+R6mQNDFn8izZmieD0+W4hiw6wSp5SVUOhYK?=
 =?iso-8859-1?Q?m4Ck7vu4MaXaYtzDzbTlm+nZpgGCIBSUpx2RjZCDv8rZBvor5UscKBG2Hy?=
 =?iso-8859-1?Q?FdoXKjjOnboVAhX7jRKk36EToPrulg+c0Lhb2mY6hO7TltH5w2H2FjuvIn?=
 =?iso-8859-1?Q?IQCojCxqnsY6kIqygbeL9RrkKVWX0yoCtvYyc7Is6Ep/yhHqhz9Mn9d1nr?=
 =?iso-8859-1?Q?MpRXNDkcno1tI3cRovLhidInpIEKLLP3HdUxc5JhQGW7/YEHJdFLXE1eUp?=
 =?iso-8859-1?Q?89xh+f5dElUspbU9seCoBi/H5ezpmpP6uQoO65bODAOCo+txChUIM5jNEP?=
 =?iso-8859-1?Q?7L6enwkiEuDQfB3ELZ1E/QDdnCduBR1sBUX05BrkVSQ9xi6iBQDpDDmXIR?=
 =?iso-8859-1?Q?4Q218N9GNwZIgCf9euqZwfEttnXHh6MZxuUlovCrQqp1YgV85/feJkiJH7?=
 =?iso-8859-1?Q?pvuHF7MRl9CCGFZLFSwpWolefN6MK2C638ysHV3WcFSNWiIjdqWkAc2E3/?=
 =?iso-8859-1?Q?Ih8w/k0hnfTr8LIdZTpBZ4RPTTdW0joA55oWTluv4ky4ppNjO14MrR9KEo?=
 =?iso-8859-1?Q?TP11ZmA0lis2I/LyY20rCfCBt7zwEW80SvAsZPpSc2oA4p3GvNTJzYiH12?=
 =?iso-8859-1?Q?QkZyE4x0bpQAU/ifqYWaYbiceSL/iZ1Pgu8bUm/Uwt9mQ0PHfyWNGcP8yK?=
 =?iso-8859-1?Q?W38FBSjB6xI/65M8qJHD1VIQ7MOc5aT86UqHl8RYmwMi+49kfifrnp51Rw?=
 =?iso-8859-1?Q?Oj/QePzakTIzqj6h1SUljaW1ufcrt/zmqtNRXe02fWY8iWuuAMJ2LkGcaM?=
 =?iso-8859-1?Q?r0gjBNNb+GB3df9lphHZKWCSX6hQYNpCw1XReRiUSLJP/vP6FYzSGTouDE?=
 =?iso-8859-1?Q?nuqek3C1/KH9FeYdcPOEwtAAjw4j2e7x5PntvkzqfFB+pLJa2PvSACVAe8?=
 =?iso-8859-1?Q?GUfeLE1gP0bXjICp7J/HVRmCNObcz45hic5gk2utwdGLW4ahW8NLz1bvZ+?=
 =?iso-8859-1?Q?gyA45V+x13uhYKlM88NJwDEzkg0Oo77+MzcyyUY6pflDbS4RX27QwnfWpT?=
 =?iso-8859-1?Q?WrBUTaTSc39PDkgOvgG09Gr3oDWBXsB8GlPn4AM+NO5LE9GITj/JqAgC6A?=
 =?iso-8859-1?Q?rS0IykB3OXlzMbERF7NvJi99HU1MN0Y0n2iPhxfgITGxto0wg1TuxNliev?=
 =?iso-8859-1?Q?mOPk1gb8WuF8UHWSUZvExwA898o5FGvWllxPgRe9Qhus2iiMhyo0iNz7sT?=
 =?iso-8859-1?Q?hkXD83qZhZfnP2TcS4Gptm7DY6bQr5W+ROA+MAXKkpkoSuUTudN8e3eQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87db3d83-aa28-4d32-0e21-08dd35f83bac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 06:37:22.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLfCYXbZPlXGPnH1zdwjI24Fi6rouQPmtJolMXJtXVf+FwsRVmhNgla1DKv+G7j9jItxPQxox5Up4jOcMv2ljA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com

hi, Niklas,

On Wed, Jan 15, 2025 at 12:42:33PM +0100, Niklas Cassel wrote:
> Hello Oliver,
> 
> On Fri, Jan 10, 2025 at 02:53:08PM +0800, Oliver Sang wrote:
> > On Wed, Jan 08, 2025 at 11:39:28AM +0100, Niklas Cassel wrote:
> > > > > Oliver, which I/O scheduler are you using?
> > > > > $ cat /sys/block/sdb/queue/scheduler 
> > > > > none mq-deadline kyber [bfq]
> > > > 
> > > > while our test running:
> > > > 
> > > > # cat /sys/block/sdb/queue/scheduler
> > > > none [mq-deadline] kyber bfq
> > > 
> > > The stddev numbers you showed is all over the place, so are we certain
> > > if this is a regression caused by commit e70c301faece ("block:
> > > don't reorder requests in blk_add_rq_to_plug") ?
> > > 
> > > Do you know if the stddev has such big variation for this test even before
> > > the commit?
> > 
> > in order to address your concern, we rebuild kernels for e70c301fae and its
> > parent a3396b9999, also for v6.12-rc4. the config is still same as shared
> > in our original report:
> > https://download.01.org/0day-ci/archive/20241212/202412122112.ca47bcec-lkp@intel.com/config-6.12.0-rc4-00120-ge70c301faece
> 
> Thank you for putting in the work to do some extra tests.
> 
> (Doing performance regression testing is really important IMO,
> as without it you are essentially in the blind.
> Thank you guys for taking on the role of this important work!)
> 
> 
> Looking at the extended number of iterations that you've in this email,
> it is quite clear that e70c301faece, at least with the workload provided
> by stress-ng + mq-deadline, introduced a regression:
> 
>        v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     187.64 ±  5%      -0.6%     186.48 ±  7%     -47.6%      98.29 ± 17%  stress-ng.aiol.ops_per_sec
> 
> 
> 
> 
> Looking at your results from stress-ng + none scheduler:
> 
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>     114.62 ± 19%      -1.9%     112.49 ± 17%     -32.4%      77.47 ± 21%  stress-ng.aiol.ops_per_sec
> 
> 
> Which shows a change, but -32% rather than -47%, also seems to suggest a
> regression for the stress-ng workload.
> 
> 
> 
> 
> Looking closer at the raw number for stress-ng + none scheduler, in your
> other email, it seems clear that the raw values from the stress-ng workload
> can vary quite a lot. In the long run, I wonder if we perhaps can find a
> workload that has less variation. E.g. fio test for IOPS and fio test for
> throughout. But perhaps such workloads are already part of lkp-tests?

yes, we have fio tests [1].
as in [2], we get it from https://github.com/axboe/fio
not sure if it's just the fio you mentioned?

our framework is basically automatic. bot merged repo/branches it monitors
into so-called hourly kernel, then if found performance difference with base,
bisect will be triggered to capture which commit causes the change.

due to resource constraint, we cannot allot all testsuites (we have around 80)
to all platforms, and there are other various reasons which could cause us to
miss some performance differences.

if you have interests, could you help check those fio-basic-*.yaml files under
[3]? if you can spot out the correct case, we could do more tests to check
e70c301fae and its parent. thanks!

[1] https://github.com/intel/lkp-tests/tree/master/programs/fio
[2] https://github.com/intel/lkp-tests/blob/master/programs/fio/pkg/PKGBUILD
[3] https://github.com/intel/lkp-tests/tree/master/jobs

> 
> 
> Kind regards,
> Niklas

