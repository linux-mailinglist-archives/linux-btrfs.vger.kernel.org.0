Return-Path: <linux-btrfs+bounces-14619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39233AD67FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1621F17E44C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0435D1F2361;
	Thu, 12 Jun 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmFl+7Aa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D571AC891;
	Thu, 12 Jun 2025 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709585; cv=fail; b=U9aZx6qa6qdewJDQRe3Kkx5jTCun7YYcf0yPQC7E38jwUbc5iBHipey029YyBcgCufRTS61BbF6UeENghSbCLELiV3vg21oWhk1C10a1qbDSI0F8uEYUfrMRsjl2qk8pc1Vvx8bGOMkFb14tpyK0GLXZiVI4xp97Dy33I9uFo3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709585; c=relaxed/simple;
	bh=IJTx6lTG4T/8QHuVtIfgUVFMBylNrzHzDmU3hZ0egfs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=fMhfwqTjtDRal35OT/bo6sQgFGalrDG0+KBzFgvhDBD+gUQ5hXwCLZeXIHJXAqBdYJGfyT+TdDrMR1mrNd5Mw6aZi3MO/hYpL8/F7x4M+HItPI1At7lzUtTBeWXZ3QYdTc0pfYKQaRU20aCBMXy27tCkgFAhbCTonRtdixUZZ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmFl+7Aa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749709583; x=1781245583;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=IJTx6lTG4T/8QHuVtIfgUVFMBylNrzHzDmU3hZ0egfs=;
  b=DmFl+7Aazb3yAt2WtMbC00CLY5GcfuU/jB5IxuqgIz4NLD9TaGniF/a1
   scygU0v9PE9Afonf02jnYIC0ENOlG9B0lMrpbt3l0pPa0vs1qCMCI7VRc
   Alxrzdh9yacyRHXd/GS2DS1pjBkNbHWzI6+s8ZWMV9gb8wgEvQdVJAi0f
   8LW/v9VZt+ocfMfcZ9b35n7BQF0genpdP9+cUJOhBh+fHjvRsSUZbF0XC
   uuLIa02JXSNso5FOSE4VU1uxgDapNUKMpMu3t9TBSaGExPUZ0UWUWNsPH
   lw+FjXNe7vmXXW9vQMHIXnVMNfwpOR2evf4fMklyDUhjiOn4wRXuLiQJh
   g==;
X-CSE-ConnectionGUID: kseJpQWJRgK3yTf61/jSUw==
X-CSE-MsgGUID: gS7ujUoxQjOOhscpvbEZkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="52016959"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="52016959"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 23:26:23 -0700
X-CSE-ConnectionGUID: m7NQa/3kSiO63zAR1vv37w==
X-CSE-MsgGUID: cSKNoFeSTByTxdoiFH06tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="148335681"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 23:26:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 23:26:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 23:26:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 23:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzglkU6NkctBP3sxu2N+3npyZPG/l0dcm5awdfJ/HR8YKL0/x8EBsSG35lWMM6KA9+SVdAzEpjifdf/HvKyDcV6w/8sNW7hzBJsgKcKm0jWeN2JGJ1qm9Xa86EhqS3fwsrrzaDXUtG+g25BgMOhqmyvy9m3r9to2s5sCGxNbS+BgrZwXCF5p/SuNpzCGe7XpeIsFI9uBVhK0swWXcWe7vDMCQxBmkyDv3aW6kjbJu+f6XWiMptyjG2KwgdcuAML8NrbjZHwjvLryJjKWKLbxujrNzZMffWEzJu2LT1pOmsgXTzvjhcaSNBf37Q9x/AZ6rEqCGiDCQ8bZki4Fsg3rCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbAb6Xtd/tzQPh/TLw9LOjxx+sLG4aUak4LmAfLZ2As=;
 b=UB2gQgUY+l8Nn+/WE5OsCbrVwadLSOaE7SCuOd8fZtFaogoq//3o9Z9Tc5NzZV1LZJORDe7FsC6jE3Pi1wfv03wNITY9t80W2/mskXQjunXJehHwyDBfoYgTQ4pZq/l57wPWOd4LVAmV1EEpqHRDtY0DLwcWkBDTJMG8jjxIiJOwzk+ADihcklW8ns8qhDN/itH0ankwoGS6u8ArfMC6Bv6KQJCpYePDetZbqlkf/vA14/R82/uZq8qtexGesnEPOlqJWYz/4UnYLaOouzKMDbOu3O8DoNt7lAJa0nrkyu4u8RBGuK5a0NHeuXy6fQYfdI0PzGeYsNWpQhM81CoEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 06:26:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 06:26:18 +0000
Date: Thu, 12 Jun 2025 14:26:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Filipe Manana <fdmanana@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  32c523c578:  reaim.jobs_per_min 16.1%
 regression
Message-ID: <202506121329.9d1f4d50-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e00146-b271-4666-6085-08dda97a0a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ForVD3PwO6HA9dVnZDD71paCutll/mYVv9EM72W3B57KoSTdSB2u1YVje9?=
 =?iso-8859-1?Q?d7RK4NuXG64bh8C7gYcBxNITFI5ueW2wP6jSfevar7cKgB9NBy9+RKRKQ4?=
 =?iso-8859-1?Q?Lrq3A0sPJ0SDb+oALl5vXNul4QJXQ00GTMy6HY2rEinYTn64n80bRSCUO6?=
 =?iso-8859-1?Q?K5qqvKZazm5ZTjjGaIX5hdaMo9crqe/emIV1eq1X2W60LQnnbDiw/g2I6z?=
 =?iso-8859-1?Q?eOBzXpt5MoXoMoF1gr6SGT8L4d9hq5ExkPGehJssyI0+akKoZXQSHRsw0a?=
 =?iso-8859-1?Q?5lfAHgbQlw5yMsjGl5/7JEmQAB9/GKpxESiLYriUAcYynFpc+sOpJdr3/q?=
 =?iso-8859-1?Q?VcKpbWkV4w2A+lEhh9cltf89uP+ONmkTlsoVUp10Rk4fZAb+aRvAitRtUj?=
 =?iso-8859-1?Q?jcIfTFmJXEIWoInszgTmhu5t5LC8wDEigP2Zxls23cIhSgt9nwvPZXF8pT?=
 =?iso-8859-1?Q?9HMg4qVUPxzLRllbhaTo2CH76i/k3uwN5CQIBzcu4m28Afw51h392A3Cwu?=
 =?iso-8859-1?Q?4/jUSI7ctK3+YxZThxHkSIr6IEmYYr/jrfT0uMkd03Ap4wQ3wYHswxAvPo?=
 =?iso-8859-1?Q?VfouXGFo+3cTzNfsePLvAHIb9WNnjpAYLS/76xU2uikX6inYo55huYxi/5?=
 =?iso-8859-1?Q?ncn0sazY7DxlXID17sfG7fG3LjTNAhNVblBpg7hSn3/8GWk4EoZn5NFkjK?=
 =?iso-8859-1?Q?ODyBDvrRL+b6DI9AFkhErE6F2uAkQARhtWJbeLNQqMmCdvpKNXmcsu5WNX?=
 =?iso-8859-1?Q?UZHbtTjaFqVKJJq+nkt0xkPXYaBMmoA4Y4UW9J2bJsDp8pltv/C6W3oHdz?=
 =?iso-8859-1?Q?smlxbDA2xR+eQRnkgt4E+Pj/aw5xqO7GLlKtDJ0gdQfDx+PUUp6i8tq/tR?=
 =?iso-8859-1?Q?zF/IPwE10M/eIZXPXAdI5v4cE7lY/Eww5UHoWRpQr85bQhS+w8y9GfT9aA?=
 =?iso-8859-1?Q?sFymBKwfmMBa2nUWsYzIoZUSP/s9H73YbfnCVIpWE/jaamCbMSuvPjswdU?=
 =?iso-8859-1?Q?8VGsNNBxCL05AgzoKYV4Yz4qt6TNJ1DAH1tGAZAgE50dDuf7Y80pMXBcu9?=
 =?iso-8859-1?Q?xvuLmEzBAEDnIlMu05u/wl7nsK7Nbfs9WAAzGUUTL4jFt09kUatF7TnY75?=
 =?iso-8859-1?Q?VRAV41jBJlEI8xXgEoQIfPZuKhOr+qRNs0L02rEyplEZY1hDfd0K97kl3c?=
 =?iso-8859-1?Q?5cl3qHC4i4YKncx9KwLEJRCB6r6FDijFDnNecd9rK8LW8HUpN2EbWfAQ9+?=
 =?iso-8859-1?Q?L6IuSLxpYIBqDz+x2n93SKUCyyiz7tI3mt7d6P16/qxLT1k0PlD/3bKT4E?=
 =?iso-8859-1?Q?m+gTdj4/HclaVvY6AoHYihVLTQC5caGBm1rWz02Co2Mof1eAbRHmMco1UH?=
 =?iso-8859-1?Q?vUccSFElusUFjEUqTyBtifoQbvpvj2nhINOTBjy7kgHXFwas++sMVEY7GS?=
 =?iso-8859-1?Q?8y45hvm8y4jpyWcF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lnarbB2VcUGZugOE6pAJNTq740mTDNYeiEIuYUoohAJfzlVZFjTVm5W4Mq?=
 =?iso-8859-1?Q?c+K+vs6xiqidv+kF1NurAqzVMMvLt5ChQHUy5VqwpAoJ/dCqg3OeGW9oMD?=
 =?iso-8859-1?Q?cVl4S3f8b7Nzt+ETTQpyTIhiKYSHyrppxeV9o9qDmrcxYjPT+Zqzg/jf1r?=
 =?iso-8859-1?Q?pBQApsKM88b//vh6htOAASLivzFMIMQbp+i0xUiZ1KpAO9JhdxsKC6qLg2?=
 =?iso-8859-1?Q?sfnl+bdvSTZspUsSj3cpojV+vMAICvPNpkS9TjDoDSbPJx9DCNDKHUKydV?=
 =?iso-8859-1?Q?vmQhUxyaK1CDxWK2UPIDN9JXz+7Lub0lDMVKYXEnmkKkVDU3Ns3jeUZgyT?=
 =?iso-8859-1?Q?Z3n6ZFSdFMbn5paCSsa0KbSsTkb+1qwtjOUsg/6dzMRiVHwn1aM7nUBFFs?=
 =?iso-8859-1?Q?JASJUUVrCqORupA9JZdJ/pWW+1dtL1OBR4N1Ru+3I9RvxsfBtH3hyF+ww3?=
 =?iso-8859-1?Q?J8zSbjLQWArEbwQg7mIFf13SWTVEDGvtJ9VkE45HGR+Ewpt33KlK+pp8NN?=
 =?iso-8859-1?Q?3M9S4Du/tHmzQc7nfgaNgdOCnY+bqzeSwH84OvdCZRqX047pOLtfYu19Ek?=
 =?iso-8859-1?Q?9+MkdWK+dNRwDFiwwePClMseSA3ZOWKbmm5cyKtzELOVHDf78tZjDLJD48?=
 =?iso-8859-1?Q?q9SdPtRQ9DKn5Ezupr8J/n1Avwlfl+Zi2q2T/IBXcH0kUOPFmRFC+aOtz8?=
 =?iso-8859-1?Q?wmbeF54AszGkJAjyMePkUobKu78hT/hAEECnResCg9pyxhW21q8fVCHnY/?=
 =?iso-8859-1?Q?u7UjeuaOVb7gpi3VegF+HvOjxpktinyToaQO37VpCT+L0Z1zff5DOHPPsQ?=
 =?iso-8859-1?Q?rESEzmvDWnvowzNXQWqVsgwJFXrfHyuWAp8cmyymh4S0KVL+Cqp7B0XU6r?=
 =?iso-8859-1?Q?k6U6vNII5/L0tk2FRUhBWg5CbLHEi0dR5gfrVU8DAVi73dXaou6DEe2MxR?=
 =?iso-8859-1?Q?8zmTf5eOui1Sem3eMcJ1/jjb4qEnbHmof5y50IV18RW/OtpT10vKCCSidm?=
 =?iso-8859-1?Q?nZkymw0keFXRIsSSqf+x5gFs+8mcw7qcpt2XPniH97Iwjoj7dCl3UhL5lH?=
 =?iso-8859-1?Q?hPWgaarKIHXGohAJ5qAiHyKPp1ntSiTNCJUX+izu+V5/feVV1UrdBuRnOA?=
 =?iso-8859-1?Q?H2jre8Ti5v+URwOe6EDvn3JoRCx4TCNgMKOV7gD9cvclhpHc/0FRXKCvPE?=
 =?iso-8859-1?Q?Fgq0HK1jjquF7r1JJagy2T2PUrfVacCS98cVU2lqNLOOQyahEgfuhP/VVg?=
 =?iso-8859-1?Q?+zWepvaO1S9lKxmP2Jd9sFkIt4TGwyHLrLKW4TPaxor3L21Io7PHiidDw4?=
 =?iso-8859-1?Q?dyU9Gyw7hJfI6p2DHm6c2hNN+xBNwN5911Kxn5raXFGqtMy4R3qpFZQaz/?=
 =?iso-8859-1?Q?A5BbTJ5MYjIdgHScAybESfoyKjFCzNT0Y8tFZ5HI4FQ07FbCV9YHPfPbaY?=
 =?iso-8859-1?Q?hpA7o6Zh7I2aJLJ3CGCM1dfLDXOcNuEFrp3XPI76Z885e9d7Wh8/uH3Ohx?=
 =?iso-8859-1?Q?qkgGF8DF1BpfyksigrOOOpkxsa6vbuYEhuCwir36wis0RsrCz6WjH9ts2t?=
 =?iso-8859-1?Q?HXODbaKI+02ROcbJT763q8cs5V3/JxALO+VoDSEoI9jvt0BD9SMSs+wl2D?=
 =?iso-8859-1?Q?5Qfu0ppleBKMs+24BV5OmD3ZOb8l3WYCCNnKn1hrRMflZNzxqGoYOPuQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e00146-b271-4666-6085-08dda97a0a33
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 06:26:18.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +StxF1dUUAuj86pNOvj3cqWW9ZKoHZO/hxbf3h4+QSne1VDqWhjahV3a2BXezx5ZdmAiqP2zJeFouq7pHRnSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 16.1% regression of reaim.jobs_per_min on:


commit: 32c523c578e8489f55663ce8a8860079c8deb414 ("btrfs: allow folios to be released while ordered extent is finishing")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      5abc7438f1e9d62e91ad775cc83c9594c48d2282]
[still regression on linux-next/master 911483b25612c8bc32a706ba940738cc43299496]

testcase: reaim
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	disk: 1HDD
	fs: btrfs
	test: disk
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min  5.3% regression                                                |
| test machine     | 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=btrfs                                                                                  |
|                  | nr_task=100%                                                                              |
|                  | runtime=300s                                                                              |
|                  | test=disk                                                                                 |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506121329.9d1f4d50-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250612/202506121329.9d1f4d50-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp7/disk/reaim

commit: 
  cbfb4cbf45 ("btrfs: update comment for try_release_extent_state()")
  32c523c578 ("btrfs: allow folios to be released while ordered extent is finishing")

cbfb4cbf459d9be4 32c523c578e8489f55663ce8a88 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     71009           -14.7%      60593        meminfo.Shmem
 2.344e+10           -10.8%   2.09e+10        cpuidle..time
   6491212           -20.8%    5141230        cpuidle..usage
     93.14            -1.5%      91.75        iostat.cpu.idle
      5.81           +24.8%       7.24        iostat.cpu.iowait
    419.83            -9.5%     380.03        uptime.boot
     24988           -10.7%      22325        uptime.idle
    584.67 ±  3%     -23.6%     446.83 ±  5%  perf-c2c.DRAM.remote
    551.00 ± 10%     -19.1%     445.50 ±  9%  perf-c2c.HITM.local
    407.83 ±  5%     -25.4%     304.17 ±  6%  perf-c2c.HITM.remote
      5.84            +1.5        7.29        mpstat.cpu.all.iowait%
      0.09            -0.0        0.07        mpstat.cpu.all.irq%
      0.53            -0.1        0.46        mpstat.cpu.all.sys%
      0.36 ±  2%      +0.0        0.40 ±  4%  mpstat.cpu.all.usr%
   2110659 ±  3%     -22.4%    1638521 ±  3%  numa-numastat.node0.local_node
   2132066 ±  3%     -21.5%    1673684 ±  3%  numa-numastat.node0.numa_hit
   2054843 ±  4%     -16.8%    1709588 ±  2%  numa-numastat.node1.local_node
   2099801 ±  3%     -17.1%    1740752 ±  2%  numa-numastat.node1.numa_hit
     61.66          +186.4%     176.60        vmstat.io.bi
     17553           -16.2%      14712        vmstat.io.bo
      3.91 ±  3%     +25.7%       4.92 ±  4%  vmstat.procs.b
      9668           -12.3%       8476        vmstat.system.cs
     13868           -10.9%      12357        vmstat.system.in
    521965 ±  4%     -27.8%     376885 ±  2%  numa-vmstat.node0.nr_dirtied
    500007 ±  4%     -27.9%     360465 ±  2%  numa-vmstat.node0.nr_written
   2131472 ±  3%     -21.5%    1673240 ±  3%  numa-vmstat.node0.numa_hit
   2110065 ±  3%     -22.4%    1638077 ±  3%  numa-vmstat.node0.numa_local
    423228 ±  4%     -21.9%     330636 ±  4%  numa-vmstat.node1.nr_dirtied
    405391 ±  4%     -21.9%     316667 ±  4%  numa-vmstat.node1.nr_written
   2099495 ±  4%     -17.1%    1739892 ±  2%  numa-vmstat.node1.numa_hit
   2054537 ±  4%     -16.8%    1708728 ±  2%  numa-vmstat.node1.numa_local
      4262           -16.1%       3575        reaim.jobs_per_min
     66.61           -16.1%      55.87        reaim.jobs_per_min_child
      4305           -15.6%       3635        reaim.max_jobs_per_min
     90.09           +19.2%     107.42        reaim.parent_time
      1.07 ±  4%     -15.8%       0.90 ±  3%  reaim.std_dev_percent
    369.06           -10.9%     328.84        reaim.time.elapsed_time
    369.06           -10.9%     328.84        reaim.time.elapsed_time.max
     45840          +155.6%     117178        reaim.time.file_system_inputs
   5943434           -25.9%    4401353        reaim.time.file_system_outputs
     18556           -29.3%      13119        reaim.time.involuntary_context_switches
   3738859           -25.0%    2804459        reaim.time.minor_page_faults
     28.83           -16.8%      24.00        reaim.time.percent_of_cpu_this_job_got
     93.94           -24.8%      70.62        reaim.time.system_time
   1061461           -24.9%     797506        reaim.time.voluntary_context_switches
     25600           -25.0%      19200        reaim.workload
    187046            -1.3%     184574        proc-vmstat.nr_active_anon
    945195           -25.1%     707517        proc-vmstat.nr_dirtied
   1133127            -1.6%    1115274        proc-vmstat.nr_file_pages
    214899            -7.1%     199637        proc-vmstat.nr_inactive_file
     17745           -14.7%      15145        proc-vmstat.nr_shmem
    905398           -25.2%     677133        proc-vmstat.nr_written
    187046            -1.3%     184574        proc-vmstat.nr_zone_active_anon
    214899            -7.1%     199637        proc-vmstat.nr_zone_inactive_file
   4233781           -19.3%    3415500        proc-vmstat.numa_hit
   4167415           -19.6%    3349180        proc-vmstat.numa_local
   4401990           -19.1%    3559895        proc-vmstat.pgalloc_normal
   4837041           -21.2%    3813117        proc-vmstat.pgfault
   4058646           -20.7%    3220351        proc-vmstat.pgfree
     22920          +155.6%      58589        proc-vmstat.pgpgin
   6526981           -25.2%    4881946        proc-vmstat.pgpgout
     48196            -8.6%      44072 ±  3%  proc-vmstat.pgreuse
      2.95            +0.1        3.06        perf-stat.i.branch-miss-rate%
   9010149            +3.5%    9323057        perf-stat.i.branch-misses
  15272312            -6.6%   14260618        perf-stat.i.cache-references
      9701           -12.3%       8509        perf-stat.i.context-switches
      1.97            -1.7%       1.94        perf-stat.i.cpi
 2.028e+09            -3.4%  1.958e+09        perf-stat.i.cpu-cycles
    345.48           -12.7%     301.68        perf-stat.i.cpu-migrations
      1061            +2.2%       1083        perf-stat.i.cycles-between-cache-misses
      0.53            +2.0%       0.54        perf-stat.i.ipc
      3.86 ±  2%     -20.1%       3.09 ±  3%  perf-stat.i.major-faults
     12520           -11.9%      11027        perf-stat.i.minor-faults
     12524           -11.9%      11030        perf-stat.i.page-faults
      3.66            +0.1        3.81        perf-stat.overall.branch-miss-rate%
     16.24 ±  5%      +1.2       17.46 ±  6%  perf-stat.overall.cache-miss-rate%
      1.64            -3.2%       1.59        perf-stat.overall.cpi
      0.61            +3.3%       0.63        perf-stat.overall.ipc
  17792434           +18.5%   21081619        perf-stat.overall.path-length
   8979944            +3.5%    9292382        perf-stat.ps.branch-misses
  15229067            -6.6%   14216663        perf-stat.ps.cache-references
      9674           -12.3%       8483        perf-stat.ps.context-switches
 2.022e+09            -3.5%  1.953e+09        perf-stat.ps.cpu-cycles
    344.62           -12.7%     300.82        perf-stat.ps.cpu-migrations
      3.85 ±  2%     -20.2%       3.08 ±  4%  perf-stat.ps.major-faults
     12486           -12.0%      10993        perf-stat.ps.minor-faults
     12490           -12.0%      10996        perf-stat.ps.page-faults
 4.555e+11           -11.1%  4.048e+11        perf-stat.total.instructions
     24864 ±  2%     -18.6%      20241 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.avg
      9646 ±  3%     -32.1%       6545 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.min
     88.62 ±  7%     +17.8%     104.42 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
    165.70 ±  8%     +21.4%     201.23 ±  6%  sched_debug.cfs_rq:/.load_avg.stddev
     24864 ±  2%     -18.6%      20241 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
      9646 ±  3%     -32.1%       6545 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
      7.59 ± 18%     +40.4%      10.66 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    197.81 ± 13%     +32.3%     261.71 ± 17%  sched_debug.cfs_rq:/.util_est.max
     31.28 ± 12%     +30.3%      40.77 ± 10%  sched_debug.cfs_rq:/.util_est.stddev
    229863           -17.2%     190282 ±  7%  sched_debug.cpu.clock.avg
    229868           -17.2%     190287 ±  7%  sched_debug.cpu.clock.max
    229857           -17.2%     190276 ±  7%  sched_debug.cpu.clock.min
    229303           -17.2%     189808 ±  7%  sched_debug.cpu.clock_task.avg
    229667           -17.2%     190143 ±  7%  sched_debug.cpu.clock_task.max
    219476           -17.8%     180349 ±  7%  sched_debug.cpu.clock_task.min
    749.88 ± 29%     -28.8%     533.95 ± 14%  sched_debug.cpu.curr->pid.avg
     32645           -29.7%      22956 ±  8%  sched_debug.cpu.curr->pid.max
      4481 ± 10%     -29.9%       3143 ± 10%  sched_debug.cpu.curr->pid.stddev
     29063           -30.0%      20341 ±  9%  sched_debug.cpu.nr_switches.avg
     83586 ±  2%     -29.8%      58716 ±  7%  sched_debug.cpu.nr_switches.max
     22149 ±  2%     -33.0%      14831 ± 11%  sched_debug.cpu.nr_switches.min
      7977 ±  2%     -25.6%       5937 ±  5%  sched_debug.cpu.nr_switches.stddev
     92.43 ± 28%     -47.8%      48.21 ± 10%  sched_debug.cpu.nr_uninterruptible.max
     25.24 ±  8%     -26.2%      18.62 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
    229859           -17.2%     190278 ±  7%  sched_debug.cpu_clk
    229148           -17.3%     189567 ±  7%  sched_debug.ktime
    230484           -17.2%     190908 ±  7%  sched_debug.sched_clk
      0.00 ±136%    +392.6%       0.02 ± 80%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.03 ±114%     -56.9%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.25 ±209%     -95.1%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.21 ± 40%     -38.8%       0.13 ± 11%  perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.07 ± 42%    +126.0%       0.16 ± 72%  perf-sched.sch_delay.max.ms.wait_extent_bit.__lock_extent.lock_extents_for_read.constprop.0
     26708 ±  2%      -9.5%      24158 ±  3%  perf-sched.total_wait_and_delay.count.ms
      3.20 ±  9%     +25.5%       4.02 ± 11%  perf-sched.wait_and_delay.avg.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
      7.26 ± 15%     +50.7%      10.94 ± 19%  perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
     19.16 ± 29%     -65.5%       6.61 ±142%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_wait_ordered_roots
      0.02 ± 59%    +188.1%       0.05 ± 63%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.sync_inodes_sb
     15.73 ± 19%     +50.8%      23.72 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    256.17 ± 15%     +34.5%     344.47 ± 13%  perf-sched.wait_and_delay.avg.ms.wait_current_trans.start_transaction.btrfs_create_common.lookup_open.isra
     78.54 ±  8%     +18.1%      92.78 ± 11%  perf-sched.wait_and_delay.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_sync
     67.31 ±  3%     +12.5%      75.72 ±  5%  perf-sched.wait_and_delay.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
    805.00 ± 11%     -21.9%     629.00 ± 11%  perf-sched.wait_and_delay.count.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
    833.33 ±  5%     -29.6%     586.50 ± 13%  perf-sched.wait_and_delay.count.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      2990 ±  5%     -16.5%       2498 ±  3%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    151.17 ±  6%     -70.6%      44.50 ±141%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_wait_ordered_roots
    553.50 ±  5%     -26.3%     407.67 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.btrfs_wait_ordered_extents.btrfs_wait_ordered_roots
    618.50 ±  9%     -25.4%     461.17 ± 12%  perf-sched.wait_and_delay.count.wait_current_trans.start_transaction.btrfs_sync_file.btrfs_do_write_iter
    955.00 ±  8%     -27.5%     692.17 ±  8%  perf-sched.wait_and_delay.count.wait_log_commit.btrfs_sync_log.btrfs_sync_file.btrfs_do_write_iter
    551.40 ± 10%     +33.8%     737.66 ±  8%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    251.59 ± 18%     +74.5%     438.99 ± 14%  perf-sched.wait_and_delay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
     11.70 ± 99%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     44.61 ±189%    +762.7%     384.84 ± 81%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      3.19 ±  9%     +25.6%       4.00 ± 11%  perf-sched.wait_time.avg.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
      7.24 ± 15%     +50.9%      10.93 ± 19%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent_nowriteback.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      1.69 ± 79%    +178.9%       4.71 ± 62%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.btrfs_writepages
     15.72 ± 19%     +50.9%      23.71 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     20.99 ±  2%     +38.2%      29.02 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.btrfs_sync_log.btrfs_sync_file.btrfs_do_write_iter
     12.97 ± 13%     +49.0%      19.32 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.barrier_all_devices
    256.15 ± 15%     +34.5%     344.45 ± 13%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_create_common.lookup_open.isra
     10.94 ± 25%     +84.6%      20.19 ± 24%  perf-sched.wait_time.avg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range
     78.51 ±  8%     +18.1%      92.75 ± 11%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_sync
     67.26 ±  3%     +12.5%      75.66 ±  5%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     19.50 ±128%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     83.75 ±187%    +516.6%     516.38 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
    551.39 ± 10%     +33.8%     737.64 ±  8%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    251.57 ± 18%     +74.5%     438.95 ± 14%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
     86.74 ± 14%     -27.4%      62.97 ± 11%  perf-sched.wait_time.max.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range


***************************************************************************************************
lkp-ivb-d01: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/300s/lkp-ivb-d01/disk/reaim

commit: 
  cbfb4cbf45 ("btrfs: update comment for try_release_extent_state()")
  32c523c578 ("btrfs: allow folios to be released while ordered extent is finishing")

cbfb4cbf459d9be4 32c523c578e8489f55663ce8a88 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     22777          +101.6%      45913 ± 13%  proc-vmstat.pgpgin
     12134 ±  4%     +18.9%      14426 ±  7%  sched_debug.cpu.nr_switches.stddev
     80.30            -1.8%      78.89        iostat.cpu.idle
     17.77            +8.1%      19.21        iostat.cpu.iowait
     54.02          +101.9%     109.06        vmstat.io.bi
      4061            -5.0%       3856        vmstat.io.bo
      2.60            +2.2%       2.65        reaim.child_systime
    348.91            -5.3%     330.27        reaim.jobs_per_min
     43.61            -5.3%      41.28        reaim.jobs_per_min_child
    356.27            -5.4%     336.88        reaim.max_jobs_per_min
    137.64            +5.6%     145.41        reaim.parent_time
     45554          +101.6%      91826 ± 13%  reaim.time.file_system_inputs
      0.17 ± 25%      -0.1        0.09 ± 31%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.16 ± 29%      -0.1        0.10 ± 33%  perf-profile.children.cycles-pp.vfs_fstatat
      0.21 ± 16%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.___perf_sw_event
      0.06 ± 79%      +0.1        0.16 ± 33%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.07 ± 72%      +0.1        0.18 ± 16%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.19 ± 18%      -0.1        0.12 ± 19%  perf-profile.self.cycles-pp.___perf_sw_event
      0.15 ± 30%      +0.1        0.23 ± 33%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.04 ±  9%     +21.8%       0.05 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.barrier_all_devices.write_all_supers.btrfs_sync_log
      0.05 ±  4%     +18.7%       0.06 ±  4%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
      0.04 ± 69%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range
      0.05 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range
     19.30 ±  9%     +17.0%      22.59 ±  6%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
     19.25 ±  9%     +17.0%      22.53 ±  6%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.write_all_supers.btrfs_sync_log
     15.74 ±107%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range
     22.16 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_extent_bit.__lock_extent.lock_and_cleanup_extent_if_need.copy_one_range
      4.44            +1.9%       4.53        perf-stat.i.MPKI
      8.16            +0.2        8.41        perf-stat.i.branch-miss-rate%
      2313            +1.6%       2350        perf-stat.i.context-switches
      2.25            +1.9%       2.29        perf-stat.i.cpi
     73.48 ±  3%      -6.6%      68.61        perf-stat.i.cpu-migrations
      1972            -2.1%       1931        perf-stat.i.minor-faults
      1972            -2.1%       1931        perf-stat.i.page-faults
      2308            +1.6%       2344        perf-stat.ps.context-switches
     73.31 ±  3%      -6.6%      68.45        perf-stat.ps.cpu-migrations
      1967            -2.1%       1926        perf-stat.ps.minor-faults
      1968            -2.1%       1926        perf-stat.ps.page-faults





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


