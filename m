Return-Path: <linux-btrfs+bounces-7438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543D95D013
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B36E1C220A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D9199397;
	Fri, 23 Aug 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEEBZI7b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AE19924E;
	Fri, 23 Aug 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423312; cv=fail; b=artWGnAD0Q5rcaGoQpVnq+n688paBe2i6cTEfAIhx3qWgTWMxMKOpwhvaSofvSxSfUR1kf06d5Aq5FkX8MTetl4aClobzwTWyu5nua13NnteS6jeZnZjnnrVPhSxChkIZKxMiztg68gMIJeaWtJg74nptpSJ25XspDFXPuYpqVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423312; c=relaxed/simple;
	bh=+bqXqm8TO/1uAhI6HZz6CP02YMkyTd0DTu6+iA3v+V8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OLSoV4BWRzG6UxdCaTA5O+b8eq73ANSvM7s7AuY+/HZ/wZHeC7jrHeOkK7Io9U3FIa0KtM/u9yMC/nMvbcLu33PRFv3VLRrg9IrVxaCqwgllzUpC9GDOYt/P0jPQvhgawACJ3+SO3bQdQ8brNAC/vOJ8/5TWwoIohHhcRjamqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEEBZI7b; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724423309; x=1755959309;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+bqXqm8TO/1uAhI6HZz6CP02YMkyTd0DTu6+iA3v+V8=;
  b=BEEBZI7bEtRMH76xAU6f+5DJUxgU8OR/CGVfWN5guUVEQ2XuJmsF2xLY
   SA9/GJ7C8ZaaoS736sPQBZ/n7SRsPugm+lmD5C8wkUwFnA2NOtQygQU7q
   UNC+6bLfVTLhbNA0bw1nlOpbZAt8Uo5M/zAHVaa13BZPmeEkfHr6E3F49
   XbRElZrRtiNileTtUSPcqhUyjmNrEqJpJu6X53iNGbHHoa8Zb05RzYl20
   psmC/ASd9q94d5YK/uozyYEryGU73rEjeH478v6WkWaywxFpmb8KsoLDJ
   0n5xnm9mu+xMBxghaIbKkwN49iZ/kH+3rgX0l5LNM4HZ8aGBLcVdcbdkr
   w==;
X-CSE-ConnectionGUID: owFnMNucSoWuTDmZfr78PA==
X-CSE-MsgGUID: 2LVW8dY4QI27F3WOtGkKuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23062359"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23062359"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:28:28 -0700
X-CSE-ConnectionGUID: 0lDiLbkTRASPsC2gRtZr7w==
X-CSE-MsgGUID: ZuNFI1bhSh2ZfLCloTrtkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="66130882"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 07:28:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 07:28:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 07:28:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 07:28:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnSXQUuGZMreaPh0CRZnadBym6pkkk2Y0nPIaA/97qLb5BZg09ftbMtuQsqFK4QbQoFU/YVbsc5oEJDD2tKsXRuWwBTfmBoxltD2peWiccOkPxZmWqEY9m5VFEDqV0YHzHFobv5oAU3q0ykUjnhXV2dMNxDeMoSaTnkSeyaSQer4Q8CpEyW4Ael/KnMuLBTlCTukgY45rI329YFlTAiZbplMUSMzr1X/o5dtM/7brlKGA8tMGz8lN6Edipx9LgYc7mYWG+I/0L2VRPtATVsI/iZVq9qcXEKEvlpkbKgedFIl20wTG+k9KiSuFTR725aTn7z+xI+C7lZ8aOV8qeT6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh3Tn04uXu8EDZC7eVeQWfEsTVJR3oHgAUsh1pDKYqQ=;
 b=sXgXluy9RsU8I2fiHMpHCNWywtymvJCjPimhzJfIS9xDnd6h2I90IDtPM+rveosqGkYQo816kBr4RyLpF4U92TKdGTDjGPYC11vEriouUvOVVLVM92Mw/Eb8MH+nRK3hCULYUlDyl9qJ5tBpm4Ky1QNgp0YClzLV0uyaRibUboii3m8+9B4ImWSxAdFp+yU1w3Bnclc9Ijgr2neP5vNlYYQ2N+QEQyRnvUciEXKusSZNzgjAo8qjvAOkasq/xg53KqgrS+Y6gj6cBieOBFIBmS53t7z+rSou/AXeiBIIshfqOCOe+Cgkk1f1t4Y3344qe52vtAUr5vTeNUQfo0K5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:28:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:28:21 +0000
Date: Fri, 23 Aug 2024 09:28:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Navneet Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 21/25] dax/region: Create resources on sparse DAX
 regions
Message-ID: <66c89c7d2c9ae_1719d294d8@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-21-7c9b96cba6d7@intel.com>
 <9b441d16-703d-4626-8707-29f4fcde2853@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b441d16-703d-4626-8707-29f4fcde2853@intel.com>
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fc5fd1-bcf2-4c22-9a34-08dcc37fd691
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVUrKeBp1F0UaQWH5fPpvIj6socKEvJ000PNWHWb2ZTTqKU7RYNU1NW8mmxg?=
 =?us-ascii?Q?2T5K2w0zGjlivJwxLjEFcMeg8q4zvV+ooutK5HmHEjKkFqbOjKqYqjoP1XfA?=
 =?us-ascii?Q?xkxBxCpt5wcDu5PXPQ3R8X1vA19Cx4lJ5XS1nWXhWBPQi3q8/4OXmCrr8w0D?=
 =?us-ascii?Q?3GuRYJ/oNe+bpaLFqEiiy3F4JcmVDdG5C3VdKgxefG2vfrDhzBXtJMYDm+SS?=
 =?us-ascii?Q?Ai7spu9twb0Ysr7qfUPfMNrZdE+aNlnarQaBQ2M1k3V1ULRrlwdbdEQuTRMz?=
 =?us-ascii?Q?AXeVO5DoXGjmeF9Ou58u96Fh99XxeO/6D41JBdMI3ozKVxiA5HrryvqYyv4G?=
 =?us-ascii?Q?QEb03GVnp6xCyiPCiZh39SPhpcrPThnBsous8GCIaa+qndAActmKl59wp6HH?=
 =?us-ascii?Q?9lQ/Pa1MrMmVtOLvO8f88x7hF/oPSKzp38vSDgFAB1NJUYJQCXGTzY8FayPb?=
 =?us-ascii?Q?y8LdxNW2lVlkMCMp4FGGEEyS+WEZ+TkzjWToZP9oK3ho3ANqoOV1yZpYXabo?=
 =?us-ascii?Q?dq2AhAstVes8S0PbgxuqxpzpCgVJ3AiD45E+U7a/zkkGRpmzfUwN6qP77Bt9?=
 =?us-ascii?Q?uNyHlGfSUqkMq1lK2sNvTstCLvlCcmPvaiuPSh3qVGKgHqHnvlL16ir5B2bW?=
 =?us-ascii?Q?+vfxmY41LB3S11MYyYhtz59XU4X4rjR9539/W+qhyemwLTKZA9QX7NIvtc2Z?=
 =?us-ascii?Q?jZcRUIQGftL9YyAucO3BYHVmomMCuoSadhpcMkz/aWOrqVlkC98+wzKtV7J8?=
 =?us-ascii?Q?zkVTtrXcMLJ6ot+eE0EM9YFBEnDl3EFTK5wvydfbkJDW2YoICTlUTBk0psBM?=
 =?us-ascii?Q?sBXXmGc4fBvioihYQ7qmB8VkAIySyw9g3DTa7RN7KIhFHF/1AuthPcAg5IE6?=
 =?us-ascii?Q?MA3YwIEdsLC5P7sDF2+6o3ItHfdAcUQtZx2ije1s9Px0zxPjlHhWqStwuXjl?=
 =?us-ascii?Q?bWYVCKUQqA8BarQARrXHhxH2WqG4kogL0HYYqJFsXV7o+mWVMziuM8y5j8pl?=
 =?us-ascii?Q?F1h6TdZ5I4Uxo/taBM/BZfZBz93MydpPcOTjpA58mWezGEFZBQXJXjDkk5wW?=
 =?us-ascii?Q?WMNcUvci+eRV9cOCUFzpIoTnVOXht8XvO6DDMCGwxygTWldy951V6Y6X9/jE?=
 =?us-ascii?Q?aaSdZEfnMufmK4cOVQZQC87dC2cnXc+6eP618pT8wUC2DEvrrlAPet7kCK2T?=
 =?us-ascii?Q?5b82s9WJtVYBzld0gUDHHDG/+9CNPNRmSa1bCptKXjDfEQu6jepAIhER312J?=
 =?us-ascii?Q?yKpzHfnV2VbDaaQK8cE/b5Z6nGyqSXIM7X0iU+ExF2tzC11Ms9/Y0nG2w8ME?=
 =?us-ascii?Q?EY+xVkkgN83bMuGrqXchjg5WYTjpljb64JUGyUj64Mv17IJCUBKEzwoMJZ8l?=
 =?us-ascii?Q?dwgBJ6/D9UQa0vXs2qk+ZENU+/eQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNu2cYMvRFh9b0yJ+4iibSA8mut32hm+nNnocSktdDBmHWpyUhgjaZB0yu5F?=
 =?us-ascii?Q?JkibWuXbHsEKEYP/NlkLh8eb6759uoV7RMgDGIV+qqyOjx1nzqzYeYbK37iN?=
 =?us-ascii?Q?NH4qwbf94RZfY2b0lTJ87kMAyUXUp4Lds644AYMsM3OXXXpeyIoGf/i+L0e7?=
 =?us-ascii?Q?1+yVzZrgyVuEas4d2Xk7NlMqWfYg1fFXj05eLSWS6MR23NLHA/sn2ISoQP4I?=
 =?us-ascii?Q?mPGKtWxjxfWrjVC8c1Q/YF0mjTWbrJBa2aT93lcdyZekMjpGae4c41rQJ72a?=
 =?us-ascii?Q?SsYf7dQNe5CIs9ZmuwNQmjRi+oU4oAWvl+U/hRlqTalNwhLu+QB4/Y8JanpE?=
 =?us-ascii?Q?cvkfi7+dY2NRXvF+OH6bvadwxkiqDaRBdAZG4q2/OwuHjGWJn4p5xlegvUF9?=
 =?us-ascii?Q?ZWOnklmceyFlqv7SKx/Jw/oyLZlrUIu+T6WNUaFPP555w5JwLP9ytShyF7Vf?=
 =?us-ascii?Q?aiENeqceliL7GctDD5g8GkVJaFgZytqm6KO1JhhFLNgAFPwo2ik6bsR+EM1O?=
 =?us-ascii?Q?dfhYr2wfamJQ2qhv2smZJftiNzdykPD9rz6qkODQY6zMwGQz5I7/uDFIW2Rc?=
 =?us-ascii?Q?vyv3PlW4ux1mTG4l04vZ1n3KTo//CwP3mmMWkuk0PEttFzK9XKk8dBUICE7G?=
 =?us-ascii?Q?WLk/IdO/u5V+oOrn+Ki+R3DJYzP/pM3HMTqqq089dpxTQtrofxc92eVx9IVO?=
 =?us-ascii?Q?MA8JrLpLS+xYtWOaz5H1gEGntcL5uxtsEf+oMXu0PPifuJ9GRxONW8jCObax?=
 =?us-ascii?Q?tlSb5srrZV3rz52bxJB1pQwfF2J7l7kaGsDGHSCBp9M0Mzc6ZUdaCw93O4s0?=
 =?us-ascii?Q?bTWCeM+wyJ3yFmRQS3Ax2dbT7GZzmgjUZaqSY2sQn0s5oDUsfq5ty8Cvn0jy?=
 =?us-ascii?Q?IRx1T6WJfOkbsgn/QePfFzRtx8589qddUkiFsJ0XN5mHagN1fDyim6MAVc6t?=
 =?us-ascii?Q?fVUzlXdfqRHxqlZ8enfFYBhMunnwQIDD5M+7hpoUG5VqWFCBBO3Bbo0P+JPf?=
 =?us-ascii?Q?NTLCHHF5bwQZ1BAR2mY3+i18uWpStJzgLocBJYy/kfJaAKbXjEziwyTeIaxX?=
 =?us-ascii?Q?YDTzkcq2j4b5rC4pvghHzswRgcZl6MRqu7xUo/lqLarboQ/UC8Gq1EqNDv6I?=
 =?us-ascii?Q?s6MMQIkxMaPxLYr9QQplbzmdXlAOGQIdeFfuTfJfWsQhZgfcoRYnw+ig15MO?=
 =?us-ascii?Q?WO4cRMuQF91JUhojVkO6ouFkqKi7Sn7ChftYazNU9A5AIpv8QJMYBvDCjrpD?=
 =?us-ascii?Q?qaBwOsrzaf1LUTbGn8r0l4XYP/7buKVYaJ1liMk9aHVOeblb/ZOf7m5XrCNH?=
 =?us-ascii?Q?qovHWs/MSZb+4l9/i/R7k2t5+ap+TEJd/XBftBjqkgWeQKUghV9Fi6AjuJxG?=
 =?us-ascii?Q?L/sDs0Bm3C4oXsUAR+H6/myCEEG0y/E8gopvgu3B+0PTr5xko9810eIIWRRc?=
 =?us-ascii?Q?MeCtKKn8uqwg6j9xvvLkOX3fD+OahaHVpd7W4IrePtgDFtl8/P2m/1wPjEcq?=
 =?us-ascii?Q?9CdxJ1ar8FGQT2JjkWdMXOd4GkOMcGz9y11TXOOuvoCgqxekyCcNzGrWLCgh?=
 =?us-ascii?Q?OXWbq863M0c5oJFPtR7+ALr37ppK9bnSvQ/E7G7n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc5fd1-bcf2-4c22-9a34-08dcc37fd691
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:28:21.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3XBdo1ZqolItpA9+KX0+TJy15e/EeTBjIMgdl6/ZH2tKgdBvMODH/zMsS4uXY4tX8zF7FRUkUJ/HSPHW7fuRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index d7d526a51e2b..103b0bec3a4a 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -271,20 +271,67 @@ static void calc_hpa_range(struct cxl_endpoint_decoder *cxled,
> >  	hpa_range->end = hpa_range->start + range_len(dpa_range) - 1;
> >  }
> >  
> > +static int cxlr_notify_extent(struct cxl_region *cxlr, enum dc_event event,
> > +			      struct region_extent *region_extent)
> > +{
> > +	struct cxl_dax_region *cxlr_dax;
> > +	struct device *dev;
> > +	int rc = 0;
> > +
> > +	cxlr_dax = cxlr->cxlr_dax;
> > +	dev = &cxlr_dax->dev;
> > +	dev_dbg(dev, "Trying notify: type %d HPA %par\n",
> > +		event, &region_extent->hpa_range);
> > +
> > +	/*
> > +	 * NOTE the lack of a driver indicates a notification has failed.  No
> > +	 * user space coordiantion was possible.
> > +	 */
> > +	device_lock(dev);
> > +	if (dev->driver) {
> > +		struct cxl_driver *driver = to_cxl_drv(dev->driver);
> > +		struct cxl_notify_data notify_data = (struct cxl_notify_data) {
> > +			.event = event,
> > +			.region_extent = region_extent,
> > +		};
> > +
> > +		if (driver->notify) {
> > +			dev_dbg(dev, "Notify: type %d HPA %par\n",
> > +				event, &region_extent->hpa_range);
> > +			rc = driver->notify(dev, &notify_data);
> > +		}
> > +	}
> > +	device_unlock(dev);
> 
> Maybe a cleaner version:
> 	guard(device)(dev);
> 	if (!dev->driver || !dev->driver->notify)
> 		return 0;

There is no dev->driver->notify.  But this works.

        if (!dev->driver)
                return 0;
        driver = to_cxl_drv(dev->driver);
        if (!driver->notify)
                return 0;

Not quite as clean but I did miss the use of guard.

> 
> 	dev_dbg(...);
> 	return driver->notify(dev, &notify_data);
>

I've cleaned it up.

[snip]

> > +
> > +int dax_region_add_resource(struct dax_region *dax_region,
> > +			    struct device *device,
> > +			    resource_size_t start, resource_size_t length)
> >
> kdoc header?

Because dax_region_add_resource() is part of the DAX private interfaces
and not intended to be used outside the DAX subsystem I skipped the kdoc
here even though the function must be exported.  Same for
dax_region_rm_resource() and dax_avail_size().

This is similar to run_dax() in that it is designed as a 'generic
operation' within the dax subsystem but not generally useful to the
kernel.

For now I'll move their declarations in dax-private.h and make a similar
comment.

Ira

> 
>  +{
> > +	struct resource *new_resource;
> > +	int rc;
> > +
> > +	struct dax_resource *dax_resource __free(kfree) =
> > +				kzalloc(sizeof(*dax_resource), GFP_KERNEL);
> > +	if (!dax_resource)
> > +		return -ENOMEM;
> > +
> > +	guard(rwsem_write)(&dax_region_rwsem);
> > +
> > +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> > +	new_resource = __request_region(&dax_region->res, start, length, "extent", 0);
> > +	if (!new_resource) {
> > +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> > +			&start, &length);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	dev_dbg(dax_region->dev, "add resource %pr\n", new_resource);
> > +	dax_resource->region = dax_region;
> > +	dax_resource->res = new_resource;
> > +	dev_set_drvdata(device, dax_resource);
> > +	rc = devm_add_action_or_reset(device, dax_release_resource,
> > +				      no_free_ptr(dax_resource));
> > +	/*  On error; ensure driver data is cleared under semaphore */
> > +	if (rc)
> > +		dev_set_drvdata(device, NULL);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_region_add_resource);
> > +
> > +int dax_region_rm_resource(struct dax_region *dax_region,
> > +			   struct device *dev)
> 
> kdoc header
> > +{
> > +	struct dax_resource *dax_resource;
> > +
> > +	guard(rwsem_write)(&dax_region_rwsem);
> > +
> > +	dax_resource = dev_get_drvdata(dev);
> > +	if (!dax_resource)
> > +		return 0;
> > +
> > +	if (dax_resource->use_cnt)
> > +		return -EBUSY;
> > +
> > +	/* avoid races with users trying to use the extent */
> > +	__dax_release_resource(dax_resource);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_region_rm_resource);
> > +
> >  bool static_dev_dax(struct dev_dax *dev_dax)
> >  {
> >  	return is_static(dev_dax->region);
> > @@ -296,19 +373,44 @@ static ssize_t region_align_show(struct device *dev,
> >  static struct device_attribute dev_attr_region_align =
> >  		__ATTR(align, 0400, region_align_show, NULL);
> >  
> > +#define for_each_child_resource(extent, res) \
> > +	for (res = (extent)->child; res; res = res->sibling)
> > +
> > +resource_size_t
> > +dax_avail_size(struct resource *dax_resource)
> kdoc header
> 
> DJ
> 

[snip]

