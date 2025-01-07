Return-Path: <linux-btrfs+bounces-10761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70CA039CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E018869AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E21E0E0A;
	Tue,  7 Jan 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beucoZdk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46772594B5;
	Tue,  7 Jan 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238510; cv=fail; b=XG3ihwM5k5/M+ElC0wKgsvXxpAeJwF9Apf4Ib+CrfXD1QJb9K/zzM5TmzYqkW/62n7ncM1pCqiPttkMHSVM5eAq/YjDn6YepIS4DH6lbNSWrhZqdGpVIK9Bc0lTXEf4dx9PkZYaAYMlYzAj2z/L/YG2vjxB6vEsKcVjUPUsgI6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238510; c=relaxed/simple;
	bh=AUPkL6Z5du5J99VXLnvWWXSoMEd5GkBhr+y6eNIx8Ug=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOvbCG3d0YNdf+kxgWxTkaOZ6udUAgAQdW/Jas8AMYjlDf1TaOd3jHJjxGTH95OJtKD31cQRA+CxEuZMmWwOUXQUjmgb/SS3fqGb6OeFvVMEtIn3gYo+FlaB4QhZK8HXiaXwbYc/7k+MgP2s3tWZb2Yds1x4SDAeYy7HtUuC4Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beucoZdk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736238509; x=1767774509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AUPkL6Z5du5J99VXLnvWWXSoMEd5GkBhr+y6eNIx8Ug=;
  b=beucoZdkKUT482MpJbr+Q6wAtbnzZDdlJ6a2JPE5z3N5VVJHBybHUZ9g
   k0OhdRr/pHKSoU+3WZI4Is2bydMhKTIDM2Xhcpq18gfR+ml8PRmZN6tEI
   aKJ2BnJvne/Z/dW4dimAce/xwS33qoG2LDeq2SdaD+yRyrWLVZJRvEI1c
   7GU1rrAX26ea5rrqUwynmHerC6hyVGyMK+/5WDg0hvTAkLo5VmSlz+OCd
   KVyEbBzjgqccT+pxh8ypOcXERSTFAgJEaCXoOqgembZ+RAnHb5IPQW/Jz
   p1nMTIc6O9ak9HsrbFPe7O9AkHRyAntMY9GlsQ64Lh42AvcrgG7+6do1+
   w==;
X-CSE-ConnectionGUID: dhfzl/NMTAe7eBQ+dPVxCA==
X-CSE-MsgGUID: gb5/LKV3R2CTXP5/QbEurQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="58871032"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="58871032"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 00:28:27 -0800
X-CSE-ConnectionGUID: mJBl2nYlR46rVQkQZy+hPw==
X-CSE-MsgGUID: Vfntu2j+SoC1/GvAcD9fWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="107752641"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 00:28:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 00:28:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 00:28:26 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 00:28:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTrfM50tz35LFfLgDmyCWtBOHaJNOkTY11LyocMzdySkGV6sYUJuV9/O9H+1O4hmBnaKg8Zp7sbjlRz37Jeh8oitU26kGTJT0uUoNuzNNKXyEd86hulHQSb67buDMd//EdqFZNdxSwJ/cKpnH0Aj84+Gb4L37b8Xxm/TMH+rLjeX19oyK483A2E63dg1oVOX1YP5KUijhRG0HVGpJ1EOQ8iiUTE9Btrbltj1i8F4m4SFu2oTW2/GBGa/BSgLNIx3qiAMPLLaOdxL3S5V5PxTgzzCwX4iq7pqc3yZl71uhd57MT7RfQhxZhQ3zrP7R99itMUTarbgWTodtJpHD/9ImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0wUSzRciiqTAcp6VmyRi0QCmUK23k4wo6bjKitVfYM=;
 b=urUU+ywm7mnbf2d7B6wAWFPIPZAOkuLTFTmWJVaKGDmt19kqlMXANQ2vPhz6OUv38ISLlTM6gQtCef9Er4ht0MoJOacVhUpdqUzllmMcXe7yR6G4BFLpISGjz8Q+NViIMacLho8WGzp4YDmSwnOEdBLx4yZOU4PZFZsU6YLHbvIONfhcK+Y9xnhsAzq9KOeaJJhy/ksrPUdz+44AsKhzcW3AN5E0kBo7QMsflvZytLrlDC5MEiMWJPMvrCYWxL5QSHlzchnYN6Gz7u35ce8iPc/25fYkqvzKaUIRip6kfibhkTApXOvgs6lxaL2Onfqi+L1D+Mtzmo4jLn3+jTDuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 08:27:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 08:27:55 +0000
Date: Tue, 7 Jan 2025 16:27:44 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-aio@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z3epOlVGDBqj72xC@ryzen>
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 420b8d4c-3f2b-40fa-a825-08dd2ef52fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Mf8u2UKGhRfmldAkO4GykQu42XU/3/rb9GA90SOCI/6cVbfaLSRS1Jnwh1R?=
 =?us-ascii?Q?0I2WDlk3c0GEyJDtVADjNnPJGHh5pVOBw9CVWLYimcxhyEgX0jGST3Y3iJ6q?=
 =?us-ascii?Q?cazrOHft/OFSSQoWyK9wqI8JtOYc7vL/H7BQeai8Bm6r9L2iJ/lkp2rRdBPB?=
 =?us-ascii?Q?oWb/w3YDVX7AjLc1G2oRC8m7PSknMp45nxVHG0ss2wnGmjgF/+G0npsvMzJ/?=
 =?us-ascii?Q?4TJNyRj+Zq5clfDrkv0wnjLthexO78Hd/6Jvsu4ktMjiYzVY8u7TVi+K7j0s?=
 =?us-ascii?Q?FuyAR0RZXK4E2OFrga6KZf+8zaHkXNTNKPxlkx5BG0Ih6RG5HiqBA5IyvpuI?=
 =?us-ascii?Q?41qOgbIg6sYa+a24/SKZa6eBNuxboQqWSMG1GpTAu1qq1sCfOy5RBabqkSna?=
 =?us-ascii?Q?jjsODjNY+hWEn1vmbLf7gTBZV4TWFa3hmTqkTRMZl55lZd9vVAh2nLNTZ2O+?=
 =?us-ascii?Q?+Tyh9QWzUFtf7sfLGgr7kU1SP8tCmohxVlnN7tIvrdx6TQPbIAjvEZHpOZKU?=
 =?us-ascii?Q?/spW+3yGAzfh9IXwEw65SOxp6I4sQiOQjIgWs89PyXkyG6eAwKY/lBxSWgSa?=
 =?us-ascii?Q?EBEhZ9VGiuwBGwSQ3u/6Q5fvnGfcWyK0xZJG/oAr7r5rc0qpOyDi0yboK1EU?=
 =?us-ascii?Q?OlCYhbvktd6iHglYHKubJhWuISIHutyMWbDSLwpSMwgO0btBLtrctvjKWSlA?=
 =?us-ascii?Q?Xr7wS0DUQge8cJ67CfkuKFGQG0PShYw1lWNcEYKhEg04t33DwmA5uPGn3PH2?=
 =?us-ascii?Q?oIVL+IG5v/9wDIEE5bEoBNK3583nQQIgtmraDinhKf0VPR5WuSUaJwyOcx5u?=
 =?us-ascii?Q?dXnjxj7+ZoTi1hFfqrYk8VE4UJzcJeJ+0Je+JpBmX0+OuZeQ2tYGnaIc1kM7?=
 =?us-ascii?Q?RHTYTYwQOJHXcopeelHp6FHyZ47j40eG/IbWwe4pbkXrVvvoNe36GhqQi3hQ?=
 =?us-ascii?Q?XzWKivv7GWQrZ4/y3GTdakHKrca127M2+fcL/eLgk+KCk4YPwVRiGKfsBPws?=
 =?us-ascii?Q?L3CONqH/orusIXDc+Q4xE4pxHdi6CUUeIxC+mII+py40HgTpouRZbOu3cArQ?=
 =?us-ascii?Q?RIbT8QdMbxT8Hj/oaBIsbYFq7IBsbmha/k5W0nT8adyoRosKsjrG2HZ/ORMY?=
 =?us-ascii?Q?SGzLmJeccRx2twlyXRNEy3NS7LH3aMjuNlCGKi9YfTP3whY5KoseVS9iqJ75?=
 =?us-ascii?Q?z+HJ5R06Ceb4IxRmvv4ta3z2EONoVgvqhVZ80+8Cd2kVqzn98ufbNcUSkdmN?=
 =?us-ascii?Q?2dj20yHGWeUfKXxPEZ1YxbwGry1WipwZ/gXLZZaC47wPNjXl7ddUVAX9zcSo?=
 =?us-ascii?Q?QB5ZzyF+mSbKeVtHVBOzT0XSBgJJL7b73KaoMYn985ivFO7OkiCjbogSO6sk?=
 =?us-ascii?Q?q/4QTxz0JsosRClv1QUdRcL45///?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRiJa+ToqOqjFAfCzDKwXQQQpcVyZ6KsKkb/HbnDeJsWfph7Nx3qlafFbilw?=
 =?us-ascii?Q?dK9moWilnRlBSTPZFeqfa4ttuIyqKiyxJwXR4i2tws6vrrkYaHS/ij6aFeUO?=
 =?us-ascii?Q?m4p16P8ZlWMZ/b2wU2Ar2nKgokKxEXBfAHBQpNNAOeI4ZMM8l6nErwM3GyuS?=
 =?us-ascii?Q?nWitMn5wjh7wpPWItVdpe6RWlGy+D2Y1EvcuTQDNITSaMKMuU19qBuqlbiWt?=
 =?us-ascii?Q?mc5w0nhWeMwFIsa7//EWMQm1n+EKB/1sSqvhlKOgE4OGRxBzfM1g6z1WPn+3?=
 =?us-ascii?Q?RTRnQURhURYayeU0rvHUGFkU88UJa3+rXh3cZ85doXswgdLkS9bFVQlAOKl4?=
 =?us-ascii?Q?ucArDFqE74V56nPA0ZhcVQZ95nln8rBS+/SLuQV70HylZhSZSdytPm/ZWg60?=
 =?us-ascii?Q?QuFZKP+Nu2qp0mxNRNjDgOFuP49V/kl0+jSccBOt1hphmYsp0b+DLgA6azYM?=
 =?us-ascii?Q?Yyd6DPeYSdXM8JdLe9nL7cSvsCoo+THE+HEl8sIfV08UQ02gVtXXONGvvSVJ?=
 =?us-ascii?Q?sWqaCc2Giqdr6z/B106wSp/n5ya1xkO1of3DVgXnwW3vdXO9AaNE7lBcveIH?=
 =?us-ascii?Q?B79P01Ubf4bH11IH3OGS+WBw1JI2OScaCUSeK6A4Uy0teuZilC6b57xaS44i?=
 =?us-ascii?Q?/5jmlFobPiCVKQqPWcZs/+ywSWPtFuuKQktyWrFZ+8IOET0XuLTY2t07L7WU?=
 =?us-ascii?Q?mSTFukv8yX7Ww9AdjDDf+vcLUq2ZtghNQiq/NRmn3z22xc6D6W+UyEI1TnOO?=
 =?us-ascii?Q?+6ayWkxg1Dc7ruKyZbIAuLbBL3GYPq7rgI4NNAPmcZJ9NTCMS5KyLjUj+SU1?=
 =?us-ascii?Q?0ahhOXqNrwpiv485Hb/bj7mZ77xKxz4k0mJW8BEFJ0D0hvFPKHXtpUtJIDjj?=
 =?us-ascii?Q?LThYEtCIfxdnk83nc6TMmZh5SvmQ+IC9uKgitHka1pvY9TaWuaMfbm5cPhYP?=
 =?us-ascii?Q?SsP4N6Mifg0J16zDCBfOUICd84+T55lXGLAYEi/p/1YibaG3BTsptES7/9Dv?=
 =?us-ascii?Q?Hh2ONkV5qSQQQNm+Q0+cmps3vJwzdA+rP2QRoTCUQ4T7osIPw9Y0nrSJ4ZW9?=
 =?us-ascii?Q?psm6/6B+HTG6tKpb6vkOB3nEA7UN62A6DE/8MzuvTmIIYVc9dzK0ueo021lt?=
 =?us-ascii?Q?/3FMk2U5MW5s71lWN7EDBbySz3kXBiLDp4YqL2V1qVUunE/avYPvrZWiprBa?=
 =?us-ascii?Q?uqfaBiEGdIioUm/EcOL76BUSXTZdXYi15IpGCFa/cTM8K5/631DHQhm/1+yw?=
 =?us-ascii?Q?wnAKGUAdm23pimTg8sFqMyqKxIxtQO8QD3p0JMRpOY8lbs9OGyMgEj84XEqL?=
 =?us-ascii?Q?UixdDpJ5ekfQWCxey3mr1sjPj3kLWU99PQ0m1yo3Uwf3lVpL7yWZLw6mCqQi?=
 =?us-ascii?Q?QcE4+AAdkttJ5tZs/5nBz5bLR2cJ11hwGuYmhLL6wEepn5lWOsCeubmr+cqp?=
 =?us-ascii?Q?Uc0//9uBTFdUHSI1Z7OuuzkL2eKf7tRfFEZEEMYn09RVBnyNrQmFJnx1fDLh?=
 =?us-ascii?Q?HWj9D59S4xe8jua3ioo6AtlZs6XL+PI14xMxJb9NfHqu43mA+F/Vwamlqr/s?=
 =?us-ascii?Q?d8WFNW0a9R/lOfFUnGn7Sn7u4rUC++J/XtfDIjrIy8li/3R5zOwNC8/u7Obp?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 420b8d4c-3f2b-40fa-a825-08dd2ef52fae
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 08:27:55.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31+3rDB74QdmysPjyw8DBi0pGbVvAfd/hc6GfM3E/K9gYYGbrpQy1Le02DnmhjVwtBI605yn+rC1DSqQ5jiYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com

hi, Niklas,

On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > > please let us know. thanks a lot!
> > > > 
> > > > Yes, this looks like ahci.  Thanks a lot!
> > > 
> > > Did this ever get resolved?
> > > 
> > > I haven't seen a patch that seems to address this.
> > > 
> > > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > > reordering when issuing a batch of commands, my guess is that the problem
> > > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > > or block layer.
> > 
> > I started looking into this before the holidays.  blktrace shows perfectly
> > sequential writes without any reordering using ahci, directly on the
> > block device or using xfs and btrfs when using dd.  I also started
> > looking into what the test does and got as far as checking out the
> > stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> > submission does simple reads and writes using increasing offsets.
> > So if the test result isn't a fluke either the aio code does some
> > weird reordering or btrfs does.
> > 
> > Oliver, did the test also show any interesting results on non-btrfs
> > setups?
> > 
> 
> One thing that came to mind.
> Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> the I/O scheduler to BFQ for single-queue HDDs.
> 
> It could very well be the I/O scheduler that reorders.
> 
> Oliver, which I/O scheduler are you using?
> $ cat /sys/block/sdb/queue/scheduler 
> none mq-deadline kyber [bfq]

while our test running:

# cat /sys/block/sdb/queue/scheduler
none [mq-deadline] kyber bfq

> 
> 
> Kind regards,
> Niklas

