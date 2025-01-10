Return-Path: <linux-btrfs+bounces-10896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACEFA08898
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 07:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5836B168C2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857172063ED;
	Fri, 10 Jan 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch2I9FyZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC12054F9;
	Fri, 10 Jan 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492054; cv=fail; b=oOaGJQ+dK3TlA/4dlm4IS1vXcqFgEHqYRr9fS9gAKQMXhFd8l1qGdvy4QzajO0UehKt+RvqbgsYSiSzgCCpx61+hnUKE+Qnh5IVWzGz8M2+70QBSP77rbINTt0cSzir8gbL3DsiaQvRqoPyVR6BCZ8P3IxRtYBs64UFgFrFO43c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492054; c=relaxed/simple;
	bh=SFHKO8D6R5066kCUcjFRqtwKYgzRQNskGZvfZXRNlpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6skmxXjV4hhF5SDbYb2qaHZnIxbjg+hNJgKHpCVQR/hyFxML2dxgzpyP1H7NuyJAINwqRIoFXVbVpSt/44cv2zFnAQvFMiOuEMMZ0NRcg14NdKCiTeDteXkebVcjvkgPJHTFIR+pgVYnKGVkBcX2pUGwzAVYD9i+Lq4qLudDO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch2I9FyZ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736492051; x=1768028051;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SFHKO8D6R5066kCUcjFRqtwKYgzRQNskGZvfZXRNlpo=;
  b=ch2I9FyZot3zV/pxmfp1wkJ/uwY4uSBaneCnH1bhTN67XpW+hiiVqesa
   /hqnmMWeyM0OwgpcIDmXQDd+/ESkczSuWmhuFQqif7UU1MJZ4YwLCb4iM
   42BCjb5FoGv2lud/lEva6sJcnxs55eDBOugytVQehU2CRFmvZpvQ5xP2G
   EYaeXhjnn25MyHu2/OjR/i7a6XHdp0e+wfDzUBQXZsaBj8YgYWGeCP0Ot
   G0IanLa7xC3KbzCMGYVbROEMslsO6qsUKFo7oMhi3qo9NVRMXBamNCFsQ
   juw7PZok0HptAvYddfpm2Wx2vVzOSkhST+wd33ZbqAHPhUL141t5rI1qn
   w==;
X-CSE-ConnectionGUID: R5LESSBwQK+S8qNLkIIgyQ==
X-CSE-MsgGUID: ZR0tzZKOQLyUCS7L1Vac8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36937986"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36937986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 22:54:10 -0800
X-CSE-ConnectionGUID: uIwKZcdnSLOEgsZWq2uSxw==
X-CSE-MsgGUID: rvf2BeoIQSWXnz9DG7lsgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="104197357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 22:54:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 22:54:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 22:54:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 22:54:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/fZInvSgur9v9n8+WVH0IZU2AXSPOhCksC7KQmizhnW6WdN+I3b+OoxjsPVcatzYiFy6dnK7jrfu7yQyyVaW/xxHH7/BwLyc9xaE3Gnek/RPuRy4NscV8S7i8sEock8V9733uI663x0AAXoCi9Slkf+filfmUm0yvNTFP6WPYjX4haBSa+6LSx7abmHNaTDK0lpAX54Ed058XUF03AUiYkxtM4V3SZHMSH7Jwa8zIfOgNd7j/a1lr6glOVqaW/msODPY0raRL2seZU4R6hT0/dvBZHVW52U34ypGCKqCCFUfdkJVhmj4pHAhO19xPszwtsrPV3IUr4C4Uw6Kcxk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjycmu0S/wsNlSbN/Drq8W2VRjAaB1dMgaPEczuAvN8=;
 b=dkmlNPWRL3yTyd8atrujTWH30jyKTL6zRs0x2vCLvdaJVGfpLDj1TklMybyQ8/J2Mr72vnQvdM6wKfZSErBzxJN+kWPl790yz/I+kDOanFJrdEOOALqjRDKgjuYCIHeRU9QLJLF613aRVtce/662Ffi3wGPC/SjfDnk22qP12gXb66WCnMAxJ7iJS5f9zY3sJbXIZ0H+vLTxJxnflt+P/7DoqtwzDnunNOwYbJfmcqKdBQ6Rk+3toLtmNAdjVBTWA8hLTB6Qll5ySrRV6hNmCrw9SzkRuvjNb+bGITL0gXnrn09yhHHgH6I84YGNdhcn/PKhocu5BIBtpOstCZTG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 06:53:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 06:53:19 +0000
Date: Fri, 10 Jan 2025 14:53:08 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-aio@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z35VVvuT0nl0iDfd@ryzen>
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a16548-8ed3-4461-bfe9-08dd31437723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2c4ObL8ZnuTeVEGdWATke+SBkJXXgbUggBYRhVJz7nU5wVwS3xNOFVHlrR?=
 =?iso-8859-1?Q?ZTRQPrhR4pOJh4ywYZp6CCdOgx4J+dw0KKJ4R7Oa/Uf/D4WLFtHLfybzm8?=
 =?iso-8859-1?Q?odAfzVYrXtYxcoZgZ/aKx5qqjj8bx3u+rPmkdWNUBEf1pwdxF9Pc858OYo?=
 =?iso-8859-1?Q?46iRnudTFLbJtOoncPG1J5uox5lL1CLm/rc5s+7KAsFVzKyUwVdoWZxZE+?=
 =?iso-8859-1?Q?N+A+8hgNvk/vqeRlVqfGGFOwFXn7fylhGv7lJauHt+J8vdUF8gZdr5khLJ?=
 =?iso-8859-1?Q?pq9tzAyQT8F5YzY+XbqVW80MlsjadnWEW+nkkEwSnQpdVD1Cb4I8E8rGXy?=
 =?iso-8859-1?Q?Gp5M7GyYXWUAgTqpObS+iLkUh2jL+mnt6y3yz7PWSDjc3KPZaWbfOeuAxC?=
 =?iso-8859-1?Q?vmWVdffFOkbeifKIJVWUAtal33VHSFmB8nNE2CEwI25HSHqnh/avdQv0Up?=
 =?iso-8859-1?Q?4IJ3ZY3h3pOZE2hU9KKzo51MoRQY/8FN/qW+I4Le6KoagwTVjNgV1No2Dm?=
 =?iso-8859-1?Q?dTw3sTTWRJJdH+glmDcP9N/tRo7Qe8okP2WN7svj8YkyNcHGoR9DOGxhaY?=
 =?iso-8859-1?Q?SQxqkx/AdXsrC0fOLsupVPTIpy7ZnqZa6LwqfpPRqjZHRY3HZa5jSiCUXL?=
 =?iso-8859-1?Q?Qr6hvcLJL5pIFEj5ZL1XVlIzSkiZokXCFANpZ4CgluHrGUeiLHvF5uSJ6B?=
 =?iso-8859-1?Q?B0QEnY5O3/hDx14/5F4QEqPm+d7ohnZ/uzsFti5g1mKEOpHeHoC0f7EDU9?=
 =?iso-8859-1?Q?1dFQy21XMR8Zx3LGhLovPexhk6rEzLodgwpThhQcKxTTueA/rwD6FZVxE1?=
 =?iso-8859-1?Q?dl+CurzAgoqWO8uJFSMozvdXhTUWRRdZ6zG6uYX0oudxpWq2A8+8uqpSQE?=
 =?iso-8859-1?Q?WP4bzvlSc+n5xAwiFtOA6aOhHEWfhZD5VbEREwsznUCQT+ZQWs70s1K8/1?=
 =?iso-8859-1?Q?dpCsZ8DNb8Ts4E+YE4aj94xTaT1zuPNTJ8TFC1QI2ct4QLee/GTqD5kVGC?=
 =?iso-8859-1?Q?CCzZWJJ+IlWbR1bfdyXFspsZHS/wlJl3mkVAWayDKktu8biXR7RfdX//gT?=
 =?iso-8859-1?Q?XaNzCjV6T8l0CEU+3gol+9G5T48j5H5uyuFPUpcax7R7achDSpuWU4uU7v?=
 =?iso-8859-1?Q?AFCwQlJZRq/LlY1IGg5i4LKbYQsYKMONjhwSBltWiqYj6DvLJRwln3C8/X?=
 =?iso-8859-1?Q?aryYmEYv0Qur6DYuGOs0UtqJFjC5WOffCzgO1u1wvH6hwB5682EsZjjkvN?=
 =?iso-8859-1?Q?TvllxWKfRHKEsh1K+1ba9gbmkHFoqc/0FAu/zW3uakIth9IUr+9mGvGRfR?=
 =?iso-8859-1?Q?nIaRchFeLC8MIHAYU1FmgxzsAb1CbnGbUhAJu0ZwVbsea/gl4OY3hKgoH8?=
 =?iso-8859-1?Q?soDO1zZLol7u2dtxxPHvaQ1C82zHLi6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8BiWD18HTIt0RKartncy+WtP+kI2anI4EWJfJRwwoYzlqWivKBroTaqPBZ?=
 =?iso-8859-1?Q?sC25TebRKAHse55lx9szJYXpBbQQ3aGQknxEBBpw2rwRpCGNB4f18lBFmG?=
 =?iso-8859-1?Q?EHPSxB2iqQyu6BqvtdTJuwm5lW9BYlRBcsnMCqduNe1+TEvRwyHmnzqJxp?=
 =?iso-8859-1?Q?ndVc2RoOskasiY/c0TrHP4dBaYWiGfYMbOBcySj74ynpvhf8KTSvumM8sH?=
 =?iso-8859-1?Q?APHYkXHWwL3sBqwUnG441EPNbKsgAYJte0OT2G9ume6zwLxWuAikhuLXWM?=
 =?iso-8859-1?Q?pjAYy1p4+5RvQ5BTkZCt6DBd0tZsxXurh5hBzfMZdnN0qYUwAT9aZNFTKY?=
 =?iso-8859-1?Q?O2ii4tUZFi6nHDLZ/4rD27aLUjKxIyiKR2VP+0lVBbMgs7jUwdCNkWCngZ?=
 =?iso-8859-1?Q?5CbBiS0Lvb8rdZW8DEo2M+WYr4siy3tBV280deaPcCPuNVcf5DhFmoNVWy?=
 =?iso-8859-1?Q?tz16CNuqghuX+4uyhFXiRyws+pYG2rsCnbXaglTU32pVgw0r1DvvGlJ2G7?=
 =?iso-8859-1?Q?AR3A8mmi6j2K6naVwT+u75tJEKcNai0VZfF8Nst9ExnQr61aUn5f5wU/hK?=
 =?iso-8859-1?Q?d1PEKIs/CwrUcZqK2Nv1HSKM1+goV9wpKb5967aD+Ewh53H6pq682ei9tI?=
 =?iso-8859-1?Q?9S4Y+4gPH0mEvfDi62YOv+/lx0LNXT7pwikImvyurOg7la2e/XIlGKyZQ+?=
 =?iso-8859-1?Q?p30zEADPXtmN1zABtxa+IsUMXuHm1x0NqZDlfopgDqVVnarI3vfHmLvXgP?=
 =?iso-8859-1?Q?X2UXj54oZhguZpiWZ3UoZZSpydus9i3ZnAGgs9Zxx6exS0/SM/uRevpr/x?=
 =?iso-8859-1?Q?v5G/4oL2YVM4E7mRw/pCwR7TuQk+Rm7kXtnMCuw/LjLSrlWYCoCKhkoQYk?=
 =?iso-8859-1?Q?iBQ5opTeOv8vzTbKE/X+N6HDuPYE7FCeuuJGXkx61dy+YMm0EONZwkGOFd?=
 =?iso-8859-1?Q?pQ8hnat8J4dD2ulsJPav1cB8oRp8/VV1yfU+tGdfLvXTmJzKCojsSzhT/b?=
 =?iso-8859-1?Q?0A4LXaF33yvq+7UzR7+OGaE7lxQyDvVT1jamShCOOw0lInfhUBI4Bm7HEr?=
 =?iso-8859-1?Q?e5iaTzmytdJ3HJHeoBOLO8pdMHMmlQ4UTK+GzEYDuxhjMgv1EGZAZutg/m?=
 =?iso-8859-1?Q?WKaacsI3vB6hTxWVBPY1sedbjWw0IdMDqOge8aujF1unFvCWfFNbLImHHz?=
 =?iso-8859-1?Q?w0OxNMueSxTrIiiC5QfLmn/ZCdQf4syNzWSxwcFLJ1DHzafOZAPA29i1HQ?=
 =?iso-8859-1?Q?z0vkvURP31AesWOpZk9xeT7wo1I4agb+qKjdt17Lvs0MpotNnr6QM9F0Gn?=
 =?iso-8859-1?Q?JWTrvtMIr6+A3LFBuFcWpjlYMu88uLAB5/9FbijSt51/cMUcX7ShBmGrb9?=
 =?iso-8859-1?Q?poLmF06UvJMcjuZc7qVSp9CbsFy3zgOug7VBJcJqLWY+EGt209IAUafiUT?=
 =?iso-8859-1?Q?dlYQ7Z73tisLxG7NL0ybwG3j9uLJ8rhcpfqwCt1zeo3pX++0QZbc74ZJtv?=
 =?iso-8859-1?Q?hQsHMQoDTokapo8L7MwOjfseBQj1UEg7TH2ysR3h2bgqRlpuqqKkTG4wW7?=
 =?iso-8859-1?Q?XhK6uZyiKPUaVfDX5MpDj6Hvrg+hdgHxO9DkbnOdLisPJcKi6+5VFVHmmA?=
 =?iso-8859-1?Q?RdyNMt5/qzxQZQ0Y/JPbbGEIMKCAi6IR7wJKssI1EUd+k8p6xaxUDuhw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a16548-8ed3-4461-bfe9-08dd31437723
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:53:19.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7KLV1FahuWIusyT4e36yERt54ilwOx4DzulWo4E1A1g+arSw5hUYHK1y9cma1HBNNB6t6ymRpzin3YJjmHmyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com

hi, Niklas,

On Wed, Jan 08, 2025 at 11:39:28AM +0100, Niklas Cassel wrote:
> On Tue, Jan 07, 2025 at 04:27:44PM +0800, Oliver Sang wrote:
> > hi, Niklas,
> > 
> > On Fri, Jan 03, 2025 at 10:09:14AM +0100, Niklas Cassel wrote:
> > > On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> > > > On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > > > > please let us know. thanks a lot!
> > > > > > 
> > > > > > Yes, this looks like ahci.  Thanks a lot!
> > > > > 
> > > > > Did this ever get resolved?
> > > > > 
> > > > > I haven't seen a patch that seems to address this.
> > > > > 
> > > > > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > > > > reordering when issuing a batch of commands, my guess is that the problem
> > > > > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > > > > or block layer.
> > > > 
> > > > I started looking into this before the holidays.  blktrace shows perfectly
> > > > sequential writes without any reordering using ahci, directly on the
> > > > block device or using xfs and btrfs when using dd.  I also started
> > > > looking into what the test does and got as far as checking out the
> > > > stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> > > > submission does simple reads and writes using increasing offsets.
> > > > So if the test result isn't a fluke either the aio code does some
> > > > weird reordering or btrfs does.
> > > > 
> > > > Oliver, did the test also show any interesting results on non-btrfs
> > > > setups?
> > > > 
> > > 
> > > One thing that came to mind.
> > > Some distros (e.g. Fedora and openSUSE) ship with an udev rule that sets
> > > the I/O scheduler to BFQ for single-queue HDDs.
> > > 
> > > It could very well be the I/O scheduler that reorders.
> > > 
> > > Oliver, which I/O scheduler are you using?
> > > $ cat /sys/block/sdb/queue/scheduler 
> > > none mq-deadline kyber [bfq]
> > 
> > while our test running:
> > 
> > # cat /sys/block/sdb/queue/scheduler
> > none [mq-deadline] kyber bfq
> 
> The stddev numbers you showed is all over the place, so are we certain
> if this is a regression caused by commit e70c301faece ("block:
> don't reorder requests in blk_add_rq_to_plug") ?
> 
> Do you know if the stddev has such big variation for this test even before
> the commit?

in order to address your concern, we rebuild kernels for e70c301fae and its
parent a3396b9999, also for v6.12-rc4. the config is still same as shared
in our original report:
https://download.01.org/0day-ci/archive/20241212/202412122112.ca47bcec-lkp@intel.com/config-6.12.0-rc4-00120-ge70c301faece

(
ok, with a small diff

@@ -19,7 +19,7 @@ CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
 CONFIG_TOOLS_SUPPORT_RELR=y
 CONFIG_CC_HAS_ASM_INLINE=y
 CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
-CONFIG_PAHOLE_VERSION=127
+CONFIG_PAHOLE_VERSION=128
 CONFIG_IRQ_WORK=y
 CONFIG_BUILDTIME_TABLE_SORT=y
 CONFIG_THREAD_INFO_IN_TASK=y

but anyway, the configs for e70c301fae, a3396b9999 and v6.12-rc4 for runs this
time are same
)

then we rerun tests more times than before. (normally we run tests for each
commit 6 times at least, this time, 15 times for each commit. but due to our
bot run some tests more times for various purpose, so we got 16 results for
a3396b9999 and 24 results for v6.12-rc4).

summary results are as below:

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

commit:
  v6.12-rc4
  a3396b9999 ("block: add a rq_list type")
  e70c301fae ("block: don't reorder requests in blk_add_rq_to_plug")

       v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    187.64 ±  5%      -0.6%     186.48 ±  7%     -47.6%      98.29 ± 17%  stress-ng.aiol.ops_per_sec

yes, the %stddev is not small, which means the data is not very stable, but
still much better than ext4 or xfs I shared in another mail.

a3396b9999 has very similar results as v6.12-rc4, both stress-ng.aiol.ops_per_sec
score and %stddev, e70c301fae has even bigger %stddev, but since the %change is
bigger, we still think the data is valid.

also list the raw data as below FYI.

e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json:  "stress-ng.aiol.ops_per_sec": [
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    112.31,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    76.2,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    111.71,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    109.43,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    106.02,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    101.38,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    109.94,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    103.79,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    116.88,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    61.9,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    104.32,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    100.19,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    87.52,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    64.11,
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-    108.66
e70c301faece15b618e54b613b1fd6ece3dd05b4/matrix.json-  ],


a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json:  "stress-ng.aiol.ops_per_sec": [
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    175.57,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    182.85,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    192.2,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    191.0,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    178.72,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    174.45,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    196.39,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    196.96,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    142.27,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    196.54,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    193.73,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    193.85,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    194.63,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    184.75,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    196.38,
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-    193.44
a3396b99990d8b4e5797e7b16fdeb64c15ae97bb/matrix.json-  ],


v6.12-rc4/matrix.json:  "stress-ng.aiol.ops_per_sec": [
v6.12-rc4/matrix.json-    193.49,
v6.12-rc4/matrix.json-    185.16,
v6.12-rc4/matrix.json-    187.78,
v6.12-rc4/matrix.json-    187.25,
v6.12-rc4/matrix.json-    193.65,
v6.12-rc4/matrix.json-    195.93,
v6.12-rc4/matrix.json-    194.48,
v6.12-rc4/matrix.json-    190.68,
v6.12-rc4/matrix.json-    195.61,
v6.12-rc4/matrix.json-    188.66,
v6.12-rc4/matrix.json-    181.88,
v6.12-rc4/matrix.json-    195.75,
v6.12-rc4/matrix.json-    187.21,
v6.12-rc4/matrix.json-    194.72,
v6.12-rc4/matrix.json-    159.46,
v6.12-rc4/matrix.json-    188.29,
v6.12-rc4/matrix.json-    189.42,
v6.12-rc4/matrix.json-    194.79,
v6.12-rc4/matrix.json-    192.25,
v6.12-rc4/matrix.json-    153.43,
v6.12-rc4/matrix.json-    196.16,
v6.12-rc4/matrix.json-    168.24,
v6.12-rc4/matrix.json-    193.78,
v6.12-rc4/matrix.json-    195.33
v6.12-rc4/matrix.json-  ],


the full comparison is as beloe [1] FYI.

> 
> 
> If it is not too much to ask... It might be interesting to know if we see
> a regression when comparing before/after e70c301faece with scheduler none
> instead of mq-deadline.

ok, we can do this. but due to resource constraint and our current priority,
please don't expect that we can supply results soon. thanks

> 
> 
> Kind regards,
> Niklas
> 


[1]
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

commit:
  v6.12-rc4
  a3396b9999 ("block: add a rq_list type")
  e70c301fae ("block: don't reorder requests in blk_add_rq_to_plug")

       v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    642.17 ± 27%     -14.3%     550.12 ± 39%     -56.2%     281.53 ± 47%  perf-c2c.HITM.local
     45.74            +0.1%      45.79 ±  2%     -10.1%      41.12 ±  2%  iostat.cpu.idle
     53.09            -0.2%      52.99            +8.9%      57.80        iostat.cpu.iowait
     44.17 ±  2%      +0.0       44.20 ±  2%      -4.8       39.36 ±  2%  mpstat.cpu.all.idle%
      0.46 ±  4%      +0.0        0.48 ±  9%      -0.1        0.32 ±  8%  mpstat.cpu.all.sys%
     14022 ± 33%      +5.7%      14817 ± 21%     -57.5%       5953 ± 15%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      3698 ± 32%     +11.6%       4126 ± 30%     -63.0%       1367 ± 27%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
     14683 ±  5%      -0.2%      14651 ±  7%     -46.3%       7886 ± 17%  vmstat.io.bi
     16122 ±  5%      -0.2%      16087 ±  7%     -45.4%       8796 ± 16%  vmstat.io.bo
      7237 ± 22%      -7.4%       6699 ± 20%     -54.5%       3295 ± 22%  meminfo.Dirty
     24305 ± 15%      -1.1%      24025 ± 17%     -40.6%      14427 ± 14%  meminfo.Inactive
     24305 ± 15%      -1.1%      24025 ± 17%     -40.6%      14427 ± 14%  meminfo.Inactive(file)
   1997820 ±  6%      -1.2%    1974059 ±  7%     -47.9%    1040100 ± 16%  time.file_system_inputs
   2008181 ±  6%      -1.2%    1984688 ±  7%     -47.5%    1054950 ± 16%  time.file_system_outputs
      1893 ±  9%      -2.6%       1844 ±  8%     -25.9%       1403 ± 14%  time.involuntary_context_switches
      0.37 ±  6%      +2.6%       0.38 ±  9%     -42.9%       0.21 ± 14%  time.user_time
    125.95 ±  5%      -0.6%     125.18 ±  7%     -47.2%      66.52 ± 17%  stress-ng.aiol.async_I/O_events_completed_per_sec
     11574 ±  6%      -1.2%      11430 ±  7%     -48.5%       5955 ± 17%  stress-ng.aiol.ops
    187.64 ±  5%      -0.6%     186.48 ±  7%     -47.6%      98.29 ± 17%  stress-ng.aiol.ops_per_sec
   1997820 ±  6%      -1.2%    1974059 ±  7%     -47.9%    1040100 ± 16%  stress-ng.time.file_system_inputs
   2008181 ±  6%      -1.2%    1984688 ±  7%     -47.5%    1054950 ± 16%  stress-ng.time.file_system_outputs
      4333 ± 24%     -10.5%       3877 ± 20%     -57.2%       1853 ± 19%  numa-meminfo.node0.Dirty
     14414 ± 15%      -5.4%      13632 ± 20%     -44.4%       8019 ± 19%  numa-meminfo.node0.Inactive
     14414 ± 15%      -5.4%      13632 ± 20%     -44.4%       8019 ± 19%  numa-meminfo.node0.Inactive(file)
      2916 ± 22%      -2.9%       2833 ± 24%     -50.7%       1439 ± 28%  numa-meminfo.node1.Dirty
      9940 ± 18%      +4.8%      10419 ± 17%     -35.0%       6462 ± 21%  numa-meminfo.node1.Inactive
      9940 ± 18%      +4.8%      10419 ± 17%     -35.0%       6462 ± 21%  numa-meminfo.node1.Inactive(file)
      1.15 ±  4%      -1.0%       1.14 ±  3%     +17.0%       1.35 ±  6%  perf-stat.i.MPKI
  14638106 ±  3%      +1.9%   14923264 ±  3%     -10.8%   13053409 ±  8%  perf-stat.i.cache-references
      4.25 ±  4%      +0.0        4.27            +0.4        4.63 ±  2%  perf-stat.overall.branch-miss-rate%
      0.95            +0.7%       0.95 ±  2%      -4.8%       0.90        perf-stat.overall.cpi
      1.06            -0.6%       1.05 ±  2%      +5.0%       1.11        perf-stat.overall.ipc
  14448948 ±  3%      +2.0%   14733547 ±  3%     -10.8%   12885674 ±  8%  perf-stat.ps.cache-references
 3.675e+08 ± 23%     -12.5%  3.215e+08 ± 38%    +119.8%  8.077e+08 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.avg
 8.117e+08 ± 23%     -14.5%  6.942e+08 ± 38%    +111.1%  1.714e+09 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.max
 2.135e+08 ± 23%     -11.3%  1.893e+08 ± 38%     +94.6%  4.155e+08 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
 3.675e+08 ± 23%     -12.5%  3.215e+08 ± 38%    +119.8%  8.077e+08 ± 14%  sched_debug.cfs_rq:/.min_vruntime.avg
 8.117e+08 ± 23%     -14.5%  6.942e+08 ± 38%    +111.1%  1.714e+09 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
 2.135e+08 ± 23%     -11.3%  1.893e+08 ± 38%     +94.6%  4.155e+08 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
     10720 ± 16%      -7.9%       9870 ± 19%     -48.9%       5475 ± 18%  numa-vmstat.node0.nr_dirtied
      1086 ± 24%     -10.6%     972.03 ± 20%     -57.2%     464.99 ± 19%  numa-vmstat.node0.nr_dirty
    124767 ± 19%      +8.2%     134943 ± 25%     -48.8%      63821 ± 25%  numa-vmstat.node0.nr_foll_pin_acquired
    124590 ± 19%      +8.1%     134739 ± 25%     -48.9%      63722 ± 25%  numa-vmstat.node0.nr_foll_pin_released
      3627 ± 14%      -5.5%       3428 ± 20%     -44.5%       2014 ± 19%  numa-vmstat.node0.nr_inactive_file
      6842 ± 18%      -5.7%       6453 ± 27%     -44.0%       3829 ± 23%  numa-vmstat.node0.nr_written
      3627 ± 14%      -5.5%       3428 ± 20%     -44.5%       2014 ± 19%  numa-vmstat.node0.nr_zone_inactive_file
      1101 ± 23%     -10.6%     985.18 ± 20%     -57.1%     472.33 ± 18%  numa-vmstat.node0.nr_zone_write_pending
    728.88 ± 22%      -2.4%     711.19 ± 24%     -50.5%     361.14 ± 28%  numa-vmstat.node1.nr_dirty
    132261 ± 21%     -13.7%     114207 ± 24%     -50.6%      65275 ± 24%  numa-vmstat.node1.nr_foll_pin_acquired
    132076 ± 21%     -13.7%     114026 ± 24%     -50.7%      65176 ± 24%  numa-vmstat.node1.nr_foll_pin_released
      2502 ± 18%      +4.9%       2624 ± 17%     -35.1%       1623 ± 21%  numa-vmstat.node1.nr_inactive_file
      2502 ± 18%      +4.9%       2624 ± 17%     -35.1%       1623 ± 21%  numa-vmstat.node1.nr_zone_inactive_file
    738.83 ± 22%      -2.5%     720.39 ± 24%     -50.4%     366.25 ± 28%  numa-vmstat.node1.nr_zone_write_pending
     17946 ± 11%      -1.0%      17775 ± 16%     -43.7%      10111 ± 19%  proc-vmstat.nr_dirtied
      1813 ± 22%      -7.4%       1679 ± 20%     -54.6%     823.72 ± 22%  proc-vmstat.nr_dirty
    256770 ± 14%      -3.1%     248901 ± 13%     -49.7%     129104 ± 12%  proc-vmstat.nr_foll_pin_acquired
    256411 ± 14%      -3.1%     248510 ± 13%     -49.7%     128908 ± 12%  proc-vmstat.nr_foll_pin_released
      6098 ± 14%      -1.3%       6022 ± 17%     -40.6%       3623 ± 14%  proc-vmstat.nr_inactive_file
     47060            -0.1%      47015            -2.7%      45813        proc-vmstat.nr_slab_unreclaimable
     11219 ± 16%      +1.6%      11404 ± 24%     -38.2%       6928 ± 25%  proc-vmstat.nr_written
      6098 ± 14%      -1.3%       6022 ± 17%     -40.6%       3623 ± 14%  proc-vmstat.nr_zone_inactive_file
      1838 ± 22%      -7.4%       1702 ± 20%     -54.6%     834.16 ± 22%  proc-vmstat.nr_zone_write_pending
    420018            +0.2%     420980            -3.6%     404817        proc-vmstat.numa_hit
    353786            +0.3%     354765 ±  2%      -4.3%     338592 ±  2%  proc-vmstat.numa_local
    464103            +0.3%     465694            -4.0%     445644        proc-vmstat.pgalloc_normal
   1000691 ±  6%      -1.2%     989162 ±  7%     -47.8%     522520 ± 17%  proc-vmstat.pgpgin
   1094318 ±  6%      -1.0%    1083461 ±  8%     -46.7%     582829 ± 16%  proc-vmstat.pgpgout
     19.24 ± 19%      -2.2       17.01 ± 29%     -10.7        8.50 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
     19.22 ± 19%      -2.2       16.99 ± 29%     -10.7        8.49 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
     15.59 ± 22%      -1.9       13.74 ± 30%      -9.2        6.38 ± 20%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot
     15.21 ± 22%      -1.8       13.44 ± 31%      -8.9        6.32 ± 21%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
     15.16 ± 22%      -1.8       13.40 ± 31%      -8.9        6.29 ± 21%  perf-profile.calltrace.cycles-pp.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
     15.16 ± 22%      -1.8       13.40 ± 31%      -8.9        6.29 ± 21%  perf-profile.calltrace.cycles-pp.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent
     15.32 ± 22%      -1.7       13.59 ± 30%      -9.0        6.28 ± 20%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node
     11.15 ± 26%      -1.4        9.72 ± 34%      -6.7        4.41 ± 24%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      5.03 ± 15%      -0.5        4.48 ± 24%      -2.9        2.15 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      1.64 ± 19%      -0.3        1.39 ± 29%      -1.0        0.62 ± 42%  perf-profile.calltrace.cycles-pp.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      1.64 ± 19%      -0.3        1.39 ± 29%      -1.0        0.62 ± 42%  perf-profile.calltrace.cycles-pp.down_write.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
      3.07 ± 15%      -0.2        2.82 ± 21%      +2.1        5.21 ± 22%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      1.61 ± 20%      -0.2        1.37 ± 29%      -1.0        0.58 ± 52%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent
      1.63 ± 18%      -0.2        1.39 ± 27%      -1.1        0.56 ± 52%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_search_slot
      3.10 ± 14%      -0.2        2.86 ± 21%      +2.2        5.26 ± 22%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.39 ± 21%      -0.2        2.17 ± 29%      +1.4        3.78 ± 21%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
      2.27 ± 15%      -0.2        2.08 ± 22%      +1.7        3.94 ± 21%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.worker_thread.kthread
      2.24 ± 16%      -0.2        2.06 ± 21%      +1.7        3.91 ± 21%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.worker_thread
      1.25 ± 15%      -0.2        1.10 ± 33%      +0.9        2.15 ± 22%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work
      2.84 ± 15%      -0.1        2.70 ± 22%      +2.0        4.82 ± 23%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw
      2.34 ± 17%      -0.1        2.20 ± 26%      +1.7        4.05 ± 23%  perf-profile.calltrace.cycles-pp.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk
      2.81 ± 15%      -0.1        2.67 ± 22%      +2.0        4.78 ± 23%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio
      2.82 ± 15%      -0.1        2.68 ± 22%      +2.0        4.79 ± 23%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter
      2.28 ± 17%      -0.1        2.18 ± 26%      +1.8        4.03 ± 23%  perf-profile.calltrace.cycles-pp.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck
      1.72 ± 15%      -0.1        1.65 ± 22%      +1.4        3.10 ± 21%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task
      1.69 ± 15%      -0.1        1.62 ± 22%      +1.4        3.05 ± 21%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      0.99 ± 11%      -0.1        0.92 ± 27%      +0.3        1.29 ± 15%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.04 ± 11%      -0.1        0.98 ± 27%      +0.3        1.37 ± 15%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.87 ± 15%      -0.1        1.81 ± 26%      +1.4        3.29 ± 21%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule
      1.88 ± 12%      -0.1        1.83 ± 21%      +1.3        3.16 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_direct_write.btrfs_do_write_iter
      1.88 ± 12%      -0.0        1.83 ± 21%      +1.3        3.15 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_direct_write
      1.53 ± 15%      -0.0        1.48 ± 23%      +1.2        2.76 ± 21%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      0.64 ± 80%      +0.1        0.70 ± 70%      +1.3        1.95 ± 27%  perf-profile.calltrace.cycles-pp.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio
      0.41 ±103%      +0.2        0.57 ± 76%      +0.8        1.17 ± 15%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     46.71 ±  8%      +0.7       47.37 ± 20%     -13.4       33.31 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     46.71 ±  8%      +0.7       47.37 ± 20%     -13.4       33.31 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     46.71 ±  8%      +0.7       47.37 ± 20%     -13.4       33.31 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     31.82 ± 13%      +0.9       32.73 ± 36%     -14.2       17.66 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
     31.74 ± 13%      +0.9       32.66 ± 36%     -14.1       17.59 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
     22.58 ± 17%      -2.4       20.19 ± 26%     -12.0       10.53 ± 15%  perf-profile.children.cycles-pp.btrfs_search_slot
     19.26 ± 19%      -2.2       17.02 ± 29%     -10.7        8.51 ± 17%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
     18.23 ± 19%      -2.0       16.20 ± 28%     -10.4        7.78 ± 17%  perf-profile.children.cycles-pp.btrfs_tree_lock_nested
     18.28 ± 19%      -2.0       16.26 ± 27%     -10.4        7.85 ± 17%  perf-profile.children.cycles-pp.down_write
     18.06 ± 19%      -2.0       16.07 ± 28%     -10.3        7.72 ± 17%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     17.92 ± 19%      -2.0       15.95 ± 28%     -10.3        7.64 ± 17%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     16.20 ± 21%      -1.8       14.40 ± 30%      -9.3        6.88 ± 19%  perf-profile.children.cycles-pp.btrfs_lock_root_node
     11.86 ± 24%      -1.4       10.46 ± 32%      -7.0        4.87 ± 21%  perf-profile.children.cycles-pp.osq_lock
      5.44 ± 13%      -0.5        4.94 ± 22%      -3.0        2.49 ± 14%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.63 ± 11%      -0.3        3.31 ± 21%      -1.2        2.43 ± 18%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.61 ± 10%      -0.3        2.34 ± 22%      -0.9        1.74 ± 23%  perf-profile.children.cycles-pp.__memmove
      6.25 ±  9%      -0.2        6.01 ± 16%      +2.7        8.90 ± 10%  perf-profile.children.cycles-pp.__schedule
      4.94 ±  5%      -0.2        4.71 ± 15%      +1.1        6.03 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
      3.13 ± 11%      -0.2        2.93 ± 19%      +1.4        4.56 ± 16%  perf-profile.children.cycles-pp.sched_balance_rq
      5.29 ± 10%      -0.2        5.09 ± 16%      +2.3        7.61 ± 13%  perf-profile.children.cycles-pp.schedule
      3.66 ± 12%      -0.2        3.48 ± 18%      +1.7        5.38 ± 15%  perf-profile.children.cycles-pp.__pick_next_task
      3.48 ± 13%      -0.2        3.30 ± 19%      +1.7        5.14 ± 16%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.70 ± 18%      -0.2        1.53 ± 26%      -0.7        0.95 ± 30%  perf-profile.children.cycles-pp.btrfs_del_items
      2.77 ± 10%      -0.2        2.61 ± 19%      +1.4        4.15 ± 18%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      3.10 ± 13%      -0.2        2.93 ± 19%      +1.6        4.69 ± 18%  perf-profile.children.cycles-pp.sched_balance_newidle
      1.20 ± 14%      -0.2        1.04 ± 21%      -0.5        0.65 ± 24%  perf-profile.children.cycles-pp.btrfs_set_token_32
      2.73 ± 10%      -0.2        2.58 ± 19%      +1.4        4.10 ± 18%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.85 ± 15%      -0.1        2.70 ± 22%      +2.0        4.82 ± 23%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      2.82 ± 15%      -0.1        2.68 ± 22%      +2.0        4.78 ± 23%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      2.26 ± 20%      -0.1        2.12 ± 22%      -1.0        1.28 ± 23%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      2.82 ± 15%      -0.1        2.69 ± 22%      +2.0        4.79 ± 23%  perf-profile.children.cycles-pp.__submit_bio
      2.55 ± 11%      -0.1        2.41 ± 19%      +1.2        3.78 ± 18%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.97 ± 12%      -0.1        1.85 ± 17%      +0.8        2.75 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.34 ± 17%      -0.1        2.23 ± 22%      +1.7        4.05 ± 23%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.82 ± 14%      -0.1        0.71 ± 30%      -0.2        0.57 ± 22%  perf-profile.children.cycles-pp.read_block_for_search
      0.69 ± 19%      -0.1        0.59 ± 26%      -0.3        0.40 ± 16%  perf-profile.children.cycles-pp.up_write
      1.31 ± 17%      -0.1        1.22 ± 22%      +1.0        2.30 ± 23%  perf-profile.children.cycles-pp.handle_edge_irq
      1.26 ± 17%      -0.1        1.18 ± 22%      +1.0        2.23 ± 23%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      1.25 ± 17%      -0.1        1.18 ± 22%      +1.0        2.23 ± 23%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      1.36 ± 17%      -0.1        1.29 ± 22%      +1.1        2.42 ± 22%  perf-profile.children.cycles-pp.__sysvec_posted_msi_notification
      1.30 ± 17%      -0.1        1.22 ± 22%      +1.0        2.29 ± 22%  perf-profile.children.cycles-pp.handle_irq_event
      2.29 ± 17%      -0.1        2.22 ± 22%      +1.8        4.04 ± 23%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.60 ± 18%      -0.1        0.53 ± 21%      -0.2        0.39 ± 24%  perf-profile.children.cycles-pp.aio_complete_rw
      0.90 ± 15%      -0.1        0.84 ± 27%      +0.8        1.65 ± 23%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.51 ± 21%      -0.1        0.45 ± 27%      -0.2        0.28 ± 25%  perf-profile.children.cycles-pp.rwsem_wake
      0.39 ± 21%      -0.1        0.34 ± 21%      -0.2        0.19 ± 35%  perf-profile.children.cycles-pp.pwq_dec_nr_in_flight
      1.15 ± 15%      -0.0        1.10 ± 26%      +0.9        2.08 ± 23%  perf-profile.children.cycles-pp.sbitmap_find_bit
      0.95 ± 15%      -0.0        0.91 ± 21%      +0.3        1.30 ±  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.48 ± 17%      -0.0        0.44 ± 25%      -0.2        0.30 ± 19%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.18 ± 30%      -0.0        0.15 ± 29%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.node_activate_pending_pwq
      0.57 ± 26%      -0.0        0.55 ± 27%      +0.5        1.10 ± 33%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      1.03 ± 20%      -0.0        1.01 ± 24%      +1.0        1.99 ± 25%  perf-profile.children.cycles-pp.io_schedule
      0.57 ± 26%      -0.0        0.55 ± 27%      +0.5        1.11 ± 33%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.58 ± 26%      -0.0        0.56 ± 27%      +0.5        1.11 ± 32%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.89 ± 13%      -0.0        0.87 ± 21%      +0.4        1.25 ± 12%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.09 ± 34%      -0.0        0.08 ± 55%      +0.1        0.19 ± 26%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      1.65 ± 17%      -0.0        1.64 ± 26%      +0.8        2.41 ±  9%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.46 ± 17%      -0.0        0.45 ± 23%      +0.2        0.69 ± 15%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.61 ± 14%      -0.0        0.61 ± 17%      +0.2        0.82 ± 11%  perf-profile.children.cycles-pp.dequeue_entity
      0.56 ± 14%      +0.0        0.57 ± 23%      +0.2        0.78 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.37 ± 16%      +0.0        0.40 ± 33%      +0.2        0.53 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.47 ± 15%      +0.1        0.52 ± 28%      +0.2        0.67 ± 11%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
     46.71 ±  8%      +0.7       47.37 ± 20%     -13.4       33.31 ±  4%  perf-profile.children.cycles-pp.kthread
     46.73 ±  8%      +0.7       47.40 ± 20%     -13.4       33.35 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
     46.74 ±  8%      +0.7       47.41 ± 20%     -13.4       33.36 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
     31.82 ± 13%      +0.9       32.73 ± 36%     -14.2       17.66 ± 12%  perf-profile.children.cycles-pp.btrfs_work_helper
     31.74 ± 13%      +0.9       32.66 ± 36%     -14.2       17.59 ± 12%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      2.44 ± 12%      +3.7        6.16 ±239%      -0.9        1.51 ± 18%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     11.82 ± 24%      -1.4       10.42 ± 32%      -7.0        4.85 ± 21%  perf-profile.self.cycles-pp.osq_lock
      5.31 ± 13%      -0.5        4.82 ± 22%      -2.9        2.44 ± 14%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.59 ± 10%      -0.3        2.33 ± 22%      -0.9        1.73 ± 23%  perf-profile.self.cycles-pp.__memmove
      1.09 ± 14%      -0.1        0.97 ± 21%      -0.5        0.60 ± 27%  perf-profile.self.cycles-pp.btrfs_set_token_32
      1.77 ± 12%      -0.1        1.66 ± 17%      +0.8        2.55 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.23 ± 22%      -0.0        0.19 ± 27%      -0.1        0.10 ± 44%  perf-profile.self.cycles-pp.__set_extent_bit
      0.41 ± 25%      -0.0        0.38 ± 23%      -0.2        0.21 ± 30%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.34 ± 29%      -0.0        0.30 ± 24%      -0.1        0.20 ± 27%  perf-profile.self.cycles-pp.btrfs_get_32
      0.09 ± 40%      -0.0        0.08 ± 59%      +0.1        0.17 ± 33%  perf-profile.self.cycles-pp.fold_diff
      0.25 ± 29%      -0.0        0.25 ± 26%      +0.2        0.46 ± 26%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      2.44 ± 12%      +3.7        6.14 ±239%      -0.9        1.50 ± 18%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



