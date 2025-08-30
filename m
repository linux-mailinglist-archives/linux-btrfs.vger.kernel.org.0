Return-Path: <linux-btrfs+bounces-16536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A7B3C894
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 09:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACD9189EFB7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1F22ACFA;
	Sat, 30 Aug 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUd2mIk6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931943FE5F
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756537262; cv=fail; b=MzZLbwwKtukZ5nByml6JD13G33gWT82XUsKfKSKw+6wFdihAECuFX4q9moLuboMKk47gwRE+ybyLIgc9ixwmQbiIby6WnU8+xO2yMqmLW9rySFdGDpkjWM9giTYdKKyhBIIJqicMb1rZcZmNzQtuAsCT16I7mReZ0K9Gvz7S/ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756537262; c=relaxed/simple;
	bh=OCFqJ79kgJ4DViyG6DnrPG3ib94Po/xHZ6ZEB3sqjho=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mK0BeVzOCmLBPFR7qanzU/HvYoohhVVnaxQ8bYB4iwOkCt1pqFzmeMAy0cm+KqYer4LqfwZVxeJzFySZy18yt1w8QKQdILuD770ZN31Km3SGX3sIo3PuRdiYbb8xjd7T7ecqF/SUc7pV6XLudgeCDUEkqtP8yRZ3d37C0A8WelM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUd2mIk6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756537260; x=1788073260;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OCFqJ79kgJ4DViyG6DnrPG3ib94Po/xHZ6ZEB3sqjho=;
  b=FUd2mIk6SUy660Og1NpiW3fI3A1M7Z58QsaPysVM5WLgVF8icZhRnscf
   +Vrk5kTvdj5SliIo8Na5WyVkCaKKQduL7HaZSTKBoP+nJjVwwSMyobuX6
   UDWeusOjLnMFDcH/1av2gGHY1BCNoTCLXTC7tNrxslynZUqfFM9JWl7Z0
   HLKCWwSB5sGZFSkaQ8VFg24m1HqscNykXu5duGTL71u08hn7LBnhFfiZ3
   F16A30C6hgnHjKlq+zKWYzYzlmwnq3p+v4w6++6bFdDV4I1E/u6/d/R3f
   Lq/uRtRSIEXxdcH3OdylCOf9cs3Jm4Qn6++ghAYkUpcMd8H4r4LPI1RVq
   w==;
X-CSE-ConnectionGUID: j4sWc15bTXOOB1uxxRmojQ==
X-CSE-MsgGUID: xxFE7IVgQRCA1pF+RgFX2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58883820"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58883820"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 00:01:00 -0700
X-CSE-ConnectionGUID: zVutHywnTSWB3NFJGDo0DA==
X-CSE-MsgGUID: RvNwBfyyQcqItNRDxK9ABA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="174918275"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 00:01:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 30 Aug 2025 00:00:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 30 Aug 2025 00:00:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 30 Aug 2025 00:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBUQtxPL2uV8qq+Ou7cE68h0dANt3fmB064R/ufOU4T8WpNDuGYfXAhE/ddEvyI5SyLjeoxbQlaOyVLbZcPhWtp0yBXwrGXJP4FHj/WJgqF+hM4a49K722dQitOqrsACepYdOXwRkkVqe2/wq+lsbFDIr9dqgjjn+VhmNPaCxWNhPjlqoYGW1I+lvCBxrkK/upDg5Rt73mQNNK2fiKT1at/uc3wajn1Bb1MNPW645MOjKHT0eDT/g9Nhm4hvRoqPg8DMG3R3jQsdIhIRD6EN+sFRNi+PcnI/dH7vtQAhuO4AauQGLUF3Im0FeMWcepYFX0YGumIQ0q2+NIteUei1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y95q6aEQ1F4DShKZNHQ/wSLc2374Ds5c4kBiv46vL/g=;
 b=TEf6BiZEmtL/9dJCOx6y2jAn0PNoaMJwBG/AYXvfWGFst07qNSrbb0d3jbA0NGS06pT4tfiXH8rHb+k6bqrHswizlFJe2yA+esn1n0epPdyRPCW3TLmE3byCmxJeCNuDu/s/7VckvuK4UYdiQpm7R4/diQCc2Aq5BjVYU4KMBSzS8X+m48Vs08isCZhCdcKl614Burq/NjhK5lvlbV9UHe7y2cKnzoksmie7Vvg58K+ZaSfejRyeKnyO+Ny3XZCZiVKXt4RjUxPeDuaBYKBa7ZCOYxGZ0uP4wwd+WDt8KBiUfxQJnYcLzZwpUx1EfykdeySjBt2XSJEkqJyGL8Fevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 07:00:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 07:00:52 +0000
Date: Sat, 30 Aug 2025 15:00:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sun YangKai <sunk67188@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	Sun YangKai <sunk67188@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter
 early
Message-ID: <202508291655.c99c34a4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821131557.5185-2-sunk67188@gmail.com>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: f06a6b4a-6e8b-418d-424f-08dde792f57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQMnWmOjAACecHqg681LTz4dzl0jx3DdubIcvuIy7By3RlLHIh6dRySahnhh?=
 =?us-ascii?Q?qIDG7Rro2MpQnnULOGS3pTmEBej7awvs9j8St+bKXphwuu4XJODXpGM2mvsO?=
 =?us-ascii?Q?UDAbYBnfL5MaIkOidgNr6zj/gQsnN+CTOvgT+t4aXidlUVoKqWB1xqisUwnv?=
 =?us-ascii?Q?ipi9CutavprS9g9hdKvQE12F/TI5T549z4tTC0jgvuICNid1tCHya/uLC9as?=
 =?us-ascii?Q?g/rrxJVYMC0SAo+ctBpkNFSC9+/PJNM5gN6ppiyLpUzr/E9wUCAq0LjHdgAw?=
 =?us-ascii?Q?UaOLEqV3rf2JnQ8j1oXUmZeh2zNt6RIEeF5Nc2aVn+qH3jK4FhtIThYs4ryC?=
 =?us-ascii?Q?E5yK2yAJWjKMJnH5ixCSJnlCumyQfQCG+9Bao18m+7UaDhyBsE8K2Ypp+nNA?=
 =?us-ascii?Q?fL7un/IuejeEHpVA4Hy+17NVTzNLkA0h9rO9qrzIogE6mI3naYYnQHj8V1Yf?=
 =?us-ascii?Q?Ro0TpzreZMnFAaI3b+jcU7y2xypkDaLx53+CJUpqrlGxx8Uoe0C4cKhEoDeM?=
 =?us-ascii?Q?lfnP+nvXGdr3NupDHd27aIF34xzov7oiYih+7VHxx5eMu7y8APx+t5VPKZ8N?=
 =?us-ascii?Q?0IKsfW+iWVbV85qay3Ip0+nZmPx2w7C7ERdJmI1sWl9x877CsPJW4QmrbnSq?=
 =?us-ascii?Q?0dwN09Jq1Ns/XSZha/WrYjn/j4jMAnGpdTN2H55WCJK76dq6Jvl7sduWxzv8?=
 =?us-ascii?Q?aVvrrs/vryxcaZjryhBOQP6S0KMivlZjJP/ISoNEE7IAvBgQDxPXn02Oc5UR?=
 =?us-ascii?Q?QmC51ZhxnVmuXO4ZFAk7EaI0SIFRQK8X5i39noaxDtaWa70GIaCGDXm9HoJc?=
 =?us-ascii?Q?Yej8NiN8GvayHmsud8CcMsL6gEHBouBCZrxDZ/0Qi3fAX9dKdbhChGPPubu6?=
 =?us-ascii?Q?LudflZ7f9QaaXMaKSnxrI8RXTaCWGllviZBepy8luuYXuw0syO3xEFfq5hu/?=
 =?us-ascii?Q?6tXTiwStupysHIgs0SxnPew8TtHJRmFXzQGPeiQWnqUNxRiFNIAd9daq02+7?=
 =?us-ascii?Q?WIdSUbpDcjxPfl8ExQ5ey2ogyR2XhZsvKenBlCSfqIy3QS/O5YW8lRwCvMvv?=
 =?us-ascii?Q?A1fdwHL11katWheoJ4bbf330UD/5YrkEuzKCpUbzZVVfNx9Rl/VTjmbDO3SR?=
 =?us-ascii?Q?f/vWCsd6JRqMoPcnIdkuXR5Rg2ERKSx0CpBKdsRLQABXfXj9xmBbnHYtTRfI?=
 =?us-ascii?Q?qC7nd8elZgLY0/Lzd3Y9uQC8+TO3Q2T8nFbcOHKE7hkS9rgZg26BgZxX4Aqj?=
 =?us-ascii?Q?y3aDidOSFLKxHW28Eo+77fr2pKE5sBeF/nkgtf7WjtC2RN0jec+45OjiRvqJ?=
 =?us-ascii?Q?jejyTFdzkARJbyW8vnlmBxLczSPHK91rOZMEeMMNJ7kih8/R4vw6f0tr+AIQ?=
 =?us-ascii?Q?S+Tz2gRrkL08nlEO05iFnI8trVHr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tqas9Xs6HVqjTY1FR2TlT4vCbK1AgIcSKQUAe3u0AHUHPHP5H9M3J9aKZk2o?=
 =?us-ascii?Q?wjikTrAzYb4N7IV6zc2jHikNHlTv6kK0+dZ1f+EtjAOpOoivAb0OcTD824ZW?=
 =?us-ascii?Q?cl0KCQvgRxtsefEsS8rYI5ESaBKJufx8cJVMSgLxD0s2bpjKMOsIreCbioTu?=
 =?us-ascii?Q?I+acnDCAQBAKBK4ktlTsCbC14QGoqbN7zsGxOKV80jz6JcuS1I4tqxAtchhM?=
 =?us-ascii?Q?fwGl/651phHmCJ2H02+uyBNPUI5qTaYK6Qez0D4WU4qJXj9EMPjFQ9eMdFKs?=
 =?us-ascii?Q?Fsdt/L34+U04c7+E+0EC3X7rkTXn02ILjpHGwJpad8CBQldHBczD5QazKKpa?=
 =?us-ascii?Q?yaxyh6qBSBmdXU17L2EtfTrwaDShadnW0HnaflA6vYklOi7dfvjsu8vxKNYJ?=
 =?us-ascii?Q?LVmwV8uQt3qctoVFWDaCAQSj46A1P65j0Gw/R0uM0NM2wVm6xLnMtIvHD3UO?=
 =?us-ascii?Q?D7Fv0Xpw/3WYnY/m2HTMksRa3ST20zt/4DWxnj/mobWn+W0MOigwirfcc/em?=
 =?us-ascii?Q?zdAo9hqmGZuj8IQYjj3o05R2+PAgMBZH5BYcWlYh8mN695f7d84ck+PAetR3?=
 =?us-ascii?Q?/byJcZ0ZzU9VYIQsfydJYU1SGHQj0C/ityGzbcHMa3IbgX9NVJuxQ5QHxt8p?=
 =?us-ascii?Q?Eg1mkJ6F+yU6G6NbAZhY4ohswcaBQsjG7nfDKOQqWAAWPo3Py8Hn2fVQOSDI?=
 =?us-ascii?Q?iWnkXP3YrgBM9FFV3+F4rWO7H3SDsezpEnNpLuvEnYByOATWCbY+UHzjwxUU?=
 =?us-ascii?Q?mxPRiXNlFmTVrkKUXKGiKIqnDgHKUqhFUffPFTjL6usLvjpW7Hy/UOWomSPg?=
 =?us-ascii?Q?w+RjTeO/QmsO5ydeUA6y1EJXthwg1kXmfIx1WjYIhmUgW0N68ruMgURCsXjj?=
 =?us-ascii?Q?G2ax07qLrgT65bH4q3KSEWwk/vTCrq8LgBmiBT3m+v3UfTBOZBZLzYRx6D+O?=
 =?us-ascii?Q?7LG/uZ2aqorm/lEr2noduZwTo5dD8X3BkMJoDV16PxjlVBdUuY9AuO94pnQf?=
 =?us-ascii?Q?6zSpPe2BVxv7YIKzt/vVOWZ5mRmuU7AFu6Aky+TCm1+/jwvWiGZCfBi/NRiI?=
 =?us-ascii?Q?uAPsCeVwzjvZFCsAZSOxSHW35CpjtyLtwbw38Jy+aKBQq1i8saqIvJMAiqls?=
 =?us-ascii?Q?wHWFabw/pWrQYngyPr2IJ0aYbiYcqAbUuzBoRCAz9f5SrgykyiAWkV3rnGxv?=
 =?us-ascii?Q?+WjloBQpekF14STWraG5zF9/6eWiPOyOl3JooHK4x2yzOkPFBaCsoiOw/djM?=
 =?us-ascii?Q?KZTrCHPUAdZQn/ijvsf7QHvrLzXuw8sqbpKe1S+x5kCguiXe16Rf0se9mpMt?=
 =?us-ascii?Q?xdnIsw213D9d5nDRR9gHOSAfeCafImw3oKbc5pJ99vZEXrVzZhj1uxo1zAmf?=
 =?us-ascii?Q?jTxRDDmHNWSd2bjaUrooKTf+cufKrICSaWHaTPwKjBt20nStl26fbJK72+9q?=
 =?us-ascii?Q?Ybim9AavdD/M0B4pA93RwViJLs3+uXN3xtypO7wTJ8F8be6lU/JJWU84yAIz?=
 =?us-ascii?Q?qL/xjvQh7iAIzH/6N8P1pUMREhRcXZkN6sqejdw9xShx5dxxZ2Ok7JFG1EDK?=
 =?us-ascii?Q?WWIuKSuKYhGtC8Mffsr+wPVHMWuTkkVOk5ZWUbt2ZbHC2HnpId0g9aw2QwaH?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f06a6b4a-6e8b-418d-424f-08dde792f57f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 07:00:52.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOX+4QCylPWkoANuO4w89l4K9w9/5DKM2v6oOwUdztC5To4yl/FFa4+GVeALXCS2eVvif0jZLcwgkWj3nX504w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8414
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.129.fail" on:

commit: 0f755c2d1c496756f81bbe6330e4a3cb9252c89d ("[PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter early")
url: https://github.com/intel-lab-lkp/linux/commits/Sun-YangKai/btrfs-get_inode_info-check-NULL-info-parameter-early/20250821-212815
base: v6.17-rc2
patch link: https://lore.kernel.org/all/20250821131557.5185-2-sunk67188@gmail.com/
patch subject: [PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter early

in testcase: xfstests
version: xfstests-x86_64-e1e4a0ea-1_20250714
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-129



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508291655.c99c34a4-lkp@intel.com

2025-08-28 18:04:50 export TEST_DIR=/fs/sdb1
2025-08-28 18:04:50 export TEST_DEV=/dev/sdb1
2025-08-28 18:04:50 export FSTYP=btrfs
2025-08-28 18:04:50 export SCRATCH_MNT=/fs/scratch
2025-08-28 18:04:50 mkdir /fs/scratch -p
2025-08-28 18:04:50 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2025-08-28 18:04:50 echo btrfs/129
2025-08-28 18:04:50 ./check btrfs/129
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.17.0-rc2-00001-g0f755c2d1c49 #1 SMP PREEMPT_DYNAMIC Fri Aug 29 01:46:03 CST 2025
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/129       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/129.out.bad)
    --- tests/btrfs/129.out	2025-07-14 17:48:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/129.out.bad	2025-08-28 18:04:52.493243659 +0000
    @@ -1,2 +1,3 @@
     QA output created by 129
    -Silence is golden
    +failed: '/bin/btrfs send -p /fs/scratch/mysnap1 -f /fs/sdb1/btrfs-test-129/2.snap /fs/scratch/mysnap2'
    +(see /lkp/benchmarks/xfstests/results//btrfs/129.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/129.out /lkp/benchmarks/xfstests/results//btrfs/129.out.bad'  to see the entire diff)
Ran: btrfs/129
Failures: btrfs/129
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250829/202508291655.c99c34a4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


