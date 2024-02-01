Return-Path: <linux-btrfs+bounces-2023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64F845C20
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DB429B7D6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3C77A1A;
	Thu,  1 Feb 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/9Lf0Dk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2469779FD;
	Thu,  1 Feb 2024 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802629; cv=fail; b=QNNNp6zQjdGHAi7AP+ApwU4FkCLxXaRo/DvzEJTP8H250TneoRbCrUK3Yf6IQxmv4A1gJzukD6thmu5GJgEe0R0y9AYdDUorHSp8jlbpz9QdfVgbvFCNixJAGsBTK4GCLeBTKdRTI1YtstrjTCULxRhNQLH37E0C2zjm8uG7Ycg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802629; c=relaxed/simple;
	bh=XyalGKsSTHL2LNmia9RPXI4SvlU21/406hjJAMsmbHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o0xxQkiSxBA6UCu67Kos+2Jew5G5sz+1vRyVsFN8cinsDeLLrQY1xoy83cvZoWk/lERRZd2I4b6LttowavdKWmcT7aLcbbaYE7NA0ZEjwNuAzvqU+k7idISyySucp9rtDmcvvBoBTJ0ZfeOt4Txr94T0nkwnfba9ZCIKEqHYjLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/9Lf0Dk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706802628; x=1738338628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XyalGKsSTHL2LNmia9RPXI4SvlU21/406hjJAMsmbHc=;
  b=f/9Lf0Dk/4DYxF5MXfAR5q35AHvhe6qhqyesO3A39Mq/fXkFOm90vzoW
   XYZxJBY8jdVM6oIj4S1homH7mPX1uy4yA0QjWYTFI69HzBg64n5k35+bi
   H1t/5lefyBm0eHa9FNyzM0t2eQ5B+ztj4r9k0pIaJirvdaOTvphOigg+a
   HeGqztFVurYhkfEWzeAwTqH/dv6wkhJ3mrdbmp6c27B42OyjrsLfEgmd3
   7Quuqh9iU9cy6xUtVl9luRoUyKSd/3pecRbHiAGehU1dVlta+h7OsFpnK
   zBrb12XKgLdzJ3/wzeROzCrDaZS/S8IvXYO69+siPj1fYrji7TlhSqFEK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11295866"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11295866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4538494"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 07:50:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 07:50:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 07:50:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 07:50:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 07:50:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3CMRqP2UdgjPTfIbqvMl1KAxLObXGH9NtB9l9DuzSCFFZZSYvtMfzCUjrvMGJraLoA4dlhlpLykBlHwpA8Yt6YZ8rngOdFp/NKhwk0FOhV/zFRfdyuLMHc7CIsTm7btGNlj3X8IiLPj9SO72R9y0J/p2utpA8aCOmzggsWjUBNrwcLOjOmuGtCPXzAOFarfgicVVAEjz2HNCQd+QD8/WEzfXQoW7JSu7slIETdFd/4vYuIOkWPIVOF5ylyjKe2F8CHLjSHRArMjWqGy16IjF0WswblmwssywmqcnFqxTkydEQgUXnG0l4Y9COmN4F0A4tBmSyDCG41a7anXtfZzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oZmtv5yI9nUsWY6VHJioeSH37Ziw3LyivfxC7fVOMY=;
 b=Dp7MSjFxAWelPmK9AqJ9cn8ai36fmMQmdCToMXQrJ16nPYL/GlMoUqW2wpND9dJlViIJIo8+Xiuuw3qd1ucznmlPsLHWK4soHXe5rdJ2+BndfwdJhpEjJdmwB5gO9cd3p60YMa/Gvagr9uT1JvmQLhG2zKC3vpCwtOVp6V0dISDIP2tcVCs5gUuv8z7r0CXgRaVr/gRvYIt0ihRrLst9Vf2s3ZjOwpLrHh3X23ZelKb3aZhnpWfpU25KTxrcWjkD3lQnRtBtqCzgOIM0oqQBB8hmkMqpKz0NsXxJ8K+pYL2quDVGDfQqacj6jiCoYO3H4rEhUJ0u4FiGq2Mr0RIGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Thu, 1 Feb
 2024 15:50:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.017; Thu, 1 Feb 2024
 15:50:22 +0000
Message-ID: <901aef4c-27fa-475f-9d56-7ee292cca763@intel.com>
Date: Thu, 1 Feb 2024 16:49:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
To: Arnd Bergmann <arnd@arndb.de>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Yury Norov <yury.norov@gmail.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>, Jiri Pirko <jiri@resnulli.us>, "Ido
 Schimmel" <idosch@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <dm-devel@redhat.com>,
	<ntfs3@lists.linux.dev>, <linux-s390@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Netdev
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Syed Nayyar Waris
	<syednwaris@gmail.com>, William Breathitt Gray <william.gray@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com>
 <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 044ac232-b629-4a08-0393-08dc233d7f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aacphW9P3Zgmxj67bCGBbAU/NU/mP65qTxDk8OCDf5wGdoKJo441/QJ/IMsoNWPUTteWD0LhRb54f4tbuPRQdo4b31kGvi5+Ui39Mxtjg17fy0Ryk4M5ogs6VE31yU6inh1xEI61VSmGGFU9bBjMMWFlA/iiEqIXWF5DU01igpniha1caNNl0dcHeX8H9w3zanemsdJ2mOGpzIe+qH1tuUPrBxahKQ557gDIVtKGTJH8IfuJrBU6TlyDJGIZDiOqlBcAzbISdUhspz4KeXt5GTpz6V9oIT0L20WLzc7CqcX/Ch8Wmy0v4sqilKlkAg4Jhi8SqrDhtkOk8Y0cfuso3ssde1H9zHMkQjN7phG04QMfWowyqcwF7PRR7zPdwpuyyFOMxo6LcSqFOnnveM0qJ3TIUwQaBw9kWkU5R6/iHjAFX8iGw31BEM4UpIHtHEzecujwy+ueajWfT5kNxmpFq9+g5kkZaqlv6sZf8q1iO4W970Sx8j2PxCePkj8LozfoeDTj+Wy8lLceZStcjQadGUpBtooj3iTkQke+PVxz4eEi1CEZTMn4fPCfbXQdLs5l6dret5l76zMrEQ0hp7h5aa1dz//IrgRizIc0lRAlgW0u7BUNBDoBP1Tx2yereDHwmHi0xqPhpyIfoFp9cU+AV6xwq+jzZ1mbBqWOxIHweRCnSrn6wEGm7dIWhPHroaoK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(8936002)(54906003)(6916009)(66476007)(66556008)(8676002)(4326008)(66946007)(6486002)(478600001)(31696002)(86362001)(7416002)(2906002)(5660300002)(41300700001)(36756003)(31686004)(83380400001)(26005)(2616005)(38100700002)(82960400001)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUF0RHhDTnZveGRxRUV6OW91TXVxNE5oSlpkb0JUU0oxWktLNmdudFhMdHo5?=
 =?utf-8?B?dlQrYUVQT0JISEw3a1E3djBsdVdQK1FyYWJZNlQzUVprZzlxWStMOUdYSjFU?=
 =?utf-8?B?WitBTFVwN2p6RTIvZXMyREpNNGdrelkyWHNNZWNJSHROOVc0ZVJlaHRxRWJn?=
 =?utf-8?B?ODVCS2dvYTdtWkRZempEZzZ5L0V1QnlEcnJTZlNRVEZXNW5zTUg4UFV1cG02?=
 =?utf-8?B?WVdCWUZta0xRVmVSa3F6ZW5UVjVZZGZNUnM3WjZyN3ptdU82c1BsYWEreEtk?=
 =?utf-8?B?THp0b0htQ2lOUVNNSU9mbWVCK2h1d1NQNGR5eWw2MVFDTkx0cWlUVmhJbDZa?=
 =?utf-8?B?RUIvcHhBVWNib2RjTmdxMmpmMEgvdnZoSm9aOHJ1MmhKZW1aRHBYNHc0RUZS?=
 =?utf-8?B?WjNnNmg3OHpxQzBhQW5nVkNNcWM0eW1KRzRJMURsL2FLTnE1cWRoUVZTalMz?=
 =?utf-8?B?cUhyWnphTWZTcWpxbDgwS21HT0lZNlkzbVZDMWo4YWpxTkhQcTVQSytBaXRa?=
 =?utf-8?B?WDd1QTNad3lkQ1NmV2xYQVF6ejBZUG0vbkdrazMwUnNGRExvaC9QVllUSkJJ?=
 =?utf-8?B?Q0JSYWdJOTA3NlI1WWk2THJXZXR0MCtwTVZXdjZuRWRjZENMc0RJWUlUaUZx?=
 =?utf-8?B?SFNOS3hyRDFRY3o3MWdlQTgxYmxQVDA2cUduLzU4RUpFNkZRbUtWaENSNjlt?=
 =?utf-8?B?Ny9zakJsR0R3R3c2WXBUVDJLbUlTQVVQcHArL1BoN3QyOFNkMW93N05kSDFZ?=
 =?utf-8?B?UDY3V253N2J0WFBaQzJreHdTKzUxbDUvcHZaRVB1NEs5eG83eVJpTUxJQy9S?=
 =?utf-8?B?dUlOZE1BNGtmN3dFbmdadFBHY3lHczdxTUZHcWdIRzRTbURqUWVYemo2MmJV?=
 =?utf-8?B?QTZHSUVMdFN0dmxneG5pdFQrOVdKUVNsVTJYN2NOeWliaDdpcmxZSXloeG50?=
 =?utf-8?B?bVlhMWl0V2xwM1NHRVM0RXdUQ1JSSnVVb05SRyt3MUdLZURFSE1GUjFoN3Vs?=
 =?utf-8?B?UG9tT1ladUtKVTZLSkRrOTVPRTRvZlpsdVRVZHBFNmNXZVdpMzlzUTNDSjY2?=
 =?utf-8?B?dkdUL3VIYUw5bWNyRmgyZ0NyWjFWM1NtdUtMWHhpNVNGTmlaSWs1cEVaTlVh?=
 =?utf-8?B?RWV2R0ZmQXhiLzVKOEZkRHFqeXVYNm9NcXJsbVJWMk5BdThRZnhwaVJVK2xi?=
 =?utf-8?B?L2RIaXJha21DakZLbDM0cUV1S21WQ2p6R0VFZUJZOE4rbHZlckJlU1BBOWpw?=
 =?utf-8?B?eGY2NW5aUGg4azdWUVNnUjl0WkZUdDlFNXpzeWFUR2hCMzhIaS9Zdkk3cFdG?=
 =?utf-8?B?WkhBMEVzbWlMY0QyYXRoQUdPckhtYlNnZjBoc0EzTGhkQThoRElxbTNNSjhi?=
 =?utf-8?B?QTY1SDc1Smk1R2VYeXFiSitQb2RrSlhCR1BLU25CMFEwRnA5RHlvU0RuOVRX?=
 =?utf-8?B?elNoN2VpY0NLQVFxelJZQ3dtOUpRZEJFWnFVU2luZkZUSSt5TmJaSEhJUXAr?=
 =?utf-8?B?MDZtdHJBcE1BVjNoOFRPWDNXeVVVV0VDM0tmN3MwOWVBUzRLUmhjOGs3YnBo?=
 =?utf-8?B?eGpUYkhKS2RkSWdLVVBMKy9iMi9PNjBqS1FwREhPVS9JcXMzRitiVnczb3ln?=
 =?utf-8?B?cDhRb0pxN2Q0N3lob2kyR2JHbVRBTnBoSFA2R0hTSEp2OEoxekMxYU1LQUdm?=
 =?utf-8?B?RHp5ViswdHdKU1lheWVBY1lKdzh4MmF4bEhPeE5WcUdPa0RNeTBvTVNzS3dq?=
 =?utf-8?B?Z3lXUWZ5WHdsMVAwRlFMTnNpdmdrcHdMUDZERG11NjV3dnFMUWt4eStvMHlk?=
 =?utf-8?B?Z2d0QzFKc3NVRFpqUXl4bmp2M015U1kvSzZqaHMwWi9wNytzNWhlUkNRSkR3?=
 =?utf-8?B?SFN5Uk1TckE3SkkzRk1UNWovRmRmQzJIbThUaXNIZElqY29rSkdtbVVEUDVy?=
 =?utf-8?B?OGExMUZVYXNLbnRYQ2d4V3Q1VzFVMWJxSjZ1bUI1NTVvaTVJRHhKTUpYWktB?=
 =?utf-8?B?ck5TNVNFWHM0bklSQlg4a040Z254SnJPSWY0am9GcjcvSnBTMUFEZjRiUnlF?=
 =?utf-8?B?KzNuTmJCQmpSWGVwL0gwRnYranBJWS9YT2ZHNTFJd2VjNEN6YmxrOGlkSjFr?=
 =?utf-8?B?aElLd3pHam93anpuaUNMdkxZUVJFZW45Q3lCa2ZRZGRqc21oVlFBOW5JeGpX?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 044ac232-b629-4a08-0393-08dc233d7f81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:50:22.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWMsblWvYrsbABrZouh4TnXSNQjwifzIRib91+7QgJRCiwetKEOgnr+nU1u5keAZI8wMAsO1RwkWZyurDOVSkYzfMaTfwPy/W9JLTzteHM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 01 Feb 2024 14:23:33 +0100

> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
>> From: Syed Nayyar Waris <syednwaris@gmail.com>
>>
>> The two new functions allow reading/writing values of length up to
>> BITS_PER_LONG bits at arbitrary position in the bitmap.
>>
>> The code was taken from "bitops: Introduce the for_each_set_clump macro"
>> by Syed Nayyar Waris with a number of changes and simplifications:
>>  - instead of using roundup(), which adds an unnecessary dependency
>>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>>  - indentation is reduced by not using else-clauses (suggested by
>>    checkpatch for bitmap_get_value());
>>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>>    and bitmap_write();
>>  - some redundant computations are omitted.
> 
> These functions feel like they should not be inline but are
> better off in lib/bitmap.c given their length.

When their arguments are compile-time constants, they got optimized
well. They're also used on hotpath, so making them external could hurt
performance + taking the first sentence into account, making them
external will hurt the performance even more, 'cause they won't be then
as optimized by the compiler as they are now.

> 
> As far as I can tell, the header ends up being included
> indirectly almost everywhere, so just parsing these functions
> likey adds not just dependencies but also compile time.
> 
>      Arnd

Thanks,
Olek

