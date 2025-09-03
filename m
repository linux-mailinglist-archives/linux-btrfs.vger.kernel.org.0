Return-Path: <linux-btrfs+bounces-16613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAABB418F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18124204943
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123E2EC553;
	Wed,  3 Sep 2025 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ekm4HIKI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4962EBDD9;
	Wed,  3 Sep 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889105; cv=fail; b=BXOqigA815DP4F6B0V2oGO9EI87jRQ7ak2Dierf+TWwAeYR+hmteqFfml8ViL9+ncYX+hUB2tNSNQ2iA3Rs9m/xRCSPNgmqC+EX1Z6cBNMB8IiSEgD6D53gHOsCJziLumE+khSHtQggyhJIM9EKazuZ3Dxrb3QGNI16traQzDP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889105; c=relaxed/simple;
	bh=CR3VvePPHuoWwHDALkQkXxaUs63CQFSzJnw15mnaWF8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YS8krh7cKVOUIPE/6PNfWjm28lGQwFfPLR4axLLQwByLR9zT5WBUFfXwuCScSGGSI7x9eTpOoI8rLxM6k1T+7cYyDJpjRbzWpAXwFG88P6CaiyCEJ+ZrlR5qnzCuvxkfh2Gm2M+kMS3HWg3pKUN1anqBYrbX2sle+gLoC3bqWMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ekm4HIKI; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756889103; x=1788425103;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=CR3VvePPHuoWwHDALkQkXxaUs63CQFSzJnw15mnaWF8=;
  b=Ekm4HIKIMe6ftCuDVXby0HbKKA6i9eoEqcOY5H3KC9fiqJYbEWm8X1tK
   lxOFCS5TKGiWoC8KO/8lHxNLlANVoAkSTnkszT8NIckIrXUBzaI2g88QW
   TnvTSWeNeEOS9wBqtToxLlgL33Qqzai94+3NeSJQmar/AmKWL5D7ULDvz
   Sq0LjWsmfk+tmV7LwTSJs4xtT3yzDCqJBDtg8gHhF62zaetvU+hAR5pPK
   9DAFUY996fluS6T0JNTjx4VkbaAvxHLfZ739SEe5fsOJFg0yO1op3K+wN
   XFN8JwuR735KCRVaWJpa1As8w9fU7grD4KQiAqEHa6KwRR+HNKjU3ppi2
   g==;
X-CSE-ConnectionGUID: 2kzj6vaeSCKu3P4ae1o7kA==
X-CSE-MsgGUID: SQ8PdKXJTyOCw0P3QNXT4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58226144"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58226144"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:45:02 -0700
X-CSE-ConnectionGUID: 782A1npxR0iw+nwqntKVtA==
X-CSE-MsgGUID: KXMhuM5+Sy2lX/hoTicvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171902626"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:45:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:45:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 01:45:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 01:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmAJ+pyznDO1df1Oc0eSsZwYACvSaucXq7BVR1EgXt7aNiCl8fOKETwWRJfAMeHBMAOjrHWR2eeBDETqQJnQeS4tJR7dlbuCRPuB+e2wwO9QBQhO9PYzA5ADoU+iPK+a6pn4oK+QhX3FEnV94DcdOZyO8fhXPHqUWUYtm/W0N+/lk/yChqv/xZgpuoX2F+8ECztA1lBFMAaQHGrqVy5VX6ve8n9qddepvGxo+fe09e6Dm05izsIPR+toI/I3VcGXdkplbYJtk74OM6+SUgDwFKEcuxakYeHK2DzZJIrzf6vfr3Ze0jCAqPYKKN+huZU4WE2GEx5R6NaQEVzqDkyAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq0aABiBD7T/EJGRLgBHxk0KYHfA3665cg/nsGPMJx0=;
 b=iQwi6+mRqbUY68fiBqplGECp8eHO5inSj5KEsm9b5DCGIIAJZIuJ2R+sx2csbum5j2hE9pthKzwkH6wrUHEmomzKAsmRXk6ZPO6H6Cawz1FIIFZ3Ldb/GbDnA0gUgCcUtSKbV8bs9DQ/XdkVNA8II7xuuRbLDvOuBzRripERaM9f8nIAcD72/u2pR8WkaDbyiAIQwrT5YKHEYPxXv56aZzKybW1Q5utVBEYmaikxtudCU7jqvNGOQjy8/XKhCn1NZKzVqnq1UidC/GuYScNERDL5Pn6m4FiO9rYchg/4zoxwrXY6vVBbG+TzLyczTcdHwxY6nIfp11pv+K09w/ZFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6487.namprd11.prod.outlook.com (2603:10b6:930:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 3 Sep
 2025 08:44:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:44:58 +0000
Date: Wed, 3 Sep 2025 16:44:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  bddf57a707:  stress-ng.sync-file.ops_per_sec
 44.2% regression
Message-ID: <202509031643.303d114c-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f928c5-6965-41aa-e7f1-08ddeac629f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5BcKRIWsxXuMwOaC8lpIyZZ8pe6BCFCzfJkYD1x7eoRx7/GXn8Zyqxx/4n?=
 =?iso-8859-1?Q?QneCkhWkJly/i2vldiLx5wEAzDwmE39W896cJLdAlXKHH0awsV3RvNxQv3?=
 =?iso-8859-1?Q?f5oDumQYpsscRRI+0Q+bwO7Z6Eptq0JdPf9VvGOZh5bTqcVRSReri5tCv2?=
 =?iso-8859-1?Q?JobA+gpq/DulQwbWXdy76Bwx66FO8z7ZXyxqSsKv5xmkEJ2Dcz0zuL+9hH?=
 =?iso-8859-1?Q?YM50ZAitf2vTpaIPdii9E8gY2wQO3s5EXKc2BzNFHbQ891pNV95701GiUy?=
 =?iso-8859-1?Q?XrgAnhT5aPbzU4xszvFo0M/aGdWMdyBARKRLix0MIUVGowI+DUFrCgO3tF?=
 =?iso-8859-1?Q?dMahGE5AR2t0adIaRAKcdch3BQS+Uoq9vFgi2jhFy2LnYXznx2JdzkPXkr?=
 =?iso-8859-1?Q?DA1aYMY3sj3otkDwygc1Ay+jxjlhp9Lt7rlqfJhXgWMifs/e6KPxHdzIap?=
 =?iso-8859-1?Q?9ZP6JYI2IhojUQF2/U5wEluiMZkezuk5/zHrQPp36n8/u3MZZ1JXd8vqgB?=
 =?iso-8859-1?Q?L+8nM3AJLAsI2Bi/a0Zt+nf+X9w1Veke+hYQUPM7hDjWCvMylSI9ajTp8F?=
 =?iso-8859-1?Q?fmV2QTnAS/0dzw+/A6jEcCV7b8Tl7Q1xLNGxO0anGfvmmCac7EqX3D0xjc?=
 =?iso-8859-1?Q?hF6x34t+SMwUNucYTHoKQ+yHuu5zVgl/FnQUTakKqhX3J6OTJZcsckyCdv?=
 =?iso-8859-1?Q?I2NkQMNHXkvZ3bMpmpFxTILzqUM2lh6QIZrfW/vMTLpoV7amxVluOnz5Zq?=
 =?iso-8859-1?Q?0707UMl+Sq0K0Tu99G8bTfFnh+Hc+hObqjYIVOraoHN97vFmutuYxfx4tB?=
 =?iso-8859-1?Q?hle9EeNvIn8oQCP5FX+w+yTqFT8ltC+vIZduItJuU+h/JrwEUSnGIABnzN?=
 =?iso-8859-1?Q?C8hGfUeujv0e8DqLrWJtobgnDjAadbblXcv/+NHSGf71tzR99AGD4uRDTs?=
 =?iso-8859-1?Q?JmA9U/qJtEs312Zk/EBMhFXJwdm7fW7IV5ZJum4R5quiepdOWTqkjjvYBA?=
 =?iso-8859-1?Q?QWPQmq2hDHxpeE/KTrXL85uYN8bCwDDQj9rG+MS6gLnvLSAPK/+Hvr9egz?=
 =?iso-8859-1?Q?4yAgEPrzukNS1Cdtd1rDWliUp5YtzL0+KmSTOMiiraBG6tbBFwpXBHEt1Q?=
 =?iso-8859-1?Q?et1fUgBMxFz3MjRt15WgY1EZdS3C5vl8nNeXx42Bp4u3oOv2n1XAPWkrM3?=
 =?iso-8859-1?Q?r4/kS4/+oxKmomMBEtmql5LgTN9n/zZ/ggI3yyDsG5xM47ZMhiSp3zTbTq?=
 =?iso-8859-1?Q?bZcqVcyC3AJj7NaOcXSsiGmQIiU9C4/PxL6QJGoE+4qzNzTyhetUEdMAp8?=
 =?iso-8859-1?Q?3qdJUdKKg4u0UTyNLHqBd5uvZLSpSX/N5XwFqSgAOMKYx9uJf7kTCg/9FV?=
 =?iso-8859-1?Q?7nS1U4tBkGsLFfjhgMVw7DxN+Oh59utAcGz16Hscx9J3UuGKSTCMwK6zDt?=
 =?iso-8859-1?Q?JiRIi6q7huG0TYrd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XAJKNGM55MLbExRNAH3d5gIDlFyWEKiQL3gzbXTWoX24eSEJVtOpmxKmss?=
 =?iso-8859-1?Q?HzYrnnicUg4LIqZhbYXHrM6ySdHJ2VdyYO4v8gnBHiFJyHnHSfNjmi9ZYy?=
 =?iso-8859-1?Q?2v3thnKednnKx0tWCCqDd60Bd4Fsdb/U8yUCiDd8OVtC2esXIS8pcUMs+M?=
 =?iso-8859-1?Q?U/JVQK35S1WaywBQXqSTHaYMVEeJNmbIp9vLPYT22ySJCU6WdJc+dHVcrH?=
 =?iso-8859-1?Q?sydGcM3NRLbLZ+1AcXThma6vdv74viVcJ4VxkflF/R4b80TovUN8fs4HJx?=
 =?iso-8859-1?Q?j2ksavnjqyVC4XoCiqXgt9J/uz353dWyJ/zKIvG7UK5+c2jvMDGfDBrOtv?=
 =?iso-8859-1?Q?KsCiKARIwE48rRtdpDoaMbmy+G1/Ev7+XvVcKvfbORWYOEBYw3nHHA2ICs?=
 =?iso-8859-1?Q?VAU5nnb3C6XhS8ce3kNqWy1AdKPhdQUCZFfa1bmHVK/oQGSQ+pTzfDzcJS?=
 =?iso-8859-1?Q?x1TgcS/504y2+RngGhpsFmb49VyCM7zK0udebCc1y3+b24xgNRRy8Ef92Y?=
 =?iso-8859-1?Q?YlOggIP4kvPlIG/8BNe5iG4F3bCbXAFbboL+gpqLHWraDAI0XYIJde4O4d?=
 =?iso-8859-1?Q?sfibkmFDF/WoRYAFJPhG/69Mrtj3SrVE9me4yXi4QVFf+xG/AaLJuEjOaK?=
 =?iso-8859-1?Q?VZbdLWiEbUHhTYqHBbMTn8blb/SEA6YR/tN1RzaUlVjOqtQ5ACad14epbP?=
 =?iso-8859-1?Q?m0U02wct0dQcEXH5tt1lSmheXXW2Dko/zVu6ABIZFzQZ9qp9CgJjjqJGwU?=
 =?iso-8859-1?Q?93eUCTW4f1IgRhcUIP9mSZpI7qGSW9FncOoRfzeUXHZqnqvIenKpE6cW1R?=
 =?iso-8859-1?Q?kA1C0lPsX3bS2gYIfFZ5b46vk3sLOHqQgNXKe31xU2CWwLi8NVAIjb4mvY?=
 =?iso-8859-1?Q?DckMYEt6kjEglx73noZhnB0MuOulx+xhCTxDybTeU82O5jRDPZP6+gWJmn?=
 =?iso-8859-1?Q?7HKqbW+YGmOxtOnR2Xp4VH3rLEZPE0lmkrHiJYrq6jxqCQW+mMWFgipRp4?=
 =?iso-8859-1?Q?DbH47dYuK8zoBfiJYYjFGleeW8JVkW7dQQPeOuRkrviuE2nHX4kZVG+lfk?=
 =?iso-8859-1?Q?T/ELQON9GC1bha7seV4wFaTHPZvD7EqRI9M+bhSR7R+BrtNPROLXhm3Z4M?=
 =?iso-8859-1?Q?P+K3zC8biEr7+SFsKkio5KCdMX1nn2NGsm4gE/tpykHxj0+yHhNcViYAbs?=
 =?iso-8859-1?Q?+HeKY9egJs5GNE0pmTkOo784EIt7L7UHwv8qf+i34xARpxDwISu0PGhT6P?=
 =?iso-8859-1?Q?sfm9NOxfF6N8nr2CgJVOXq2ViAPVmpFo7Qvw8jlQGN3YWMQtpMAc3V6mvU?=
 =?iso-8859-1?Q?9nPZo6unLhQuuvtbBljVWNk2l4XSK+PLgRw7B+GQuNsO06fQ5g3I4XFaAo?=
 =?iso-8859-1?Q?rPo7RNkU1wh9IbZ2gVml7ABM5HwXTSpRVwCBY2xM/MRTnjumltcGd4lbx5?=
 =?iso-8859-1?Q?Bg2v4Tf3ffMTMWewnOakrY9i+DpPMa/jM8ZHuiGO9iLb32GKlOJFhTJePM?=
 =?iso-8859-1?Q?qIXrtbaTMuDM8QcQC2RC3MSScKXjZaQmzddnXds42almd2mXkLLBC1xyIa?=
 =?iso-8859-1?Q?4iVR24XWOktnfWe/MAWlWcjDql6vpgVFmldsB2dBFTvKiA3VSUmwT8DHDF?=
 =?iso-8859-1?Q?idp2LJkNQA29M/m1BkqOGrFvPK/ivOzg1e5BX8HtjSOQaQ0RWGFwj0tA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f928c5-6965-41aa-e7f1-08ddeac629f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:44:58.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a87eUh7qL1CBu/8qCj0obJVoB+VUxgzIBtGfVDZUocfon9DmZrMWMKjqQggclhxWvFAI54SqH3qRllf9JMf9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6487
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed a 44.2% regression of stress-ng.sync-file.ops_per_sec on:


commit: bddf57a70781ef8821d415200bdbcb71f443993a ("btrfs: delay btrfs_open_devices() until super block is created")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on      linus/master fb679c832b6497f19fffb8274c419783909c0912]
[still regression on linux-next/master 3cace99d63192a7250461b058279a42d91075d0c]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: sync-file
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509031643.303d114c-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250903/202509031643.303d114c-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/sync-file/stress-ng/60s

commit: 
  de339cbfb4 ("btrfs: call bdev_fput() to reclaim the blk_holder immediately")
  bddf57a707 ("btrfs: delay btrfs_open_devices() until super block is created")

de339cbfb4027957 bddf57a70781ef8821d415200bd 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1885182 ±  2%     -35.0%    1226241        cpuidle..usage
      1.35 ±  3%     +26.8%       1.71 ± 31%  iostat.cpu.iowait
    114330           -10.0%     102922        meminfo.Shmem
     17680 ±  2%     -39.7%      10656 ±  2%  vmstat.system.cs
     32084 ±  3%     -33.6%      21290 ±  2%  vmstat.system.in
      0.08 ±  2%      -0.0        0.05 ±  2%  mpstat.cpu.all.irq%
      0.03 ±  6%      -0.0        0.02 ±  5%  mpstat.cpu.all.soft%
      0.66 ±  3%      -0.2        0.45 ±  2%  mpstat.cpu.all.sys%
    311692 ±  9%     -17.9%     255869 ± 12%  numa-numastat.node0.numa_hit
    304181 ±  8%     -24.2%     230456 ± 20%  numa-numastat.node1.local_node
    331109 ±  6%     -19.3%     267048 ± 11%  numa-numastat.node1.numa_hit
    311531 ±  9%     -17.9%     255766 ± 13%  numa-vmstat.node0.numa_hit
    330584 ±  6%     -19.3%     266623 ± 10%  numa-vmstat.node1.numa_hit
    303656 ±  8%     -24.2%     230030 ± 20%  numa-vmstat.node1.numa_local
     59.00 ± 13%     -41.5%      34.50 ± 10%  perf-c2c.DRAM.local
      1139 ±  4%     -46.1%     613.67 ±  5%  perf-c2c.DRAM.remote
      1254 ±  5%     -45.3%     686.50 ±  2%  perf-c2c.HITM.local
    681.33 ±  3%     -45.8%     369.50 ±  6%  perf-c2c.HITM.remote
      1.33 ± 41%     -93.8%       0.08 ±223%  sched_debug.cfs_rq:/.runnable_avg.min
      1.33 ± 41%     -93.8%       0.08 ±223%  sched_debug.cfs_rq:/.util_avg.min
     10502           -34.4%       6886        sched_debug.cpu.nr_switches.avg
      8094 ±  2%     -41.8%       4710 ±  2%  sched_debug.cpu.nr_switches.min
     21146 ±  2%     -44.2%      11809        stress-ng.sync-file.ops
    352.20 ±  2%     -44.2%     196.65        stress-ng.sync-file.ops_per_sec
     34.00 ±  2%     -43.6%      19.17        stress-ng.time.percent_of_cpu_this_job_got
     20.20 ±  2%     -43.6%      11.38        stress-ng.time.system_time
    513054 ±  2%     -45.5%     279629        stress-ng.time.voluntary_context_switches
     28437           -10.3%      25522        proc-vmstat.nr_shmem
     25303            -1.0%      25040        proc-vmstat.nr_slab_reclaimable
    644388           -18.6%     524319        proc-vmstat.numa_hit
    578153           -20.8%     458095        proc-vmstat.numa_local
    682807           -18.2%     558809        proc-vmstat.pgalloc_normal
    675599           -18.3%     551960 ±  2%  proc-vmstat.pgfree
      1.61            -5.0%       1.53        perf-stat.i.MPKI
 6.692e+08 ±  3%      -8.2%  6.144e+08 ±  6%  perf-stat.i.branch-instructions
     23.54            -2.2       21.29        perf-stat.i.cache-miss-rate%
   2665211 ±  3%     -27.0%    1946091 ±  4%  perf-stat.i.cache-misses
  12037045 ±  3%     -18.2%    9840696 ±  3%  perf-stat.i.cache-references
     18418 ±  3%     -40.1%      11025        perf-stat.i.context-switches
      2.13            -5.4%       2.01        perf-stat.i.cpi
 3.964e+09 ±  3%     -19.8%  3.177e+09 ±  4%  perf-stat.i.cpu-cycles
    181.54 ±  3%     -23.8%     138.31 ±  4%  perf-stat.i.cpu-migrations
      1472            +7.4%       1581        perf-stat.i.cycles-between-cache-misses
 3.216e+09 ±  3%      -7.6%  2.972e+09 ±  6%  perf-stat.i.instructions
      0.65            +8.4%       0.71 ±  2%  perf-stat.i.ipc
      0.83           -20.9%       0.66 ±  2%  perf-stat.overall.MPKI
      4.24            +0.3        4.58 ±  2%  perf-stat.overall.branch-miss-rate%
     22.13            -2.4       19.76        perf-stat.overall.cache-miss-rate%
      1.23           -13.1%       1.07 ±  2%  perf-stat.overall.cpi
      1488            +9.8%       1634        perf-stat.overall.cycles-between-cache-misses
      0.81           +15.1%       0.93 ±  2%  perf-stat.overall.ipc
 6.587e+08 ±  3%      -8.2%  6.047e+08 ±  6%  perf-stat.ps.branch-instructions
   2623092 ±  3%     -27.0%    1915109 ±  4%  perf-stat.ps.cache-misses
  11851537 ±  3%     -18.3%    9688099 ±  3%  perf-stat.ps.cache-references
     18125 ±  3%     -40.2%      10847        perf-stat.ps.context-switches
 3.903e+09 ±  3%     -19.8%  3.129e+09 ±  4%  perf-stat.ps.cpu-cycles
    178.73 ±  3%     -23.8%     136.12 ±  4%  perf-stat.ps.cpu-migrations
 3.166e+09 ±  3%      -7.6%  2.925e+09 ±  6%  perf-stat.ps.instructions
 2.004e+11            -9.3%  1.818e+11 ±  5%  perf-stat.total.instructions
      0.00 ±223%   +4160.0%       0.04 ± 35%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_create_pending_block_groups
      0.01          -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
      0.01 ± 15%    +246.8%       0.03 ± 96%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_sync_log
      0.00 ±223%   +4180.0%       0.04 ± 35%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_create_pending_block_groups
      0.02 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
      0.16 ±106%     -77.8%       0.04 ± 39%  perf-sched.sch_delay.max.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
     27.42 ±  3%     +53.9%      42.21 ±  4%  perf-sched.total_wait_and_delay.average.ms
     40831 ±  3%     -36.6%      25906 ±  4%  perf-sched.total_wait_and_delay.count.ms
     27.41 ±  3%     +54.0%      42.21 ±  4%  perf-sched.total_wait_time.average.ms
    229.23 ±  2%     +51.7%     347.78 ± 15%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     12.64 ±  3%     +56.9%      19.84 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      2.33 ± 11%     +63.7%       3.81 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      6.94 ±  2%     +29.6%       9.00 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.31 ±  5%    +421.7%       1.64 ± 25%  perf-sched.wait_and_delay.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
     18.67 ±  5%     -35.7%      12.00 ± 16%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     22342 ±  4%     -40.1%      13375 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      9405 ±  4%     -40.8%       5564 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
    666.83 ±  2%     -22.5%     516.50 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4582 ±  4%     -37.4%       2866 ±  5%  perf-sched.wait_and_delay.count.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
      5.34 ± 21%    +756.6%      45.72 ±  4%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
     22.83 ±  2%     +15.9%      26.46 ±  8%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
    229.23 ±  2%     +51.6%     347.59 ± 15%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     12.63 ±  3%     +57.1%      19.83 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      2.32 ± 12%     +64.0%       3.81 ± 18%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      8.58 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync
      6.94 ±  2%     +29.6%       8.99 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.31 ±  5%    +427.4%       1.63 ± 25%  perf-sched.wait_time.avg.ms.wait_log_commit.btrfs_sync_log.btrfs_sync_file.do_fsync
    101.57 ± 20%     +56.6%     159.06 ± 22%  perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
    116.41 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.do_fsync




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


