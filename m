Return-Path: <linux-btrfs+bounces-10760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C297A039C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB90164FA2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36911E0E0A;
	Tue,  7 Jan 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsVUjpZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3141DF27C;
	Tue,  7 Jan 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238399; cv=fail; b=nXwxpqkaGfZjKqcE5Dn/BQM3aHMyzS6LIKskmJ1o2ezz8+7PSznETjkXUddm+Rs/uACvVbgg02plZ5/QBcZ4aCDG3VWHmZJ+FdziBQyroqlu4hb3KErS6GuF0vh1SJVHK1TOUh/yKF2wFwP/4bbFLgBqr1tIyp6RtNunUSclMTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238399; c=relaxed/simple;
	bh=A1/rnTTnv7GueqH00W0EKSBEnHg5l1S7mJ5JTR2VWFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYWF5lMPp3gLDw7Jclyem2yeNIi7RyoogFttWV0V/Adwbg7l7v3mUGAWbYo0oTSay6Qc83L9sgsZ+Ld8DUFO9Uizcm/GhARUbddcJOTpszslZQ92h2TGpVKvs3LeOJmRscAsOgIpTSbpX9D+Oq94n4ylmSZZmnmXMb1aCXjR/Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsVUjpZ1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736238398; x=1767774398;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A1/rnTTnv7GueqH00W0EKSBEnHg5l1S7mJ5JTR2VWFk=;
  b=EsVUjpZ193AB0Kk/TQoM7i//vVOwi511nPXk0liJ/9pNeZMQm/HU1Vnz
   2nHXZmBaQ0z8HjTbNSMs8r9BLZIn8MKiI7NDI5xVqtQH0JNxFwSuDoy/X
   cfaGyV+AdMEpMf3iauR34/f20du6/8X+Py8Txy/vW41x7aFy+1CSZKMqS
   7X4SDKv4/d+tIfItbuSWYRuD3G7SpocFcK303tYz/Yc4f4Kg7WbQ9Yxy0
   E5BKqg6On1GNPbVhKvRYXFce4g1K/LeByUElu7EI9GLtsTb1h0cTxW3oc
   QQbyOCx3m2+r67GUtHAR6lvB9vYkrVq8aQ5s5Yfs+zzORasy7tXIHfKdC
   A==;
X-CSE-ConnectionGUID: D/EJHNWJRtaHE00gq0AzwQ==
X-CSE-MsgGUID: yqqVUGD0RaSvBIXUSPjFNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="24015910"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="24015910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 00:26:30 -0800
X-CSE-ConnectionGUID: fNqT7YDOR5+fIIYQDONtcw==
X-CSE-MsgGUID: LUigxc4ZRtKRIyUxL/wfig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="107568977"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 00:26:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 00:26:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 00:26:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 00:26:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4vuvBOLlbL0MVkI5NAhGTNNHvegNpjG2/aDENavjXGCBQJ1qJTkZ0DL2D5tvBuap/M5ERz53lkYaLMPWDJfuvBuY0r/mskpcIB0vfQMbsqA4Nh9tFbQ+fkvDUgQm9VM0UXkyYyWt8BnPfwsBfY4HtdvtJDq4Ph7GK4QBKTYeVqkTSiolwqvknnb79zky6vhhn+OwG4zBbFhZa6fkQWipsCk5hbpqkxMi2X5cgXpoasKm1pIZEpqp+bR+95P5CjlbISodJxxyZ50CHF1VlzaITuYlxELzur/D1qC1BLtPYHsHBR0H7jYgy//c5TCOzCFmc8gsCRPkFWtLq7HUnjmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh5RC93HZCpSTpTlzZVs/zrzongq4GDtk9HDJ4swzK8=;
 b=M/zKII/0xxbH/x2zzKNpIbFdPc0luJBJ8QWRDQr3MNVvGncNOYkOxx9c/k6/1YPvCuu/pBeC1OCfEn8+znucziKhVccuZ3IXHw6FGM+9hz74VC13rYEvnQfrkE0Jl4iXTAdM6nROAcZrEFtx/ea0LkKqBrWLa+wZCsBsbfZU/NR36nvfQi2mfmk5t0sfBySrjfdiOyYfnIc4v8+7JKvcCF2patH/UcEittSNj5XpQHsOFprCwPSG627B/meyDOWnrfX+G0IaZ58+ECTfIk3nCHT+0Y2uGS5X90N3OnL/fpTznYPMqzbNcodsydraGxSKdkmRLswUBN2cnWx+yxicPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 08:26:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 08:26:16 +0000
Date: Tue, 7 Jan 2025 16:26:05 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: Niklas Cassel <cassel@kernel.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>, "Damien
 Le Moal" <dlemoal@kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-aio@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z3zlHVJ+eo8rf1O+@xsang-OptiPlex-9020>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250103064925.GB27984@lst.de>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d7217-0099-462b-3527-08dd2ef4f448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gZR0pJvsaQxy9URrvQJt9+A0AjEnHztTwPXsfHRy8NWGqkNl//c3jgh55Z?=
 =?iso-8859-1?Q?2K3c4755IEOokyt5W7KeeL54NZ6z7ckMVz5EJW9emJWaamtpav3b776KDO?=
 =?iso-8859-1?Q?YNNMz2RMfu0asJ9gj1jL21t6rh52x/c7nyrB1zkEya+AXuugd+932iNmhp?=
 =?iso-8859-1?Q?IDjoDyt4yBzhBgPro/6Dn1nQpLM6ddjI33jrj3Nfnso5xf4zq04V7wGEBE?=
 =?iso-8859-1?Q?ETzwkI8w3pA5/xbqHaS9ZwglmeZYQr0zV+RqFCKguyO1wIfCbujEFrji/x?=
 =?iso-8859-1?Q?3kBC+85nBgRkyusKcAeCIv15wwdZNcsoAPia72R+3w/flsb/LEC+9D0lRx?=
 =?iso-8859-1?Q?AJQVSE4bVZ7Jw5NOhju7MzoczkYqjO0Ll9RzKQ8VUbWPc6bwfu6SmiH0Di?=
 =?iso-8859-1?Q?RQMwwqUoDP20SBW2skDD4oGyeWwjl+/pEZFNE9veieL/SOJIOE5Z/IM0hM?=
 =?iso-8859-1?Q?iyTpOu/j8UTFN7z5r3QMRWPENksSLJZd8jsxkq+YS7REISfb0vI/uayclp?=
 =?iso-8859-1?Q?KvxbNqGRaYtpuH1h4NCOgxqjA07bUId6LOemF70HUFm+JVRnIFZAwp7shw?=
 =?iso-8859-1?Q?LFp892KJp+TlWStx43Vo5cWs0lWi+Ly40oX6bKUghnXcILBAISfwby4OnB?=
 =?iso-8859-1?Q?ryW3eUKPFYp/3EYC/8S0/EXSSKTGIoG9tp/Ry/gFceouK52PqXoszGOroS?=
 =?iso-8859-1?Q?QgNFRNbRh85rZNv+IxOt/511fz5Sd8mvcI4OUfOWob/sTAscRiNEhPb85f?=
 =?iso-8859-1?Q?wiWPzDmTVYOBbBKYzkEFJ48RsrBjMl1Qsh/BW8sJqAncFquR4cPvyNxtNO?=
 =?iso-8859-1?Q?Jz9eYIiJzcqrlxtlS0UGA7tBTEOw+WZtFbttHcHGq15RFm4asnrzmzZrKx?=
 =?iso-8859-1?Q?gNKGr1rG3KjQatH/7TCwgAaVAASjQpoxqvpgGVMinNM0lKcNwRRONeExP1?=
 =?iso-8859-1?Q?MR9+WwevSGn0mEgtYVeJQ9a8g1xD+oFoGRvQ0sLwTjAD3IjhfLRFK6HEWD?=
 =?iso-8859-1?Q?8ArarOqgHEMq1Pej4MmOqDciPvCGAv7INNObhKFkUSMcTinuyEGHRnUsUt?=
 =?iso-8859-1?Q?ayQSTNa0UgEaH/SxE7uB04rHfhzF6WBKZhZm6+v0it6iGDqNZQqW+tLx7R?=
 =?iso-8859-1?Q?v7SKGxF1vCOYr7nOf2c751cyONPDeUxpD5v5nzpaZLZzNUOQSIPV2ImQNV?=
 =?iso-8859-1?Q?VldKRQI5y8GZxC7/KctasHdpXUoeUjnRex4qPPJW0A/sXXMFuSJkgsEjPT?=
 =?iso-8859-1?Q?iOPcakx4nPFg+4YzjvpWQTAth+OwZKIPnP03+jYqtIu+LXBJFzfcHAatJU?=
 =?iso-8859-1?Q?2FNUcROtJTyi7pfiASzCPNk5BGlsrvIk3bLVfSdBRp7PP7hMCdmxujDnnS?=
 =?iso-8859-1?Q?GLhyqcKOdyDrJFRgdzOYVEsyTJALmgtFu1JGqGiB+IVAljIhjfklD8GCxu?=
 =?iso-8859-1?Q?r91Edn7+hUpa+4Xu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gQHXfBS+Q74+zYNKpHwd8/RmWgToCBt5l7ZNmLsMccxpa4yxoDkckq+Dxl?=
 =?iso-8859-1?Q?1kLEm8p1YDe0hwrEdvgtOqAKzBs2NcLDEYG/AhP3pjdKdoJVOKr6qv6FVD?=
 =?iso-8859-1?Q?/+7U22xJzL9JwoIp65Pvpko0YODNJS9tntbHxYPaLLUH+upTxhDGR8vC1C?=
 =?iso-8859-1?Q?QjgfaohsPVeFcvqly03IjSUIh00RqDZ5d/BT2IHj72yILorkHG/Qp8JpPz?=
 =?iso-8859-1?Q?qQ9Aroye+c+YkHp5EkLpZ/79qZICT3WkkDTHrUbxzDmPHVvrIrkvDZK0QW?=
 =?iso-8859-1?Q?+kIeZ8Rce3X836rL82sOKl1244NjB/ZtvihE94Eojn77BcDSsmvQI6qsN5?=
 =?iso-8859-1?Q?nBITabiA+U9ucpLXMlDM4AWLlx5Tf3Iu1AvS1J44FXOwNpwaECN7YYGj70?=
 =?iso-8859-1?Q?Rn5uAtMj1q3YQ+d6IxXZQN2VLu8CbAmdZ6EiNT2OWyAy6GV9gG0ATLpr3o?=
 =?iso-8859-1?Q?U1uWBo0NuwmRva7uQAtV2dZELj8ZajeA/Zv8ZnFoizW7MWgEXvA0YMVtwo?=
 =?iso-8859-1?Q?RIIR+4aBOnjXYwhSPE0BvjSyQNAh+54fTKzm3UT0BYOlJh0o8yBqNi/CXq?=
 =?iso-8859-1?Q?nN4bzAtFGRNIhx2tEmIA+KNQ3v1/LsBrM+P+VrY1Xy2NsD3MvPc/QZdnHw?=
 =?iso-8859-1?Q?hk9iyp2trSJUChsdY9Gz2LlFOX5Xh16SEkKCBOzsWlYzCX/YaLokeNy14g?=
 =?iso-8859-1?Q?9L0rlyUdnBXkhbLrsqcJAgRY7vl51RzqWsIB5bcwxVofTsLufVaG9WyITG?=
 =?iso-8859-1?Q?HMuk+eZaPiUgDRuJsf6xI9kWZAz+s/x67xxI9t3MKr9Cb4NnA67prMgMtz?=
 =?iso-8859-1?Q?6esXR9uBYrns4LC4yQ+i5CJXSlcS0T8C8/Y3h8IzGcYlFNBVSrZjzGRwRD?=
 =?iso-8859-1?Q?YqygmdrsV/yLwNNqtaO8i2gWht4P0Xm2LCmjx+FDRmddMtfTyQ75Wc9mi0?=
 =?iso-8859-1?Q?BgP3YXuM8vUuykkAoi90s5LZpmq9hhjfPD5+Qh9Tv65yc9Rttom0iJQn4O?=
 =?iso-8859-1?Q?W13bkALuBANQeMm94ciJiz6wIug7j3MTCWw7bBAEDOsruQHa1NMaqpsdHw?=
 =?iso-8859-1?Q?aeXjbw1F8DhzC93uesywzzafemNs/2E1LU5CVbzOq8d7X8LE2MPD6b/sdI?=
 =?iso-8859-1?Q?vOhpqHwiYKZSvLMdXxkLLyvBJSwwX3SKHNvg6/HfBlDu6J/MRLBxX+zGWP?=
 =?iso-8859-1?Q?gV0bUwqKoY7qdBU8G6Q/mwvCo0WEC4u/dM3Om5xZSH9dKJyLbmkRfca7VK?=
 =?iso-8859-1?Q?dmlqkbnTz0GrBeiqwnjbQ3kyI4Z4PZYSLrT8PZ+UUh1VkkXtb8c6L7AIRL?=
 =?iso-8859-1?Q?fmQzQJ11fsWZ5wA4JXTB/8rWFdl6zFLWL3B6byzLC+F4ZvS3v5MTT51blJ?=
 =?iso-8859-1?Q?XkG9Cc+kBgn9Sc9sNPnFU9tmN677Tq9bNDQGy+YwctCo8whSE03UDef3nT?=
 =?iso-8859-1?Q?2L13jwxSyz5i2vadgmWt4K1oPQbvXc9CHKcfSUURHxGHZVQs0f5fwo8KFy?=
 =?iso-8859-1?Q?/OayXY6V7BoQh9ckW7TflnL6Z2u6Vf0PegT2HvX4bwtQDma7vxCpuWoO4d?=
 =?iso-8859-1?Q?3HWbMkXIlJxQEo94J6vbJP+ISC7ZrKYkgFTUlMNytxGwuMLAYG8S/39DZR?=
 =?iso-8859-1?Q?Bky/hWP9TvTwyMERyiBYTD7CKK5rAI9SLnv90VBid5k40xVE3kTwI87A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d7217-0099-462b-3527-08dd2ef4f448
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 08:26:16.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JsSGjEtp0RkqqSfFXJE423EzDon2Tr1jYtatVQxXNDBO9RdReD8w2G6OgVKellx52wc0L3c7TsV57sXEi91wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com

hi, Christoph Hellwig,

On Fri, Jan 03, 2025 at 07:49:25AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 02, 2025 at 10:49:41AM +0100, Niklas Cassel wrote:
> > > > from below information, it seems an 'ahci' to me. but since I have limited
> > > > knowledge about storage driver, maybe I'm wrong. if you want more information,
> > > > please let us know. thanks a lot!
> > > 
> > > Yes, this looks like ahci.  Thanks a lot!
> > 
> > Did this ever get resolved?
> > 
> > I haven't seen a patch that seems to address this.
> > 
> > AHCI (ata_scsi_queuecmd()) only issues a single command, so if there is any
> > reordering when issuing a batch of commands, my guess is that the problem
> > also affects SCSI / the problem is in upper layers above AHCI, i.e. SCSI lib
> > or block layer.
> 
> I started looking into this before the holidays.  blktrace shows perfectly
> sequential writes without any reordering using ahci, directly on the
> block device or using xfs and btrfs when using dd.  I also started
> looking into what the test does and got as far as checking out the
> stress-ng source tree and looking at stress-aiol.c.  AFAICS the default
> submission does simple reads and writes using increasing offsets.
> So if the test result isn't a fluke either the aio code does some
> weird reordering or btrfs does.
> 
> Oliver, did the test also show any interesting results on non-btrfs
> setups?
> 

I tried to run with ext4 fs [1] and xfs [2], seems not be able to get stable
results (%stddev is too big, even bigger than %change). seems no value from
both tests.


[1]
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

a3396b99990d8b4e e70c301faece15b618e54b613b1
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    142.01 ± 17%      -4.6%     135.55 ± 18%  stress-ng.aiol.async_I/O_events_completed_per_sec
     14077 ± 14%      -3.3%      13617 ± 15%  stress-ng.aiol.ops
    233.95 ± 14%      -3.4%     225.97 ± 15%  stress-ng.aiol.ops_per_sec


[2]
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/xfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

a3396b99990d8b4e e70c301faece15b618e54b613b1
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     11.97 ± 21%     +18.5%      14.19 ± 44%  stress-ng.aiol.async_I/O_events_completed_per_sec
      1498 ± 33%      +9.5%       1640 ± 49%  stress-ng.aiol.ops
     23.45 ± 34%     +10.2%      25.85 ± 52%  stress-ng.aiol.ops_per_sec

