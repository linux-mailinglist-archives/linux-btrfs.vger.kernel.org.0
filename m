Return-Path: <linux-btrfs+bounces-4334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 888998A81AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9071C218B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212913C825;
	Wed, 17 Apr 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WHaPzOiE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fj9E1Y9a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B50136674
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352104; cv=fail; b=PtQvfst3G6lqZ0ZjE42FsE6oUhjya9IqXC6Oh4u34lib3R2Efxm6Oa5s7LFnBZDhsJzGNjEHNEv4gsj/z4Op3V1x+u8jSIrd3aQ9ju6pqMryk8TVYmqMDBmaRyNuySunXMdcEGLOGRufSMLTopYve6kzE6Op4HPYCYp4HMeNvVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352104; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXEZCKB3pW8RYxH4O52EpMRGKYShjBwdQd6BtP7PKl2/f8nfY/PitHiS52H+BHTskfqVlXk8bHqREwFtaFgC8634t5BPyrFmAwUeebl9RRmLhJ1+IPowQmRxiTVtGt2qHv7QOPjSOnMBzKkzqESRXlF0dXL2L0srqOp+43P7N90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WHaPzOiE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fj9E1Y9a; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352102; x=1744888102;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=WHaPzOiEhw20i+qD62EXhsTRGVYNGqH0z0yUNik6SMqAwsKoQyrB0nD3
   Mj6zoOA4R+82HK2ovpM1thzMD7GChe39rnzRBSF5FFCbf96hQQRz/W7FQ
   bYqb2UBOVXxe4d5H0VaNLbLxkK7kxe5wdjoj3zjWLyAEb8WlkkK2j51i5
   FMnPsuAcKoNu45xU8IfNFXoWPHVzyee5nq6IKpfLD/oO6gj4vBYlcfDfW
   UqAxdf454k9RH3aSJWQAtGTdZpnSq2pVi9aVlsdJ9bP1HtdyzDiAV6W16
   EEoT1+Lw9Fg7h2OYAUAYADYU9F+GL6Ip2jFT0aWNwl/+qZMgYjJzRpeES
   Q==;
X-CSE-ConnectionGUID: sV1Hf3twTiqi7hzgyqry2w==
X-CSE-MsgGUID: S7pJ8FQ+QBSDbnbDCA07lw==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14214408"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:08:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy9406EWCMnhhBXFtfR+UFF5I6doPymbwkVf5g8ZTpitMt3mx0OeAUwxnxnbaBhMlOU9kmQZpiq/9lmm661nZQXYu3lnru/OpOCr6oGOeiviH1BC5JSBuzcLGhRhP3nomUwYwmWVD44xxWR2hjGruOCVhiS+D9yyGIDv8iTN8j38/WhdGgjUV3dzHSlIvPM2OT1jZgaCN6YtKy9UKAh9cnGnUrz1Mepjfp7darJu02Qe9Fcz1WnaZ+32HchQB9n3h9qFN2J9SKFgIoIgmsrnceCZeho8dpMYo/+Wf4Cf9tV7bSQmNBrPcFC6YxNuOvFuXX9gSGHbFZ6yP9EHDzM70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=hkrP0QHd9mUm/Yvj/Ww7xUZeMTY3W386FhULCJUHuP3KZZ4CqC7EZFB688aw5TI4ktcjoIcuoHoIMuymC9ez72cI2CF9eqYsO9cfcvsOj2nqNAtxYgGbPNqbYhWG19VvC3aJatCfTMltAYlLRYn2IS8YpOV7kwsfsVcgZxt59suEVkszqiDq/cwfnVNnFwahsvk2rRRDCBqpfP82D2e4x6a0SvU0/6tZBUdWPpKsSE2CTrQZG6akWQXMpbuJ9xrtZ87cvbZkmF/MyRk/fQswln0+UDraq65Av7+VAqFyMu5hG0p3zRpd4g/MXVtO2IsYgfImBOQA2+5qpUu/eUhoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Fj9E1Y9anbKfSUhWlRtiqHwsVtBOteAh6KeL5S9R+9iORsE8rRPyWkJDaM1S8a/u1aE26piXomCFvoTF9ODvFcH7wkZtppHR+G2zM0VSNCWJsqfQYnR5qjcBgMyaoergN775YGlHAhBQbT3xJ2choSh87+o1ALZCTW45PLm04SU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7985.namprd04.prod.outlook.com (2603:10b6:610:fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 11:08:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:08:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] btrfs: pass the extent map tree's inode to
 add_extent_mapping()
Thread-Topic: [PATCH v3 01/10] btrfs: pass the extent map tree's inode to
 add_extent_mapping()
Thread-Index: AQHaj/8saiT+6xQHyk6h+Sl7d+DjcbFsTxsA
Date: Wed, 17 Apr 2024 11:08:18 +0000
Message-ID: <42fccb13-d9dd-4e04-b84b-81c44892987a@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <2230af95994821e09505d0c1a9b65e93a70383f2.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <2230af95994821e09505d0c1a9b65e93a70383f2.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7985:EE_
x-ms-office365-filtering-correlation-id: 328f3128-8dea-430f-ad18-08dc5eceb004
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HYjK+WOMPvGTLosMmABegfurwQmEiznuS2h1L4scp23UEkcu+lWzTbM9zxuOGE1/cc9jrDYmCRXulgSnpk2KFsiMUik8buXArNqQ7JIEaHp4mMx4L+yLQwWnVY8aVsc61hldhSsgESGn6rUlhruqidW6Zmn+WFNpJr3FRK7/beCpFx7JWoJslzvsd80mVwAJqD0LYVbHxu05P7Z2hfwHqy75OXOgdt7EFvelb5YM3V9TbhNfUlj6iyouKGWkq6oBsejBC0DeuLEFzd56YpQGtTHv/1R2tApu/jUcnpTKic3zR7dQzWRbjTjAcwwxigqfSmUnVUxPGq6LuCCRy7M7jrMzVNjNp7N5NY6WY7+D5EuATPtdqUDeLrXgKcPFxhIS2v+QMrzdgPP/k3Iz63lKjDzyaDHDb0TE56lgzkH8pyUdfjHwyHWJvKH++R8bUtFh9r7iyMaxMBWRIISN+4FTOiOl/Y/6AmDsmtMhyLa5TGbCGwdJIUwG93VAJxKBSYFBUPv+QvYxSEnwdMvCDrCDVdXAsAxguHOrYUte7PE1OBt0YK/coyLifmHPxYjdH8dZE68ADvWOhen2w9Y7RIUboD5+jHpKnV+0B9F+hl3nWbL4KQKZBt7BPthobdl3RtN8HFJF2tVUQLhhmfg701WOFSZIkmy9nmRb8v+Mmt5VjTJcUSIK84jjLWn4KhiXQ9X3pyG9Jt0k3nJy/Pk39EURA9uQOm1yOzlPbeVGfngEL+8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1ZlSGQ1N2YrN1VBWWNQRmt4TEs0N3BjNlhBTUk2TUd0MXB4bWZCdVhxdDdq?=
 =?utf-8?B?UlpnWk5YaHhHeE1tdFVlQnhrUzcydXNMOVNzQ08xbU51U3UzbGNPNlVEdTZ3?=
 =?utf-8?B?SWRXMDhheWQwUDQwU0pXWDZEc1llMkRsclJQN1J0bFpCOFdwRUVBKys3b0k2?=
 =?utf-8?B?S2Mvc1dQdlNTTDVVc2NhbHlFdVFXbWVRVnJOS2NScS9mUWdQTzRzWEZNdjFM?=
 =?utf-8?B?VWdKSDdMUXJQdGl4RGJCY1czb081R0k5M20wR2xONExnNEdLT05QYkFvbWov?=
 =?utf-8?B?TWJJM2VsdEY4L1NoUUx6THdQd0U1eHo5LzhEd0FoMlg2UXlvMlh4dHpBTS9N?=
 =?utf-8?B?c0JCUWlGZkMxYnJidFJwWVo4WkpOWXMzUE9TZ0JlMHRyMTNWNHhFa3FqUk1Q?=
 =?utf-8?B?VE44d25hcGxDeHI3WFowamF5Z04xTVJlbkp5aUlYOTlBem9DQnVMNmx1VHlt?=
 =?utf-8?B?MUdiT2hPZHhVeGRDN0xVS2VsNFNtdk5ETFVoTG1mNVZhdE5hMXFxRElFNWxY?=
 =?utf-8?B?TUxrcll5ajROUCs2NlBoV1pBbWpyZUdOMDJFaXl3SGVhejJYcU0raVlueDJs?=
 =?utf-8?B?bDRpMFJ3L0tGbkFwVjN2NkFmZkM1SWEvQlMwblNYdGttUDNsZGRYaUMvc3RH?=
 =?utf-8?B?YmUwcGNNMUpkeC9aOXQrYXhxZlpUcEdOTVM3NTJMK3djcE4zZUlvemh2eS90?=
 =?utf-8?B?aHhOZnk0QXBsY2c2TWVnbDNGSHd2SFFmbVlVYVdjQnptejc3RXlVSTVPdkdY?=
 =?utf-8?B?L3RhSjFjQ1dVNU8yaml2VENJSWkxMW5WaXljbHNlMnRMNzVweFordjNkUks5?=
 =?utf-8?B?TnRQYjhwY0tadXY5R2ZoU1l6WmtjWm9nRmVpQnU1b01FOHRFY2dHenpIVGRn?=
 =?utf-8?B?d2lqZGc4dW4yQzhobHZjTzVNcDc4NXpkdXVFV1Q2NHFsTWVmenE5alFvbkhV?=
 =?utf-8?B?SFV1TnY5MHYwckVzeGZJSzBLbHU1Vy8yY09JZnZmd1QxbUoyNDNjZ2ZDdk5l?=
 =?utf-8?B?dXI4MkVnSzhVV0pOS29iWWlyUk1iVXkxay9CTHhKVXBaZkd3ZU4wZUgveW1z?=
 =?utf-8?B?cklaS2sxSVc3MEhPZHZNWW1tV09ydEJXSTg3YjJOaGNQb0doY0kvQ0hIb2NO?=
 =?utf-8?B?empnZWF2Vk81YnB0ZGhZeFVCSWkzR2dCQTdPb0JNeHZSdTk3bmp2dzVjVzJt?=
 =?utf-8?B?NU4rVE5mK3hWY0ttbFQxRW1MVGtEWXRJaXpDRlM1YjkxaTYrYXhPd21RL0hM?=
 =?utf-8?B?dllZTnZBdXZCR3pXRjNkS2NEN2xtRXZFZzdzTWJJWFc0cHJJbzNuVDhlTXFz?=
 =?utf-8?B?dW1LOUhzdHFMZmxIZ2h2bzk2Y3QxNWZvOVR0OTI5TVR3YzNPRDZYVklIUnhp?=
 =?utf-8?B?c3hjZGVpYkx6RGFJTC8zTHJZMEdrTVQ4YXBSTjU1MVE3L21tSmEwbzdjRU9s?=
 =?utf-8?B?Mnl0VkFlVGNNWGJQemRvMG8rZVhBRG9TU3ZJT2JmekVEMm1MRElUeGdnR3Vq?=
 =?utf-8?B?V0dRbTVrdFdFNTVPMDVGN1dMZXliamZCLzJodHhCWGNsUHZTUk5RMXRmZ1A0?=
 =?utf-8?B?VndTdWRnWDNYZitlOGI3ZjVjTE5EV0RqSVkxK3ZhTWE1MGpab3BEaHcreDBN?=
 =?utf-8?B?NDZrNjg0NzRTR3NRc0x5MEdtd3YwWFQ1em9pd2tYUnJRL3FlUjhPZWgrTitS?=
 =?utf-8?B?Sm8wd0g2eGRXV0ZqeHBKKzFNRVI0UXFudkh5RzhhOU1YLzNrZGU4UU9ydlpZ?=
 =?utf-8?B?VEtUdzE5dStic29sU1lkaEV2YkQraklKNkwzMnR3dU5GWmJjRFNyYWc1Tjlj?=
 =?utf-8?B?M3VQcW43RjlNbmcvcWJFYTY4TktIL0E2TVlSVld5a3lYaWJRUW9qQStZOHlE?=
 =?utf-8?B?TFlSVzh5eVRiVzFRbHBpYi9UbTVRczZvaFBubStQeHdJV053cHdIbFJNeHc2?=
 =?utf-8?B?dnp1NERYczdYR1NzenlsMU1Ec2lmSDNpMzlTYTlTN3FydFluMDJkZzBRQUFL?=
 =?utf-8?B?NGpPWGtvb1lJNzdtM2F4OGpIbkhJMVcyK2pJcHZnMGV6TkJPbEtWOHJ6bUZR?=
 =?utf-8?B?U1phOFhZYTNGRHFYYWFhY1VqZ2szQlRHNXpVUDdFZm1LWko0QVN5TVFWdlFB?=
 =?utf-8?B?L3ZpcXpYTHR6OFUzK3RrY29JekRuckV5QVN1YUh1ZDdsSlo4S3IzeFlscDll?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA708EAA895DC48AE577AE0C8D081E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	crRf+E5b/zV+ivWzzLDxiMCjgjJo2+uFgOZdROyvgrwLWB9RB77TPw8gjZRBYbccxX5EtSslwe/WJJ66PhMWkpLopcIzLoDmlYN/jM/XuruvdoL8RXmzrSn350qo3dP2b9MsrLHYumXf8t0KkbNuS9ojTVVpaUM2m77zk9bW0/EmktOYG8cbb/gufVwC9FxWCdx3VCrmt6XUy3x545xoX1OwkeYL/JDl4SzHYuEY1VrR2vu8ToDPNEv/E0oHJ+HnBtNzratmwJUs+XFWpMK/LddZmRgPI3Vm3U1ZqEA37aYJpGGC3G5VYmuGainqhcy2aixfQYlOrdIUM4xJG2Gd4p7Q6ZNPaUjB4RuNZw1VrVO/KrnaRCJT3T/l1IH8X2GX7I0ztblP1OHHTagfYR/ZqyXz++Fy7l0TCYb6Dl/ZlZKIgMm9LG+LaMINlQD6QR/GDOG4B7hIJfMXl/FCc5t0ycsWW49uXzMFcNwGc6R2KDfLCvS86bILgZWDn3MYPtdawWMDr7vpMhA5Fz2rSppquCT4zKVj/AkpxTQ9YnKyaLc4j8ti9uERitaUMXp6FQnZ7fhiDMH/jnN2NiqwI9eNlTK+2SWtOgy5VK1GBAhYaFWqcch5pNK4Qt1JkXKhQtbE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328f3128-8dea-430f-ad18-08dc5eceb004
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:08:18.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+Nmbj3lSWd3FC+N17kQ9inbhvBab4kTjErhvhYYPFFAVnBsu0fB6XnE/pZxAZ7PiJ85u1j0CzKT5v3N8Ei98LC2vg14PqOhdfE1yi+zcyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7985

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

