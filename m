Return-Path: <linux-btrfs+bounces-8980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E589A1B5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF8D281024
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D41C232B;
	Thu, 17 Oct 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNOWkZAT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A631BAECA
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148913; cv=fail; b=gId0Ltl3jZd2rTUoprI+8Dx7hxE19aFKusnzoIWIT5KqPZcLbubP0r3LK0ZbOIKxEwF0Gl47j9NH1WPE9s4G6Z3olNJQAAo3Uh5Tydh+TPn8i9Q4/rQVKJeQ1vtyq6Bvsma3+NfJB3TB4bX1STj+NirPx7uoaYqRQe2cYJuPV6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148913; c=relaxed/simple;
	bh=LQJoGD7pOIK+wyNPsElp3USl3P4LlCqYkH3TOvreMn4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqHYTJa3AAKBdKrAwZUn+DoGt54DbJhmRkZTzErcag/rRNia2UzEdmQmSPafufJKnw+gpI62v19TUgAOA5UVrE3pEWpb+t1sgvrtnLqyKx3mbo5XPspQ2OXK3172xvpWKFes1lU0BhGZU3DvliUjBHbC7guyeLUwgJlI64N8RVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNOWkZAT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729148910; x=1760684910;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LQJoGD7pOIK+wyNPsElp3USl3P4LlCqYkH3TOvreMn4=;
  b=aNOWkZAT2zjqYL4cv4JoJh8qVN3jpYG2X3gE/iJHNTcS8Es7M8Ph8FoK
   p7oqHUm3W3wMECNisdOVT5HvLNCiS1umxLUcOQdrk2DVm0+D2C8nbboSJ
   zPVrFjK4ajYq4NDMNIVC6q/f3YLKfYTsTHU6VrH2uz11yzs1QhU0483TC
   2b4p7gdPIbsL9djKAtU9UVixi9hGdfK2ArlYgv4s1C6HHMwZ2xlwCXnBs
   ZwIutcK4kOZTKKlGXHT8TOekrilsSke6ROVSe7uv2TxFyz9jDc+Bvbl3Y
   L9DyERAEaks+ywuxLdHVdUm9Q8b7Gvd5N27WOzULiaOVph2JfIZI9acYP
   A==;
X-CSE-ConnectionGUID: f63vII5pRbqw2DsLpU11YA==
X-CSE-MsgGUID: Ds+BPCxOSS+poBt9kIFBBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="32549931"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="32549931"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:08:29 -0700
X-CSE-ConnectionGUID: 1yexTnywQdadn+whkWDbjw==
X-CSE-MsgGUID: YuHjJ6bOSeuAReR71IXhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83109758"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 00:08:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 00:08:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 00:08:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 00:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZKcGG57tyynZHskF1vohEM2/f5tYPdWzfT7zSCqodQUrGWRIiu9Epi8jSuf02zx2EQBVLFGtKb7bEN9Xhdd2kw4o3lHH+TkzAU5iYEUdl6parydVY+cinvQnQIcQddDzAr9b4nOAzs5cLyqgIY1uXpXqn9l/OCDoEKkBV+XhVJcd7QvFlLpnMIMC0uDXUbS7FdaZ46yLHIU45M7gwGG95y3iqj1Rc//3032MlDwpj95bnHV6NUqN77DcBjDhwEFBimjOC+s0hnZb++/tsz8sycg9b87TRyH6gcMQB96z27MsjhsE4Gux9sy5ODQbNWt4x+FmmeziRjfBxpQXQuwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnkXaGGDxPvmzSm8OLJdeaX58sapkm+l14R1I6rvNk8=;
 b=SAQLMNetqRBcHi/WVDznhb5XbMqHbAzxwFgJ0cRQoSaH18pkSWmUbOg8E3zqEUNa8zg53pN/D5B9+XylU87GP3gqg9sk1KmjtvFH1g7Fei7hpWil4Zjjijfd4uxIi4Z3dhUVw2yZ/wk6p1j3kfiIZNMFalUy8pNsw0DqIv+2W1ZnTpon9r4dgHqHbRBGiD5d5S5/I5baYNez3LCuJktMu5BbqLpLaoPSxWmjaJdWh0tgEJu/o8YRNZdac7hp/f65E63pZJJOr4VaDLkM78m4wOUgjGyieQk5wZtL5ypmV2SZYUO7zlgxIwROUVe1Skt1arBMrquj/z4ryUDAY2/Ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 07:08:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 07:08:24 +0000
Date: Thu, 17 Oct 2024 15:08:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] btrfs: make buffered write to copy one page a time
Message-ID: <202410171456.b6cdebb1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d6f8e54faafe6dba9be2f72e6d0fca99951ddfd.1728532438.git.wqu@suse.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 89359996-6d7a-4273-afd3-08dcee7a7dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hxgzBdMtJXPKj88wyvk/nZ6oRhAWABzjiZ0GYqmf1PyN4E5yZJoqQtJZMh?=
 =?iso-8859-1?Q?1xZSrOIHTFX4NivRjQDgqgF2Ig/CXt3M/c3POjMz6WwMdilblTccVR1gCs?=
 =?iso-8859-1?Q?CvK8OVbC34fC8GkpRrOC/T6n+QB5as1X3kntnAV/swn+g1WzOJmBZo2y9j?=
 =?iso-8859-1?Q?Hu4IslYuhNJ5iRp6bkkDLFxaQBBpVYM3aEobDmnDfexYmK1EUWlOSFxOJn?=
 =?iso-8859-1?Q?9O0OhBL78o/4C6fH1Ag7Oq0DTp59i9cFsuF8OJ+f75rja1c+1CDx4H5V+N?=
 =?iso-8859-1?Q?MyjlNDPtvWvZbkDAiw48mZQFEGoSe8+m6divEL9McT3lRUEzRJEGbrhpNb?=
 =?iso-8859-1?Q?ZMhvT1rqNe1LSyVzCXuXjzLkuDiNTkHcN/AJD9B25t5Emehj7jgLf9NmGi?=
 =?iso-8859-1?Q?fdnM18J3TRckGYZex6wO/MUz8O6GqI6wtJ1cmCV0e2NXSV/erpCFkleKOS?=
 =?iso-8859-1?Q?myXfbTS7mABTkp5toTDetgJQ99faWxUm+uizNxY/bsS+xCjp+c/7wggSz8?=
 =?iso-8859-1?Q?yywri0/FsMPZ5XgH8lYSDM7JbR9RfZ2tjQcHSwEijQ3NiN0gIbSke+mX20?=
 =?iso-8859-1?Q?k1roegFscXbW/aR0UAiHrVwVRHIaigyrYZUwjLD0DExNUuvx2mLMk/4+t4?=
 =?iso-8859-1?Q?7fysV2ywRFVq4weddN9RFxk3JOvNqUmXsSMddRyzS0/XeA1oRnjF46E8Gb?=
 =?iso-8859-1?Q?5yd0pc8+xX7/JOqYxBtF4XgBgtAbtX4xpLrGiA2SYwSyAmC5xvK0N2TivR?=
 =?iso-8859-1?Q?uZ3x5qxIMOzYZH6cW+UYIaXO/R9q7tzZKl3ixXc1d14SXPO3HlSOYhkYzA?=
 =?iso-8859-1?Q?TRahJipGcM6wiwQX+1XlgqaOt/Nv2uLCb3rUKu3rTFE9dGpyAwwU7wvAip?=
 =?iso-8859-1?Q?vcZb/kZTGKJLG3BGhiilpYrLEh2ZIaH9YmLTnSP88WYZ2Q9f3lOlBK5ZCs?=
 =?iso-8859-1?Q?Rp0GKa//8Dd/6goruTyQEefb+8SLWM45F8LnOUvNHZa7TKRGKLyECUBAA/?=
 =?iso-8859-1?Q?f+t5bIjxGSP9EtFZpMXjd6/SRIPnL9Pp3KNoJ8/IjMK9WIJt6cA03pOGPR?=
 =?iso-8859-1?Q?JS9zMkvURgAxeFWfbahnuwQzc0IwYFPkdELGaJdOqgcFP6pBIoA0fB4LmE?=
 =?iso-8859-1?Q?KtHMi76OSfk+0KSlxkaopq5ZCIo4By7W6g9IZ4PQEDFwCws6kX5JPUstKB?=
 =?iso-8859-1?Q?41pUK9RLZpUIn4KWqeoSE4/jKKTwSRut0UkYg80PYtPeOmNA/5izidmx9k?=
 =?iso-8859-1?Q?0do7fZh6vWvAe8B6qoAY4E9PPpB1ualPwlEmYjWTVL4I67V2cHfvamZJg2?=
 =?iso-8859-1?Q?6bKNx4jaHqYLrk212OKKJu2P5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WXFxVYcWOMJMyVOAqt/im+0iiBo9FXLxb+u+ACZVZPt5KyDef606UjOJ+K?=
 =?iso-8859-1?Q?zKhPkdYIqMUwrRSWVlgT/TStYNhH2lEvIa0pOoUyVFxVQucdazciVRgm1s?=
 =?iso-8859-1?Q?xJpxE8OlZkLCXFnMmWK901fkSk2W+9F30hEHUZDtB5WnHxpJFnNf6ghSoD?=
 =?iso-8859-1?Q?g/cIbkRly26GV1YInUe6ZnLtEvf59B91sM44iU9gbhUSQHYVA82ync1wGR?=
 =?iso-8859-1?Q?XRFfWkPdUvfRJXX4Ps5cBWEWOa1Oq9OM3rlCv+uFd1pF/ErRSUMXLS/Nli?=
 =?iso-8859-1?Q?0TKTDA078stwdPl+gyvvJmkjsapYvTB4AM85sK+NU34NfetJ1hATY0DrV2?=
 =?iso-8859-1?Q?Z6j3t5KR3anK0V3bYRH3eUPq38dRuS04TKtPvStg3WJndOzQP6EZeJK/qv?=
 =?iso-8859-1?Q?lbj2uLmMF3EfCkOhluuZV1hzOgH0IHlP+g0g9j3agqPIaPcQvMeiVogqLe?=
 =?iso-8859-1?Q?O6ZDEDsrHzB2K63UQD/xIbx2H/d/IsUNZSf2sWi/wRfo/wO2oIcjCBazlZ?=
 =?iso-8859-1?Q?BVbkho0U1bxjDoHDF2qs71zv2Y9fyYwgDhV+/AUf108kUjpeWCMTOmuG3h?=
 =?iso-8859-1?Q?A3EkOfU5tHHYLifuyMRz9JXevfloyYYHSLgfO5QlP/bC+wh20XxrIOPtIi?=
 =?iso-8859-1?Q?fkm4Xp5PZw1c7Bp6CbCH5dw0QlooShETCxLrkWUc2qC9+7bKXLJhEsDabv?=
 =?iso-8859-1?Q?dFe+Z3f8Bgu0Uhc0PJ/Rtm0n8MRJyVkhms4lOAMRaohYesm9AieiMOxNtb?=
 =?iso-8859-1?Q?qGRy/pI1H9r2KFjC/jMJM1bHfrgG4Tbvdxhi8KbotgEoR85PrqsiCTqrlv?=
 =?iso-8859-1?Q?Z3s4IBwxyBENZNUuOWuSCC37S/OiaXzifYTj/XSGICw6wZhLBmjst4N4I6?=
 =?iso-8859-1?Q?GV6wtS2stQOdZ7/3qEPAucb5jMQHjAmO8eW86yuqBTpzxMkVHXjeEzNsJe?=
 =?iso-8859-1?Q?7vYivWZpN9l1CPf5OmULitN97/GHy6gO6fysBxUKPsbk16FHLpMESqwN9p?=
 =?iso-8859-1?Q?jgbm9oGOTVVaYObOomOkX0hQ1l72gaa1v814+LoxGPA7vdokteiixpuJ7d?=
 =?iso-8859-1?Q?dGggTT7xdqoGwgyMqhmUzBDZ8c/6mwQCNuCaMoSemNCMQqk8wf3G2W/i3y?=
 =?iso-8859-1?Q?PkqcZadrLG8wyZenaV8Ezar9Eoxa8zNTsxbaHpxmtjhABD5B9GLhdCxyp5?=
 =?iso-8859-1?Q?3KCW0WYdclvJr9ir0mCWS8RNt6Iep+9aYphDViFkxgDUZvzhftuau+UGJI?=
 =?iso-8859-1?Q?hHPwBZ23FB7E35NpWEZvBzK3fpzi7cX1R1bHeIFcv4g7g8Ut+oLErRIyc0?=
 =?iso-8859-1?Q?nSwUHReq/fFZ4XliwXXKPV2wEIW8xVYwzQd/2L3xUEEinQZSow4m4Fq5OK?=
 =?iso-8859-1?Q?gPAqc6aXSdmAlaqrCJLm5DU3aQUbCITmlbnvEVcNVEsyGncRxOSsi4xWcv?=
 =?iso-8859-1?Q?H8BRJttQ5nhJGAYr0Mc/qyxYkarJ+yCHDesewtdOgwR7HeVsbDmUR5SksL?=
 =?iso-8859-1?Q?vYqUal9++4dWsNWWG5K8pddTq3PfYxklZkbipY+nDxqTYCbehQfBeR0JLT?=
 =?iso-8859-1?Q?eud6e+MjlHImb1jQ4EJ0SHhP8c1usQ7bL942GoWN4gySNY6avFch3r3cNt?=
 =?iso-8859-1?Q?gkj015XKM/0cunxysSB/oM8TLQ3+cgOQJLIwU5yIPlq0gRheZ+bzhlzw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89359996-6d7a-4273-afd3-08dcee7a7dc3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 07:08:24.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF2aizTqrHtiZYGxJmqCpA5sf6z9AUXJn7p8kjtUReRzgkgmUFFwHQRRmluxlSdXiIeoUAAt/9chdNfbmGp/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 16.0% regression of iozone.average_KBps on:


commit: eeeea160c640d8eb91dc3d6dc48be26c2c37457c ("[PATCH 1/2] btrfs: make buffered write to copy one page a time")
url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-buffered-write-to-copy-one-page-a-time/20241010-124734
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/0d6f8e54faafe6dba9be2f72e6d0fca99951ddfd.1728532438.git.wqu@suse.com/
patch subject: [PATCH 1/2] btrfs: make buffered write to copy one page a time

testcase: iozone
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	disk: 2HDD
	fs: btrfs
	iosched: kyber
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410171456.b6cdebb1-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241017/202410171456.b6cdebb1-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/iosched/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/2HDD/btrfs/kyber/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/iozone

commit: 
  a6f63ff0d7 ("Merge branch 'for-next-next-v6.12-20241009' into for-next-20241009")
  eeeea160c6 ("btrfs: make buffered write to copy one page a time")

a6f63ff0d7025c54 eeeea160c640d8eb91dc3d6dc48 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.04            +0.0        0.04        mpstat.cpu.all.sys%
   1998642 ± 84%     -68.0%     638956 ± 37%  numa-numastat.node0.local_node
   2099811 ± 80%     -65.2%     730619 ± 31%  numa-numastat.node0.numa_hit
   2099377 ± 80%     -65.2%     730368 ± 31%  numa-vmstat.node0.numa_hit
   1998208 ± 84%     -68.0%     638705 ± 37%  numa-vmstat.node0.numa_local
     64443 ±  4%      +6.8%      68808 ±  2%  proc-vmstat.nr_zone_write_pending
      7331 ± 79%    +138.8%      17505 ± 16%  proc-vmstat.numa_hint_faults
     95857 ± 48%     +65.7%     158842 ± 11%  proc-vmstat.numa_pte_updates
    137921            +2.1%     140815        proc-vmstat.pgreuse
      9.03 ±  2%     -19.9%       7.23 ±  3%  perf-stat.i.MPKI
  99780778 ±  3%     +20.9%  1.207e+08 ±  3%  perf-stat.i.branch-instructions
      1.22            -0.1        1.15        perf-stat.i.branch-miss-rate%
 5.024e+08 ±  3%     +22.7%  6.164e+08 ±  3%  perf-stat.i.instructions
      0.71            +7.1%       0.76        perf-stat.i.ipc
      7.75           -15.9%       6.52 ±  2%  perf-stat.overall.MPKI
      2.18 ±  2%      -0.3        1.90        perf-stat.overall.branch-miss-rate%
  99931564 ±  3%     +20.8%  1.207e+08 ±  3%  perf-stat.ps.branch-instructions
 5.032e+08 ±  3%     +22.6%  6.168e+08 ±  3%  perf-stat.ps.instructions
 6.001e+11 ±  3%     +22.4%  7.348e+11 ±  3%  perf-stat.total.instructions
      0.55 ± 47%      +0.4        0.94 ±  9%  perf-profile.calltrace.cycles-pp.write
      0.40 ± 71%      +0.5        0.86 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64
      0.41 ± 71%      +0.5        0.87 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_do_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.43 ± 71%      +0.5        0.90 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.44 ± 71%      +0.5        0.92 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.44 ± 71%      +0.5        0.92 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.44 ± 71%      +0.5        0.91 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.16 ± 12%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.02 ±141%      +0.1        0.09 ± 46%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.prepare_one_page
      0.07 ± 53%      +0.1        0.17 ± 31%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +0.3        0.27 ± 18%  perf-profile.children.cycles-pp.btrfs_dirty_page
      0.60 ± 29%      +0.3        0.95 ±  9%  perf-profile.children.cycles-pp.write
      0.52 ± 28%      +0.3        0.87 ±  9%  perf-profile.children.cycles-pp.btrfs_buffered_write
      0.56 ± 28%      +0.3        0.91 ± 10%  perf-profile.children.cycles-pp.vfs_write
      0.52 ± 28%      +0.4        0.87 ±  9%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.56 ± 28%      +0.4        0.92 ± 10%  perf-profile.children.cycles-pp.ksys_write
      0.23 ±  8%      -0.0        0.19 ±  8%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.16 ± 12%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.run_posix_cpu_timers
    542043           -20.2%     432357        iozone.1024KB_1024reclen
   9097871 ±  4%     -57.3%    3886841 ±  8%  iozone.1024KB_1024reclen.frewrite
   9632899 ±  2%     -57.6%    4083590 ±  3%  iozone.1024KB_1024reclen.fwrite
   9773507           -58.4%    4068268 ±  5%  iozone.1024KB_1024reclen.random_write
   9246355 ± 11%     -54.7%    4192127        iozone.1024KB_1024reclen.record_rewrite
   7060912 ±  3%     -50.5%    3495651 ±  2%  iozone.1024KB_1024reclen.rewrite
   5854028 ± 11%     -35.9%    3751337 ±  2%  iozone.1024KB_1024reclen.write
   8683596 ± 22%     -55.1%    3898752 ± 13%  iozone.1024KB_128reclen.frewrite
   8147547 ± 30%     -52.2%    3896196 ± 17%  iozone.1024KB_128reclen.fwrite
  11646693 ±  9%     -61.2%    4517455 ±  5%  iozone.1024KB_128reclen.random_write
  17030272 ±  7%     -73.1%    4582005 ±  2%  iozone.1024KB_128reclen.record_rewrite
   6710074 ± 24%     -49.9%    3362845 ± 14%  iozone.1024KB_128reclen.rewrite
   5304511 ± 18%     -31.5%    3635821 ±  9%  iozone.1024KB_16reclen.frewrite
   5599329 ± 12%     -31.5%    3835223 ± 10%  iozone.1024KB_16reclen.fwrite
   6420412 ± 12%     -37.5%    4015161 ±  3%  iozone.1024KB_16reclen.random_write
   8956010           -53.0%    4204864 ±  4%  iozone.1024KB_16reclen.record_rewrite
   5400865 ±  4%     -36.4%    3433675 ±  8%  iozone.1024KB_16reclen.rewrite
   5057394 ±  4%     -26.2%    3731322 ±  7%  iozone.1024KB_16reclen.write
  10659137 ±  4%     -57.5%    4524846 ± 14%  iozone.1024KB_256reclen.frewrite
   9600316 ± 16%     -53.8%    4433287 ± 18%  iozone.1024KB_256reclen.fwrite
  12086394 ±  7%     -62.1%    4581666 ±  5%  iozone.1024KB_256reclen.random_write
  18674893 ±  3%     -75.0%    4662367 ±  2%  iozone.1024KB_256reclen.record_rewrite
   6954389 ± 24%     -53.5%    3237090 ± 15%  iozone.1024KB_256reclen.rewrite
   6511047 ± 22%     -45.8%    3528011 ± 13%  iozone.1024KB_32reclen.frewrite
   6991276 ± 19%     -45.7%    3797465 ± 13%  iozone.1024KB_32reclen.fwrite
   8883588 ±  8%     -50.7%    4377528 ±  3%  iozone.1024KB_32reclen.random_write
  12071763 ±  4%     -64.2%    4316696        iozone.1024KB_32reclen.record_rewrite
   5838377 ± 19%     -43.2%    3317402 ± 14%  iozone.1024KB_32reclen.rewrite
   8226792 ±  4%      +6.4%    8755907        iozone.1024KB_4reclen.random_read
   3385272            +3.1%    3491635        iozone.1024KB_4reclen.record_rewrite
   2820123 ±  5%      +5.4%    2971591        iozone.1024KB_4reclen.rewrite
    705144 ±  3%     -21.2%     555839 ±  2%  iozone.1024KB_512reclen
  13870147 ±  4%     -51.6%    6708400 ± 12%  iozone.1024KB_512reclen.frewrite
   5714601 ±  6%     -28.5%    4086432 ±  8%  iozone.1024KB_512reclen.fwrite
  12128304 ±  4%     -63.6%    4417054 ±  7%  iozone.1024KB_512reclen.random_write
  15557904           -70.4%    4597540        iozone.1024KB_512reclen.record_rewrite
   7655911 ±  5%     -51.7%    3695523 ±  3%  iozone.1024KB_512reclen.rewrite
   6998972 ±  4%     -42.9%    3996083 ±  6%  iozone.1024KB_512reclen.write
   7531595 ± 23%     -50.8%    3701834 ± 16%  iozone.1024KB_64reclen.frewrite
   7586858 ± 27%     -51.8%    3657647 ± 18%  iozone.1024KB_64reclen.fwrite
  10537091 ± 10%     -58.1%    4410056 ±  5%  iozone.1024KB_64reclen.random_write
  14724491 ±  7%     -69.4%    4504235 ±  2%  iozone.1024KB_64reclen.record_rewrite
   6233206 ± 24%     -48.9%    3184404 ± 16%  iozone.1024KB_64reclen.rewrite
   4583844 ±  2%     -23.5%    3507804        iozone.1024KB_8reclen.frewrite
   4836398           -24.3%    3660722        iozone.1024KB_8reclen.random_write
   5725197 ±  9%     -28.2%    4110803        iozone.1024KB_8reclen.record_rewrite
   4226568 ±  3%     -22.8%    3263105 ±  8%  iozone.1024KB_8reclen.rewrite
    958137 ±  3%     -12.4%     839054 ±  7%  iozone.128KB_128reclen
   8738751 ±  6%     -58.6%    3617394 ± 22%  iozone.128KB_128reclen.frewrite
   9185212 ±  2%     -59.6%    3713555 ± 20%  iozone.128KB_128reclen.fwrite
  11038193 ±  2%     -58.9%    4542068        iozone.128KB_128reclen.random_write
  10983805 ±  3%     -63.0%    4068594 ± 17%  iozone.128KB_128reclen.record_rewrite
   6397989 ±  8%     -49.6%    3221561 ± 11%  iozone.128KB_128reclen.rewrite
   5394780 ±  9%     -40.7%    3196876 ± 17%  iozone.128KB_128reclen.write
   5788254 ±  5%     -31.2%    3984232 ±  5%  iozone.128KB_16reclen.frewrite
   5282205 ± 11%     -26.0%    3906918 ±  8%  iozone.128KB_16reclen.fwrite
   6110253 ±  8%     -38.0%    3787704 ±  7%  iozone.128KB_16reclen.random_write
   7310434 ±  3%     -47.3%    3854735 ±  2%  iozone.128KB_16reclen.record_rewrite
   4233865 ±  9%     -31.2%    2913969 ± 20%  iozone.128KB_16reclen.write
   7153424 ± 12%     -38.8%    4380585 ±  9%  iozone.128KB_32reclen.frewrite
   6781060 ± 14%     -32.6%    4569325 ±  7%  iozone.128KB_32reclen.fwrite
   8272460 ±  2%     -49.1%    4212237 ±  2%  iozone.128KB_32reclen.random_write
   9058701 ±  4%     -57.3%    3865827 ±  8%  iozone.128KB_32reclen.record_rewrite
   5670379 ±  8%     -42.0%    3290422 ±  6%  iozone.128KB_32reclen.rewrite
   4886671 ±  8%     -30.9%    3378247 ±  7%  iozone.128KB_32reclen.write
  10953435 ±  4%     -45.0%    6027905 ± 18%  iozone.128KB_64reclen.frewrite
   5211701 ± 15%     -26.1%    3851838 ±  6%  iozone.128KB_64reclen.fwrite
   9901762 ±  3%     -55.0%    4457872 ±  2%  iozone.128KB_64reclen.random_write
  10619616 ±  3%     -64.1%    3817487 ± 14%  iozone.128KB_64reclen.record_rewrite
   5921763 ± 14%     -41.8%    3446338 ±  7%  iozone.128KB_64reclen.rewrite
   5102284 ± 10%     -33.3%    3400985 ±  9%  iozone.128KB_64reclen.write
   4429298 ±  5%     -20.9%    3502551 ±  5%  iozone.128KB_8reclen.frewrite
   4245188 ±  8%     -24.6%    3201936 ± 18%  iozone.128KB_8reclen.fwrite
   4598068           -29.4%    3247543 ± 13%  iozone.128KB_8reclen.random_write
    385560           -17.4%     318351        iozone.131072KB_1024reclen
   4226504           -38.1%    2617224        iozone.131072KB_1024reclen.frewrite
   4248661           -38.3%    2622832        iozone.131072KB_1024reclen.fwrite
   4872229 ±  2%     -42.1%    2820516        iozone.131072KB_1024reclen.random_write
  12985870           -69.8%    3922393        iozone.131072KB_1024reclen.record_rewrite
   4187877           -38.8%    2565012        iozone.131072KB_1024reclen.rewrite
   3672037 ±  4%     -26.8%    2686945        iozone.131072KB_1024reclen.write
    448736           -19.4%     361855        iozone.131072KB_128reclen
   4268447           -38.3%    2631749        iozone.131072KB_128reclen.frewrite
   4323348           -39.0%    2638197        iozone.131072KB_128reclen.fwrite
   4622813           -42.1%    2678604        iozone.131072KB_128reclen.random_write
  19501625           -76.0%    4672640        iozone.131072KB_128reclen.record_rewrite
   4027166           -37.8%    2505861        iozone.131072KB_128reclen.rewrite
   3673398           -28.7%    2620321        iozone.131072KB_128reclen.write
    343686 ±  2%     -12.9%     299492 ±  2%  iozone.131072KB_16384reclen
   3478793           -30.9%    2404333        iozone.131072KB_16384reclen.frewrite
   3553351           -31.4%    2437960 ±  2%  iozone.131072KB_16384reclen.fwrite
   4601231           -39.9%    2764435        iozone.131072KB_16384reclen.random_write
   7507491 ±  2%     -58.5%    3118015        iozone.131072KB_16384reclen.record_rewrite
   4036137           -38.0%    2501444 ±  2%  iozone.131072KB_16384reclen.rewrite
   3628587           -28.2%    2606651        iozone.131072KB_16384reclen.write
    366856           -14.8%     312456        iozone.131072KB_2048reclen
   4072963           -37.1%    2560087        iozone.131072KB_2048reclen.frewrite
   4113190           -37.2%    2582822        iozone.131072KB_2048reclen.fwrite
   4757567           -40.9%    2809962        iozone.131072KB_2048reclen.random_write
  10030466           -63.4%    3675841        iozone.131072KB_2048reclen.record_rewrite
   4155697           -38.9%    2540635 ±  2%  iozone.131072KB_2048reclen.rewrite
   3694537 ±  3%     -27.3%    2684360        iozone.131072KB_2048reclen.write
    462547           -18.3%     378043        iozone.131072KB_256reclen
  10477031 ±  3%      +6.4%   11143514        iozone.131072KB_256reclen.bkwd_read
  10786442 ±  3%      +6.3%   11466470 ±  2%  iozone.131072KB_256reclen.fread
   4422554           -38.9%    2703180        iozone.131072KB_256reclen.frewrite
   4513907           -40.2%    2700056        iozone.131072KB_256reclen.fwrite
   4691120 ±  2%     -42.1%    2715491        iozone.131072KB_256reclen.random_write
  21472934           -78.2%    4689219        iozone.131072KB_256reclen.record_rewrite
   4025658 ±  3%     -37.7%    2508850        iozone.131072KB_256reclen.rewrite
  10425184            +3.6%   10798459        iozone.131072KB_256reclen.stride_read
   3674918 ±  2%     -30.0%    2572009 ±  4%  iozone.131072KB_256reclen.write
    362980 ±  2%     -13.2%     315057        iozone.131072KB_4096reclen
   8598261 ±  2%      +4.7%    9002206        iozone.131072KB_4096reclen.bkwd_read
   4080689           -36.7%    2581225        iozone.131072KB_4096reclen.frewrite
   4124534           -37.0%    2596925        iozone.131072KB_4096reclen.fwrite
   4761270           -40.8%    2816424        iozone.131072KB_4096reclen.random_write
   9783775           -62.2%    3697554        iozone.131072KB_4096reclen.record_rewrite
   4094406           -38.6%    2515909        iozone.131072KB_4096reclen.rewrite
   3711599           -27.6%    2687856        iozone.131072KB_4096reclen.write
    445354           -19.5%     358554 ±  2%  iozone.131072KB_512reclen
   4505758           -38.9%    2751413        iozone.131072KB_512reclen.frewrite
   4533134           -39.3%    2752491        iozone.131072KB_512reclen.fwrite
   4841713           -42.5%    2785239 ±  2%  iozone.131072KB_512reclen.random_write
  19357877 ±  2%     -76.6%    4527349        iozone.131072KB_512reclen.record_rewrite
   4255338 ±  2%     -39.3%    2581578        iozone.131072KB_512reclen.rewrite
   3917082           -30.0%    2741744        iozone.131072KB_512reclen.write
    427530           -18.4%     348661        iozone.131072KB_64reclen
   4120078           -36.6%    2612921        iozone.131072KB_64reclen.frewrite
   4163104           -37.1%    2616671        iozone.131072KB_64reclen.fwrite
   4342296           -40.3%    2593797        iozone.131072KB_64reclen.random_write
  16675187 ±  2%     -72.3%    4617489        iozone.131072KB_64reclen.record_rewrite
   3862107           -35.1%    2508071        iozone.131072KB_64reclen.rewrite
   3615562           -28.2%    2594525        iozone.131072KB_64reclen.write
    369656           -13.8%     318628        iozone.131072KB_8192reclen
   4084040           -35.8%    2621236        iozone.131072KB_8192reclen.frewrite
   4171031           -36.3%    2657549        iozone.131072KB_8192reclen.fwrite
   4751812           -40.9%    2808532        iozone.131072KB_8192reclen.random_write
   9274324           -61.4%    3584092        iozone.131072KB_8192reclen.record_rewrite
   4079969           -38.3%    2516161 ±  2%  iozone.131072KB_8192reclen.rewrite
   3662940           -27.4%    2658129        iozone.131072KB_8192reclen.write
    523766 ±  3%     -22.7%     404748        iozone.16384KB_1024reclen
   6837159 ±  6%     -49.8%    3432704 ±  3%  iozone.16384KB_1024reclen.frewrite
   6452432 ±  6%     -49.4%    3264958        iozone.16384KB_1024reclen.fwrite
  11712645 ±  2%      -5.3%   11094955 ±  3%  iozone.16384KB_1024reclen.random_read
  10212039           -59.5%    4130773        iozone.16384KB_1024reclen.random_write
  10644747 ±  2%      -4.2%   10199361        iozone.16384KB_1024reclen.read
  13233016           -69.6%    4019136        iozone.16384KB_1024reclen.record_rewrite
  11476059 ±  3%      -4.7%   10941165 ±  2%  iozone.16384KB_1024reclen.reread
   6769300 ± 10%     -50.3%    3361173        iozone.16384KB_1024reclen.rewrite
   5575719 ±  7%     -40.2%    3332755 ±  2%  iozone.16384KB_1024reclen.write
    670808 ±  4%     -25.8%     497581        iozone.16384KB_128reclen
  15744853 ±  4%      -7.3%   14588313 ±  4%  iozone.16384KB_128reclen.fread
   8575298 ±  6%     -55.9%    3779439 ±  2%  iozone.16384KB_128reclen.frewrite
   8528342 ±  9%     -55.0%    3838202 ±  2%  iozone.16384KB_128reclen.fwrite
  10657796 ±  3%     -59.9%    4274345        iozone.16384KB_128reclen.random_write
  14753478 ±  5%      -7.1%   13710497 ±  3%  iozone.16384KB_128reclen.read
  19883590 ±  2%     -76.4%    4687775        iozone.16384KB_128reclen.record_rewrite
   6879699 ± 11%     -50.0%    3438716 ±  2%  iozone.16384KB_128reclen.rewrite
   5693333 ±  8%     -39.7%    3435110 ±  3%  iozone.16384KB_128reclen.write
    402948 ±  8%     -25.0%     302066 ±  3%  iozone.16384KB_16384reclen
   5989603 ± 18%     -48.4%    3089331 ±  7%  iozone.16384KB_16384reclen.frewrite
   5952726 ± 18%     -51.1%    2909260 ±  3%  iozone.16384KB_16384reclen.fwrite
  10926335            -6.0%   10266058        iozone.16384KB_16384reclen.random_read
   7865529           -53.7%    3641609        iozone.16384KB_16384reclen.random_write
   7097218 ± 13%     -54.3%    3243012 ±  5%  iozone.16384KB_16384reclen.record_rewrite
   4955000 ± 13%     -43.3%    2809554 ±  3%  iozone.16384KB_16384reclen.rewrite
   3852320 ±  9%     -33.1%    2575572 ±  2%  iozone.16384KB_16384reclen.write
    492780 ±  4%     -15.7%     415240 ±  2%  iozone.16384KB_16reclen
   5747167 ±  5%     -37.8%    3572140 ±  2%  iozone.16384KB_16reclen.frewrite
   5611391 ±  6%     -38.2%    3466024 ±  3%  iozone.16384KB_16reclen.fwrite
   6074952           -40.8%    3598773        iozone.16384KB_16reclen.random_write
   9187879           -52.5%    4365629        iozone.16384KB_16reclen.record_rewrite
   5018736 ±  8%     -37.5%    3135693 ±  2%  iozone.16384KB_16reclen.rewrite
   4501210 ± 10%     -31.2%    3098882 ±  3%  iozone.16384KB_16reclen.write
    476039 ±  3%     -20.2%     379667        iozone.16384KB_2048reclen
   6201803 ± 10%     -43.6%    3500786 ±  2%  iozone.16384KB_2048reclen.frewrite
   5898758 ±  9%     -45.2%    3230000 ±  2%  iozone.16384KB_2048reclen.fwrite
   8666918           -55.7%    3842024 ±  2%  iozone.16384KB_2048reclen.random_write
  10076118           -63.3%    3695523        iozone.16384KB_2048reclen.record_rewrite
  11218308 ±  3%      -4.8%   10684627 ±  3%  iozone.16384KB_2048reclen.reread
   6119133 ± 10%     -48.4%    3156270 ±  3%  iozone.16384KB_2048reclen.rewrite
   5152680 ± 10%     -37.9%    3197545 ±  3%  iozone.16384KB_2048reclen.write
    683080 ±  5%     -27.1%     497924 ±  3%  iozone.16384KB_256reclen
  16140658 ±  4%      -8.2%   14818303 ±  5%  iozone.16384KB_256reclen.freread
   8337309 ± 12%     -55.9%    3675422 ±  6%  iozone.16384KB_256reclen.frewrite
   8623447 ± 12%     -57.0%    3709426 ±  5%  iozone.16384KB_256reclen.fwrite
  11159490 ±  2%     -61.4%    4306677 ±  3%  iozone.16384KB_256reclen.random_write
  14760981 ±  4%      -6.7%   13765221 ±  2%  iozone.16384KB_256reclen.read
  21831204           -78.4%    4713642        iozone.16384KB_256reclen.record_rewrite
   7346093 ±  9%     -53.7%    3403207 ±  4%  iozone.16384KB_256reclen.rewrite
   6109079 ±  8%     -41.8%    3556551 ±  3%  iozone.16384KB_256reclen.write
    566054 ±  5%     -19.9%     453202 ±  2%  iozone.16384KB_32reclen
   6697700 ± 10%     -46.4%    3591587 ±  2%  iozone.16384KB_32reclen.frewrite
   6970026 ±  9%     -48.2%    3609335 ±  4%  iozone.16384KB_32reclen.fwrite
   7956017 ±  2%     -50.3%    3958068        iozone.16384KB_32reclen.random_write
  12942212 ±  5%     -66.0%    4406567 ±  4%  iozone.16384KB_32reclen.record_rewrite
   5921726 ± 11%     -45.9%    3201790 ±  3%  iozone.16384KB_32reclen.rewrite
   5191971 ± 12%     -37.6%    3237823 ±  4%  iozone.16384KB_32reclen.write
    460586 ±  5%     -20.6%     365537 ±  2%  iozone.16384KB_4096reclen
   6335781 ± 15%     -40.0%    3803409 ±  5%  iozone.16384KB_4096reclen.frewrite
   5870430 ± 13%     -41.6%    3428726 ±  2%  iozone.16384KB_4096reclen.fwrite
   8495162           -54.7%    3847451 ±  2%  iozone.16384KB_4096reclen.random_write
   9388265 ±  3%     -61.5%    3615448        iozone.16384KB_4096reclen.record_rewrite
  11077239 ±  3%      -6.7%   10336092 ±  2%  iozone.16384KB_4096reclen.reread
   5871104 ± 12%     -49.5%    2965535        iozone.16384KB_4096reclen.rewrite
   4790750 ± 13%     -37.9%    2972961        iozone.16384KB_4096reclen.write
   9047972 ±  2%      -3.4%    8738705        iozone.16384KB_4reclen.freread
   6915186 ±  4%      -4.3%    6614717 ±  2%  iozone.16384KB_4reclen.random_read
   3396707            +3.0%    3497129        iozone.16384KB_4reclen.record_rewrite
    614723 ±  3%     -27.4%     446233 ±  4%  iozone.16384KB_512reclen
  13914396 ±  4%      -7.8%   12828695 ±  5%  iozone.16384KB_512reclen.bkwd_read
   8096910 ±  7%     -54.1%    3714698 ±  4%  iozone.16384KB_512reclen.frewrite
   8101100 ±  8%     -54.6%    3676473        iozone.16384KB_512reclen.fwrite
  11355901 ±  3%     -61.9%    4330173 ±  2%  iozone.16384KB_512reclen.random_write
  12460175 ±  4%      -7.6%   11507388 ±  4%  iozone.16384KB_512reclen.read
  19238622 ±  4%     -76.4%    4542726        iozone.16384KB_512reclen.record_rewrite
   7323816 ± 12%     -53.2%    3425389        iozone.16384KB_512reclen.rewrite
  13429700 ±  4%      -8.2%   12323787 ±  4%  iozone.16384KB_512reclen.stride_read
   6207547 ± 11%     -42.5%    3572174 ±  3%  iozone.16384KB_512reclen.write
    624341 ±  4%     -23.2%     479567        iozone.16384KB_64reclen
  15151736 ±  4%      -8.6%   13854885 ±  4%  iozone.16384KB_64reclen.bkwd_read
   7323657 ±  8%     -48.8%    3746646 ±  2%  iozone.16384KB_64reclen.frewrite
   7790658 ±  7%     -52.3%    3719161 ±  3%  iozone.16384KB_64reclen.fwrite
   9510948 ±  2%     -55.8%    4207249        iozone.16384KB_64reclen.random_write
  16906757           -72.5%    4652294        iozone.16384KB_64reclen.record_rewrite
   6631166 ±  9%     -50.1%    3311344 ±  3%  iozone.16384KB_64reclen.rewrite
   5573825 ± 10%     -39.7%    3361066 ±  4%  iozone.16384KB_64reclen.write
    433143 ±  7%     -21.4%     340305 ±  3%  iozone.16384KB_8192reclen
   7362577 ±  9%     -40.0%    4417899 ±  5%  iozone.16384KB_8192reclen.frewrite
   5392604 ±  2%     -31.0%    3719420 ±  6%  iozone.16384KB_8192reclen.fwrite
   8344361 ±  3%     -53.9%    3843290        iozone.16384KB_8192reclen.random_write
   8531288 ± 10%     -59.7%    3440601 ±  4%  iozone.16384KB_8192reclen.record_rewrite
   5582200 ± 14%     -48.4%    2880844 ±  2%  iozone.16384KB_8192reclen.rewrite
  11218798 ±  2%     -11.7%    9903546 ±  8%  iozone.16384KB_8192reclen.stride_read
   4609004 ± 13%     -40.2%    2756259        iozone.16384KB_8192reclen.write
    406592 ±  5%      -9.1%     369612        iozone.16384KB_8reclen
   4483118 ±  4%     -24.4%    3388493 ±  2%  iozone.16384KB_8reclen.frewrite
   4294129 ±  8%     -24.4%    3248404 ±  2%  iozone.16384KB_8reclen.fwrite
   4177378 ±  2%     -24.7%    3147515        iozone.16384KB_8reclen.random_write
   6115193           -32.6%    4124662        iozone.16384KB_8reclen.record_rewrite
   4044126 ±  7%     -24.7%    3046498 ±  3%  iozone.16384KB_8reclen.rewrite
   3777195 ±  9%     -22.3%    2935122 ±  4%  iozone.16384KB_8reclen.write
    546618           -19.5%     439945        iozone.2048KB_1024reclen
  12660025           -46.8%    6732798 ±  2%  iozone.2048KB_1024reclen.frewrite
   6005037 ±  4%     -29.6%    4228146 ±  4%  iozone.2048KB_1024reclen.fwrite
   9615106 ±  4%     -56.3%    4204222        iozone.2048KB_1024reclen.random_write
  10922139 ±  2%     -63.3%    4012164 ±  6%  iozone.2048KB_1024reclen.record_rewrite
   7433654 ±  2%     -51.5%    3602167        iozone.2048KB_1024reclen.rewrite
   6398008 ±  4%     -39.9%    3847742 ±  5%  iozone.2048KB_1024reclen.write
    774331 ±  2%     -19.1%     626077        iozone.2048KB_128reclen
   9339282 ±  3%     -54.7%    4235217 ±  7%  iozone.2048KB_128reclen.frewrite
   9861836           -55.1%    4432068        iozone.2048KB_128reclen.fwrite
  11255098 ±  3%     -61.0%    4393415 ±  5%  iozone.2048KB_128reclen.random_write
  19154136           -75.7%    4660792        iozone.2048KB_128reclen.record_rewrite
   7915314 ±  3%     -52.0%    3797347        iozone.2048KB_128reclen.rewrite
   6736213 ±  7%     -39.0%    4106970 ±  6%  iozone.2048KB_128reclen.write
    540333           -12.0%     475243 ±  2%  iozone.2048KB_16reclen
   6117335           -37.0%    3853879        iozone.2048KB_16reclen.frewrite
   6170729 ±  3%     -36.7%    3906222        iozone.2048KB_16reclen.fwrite
   6457065 ±  2%     -39.3%    3920286 ±  2%  iozone.2048KB_16reclen.random_write
   8925801           -52.3%    4258996        iozone.2048KB_16reclen.record_rewrite
   5634792 ±  2%     -36.8%    3559899 ±  3%  iozone.2048KB_16reclen.rewrite
   5116892 ±  8%     -27.1%    3732619 ±  4%  iozone.2048KB_16reclen.write
    487898           -17.8%     401052        iozone.2048KB_2048reclen
   8131189           -53.7%    3766691 ±  2%  iozone.2048KB_2048reclen.frewrite
   8051272 ±  8%     -52.1%    3853722 ±  2%  iozone.2048KB_2048reclen.fwrite
   8324425 ±  2%     -53.1%    3907865 ±  3%  iozone.2048KB_2048reclen.random_write
   8403246           -54.1%    3853043 ±  3%  iozone.2048KB_2048reclen.record_rewrite
   6448049 ±  7%     -46.7%    3436943        iozone.2048KB_2048reclen.rewrite
   4736760 ± 10%     -33.6%    3147117        iozone.2048KB_2048reclen.write
    787613 ±  3%     -20.5%     626349        iozone.2048KB_256reclen
  10263264 ±  3%     -54.7%    4646604        iozone.2048KB_256reclen.frewrite
  10179784 ±  3%     -54.3%    4657053        iozone.2048KB_256reclen.fwrite
  11645748 ±  7%     -61.9%    4442609 ±  5%  iozone.2048KB_256reclen.random_write
  19996981 ±  3%     -76.9%    4610956 ±  4%  iozone.2048KB_256reclen.record_rewrite
   7744388 ±  9%     -50.5%    3835087        iozone.2048KB_256reclen.rewrite
   7117349 ±  4%     -41.4%    4169140 ±  3%  iozone.2048KB_256reclen.write
    617275 ±  2%     -15.9%     519296        iozone.2048KB_32reclen
   7401019 ±  3%     -45.4%    4037639        iozone.2048KB_32reclen.frewrite
   7719491 ±  2%     -46.9%    4097741        iozone.2048KB_32reclen.fwrite
   8633317 ±  3%     -51.1%    4221529 ±  2%  iozone.2048KB_32reclen.random_write
  11765911 ± 14%     -62.2%    4441885        iozone.2048KB_32reclen.record_rewrite
   6743151 ±  2%     -44.1%    3772064 ±  2%  iozone.2048KB_32reclen.rewrite
   6067717 ±  6%     -33.3%    4045820 ±  3%  iozone.2048KB_32reclen.write
    686319 ±  2%     -20.3%     547002 ±  2%  iozone.2048KB_512reclen
  10258408 ±  4%     -51.1%    5013013 ±  3%  iozone.2048KB_512reclen.frewrite
   9201658 ± 14%     -46.4%    4934039 ±  7%  iozone.2048KB_512reclen.fwrite
  11811913 ±  5%     -61.4%    4556856        iozone.2048KB_512reclen.random_write
  16741303 ±  3%     -73.0%    4512235        iozone.2048KB_512reclen.record_rewrite
   8076937 ±  5%     -52.5%    3832601        iozone.2048KB_512reclen.rewrite
   6402629 ± 11%     -37.7%    3990424 ±  4%  iozone.2048KB_512reclen.write
    686438 ±  2%     -19.3%     553707        iozone.2048KB_64reclen
   8426729 ±  8%     -50.2%    4196218        iozone.2048KB_64reclen.frewrite
   8949585 ±  2%     -52.3%    4271865        iozone.2048KB_64reclen.fwrite
  10476756 ±  2%     -59.1%    4284777 ±  7%  iozone.2048KB_64reclen.random_write
  16339660 ±  2%     -72.4%    4512540        iozone.2048KB_64reclen.record_rewrite
   7299616 ±  6%     -48.1%    3786234        iozone.2048KB_64reclen.rewrite
   6425014 ± 13%     -35.1%    4172482 ±  2%  iozone.2048KB_64reclen.write
    446265 ±  2%      -7.2%     414117 ±  2%  iozone.2048KB_8reclen
   4600877 ±  3%     -21.7%    3602700        iozone.2048KB_8reclen.frewrite
   4696867 ±  4%     -24.1%    3563359 ±  5%  iozone.2048KB_8reclen.fwrite
   4575834           -25.8%    3396893 ±  3%  iozone.2048KB_8reclen.random_write
   5909456 ±  6%     -30.9%    4084327        iozone.2048KB_8reclen.record_rewrite
   4163296 ±  8%     -17.9%    3419822        iozone.2048KB_8reclen.rewrite
   4315228 ±  3%     -17.8%    3545590 ±  2%  iozone.2048KB_8reclen.write
    876883           -12.7%     765305 ±  2%  iozone.256KB_128reclen
  12782503 ±  3%     -45.0%    7025945        iozone.256KB_128reclen.frewrite
   5741338 ±  2%     -33.1%    3842429 ± 15%  iozone.256KB_128reclen.fwrite
  12766790 ±  2%     -62.6%    4776665 ±  3%  iozone.256KB_128reclen.random_write
  14002687           -67.8%    4512965 ±  5%  iozone.256KB_128reclen.record_rewrite
   7065110 ± 13%     -50.3%    3507880 ± 14%  iozone.256KB_128reclen.rewrite
   5930962 ±  7%     -32.3%    4015437        iozone.256KB_128reclen.write
    642307 ±  2%      -9.2%     583516 ±  3%  iozone.256KB_16reclen
   6074746 ±  2%     -37.6%    3792774 ±  6%  iozone.256KB_16reclen.frewrite
   6105783           -41.2%    3591341 ± 20%  iozone.256KB_16reclen.fwrite
   6873747 ±  4%     -41.7%    4006649 ±  4%  iozone.256KB_16reclen.random_write
   7981703 ±  7%     -48.4%    4120145        iozone.256KB_16reclen.record_rewrite
   5440790           -34.9%    3540479        iozone.256KB_16reclen.rewrite
   4945496 ±  5%     -25.8%    3668556 ±  4%  iozone.256KB_16reclen.write
    936922           -12.7%     817874        iozone.256KB_256reclen
   9160325 ± 13%     -53.8%    4230113 ±  4%  iozone.256KB_256reclen.frewrite
  10080319 ±  8%     -56.3%    4405546        iozone.256KB_256reclen.fwrite
  13506820 ±  9%     -65.9%    4601257 ± 15%  iozone.256KB_256reclen.random_write
  13415163           -65.9%    4570189 ± 10%  iozone.256KB_256reclen.record_rewrite
   6785904 ± 16%     -45.7%    3687027 ±  4%  iozone.256KB_256reclen.rewrite
   6143300 ±  8%     -42.8%    3513204 ±  9%  iozone.256KB_256reclen.write
    731396 ±  4%      -9.5%     661916        iozone.256KB_32reclen
   7356434 ±  6%     -42.7%    4215021 ±  4%  iozone.256KB_32reclen.frewrite
   7645775 ±  2%     -43.3%    4336420 ±  4%  iozone.256KB_32reclen.fwrite
   9336883           -51.9%    4486681        iozone.256KB_32reclen.random_write
  10992498           -61.6%    4219066 ±  4%  iozone.256KB_32reclen.record_rewrite
   6343748 ±  3%     -44.5%    3519118 ±  4%  iozone.256KB_32reclen.rewrite
   5653159 ±  3%     -33.4%    3767542 ±  7%  iozone.256KB_32reclen.write
   9842890            +3.0%   10135309        iozone.256KB_4reclen.fread
   3091569            +3.9%    3211087        iozone.256KB_4reclen.frewrite
    819494           -12.5%     716765 ±  3%  iozone.256KB_64reclen
   9479809 ±  2%     -48.1%    4915296 ±  4%  iozone.256KB_64reclen.frewrite
   9443174           -47.2%    4989437        iozone.256KB_64reclen.fwrite
  10982966 ±  9%     -60.0%    4396044 ± 16%  iozone.256KB_64reclen.random_write
  13120773 ±  2%     -66.2%    4430361        iozone.256KB_64reclen.record_rewrite
   7022881           -47.4%    3691036 ±  4%  iozone.256KB_64reclen.rewrite
   5811449 ± 10%     -32.1%    3946590 ±  4%  iozone.256KB_64reclen.write
    505316            -6.0%     474879 ±  3%  iozone.256KB_8reclen
   4604603 ±  3%     -22.0%    3592664 ±  3%  iozone.256KB_8reclen.frewrite
   4723759 ±  4%     -20.5%    3757181        iozone.256KB_8reclen.fwrite
   4880843           -25.9%    3614503 ±  3%  iozone.256KB_8reclen.random_write
   5720852           -31.3%    3930088        iozone.256KB_8reclen.record_rewrite
   4171724 ±  3%     -27.0%    3045157 ± 19%  iozone.256KB_8reclen.rewrite
    384269           -18.7%     312569 ±  3%  iozone.262144KB_1024reclen
   4228130           -38.5%    2601765        iozone.262144KB_1024reclen.frewrite
   4245661           -38.6%    2605001        iozone.262144KB_1024reclen.fwrite
   4764166           -43.3%    2700353 ±  7%  iozone.262144KB_1024reclen.random_write
  13022842           -71.4%    3718118 ±  9%  iozone.262144KB_1024reclen.record_rewrite
   4224765           -38.4%    2603504        iozone.262144KB_1024reclen.rewrite
   3762221           -30.8%    2604280 ±  8%  iozone.262144KB_1024reclen.write
    444657           -19.4%     358268        iozone.262144KB_128reclen
   4257822           -38.7%    2611195        iozone.262144KB_128reclen.frewrite
   4256653           -38.4%    2620727        iozone.262144KB_128reclen.fwrite
   4442435           -41.8%    2585358        iozone.262144KB_128reclen.random_write
  19508218           -76.2%    4635032        iozone.262144KB_128reclen.record_rewrite
   4027292           -38.4%    2482551        iozone.262144KB_128reclen.rewrite
   3685432           -31.3%    2531930 ±  5%  iozone.262144KB_128reclen.write
    350335           -12.9%     305213        iozone.262144KB_16384reclen
   3306788           -31.6%    2262244        iozone.262144KB_16384reclen.frewrite
   3400413           -34.4%    2230709 ±  5%  iozone.262144KB_16384reclen.fwrite
   4625060           -39.8%    2783094        iozone.262144KB_16384reclen.random_write
   7521068 ± 14%     -57.6%    3192318 ±  5%  iozone.262144KB_16384reclen.record_rewrite
   4086952           -39.4%    2477683        iozone.262144KB_16384reclen.rewrite
   3595399           -30.1%    2513733 ± 11%  iozone.262144KB_16384reclen.write
    359063 ±  4%     -13.1%     311921        iozone.262144KB_2048reclen
   3920404 ±  8%     -35.4%    2531203        iozone.262144KB_2048reclen.frewrite
   3927967 ±  9%     -35.2%    2544352        iozone.262144KB_2048reclen.fwrite
   4645669 ±  2%     -40.2%    2777700        iozone.262144KB_2048reclen.random_write
  10198908           -63.7%    3697244        iozone.262144KB_2048reclen.record_rewrite
   4147484           -38.1%    2567342        iozone.262144KB_2048reclen.rewrite
   3710679 ±  2%     -28.2%    2662870        iozone.262144KB_2048reclen.write
    463955           -20.6%     368213        iozone.262144KB_256reclen
  10373960 ±  5%      +5.0%   10890873        iozone.262144KB_256reclen.bkwd_read
   4479411           -40.2%    2680473        iozone.262144KB_256reclen.frewrite
   4457060           -39.9%    2679874        iozone.262144KB_256reclen.fwrite
   4606982           -42.4%    2655255        iozone.262144KB_256reclen.random_write
  21281948           -78.1%    4651245        iozone.262144KB_256reclen.record_rewrite
   4131652           -39.6%    2494448 ±  2%  iozone.262144KB_256reclen.rewrite
   3745982           -30.3%    2610616        iozone.262144KB_256reclen.write
    363030           -13.7%     313142        iozone.262144KB_4096reclen
   4077622           -37.6%    2545637        iozone.262144KB_4096reclen.frewrite
   4097419           -37.5%    2560139        iozone.262144KB_4096reclen.fwrite
   4667585 ±  2%     -39.9%    2803072        iozone.262144KB_4096reclen.random_write
   9839826           -62.5%    3694499        iozone.262144KB_4096reclen.record_rewrite
   4124679           -38.3%    2543895        iozone.262144KB_4096reclen.rewrite
   3629825 ±  3%     -26.5%    2666858        iozone.262144KB_4096reclen.write
    447934           -20.2%     357320        iozone.262144KB_512reclen
   4535922           -40.0%    2722081        iozone.262144KB_512reclen.frewrite
   4549499           -39.9%    2732292        iozone.262144KB_512reclen.fwrite
   4748840           -41.8%    2764377        iozone.262144KB_512reclen.random_write
  19397355 ±  2%     -76.8%    4508272        iozone.262144KB_512reclen.record_rewrite
   4267200 ±  2%     -40.2%    2552813        iozone.262144KB_512reclen.rewrite
   3885152 ±  5%     -31.3%    2670734 ±  5%  iozone.262144KB_512reclen.write
    424456           -18.3%     346877        iozone.262144KB_64reclen
  10154974 ±  3%      +4.1%   10568230        iozone.262144KB_64reclen.fread
   4094335           -36.6%    2596063        iozone.262144KB_64reclen.frewrite
   4122313           -37.1%    2590914        iozone.262144KB_64reclen.fwrite
   4173511           -40.4%    2488944        iozone.262144KB_64reclen.random_write
  16968397           -72.9%    4604559        iozone.262144KB_64reclen.record_rewrite
   3911540           -36.7%    2476357        iozone.262144KB_64reclen.rewrite
   3540605 ±  2%     -28.8%    2522326 ±  5%  iozone.262144KB_64reclen.write
    363270           -14.1%     312070        iozone.262144KB_8192reclen
   4072504           -36.9%    2569494        iozone.262144KB_8192reclen.frewrite
   4127105           -37.6%    2577055        iozone.262144KB_8192reclen.fwrite
   4684117           -40.3%    2795599        iozone.262144KB_8192reclen.random_write
   9668475           -62.9%    3591337 ±  4%  iozone.262144KB_8192reclen.record_rewrite
   4149213           -38.8%    2540318 ±  2%  iozone.262144KB_8192reclen.rewrite
   3626868 ±  4%     -26.8%    2656000        iozone.262144KB_8192reclen.write
    452361 ±  6%     -23.5%     346179 ±  3%  iozone.32768KB_1024reclen
  10954271 ±  5%      -7.6%   10121060 ±  7%  iozone.32768KB_1024reclen.fread
   5449792 ± 13%     -45.9%    2950655 ±  6%  iozone.32768KB_1024reclen.frewrite
   5406442 ± 14%     -47.2%    2853976 ±  4%  iozone.32768KB_1024reclen.fwrite
   8077369 ±  7%     -55.7%    3581207 ±  3%  iozone.32768KB_1024reclen.random_write
  13107006           -69.8%    3962878        iozone.32768KB_1024reclen.record_rewrite
   5297933 ± 13%     -44.4%    2944868 ±  5%  iozone.32768KB_1024reclen.rewrite
   4381643 ± 17%     -34.6%    2863550 ±  4%  iozone.32768KB_1024reclen.write
    540696 ± 10%     -24.6%     407737        iozone.32768KB_128reclen
  13364204 ±  8%     -11.1%   11887041 ±  7%  iozone.32768KB_128reclen.freread
   5879763 ± 19%     -48.6%    3021490 ±  4%  iozone.32768KB_128reclen.frewrite
   5784176 ± 26%     -49.4%    2926630 ±  5%  iozone.32768KB_128reclen.fwrite
   7645945 ± 13%     -53.4%    3566359 ±  4%  iozone.32768KB_128reclen.random_write
  19380762 ±  4%     -76.1%    4637415        iozone.32768KB_128reclen.record_rewrite
   5152463 ± 15%     -46.5%    2756253 ±  4%  iozone.32768KB_128reclen.rewrite
   4778959 ± 12%     -42.6%    2743941 ±  2%  iozone.32768KB_128reclen.write
    355402 ±  6%     -18.6%     289426 ±  5%  iozone.32768KB_16384reclen
   5065660 ±  7%     -27.4%    3678717 ±  3%  iozone.32768KB_16384reclen.frewrite
   4502475 ±  5%     -22.7%    3479293 ±  3%  iozone.32768KB_16384reclen.fwrite
   5977933 ±  2%     -48.3%    3091112 ±  8%  iozone.32768KB_16384reclen.random_write
   6161792 ±  3%     -51.7%    2974276 ±  4%  iozone.32768KB_16384reclen.record_rewrite
   4532246 ±  3%     -42.5%    2606120 ±  3%  iozone.32768KB_16384reclen.rewrite
   3764245 ± 11%     -29.5%    2653857 ±  4%  iozone.32768KB_16384reclen.write
    434720 ±  5%     -20.8%     344426 ±  3%  iozone.32768KB_2048reclen
   5241635 ± 11%     -45.6%    2851437 ±  2%  iozone.32768KB_2048reclen.frewrite
   4750629 ± 13%     -43.2%    2699454 ±  5%  iozone.32768KB_2048reclen.fwrite
   7484649 ±  5%     -55.5%    3327521 ±  8%  iozone.32768KB_2048reclen.random_write
   9823060           -62.6%    3673651        iozone.32768KB_2048reclen.record_rewrite
   5226760 ± 13%     -45.0%    2872670 ±  4%  iozone.32768KB_2048reclen.rewrite
   4208492 ± 13%     -33.9%    2781504 ±  2%  iozone.32768KB_2048reclen.write
    561829 ±  9%     -25.6%     417889 ±  2%  iozone.32768KB_256reclen
   6860768 ± 11%     -53.2%    3208544 ±  7%  iozone.32768KB_256reclen.frewrite
   6098671 ± 27%     -50.5%    3020109 ±  6%  iozone.32768KB_256reclen.fwrite
   8463832 ±  8%     -56.5%    3682172 ±  3%  iozone.32768KB_256reclen.random_write
  21467650           -78.2%    4679967        iozone.32768KB_256reclen.record_rewrite
   5273214 ± 13%     -47.3%    2778932 ±  7%  iozone.32768KB_256reclen.rewrite
   4373441 ± 13%     -35.2%    2832910 ±  7%  iozone.32768KB_256reclen.write
    414838 ±  7%     -15.6%     350194 ±  4%  iozone.32768KB_4096reclen
   5398092 ±  6%     -44.2%    3011772 ±  6%  iozone.32768KB_4096reclen.frewrite
   4815155 ± 10%     -38.3%    2971343 ±  5%  iozone.32768KB_4096reclen.fwrite
   7050252 ±  8%     -50.8%    3465523 ±  3%  iozone.32768KB_4096reclen.random_write
   9399112 ±  3%     -60.9%    3672116        iozone.32768KB_4096reclen.record_rewrite
   5116695 ±  9%     -44.6%    2835183 ±  4%  iozone.32768KB_4096reclen.rewrite
   4077496 ± 11%     -31.7%    2786662 ±  3%  iozone.32768KB_4096reclen.write
    537403 ±  7%     -26.9%     392679 ±  2%  iozone.32768KB_512reclen
   6382722 ± 14%     -53.0%    2999010 ±  5%  iozone.32768KB_512reclen.frewrite
   6043775 ± 20%     -50.8%    2975689 ±  5%  iozone.32768KB_512reclen.fwrite
   8431834 ±  9%     -55.9%    3715052 ±  3%  iozone.32768KB_512reclen.random_write
  19350771           -76.7%    4499910        iozone.32768KB_512reclen.record_rewrite
   5673691 ± 15%     -49.6%    2860172 ±  3%  iozone.32768KB_512reclen.rewrite
   4695280 ± 17%     -39.0%    2862002 ±  2%  iozone.32768KB_512reclen.write
    516609 ±  8%     -23.8%     393799 ±  2%  iozone.32768KB_64reclen
  13166484 ±  5%     -12.2%   11562108 ±  8%  iozone.32768KB_64reclen.bkwd_read
   5103586 ± 19%     -46.5%    2727942 ±  3%  iozone.32768KB_64reclen.frewrite
   5235240 ± 23%     -46.5%    2801394 ±  3%  iozone.32768KB_64reclen.fwrite
   7279781 ±  6%     -50.6%    3592676 ±  3%  iozone.32768KB_64reclen.random_write
  16991347           -72.9%    4607452        iozone.32768KB_64reclen.record_rewrite
   4910826 ± 14%     -43.0%    2799150 ±  6%  iozone.32768KB_64reclen.rewrite
   4188458 ±  6%     -35.2%    2715386 ±  3%  iozone.32768KB_64reclen.write
    399134 ±  6%     -16.3%     334017 ±  3%  iozone.32768KB_8192reclen
   4890220 ± 10%     -36.2%    3118086 ±  6%  iozone.32768KB_8192reclen.frewrite
   5198365 ±  5%     -36.9%    3281056        iozone.32768KB_8192reclen.fwrite
   6937688 ±  5%     -50.9%    3404642 ±  2%  iozone.32768KB_8192reclen.random_write
   8411000 ±  5%     -58.4%    3497183        iozone.32768KB_8192reclen.record_rewrite
   4886181 ± 10%     -40.6%    2901408 ±  2%  iozone.32768KB_8192reclen.rewrite
   4060328 ± 14%     -29.3%    2869880 ±  6%  iozone.32768KB_8192reclen.write
    547507           -21.3%     431106        iozone.4096KB_1024reclen
   8803122           -47.6%    4608902        iozone.4096KB_1024reclen.frewrite
   8190984 ±  2%     -45.8%    4436387        iozone.4096KB_1024reclen.fwrite
  10046329           -58.1%    4210980 ±  3%  iozone.4096KB_1024reclen.random_write
  12133980           -66.9%    4019665        iozone.4096KB_1024reclen.record_rewrite
   7585382 ±  2%     -51.9%    3651453        iozone.4096KB_1024reclen.rewrite
   6590193 ±  2%     -42.1%    3817964 ±  4%  iozone.4096KB_1024reclen.write
    722013 ±  2%     -23.0%     556038        iozone.4096KB_128reclen
   9524794           -55.3%    4258037 ±  2%  iozone.4096KB_128reclen.frewrite
   9592753           -55.8%    4241299 ±  2%  iozone.4096KB_128reclen.fwrite
  11349709           -60.6%    4473598        iozone.4096KB_128reclen.random_write
  19159156 ±  2%     -75.8%    4638607        iozone.4096KB_128reclen.record_rewrite
   8146349           -53.5%    3789449 ±  3%  iozone.4096KB_128reclen.rewrite
   7034730 ±  3%     -43.2%    3994649 ±  7%  iozone.4096KB_128reclen.write
    531712           -12.5%     465267        iozone.4096KB_16reclen
   6137175           -37.2%    3852128        iozone.4096KB_16reclen.frewrite
   6226631 ±  2%     -37.0%    3921424        iozone.4096KB_16reclen.fwrite
   6427825           -40.2%    3841270        iozone.4096KB_16reclen.random_write
   9153123           -52.9%    4310771        iozone.4096KB_16reclen.record_rewrite
   5642240 ±  2%     -36.1%    3606201        iozone.4096KB_16reclen.rewrite
   4733088 ± 10%     -26.9%    3461604 ±  7%  iozone.4096KB_16reclen.write
    498194           -17.3%     411858        iozone.4096KB_2048reclen
  10061771           -40.7%    5967435        iozone.4096KB_2048reclen.frewrite
   5695122 ±  3%     -29.8%    3999587 ±  2%  iozone.4096KB_2048reclen.fwrite
   8538957           -52.9%    4021716        iozone.4096KB_2048reclen.random_write
   9154121           -57.9%    3852260        iozone.4096KB_2048reclen.record_rewrite
   6784175           -48.7%    3477279        iozone.4096KB_2048reclen.rewrite
   5730945 ±  4%     -37.5%    3583348 ±  4%  iozone.4096KB_2048reclen.write
    799652           -22.1%     622935        iozone.4096KB_256reclen
  10182498           -56.7%    4413478        iozone.4096KB_256reclen.frewrite
  10079537 ±  2%     -56.4%    4398351        iozone.4096KB_256reclen.fwrite
  11431595 ±  5%     -60.7%    4489528        iozone.4096KB_256reclen.random_write
  21136142           -77.9%    4668119        iozone.4096KB_256reclen.record_rewrite
   8432884 ±  2%     -54.4%    3841577        iozone.4096KB_256reclen.rewrite
   7143188 ±  3%     -41.3%    4190914        iozone.4096KB_256reclen.write
    622082           -18.0%     509974        iozone.4096KB_32reclen
   7573420 ±  2%     -47.2%    3997267        iozone.4096KB_32reclen.frewrite
   7723292           -47.7%    4040106 ±  2%  iozone.4096KB_32reclen.fwrite
   8332826           -51.0%    4080432 ±  3%  iozone.4096KB_32reclen.random_write
  13037221           -65.6%    4482760        iozone.4096KB_32reclen.record_rewrite
   6853083 ±  2%     -45.0%    3767795        iozone.4096KB_32reclen.rewrite
   6176004 ±  3%     -34.5%    4044866 ±  2%  iozone.4096KB_32reclen.write
    500859           -18.8%     406662        iozone.4096KB_4096reclen
   8390312           -54.4%    3825195 ±  3%  iozone.4096KB_4096reclen.frewrite
   8363283           -53.3%    3901735        iozone.4096KB_4096reclen.fwrite
   8389951 ±  4%     -52.1%    4022578        iozone.4096KB_4096reclen.random_write
   8597277           -53.3%    4017127        iozone.4096KB_4096reclen.record_rewrite
   6710892           -48.8%    3438657        iozone.4096KB_4096reclen.rewrite
   4836366 ±  3%     -33.0%    3238538        iozone.4096KB_4096reclen.write
   7445582 ±  2%      -4.1%    7142068 ±  2%  iozone.4096KB_4reclen.stride_read
    703788 ±  2%     -23.3%     539608 ±  2%  iozone.4096KB_512reclen
   9674357 ±  2%     -54.1%    4444669        iozone.4096KB_512reclen.frewrite
   9274029           -52.7%    4384389        iozone.4096KB_512reclen.fwrite
  12050340           -62.6%    4509701        iozone.4096KB_512reclen.random_write
  18073626           -75.1%    4502289        iozone.4096KB_512reclen.record_rewrite
   8382898 ±  2%     -53.8%    3874107        iozone.4096KB_512reclen.rewrite
   7020098 ±  8%     -40.0%    4213203        iozone.4096KB_512reclen.write
    680911           -20.5%     541063        iozone.4096KB_64reclen
   8715570 ±  2%     -52.1%    4171282        iozone.4096KB_64reclen.frewrite
   8859582 ±  2%     -53.2%    4142478 ±  4%  iozone.4096KB_64reclen.fwrite
  10038380 ±  2%     -56.8%    4331688        iozone.4096KB_64reclen.random_write
  15765586            -2.9%   15313032        iozone.4096KB_64reclen.read
  16626317           -72.4%    4584815        iozone.4096KB_64reclen.record_rewrite
   7572169 ±  3%     -49.2%    3848094        iozone.4096KB_64reclen.rewrite
   6403648 ±  9%     -38.2%    3959666 ±  5%  iozone.4096KB_64reclen.write
    425985 ±  3%      -6.5%     398362        iozone.4096KB_8reclen
   4504277 ±  4%     -22.2%    3504237        iozone.4096KB_8reclen.frewrite
   4593663 ±  3%     -22.4%    3564791 ±  2%  iozone.4096KB_8reclen.fwrite
  10555094            -3.3%   10208177        iozone.4096KB_8reclen.random_read
   4370705 ±  2%     -26.3%    3220631        iozone.4096KB_8reclen.random_write
   5963939 ±  2%     -33.1%    3989125 ±  2%  iozone.4096KB_8reclen.record_rewrite
   4209124 ±  3%     -21.5%    3303798        iozone.4096KB_8reclen.rewrite
    852407 ±  3%     -16.0%     715694 ±  2%  iozone.512KB_128reclen
  10177118 ±  5%     -50.2%    5068071 ±  4%  iozone.512KB_128reclen.frewrite
  10282951 ±  3%     -50.3%    5106983 ±  3%  iozone.512KB_128reclen.fwrite
  12595570 ± 15%     -61.4%    4865755 ±  2%  iozone.512KB_128reclen.random_write
  16296842           -72.9%    4417265 ±  8%  iozone.512KB_128reclen.record_rewrite
   7757871 ±  3%     -51.1%    3794609 ±  2%  iozone.512KB_128reclen.rewrite
   6638722 ±  3%     -38.9%    4057507 ±  3%  iozone.512KB_128reclen.write
    595458            -9.2%     540559        iozone.512KB_16reclen
   5956064 ±  3%     -34.5%    3903203        iozone.512KB_16reclen.frewrite
   6272496 ±  2%     -37.0%    3949192 ±  2%  iozone.512KB_16reclen.fwrite
   7236243           -43.7%    4075432 ±  3%  iozone.512KB_16reclen.random_write
   8719765           -51.8%    4201307 ±  2%  iozone.512KB_16reclen.record_rewrite
   5446223 ±  2%     -34.1%    3588778 ±  2%  iozone.512KB_16reclen.rewrite
   5142682 ±  5%     -26.0%    3804311 ±  3%  iozone.512KB_16reclen.write
    849114 ±  2%     -15.0%     721716 ±  3%  iozone.512KB_256reclen
  12957952 ±  4%     -46.2%    6969607 ±  2%  iozone.512KB_256reclen.frewrite
   5522956 ±  8%     -25.6%    4110667 ±  5%  iozone.512KB_256reclen.fwrite
  14017494           -65.6%    4822324 ±  6%  iozone.512KB_256reclen.random_write
  16381271           -71.5%    4674505 ±  4%  iozone.512KB_256reclen.record_rewrite
   7501543 ±  4%     -50.6%    3703905 ±  5%  iozone.512KB_256reclen.rewrite
   6216048 ± 13%     -36.3%    3958710 ± 11%  iozone.512KB_256reclen.write
    719626 ±  2%     -11.8%     634484        iozone.512KB_32reclen
   7478304 ±  5%     -44.2%    4170717        iozone.512KB_32reclen.frewrite
   7753337           -45.1%    4258997        iozone.512KB_32reclen.fwrite
   9722852           -53.8%    4495981 ±  3%  iozone.512KB_32reclen.random_write
  11873100 ±  3%     -63.3%    4351978 ±  2%  iozone.512KB_32reclen.record_rewrite
   6544030 ±  5%     -42.7%    3747946        iozone.512KB_32reclen.rewrite
   5826301 ±  6%     -31.0%    4019454 ±  2%  iozone.512KB_32reclen.write
    741696 ±  2%     -15.5%     626927 ±  4%  iozone.512KB_512reclen
   9528590 ± 18%     -55.5%    4237034 ±  4%  iozone.512KB_512reclen.frewrite
  10150088 ± 18%     -57.3%    4333989 ±  4%  iozone.512KB_512reclen.fwrite
  12817906 ±  5%     -64.2%    4585174 ±  7%  iozone.512KB_512reclen.random_write
  11254899 ± 23%     -58.1%    4712207 ±  3%  iozone.512KB_512reclen.record_rewrite
   7774338 ±  5%     -53.4%    3624363 ±  9%  iozone.512KB_512reclen.rewrite
   6771886 ±  2%     -41.1%    3986479 ±  4%  iozone.512KB_512reclen.write
    800056           -13.7%     690201 ±  2%  iozone.512KB_64reclen
   8943767 ±  2%     -49.5%    4519888 ±  2%  iozone.512KB_64reclen.frewrite
   9113029 ±  2%     -49.3%    4618343        iozone.512KB_64reclen.fwrite
  11727579 ±  4%     -59.9%    4707398 ±  4%  iozone.512KB_64reclen.random_write
  14262817 ±  7%     -69.3%    4379665 ±  3%  iozone.512KB_64reclen.record_rewrite
   7189400 ±  2%     -48.1%    3727859 ±  2%  iozone.512KB_64reclen.rewrite
   6324167 ±  3%     -35.8%    4057263 ±  3%  iozone.512KB_64reclen.write
    478105            -4.9%     454663 ±  2%  iozone.512KB_8reclen
   4484121 ±  8%     -21.3%    3529343 ±  2%  iozone.512KB_8reclen.frewrite
   4734724 ±  2%     -22.5%    3667327 ±  2%  iozone.512KB_8reclen.fwrite
   4285637 ±  3%     -21.7%    3354676 ±  3%  iozone.512KB_8reclen.rewrite
   4167376 ±  7%     -16.1%    3497431 ±  4%  iozone.512KB_8reclen.write
    380792           -16.9%     316489        iozone.524288KB_1024reclen
   4182707           -38.2%    2584442        iozone.524288KB_1024reclen.frewrite
   4208045           -38.5%    2586615        iozone.524288KB_1024reclen.fwrite
   4746818           -41.9%    2756626        iozone.524288KB_1024reclen.random_write
  12948563           -69.8%    3914308        iozone.524288KB_1024reclen.record_rewrite
   4186499           -38.2%    2588662        iozone.524288KB_1024reclen.rewrite
   3707293           -27.7%    2680239        iozone.524288KB_1024reclen.write
    431843 ±  4%     -17.4%     356596        iozone.524288KB_128reclen
   4069767 ±  9%     -36.4%    2588593        iozone.524288KB_128reclen.frewrite
   4079706 ±  9%     -36.0%    2611388        iozone.524288KB_128reclen.fwrite
   4379068           -42.5%    2519619        iozone.524288KB_128reclen.random_write
  18466442 ± 14%     -75.0%    4611034        iozone.524288KB_128reclen.record_rewrite
  10592121            +1.7%   10767895        iozone.524288KB_128reclen.reread
   4002754           -37.8%    2491421        iozone.524288KB_128reclen.rewrite
   3627215           -29.8%    2548092 ±  3%  iozone.524288KB_128reclen.write
    347453           -11.4%     307984        iozone.524288KB_16384reclen
   3271528           -34.2%    2151430 ±  4%  iozone.524288KB_16384reclen.frewrite
   3286841           -32.6%    2214421        iozone.524288KB_16384reclen.fwrite
   4625809           -39.7%    2791290        iozone.524288KB_16384reclen.random_write
   8139628 ±  8%     -59.9%    3267021 ±  2%  iozone.524288KB_16384reclen.record_rewrite
   4074653           -36.6%    2584407        iozone.524288KB_16384reclen.rewrite
   3657694           -27.9%    2636561        iozone.524288KB_16384reclen.write
    364883           -13.9%     314183        iozone.524288KB_2048reclen
   8847193            +2.4%    9060472        iozone.524288KB_2048reclen.fread
   4036772           -37.6%    2518570        iozone.524288KB_2048reclen.frewrite
   4055761           -37.3%    2541319        iozone.524288KB_2048reclen.fwrite
   4648856           -40.5%    2767063        iozone.524288KB_2048reclen.random_write
  10209277           -63.8%    3700146        iozone.524288KB_2048reclen.record_rewrite
   4120405           -37.4%    2580251        iozone.524288KB_2048reclen.rewrite
   3687354 ±  2%     -27.5%    2673004        iozone.524288KB_2048reclen.write
    431784 ±  8%     -14.7%     368311        iozone.524288KB_256reclen
   4061568 ± 12%     -34.3%    2667748        iozone.524288KB_256reclen.frewrite
   4089031 ± 13%     -34.6%    2675433        iozone.524288KB_256reclen.fwrite
   4153039 ± 13%     -37.7%    2586336        iozone.524288KB_256reclen.random_write
  21061999           -77.9%    4663314        iozone.524288KB_256reclen.record_rewrite
   9644476 ± 11%     +13.5%   10947927        iozone.524288KB_256reclen.reread
   3957096 ±  8%     -36.9%    2498077        iozone.524288KB_256reclen.rewrite
   3708958           -29.7%    2607600        iozone.524288KB_256reclen.write
    365403           -13.8%     314900        iozone.524288KB_4096reclen
   4018347           -36.9%    2537033        iozone.524288KB_4096reclen.frewrite
   4064270           -37.3%    2549563        iozone.524288KB_4096reclen.fwrite
   4663198           -40.3%    2784744        iozone.524288KB_4096reclen.random_write
  10057156           -63.1%    3715403        iozone.524288KB_4096reclen.record_rewrite
   4154963           -38.3%    2561944        iozone.524288KB_4096reclen.rewrite
   3733178           -28.7%    2662798        iozone.524288KB_4096reclen.write
    445806           -19.5%     358905        iozone.524288KB_512reclen
   4455258           -38.9%    2723386        iozone.524288KB_512reclen.frewrite
   4529424           -39.7%    2732012        iozone.524288KB_512reclen.fwrite
   4728030           -42.8%    2702810        iozone.524288KB_512reclen.random_write
  19417290 ±  3%     -76.9%    4494683        iozone.524288KB_512reclen.record_rewrite
   4252001 ±  2%     -40.2%    2543611        iozone.524288KB_512reclen.rewrite
   3748274 ±  5%     -28.2%    2690289 ±  2%  iozone.524288KB_512reclen.write
    416154           -16.7%     346626        iozone.524288KB_64reclen
   4097421           -37.7%    2552856        iozone.524288KB_64reclen.frewrite
   4114763           -36.9%    2597729        iozone.524288KB_64reclen.fwrite
   4059909           -41.4%    2380185 ±  4%  iozone.524288KB_64reclen.random_write
  16909664           -73.5%    4487795 ±  5%  iozone.524288KB_64reclen.record_rewrite
   3885305           -36.0%    2484738        iozone.524288KB_64reclen.rewrite
   3485125 ±  2%     -26.4%    2565242        iozone.524288KB_64reclen.write
    361507           -13.0%     314496        iozone.524288KB_8192reclen
   8751425            +3.3%    9044435        iozone.524288KB_8192reclen.bkwd_read
   4021932           -37.3%    2519798        iozone.524288KB_8192reclen.frewrite
   4029210           -37.4%    2520367        iozone.524288KB_8192reclen.fwrite
   4624949           -39.6%    2792755        iozone.524288KB_8192reclen.random_write
   9824162           -63.5%    3588696 ±  2%  iozone.524288KB_8192reclen.record_rewrite
   4113266           -37.5%    2569105        iozone.524288KB_8192reclen.rewrite
   8840507            +2.6%    9069156        iozone.524288KB_8192reclen.stride_read
   3695751           -27.7%    2670870        iozone.524288KB_8192reclen.write
   4652673 ± 24%     -48.2%    2411724 ± 38%  iozone.64KB_16reclen.random_write
   6124949 ±  6%     -44.5%    3402157 ±  5%  iozone.64KB_16reclen.record_rewrite
   4690498 ±  4%     -34.5%    3072246 ± 14%  iozone.64KB_16reclen.rewrite
   7132382 ± 15%     -48.9%    3642362 ±  6%  iozone.64KB_32reclen.record_rewrite
   8120162 ±  6%     -54.2%    3720855 ± 19%  iozone.64KB_64reclen.random_write
   8267460 ±  6%     -50.1%    4125200 ±  4%  iozone.64KB_64reclen.record_rewrite
   4581532 ± 17%     -39.5%    2769666 ± 19%  iozone.64KB_64reclen.write
   4691011           -35.0%    3050516 ± 20%  iozone.64KB_8reclen.record_rewrite
   4003729 ±  4%     -27.2%    2915760 ± 11%  iozone.64KB_8reclen.rewrite
   3360656 ±  3%     -14.1%    2885464 ±  5%  iozone.64KB_8reclen.write
    402591 ±  2%     -20.6%     319718        iozone.65536KB_1024reclen
   9791995 ±  2%      -3.8%    9416697 ±  3%  iozone.65536KB_1024reclen.freread
   4307101           -39.1%    2621644        iozone.65536KB_1024reclen.frewrite
   4498761 ±  4%     -41.9%    2615383        iozone.65536KB_1024reclen.fwrite
   5660509 ±  4%     -48.7%    2902944        iozone.65536KB_1024reclen.random_write
  12809725 ±  2%     -69.4%    3916498        iozone.65536KB_1024reclen.record_rewrite
   9776019 ±  5%      -8.1%    8988945 ±  2%  iozone.65536KB_1024reclen.reread
   4350957 ±  2%     -39.4%    2638716        iozone.65536KB_1024reclen.rewrite
   3974207 ±  5%     -31.6%    2718382        iozone.65536KB_1024reclen.write
    473239 ±  4%     -21.9%     369705 ±  2%  iozone.65536KB_128reclen
   4377096 ±  2%     -39.5%    2647855        iozone.65536KB_128reclen.frewrite
   4729920 ±  9%     -43.2%    2684971        iozone.65536KB_128reclen.fwrite
   5468735 ±  5%     -46.9%    2903721        iozone.65536KB_128reclen.random_write
  19818575           -76.5%    4652744        iozone.65536KB_128reclen.record_rewrite
   4213942 ±  2%     -38.8%    2580789        iozone.65536KB_128reclen.rewrite
   3959940 ±  5%     -33.7%    2627238        iozone.65536KB_128reclen.write
    339441 ±  2%     -14.9%     288777 ±  2%  iozone.65536KB_16384reclen
   3836114           -29.5%    2705330        iozone.65536KB_16384reclen.frewrite
   4026876 ±  2%     -32.6%    2713650 ±  5%  iozone.65536KB_16384reclen.fwrite
   5066003 ±  2%     -42.3%    2921152 ±  2%  iozone.65536KB_16384reclen.random_write
   6647502           -53.6%    3084275        iozone.65536KB_16384reclen.record_rewrite
   4000380           -37.0%    2520062 ±  2%  iozone.65536KB_16384reclen.rewrite
   3689062 ±  4%     -29.9%    2585183        iozone.65536KB_16384reclen.write
    381408 ±  3%     -17.2%     315791        iozone.65536KB_2048reclen
   4150052 ±  2%     -38.2%    2562800 ±  3%  iozone.65536KB_2048reclen.frewrite
   4366399 ±  5%     -40.6%    2594992        iozone.65536KB_2048reclen.fwrite
   5459554 ±  5%     -46.4%    2928750        iozone.65536KB_2048reclen.random_write
   9999409           -63.3%    3665495        iozone.65536KB_2048reclen.record_rewrite
   4323040 ±  2%     -39.5%    2616028        iozone.65536KB_2048reclen.rewrite
   3975298 ±  4%     -31.6%    2719542 ±  2%  iozone.65536KB_2048reclen.write
    493925 ±  3%     -23.3%     379052        iozone.65536KB_256reclen
   4618908 ±  2%     -40.7%    2739839        iozone.65536KB_256reclen.frewrite
   4878676 ±  8%     -43.8%    2742467        iozone.65536KB_256reclen.fwrite
   5543513 ±  7%     -47.5%    2911964 ±  2%  iozone.65536KB_256reclen.random_write
  21674869           -78.3%    4703546        iozone.65536KB_256reclen.record_rewrite
   4316073 ±  2%     -40.6%    2561615 ±  2%  iozone.65536KB_256reclen.rewrite
   4091194 ±  8%     -34.4%    2685829 ±  3%  iozone.65536KB_256reclen.write
    386466 ±  3%     -16.4%     322996        iozone.65536KB_4096reclen
   4262068           -38.7%    2613308 ±  2%  iozone.65536KB_4096reclen.frewrite
   4246013 ±  2%     -37.8%    2639126        iozone.65536KB_4096reclen.fwrite
   5377536 ±  2%     -46.7%    2868163 ±  5%  iozone.65536KB_4096reclen.random_write
   9619397           -62.4%    3619658        iozone.65536KB_4096reclen.record_rewrite
   4295062 ±  2%     -39.2%    2609899        iozone.65536KB_4096reclen.rewrite
   3873263 ±  4%     -29.3%    2737042 ±  2%  iozone.65536KB_4096reclen.write
    471489           -23.1%     362778 ±  2%  iozone.65536KB_512reclen
   4719039 ±  2%     -41.0%    2786233        iozone.65536KB_512reclen.frewrite
   4941073 ±  6%     -44.5%    2744267 ±  2%  iozone.65536KB_512reclen.fwrite
   5763651 ±  6%     -47.5%    3027789 ±  2%  iozone.65536KB_512reclen.random_write
  19424730 ±  3%     -76.7%    4531186        iozone.65536KB_512reclen.record_rewrite
   4506592 ±  2%     -41.0%    2657102        iozone.65536KB_512reclen.rewrite
   4278222 ±  6%     -35.5%    2758807 ±  2%  iozone.65536KB_512reclen.write
    450461 ±  2%     -21.4%     354159 ±  3%  iozone.65536KB_64reclen
   4245088 ±  3%     -39.9%    2551044 ±  5%  iozone.65536KB_64reclen.frewrite
   4472056 ±  7%     -39.1%    2721937 ±  2%  iozone.65536KB_64reclen.fwrite
   5105996 ±  5%     -44.1%    2852003        iozone.65536KB_64reclen.random_write
  16847036 ±  2%     -72.5%    4626346        iozone.65536KB_64reclen.record_rewrite
   4068751           -36.8%    2569793        iozone.65536KB_64reclen.rewrite
   3761778 ±  4%     -29.8%    2640634 ±  6%  iozone.65536KB_64reclen.write
    374899 ±  2%     -16.6%     312721        iozone.65536KB_8192reclen
   4248877 ±  3%     -35.4%    2744762 ±  2%  iozone.65536KB_8192reclen.frewrite
   4347033 ±  2%     -36.0%    2782983        iozone.65536KB_8192reclen.fwrite
   5102401 ±  2%     -42.7%    2923845        iozone.65536KB_8192reclen.random_write
   9046426           -60.9%    3535553        iozone.65536KB_8192reclen.record_rewrite
   4181552           -37.9%    2598768        iozone.65536KB_8192reclen.rewrite
   3725325 ±  5%     -27.6%    2698126        iozone.65536KB_8192reclen.write
    541652           -21.0%     427956        iozone.8192KB_1024reclen
   7588814 ±  2%     -47.4%    3994097        iozone.8192KB_1024reclen.frewrite
   7082574 ±  4%     -44.9%    3904631        iozone.8192KB_1024reclen.fwrite
  10345367           -58.8%    4265061 ±  2%  iozone.8192KB_1024reclen.random_write
  12687343 ±  4%     -68.1%    4044617        iozone.8192KB_1024reclen.record_rewrite
   7671323           -52.6%    3637718 ±  2%  iozone.8192KB_1024reclen.rewrite
   6403719           -40.0%    3843378 ±  2%  iozone.8192KB_1024reclen.write
    715385           -21.7%     559829 ±  2%  iozone.8192KB_128reclen
   9492398           -55.1%    4265155        iozone.8192KB_128reclen.frewrite
   9583339           -55.2%    4294686        iozone.8192KB_128reclen.fwrite
  10948189           -59.5%    4439434        iozone.8192KB_128reclen.random_write
  19822925           -76.5%    4666594        iozone.8192KB_128reclen.record_rewrite
   8024183 ±  2%     -51.5%    3895607        iozone.8192KB_128reclen.rewrite
   6726543 ±  3%     -38.9%    4111241 ±  2%  iozone.8192KB_128reclen.write
    529512           -12.8%     461764        iozone.8192KB_16reclen
  12713193 ±  2%      -2.4%   12403682        iozone.8192KB_16reclen.bkwd_read
   6142090 ±  2%     -37.0%    3869305        iozone.8192KB_16reclen.frewrite
   6202098           -36.7%    3924276        iozone.8192KB_16reclen.fwrite
   6298580           -40.0%    3782064        iozone.8192KB_16reclen.random_write
   9019398 ±  4%     -51.7%    4356552        iozone.8192KB_16reclen.record_rewrite
   5739034           -37.1%    3608220        iozone.8192KB_16reclen.rewrite
   5319076 ±  3%     -30.9%    3677574 ±  6%  iozone.8192KB_16reclen.write
    497042           -19.9%     398208 ±  2%  iozone.8192KB_2048reclen
   7599511 ±  2%     -53.0%    3568886 ± 26%  iozone.8192KB_2048reclen.frewrite
   7063907           -43.2%    4012680 ±  2%  iozone.8192KB_2048reclen.fwrite
   8661047           -57.6%    3676566 ± 18%  iozone.8192KB_2048reclen.random_write
   9853000           -61.9%    3752285        iozone.8192KB_2048reclen.record_rewrite
   6834824           -49.3%    3465809        iozone.8192KB_2048reclen.rewrite
   5745400 ±  5%     -37.6%    3585810 ±  2%  iozone.8192KB_2048reclen.write
    733833 ±  2%     -23.5%     561035 ±  2%  iozone.8192KB_256reclen
   9868867 ±  2%     -56.1%    4335083        iozone.8192KB_256reclen.frewrite
   9962499           -56.7%    4309833 ±  2%  iozone.8192KB_256reclen.fwrite
  11554593           -61.1%    4490540        iozone.8192KB_256reclen.random_write
  21283509           -77.9%    4705744        iozone.8192KB_256reclen.record_rewrite
   8183994 ±  5%     -52.0%    3931252        iozone.8192KB_256reclen.rewrite
   6826489 ±  9%     -39.7%    4119292 ±  4%  iozone.8192KB_256reclen.write
    616178 ±  2%     -17.3%     509351 ±  2%  iozone.8192KB_32reclen
   7607962 ±  2%     -47.0%    4028488        iozone.8192KB_32reclen.frewrite
   7723721           -47.1%    4089104        iozone.8192KB_32reclen.fwrite
   8246685           -49.9%    4127517        iozone.8192KB_32reclen.random_write
  14882779 ±  2%      -3.8%   14313397 ±  3%  iozone.8192KB_32reclen.read
  13176393           -65.8%    4512706        iozone.8192KB_32reclen.record_rewrite
   6905286 ±  2%     -45.3%    3777504        iozone.8192KB_32reclen.rewrite
   6136280 ±  4%     -36.1%    3919141 ±  2%  iozone.8192KB_32reclen.write
    480910 ±  3%     -18.6%     391551        iozone.8192KB_4096reclen
   9029468 ±  7%     -43.0%    5145507 ±  3%  iozone.8192KB_4096reclen.frewrite
   4898402 ±  3%     -24.6%    3693143 ±  7%  iozone.8192KB_4096reclen.fwrite
   8547116           -54.0%    3929360        iozone.8192KB_4096reclen.random_write
   9254872           -59.3%    3769732        iozone.8192KB_4096reclen.record_rewrite
   6569113 ±  2%     -49.7%    3303761        iozone.8192KB_4096reclen.rewrite
   5563031 ±  2%     -39.3%    3374003 ±  3%  iozone.8192KB_4096reclen.write
   3440021            +2.4%    3522588        iozone.8192KB_4reclen.record_rewrite
    711208 ±  2%     -23.9%     541401 ±  3%  iozone.8192KB_512reclen
   9320610           -55.0%    4196921 ±  2%  iozone.8192KB_512reclen.frewrite
   8957011           -53.4%    4174983        iozone.8192KB_512reclen.fwrite
  11809259           -62.1%    4476670 ±  2%  iozone.8192KB_512reclen.random_write
  18829929           -76.1%    4508938        iozone.8192KB_512reclen.record_rewrite
   8411175 ±  3%     -53.8%    3887441        iozone.8192KB_512reclen.rewrite
   7166144 ±  2%     -44.7%    3959966 ±  3%  iozone.8192KB_512reclen.write
    675616 ±  2%     -19.9%     541307 ±  2%  iozone.8192KB_64reclen
   8613899 ±  4%     -51.6%    4172567        iozone.8192KB_64reclen.frewrite
   8822220 ±  2%     -52.4%    4202922        iozone.8192KB_64reclen.fwrite
   9695269 ±  4%     -55.4%    4319618        iozone.8192KB_64reclen.random_write
  16652653           -72.5%    4584103        iozone.8192KB_64reclen.record_rewrite
   7647358 ±  2%     -49.8%    3838600        iozone.8192KB_64reclen.rewrite
   6513828 ±  5%     -38.2%    4025626 ±  4%  iozone.8192KB_64reclen.write
    461761 ±  4%     -22.1%     359687        iozone.8192KB_8192reclen
   7795996 ±  6%     -54.3%    3564917        iozone.8192KB_8192reclen.frewrite
   7654999 ±  6%     -54.5%    3479801 ±  2%  iozone.8192KB_8192reclen.fwrite
   8520759           -54.0%    3918730        iozone.8192KB_8192reclen.random_write
   8157000 ±  3%     -55.0%    3671143        iozone.8192KB_8192reclen.record_rewrite
   6177989 ±  5%     -49.5%    3119569 ±  2%  iozone.8192KB_8192reclen.rewrite
   4416235 ±  5%     -34.4%    2896523 ±  3%  iozone.8192KB_8192reclen.write
    439124 ±  2%      -7.6%     405667        iozone.8192KB_8reclen
   4698260           -23.2%    3610275        iozone.8192KB_8reclen.frewrite
   4768517           -23.2%    3660266        iozone.8192KB_8reclen.fwrite
   4380191           -25.2%    3277166 ±  2%  iozone.8192KB_8reclen.random_write
   6126524           -33.0%    4104360        iozone.8192KB_8reclen.record_rewrite
   4439028           -22.8%    3425308        iozone.8192KB_8reclen.rewrite
   4266167 ±  5%     -20.0%    3412028 ±  2%  iozone.8192KB_8reclen.write
   5162798           -16.0%    4334478        iozone.average_KBps
  60901246 ±  3%     -43.0%   34701299        iozone.frewrite_KBps
  57283573 ±  3%     -42.0%   33239682        iozone.fwrite_KBps
  70165219           -50.7%   34625385        iozone.random_write_KBps
 1.178e+08           -66.3%   39658202        iozone.record_rewrite_KBps
  52267713 ±  2%     -42.3%   30152206        iozone.rewrite_KBps
      5.00           +20.0%       6.00        iozone.time.percent_of_cpu_this_job_got
     59.48           +27.4%      75.76        iozone.time.system_time
    390341 ± 16%     +40.8%     549598 ±  9%  iozone.time.voluntary_context_switches
  45439615 ±  3%     -32.4%   30728676        iozone.write_KBps




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


