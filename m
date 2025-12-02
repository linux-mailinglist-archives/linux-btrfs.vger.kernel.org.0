Return-Path: <linux-btrfs+bounces-19463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252FC9C56D
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF93A32CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491C2C029F;
	Tue,  2 Dec 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQBYdac8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B82BE655;
	Tue,  2 Dec 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695367; cv=fail; b=X14vgkuudvrHFoCAcinT6hiEixs+EKNvbLpdIDlSc/4Bf13+G3t+3Iy0tJc2V81cjbGEy0o8AXBZaQetd6IVBOQkwDqD0bKscvDaR+4l53W2nT2RKYAiWdLWMIRSboyyLpIllHBEOodqqmQW3Z2kSOuHSR4RIybqJCAjvGyHav0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695367; c=relaxed/simple;
	bh=OggpKrRkJEKOx/zZl0WNAuISA68Qjrvc4qbL35Xu2t0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIlV5mNqcipIXtE8VFtB4DkXbOPWYp3fV+rM4TflNoH8lDj0g7EyiNaF/1bW/8mOpviqv+Z+AiBginLoOYZtnNsAuTjRqrm+KwsK0bV7EfySZppWJbrPaba7Ilit0xzBsVIXFVRUlqDqdr0YLw3IBeGYmSQPVexeC0xh/ScD7BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQBYdac8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764695365; x=1796231365;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OggpKrRkJEKOx/zZl0WNAuISA68Qjrvc4qbL35Xu2t0=;
  b=BQBYdac8Wfq8VuV5HZBGhJ0Le/jSjE4nqxN1PZTNgdLl4Fm4CN8MGoFW
   ipTosgCFQaMKLXwvUoyv11gY7y9aIrtEz7jeGWLoZdGrXnoFNwGNy0rM3
   bQnrzdfHRNdc0OWGMDwyUqcZxNfp+KJzHSUObmOpLI1smMWlTxZJ+ivqP
   mBT3bsaVXAqf63smM6LgTrZiDoe+u7AD8cS5YM28Qkn/DqIX1+EloJh4v
   8l6A0l8VORPJSjRsAhlhYImRAxLP3yQ6FW4/VemsgttzHfH3zgahqEGJQ
   smN9HqshoDWoa9JNI34IYDOuf8nuwXjOR2HwTpBFD4XQynRAkWB7jzhjr
   g==;
X-CSE-ConnectionGUID: ee3581AGT9+8lfE6rsiKvw==
X-CSE-MsgGUID: 5yRaJB7PR7OcOneZjYX/WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70289068"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="70289068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:09:23 -0800
X-CSE-ConnectionGUID: LlQBgZO8SPuTcl7btrIqSQ==
X-CSE-MsgGUID: ezODYhiBQ7+FCvp1FJxkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="195239551"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 09:09:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:09:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 09:09:22 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 09:09:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huyiIR2+6xlGa+9RileCQwd4+IcRzWUIGwpd/qRJLtq+tchELLHYrn7GTzvMvGrmJa4MF5wGrvIQlq6jT28IWMgTusKq1qKWqT8e+VesXFRLBOrKfIpvxsvYZ3ANnDNDEOwd+cK/eggp2GI+oKAoRWWZs7fmsSEyzrdaL2gFH7ahCMDdmn4Uht6EEVA62ruynO5oinW9HNIJgt+cvIGRVtmKEbpI4lkoHaaISYh7m8G5wYjWYPqszazrJ8mX2+pfhEvDSAUPQWA/Y6xnKupksCnqFaWSIq9Q/IrCknE49pSsE4+P6+c5PUzFMPWMABn5QZ9gfDrYBm++opUOEYy+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/ZxJIhKypp7Wq/UeGrN6ayYx6bB7xlg1bHFI0gV9m4=;
 b=LahJZMhUQt6dFj8eoqVADA5PZK4U8ZchLB+Rsau98cTPBv5Fe2IevSAUdwzuRR+rkjDM7ejZSZozhbaqlDY0lw0sP4ncSmycuGC7wnHMgOrZOCCFviH+nmxskO/V8gRSVW1Xna7PvPt5xleNxJolIWGUx1AObdJ3L0IB+vNKQeuu/yvSCjukYWiVQ128vzcriGodaq4QVHkJ0LBJS5+YXEW+dN95Xo4DOWs2Y03uoCTAgVDt+Z8ED2O4BoTr8N47laKW3swTofGvwghSMogKG32WSdhgwYh1rEvfjaPDPGV1TU2NNoWbmqSXahHZGUGWCKSvdy4Lv0rEL8hjEbl85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by BL4PR11MB8848.namprd11.prod.outlook.com (2603:10b6:208:5a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 17:09:19 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 17:09:19 +0000
Date: Tue, 2 Dec 2025 17:09:10 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: <dsterba@suse.com>, <herbert@gondor.apana.org.au>, Qu Wenruo
	<wqu@suse.com>, <clm@fb.com>, <terrelln@fb.com>,
	<linux-btrfs@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<qat-linux@intel.com>, <cyan@meta.com>, <brian.will@intel.com>,
	<weigang.li@intel.com>, <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <aS8dNt3gCzlIxBIs@gcabiddu-mobl.ger.corp.intel.com>
References: <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
 <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
 <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU7P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::26) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|BL4PR11MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3520e734-8a50-4950-9fe1-08de31c587cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elc5aGdXQmJlUE9aTjh2a2dDTzlTNTU2RmRqbVRKSCtKYnYrQy9TNjdyREd4?=
 =?utf-8?B?cEZvRk5RNmhDeEJsT1g0cUx0bmJJcG11VGkxWnBVaVBRK0ZNbmhSZytGZU9Y?=
 =?utf-8?B?L1Bxek96NWtDVnNGY1dINXNTQUtxRG9KSnlBRmVtS2ZPZ1RFTzBlMElROW05?=
 =?utf-8?B?cjFnaTRjcU1uSktyMzRGQWtpUXdkdWdHUS9zcHhBQSt0blpNdEowbFZiTUln?=
 =?utf-8?B?bmhxU0tNcDBZQU5XbXg0MzF3cFUwVWI0Z2JnelVwTndTZ3Q0UmdaRDk1Y3Jq?=
 =?utf-8?B?UDB4aWRkS3VmSU5BSDhubG5vNjFnSFdFb1NTcmdQRURza1N1N1NlN3JDeTBo?=
 =?utf-8?B?b2Zkb1dzc2Jlc0hDRWpVbmEzZk5UU3N4TGpjSkVhWmRWNHBsQTE4VXpuZzF3?=
 =?utf-8?B?VjArZjU0elZSdTkraFdiT1Z0ejhoQ0FpWVZwMkp6dnRnMDZoZjgzYmpxWW5R?=
 =?utf-8?B?K2RzSjROSkNKbGNyT1V4Qis1dURFMDloV2NsdUlob3g5eXdhUjdJeVcxZmRE?=
 =?utf-8?B?dk9tQTdZclhEVllsK0VXNWFPSkJsSWRORnIwQ3FEeTNPKzFpMEgwTkZHVnNm?=
 =?utf-8?B?OFlhd3BDSG5vcHNvTGxhZEhOMER0TGpXYWdpVnBtandnU2RWS0pPWDljTXls?=
 =?utf-8?B?cFNrYjBDVzM1Sy9yZ0JZNnR3MGg2WUNwQUtPVTYwYzJ1Vy9nTjZWUHJIdHl6?=
 =?utf-8?B?SzNWU3g1WFUxVE9QS0VPbk5ETW5mRy8rWGsvNHAvQjBHVWJBU2NKazZxKzJa?=
 =?utf-8?B?bWlPRWVVZmVnS1N5ZzdWSVhEaTF0VzZ0aG5lT0R3QjkvWTNCOENrS0o4aW0x?=
 =?utf-8?B?R3Z5TUREZ00yajFPcE9Pd1RMd3pvR3ZJU3BydzhNYXFNaUk3NElKYTRSR2JC?=
 =?utf-8?B?VUdvQU1rL0V0QkdqWGpZVHBJT3VaK1Z0bndEQ1VIa210eE5tUU9wN0xpMmxa?=
 =?utf-8?B?d0lUZjJpZVloUzNDWGhCQVphcWw2UXJTT0VuWlJSSzJhaTJnMUpKUnZnNllB?=
 =?utf-8?B?TDc2REtKeWduSkRyb2t2WnAzTmxYUVdDNXplM2JpRzQrUll3ZktUVmdZSTFx?=
 =?utf-8?B?d2VMSFN4bmI0MXYvWll6dXFMbGhocWV5dlNPU0d4N21KMWRtRXdTdlZMekRz?=
 =?utf-8?B?SktOWFM0UTNwbnhSMWtwb2lRZlNqc0NQR1ludWdOWTBDNG1ZRzBZeFJqWXh1?=
 =?utf-8?B?SzlCUWYveHQ1eHJuc2ZTZ2dBNEtYeTNCVDcvSzdaQ2VoNWhxU2xidU02U0Rz?=
 =?utf-8?B?Z3FxUnY4MUJ0SFpjWU9vRmpqd3FFckJsUE8zWCtXR000QmNmQUxkdlFrZEtK?=
 =?utf-8?B?T29ZY0NMVUd3WVpUUlFSL3BKelc5emw0ZWNpRVhBKzNDRlUzOWgrNHJPRFVr?=
 =?utf-8?B?N0NGZ0dtY1ZqYWRBdndBWjA4Q21XdzhSaXQ2c21hRDdYa1FTa1lVY3REaVdM?=
 =?utf-8?B?TlZMOVF5YXNZbGo1RlhOWmtvYTc5NTFGOHFFaG1qN1JLM3VlNllhYnY4aUt3?=
 =?utf-8?B?cVI0cTM4SU12MHF6SUtrcEwzaklYOTZkeklEQ0t5M1V6TFlDZHMyVDdXeDNM?=
 =?utf-8?B?SUlMTXJ0OFRlUmtyZVMreDBZMlFoYk1zcGNuNzNEM3cxU1RHRHlNWk5kc1J4?=
 =?utf-8?B?R25EeXhpby9TZ1FqQVRucFhVVVRESVJSazkraWd4QUdQVTNpc01PY1ltaWJk?=
 =?utf-8?B?N3MwMTZoVGVhU2xmNUVwK3lnSDN6QkdjblMvNHVSVDZqM2RtOHhXbkl4dlhW?=
 =?utf-8?B?SFN0Z3VsY1BQUDEzNGtqK05Cc3ozYi9OOGF6aXdJbEV5eW5VTWoyVGt0K2pM?=
 =?utf-8?B?M1NxOUpGSUJPOGxnZ20vQnBTd3Y2ZXNDQkF4eVE2Y1U2dERwSTlDUDJjQlpw?=
 =?utf-8?B?N3BjbmtqUGtmY1YvNFV0VCs3akEwRUx2YjQxdVpONUxORjNLbHQ1Z09IU3Nk?=
 =?utf-8?Q?WSVqbaV44RyD/ncFNjPxHvTzFliaLoL5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQ2QVlQdTFVMnVDQkpRSmVVSUhqaEZQbjNBcG9tQk5VUWl0REk3ZE5CYzdp?=
 =?utf-8?B?YkFzWkZXdDlIVDZ6QWJ2SWZBbWdsdHdmN21Pc0tBZVJTRWNjeHc5L1VHVGtT?=
 =?utf-8?B?VFRxd1Noa1phVjhqK2RRK2l2ZDJIMHdUdjBCSkZOK0ppNVJtNCtCSzRaK1B3?=
 =?utf-8?B?SHVsOTljU01IazREUUxSeWt0dm0vczJBRXU4RXJwLzVpeDUxQVBNZjEzcms4?=
 =?utf-8?B?djRtSGlmZFFHaG5UcitZVU1yTE95Ky9BYTlERWJ3Ny9uSVk4aFJ3SDBBcEN4?=
 =?utf-8?B?VEx2WVFlZDdkQnB3My9ibUJMVVA1Z0tIeWo0R013aVluT21MOFZtUHNFMjJ2?=
 =?utf-8?B?bkNGbFJkbFBjbnVrb1g3aVp5dGVNSm9LbTJGSEhzMEhDZTR4SmpCNFFKbHBq?=
 =?utf-8?B?MEQzMFZKWlhVNkdWZk1FQnJpUmFVb21sWld0WnpqS2tmSEl6dEFybXlFNGJY?=
 =?utf-8?B?RWdJNkpKTjdtRGs4bVA0cnlxRUxYb041Mk1mOS9PemtoYytBTmtsVXNQMWhL?=
 =?utf-8?B?ajB2RWpHRWUxL01sSDh3ZXJWeXdId25CU0RwQnBOTnhaZEsyWllPMUxCdDZv?=
 =?utf-8?B?NHlCbzh6SFY0MXRaallwaTJ6Mmh1aitUUG9XRzIrZVNLRkNHbVVBZWFXNjlu?=
 =?utf-8?B?T1NpYWROanNYdFdYdnVsS1Q0cVJVSTBib011bUFrdDRpdDNtcGJoWGE4cncv?=
 =?utf-8?B?aldWMU4xWUFSdDBCYVFuUHpkZE9YY0w0enV3TUJldU9TRE5QY2JvbVYvOVgr?=
 =?utf-8?B?RkEwTVZMWnhxWnd5QUt0Q3NnYTdUYk9JWWxCMWZzaFV0Y0tTMGgrNjJ5dWZ2?=
 =?utf-8?B?L1doSW5TSy9SMC9xQ0dvdGNzMHJVMXAzZnBSd2lKaUJNcjMzVjRpT2dmdDZQ?=
 =?utf-8?B?aGJpbEpkYWIra0Q1L3NQYjhJN29hRDFnZFRHOUR2R2ROOG5WYldWaExFd3ZV?=
 =?utf-8?B?SkpRdW9BNjlTekZ6WndSZ0hkNklRbjdaQURYSDY5MXFjcEtLWjdycTlOeUpq?=
 =?utf-8?B?ZHUzNDhYUFFmVEErRkxjMHM5dlIxS3pJVUI2OXVlc1BEWVZtSXp5ZmNPbTZa?=
 =?utf-8?B?bnZzMFhQWHpqK1d1TFJOeFgrZTNwUXR2cm1rR0w2QkdQMTV1RmpsSkxua1NM?=
 =?utf-8?B?cVQ3NVNDVm1jam9LYWEyM1plTUdNNTlJeXA0OWQzN2NaTmtYdzVTc1hIalZW?=
 =?utf-8?B?SytTWUQzY3N0UE14VGkxS0UzSStXRXdSK3VPdDRqeTY4ZU5DTnpUeVV6UDRj?=
 =?utf-8?B?Rm9vSW9WU2VQR3NjdFdZNEFDc1J1YWg5MVBJTUc0Vjd0ZWpSUVl4RWtvL1Ra?=
 =?utf-8?B?czEvUzYrYlBzbFZXaXZlSnhBUU5pOEljT1lkcTVNK1VsMWRVeS9zTjJXUmVp?=
 =?utf-8?B?RGdaemFrQUdaVE1ybGRaTURtQThhRWUyUXJGNy9qTWhzdlJHbTVMaDNvYStF?=
 =?utf-8?B?M3pVeFRjMFpTZzhlVHU0V0tzK0lFZWhaNXZ0VGMrY2NFSTRPUFdQMnhiZjZO?=
 =?utf-8?B?UDZsZVorL3FpZm1PT2c1YVhEc3QzeGRTakNwWXFBWndqV2pLblJtbW11U2hQ?=
 =?utf-8?B?cWJoaVBCTmZtWm9QU2RGMytCdlRWQ3V0OTI1UldMMDFaYTlzNzcwZkx0TDhN?=
 =?utf-8?B?TmFXaTZzbXR6TDk4ODJBRUY4VFgvQW1PbWFXaUJLQnBmUXRvUUV4YVVmNzZw?=
 =?utf-8?B?SlBVa1hZOUxxOUFRZVVwbE1naWI4OUQ1ZDVRSDdXWFQ2c2phcFgrbUl6UXZX?=
 =?utf-8?B?RVVnK0NBWkIzTzNLMWllc0pjSlgva28vMkduS1NSYmZUTGFyd1c0VUVEVGwy?=
 =?utf-8?B?cVF2Qk9SbU9CcS9EbzJrd3RYOGZHRUxLQjZMODVBWFg1NnczMFBvQXVnLzZC?=
 =?utf-8?B?cjNwYU1PRlRUc3Z4U1NhME84aUp6RENrOHlDbS80NXdwN0o0TjhCeVZ1ZVRq?=
 =?utf-8?B?OHdYY1VMQUdXNGp0NHRoWEhZdE9Sd3JMVzYyb00wZDkvdWtuVDVGY1JucmNW?=
 =?utf-8?B?YkpOcE8vdHYvS0VjMllNSFlSYzYzUU5GVW9IdHNBNkUyUTg2RXVFQlhYK3lS?=
 =?utf-8?B?N25MNjFoTGZCclN2aEkraTFnY1h3RXRGQ2JvY25QZVAwL2pJQS9pZzFmSWQ1?=
 =?utf-8?B?WVp6ZGNKVVRqVDBWc1lac2pFVyt5a3dSWnk0V201a25kK2VSODUvZnBMamRC?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3520e734-8a50-4950-9fe1-08de31c587cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:09:19.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUN2c7xAJlajFBeHiWb9CTq9ziAhPTxAibciy3b2+/R7VSiyXq8l2pW3i6vaq2SoBAfxT2VP+a7qSpP16Vh1vbmpmEZMGAx2lA1E80MBAmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8848
X-OriginatorOrg: intel.com

On Tue, Dec 02, 2025 at 09:43:24AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/12/2 08:48, Giovanni Cabiddu 写道:
> > On Tue, Dec 02, 2025 at 07:27:18AM +1030, Qu Wenruo wrote:
> [...]
> > > > Here is what happens:
> > > > 1. The acomp tfm is allocated as part of the compression workspace.
> > > 
> > > Not an expert on crypto, but I guess acomp is not able to really dynamically
> > > queue the workload into different implementations, but has to determine it
> > > at workspace allocation time due to the differences in
> > > tfm/buffersize/scatter list size?
> > Correct. There isn't an intermediate layer that can enqueue to a
> > separate implementation. The enqueue to a separate implementation can be
> > done in a specific implementation. The QAT driver does that to implement
> > a fallback to software.
> > 
> > > This may be unrealistic, but is it even feasible to hide QAT behind generic
> > > acomp decompress/compress algorithm names.
> > > Then only queue the workload to QAT devices when it's available?
> > That is possible. It is possible to specify a generic algorithm name to
> > crypto_alloc_acomp() and the implementation that has the highest
> > priority will be selected.
> 
> I think it will be the best solution, and the most transparent one.
> 
> > 
> > > Just like that we have several different implementation for RAID6 and can
> > > select at module load time, but more dynamically in this case.
> > > 
> > > With runtime workload delivery, the removal of QAT device can be pretty
> > > generic and transparent. Just mark the QAT device unavailable for new
> > > workload, and wait for any existing workload to finish.
> > > 
> > > And this also makes btrfs part easier to implement, just add acomp interface
> > > support, no special handling for QAT and acomp will select the best
> > > implementation for us.
> > > 
> > > But for sure, this is just some wild idea from an uneducated non-crypto guy.
> > 
> > I'm trying to better understand the concern:
> > 
> > Is the issue that QAT specific details are leaking into BTRFS?
> > Or that we currently have two APIs performing similar functions being
> > called (acomp and the sw libs)?
> > 
> > If it is the first case, the only QAT-related details exposed are:
> > 
> >   * Offload threshold – This can be hidden inside the implementation of
> >     crypto_acomp_compress/decompress() in the QAT driver or exposed as a
> >     tfm attribute (that would be my preference), so we can decide early
> >     whether offloading makes sense without going throught the conversions
> >     between folios and scatterlists
> 
> This part is fine, the practical threshold will be larger than 1024 and 2048
> anyway.
> 
> > 
> >   * QAT implementation names, i.e.:
> >         static const char *zlib_acomp_alg_name = "qat_zlib_deflate";
> >         static const char *zstd_acomp_alg_name = "qat_zstd";
> >     We can use the generic names instead. If the returned implementation is
> >     software, we simply ignore it. This way we will enable all the devices
> >     that implement the acomp API, not only QAT. However, the risk is testing.
> >     I won't be able to test such devices...
> 
> This is only a minor part of the concern.
> 
> The other is the removal of QAT, which is implemented as a per-fs interface
> and fully exposed to btrfs.
> And that's really the only blockage to me.
> 
> If QAT is the first one doing this, would there be another drive
> implementing the same interface for its removal in the future?
> To me this doesn't look to scale.

I should have explained this better.

The switch is not QAT specific:

    /sys/fs/btrfs/<UUID>/offload_compress

It does not require any other compression engine that plugs into the
acomp framework to implement anything.

Here's how it works:

  * If `offload_compress` is enabled, an acomp tfm is allocated. The tfm
    allocation in the algorithm implementation typically increments the
    reference count on the driver that provides the algorithm. At this
    point, the hardware implementation of the algorithm is selected.
    Compression/decompression is done through the acomp APIs.

  * If `offload_compress` is disabled, the acomp tfms in the workspace are
    freed, and the software libraries are used instead.

So there is nothing QAT specific here. The mechanism is generic.

Have a look at the code, it is pretty straightforward :-).

Hopefully this clarifies.

Thanks,

-- 
Giovanni

