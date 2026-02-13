Return-Path: <linux-btrfs+bounces-21657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DmzATN7jmmJCgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21657-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 02:15:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBF6132354
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 02:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C66F301168C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F581DA23;
	Fri, 13 Feb 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8f06Kgg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D051224D6
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945323; cv=fail; b=c0ELTdkw/MvCc3F1KXMWiMQPkLnQsPUcc6Xa+SC4nbTcr9wU8Lgz+Df3yrdLEY+kzatV9cj0dmFIvmdyjMu+SpXJVpers3ckju20bdaKREugeNPpmh4ZPGScvrOyJbLzGIsbc7JPWSs7OMI7ssajZh5C67lnR3hO5dRGwwcx/Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945323; c=relaxed/simple;
	bh=XKv5cr3P4trt4uDrZRHsMtASEFbCmWF78DyyrV9Bzzg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i1D10FyaZIwAsfdsd3x46b4Sn60nT9n37Rr3ubuvsu6ObTXWNw4NykAIKywU4khNcGMXUeC/athp0DfCUBShWds12ODvZjEMDTIQhj4e8Led6PVktN4loQ+4dZa//pupNo5dcTpBpZ0YbtnyLZQO+FmqkKh+6E+H1LBFpWRTUqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8f06Kgg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770945321; x=1802481321;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=XKv5cr3P4trt4uDrZRHsMtASEFbCmWF78DyyrV9Bzzg=;
  b=A8f06KggfAwjxqkFjmcGEY89iwbrA1b0p3uzdaE1+vDQW9lFxO6k0r64
   XNqzbkfIqrlrIIEwaKtvLSNiVO4ar4FJVIDAwsVHiMmbel98kJ7pLYGbE
   GoTSpbXZYsSBX4yv5XDqxmkSCdOzHuO9qCg8EQifSSdBuKMPqoEapxaM5
   /8K7Tsgsz8BDOYn2Q47lTOfQzvc3l0GV8oHesyRhz3KlMceKQiu8QSGQL
   stI9HD7O4qbS2FI8o3UGleBqjfLZ6VjnGpHNQXrbdUx2EtkWEZRZftdNd
   bNlKGBkDaLMMgp2FF/6nK208CsfH95f1cmhEI8SSWmmLhXYxxXPQ4ke2g
   Q==;
X-CSE-ConnectionGUID: 3nO1Hr8rQf+BUrrre7jfmQ==
X-CSE-MsgGUID: 7kvb8TBwTvG/YQGiMtE1Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72312682"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72312682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 17:15:21 -0800
X-CSE-ConnectionGUID: GvN0+w04SQCvr6CID8EMSA==
X-CSE-MsgGUID: iv77Pw24Sh2ie7FpJ3l05Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211527749"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 17:15:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 17:15:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 17:15:20 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 17:15:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dybtwONV7aAa8mFhl1HGWhaxGfD6XFFxIpb7aOfyeDvRmt59jh5vigagtB4hIG6oHfMOEZg32Vjb2IFxK1Vwgrf5rYyQbRDd/wQg8cZP0r1qGcho8DxJwcmQM6MQ4toMuDo6H9COdMFmlAQqlCZE87G9Igr9akgOjWe+FUwlsA8qU7lmS5cKK2rj+1fPDobkHGwuRMMVgqX1uy/vznEmDLIqr9MdJDN4ivCWwgMfjDfIUar7Xc+SahLlvS6qLCU60WojR7AdahRgyhpc2F6NtyC2xmKePGc+Pgf3WZi4s72gAkUpIsvMo6kaDyEPkMEnYfrHhHKi+PLud+uTvBWyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzu5Ep5lwxszaq9LV5tD2zTj1LTap6Mxcw/EFOeMMxQ=;
 b=WTpB42z3cFY6oGQBpYwEXakHmZn/Iu+dMVcA7IjPJbXra5JnSa4EhIz0IFC+U2IAgQQX1A48xWlfR6jrUjl7MHrmMu0//7Bz1j7Ax5VbTh3urpy32EtJ2GOKt7LiE2aoHVxRhLKtv0Th+5QCGqYTSjaritb2CdY9zT4UKHK6Aol4nvLkGnqlinx81fscUY9g9ARSozDdmUEkV2N/A5/dtoxbmOpXz99+yN6NVlAqQkDg2Akg4N2sHetXKd0r0nNaMWI6VgO6vtevzlB5Z9r+yEVjRco13ZtEBn3B4ZIEqMI94fXJzAsNeEORhiAD2pFomInzRb9S+2IkZIjPVv3ACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 01:15:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 01:15:17 +0000
Date: Fri, 13 Feb 2026 09:15:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/3] btrfs: update per-profile available estimation
Message-ID: <202602130252.89b82f3f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4d6fcecccd3c2c3b5359131e0493f190d1f5959.1770173615.git.wqu@suse.com>
X-ClientProxiedBy: CH0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:610:119::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ff0478-c969-4990-a691-08de6a9d5931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?25OT15q3nw95ohLiP8oum/zVRr1f8ilBmuKYdVu+dlDVJy2Qh9YZ3xA8OCVu?=
 =?us-ascii?Q?be3Nqo+KNgb3lraAi4yEahP5k46eOtNdhNmdhdvR0kWrVJ6AFSkzm0bl9gu1?=
 =?us-ascii?Q?qoM/A71znIA9fF2eYsI7QzwhYsMOuUxdpyU+l26AdAhxCAessOAMty0WFr2d?=
 =?us-ascii?Q?f29aWvtJ8pGm9Q3g86Qq+I4ty/OOrcDOKgEuojQ+2+EFKQN/WtKzP6PcAbzd?=
 =?us-ascii?Q?im06Pi/SSTtnIALgUSBKFPk8pN2Nf192X0wA44Ji6yEkjy3myOJ7fSGv3NRN?=
 =?us-ascii?Q?P/jr1iX9xlv1NWm1Cq/omVlQG8RcrpTKV6kvsopInLoNfrXhGUOmT1cIelj/?=
 =?us-ascii?Q?luG9MxBNQ9HUw08+a/q9UAOP7yRa/iFZ7JOZmus3S4rjCuFsi4y0zWPThAPX?=
 =?us-ascii?Q?kcPK3zls3cXelmSMsqzMaxmev9x/aYVNIFeb3bcKlrDqfJg0KATVq9Un+gr0?=
 =?us-ascii?Q?Xvjxfxt7VHx8TBWyNhgj0Lq9D+2eCzi9LbgbFuw+74+YEyl8ZE9hsKdSZK/7?=
 =?us-ascii?Q?Kmye2OL6BqZ69W7VMmlRfC4akEjLi76RHEgyCUONaGbf6W8MXs+8wOifGD6w?=
 =?us-ascii?Q?CEMhorxEN4hov43Co+n+2m0+HlnhQrwkcmJfAVEHhmK5+waSaEpzKKtSFsrv?=
 =?us-ascii?Q?cJnP0H9hsvUjTAn0Xkms2l6BiirjBsc8ScPD9y1B7Vaul/NoUV9vD8OcOR7r?=
 =?us-ascii?Q?wEWtQd+RqREyPmfZ0Kr+WqCuTQMNYj1W0HEoZ4cDZ9ubLkWghSbpIittqcti?=
 =?us-ascii?Q?LpF7O7wERA1dpPDuf9zF7W+JTh5o6VcfTPMveAgsDxSOyM/ZXiGIs5ouWhMY?=
 =?us-ascii?Q?pTtgCDKTtHFaiklCOYKnGDN1oa1/7dufScozl2GYWIPHe8o49+OHyZE1Vgvq?=
 =?us-ascii?Q?kCzuf2BPrwutF80R8wXrLnxv1NqATu5UeWGVRkAK6H3itCAAHQGLUytKN1k5?=
 =?us-ascii?Q?DJwGHsZSkKGc94mrTxjCabp8UDvVKYk/fj5HVeO/eTeSo6bkSy5i2crjacBT?=
 =?us-ascii?Q?t/A1+c2r7RcKc7LCLNQ55s72z6A+8kV9+p65UzyiCrpE/fPd4MRXeOpcRTtv?=
 =?us-ascii?Q?XhZXaycvlkg/+04Yz0YlxA0hFbG8D5SRYHXSJpFgPl4WWnybb4l7dKMEZmmY?=
 =?us-ascii?Q?9sQtpLhOMTNDDTs4UolNJFkDTBvHoDtSOW/8d5YYQXoa13pPWH6oxNtE+Tse?=
 =?us-ascii?Q?HR+LQZWitNRQuzdvPWDkXXr+QoL9TXcHQLhVf+lVeVqWD+cYEA4nthH6mS4b?=
 =?us-ascii?Q?Sf8Drrdz3rnAGRaLM1TJXitlKFBLb/U5Sy/ePeAbzKYn+qi+pbFjk1VfrAUp?=
 =?us-ascii?Q?erryX8wA5qpp5PrNEPuIv+9mkPKoprWtXyA5zl214uNa76ezr+GM9NHjeJiH?=
 =?us-ascii?Q?b4+WAWarXy0T9IYs0mChPRw8kOkWiRSGgZIOqYOGu0EzGVP1ojYtM2Nls3fh?=
 =?us-ascii?Q?G9E6Wc8Rz+vF6CmFZiTalcZYK/4HUZvs3bB3D+wP53qPYAKmP9QYdDU/MuzF?=
 =?us-ascii?Q?ZyVZ3O5CpCNzICsaDxwccdwlNNZi4tvYHfycIavwGkzcCZRtyPN8Wei7dA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZkejRxZCLs0g1G4dzg5OT9rpWjxv1gbMGFeTSsJ/GINq9egSVpsWbPAS9Gl?=
 =?us-ascii?Q?FYub2oqDXY72Ij4YHw45LfPqb+Qle6B5gUKZzyQag+1+uyQXS77FuOUhHJ44?=
 =?us-ascii?Q?BLwIVv6QrdrGX2ut/m6liMqHBDT/Y+IM/LcGgVzocvmuPs61WKUJN1Pk3GVY?=
 =?us-ascii?Q?Iaj04DxdrF3bDbw2c2nAsDBl8AtU0Y0y2cidyE74MmoQ5MfaRnBx7salvuYT?=
 =?us-ascii?Q?Ovj5n5wvVppe4oLUtn/FcG7HV3XfYlwt/SSHazvpoF1PJHAep/JwDv5ZKYHy?=
 =?us-ascii?Q?7zsF+Kx4afWEeYR6zH+RR1pTIlXe9uaJ/ISYJYtn2Wd70xUxQe2m/tCaBf5y?=
 =?us-ascii?Q?Uh47pdQ924Jd5z64EoBUqjcnRb46lddThAbarUafpiH2CmGXbMu1QYc7VQog?=
 =?us-ascii?Q?vcr14FzQZ0x+yvXCKml4fzpHf8hdUDoz3ozSoz+NEQ4CyUQ+M7J0TpbwYrJn?=
 =?us-ascii?Q?3ekL0cL3jar6UW8KF8uW7oj6exFkHNlxP8xE8fnVdgssscVk1pNSXMAaLqtP?=
 =?us-ascii?Q?XBKReSVsG1wMTeUs0AaOthK586oahHfftydeDyUv+cZmNanrBcSj61USkuBd?=
 =?us-ascii?Q?eoRmOkWK5DDJaqmJGv4xabC7QJhkRy/MdkFjHpX8/dNlqk+FVd2ADFythC9D?=
 =?us-ascii?Q?SNq2VVc5/hwpuS/9hV/MKW82fOENNtmDEm/yR61ru3YIwb9HxzrplSp4SRQy?=
 =?us-ascii?Q?yR0Nxpi56dmkzIEwRBpNDPYnbda13Vbkzeq7pApN3h/Al69l83he2l4A93dV?=
 =?us-ascii?Q?0mMf3MbGEzpt/DUg/9VDnBJSTgvJjFtpte8bJyVElFS4SgGipVjPmyZ7LXJI?=
 =?us-ascii?Q?bL03IUoLGKMlscN8FuZW2yPdwiVoWubYyMWpZAib5vQSrjkyW50tUdltlfi1?=
 =?us-ascii?Q?tYAX0ZiwUY7HJ+6hjDw5/OXp5l51OdRXSC9iPmLxYi4gzxQBSrS25D3oSLu+?=
 =?us-ascii?Q?UL8rQZeCtLO8O0EWzq0qQ/eX64TOjF6UTRTJn/Fy5ChyuyfNFHDjKRFmBSbB?=
 =?us-ascii?Q?nMrzkDNTSDTKH18zIGU2FvaWugqj2cOAMVb0kjAA/J15SGoMQQZ0rmaQf/2t?=
 =?us-ascii?Q?DD43Mw+yjBEDxzx9Id6c/9sAK/EGia2Z4d++rh+2x9IkVacuSHZTqWnTbQlU?=
 =?us-ascii?Q?BUG2vOU1jSUDadRPfYlUFLX6o0F73N7yhRVA2Oe7DLmcS1YXJadbHDMJy8cI?=
 =?us-ascii?Q?k/sFsEDInhTFCWrlPxpePBvoVl87NEzgBdz87Nf1rAipzJMSCODFBS44riVn?=
 =?us-ascii?Q?HZ4fwXIUgsbE5dj6twlk1H0RKjx+leCS9nACO49brF01wMBHzXFZwgltY9Wn?=
 =?us-ascii?Q?zUKetGykZGo9RVhHkMMg++e6r1bJTUDJz5yeWY5trN1PUzl7CjBJAIwcr7lY?=
 =?us-ascii?Q?ZFAnYh4QSVE0BcxlNruf/30EPbukPZ5khMOpkWbR3Dsn/bFj8YwHfuX++w2V?=
 =?us-ascii?Q?iVCUFlunfKtk0y3Rtyiqf7pndghTYPSfHDBvD5zN/d8iO1mlv+unTyrZsEuP?=
 =?us-ascii?Q?7vaj5snhq5k39CgxgafVn/d8wRJxr5QBkT/Sqwowrk56SAjEkVVFj9XSgsEB?=
 =?us-ascii?Q?bjorrZriSDK/kCvrTqe9qoBnHAn57zGzdLXS0U0Iai/UZlNenAdZJ+zhn4rD?=
 =?us-ascii?Q?7AMz7JTd53S5jydemaK4LC9DkDCmdrntTNRUWYw5onrSPyFSZB6J/DH/bnTp?=
 =?us-ascii?Q?XK+MaHd4UoM70qlpyheflz6pudYL2UdTWaN10FD1KQnE3oip1VeKa9Fea4xx?=
 =?us-ascii?Q?lU/fqrCD3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ff0478-c969-4990-a691-08de6a9d5931
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 01:15:17.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M89W3ND4tFMcA8ju3tGXDtLBKUcxD0vKOPyg7huuiWGXqIAaflAXTbgLLlodJVGbcqJq1eWAgDhjkzdUWb6yMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21657-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0BBF6132354
X-Rspamd-Action: no action


Hello,

kernel test robot noticed "INFO:trying_to_register_non-static_key" on:

commit: 50b35a50fe83cb7870710b173f8b5ee78dd20107 ("[PATCH v2 2/3] btrfs: update per-profile available estimation")
url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-introduce-the-device-layout-aware-per-profile-available-space/20260204-105811
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/b4d6fcecccd3c2c3b5359131e0493f190d1f5959.1770173615.git.wqu@suse.com/
patch subject: [PATCH v2 2/3] btrfs: update per-profile available estimation

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 22 threads 1 sockets Intel(R) Core(TM) Ultra 9 185H @ 4.5GHz (Meteor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602130252.89b82f3f-lkp@intel.com


kern  :err   : [   91.987109] [   T4552] INFO: trying to register non-static key.
kern  :err   : [   91.988642] [   T4552] The code is fine but needs lockdep annotation, or maybe
kern  :err   : [   91.990349] [   T4552] you didn't initialize this object before use?
kern  :err   : [   91.991930] [   T4552] turning off the locking correctness validator.
kern  :warn  : [   91.993525] [   T4552] CPU: 1 UID: 0 PID: 4552 Comm: mount Tainted: G S      W           6.19.0-rc8-00146-g50b35a50fe83 #1 PREEMPT(full)
kern  :warn  : [   91.993530] [   T4552] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
kern  :warn  : [   91.993531] [   T4552] Hardware name: ASUSTeK COMPUTER INC. NUC14RVS-B/NUC14RVSU9, BIOS RVMTL357.0047.2025.0108.1408 01/08/2025
kern  :warn  : [   91.993532] [   T4552] Call Trace:
kern  :warn  : [   91.993533] [   T4552]  <TASK>
kern  :warn  : [   91.993535] [   T4552]  dump_stack_lvl (lib/dump_stack.c:122)
kern  :warn  : [   91.993541] [   T4552]  register_lock_class (kernel/locking/lockdep.c:985 kernel/locking/lockdep.c:1299)
kern  :warn  : [   91.993545] [   T4552]  __lock_acquire (kernel/locking/lockdep.c:5113)
kern  :warn  : [   91.993549] [   T4552]  lock_acquire (include/linux/preempt.h:469 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
kern  :warn  : [   91.993551] [   T4552]  ? btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
kern  :warn  : [   91.993701] [   T4552]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
kern  :warn  : [   91.993704] [   T4552]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
kern  :warn  : [   91.993706] [   T4552]  _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
kern  :warn  : [   91.993710] [   T4552]  ? btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
kern  :warn  : [   91.993849] [   T4552] btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5537) btrfs
kern  :warn  : [   91.993988] [   T4552]  ? __pfx_btrfs_update_per_profile_avail (fs/btrfs/volumes.c:5518) btrfs
kern  :warn  : [   91.994127] [   T4552]  ? btrfs_verify_dev_extents (fs/btrfs/volumes.c:8602) btrfs
kern  :warn  : [   91.994268] [   T4552]  ? __lock_release+0x5d/0x1b0
kern  :warn  : [   91.994270] [   T4552]  ? rcu_is_watching (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_tracking.h:128 kernel/rcu/tree.c:751)
kern  :warn  : [   91.994274] [   T4552] btrfs_verify_dev_extents (fs/btrfs/volumes.c:8604) btrfs
kern  :warn  : [   91.994415] [   T4552]  ? __pfx_btrfs_verify_dev_extents (fs/btrfs/volumes.c:8512) btrfs
kern  :warn  : [   91.994562] [   T4552]  ? btrfs_verify_dev_items (fs/btrfs/volumes.c:8641) btrfs
kern  :warn  : [   91.994704] [   T4552] open_ctree (fs/btrfs/disk-io.c:3533) btrfs
kern  :warn  : [   91.994842] [   T4552] btrfs_fill_super.cold (fs/btrfs/super.c:981) btrfs
kern  :warn  : [   91.994976] [   T4552] btrfs_get_tree_super (fs/btrfs/super.c:1945) btrfs
kern  :warn  : [   91.995108] [   T4552] btrfs_get_tree_subvol (fs/btrfs/super.c:2087) btrfs
kern  :warn  : [   91.995241] [   T4552]  vfs_get_tree (fs/super.c:1751)
kern  :warn  : [   91.995245] [   T4552]  vfs_cmd_create (fs/fsopen.c:231)
kern  :warn  : [   91.995249] [   T4552]  __do_sys_fsconfig (fs/fsopen.c:474)
kern  :warn  : [   91.995251] [   T4552]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
kern  :warn  : [   91.995255] [   T4552]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
kern  :warn  : [   91.995257] [   T4552]  ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:108 arch/x86/entry/syscall_64.c:90)
kern  :warn  : [   91.995261] [   T4552]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
kern  :warn  : [   91.995263] [   T4552]  ? __pfx_ksys_read (fs/read_write.c:705)
kern  :warn  : [   91.995265] [   T4552]  ? kfree (mm/slub.c:6674 (discriminator 3) mm/slub.c:6882 (discriminator 3))
kern  :warn  : [   91.995268] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [   91.995270] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [   91.995272] [   T4552]  ? __do_sys_fsconfig (fs/fsopen.c:499)
kern  :warn  : [   91.995274] [   T4552]  ? __do_sys_fsconfig (fs/fsopen.c:499)
kern  :warn  : [   91.995277] [   T4552]  ? __pfx___do_sys_fsconfig (fs/fsopen.c:356)
kern  :warn  : [   91.995279] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [   91.995282] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [   91.995284] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [   91.995286] [   T4552]  ? do_syscall_64 (include/linux/irq-entry-common.h:298 include/linux/entry-common.h:196 arch/x86/entry/syscall_64.c:100)
kern  :warn  : [   91.995288] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [   91.995290] [   T4552]  ? do_syscall_64 (arch/x86/entry/syscall_64.c:113)
kern  :warn  : [   91.995292] [   T4552]  ? irqentry_exit (include/linux/irq-entry-common.h:298 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
kern  :warn  : [   91.995294] [   T4552]  ? trace_hardirqs_on_prepare (kernel/trace/trace_preemptirq.c:64 (discriminator 4) kernel/trace/trace_preemptirq.c:59 (discriminator 4))
kern  :warn  : [   91.995296] [   T4552]  ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4629 (discriminator 4))
kern  :warn  : [   91.995299] [   T4552]  ? irqentry_exit (arch/x86/include/asm/jump_label.h:37 include/linux/context_tracking_state.h:138 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:301 include/linux/irq-entry-common.h:341 kernel/entry/common.c:196)
kern  :warn  : [   91.995301] [   T4552]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
kern  :warn  : [   91.995304] [   T4552] RIP: 0033:0x7fb38ba0e4aa
kern  :warn  : [   91.995331] [   T4552] Code: 73 01 c3 48 8b 0d 4e 59 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1e 59 0d 00 f7 d8 64 89 01 48
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
kern  :warn  : [   91.995334] [   T4552] RSP: 002b:00007ffd1dd07898 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
kern  :warn  : [   91.995337] [   T4552] RAX: ffffffffffffffda RBX: 000055a8acde41d0 RCX: 00007fb38ba0e4aa
kern  :warn  : [   91.995339] [   T4552] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
kern  :warn  : [   91.995340] [   T4552] RBP: 000055a8acde5d20 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [   91.995342] [   T4552] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
kern  :warn  : [   91.995343] [   T4552] R13: 00007fb38bba0580 R14: 00007fb38bba226c R15: 00007fb38bb87a23
kern  :warn  : [   91.995347] [   T4552]  </TASK>
kern  :info  : [   92.094700] [   T4552] BTRFS info (device nvme0n1p5): enabling ssd optimizations
kern  :info  : [   92.096302] [   T4552] BTRFS info (device nvme0n1p5): turning on async discard
kern  :info  : [   92.097968] [   T4552] BTRFS info (device nvme0n1p5): enabling free space tree


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260213/202602130252.89b82f3f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


