Return-Path: <linux-btrfs+bounces-8889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F2299BD96
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 04:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD921F22743
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C42BD19;
	Mon, 14 Oct 2024 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzLXob/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4D1BC2A;
	Mon, 14 Oct 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871568; cv=fail; b=kMPGUnzDi2UUXJgX23xbM9NIFfov0j0t6tKiu9+PhYXYXi9stxASQ3LmgN/l9rh26FVumk1Jeg6TXtz55edATPCk9TTe7djjEShCrU/rQmtdTEh0mYi3e7psPys9bzK2NIucAab/joBRm+A2BX89ZRu+eR0CUsrATZhVKoG18tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871568; c=relaxed/simple;
	bh=jBcf11wo6CZRZK5ca5457cAvAQEzoMP2TnrgD377c8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PBh8nu48aLidnW2rQaViw2ihiMcD1syshJluJmiDof0Xaz79WJWNbaAK2/w9xns4W+KYe3MECgsWX7uV/oYFKUm8VvAXqv1s7/Sd0hrHqzR79bpQhP/6P7d0r4K8NesrdCkShTuO7Du5gk7p0MyGrrjfc/A9SGySkRbvZw4oGN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzLXob/9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728871564; x=1760407564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jBcf11wo6CZRZK5ca5457cAvAQEzoMP2TnrgD377c8g=;
  b=DzLXob/9zFFf18QXyf9RkYUGunlxTyv967/m6Hef9V1hyP6SBFC2A1Fl
   l5SpM+rlpu2X3h9LLZ+cejil59Vfpwv5I7tR64AX9KQ8KVTAAHVtCxAFv
   XNCJHsGHDlU/jVRZ/90o1Xsk7WcQNnnNouJrjeDERo4nbR+NC+Q008IIm
   ElbRpyjQqmlavG0Ry/Hnr/DW3SF1gpDLDEkoNGmjBnv8Dl/Cn2yJh3ArM
   2vBW0gzH7K1clRwNHfc7YKUQellyJW3GHfQqUBOv/We6eSyTXT3cyfqEI
   tNVpeg0vuiFY8X3Nod37c6x8sxGluIBwE5W2ycWdpKPVdkKOdIvPfz8ux
   Q==;
X-CSE-ConnectionGUID: 5Mx8elO8RXqFneIc2JGNXA==
X-CSE-MsgGUID: gCFkV5F7T6mqUruj/R2V9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="15832889"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="15832889"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 19:06:03 -0700
X-CSE-ConnectionGUID: AWk0LIYUQASuPURevq0KCw==
X-CSE-MsgGUID: 5R9dwvjeTuCJ66+tg2AY2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77083027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 19:06:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 19:06:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 19:06:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 19:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWFgzGrg3FJgt8WR5EiuMAvjpUGTFFpGeaHQGU+vp1pVhHSbdoqI+xK0MdPPIg+fzJ4MtdQgF2Mg18zy6LkQJjKH2uQbj9L+b7GvSDIqimybKNSwRBKIDvArmjS68F9wZZgEmArwXCz/T/Ew/mFVlu2WcvyL2bowGVGq5VO2kNVR31cvfcHGfB3i9RnfLl0U6wWDhwg+AvDRFMBmj9OhPNfHWsGt75KWia6f7KHVSUFvcobTDLDfY4bxLwvLjI/oxJftnMaCGeJm/ICYcIciBLvOcDl1nDkX8AnyxmSxJ6OgF1uR2OtnTM7jMNI4IFLZ6TM2qcrH/1LXAPEkeCGENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk5V3QezfnJbstPIXxIwYXiO7K3nghTemtzjOoYv38U=;
 b=FAliqCFhfFO7kRa+dHqnfjBj4mVXwlj5g3YJN+zRzMztQTvlb3EZxOwelui9GV6A/k2jB3j7MCEZorWb7UbEF6xWPAN744l3li8Dk9TR8Vnu0AVNpk078DJI5wbtswL3kcXpyNh81RQTNOiFMK/gzTOZflFGhSzFs3gzPOwut8OXNAX0IVPyBo5hGyk8kQ/iwhyEDw1Jq8EkoUFe1VRNxUf0kFZAiepzncY/nbOhR2Wm4yb8WvmZEcA/tBWfrwd9sQiRScyfaEa/WdXa2eEfNKlVLT0LSHYBgsWBCBO4eyo8+HXVCwjqF0WmmWCrq7O6IcVdf3bnd3eYTP+DLhgbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 02:05:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:05:54 +0000
Date: Sun, 13 Oct 2024 21:05:48 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Li, Ming4" <ming4.li@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 21/28] cxl/extent: Process DCD events and realize
 region extents
Message-ID: <670c7c7c8bf5c_12d98c294c7@iweiny-mobl.notmuch>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-21-c261ee6eeded@intel.com>
 <4337ddd9-312b-4fb7-9597-81e8b00d57cb@intel.com>
 <6706de3530f5c_40429294b8@iweiny-mobl.notmuch>
 <dd13b703-a535-4de3-9b33-0e28fe720700@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd13b703-a535-4de3-9b33-0e28fe720700@intel.com>
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a8f356-cb13-4dcf-48b8-08dcebf4bc3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6HB5GH424KA0VpqBInQwSwpfn1SO3wy047BlC34yKSJ5jPdY+EmT6uFjBpZD?=
 =?us-ascii?Q?SdjYgN/B7lA0dGzcAinJcNXTlT5v3kPzB5Cs789b5vqBnubup6wqRvYzeHta?=
 =?us-ascii?Q?1XUB8o7C4ik1fq9DHyTjeM29IDXEuRNkKLDGW8Kn6Cf59fgzrl+9wCy21EXJ?=
 =?us-ascii?Q?qJ04t8Wp8s7Jn8EgL3JxZl105hldjNTXiTP3hiBwkNyHJu3zsQiGGeuUBwxY?=
 =?us-ascii?Q?8D1MnA4TCvT6erFCcDXERL8tAnXv/uGzAysQVaWpIt2j+ijS/Ua+rRiGnvu5?=
 =?us-ascii?Q?sntss5iTSXUUtS+7qRuVMt/j/Ym3HJrI3+Y8OUrb7GT63HbiCVXwSc9RwGVh?=
 =?us-ascii?Q?10KTJ7Bd4FiX+g/iIiRklgapL4Pu6vSZmAtTIvle09V4RsccJ0/jnH/Hdald?=
 =?us-ascii?Q?vxWKz0/c/eEi69GHfsNrRFX1VnOvW1EYHh5PXuO54SaEzeondrLK/iwRElwp?=
 =?us-ascii?Q?oUSsvcAaMl9/BTCE64n6xSUZ4fMAhymhzfOpsM7gWpUQPTMvyDMyxisJcgiJ?=
 =?us-ascii?Q?1fszcWF7E5VrnOMTIKCq4b9mkx0bRRsgW3hAXfww0QJFfVG2S/I3XzBMRwEU?=
 =?us-ascii?Q?2BYouic5vRMod2cE8tt66ulMoWv+r0R/OSgTxf9p5sHQy2z1/AsPeTBqIBHz?=
 =?us-ascii?Q?XG9tKsfoHAcvozmow6wB6TOgYhVhqkbzHsRETXvpaq+IhpPxPZWbXDhG05gG?=
 =?us-ascii?Q?itkkvbdGOb/3dDsfAQ/mZrX2+Li+Hv0Jda6HBSo6LIT/EK+2IJOdeb5Ogl74?=
 =?us-ascii?Q?pLhBqafBJ2eJsgEt9QfKupqxpWIOiRfmwrFBSHrdi6jwaRN70EqFJMRIrOSN?=
 =?us-ascii?Q?Gwbq6bFijreYZTDNB0MCNpCTOyyiP2UKI2JxIrTadM3S0zg9cCoxzk+M/ErA?=
 =?us-ascii?Q?mHKHNabXtKIMnMh25RnKR/Xb58Je6ZWsY6jX+7oSQCNk+37xsQes2QFnad37?=
 =?us-ascii?Q?RLEjrw5X8niSIri4Ou5+WSOm3EKwF3+84Vq/5NhhJP4547nvs991QeF7CJga?=
 =?us-ascii?Q?C5bP/mXGepdOmkeYASLR57iVC0GQFgILQZnP3yfgndZMnaasbmOSgYYfhnj8?=
 =?us-ascii?Q?39N6zGxgQG+JxaItSu9IzuQCGUCi2aa1UdDP9Ep8MEpGSSOJzhzcqyftaZYX?=
 =?us-ascii?Q?Ze6GuaibXL88BdjPw0k/sHgTWYXBMvryPqP/+F9HbDoDpxG5IZYrprBE/LlM?=
 =?us-ascii?Q?5aJEqoYbHm8PDU9B5tBKKeZ44M8b0Qs6mmubJsvE+SUmmO1OEEIgQcb8HH+c?=
 =?us-ascii?Q?URP/c5wSv8hipAySWLwDaJ0Jub/6PTkcG8rdOjThwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMxLhS5N33buchcQj7ktB9QT1yB2E3PiLzbMrK1e5+snMYLZd7Ez8UsJBgbV?=
 =?us-ascii?Q?+PWO1GdV1ZlqcpXULmPgm5YWdXwUektYxce9JSJ19F76C8zJdJMlkaS+9I4Z?=
 =?us-ascii?Q?+H05ePtYDWrCPOKJb0TqvSBnW90E4upxD2kcZUq8GQJ5ceaJAnZiXy/IAFvf?=
 =?us-ascii?Q?PTGnFx4uihYy/W43+fOzZ2sNGuiBCuufrO1s/QucE/SD93rWEu3rO6JwTwfF?=
 =?us-ascii?Q?5+3fnvwndBHdGWPR5/IfzkX7OzELomqeTX2EhgoXlq8GsThybGDSZY8T6X6T?=
 =?us-ascii?Q?bCPPxE319vAvhiEByqCkXe4tHe5bAdfsEp+FaDWzvZ486OOb4MYjF+CdeFXa?=
 =?us-ascii?Q?O1zQDYqJigzQA6tyYAsnb/PeLDM/86gT3vJH+CmmdwwHw1HhHc0Vuy5UM017?=
 =?us-ascii?Q?uW75sjEIo1aVTmEwRX9wql1xtIvczaZ95nrOpb5Plcf5H2BlzSUoD7w4UvjQ?=
 =?us-ascii?Q?plFezwbce+pD8tdcEbPoqO1uE8+I+mrcCRqVBYa9xuG9ULBchA9f50C97vzN?=
 =?us-ascii?Q?Bnx1PMv0nEdFOHqFdzEzZIl2YfRswKEk6Rw1E738Ycr4X5c+iZfu56tKCUQZ?=
 =?us-ascii?Q?zgG11TVjCdIr7ETJzJx+Re4zolMVa0R+keIetJxCQJNXrVnjDIjhQJYK+MBw?=
 =?us-ascii?Q?NsgbwQXreq6XzCXhncAiPp7BYDgij86q7Y7VyrQT5vIbJ1JkltjrKciQcTxe?=
 =?us-ascii?Q?Aga0yg9nGShOEBm0MqLDIStY9L/DAIlQ2j5KonnDi63yWBhZCKLaxqN45/ET?=
 =?us-ascii?Q?V5MMNWg+cFxaLBnO9gpnHBCZkSzpmfZMyKf7xzyGk/Dm6SOKaX2LmfW/IBfw?=
 =?us-ascii?Q?QhX0rDm0J48Q9BrUy/KpDELJm3Civ+HivrRLwyIa/44/7y4DvcCHDyDaS7R6?=
 =?us-ascii?Q?kgfLvUb5tQHYvuKltJxJJIOLU4Uf45satCrdGO6EAcGQZqK+9uVQ/97SgTsl?=
 =?us-ascii?Q?TOQcjnPpFc1vTSSnPSzSYVK05U0ha0OShb5x18CRqu8t8XNlIj8nKwcaw2+s?=
 =?us-ascii?Q?bmy1qA8Hh3n2P254usJ4T25HMGd8Ki/Daub98lLDm6PfZgErsYlISg1Ztq3T?=
 =?us-ascii?Q?bRL+yVLqTc8GfuOzhAnHj8/1uRXtU9YYmYgXUqGR/D3+NT0M7D3PkCs4Has7?=
 =?us-ascii?Q?CdRB2Xr3xhqgwM1rAShF2SPYg5dwAsiYJYN+ZtrjXFfH9wGSLqrSfnI8kDMt?=
 =?us-ascii?Q?OkfDdOaDPv2Lsu054d/mbSZbiM8+xfNgwJUuzNm5nRPOBiXuEm7ucQ1F/FeA?=
 =?us-ascii?Q?QHbnjt9ZFkjc08mwVvDOaku8L8ep2Q//MifpVVVG0jQ+4F2ch7WNEW+9J8QV?=
 =?us-ascii?Q?vXOmW/7BDR4wW9sLElQfmK58EDvBeI9VMUI2cPH2uWJceQVCQowmJVmQq+LB?=
 =?us-ascii?Q?lNjcVuc6KcAexWI/XVHcNbNknJANOS0nedMAMH8joKv3Xg9v+WOIwmaXS0pI?=
 =?us-ascii?Q?n3Si34C/7kx35wKrQvW6Bh5RRx4IdZvjXRpwa1gUQC/7kuLKzVlIoyII6XHK?=
 =?us-ascii?Q?nq/6jmdO7KbNalzu2z6fTUeZ8AYhRVxd6B/MNApakBECX3QPBAUFoePj7rOG?=
 =?us-ascii?Q?HuRI6hUBAQj70s4KWXlr7iqc28Y+u96OBy0K1JE1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a8f356-cb13-4dcf-48b8-08dcebf4bc3d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:05:54.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PEx1pJm5gCBJNJMbe5yi4JHkS9LDA7yCFTqXQNmkHZyAtxKxotfU9y7FRNHlrp+8z9YE2kP/jscZrjh13mUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com

Li, Ming4 wrote:
> On 10/10/2024 3:49 AM, Ira Weiny wrote:
> > Li, Ming4 wrote:
> >> On 10/8/2024 7:16 AM, ira.weiny@intel.com wrote:
> >>> From: Navneet Singh <navneet.singh@intel.com>

[snip]

> > This should fix it:
> >
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d66beec687a0..99200274dea8 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1119,10 +1119,11 @@ static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> >                         if (rc)
> >                                 return rc;
> >                         pl_index = 0;
> > +                       cnt -= pl_index;
> 
> should update cnt before pl_index is reset to 0.

Of course.

> 
> the cnt is a one of parameters of cxl_send_dc_response(), that means the
> caller gives the value of cnt, is that possible if the size of
> extent_array is larger than cnt?

No both callers ensure cnt is equal to the number of elements in the
array.  Otherwise cxl_send_dc_response() would need to iterate the array
to determine this size itself.  It is just more efficient to pass that
count which was already determined.

> Should skip remain extents in
> extent_array when cnt is equal to 0?
>

No not skip.  But this makes me rethink this solution.  The spec requires
a response even if 0 extents are accepted.  That is what drove me to the
buggy solution before.  I'll have to think on this a bit.  I'd like to not
have weird gotos but that is the easiest solution I see.

Ira

