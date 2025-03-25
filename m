Return-Path: <linux-btrfs+bounces-12521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE40A6EA6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 08:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C793AA5C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764B2528E5;
	Tue, 25 Mar 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl1WutJs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE51D7E37
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887466; cv=fail; b=qLDo21cpR7Upd+7bEEd4mKGMeZ36T+a7oyip8LR7THN8FZmPQ2RXDKxsNH/ensiK469FwBHs3fYolc3YQNMDth2XPmX+ptFvvoA900VZ+IKXI3VahTRrHTQMOUhw4ap4XMvGYPeyZWpunv2Bv2Qe9acU4Chi3gQgC0AY29utZUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887466; c=relaxed/simple;
	bh=Yr1RL033ZC6LkUkAZVbe2dtr85MlrT6v2gRCDUYmN5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XoisckEKcFCOagQUs0FGCCVCNyHe7Ep7VKpLdUkV0mclEDW1hKAPExoJ133TLLcOrP5wEW+aJeukGKt9hQcxMadd6wIbO6UJcQTxNa09vAxOSQGTD4j2++Hq4KEwayBC/DG1Obef5slTkzJZfuJ/m/ibN0uccgZv+DNnK2x6yqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl1WutJs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742887463; x=1774423463;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Yr1RL033ZC6LkUkAZVbe2dtr85MlrT6v2gRCDUYmN5Y=;
  b=Pl1WutJsF3I+BJ7Mb5q931G4dVTcOcF8HLFwTIFvGvaFipa/SO5KJ9p+
   DdoSDzY9Imkj7AJMEnpcREy+uqKCia2xcGKEYfh4D3c0/NoOmcBVeoqSi
   tUeh8YKX9Ty8syM+U7WwNlwHrWLM4d4ueIFgCSfzI9Z7j3aTea5kRQ01Q
   r/Nyno6yp83QNT/5aVJUUWMD6pthHCiGa+rj+II9KQL6Ehkwot27AB/kF
   rJTbLxfPccaGI7fdDBMwhLIDMbg7eNen2c3/cMHdT/PEFkIQU9VeYVrDC
   wKASnmT6iNOxjiEoOxfWL/SymGhoJPMjW4OSwlaEjFXQ7WBvjNNBOZPKL
   Q==;
X-CSE-ConnectionGUID: Ud7ehYUiSrCyjRwJCwr/Dg==
X-CSE-MsgGUID: cWdw1/GJQDGsYPel6a8E1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="44007440"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="44007440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 00:24:23 -0700
X-CSE-ConnectionGUID: YQd6gSHtQD2X1CDA9l2jKQ==
X-CSE-MsgGUID: ekp9d9VxTV+J/TKnybKV2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="125227802"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 00:24:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 00:24:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 00:24:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 00:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhX3ljiJVaxln4wKVqKJwtq/V+p9irKk8xixYSppM9xqLrhoCwSRrs1pHfeF5O+cCe3sLpNUZQjjNdhHY2D5PmablWzYCbOc6wrKTwPNnERDgYX7onVORfwBKq77BoDalrP9J01Sor1peQ5WPqk3mpkBphn8F5aqpfUSwdcSJj66N/JVI8virPvchlzbmfTGNEe386rP8E5orFd+akY2D+gBEcrQxDLxOXNN2zAhCIm0z/0A6TEAvCCEDxqUqwzz7926nLS6CZnujYN64z1vGXPGE1eI3pJlG7NvLA1PkeZAfebhbbrz0PmAtnRUf5ZBzWW/YAQaSvPJR36dCS5miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBIWFZ7IzWb8C5hl9OCfilEB3KiuOKK/Tjl5EmcwG9M=;
 b=Y5Y/K4ko9yHlPtJSfvoZzzRM02VAexXo72sjFoS9MEguz/cyvK5sxEGrPOHlLQ3xd6lOCQaubVRbWctcnqDgTQ3kfAz9I7CwVdd6nTuvT7NmT93boC+zaWddKaHuZqIRUdOhib1LqW7VsDT0b6A7JbNAdqB64hpvNFGdm3WAajyPiK56g+7iBpVJ66sGijBP3G/UEb0qnwU7fDzPYKJYOoo7gm+nLiz74XK9Rh5iCWbVVnovPPSbpOIQI9WnzTI4jZ3kJyPT23Q+mmvEePt+kMYT/cn5LaHkxwMrNzdkIyiwUBmPPSrGmS8RkwTD8A2EjOXIFUgYp+hoviVKGRw7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:23:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:23:38 +0000
Date: Tue, 25 Mar 2025 15:23:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Sterba
	<dsterba@suse.com>, Christoph Hellwig <hch@infradead.org>, Filipe Manana
	<fdmanana@suse.com>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [btrfs] 968f19c5b1: xfstests.btrfs.226.fail
Message-ID: <Z+JZ8bIy5f58GrZ+@xsang-OptiPlex-9020>
References: <202503241538.dbc17bf9-lkp@intel.com>
 <883442fa-e398-4d56-a7cc-a7fdfbadfd53@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <883442fa-e398-4d56-a7cc-a7fdfbadfd53@suse.com>
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b08a31d-6fa7-45e3-650a-08dd6b6df63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmEzYWpZNGYvZjdTbGNzZk9NSEl4aUZCOHUzeHBNZDFSOTFoNVZjekp4WUty?=
 =?utf-8?B?MDlqQTFhQU90K3MzVGlQdWZidkNRV0Q3YWFjbVMwVDJoaEpCR01qeEJ4UVJq?=
 =?utf-8?B?K0JublluaFoxWWovVXBCNU1idkhyQWlSVi9QRTVITDZZQVR3ODgvMWRKaXZX?=
 =?utf-8?B?UGUzOGdBcUsvY2trTHlsV3FQSlk3MGpiM3FvVDVCWGNDTEtOT1BFcjNCVkps?=
 =?utf-8?B?Q2hCUFluWEcvZm1RV1pKRzJXWjBLZmJBYTAycDZySnc2enQrM1BaSzlSeTlL?=
 =?utf-8?B?eGdaN1FjREdKbFkreWVTZmN4dUVBTlZadU12TGRabXh3czNxOFlzUlorRHBK?=
 =?utf-8?B?TkRSdXVJcEowcnhuZlRwaFpEUkt2bW9tbnZETjM5NkMwdWJlWXBpVFJIeE1P?=
 =?utf-8?B?b05SSXFmVE5TaTloczhxb1J0cnJHOEhzSW5IaGlwZmo2RDhEYVhRS1NOQkpI?=
 =?utf-8?B?MC9YWFZrUzFheWt4SWVnc3FHUHdFM0Y2NHN3Z1RsY0Q0TGJPUUdRK1hTWnJS?=
 =?utf-8?B?TGtvcEx3cGRxMk1ETno5TkFpQ3g3ZllEdG95UkJjeXV0SG5RbndhL0FLeXlQ?=
 =?utf-8?B?V2VMZW4yUWtPSUNJREtOVzNXLzlza0kvNDFtY1VqTlZ5R1BPZFRMQjhGeEo5?=
 =?utf-8?B?UmxWVHNkNkUxQm1nMG5lZUxseFNKVWxTQXA2ZDduVmpkNWxWMlRLcDBRSjZy?=
 =?utf-8?B?TWFINklLbXRMU0pka0hkVkFDemVlaE1TQW5WRmZQZkplMXVTS0hJRWt2eFha?=
 =?utf-8?B?Z3hPSExGNENraUVNeVY4MEZTdXc1NVVpSmVBZ0UyQm5wOEMwZHltQ2M0cFZ1?=
 =?utf-8?B?dmgvcEZNYTV3Y2FiRWkybmhFVU0vejdmajFCWUdVdk1adktaenJKSlJvYXNv?=
 =?utf-8?B?NlVVV2JDUTZnNGVTMkpQTlQ3MDRLQlE4SENqUHJKZU5YSEF5cTJhSk9YVCtS?=
 =?utf-8?B?MjR1emdvcVA4dnZDNVZTWVVCY3JlT1IwMStWYjkzdGRWbEhYY2NHdFpoY3Bp?=
 =?utf-8?B?NXBhZTI5M3ZPamphNURnYnpqdnlVUzB1VG1SZDF6RlhVNjhUNUlGbWYzRUk4?=
 =?utf-8?B?TkNHMUxuaE0xcWw5M0k5eTcyaERQN3VTM0t1OHkrUDhINEppKytMamdPMEFY?=
 =?utf-8?B?SjFNM0N5WGhVVVpZcVF3aDJsaGlkN2VtV3ozN3pTYnhQdzllYTgvbUNYek96?=
 =?utf-8?B?dFdCWmpSMENBS1Q3UVh6aUFrLzNZN3ZSQzR6Q2hsZEFkb2N4YkNNOXRXWjBm?=
 =?utf-8?B?b2RTeWpNMnM4ZXpFc2c2MGVqUFhjWlFDQm9qZTVqOUNiaXk3NWhhL3hSZkF3?=
 =?utf-8?B?VUpIVnlGeE1La20xZzBhVWxUdjNHYUp4dXBxaDM4UmpoQ1Z4ejVSUkoyK2t6?=
 =?utf-8?B?N2twa09WWTB2YmV5eExYbER3TXNlcm80SnFkZ0Erblc4SGFuWXBpRU5VUTZa?=
 =?utf-8?B?ME1ZQWtpZm5qalBxeSsvOHNDd1ErY2FxOS94QnpNaFJKYlJVUE1uR0RFcnZL?=
 =?utf-8?B?MXZhWTgveUNnbWs2akpRQnhhb3UydzZ0TGtEbDdlWnFHc2tkRHZMcytmN0J0?=
 =?utf-8?B?ZWR6MzlIL1Y1aVhma3E0NmJvVXhJS21KcFBubGgwck5lVUJKQmYxMDh2ZGNE?=
 =?utf-8?B?UUgwR2lKYmZXVUdNT2tqTXpCS1lPMEpjMFJRSDF1M1pELzlodFRsT3BEbFFE?=
 =?utf-8?B?VnF2TFN5R1NydlJNZDI5ZTFTbmhJSXhScW1VSUNjRzVoN0NZeEVuS1d0eUU1?=
 =?utf-8?B?VjdsZ3E1VGNyYXFtNEwxZTM0NFB0OHBmS2Z2eVozVXdtL011emtIaUdRNDhF?=
 =?utf-8?B?TmliSzRmQXlFK2h0cVh0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpIRVZVR01KcXUwSVZpQVgvSXlleG8xWk82Q2NkUGxSOUtXTDVqanArS3U5?=
 =?utf-8?B?ZjBEMWtNaThCaThBQVZoZFk2NzFucDkvUFBIMzNkVllMUEkvUWRuNVVWUUQ5?=
 =?utf-8?B?K2Jlb1JsNy9hSTZsK29kci9rNXRad0krL2x4dFVCVWlwd2FYZzB3eSsycW1n?=
 =?utf-8?B?WG5Gd2JUK3ZOTDlReUlvSmkxdU84QlNsa1lndW8vd0g3TENCN3kzMDNQMWpQ?=
 =?utf-8?B?NStPbGttejByS1Z2KzhRdUVQMzM3ZitKbFpNT0hrVHBiWkhUY2VsVitQZU5y?=
 =?utf-8?B?cWJBRlo2SVMzZTVyb2tFVWxsaGFNUXhMNG9nSk5uWXgxWkpKQTVvMUtQYXgv?=
 =?utf-8?B?QlR2UkVDSXFPc2lCNHZCelpvQzhaOUlXakRQU2ludkNVRzFZcnRHZFYyYUpF?=
 =?utf-8?B?eGo0MkhkangvZWlCK3VvU0NTWU9TalRTVFJYOVZJbG93blZnT0c0U212dkcr?=
 =?utf-8?B?Nk16c2xGWE9CaU9pRmtzZkZ2cEF3cDkzMzBxbVQ1R2NubStEWkp6M3BZMVF2?=
 =?utf-8?B?NGdYOVZlRzZIVGI4TUMxTjE4OGtRMFhGd2x0WC9uRlQ2alpLOVRCaS9IWDMy?=
 =?utf-8?B?WXRJZStZcVcxdlVET3NhWjAwV2xsZlR0dXhjeHlBcGQvemwwUnBuU0xFUjY0?=
 =?utf-8?B?dzhhT2puTWhEWW5hQ2RNZWxua0N3ZzdXZ01kU0ZJYXVFMDl4RTZ1Sy9VQ3ZX?=
 =?utf-8?B?ZFJDN1ZBdGJDM1FCa29UM2VRRXVpUUgyN1R3U1pzQjJ3L1EwVmlnbnRCMERk?=
 =?utf-8?B?QmVKWDk4UllzRlZCSUI5WUJ4QXVMSHlsQjlZNTMwTWdSZ0RFQnVNS0x1MmRW?=
 =?utf-8?B?OEhxaWJ6dHBhZXJrOHpOMGE5QzRvb0hGckM3WEwwWnhNaGNjUlNnWTNPN042?=
 =?utf-8?B?WGQxRkpPNDRRK2lETmZsUFAwS3lzT1kyQWtIQlFESDYvL0RmVWFaeC9BVkxs?=
 =?utf-8?B?anBwVzIyclhWQXc5TGNxQVRzeUJhNGZ1b2lSQ0RPRTVCdUZ4bmFvWnh0akht?=
 =?utf-8?B?UzBzRTJHem1RZ1h3cHh3ZTlJU2pyd0hGTzRXMFRKemU0UUp2Mmt6V3hkOXVi?=
 =?utf-8?B?aS9lcDNlKzlRSVpTMHQzb1l4TDFNc2RkR0prUWpqbENIbXNUdEpSbHlrbmFo?=
 =?utf-8?B?aUdhNkQwR2dFbGk1aThBTmFKWENXV0pMZVpaWm1nY3Ywdkd1TEx3VURaWThv?=
 =?utf-8?B?Ym1HUWw3S2hWRHE2ZlpncXNHL1RwL3hMWWFvQUpvZU1iZ2dJUWl6dVdkZmQw?=
 =?utf-8?B?cVRyME8rUWNSN2J2WitZZDBzbUh1cmRvNTdWWGh2VVFFTWI4ZktZTU1ERFpM?=
 =?utf-8?B?Z2hUQnBrR1FQN2JuTGNGcWhVdlovazVQVm1CWldKRnVwbGZRMVNnMEl0VFg2?=
 =?utf-8?B?RnJKeHNFUDR5V1Ewb25SQUpzajhSUjRkYVZGZTQvSFdXdEV0T3NDaE8zRFFP?=
 =?utf-8?B?dlgvUCt3VGpEWjNINStoNXZIS2NNNHdydWFlUzliVTk2NytiSFdpVE03V0Zy?=
 =?utf-8?B?cG1rUGxJRUxuY3hvMWozeU0yS1BXRkNHak5jN0JRVDNxTUNYak9kRHBTbzVv?=
 =?utf-8?B?QklEOW9iaTVtR2oyRTZ5NXpUUERZQmFNQ2hHcHF6aFNLSzJtUEFLQ1ZoZk5D?=
 =?utf-8?B?UGUxYnY4RitNajdkWTF2OVZDM0RWeDNBdTJkc29ia21mVlhYL2VKbms1ZDha?=
 =?utf-8?B?aktQV1duRWFxdnYvNENhSS84RFBjaHFpZlFXOEtEWGYvTTllUlhGRjhLaVJU?=
 =?utf-8?B?WWtqSUhWVVd1QXF5c1hlQWtBT1dvZ0RveTFoZzE4ZG5FQi9QZFJuWDY1SHZq?=
 =?utf-8?B?d1NIT0VXeHBuOGVGYTNvZVFDR2F0ejVBcVQwbTdsTmR5ODN3WEl6T2ZTM2NJ?=
 =?utf-8?B?M21FckF3TnRzTWZZc2NabnZrV1BBdU5SK2hxbzZ5bUpGamhacnlJR0pIUW44?=
 =?utf-8?B?SSs2aXVhQU83aE5lSTFwSzUwbnpTVTdvOUpOU04vOHRRNWsvL0VkOWZSNjgx?=
 =?utf-8?B?dk40QThCYllDZGhCOGRuOTVPQ2wvUXZ3QlJsMW1kMm5uM0NEdEpZKzFKZ2Uz?=
 =?utf-8?B?WFhzWmFKeHlmNGZYNTZCbExKZnRhSHhhdDJudTVkOVRIOHpNYVhhbjdFYXFl?=
 =?utf-8?B?KzQzNFMvT2FvOU9hSkZNbWQzdDBHQnlPc1BxVHRBaTI4SXl6bG5sakd1L3Jv?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b08a31d-6fa7-45e3-650a-08dd6b6df63b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:23:38.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TOKrSAtGnYCWEut3aU+bvTNu6JS1aWs/Ica81S1pW5hS/JO/48vLWScMujTKWTq1K0K4iV4cTCLVfyqK6cgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com

hi, Qu,

On Mon, Mar 24, 2025 at 08:03:02PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/24 18:15, kernel test robot 写道:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "xfstests.btrfs.226.fail" on:
> > 
> > commit: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 ("btrfs: always fallback to buffered write if the inode requires checksum")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 9388ec571cb1adba59d1cded2300eeb11827679c]
> > 
> > in testcase: xfstests
> > version: xfstests-x86_64-8467552f-1_20241215
> > with following parameters:
> > 
> > 	disk: 6HDD
> > 	fs: btrfs
> > 	test: btrfs-226
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-12
> > test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202503241538.dbc17bf9-lkp@intel.com
> > 
> > 2025-03-22 11:44:50 export TEST_DIR=/fs/sdb1
> > 2025-03-22 11:44:50 export TEST_DEV=/dev/sdb1
> > 2025-03-22 11:44:50 export FSTYP=btrfs
> > 2025-03-22 11:44:50 export SCRATCH_MNT=/fs/scratch
> > 2025-03-22 11:44:50 mkdir /fs/scratch -p
> > 2025-03-22 11:44:50 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
> > 2025-03-22 11:44:50 echo btrfs/226
> > 2025-03-22 11:44:50 ./check btrfs/226
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.14.0-rc7-00005-g968f19c5b1b7 #1 SMP PREEMPT_DYNAMIC Sat Mar 22 19:24:48 CST 2025
> > MKFS_OPTIONS  -- /dev/sdb2
> > MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
> > 
> > btrfs/226       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/226.out.bad)
> >      --- tests/btrfs/226.out	2024-12-15 06:14:52.000000000 +0000
> >      +++ /lkp/benchmarks/xfstests/results//btrfs/226.out.bad	2025-03-22 11:44:56.303230706 +0000
> >      @@ -39,14 +39,11 @@
> >       Testing write against prealloc extent at eof
> >       wrote 65536/65536 bytes at offset 0
> >       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      -wrote 65536/65536 bytes at offset 65536
> >      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      +pwrite: Resource temporarily unavailable
> 
> Please update the fstests project.
> 
> The commit 7e92cb991b0b ("fstests: btrfs/226: use nodatasum mount option to
> prevent false alerts") fixes the false alerts.

got it. thanks a lot for information!

> 
> Thanks,
> Qu
> 
> >       File after write:
> >      ...
> >      (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/226.out /lkp/benchmarks/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
> > Ran: btrfs/226
> > Failures: btrfs/226
> > Failed 1 of 1 tests
> > 
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250324/202503241538.dbc17bf9-lkp@intel.com
> > 
> > 
> > 
> 

