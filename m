Return-Path: <linux-btrfs+bounces-21583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC9BCUPiimmTOgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21583-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:46:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4409118058
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FB78301CFA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B2335556;
	Tue, 10 Feb 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrzAsWRS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5838DF9
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709563; cv=fail; b=io5y16TT8tcTwJkneltOPv6gQIAfH+UPeElDdle0SCULcvNv+cvfQjejXoftxfxuJfGnK7hn1PQrBQlOWDL6oCT9PyKwAM+PJlv4FbvPFR/TwJXLzdpXbf+qAn0QysWC8xvCN1H7PUW1MFQyW+SaFPcTAJbV9w4yuIiXwPrzq7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709563; c=relaxed/simple;
	bh=eHf+PQgHPRYOUqvkkGnm1yJltzmqv56luN+hn1HPEGE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g60MmZSxkN+KI9rfLJRKDRkrkNXwNdV0EuXHopnuKfhxV6NUGMgf6xHHwjXwKVUUM1+GsqCjHflCw+uYJUJiFMOHDfBu1zn4usHJesru2TTDgWq2bzsX9twrNB5AGvzLZTAtj8ThUDDjgPtV/t3psJec/t+mh1TLtYVL7qv6cSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrzAsWRS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770709562; x=1802245562;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=eHf+PQgHPRYOUqvkkGnm1yJltzmqv56luN+hn1HPEGE=;
  b=OrzAsWRSPQyZNe/IncJyM7B4vjkl1ywJ8TQ8uHh7sKq/HvTPaCWQSGA+
   kNIplerlnC66QxbaKcpVgR5snmpxIO1rflmAaucHIhqfRwnJXqOTGsbBA
   H+YBgoqdK5aV+DFg2SWQdfjSrkP6FEW1qHRGXbE9SSGn6Jc8gFssY4rBh
   THMguwVVOJxkL1kZEhIKhP/LnA+8Q/sq7RzLa7EiKKU1F8ZfgUMKC7tDf
   N0RcR2OouLQ0ArG8+lLBnRd5SgI8Vdgd92l6FK97LaLJsoO9lYZaUNhnd
   3sScZorr6fAHEO9Il04kO79zRYLbI/NpOyCXbNhH5iZyBCrNsYhnplZ8x
   w==;
X-CSE-ConnectionGUID: SVWdS+jQTDSqgCcz9c+BuA==
X-CSE-MsgGUID: cnFqFFNTTZS0f/3Onh5Mug==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="97291162"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="97291162"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:46:01 -0800
X-CSE-ConnectionGUID: mUV3bvr1QZqwv+2/TpVQKA==
X-CSE-MsgGUID: WM6vRIfuQ4ahKL83yTGs6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211873021"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 23:46:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:46:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 23:46:01 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 23:46:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF/WAFEICxCqkCMDoUEhzfxT6qEEw/XgJEfnV8JpMlJgguM+fZkGE2tbHoYMGfUkJ9/eVMqgnYPnxRGjIjpRuSprXDYNrYOa2E3DbvAAUBsnVsANyNIz5q9ZPRLINcDwHHDxDsMsBQ6syyvh3a+XsbfTLxq4ntTKv0dobwgPE5Yvazhrh8NU8mPaFQkRQeJs86DOsCrzjt6OC3x5LLK/JgEoWyXuNkqvP/Em0brq51XI1xPt6g+Y2FVuuVEiva8XtbI/iwXP1N96/0hI2z/ygl4Qyn1AQRyIOSUoBXh5/EzHGc3v7CXzeanBsVR3jCtYY8LFXgv0pxS3IUQuYZUodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PKw1CUYOn3X8TqQ5ZrUGeocG6sjEefht3aZQX0VRUU=;
 b=ZPuXy0RDrazDEnhg/heEPcA6MgN+vuBkJSNhstTv8EnT1eDzFxmZltfGSg5fK8fSbO0k+jnG6bVwBSd95jnSik1gr9Rm0NiMe6pAQ4vSwYeLB8S3NLHfYO5J1Cv+0k5mmBoK/Fs6ItJVR01vt/TE/gpeEYP7MeRE0CW3usVnE74iIYx3W1vhpYOIcA7D+SeFeiOzjdupfMkkqP9+a7Exd8IuwtwGmjMmKEl0jOLEeZUOCIxhffaOf6K0nC+K/Upxf3YZiwrhkARzC+uFuSk3MR1wyRbsEKcQnryrExFg7pGXRd072h+bSAtbKMHj3j+Z36qfdUOe6vm1XlVjbh2qgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 07:45:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 07:45:58 +0000
Date: Tue, 10 Feb 2026 15:45:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leo Martins <loemra.dev@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<kernel-team@fb.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Message-ID: <202602101504.f113db13-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com>
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 013c1a75-1aec-4bca-3aaf-08de68786de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?07/pcQLE+eEWksUd8TtHhVV/vFPupkrxmuX4E41txOrDPkWSLvf1nHS4WWsc?=
 =?us-ascii?Q?n4P7HE1luUpwFcIaIfWVJ8VSBryo/Ush/0LMavZ5UTU2nURTFCYl8+FPaeNU?=
 =?us-ascii?Q?f55UYzqyJRoVWTrbX6WHBzyKMTacbRsVmOUURND75k4CCqPDvSPZ/Y09jsOA?=
 =?us-ascii?Q?yQZuQorWlTQXolZP3+6eNkTchdoLnPGlJ0O5xszx4EsjLzYVHEtuMHEyZL9K?=
 =?us-ascii?Q?XgeCxNO/diT50YvzWMqPUd0ESGeKjyFUjLTtUdX4jh+/+PiAKG9fBC/UeTF/?=
 =?us-ascii?Q?M7/6NwBZA9OzGICQxxMgeuBp/BzYGxGwUsaBhRKYeDwmBiH7bJycUmKpbz7R?=
 =?us-ascii?Q?eli86JvB22Q6x8c/roFXeAbH0zdzrzkFL+bAAxgy5VuZ1WInkbYQ9sA5JECx?=
 =?us-ascii?Q?DsIrwgUzH3am2M7S62t9yXhOgsOYp4iN5P939q05pv5Ri7Cw6l2wMSLUMFlg?=
 =?us-ascii?Q?BVHotViW1lQmwzVKiMzEBv0NjvJPAFNR/iB19C2F1rGS4eSyWiCDVgX+Xh4G?=
 =?us-ascii?Q?AVguqT5z4EX0Tqhd5tt2zRseWINgKwB3VWpQhf9tgZPonD7VRKh6qBcSh9/K?=
 =?us-ascii?Q?e8AQGkV++fT2mqFbwtNmcg4q1km+D+2yJWdyEJRZFRdl2o73qt9XQpNk0egk?=
 =?us-ascii?Q?U1GlH/dhNdLhe/c3gBe/CwlB6ycB0S+DOvfUDtZfUUwI4PjqXpsb2GLcGIuN?=
 =?us-ascii?Q?Ttm3QsT7zCqMSy2xH0knyCwrEnUH3AdCQ87xoDXGQ+p86HFxQzkSxxEnxNYp?=
 =?us-ascii?Q?eNpO4zA3tLKVFSy5pcN6wj/ku8GjYwMRxJT0bQtR18e1I6OZwnEeHo+ioKb5?=
 =?us-ascii?Q?tSwlFZ/NrDhrQZJ/TUfDdHDwAPDgPTcDUEuMj9neYjteC54DHfFaCO83nDJr?=
 =?us-ascii?Q?hTlYBsJFodcreFgA2aaEjLJtov1Ch6LAc+/u8JIKmQsR/+VxS511k3tNK0sx?=
 =?us-ascii?Q?aqg5q8DNWxSpFRyFiKRzyd5cTwITpnjWNTFbrKQQz7CgX76LxRezRKhCn+H+?=
 =?us-ascii?Q?xnIZxBwd4a3+3W6TOXkDo0oScvW3NoE/+uVEud0mebyA/pnCkk0lFk+QUxQs?=
 =?us-ascii?Q?lZwGp0jvPQicgCt5E6boxbr4tW9YAT0q919+OXFnaxBTuWOcXwsYHRD8p3cV?=
 =?us-ascii?Q?7i5Zlzg11H6dQSFRp2gna2yz4PksIcHsoymOuOm5KyFvwOK0ocjBJd9yyJk0?=
 =?us-ascii?Q?NbhahbSUbqYZJQSbcyaRarY9NB5Feyz4tnr8RX5RXYIkTFqpC1XDfhvKanhF?=
 =?us-ascii?Q?qkGrTf7mxUWxGD3nP/h2qyNCr82+l6Ch5MOvOmPsQ8k3bLYs4mwny3jkcIqw?=
 =?us-ascii?Q?5ci+fPJkkR81RQ1i66aO3mTqGOLMAppkY8zu5Qh/F7RLILJz0EFP8svZsu8U?=
 =?us-ascii?Q?VOImSTn4GxiyqPWYEovpLku2+KZrSmgpp3Au4XItAdyxesfAQrKM/O+lhN9I?=
 =?us-ascii?Q?Ll3JlUCzH7o/e2fZK6F0sxQ4jCuSJRdKPkgr1YUy3SRdGdtrZV8mUWFa8XQd?=
 =?us-ascii?Q?ozF2lYzEaoT3qNQnNDUZC9R5RCZTUnJmJInv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Swfi3NeMaHhCO/RN4pCztsOztVwLuhQUfn5qIgUJFvs+usZ7aKep1fh2ESWg?=
 =?us-ascii?Q?/bxgHDelwPATf1/TaMHG5mQuYFSI7onFcsl1Wz3PgZMSc55DuEF/8fj4RhQz?=
 =?us-ascii?Q?BIhHgH9jnFVeNZIp6ZXWExT5Irs+rIOxvLmPTKAiGmxgQwl0T9QY8RD5luJB?=
 =?us-ascii?Q?PyW1gpxK9EVBVdO8ET98vFTl51M5URz74qxQa3XCnzCOCHf8G82V57LNHPUA?=
 =?us-ascii?Q?CCZIhGstP4sH8F0S1DalVtpPYsU/Ul7KISwsLmfZEhh2GlLA9zR6i+jJnisU?=
 =?us-ascii?Q?+VZHdXuoGT+hb39NR+6pi5L03qda0aruuiLOQYAEMlxf/+mhg87ThVwqcXH8?=
 =?us-ascii?Q?PwTToV/DCm8Yl9sdThTLk9djv51pRLrFN/gjCt4cYEIRa5gCSyg4JGSKi/aC?=
 =?us-ascii?Q?kI80rtMkHoZPLoAjyqn2vVGxAk4kiB0K5o6O3rKYFWjwA5gCWZSe63ztDEX0?=
 =?us-ascii?Q?zo9FYNUQkNvxheMQLozgGEG4Ex6/m2MMCXQaD+xoHvkqVfO/skU62joGY3iz?=
 =?us-ascii?Q?S58HqkhUMhKt+GqPIjPix+V49i/Qn2gyvn404Rn16YuGm4DYgm/G0tCdFjMB?=
 =?us-ascii?Q?QFFv6MraAoWgSyS+jn8xoGpEkMVfFFWYy/Tw7jrg68XNeI4B8wyGnPvhLSKs?=
 =?us-ascii?Q?JaUHP1T9s6wOooqR1z9ViIoTAoKz8jNe+hBNYJevqb5ku0+/AY51iqbOUWA0?=
 =?us-ascii?Q?i2RJi/ARwrEyIArs4Jo6FAuK/CxieLo5F2LS4ywLjQ8peEFnHyKhcxiL0r8G?=
 =?us-ascii?Q?tmEkdMXhE+laCaw0Gwe0V/98WqvskarZC4BG9tHKk7DBjCnXnaZKQem5VyGs?=
 =?us-ascii?Q?WGpLQodfY9opeoMP8DQRsvAL+8F2z2wLuz2K0aTme/BKT0J4HixUplD1yQX7?=
 =?us-ascii?Q?Vfbe0qqXvfWGb7BCUp0aKGhare0/RsM1WpreLCJVspBKvBxTeYWT8/NfQZzY?=
 =?us-ascii?Q?YMkN+hQKDdng7beIiWBSu9C9k/Rh1HVw4CXkLpZ/6ju26btNqftntF4VPF5B?=
 =?us-ascii?Q?EJlObOYAXfGtpOfCB7ykuvq+YG/w9zqY6IBKoSDEcICn9Ko6y58iE4SekEGS?=
 =?us-ascii?Q?BDJECd2AvekmDcr/99vLaWz0JnJXaXp5orLblR9YpMdGJCG/Mf2Mtty87u3C?=
 =?us-ascii?Q?jrsApo7AuAEE5UIx7o86i7eG98YiKAkouyK4cyiiR9G/UNceHnx+d+M0vAZ3?=
 =?us-ascii?Q?6vZumgpqqOs8QJfoVrZWHpbjkZC9dlOtsH+X7S3MD2ZwULv31WSLRgXeSiyx?=
 =?us-ascii?Q?l1Bd300JEaKsDbt5bxKa26VbQ5jBU/83n88ldp8wze7K49vxW1CeZg44DtQ9?=
 =?us-ascii?Q?yf39vJS+h4FZyZtQePjbzWYuAgvbvYeO20+nm8o7VkRLiDQE7+rt/ZZPKPmV?=
 =?us-ascii?Q?aGDPymYSLPm7okwzEiRrFXNZ+srsHAq65ONvoPIfhZjnCi1yz8jKcpNAJ4oe?=
 =?us-ascii?Q?L+42DBtx4clTDqH9M7HYfSf3kZ1FfN7x6V4r4wC/OZlHvZRiMBfT72fYNV9o?=
 =?us-ascii?Q?aX6GnTnPbX2w+wdi1vKdX3kJWEmf8+PdC1x5HmYB1pvOjZCJRpZ7oHhqM39f?=
 =?us-ascii?Q?dbwyNiko7bQiOAKjKUDbJuE08JI+sFz9pF++Fy6WJchOsLMWzpr0cw1xI+my?=
 =?us-ascii?Q?x7o7l51U6hrphweJTSHY3+vfIJ3oPRF5m3Bx9YDWX5/AoW2mbBDBFuK+9Lmb?=
 =?us-ascii?Q?7oizD54dxham7KKHvrtycZtwLlQSjQ5gdgmRAcINhfzKzUXGILD1a1/2rbD2?=
 =?us-ascii?Q?mLwvYhRZHA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 013c1a75-1aec-4bca-3aaf-08de68786de3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:45:58.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+smDuWK0aDUbzL9SpWLR4rrurMcJe/ei/ZtBE9Y1ihDOQpRsavwx1CFI2dO4SGgOHjvygGTdZE7+U9n+nK/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21583-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B4409118058
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: ba9c6f19149df060c2b7c71eaac21c394c161190 ("[PATCH] btrfs: prevent COW amplification during btrfs_search_slot")
url: https://github.com/intel-lab-lkp/linux/commits/Leo-Martins/btrfs-prevent-COW-amplification-during-btrfs_search_slot/20260128-044526
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/ba53d279b8bb3456f61cb8a4f15d9a4b1e618d0e.1769546089.git.loemra.dev@gmail.com/
patch subject: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602101504.f113db13-lkp@intel.com



[  125.965833][ T4372] INFO: trying to register non-static key.
[  125.971503][ T4372] The code is fine but needs lockdep annotation, or maybe
[  125.978465][ T4372] you didn't initialize this object before use?
[  125.984560][ T4372] turning off the locking correctness validator.
[  125.990745][ T4372] CPU: 3 UID: 0 PID: 4372 Comm: mount Tainted: G S        I         6.19.0-rc7-00122-gba9c6f19149d #1 PREEMPT(full)
[  125.990755][ T4372] Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
[  125.990758][ T4372] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[  125.990761][ T4372] Call Trace:
[  125.990764][ T4372]  <TASK>
[  125.990767][ T4372]  dump_stack_lvl (lib/dump_stack.c:122)
[  125.990777][ T4372]  register_lock_class (kernel/locking/lockdep.c:985 kernel/locking/lockdep.c:1299)
[  125.990784][ T4372]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
[  125.990790][ T4372]  ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:441 (discriminator 1))
[  125.990799][ T4372]  __lock_acquire (kernel/locking/lockdep.c:5113)
[  125.990809][ T4372]  lock_acquire (include/linux/preempt.h:469 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[  125.990815][ T4372]  ? xa_destroy (lib/xarray.c:2390 (discriminator 1))
[  125.990823][ T4372]  ? xa_find (include/linux/rcupdate.h:341 include/linux/rcupdate.h:897 lib/xarray.c:2202)
[  125.990830][ T4372]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
[  125.990836][ T4372]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[  125.990844][ T4372]  _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[  125.990851][ T4372]  ? xa_destroy (lib/xarray.c:2390 (discriminator 1))
[  125.990858][ T4372]  xa_destroy (lib/xarray.c:2390 (discriminator 1))
[  125.990865][ T4372]  ? xa_find (lib/xarray.c:2204)
[  125.990872][ T4372]  ? __pfx_xa_destroy (lib/xarray.c:2384)
[  125.990884][ T4372]  ? unlock_up (fs/btrfs/ctree.c:1427) btrfs
[  125.991323][ T4372] btrfs_search_slot (fs/btrfs/ctree.c:2043) btrfs
[  125.991720][ T4372]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
[  125.991732][ T4372]  ? __pfx_btrfs_search_slot (fs/btrfs/ctree.c:2043) btrfs
[  125.992150][ T4372]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
[  125.992158][ T4372]  ? ___slab_alloc (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 mm/slub.c:4555)
[  125.992166][ T4372]  ? __pfx___mutex_lock (kernel/locking/mutex.c:775)
[  125.992173][ T4372]  ? trace_preempt_on (include/trace/events/preemptirq.h:53 (discriminator 2) kernel/trace/trace_preemptirq.c:120 (discriminator 2))
[  125.992184][ T4372]  ? kmem_cache_alloc_noprof (include/trace/events/kmem.h:12 (discriminator 2) mm/slub.c:5273 (discriminator 2))
[  125.992191][ T4372]  ? btrfs_read_chunk_tree (fs/btrfs/volumes.c:7639) btrfs
[  125.992599][ T4372] btrfs_read_chunk_tree (fs/btrfs/volumes.c:7680) btrfs
[  125.993066][ T4372]  ? __pfx_btrfs_read_chunk_tree (fs/btrfs/volumes.c:7627) btrfs
[  125.993473][ T4372]  ? __pfx_load_super_root (fs/btrfs/disk-io.c:2617) btrfs
[  125.993868][ T4372]  ? __pfx_btrfs_read_sys_array (fs/btrfs/volumes.c:7494) btrfs
[  125.994309][ T4372]  ? __asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
[  125.994317][ T4372]  ? read_extent_buffer (fs/btrfs/extent_io.c:3981) btrfs
[  125.994743][ T4372] open_ctree (fs/btrfs/disk-io.c:3481) btrfs
[  125.995173][ T4372] btrfs_fill_super.cold (fs/btrfs/super.c:981) btrfs
[  125.995570][ T4372] btrfs_get_tree_super (fs/btrfs/super.c:1945) btrfs
[  125.995959][ T4372] btrfs_get_tree_subvol (fs/btrfs/super.c:2087) btrfs
[  125.996378][ T4372]  vfs_get_tree (fs/super.c:1751)
[  125.996387][ T4372]  vfs_cmd_create (fs/fsopen.c:231)
[  125.996394][ T4372]  __do_sys_fsconfig (fs/fsopen.c:474)
[  125.996401][ T4372]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
[  125.996411][ T4372]  ? vfs_read (include/linux/sched/xacct.h:24 fs/read_write.c:579)
[  125.996417][ T4372]  ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:108 arch/x86/entry/syscall_64.c:90)
[  125.996425][ T4372]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[  125.996431][ T4372]  ? kasan_quarantine_put (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 mm/kasan/quarantine.c:234)
[  125.996438][ T4372]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
[  125.996446][ T4372]  ? kasan_quarantine_put (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 mm/kasan/quarantine.c:234)
[  125.996453][ T4372]  ? kfree (mm/slub.c:6674 (discriminator 3) mm/slub.c:6882 (discriminator 3))
[  125.996459][ T4372]  ? __do_sys_fsconfig (fs/fsopen.c:499)
[  125.996467][ T4372]  ? ksys_read (fs/read_write.c:715)
[  125.996473][ T4372]  ? __pfx_ksys_read (fs/read_write.c:705)
[  125.996479][ T4372]  ? __do_sys_fsconfig (fs/fsopen.c:499)
[  125.996486][ T4372]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
[  125.996492][ T4372]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[  125.996499][ T4372]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
[  125.996505][ T4372]  ? __pfx_css_rstat_updated (kernel/cgroup/rstat.c:71)
[  125.996512][ T4372]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
[  125.996520][ T4372]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
[  125.996525][ T4372]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[  125.996531][ T4372]  ? count_memcg_events_mm+0x91/0x170
[  125.996539][ T4372]  ? count_memcg_events_mm+0x91/0x170
[  125.996545][ T4372]  ? __lock_release+0x5d/0x1b0
[  125.996553][ T4372]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
[  125.996559][ T4372]  ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 arch/x86/mm/fault.c:1480 arch/x86/mm/fault.c:1527)
[  125.996567][ T4372]  ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 arch/x86/mm/fault.c:1480 arch/x86/mm/fault.c:1527)
[  125.996573][ T4372]  ? __lock_release+0x5d/0x1b0
[  125.996578][ T4372]  ? handle_mm_fault (mm/memory.c:6469 (discriminator 1) mm/memory.c:6609 (discriminator 1))
[  125.996587][ T4372]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
[  125.996594][ T4372]  ? irqentry_exit (include/linux/irq-entry-common.h:298 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
[  125.996600][ T4372]  ? trace_hardirqs_on_prepare (kernel/trace/trace_preemptirq.c:64 (discriminator 4) kernel/trace/trace_preemptirq.c:59 (discriminator 4))
[  125.996605][ T4372]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
[  125.996612][ T4372]  ? irqentry_exit (arch/x86/include/asm/jump_label.h:37 include/linux/context_tracking_state.h:138 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:301 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
[  125.996619][ T4372]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
[  125.996625][ T4372] RIP: 0033:0x7f169cce04aa
[  125.996652][ T4372] Code: 73 01 c3 48 8b 0d 4e 59 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e 59 0d 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 4e 59 0d 00 	mov    0xd594e(%rip),%rcx        # 0xd5958
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	66 90                	xchg   %ax,%ax
  20:	49 89 ca             	mov    %rcx,%r10
  23:	b8 af 01 00 00       	mov    $0x1af,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd5958
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 1e 59 0d 00 	mov    0xd591e(%rip),%rcx        # 0xd592e
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260210/202602101504.f113db13-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


