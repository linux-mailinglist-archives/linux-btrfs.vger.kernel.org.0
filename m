Return-Path: <linux-btrfs+bounces-4087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D712689E92C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 06:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063651C20D67
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51410A2C;
	Wed, 10 Apr 2024 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8oVU4lu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EB9479;
	Wed, 10 Apr 2024 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724584; cv=fail; b=rJQxsngsYumNZ0geTczYNNVPI6etydWgpHANFxi0Qjb49IF3dNE4UcBnTwW+4RhQ0atvQ+AJuRmhuimvYNE5GC9sCZI8N6jyetGWwnqEtyEGGwILMZPEOdYA0Tzh8ID0doORG44GMx25YNIR71UGfoki1VhS2G068RW1uDhnZV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724584; c=relaxed/simple;
	bh=TG/yFwXvpiWLY0E62FIqLk+HQOlwlLhcA/cncaPRRmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZfeAokeNjkYsRk8EkrSPZTm1MjGr6JUFJ5/alR5K0zjbpRQovyZm8fK5JKJNzlJVl/mxBWjzoKqr5UMS+DFAt96URNtqeKU6jr72800+1F1JIsRrAhO43xbr1482FzIxTi4cdlQBarKBouM+Ms9S/pfLFqE2nuxCxP8vDFTgD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8oVU4lu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712724582; x=1744260582;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TG/yFwXvpiWLY0E62FIqLk+HQOlwlLhcA/cncaPRRmw=;
  b=H8oVU4luImT69JOWVEH39nBZbRRBr+++ce1Xu18T213Qowcf4l7BZJJT
   BBIixzzlE0ief2FoZFF1qtXCv213YZtFWCVxAjm0xvJwGjxFeVEIdI3Yx
   yCXQikQtGd48xNdnyqbm+3+meO7VqHn69edUB8OkvoMQhCriHSynFuQmU
   wrh5jaIwKOVABq78cAnfka+mh339YIkoJA862ggd+VU9XapFqoy+bMJ3c
   HsHpj7YlHIsMWQ0r0ggWSVmLyIci7Tgf6ywDrqTsXoc6b7PV8pU9SGjy3
   gF2fsl9kObjFpiFsiCWXkGwTS9ctJ0wwjzVuGjypsnZNWUtnSR77GUffm
   Q==;
X-CSE-ConnectionGUID: H8SzUwNbSBCcuYFqw8Ourw==
X-CSE-MsgGUID: di3mGeiNTSqMl4DNzt9GZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25572649"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25572649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 21:49:41 -0700
X-CSE-ConnectionGUID: R3LpJAhuRROmpTZeyROZeQ==
X-CSE-MsgGUID: ZiBA2B6wRTScSUuDsAKXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25225360"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 21:49:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 21:49:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 21:49:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 21:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To1Cy/fBQ22Id4rqEZJhKQwvhUonbn8QXu5LwkcDRcuuEzQ8x+zt6Nu7zbD26R/rUQ3II5nQah+QY5aQFFmswLtNAwHZ4w0yfkxFf1bitlnE+WMZu8niOqozf031ZEUvT5ejU7s+A3VfLiyZfi3pnanprcAI2McW6fnkIOmgatf2KEhBvNuQfUDSM4tibxsK6lEHwfAc1aA/5UB1LaSULNBG0b65FT3bFthdXzOEjmY8yNcKYNhd6lBARMACDk7zMgj8FQdQ+v1RyBwWl72osSYvXLdA+aC6wPtySXVbWpWy0hFUNo244Q+YDY6LxmGoHZz6Y4Y1ym7B557fkJQwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKhuEmoKEP5ut05PO/c0rMjeC7XVJ1C7+V7KLy0cHck=;
 b=Fw5F0jyAL7aNPp0AH2ynAw/9NuVt+QnGI37+6BJDuNr6ox2ftehLI1F61cRsKhOugMTmnjTd5+okWa3lCSg4+KcXOX0sI+x5cIPGqGwQIJGrIgMRCOYGUuS3Y9k3P5WVqMUtn16Jq78lsGVz4x8vi66GmzUvlJ4sTc8wlEKYwm7REscaskTQjJZN172L+FXcgWNeN+NeEuBkpEiQKyHJ5lVJ+8Ja4AMkhouYVPsticcjFJrEXg7Svw8uIR/xN60msumV7lRCje0yNxdW3fGr2wUSOjq74YuWI4Qez7b9Aq4QB47Y4YuXLrJb0tXXf2Qv+e6vGSY9hLCYFk2t53vPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 04:48:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 04:48:48 +0000
Date: Tue, 9 Apr 2024 21:48:45 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: fan <nifan.cxl@gmail.com>, <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Navneet Singh
	<navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <66161a2d18c7e_e9f9f29463@iweiny-mobl.notmuch>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
 <ZgNWYdTMv8gjiKj9@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgNWYdTMv8gjiKj9@debian>
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYXPR11MB8731:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpldOoP+x7meyLR/7OpiowMgNcgAcuK7LqcALadrzZP6/pNFHMGyicEdsflEyWDhCDZ5lDujdVimbq54OBoOrjroVDYYiu6QmtxvSop7IDHM3x9Xy2IEPjDcvzQhinbJhhoe9wAm/e0i05I/dRnZZBI4jUVgOIKSCeU3OBZutQ4/zp5eLppU1Ev9WrzHavu3bE60PYWb8wxcjJNmevdb3Y6n4DnKuoel1kOioKrzxma9cwGGzkit8VaGuVOmtQrbYU4BFXYBBGrCCvfdgpQzNTq/b2QEw+LvONsZqVvRaUpnK+tlmuinS32w2ttoNn4og4kg/JYw2eMCTpy5kgmK7SBfjGQJwtPUMKmGF7AIPwg3A8o739QWk8Ewyr72hnS3EsD2MqO+LH4LtJ8+OKDZ39PtLulzU/6KiFIYtS00qTrDrNTWX0PkvC+UfNaLk0TQ3RNR1AP3JryJqe0aXrxkBuE9zMVRLeuTX36fhjqGX26bMDXNZngcT8dl6Jb2HwY64pmoCzu7/HIyiQE8LpSdL2zC8Khitu64dQxuInnjWf9iPr0MGqsmsGut8Zibs4lFWwhm0QYFs349SvYjw3WeiTwf11XDuJkWivG1wr1R9u4kLF0gKAkCSm6OHH8ERv1CqBQM9724higqbS8yuQRk/kNaCtzv77ClXe8mz0LmvT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HElyP5ZSkDbLEu5ZQkdDJVGJ2EMU6xMc0M0hMduqQNVy2DyvCoMEDjP78MR9?=
 =?us-ascii?Q?XzyPHWK6wxi1Kw3FDa6fPk0UtaNPiRte7cfoEVwxATFjNV5IpssByAfc28ee?=
 =?us-ascii?Q?x8AGSTaao7DBMBaPMzwTnSSAAN73EHpVqm6FHfCsh6UWDT1y0DXClGWLI3W3?=
 =?us-ascii?Q?vBhcVMlx7LIeqxI5ylCRmcvNGk0thBgsmQIUCr/8oJ8Gq0wfRuJLAN2OsrMQ?=
 =?us-ascii?Q?2Ofo8UMjBavBEDhXrMSdzia0hiel35+jZXNFgLC4AXLZC1tB84Hlt3+5HbG7?=
 =?us-ascii?Q?QyF8ooKXlMsqNO7tdtm8VL2JhyBubLHGpEXnU4BaWNGWxyGfPsAJY0JX2yPK?=
 =?us-ascii?Q?GqSGG3SX/cgMrUkrsTW8OVyuT/Sn+DIPxyBjLGav2PZm6hxx879+YWzcViHd?=
 =?us-ascii?Q?L9EqbF2SftYtmrSIRlnu+xackh32a8+5FFC0zI+dn13QuFc9c+jzkkeIM14M?=
 =?us-ascii?Q?hAktrvm1//ebug/F6ngt8bikhBFKnx03jw5HLBTwLwVemJc6tzjrLGRX3pnM?=
 =?us-ascii?Q?we/5J8xFYiqLFYHvdzxe5/7UYWrkE0ZO5I6eyKNUKfP4AnbDQbvIXon1FcN8?=
 =?us-ascii?Q?F06fUJr1uYTtg8/63Uw2wnfbID937+Z98N4/xa0FBl86QePYqFb/HSHDkEUC?=
 =?us-ascii?Q?pWdpmun2tS7wUge2gYXn8LVPbWAQzNDKkb2vWoBEpJ4sLQUGPnUrzP9wQTiN?=
 =?us-ascii?Q?ynQH8rryTRrOdGilhP/u0G309dzS6p92k5dnfavOPgLCpXA/2Ogfb2qb7JvT?=
 =?us-ascii?Q?LT4+5Lz4LYklBZyJHpi32lHV8vtjMuWz0APIf4aaxlxawtM9/XcxVnrsjpeD?=
 =?us-ascii?Q?3I8nxxLYhF8h7EYq5dZWD/EgLkSoAXtvULrOli/cHOg92joyY+JBv0ULHUo6?=
 =?us-ascii?Q?dF3WiJ+/MGz7smhh8vADwrZfF6A26Phk2vt/uKbH4JmlrSTdTX0kGCHjzvpU?=
 =?us-ascii?Q?6aBddDAbAGrwUQWiCpsEMOCioaCoTcEuOE2Myj+kBxxKbEYdvkssna6Xl5mE?=
 =?us-ascii?Q?VyfJyb6MVUAG5HNGm0+0WW6Ul6rYGD6TyH9o+ZzIktum3ltpO5RsNOIV4k8l?=
 =?us-ascii?Q?SHFpFUKZVqkQOGtNGKGgUBnr4X+jfahlhF4t9pGXOpR+N4QjB8WtJN/oXobw?=
 =?us-ascii?Q?X0WKZtTDfYy/IzqC685dKRwbl0btKjZ6IaUHabeB3l8SdvII4KJUcGh2kUJY?=
 =?us-ascii?Q?HxcDUuTou4t2ujFQ8OGUbViKkf7s97ji/iP+eFDmNldDwfvprZH1/Ey3BNO5?=
 =?us-ascii?Q?t16Aj0bowkScvj1fwbVFgmahoKCIJI1g6Ruux2JphbAGt6eH18f6i1uLjjp4?=
 =?us-ascii?Q?mXylBA1RHTDufkttzN+JvT07CIw9/m+7OAPDTAyrb9eWvOYuR7Ek5CvMPVXS?=
 =?us-ascii?Q?p0r708+xEgiP6ROColNxxEPmaZ9v8LFfCoqZ3Yz2nZ2CAG6sgz76TF2+zWpY?=
 =?us-ascii?Q?0rPsS5L/W6VDX0KTroPw30sGcFY3vy4EnB2hmSdQSUvVc1cLaVwxAGQ3Q4Gl?=
 =?us-ascii?Q?tlid+bE0TkyQtZM9JBZvBXZumSJMfR7WDcDmods0Ovfsz1fuhsQk7BwTHdSC?=
 =?us-ascii?Q?nV/9EdLixAUO0swJca40jlZWarTz1iRKPw681zL3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a11be0-1396-4998-2d26-08dc591982d2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:48:48.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trXOzywNGLU2X37GmT85uT2JDHunMiE1MuGtDZqw6aZcSehQqAlWjMqqMFgkZpjkI5IYrKwfoCioylNRofVk4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

fan wrote:
> On Sun, Mar 24, 2024 at 04:18:16PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>

[snip]

> > @@ -786,12 +830,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_event_irqsetup(mds, &policy);
> > +	rc = cxl_irqsetup(mds, &policy, native_cxl);
> >  	if (rc)
> >  		return rc;
> >  
> >  	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> >  
> > +	dev_dbg(mds->cxlds.dev, "Event config : %d %d\n",
> > +		native_cxl, cxl_dcd_supported(mds));
> 
> The message will print out two numbers, seems not very clear. Should we
> translate to more straightforward message, like
> native_cxl? "OS...":""
> cxl_dcd_supported(msd)? "DCD supported": "DCD not supported"?

Perhaps but it is just a debug message to know if something is wonky with a BIOS configuration.

So I'm inclined to leave it alone.
Ira

